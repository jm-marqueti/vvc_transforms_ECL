import numpy as np
import math
from math import sqrt, cos
import math
import random
###  python3 DCT2.py > out.txt  ###


def decimal_to_18bit_binary(decimal_number):
    # Ensure the number is within the range of an 18-bit signed integer
    if decimal_number < -262144 or decimal_number > 262143:
        raise ValueError("Decimal number is out of the 18-bit signed integer range")

    # Check if the number is negative
    if decimal_number < 0:
        # Calculate the two's complement representation
        binary_number = bin(decimal_number & 0x3FFFF)[2:]
    else:
        # Convert the positive number to binary with leading zeros
        binary_number = format(decimal_number, '018b')

    return binary_number


def decimal_to_8bit_signed_binary(decimal_number):
    # Ensure the number is within the range of an 8-bit signed integer (-128 to 127)
    if decimal_number < -128 or decimal_number > 127:
        raise ValueError("Decimal number is out of the 8-bit signed integer range")

    # Check if the number is negative
    if decimal_number < 0:
        # Calculate the two's complement representation
        binary_number = bin(decimal_number & 0xFF)[2:]
    else:
        # Convert the positive number to binary with leading zeros
        binary_number = format(decimal_number, '08b')

    return binary_number

def DCT_2(N):
    kernel = []
    for i in range(0, N):
        linha = []
        for j in range(0, N):
            alpha = 1 if i == 0 else math.sqrt(2)
            t = alpha * math.cos((math.pi * (2 * j + 1) * i) / (2 * N))
            linha.append(round(t * 64))
        kernel.append(linha)
    return kernel

if __name__ == "__main__":
    N = 8
    lim_inf = -128
    lim_sup = 127
    result = DCT_2(N)

    for c in range(0,1000):
        x = [random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup)]

        transformed = np.matmul(result,x)

        x_bin = list(map(decimal_to_8bit_signed_binary,x))
        transformed_bin = list(map(decimal_to_18bit_binary,transformed))


        x_input = ""
        for vetor in x_bin:
            x_input+=str(vetor)

        output = ""
        for vetor in transformed_bin:
            output+=str(vetor)

        print(x_input + " " + output)

