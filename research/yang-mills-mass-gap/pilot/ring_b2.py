"""Ring test for step 3: does a far-away tilt of retained spins move a freed retained spin?

Decimated 2D O(3) at b = 2, periodic planar pattern
    eta_(2m,2n) = ((-1)^m e_x + (-1)^n e_y) / sqrt(2)   on (2Z)^2.
Torus of side L, centre c on (2Z)^2, distance d(x) = max(|x1 - c1|, |x2 - c2|).
  - retained spin at c: FREE (sigma_0, the observable);
  - other retained spins with d <= R: eta;
  - retained spins with R < d <= 2R (annulus A_R): cos(eps) eta +/- sin(eps) e_z;
  - retained spins with d > 2R (only if L > 4R): eta;
  - all hidden spins free.
Delta_R = <sigma_0^z>_{+ring} - <sigma_0^z>_{-ring}.

Each ring is run from hidden starts near +z, near -z and random, two seeds each.
Updates: Metropolis + overrelaxation (stage2.sweep2) plus, once per sweep, a global
move that flips the z-component of every free spin, accepted with the true energy
change (only couplings to tilted retained spins change). This move is an involution
with a symmetric proposal, so it keeps the Gibbs measure.

Usage: python ring_b2.py BETA R [L [EPS]]   (L defaults to 4R, EPS to 0.3;
       writes ring_b2_beta{BETA}_R{R}_L{L}[_eps{EPS}].json/.npz)
"""

import json
import math
import sys
import time

import numpy as np
from numba import njit

sys.path.insert(0, ".")
from pilot import seed  # noqa: E402
from stage2 import sweep2  # noqa: E402
from periodic_b2 import tau_int  # noqa: E402

EPS = 0.3   # tilt angle of the annulus spins, radians
BLOCK = 10  # saved time series are means over blocks of this many sweeps


@njit(cache=True)
def zflip_move(s, beta, frozen):
    """Propose s^z -> -s^z for all free spins; accept with exp(-beta dH)."""
    L = s.shape[0]
    dH = 0.0
    for i in range(L):
        for j in range(L):
            if frozen[i, j] and s[i, j, 2] != 0.0:
                nz = (s[(i + 1) % L, j, 2] + s[(i - 1) % L, j, 2]
                      + s[i, (j + 1) % L, 2] + s[i, (j - 1) % L, 2])
                dH += 2.0 * s[i, j, 2] * nz
    if dH <= 0.0 or np.random.random() < math.exp(-beta * dH):
        for i in range(L):
            for j in range(L):
                if not frozen[i, j]:
                    s[i, j, 2] = -s[i, j, 2]
        return 1
    return 0


@njit(cache=True)
def run_chain(s, beta, frozen, inner, c, ntherm, nmeas):
    L = s.shape[0]
    acc = 0
    for _ in range(ntherm):
        sweep2(s, beta, frozen, 0.5)
        zflip_move(s, beta, frozen)
    s0 = np.empty(nmeas)
    mi = np.empty(nmeas)
    en = np.empty(nmeas)
    nin = 0
    for i in range(L):
        for j in range(L):
            if inner[i, j]:
                nin += 1
    for t in range(nmeas):
        sweep2(s, beta, frozen, 0.5)
        acc += zflip_move(s, beta, frozen)
        s0[t] = s[c, c, 2]
        m = 0.0
        e = 0.0
        for i in range(L):
            for j in range(L):
                if inner[i, j]:
                    m += s[i, j, 2]
                for k in range(3):
                    e -= s[i, j, k] * (s[(i + 1) % L, j, k] + s[i, (j + 1) % L, k])
        mi[t] = m / nin
        en[t] = e / (L * L)
    return s0, mi, en, acc / nmeas


def setup(L, R, ring, start, rng):
    c = L // 2
    s = np.empty((L, L, 3))
    frozen = np.zeros((L, L), dtype=np.bool_)
    inner = np.zeros((L, L), dtype=np.bool_)   # hidden odd-odd spins with d <= R
    for i in range(L):
        for j in range(L):
            d = max(abs(i - c), abs(j - c))
            if i % 2 == 0 and j % 2 == 0:
                m, n = i // 2, j // 2
                eta = np.array([(-1) ** m, (-1) ** n, 0.0]) / math.sqrt(2)
                if (i, j) == (c, c):
                    s[i, j] = eta          # free, starts in-plane
                    continue
                frozen[i, j] = True
                if R < d <= 2 * R:
                    s[i, j] = math.cos(EPS) * eta + ring * math.sin(EPS) * np.array([0, 0, 1.0])
                else:
                    s[i, j] = eta
                continue
            if i % 2 == 1 and j % 2 == 1 and d <= R:
                inner[i, j] = True
            if start == "up":
                v = np.array([0, 0, 1.0]) + 0.3 * rng.normal(size=3)
            elif start == "down":
                v = np.array([0, 0, -1.0]) + 0.3 * rng.normal(size=3)
            else:
                v = rng.normal(size=3)
            s[i, j] = v / np.linalg.norm(v)
    return s, frozen, inner, c


