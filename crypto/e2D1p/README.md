# e2D1p

+ Category: **Crypto**
+ Difficulty: ★★★
+ Solved: 12
+ Tag: **LLL, Linear Algebra**

## Description

Based on N1CTF 2022 "ezdlp". Easy dlp too, try again : ) .

## Details

Adapted from the N1CTF 2022 "ezdlp", the difference is that we xor the mask in the exponent part, and need to recover the mask.

## Solution

#### I. Recovering modulus p

We have 200 equations $65537^{m_i⊕mask}=c_i (mod p)$

Use LLL to construct small coefficients $t_i$ , satisfying $\prod c_i^{t_i}=\prod c_j^{t_j} (mod p)$

Through $GCD(\prod c_i^{t_i}-\prod c_j^{t_j},\prod c_i^{t'_i}-\prod c_j^{t'_j})$ to recover the modulus p.

From the equation $m_i\oplus mask=\sum\limits_{j=0}\limits^n(m_{i,j}\oplus mask_j)\cdot2^j$

We can construct $t_i$ that for any $j$ , $\sum\limits_{i=1}\limits^{200}t_i\cdot (m_{i,j}\oplus mask_j)=0$

If $mask_j=0$ , you only need to ensure that $\sum\limits_{\{i|m_{i,j}=1\}}t_i=0$

If $mask_j=1$ , you only need to ensure that $\sum\limits_{\{i|m_{i,j}=0\}}t_i=0$

Construct the lattice as follows,

$$
\begin{bmatrix}
1&&&&&m_{1,0}\cdot g&m_{1,1}\cdot g&\cdots&m_{1,n}\cdot g&g\\
&1&&&&m_{2,0}\cdot g&m_{2,1}\cdot g&\cdots&m_{2,n}\cdot g&g\\
&&&&&\vdots\\
&&&&1&m_{200,0}\cdot g&m_{200,1}\cdot g&\cdots&m_{200,n}\cdot g&g\\
\end{bmatrix}
$$

The last column ensures that $\sum\limits_{\{i|m_{i,j}=0\}}t_i=0$

After LLL, take part of it and do GCD to recover the modulus p.

> Discussing in discord after the game, I discovered that this part is consistent with [TetCTF2022](https://affine.group/writeup/2022-01-TetCTF#fault) . :(

#### II. Recovering mask

First, for one bit message $m,x$

$$x\oplus m =
\begin{cases}
x& \text{m=0}\\
1-x& \text{m=1}
\end{cases}$$


For $65537^{\sum2^i\cdot(x_i\oplus m_i)}=c (mod p)$

We can transform it to $(65537)^{\sum\limits_{\{i|m_i=0\}}2^i\cdot x_i+\sum\limits_{\{j|m_j=1\}}2^j\cdot(-x_j)}=c\cdot 65537^{-\sum\limits_{\{j|m_j=1\}}2^j} (mod p)$

According to $x_i$ coefficient 1 or -1, use 200 equations to construct matrix A.

Find the vector $u$ that satisfies $u\cdot A=(1, 0, \cdots, 0)(mod q)$

if $mask_0=0$ , $\prod\limits_{i=1}\limits^{200}c_i^{u_i}=65537^0=1(mod p)$

In the same way, find the linear coefficient $u_i$ of other one-hot encodings to check other positions of the mask, and finally recover the mask.
