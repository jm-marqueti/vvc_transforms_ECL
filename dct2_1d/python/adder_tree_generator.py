import math

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


if __name__ == '__main__':
    N = 32
    kernel = DCT_2(N)
    odd_kernel = []
    for i in range(0, N):
        linha = []
        if (i % 2 == 1):
            for j in range(0, round(N/2)):
                linha.append(kernel[i][j])
            odd_kernel.append(linha)

    for i in range(0, round(N/2)):

        print("assign Yo[" + str(i) + "] =", end=' ')

        for j in range(0, round(N/2)):
            if (j == 0):
                operator = ""
            elif (odd_kernel[i][j] > 0):
                operator = " + "
            else:
                operator = " - "

            print(operator + "x" + str(abs(odd_kernel[i][j])) + "[" + str(j) + "]" , end= '')

        print(";")
