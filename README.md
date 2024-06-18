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
X = Spatial domain vector (32x16 bits) <br>
N = Coded size (2 bits) <br>
Outputs: <br>
Y = Frequency domain vector (32x16 bits) 

### Block Diagram
![alt_text](https://github.com/jm-marqueti/vvc_transforms_ECL/blob/main/images/dct2_1d.png?raw=true)

### Golden Model and Testbench
Test vector order is {SIZE, INPUT} with **no spaces**. Non-utilised bits are set to zero. <br> Example for N=4: <br>
00 0011111100010000 1000000101110001 101110000000001 1010000000100000 0000000000000000000000000000000000...

## DCT-II 2-D (dct2_2d)
Two-dimensional DCT-II for square blocks

### Block Diagram
WIP
### Transpose Buffer
32x32 register array with bit-depth 16

### Control

### Golden model and Testbench
WIP
