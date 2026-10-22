"""Simulations for research/cooperative-correction (D35), VERSION 1.

Kept as assessed by review A (sources/REVIEW_A.md). Superseded by sim.py:
review A showed that the cooperative point estimate below equals the
provenance-weighted mean of the ordinary measurements, because the bridge
correction cancels when corrected estimates are averaged.

Compares, on the SAME raw data:
  - independent agents (each uses only its own method),
  - a lone agent given the same total amount of data as the whole group,
  - forced consensus (everyone adopts the equal-weight average and treats
    agents as independent),
  - cooperative error identification: agents keep their own methods and
    records, use a shared bridge operation (a common reference measurement)
    to estimate *relative* errors, and correct their own estimates.
    Two variants: without provenance (agents counted as independent) and with
    provenance (agents grouped by the origin of their errors, "count origins,
    not copies"), plus a robust variant that uses the median across origins.

Dependence between sources is explicit: agents in the same cluster share part
of their systematic error. A global component shared by every method can be
switched on: it is the error no amount of cross-checking can see.

Experiments
  E1  accuracy and calibration, with and without dependence
  E2  a later drift in one cluster: contamination and detection; a monoculture
      (all agents one method) for comparison
  E3  how many independent methods to keep under a fixed budget, and how many
      are needed to localize a single faulty one
  E4  bridge construction: committed predictions + shared records, with
      irreproducible operations, uncommitted agents and theory-laden records
      as failure modes
  E5  responsiveness: what happens when some agents do not act on exposed errors

Run:  python3 sim.py            (writes results/ and figures/ next to this file)
All randomness is seeded. numpy and matplotlib only.
"""

from __future__ import annotations

import json
import os
from dataclasses import dataclass, field, asdict

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, "results_v1")
FIG = os.path.join(HERE, "figures_v1")
os.makedirs(RES, exist_ok=True)
os.makedirs(FIG, exist_ok=True)

Z95 = 1.959964
# two-sided 97.5% Student t quantiles, for intervals whose spread is estimated
# from few error origins (df = origins - 1)
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
    rho: float = 0.8          # share of bias variance common within a cluster
    tau: float = 0.0          # sd of an error shared by ALL methods (invisible)
    T: int = 40               # rounds
    t_bridge: int = 10        # round from which the bridge operation exists
    drift: float = 0.0        # extra error from round t_drift in drift_cluster
    t_drift: int = 25
    drift_cluster: int = 0
    window: int = 40          # rounds used by every estimator (same for all)
    reps: int = 4000
    seed: int = 1


def agent_cluster_ids(clusters):
    ids = []
    for k, size in enumerate(clusters):
        ids += [k] * size
    return np.array(ids)


def generate(w: World):
    """Return round means y[r,i,t], reference readings ref[r,i,t], biases."""
    rng = np.random.default_rng(w.seed)
    cid = agent_cluster_ids(w.clusters)
    N, C, R, T = len(cid), len(w.clusters), w.reps, w.T
    theta = 0.0
    g = rng.normal(0, w.tau, size=(R, 1))                                     # shared by all
    c = rng.normal(0, np.sqrt(w.rho) * w.sigma_b, size=(R, C))                 # per cluster
    u = rng.normal(0, np.sqrt(1 - w.rho) * w.sigma_b, size=(R, N))             # per agent
    beta = g + c[:, cid] + u                                                   # R x N
    drift = np.zeros((R, N, T))
    if w.drift != 0.0:
        drift[:, cid == w.drift_cluster, w.t_drift:] = w.drift
    y = theta + beta[:, :, None] + drift + rng.normal(0, w.sigma / np.sqrt(w.n), size=(R, N, T))
    r0 = rng.normal(0, 1.0, size=(R, 1, 1))                                    # unknown reference value
    ref = r0 + beta[:, :, None] + drift + rng.normal(0, w.sigma_r, size=(R, N, T))
    return dict(theta=theta, y=y, ref=ref, beta=beta, cid=cid, N=N, C=C)


