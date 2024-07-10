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


if __name__ == '__main__':
    N = 4
    kernel = DST7(N)
    for i in range(0, N):

        print("assign Y[" + str(i) + "] =", end=' ')

        for j in range(0, round(N)):
            if (j == 0):
                operator = ""
            elif (kernel[i][j] > 0):
                operator = " + "
            else:
                operator = " - "

            if (kernel[i][j] != 0):
                print(operator + "x" + str(abs(kernel[i][j])) + "[" + str(j) + "]" , end= '')

        print(";")
