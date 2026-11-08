"""Which worst-case (Dobrushin-type) bounds are reachable, and at what beta?

1. Single-site worst-case influence of the original model,
       c(beta) = sup TV( mu(.|h + s_j), mu(.|h + s_j') ),
   where mu(s|h) ~ exp(beta s.h) on the sphere, h is the sum of the other three
   neighbours (|h| <= 3) and s_j, s_j' are any two values of one neighbour.
   Computed numerically by quadrature on the sphere and a search over the
   configuration. This is a numerical estimate of the supremum, not a
   certified (interval-arithmetic) bound.

2. Dobrushin's comparison theorem for the decimated model. Keep the coarse
   spins on (bZ)^2 and let the target coarse spin i and all hidden spins be
   free. If the worst-case influence matrix C of the free system (C_kl = c for
   nearest neighbours) has spectral radius < 1, then a change at visible spin j
   moves the marginal of i by at most  sum_k D_ik C_kj,  with
   D = (I - C)^(-1). So the decimated model's row sum is bounded by
       S(b, c) = sum_{visible j != i} sum_k D_ik c A_kj .
   The decimated model is then certified to satisfy Dobrushin's condition when
   S(b, c(beta)) < 1. For b = 1 this reduces to 4 c(beta) < 1.

Output: c(beta) for O(2) and O(3), and the largest beta at which S < 1 for
b = 1, 2, 3, 4 and 8.
"""

import json

import numpy as np
from scipy.optimize import brentq

rng = np.random.default_rng(0)


def sphere(n, k):
    if n == 2:
        t = 2 * np.pi * (np.arange(k) + 0.5) / k
        return np.column_stack([np.cos(t), np.sin(t)])
    idx = np.arange(k) + 0.5
    phi = np.arccos(1 - 2 * idx / k)
    th = np.pi * (1 + 5 ** 0.5) * idx
    return np.column_stack([np.cos(th) * np.sin(phi), np.sin(th) * np.sin(phi), np.cos(phi)])


GRID = {2: sphere(2, 4000), 3: sphere(3, 20000)}


def tv(n, beta, h1, h2):
    g = GRID[n]
    a1 = beta * g @ h1
    a2 = beta * g @ h2
    w1 = np.exp(a1 - a1.max())
    w2 = np.exp(a2 - a2.max())
    return 0.5 * np.abs(w1 / w1.sum() - w2 / w2.sum()).sum()


def unit(v):
    return v / np.linalg.norm(v)


def c_of_beta(n, beta, trials=400):
    """Search over h (|h| <= 3) and the two values of s_j for the largest TV."""
    best = 0.0
    e = np.zeros(n)
    e[0] = 1.0
    for _ in range(trials):
        r = rng.uniform(0, 3)
        h = r * unit(rng.normal(size=n))
        sj = unit(rng.normal(size=n))
        sj2 = -sj if rng.random() < 0.5 else unit(rng.normal(size=n))
        best = max(best, tv(n, beta, h + sj, h + sj2))
    # structured candidates: h = 0, h along or against s_j, s_j' = -s_j
    for r in np.linspace(0, 3, 13):
        for sgn in (1, -1):
            for perp in (0.0, 1.0):
                f = np.zeros(n)
                f[1] = 1.0
                h = r * unit(sgn * e + perp * f) if r > 0 else np.zeros(n)
                best = max(best, tv(n, beta, h + e, h - e))
                best = max(best, tv(n, beta, h + f, h - f))
    return best


def coarse_row_sum(b, c, L=None):
    """Dobrushin comparison bound S(b, c) on a torus of side L (multiple of b)."""
    if b == 1:
        return 4 * c
    L = L or max(8 * b, 24 - 24 % b)
    N = L * L
    idx = lambda i, j: (i % L) * L + (j % L)  # noqa: E731
    visible = np.zeros(N, dtype=bool)
    for i in range(0, L, b):
        for j in range(0, L, b):
            visible[idx(i, j)] = True
    target = idx(0, 0)
    free = ~visible
    free[target] = True
    fidx = np.where(free)[0]
    pos = {k: t for t, k in enumerate(fidx)}
    m = len(fidx)
    C = np.zeros((m, m))
    Cv = {}  # influence of visible j on free k
    for k in fidx:
        i, j = divmod(k, L)
        for di, dj in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            nb = idx(i + di, j + dj)
            if free[nb]:
                C[pos[k], pos[nb]] = c
            else:
                Cv[(k, nb)] = c
    rho = max(abs(np.linalg.eigvals(C))) if m < 1500 else None
    if rho is not None and rho >= 1:
        return np.inf
    D = np.linalg.inv(np.eye(m) - C)
    row = D[pos[target]]
    total = 0.0
    for (k, jv), val in Cv.items():
        total += row[pos[k]] * val
    return total


def spectral_radius_hidden(b, L=None):
    """Spectral radius of the adjacency of the free system (hidden + target)."""
    if b == 1:
        return 0.0
    L = L or max(8 * b, 24 - 24 % b)
    N = L * L
    idx = lambda i, j: (i % L) * L + (j % L)  # noqa: E731
    free = np.ones(N, dtype=bool)
    for i in range(0, L, b):
        for j in range(0, L, b):
            free[idx(i, j)] = False
    free[idx(0, 0)] = True
    fidx = np.where(free)[0]
    pos = {k: t for t, k in enumerate(fidx)}
    A = np.zeros((len(fidx), len(fidx)))
    for k in fidx:
        i, j = divmod(k, L)
        for di, dj in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            nb = idx(i + di, j + dj)
            if free[nb]:
                A[pos[k], pos[nb]] = 1
    return float(max(abs(np.linalg.eigvals(A))))


def main():
    out = {"c_of_beta": {}, "thresholds": {}, "rho_hidden": {}}
    betas = np.round(np.linspace(0.05, 1.5, 30), 3)
    cfun = {}
    for n in (2, 3):
        cs = [c_of_beta(n, bb) for bb in betas]
        out["c_of_beta"][f"O({n})"] = dict(zip(betas.tolist(), cs))
        cfun[n] = lambda x, bs=betas, cs=cs: float(np.interp(x, bs, cs))
        print(f"O({n}) c(beta): " + ", ".join(f"{bb}:{cv:.3f}" for bb, cv in zip(betas[::3], cs[::3])))
    for b in (1, 2, 3, 4, 8):
        rho = spectral_radius_hidden(b)
        out["rho_hidden"][b] = rho
        # largest c with S(b, c) < 1
        f = lambda c: coarse_row_sum(b, c) - 1.0  # noqa: E731
        hi = 0.999 / rho if rho > 0 else 0.999
        cstar = brentq(lambda c: (coarse_row_sum(b, c) if coarse_row_sum(b, c) < np.inf else 10) - 1.0,
                       1e-4, min(hi, 0.999))
        row = {"rho_hidden": rho, "c_star": cstar}
        for n in (2, 3):
            try:
                bstar = brentq(lambda x: cfun[n](x) - cstar, betas[0], betas[-1])
            except ValueError:
                bstar = None
            row[f"beta_star_O({n})"] = bstar
        out["thresholds"][b] = row
        print(f"b={b}: spectral radius of hidden graph {rho:.3f}, certified if c < {cstar:.4f}"
              f"  -> beta* O(2) {row['beta_star_O(2)']}, O(3) {row['beta_star_O(3)']}")
    with open("reachable_bounds.json", "w") as fh:
        json.dump(out, fh, indent=1, default=float)


if __name__ == "__main__":
    main()
