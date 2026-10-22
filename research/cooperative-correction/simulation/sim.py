"""Simulations for research/cooperative-correction (D35), VERSION 2.

Version 2 answers review A (sources/REVIEW_A.md). Version 1 (sim_v1.py) credited
a gain in the collective estimate to bridge-mediated correction; review A showed
that the correction cancels exactly when corrected estimates are averaged, so the
gain came from weighting error origins (provenance). Version 2 therefore
separates four outcomes and gives every claim a matched comparator:

  (a) the collective point estimate,
  (b) the correction of individual agents,
  (c) calibration of the stated uncertainty, with matched interval methods,
  (d) detection of a new error, at a matched false-alarm rate.

It also adds the case the bridge exists for: agents that measure DIFFERENT
quantities, so that method error cannot be told apart from real differences by
comparing the ordinary measurements.

Experiments
  E1  common target: collective estimate and calibration, matched comparators;
      individual correction with and without the bridge
  E2  common target: a later instrument drift; contamination; detection by the
      reference versus by the ordinary measurements, at matched false alarms
  E3  diversity under a budget (formula and check); localization of faulty
      methods, conditional on fault size, noise and the number of faults
  E4  bridge discovery among available operations: committed predictions and
      shared records; irreproducible operations, operations outside the models,
      theory-laden records by different theories and by a shared theory
  E5  responsiveness, randomized across error origins
  E6  distinct targets: individual levels, comparisons, and detection of an
      instrument drift when real changes also happen
  E7  commutability (added after review B): the bridge works only if each method
      responds to the reference as it does to its real target. A reference-
      specific bias, and drift that transfers only partly to the reference.

Run:  python3 sim.py     (writes results/ and figures/ next to this file)
All randomness is seeded. numpy and matplotlib only.
"""

from __future__ import annotations

import json
import os
from dataclasses import dataclass, field, asdict

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, "results")
FIG = os.path.join(HERE, "figures")
os.makedirs(RES, exist_ok=True)
os.makedirs(FIG, exist_ok=True)

Z95 = 1.959964
T975 = {1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776, 5: 2.571, 6: 2.447, 7: 2.365,
        8: 2.306, 9: 2.262, 10: 2.228}


# ---------------------------------------------------------------------------
# Data generation
# ---------------------------------------------------------------------------

@dataclass
class World:
    clusters: list = field(default_factory=lambda: [3, 1, 1, 1])  # agents per error origin
    sigma: float = 1.0        # sampling noise per observation
    n: int = 5                # observations per agent per round
    sigma_r: float = 0.5      # noise of one reference (bridge) reading
    sigma_b: float = 0.5      # sd of an agent's systematic error
    rho: float = 0.8          # share of bias variance common within an origin
    tau: float = 0.0          # sd of an error shared by ALL methods
    distinct_targets: bool = False  # each agent measures its own quantity
    sd_theta: float = 1.0     # spread of the agents' true quantities, if distinct
    T: int = 40
    t_bridge: int = 10
    drift: float = 0.0        # instrument drift from t_change in drift_origin
    drift_origin: int = 0
    real_change: float = 0.0  # a REAL change from t_change in the target of agent change_agent
    change_agent: int = 3
    t_change: int = 25
    ref_bias_sd: float = 0.0     # a method's extra, persistent error on the reference only
    ref_drift_share: float = 1.0 # share of an instrument drift that also affects the reference
    window: int = 40
    reps: int = 4000
    seed: int = 1


def origin_ids(clusters):
    ids = []
    for k, size in enumerate(clusters):
        ids += [k] * size
    return np.array(ids)


