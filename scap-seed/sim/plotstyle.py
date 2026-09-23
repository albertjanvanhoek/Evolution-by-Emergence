"""Figure functions. Palette: validated reference categorical slots (light mode)."""
from __future__ import annotations

import math

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

SURFACE = "#fcfcfb"
INK = "#0b0b0b"
INK2 = "#52514e"
MUTED = "#8a8984"
GRID = "#e6e5e0"
S = ["#2a78d6", "#eb6834", "#1baf7a", "#eda100"]   # slots 1-4 (fixed order)
SEQ = ["#cde2fb", "#9ec5f4", "#6da7ec", "#3987e5", "#256abf", "#184f95", "#0d366b"]

plt.rcParams.update({
    "figure.facecolor": SURFACE, "axes.facecolor": SURFACE, "savefig.facecolor": SURFACE,
    "axes.edgecolor": MUTED, "axes.labelcolor": INK2, "text.color": INK,
    "xtick.color": INK2, "ytick.color": INK2, "axes.grid": True, "grid.color": GRID,
    "grid.linewidth": 0.8, "axes.spines.top": False, "axes.spines.right": False,
    "font.size": 10, "axes.titlesize": 11, "axes.titleweight": "bold",
    "axes.titlelocation": "left", "lines.linewidth": 2.0, "legend.frameon": False,
    "figure.dpi": 150,
})


def _save(fig, path, caption=None):
    if caption:
        fig.text(0.01, 0.005, caption, fontsize=8, color=INK2, ha="left", va="bottom", wrap=True)
    fig.tight_layout(rect=(0, 0.04 if caption else 0, 1, 1))
    fig.savefig(path)
    plt.close(fig)


def _pts(ax, x, y, ci, color, label):
    y = np.asarray(y)
    lo = y - np.array([c[0] for c in ci])
    hi = np.array([c[1] for c in ci]) - y
    lo, hi = np.clip(lo, 0, None), np.clip(hi, 0, None)
    ax.errorbar(x, y, yerr=[lo, hi], fmt="o", ms=6, color=color, mfc=color, mec=SURFACE,
                mew=1.5, elinewidth=1.2, capsize=0, label=label, zorder=3)


def fig_e1(out, path):
    fig, ax = plt.subplots(figsize=(6.4, 4.2))
    for i, (key, rows) in enumerate(out.items()):
        x = [r["Rc"] for r in rows]
        xx = np.linspace(0.5, 3.0, 200)
        n0 = int(key.split("=")[1])
        ax.plot(xx, [0 if v <= 1 else 1 - v ** (-n0) for v in xx], color=S[i], lw=2)
        _pts(ax, x, [r["sim"] for r in rows], [r["ci"] for r in rows], S[i], None)
        ax.annotate(f"start with {n0} item{'s' if n0 > 1 else ''}", (2.9, 1 - 2.9 ** (-n0)),
                    xytext=(-4, 8), textcoords="offset points", ha="right", color=INK2, fontsize=9)
    ax.axvline(1, color=MUTED, ls="--", lw=1)
    ax.text(1.03, 0.92, "R_c = 1", color=INK2, fontsize=9)
    ax.set_xlabel("cumulative reproduction number R_c")
    ax.set_ylabel("probability of runaway")
    ax.set_title("E1  Threshold: runaway iff R_c > 1")
    ax.text(0.52, 0.55, "points: simulation (95% CI)\nlines: 1 − R_c^(−n0)", color=INK2, fontsize=9)
    ax.set_ylim(-0.03, 1.03)
    _save(fig, path)


