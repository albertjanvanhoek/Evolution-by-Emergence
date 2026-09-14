"""
Illustrative simulation for the log-slack filtered **realized-multiplier** process.

The random variable Y=log r is sampled directly. This is not a simulation of
i.i.d. intrinsic kappa loads in the simultaneous shared-pool topology, because
there the realized r depends on the accumulated load state.

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




def normal_pdf_std(z):
    return math.exp(-0.5 * z * z) / math.sqrt(2.0 * math.pi)


def gaussian_truncated_mean(w, mu, sig):
    """E[Y 1{Y<=w}] for Y ~ Normal(mu, sig^2)."""
    z = (w - mu) / sig
    return mu * normal_cdf(w, mu, sig) - sig * normal_pdf_std(z)


def drift_zero_gaussian(mu, sig):
    lo, hi = 0.0, max(1.0, mu + 10.0 * sig)
    assert gaussian_truncated_mean(lo, mu, sig) < 0.0
    while gaussian_truncated_mean(hi, mu, sig) <= 0.0:
        hi *= 2.0
    for _ in range(100):
        mid = 0.5 * (lo + hi)
        if gaussian_truncated_mean(mid, mu, sig) <= 0.0:
            lo = mid
        else:
            hi = mid
    return 0.5 * (lo + hi)


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



print("\npositive-mean Gaussian drift-zero levels:")
for mu, sig in [(0.30, 0.5), (0.80, 0.5), (0.30, 1.0)]:
    wstar = drift_zero_gaussian(mu, sig)
    accept_at_wstar = normal_cdf(wstar, mu, sig)
    gleft = gaussian_truncated_mean(max(0.0, wstar - 1e-4), mu, sig)
    gright = gaussian_truncated_mean(wstar + 1e-4, mu, sig)
    assert gleft <= 0.0 <= gright
    print(f"mu={mu:.2f}, sig={sig:.2f}: w*={wstar:.6f}, accept@w*={accept_at_wstar:.6f}")

print("ALL LOG-SLACK CHECKS PASS")

