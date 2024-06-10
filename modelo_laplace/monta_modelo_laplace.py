import struct
import matplotlib.pyplot as plt
import time
import pickle

#TODO: Incluir sample diagonal no modelo

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
def prepare_probabilites_laplace(data):
    """
    Pega o dicionário de dados e itera sobre cada valor transformando seu valor de ocorrência na faixa superior utilizada para geração de número aleatório
    exemplo:
        {1:{'total_vizinhos': 10,1:4,5:2,9:4}}
    """
    data_aux = data.copy() #dict(sorted(data.items(), key=lambda item: item[1]))
    soma = 0
    data_aux = dict(sorted(data_aux.items(), key=lambda item: item[1]))
    print(data_aux)
    for indice in data_aux:
        if indice == 'total':
            pass
        else:    
            data_aux[indice]+=soma
            soma = data_aux[indice]
    return data_aux


def get_total_samples(data): #verificar se bate com o total retornado na main, mas acho que sim
    return max(data)


def plot_dist(data_neighbours,total):
    data_total = {}
    #total_samples = get_total_samples(data_neighbours)
    soma = 0
    for indice in data_neighbours:
        if indice == 'total':
            pass
        else:
            print(indice, data_neighbours[indice])
            data_total[indice] = data_neighbours[indice]/total
            soma += data_total[indice]
    print(f"CU {soma}")
    print(f"total: {total}, total_dic: {data_neighbours['total']}")


    fig, ax = plt.subplots()
    
    # Plot the data
    ax.bar(data_total.keys(),data_total.values())
    
    # Add labels and title
    ax.set_xlabel('Valor de Amostra')
    ax.set_ylabel('Numero de ocorrências')
    ax.set_title('Distribuição de valores de Resíduo')
    
    # Show the plot
    plt.show()



def prepare_data_laplace(matrix, size, data):
    '''
    Percorre valor por valor da matriz criando um dicionário de dicionários indicando a ocorrência de vizinhanças
    para cada valor de indíce.
    Exemplo data_aux[77] = {"total": 30, 102: 28, -80, 2}
    nesse exemplo, foram encontrados 30 amostras vizinhas para o valor 77, 28 amostras de valor 102 e 2 amostras de valor -80
    '''
    data_aux = data.copy()
   # print(matrix)
    for i in range(0,size):
        for j in range(0,size):
            current_value = matrix[i][j]
            if current_value>255:
                current_value = 255
            elif current_value <-256:
                current_value = -256

            if current_value not in data_aux: 
                data_aux[current_value] = 1
            else:
                data_aux[current_value] += 1
            data_aux['total']+=1

    return data_aux

def read_file(file_paths):
    data_neighbours = {'total':0}
    total_samples = 0
    for file_path in file_paths:
        try:
            with open(file_path, 'rb') as file:
                print(f"trabalhando em {file_path}")
                while True:
                    # Read width (uint8_t)
                    width_bytes = file.read(1)
                    if len(width_bytes) < 1:
                        print("End of file reached or insufficient data for width.")
                        break  # End of file reached
                    width = struct.unpack('B', width_bytes)[0]  # Use 'B' for unsigned 8-bit integer
                   # print(f"W = {width}")
    
                    # Read height (uint8_t)
                    height_bytes = file.read(1)
                    if len(height_bytes) < 1:
                        print("End of file reached or insufficient data for height.")
                        break  # End of file reached
                    height = struct.unpack('B', height_bytes)[0]  # Use 'B' for unsigned 8-bit integer
                    total_samples += width*height
                  #  print(f"H = {height}")
    
                    # Read the matrix of 9-bit integers packed into 16-bit integers
                    matrix = []
                    for i in range(height):
                        row = []
                        for j in range(width):
                            # Read a 16-bit integer
                            value_bytes = file.read(2)
                            if len(value_bytes) < 2:
                                raise ValueError("File does not contain enough bytes to read matrix data.")
                            
                            # Unpack the 16-bit integer and extract the 9-bit value
                            packed_value = struct.unpack('<h', value_bytes)[0]  # Little-endian signed short (16-bit)
    
                            if packed_value > 255:
                                packed_value = -((packed_value ^ 0xFF00) +1)
                                packed_value = str(bin(packed_value))
                                packed_value = packed_value[7:]
                                packed_value = (int(packed_value, 2) - (1 << len(packed_value)))
    
                            row.append(packed_value)
                     #   print(row)
                        matrix.append(row)
                    #print(matrix)
    
                    data_neighbours = prepare_data_laplace(matrix, width, data_neighbours)
                   # print(data)
    
                    #print()  # Add a newline for readability between matrices
            

        except FileNotFoundError:
            print(f"File {file_path} not found.")

    return data_neighbours, total_samples

if __name__ == "__main__":
    start_time = time.time()
    file_paths = ['saida_bin.dat']
    data_neighbours, total_samples = read_file(file_paths)
    #total_samples = get_total_samples(data_neighbours)
   # print(data_00)
  #  print(data_neighbours)
    end_time = time.time()
    total_time = end_time - start_time
    print(f"{GREEN} DONE: {total_samples} samples processed in {total_time:.2f} secs{RESET}")
    plot_dist(data_neighbours,total_samples)

    #Dicionário com dados puros. Antes do tratametno de probabilidade
    with open('untreated_data_neighbours.pkl','wb') as file:
        pickle.dump(data_neighbours, file)

    data_neighbours = prepare_probabilites_laplace(data_neighbours)

    #print(data_00)


    with open('data_neighbours.pkl', 'wb') as file: #salvando o dicionário de adjacencia
        pickle.dump(data_neighbours, file)

    #with open('data_neighbours.pkl', 'rb') as file:
    #    loaded_dict = pickle.load(file)

    
    
