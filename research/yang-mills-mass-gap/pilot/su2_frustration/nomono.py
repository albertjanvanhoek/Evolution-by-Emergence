"""4D SU(2) with Z2 monopoles suppressed (lambda = infinity), next to the Wilson action.

Constraint: for every 3-cube c, sigma_c = prod over its six faces of sign Tr U_p = +1.
Update: links of one direction on one of the 16 sublattices (x mod 2) at a time.
No two such links share a plaquette or a 3-cube, so proposals are independent.
Proposal = exact Wilson heatbath (or an overrelaxation reflection); accepted only
if it creates no monopole. This is a Metropolis step whose target is
Wilson weight x indicator(no monopoles), so detailed balance holds.
Local updates cannot change the Z2 flux through a plane, so a cold start samples
the trivial twist sector only.

Usage: python nomono.py BETA MODE [L] [NCONF] [SEED]   MODE = wilson | nomono
"""
import json
import sys
import time

import numpy as np
from scipy.sparse import coo_matrix
from scipy.sparse.csgraph import connected_components

from su2 import (cold, sweep, qmul, qdag, sh, staple, kp_sample_x0, plaquette_field,
                 mean_plaquette, line, dmcg_fix)
from frustration import PLANES, plane_index, frustrated_cubes, coset_stats

JC = 0.5 * np.log(1 + np.sqrt(2))  # self-dual coupling of 4D Z2 gauge theory


def sublattice_masks(L):
    g = np.indices((L, L, L, L)) % 2
    code = g[0] + 2 * g[1] + 4 * g[2] + 8 * g[3]
    return [code == c for c in range(16)]


class NoMono:
    def __init__(self, U, beta, rng):
        self.U, self.beta, self.rng = U, beta, rng
        self.L = U.shape[1]
        self.masks = sublattice_masks(self.L)
        self.sig = np.stack([np.sign(plaquette_field(U, m, n)[..., 0]) for m, n in PLANES])
        self.sig[self.sig == 0] = 1
        self.acc = [0, 0]

    def cubes(self, sig):
        return frustrated_cubes(sig, 1)  # sign of sig is sig itself

    def try_update(self, mu, mask, proposal):
        U = self.U
        old = U[mu][mask].copy()
        U[mu][mask] = proposal
        planes = [plane_index(mu, nu) for nu in range(4) if nu != mu]
        sig_new = self.sig.copy()
        for nu in range(4):
            if nu == mu:
                continue
            a, b = min(mu, nu), max(mu, nu)
            s = np.sign(plaquette_field(U, a, b)[..., 0])
            s[s == 0] = 1
            sig_new[plane_index(mu, nu)] = s
        Mnew = self.cubes(sig_new) < 0
        Mold = self.cubes(self.sig) < 0
        D = Mnew.astype(int) - Mold.astype(int)
        dM = np.zeros((self.L,) * 4, dtype=int)
        for k in range(4):
            if k == mu:
                continue
            nu, la = [d for d in range(4) if d not in (mu, k)]
            for a in (0, 1):
                for b in (0, 1):
                    dM += sh(sh(D[k], nu, -a), la, -b)
        ok = dM[mask] <= 0
        self.acc[0] += int(ok.sum())
        self.acc[1] += int(ok.size)
        cur = U[mu][mask]
        cur[~ok] = old[~ok]
        U[mu][mask] = cur
        for nu in range(4):
            if nu == mu:
                continue
            a, b = min(mu, nu), max(mu, nu)
            s = np.sign(plaquette_field(U, a, b)[..., 0])
            s[s == 0] = 1
            self.sig[plane_index(mu, nu)] = s

    def heatbath(self, mu, mask):
        A = staple(self.U, mu)[mask]
        k = np.linalg.norm(A, axis=-1)
        Abar = A / k[:, None]
        x0 = kp_sample_x0(self.beta * k, self.rng)
        v = self.rng.normal(size=(x0.size, 3))
        v /= np.linalg.norm(v, axis=-1, keepdims=True)
        s = np.sqrt(np.maximum(0.0, 1 - x0 ** 2))
        X = np.concatenate([x0[:, None], s[:, None] * v], axis=-1)
        P = qmul(X, qdag(Abar))
        return P / np.linalg.norm(P, axis=-1, keepdims=True)

    def overrelax(self, mu, mask):
        A = staple(self.U, mu)[mask]
        V0 = qdag(A / np.linalg.norm(A, axis=-1, keepdims=True))
        P = qmul(qmul(V0, qdag(self.U[mu][mask])), V0)
        return P / np.linalg.norm(P, axis=-1, keepdims=True)

    def sweep(self, n_or=1):
        for mu in range(4):
            for m in self.masks:
                self.try_update(mu, m, self.heatbath(mu, m))
        for _ in range(n_or):
            for mu in range(4):
                for m in self.masks:
                    self.try_update(mu, m, self.overrelax(mu, m))


