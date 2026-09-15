#!/usr/bin/env python3
"""Figure: the speed limit is tight, and depth is capped by two factors at once.

(a) achieved / bound against drive asymmetry eps.  Analytic curves for the SFS
    and Zhang forms, with measured points from a depth-2 shuttle and a depth-6
    interior ring -- which land on the same curve.  Saturation is asymptotic.
(b) the two-factor bound on packing depth for a 12-state interior ring, whose
    own repertoire X is its 12 configurations: the
    thermodynamic factor grows with the budget, the geometric factor does not,
    and the achieved depth tracks whichever is smaller.

All measured points come from simulate.py, not from the closed forms.
House style follows the manuscript's own make_figures.py.
"""
from __future__ import annotations
from pathlib import Path
import matplotlib as mpl
mpl.use("Agg")
import numpy as np                      # noqa: E402
import matplotlib.pyplot as plt         # noqa: E402
from simulate import shuttle, ring      # noqa: E402

TEXTWIDTH_IN = 15.8 / 2.54
C_1, C_2, C_3, C_W = "#0173B2", "#DE8F05", "#029E73", "#CC3311"
C_RULE, C_SHADE = "#4D4D4D", "#E6E6E6"
mpl.rcParams.update({
    "font.family": "serif",
    "font.serif": ["cmr10", "Computer Modern Roman", "DejaVu Serif"],
    "mathtext.fontset": "cm", "axes.unicode_minus": False,
    "axes.formatter.use_mathtext": True,
    "font.size": 9, "text.color": "#1A1A1A",
    "axes.edgecolor": "#4D4D4D", "axes.linewidth": 0.8,
    "xtick.color": "#4D4D4D", "ytick.color": "#4D4D4D",
    "xtick.direction": "out", "ytick.direction": "out",
    "figure.dpi": 150, "savefig.dpi": 300,
    "pdf.fonttype": 42, "pdf.compression": 6,
})
OUT = Path(__file__).resolve().parent / "figures"; OUT.mkdir(exist_ok=True)

DELTA = 0.5
EPS = [0.5, 0.2, 0.05, 0.01]
KS = [2, 4, 6, 8, 11, 20, 40, 80]

# ---- measure ---------------------------------------------------------------
print("measuring ...")
sh = [shuttle(e, DELTA, 40) for e in EPS]
rg = [ring(6, DELTA, e, 40) for e in EPS]
sh_r = [r.counts(DELTA)[0] / r.bound_consec(DELTA) for r in sh]
rg_r = [r.counts(DELTA)[0] / r.bound_consec(DELTA) for r in rg]
runs12 = [ring(12, DELTA, 0.01, k) for k in KS]
therm = [r.bound_depth(DELTA) for r in runs12]
depth = [r.counts(DELTA)[1] for r in runs12]
budget = [r.N for r in runs12]
for e, a, b in zip(EPS, sh_r, rg_r):
    print(f"  eps={e:<6g} shuttle {a:.5f}   ring(m=6) {b:.5f}")

fig, axes = plt.subplots(1, 2, figsize=(TEXTWIDTH_IN, TEXTWIDTH_IN * 0.40),
                         layout="constrained")

# ---- (a) tightness --------------------------------------------------------
ax = axes[0]
e = np.logspace(-4, np.log10(0.95), 500)
ax.semilogx(e, np.sqrt(2 * e / (np.arctanh(e) * (1 + np.sqrt(1 - e ** 2)))),
            "-", color=C_3, lw=1.2, zorder=3,
            label=r"Zhang form $r_Z(\epsilon)$")
ax.semilogx(e, np.sqrt(e / np.arctanh(e)), "-", color=C_1, lw=1.6, zorder=4,
            label=r"SFS form $\sqrt{\epsilon/\mathrm{artanh}\,\epsilon}$")
ax.semilogx(EPS, rg_r, "s", color="none", mec=C_W, mew=1.3, ms=9.5, zorder=5,
            label=r"interior ring, $|S|=6$ (depth 6)")
ax.semilogx(EPS, sh_r, "o", color=C_2, ms=5.0, zorder=6, mec="white", mew=0.8,
            label="two-state shuttle (depth 2)")
ax.axhline(1.0, color=C_RULE, lw=0.8, ls=(0, (4, 2)), zorder=2)
ax.text(1.4e-4, 0.9975, "bound saturated", color=C_RULE, fontsize=7.6, va="top")
ax.text(2.2e-4, 0.9835, "depth 2 and depth 6 land\non the same curve",
        fontsize=7.4, color=C_W, ha="left", va="top", linespacing=1.35)
ax.set_xlabel(r"drive asymmetry $\epsilon = J/A$")
ax.set_ylabel(r"achieved $K_\delta$ / bound")
ax.set_ylim(0.919, 1.018); ax.set_xlim(1e-4, 0.7)
ax.legend(frameon=False, fontsize=7.2, loc="lower left", handlelength=1.5,
          borderaxespad=0.5, handletextpad=0.6, labelspacing=0.3)
ax.set_title(r"(a) saturated asymptotically, at any depth", fontsize=8.8, pad=5)

# ---- (b) two factors ------------------------------------------------------
ax = axes[1]
Pd = 12.0                                   # geometric factor for this ring
slope = np.polyfit(budget, np.array(therm) - 1.0, 1)[0]     # (therm-1)/N_*
xs = np.logspace(np.log10(70), np.log10(6e3), 400)
th = 1.0 + slope * xs
frontier = np.minimum(th, Pd)
ax.fill_between(xs, frontier, 400, color=C_SHADE, alpha=0.9, zorder=0, lw=0)
ax.loglog(xs, th, "-", color=C_RULE, lw=1.0, ls=(0, (5, 2)), zorder=2,
          label=r"thermodynamic factor $1+\delta^{-1}\sqrt{\mathcal{N}_*\Sigma_*/2}$")
ax.loglog(xs, np.full_like(xs, Pd), "-", color=C_3, lw=1.0, ls=(0, (5, 2)),
          zorder=2, label=r"geometric factor $\mathcal{P}_\delta(X)$, $X$ = repertoire")
ax.loglog(xs, frontier, "-", color=C_W, lw=1.8, zorder=4,
          label=r"bound $=\min$ of the two")
ax.loglog(budget, depth, "o", color=C_2, ms=6.0, zorder=6, mec="white", mew=0.9,
          label=r"achieved packing depth $D_\delta$")
kx = (Pd - 1.0) / slope
ax.text(kx * 0.72, 1.35, "thermodynamics\nbinds", fontsize=7.2, color=C_RULE,
        ha="right", va="bottom", linespacing=1.3)
ax.text(kx * 1.35, 1.35, "geometry\nbinds", fontsize=7.2, color=C_3,
        ha="left", va="bottom", linespacing=1.3)
ax.text(3.2e3, 55, "excluded", fontsize=7.6, color=C_RULE, ha="center")
ax.set_xlabel(r"activity budget $\mathcal{N}_*$")
ax.set_ylabel(r"depth at resolution $\delta$")
ax.set_ylim(0.9, 400); ax.set_xlim(70, 6e3)
ax.legend(frameon=False, fontsize=7.2, loc="upper left", handlelength=1.7,
          borderaxespad=0.35, handletextpad=0.6, labelspacing=0.35)
ax.set_title(r"(b) $D_\delta \leq \min[\,$thermodynamic$,\ $geometric$\,]$",
             fontsize=8.8, pad=5)

fig.savefig(OUT / "tightness.pdf")
fig.savefig(OUT / "tightness.png", dpi=200)
plt.close(fig)
print("wrote", OUT / "tightness.pdf")