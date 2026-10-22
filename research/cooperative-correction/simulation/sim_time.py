"""Acting under time: simulations E8 and E9 for research/cooperative-correction
(ACTING_UNDER_TIME.md, D35).

A threat may or may not be growing (prior 0.3). Each period, six agents receive
noisy signals of it; three of them share most of their noise (one lab). If the
threat grows and nothing is done, damage grows by a factor each period. An
intervention stops the damage. Every period the collective must decide:
intervene, or wait, which is also a decision.

Information regimes (same raw signals for all):
  solo                one agent's signals only
  pooled, provenance  all agents, the lab counted once (dependence modelled)
  pooled, naive       all agents treated as independent (the lab counted three times)

Interventions:
  irreversible        a one-off cost; the measure stays
  reversible          a running cost per period; it can be lifted and restarted

E8  the decision boundary: for each regime and each kind of intervention, the
    best threshold (tuned on one set of runs, evaluated on another), the loss,
    wrong interventions, and how early the collective acts.
E9  prevention hides the evidence: while an intervention is on, a growing threat
    produces the same signals as a harmless one. Agents that ignore this lift
    the measure too early; agents that know it stop learning; an independent
    sentinel channel that the intervention does not mask keeps learning going.

Run: python3 sim_time.py   (writes results/RESULTS_TIME.md and results/results_time.json)
Seeded; numpy only.
"""

from __future__ import annotations

import json
import os
from dataclasses import dataclass, asdict

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, "results")
os.makedirs(RES, exist_ok=True)


@dataclass
class P:
    reps: int = 20000
    T: int = 16
    prior: float = 0.3
    mu1: float = 0.5          # signal mean if the threat grows
    mu0: float = -0.5         # signal mean if it does not (and while masked)
    sigma: float = 1.5        # noise per agent per period
    rho: float = 0.8          # share of noise variance common within the lab
    clusters: tuple = (3, 1, 1, 1)
    d0: float = 0.5           # damage in period 1 if growing and unchecked
    growth: float = 1.35      # damage multiplies by this each period
    C: float = 6.0            # one-off cost of an irreversible intervention
    k: float = 0.375          # running cost per period of a reversible one (C / T: never lifting it costs as much as the irreversible one)
    sigma_s: float = 2.0      # noise of the sentinel channel (E9)


def draw(p: P, seed: int):
    rng = np.random.default_rng(seed)
    R, T = p.reps, p.T
    G = rng.random(R) < p.prior
    K = len(p.clusters)
    cid = np.repeat(np.arange(K), p.clusters)
    shared = rng.normal(0, p.sigma * np.sqrt(p.rho), size=(R, K, T))
    own = rng.normal(0, p.sigma * np.sqrt(1 - p.rho), size=(R, len(cid), T))
    noise = shared[:, cid, :] + own                          # R x N x T
    sentinel_noise = rng.normal(0, p.sigma_s, size=(R, T))
    return dict(G=G, noise=noise, cid=cid, sentinel_noise=sentinel_noise)


def llr_increment(p: P, regime: str, d, t, mean):
    """Log-likelihood ratio for growing vs not, from period t's signals whose
    true mean is `mean` (R,), as the regime reads them."""
    x = mean[:, None] + d["noise"][:, :, t]                  # R x N
    if regime == "solo":
        return x[:, 0] / p.sigma ** 2
    if regime == "pooled, naive":
        return x.sum(axis=1) / p.sigma ** 2
    if regime == "pooled, provenance":
        out = np.zeros(x.shape[0])
        for k, n_k in enumerate(p.clusters):
            v = p.sigma ** 2 * (p.rho + (1 - p.rho) / n_k)
            out += x[:, d["cid"] == k].mean(axis=1) / v
        return out
    raise ValueError(regime)