# ---------------------------------------------------------------------------
# Estimators. Every one sees the same window of the same draws.
# ---------------------------------------------------------------------------

def window_slices(w: World):
    t0 = w.T - w.window
    r0 = max(t0, w.t_bridge)
    return slice(t0, w.T), slice(r0, w.T), w.window, w.T - r0


def independent(w, d):
    ys, _, wy, _ = window_slices(w)
    est = d["y"][:, :, ys].mean(axis=2)
    se = np.full_like(est, w.sigma / np.sqrt(w.n * wy))
    return est, se


def lone_agent_same_total(w, d, rng):
    """Agent 0's method, but with N times the data: information controlled."""
    ys, _, wy, _ = window_slices(w)
    N = d["N"]
    sys_err = d["beta"][:, 0]                                       # bias of agent 0
    drift = 0.0
    if w.drift != 0.0 and d["cid"][0] == w.drift_cluster:
        drift = w.drift * max(0, w.T - max(w.t_drift, w.T - w.window)) / wy
    est = d["theta"] + sys_err + drift + rng.normal(0, w.sigma / np.sqrt(w.n * wy * N), size=sys_err.shape)
    se = np.full_like(est, w.sigma / np.sqrt(w.n * wy * N))
    return est, se


def consensus(w, d):
    m, _ = independent(w, d)
    est = m.mean(axis=1)
    se = np.full_like(est, w.sigma / np.sqrt(w.n * w.window * d["N"]))
    return est, se


def cooperative(w, d, provenance=True, robust=False, responsive=None):
    """Error identification through the bridge, then each agent corrects itself.

    Returns the collective estimate (the agents' corrected estimates agree up to
    noise; we report their average over origins) and its reported SE, plus the
    per-agent corrected estimates.
    responsive: boolean array (N,) of agents that act on their exposed error.
    """
    ys, rs, wy, wr = window_slices(w)
    if wr <= 1:
        est, se = consensus(w, d)
        return est, se, None
    cid, C, N = d["cid"], d["C"], d["N"]
    m = d["y"][:, :, ys].mean(axis=2)               # own estimates
    gi = d["ref"][:, :, rs].mean(axis=2)            # own reference readings
    if provenance:
        groups = [np.where(cid == k)[0] for k in range(C)]
    else:
        groups = [np.array([i]) for i in range(N)]  # every agent its own origin
    G_of = np.stack([gi[:, idx].mean(axis=1) for idx in groups], axis=1)   # R x origins
    M_of = np.stack([m[:, idx].mean(axis=1) for idx in groups], axis=1)
    center = np.median(G_of, axis=1) if robust else G_of.mean(axis=1)
    rel = gi - center[:, None]                      # estimated relative error of each agent
    if responsive is None:
        responsive = np.ones(N, dtype=bool)
    corrected = np.where(responsive[None, :], m - rel, m)
    # collective estimate: corrected estimates averaged over origins
    corr_of = np.stack([corrected[:, idx].mean(axis=1) for idx in groups], axis=1)
    est = np.median(corr_of, axis=1) if robust else corr_of.mean(axis=1)
    # reported uncertainty: spread of systematic errors between origins, estimated
    # from the bridge, plus sampling noise
    K = G_of.shape[1]
    sizes = np.array([len(idx) for idx in groups])
    ref_noise_share = np.mean(w.sigma_r ** 2 / (wr * sizes))
    sb2 = np.clip(G_of.var(axis=1, ddof=1) - ref_noise_share, 0, None)
    noise_var = np.sum(w.sigma ** 2 / (w.n * wy * sizes)) / K ** 2
    ref_var = np.sum(w.sigma_r ** 2 / (wr * sizes)) / K ** 2
    se = np.sqrt(sb2 / K + noise_var + ref_var)
    if robust:
        se = se * 1.2533  # efficiency of the median for normal data
    cooperative.last_df = K - 1
    return est, se, corrected