def generate(w: World):
    rng = np.random.default_rng(w.seed)
    cid = origin_ids(w.clusters)
    N, K, R, T = len(cid), len(w.clusters), w.reps, w.T
    g = rng.normal(0, w.tau, size=(R, 1))
    c = rng.normal(0, np.sqrt(w.rho) * w.sigma_b, size=(R, K))
    u = rng.normal(0, np.sqrt(1 - w.rho) * w.sigma_b, size=(R, N))
    beta = g + c[:, cid] + u
    if w.distinct_targets:
        theta = rng.normal(0, w.sd_theta, size=(R, N))
    else:
        theta = np.zeros((R, N))
    theta_t = np.repeat(theta[:, :, None], T, axis=2)
    if w.real_change != 0.0:
        theta_t[:, w.change_agent, w.t_change:] += w.real_change
    drift = np.zeros((R, N, T))
    if w.drift != 0.0:
        drift[:, cid == w.drift_origin, w.t_change:] = w.drift
    y = theta_t + beta[:, :, None] + drift + rng.normal(0, w.sigma / np.sqrt(w.n), size=(R, N, T))
    r0 = rng.normal(0, 1.0, size=(R, 1, 1))
    ref = r0 + beta[:, :, None] + w.ref_drift_share * drift + rng.normal(0, w.sigma_r, size=(R, N, T))
    if w.ref_bias_sd > 0:
        # drawn from a separate generator, so that every other draw is unchanged
        delta = np.random.default_rng(w.seed + 100003).normal(0, w.ref_bias_sd, size=(R, N))
        ref = ref + delta[:, :, None]
    return dict(theta=theta, theta_t=theta_t, y=y, ref=ref, beta=beta, cid=cid, N=N, K=K)


def windows(w):
    t0 = w.T - w.window
    return slice(t0, w.T), slice(max(t0, w.t_bridge), w.T), w.window, w.T - max(t0, w.t_bridge)


def origin_means(x, cid, K):
    return np.stack([x[:, cid == k].mean(axis=1) for k in range(K)], axis=1)


# ---------------------------------------------------------------------------
# Collective estimators for a common target (E1, E2)
# ---------------------------------------------------------------------------

def collective_estimates(w, d):
    """Every estimator sees the same window of the same data. Each returns a
    point estimate, a standard error and the critical value its interval uses."""
    ys, rs, wy, wr = windows(w)
    cid, N, K = d["cid"], d["N"], d["K"]
    m = d["y"][:, :, ys].mean(axis=2)
    gi = d["ref"][:, :, rs].mean(axis=2)
    M = origin_means(m, cid, K)
    G = origin_means(gi, cid, K)
    out = {}
    # consensus, stating only sampling noise (version 1's comparator)
    out["consensus, sampling-noise SE"] = (m.mean(axis=1), np.full(m.shape[0], w.sigma / np.sqrt(w.n * wy * N)), Z95)
    # consensus with uncertainty from the spread of the agents (matched method)
    out["consensus, SE from agents' spread"] = (m.mean(axis=1), m.std(axis=1, ddof=1) / np.sqrt(N), T975[N - 1])
    # provenance-aware aggregation, no bridge
    out["provenance, no bridge"] = (M.mean(axis=1), M.std(axis=1, ddof=1) / np.sqrt(K), T975[K - 1])
    out["provenance + median, no bridge"] = (np.median(M, axis=1), 1.2533 * M.std(axis=1, ddof=1) / np.sqrt(K), T975[K - 1])
    # bridge-mediated correction, averaged: identical point estimate (shown below)
    rel = gi - G.mean(axis=1)[:, None]
    corrected = m - rel
    est_bridge = origin_means(corrected, cid, K).mean(axis=1)
    sizes = np.array(w.clusters)
    sb2 = np.clip(G.var(axis=1, ddof=1) - np.mean(w.sigma_r ** 2 / (wr * sizes)), 0, None)
    se_bridge = np.sqrt(sb2 / K + np.sum(w.sigma ** 2 / (w.n * wy * sizes)) / K ** 2
                        + np.sum(w.sigma_r ** 2 / (wr * sizes)) / K ** 2)
    out["provenance + bridge-corrected agents, averaged"] = (est_bridge, se_bridge, T975[K - 1])
    identity_gap = float(np.max(np.abs(est_bridge - M.mean(axis=1))))
    return out, identity_gap, m, corrected


def score(est, se, crit, truth=0.0):
    err = est - truth
    return dict(rmse=float(np.sqrt(np.mean(err ** 2))),
                coverage95=float(np.mean(np.abs(err) <= crit * se)),
                mean_se=float(np.mean(se)))


