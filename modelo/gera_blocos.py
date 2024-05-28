import struct
import matplotlib.pyplot as plt
import numpy as np
import time
import pickle
import random
import numpy as np


#####Estético#####
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
YELLOW = "\033[33m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
WHITE = "\033[37m"
RESET = "\033[0m"
##################
def gera_valor_inicial(data_00):
    max_val = data_00["total_blocos"]
    r = random.randint(0,max_val)
    for val in data_00:
        if r <= data_00[val]: #como o dicionário está ordenado, o primeiro valor que ele encontrar em que r<=data_00[val] será o valor gerado
            valor_gerado = val
            #print(valor_gerado)
            break
    return valor_gerado

def gera_valor(valor_ref, data_adj):
    max_val = data_adj[valor_ref]["total_vizinhos"]
    #print(max_val)
    r = random.randint(0,max_val)
    for val in data_adj[valor_ref]:
        if r <= data_adj[valor_ref][val]:
            valor_gerado = val
            break

    return valor_gerado


def gera_bloco(w,h,data_00,data_adj):
    matrix = []
    for i in range(0,w):
        linha = []
        for j in range(0,h):
            if(i==j and i==0):
                val = gera_valor_inicial(data_00) #gera o valor matrix[0][0]
            elif(i==0):
                val = gera_valor(linha[j-1], data_adj) #pega o valor a esquerda como referência para valor matrix[0][j]
            elif(j==0):
                val = gera_valor(matrix[i-1][0], data_adj) #pega o valor em cima como referencia para valor matrix[i][0]
            else:
                val1 = gera_valor(matrix[i-1][0], data_adj) #pega o valor em cima como referencia
                val2 = gera_valor(matrix[0][j-1], data_adj) #pega o valor a esquerda como referência
                val = int((val1 + val2)/2) #OBS: existe a pequena possibilidade (quase 0) desse valor não existir no dicionário de adjacencias, pode causar problema na proxima geração. Caso aconteça,arrumar

            linha.append(val)
            #print(linha)

        matrix.append(linha)

    return matrix




if __name__ == "__main__":
    start_time = time.time()
    with open('data_00.pkl', 'rb') as file:
        data_00 = pickle.load(file)

    with open('data_neighbours.pkl', 'rb') as file:
        data_adj = pickle.load(file)

  #  prefixos_de_tamanho = {4: "00", 8: "01", 16: "10", 32: "11"}
    for blocks in range(0,1):
        i = 1 #random.randint(0, 1)  # 0 a 3
        N = 32#4 * pow(2, i)
        #size = prefixos_de_tamanho[N]
        matrix = gera_bloco(N,N, data_00, data_adj)
        matrix = np.array(matrix)
        plt.imshow(matrix, cmap='bwr')  # 'viridis' is just one of many available colormaps
        plt.colorbar()  # Add a color bar to show the scale
        plt.show()
        print(matrix)

    #print(data[0]['ocorrencias'])




    end_time = time.time()
    total_time = end_time - start_time

    
    
    