def summarize(est, se, theta, df=None):
    err = est - theta
    out = dict(rmse=float(np.sqrt(np.mean(err ** 2))),
               coverage95=float(np.mean(np.abs(err) <= Z95 * se)),
               mean_reported_se=float(np.mean(se)))
    if df is not None:
        out["coverage95_t"] = float(np.mean(np.abs(err) <= T975[df] * se))
    return out


def coop_summary(w, d, **kw):
    e, s, _ = cooperative(w, d, **kw)
    return summarize(e, s, d["theta"], df=cooperative.last_df)


# ---------------------------------------------------------------------------
# E1: accuracy and calibration, with and without dependence
# ---------------------------------------------------------------------------

def e1():
    out = {}
    for label, clusters in [("dependent sources: clusters 3+1+1+1", [3, 1, 1, 1]),
                            ("independent sources: 6 x 1", [1] * 6)]:
        w = World(clusters=clusters, seed=11)
        d = generate(w)
        rng = np.random.default_rng(12)
        rows = {}
        e, s = independent(w, d); rows["independent (per agent)"] = summarize(e, s, d["theta"])
        e, s = lone_agent_same_total(w, d, rng); rows["lone agent, same total data"] = summarize(e, s, d["theta"])
        e, s = consensus(w, d); rows["forced consensus (equal weights)"] = summarize(e, s, d["theta"])
        rows["cooperative, no provenance"] = coop_summary(w, d, provenance=False)
        rows["cooperative, with provenance"] = coop_summary(w, d, provenance=True)
        rows["cooperative, provenance + robust"] = coop_summary(w, d, provenance=True, robust=True)
        out[label] = rows
    # the invisible floor: an error shared by every method
    w = World(tau=0.4, seed=13)
    d = generate(w)
    out["shared error in all methods (tau = 0.4)"] = {"cooperative, with provenance": coop_summary(w, d, provenance=True)}
    return out


# ---------------------------------------------------------------------------
# E2: a later drift in one cluster
# ---------------------------------------------------------------------------

def detect_flags(w, d, robust=True):
    """Flag origins whose relative reference reading moved between the window
    before the drift and the window after it, beyond 4 standard errors."""
    cid, C = d["cid"], d["C"]
    pre = slice(w.t_bridge, w.t_drift)
    post = slice(w.t_drift, w.T)
    groups = [np.where(cid == k)[0] for k in range(C)]

    def rel(sl):
        G_of = np.stack([d["ref"][:, idx, sl].mean(axis=(1, 2)) for idx in groups], axis=1)
        center = np.median(G_of, axis=1) if robust else G_of.mean(axis=1)
        return G_of - center[:, None]

    change = rel(post) - rel(pre)
    sizes = np.array([len(idx) for idx in groups])
    se = np.sqrt(w.sigma_r ** 2 / sizes * (1 / (w.t_drift - w.t_bridge) + 1 / (w.T - w.t_drift)) * 2)
    return np.abs(change) > 4 * se[None, :]


def e2():
    out = {}
    base = dict(window=10, seed=21, t_drift=25)
    for label, clusters in [("clusters 3+1+1+1", [3, 1, 1, 1]), ("monoculture: one method, 6 agents", [6])]:
        for drift in [0.0, 1.0]:
            w = World(clusters=clusters, drift=drift, **base)
            if clusters == [6]:
                w.rho = 1.0
            d = generate(w)
            rows = {}
            e, s = independent(w, d); rows["independent (per agent)"] = summarize(e, s, d["theta"])
            e, s = consensus(w, d); rows["forced consensus"] = summarize(e, s, d["theta"])
            if len(clusters) > 1:
                rows["cooperative, with provenance"] = coop_summary(w, d, provenance=True)
                rows["cooperative, provenance + robust"] = coop_summary(w, d, provenance=True, robust=True)
                flags = detect_flags(w, d)
                drifted = flags[:, w.drift_cluster]
                others = np.delete(flags, w.drift_cluster, axis=1)
                rows["detection"] = dict(drifted_origin_flagged=float(drifted.mean()),
                                         any_other_origin_flagged=float(others.any(axis=1).mean()))
            else:
                rows["detection"] = dict(note="no relative signal exists: every agent shares the drift; "
                                              "detection is impossible from inside the collective")
            out[f"{label}, drift {drift}"] = rows
    return out