def e1():
    out = {}
    for label, clusters in [("dependent origins (3+1+1+1)", [3, 1, 1, 1]), ("independent origins (6 x 1)", [1] * 6)]:
        w = World(clusters=clusters, seed=11)
        d = generate(w)
        ests, gap, m, corrected = collective_estimates(w, d)
        rows = {k: score(*v) for k, v in ests.items()}
        # information control: one method with the whole group's data
        rng = np.random.default_rng(12)
        lone = d["beta"][:, 0] + rng.normal(0, w.sigma / np.sqrt(w.n * w.window * d["N"]), size=d["beta"].shape[0])
        rows["lone agent, same total data"] = score(lone, np.full_like(lone, w.sigma / np.sqrt(w.n * w.window * d["N"])), Z95)
        # individual correction
        M = origin_means(m, d["cid"], d["K"]).mean(axis=1)
        indiv = dict(
            own_estimate=float(np.sqrt(np.mean(m ** 2))),
            corrected_by_bridge=float(np.sqrt(np.mean(corrected ** 2))),
            adopting_the_provenance_estimate=float(np.sqrt(np.mean(M ** 2))))
        out[label] = dict(collective=rows, identity_gap=gap, individual_rmse=indiv)
    w = World(tau=0.4, seed=13)
    d = generate(w)
    ests, _, _, _ = collective_estimates(w, d)
    out["error shared by all methods (tau = 0.4)"] = dict(collective={k: score(*v) for k, v in ests.items()})
    return out


# ---------------------------------------------------------------------------
# Detection at a matched false-alarm rate (E2, E6)
# ---------------------------------------------------------------------------

def change_stats(w, d, source):
    """Per origin: change in its value relative to the median origin, between
    the window before t_change and the window after, in standard-error units."""
    cid, K = d["cid"], d["K"]
    x = d[source]
    pre, post = slice(w.t_bridge, w.t_change), slice(w.t_change, w.T)
    sizes = np.array(w.clusters)

    def rel(sl):
        O = np.stack([x[:, cid == k, sl].mean(axis=(1, 2)) for k in range(K)], axis=1)
        return O - np.median(O, axis=1)[:, None]

    noise = (w.sigma_r if source == "ref" else w.sigma / np.sqrt(w.n))
    se = noise * np.sqrt((1 / (w.t_change - w.t_bridge) + 1 / (w.T - w.t_change)) / sizes)
    return (rel(post) - rel(pre)) / se[None, :]


def matched_detection(w_null, w_alt, flagged_origin, real_origin=None, fa=0.005):
    out = {}
    d0, d1 = generate(w_null), generate(w_alt)
    for source, name in [("ref", "reference (bridge)"), ("y", "ordinary measurements")]:
        z0 = np.abs(change_stats(w_null, d0, source))
        thr = float(np.quantile(z0, 1 - fa))
        z1 = np.abs(change_stats(w_alt, d1, source))
        flags = z1 > thr
        row = dict(threshold=thr, drifted_origin_flagged=float(flags[:, flagged_origin].mean()))
        others = [k for k in range(d1["K"]) if k != flagged_origin and k != real_origin]
        row["other_origins_flagged"] = float(flags[:, others].mean())
        if real_origin is not None:
            row["origin_with_a_real_change_flagged"] = float(flags[:, real_origin].mean())
        out[name] = row
    return out


def e2():
    out = {}
    base = dict(window=10, seed=21, t_change=25)
    for drift in [0.0, 1.0]:
        w = World(drift=drift, **base)
        d = generate(w)
        ests, _, _, _ = collective_estimates(w, d)
        out[f"collective estimate after drift {drift}"] = {k: score(*v) for k, v in ests.items()}
    w_null, w_alt = World(**base), World(drift=1.0, **base)
    w_alt.seed = 22
    out["detection of the drift at 0.5% false alarms per origin"] = matched_detection(w_null, w_alt, flagged_origin=0)
    mono = World(clusters=[6], rho=1.0, drift=1.0, **base)
    d = generate(mono)
    m = d["y"][:, :, windows(mono)[0]].mean(axis=2)
    out["monoculture (one method, 6 agents), drift 1.0"] = dict(
        consensus_rmse=float(np.sqrt(np.mean(m.mean(axis=1) ** 2))),
        note="no relative signal exists inside the collective, by reference or ordinary data")
    return out


# ---------------------------------------------------------------------------
# E3: diversity under a budget; conditional localization
# ---------------------------------------------------------------------------

def mse_k(k, B, F, sigma, sigma_b, tau):
    n_total = B - k * F
    return np.inf if n_total <= 0 else tau ** 2 + sigma_b ** 2 / k + sigma ** 2 / n_total


