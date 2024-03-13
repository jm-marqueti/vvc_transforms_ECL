
import numpy as np
import math


def DCT_2(N):
    kernel = []
    for i in range(0, N):
        linha = []
        for j in range(0, N):
            alpha = 1 if i == 0 else math.sqrt(2)
            t = alpha * math.cos((math.pi * (2 * j + 1) * i) / (2 * N))
            t = round(t * 64)
            if t == 84:
                t = 83
            elif t == -84:
                t = -83

            elif t == 35:
                t = 36
            elif t == -35:
                t = -36

            elif t == 26:
                t = 25
            elif t == -26:
                t = -25

            elif t == 30:
                t = 31
            elif t == -30:
                t = -31

            elif t == 39:
                t = 38
            elif t == -39:
                t = -38

            elif t == 47:
                t = 46
            elif t == -47:
                t = -46
            linha.append(t)
        kernel.append(linha)
    return kernel


if __name__ == "__main__":
    N = 16
    kernel = np.transpose(DCT_2(N))

    x =[]

    for i in range(0, N):
        x.append(i)

    transformed_intermediary = np.matmul(kernel, x)

    transformed = np.round(transformed_intermediary)

    print(transformed)

    inverse = np.round(np.divide(np.matmul(np.transpose(kernel), transformed),(2 ** (12 + math.log(N,2)))))

    print(inverse)
