import numpy as np
import math
from math import sqrt, sin
import math
import random

def DST7(N):
    kernel = []
    for i in range(0,N):
        linha = []
        for j in range(0,N):
            raiz = sqrt(4/(2*N +1)) 
            top_div = math.pi*(2*i +1) * (j +1)
            temp = raiz * sin(top_div/(2*N+1))
            linha.append(round(temp*128*sqrt(2)))
        kernel.append(linha)

    return kernel



r8 =  DST7(8)
r4 = DST7(4)

for linha in r8:
    print(linha)