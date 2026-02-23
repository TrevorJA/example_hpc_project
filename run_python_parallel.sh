#!/bin/bash
#SBATCH --ntasks=3
#SBATCH --job-name=parallel_demo
#SBATCH --output=logs/parallel_out.txt
#SBATCH --error=logs/parallel_err.txt
#SBATCH --time=00:10:00
#SBATCH --exclusive

# Load the MPI module
module load python/3.11.5

# Use the number of tasks requested from SLURM
np=$SLURM_NTASKS

# Activate the local environment with custom libraries
source venv/bin/activate

# Run the Python script using MPI
# The "$@" allows you to pass additional command-line arguments to the python script
mpirun -np $np python python_code/python_demo_parallel.py "$@"