def main():
    beta = float(sys.argv[1])
    R = int(sys.argv[2])
    global EPS
    L = int(sys.argv[3]) if len(sys.argv) > 3 else 4 * R
    if len(sys.argv) > 4:
        EPS = float(sys.argv[4])
    assert L % 4 == 0 and L >= 4 * R
    ntherm, nmeas = 4000, 16000
    out = {"beta": beta, "R": R, "L": L, "eps": EPS, "ntherm": ntherm, "nmeas": nmeas,
           "block": BLOCK, "runs": []}
    series = {}
    t0 = time.time()
    for ring in (+1, -1):
        for start in ("up", "down", "random"):
            for sd in (1, 2):
                seedv = int(1000 * beta) * 100000 + 1000 * R + 10 * L + sd \
                    + {"up": 0, "down": 3, "random": 6}[start] + (0 if ring > 0 else 50)
                rng = np.random.default_rng(seedv)
                seed(seedv)
                s, frozen, inner, c = setup(L, R, ring, start, rng)
                s0, mi, en, acc = run_chain(s, beta, frozen, inner, c, ntherm, nmeas)
                key = f"{'p' if ring > 0 else 'm'}_{start}_{sd}"
                nb = nmeas // BLOCK
                series[key + "_s0"] = s0[:nb * BLOCK].reshape(nb, BLOCK).mean(1).astype(np.float32)
                series[key + "_min"] = mi[:nb * BLOCK].reshape(nb, BLOCK).mean(1).astype(np.float32)
                h = nmeas // 2
                out["runs"].append({
                    "ring": ring, "start": start, "seed": seedv, "zflip_acc": acc,
                    "mean_s0z": float(s0.mean()), "mean_s0z_first_half": float(s0[:h].mean()),
                    "mean_s0z_second_half": float(s0[h:].mean()),
                    "mean_m_inner": float(mi.mean()), "mean_abs_m_inner": float(np.abs(mi).mean()),
                    "tau_s0z": tau_int(s0), "tau_m": tau_int(mi), "tau_m2": tau_int(mi ** 2),
                    "tau_m4": tau_int(mi ** 4), "tau_E": tau_int(en),
                })
                r = out["runs"][-1]
                print(f"beta={beta} R={R} L={L} ring={ring:+d} {start:6s} sd={sd}: "
                      f"<s0z>={r['mean_s0z']:+.3f} (halves {r['mean_s0z_first_half']:+.3f} "
                      f"{r['mean_s0z_second_half']:+.3f}) m_in={r['mean_m_inner']:+.3f} "
                      f"tau s0z={r['tau_s0z']:.0f} m={r['tau_m']:.0f} m2={r['tau_m2']:.0f} "
                      f"m4={r['tau_m4']:.0f} E={r['tau_E']:.0f} flip_acc={acc:.3f} ({time.time() - t0:.0f}s)",
                      flush=True)
    rp = [r["mean_s0z"] for r in out["runs"] if r["ring"] > 0]
    rm = [r["mean_s0z"] for r in out["runs"] if r["ring"] < 0]
    se = math.sqrt(np.var(rp, ddof=1) / len(rp) + np.var(rm, ddof=1) / len(rm))
    out["Delta"] = float(np.mean(rp) - np.mean(rm))
    out["Delta_se_over_runs"] = float(se)
    print(f"beta={beta} R={R} L={L}: Delta_R = {out['Delta']:+.4f} +- {se:.4f}", flush=True)
    tag = f"ring_b2_beta{beta}_R{R}_L{L}" + ("" if EPS == 0.3 else f"_eps{EPS}")
    with open(tag + ".json", "w") as f:
        json.dump(out, f, indent=1)
    np.savez_compressed(tag + ".npz", **series)


if __name__ == "__main__":
    main()
