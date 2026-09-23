"""
Experiments E1-E8 for the Cumulative Reproduction Model.
Each experiment compares exact stochastic simulation with an analytic prediction.
Run:  python experiments.py  [--quick]
Outputs: results/results.json, figures/*.png
"""
from __future__ import annotations

import json
import math
import os
import sys
import time
import argparse
import platform
import scipy
import matplotlib

import numpy as np

from crm import (CRM, Ledger, gillespie, ode_trajectory, arity2_critical_mass,
                 arity2_time_to, birth_death_hit_prob, linear_extinction_prob,
                 spectral_radius, two_layer_threshold, transient_distribution, project_down)
import plotstyle as ps

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("experiments", nargs="*", )
parser.add_argument("--quick", action="store_true")
parser.add_argument("--output-dir", default=os.path.dirname(os.path.abspath(__file__)))
args = parser.parse_args() if __name__ == "__main__" else parser.parse_args([])
QUICK = args.quick
HERE = os.path.abspath(args.output_dir)
RES = os.path.join(HERE, "results")
FIG = os.path.join(HERE, "figures")
SEED = 20260922
results: dict = {"seed": SEED, "quick": QUICK, "schema_version": 2,
                 "environment": {"python": platform.python_version(), "numpy": np.__version__,
                                 "scipy": scipy.__version__, "matplotlib": matplotlib.__version__}}


def rng_for(tag: str) -> np.random.Generator:
    import zlib
    return np.random.default_rng([SEED, zlib.crc32(tag.encode())])


def runs(n):  # scale run counts in quick mode
    return max(20, n // 5) if QUICK else 5 * n


def wilson(k, n, z=1.96):
    if n == 0:
        return (0, 0)
    p = k / n
    d = 1 + z * z / n
    c = (p + z * z / (2 * n)) / d
    h = z * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n)) / d
    return (c - h, c + h)


# ============================================================================ E1
def e1_threshold():
    """Finite-target hitting probability, distinguished from infinite-horizon survival."""
    t0 = time.time()
    rcs = np.round(np.linspace(0.5, 3.0, 11), 3)
    n_cap = 100
    R = runs(400)
    out = {}
    for n0 in (1, 3):
        rows = []
        for rc in rcs:
            m = CRM(delta=1.0, alpha={1: float(rc)})
            rng = rng_for(f"e1-{n0}-{rc}")
            hits = sum(gillespie(m, n0, 1e6, n_cap, rng, record=False).outcome == "cap" for _ in range(R))
            rows.append(dict(Rc=float(rc), sim=hits / R, ci=wilson(hits, R),
                             exact=birth_death_hit_prob(m, n0, n_cap),
                             asymptotic=1 - linear_extinction_prob(rc, n0)))
        out[f"n0={n0}"] = rows
    results["E1"] = dict(runs=R, n_cap=n_cap, rows=out, secs=time.time() - t0)
    ps.fig_e1(out, os.path.join(FIG, "E1_threshold.png"))


# ============================================================================ E2
def e2_critical_mass():
    """Arity 2 (pairwise composition): Allee threshold at N* = 1 + 2 delta/(rho alpha2)."""
    t0 = time.time()
    m = CRM(delta=1.0, alpha={2: 0.2})
    Ns = arity2_critical_mass(m)
    n_cap = 200
    R = runs(300)
    rows = []
    for n0 in list(range(2, 31, 2)):
        rng = rng_for(f"e2-{n0}")
        hits = sum(gillespie(m, n0, 1e6, n_cap, rng, record=False).outcome == "cap" for _ in range(R))
        rows.append(dict(n0=n0, sim=hits / R, ci=wilson(hits, R), exact=birth_death_hit_prob(m, n0, n_cap)))
    results["E2"] = dict(runs=R, alpha2=0.2, delta=1.0, N_star=Ns, n_cap=n_cap, rows=rows, secs=time.time() - t0)
    ps.fig_e2(rows, Ns, os.path.join(FIG, "E2_critical_mass.png"))


