#!/usr/bin/env python3
"""Generate figures used by organizational_accessibility_v6.tex.

The numerical seeding figure is generated from the equations printed in the paper.
The bifurcation figure is generated from the analytical equilibrium branch.
The accessibility-routes figure is a schematic of the decomposition described in the text.
"""

from pathlib import Path

import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
from scipy.integrate import solve_ivp
from scipy.optimize import brentq

OUT = Path("docs/figures")
OUT.mkdir(parents=True, exist_ok=True)

U = 30.0
V = 2.0
RTOL = 1e-10
ATOL = 1e-12


def _save(fig, name):
    fig.savefig(OUT / f"{name}.svg", bbox_inches="tight")
    plt.close(fig)


def _rhs(t, y, eta, J):
    a, b, c, r, w = y
    return np.array([
        r * b + eta * V * r * c - a,
        r * a - b,
        U * r * a * c - c,
        J - r - (r * b + V * r * c + r * a + U * r * a * c),
        (1.0 - eta) * V * r * c - w,
    ])


def _segment(y0, t0, t1, eta, J):
    return solve_ivp(
        lambda t, y: _rhs(t, y, eta, J),
        (t0, t1),
        y0,
        rtol=RTOL,
        atol=ATOL,
    )


def simulate(seed, eta):
    # A-B equilibrium at J=1.2: r=1, a=b=(J-1)/2=0.1.
    y0 = np.array([0.1, 0.1, 0.0, 1.0, 0.0], dtype=float)
    s1 = _segment(y0, 0.0, 50.0, eta, 1.2)
    y50 = s1.y[:, -1].copy()

    if seed:
        eps = 1e-4
        y50[2] += eps
        y50[3] -= eps

    s2 = _segment(y50, 50.0, 150.0, eta, 1.2)
    s3 = _segment(s2.y[:, -1], 150.0, 500.0, eta, 0.9)

    t = np.concatenate([s1.t, s2.t[1:], s3.t[1:]])
    y = np.concatenate([s1.y, s2.y[:, 1:], s3.y[:, 1:]], axis=1)
    return t, y


def seeding_trajectories():
    cases = [
        (True, 1.0, r"Seed $C$, productive return ($\eta=1$)"),
        (False, 1.0, "No seed"),
        (True, 0.0, r"Seed $C$, return diverted to inert waste ($\eta=0$)"),
    ]

    fig, axes = plt.subplots(3, 1, figsize=(8.3, 8.0), sharex=True)
    for ax, (seed, eta, title) in zip(axes, cases):
        t, y = simulate(seed, eta)
        labels = ["a", "b", "c"]
        for idx, label in enumerate(labels):
            ax.plot(t, y[idx], label=label)
        if eta == 0.0:
            ax.plot(t, y[4], label="w (inert)", linestyle=":")
        ax.axvline(50.0, linewidth=0.8, linestyle="--")
        ax.axvline(150.0, linewidth=0.8, linestyle="--")
        ax.set_ylabel("Abundance")
        ax.set_title(title, fontsize=10)
        ax.set_ylim(bottom=0)
        ax.legend(ncol=4, fontsize=8, frameon=False)

    axes[-1].set_xlabel("Time")
    axes[-1].text(50, axes[-1].get_ylim()[1] * 0.95, " seed", va="top", fontsize=8)
    axes[-1].text(150, axes[-1].get_ylim()[1] * 0.95, r" $J:1.2\rightarrow0.9$", va="top", fontsize=8)
    fig.suptitle("Seeding comparison and cost-matched return-path control", fontsize=12)
    fig.tight_layout()
    _save(fig, "seeding_trajectories")


def bifurcation_diagram():
    def J_of_r(r):
        return r + (1.0 / r + 1.0 + (1.0 / r**2 - 1.0) / V) / U

    def active_total(r):
        a = 1.0 / (U * r)
        b = 1.0 / U
        c = (1.0 - r**2) / (U * V * r**2)
        return a + b + c

    r_fold = brentq(lambda r: U * r**3 - r - 2.0 / V, 1e-8, 0.999999)
    J_fold = J_of_r(r_fold)
    J_inv = 1.0 + 2.0 / U

    # Parameterise the expanded equilibrium by r. Restrict the far-left high-J tail
    # to the range needed for the visual comparison.
    r_stable = np.linspace(0.18, r_fold, 350)
    r_unstable = np.linspace(r_fold, 0.999999, 450)

    J_stable = np.array([J_of_r(r) for r in r_stable])
    J_unstable = np.array([J_of_r(r) for r in r_unstable])
    T_stable = np.array([active_total(r) for r in r_stable])
    T_unstable = np.array([active_total(r) for r in r_unstable])

    Jmax = 1.25
    J0 = np.linspace(0.0, 1.0, 200)
    Jab_stable = np.linspace(1.0, J_inv, 120)
    Jab_unstable = np.linspace(J_inv, Jmax, 120)

    fig, ax = plt.subplots(figsize=(8.5, 5.2))
    mask = J_stable <= Jmax
    ax.plot(J_stable[mask], T_stable[mask], linewidth=2.0, label="Expanded equilibrium (stable)")
    ax.plot(J_unstable, T_unstable, linewidth=1.8, linestyle="--", label="Expanded equilibrium (unstable)")
    ax.plot(J0, np.zeros_like(J0), linewidth=2.0, label="Organization-free equilibrium (stable)")
    ax.plot(Jab_stable, Jab_stable - 1.0, linewidth=2.0, label="A-B equilibrium (stable)")
    ax.plot(Jab_unstable, Jab_unstable - 1.0, linewidth=1.8, linestyle="--", label="A-B equilibrium (unstable to C)")

    ax.axvline(J_fold, linewidth=0.9, linestyle=":")
    ax.axvline(1.0, linewidth=0.9, linestyle=":")
    ax.axvline(J_inv, linewidth=0.9, linestyle=":")
    ymax = ax.get_ylim()[1]
    ax.text(J_fold, ymax * 0.96, r"$J_{\rm fold}$", rotation=90, va="top", ha="right", fontsize=9)
    ax.text(1.0, ymax * 0.96, r"$R_{\rm org}=1$", rotation=90, va="top", ha="right", fontsize=9)
    ax.text(J_inv, ymax * 0.96, r"$J_{\rm inv}$", rotation=90, va="top", ha="right", fontsize=9)

    ax.set_xlim(0.5, Jmax)
    ax.set_ylim(bottom=0)
    ax.set_xlabel("External supply J")
    ax.set_ylabel("Total active abundance a + b + c")
    ax.set_title("Bifurcation structure for u = 30, v = 2")
    ax.legend(fontsize=8, frameon=False, loc="upper right")
    fig.tight_layout()
    _save(fig, "bifurcation_diagram")


