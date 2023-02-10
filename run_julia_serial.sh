#!/bin/bash
# Load the Julia module
module load julia

# Run the Julia code (not parallel)
julia code.jl $1 $2
