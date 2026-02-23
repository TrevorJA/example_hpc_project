import time
import math
import argparse


def evaluate(x):
    """Simulate an expensive computation (e.g. a model run)."""
    time.sleep(1)
    return math.sin(x)


# Execute the function if this script is called
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--size', type=int, default=6,
                        help='Number of parameter values to evaluate (default: 6)')
    args = parser.parse_args()

    # Parameter values to evaluate — processed one at a time
    params = [i * 0.5 for i in range(args.size)]

    start = time.perf_counter()

    results = []
    for x in params:
        result = evaluate(x)
        results.append((x, result))
        print(f'evaluate({x:.1f}) = {result:.4f}')

    elapsed = time.perf_counter() - start
    print(f'\nDone. Evaluated {len(results)} parameter values.')
    print(f'Total time: {elapsed:.2f} seconds')