def e3():
    out = {"assumptions": "k methods with independent, exchangeable errors of sd sigma_b, identical fixed cost F, "
                          "sampling noise sigma, an error tau shared by all, a budget B, and mean squared error as the loss",
           "analytic": {}, "simulated_check": {}, "localization": {}}
    cases = {
        "cheap methods (F=5), large method error": dict(B=400, F=5, sigma=1.0, sigma_b=0.5, tau=0.0),
        "costly methods (F=60), large method error": dict(B=400, F=60, sigma=1.0, sigma_b=0.5, tau=0.0),
        "cheap methods, small method error (sigma_b=0.1)": dict(B=400, F=5, sigma=1.0, sigma_b=0.1, tau=0.0),
        "cheap methods, shared error (tau=0.4)": dict(B=400, F=5, sigma=1.0, sigma_b=0.5, tau=0.4),
    }
    ks = np.arange(1, 200)
    curves = {}
    for name, p in cases.items():
        vals = np.array([mse_k(k, **p) for k in ks])
        curves[name] = vals
        out["analytic"][name] = dict(k_star=int(ks[np.argmin(vals)]), rmse_at_k_star=float(np.sqrt(vals.min())),
                                     rmse_at_k1=float(np.sqrt(vals[0])))
    rng = np.random.default_rng(31)
    p = cases["cheap methods (F=5), large method error"]
    for k in [1, 3, 8, 20, 42, 70]:
        R = 20000
        n_per = (p["B"] - k * p["F"]) / k
        est = (rng.normal(0, p["sigma_b"], size=(R, k)) + rng.normal(0, p["sigma"] / np.sqrt(n_per), size=(R, k))).mean(axis=1)
        out["simulated_check"][f"k={k}"] = dict(rmse_sim=float(np.sqrt(np.mean(est ** 2))),
                                               rmse_formula=float(np.sqrt(mse_k(k, **p))))
    # localization: k methods, f of them faulty by `size`, all with noise sd 1;
    # success = the f methods farthest from the median are exactly the faulty ones
    for k in [3, 5, 7]:
        for f in [1, 2]:
            if 2 * f >= k:
                out["localization"][f"k={k}, faulty={f}"] = "not attempted: no majority of sound methods"
                continue
            row = {}
            for size in [1.0, 2.0, 3.0, 5.0]:
                R = 20000
                x = rng.normal(0, 1.0, size=(R, k))
                x[:, :f] += size
                dev = np.abs(x - np.median(x, axis=1)[:, None])
                top = np.argsort(-dev, axis=1)[:, :f]
                ok = np.all(np.sort(top, axis=1) == np.arange(f)[None, :], axis=1)
                row[f"fault = {size:g} x noise"] = float(ok.mean())
            out["localization"][f"k={k}, faulty={f}"] = row
    out["localization"]["k=2"] = "not possible: two methods that disagree are symmetric"
    return out, ks, curves


# ---------------------------------------------------------------------------
# E4: bridge discovery among available operations
# ---------------------------------------------------------------------------

def e4():
    out = {}
    M, K, OPS, m_needed = 12, 6, 60, 3

    def run(p_rep=0.95, commit_rate=0.9, own_theory=0.0, shared_theory=0.0, reps=3000, seed=41):
        rng = np.random.default_rng(seed)
        s = dict(bridges=0, exposures=0, correct=0, ops=0)
        for _ in range(reps):
            a = rng.integers(M)
            true_out = rng.integers(K, size=OPS)
            common_theory = rng.integers(K, size=OPS)     # what a background theory both share expects
            agents = []
            for _j in range(2):
                support = rng.random(M) < 0.35
                support[a] = rng.random() < 0.5
                if not support.any():
                    support[rng.integers(M)] = True
                pred = rng.integers(K, size=(OPS, M))
                right = rng.random(OPS) < 0.6
                pred[right, a] = true_out[right]
                agents.append((support, pred, rng.random(OPS) < commit_rate))
            for op in range(OPS):
                s["ops"] += 1
                allowed = [set(pred[op, sup]) if dom[op] else set(range(K)) for (sup, pred, dom) in agents]
                shared_bias_here = rng.random() < shared_theory
                rec, agree = None, 0
                for _t in range(m_needed):
                    if shared_bias_here:
                        recs = [int(common_theory[op])] * 2
                    else:
                        recs = []
                        for j in range(2):
                            o = int(true_out[op])
                            if rng.random() > p_rep:
                                o = int(rng.integers(K))
                            if rng.random() < own_theory:
                                o = int(rng.choice(sorted(allowed[j])))
                            recs.append(o)
                    if recs[0] == recs[1] and (rec is None or recs[0] == rec):
                        rec = recs[0]
                        agree += 1
                if agree < m_needed or len(allowed[0]) == K or len(allowed[1]) == K or (allowed[0] & allowed[1]):
                    continue
                s["bridges"] += 1
                for j, (sup, pred, dom) in enumerate(agents):
                    if rec not in allowed[j]:
                        s["exposures"] += 1
                        if (not sup[a]) or (pred[op, a] != true_out[op]):
                            s["correct"] += 1
        return dict(bridges_per_100_ops=100 * s["bridges"] / s["ops"],
                    exposures_per_100_ops=100 * s["exposures"] / s["ops"],
                    share_of_exposures_correct=s["correct"] / s["exposures"] if s["exposures"] else None)

    out["reproducible, committed, faithful records"] = run()
    out["irreproducible operations (half of records noise)"] = run(p_rep=0.5)
    out["two in three operations outside the models"] = run(commit_rate=0.33)
    out["records shaped by each agent's OWN theory (0.3)"] = run(own_theory=0.3)
    out["records shaped by each agent's OWN theory (0.6)"] = run(own_theory=0.6)
    out["records shaped by a SHARED theory (0.2 of operations)"] = run(shared_theory=0.2)
    out["records shaped by a SHARED theory (0.5 of operations)"] = run(shared_theory=0.5)
    return out


