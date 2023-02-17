#!/bin/bash
#SBATCH --job-name=serial_demo
#SBATCH --output=output/output_text.txt
#SBATCH --error=output/error_text.txt
#SBATCH --exclusive


# Load the Julia module
module load julia/1.6.2

# Run the Julia code (not parallel)
julia julia_code/code.jl
