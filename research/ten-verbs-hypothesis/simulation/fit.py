"""Maximum-likelihood fitting of the ten-verb model to one agent's record."""

from __future__ import annotations

import numpy as np
from scipy.optimize import minimize

from model import JOINT, JOINT_BOUNDS, joint_loglik, closed_form_fits

LO = np.array([JOINT_BOUNDS[v][0] for v in JOINT])
HI = np.array([JOINT_BOUNDS[v][1] for v in JOINT])


def _to_theta(u, fixed):
    th = LO + np.clip(u, 0, 1) * (HI - LO)
    for i, val in fixed.items():
        th[..., i] = val
    return th


def fit_joint(a, P, regime, rng, fixed=None, starts=3, notice_on=True):
    """Fit the six belief verbs. fixed: {index in JOINT: value} held constant.

    Optimises in the unit cube with L-BFGS-B; the gradient is a batched
    forward difference (one replay call per gradient). Returns
    (theta_hat (6,), max loglik, number of free parameters).
    """
    fixed = fixed or {}
    free = [i for i in range(len(JOINT)) if i not in fixed]
    h = 1e-4

    def fg(uf):
        u = np.full(len(JOINT), 0.5)
        u[free] = uf
        U = np.repeat(u[None], len(free) + 1, 0)
        steps = np.where(uf + h > 1, -h, h)
        for k, i in enumerate(free):
            U[k + 1, i] += steps[k]
        ll = joint_loglik(_to_theta(U, fixed), a, P, regime, notice_on)
        f = -ll[0]
        g = -(ll[1:] - ll[0]) / steps
        return f, g

    best = None
    for _ in range(starts):
        u0 = rng.uniform(0.05, 0.95, len(free))
        res = minimize(fg, u0, jac=True, method="L-BFGS-B",
                       bounds=[(0, 1)] * len(free),
                       options=dict(maxiter=300))
        if best is None or res.fun < best.fun:
            best = res
    u = np.full(len(JOINT), 0.5)
    u[free] = best.x
    return _to_theta(u, fixed), -best.fun, len(free)


def fit_agent(a, P, regime, rng, starts=3):
    th, ll, _ = fit_joint(a, P, regime, rng, starts=starts)
    out = dict(zip(JOINT, th))
    out.update(closed_form_fits(a))
    return out
