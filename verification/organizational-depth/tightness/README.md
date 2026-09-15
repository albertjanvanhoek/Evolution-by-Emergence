# Tightness and two-factor packing depth

This directory is the canonical reproducibility package for the current two-factor Organizational Depth result.

## Run

```bash
python analytic.py
python simulate.py
python packing.py
python verify.py
python make_figure.py
```

Dependencies: `numpy`, `sympy`, and `matplotlib`.

## What is checked

- `analytic.py` — SFS and Zhang tightness formulas and limits.
- `simulate.py` — explicit finite-rate master-equation constructions, including the shuttle, finite-rate interior rings, the continuous step-size/overshoot family, and sharpness of the packing-depth thermodynamic factor.
- `packing.py` — exact two-state packing number, randomized lower bounds, and the lattice-rounding upper bound
  [
  \mathcal P_\delta(\Delta_{n-1})
  \le
  {k+n-1\choose n-1},
  \qquad
  k=\left\lfloor\frac{n}{2\delta}\right\rfloor+1.
  ]
- `verify.py` — adversarial random master-equation checks. It stores cumulative activity and entropy at every retained snapshot and tests each snapshot pair against its own subinterval budget; it also checks the geometric factor for every sampled finite state-space dimension using the exact two-state formula or the lattice upper bound. The default reproduces the 400-run audit; CI uses a smaller randomized smoke test for runtime.
- `make_figure.py` — regenerates `figures/tightness.pdf` used by the manuscript.

The detailed derivation and correction history are in [TIGHTNESS_REPORT.md](TIGHTNESS_REPORT.md).

## Main result

[
D_\delta(T)
\le
\min\left\{
1+\frac1\delta\sqrt{\frac{\Sigma_*\mathcal N_*}{2}},
\;
\mathcal P_\delta(\mathcal X_T)
\right\}.
]

Both factors can bind. The thermodynamic factor is asymptotically attained by a finite-rate interior ring until its repertoire is exhausted; after that the geometric factor caps depth.

## Provenance

The second-agent re-audit that supplied the strengthened package is preserved separately at:

`../audits/2026-09-15-two-factor/`

The earlier exploratory report that first exposed the shuttle pathology remains under `archive/`.
