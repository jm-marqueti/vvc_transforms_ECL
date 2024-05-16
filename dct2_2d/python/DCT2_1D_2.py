import numpy as np
import math
from math import sqrt, cos
import math
import random
###  python3 DCT2.py > goldenmodel.dat  ###


def decimal_to_16bit_binary(decimal_number):
    if decimal_number < -32768 or decimal_number > 32767:
        raise ValueError("Decimal number is out of the 16-bit signed integer range")

    if decimal_number < 0:
        binary_number = bin(decimal_number & 0xFFFF)[2:]
    else:
        binary_number = format(decimal_number, '016b')

    return binary_number


def decimal_to_32bit_binary(decimal_number):
    if decimal_number < -2147483648  or decimal_number > 2147483647:
        raise ValueError("Decimal number is out of the 32-bit signed integer range")

    if decimal_number < 0:
        binary_number = bin(decimal_number & 0xFFFFFFFF)[2:]
    else:
        binary_number = format(decimal_number, '032b')

    return binary_number

def decimal_to_27bit_binary(decimal_number):
    if decimal_number < -134217728  or decimal_number > 134217727:
        raise ValueError("Decimal number is out of the 27-bit signed integer range")

    if decimal_number < 0:
        binary_number = bin(decimal_number & 0x7FFFFFF)[2:]
        for j in range(0,27-len(binary_number)):
            binary_number = "1" + binary_number
    else:
        binary_number = format(decimal_number, '027b')

    return binary_number


def DCT_2(N):
    kernel = []
    for i in range(0, N):
        linha = []
        for j in range(0, N):
            alpha = 1 if i == 0 else math.sqrt(2)
            t = alpha * math.cos((math.pi * (2 * j + 1) * i) / (2 * N))
            t = round(t * 64)
            arredondamentos = {84: 83, -84: -83, 35: 36, -35: -36, 26: 25, -26: -25, 30: 31, -30: -31, 39: 38, -39: -38, 47: 46, -47: -46}
            if t in arredondamentos:
                t = arredondamentos[t]
            else:
                t = t
            linha.append(t)
        kernel.append(linha)
    return kernel

if __name__ == "__main__":
    prefixos_de_tamanho = {4: "00", 8: "01", 16: "10", 32: "11"}
    for cases in range(0,1000):
        i = random.randint(0,3)
        N = 4 * pow(2,i)

        lim_inf = -32000
        lim_sup = 32000
        kernel = DCT_2(N)

        x = []
        x_bin = []
        for l in range(0,N):
            temp = []
            temp.append(random.randint(lim_inf,lim_sup))
            x.append(temp)
            x_bin.append(list(map(decimal_to_16bit_binary,temp)))
        transformed = np.matmul(kernel,x)

        x_input = prefixos_de_tamanho[N]
        for linha in x_bin:
            for vetor in linha:
                x_input+=str(vetor)

        formatacao_input = ""
        for j in range(0,514-(len(x_input))):
            formatacao_input += '0'

        x_input+=formatacao_input
        formatacao_input=x_input

        output = ""
        for linha in transformed:
            for vetor in linha:
                #print(decimal_to_27bit_binary(vetor))
                output+= decimal_to_27bit_binary(vetor)[:16]
                #print(output)
                #output+=str(decimal_to_16bit_binary(int(vetor/pow(2,11))))


        formatacao_output=""
        for j in range(0,512-(len(output))):
            formatacao_output += '0'

        output += formatacao_output
        formatacao_output = output

        print(formatacao_input + formatacao_output)
