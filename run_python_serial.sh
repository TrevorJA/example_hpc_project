#!/bin/bash

#SBATCH --job-name=serial_demo
#SBATCH --output=output/output_text.txt
#SBATCH --error=output/error_text.txt
#SBATCH --time=00:10:00
#SBATCH --exclusive

# Load the Python module
module load python/3.11.5

# Activate the local environment with custom libraries
source venv/bin/activate

# Run the Python script
python3 python_code/python_demo_serial.py
