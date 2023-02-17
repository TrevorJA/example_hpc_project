from mpi4py import MPI
import time

def hello():
    # Get MPI info
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    print(f'Hello world, from rank {rank}!')
    time.sleep(3)
    return


# Execute the function if this script is called
if __name__ == "__main__":
    n_processes = 3
    for i in range(n_processes):
        hello()
