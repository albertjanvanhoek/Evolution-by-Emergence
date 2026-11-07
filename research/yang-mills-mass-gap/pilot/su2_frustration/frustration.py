"""Frustration of the Z2 (centre) part of 4D SU(2) lattice gauge theory.

Exact decomposition, link by link: U = s V with s = +-1 and V the coset
representative with Tr V >= 0 (in whatever gauge the links are in). Given all V,
the signs s form a Z2 lattice gauge theory with plaquette couplings

    J_p = (beta / 2) Tr V_p ,   Tr U_p = s_p Tr V_p ,  s_p = product of s round p.

J_p can be negative ("frustrated"). Changing representatives (s -> eta s,
V -> eta V) moves frustration around; what no choice can remove is the
gauge-invariant sign pattern sigma_p = sign Tr U_p on the six faces of a 3-cube:
if their product is -1 the cube carries irreducible frustration (a Z2 monopole,
in Mack-Petkova language). Frustrated plaquettes must then form sheets bounded
by these monopole loops.

Usage: python frustration.py BETA [L] [NCONF] [SEED]
"""
import json
import sys
import time

import numpy as np
from scipy.sparse import coo_matrix
from scipy.sparse.csgraph import connected_components

from su2 import (cold, sweep, mean_plaquette, plaquette_field, loop_RR, sh,
                 dmcg_fix, dmcg_functional)

PLANES = [(m, n) for m in range(4) for n in range(m + 1, 4)]


def plane_index(a, b):
    a, b = min(a, b), max(a, b)
    return PLANES.index((a, b))


def loop_traces(U, R):
    """sign-ready array T[plane, x] = (1/2) Tr of the R x R loop at x."""
    if R == 1:
        return np.stack([plaquette_field(U, m, n)[..., 0] for m, n in PLANES])
    return np.stack([loop_RR(U, m, n, R)[..., 0] for m, n in PLANES])


def frustrated_cubes(T, R):
    """For each 3-cube of side R (base x, directions m<n<l), product of the
    signs of the six R x R faces. Returns array [4 (missing dir k), x]."""
    sg = np.sign(T)
    sg[sg == 0] = 1
    out = []
    for k in range(4):
        m, n, l = [d for d in range(4) if d != k]
        p_mn, p_ml, p_nl = plane_index(m, n), plane_index(m, l), plane_index(n, l)
        prod = (sg[p_mn] * sh(sg[p_mn], l, R) *
                sg[p_ml] * sh(sg[p_ml], n, R) *
                sg[p_nl] * sh(sg[p_nl], m, R))
        out.append(prod)
    return np.stack(out)


def monopole_clusters(cubes):
    """Unit-scale cubes: frustrated cube (base x, missing k) = dual link between
    hypercubes at x and x - k. Returns sizes (in dual links) of the clusters."""
    L = cubes.shape[1]
    idx = np.arange(L ** 4).reshape(L, L, L, L)
    rows, cols = [], []
    for k in range(4):
        f = cubes[k] < 0
        a = idx[f]
        b = np.roll(idx, 1, axis=k)[f]  # site x - k
        rows.append(a)
        cols.append(b)
    rows = np.concatenate(rows)
    cols = np.concatenate(cols)
    if rows.size == 0:
        return np.array([], dtype=int)
    n = L ** 4
    G = coo_matrix((np.ones(rows.size), (rows, cols)), shape=(n, n))
    ncomp, lab = connected_components(G, directed=False)
    # cluster size in links: count links per component
    link_lab = lab[rows]
    sizes = np.bincount(link_lab)
    return sizes[sizes > 0]