def run_irreversible(p: P, d, regime: str, theta: float):
    R, T = p.reps, p.T
    G = d["G"]
    logit = np.full(R, np.log(p.prior / (1 - p.prior)))
    on = np.zeros(R, dtype=bool)
    t_on = np.full(R, -1)
    loss = np.zeros(R)
    post = 1 / (1 + np.exp(-logit))
    start = post >= theta
    on |= start
    t_on[start] = 0
    loss[start] += p.C
    for t in range(T):
        # damage this period if growing and unchecked
        loss += np.where(G & ~on, p.d0 * p.growth ** t, 0.0)
        mean = np.where(G & ~on, p.mu1, p.mu0)               # masked while on
        inc = llr_increment(p, regime, d, t, mean)
        logit = np.where(on, logit, logit + inc)             # stop updating once on
        post = 1 / (1 + np.exp(-logit))
        new = (~on) & (post >= theta)
        loss += np.where(new, p.C, 0.0)
        t_on[new] = t + 1
        on |= new
    return dict(loss=loss, on=on, t_on=t_on)


def summarize_irr(p, d, r):
    G = d["G"]
    return dict(
        mean_loss=float(r["loss"].mean()),
        wrong_interventions=float(r["on"][~G].mean()),
        missed_threats=float((~r["on"][G]).mean()),
        mean_period_of_action_when_growing=float(np.mean(np.where(r["on"][G], r["t_on"][G], p.T + 1))))


def run_reversible(p: P, d, regime: str, th_on: float, th_off: float, mode: str):
    """mode: 'unmasked' (signals keep showing the threat while on),
    'masked, naive' (masked, agents update as if not), 'masked, aware' (masked,
    agents stop updating on masked signals), 'masked, aware + sentinel'."""
    R, T = p.reps, p.T
    G = d["G"]
    logit = np.full(R, np.log(p.prior / (1 - p.prior)))
    post = 1 / (1 + np.exp(-logit))
    on = post >= th_on
    loss = np.zeros(R)
    switches = on.astype(int)
    for t in range(T):
        loss += np.where(on, p.k, 0.0)
        loss += np.where(G & ~on, p.d0 * p.growth ** t, 0.0)
        if mode == "unmasked":
            mean = np.where(G, p.mu1, p.mu0)
            inc = llr_increment(p, regime, d, t, mean)
        else:
            mean = np.where(G & ~on, p.mu1, p.mu0)
            inc = llr_increment(p, regime, d, t, mean)
            if mode.startswith("masked, aware"):
                inc = np.where(on, 0.0, inc)
            if mode == "masked, aware + sentinel":
                s = np.where(G, p.mu1, p.mu0) + d["sentinel_noise"][:, t]
                inc = inc + np.where(on, s / p.sigma_s ** 2, 0.0)
        logit = logit + inc
        post = 1 / (1 + np.exp(-logit))
        new_on = np.where(on, post >= th_off, post >= th_on)
        switches += (new_on != on).astype(int)
        on = new_on
    return dict(loss=loss, switches=switches)


THETAS = [0.0] + [round(x, 2) for x in np.arange(0.05, 1.0, 0.05)] + [1.01]


def e8(p: P):
    tune, test = draw(p, 101), draw(p, 202)
    out = {"irreversible": {}, "reversible (signals not masked), running cost C/T": {},
           "reversible (signals not masked), running cost 2C/T": {}}
    for regime in ["solo", "pooled, provenance", "pooled, naive"]:
        best = min(THETAS, key=lambda th: run_irreversible(p, tune, regime, th)["loss"].mean())
        r = run_irreversible(p, test, regime, best)
        out["irreversible"][regime] = dict(best_threshold=best, **summarize_irr(p, test, r))
    # reference policies
    for name, th in [("act now on the prior, always", 0.0), ("never act", 1.01)]:
        r = run_irreversible(p, test, "solo", th)
        out["irreversible"][name] = dict(best_threshold=th, **summarize_irr(p, test, r))
    for label, kk in [("reversible (signals not masked), running cost C/T", p.C / p.T),
                      ("reversible (signals not masked), running cost 2C/T", 2 * p.C / p.T)]:
        pk = P(**{**asdict(p), "k": kk})
        for regime in ["solo", "pooled, provenance", "pooled, naive"]:
            grid = [(a, b) for a in THETAS[1:-1] for b in THETAS[1:-1] if b < a]
            best = min(grid, key=lambda ab: run_reversible(pk, tune, regime, ab[0], ab[1], "unmasked")["loss"].mean())
            r = run_reversible(pk, test, regime, best[0], best[1], "unmasked")
            out[label][regime] = dict(
                threshold_on=best[0], threshold_off=best[1], mean_loss=float(r["loss"].mean()),
                mean_switches=float(r["switches"].mean()))
    return out


