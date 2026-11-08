"""Multi-gateway test of CP^{q-1} fusion monotonicity (spin-level, no loop enumeration).

Graph: two marked sites u, v pinned to rank-one projectors with overlap p = tr(P_u P_v);
one marked outer site a whose direction is integrated (free); free hubs x_1..x_k, each
attached only to marked sites (u, v, a) with nonnegative strengths. Optional direct
u-a and v-a edges.

E = some index loop visits both {u, v} and a.

Identities used (q >= 3):
  Z_full(p) = int dw(P_a) Z(P_a)              (a free = a pinned, then averaged)
  Z_NC(p)   = Z(P_a orthogonal to span(u, v))   (every loop joining a to {u,v} has a
                                                 factor <z_a|z_u> or <z_a|z_v> = 0, and
                                                 the free-vertex no-cross weight at a equals
                                                 the pinned weight with no a-uv adjacency,
                                                 CPN_PINNING.md section 3)
  h(p) = P(E | P_u, P_v) = 1 - Z_NC(p) / Z_full(p).

Each free hub integrates in closed form:
  int dw(z) exp(z^dag M z) = sum_d h_d(eigenvalues of M) / (q)_d,
with h_d the complete homogeneous symmetric polynomial of the nonzero eigenvalues.

The integral over a uses the exact marginal of a uniform unit vector in C^q on the
2-plane span(u, v): (t1, t2) = (|c1|^2, |c2|^2) ~ Dirichlet(1, 1, q-2), relative phase
uniform. Gauss-Jacobi x Gauss-Legendre x periodic trapezoid quadrature.

Run:  python3 cpn_multi_gateway.py            (checks + screen, about a minute)
"""
import sys
import numpy as np
from scipy.special import roots_jacobi, roots_legendre, gammaln

DMAX = 80  # series truncation; strengths here are <= 6, tails below 1e-20


def rising_log(q, d):
    return gammaln(q + d) - gammaln(q)


def hub_integral(eigs, q):
    """sum_d h_d(eigs)/(q)_d, eigs shape (..., m) nonnegative. Vectorized."""
    eigs = np.clip(eigs, 0.0, None)
    shp = eigs.shape[:-1]
    m = eigs.shape[-1]
    # h[j][d]: complete homogeneous in first j eigenvalues, built incrementally over d
    h = np.zeros(shp + (DMAX + 1,))
    h[..., 0] = 1.0
    for j in range(m):
        lam = eigs[..., j]
        for d in range(1, DMAX + 1):
            h[..., d] = h[..., d] + lam * h[..., d - 1]
    coef = np.exp(-np.array([rising_log(q, d) for d in range(DMAX + 1)]))
    return (h * coef).sum(-1)


def basis(p):
    zu = np.array([1.0, 0.0, 0.0], dtype=complex)
    zv = np.array([np.sqrt(p), np.sqrt(1 - p), 0.0], dtype=complex)
    return zu, zv


def quad_nodes(q, ns=48, nw=48, nphi=48):
    """Nodes/weights for z_a = (sqrt(t1), sqrt(t2) e^{i phi}, sqrt(1-t1-t2)) in span(e1,e2,e3)."""
    # s = t1 + t2 in [0,1], density prop. to s (1-s)^(q-3); map x = 2s-1 in [-1,1]
    alpha, beta = q - 3, 1
    x, wx = roots_jacobi(ns, alpha, beta)
    s = (x + 1) / 2
    wx = wx / wx.sum()
    y, wy = roots_legendre(nw)
    w = (y + 1) / 2
    wy = wy / wy.sum()
    phi = 2 * np.pi * np.arange(nphi) / nphi
    wphi = np.full(nphi, 1.0 / nphi)
    S, W, PHI = np.meshgrid(s, w, phi, indexing="ij")
    WT = (wx[:, None, None] * wy[None, :, None] * wphi[None, None, :])
    t1 = S * W
    t2 = S * (1 - W)
    za = np.stack([np.sqrt(t1), np.sqrt(t2) * np.exp(1j * PHI),
                   np.sqrt(np.clip(1 - t1 - t2, 0, None))], axis=-1)
    return za.reshape(-1, 3), WT.reshape(-1)


