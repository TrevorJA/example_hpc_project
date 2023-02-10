
import sys
import csv

def my_function(input_arg):
    # Your function logic here
    print("Running my_function with input:", input_arg)

if __name__ == "__main__":
    input_file = sys.argv[1]
    with open(input_file, 'r') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            input_arg = row[0]
            my_function(input_arg)
