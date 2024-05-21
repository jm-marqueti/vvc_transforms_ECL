import struct
import matplotlib.pyplot as plt

def prepare_probabilities(data):
    probabilities = {}
    for key in data:
        total = len(data[key]) #numero total de amostras
        dic_occurs = {} #dicionário indicando "vaolr de amostra : ocorrências"
        if key not in probabilities:
            probabilities[key] = {}


def prepare_data(matrix, size, data):
    '''
    Percorre valor por valor da matriz criando um dicionário de dicionários indicando a ocorrência de vizinhanças
    para cada valor de indíce.
    Exemplo data_aux[77] = {"total": 30, 102: 28, -80, 2}
    nesse exemplo, foram encontrados 30 amostras vizinhas para o valor 77, 28 amostras de valor 102 e 2 amostras de valor -80
    '''
    data_aux = data
   # print(matrix)
    for i in range(0,size):
        for j in range(0,size):
            current_value = matrix[i][j]
           # if current_value>255:
           #     print(current_value)
           # print(current_value)
            if current_value not in data_aux: 
                data_aux[current_value] = {'total':0} #inicializa o dicionário de valores no dicionário com contador total de amostras
            if i != size-1:
                hor_val = matrix[i+1][j]
                if hor_val not in data_aux[current_value]:
                    data_aux[current_value][hor_val] = 0
                data_aux[current_value][hor_val]+=1 #adiciona 1 no contador de ocorrência de vizinhança espacial do current_value
                data_aux[current_value]['total']+=1
            if j != size-1:
                vert_val = matrix[i][j+1]
                if vert_val not in data_aux[current_value]:
                    data_aux[current_value][vert_val] = 0
                data_aux[current_value][vert_val]+=1 #adiciona 1 no contador de ocorrência de vizinhança espacial do current_value
                data_aux[current_value]['total']+=1
    #print(data_aux)
    return data_aux

def read_file(file_path):
    data_neighbours = {}
    data_00 = {"total_blocos" : 0}

    try:
        with open(file_path, 'rb') as file:
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

                        if(j==i and i == 0):
                            if packed_value not in data_00:
                                data_00[packed_value] = 0
                            data_00[packed_value]+=1
                            data_00["total_blocos"]+=1


                        row.append(packed_value)
                 #   print(row)
                    matrix.append(row)
                #print(matrix)

                data_neighbours = prepare_data(matrix, width, data_neighbours)
               # print(data)

                #print()  # Add a newline for readability between matrices
            

    except FileNotFoundError:
        print(f"File {file_path} not found.")
    except ValueError as ve:
        print(f"Value error: {ve}")
   # except Exception as e:
   #     print(f"An error occurred: {e}")
    #print(data)
    return data_00, data_neighbours

if __name__ == "__main__":
    file_path = 'saida_bin.dat'
    data_00, data_neighbours = read_file(file_path)
    print(data_00)
    print(data_neighbours)
    data_total = {}
    for indice in data_neighbours:
        data_total[indice] = data_neighbours[indice]['total']

    fig, ax = plt.subplots()
    
    # Plot the data
    ax.bar(data_total.keys(),data_total.values())
    
    # Add labels and title
    ax.set_xlabel('Valor de Amostra')
    ax.set_ylabel('Numero de ocorrências')
    ax.set_title('Distribuição de valores de Resíduo')
    
    # Show the plot
    plt.show()