# ============================================================================ E3
def e3_how_fast():
    """Growth class: arity 1 exponential; arity 2 hyperbolic with closed-form blow-up time."""
    t0 = time.time()
    m2 = CRM(delta=1.0, alpha={2: 0.2})
    Ns = arity2_critical_mass(m2)
    n_cap = 2000
    R = runs(200)
    rows = []
    for n0 in (13, 15, 20, 30, 50, 100):
        rng = rng_for(f"e3-{n0}")
        ts = []
        fails = 0
        for _ in range(R):
            r = gillespie(m2, n0, 1e6, n_cap, rng, record=False)
            if r.outcome == "cap":
                ts.append(r.t_end)
            else:
                fails += 1
        rows.append(dict(n0=n0, sim_mean_time=float(np.mean(ts)), sim_median_time=float(np.median(ts)),
                         sim_sd=float(np.std(ts)), n_success=len(ts), n_fail=fails,
                         theory_time=arity2_time_to(m2, n0, n_cap),
                         theory_blowup=arity2_time_to(m2, n0, math.inf)))
    # example trajectories for the figure
    rng = rng_for("e3-traj")
    m1 = CRM(delta=1.0, alpha={1: 2.0})               # R_c = 2, exponential rate 1
    traj1 = [gillespie(m1, 20, 6.0, n_cap, rng) for _ in range(5)]
    traj2 = [gillespie(m2, 20, 6.0, n_cap, rng) for _ in range(5)]
    t_ode1, n_ode1 = ode_trajectory(m1, 20, 6.0, n_cap)
    t_ode2, n_ode2 = ode_trajectory(m2, 20, 6.0, n_cap)
    results["E3"] = dict(runs=R, N_star=Ns, n_cap=n_cap, rows=rows,
                         arity1_rate=float(m1.alpha[1] - m1.delta), secs=time.time() - t0)
    ps.fig_e3(rows, traj1, traj2, (t_ode1, n_ode1), (t_ode2, n_ode2), Ns,
              arity2_time_to(m2, 20, math.inf), os.path.join(FIG, "E3_how_fast.png"))


# ============================================================================ E4
def e4_budget():
    """Budget-balance law.
    (a) mass-action arity 2 (runaway without ledger) capped at B0/(mu-eta) when mu > eta,
        has negative raw drift below N* and no finite ledger cap when eta >= mu.
    (b) effort-limited search: interior deterministic equilibrium; linear ODE growth
        at eta = mu for this particular critical parameter choice."""
    t0 = time.time()
    rng = rng_for("e4a")
    base = dict(delta=1.0, alpha={2: 0.2})
    Ns = 11.0
    cases = []
    for label, B0, eta, mu in [("cap 60", 120, 0, 2), ("cap 30", 120, 0, 4),
                               ("cap 8 < N*", 120, 0, 15), ("self-financing", 120, 2, 2)]:
        led = Ledger(B0, eta, mu)
        m = CRM(ledger=led, **base)
        n0 = int(min(15, led.cap))
        tr = gillespie(m, n0, 20.0, 5000, rng)
        cases.append(dict(label=label, B0=B0, eta=eta, mu=mu, cap=led.cap, n0=n0,
                          outcome=tr.outcome, final=int(tr.n[-1]), t_end=tr.t_end, traj=tr))
    # (b) effort-limited plateau vs mu
    mus = [0.2, 0.5, 1.0, 1.5, 2.0, 3.0, 4.0]
    brow = []
    for mu in mus:
        m = CRM(mode="effort", delta=1.0, rho=1.0, phi=0.05, c0=1.0, beta=0.2,
                ledger=Ledger(100.0, 0.0, mu))
        # deterministic plateau: root of P(N) = delta N on (0, cap)
        from scipy.optimize import brentq
        Nhat = brentq(lambda n: m.P_raw(n) - n, 1e-9, m.ledger.cap - 1e-9)
        rngb = rng_for(f"e4b-{mu}")
        means = []
        for _ in range(runs(40)):
            r = gillespie(m, int(round(Nhat)), 60.0, 10**6, rngb)
            # Exact integral of the right-continuous path on [10, 60],
            # including the interval from burn-in to the first subsequent event.
            left = np.maximum(r.t[:-1], 10.0)
            right = np.minimum(r.t[1:], 60.0)
            means.append(float(np.sum(r.n[:-1] * np.maximum(right - left, 0)) / 50.0))
        brow.append(dict(mu=mu, cap=m.ledger.cap, N_hat=Nhat, sim_time_avg=float(np.mean(means)),
                         sim_sd=float(np.std(means))))
    # effort-limited, eta >= mu
    runaway = []
    for eta in (1.0, 1.5):
        m = CRM(mode="effort", delta=1.0, phi=0.05, c0=1.0, beta=0.2, ledger=Ledger(100.0, eta, 1.0))
        r = gillespie(m, 20, 40.0, 3000, rng_for(f"e4c-{eta}"))
        runaway.append(dict(eta=eta, mu=1.0, outcome=r.outcome, t_end=r.t_end, final=int(r.n[-1]), traj=r))
    results["E4"] = dict(
        mass_action=[{k: v for k, v in c.items() if k != "traj"} for c in cases],
        effort_plateau=brow,
        effort_self_financing=[{k: v for k, v in c.items() if k != "traj"} for c in runaway],
        N_star=Ns, secs=time.time() - t0)
    ps.fig_e4(cases, Ns, brow, runaway, os.path.join(FIG, "E4_budget_balance.png"))


