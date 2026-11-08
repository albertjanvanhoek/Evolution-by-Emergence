"""Cost of a continuous twist defect in 4D lattice gauge theory (ROUTE.md, first test).

Lattice L^4, periodic. The defect is the stack S of plaquettes P_01(y) with y_0 = y_1 = 0
(L^2 plaquettes), the same stack as the 't Hooft twist.

SU(2), Wilson weight exp(beta * a0(U_p)), a0 = tr(U_p)/2 = cos(theta). On S the weight is the
conjugacy-class average
    w_t(U_p) = int dh exp(beta * tr(U_p h D_t h^-1) / 2),   D_t = exp(i t sigma_3),
which in closed form is
    w_t = exp(beta cos(theta) cos(t)) * sinh(beta sin(theta) sin(t)) / (beta sin(theta) sin(t)).
It is gauge invariant (a class function of U_p), equals the Wilson weight at t = 0, and is the
't Hooft twist (D_pi = -1) at t = pi.

U(1), Wilson weight exp(beta cos(phi_p)); on S the central twist exp(beta cos(phi_p + t)),
with phi_p oriented in the (0,1) direction. Control: a central, continuous twist.

Measured: g(t) = (1/L^2) <sum_{p in S} d/dt log w_t(U_p)> = (1/L^2) d/dt log Z(t).
Then f(t) = -(1/L^2) log(Z(t)/Z(0)) = -int_0^t g, by Simpson's rule on the grid.
A cost per unit area means f(t) does not shrink as L grows.
Strong coupling (SU(2)): f(t) ~ 8 u^6 sin^2 t, u = I_2(beta)/I_1(beta) (cubes with two faces on S).

Usage: python gauge_twist.py su2|u1 BETA L [NT [NTHERM NMEAS]]   (writes gauge_twist_{group}_b{BETA}_L{L}.json)
"""

import json
import math
import sys
import time

import numpy as np
from numba import njit

sys.path.insert(0, ".")
from periodic_b2 import tau_int  # noqa: E402


