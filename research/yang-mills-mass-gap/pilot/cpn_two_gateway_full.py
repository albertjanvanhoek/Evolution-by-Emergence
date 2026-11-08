"""Graph (G1) of CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md in the FULL exponential CP model.

Vertices u, v (pinned, overlap p), free gateways x, y, free marked outer site a.
Edges ux, vx, uy, vy, xa, ya, xy. Gateways are joined, so they are not independent.

h(p) = 1 - Z(a orthogonal to span(u,v)) / E_a Z(a)     (CPN_MULTI_GATEWAY.md, section 1; q >= 3)

Gateway x is integrated in closed form given (u, v, a, y). Gateway y, and a in the
denominator, are integrated by scrambled Sobol points mapped to uniform unit vectors
(Gaussian then normalize). The SAME points are used at every p, so differences in p are
much more accurate than the values; the spread over independent scramblings is reported.

Run:  python3 cpn_two_gateway_full.py
"""
import numpy as np
from scipy.stats import qmc, norm
import cpn_multi_gateway as m

m.DMAX = 90


def unit_vectors(u01, q):
    g = norm.ppf(np.clip(u01, 1e-12, 1 - 1e-12))
    z = g[:, :q] + 1j * g[:, q:2 * q]
    return z / np.linalg.norm(z, axis=1, keepdims=True)


def overlap2(a, b):
    return np.abs(np.einsum("nc,nc->n", a.conj(), b)) ** 2


def Z_terms(zu, zv, za, zy, b, q):
    """Integrand after integrating x: exp(uy, vy, ya terms) * F(M_x)."""
    bux, bvx, buy, bvy, bxa, bya, bxy = b
    n = za.shape[0]
    Zu = np.broadcast_to(zu, (n, q))
    Zv = np.broadcast_to(zv, (n, q))
    vecs = np.stack([Zu, Zv, za, zy], axis=1)
    sb = np.sqrt([bux, bvx, bxa, bxy])
    V = vecs * sb[None, :, None]
    G = np.einsum("nic,njc->nij", V.conj(), V)
    Fx = m.hub_integral(np.linalg.eigvalsh(G), q)
    ey = np.exp(buy * overlap2(Zu, zy) + bvy * overlap2(Zv, zy) + bya * overlap2(za, zy))
    return Fx * ey


def h_curve(b, q, ps, log2n=18, seed=0, chunk=1 << 15):
    zperp = np.zeros(q, dtype=complex)
    zperp[2] = 1.0
    s_full = qmc.Sobol(4 * q, scramble=True, seed=seed).random_base2(log2n)
    s_nc = qmc.Sobol(2 * q, scramble=True, seed=seed + 1000).random_base2(log2n)
    za_all = unit_vectors(s_full[:, :2 * q], q)
    zy_all = unit_vectors(s_full[:, 2 * q:], q)
    zy_nc = unit_vectors(s_nc, q)
    out = []
    for p in ps:
        zu = np.zeros(q, dtype=complex); zu[0] = 1
        zv = np.zeros(q, dtype=complex); zv[0] = np.sqrt(p); zv[1] = np.sqrt(1 - p)
        full = nc = 0.0
        for i in range(0, za_all.shape[0], chunk):
            full += Z_terms(zu, zv, za_all[i:i + chunk], zy_all[i:i + chunk], b, q).sum()
            zp = np.broadcast_to(zperp, (min(chunk, zy_nc.shape[0] - i), q))
            nc += Z_terms(zu, zv, zp, zy_nc[i:i + chunk], b, q).sum()
        out.append(1 - nc / full)
    return np.array(out)


def validate(q=3):
    """With b_xy = 0 the gateways decouple; compare with the quadrature code."""
    b = (1.3, 0.7, 0.4, 1.9, 1.1, 1.6, 0.0)
    nodes = m.quad_nodes(q, 16, 16, 16)
    ref = [m.h_of_p(p, [(b[0], b[1], b[4]), (b[2], b[3], b[5])], (0, 0), q, nodes) for p in (0.0, 1.0)]
    est = h_curve(b, q, [0.0, 1.0], log2n=16)
    print("validation (b_xy=0): quadrature", np.round(ref, 6), " QMC", np.round(est, 6))
    return np.max(np.abs(np.array(ref) - est))


if __name__ == "__main__":
    err = validate()
    ps = np.linspace(0, 1, 6)
    cases = {
        "all strengths 1": (1, 1, 1, 1, 1, 1, 1),
        "(G3) (1/8,8,8,1/8,8,8,1/4)": (1 / 8, 8, 8, 1 / 8, 8, 8, 1 / 4),
        "strong gateway link (1,1,1,1,1,1,5)": (1, 1, 1, 1, 1, 1, 5),
        "crossed (3,0.2,0.2,3,2,2,3)": (3, 0.2, 0.2, 3, 2, 2, 3),
    }
    for name, b in cases.items():
        curves = np.array([h_curve(b, 3, ps, log2n=18, seed=s) for s in range(4)])
        mean = curves.mean(0)
        steps = np.diff(curves, axis=1)
        print(name)
        print("   h(p), p=0..1 step 0.2:", np.round(mean, 5).tolist())
        print("   smallest step over 4 scramblings: %.2e ; spread of h(0) over scramblings: %.1e"
              % (steps.min(), curves[:, 0].std()))
