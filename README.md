# Transform Architecture Repository
This repository provides multiplierless architectures for computing the Discrete Transforms of a vector for use in the Versatile Video Coding (VVC) standard. <br>
Bit-depth is 8 and operations are made in fixed point. <br>
X is the input vector and Y is the output vector. <br>
Input N is coded in ascending order, according to the following table
|[1:0] N  |Transform Size  |
|--|--|
| 00 | 4 |
| 01 | 8 |
| 10 | 16 |
| 11 | 32 |

## DCT-II 1-D (dct2_1d)
One-dimensional DCT-II with Even-Odd Decomposition. <br>
Inputs: <br>
X = 32x16 bits <br>
N = 2 bits <br>
Outputs: <br>
Y = 32x16 bits 

### Block Diagram
![alt_text](https://github.com/jm-marqueti/vvc_transforms_ECL/blob/main/images/dct2_1d.png?raw=true)

### Golden Model and Testbench
WIP

## DCT-II 2-D (dct2_2d)
Two-dimensional DCT-II

### Block Diagram
WIP
### Transpose Buffer
Register array

### Golden model and Testbench
WIP

