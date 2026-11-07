"""4D SU(2) lattice gauge theory, Wilson action, heatbath + overrelaxation.

Links are unit quaternions a = (a0, a1, a2, a3) <-> U = a0 I + i (a . sigma).
Tr U = 2 a0. Array layout: U[mu, x0, x1, x2, x3, 4].
"""
import numpy as np


def qmul(a, b):
    a0, a1, a2, a3 = a[..., 0], a[..., 1], a[..., 2], a[..., 3]
    b0, b1, b2, b3 = b[..., 0], b[..., 1], b[..., 2], b[..., 3]
    # (a0 + i a.s)(b0 + i b.s) = a0 b0 - a.b + i[(a0 b + b0 a - a x b).s]
    return np.stack([
        a0 * b0 - a1 * b1 - a2 * b2 - a3 * b3,
        a0 * b1 + b0 * a1 - (a2 * b3 - a3 * b2),
        a0 * b2 + b0 * a2 - (a3 * b1 - a1 * b3),
        a0 * b3 + b0 * a3 - (a1 * b2 - a2 * b1),
    ], axis=-1)


def qdag(a):
    out = -a
    out[..., 0] = a[..., 0]
    return out


def sh(x, mu, n):
    """Field at site x + n*mu (x has leading lattice axes 0..3)."""
    return np.roll(x, -n, axis=mu)


def random_su2(shape, rng):
    v = rng.normal(size=shape + (4,))
    return v / np.linalg.norm(v, axis=-1, keepdims=True)


def cold(L):
    U = np.zeros((4, L, L, L, L, 4))
    U[..., 0] = 1.0
    return U


def staple(U, mu):
    """Sum of staples A for links U_mu(x), such that the local action is
    (beta/2) Tr(U_mu(x) A)."""
    A = np.zeros(U.shape[1:])
    Umu = U[mu]
    for nu in range(4):
        if nu == mu:
            continue
        Unu = U[nu]
        # forward: U_nu(x+mu) U_mu(x+nu)^dag U_nu(x)^dag
        f = qmul(qmul(sh(Unu, mu, 1), qdag(sh(Umu, nu, 1))), qdag(Unu))
        # backward: U_nu(x+mu-nu)^dag U_mu(x-nu)^dag U_nu(x-nu)
        Unu_m = sh(Unu, nu, -1)
        b = qmul(qmul(qdag(sh(Unu_m, mu, 1)), qdag(sh(Umu, nu, -1))), Unu_m)
        A += f + b
    return A


def parity_mask(L):
    g = np.indices((L, L, L, L)).sum(axis=0)
    return (g % 2 == 0), (g % 2 == 1)


def kp_sample_x0(bk, rng):
    """Kennedy-Pendleton: sample x0 with density ~ sqrt(1-x0^2) exp(bk x0)."""
    n = bk.shape[0]
    out = np.empty(n)
    todo = np.arange(n)
    while todo.size:
        k = bk[todo]
        r1, r2, r3, r4 = rng.random((4, todo.size))
        r1 = np.maximum(r1, 1e-300)
        r3 = np.maximum(r3, 1e-300)
        lam2 = -(np.log(r1) + np.cos(2 * np.pi * r2) ** 2 * np.log(r3)) / (2 * k)
        acc = r4 ** 2 <= 1 - lam2
        out[todo[acc]] = 1 - 2 * lam2[acc]
        todo = todo[~acc]
    return out


def heatbath_sub(U, mu, mask, beta, rng):
    A = staple(U, mu)[mask]
    k = np.linalg.norm(A, axis=-1)
    Abar = A / k[:, None]
    x0 = kp_sample_x0(beta * k, rng)
    v = rng.normal(size=(x0.size, 3))
    v /= np.linalg.norm(v, axis=-1, keepdims=True)
    s = np.sqrt(np.maximum(0.0, 1 - x0 ** 2))
    X = np.concatenate([x0[:, None], s[:, None] * v], axis=-1)
    # Tr(U A) = k Tr(U Abar); X = U Abar  ->  U = X Abar^dag
    Unew = qmul(X, qdag(Abar))
    Umu = U[mu]
    Umu[mask] = Unew / np.linalg.norm(Unew, axis=-1, keepdims=True)


