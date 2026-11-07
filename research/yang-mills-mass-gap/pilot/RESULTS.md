# Pilot: coarse versus residual correlations, 2D O(2) and O(3)

**Run:** 7 November 2026, `python pilot.py` (code and seeds in [`pilot.py`](pilot.py), numbers in [`results.json`](results.json)). L = 32, blocks of b = 4, 32 outer samples (Wolff), 1000 inner sweeps per sample (Metropolis plus overrelaxation, coarse spins frozen). About 1.5 minutes in total.

**Question:** the spin correlation splits exactly into a coarse part, ⟨E[s_x|B]·E[s_y|B]⟩, and a residual part, ⟨Cov(s_x, s_y | B)⟩. Does either part tell a model with a gap (O(3)) from one without (O(2) at β = 1.3, in its quasi-long-range phase)?

## Validation of the estimator

With the coarse variable on a grid of lines (every 4th row and column), the cells are conditionally independent, so the residual between different cells must be exactly 0. Measured: |residual| ≤ 0.0009 at r ≥ 4 in all four runs, within about 2 standard errors of 0. Within one cell (r = 1) it is clearly nonzero (0.10 to 0.24). The estimator works.

## Result: decimation (coarse variable = every 4th site in both directions)

Residual part ± standard error:

| r | O(3) β=1.2 | O(3) β=1.5 | O(2) β=0.8 | O(2) β=1.3 (gapless phase) |
|---|---|---|---|---|
| 4 (one block) | 0.0426 ± 0.0005 | 0.0421 ± 0.0008 | 0.0459 ± 0.0008 | 0.0209 ± 0.0003 |
| 8 | 0.0031 ± 0.0004 | 0.0041 ± 0.0003 | 0.0039 ± 0.0005 | 0.0022 ± 0.0002 |
| 12 | 0.0006 ± 0.0003 | 0.0005 ± 0.0003 | 0.0000 ± 0.0005 | 0.0000 ± 0.0003 |

For comparison, the total correlation at r = 16 is about 0.55 in O(2) at β = 1.3, and about 0.1 in O(3) at β = 1.5.

**Finding.** The residual part drops by roughly a factor of 10 per block in all four runs, *including the gapless one*. The long-range correlations of O(2) sit entirely in the coarse part. So the residual term does not tell a gapped model from a gapless one. A second assistant predicted exactly this before the run.

**What it means for the route.** The residual condition (decay over one block, `blockScale_residual_suffices`) looks easy and does not depend on the model. With grid conditioning it even holds exactly, by the Markov property. All of the difficulty sits in the coarse part: showing that the coarse model becomes strongly coupled. The decomposition organizes the problem, but it does not open a new route through the residual term.

## Limits

Small lattice (32²), one block size, one decimation scheme, a modest number of samples. The two halves of the inner chain are not fully independent, which can leave a small bias. The direct estimate of C(r) is noisy at large r.

## Suggested next experiment

Look at the coarse part directly. A Dobrushin-type condition concerns how much a coarse spin's *conditional distribution* responds to its neighbours, not two-point correlations. Measure that sensitivity at block scales 1, 2, 4 and 8. The expectation is that it shrinks with scale for O(3) (flow to strong coupling) and levels off for O(2) at β = 1.3 (a line of fixed points).
