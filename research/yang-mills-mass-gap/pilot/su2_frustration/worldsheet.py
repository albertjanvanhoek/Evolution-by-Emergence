"""Approach 3, first numerical look: is the colour direction coherent along
centre-vortex sheets?

For each plaquette p, n_p is the unit vector part of its holonomy U_p (its colour
direction), defined up to sign. In direct maximal centre gauge, P-plaquettes are
those whose centre-projected product is -1; they form the P-vortex sheets.
Two P-plaquettes that are faces of a common 3-cube are neighbours on a sheet.
We transport each face's direction to the base site of the cube along one link
(adjoint action, which is blind to the centre sign) and compute the sign-blind
overlap (n_p . n_q)^2. Random directions give 1/3.

Compared with: all face pairs in cubes (background smoothness of the field), and
P-plaquette pairs far apart on the lattice (no transport; gauge-dependent control).

Usage: python worldsheet.py BETA [L] [NCONF] [SEED] [TFLOW]
(TFLOW > 0: apply Wilson flow before gauge fixing.)
"""
import json
import sys

import numpy as np

from su2 import cold, sweep, qmul, qdag, sh, plaquette_field, dmcg_fix
from frustration import PLANES, plane_index
from flow import flow_step


def vec_dir(q):
    v = q[..., 1:]
    n = np.linalg.norm(v, axis=-1, keepdims=True)
    return v / np.maximum(n, 1e-12), n[..., 0]


def adjoint(Ulink, v):
    """Rotate a vector v (as pure quaternion) by U: U v U^dag."""
    q = np.concatenate([np.zeros(v.shape[:-1] + (1,)), v], axis=-1)
    return qmul(qmul(Ulink, q), qdag(Ulink))[..., 1:]


def analyse(U, minvec=0.05):
    s = np.sign(U[..., 0])
    s[s == 0] = 1
    P, D, M = [], [], []
    for m, n in PLANES:
        Up = plaquette_field(U, m, n)
        sp = s[m] * sh(s[n], m, 1) * sh(s[m], n, 1) * s[n]
        d, mag = vec_dir(Up)
        P.append(sp < 0)
        D.append(d)
        M.append(mag)
    P, D, M = np.stack(P), np.stack(D), np.stack(M)
    pairs_P, pairs_all, par_P, par_all = [], [], [], []
    for k in range(4):
        m, n, l = [d for d in range(4) if d != k]
        faces = [(plane_index(m, n), None), (plane_index(m, n), l),
                 (plane_index(m, l), None), (plane_index(m, l), n),
                 (plane_index(n, l), None), (plane_index(n, l), m)]
        dirs, isP, ok = [], [], []
        for p, d in faces:
            if d is None:
                dirs.append(D[p]); isP.append(P[p]); ok.append(M[p] > minvec)
            else:
                dirs.append(adjoint(U[d], sh(D[p], d, 1)))
                isP.append(sh(P[p], d, 1)); ok.append(sh(M[p], d, 1) > minvec)
        for i in range(6):
            for j in range(i + 1, 6):
                ov = (dirs[i] * dirs[j]).sum(-1) ** 2
                good = ok[i] & ok[j]
                par = (j == i + 1) and (i % 2 == 0)  # opposite faces, same plane
                pairs_all.append(ov[good])
                pairs_P.append(ov[good & isP[i] & isP[j]])
                if par:
                    par_all.append(ov[good])
                    par_P.append(ov[good & isP[i] & isP[j]])
    par_P = np.concatenate(par_P)
    par_all = np.concatenate(par_all)
    pairs_P = np.concatenate(pairs_P)
    pairs_all = np.concatenate(pairs_all)
    # far control: P-plaquettes in the same plane, separated by L/2 in all directions
    far = []
    L = U.shape[1]
    for p in range(6):
        Dp = D[p]; Pp = P[p] & (M[p] > minvec)
        Ds = Dp
        Ps = Pp
        for ax in range(4):
            Ds = np.roll(Ds, L // 2, axis=ax); Ps = np.roll(Ps, L // 2, axis=ax)
        ov = (Dp * Ds).sum(-1) ** 2
        far.append(ov[Pp & Ps])
    far = np.concatenate(far)
    return {"P_density": float(P.mean()),
            "n_pairs_P": int(pairs_P.size), "overlap_P": float(pairs_P.mean()) if pairs_P.size else None,
            "overlap_all": float(pairs_all.mean()),
            "n_par_P": int(par_P.size),
            "overlap_parallel_P": float(par_P.mean()) if par_P.size else None,
            "overlap_parallel_all": float(par_all.mean()),
            "n_far": int(far.size), "overlap_far": float(far.mean()) if far.size else None}


def run(beta, L=8, nconf=6, seed=5, tflow=0.0):
    rng = np.random.default_rng(seed)
    U = cold(L)
    for _ in range(300):
        sweep(U, beta, rng)
    out = []
    for c in range(nconf):
        for _ in range(10):
            sweep(U, beta, rng)
        V = U.copy()
        for _ in range(int(round(tflow / 0.01))):
            flow_step(V, 0.01)
        dmcg_fix(V, iters=400, tol=1e-8)
        out.append(analyse(V))
    return out


if __name__ == "__main__":
    beta = float(sys.argv[1])
    L = int(sys.argv[2]) if len(sys.argv) > 2 else 8
    nconf = int(sys.argv[3]) if len(sys.argv) > 3 else 6
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 5
    tflow = float(sys.argv[5]) if len(sys.argv) > 5 else 0.0
    recs = run(beta, L, nconf, seed, tflow)
    summ = {}
    for k in ["P_density", "overlap_P", "overlap_all", "overlap_parallel_P", "overlap_parallel_all", "overlap_far"]:
        v = np.array([r[k] for r in recs], dtype=float)
        summ[k] = (float(v.mean()), float(v.std(ddof=1) / np.sqrt(len(v))))
    summ["n_pairs_P_total"] = int(sum(r["n_pairs_P"] for r in recs))
    summ["n_par_P_total"] = int(sum(r["n_par_P"] for r in recs))
    fn = f"worldsheet_b{beta}_L{L}_s{seed}_t{tflow}.json"
    json.dump({"beta": beta, "tflow": tflow, "L": L, "nconf": nconf, "seed": seed, "configs": recs, "summary": summ},
              open(fn, "w"), indent=1)
    print(fn, summ)