def fig_e2(rows, Ns, path):
    fig, ax = plt.subplots(figsize=(6.4, 4.2))
    x = [r["n0"] for r in rows]
    xx = np.arange(2, 31)
    ax.plot(x, [r["exact"] for r in rows], color=S[0], lw=2)
    _pts(ax, x, [r["sim"] for r in rows], [r["ci"] for r in rows], S[0], None)
    ax.axvline(Ns, color=MUTED, ls="--", lw=1)
    ax.text(Ns + 0.4, 0.05, f"critical mass N* = {Ns:.0f}", color=INK2, fontsize=9)
    ax.set_xlabel("initial retained repertoire n0")
    ax.set_ylabel("probability of runaway")
    ax.set_title("E2  Critical mass under pairwise composition (points: sim, line: exact)")
    ax.set_ylim(-0.03, 1.03)
    _save(fig, path)


def fig_e3(rows, traj1, traj2, ode1, ode2, Ns, tstar, path):
    fig, (a, b) = plt.subplots(1, 2, figsize=(10.5, 4.2))
    for tr in traj1:
        a.plot(tr.t, tr.n, color=S[0], lw=1, alpha=0.45)
    for tr in traj2:
        a.plot(tr.t, tr.n, color=S[1], lw=1, alpha=0.45)
    a.plot(ode1[0], ode1[1], color=S[0], lw=2.2)
    a.plot(ode2[0], ode2[1], color=S[1], lw=2.2)
    a.axvline(tstar, color=MUTED, ls=":", lw=1)
    a.text(tstar + 0.05, 30, f"blow-up t* = {tstar:.2f}", color=INK2, fontsize=9)
    a.set_yscale("log")
    a.set_xlim(0, 6)
    a.set_ylim(15, 2500)
    a.text(4.3, 700, "arity 1: exponential", color=S[0], fontsize=9, fontweight="bold")
    a.text(tstar + 0.05, 1200, "arity 2: hyperbolic", color=S[1], fontsize=9, fontweight="bold")
    a.set_xlabel("time (units of mean item lifetime)")
    a.set_ylabel("retained repertoire N (log)")
    a.set_title("E3a  Growth class set by arity (thin: sim, thick: ODE)")
    x = [r["n0"] for r in rows]
    xx = np.linspace(12.2, 100, 300)
    g = 0.1 + 1.0
    th = [math.log((1 - Ns / 2000) / (1 - Ns / v)) / g for v in xx]
    b.plot(xx, th, color=S[1], lw=2)
    b.errorbar(x, [r["sim_mean_time"] for r in rows], yerr=[r["sim_sd"] for r in rows], fmt="o",
               ms=6, color=S[1], mec=SURFACE, mew=1.5, elinewidth=1.2)
    b.set_xscale("log")
    b.set_xlabel("initial repertoire n0 (log)")
    b.set_ylabel("time to reach N = 2000")
    b.set_title("E3b  Time to runaway vs closed form")
    b.set_xticks([13, 20, 30, 50, 100]); b.set_xticklabels(["13", "20", "30", "50", "100"])
    b.minorticks_off()
    b.text(35, 1.3, "points: sim mean ± sd\nline: ln[(1−N*/N₁)/(1−N*/n₀)]/(a+δ)", color=INK2, fontsize=9)
    _save(fig, path)


