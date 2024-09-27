from math import exp
import sys,random,os
from time import time

# To add the repo dir to PYTHONPATH, so that the ezr module is accessible
SCRIPT_DIR = os.path.dirname(__file__)
REPO_DIR = "/".join(SCRIPT_DIR.split("/")[:-1])
sys.path.append(REPO_DIR)

# Flag to enable tests
TEST=False

from ezr import the, DATA, csv
import stats

def guess(d, N):
    some = random.choices(d.rows, k=N)
    sample = d.clone(some)
    sorted_rows = sample.chebyshevs().rows
    if TEST:
        assert sorted_rows[0] == min(sample.rows, key=lambda x: sample.chebyshev(x)), "ERROR: chebyshevs() did not sort properly" # check
    return sorted_rows

def experiment(data, repeats = 20):
    if TEST:
        print("Testing is enabled")

    d = DATA().adds(csv(data))
    
    print(f"rows: {len(d.rows)}")
    print(f"xcols: {len(d.cols.x)}")
    print(f"ycols: {len(d.cols.y)}")
    print(f"dim: {"low" if len(d.cols.y) < 6 else "high"}")
    
    # Baseline
    start = time()
    b4 = [d.chebyshev(row) for row in d.rows]
    print("asIs", f": {(time() - start) /repeats:.2f} secs")
    somes = [stats.SOME(b4,f"asIs,{len(d.rows)}")]
    
    # Dumb
    for N in [20, 30, 40, 50]:
        start = time()
        result = []
        runs = 0
        for _ in range(repeats):
            tmp = guess(d, N)
            runs += len(tmp)
            if TEST:
                assert len(tmp) == N, "ERROR: guess() produced list with incorrect number of elements"
            result += [d.chebyshev(tmp[0])]
        if TEST:
            assert runs/N == repeats, f"ERROR: guess() did not run {repeats} times"
        tag = f"dumb,{int(runs/repeats)}"
        print(tag, f": {(time() - start) /repeats:.2f} secs")
        somes +=   [stats.SOME(result,    tag)]

    # Smart
    rnd = lambda z: z
    scoring_policies = [
        ('exploit', lambda B, R,: B - R),
        ('explore', lambda B, R :  (exp(B) + exp(R))/ (1E-30 + abs(exp(B) - exp(R))))
    ]
    
    for what,how in scoring_policies:
        for the.Last in [0,20, 30, 40, 50]:
            for the.branch in [False, True]:
                start = time()
                result = []
                runs = 0
                for _ in range(repeats):
                    if TEST:
                        assert d.rows.copy() != d.shuffle().rows, "ERROR: Shuffle did not change the order"
                    tmp = d.shuffle().activeLearning(score=how)
                    runs += len(tmp)
                    if TEST:
                        if the.Last > 0:
                            assert len(tmp) == the.Last, f"ERROR: activeLearning() produced list with incorrect number of elements for {the.Last}"
                    result += [rnd(d.chebyshev(tmp[0]))]

                if TEST:
                    if the.Last > 0:
                        assert runs/the.Last == repeats, f"ERROR: activeLearning() did not run {repeats} times"
                pre=f"{what}/b={the.branch}" if the.Last >0 else "rrp"
                tag = f"{pre},{int(runs/repeats)}"
                print(tag, f": {(time() - start) /repeats:.2f} secs")
                somes +=   [stats.SOME(result,    tag)]
    
    stats.report(somes, 0.01)

if len(sys.argv) > 2:
    TEST = sys.argv[2].lower() == 'true'

[experiment(arg) for arg in sys.argv if arg[-4:] == ".csv"]