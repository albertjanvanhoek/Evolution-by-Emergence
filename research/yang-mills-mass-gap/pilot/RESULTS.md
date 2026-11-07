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

---

# Experiment 2: sensitivity of coarse conditional distributions

**Run:** 7 November 2026, [`sensitivity.py`](sensitivity.py) (seeds in the code). Protocol as proposed in review on PR #144. Coarse spins by decimation at block factors b = 1, 2, 4 on L = 32. For a coarse spin i and a boundary η, flip one other coarse spin j and measure

δ_ij = ( E[s_i·u | η] − E[s_i·u | η′] ) / 2,  with u = the original s_j.

This is an unbiased estimate of a *lower bound* on the average total-variation influence. It is not Dobrushin's supremum. A sum below 1 therefore proves nothing. A sum clearly above 1 does show that Dobrushin's condition fails at that scale. Neighbours: nearest (nn), diagonal, and distance 2, in coarse units. Two kinds of boundary: typical (equilibrium) and random (all coarse spins drawn independently; an atypical, worst-case-like test).

**Benchmark (b = 1).** The estimates match the exact single-site conditional: for example O(3) β=1.5, nn δ = 0.3197 ± 0.0087 against an exact 0.3194; O(2) β=1.3, 0.3218 ± 0.0197 against 0.3204. The exact TV distance is about 1.6 times δ, so the proxy is a fairly tight lower bound.

**Result: random boundaries, more statistics** (12 boundaries × 2 sites; files `sensitivity_confirm_*.json`). Summed influence Σ_j δ_ij:

| block b | O(3), β = 1.5 (gap) | O(2), β = 1.3 (no gap) |
|---|---|---|
| 1 | 1.29 ± 0.04 | 1.30 ± 0.08 |
| 2 | 1.27 ± 0.03 | 1.71 ± 0.07 |
| 4 | 1.04 ± 0.03 | 1.96 ± 0.09 |

Both models start at the same value at b = 1. Under coarse-graining, the summed influence **shrinks for O(3) and grows for O(2)**. The growth in O(2) comes mostly from longer-range influences: the diagonal term rises from 0.004 to 0.15 and the distance-2 term from 0 to 0.06. O(3) also develops non-nearest-neighbour influences (diagonal about 0.07), so the coarse model is not nearest-neighbour, as the review warned.

**Typical boundaries** (quick run, `sensitivity_quick.json`, noisier) show a weaker picture: O(3) β=1.5 goes 0.79 → 0.87 → 0.67, and O(2) β=1.3 goes 0.51 → 0.39 → 0.41. The two models separate clearly on *atypical* boundaries, which is where Dobrushin's supremum lives.

**Reading.** In this small pilot, the quantity that tells gapped from gapless is how worst-case-like conditional influence changes under coarse-graining. It contracts in O(3) and expands in O(2). A candidate statement, not tested beyond this pilot: for O(3) there is a block scale beyond which one blocking step shrinks the influence sum by a factor λ < 1, which would eventually push it below 1 (Dobrushin). For O(2) in its gapless phase, no such scale exists.

**Limits.** L = 32, so b = 4 leaves an 8 × 8 coarse lattice. One β per model in the confirmation. The proxy is a lower bound averaged over random boundaries, not a supremum. After the coarse spins are randomized, the fine spins get 200 sweeps to re-equilibrate, which may not be enough. Whether the O(3) trend continues to below 1 needs larger lattices; the asymptotic-scaling regime of O(3) is known to be hard to reach.