# ============================================================================ E5
def e5_phase():
    """Finite-horizon survival surface; every finite closed repertoire eventually dies."""
    t0 = time.time()
    Ks = np.arange(4, 41, 4)
    Nstars = np.arange(4, 41, 4)
    R = runs(30)
    T = 30.0
    grid = np.zeros((len(Nstars), len(Ks)))
    exact = np.zeros_like(grid)
    for i, Nst in enumerate(Nstars):
        alpha2 = 2.0 / (Nst - 1.0)        # N* = 1 + 2/alpha2 with delta = rho = 1
        for j, K in enumerate(Ks):
            m = CRM(delta=1.0, alpha={2: float(alpha2)}, ledger=Ledger(float(K), 0.0, 1.0))
            rng = rng_for(f"e5-{Nst}-{K}")
            alive = 0
            for _ in range(R):
                r = gillespie(m, int(K), T, 10**6, rng, record=False)
                alive += r.outcome != "extinct"
            grid[i, j] = alive / R
            p0 = np.zeros(int(K) + 1); p0[int(K)] = 1.0
            exact[i, j] = float(transient_distribution(m, p0, T, int(K))[1:].sum())
    # Descriptive finite-horizon sample result, not a zero-probability theorem.
    below = [(int(K), int(Nst), float(grid[i, j]), float(exact[i, j]))
             for i, Nst in enumerate(Nstars) for j, K in enumerate(Ks) if K < Nst]
    max_alive_below = max(b[2] for b in below)
    # Smallest K with numerical CTMC survival >= 0.5 at this T and initial state.
    K50 = {}
    for i, Nst in enumerate(Nstars):
        m_alpha = 2.0 / (Nst - 1.0)
        for K in range(int(Nst), 200):
            m = CRM(delta=1.0, alpha={2: m_alpha}, ledger=Ledger(float(K), 0.0, 1.0))
            p0 = np.zeros(K + 1); p0[K] = 1.0
            if float(transient_distribution(m, p0, T, K)[1:].sum()) >= 0.5:
                K50[int(Nst)] = K
                break
    results["E5"] = dict(Ks=Ks.tolist(), Nstars=Nstars.tolist(), T=T, runs=R,
                         persistence_sim=grid.tolist(), persistence_exact=exact.tolist(),
                         max_abs_sim_minus_exact=float(np.max(np.abs(grid - exact))),
                         max_persistence_when_K_below_Nstar=max_alive_below,
                         K50_exact=K50, secs=time.time() - t0)
    ps.fig_e5(Ks, Nstars, grid, exact, K50, os.path.join(FIG, "E5_phase_diagram.png"))