# ---------------------------------------------------------------------------
# E5: responsiveness, randomized across origins
# ---------------------------------------------------------------------------

def e5():
    out = {}
    w = World(seed=51)
    d = generate(w)
    _, _, m, corrected = collective_estimates(w, d)
    R, N = m.shape
    rng = np.random.default_rng(52)
    for frac in [1.0, 0.5, 0.0]:
        k = int(round(frac * N))
        mask = np.zeros((R, N), dtype=bool)
        for r in range(R):
            mask[r, rng.choice(N, size=k, replace=False)] = True
        est = np.where(mask, corrected, m)
        out[f"share acting on exposed errors = {frac} (random agents per run)"] = dict(
            rmse_per_agent=float(np.sqrt(np.mean(est ** 2))),
            spread_between_agents=float(np.mean(est.std(axis=1))))
    out["note"] = ("the correction rule is supplied by the model, not learned by the agents; with a common target, "
                   "adopting the provenance estimate does as well as the bridge correction (E1)")
    return out


# ---------------------------------------------------------------------------
# E6: distinct targets -- where the bridge adds information
# ---------------------------------------------------------------------------

def e6():
    out = {}
    w = World(distinct_targets=True, seed=61)
    d = generate(w)
    ys, rs, _, _ = windows(w)
    cid, N, K = d["cid"], d["N"], d["K"]
    m = d["y"][:, :, ys].mean(axis=2)
    gi = d["ref"][:, :, rs].mean(axis=2)
    th = d["theta"]
    G = origin_means(gi, cid, K)
    corrected_prov = m - (gi - G.mean(axis=1)[:, None])
    iu = np.triu_indices(N, 1)

    def pair_rmse(est):
        de = (est[:, :, None] - est[:, None, :])[:, iu[0], iu[1]]
        dt = (th[:, :, None] - th[:, None, :])[:, iu[0], iu[1]]
        return float(np.sqrt(np.mean((de - dt) ** 2)))

    def level_rmse(est):
        return float(np.sqrt(np.mean((est - th) ** 2)))

    # without a bridge, agents could only shrink toward each other, which mixes
    # real differences with method errors; we report the plain estimate
    out["estimates"] = {
        "own measurement only (no bridge)": dict(level_rmse=level_rmse(m), comparison_rmse=pair_rmse(m)),
        "corrected through the bridge (provenance center)": dict(level_rmse=level_rmse(corrected_prov),
                                                                 comparison_rmse=pair_rmse(corrected_prov)),
    }
    out["estimates"]["note"] = ("the bridge removes relative method errors, so comparisons between targets improve; "
                                "the absolute level keeps the average method error, which needs an anchor")
    base = dict(distinct_targets=True, window=10, t_change=25)
    w_null = World(seed=62, **base)
    w_alt = World(seed=63, drift=1.0, real_change=1.0, change_agent=3, **base)
    out["detection: instrument drift in origin 0 and a REAL change in origin 1, at 0.5% false alarms"] = \
        matched_detection(w_null, w_alt, flagged_origin=0, real_origin=int(origin_ids(w_alt.clusters)[3]))
    return out


