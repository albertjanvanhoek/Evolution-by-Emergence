"""
Illustrative simulation for the log-slack filtered candidate process.

This is not a proof. The analytical result in the manuscript uses the SLLN
and Borel--Cantelli. This script checks two numerical signatures:

1. when E[log r] < 0, log-slack grows linearly at rate approximately -E[log r];
2. when E[log r] > 0, the retention filter creates a bounded/mean-reverting
   regime in these Gaussian examples, and the acceptance fraction is NOT
   simply P(log r <= 0).

Only the Python standard library is used.
"""
import math
import random
import statistics

SEED = 20260914
N = 8000
REPS = 80
W0 = math.log(2.0)


def normal_cdf(x, mu, sig):
    z = (x - mu) / (sig * math.sqrt(2.0))
    return 0.5 * (1.0 + math.erf(z))


def run(mu, sig):
    rng = random.Random(SEED + int(round(1000 * (mu + 5))))
    ends = []
    tail_accept = []
    for _ in range(REPS):
        W = W0
        accepted_tail = 0
        tail_n = 0
        for n in range(N):
            y = rng.gauss(mu, sig)
            if y <= W:
                W -= y
                if n >= N // 2:
                    accepted_tail += 1
            if n >= N // 2:
                tail_n += 1
        ends.append(W)
        tail_accept.append(accepted_tail / tail_n)
    mean_end = statistics.fmean(ends)
    drift = (mean_end - W0) / N
    acc = statistics.fmean(tail_accept)
    pwind = normal_cdf(0.0, mu, sig)
    return mean_end, drift, acc, pwind


rows = []
for mu, sig in [(-0.30, 0.5), (-0.10, 0.5), (0.10, 0.5),
                (0.30, 0.5), (0.80, 0.5)]:
    rows.append((mu, sig, *run(mu, sig)))

print(" mu    sig   W_end    drift/n   tail_accept   P(Y<=0)")
for row in rows:
    mu, sig, Wend, drift, acc, pwind = row
    print(f"{mu:+.2f}  {sig:.2f}  {Wend:8.3f}  {drift:+.5f}     {acc:.4f}       {pwind:.4f}")

# Negative-mean regime: asymptotic drift should be -mu.
for mu, sig, Wend, drift, acc, pwind in rows[:2]:
    assert abs(drift - (-mu)) < 0.02, (mu, drift)

# Positive-mean Gaussian examples: acceptance exceeds the pure winding
# fraction because some spending candidates 0 < Y <= W are still accepted.
for mu, sig, Wend, drift, acc, pwind in rows[2:]:
    assert acc > pwind + 0.02, (mu, acc, pwind)

print("ALL LOG-SLACK CHECKS PASS")
