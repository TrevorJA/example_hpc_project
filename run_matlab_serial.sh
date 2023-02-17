#!/bin/bash
#SBATCH --job-name=DEMO
#SBATCH --output=output/output_text.txt
#SBATCH --error=output/error_text.txt
#SBATCH --exclusive

# Load the module
module load matlab/R2021a

# Run the code (not parallel)
matlab matlab_code/code.m
