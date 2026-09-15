#!/usr/bin/env python3
"""End-to-end test of  d_op(p(t),p(t')) <= sqrt(N Sigma / 2)  and of the two
counting bounds built on it.

Every run integrates a genuine master equation.  Rates are reconstructed
explicitly at each step from the instantaneous distribution,

    W[dst,src](t) = a / p_src(t),      W[src,dst](t) = b / p_dst(t),

so that the driven edge carries constant fluxes  a, b  with
A = a + b = A0  and  sigma = (a-b) ln(a/b).  The state is then advanced from
the rate matrix, and A, sigma, d_TV are measured from that trajectory.  The
maximum rate actually used is reported: a schedule that drives the state to a
simplex vertex needs W -> infinity and is therefore not a legitimate
finite-rate construction.

Two counts are reported for every architecture:

    K_consec : #{n : d_op(x_n, x_{n+1}) >= delta}          (Definition 1)
    D_delta  : max{|I| : d_op(x_i,x_j) >= delta for all i != j in I}
               -- packing depth; revisits and excursions allowed.
"""
from __future__ import annotations
import itertools
import numpy as np

# --------------------------------------------------------------------------
# metrics


def dTV(p, q):
    return 0.5 * np.abs(np.asarray(p) - np.asarray(q)).sum()


def packing_depth(states, delta, tol=1e-9):
    """max cardinality of a pairwise delta-separated subset of the visited set.

    Exact by maximum-clique search for small collections, greedy above that.
    Revisits collapse automatically (a state is never delta-far from itself).
    """
    uniq = []
    for s in states:
        if not any(dTV(s, u) < 1e-12 for u in uniq):
            uniq.append(s)
    n = len(uniq)
    if n > 18:
        chosen = []
        for s in uniq:
            if all(dTV(s, c) >= delta - tol for c in chosen):
                chosen.append(s)
        return len(chosen), n
    best = 0
    for r in range(n, 0, -1):
        if r <= best:
            break
        for comb in itertools.combinations(range(n), r):
            if all(dTV(uniq[i], uniq[j]) >= delta - tol
                   for i, j in itertools.combinations(comb, 2)):
                best = r
                break
        if best == r:
            break
    return best, n


# --------------------------------------------------------------------------
# the integrator


class Run:
    """Integrates a master equation whose rate matrix is rebuilt every step."""

    def __init__(self, p0, A0=1.0, eps=0.01):
        self.p = np.asarray(p0, dtype=float).copy()
        self.A0, self.eps = A0, eps
        self.a = A0 * (1 + eps) / 2.0          # forward flux, held constant
        self.b = A0 * (1 - eps) / 2.0          # backward flux, held constant
        self.N = 0.0                           # integral of A
        self.S = 0.0                           # integral of sigma
        self.t = 0.0
        self.Wmax = 0.0
        self.visited = [self.p.copy()]

    def _rates(self, src, dst):
        """Reconstruct the two live rates from the current distribution."""
        n = len(self.p)
        W = np.zeros((n, n))
        W[dst, src] = self.a / self.p[src]     # diverges as p_src -> 0
        W[src, dst] = self.b / self.p[dst]
        return W

    def move(self, src, dst, amount, steps=4000):
        """Transport `amount` of probability from src to dst along one edge."""
        tau = amount / (self.a - self.b)
        dt = tau / steps
        for _ in range(steps):
            W = self._rates(src, dst)
            self.Wmax = max(self.Wmax, W.max())
            F = W * self.p[None, :]            # F[i,j] = W[i,j] p_j
            A = F.sum()                        # sum_{i!=j} W_ij p_j
            f, r = F[dst, src], F[src, dst]
            sigma = (f - r) * np.log(f / r)
            dp = F.sum(axis=1) - F.sum(axis=0)  # inflow - outflow
            self.p = self.p + dp * dt
            self.N += A * dt
            self.S += sigma * dt
            self.t += dt
        self.visited.append(self.p.copy())

    # ---- reporting -------------------------------------------------------

    def bound_consec(self, delta):
        return np.sqrt(self.N * self.S / 2.0) / delta

    def bound_depth(self, delta):
        return 1.0 + np.sqrt(self.N * self.S / 2.0) / delta

    def counts(self, delta, tol=1e-9):
        k = sum(1 for i in range(len(self.visited) - 1)
                if dTV(self.visited[i], self.visited[i + 1]) >= delta - tol)
        d, nuniq = packing_depth(self.visited, delta, tol)
        return k, d, nuniq