def gram_eigs(vecs, strengths):
    """Nonzero spectrum of sum_j b_j z_j z_j^dag via the Gram matrix. vecs: (..., k, 3)."""
    sb = np.sqrt(np.asarray(strengths, dtype=float))
    V = vecs * sb[..., :, None]
    G = np.einsum("...ic,...jc->...ij", V.conj(), V)
    return np.linalg.eigvalsh(G)


def Z_of_a(za, p, hubs, direct, q):
    """Pinned-a partition function. hubs: list of (bu, bv, ba); direct: (du, dv)."""
    zu, zv = basis(p)
    n = za.shape[0]
    Zu = np.broadcast_to(zu, (n, 3))
    Zv = np.broadcast_to(zv, (n, 3))
    vecs = np.stack([Zu, Zv, za], axis=1)  # (n, 3, 3)
    out = np.ones(n)
    for (bu, bv, ba) in hubs:
        out = out * hub_integral(gram_eigs(vecs, [bu, bv, ba]), q)
    du, dv = direct
    ou = np.abs(np.einsum("c,nc->n", zu.conj(), za)) ** 2
    ov = np.abs(np.einsum("c,nc->n", zv.conj(), za)) ** 2
    return out * np.exp(du * ou + dv * ov)


def h_of_p(p, hubs, direct, q, nodes):
    za, wt = nodes
    Zfull = (Z_of_a(za, p, hubs, direct, q) * wt).sum()
    zperp = np.array([[0.0, 0.0, 1.0]], dtype=complex)
    Znc = Z_of_a(zperp, p, hubs, direct, q)[0]
    return 1.0 - Znc / Zfull


# ---------- checks against results proved elsewhere in this folder ----------

def f_r(b, r, n=200):
    d = np.arange(n)
    return np.exp(d * np.log(b) - np.array([rising_log(r, k) for k in d])).sum() if b > 0 else 1.0


def star_formula(p, bu, bv, ba, q):
    """CPN_DOUBLE_STAR_FUSION_THEOREM.md: h = 1 - sum_d w_d f_{q+d}(ba) / (f_q(ba) G)."""
    s = bu + bv
    Delta = bu * bv * (1 - p)
    disc = np.sqrt(max(s * s - 4 * Delta, 0))
    lp, lm = (s + disc) / 2, (s - disc) / 2
    num = den = 0.0
    for d in range(DMAX):
        Hd = sum(lp ** j * lm ** (d - j) for j in range(d + 1))
        wd = Hd * np.exp(-rising_log(q, d))
        den += wd
        num += wd * f_r(ba, q + d)
    return 1 - num / (f_r(ba, q) * den)


def checks():
    ok = True
    for q in (3, 4, 5):
        nodes = quad_nodes(q)
        # normalization of the a-measure
        tot = nodes[1].sum()
        ok &= abs(tot - 1) < 1e-12
        # mean of |<z_a|e1>|^2 must be 1/q
        m1 = (np.abs(nodes[0][:, 0]) ** 2 * nodes[1]).sum()
        ok &= abs(m1 - 1 / q) < 1e-12
        for (bu, bv, ba) in [(1, 1, 1), (2, 0.5, 3), (0.3, 4, 1.5)]:
            for p in (0.0, 0.4, 1.0):
                a = h_of_p(p, [(bu, bv, ba)], (0, 0), q, nodes)
                b = star_formula(p, bu, bv, ba, q)
                if abs(a - b) > 1e-10 * max(1, abs(b)):
                    ok = False
                    print("MISMATCH", q, bu, bv, ba, p, a, b)
    # published values, q=3, all strengths 1: h_side(0)=0.05389, h_side(1)=0.063468
    nodes = quad_nodes(3)
    print("single hub q=3 b=1: h(0)=%.6f h(1)=%.6f (note: 0.05389, 0.063468)"
          % (h_of_p(0, [(1, 1, 1)], (0, 0), 3, nodes), h_of_p(1, [(1, 1, 1)], (0, 0), 3, nodes)))
    print("checks:", "PASS" if ok else "FAIL")
    return ok


