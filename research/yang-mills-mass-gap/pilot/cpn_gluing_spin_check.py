"""Spin-level checks of the event-resolved gluing identity (B3) of
CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md, as proved in CPN_TWO_TERMINAL_GLUING_PROOF.md.

(B3):  Z_NC(p) = sum_{d,n} w_d(p) c_n n!/(q+d)_n,   Z(p) = G(p) sum_n c_n n!/(q)_n.

The proof: Z_NC = Z(a pinned orthogonal to span(u,v)), then integrate H's interior
(giving K_H) and x (Dirichlet moments). Here both sides are computed independently:
  left:  direct spin integration of the full exponential model (x by quadrature,
         the interior vertex y in closed form);
  right: the series (B3) with c_n from the exact kernel formula (D4) of the note.

1. Exact rational check of the Dirichlet moment step at p = 0 and p = 1, q = 3..6.
2. Serial network u,v - x - y - a, all strengths 1, q = 3: reproduce the note's table.
3. Cyclic network: triangle x-y-a plus x-a, q = 3, several strengths.
Run: python3 cpn_gluing_spin_check.py   (about one minute)
"""
from fractions import Fraction as Fr
from math import comb, factorial
import numpy as np
import cpn_multi_gateway as m

m.DMAX = 90


def rising(q, d):
    r = 1
    for i in range(d):
        r *= q + i
    return r


# ---------- 1. Dirichlet moment step, exact ----------
def dirichlet_moment(ex, q):
    """E prod |x_i|^{2 e_i} for x uniform on the unit sphere of C^q."""
    num = factorial(q - 1)
    for e in ex:
        num *= factorial(e)
    return Fr(num, factorial(q - 1 + sum(ex)))


def check_moment_step():
    ok = True
    for q in (3, 4, 5, 6):
        for bu, bv in ((Fr(1), Fr(2)), (Fr(3, 2), Fr(1, 3))):
            for d in range(0, 6):
                for n in range(0, 5):
                    # p = 0: B = diag(bu, bv): E[(bu|x1|^2 + bv|x2|^2)^d |x3|^{2n}] / d!
                    lhs = sum(comb(d, j) * bu ** j * bv ** (d - j) * dirichlet_moment((j, d - j, n), q)
                              for j in range(d + 1)) / factorial(d)
                    Hd = sum(bu ** j * bv ** (d - j) for j in range(d + 1))
                    ok &= lhs == Hd * factorial(n) / rising(q, d + n)
                    # p = 1: B = (bu+bv) P_u, eigenvalues (bu+bv, 0)
                    lhs1 = (bu + bv) ** d * dirichlet_moment((d, 0, n), q) / factorial(d)
                    ok &= lhs1 == (bu + bv) ** d * factorial(n) / rising(q, d + n)
    print("1. Dirichlet moment step, exact, q=3..6:", "PASS" if ok else "FAIL")
    return ok


# ---------- kernels ----------
def c_serial(J, b, q, nmax=60, kmax=120):
    """(D4): c_n = sum_{k,m>=n} C(k,n) C(m,n) J^k b^m / (q)_{k+m}."""
    from scipy.special import gammaln
    c = np.zeros(nmax)
    for n in range(nmax):
        k = np.arange(n, kmax)[:, None]
        mm = np.arange(n, kmax)[None, :]
        logt = (gammaln(k + 1) - gammaln(n + 1) - gammaln(k - n + 1)
                + gammaln(mm + 1) - gammaln(n + 1) - gammaln(mm - n + 1)
                + k * np.log(J) + mm * np.log(b) - (gammaln(q + k + mm) - gammaln(q)))
        c[n] = np.exp(logt).sum()
    return c


def c_with_direct(c, cxa):
    """Multiply K_H(z) by exp(cxa z): convolve coefficients."""
    from math import factorial as f
    e = np.array([cxa ** k / f(k) for k in range(len(c))])
    return np.convolve(c, e)[:len(c)]