# --------------------------------------------------------------------------
# architectures


def shuttle(eps, delta, K, A0=1.0, steps=4000):
    """Two states, mass swept back and forth.  Packing depth 2 by construction."""
    x = 0.5 + delta / 2.0
    run = Run([x, 1 - x], A0=A0, eps=eps)
    src, dst = 0, 1
    for _ in range(K):
        run.move(src, dst, delta, steps)
        src, dst = dst, src
    return run


def ring(m, s, eps, K, A0=1.0, steps=2000):
    """One-parameter family of m-cycles with step size s in total variation.

        q = (1-s)/m,      p^(k) = q*1 + s*e_k,      d_TV(p^(i), p^(j)) = s

    for every i != j, so the packing depth is m at any resolution delta <= s.
    No coordinate falls below q, so every reconstructed rate is at most a/q =
    a*m/(1-s).  s = delta is the efficient choice; s -> 1 is the vertex ring of
    the first draft, which both overshoots the resolution and needs unbounded
    rates.
    """
    q = (1.0 - s) / m
    p0 = np.full(m, q)
    p0[0] += s
    run = Run(p0, A0=A0, eps=eps)
    for k in range(K):
        run.move(k % m, (k + 1) % m, s, steps)
    return run


# --------------------------------------------------------------------------

HDR = ("  {:<26}{:>9}{:>9}{:>9}{:>8}{:>9}{:>6}{:>9}{:>11}"
       .format("construction", "N_*", "Sigma_*", "bound", "K_con",
               "ratio", "D_d", "1+bound", "max rate"))


def report(name, run, delta):
    bc, bd = run.bound_consec(delta), run.bound_depth(delta)
    k, d, _ = run.counts(delta)
    print("  {:<26}{:>9.1f}{:>9.4f}{:>9.3f}{:>8d}{:>9.5f}{:>6d}{:>9.2f}{:>11.3g}"
          .format(name, run.N, run.S, bc, k, k / bc, d, bd, run.Wmax))
    assert d <= bd + 1e-9, "packing-depth bound violated"
    assert k <= bc + 1e-6, "consecutive bound violated"


if __name__ == "__main__":
    delta, K = 0.5, 40

    print("=" * 106)
    print("TWO-STATE SHUTTLE  (packing depth 2 by construction)   delta=%.2f, K=%d"
          % (delta, K))
    print("=" * 106)
    print(HDR)
    for eps in [0.5, 0.2, 0.05, 0.01]:
        report("shuttle eps=%g" % eps, shuttle(eps, delta, K), delta)

    print()
    print("=" * 106)
    print("INTERIOR RING  s = delta  (packing depth m, finite rates)")
    print("=" * 106)
    print(HDR)
    for m in [3, 6, 12]:
        for eps in ([0.5, 0.2, 0.05, 0.01] if m == 6 else [0.01]):
            report("ring m=%d eps=%g" % (m, eps),
                   ring(m, delta, eps, K), delta)

    print()
    print("=" * 106)
    print("IS THE PACKING-DEPTH BOUND TIGHT?  m=12 ring, eps=0.01, growing budget")
    print("=" * 106)
    print(HDR)
    for k in [2, 4, 6, 8, 11, 20, 40, 80]:
        report("ring m=12 K=%d" % k, ring(12, delta, 0.01, k), delta)
    print()
    print("  For K+1 <= m the achieved depth D_delta = K+1 equals 1 + delta^-1")
    print("  sqrt(N Sigma/2) to five figures: the packing-depth bound is")
    print("  asymptotically saturated too, and by a construction that has depth.")
    print("  Past K = m-1 the geometric factor P_delta takes over and D_delta")
    print("  pins at m while the thermodynamic factor keeps growing.")

    print()
    print("=" * 106)
    print("RING STEP SIZE  s > delta  (m=6, eps=0.01): overshooting the resolution")
    print("=" * 106)
    print(HDR)
    for s in [0.5, 0.6, 0.75, 0.9, 0.99]:
        report("ring m=6 s=%g" % s, ring(6, s, 0.01, K), delta)
    print()
    print("  ratio tracks delta/s: a move that travels s >= delta still counts")
    print("  once, so the surplus s - delta is spent for nothing.  s -> 1 is the")
    print("  vertex ring of the first draft; its 0.50 was delta/s, not a fact")
    print("  about depth.  The max-rate column shows the second defect: a/q")
    print("  = a*m/(1-s) diverges, so the vertex ring is not finite-rate either.")