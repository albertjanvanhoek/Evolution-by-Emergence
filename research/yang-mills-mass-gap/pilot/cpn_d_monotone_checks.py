"""Checks for CPN_D_MONOTONICITY.md (attempt to prove that D(p) is nondecreasing).

Model of CPN_MULTI_GATEWAY.md section 3: u, v pinned at overlap p; free hubs x_i joined
to u (b_i), v (c_i), a (e_i); optional direct edges u-a, v-a; a free. q = 3.

1. Interpolation identity: log D(p) = int_0^1 dt sum_eps s_eps <O_eps>_{t,p}.
2. Edge energies <|<x_i,a>|^2>_{t,p}: nondecreasing in p? (random graphs, several t)
3. Hub factor f_i(a) increasing in the Bloch alignment of a with the hub's axis.
4. Geometry: the hub axes m_i do NOT contract monotonically near p = 0.
5. Weak a-coupling: E|<x_i,x_j>|^2 for two independent hubs, nondecreasing in p?
6. The positive series T = E[P_x] = sum_l beta_l B^l, and beta_l nonincreasing in p.
Run: python3 cpn_d_monotone_checks.py   (about two minutes)
"""
import numpy as np
import cpn_multi_gateway as m

m.DMAX = 80
q = 3
nodes = m.quad_nodes(q, 16, 16, 16)


def logZ(p, hubs, direct):
    za, wt = nodes
    return np.log((m.Z_of_a(za, p, hubs, direct, q) * wt).sum())


def logG(p, b, c):
    zu, zv = m.basis(p)
    return np.log(m.hub_integral(m.gram_eigs(np.stack([zu, zv])[None], [b, c]), q)[0])


def logD(p, hubs, direct):
    return logZ(p, hubs, direct) - sum(logG(p, b, c) for b, c, e in hubs)


def scaled(hubs, direct, t):
    return [(b, c, t * e) for b, c, e in hubs], (t * direct[0], t * direct[1])


def edge_energy(p, hubs, direct, i, h=1e-4):
    """<|<x_i,a>|^2> = d logZ / d e_i (one-sided second-order difference, valid at e_i = 0)."""
    def at(dh):
        hs = [list(x) for x in hubs]; hs[i][2] += dh
        return logZ(p, [tuple(x) for x in hs], direct)
    return (-3 * at(0) + 4 * at(h) - at(2 * h)) / (2 * h)


def direct_energy(p, hubs, direct, h=1e-4):
    """<|<a,u>|^2> = d logZ / d du."""
    at = lambda dh: logZ(p, hubs, (direct[0] + dh, direct[1]))
    return (-3 * at(0) + 4 * at(h) - at(2 * h)) / (2 * h)


def check_identity():
    hubs = [(1.5, 0.4, 2.0), (0.3, 2.2, 1.2)]
    direct = (0.6, 0.0)
    p = 0.35
    ts = np.linspace(0, 1, 41)
    vals = []
    for t in ts:
        hs, dr = scaled(hubs, direct, t)
        s = sum(hubs[i][2] * edge_energy(p, hs, dr, i) for i in range(len(hubs)))
        s += direct[0] * direct_energy(p, hs, dr)
        vals.append(s)
    from scipy.integrate import simpson
    lhs = logD(p, hubs, direct)
    rhs = simpson(vals, x=ts)
    print("1. interpolation identity: log D = %.10f, integral = %.10f" % (lhs, rhs))
    return abs(lhs - rhs) < 1e-6


def check_edge_energies(rng, n_graphs=12):
    ps = np.linspace(0, 1, 9)
    worst = np.inf
    for _ in range(n_graphs):
        k = rng.integers(2, 4)
        hubs = [tuple(rng.uniform(0, 3, 3)) for _ in range(k)]
        direct = tuple(rng.uniform(0, 1.5, 2) * (rng.random(2) > 0.5))
        for t in (0.25, 1.0):
            hs, dr = scaled(hubs, direct, t)
            for i in range(k):
                E = np.array([edge_energy(p, hs, dr, i) for p in ps])
                worst = min(worst, np.diff(E).min())
    print("2. edge energies, %d graphs, t in {0.25, 1}: smallest step %.2e" % (n_graphs, worst))
    return worst


def check_hub_factor_monotone(rng):
    """f(a) for one hub as a function of y = n_a . m_hat at fixed R."""
    worst = np.inf
    for _ in range(20):
        b, c, e = rng.uniform(0, 3, 3)
        p = rng.uniform(0, 1)
        zu, zv = m.basis(p)
        B = b * np.outer(zu, zu.conj()) + c * np.outer(zv, zv.conj())
        w, V = np.linalg.eigh(B[:2, :2])
        wp, wm = V[:, 1], V[:, 0]  # eigenvectors in the plane (real)
        R = rng.uniform(0.05, 1)
        ys = np.linspace(-1, 1, 41)
        fs = []
        for y in ys:
            tp, tm = R * (1 + y) / 2, R * (1 - y) / 2
            a = np.array([np.sqrt(tp) * wp[0] + np.sqrt(tm) * wm[0],
                          np.sqrt(tp) * wp[1] + np.sqrt(tm) * wm[1],
                          np.sqrt(max(1 - R, 0))], dtype=complex)
            vecs = np.stack([zu, zv, a])[None]
            fs.append(m.hub_integral(m.gram_eigs(vecs, [b, c, e]), q)[0])
        worst = min(worst, np.diff(fs).min() / fs[0])
    print("3. hub factor vs alignment y (20 random hubs): smallest relative step %.2e" % worst)
    return worst