def wilson_loop(U, mu, nu, R, T):
    Lm = line(U, mu, R)
    Ln = line(U, nu, T)
    W = qmul(qmul(Lm, sh(Ln, mu, R)), qmul(qdag(sh(Lm, nu, T)), qdag(Ln)))
    return W[..., 0]


def vortex_clusters(sig):
    """Negative plaquettes joined when they are faces of a common 3-cube.
    Returns (number of negative plaquettes, sizes of clusters)."""
    L = sig.shape[1]
    V = L ** 4
    idx = np.arange(V).reshape((L,) * 4)
    neg = sig < 0
    nneg = int(neg.sum())
    if nneg == 0:
        return 0, np.array([], dtype=int)
    rows, cols = [], []
    for k in range(4):
        m, n, l = [d for d in range(4) if d != k]
        faces = [(plane_index(m, n), 0, None), (plane_index(m, n), l, 1),
                 (plane_index(m, l), 0, None), (plane_index(m, l), n, 1),
                 (plane_index(n, l), 0, None), (plane_index(n, l), m, 1)]
        F, N = [], []
        for p, d, off in faces:
            base = idx if off is None else np.roll(idx, -1, axis=d)
            F.append(p * V + base)
            N.append(neg[p] if off is None else sh(neg[p], d, 1))
        F = np.stack(F).reshape(6, -1)
        N = np.stack(N).reshape(6, -1)
        anyneg = N.any(axis=0)
        first = np.argmax(N, axis=0)
        Ff = F[first, np.arange(F.shape[1])]
        for j in range(6):
            e = N[j] & anyneg
            rows.append(F[j][e])
            cols.append(Ff[e])
    rows = np.concatenate(rows)
    cols = np.concatenate(cols)
    G = coo_matrix((np.ones(rows.size), (rows, cols)), shape=(6 * V, 6 * V))
    _, lab = connected_components(G, directed=False)
    sizes = np.bincount(lab[neg.reshape(-1)])
    return nneg, sizes[sizes > 0]


def twist_flux(sig):
    """Product of plaquette signs over each full (mu,nu) 2-torus slice."""
    out = []
    for p, (m, n) in enumerate(PLANES):
        prod = np.prod(sig[p], axis=(m, n))  # remaining two axes
        out.append(prod)
    return np.stack(out)  # (6, L, L)


