"""Plotting subset used by the SCAP fragmentation experiments.

This keeps the palette and save helper from the packaged Agent-2 `plotstyle.py`
without duplicating the unrelated E-series CRM figure functions, which remain
canonical with PR #65.
"""
from __future__ import annotations

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

SURFACE = "#fcfcfb"
INK = "#0b0b0b"
INK2 = "#52514e"
MUTED = "#8a8984"
GRID = "#e6e5e0"
S = ["#2a78d6", "#eb6834", "#1baf7a", "#eda100"]
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