# ---------------------------------------------------------------------------
# E7: commutability
# ---------------------------------------------------------------------------

def e7():
    out = {"comparisons_vs_reference_specific_bias": {}, "detection_vs_drift_transfer": {}}
    iu = None
    for s in [0.0, 0.1, 0.25, 0.4, 0.5, 0.75, 1.0]:
        w = World(distinct_targets=True, ref_bias_sd=s, seed=61)
        d = generate(w)
        ys, rs, _, _ = windows(w)
        cid, N, K = d["cid"], d["N"], d["K"]
        m = d["y"][:, :, ys].mean(axis=2)
        gi = d["ref"][:, :, rs].mean(axis=2)
        th = d["theta"]
        G = origin_means(gi, cid, K)
        corr = m - (gi - G.mean(axis=1)[:, None])
        iu = np.triu_indices(N, 1)

        def pair(est):
            de = (est[:, :, None] - est[:, None, :])[:, iu[0], iu[1]]
            dt = (th[:, :, None] - th[:, None, :])[:, iu[0], iu[1]]
            return float(np.sqrt(np.mean((de - dt) ** 2)))
        out["comparisons_vs_reference_specific_bias"][f"sd {s:g}"] = dict(
            with_bridge=pair(corr), without_bridge=pair(m))
    base = dict(distinct_targets=True, window=10, t_change=25)
    for share in [0.0, 0.25, 0.5, 0.75, 1.0]:
        w_null = World(seed=62, ref_drift_share=share, **base)
        w_alt = World(seed=63, drift=1.0, real_change=1.0, change_agent=3, ref_drift_share=share, **base)
        r = matched_detection(w_null, w_alt, flagged_origin=0, real_origin=int(origin_ids(w_alt.clusters)[3]))
        out["detection_vs_drift_transfer"][f"{int(share * 100)}% of the drift reaches the reference"] = r["reference (bridge)"]
    return out


# ---------------------------------------------------------------------------

def table(rows, keys):
    lines = ["| | " + " | ".join(keys) + " |", "|---|" + "---|" * len(keys)]
    for name, r in rows.items():
        if not isinstance(r, dict):
            continue
        cells = []
        for k in keys:
            v = r.get(k, "")
            cells.append(f"{v:.3f}" if isinstance(v, float) else str(v))
        lines.append(f"| {name} | " + " | ".join(cells) + " |")
    return "\n".join(lines)


