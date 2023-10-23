# h2o

The verification algorithm (an XTEA variant) is implemented in H2OC, a high-level language that resembles C. Please refer to [h2o.h2oc](./h2o.h2oc) for the details of the algorithm.

[h2o.h2oc](./h2o.h2oc) gets compiled by `h2occ`, a (not-yet-opensourced) subleq compiler collection that transforms programs written in H2OC into a subleq program.

The subleq program is then embedded into and executed by a subleq emulator (which is the challenge `h2o` given to the players).

Generally speaking, the h2occ pipeline consists of two stages:

1. Compile: H2OC -> H2OASM
2. Assemble: H2OASM -> Subleq program

H2OASM is an assembly language that describes operations in a virtual architecture H2OArch that resembles the x64 architecture. For example, it contains some general registers, stack pointers, and I/O interrupts. Every assembly instruction in H2OASM has a one-to-one mapping to a fixed subleq sequence. For instance, the implementations for `sub reg, reg` and `add reg, reg` are:

```
> sub reg0, reg1
subleq reg1_addr, reg0_addr, NEXT_IP // reg0 -= reg1

> add reg0, reg1
subleq TMP0_addr, TMP0_addr, NEXT_IP // TMP0 = 0
subleq reg1_addr, TMP0_addr, NEXT_IP // TMP0 = -reg1
subleq TMP0_addr, reg0_addr, NEXT_IP // reg0 -= -reg1 = reg0 + reg1
```

To reverse engineer the verification algorithm, one will first need to reverse engineer the mappings from the subleq sequences to the assembly instructions, i.e., `subleq pattern -> H2OASM`. The next step would be to perform conventional reverse engineering on the H2OASM assembly code, i.e., getting `H2OASM -> H2OC`. We expect this process to be non-trivial.

We provide the assembly code ([./h2o.asm](./h2o.asm)) and debug symbols ([./h2o.sym](./h2o.sym)) for the challenge. The mapping `insns<->ips` in debug symbols should be useful for identifying the specific assembly operation at a specific address of the subleq program.

We provide the solution to the verification algorithm in [./sol.c](./sol.c).
