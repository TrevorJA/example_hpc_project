import time
import math


def evaluate(x):
    """Simulate an expensive computation (e.g. a model run)."""
    time.sleep(1)
    return math.sin(x)


# Execute the function if this script is called
if __name__ == "__main__":
    # Parameter values to evaluate — processed one at a time
    params = [i * 0.5 for i in range(6)]

    results = []
    for x in params:
        result = evaluate(x)
        results.append((x, result))
        print(f'evaluate({x:.1f}) = {result:.4f}')

    print(f'\nDone. Evaluated {len(results)} parameter values.')
