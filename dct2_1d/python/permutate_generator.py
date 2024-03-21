def find_sequence(arrays):

    sequence = []
    # Initialize pointers for each array
    pointers = [0] * len(arrays)

    # Keep track of the last printed array index
    last_array_index = -1

    # Loop until one of the arrays is exhausted
    while any(ptr < len(arr) for ptr, arr in zip(pointers, arrays)):
        # Find the minimum value among the current pointers
        min_val = float('inf')
        min_arr = None

        for i, ptr in enumerate(pointers):
            if ptr < len(arrays[i]) and arrays[i][ptr] < min_val:
                min_val = arrays[i][ptr]
                min_arr = i

        # Print the array from which the minimum value comes
        if min_arr != last_array_index:
            sequence.append(min_arr + 1)
            last_array_index = min_arr

        # Move the pointer of the corresponding array
        pointers[min_arr] += 1
    return sequence

N = 32

# Matrices
arr1 = [0,16] #Y2E
arr2 = [8,24] #Y2O
arr3 = [4,12,20,28] #Y4O
arr4 = [2,6,10,14,18,22,26,30] #Y8O
arr5 = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31] #Y16O


sequence = find_sequence([arr1, arr2, arr3, arr4,arr5])

print("assign Y_" + str(N) + " = {", end='')

amount1 = 0
amount2 = 0
amount3 = 0
amount4 = 0
amount5 = 0

for i in range(0,len(sequence)):
    index = sequence[i]
    if (index == 1):
        print("Y2E["+ str(amount1) +"], ", end='')
        amount1 = amount1 + 1
    elif (index == 2):
        print("Y2O["+ str(amount2) +"], ", end='')
        amount2 = amount2 + 1
    elif (index == 3):
        print("Y4O["+ str(amount3) +"], ", end='')
        amount3 = amount3 + 1
    elif (index == 4):
        print("Y8O["+ str(amount4) +"], ", end='')
        amount4 = amount4 + 1
    elif (index == 5):
        print("Y16O["+ str(amount5) +"], ", end='')
        amount5 = amount5 + 1

print(str( 512 - (16*len(sequence)))+"'d0};")
