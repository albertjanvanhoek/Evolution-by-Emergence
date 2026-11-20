"""Experiments for research/ten-verbs-hypothesis (seeded; about 15 minutes on 2 cores).

E1  Parameter recovery. 100 agents per condition with verb settings drawn at
    random; fit back from what an experimenter records; correlation between
    true and recovered settings, per verb, condition and belief-report regime.
E2  Confusion. Pooled over conditions: does a recovered setting of one verb
    track the true setting of another? (Trade-offs show up here.)
E3  Model recovery. Data from the full model, from a model without Notice
    (notice fixed at 1) and from a model without Stay open (stay_open fixed
    at 1); each fitted with all three; which one BIC picks.
E4  Knockout matrix. All learners in a group have one verb impaired; change in
    accuracy (mean belief in the true state, rounds 20-59) against intact
    groups, per condition and per route. An architecture check only: the
    model was built with these verbs, so this shows what this model does,
    not what learners do.

Usage: python run.py                  (writes results/ and figures/)
       python run.py --figures-only   (redraws figures from results.json)
"""

from __future__ import annotations

import json
import os
import sys
from multiprocessing import Pool

import numpy as np

sys.path.insert(0, os.path.dirname(__file__))
from model import (CONDITIONS, JOINT, LABELS, N, VERBS, agent_record,   # noqa: E402
                   draw_params, simulate, test_table)
from fit import fit_agent, fit_joint                                     # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, "results")
FIG = os.path.join(HERE, "figures")
GROUPS_E1 = 20          # x N = 100 agents per condition
GROUPS_E3 = 8           # x N = 40 agents per generating model
REPS_E4 = 400
SEED = 2026
REGIMES = ["rich", "sparse"]
CLOSED = ["take_care", "share", "repair", "find_new_ways"]


# ------------------------------------------------------------------ E1, E2

def _fit_task(args):
    a, blind, regime, seed = args
    rng = np.random.default_rng(seed)
    return fit_agent(a, test_table(blind), regime, rng)


def e1_recovery(pool):
    out = {}
    for ci, (cname, cond) in enumerate(CONDITIONS.items()):
        rng = np.random.default_rng(SEED + ci)
        pr = draw_params(rng, (GROUPS_E1, N))
        rec = simulate(pr, cond, rng)
        agents = [(r, n) for r in range(GROUPS_E1) for n in range(N)]
        true = {v: [float(pr[v][r, n]) for r, n in agents] for v in VERBS}
        out[cname] = {"true": true}
        for regime in REGIMES:
            tasks = [(agent_record(rec, r, n), cond["blind"], regime,
                      SEED * 1000 + ci * 100 + k)
                     for k, (r, n) in enumerate(agents)]
            fits = pool.map(_fit_task, tasks)
            out[cname][regime] = {v: [float(f[v]) for f in fits] for v in VERBS}
            print(f"E1 {cname:12s} {regime:6s} done", flush=True)
    return out


def _corr(x, y):
    x, y = np.asarray(x, float), np.asarray(y, float)
    ok = ~np.isnan(y)
    if ok.sum() < 5 or np.std(y[ok]) == 0:
        return float("nan"), int(ok.sum())
    return float(np.corrcoef(x[ok], y[ok])[0, 1]), int(ok.sum())


def summarise_e1(e1):
    table = {}
    for cname, d in e1.items():
        for regime in REGIMES:
            for v in VERBS:
                r, n = _corr(d["true"][v], d[regime][v])
                table[f"{cname}|{regime}|{v}"] = {"r": r, "n": n}
    conf = {}
    for regime in REGIMES:
        T_ = {v: np.concatenate([e1[c]["true"][v] for c in e1]) for v in JOINT}
        F_ = {v: np.concatenate([e1[c][regime][v] for c in e1]) for v in JOINT}
        conf[regime] = [[float(np.corrcoef(T_[vt], F_[vf])[0, 1]) for vt in JOINT]
                        for vf in JOINT]
    return table, conf


# ------------------------------------------------------------------ E3

MODELS = {"full": {}, "no_notice": {JOINT.index("notice"): 1.0},
          "no_open": {JOINT.index("stay_open"): 1.0}}