# ---------------------------------------------------------------------------
# E3: how many independent methods to keep under a budget
# ---------------------------------------------------------------------------

def mse_k(k, B, F, sigma, sigma_b, tau):
    n_total = B - k * F
    if n_total <= 0:
        return np.inf
    return tau ** 2 + sigma_b ** 2 / k + sigma ** 2 / n_total


def e3():
    out = {"analytic": {}, "simulated_check": {}, "localization": {}}
    cases = {
        "cheap methods (F=5), large method error": dict(B=400, F=5, sigma=1.0, sigma_b=0.5, tau=0.0),
        "costly methods (F=60), large method error": dict(B=400, F=60, sigma=1.0, sigma_b=0.5, tau=0.0),
        "cheap methods, small method error (sigma_b=0.1)": dict(B=400, F=5, sigma=1.0, sigma_b=0.1, tau=0.0),
        "cheap methods, shared floor (tau=0.4)": dict(B=400, F=5, sigma=1.0, sigma_b=0.5, tau=0.4),
    }
    ks = np.arange(1, 200)
    curves = {}
    for name, p in cases.items():
        vals = np.array([mse_k(k, **p) for k in ks])
        kstar = int(ks[np.argmin(vals)])
        out["analytic"][name] = dict(k_star=kstar, rmse_at_k_star=float(np.sqrt(vals.min())),
                                     rmse_at_k1=float(np.sqrt(vals[0])),
                                     rmse_floor_tau=p["tau"])
        curves[name] = vals
    # simulated check for one case
    rng = np.random.default_rng(31)
    p = cases["cheap methods (F=5), large method error"]
    for k in [1, 3, 8, 20, 42, 70]:
        R = 20000
        n_per = (p["B"] - k * p["F"]) / k
        if n_per <= 0:
            continue
        bias = rng.normal(0, p["sigma_b"], size=(R, k))
        noise = rng.normal(0, p["sigma"] / np.sqrt(n_per), size=(R, k))
        est = (bias + noise).mean(axis=1)
        out["simulated_check"][f"k={k}"] = dict(rmse_sim=float(np.sqrt(np.mean(est ** 2))),
                                               rmse_formula=float(np.sqrt(mse_k(k, **p))))
    # localization of one faulty method by the median rule
    for k in [2, 3, 4, 6]:
        R = 20000
        good = rng.normal(0, 0.1, size=(R, k))
        good[:, 0] += 1.0                        # method 0 is faulty by 1.0
        med = np.median(good, axis=1)
        dev = np.abs(good - med[:, None])
        if k == 2:
            # with two methods both deviate equally from their median: no localization
            correct = 0.5
        else:
            correct = float(np.mean(np.argmax(dev, axis=1) == 0))
        out["localization"][f"k={k}"] = dict(faulty_method_identified=correct)
    return out, ks, curves


# ---------------------------------------------------------------------------
# E4: bridge construction
# ---------------------------------------------------------------------------

