from mpi4py import MPI
import time
import math
import argparse


def evaluate(x):
    """Simulate an expensive computation (e.g. a model run)."""
    time.sleep(1)
    return math.sin(x)


# Each MPI process independently executes this block
if __name__ == "__main__":
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    parser = argparse.ArgumentParser()
    parser.add_argument('--size', type=int, default=6,
                        help='Number of parameter values to evaluate (default: 6)')
    args = parser.parse_args()

    # All parameter values — distributed across ranks via interleaved assignment.
    # With 3 ranks and 6 params: rank 0 → [0.0, 1.5], rank 1 → [0.5, 2.0], rank 2 → [1.0, 2.5]
    params = [i * 0.5 for i in range(args.size)]
    local_params = params[rank::size]

    start = MPI.Wtime()

    # Each rank evaluates its assigned subset in parallel
    local_results = []
    for x in local_params:
        result = evaluate(x)
        local_results.append((x, result))
        print(f'Rank {rank}: evaluate({x:.1f}) = {result:.4f}')

    # Gather all results to rank 0
    all_results = comm.gather(local_results, root=0)

    if rank == 0:
        elapsed = MPI.Wtime() - start
        results = sorted(item for sublist in all_results for item in sublist)
        print(f'\nAll results gathered at rank 0:')
        for x, result in results:
            print(f'  evaluate({x:.1f}) = {result:.4f}')
        print(f'\nDone. Evaluated {len(results)} parameter values.')
        print(f'Total time: {elapsed:.2f} seconds')
