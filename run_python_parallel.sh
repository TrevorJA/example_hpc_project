#!/bin/bash
#SBATCH --ntasks=3 --nodes=3
#SBATCH --job-name=parallel_demo
#SBATCH --output=output/output_text.txt
#SBATCH --error=output/error_text.txt
#SBATCH --exclusive

# Load the MPI module
module load python/3.9.4

# Define the number of processes to run
np=$3

# Activate the local environment with custom libraries
source venv/bin/activate

# Run the Python script using MPI
mpirun -np $np python python_code/python_demo_parallel.py