def overrelax_sub(U, mu, mask, rng=None):
    A = staple(U, mu)[mask]
    Abar = A / np.linalg.norm(A, axis=-1, keepdims=True)
    V0 = qdag(Abar)
    Umu = U[mu]
    Unew = qmul(qmul(V0, qdag(Umu[mask])), V0)
    Umu[mask] = Unew / np.linalg.norm(Unew, axis=-1, keepdims=True)


def sweep(U, beta, rng, n_or=3):
    L = U.shape[1]
    ev, od = parity_mask(L)
    for mu in range(4):
        for m in (ev, od):
            heatbath_sub(U, mu, m, beta, rng)
    for _ in range(n_or):
        for mu in range(4):
            for m in (ev, od):
                overrelax_sub(U, mu, m)


def plaquette_field(U, mu, nu):
    """U_mu(x) U_nu(x+mu) U_mu(x+nu)^dag U_nu(x)^dag."""
    return qmul(qmul(U[mu], sh(U[nu], mu, 1)), qmul(qdag(sh(U[mu], nu, 1)), qdag(U[nu])))


def mean_plaquette(U):
    s, n = 0.0, 0
    for mu in range(4):
        for nu in range(mu + 1, 4):
            P = plaquette_field(U, mu, nu)
            s += P[..., 0].mean()
            n += 1
    return s / n


def line(U, mu, R):
    """Product U_mu(x) U_mu(x+mu) ... (R links)."""
    W = U[mu].copy()
    for k in range(1, R):
        W = qmul(W, sh(U[mu], mu, k))
    return W


def loop_RR(U, mu, nu, R):
    """R x R Wilson loop field in plane (mu, nu), as quaternion."""
    Lm = line(U, mu, R)
    Ln = line(U, nu, R)
    return qmul(qmul(Lm, sh(Ln, mu, R)), qmul(qdag(sh(Lm, nu, R)), qdag(Ln)))


# ---------------- gauge fixing: direct maximal center gauge ----------------

def dmcg_functional(U):
    return (U[..., 0] ** 2).mean()


def gauge_transform_sites(U, g):
    """U_mu(x) -> g(x) U_mu(x) g(x+mu)^dag."""
    for mu in range(4):
        U[mu] = qmul(qmul(g, U[mu]), qdag(sh(g, mu, 1)))


def random_gauge(U, rng):
    L = U.shape[1]
    g = random_su2((L, L, L, L), rng)
    gauge_transform_sites(U, g)


def dmcg_fix(U, iters=300, tol=1e-9, overrelax=1.7):
    """Maximise sum (Tr U)^2 by site-wise exact maximisation (checkerboard)."""
    L = U.shape[1]
    ev, od = parity_mask(L)
    prev = dmcg_functional(U)
    hist = [prev]
    for it in range(iters):
        for m in (ev, od):
            M = np.zeros((L, L, L, L, 4, 4))
            for mu in range(4):
                c = qdag(U[mu])  # links leaving x: (g W)_0 = <g, conj(W)>
                M += c[..., :, None] * c[..., None, :]
                d = sh(U[mu], mu, -1)  # links entering x: (W g^dag)_0 = <g, W>
                M += d[..., :, None] * d[..., None, :]
            w, v = np.linalg.eigh(M[m])
            gsel = v[..., :, -1]
            if overrelax != 1.0:
                # move past the optimum along the geodesic from identity (simple OR)
                gsel = gsel * np.sign(gsel[..., :1] + 1e-15)
                ang = np.arccos(np.clip(gsel[..., 0], -1, 1))
                axis = gsel[..., 1:] / np.maximum(np.sin(ang)[..., None], 1e-15)
                ang2 = overrelax * ang
                gsel = np.concatenate([np.cos(ang2)[..., None], np.sin(ang2)[..., None] * axis], axis=-1)
            g = np.zeros((L, L, L, L, 4))
            g[..., 0] = 1.0
            g[m] = gsel
            gauge_transform_sites(U, g)
        cur = dmcg_functional(U)
        hist.append(cur)
        if it > 20 and abs(cur - prev) < tol:
            break
        prev = cur
    # final pure (non-overrelaxed) polishing
    if overrelax != 1.0:
        dmcg_fix(U, iters=50, tol=tol, overrelax=1.0)
    return hist
