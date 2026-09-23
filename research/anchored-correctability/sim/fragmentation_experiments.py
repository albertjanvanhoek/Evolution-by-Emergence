"""Experiments F1-F5 for Layer 6 (persistence, shared reality, repair).

Run:  python fragmentation_experiments.py        (about 2 minutes)
      python fragmentation_experiments.py --quick

Writes results/fragmentation.json and figures/F1..F5*.png.
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

import numpy as np

from fragmentation import Params, World, run, er_giant
import plotstyle as ps
import matplotlib.pyplot as plt

QUICK = "--quick" in sys.argv
HERE = Path(__file__).parent
FIG = HERE / "figures"
RES = HERE / "results"
FIG.mkdir(exist_ok=True)
RES.mkdir(exist_ok=True)
SEEDS = 2 if QUICK else 4


def tail_mean(series, key, n=20):
    xs = [s[key] for s in series[-n:]]
    return float(np.mean(xs))


def ci(xs):
    xs = np.asarray(xs, dtype=float)
    if len(xs) < 2:
        return (float(xs.mean()), float(xs.mean()))
    h = 1.96 * xs.std(ddof=1) / np.sqrt(len(xs))
    return (float(xs.mean() - h), float(xs.mean() + h))


# ---------------------------------------------------------------------------
# F1: the forgiveness threshold (percolation of repaired links)
# ---------------------------------------------------------------------------
def F1():
    k, p = 6.0, 0.05
    rs = np.linspace(0.0, 0.12, 7 if QUICK else 13)
    rows = []
    for r in rs:
        S, K = [], []
        for s in range(SEEDS):
            P = Params(G=1, k_in=k, p=p, r=float(r), q=0.02, eps=0.1, T=300 if QUICK else 500, seed=s)
            _, ser = run(P)
            S.append(tail_mean(ser, "S")); K.append(tail_mean(ser, "know"))
        c = k * r / (p + r)
        rows.append(dict(r=float(r), c=float(c), pi=float(r / (p + r)), S=float(np.mean(S)), S_ci=ci(S),
                         know=float(np.mean(K)), know_ci=ci(K), S_theory=er_giant(c)))
    fig, ax = plt.subplots(1, 2, figsize=(9.5, 3.6))
    cs = [x["c"] for x in rows]
    cc = np.linspace(0, max(cs), 200)
    ax[0].plot(cc, [er_giant(c) for c in cc], color=ps.MUTED, lw=1.5, label="random-graph theory")
    ax[0].errorbar(cs, [x["S"] for x in rows],
                   yerr=[[x["S"] - x["S_ci"][0] for x in rows], [x["S_ci"][1] - x["S"] for x in rows]],
                   fmt="o", color=ps.S[0], label="simulation")
    ax[0].axvline(1.0, color=ps.S[1], lw=1, ls="--")
    ax[0].text(1.05, 0.05, "k·r/(p+r) = 1", color=ps.S[1], fontsize=8)
    ax[0].set_xlabel("active links per member, k·r/(p+r)")
    ax[0].set_ylabel("share in the largest collaboration")
    ax[0].set_title("A. Forgiveness threshold")
    ax[0].legend(loc="lower right")
    ax[1].errorbar(cs, [x["know"] for x in rows],
                   yerr=[[x["know"] - x["know_ci"][0] for x in rows], [x["know_ci"][1] - x["know"] for x in rows]],
                   fmt="o-", color=ps.S[2])
    ax[1].axvline(1.0, color=ps.S[1], lw=1, ls="--")
    ax[1].set_xlabel("active links per member, k·r/(p+r)")
    ax[1].set_ylabel("usable knowledge (sharp and in step)")
    ax[1].set_title("B. Shared reality pays")
    ps._save(fig, FIG / "F1_forgiveness_threshold.png")
    return rows


# ---------------------------------------------------------------------------
# F2: tipping and hysteresis when disagreement erodes links
# ---------------------------------------------------------------------------
def F2():
    rs = list(np.linspace(0, 1, 6 if QUICK else 11))
    steps = 300 if QUICK else 500
    up_a, dn_a, up_d, dn_d = [], [], [], []
    for s in range(max(2, SEEDS - 1)):
        P = Params(G=2, k_in=6, k_out=3, bias_rate=0.6, p=0.005, beta=4, gamma=16,
                   fb_cross_only=True, r=0.0, T=0, seed=s)
        w = World(P)
        ua, ud = [], []
        for r in rs:
            w.narr[:] = r
            _, ser = run(P, world=w, T=steps)
            ua.append(tail_mean(ser, "cross_active", 15)); ud.append(tail_mean(ser, "cross_dis", 15))
        da, dd = [], []
        for r in rs[::-1]:
            w.narr[:] = r
            _, ser = run(P, world=w, T=steps)
            da.append(tail_mean(ser, "cross_active", 15)); dd.append(tail_mean(ser, "cross_dis", 15))
        up_a.append(ua); dn_a.append(da[::-1]); up_d.append(ud); dn_d.append(dd[::-1])
    up_a, dn_a, up_d, dn_d = map(lambda a: np.mean(a, axis=0), (up_a, dn_a, up_d, dn_d))
    fig, ax = plt.subplots(1, 2, figsize=(9.5, 3.6))
    ax[0].plot(rs, up_a, "o-", color=ps.S[0], label="repair rising (starting split)")
    ax[0].plot(rs, dn_a, "s--", color=ps.S[1], label="repair falling (starting connected)")
    ax[0].set_xlabel("repair rate of the narrative, r")
    ax[0].set_ylabel("share of links between groups alive")
    ax[0].set_title("A. Tipping and hysteresis")
    ax[0].legend(loc="lower right")
    ax[1].plot(rs, up_d, "o-", color=ps.S[0], label="repair rising")
    ax[1].plot(rs, dn_d, "s--", color=ps.S[1], label="repair falling")
    ax[1].set_xlabel("repair rate of the narrative, r")
    ax[1].set_ylabel("pairs across groups with separate realities")
    ax[1].set_title("B. Separate realities")
    ax[1].legend(loc="upper right")
    ps._save(fig, FIG / "F2_tipping_hysteresis.png")
    return dict(r=[float(x) for x in rs], up_active=up_a.tolist(), down_active=dn_a.tolist(),
                up_disjoint=up_d.tolist(), down_disjoint=dn_d.tolist())


# ---------------------------------------------------------------------------
# F3: the learning law (rigid, drifting, sealed, vacuous, learning)
# ---------------------------------------------------------------------------
def F3():
    kinds = ["learner", "rigid", "drifter", "sealed", "vacuous"]
    T = 800 if QUICK else 2000
    per = 60
    traces = {k: {"instep": [], "know": []} for k in kinds}
    ts = None
    for s in range(SEEDS):
        P = Params(N=per * len(kinds), G=1, k_in=0.0, q=0.05, eps=0.05, lam=0.05, T=T, seed=s)
        kd = [k for k in kinds for _ in range(per)]
        _, ser = run(P, kinds=kd, every=20)
        ts = [x["t"] for x in ser]
        for k in kinds:
            traces[k]["instep"].append([x["kind_instep"][k] for x in ser])
            traces[k]["know"].append([x["kind_know"][k] for x in ser])
    labels = {"learner": "learns (open + evidence)", "rigid": "rigid (stops learning)",
              "drifter": "drifts (changes, not listening)", "sealed": "sealed tradition",
              "vacuous": "says nothing"}
    colors = {"learner": ps.S[2], "rigid": ps.S[1], "drifter": ps.S[3], "sealed": ps.S[0], "vacuous": ps.MUTED}
    fig, ax = plt.subplots(1, 2, figsize=(9.5, 3.6))
    out = {}
    for k in kinds:
        ins = np.mean(traces[k]["instep"], axis=0)
        kn = np.mean(traces[k]["know"], axis=0)
        ax[0].plot(ts, ins, color=colors[k], label=labels[k])
        ax[1].plot(ts, kn, color=colors[k], label=labels[k])
        out[k] = dict(final_instep=float(np.mean(ins[-10:])), final_know=float(np.mean(kn[-10:])))
    ax[0].set_xlabel("time"); ax[0].set_ylabel("share in step with the world")
    ax[0].set_title("A. In step with a changing world")
    ax[1].set_xlabel("time"); ax[1].set_ylabel("usable knowledge")
    ax[1].set_title("B. Knowing something useful")
    h, l = ax[0].get_legend_handles_labels()
    fig.legend(h, l, loc="lower center", ncol=5, fontsize=7.5, frameon=False)
    fig.tight_layout(rect=(0, 0.08, 1, 1))
    fig.savefig(FIG / "F3_learning_law.png")
    plt.close(fig)
    return out


# ---------------------------------------------------------------------------
# F4: second-order selection of narratives (repair) with a cost
# ---------------------------------------------------------------------------
def F4():
    kappas = [0.0, 1.0, 4.0]
    gens = 20 if QUICK else 60
    gen_len = 50
    res = {}
    fig, ax = plt.subplots(1, 2, figsize=(9.5, 3.6))
    for ci_, kappa in enumerate(kappas):
        hs, shock = [], []
        for s in range(max(2, SEEDS - 1)):
            rng = np.random.default_rng(100 + s)
            G = 10
            narr = rng.uniform(0, 0.3, G)
            P = Params(N=300, G=G, k_in=6, k_out=2, bias_rate=0.5, bias_size=2, p=0.05,
                       r=0.0, T=0, seed=s)
            w = World(P, narratives=narr)
            h = [float(narr.mean())]
            for g in range(gens):
                acc = np.zeros(G); n = 0
                for st in range(gen_len):
                    w.step()
                    if st % 10 == 9:
                        acc += np.array(w.measure()["group_know"]); n += 1
                fit = acc / n - kappa * w.narr
                worst, best = int(np.argmin(fit)), int(np.argmax(fit))
                w.narr[worst] = float(np.clip(w.narr[best] + rng.normal(0, 0.02), 0, 1))
                h.append(float(w.narr.mean()))
            hs.append(h)
            # robustness: a shock doubles the break rate
            _, before = run(P, world=w, T=200)
            P.p = 0.10
            _, after = run(P, world=w, T=300)
            shock.append((tail_mean(before, "S", 10), tail_mean(after, "S", 10),
                          tail_mean(before, "know", 10), tail_mean(after, "know", 10)))
        hm = np.mean(hs, axis=0)
        ax[0].plot(range(len(hm)), hm, color=ps.S[ci_], label=f"repair cost κ = {kappa:g}")
        sh = np.mean(shock, axis=0)
        res[str(kappa)] = dict(r_start=float(hm[0]), r_end=float(np.mean(hm[-5:])),
                               S_before=float(sh[0]), S_after_shock=float(sh[1]),
                               know_before=float(sh[2]), know_after_shock=float(sh[3]))
    ax[0].axhline(0.05 / 5, color=ps.MUTED, lw=1, ls=":")
    ax[0].set_ylim(bottom=-0.01)
    ax[0].text(gens * 0.40, 0.002, "threshold inside a group, k·π = 1", color=ps.MUTED, fontsize=7.5)
    ax[0].set_xlabel("generation"); ax[0].set_ylabel("mean repair rate of narratives")
    ax[0].set_title("A. Selection of repair narratives")
    ax[0].legend(loc="center right")
    x = np.arange(len(kappas))
    ax[1].bar(x - 0.18, [res[str(k)]["S_before"] for k in kappas], 0.36, color=ps.S[0], label="before shock")
    ax[1].bar(x + 0.18, [res[str(k)]["S_after_shock"] for k in kappas], 0.36, color=ps.S[1], label="break rate doubled")
    ax[1].set_xticks(x); ax[1].set_xticklabels([f"κ = {k:g}" for k in kappas])
    ax[1].set_ylabel("share in the largest collaboration")
    ax[1].set_title("B. Robustness of the evolved narrative")
    ax[1].legend(loc="lower left")
    ps._save(fig, FIG / "F4_narrative_selection.png")
    return res


# ---------------------------------------------------------------------------
# F5: links through time (inheritance) and links across people
# ---------------------------------------------------------------------------
def F5():
    fids = [0.0, 0.25, 0.5, 0.75, 1.0]
    out = {"fidelity": fids, "connected": [], "isolated": []}
    for label, k in (("connected", 6.0), ("isolated", 0.0)):
        for f in fids:
            K = []
            for s in range(SEEDS):
                P = Params(G=1, k_in=k, r=0.2, q=0.02, eps=0.05, death=0.02, fidelity=f,
                           T=300 if QUICK else 600, seed=s)
                _, ser = run(P)
                K.append(tail_mean(ser, "know"))
            out[label].append(float(np.mean(K)))
    fig, ax = plt.subplots(figsize=(5.2, 3.6))
    ax.plot(fids, out["connected"], "o-", color=ps.S[0], label="linked to others")
    ax.plot(fids, out["isolated"], "s--", color=ps.S[1], label="alone")
    ax.set_xlabel("inheritance fidelity (link to the previous generation)")
    ax.set_ylabel("usable knowledge")
    ax.set_title("Links through time and across people")
    ax.legend(loc="lower right")
    ps._save(fig, FIG / "F5_succession.png")
    return out


def main():
    t0 = time.time()
    results = {}
    only = [a for a in sys.argv[1:] if a.startswith("F")]
    prev = json.loads((RES / "fragmentation.json").read_text()) if only and (RES / "fragmentation.json").exists() else {}
    results.update(prev)
    for name, fn in (("F1", F1), ("F2", F2), ("F3", F3), ("F4", F4), ("F5", F5)):
        if only and name not in only:
            continue
        t = time.time()
        results[name] = fn()
        print(f"{name} done in {time.time() - t:.0f}s", flush=True)
    results["meta"] = dict(quick=QUICK, seeds=SEEDS, seconds=time.time() - t0)
    (RES / "fragmentation.json").write_text(json.dumps(results, indent=1))
    print(json.dumps({k: v for k, v in results.items() if k != "F2"}, indent=1)[:4000])


if __name__ == "__main__":
    main()