def _box(ax, x, y, w, h, title, body, lw=1.2):
    patch = FancyBboxPatch(
        (x, y), w, h,
        boxstyle="round,pad=0.012,rounding_size=0.015",
        linewidth=lw,
        facecolor="white",
    )
    ax.add_patch(patch)
    ax.text(x + w / 2, y + h * 0.70, title, ha="center", va="center", fontsize=10, fontweight="bold")
    ax.text(x + w / 2, y + h * 0.36, body, ha="center", va="center", fontsize=8.5, wrap=True)
    return patch


def _arrow(ax, x1, y1, x2, y2, style="-|>", lw=1.2, ls="-"):
    ax.add_patch(FancyArrowPatch((x1, y1), (x2, y2), arrowstyle=style, mutation_scale=12, linewidth=lw, linestyle=ls))


def accessibility_routes():
    fig, ax = plt.subplots(figsize=(12.0, 7.0))
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis("off")

    _box(ax, 0.37, 0.80, 0.26, 0.13,
         "Realized organization / history",
         r"architecture $\theta$  •  state $z$  •  environment $E$")

    _box(ax, 0.02, 0.48, 0.205, 0.18,
         "I. Hysteretic retention",
         "state + basin occupancy\nwhat can remain")
    _box(ax, 0.265, 0.48, 0.205, 0.18,
         "II. Inherited adaptive extension",
         "retained architecture + exposure\nwhere search begins / how much")
    _box(ax, 0.51, 0.48, 0.205, 0.18,
         "Variation process",
         r"$Q=(q,\nu)$" + "\nwhat candidates are generated")
    _box(ax, 0.755, 0.48, 0.205, 0.18,
         "III. Evolvability",
         r"retainable changes in $Q$" + "\nchanges future variation")

    _box(ax, 0.08, 0.12, 0.28, 0.18,
         "Compositional accessibility",
         "external modules / partners\nrecombination • transfer • symbiosis\ncross-scale incorporation")
    _box(ax, 0.43, 0.12, 0.19, 0.18,
         "Candidate successors",
         "generated or imported\narchitectures")
    _box(ax, 0.67, 0.12, 0.17, 0.18,
         "Establishment filter",
         r"$\pi_{\rm est}$" + "\nunder state + environment")
    _box(ax, 0.89, 0.12, 0.09, 0.18,
         "Later",
         "persistent\norganization")

    # History conditions each route.
    for x in [0.122, 0.368, 0.612, 0.858]:
        _arrow(ax, 0.50, 0.80, x, 0.66)

    # Inheritance and variation shape the successor distribution.
    _arrow(ax, 0.368, 0.48, 0.50, 0.30)
    _arrow(ax, 0.612, 0.48, 0.55, 0.30)

    # Evolvability acts on Q.
    _arrow(ax, 0.755, 0.57, 0.715, 0.57)

    # Compositional access can alter inherited starting structure, Q, or feed candidates directly.
    _arrow(ax, 0.22, 0.30, 0.34, 0.48, ls="--")
    _arrow(ax, 0.31, 0.30, 0.57, 0.48, ls="--")
    _arrow(ax, 0.36, 0.21, 0.43, 0.21)

    # Candidate → establishment → later organization.
    _arrow(ax, 0.62, 0.21, 0.67, 0.21)
    _arrow(ax, 0.84, 0.21, 0.89, 0.21)

    # Hysteresis can directly change persistence accessibility.
    _arrow(ax, 0.122, 0.48, 0.925, 0.30, ls=":")

    ax.text(
        0.5, 0.975,
        "Routes by which realized organization can condition later accessibility",
        ha="center", va="top", fontsize=13,
    )
    ax.text(
        0.5, 0.04,
        "Operational decomposition: compositional access is cross-cutting because imported modules can alter the inherited base point, candidate generation, or both.",
        ha="center", va="bottom", fontsize=8.5,
    )

    fig.tight_layout()
    _save(fig, "accessibility_routes")


def main():
    seeding_trajectories()
    bifurcation_diagram()
    accessibility_routes()


if __name__ == "__main__":
    main()