def e4():
    """Two agents over M worlds and K outcomes, with different supports and
    different models of each operation. Each round they try one new operation:
    each commits to the outcomes its model allows (an operation outside an
    agent's model gets no commitment: it allows everything); the operation is
    performed; each records an outcome. A shared record needs `m` consistent
    joint records. A bridge is an operation with a shared record on which both
    committed and whose allowed sets are disjoint. It exposes at least one agent.
    An exposure is CORRECT if the exposed agent's model really is wrong about
    the actual world (support excludes it, or the operation model is wrong
    there), FALSE otherwise; false exposures can only come from wrong records.
    """
    out = {}
    M, K, OPS, m_needed = 12, 6, 60, 3

    def run(p_rep, commit_rate, theory_laden, shared_error=0.0, systematic_shared=0.0, reps=3000, seed=41):
        rng = np.random.default_rng(seed)
        stats = dict(bridges=0, exposures=0, correct=0, false=0, ops=0)
        for _ in range(reps):
            a = rng.integers(M)
            true_out = rng.integers(K, size=OPS)            # what each op yields in the actual world
            agents = []
            for _j in range(2):
                support = rng.random(M) < 0.35
                if rng.random() < 0.5:                       # half the agents keep the actual world
                    support[a] = True
                else:
                    support[a] = False
                if not support.any():
                    support[rng.integers(M)] = True
                pred = rng.integers(K, size=(OPS, M))
                # each agent's model is right about the actual world for 60% of ops
                right = rng.random(OPS) < 0.6
                pred[right, a] = true_out[right]
                in_domain = rng.random(OPS) < commit_rate
                agents.append((support, pred, in_domain))
            for op in range(OPS):
                stats["ops"] += 1
                allowed = []
                for (support, pred, in_domain) in agents:
                    if in_domain[op]:
                        allowed.append(set(pred[op, support]))
                    else:
                        allowed.append(set(range(K)))       # uncommitted
                # records: each trial, each agent records the true outcome, except
                # with prob 1-p_rep it records noise; with prob theory_laden it
                # records an outcome its own model allows instead
                agree = 0
                rec = None
                # a systematic shared fault: for this operation, one channel feeds
                # both agents the same wrong outcome on every trial
                sys_bad = rng.random() < systematic_shared
                sys_val = int((true_out[op] + 1 + rng.integers(K - 1)) % K)
                for _t in range(m_needed):
                    recs = []
                    if sys_bad:
                        recs = [sys_val, sys_val]
                    elif rng.random() < shared_error:
                        # both agents' records come from one faulty channel
                        o = int(rng.integers(K))
                        recs = [o, o]
                    for j in range(2 if not recs else 0):
                        o = true_out[op]
                        if rng.random() > p_rep:
                            o = int(rng.integers(K))
                        if rng.random() < theory_laden:
                            o = int(rng.choice(sorted(allowed[j])))
                        recs.append(o)
                    if recs[0] == recs[1] and (rec is None or recs[0] == rec):
                        rec = recs[0]
                        agree += 1
                if agree < m_needed:
                    continue                                 # no shared record
                if len(allowed[0]) == K or len(allowed[1]) == K:
                    continue                                 # someone uncommitted
                if allowed[0] & allowed[1]:
                    continue                                 # not discriminating
                stats["bridges"] += 1
                for j, (support, pred, in_domain) in enumerate(agents):
                    if rec not in allowed[j]:
                        stats["exposures"] += 1
                        wrong = (not support[a]) or (pred[op, a] != true_out[op])
                        stats["correct" if wrong else "false"] += 1
        ops = stats["ops"]
        return dict(bridges_per_100_ops=100 * stats["bridges"] / ops,
                    exposures_per_100_ops=100 * stats["exposures"] / ops,
                    share_of_exposures_correct=(stats["correct"] / stats["exposures"]) if stats["exposures"] else None)

    out["baseline: reproducible, committed, faithful records"] = run(0.95, 0.9, 0.0)
    out["irreproducible operations (p_rep = 0.5)"] = run(0.5, 0.9, 0.0)
    out["two in three operations outside the models (commit 0.33)"] = run(0.95, 0.33, 0.0)
    out["theory-laden records (0.3)"] = run(0.95, 0.9, 0.3)
    out["theory-laden records (0.6)"] = run(0.95, 0.9, 0.6)
    out["shared recording error (0.2): one faulty channel feeds both"] = run(0.95, 0.9, 0.0, shared_error=0.2)
    out["shared recording error (0.5)"] = run(0.95, 0.9, 0.0, shared_error=0.5)
    out["systematic shared recording error (0.2 of operations)"] = run(0.95, 0.9, 0.0, systematic_shared=0.2)
    return out


# ---------------------------------------------------------------------------
# E5: responsiveness
# ---------------------------------------------------------------------------