def fig_e4(cases, Ns, brow, runaway, path):
    fig, (a, b, c) = plt.subplots(1, 3, figsize=(14, 4.2))
    for i, cs in enumerate(cases):
        tr = cs["traj"]
        t = np.append(tr.t, 20.0 if cs["outcome"] != "cap" else tr.t[-1])
        n = np.append(tr.n, tr.n[-1])
        a.step(t, n, where="post", color=S[i], lw=1.6)
        if math.isfinite(cs["cap"]):
            a.axhline(cs["cap"], color=S[i], ls="--", lw=1, alpha=0.7)
        lab_y = min(n[-1], 95) if cs["outcome"] != "cap" else 95
        a.text(t[-1] if cs["outcome"] != "cap" else t[-1] + 0.3, lab_y + 2, cs["label"], color=S[i],
               fontsize=9, fontweight="bold", ha="right" if cs["outcome"] != "cap" else "left")
    a.axhline(Ns, color=MUTED, ls=":", lw=1)
    a.text(0.4, Ns + 1.5, "N* = 11", color=INK2, fontsize=9)
    a.set_ylim(0, 100)
    a.set_xlim(0, 20)
    a.set_xlabel("time")
    a.set_ylabel("retained repertoire N")
    a.set_title("E4a  Mass-action, arity 2, with ledger")
    mus = [r["mu"] for r in brow]
    mm = np.linspace(0.15, 4.2, 200)
    from scipy.optimize import brentq

    def nhat(mu):
        return brentq(lambda n: 0.05 * (100 - mu * n) * (1 + 0.2 * n) - n, 1e-9, 100 / mu - 1e-9)
    b.plot(mm, [nhat(m) for m in mm], color=S[0], lw=2)
    b.plot(mm, 100 / mm, color=MUTED, ls="--", lw=1)
    b.text(0.9, 105, "ceiling B0/(μ−η)", color=INK2, fontsize=9)
    b.errorbar(mus, [r["sim_time_avg"] for r in brow], yerr=[r["sim_sd"] for r in brow], fmt="o",
               ms=6, color=S[0], mec=SURFACE, mew=1.5)
    b.text(1.6, 28, "plateau: P(N) = δN", color=S[0], fontsize=9, fontweight="bold")
    b.set_ylim(0, 130)
    b.set_xlabel("upkeep per retained item μ  (η = 0)")
    b.set_ylabel("stationary repertoire")
    b.set_title("E4b  Effort-limited search: interior plateau")
    for i, r in enumerate(runaway):
        tr = r["traj"]
        c.plot(tr.t, tr.n, color=S[i], lw=1.6)
        lbl = "η = μ: linear growth" if r["eta"] == r["mu"] else "η > μ: hyperbolic runaway"
        if i == 0:
            c.text(tr.t[-1] - 0.5, tr.n[-1] * 1.25, lbl, color=S[i], fontsize=9,
                   fontweight="bold", ha="right")
        else:
            c.text(tr.t[-1] + 1.0, 1500, lbl, color=S[i], fontsize=9, fontweight="bold", ha="left")
    c.set_yscale("log")
    c.set_xlabel("time")
    c.set_ylabel("retained repertoire N (log)")
    c.set_title("E4c  Self-financing retention (η ≥ μ)")
    _save(fig, path)


