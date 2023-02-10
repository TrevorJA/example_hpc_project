#!/bin/bash

# Load the MPI module
module load mpi4py

# Define the number of processes to run
np=$1

# Define the input CSV file
input_file=$2

# Run the Python script using MPI
mpirun -np $np python script.py $input_file