def e9(p: P):
    tune, test = draw(p, 303), draw(p, 404)
    out = {"reversible, provenance-pooled evidence": {}, "irreversible: can the decision be checked afterwards?": {}}
    for mode in ["unmasked", "masked, naive", "masked, aware", "masked, aware + sentinel"]:
        grid = [(a, b) for a in THETAS[1:-1] for b in THETAS[1:-1] if b < a]
        best = min(grid, key=lambda ab: run_reversible(p, tune, "pooled, provenance", ab[0], ab[1], mode)["loss"].mean())
        r = run_reversible(p, test, "pooled, provenance", best[0], best[1], mode)
        out["reversible, provenance-pooled evidence"][mode] = dict(
            threshold_on=best[0], threshold_off=best[1], mean_loss=float(r["loss"].mean()),
            mean_switches=float(r["switches"].mean()))
    # after an irreversible intervention, can anyone later tell whether it was needed?
    best_irr = min(THETAS, key=lambda th: run_irreversible(p, tune, "pooled, provenance", th)["loss"].mean())
    r = run_irreversible(p, test, "pooled, provenance", best_irr)
    G, on, t_on = test["G"], r["on"], r["t_on"]
    # the main signals are masked after the intervention: only the sentinel can tell
    R, T = p.reps, p.T
    logit_s = np.zeros(R)
    for t in range(T):
        s = np.where(G, p.mu1, p.mu0) + test["sentinel_noise"][:, t]
        logit_s += np.where(on & (t >= t_on), s / p.sigma_s ** 2, 0.0)
    post_s = 1 / (1 + np.exp(-(np.log(p.prior / (1 - p.prior)) + logit_s)))
    decided = on & (t_on <= T - 6)
    out["irreversible: can the decision be checked afterwards?"] = dict(
        interventions_considered=int(decided.sum()),
        checkable_without_sentinel=0.0,
        checkable_with_sentinel_at_95pct=float(np.mean((post_s[decided] > 0.95) | (post_s[decided] < 0.05))),
        note="without an unmasked channel the signals after a successful intervention look the same whether "
             "it was needed or not, so no run can be checked")
    return out


def table(rows, keys):
    lines = ["| | " + " | ".join(keys) + " |", "|---|" + "---|" * len(keys)]
    for name, r in rows.items():
        cells = [f"{r[k]:.3f}" if isinstance(r.get(k), float) else str(r.get(k, "")) for k in keys]
        lines.append(f"| {name} | " + " | ".join(cells) + " |")
    return "\n".join(lines)


def main():
    p = P()
    res = {"parameters": asdict(p), "E8": e8(p), "E9": e9(p)}
    with open(os.path.join(RES, "results_time.json"), "w") as f:
        json.dump(res, f, indent=2)
    md = ["# Acting under time: simulation results (E8, E9)", "",
          "Generated by `sim_time.py` (seeded). Thresholds are tuned on one set of runs and evaluated on another. "
          "Loss is in the units of the damage and cost parameters; lower is better.", "",
          "## E8. The decision boundary", "", "### Irreversible intervention", "",
          table(res["E8"]["irreversible"], ["best_threshold", "mean_loss", "wrong_interventions", "missed_threats",
                                            "mean_period_of_action_when_growing"]), "",
          "### Reversible intervention (signals not masked); never lifting it costs the same as the irreversible one", "",
          table(res["E8"]["reversible (signals not masked), running cost C/T"], ["threshold_on", "threshold_off", "mean_loss", "mean_switches"]), "",
          "### Reversible intervention (signals not masked); running cost doubled", "",
          table(res["E8"]["reversible (signals not masked), running cost 2C/T"], ["threshold_on", "threshold_off", "mean_loss", "mean_switches"]), "",
          "## E9. Prevention hides the evidence", "", "### Reversible intervention, provenance-pooled evidence", "",
          table(res["E9"]["reversible, provenance-pooled evidence"], ["threshold_on", "threshold_off", "mean_loss", "mean_switches"]), "",
          "### After an irreversible intervention", "", json.dumps(res["E9"]["irreversible: can the decision be checked afterwards?"]), ""]
    with open(os.path.join(RES, "RESULTS_TIME.md"), "w") as f:
        f.write("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main()