def rhs_B3(p, bu, bv, c, q):
    s = bu + bv
    Delta = bu * bv * (1 - p)
    disc = np.sqrt(max(s * s - 4 * Delta, 0.0))
    lp, lm = (s + disc) / 2, (s - disc) / 2
    n = np.arange(len(c))
    from scipy.special import gammaln
    Z = ZNC = G = 0.0
    CH = sum(c[k] * np.exp(gammaln(k + 1) - (gammaln(q + k) - gammaln(q))) for k in n)
    for d in range(m.DMAX):
        Hd = sum(lp ** j * lm ** (d - j) for j in range(d + 1))
        wd = Hd * np.exp(-(gammaln(q + d) - gammaln(q)))
        G += wd
        ZNC += wd * sum(c[k] * np.exp(gammaln(k + 1) - (gammaln(q + d + k) - gammaln(q + d))) for k in n)
    return G * CH, ZNC


# ---------- left side: spin integration (q = 3) ----------
def lhs_spin(p, bu, bv, J, b, cxa, q, nodes):
    """Network u,v - x ; x - y (J) ; y - a (b) ; x - a (cxa). y in closed form, x by quadrature.
    Returns (Z_full, Z_NC). Z_full integrates a; Z_NC pins a to e3 (orthogonal to span(u,v))."""
    zu, zv = m.basis(p)
    zx, wt = nodes  # x in span(e1, e2, e3); the complement of span(u,v) is e3 when q = 3
    n = zx.shape[0]
    ex = np.exp(bu * np.abs(zx @ zu.conj()) ** 2 + bv * np.abs(zx @ zv.conj()) ** 2)

    def given_a(za):
        Za = np.broadcast_to(za, (n, 3))
        Fy = m.hub_integral(m.gram_eigs(np.stack([zx, Za], axis=1), [J, b]), q)
        return Fy * np.exp(cxa * np.abs(np.einsum("nc,nc->n", zx.conj(), Za)) ** 2)

    ZNC = (ex * given_a(np.array([0, 0, 1.0], dtype=complex)) * wt).sum()
    # Z_full: by unitary invariance the a-average of the H factor does not depend on x,
    # so Z_full = G(p) * C_H with C_H the a-average at fixed x; compute it at x = e3.
    nodes_a = nodes
    za, wa = nodes_a
    e3 = np.broadcast_to(np.array([0, 0, 1.0], dtype=complex), (za.shape[0], 3))
    Fy = m.hub_integral(m.gram_eigs(np.stack([e3, za], axis=1), [J, b]), q)
    CH = (Fy * np.exp(cxa * np.abs(za[:, 2]) ** 2) * wa).sum()
    G = (ex * wt).sum()
    return G * CH, ZNC


def check_networks():
    q = 3
    nodes = m.quad_nodes(q, 24, 24, 24)
    ok = True
    print("2. serial u,v-x-y-a, q=3, all strengths 1 (note's table in the last column):")
    table = {0.0: 0.004826190176, 0.25: 0.005056163727, 0.5: 0.005281249142,
             0.75: 0.005501599512, 1.0: 0.005717361678}
    c = c_serial(1.0, 1.0, q)
    for p, ref in table.items():
        Zl, Nl = lhs_spin(p, 1, 1, 1, 1, 0.0, q, nodes)
        Zr, Nr = rhs_B3(p, 1, 1, c, q)
        hl, hr = 1 - Nl / Zl, 1 - Nr / Zr
        ok &= abs(hl - hr) < 1e-11 and abs(hl - ref) < 1e-11
        print("   p=%.2f  spin %.12f   (B3) %.12f   table %.12f" % (p, hl, hr, ref))
    print("3. cyclic: triangle x-y-a with x-a edge, q=3 (Z_NC spin vs (B3), relative):")
    for (bu, bv, J, b, cxa) in ((1, 1, 1, 1, 1), (2, 0.5, 3, 1, 0.7), (0.3, 2.5, 0.8, 4, 2)):
        c = c_with_direct(c_serial(J, b, q), cxa)
        worst = 0.0
        for p in (0.0, 0.3, 0.7, 1.0):
            Zl, Nl = lhs_spin(p, bu, bv, J, b, cxa, q, nodes)
            Zr, Nr = rhs_B3(p, bu, bv, c, q)
            worst = max(worst, abs(Nl / Nr - 1), abs(Zl / Zr - 1))
        ok &= worst < 1e-11
        print("   strengths (bu,bv,J,b,cxa)=%s  max relative difference %.1e" % ((bu, bv, J, b, cxa), worst))
    print("networks:", "PASS" if ok else "FAIL")
    return ok


if __name__ == "__main__":
    a = check_moment_step()
    b = check_networks()
    raise SystemExit(0 if (a and b) else 1)