# ============================================================================ E6
class Schedule:
    def __init__(self, B_hi, B_lo, t1, t2, eta=0.0, mu=1.0):
        self.B_hi, self.B_lo, self.t1, self.t2 = B_hi, B_lo, t1, t2
        self.eta, self.mu = eta, mu
        self.breaks = [t1, t2]

    def __call__(self, t):
        B = self.B_lo if self.t1 <= t < self.t2 else self.B_hi
        return Ledger(B, self.eta, self.mu)


def e6_hysteresis():
    """Recovery probability after a finite shock, with and without immigration."""
    t0 = time.time()
    shocks = [("shallow shock: ceiling 24", 24, 0.0, True),
              ("shock to ceiling 16 (> N* = 11, inside stochastic margin)", 16, 0.0, False),
              ("deep shock: ceiling 8 < N*", 8, 0.0, True),
              ("deep shock + from-scratch innovation a0 = 1.5", 8, 1.5, True)]
    trajs = []
    R = runs(400)
    stats = []
    M = 40
    for label, Blo, a0, plot in shocks:
        rng = rng_for(f"e6-{Blo}-{a0}")
        if plot:
            tr = gillespie(CRM(delta=1.0, alpha={2: 0.2}, a0=a0), 30, 80.0, 10**6, rng,
                           ledger_schedule=Schedule(40.0, float(Blo), 20.0, 30.0))
            trajs.append((label, tr))
        recovered = 0
        for _ in range(R):
            r = gillespie(CRM(delta=1.0, alpha={2: 0.2}, a0=a0), 30, 80.0, 10**6, rng,
                          ledger_schedule=Schedule(40.0, float(Blo), 20.0, 30.0))
            recovered += int(r.n[-1] >= 30)
        # exact: piecewise-constant CTMC with forced forgetting at the shock onset
        m = CRM(delta=1.0, alpha={2: 0.2}, a0=a0, ledger=Ledger(40.0, 0.0, 1.0))
        p = np.zeros(M + 1); p[30] = 1.0
        p = transient_distribution(m, p, 20.0, M)
        p = project_down(p, int(Blo)); m.ledger = Ledger(float(Blo), 0.0, 1.0)
        p = transient_distribution(m, p, 10.0, M)
        m.ledger = Ledger(40.0, 0.0, 1.0)
        p = transient_distribution(m, p, 50.0, M)
        stats.append(dict(label=label, B_low=Blo, a0=a0, frac_recovered_sim=recovered / R,
                          ci=wilson(recovered, R), frac_recovered_exact=float(p[30:].sum())))
    results["E6"] = dict(runs=R, N_star=11.0, rows=stats, secs=time.time() - t0)
    ps.fig_e6(trajs, os.path.join(FIG, "E6_hysteresis.png"))


# ============================================================================ E7
def multitype_gillespie(lam, delta, n0, n_cap, rng):
    """lam[i][j] = rate at which one type-j item produces a type-i item."""
    n = np.array(n0, dtype=float)
    L = len(delta)
    while True:
        tot_n = n.sum()
        if tot_n == 0:
            return False
        if tot_n >= n_cap:
            return True
        births = np.array([sum(lam[i][j] * n[j] for j in range(L)) for i in range(L)])
        deaths = np.array(delta) * n
        rates = np.concatenate([births, deaths])
        tot = rates.sum()
        k = np.searchsorted(np.cumsum(rates), rng.random() * tot)
        if k < L:
            n[k] += 1
        else:
            n[k - L] -= 1


