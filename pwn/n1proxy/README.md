
## n1proxy

n1proxy is a pwn challenge for n1ctf 2023

server : the challenge server

client : exploit

## The Vulnerability


the bug is in the function `my_recv_msg` in `server/src/main.rs`

if you have not find the bug, you can read the following code, and try to find the bug again :). 

```rust
#[inline(always)]
fn my_recv_msg(fd: i32, recv_size: usize) -> Result<Vec<u8>> {
    let mut recv_iov = [iovec {
        iov_base: vec![0u8; recv_size].as_mut_ptr() as *mut _,
        iov_len: recv_size,
    }];
    let mut msg = msghdr {
        msg_name: std::ptr::null_mut(),
        msg_namelen: 0,
        msg_iov: recv_iov.as_mut_ptr(),
        msg_iovlen: 1,
        msg_control: std::ptr::null_mut(),
        msg_controllen: 0,
        msg_flags: 0,
    };
    let recv_sz = unsafe { recvmsg(fd, &mut msg, 0) };
    if recv_sz < 0 {
        return os_error!();
    }

    let res = unsafe { slice::from_raw_parts(recv_iov[0].iov_base as *const u8, recv_size) };
    Ok(res.to_vec())
}

```


the bug is that the `recv_iov.iov_base` is a temporary variable, and the `recv_iov[0].iov_base` is a pointer to the memory , so when the `iovec` finish initailization, the `recv_iov[0].iov_base` will be a dangling pointer.

It looks unbelievable? Many people think that the pointer to the `iov_base` will be free until the function return , but it is not true. We can see the assembly code of the `iovec` initialization.

```asm
.text:000000000002CABE BE 01 00 00 00                mov     esi, 1
.text:000000000002CAC3 48 8B 3C 24                   mov     rdi, [rsp+0D38h+var_D38]        ; nmemb
.text:000000000002CAC7 E8 F4 56 00 00                call    __rust_alloc_zeroed
.text:000000000002CAC7
.text:000000000002CACC 48 85 C0                      test    rax, rax
.text:000000000002CACF 0F 84 BA 14 00 00             jz      loc_2DF8F
.text:000000000002CACF
.text:000000000002CAD5 48 89 84 24 30 02 00 00       mov     qword ptr [rsp+0D38h+addr.sa_family], rax
.text:000000000002CADD 48 8B 0C 24                   mov     rcx, [rsp+0D38h+var_D38]
.text:000000000002CAE1 48 89 8C 24 38 02 00 00       mov     qword ptr [rsp+0D38h+addr.sa_data+6], rcx
.text:000000000002CAE9 48 89 C7                      mov     rdi, rax                        ; ptr
.text:000000000002CAEC FF 15 3E 42 08 00             call    cs:free_ptr
.text:000000000002CAEC
.text:000000000002CAF2 E9 14 14 00 00                jmp     loc_2DF0B
```

we can see that the `iov_base` will be free after the `__rust_alloc_zeroed` function return, so the `recv_iov[0].iov_base` will be a dangling pointer.

## The Exploit

It's easy to exploit this bug, we can use the `recv_iov` to leak the libc address, and overwrite the `__free_hook` to `system` by tcache attack. When a vector is initialized, there are two ways to initialize it, one is to initialize it with a value, and the other is to initialize it with a default value. When we initialize it with a value(`slice.to_vec`), it will call `malloc` and copy the value to the memory, and when we initialize it with a default value, it will call `calloc` to initialize the memory. So we can choose a tcache size which not used in the program, and use the `malloc` to get it, and then overwrite the `__free_hook` to `system` function. Finally, we can send many commands to the server to trigger the `system` function to reverse shell.For more details, you can read the `client/src/main.rs` file.
