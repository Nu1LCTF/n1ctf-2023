# e20k

+ Category: **Crypto**
+ Difficulty: ★★
+ Solved: 13
+ Tag: **Algebra, n-Torsion, ZKP**

## Description

Sometimes it always feels like some secure protocols will always cause some strange problems in some strange situations. Isn't it  (・◇・)？

## Details

The Protocol part implements a zero-knowledge proof protocol based on Ring-SIS. The polynomial sampling part of the protocol is based on the ECPrng and random libraries. The output of the protocol interaction process is given. You need to recover  the original short vector secret.

The interaction process will initialize the state of ECPrng based on the input point. This part uses an elliptic curve on $Z_n$ to update the internal state through point addition. The output is the x coordinate of the current state plus an unknown fixed bias.

## Solution

#### I. Factoring N

$N = p\cdot(2p-1)\cdot q$

Using the structure of $p\cdot (2p-1)$ , it can be written as  $p'\cdot \frac{p'+1}{2}$.  Using the trick in [ImaginaryCTF 2023 Sus](https://github.com/maple3142/My-CTF-Challenges#imaginaryctf-2023), choose a suitable quadratic constructing quotient ring to recover $p$.

#### II. Calculate 3-torsion

That is, calculate the point $Q$ that satisfies the form $2\cdot Q=-Q$

$\lambda = \frac{3x^2+a}{2y}$

$\lambda^2-2\cdot x = x$ 

Solve the roots of the polynomial on $F_p$ , and use CRT to find the 3-torsion on $E_n$.

> *@Neobeo* offers a better way, take 15-torsion which use 4Q=-Q and 4Q=Q , which will have a higher success rate.

#### III. Transform Ring-SIS Problem

P generate the proof:  $\vec{z}=\vec{s}\cdot c+\vec{y}$ . When the component of $\vec{y}$ is sampled, Random will be reset based on the ECPrng generated value. By setting the initial point to the element in $E[3]$, since $4\cdot Q=Q$, the State in ECPrng will remain constant,  the components of $\vec{y}$ are consistent, and we can get the following relationship

$$
\begin{bmatrix}
z_1\\
z_2\\
\vdots \\
z_m
\end{bmatrix}=
c\cdot 
\begin{bmatrix}
s_1\\
s_2\\
\vdots \\
s_m
\end{bmatrix}+
\begin{bmatrix}
y_0\\
y_0\\
\vdots \\
y_0
\end{bmatrix}
$$

From this, we express the component difference $\delta_i$ of $\vec{s}$ as follows,

$$
\begin{bmatrix}
   \delta_1 \\
   \delta_2 \\
    \vdots\\
   \delta_{m-1} \\
\end{bmatrix}=
c^{-1}\cdot \begin{bmatrix}
    z_1-z_2 \\
    z_1-z_3 \\
    \vdots\\
    z_1-z_m \\
\end{bmatrix}
$$

Substitute the relationship $\vec{A}\cdot\vec{s}=t$ ,

$$
\begin{bmatrix}
a_1&a_2&\dots a_m
\end{bmatrix}\cdot
\begin{bmatrix}
s_1-0\\
s_1-\delta_1\\
\vdots\\
s_1-\delta_{m-1}
\end{bmatrix}=t
$$

$\Rightarrow (\sum\limits_{i=1}\limits^m a_i)\cdot s_1=t+\sum\limits_{i=1}\limits^{m-1}a_{i+1}\delta_i$

Find $s_1$ and then subtract the corresponding difference $\delta_i$ to recover $\vec{s}$