def e5():
    out = {}
    w = World(seed=51)
    d = generate(w)
    for frac in [1.0, 0.5, 0.0]:
        N = d["N"]
        resp = np.zeros(N, dtype=bool)
        resp[: int(round(frac * N))] = True
        _, _, corrected = cooperative(w, d, provenance=True, responsive=resp)
        err = corrected - d["theta"]
        out[f"share of agents that act on exposed errors = {frac}"] = dict(
            rmse_per_agent=float(np.sqrt(np.mean(err ** 2))),
            spread_between_agents=float(np.mean(corrected.std(axis=1))))
    return out


# ---------------------------------------------------------------------------

def table(rows, keys):
    lines = ["| regime | " + " | ".join(keys) + " |", "|---|" + "---|" * len(keys)]
    for name, r in rows.items():
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

    results = {"parameters": asdict(World())}
    results["E1"] = e1()
    results["E2"] = e2()
    e3res, ks, curves = e3()
    results["E3"] = e3res
    results["E4"] = e4()
    results["E5"] = e5()
    with open(os.path.join(RES, "results.json"), "w") as f:
        json.dump(results, f, indent=2)

    md = ["# Simulation results", "", "Generated by `sim.py` (seeded). RMSE is the root mean squared error of the estimate of the true value; coverage is the share of 95% intervals that contain it.", ""]
    md.append("## E1. Accuracy and calibration\n")
    for label, rows in results["E1"].items():
        md += [f"### {label}", "", table(rows, ["rmse", "coverage95", "coverage95_t", "mean_reported_se"]), ""]
    md.append("## E2. A later drift of +1.0 in one cluster (window of the last 10 rounds)\n")
    for label, rows in results["E2"].items():
        det = rows.pop("detection", None)
        md += [f"### {label}", "", table(rows, ["rmse", "coverage95", "coverage95_t"]), ""]
        if det:
            md += ["Detection: " + json.dumps(det), ""]
            rows["detection"] = det
    md.append("## E3. How many independent methods, under a fixed budget\n")
    md += [table(results["E3"]["analytic"], ["k_star", "rmse_at_k_star", "rmse_at_k1", "rmse_floor_tau"]), ""]
    md += ["Simulated check (cheap methods): " + json.dumps(results["E3"]["simulated_check"]), ""]
    md += ["Localizing one faulty method by the median rule: " + json.dumps(results["E3"]["localization"]), ""]
    md.append("## E4. Bridge construction\n")
    md += [table(results["E4"], ["bridges_per_100_ops", "exposures_per_100_ops", "share_of_exposures_correct"]), ""]
    md.append("## E5. Responsiveness\n")
    md += [table(results["E5"], ["rmse_per_agent", "spread_between_agents"]), ""]
    with open(os.path.join(RES, "RESULTS.md"), "w") as f:
        f.write("\n".join(md))

    # figures
    fig, ax = plt.subplots(figsize=(6.4, 4))
    for name, vals in curves.items():
        ax.plot(ks, np.sqrt(vals), label=name)
    ax.set_xlabel("number of independent methods kept (k)")
    ax.set_ylabel("RMSE of the collective estimate")
    ax.set_title("E3. Diversity under a fixed budget")
    ax.set_ylim(0, 0.8)
    ax.set_xscale('log')
    ax.legend(fontsize=7)
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e3_diversity_budget.png"), dpi=150)

    fig, ax = plt.subplots(figsize=(6.4, 4))
    rows = results["E1"]["dependent sources: clusters 3+1+1+1"]
    names = list(rows.keys())
    ax.bar(range(len(names)), [rows[n]["rmse"] for n in names], label="RMSE")
    ax.plot(range(len(names)), [rows[n]["coverage95"] for n in names], "ko-", label="95% coverage")
    ax.axhline(0.95, color="grey", lw=0.8, ls="--")
    ax.set_xticks(range(len(names)))
    ax.set_xticklabels([n.replace(", ", ",\n").replace(" (", "\n(") for n in names], fontsize=6)
    ax.set_title("E1. Same data, dependent sources")
    ax.legend(fontsize=7)
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e1_regimes.png"), dpi=150)
    print("\n".join(md))


if __name__ == "__main__":
    main()
