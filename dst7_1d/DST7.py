import math
from math import sqrt, sin


def DST7(N):
    kernel = []
    for i in range(0,N):
        linha = []
        for j in range(0,N):
            raiz = sqrt(1/(2*N +1)) 
            top_div = math.pi*(2*i +1) * (j +1)
            temp = raiz * sin(top_div/(2*N+1))
            linha.append(round(temp*256))
        kernel.append(linha)

    return kernel

r32 = DST7(32)
r16 = DST7(16)
r8 = DST7(8)
r4 = DST7(4)


for linha in r32:
    print(str(linha) + )
