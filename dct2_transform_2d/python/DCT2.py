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
    aux = np.array(kernel)

    return kernel

if __name__ == "__main__":
    prefixos_de_tamanho = {4: "00", 8: "01", 16: "10", 32: "11"}
    for cases in range(0,1): #numero de matrizes geradas
        i = random.randint(0,0) #0 a 3
        N = 4 * pow(2,i)

        lim_inf = -255
        lim_sup = 255
        kernel = DCT_2(N)

        x = []
        x_bin = []
         
        for p in range(0,N):
            linha = []
            linha_bin = []
            for l in range(0,N):
                temp = random.randint(lim_inf,lim_sup)
                linha.append(temp) #acrescenta elemento a linha
                #print(linha)
            linha_bin.append(list(map(decimal_to_16bit_binary,linha))) #acrescenta elemento a linha binaria
            x.append(linha)
            #print(x)
            x_bin.append(linha_bin[0]) #INPUT LINHA POR LINHA


      #  x= [[-1, -2, -3, -4]]

        x_bin = []
        for linha in x:
            x_bin.append(list(map(decimal_to_16bit_binary,linha)))

        x_bin = np.array(x_bin)
        


        x_bonito = np.array(x)
       # x_bin_b = np.array(x_bin)
        x_bin_2=[]
        for linha in x_bin:
            linha_bin = []
            for vetor in linha:
                #print(vetor)
                if(vetor[0]=='1'):
                    linha_bin.append(int(vetor,2)-(1<<len(vetor)))
                else:
                    linha_bin.append(int(vetor,2))
                

            x_bin_2.append(linha_bin)

        x = np.array(x).transpose()
        transformed_med = np.array(np.matmul(kernel,x))
        # tem que truncar os últimos 16 bits que nem na linha 116 aqui e lá (2 vezes) se não da erro numérico
        # transformed_med -> binario -> binario truncado -> decimal -> transpor -> multiplica pelo kernel -> resultado
        
        new_transformed_med = []
        for linha in transformed_med:
            new_linha = []
            for vetor in linha:
                vetor_bin = decimal_to_27bit_binary(vetor)[16:] # binario -> binario truncado 
                if(vetor_bin[0]=='1'):
                    new_linha.append(int(vetor_bin,2)-(1<<len(vetor_bin)))
                else:
                    new_linha.append(int(vetor_bin,2))
                #new_linha.append(int(vetor_bin,2)-(1<<16)) #binario truncado -> decimal signed
            new_transformed_med.append(new_linha)

        new_transformed_med = np.array(new_transformed_med).transpose()

        
        
        new_transformed_med = new_transformed_med#.transpose() #decimal -> transpor

        transformed_fin = np.matmul(kernel,new_transformed_med) #transpor -> multiplica pelo kernel -> resultado

        new_transformed_fin = []
        for linha in transformed_fin:
            new_linha = []
            for vetor in linha:
                vetor_bin = decimal_to_27bit_binary(vetor)[:16] # binario -> binario truncado 
                if(vetor_bin[0]=='1'):
                    new_linha.append(int(vetor_bin,2)-(1<<len(vetor_bin)))
                else:
                    new_linha.append(int(vetor_bin,2))
                #new_linha.append(int(vetor_bin,2)-(1<<len(vetor_bin))) #binario truncado -> decimal signed
            new_transformed_fin.append(new_linha)

        new_transformed_fin = np.array(new_transformed_fin)




        #Tirar dúvida sobre tamanho e formato do input output. Num de bits nos dois.
        
       # x_input = prefixos_de_tamanho[N]
       # for linha in x_bin:
       #     for vetor in linha:
       #         x_input+=str(vetor)


        with open('goldenmodel_input.dat', 'w') as file:
            for j in range(N):
                x_input = prefixos_de_tamanho[N]
                for k in range(N):
                    x_input+=x_bin[j][k]
                formatacao_input = "" 
                for p in range(0,514-(len(x_input))):
                        formatacao_input += '0'
                x_input+=formatacao_input
            #    print(x_input)
                file.write(x_input+"\n")


        #formatacao_input = ""
        #for j in range(0,514-(len(x_input))):
        #    formatacao_input += '0'
        #
        #x_input+=formatacao_input
        #formatacao_input=x_input

        output = ""
        for linha in transformed_fin:
            for vetor in linha:
                #print(decimal_to_27bit_binary(vetor))
                output+= decimal_to_27bit_binary(vetor)[:16]
                #print(output)
                #output+=str(decimal_to_16bit_binary(int(vetor/pow(2,11))))

        with open('goldenmodel_output.dat', 'w') as file:
            for j in range(N):
                x_output=""
                for k in range(N):
                    x_output+=decimal_to_27bit_binary(new_transformed_fin[j][k])
                formatacao_output = "" 
                for p in range(0,514-(len(x_output))):
                        formatacao_output += '0'
                x_output+=formatacao_output
             #   print(x_output)
                file.write(x_output+"\n")


        formatacao_output=""
        for j in range(0,512-(len(output))):
            formatacao_output += '0'

        output += formatacao_output
        formatacao_output = output

       # print(formatacao_input + formatacao_output)
