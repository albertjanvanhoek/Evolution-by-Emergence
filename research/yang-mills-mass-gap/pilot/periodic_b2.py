"""Periodic planar conditioning of decimated 2D O(3) at b = 2.

Retained spins on (2Z)^2 are fixed to
    eta_(2m,2n) = ((-1)^m e_x + (-1)^n e_y) / sqrt(2).
The hidden spins are all others. At zero temperature the odd-odd hidden spins
(tau) have exactly two energy minima, all +e_z or all -e_z (checked in review).
Leake and Li (arXiv:2611.05228, Theorem 5 / Remark 22) exclude phase
coexistence of the hidden system for beta < 3/sqrt(8) ~ 1.061. The question
here: is there a two-phase (Ising-like) regime at larger beta?

Measured on the tau spins: m_z (mean z-component), U4 = 1 - <m^4>/(3<m^2>^2),
the m_z histogram, and integrated autocorrelation times of m_z, m_z^2 and the
energy. Starts: hidden spins near +z, near -z, and random; two seeds each.
L must be a multiple of 4.

Usage: python periodic_b2.py L          (writes periodic_b2_L{L}.json)
       python periodic_b2.py L fine     (beta 2.6-2.9, writes periodic_b2_L{L}_fine.json)
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

BETAS = (0.8, 1.0, 1.25, 1.5, 2.0, 2.5, 3.0)


@njit(cache=True)
def run_chain(s, beta, frozen, ntherm, nmeas):
    L = s.shape[0]
    for _ in range(ntherm):
        sweep2(s, beta, frozen, 0.5)
    mz = np.empty(nmeas)
    en = np.empty(nmeas)
    ntau = (L // 2) * (L // 2)
    for t in range(nmeas):
        sweep2(s, beta, frozen, 0.5)
        m = 0.0
        for i in range(1, L, 2):
            for j in range(1, L, 2):
                m += s[i, j, 2]
        mz[t] = m / ntau
        e = 0.0
        for i in range(L):
            for j in range(L):
                for k in range(3):
                    e -= s[i, j, k] * (s[(i + 1) % L, j, k] + s[i, (j + 1) % L, k])
        en[t] = e / (L * L)
    return mz, en


def tau_int(x):
    """Integrated autocorrelation time with Sokal's automatic window (c = 6)."""
    x = np.asarray(x) - np.mean(x)
    n = len(x)
    if np.var(x) == 0:
        return 0.5
    f = np.fft.rfft(x, 2 * n)
    acf = np.fft.irfft(f * np.conj(f))[:n] / (np.var(x) * np.arange(n, 0, -1))
    tau = 0.5
    for w in range(1, n):
        tau += acf[w]
        if w >= 6 * tau:
            break
    return float(tau)


def setup(L, start, rng):
    s = np.empty((L, L, 3))
    for i in range(L):
        for j in range(L):
            if i % 2 == 0 and j % 2 == 0:
                m, n = i // 2, j // 2
                v = np.array([(-1) ** m, (-1) ** n, 0.0]) / math.sqrt(2)
            elif start == "up":
                v = np.array([0, 0, 1.0]) + 0.3 * rng.normal(size=3)
            elif start == "down":
                v = np.array([0, 0, -1.0]) + 0.3 * rng.normal(size=3)
            else:
                v = rng.normal(size=3)
            s[i, j] = v / np.linalg.norm(v)
    frozen = np.zeros((L, L), dtype=np.bool_)
    frozen[::2, ::2] = True
    return s, frozen


def main():
    global BETAS
    L = int(sys.argv[1])
    assert L % 4 == 0
    fine = len(sys.argv) > 2 and sys.argv[2] == "fine"
    if fine:
        BETAS = (2.6, 2.7, 2.8, 2.9)
    nmeas = {16: 40000, 32: 20000, 64: 8000}.get(L, 8000)
    ntherm = nmeas // 4
    out = {"L": L, "ntherm": ntherm, "nmeas": nmeas, "runs": []}
    t0 = time.time()
    for beta in BETAS:
        series = []
        for start in ("up", "down", "random"):
            for sd in (1, 2):
                seedv = 100 * L + 10 * BETAS.index(beta) + sd + {"up": 0, "down": 3, "random": 6}[start] * 1000
                rng = np.random.default_rng(seedv)
                seed(seedv)
                s, frozen = setup(L, start, rng)
                mz, en = run_chain(s, beta, frozen, ntherm, nmeas)
                series.append(mz)
                out["runs"].append({
                    "beta": beta, "start": start, "seed": seedv,
                    "mean_mz": float(mz.mean()), "mean_abs_mz": float(np.abs(mz).mean()),
                    "m2": float((mz ** 2).mean()), "m4": float((mz ** 4).mean()),
                    "frac_sign_flips": float(np.mean(np.diff(np.sign(mz)) != 0)),
                    "tau_mz": tau_int(mz), "tau_mz2": tau_int(mz ** 2), "tau_E": tau_int(en),
                    "hist": np.histogram(mz, bins=20, range=(-1, 1))[0].tolist(),
                })
        allm = np.concatenate(series)
        m2, m4 = (allm ** 2).mean(), (allm ** 4).mean()
        U4 = 1 - m4 / (3 * m2 ** 2)
        rs = [r for r in out["runs"] if r["beta"] == beta]
        print(f"L={L} beta={beta}: U4={U4:.3f}  <|m|>={np.abs(allm).mean():.3f}  "
              f"run means mz: {' '.join(f'{r['mean_mz']:+.2f}' for r in rs)}  "
              f"tau_mz~{np.median([r['tau_mz'] for r in rs]):.0f} tau_E~{np.median([r['tau_E'] for r in rs]):.0f}"
              f"  ({time.time() - t0:.0f}s)", flush=True)
        out.setdefault("pooled", []).append({"beta": beta, "U4": float(U4), "mean_abs_mz": float(np.abs(allm).mean()),
                                             "m2": float(m2), "m4": float(m4)})
    with open(f"periodic_b2_L{L}{'_fine' if fine else ''}.json", "w") as f:
        json.dump(out, f, indent=1)


if __name__ == "__main__":
    main()