def _model_task(args):
    a, regime, seed = args
    rng = np.random.default_rng(seed)
    P = test_table(False)
    n_obs = 60 + int(a["tested"].sum()) + int(a["shared"].sum())
    bic = {}
    for m, fixed in MODELS.items():
        _, ll, k = fit_joint(a, P, regime, rng, fixed=fixed)
        bic[m] = -2 * ll + k * np.log(n_obs)
    return bic


def e3_model_recovery(pool):
    out = {}
    for gi, (gen, fixed) in enumerate(MODELS.items()):
        rng = np.random.default_rng(SEED + 50 + gi)
        pr = draw_params(rng, (GROUPS_E3, N))
        for i, val in fixed.items():
            pr[JOINT[i]][:] = val
        rec = simulate(pr, CONDITIONS["base"], rng)
        out[gen] = {}
        for regime in REGIMES:
            tasks = [(agent_record(rec, r, n), regime, SEED * 7 + gi * 1000 + r * N + n)
                     for r in range(GROUPS_E3) for n in range(N)]
            bics = pool.map(_model_task, tasks)
            picks = [min(b, key=b.get) for b in bics]
            out[gen][regime] = {m: picks.count(m) for m in MODELS}
            print(f"E3 gen={gen:9s} {regime:6s} {out[gen][regime]}", flush=True)
    return out


# ------------------------------------------------------------------ E4

INTACT = {"stay_open": 0.7, "try": 0.8, "notice": 0.8, "be_honest": 0.95,
          "change": 0.8, "let_go": 0.03, "take_care": 0.9, "share": 0.7,
          "repair": 0.5, "find_new_ways": 0.15}
KNOCKOUTS = [("Stay open", "stay_open", 0.0), ("Try", "try", 0.0),
             ("Notice", "notice", 0.0), ("Be honest", "be_honest", 0.0),
             ("Change", "change", 0.05),
             ("Remember only (no letting go)", "let_go", 0.0),
             ("Let go too fast", "let_go", 0.3),
             ("Take care", "take_care", 0.0), ("Share", "share", 0.0),
             ("Repair", "repair", 0.0), ("Find new ways", "find_new_ways", 0.0)]
COLUMNS = [("base", "base", {}), ("volatile", "volatile", {}),
           ("scarce", "scarce", {}), ("blind", "blind", {}),
           ("disrupted", "disrupted", {}), ("adversarial", "adversarial", {}),
           ("reality route only", "base", {"isolate0": True}),
           ("commons route only", "base", {"no_budget0": True})]


def _acc(params, cname, kw, seed):
    rng = np.random.default_rng(seed)
    rec = simulate(params, CONDITIONS[cname], rng, **kw)
    acc = rec["acc"][:, :, 20:].mean(-1)           # (R, N)
    per_rep = acc[:, 0] if kw else acc.mean(1)      # route columns: agent 0
    return per_rep


def e4_knockouts():
    def params(over=None):
        p = {v: np.full((REPS_E4, N), INTACT[v]) for v in VERBS}
        if over:
            p[over[0]][:] = over[1]
        return p
    out = {"columns": [c[0] for c in COLUMNS], "rows": [k[0] for k in KNOCKOUTS],
           "intact": [], "diff": [], "se": []}
    for ci, (col, cname, kw) in enumerate(COLUMNS):
        seed = SEED + 900 + ci                      # common random numbers per column
        base = _acc(params(), cname, kw, seed)
        out["intact"].append(float(base.mean()))
    for label, verb, val in KNOCKOUTS:
        drow, srow = [], []
        for ci, (col, cname, kw) in enumerate(COLUMNS):
            seed = SEED + 900 + ci
            base = _acc(params(), cname, kw, seed)
            ko = _acc(params((verb, val)), cname, kw, seed)
            d = ko - base
            drow.append(float(d.mean()))
            srow.append(float(d.std(ddof=1) / np.sqrt(len(d))))
        out["diff"].append(drow)
        out["se"].append(srow)
        print(f"E4 {label} done", flush=True)
    return out


# ------------------------------------------------------------------ output

