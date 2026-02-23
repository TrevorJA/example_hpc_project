#!/bin/bash

#SBATCH --job-name=serial_demo
#SBATCH --output=logs/serial_out.txt
#SBATCH --error=logs/serial_err.txt
#SBATCH --time=00:10:00
#SBATCH --exclusive

# Load the Python module
module load python/3.11.5

# Activate the local environment with custom libraries
source venv/bin/activate

# Run the Python script
# The "$@" allows you to pass additional command-line arguments to the python script
# Pass --size N to increase the number of parameter values 
python3 python_code/python_demo_serial.py "$@"
