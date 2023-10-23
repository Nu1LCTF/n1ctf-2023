# e2Is0

+ Category: **Crypto**
+ Difficulty: ★★★
+ Solved: 7
+ Tag: **Isogeny, Algebra, LLL**

## Description

I've hidden my treasure on this intricate path, and I think it's safe enough : ) .

## Details

Select a specific curve $E$ on $F_{p^2}$ based on guess, and then do a 3-isogeny to get codomain $E'$, and the corresponding j-invariants are j'. We can query the real part of $(j')^{x^r-1(mod p^2)}$. Finally, we need to recover the value of guess. 

## Solution

#### I. Query

Since  $x\in Z_{p^2}$,  $j'\in F_{p^2}$, and the order of $j'$ is $p^2-1$.

It's easy to find if $a=-1$ and $2\nparallel r$, we have $x=p^2-2$

$\Rightarrow s_1+s_2\cdot i=j'^x=j'^{p^2-2}=j'^{-1}$

Assume $j'=j_2+j_2'\cdot i$ , $\Rightarrow (j_2+j_2'\cdot i)^{-1}=\frac{j_2-j_2'\cdot i}{j_2^2+j_2'^2}$

$\Rightarrow (j_2^2+j_2'^2)\cdot s_1=j_2$

$\Rightarrow j_2'^2=-j_2^2+s_1^{-1}\cdot j_2$

#### II. Modular polynomials

The idea is to use the modular polynomials $\phi_r(x,y)$ to relate two curve $E,E'$

Recall that the modular polynomial $\phi_r(x,y)$ has the following property:

There exits an isogeny $\phi:E\rightarrow E'$ of degree $r$ with cyclic kernel if and only if  $\Phi_r(j(E),j(E'))=0$ 

We can find $\Phi_3$ through this [page](https://math.mit.edu/~drew/ClassicalModPolys.html)

Since $j$ is an integer, assume $j=j_1,j'=j_2+j_2'\cdot i$ 

Then we can get two equation of $j_1,j_2,j_2'$ by spliting the real and imaginary. 

Combined with the results of Query, use three polynomial equations to solve the three variables through the resultant. 

#### III. Recovering guess

After taking the root of a random number, it gives the decimal part of a certain number of digits. It is required to recover the random number.

Let's assume that the unknown number is $s$, the integer part after the root $t\approx10^{\delta}$, the known d decimal part $r\cdot 10^{-d}$, and the unknown decimal part $\epsilon< 10^{-d}$

$\sqrt{s}=t+r\cdot 10^{-d}+\epsilon$

$\Rightarrow s=t^2+r^2\cdot 10^{-2d}+\epsilon^2+2\cdot t\cdot r\cdot 10^{-d}+2\cdot t\cdot \epsilon +2\cdot \epsilon \cdot r\cdot 10^{-d}$

$\Rightarrow (s-t^2)\cdot 10^{2d}-r^2-2\cdot t\cdot r\cdot 10^d\approx2\cdot 10^{\delta+d}$

Construct the lattice in this way,

$$
L=
\left[\begin{matrix}
10^d&&&10^{2\cdot d}\\
&10^d&&10^d\cdot 2\cdot r\\
&&10^{d+\delta}&r^2
\end{matrix}\right]
$$

Try LLL to get short vector $(10^d\cdot (s-t^2),-10^d\cdot t,-10^{\delta+d},\Delta)$

s can be recovered by using the first and second components. 
