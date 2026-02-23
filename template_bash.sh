#!/bin/bash
#SBATCH --ntasks=1 --nodes=1
#SBATCH --job-name=NAME
#SBATCH --output=output/output_text.txt
#SBATCH --error=output/error_text.txt
#SBATCH --time=HH:MM:SS
#SBATCH --exclusive

# Load the required software module for the specific language
module load <language>

# Set the input variable(s) if needed
input="<input>"

# Execute the code with the specified input, and redirect both output and errors to text files
<language> <code_file> $input > <output_file>.txt 2> <error_file>.txt