def write_tables(table, conf, e3, e4):
    L = ["# Generated tables (do not edit by hand; produced by run.py)", ""]
    L.append("## E1. Recovery: correlation between true and recovered settings")
    L.append("")
    L.append("n = agents with an estimate (of 100). '-' = no information in this condition.")
    for regime in REGIMES:
        L += ["", f"### Belief reports: {regime}", "",
              "| Verb | " + " | ".join(CONDITIONS) + " |",
              "|---|" + "---|" * len(CONDITIONS)]
        for v in VERBS:
            cells = []
            for c in CONDITIONS:
                e = table[f"{c}|{regime}|{v}"]
                cells.append("-" if np.isnan(e["r"]) else
                             f"{e['r']:.2f}" + ("" if e["n"] == 100 else f" (n={e['n']})"))
            L.append(f"| {LABELS[v]} | " + " | ".join(cells) + " |")
    L += ["", "## E2. Confusion (pooled over conditions)", "",
          "Rows: recovered setting. Columns: true setting. Pearson r.", ""]
    for regime in REGIMES:
        L += [f"### {regime}", "", "| recovered \\ true | " +
              " | ".join(LABELS[v] for v in JOINT) + " |",
              "|---|" + "---|" * len(JOINT)]
        for i, v in enumerate(JOINT):
            L.append(f"| {LABELS[v]} | " + " | ".join(f"{x:.2f}" for x in conf[regime][i]) + " |")
        L.append("")
    L += ["## E3. Model recovery (BIC picks, 40 agents per generating model, base condition)", "",
          "| generated by | regime | picked full | picked no-Notice | picked no-Stay-open |",
          "|---|---|---|---|---|"]
    for g in MODELS:
        for regime in REGIMES:
            d = e3[g][regime]
            L.append(f"| {g} | {regime} | {d['full']} | {d['no_notice']} | {d['no_open']} |")
    L += ["", "## E4. Knockouts: change in accuracy (percentage points), with standard error", "",
          f"{REPS_E4} groups per cell. Accuracy = mean belief in the true state, rounds 20-59.",
          "Route columns use agent 0 only.", "",
          "| Impaired | " + " | ".join(e4["columns"]) + " |",
          "|---|" + "---|" * len(e4["columns"]),
          "| *(intact accuracy)* | " + " | ".join(f"{100*x:.1f}" for x in e4["intact"]) + " |"]
    for i, row in enumerate(e4["rows"]):
        L.append(f"| {row} | " + " | ".join(
            f"{100*d:+.1f} ({100*s:.1f})" for d, s in zip(e4["diff"][i], e4["se"][i])) + " |")
    with open(os.path.join(RES, "tables.md"), "w") as f:
        f.write("\n".join(L) + "\n")


