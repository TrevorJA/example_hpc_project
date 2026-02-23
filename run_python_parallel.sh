#!/bin/bash
#SBATCH --ntasks=3
#SBATCH --job-name=parallel_demo
#SBATCH --output=output/output_text.txt
#SBATCH --error=output/error_text.txt
#SBATCH --time=00:10:00
#SBATCH --exclusive

# Load the MPI module
module load python/3.11.5

# Use the number of tasks requested from SLURM
np=$SLURM_NTASKS

# Activate the local environment with custom libraries
source venv/bin/activate

# Run the Python script using MPI
mpirun -np $np python python_code/python_demo_parallel.py