def tables(L):
    V = L ** 4
    coords = np.zeros((V, 4), dtype=np.int64)
    up = np.zeros((V, 4), dtype=np.int64)
    dn = np.zeros((V, 4), dtype=np.int64)
    for s in range(V):
        c = [(s // L ** (3 - k)) % L for k in range(4)]
        coords[s] = c
    for s in range(V):
        for mu in range(4):
            c = coords[s].copy()
            c[mu] = (c[mu] + 1) % L
            up[s, mu] = ((c[0] * L + c[1]) * L + c[2]) * L + c[3]
            c = coords[s].copy()
            c[mu] = (c[mu] - 1) % L
            dn[s, mu] = ((c[0] * L + c[1]) * L + c[2]) * L + c[3]
    sheet = np.array([s for s in range(V) if coords[s, 0] == 0 and coords[s, 1] == 0], dtype=np.int64)
    return coords, up, dn, sheet


# ---------- SU(2) as unit quaternions: U = a0 + i a.sigma ----------

@njit(cache=True)
def qmul(a, b, c):
    c[0] = a[0] * b[0] - a[1] * b[1] - a[2] * b[2] - a[3] * b[3]
    c[1] = a[0] * b[1] + b[0] * a[1] - (a[2] * b[3] - a[3] * b[2])
    c[2] = a[0] * b[2] + b[0] * a[2] - (a[3] * b[1] - a[1] * b[3])
    c[3] = a[0] * b[3] + b[0] * a[3] - (a[1] * b[2] - a[2] * b[1])


@njit(cache=True)
def qdag(a, c):
    c[0] = a[0]
    c[1] = -a[1]
    c[2] = -a[2]
    c[3] = -a[3]


@njit(cache=True)
def logsinhc(x):
    if x < 1e-4:
        return x * x / 6.0
    if x > 20.0:
        return x - math.log(2.0 * x)
    return math.log(math.sinh(x) / x)


@njit(cache=True)
def langevin(x):
    if x < 1e-3:
        return x / 3.0 - x ** 3 / 45.0
    return 1.0 / math.tanh(x) - 1.0 / x


@njit(cache=True)
def su2_logw(a0, beta, t, defect):
    if not defect:
        return beta * a0
    s = math.sqrt(max(0.0, 1.0 - a0 * a0))
    return beta * a0 * math.cos(t) + logsinhc(beta * s * abs(math.sin(t)))


@njit(cache=True)
def su2_dlogw(a0, beta, t):
    s = math.sqrt(max(0.0, 1.0 - a0 * a0))
    st = math.sin(t)
    x = beta * s * abs(st)
    sg = 1.0 if st >= 0 else -1.0
    return -beta * a0 * st + beta * s * math.cos(t) * langevin(x) * sg


@njit(cache=True)
def su2_staples(U, s, mu, up, dn, coords, S, D):
    """Six staples S[k] with tr(U_mu(s) S[k])/2 = a0 of the k-th plaquette; D[k] = on sheet."""
    tmp = np.empty(4)
    tmp2 = np.empty(4)
    d1 = np.empty(4)
    d2 = np.empty(4)
    k = 0
    for nu in range(4):
        if nu == mu:
            continue
        on01 = (mu == 0 and nu == 1) or (mu == 1 and nu == 0)
        # forward: U_nu(s+mu) U_mu(s+nu)^+ U_nu(s)^+, base s
        qdag(U[up[s, nu], mu], d1)
        qmul(U[up[s, mu], nu], d1, tmp)
        qdag(U[s, nu], d2)
        qmul(tmp, d2, tmp2)
        S[k, :] = tmp2
        D[k] = on01 and coords[s, 0] == 0 and coords[s, 1] == 0
        k += 1
        # backward: U_nu(s+mu-nu)^+ U_mu(s-nu)^+ U_nu(s-nu), base s-nu
        b = dn[s, nu]
        qdag(U[up[b, mu], nu], d1)
        qdag(U[b, mu], d2)
        qmul(d1, d2, tmp)
        qmul(tmp, U[b, nu], tmp2)
        S[k, :] = tmp2
        D[k] = on01 and coords[b, 0] == 0 and coords[b, 1] == 0
        k += 1


@njit(cache=True)
def su2_sweep(U, beta, t, up, dn, coords, eps, nhit):
    V = U.shape[0]
    S = np.empty((6, 4))
    D = np.zeros(6, dtype=np.bool_)
    R = np.empty(4)
    Un = np.empty(4)
    acc = 0
    for s in range(V):
        for mu in range(4):
            su2_staples(U, s, mu, up, dn, coords, S, D)
            for _ in range(nhit):
                r1 = eps * (2 * np.random.random() - 1)
                r2 = eps * (2 * np.random.random() - 1)
                r3 = eps * (2 * np.random.random() - 1)
                nr = math.sqrt(1.0 + r1 * r1 + r2 * r2 + r3 * r3)
                R[0] = 1.0 / nr
                R[1] = r1 / nr
                R[2] = r2 / nr
                R[3] = r3 / nr
                qmul(R, U[s, mu], Un)
                dS = 0.0
                for k in range(6):
                    a_old = U[s, mu, 0] * S[k, 0] - U[s, mu, 1] * S[k, 1] - U[s, mu, 2] * S[k, 2] - U[s, mu, 3] * S[k, 3]
                    a_new = Un[0] * S[k, 0] - Un[1] * S[k, 1] - Un[2] * S[k, 2] - Un[3] * S[k, 3]
                    dS += su2_logw(a_new, beta, t, D[k]) - su2_logw(a_old, beta, t, D[k])
                if dS >= 0 or np.random.random() < math.exp(dS):
                    nn = math.sqrt(Un[0] ** 2 + Un[1] ** 2 + Un[2] ** 2 + Un[3] ** 2)
                    for i in range(4):
                        U[s, mu, i] = Un[i] / nn
                    acc += 1
    return acc / (V * 4 * nhit)


@njit(cache=True)
def su2_measure(U, beta, t, up, sheet):
    tmp = np.empty(4)
    tmp2 = np.empty(4)
    d1 = np.empty(4)
    d2 = np.empty(4)
    g = 0.0
    for y in sheet:
        qmul(U[y, 0], U[up[y, 0], 1], tmp)
        qdag(U[up[y, 1], 0], d1)
        qmul(tmp, d1, tmp2)
        qdag(U[y, 1], d2)
        qmul(tmp2, d2, tmp)
        g += su2_dlogw(tmp[0], beta, t)
    return g / sheet.shape[0]


@njit(cache=True)
def su2_plaq(U, up):
    V = U.shape[0]
    tmp = np.empty(4)
    tmp2 = np.empty(4)
    d1 = np.empty(4)
    d2 = np.empty(4)
    p = 0.0
    for s in range(V):
        for mu in range(4):
            for nu in range(mu + 1, 4):
                qmul(U[s, mu], U[up[s, mu], nu], tmp)
                qdag(U[up[s, nu], mu], d1)
                qmul(tmp, d1, tmp2)
                qdag(U[s, nu], d2)
                qmul(tmp2, d2, tmp)
                p += tmp[0]
    return p / (6 * V)


# ---------- U(1) ----------

@njit(cache=True)
def u1_sweep(th, beta, t, up, dn, coords, eps, nhit):
    V = th.shape[0]
    rest = np.empty(6)
    sgn = np.empty(6)
    D = np.zeros(6, dtype=np.bool_)
    acc = 0
    for s in range(V):
        for mu in range(4):
            k = 0
            for nu in range(4):
                if nu == mu:
                    continue
                a, b = (mu, nu) if mu < nu else (nu, mu)
                # plaquette P_ab(base) = th_a(base) + th_b(base+a) - th_a(base+b) - th_b(base)
                for base in (s, dn[s, nu]):
                    ph = th[base, a] + th[up[base, a], b] - th[up[base, b], a] - th[base, b]
                    # coefficient of th_mu(s) in this plaquette
                    c = 0.0
                    if mu == a and base == s:
                        c += 1.0
                    if mu == b and up[base, a] == s:
                        c += 1.0
                    if mu == a and up[base, b] == s:
                        c -= 1.0
                    if mu == b and base == s:
                        c -= 1.0
                    sgn[k] = c
                    rest[k] = ph - c * th[s, mu]
                    D[k] = a == 0 and b == 1 and coords[base, 0] == 0 and coords[base, 1] == 0
                    k += 1
            for _ in range(nhit):
                new = th[s, mu] + eps * (2 * np.random.random() - 1)
                dS = 0.0
                for k in range(6):
                    sh = t if D[k] else 0.0
                    dS += beta * (math.cos(rest[k] + sgn[k] * new + sh) - math.cos(rest[k] + sgn[k] * th[s, mu] + sh))
                if dS >= 0 or np.random.random() < math.exp(dS):
                    th[s, mu] = new
                    acc += 1
    return acc / (V * 4 * nhit)


@njit(cache=True)
def u1_measure(th, beta, t, up, sheet):
    g = 0.0
    for y in sheet:
        ph = th[y, 0] + th[up[y, 0], 1] - th[up[y, 1], 0] - th[y, 1]
        g += -beta * math.sin(ph + t)
    return g / sheet.shape[0]


@njit(cache=True)
def u1_plaq(th, up):
    V = th.shape[0]
    p = 0.0
    for s in range(V):
        for a in range(4):
            for b in range(a + 1, 4):
                p += math.cos(th[s, a] + th[up[s, a], b] - th[up[s, b], a] - th[s, b])
    return p / (6 * V)


@njit(cache=True)
def run_su2(field, beta, t, up, dn, coords, sheet, eps, nhit, ntherm, nmeas, seedv):
    np.random.seed(seedv)
    for _ in range(ntherm):
        su2_sweep(field, beta, t, up, dn, coords, eps, nhit)
    g = np.empty(nmeas)
    p = np.empty(nmeas)
    acc = 0.0
    for i in range(nmeas):
        acc += su2_sweep(field, beta, t, up, dn, coords, eps, nhit)
        g[i] = su2_measure(field, beta, t, up, sheet)
        p[i] = su2_plaq(field, up)
    return g, p, acc / nmeas


@njit(cache=True)
def run_u1(field, beta, t, up, dn, coords, sheet, eps, nhit, ntherm, nmeas, seedv):
    np.random.seed(seedv)
    for _ in range(ntherm):
        u1_sweep(field, beta, t, up, dn, coords, eps, nhit)
    g = np.empty(nmeas)
    p = np.empty(nmeas)
    acc = 0.0
    for i in range(nmeas):
        acc += u1_sweep(field, beta, t, up, dn, coords, eps, nhit)
        g[i] = u1_measure(field, beta, t, up, sheet)
        p[i] = u1_plaq(field, up)
    return g, p, acc / nmeas


def main():
    group = sys.argv[1]
    beta = float(sys.argv[2])
    L = int(sys.argv[3])
    nt = int(sys.argv[4]) if len(sys.argv) > 4 else 9
    ntherm = int(sys.argv[5]) if len(sys.argv) > 5 else 300
    nmeas = int(sys.argv[6]) if len(sys.argv) > 6 else 1500
    coords, up, dn, sheet = tables(L)
    V = L ** 4
    ts = np.linspace(0, math.pi, nt)
    rng = np.random.default_rng(int(1000 * beta) + L)
    out = {"group": group, "beta": beta, "L": L, "ntherm": ntherm, "nmeas": nmeas, "points": []}
    t0 = time.time()
    for i, t in enumerate(ts):
        if group == "su2":
            field = np.zeros((V, 4, 4))
            field[:, :, 0] = 1.0              # cold start
            g, p, acc = run_su2(field, beta, t, up, dn, coords, sheet, 0.6, 3, ntherm, nmeas,
                            int(rng.integers(1 << 30)))
        else:
            field = np.zeros((V, 4))
            g, p, acc = run_u1(field, beta, t, up, dn, coords, sheet, 1.2, 3, ntherm, nmeas,
                            int(rng.integers(1 << 30)))
        tau = tau_int(g)
        err = float(np.std(g) * math.sqrt(2 * tau / len(g)))
        out["points"].append({"t": float(t), "g": float(g.mean()), "g_err": err, "tau_g": tau,
                              "plaq": float(p.mean()), "acc": acc,
                              "g_first_half": float(g[:nmeas // 2].mean()),
                              "g_second_half": float(g[nmeas // 2:].mean())})
        print(f"{group} beta={beta} L={L} t={t:.3f}: g={g.mean():+.4f} +- {err:.4f} tau={tau:.1f} "
              f"plaq={p.mean():.4f} acc={acc:.2f} ({time.time() - t0:.0f}s)", flush=True)
    # f(t) = -int_0^t g by the trapezoid rule on the grid (Simpson for the full range)
    gs = np.array([q["g"] for q in out["points"]])
    es = np.array([q["g_err"] for q in out["points"]])
    h = ts[1] - ts[0]
    f = [0.0]
    fe = [0.0]
    for i in range(1, nt):
        f.append(f[-1] - 0.5 * h * (gs[i - 1] + gs[i]))
        fe.append(math.sqrt(fe[-1] ** 2 + (0.5 * h) ** 2 * (es[i - 1] ** 2 + es[i] ** 2)))
    for q, fv, fev in zip(out["points"], f, fe):
        q["f"] = fv
        q["f_err"] = fev
    if (nt - 1) % 2 == 0:
        w = np.ones(nt)
        w[1:-1:2] = 4
        w[2:-1:2] = 2
        out["f_pi_simpson"] = float(-h / 3 * np.sum(w * gs))
        out["f_pi_simpson_err"] = float(h / 3 * math.sqrt(np.sum((w * es) ** 2)))
    print(f"{group} beta={beta} L={L}: f(t) = " + " ".join(f"{v:+.4f}" for v in f), flush=True)
    with open(f"gauge_twist_{group}_b{beta}_L{L}.json", "w") as fh:
        json.dump(out, fh, indent=1)


if __name__ == "__main__":
    main()