def measure(U, beta):
    r = {"plaq": float(mean_plaquette(U))}
    TP = np.stack([plaquette_field(U, m, n)[..., 0] for m, n in PLANES])
    sig = np.sign(TP)
    sig[sig == 0] = 1
    r["frac_negative_plaquettes"] = float((sig < 0).mean())
    r["monopole_density"] = float((frustrated_cubes(sig, 1) < 0).mean())
    r["frac_weak_coupling"] = float((beta * np.abs(TP) < JC).mean())
    T2 = np.stack([wilson_loop(U, m, n, 2, 2) for m, n in PLANES])
    r["frac_negative_2x2"] = float((T2 < 0).mean())
    r["monopole_density_R2"] = float((frustrated_cubes(T2, 2) < 0).mean())
    W = {}
    for (R, T) in [(1, 1), (1, 2), (2, 2), (2, 3), (3, 3)]:
        vals = []
        for m in range(4):
            for n in range(4):
                if m != n:
                    vals.append(wilson_loop(U, m, n, R, T).mean())
        W[f"{R}x{T}"] = float(np.mean(vals))
    r["W"] = W
    nneg, sizes = vortex_clusters(sig)
    r["n_negative"] = nneg
    r["vortex_largest_frac"] = float(sizes.max() / nneg) if nneg else 0.0
    r["vortex_n_clusters"] = int(sizes.size)
    tf = twist_flux(sig)
    r["twist_flux_frac_minus"] = float((tf < 0).mean())
    r["twist_flux_slice_constant"] = bool(all(np.all(tf[p] == tf[p].flat[0]) for p in range(6)))
    Ug = U.copy()
    dmcg_fix(Ug, iters=400, tol=1e-8)
    r["dmcg"] = coset_stats(Ug)
    return r


def run(beta, mode, L=8, nconf=12, seed=0, ntherm=200, nsep=5):
    rng = np.random.default_rng(seed)
    U = cold(L)
    t0 = time.time()
    if mode == "nomono":
        alg = NoMono(U, beta, rng)
        step = alg.sweep
    else:
        alg = None
        step = lambda: sweep(U, beta, rng, n_or=1)
    for _ in range(ntherm):
        step()
    if alg:
        alg.acc = [0, 0]
    recs = []
    for c in range(nconf):
        for _ in range(nsep):
            step()
        recs.append(measure(U, beta))
    out = {"beta": beta, "mode": mode, "L": L, "nconf": nconf, "seed": seed,
           "ntherm": ntherm, "nsep": nsep, "seconds": time.time() - t0,
           "acceptance": (alg.acc[0] / alg.acc[1]) if alg else 1.0, "configs": recs}
    return out


def summarize(out):
    rs = out["configs"]
    s = {}
    def add(name, v):
        v = np.array(v, dtype=float)
        s[name] = (float(v.mean()), float(v.std(ddof=1) / np.sqrt(len(v))))
    for k in ["plaq", "frac_negative_plaquettes", "monopole_density", "frac_weak_coupling",
              "frac_negative_2x2", "monopole_density_R2",
              "vortex_largest_frac", "vortex_n_clusters", "twist_flux_frac_minus"]:
        add(k, [r[k] for r in rs])
    for k in rs[0]["W"]:
        add("W" + k, [r["W"][k] for r in rs])
    W = lambda k: np.array([r["W"][k] for r in rs])
    add("creutz_2x2", -np.log(W("2x2") * W("1x1") / W("1x2") ** 2))
    add("creutz_3x3", -np.log(W("3x3") * W("2x2") / W("2x3") ** 2))
    for k in ["frac_J_negative", "P_plaquette_density"]:
        add("dmcg." + k, [r["dmcg"][k] for r in rs])
    s["twist_flux_slice_constant_all"] = all(r["twist_flux_slice_constant"] for r in rs)
    return s


if __name__ == "__main__":
    beta, mode = float(sys.argv[1]), sys.argv[2]
    L = int(sys.argv[3]) if len(sys.argv) > 3 else 8
    nconf = int(sys.argv[4]) if len(sys.argv) > 4 else 12
    seed = int(sys.argv[5]) if len(sys.argv) > 5 else 2
    out = run(beta, mode, L, nconf, seed)
    out["summary"] = summarize(out)
    fn = f"{mode}_b{beta}_L{L}_s{seed}.json"
    with open(fn, "w") as f:
        json.dump(out, f, indent=1)
    print(fn, f"{out['seconds']:.0f}s acceptance {out['acceptance']:.3f}")
    for k, v in out["summary"].items():
        print(f"  {k:32s} {v}")
