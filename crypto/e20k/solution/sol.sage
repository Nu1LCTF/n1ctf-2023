import gmpy2
from pwn import *
import os

def fac(N):
    res = []
    PR.<x> = PolynomialRing(Zmod(N))
    while True:
        s = randint(1, N)
        R = PR.quotient(x^2+s)
        for _ in range(10):
            a = R.random_element()
            coeff = list(a^(2*N))
            if 1 < GCD(ZZ(coeff[0]), N) < N:
                p = GCD(ZZ(coeff[0]), N); p_ = (p+1)//2
                res.append(p); res.append(p_); res.append(N//(p*p_))
                return res
            elif 1 < GCD(ZZ(coeff[1]), N) < N:
                p = GCD(ZZ(coeff[1]), N); p_ = (p+1)//2
                res.append(p); res.append(p_); res.append(N//(p*p_))
                return res

while True:
    try:
        io = remote("121.41.9.20", '6665')
        io.recvuntil("python3 <(curl -sSL https://goo.gle/kctf-pow) solve ")
        prob = io.recvline()[:-1].decode()
        os.system(f"python3 pow.py solve {prob} > res")
        io.sendlineafter("Solution? ", open("res", 'r').read())
        io.recvuntil("N = ")
        N = int(io.recvline())
        E = EllipticCurve(Zmod(N), [3, 7])
        factors = fac(N)
        El = []
        Gx = []
        Gy = []
        for _ in range(3):
            E_ = E.change_ring(GF(factors[_]))
            El.append(E_)
            G_ = E_(0).division_points(3)[1]
            Gx.append(ZZ(G_.xy()[0]))
            Gy.append(ZZ(G_.xy()[1]))

        gx = crt(Gx, factors)
        gy = crt(Gy, factors)
        io.sendlineafter("PLZ SET PRNG SEED > ", str(gx)+','+str(gy))
        break
    except:
        io.close()
        continue

io.interactive()