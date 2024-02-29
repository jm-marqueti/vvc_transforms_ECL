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
            t = round(t * 64)
            if t==84:
                t=83
            elif t==-84:
                t=-83

            elif t==35:
                t=36
            elif t ==-35:
                t=-36

            elif t==26:
                t=25
            elif t==-26:
                t=-25

            elif t==30:
                t=31
            elif t==-30:
                t=-31

            elif t==39:
                t=38
            elif t==-39:
                t=-38

            elif t==47:
                t=46
            elif t==-47:
                t=-46
            linha.append(t)
        kernel.append(linha)
    return kernel

if __name__ == "__main__":
    N = 32
    lim_inf = -128
    lim_sup = 127
    result = DCT_2(N)
    for linha in result:
        print(linha)

    for c in range(0,1000):
        x = []#[random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup),random.randint(lim_inf,lim_sup)]
        x_bin = []
        for i in range(0,N):
            temp = []
            for j in range(0,N):
                temp.append(random.randint(lim_inf,lim_sup))
            x.append(temp)
            x_bin.append(list(map(decimal_to_8bit_signed_binary,temp)))

        transformed = np.matmul(result,x)
        #print(transformed)

 
       # x_bin = list(map(decimal_to_8bit_signed_binary,x))


        x_input = ""
        for linha in x_bin:
            for vetor in linha:
                x_input+=str(vetor)

        output = ""
        for linha in transformed:
            for vetor in linha:
                #print(vetor)
                output+=str(decimal_to_18bit_binary(vetor))

        print(x_input + " " + output)

