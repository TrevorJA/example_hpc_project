#!/bin/bash

# Load the required software module for the specific language
module load <language>

# Set the input variable
input="<input>"

# Execute the code with the specified input, and redirect both output and errors to text files
<language> <code_file> $input > <output_file>.txt 2> <error_file>.txt

# Check if the code execution was successful, and if not, print an error message
if [ $? -ne 0 ]; then
  echo "Error: code execution failed"
fi