def figures(table, conf, e4):
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.colors import LinearSegmentedColormap

    seq = LinearSegmentedColormap.from_list(
        "seq", ["#fcfcfb", "#cde2fb", "#86b6ef", "#3987e5", "#1c5cab", "#0d366b"])
    div = LinearSegmentedColormap.from_list("div", ["#e34948", "#f0efec", "#256abf"])
    ink = "#2b2b29"

    # Figure 1: recovery heatmaps, rich and sparse side by side.
    fig, axes = plt.subplots(1, 2, figsize=(13, 5.2), sharey=True)
    conds = list(CONDITIONS)
    for ax, regime in zip(axes, REGIMES):
        M = np.array([[table[f"{c}|{regime}|{v}"]["r"] for c in conds] for v in VERBS])
        Mp = np.where(np.isnan(M), 0, np.clip(M, 0, 1))
        ax.imshow(Mp, cmap=seq, vmin=0, vmax=1, aspect="auto")
        for i in range(len(VERBS)):
            for j in range(len(conds)):
                txt = "—" if np.isnan(M[i, j]) else f"{M[i, j]:.2f}"
                ax.text(j, i, txt, ha="center", va="center", fontsize=8.5,
                        color="white" if Mp[i, j] > 0.6 else ink)
        ax.set_xticks(range(len(conds)), [c.replace("_", " ") for c in conds],
                      rotation=30, ha="right", fontsize=9)
        ax.set_yticks(range(len(VERBS)), [LABELS[v] for v in VERBS], fontsize=9)
        ax.set_title(f"Belief reports: {regime}", fontsize=11, color=ink, loc="left")
        for s in ax.spines.values():
            s.set_visible(False)
    fig.suptitle("Parameter recovery: correlation between true and recovered verb "
                 "settings (100 agents per cell; — = no information)",
                 fontsize=11.5, color=ink, x=0.02, ha="left")
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e1_recovery.png"), dpi=150)
    plt.close(fig)

    # Figure 2: confusion matrices.
    fig, axes = plt.subplots(1, 2, figsize=(11, 4.6))
    lab = [LABELS[v].replace("Remember / let go", "Let go") for v in JOINT]
    for ax, regime in zip(axes, REGIMES):
        C = np.array(conf[regime])
        ax.imshow(C, cmap=div, vmin=-1, vmax=1)
        for i in range(len(JOINT)):
            for j in range(len(JOINT)):
                ax.text(j, i, f"{C[i, j]:.2f}", ha="center", va="center", fontsize=8.5,
                        color="white" if abs(C[i, j]) > 0.6 else ink)
        ax.set_xticks(range(len(JOINT)), lab, rotation=30, ha="right", fontsize=9)
        ax.set_yticks(range(len(JOINT)), lab, fontsize=9)
        ax.set_xlabel("true setting", fontsize=9, color=ink)
        ax.set_ylabel("recovered setting", fontsize=9, color=ink)
        ax.set_title(f"Belief reports: {regime}", fontsize=11, color=ink, loc="left")
        for s in ax.spines.values():
            s.set_visible(False)
    fig.suptitle("Confusion: does a recovered verb track the true setting of another? "
                 "(pooled over 7 conditions, 700 agents)", fontsize=11.5, color=ink,
                 x=0.02, ha="left")
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e2_confusion.png"), dpi=150)
    plt.close(fig)

    # Figure 3: knockout matrix.
    D = 100 * np.array(e4["diff"])
    S = 100 * np.array(e4["se"])
    lim = np.abs(D).max()
    fig, ax = plt.subplots(figsize=(12, 6))
    ax.imshow(D, cmap=div, vmin=-lim, vmax=lim, aspect="auto")
    for i in range(D.shape[0]):
        for j in range(D.shape[1]):
            weak = abs(D[i, j]) <= 3 * S[i, j]
            txt = "·" if weak else f"{D[i, j]:+.1f}"
            ax.text(j, i, txt, ha="center", va="center", fontsize=9,
                    color="white" if abs(D[i, j]) > 0.6 * lim else ink)
    ax.set_xticks(range(len(e4["columns"])), e4["columns"], rotation=25, ha="right", fontsize=9)
    ax.set_yticks(range(len(e4["rows"])), e4["rows"], fontsize=9)
    for s in ax.spines.values():
        s.set_visible(False)
    ax.set_title("Knockouts in this model: change in accuracy, percentage points "
                 "(red = worse, blue = better; · = within 3 SE of zero)",
                 fontsize=11, color=ink, loc="left")
    fig.tight_layout()
    fig.savefig(os.path.join(FIG, "e4_knockouts.png"), dpi=150)
    plt.close(fig)


def main():
    if "--figures-only" in sys.argv:
        with open(os.path.join(RES, "results.json")) as f:
            d = json.load(f)
        figures(d["e1_table"], d["e2_confusion"], d["e4_knockouts"])
        return
    os.makedirs(RES, exist_ok=True)
    os.makedirs(FIG, exist_ok=True)
    with Pool(os.cpu_count() or 1) as pool:
        e1 = e1_recovery(pool)
        e3 = e3_model_recovery(pool)
    e4 = e4_knockouts()
    table, conf = summarise_e1(e1)
    with open(os.path.join(RES, "results.json"), "w") as f:
        json.dump({"e1_raw": e1, "e1_table": table, "e2_confusion": conf,
                   "e3_model_recovery": e3, "e4_knockouts": e4}, f)
    write_tables(table, conf, e3, e4)
    figures(table, conf, e4)
    print("written:", RES, FIG)


if __name__ == "__main__":
    main()
