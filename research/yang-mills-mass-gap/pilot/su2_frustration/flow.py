"""Approach 1, 'flow to positivity': does the centre sector of a gradient-flowed
SU(2) field have a scale where it is both nearly unfrustrated and still disordered?

Wilson flow (Luscher's normalisation): dV/dt = -g0^2 (d S_w) V. For SU(2) with
quaternions this is dV/dt = (0, -w/2) V with w the vector part of W = V A, A the
staple sum. Euler steps of size eps (flow time t = n eps).

At each flow time, for R = 1, 2, 3:
  neg_R  = fraction of R x R Wilson loops with negative trace (thick-vortex piercings),
  frus_R = fraction of side-R 3-cubes whose six R x R faces have sign product -1
           (irreducible frustration of the centre signs at scale R).
A positive-and-disordered window would show frus_R small while neg_R stays sizable.

Usage: python flow.py BETA [L] [NCONF] [SEED]
"""
import json
import sys
import time

import numpy as np

from su2 import cold, sweep, qmul, staple, mean_plaquette, loop_RR, plaquette_field
from frustration import PLANES, frustrated_cubes

TIMES = [0.0, 0.05, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0]


def qexp_vec(v):
    n = np.linalg.norm(v, axis=-1, keepdims=True)
    s = np.where(n > 1e-15, np.sin(n) / np.maximum(n, 1e-15), 1.0)
    return np.concatenate([np.cos(n), s * v], axis=-1)


def flow_step(U, eps):
    Z = []
    for mu in range(4):
        W = qmul(U[mu], staple(U, mu))
        Z.append(-0.5 * W[..., 1:])
    for mu in range(4):
        U[mu] = qmul(qexp_vec(eps * Z[mu]), U[mu])
        U[mu] /= np.linalg.norm(U[mu], axis=-1, keepdims=True)


def scale_stats(U):
    out = {"plaq": float(mean_plaquette(U))}
    for R in (1, 2, 3):
        if R == 1:
            T = np.stack([plaquette_field(U, m, n)[..., 0] for m, n in PLANES])
        else:
            T = np.stack([loop_RR(U, m, n, R)[..., 0] for m, n in PLANES])
        out[f"neg_{R}"] = float((T < 0).mean())
        out[f"frus_{R}"] = float((frustrated_cubes(T, R) < 0).mean())
    return out


def run(beta, L=8, nconf=8, seed=3, ntherm=300, nsep=10, eps=0.01):
    rng = np.random.default_rng(seed)
    U = cold(L)
    t0 = time.time()
    for _ in range(ntherm):
        sweep(U, beta, rng)
    recs = []
    for c in range(nconf):
        for _ in range(nsep):
            sweep(U, beta, rng)
        V = U.copy()
        t, row = 0.0, {}
        for tt in TIMES:
            while t < tt - 1e-12:
                flow_step(V, eps)
                t += eps
            row[f"{tt}"] = scale_stats(V)
        recs.append(row)
    return {"beta": beta, "L": L, "nconf": nconf, "seed": seed, "eps": eps,
            "seconds": time.time() - t0, "configs": recs}


if __name__ == "__main__":
    beta = float(sys.argv[1])
    L = int(sys.argv[2]) if len(sys.argv) > 2 else 8
    nconf = int(sys.argv[3]) if len(sys.argv) > 3 else 8
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 3
    out = run(beta, L, nconf, seed)
    summ = {}
    for tt in TIMES:
        rows = [r[f"{tt}"] for r in out["configs"]]
        summ[f"{tt}"] = {k: (float(np.mean([x[k] for x in rows])),
                             float(np.std([x[k] for x in rows], ddof=1) / np.sqrt(len(rows))))
                         for k in rows[0]}
    out["summary"] = summ
    fn = f"flow_b{beta}_L{L}_s{seed}.json"
    json.dump(out, open(fn, "w"), indent=1)
    print(fn, f"{out['seconds']:.0f}s")
    for tt, s in summ.items():
        print(f"t={tt:5s} " + " ".join(f"{k}={v[0]:.4f}" for k, v in s.items()))