def e7_nested():
    """Two nested layers, each subcritical alone (k11 = k22 = 0.6) become jointly supercritical
    when the cross-layer coupling c = k12 = k21 exceeds c* = sqrt((1-k11)(1-k22)) = 0.4."""
    t0 = time.time()
    k11 = k22 = 0.6
    delta = [1.0, 1.0]
    cs = np.round(np.linspace(0.0, 0.8, 9), 3)
    R = runs(400)
    rows = []
    for c in cs:
        lam = [[k11, c], [c, k22]]           # with delta = 1, K = lam
        rng = rng_for(f"e7-{c}")
        hits = sum(multitype_gillespie(lam, delta, [1, 0], 150, rng) for _ in range(R))
        rows.append(dict(c=float(c), rhoK=spectral_radius(np.array(lam)), sim=hits / R,
                         ci=wilson(hits, R),
                         # Symmetry makes total N exactly a linear birth-death chain.
                         exact=birth_death_hit_prob(CRM(alpha={1: k11 + float(c)}), 1, 150),
                         asymptotic=1 - linear_extinction_prob(k11 + float(c), 1)))
    # property test of the 2x2 criterion on random matrices
    rng = rng_for("e7-prop")
    mism = 0
    M = 100000
    for _ in range(M):
        a, d = rng.uniform(0, 1, 2)
        b, c = rng.uniform(0, 2, 2)
        pred = (1 - a) * (1 - d) < b * c
        true = spectral_radius(np.array([[a, b], [c, d]])) > 1
        mism += pred != true
    results["E7"] = dict(n_cap=150, k11=k11, k22=k22, c_star=two_layer_threshold(k11, k22), runs=R, rows=rows,
                         criterion_property_test=dict(samples=M, mismatches=int(mism)),
                         secs=time.time() - t0)
    ps.fig_e7(rows, two_layer_threshold(k11, k22), os.path.join(FIG, "E7_nested_layers.png"))


# ============================================================================ E8
def expected_max_geometric(k, p):
    """E[max of k iid Geometric(p) on {1,2,...}] = sum_{j=1}^k (-1)^{j+1} C(k,j) / (1-(1-p)^j)."""
    return sum((-1) ** (j + 1) * math.comb(k, j) / (1 - (1 - p) ** j) for j in range(1, k + 1))


def e8_scaffold():
    """Emergence made load-bearing: an all-or-nothing target of arity k with q options/part.
    Without retained, evaluable parts: expected trials q^k.
    With part-wise feedback and retention (each trial re-draws only missing parts): E[max of k geometrics].
    Deterministic sequential scaffold bound (Lean): <= k q."""
    t0 = time.time()
    q = 4
    rng = rng_for("e8")
    rows = []
    for k in range(1, 11):
        R = runs(2000)
        scaff = []
        for _ in range(R):
            missing = k
            trials = 0
            while missing:
                trials += 1
                missing -= rng.binomial(missing, 1 / q)
            scaff.append(trials)
        row = dict(k=k, unscaffolded_expected=q ** k, scaffolded_sim=float(np.mean(scaff)),
                   scaffolded_exact=expected_max_geometric(k, 1 / q), sequential_bound=k * q)
        if q ** k <= 4096:
            un = rng.geometric(q ** -k, size=runs(2000))
            row["unscaffolded_sim"] = float(np.mean(un))
        rows.append(row)
    results["E8"] = dict(q=q, rows=rows, secs=time.time() - t0)
    ps.fig_e8(rows, q, os.path.join(FIG, "E8_scaffold.png"))


if __name__ == "__main__":
    only = args.experiments
    if any(x not in {f"E{i}" for i in range(1, 9)} for x in only):
        parser.error("Experiment names must be E1 through E8")
    os.makedirs(RES, exist_ok=True)
    os.makedirs(FIG, exist_ok=True)
    exps = dict(E1=e1_threshold, E2=e2_critical_mass, E3=e3_how_fast, E4=e4_budget,
                E5=e5_phase, E6=e6_hysteresis, E7=e7_nested, E8=e8_scaffold)
    path = os.path.join(RES, "results.json")
    if os.path.exists(path) and only:
        previous = json.load(open(path))
        if any(previous.get(k) != results.get(k) for k in ("seed", "quick", "schema_version")):
            raise ValueError("Use a fresh output directory for a different mode or schema")
        previous.update(results)
        results = previous
    for name, fn in exps.items():
        if only and name not in only:
            continue
        t = time.time()
        fn()
        results[name]["quick"] = QUICK
        results[name]["seed"] = SEED
        print(f"{name} done in {time.time() - t:.1f}s", flush=True)
        json.dump(results, open(path, "w"), indent=2, default=float)