def axis_angle(p, rho1, rho2):
    th = np.arccos(2 * p - 1)
    phi = lambda r: np.arctan2(r * np.sin(th), 1 + r * np.cos(th))
    return abs(phi(rho1) - phi(rho2))


def check_geometry():
    ps = [0.0, 0.001, 0.01, 0.05, 0.2, 0.5, 0.9, 1.0]
    angs = [axis_angle(p, 2.0, 3.0) for p in ps]
    print("4. angle between hub axes, c/b = 2 and 3, at p =", ps)
    print("   ", np.round(angs, 4).tolist(), "(0 at p = 0, grows, then shrinks to 0)")


def overlap2_moment(p, h1, h2):
    """E|<x1,x2>|^2 for independent hubs = Tr(T1 T2), T = E[P_x] under the hub law."""
    za, wt = nodes  # reuse the a-quadrature as a quadrature for one hub's direction
    zu, zv = m.basis(p)
    out = []
    for (b, c) in (h1, h2):
        wgt = np.exp(b * np.abs(za @ zu.conj()) ** 2 + c * np.abs(za @ zv.conj()) ** 2) * wt
        T = np.einsum("n,ni,nj->ij", wgt, za, za.conj()) / wgt.sum()
        # the quadrature fixes the phase of the e3 component; the true mean projector
        # has no W-e3 cross terms (phase symmetry), so remove them
        T[:2, 2] = 0; T[2, :2] = 0
        out.append(T)
    T1, T2 = out
    # the quadrature lives in span(e1,e2,e3); for q = 3 that is all of C^3
    return np.real(np.trace(T1 @ T2))


def check_weak_coupling(rng, n_pairs=40):
    ps = np.linspace(0, 1, 11)
    worst = np.inf
    for _ in range(n_pairs):
        h1 = tuple(rng.uniform(0, 4, 2)); h2 = tuple(rng.uniform(0, 4, 2))
        vals = np.array([overlap2_moment(p, h1, h2) for p in ps])
        worst = min(worst, np.diff(vals).min())
    print("5. weak coupling: E|<x1,x2>|^2, %d random hub pairs: smallest step %.2e" % (n_pairs, worst))
    return worst


def check_T_formula():
    """T = E[P_x] = sum_l beta_l B^l, beta_l = E_mu[(q)_j/(q)_{j+l+1}]; and beta_l nonincreasing in p."""
    from scipy.special import gammaln
    rq = lambda d: np.exp(gammaln(q + d) - gammaln(q))
    def h_seq(lams, D=80):
        h = np.zeros(D + 1); h[0] = 1
        for l in lams:
            for d in range(1, D + 1):
                h[d] += l * h[d - 1]
        return h
    za, wt = m.quad_nodes(q, 24, 24, 24)
    err = 0.0; beta_ok = True
    for (b, c, p) in [(1.0, 2.0, 0.3), (2.5, 0.4, 0.8), (0.7, 0.7, 0.0), (3.0, 3.5, 0.55)]:
        zu, zv = m.basis(p)
        B = b * np.outer(zu, zu.conj()) + c * np.outer(zv, zv.conj())
        h = h_seq(np.linalg.eigvalsh(B)); G = sum(h[j] / rq(j) for j in range(80))
        T = np.zeros((3, 3), complex); Bl = np.eye(3, dtype=complex)
        for l in range(60):
            T += sum(h[j] / rq(j + l + 1) for j in range(80 - l)) / G * Bl
            Bl = Bl @ B
        w = np.exp(b * np.abs(za @ zu.conj()) ** 2 + c * np.abs(za @ zv.conj()) ** 2) * wt
        Tq = np.einsum("n,ni,nj->ij", w, za, za.conj()) / w.sum(); Tq[:2, 2] = 0; Tq[2, :2] = 0
        err = max(err, np.abs(T - Tq).max())
    b, c = 1.3, 2.1
    for l in range(5):
        vals = []
        for p in np.linspace(0, 1, 11):
            zu, zv = m.basis(p)
            B = b * np.outer(zu, zu.conj()) + c * np.outer(zv, zv.conj())
            h = h_seq(np.linalg.eigvalsh(B)); G = sum(h[j] / rq(j) for j in range(80))
            vals.append(sum(h[j] / rq(j + l + 1) for j in range(80 - l)) / G)
        beta_ok &= bool(np.all(np.diff(vals) <= 1e-15))
    print("6. T = sum_l beta_l B^l vs quadrature: max error %.1e; beta_l nonincreasing in p: %s" % (err, beta_ok))
    return err < 1e-10 and beta_ok


if __name__ == "__main__":
    rng = np.random.default_rng(20261108)
    ok = check_identity()
    check_edge_energies(rng)
    check_hub_factor_monotone(rng)
    check_geometry()
    check_weak_coupling(rng)
    ok &= check_T_formula()
    raise SystemExit(0 if ok else 1)
