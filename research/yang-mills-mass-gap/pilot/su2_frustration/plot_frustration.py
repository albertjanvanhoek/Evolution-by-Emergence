import json, glob
import matplotlib; matplotlib.use("Agg")
import matplotlib.pyplot as plt
fs = sorted(glob.glob("out/frustration_b*_L8_s1.json"), key=lambda s: float(s.split('_b')[1].split('_')[0]))
D = [json.load(open(f)) for f in fs]
b = [d["beta"] for d in D]; S = [d["summary"] for d in D]
g = lambda k: ([s[k][0] for s in S], [s[k][1] for s in S])
C1, C2, C3 = "#2a78d6", "#eb6834", "#1baf7a"
INK, INK2, GRID, SURF = "#0b0b0b", "#52514e", "#e4e3df", "#fcfcfb"
plt.rcParams.update({"font.size": 10, "axes.edgecolor": INK2, "axes.labelcolor": INK2,
                     "xtick.color": INK2, "ytick.color": INK2, "axes.facecolor": SURF, "figure.facecolor": SURF})
fig, ax = plt.subplots(1, 2, figsize=(10, 4))
for a in ax:
    a.grid(True, color=GRID, lw=0.8); a.set_axisbelow(True)
    for sp in ("top", "right"): a.spines[sp].set_visible(False)
    a.set_yscale("log"); a.set_xlabel("β (Wilson action, 8⁴ lattice)")
# A: irreducible frustration at two scales
y, e = g("monopole_density_R1"); ax[0].errorbar(b, y, e, color=C1, lw=2, marker="o", ms=8, mec=SURF, mew=1.5, label="cubes of side a")
y2, e2 = g("monopole_density_R2"); ax[0].errorbar(b, y2, e2, color=C2, lw=2, marker="s", ms=8, mec=SURF, mew=1.5, label="cubes of side 2a")
ax[0].axhline(0.5, color=INK2, lw=1, ls=":"); ax[0].text(3.5, 0.53, "random signs (0.5)", ha="right", va="bottom", color=INK2, fontsize=9)
ax[0].text(b[-1] + 0.04, y[-1], "side a", color=INK, va="center", fontsize=9)
ax[0].text(b[-1] + 0.04, y2[-1], "side 2a", color=INK, va="center", fontsize=9)
ax[0].set_ylabel("fraction of 3-cubes with frustration")
ax[0].set_title("Irreducible frustration (Z₂ monopoles), gauge invariant", color=INK, fontsize=10, loc="left")
ax[0].legend(frameon=False, loc="lower left", labelcolor=INK)
ax[0].set_xlim(1.9, 3.75); ax[0].set_ylim(0.01, 0.8)
# B: frustrated plaquettes after maximal centre gauge vs lower bound
yr, er = g("raw.frac_J_negative"); ax[1].errorbar(b, yr, er, color=C3, lw=2, marker="^", ms=8, mec=SURF, mew=1.5, label="no gauge fixing")
yd, ed = g("dmcg.frac_J_negative"); ax[1].errorbar(b, yd, ed, color=C1, lw=2, marker="o", ms=8, mec=SURF, mew=1.5, label="maximal centre gauge")
lb = [v / 6 for v in y]; ax[1].plot(b, lb, color=C2, lw=2, ls="--", marker="s", ms=8, mec=SURF, mew=1.5, label="lower bound (monopoles / 6)")
ax[1].set_ylabel("fraction of plaquettes with J_p < 0")
ax[1].set_title("Frustrated plaquettes: removable part depends on the gauge", color=INK, fontsize=10, loc="left")
ax[1].legend(frameon=False, loc="center right", bbox_to_anchor=(1.0, 0.62), labelcolor=INK)
ax[1].set_xlim(1.9, 3.75); ax[1].set_ylim(0.002, 0.8)
fig.tight_layout()
fig.savefig("frustration_su2.png", dpi=150)
print("ok")
