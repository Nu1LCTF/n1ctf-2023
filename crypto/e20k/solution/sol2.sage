from Crypto.Cipher import AES
from hashlib import md5


f = open('data', 'r')
A = eval(f.readline()[4:])
t = eval(f.readline()[4:])
w = eval(f.readline()[4:])
c = eval(f.readline()[4:])
z = eval(f.readline()[4:])
ct_ = f.readline()[5:]

N = 256
q = 4197821
m = 20
Zq = Zmod(q)
PRq.<a> = PolynomialRing(Zq)
Rq = PRq.quotient(a^N + 1, 'x')


delta_s = []
c = Rq(c)
for _ in range(len(z)):
    delta_s.append((Rq(z[_])-Rq(z[0]))*c^-1)


A = vector(Rq, [Rq(item) for item in A])
t = Rq(t) - A*vector(Rq, delta_s)
s0 = sum(A)^-1*t
s = vector(Rq, [s0+delta for delta in delta_s])
cipher = AES.new(md5(str(s).encode()).digest(), mode=AES.MODE_ECB)
print(cipher.decrypt(bytes.fromhex(ct_)))