def main():
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    res = {"parameters": asdict(World())}
    res["E1"] = e1()
    res["E2"] = e2()
    e3r, ks, curves = e3()
    res["E3"] = e3r
    res["E4"] = e4()
    res["E5"] = e5()
    res["E6"] = e6()
    res["E7"] = e7()
    with open(os.path.join(RES, "results.json"), "w") as f:
        json.dump(res, f, indent=2)

    md = ["# Simulation results, version 2", "",
          "Generated by `sim.py` (seeded). RMSE: root mean squared error. Coverage: share of 95% intervals containing "
          "the truth; each estimator uses the critical value that fits how its uncertainty is estimated "
          "(normal for known noise, Student t with origins-minus-one or agents-minus-one degrees of freedom when the "
          "spread is estimated).", ""]
    md.append("## E1. Common target: collective estimate, calibration, individual correction\n")
    for label, r in res["E1"].items():
        md += [f"### {label}", "", table(r["collective"], ["rmse", "coverage95", "mean_se"]), ""]
        if "identity_gap" in r:
            md += [f"Largest difference between the bridge-corrected average and the provenance mean without a bridge: {r['identity_gap']:.1e}.", ""]
            md += ["Individual agents, RMSE: " + json.dumps({k: round(v, 3) for k, v in r["individual_rmse"].items()}), ""]
    md.append("## E2. Common target: a later drift of +1.0 in origin 0 (last 10 rounds)\n")
    for label, r in res["E2"].items():
        if label.startswith("collective"):
            md += [f"### {label}", "", table(r, ["rmse", "coverage95"]), ""]
        elif label.startswith("detection"):
            md += [f"### {label}", "", table(r, ["drifted_origin_flagged", "other_origins_flagged", "threshold"]), ""]
        else:
            md += [f"### {label}", "", json.dumps(r), ""]
    md.append("## E3. Diversity under a budget, and localization\n")
    md += ["Assumptions: " + res["E3"]["assumptions"], ""]
    md += [table(res["E3"]["analytic"], ["k_star", "rmse_at_k_star", "rmse_at_k1"]), ""]
    md += ["Simulated check: " + json.dumps({k: {kk: round(vv, 4) for kk, vv in v.items()} for k, v in res["E3"]["simulated_check"].items()}), ""]
    md += ["Localization (share of runs in which the faulty methods are exactly those farthest from the median; noise sd 1):", ""]
    for k, v in res["E3"]["localization"].items():
        md.append(f"- {k}: {json.dumps(v)}")
    md += ["", "## E4. Bridge discovery among available operations\n",
           table(res["E4"], ["bridges_per_100_ops", "exposures_per_100_ops", "share_of_exposures_correct"]), ""]
    md += ["## E5. Responsiveness, randomized across origins\n", table(res["E5"], ["rmse_per_agent", "spread_between_agents"]), "",
           res["E5"]["note"], ""]
    md += ["## E6. Distinct targets: where the bridge adds information\n",
           table(res["E6"]["estimates"], ["level_rmse", "comparison_rmse"]), "", res["E6"]["estimates"]["note"], ""]
    for label, r in res["E6"].items():
        if label.startswith("detection"):
            md += [f"### {label}", "", table(r, ["drifted_origin_flagged", "origin_with_a_real_change_flagged", "other_origins_flagged", "threshold"]), ""]
    md += ["## E7. Commutability: does each method respond to the reference as to its real target?\n",
           "Comparisons between distinct targets (RMSE), as the reference picks up a method-specific bias of its own:", "",
           table(res["E7"]["comparisons_vs_reference_specific_bias"], ["with_bridge", "without_bridge"]), "",
           "Detection of the instrument drift by the reference (0.5% false alarms per origin), as less of the drift reaches the reference:", "",
           table(res["E7"]["detection_vs_drift_transfer"], ["drifted_origin_flagged", "origin_with_a_real_change_flagged", "other_origins_flagged"]), ""]
    with open(os.path.join(RES, "RESULTS.md"), "w") as f:
        f.write("\n".join(md))
    sds = [0.0, 0.1, 0.25, 0.4, 0.5, 0.75, 1.0]
    rows7 = res["E7"]["comparisons_vs_reference_specific_bias"]
    fig, ax = plt.subplots(figsize=(6.4, 4))
    ax.plot(sds, [rows7[f"sd {s:g}"]["with_bridge"] for s in sds], "o-", label="corrected through the bridge")
    ax.plot(sds, [rows7[f"sd {s:g}"]["without_bridge"] for s in sds], "s--", label="own measurement only")
    ax.set_xlabel("sd of a method's bias on the reference only (method error sd = 0.5)")
    ax.set_ylabel("RMSE of comparisons between targets")
    ax.set_title("E7. The bridge helps only if the reference is commutable")
    ax.legend(fontsize=8)
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e7_commutability.png"), dpi=150)

    fig, ax = plt.subplots(figsize=(6.4, 4))
    for name, vals in curves.items():
        ax.plot(ks, np.sqrt(vals), label=name)
    ax.set_xscale("log")
    ax.set_ylim(0, 0.8)
    ax.set_xlabel("number of independent methods kept (k)")
    ax.set_ylabel("RMSE of the collective estimate")
    ax.set_title("E3. Diversity under a fixed budget (assumptions in RESULTS.md)")
    ax.legend(fontsize=7)
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e3_diversity_budget.png"), dpi=150)

    rows = res["E1"]["dependent origins (3+1+1+1)"]["collective"]
    names = list(rows.keys())
    fig, ax = plt.subplots(figsize=(7.2, 4))
    ax.bar(range(len(names)), [rows[n]["rmse"] for n in names], label="RMSE")
    ax.plot(range(len(names)), [rows[n]["coverage95"] for n in names], "ko-", label="95% coverage")
    ax.axhline(0.95, color="grey", lw=0.8, ls="--")
    ax.set_xticks(range(len(names)))
    ax.set_xticklabels([n.replace(", ", ",\n") for n in names], fontsize=6)
    ax.set_title("E1. Same data, dependent origins: matched comparators")
    ax.legend(fontsize=7)
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e1_matched.png"), dpi=150)
    print("\n".join(md))


if __name__ == "__main__":
    main()
