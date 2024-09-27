from math import exp
import sys,random,os
from time import time

# To add the repo dir to PYTHONPATH, so that the ezr module is accessible
SCRIPT_DIR = os.path.dirname(__file__)
REPO_DIR = "/".join(SCRIPT_DIR.split("/")[:-1])
sys.path.append(REPO_DIR)

from ezr import the, DATA, csv
import stats

def guess(d, N):
    some = random.choices(d.rows, k=N)
    return d.clone(some).chebyshevs().rows

def experiment(data, repeats = 20):
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
            result += [d.chebyshev(tmp[0])]

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
                    tmp = d.shuffle().activeLearning(score=how)
                    runs += len(tmp)
                    result += [rnd(d.chebyshev(tmp[0]))]

                pre=f"{what}/b={the.branch}" if the.Last >0 else "rrp"
                tag = f"{pre},{int(runs/repeats)}"
                print(tag, f": {(time() - start) /repeats:.2f} secs")
                somes +=   [stats.SOME(result,    tag)]
    
    stats.report(somes, 0.01)
    
[experiment(arg) for arg in sys.argv if arg[-4:] == ".csv"]