def coset_stats(U):
    """Representation-dependent numbers for the current gauge."""
    s = np.sign(U[..., 0])
    s[s == 0] = 1
    res = {}
    TV, Pp = [], []
    for m, n in PLANES:
        TU = plaquette_field(U, m, n)[..., 0]
        sp = s[m] * sh(s[n], m, 1) * sh(s[m], n, 1) * s[n]
        TV.append(sp * TU)  # (1/2) Tr V_p
        Pp.append(sp)
    TV = np.stack(TV)
    Pp = np.stack(Pp)
    res["frac_J_negative"] = float((TV < 0).mean())
    res["P_plaquette_density"] = float((Pp < 0).mean())
    res["mean_halfTrV"] = float(TV.mean())
    res["frac_absJ_below_0.25"] = float((np.abs(TV) < 0.25).mean())
    res["frac_absJ_below_0.10"] = float((np.abs(TV) < 0.10).mean())
    res["mean_link_a0sq"] = float((U[..., 0] ** 2).mean())
    return res


def run(beta, L=8, nconf=20, seed=0, ntherm=300, nsep=10):
    rng = np.random.default_rng(seed)
    U = cold(L)
    t0 = time.time()
    for _ in range(ntherm):
        sweep(U, beta, rng)
    recs = []
    for c in range(nconf):
        for _ in range(nsep):
            sweep(U, beta, rng)
        rec = {"plaq": float(mean_plaquette(U))}
        T1 = loop_traces(U, 1)
        rec["frac_negative_plaquettes"] = float((T1 < 0).mean())
        cub1 = frustrated_cubes(T1, 1)
        rec["monopole_density_R1"] = float((cub1 < 0).mean())
        if L >= 6:
            T2 = loop_traces(U, 2)
            rec["frac_negative_2x2"] = float((T2 < 0).mean())
            rec["monopole_density_R2"] = float((frustrated_cubes(T2, 2) < 0).mean())
        sizes = monopole_clusters(cub1)
        nlinks = int((cub1 < 0).sum())
        rec["n_monopole_links"] = nlinks
        rec["largest_cluster_frac"] = float(sizes.max() / nlinks) if nlinks else 0.0
        rec["mean_cluster_size"] = float(sizes.mean()) if sizes.size else 0.0
        rec["frac_links_in_clusters_le4"] = float(sizes[sizes <= 4].sum() / nlinks) if nlinks else 1.0
        # representation-dependent: as generated (no gauge fixing)
        rec["raw"] = coset_stats(U)
        # direct maximal centre gauge on a copy
        Ug = U.copy()
        hist = dmcg_fix(Ug, iters=400, tol=1e-8)
        rec["dmcg_iters"] = len(hist)
        rec["dmcg_functional"] = float(dmcg_functional(Ug))
        rec["dmcg"] = coset_stats(Ug)
        # check gauge invariance of the plaquette after fixing
        rec["plaq_after_fix"] = float(mean_plaquette(Ug))
        recs.append(rec)
    return {"beta": beta, "L": L, "nconf": nconf, "seed": seed, "ntherm": ntherm,
            "nsep": nsep, "seconds": time.time() - t0, "configs": recs}


def summarize(out):
    rs = out["configs"]

    def ms(key, sub=None):
        v = np.array([r[sub][key] if sub else r[key] for r in rs])
        return float(v.mean()), float(v.std(ddof=1) / np.sqrt(len(v)))
    keys = ["plaq", "frac_negative_plaquettes", "monopole_density_R1", "frac_negative_2x2",
            "monopole_density_R2", "largest_cluster_frac", "mean_cluster_size",
            "frac_links_in_clusters_le4", "dmcg_iters"]
    s = {k: ms(k) for k in keys if k in rs[0]}
    for sub in ("raw", "dmcg"):
        for k in rs[0][sub]:
            s[f"{sub}.{k}"] = ms(k, sub)
    return s


if __name__ == "__main__":
    beta = float(sys.argv[1])
    L = int(sys.argv[2]) if len(sys.argv) > 2 else 8
    nconf = int(sys.argv[3]) if len(sys.argv) > 3 else 20
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    out = run(beta, L, nconf, seed)
    out["summary"] = summarize(out)
    fn = f"frustration_b{beta}_L{L}_s{seed}.json"
    with open(fn, "w") as f:
        json.dump(out, f, indent=1)
    print(fn, f"{out['seconds']:.0f}s")
    for k, (m, e) in out["summary"].items():
        print(f"  {k:38s} {m:.5f} +- {e:.5f}")
