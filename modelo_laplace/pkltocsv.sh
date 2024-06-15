#!/bin/bash

# Directory containing the .pkl files
directory="."

# Loop through all .pkl files in the directory
for input_file in "$directory"/*.pkl; do
    # Get the base name of the file (without the directory and extension)
    base_name=$(basename "$input_file" .pkl)
    
    # Define the output file name
    output_file="$directory/$base_name.csv"
    
    # Call the Python script to convert the .pkl file to .csv
    python3 ./pkl_to_csv.py "$input_file" "$output_file"
    
    # Check if the conversion was successful
    if [ $? -eq 0 ]; then
        echo "Converted $input_file to $output_file successfully."
    else
        echo "Failed to convert $input_file to $output_file."
    fi
done
