## e2$m4

+ Category: **Crypto**
+ Difficulty: ★★★
+ Solved: 6
+ Tag: **SM4, DFA**

## Description

I hope to make sm4 random through new components, but when I get some characteristic of ciphertext, it seems to be very bad :( .

## Details

Based on the idea of differential fault analysis, SM4 was partially modified. The Dance component has an effect similar to fault injection.

## Solution

The encryption of this challenge is based on SM4 and adds a layer of invertible P component. 

Where P can be expressed as $P(x_1, x_2, x_3,x_4)=(Sbox_1(x_1)\lll3,Sbox_2(x_2)\lll4,Sbox_3(x_3)\lll5,Sbox_3(x_4)\lll6)$

We can write $P_i(x)=Sbox_i(x)\lll(2+i)$，where $Sbox_1=Sbox_3$

The rest is consistent with SM4, and dance is added when encryption. Dance part will rotate the `Dance_box` order. However, because $box_1,box_3$ are the same. Therefore, the first 4 bytes are still the same after a round of P box, which is also the premise of differential analysis later.

After 32 rounds of operation, the four blocks are processed in reverse order to output the ciphertext results.

Consider the ciphertext form which dance in round 32 and round 31. Remember that the P function after dance is P'

$X_{35}=P_1(X_{31})\oplus T(P_2(X_{32})\oplus P_3(X_{33})\oplus P_4(X_{34})\oplus rk_{32})$

$X_{35}'=P_1'(X_{31})\oplus T(P_2'(X_{32})\oplus P_3'(X_{33})\oplus P_4'(X_{34})\oplus rk_{32})$

After noting $P_1'$ and $P_1$ are still the same,

$\Rightarrow \Delta X_{35}=T(P_2(X_{32})\oplus P_3(X_{33})\oplus P_4(X_{34})\oplus rk_{32})\oplus T(P_2'(X_{32})\oplus P_3'(X_{33})\oplus P_4'(X_{34})\oplus rk_{32})$

Due to $T=L\cdot S$,

$\Rightarrow L^{-1}(\Delta X_{35})=S(P_2(X_{32})\oplus P_3(X_{33})\oplus P_4(X_{34})\oplus rk_{32})\oplus S(P_2'(X_{32})\oplus P_3'(X_{33})\oplus P_4'(X_{34})\oplus rk_{32})$

Reverse L can be solved by matrix or z3.

After that, combined with the S-box structure of SM4, if the difference table is not zero in the case of fixed difference, the high probability is 2. The above difference equation can be used to choose the candidate key. Because the ecb mode encrypts two blocks, there is only one situation after getting intersection of the two sets of candidate keys. Finally, the last four rounds of the round key is used to recover the master key, then decrypt.

For details, plz refer to the `References` and `sol.sage`.

## References

\[1]: [Differential Fault Analysis on SMS4](http://cjc.ict.ac.cn/eng/qwjse/view.asp?id=2132)

\[2]: [Differential Fault Analysis on SMS4 Using a Single Fault](https://eprint.iacr.org/2010/063.pdf)