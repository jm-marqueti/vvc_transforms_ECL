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

def gera_valor(data_adj):
    max_val = data_adj['total']
    data_aux = data_adj.copy()
    print(data_aux)
    data_aux.pop('total')
    #print(max_val)
    r = random.randint(0,max_val)
    print(max_val, r)
    for val in data_aux:
        if r <= data_aux[val]:
            valor_gerado = val
            print(valor_gerado)
            #quit()
            break

    return valor_gerado


def gera_bloco(w,h,data_adj):
    matrix = []
    for i in range(0,w):
        linha = []
        for j in range(0,h):
            val = gera_valor(data_adj)
            linha.append(val)
            #print(linha)

        matrix.append(linha)
        print(matrix)

    return matrix

import pandas as pd
def gera_matriz_correlacao_real(data_adj):
    # Define the full range of indices
    index_range = range(-256, 256 + 1)
    
    # Create an empty DataFrame with the full range of indices for both rows and columns
    full_df = pd.DataFrame(0, index=index_range, columns=index_range)
    
    # Populate the DataFrame with values from the dictionary
    for row_idx, col_dict in data_adj.items():
        for col_idx, value in col_dict.items():
            full_df.at[row_idx, col_idx] = value
    
    # Compute the correlation matrix
    correlation_matrix = full_df.corr()
    
    # Plot the correlation matrix
    plt.figure(figsize=(10, 10))
    plt.imshow(correlation_matrix, cmap='coolwarm', vmin=-1, vmax=1, extent=(-256, 255, 255, -256))
    plt.colorbar(label='Correlation')
    plt.title('Correlation Matrix')
    plt.xlabel('Column Index')
    plt.ylabel('Row Index')
    
    # Set ticks to show the full range from -256 to 255
    ticks = np.arange(-256, 257, 64)  # Adjust the step as needed for readability
    plt.xticks(ticks=ticks, labels=ticks)
    plt.yticks(ticks=ticks, labels=ticks)
    
    plt.show()

def gera_matriz_correlacao_pseudo(matrix):
    # Convert the matrix to a DataFrame
    df = pd.DataFrame(matrix)
    
    # Compute the correlation matrix
    correlation_matrix = df.corr()
    
    # Plot the correlation matrix
    plt.figure(figsize=(10, 10))
    plt.imshow(correlation_matrix, cmap='coolwarm', vmin=-1, vmax=1)
    plt.colorbar(label='Correlation')
    plt.title('Correlation Matrix')
    plt.xlabel('Column Index')
    plt.ylabel('Row Index')
    
    # Set ticks to match DataFrame indices
    ticks = np.arange(df.shape[1])
    plt.xticks(ticks=ticks, labels=ticks)
    plt.yticks(ticks=ticks, labels=ticks)
    
    plt.show()

def gera_matriz_probabilidades(data):
    data_aux = data.copy()
    mat_aux = []
    max_ocr = 0
    min_ocr = 70000000000
    total_ocr = 0
    for i in range(0,512):
        l = []
        for j in range(0,512):
            l.append(0)
        mat_aux.append(l)

    for key in data:
        data_aux[key].pop("total_vizinhos")
        if data_aux[key]["ocorrencias"] > max_ocr:
            max_ocr = data_aux[key]["ocorrencias"]
        elif data_aux[key]["ocorrencias"] < min_ocr:
            min_ocr = data_aux[key]["ocorrencias"]
        total_ocr += data_aux[key]["ocorrencias"]
        data_aux[key].pop("ocorrencias")


    for key in data:
        for subkey in data_aux[key]:
            #print(f"key {key} subkey {subkey}")
            mat_aux[key+256][subkey+256]=data_aux[key][subkey]/total_ocr

    mat_aux=np.array(mat_aux)
    plt.imshow(mat_aux, cmap='coolwarm', vmin=0, vmax=0.3, extent=(-256, 255, -256, 255))
    plt.colorbar(label='Value')
    plt.title('Matriz de correlação')
    plt.xlabel('Column Index')
    plt.ylabel('Row Index')
    
    # Set ticks to show the full range from -256 to 255
    ticks = np.arange(-256, 256, 1)  # Adjust the step as needed for readability
    plt.xticks(ticks=ticks, labels=ticks)
    plt.yticks(ticks=ticks, labels=ticks)
    
    plt.show()
    #print(matrix)


if __name__ == "__main__":
    start_time = time.time()

    with open('data_neighbours.pkl', 'rb') as file:
        data_adj = pickle.load(file)

    #gera_matriz_probabilidades(data_adj)

  #  prefixos_de_tamanho = {4: "00", 8: "01", 16: "10", 32: "11"}

    with open('data_neighbours.pkl', 'rb') as file:
        data_adj = pickle.load(file)
    for blocks in range(0,1):
        i = 1 #random.randint(0, 1)  # 0 a 3
        N = 32#4 * pow(2, i)
        #size = prefixos_de_tamanho[N]
        matrix = gera_bloco(N,N, data_adj)
        matrix = np.array(matrix)
        gera_matriz_correlacao_pseudo(matrix)
        plt.imshow(matrix, cmap='bwr', vmin=-256, vmax=255)  # 'viridis' is just one of many available colormaps
        plt.colorbar()  # Add a color bar to show the scale
        plt.show()
       # print(data_adj[0])

    #print(data_adj)

    #print(data[0]['ocorrencias'])




    end_time = time.time()
    total_time = end_time - start_time

    
    
    