def fig_e5(Ks, Nstars, grid, exact, K50, path):
    from matplotlib.colors import LinearSegmentedColormap
    cmap = LinearSegmentedColormap.from_list("seq", SEQ)
    fig, ax = plt.subplots(figsize=(6.4, 5.0))
    im = ax.imshow(grid, origin="lower", cmap=cmap, vmin=0, vmax=1, aspect="auto",
                   extent=(Ks[0] - 2, Ks[-1] + 2, Nstars[0] - 2, Nstars[-1] + 2))
    lo, hi = Ks[0] - 2, Ks[-1] + 2
    ax.plot([lo, hi], [lo, hi], color=S[1], lw=2)
    ax.text(33, 38.5, "K = N*", color=S[1], fontsize=10, fontweight="bold", rotation=36)
    xs = [K50[int(n)] for n in Nstars if int(n) in K50 and K50[int(n)] <= hi]
    ys = [n for n in Nstars if int(n) in K50 and K50[int(n)] <= hi]
    ax.plot(xs, ys, color=INK, lw=1.5, ls="--")
    ax.text(xs[len(xs)//2] + 1, ys[len(ys)//2] - 4, "50% persistence\n(exact CTMC)", color=INK,
            fontsize=8.5)
    ax.text(31, 8, "persists", color=SURFACE, fontsize=11, fontweight="bold")
    ax.text(5, 34, "collapses", color=INK, fontsize=11, fontweight="bold")
    ax.grid(False)
    ax.set_xlim(lo, hi); ax.set_ylim(lo, hi)
    ax.set_xlabel("budget ceiling K = B0/(μ−η)")
    ax.set_ylabel("critical mass N*")
    ax.set_title("E5  Unaffordable critical mass ⇒ collapse")
    cb = fig.colorbar(im, ax=ax, shrink=0.85)
    cb.set_label("fraction persisting to T = 30 (sim, start at K)", color=INK2)
    cb.outline.set_visible(False)
    _save(fig, path)


def fig_e6(trajs, path):
    fig, ax = plt.subplots(figsize=(8.0, 4.2))
    ax.axvspan(20, 30, color=GRID, alpha=0.8, lw=0)
    ax.text(25, 44, "budget shock", ha="center", color=INK2, fontsize=9)
    for i, (label, tr) in enumerate(trajs):
        t = np.append(tr.t, 80.0)
        n = np.append(tr.n, tr.n[-1])
        ax.step(t, n, where="post", color=S[i], lw=1.6, label=label)
    ax.axhline(11, color=MUTED, ls=":", lw=1)
    ax.text(0.5, 12, "N* = 11", color=INK2, fontsize=9)
    ax.legend(loc="center right", bbox_to_anchor=(1.0, 0.52), fontsize=9, labelcolor=INK2)
    ax.set_xlim(0, 80)
    ax.set_ylim(0, 48)
    ax.set_xlabel("time")
    ax.set_ylabel("retained repertoire N")
    ax.set_title("E6  Hysteresis: a transient ceiling below N* destroys the repertoire")
    _save(fig, path)


def fig_e7(rows, cstar, path):
    fig, ax = plt.subplots(figsize=(6.4, 4.2))
    x = [r["c"] for r in rows]
    ax.plot(x, [r["exact"] for r in rows], color=S[0], lw=2)
    _pts(ax, x, [r["sim"] for r in rows], [r["ci"] for r in rows], S[0], None)
    ax.axvline(cstar, color=MUTED, ls="--", lw=1)
    ax.text(cstar + 0.01, 0.8, f"c* = √((1−k11)(1−k22)) = {cstar:.2f}", color=INK2, fontsize=9)
    ax.set_xlabel("cross-layer coupling c = k12 = k21   (k11 = k22 = 0.6, each layer subcritical)")
    ax.set_ylabel("probability of runaway")
    ax.set_title("E7  Nested layers: jointly supercritical iff ρ(K) > 1")
    ax.set_ylim(-0.03, 1.03)
    _save(fig, path)


def fig_e8(rows, q, path):
    fig, ax = plt.subplots(figsize=(6.4, 4.2))
    k = [r["k"] for r in rows]
    ax.plot(k, [r["unscaffolded_expected"] for r in rows], color=S[1], lw=2)
    ks = [r["k"] for r in rows if "unscaffolded_sim" in r]
    ax.plot(ks, [r["unscaffolded_sim"] for r in rows if "unscaffolded_sim" in r], "o", color=S[1],
            ms=6, mec=SURFACE, mew=1.5)
    ax.plot(k, [r["scaffolded_exact"] for r in rows], color=S[0], lw=2)
    ax.plot(k, [r["scaffolded_sim"] for r in rows], "o", color=S[0], ms=6, mec=SURFACE, mew=1.5)
    ax.plot(k, [r["sequential_bound"] for r in rows], color=S[2], lw=1.5, ls="--")
    ax.set_yscale("log")
    ax.text(4.3, 4 ** 7, "no retained parts: q^k", color=S[1], fontsize=9, fontweight="bold")
    ax.text(6.0, 3.0, "retained, evaluable parts", color=S[0], fontsize=9, fontweight="bold")
    ax.text(7.5, 46, "sequential bound k·q (Lean)", color=S[2], fontsize=9, fontweight="bold")
    ax.set_xlabel(f"arity k of the emergent target (q = {q} options per part)")
    ax.set_ylabel("expected trials (log)")
    ax.set_title("E8  Scaffold law: exponential vs (sub)linear assembly")
    _save(fig, path)