def scan(hubs, direct, q, nodes, ps=np.linspace(0, 1, 21)):
    hs = np.array([h_of_p(p, hubs, direct, q, nodes) for p in ps])
    return ps, hs


def random_graph(rng, k_range=(2, 5), split=False):
    k = rng.integers(*k_range)
    hubs = []
    for _ in range(k):
        b = rng.uniform(0, 3, 3) * (rng.random(3) > 0.25)
        if split:  # each gateway touches at most one of u, v
            b[rng.integers(0, 2)] = 0.0
        hubs.append(tuple(b))
    direct = tuple(rng.uniform(0, 2, 2) * (rng.random(2) > 0.5))
    return hubs, direct


def screen(q, n_graphs, rng, nodes, split=False, ps=np.linspace(0, 1, 11)):
    worst = (np.inf, None)
    for _ in range(n_graphs):
        hubs, direct = random_graph(rng, split=split)
        _, hs = scan(hubs, direct, q, nodes, ps)
        step = np.diff(hs).min()
        if step < worst[0]:
            worst = (step, (hubs, direct, hs))
    return worst


def adversarial(q, nodes, rng, restarts=4, iters=60, bmax=4.0):
    """Local search over strengths of two three-terminal gateways (+ direct edges),
    seeking a counterexample. Objective: the largest relative increase of 1 - h
    between neighbouring p (positive = h decreases somewhere). Relative, so that
    saturation h -> 1 cannot fake a near-counterexample."""
    ps = np.linspace(0, 1, 6)

    def obj(x):
        hubs = [tuple(x[0:3]), tuple(x[3:6])]
        direct = tuple(x[6:8])
        hs = np.array([h_of_p(p, hubs, direct, q, nodes) for p in ps])
        g = np.log1p(-hs)
        return np.diff(g).max(), hs

    best = (-np.inf, None)
    for _ in range(restarts):
        x = rng.uniform(0, bmax, 8)
        f = obj(x)
        scale = 1.0
        for _ in range(iters):
            y = np.clip(x + scale * rng.normal(size=8), 0, bmax)
            g = obj(y)
            if g[0] > f[0]:
                x, f = y, g
            else:
                scale *= 0.97
        if f[0] > best[0]:
            best = (f[0], (np.round(x, 3).tolist(), f[1]))
    return best


if __name__ == "__main__":
    if not checks():
        sys.exit(1)
    rng = np.random.default_rng(20261108)
    for q in (3, 4, 6):
        nodes = quad_nodes(q, 16, 16, 16)  # converged to ~1e-15 (see note)
        w_split = screen(q, 15, rng, nodes, split=True)
        w_gen = screen(q, 25, rng, nodes, split=False)
        print("q=%d split gateways: smallest increment of h over 15 graphs: %.2e" % (q, w_split[0]))
        print("q=%d general gateways: smallest increment of h over 25 graphs: %.2e" % (q, w_gen[0]))
    nodes = quad_nodes(3, 16, 16, 16)
    best = adversarial(3, nodes, rng)
    print("adversarial search, q=3, two three-terminal gateways, strengths <= 4:")
    print("   largest step of log(1-h) between neighbouring p (positive = counterexample): %.3e" % best[0])
    print("   at strengths (bu1,bv1,ba1,bu2,bv2,ba2,du,dv) =", best[1][0])
    print("   h on p=0,0.2,..,1:", np.round(best[1][1], 8).tolist())
