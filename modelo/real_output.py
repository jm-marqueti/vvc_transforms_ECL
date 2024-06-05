import struct
import matplotlib.pyplot as plt
import time
import pickle
import numpy as np
#[ N, N dados de 9 bits, zeros até atingir 290 bits]  #
def read_file(file_paths):
    count = 0
    real_matrixes = []
    bin_matrixes = []
    for file_path in file_paths:
        try:
            with open(file_path, 'rb') as file:
                print(f"trabalhando em {file_path}")
                while count<3:
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
                    #total_samples += width*height
                  #  print(f"H = {height}")
    
                    # Read the matrix of 9-bit integers packed into 16-bit integers
                    matrix = []
                    bin_matrix = []
                    for i in range(height):
                        row = []
                        bin_row = []
                        for j in range(width):
                            # Read a 16-bit integer
                            value_bytes = file.read(2)
                            if len(value_bytes) < 2:
                                raise ValueError("File does not contain enough bytes to read matrix data.")
                            
                            # Unpack the 16-bit integer and extract the 9-bit value
                            packed_value = struct.unpack('<h', value_bytes)[0]  # Little-endian signed short (16-bit)

                            if packed_value < 0:
                                bin_val = f'{(1 <<9) + packed_value:09b}'
                            else:
                                bin_val = f'{packed_value:09b}'
    
                            if packed_value > 255:
                                packed_value = -((packed_value ^ 0xFF00) +1)
                                packed_value = str(bin(packed_value))
                                packed_value = packed_value[7:]
                                packed_value = (int(packed_value, 2) - (1 << len(packed_value)))
    
    
    
                            row.append(packed_value)
                            bin_row.append(bin_val)
                     #   print(row)
                        matrix.append(row)
                        bin_matrix.append(bin_row)
                    #print(matrix)
                    
                    print(matrix)
                    print(bin_matrix)
                    real_matrixes.append(np.array(matrix))
                    bin_matrixes.append(np.array(bin_matrix))
                    count+=1
                   # print(data)
    
                    #print()  # Add a newline for readability between matrices
            

        except FileNotFoundError:
            print(f"File {file_path} not found.")

    return bin_matrixes


def prepare_output(bin_mat):
    prefixos_de_tamanho = {4: "00", 8: "01", 16: "10", 32: "11"}
    for matrix in bin_mat:
        size = len(matrix)
        linha = prefixos_de_tamanho[size]
        print(size)

if __name__ == "__main__":
    start_time = time.time()
    file_paths = ['saida_bin.dat']
    matrixes = read_file(file_paths)
    prepare_output(matrixes)
    #print(np.array(matrixes))
    #total_samples = get_total_samples(data_neighbours)
   # print(data_00)
  #  print(data_neighbours)
    end_time = time.time()
    total_time = end_time - start_time

        