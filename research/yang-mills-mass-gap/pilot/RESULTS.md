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

## Stage 1 validation (review on PR #144)

**Run:** [`validate.py`](validate.py), files `validate_*.json`. L = 32, random boundaries, 12 outer boundaries × 2 sites, 600 measurement sweeps. Uncertainty is now grouped by outer configuration: one summed influence per boundary, which includes correlations between sites and between neighbour classes. Two independent seeds, and a burn-in after each perturbation of 200 versus 800 sweeps. Neighbour offsets are de-duplicated on the coarse lattice (12 distinct neighbours at b = 2 and b = 4).

Summed influence (lower-bound proxy):

| model | b | seed A, burn 200 | seed B, burn 200 | seed A, burn 800 |
|---|---|---|---|---|
| O(3), β = 1.5 | 2 | 1.332 ± 0.036 | 1.330 ± 0.027 | 1.326 ± 0.041 |
| O(3), β = 1.5 | 4 | 1.062 ± 0.040 | 1.064 ± 0.023 | 1.086 ± 0.031 |
| O(2), β = 1.3 | 2 | 1.664 ± 0.107 | 1.640 ± 0.122 | 1.704 ± 0.080 |
| O(2), β = 1.3 | 4 | 1.583 ± 0.104 | 1.926 ± 0.134 | 1.622 ± 0.155 |

**What survives**
- **Equilibration is adequate.** 200 and 800 sweeps agree in every row.
- **O(3) contracts.** It goes from 1.33 to 1.06–1.09 between b = 2 and b = 4, the same for both seeds and both burn-ins, with errors of about 0.03.
- **O(2) does not contract.** It stays around 1.6–1.9, well above O(3) at b = 4.

**What does not survive**
- **The earlier claim that O(2) *grows* from b = 2 to b = 4.** With grouped errors and a second seed, b = 2 and b = 4 are consistent for O(2). The two seeds at b = 4 differ by about 2 standard errors (1.58 and 1.93), so the variability between boundaries is larger than the earlier per-site errors suggested. The robust statement is: O(2) increases from b = 1 (1.30) to b = 2, then stays flat.

**Revised reading.** Between b = 2 and b = 4, the influence proxy contracts by a factor of about 0.8 for O(3) and does not contract for gapless O(2). This still concerns a lower bound, 12 neighbours, one β per model, and L = 32. It says nothing yet about the full worst-case sum or about larger scales.

## Stage 2: L = 64, block size 4, 28 neighbours

**Run:** [`stage2.py`](stage2.py), files `stage2_*.json`. L = 64, b = 4, random boundaries, 8 outer boundaries × 2 sites, 600 measurement sweeps. Influence summed over 28 coarse neighbours: ring 1 (Chebyshev distance 1, 8 neighbours), ring 2 (Chebyshev distance 2, 16), and axis 3 (the 4 at axis distance 3). The kernel was rewritten for speed (3.3×) and re-checked against the exact single-site conditional at b = 1: mean deviation 0.008 (O(3)) and 0.006 (O(2)), consistent with sampling noise. "Fresh chains": every conditional chain starts from independently drawn random fine spins, with 800 burn-in sweeps.

| model | setting | total | ring 1 | ring 2 | axis 3 |
|---|---|---|---|---|---|
| O(3), β=1.5 | seed A | 1.25 ± 0.05 | 1.01 ± 0.04 | 0.25 ± 0.03 | −0.01 ± 0.01 |
| O(3), β=1.5 | seed B | 1.18 ± 0.04 | 0.97 ± 0.03 | 0.20 ± 0.02 | 0.00 ± 0.01 |
| O(3), β=1.5 | seed A, fresh chains | 1.25 ± 0.06 | 0.98 ± 0.03 | 0.23 ± 0.03 | 0.04 ± 0.02 |
| O(2), β=1.3 | seed A | 2.51 ± 0.28 | 1.70 ± 0.17 | 0.73 ± 0.13 | 0.09 ± 0.04 |
| O(2), β=1.3 | seed B | 2.39 ± 0.28 | 1.60 ± 0.15 | 0.74 ± 0.15 | 0.05 ± 0.03 |
| O(2), β=1.3 | seed A, fresh chains | 2.80 ± 0.23 | 1.88 ± 0.11 | 0.77 ± 0.11 | 0.16 ± 0.04 |

**Findings**
- **No sign of a bias shared by chains with the same start.** Fresh chains agree with the standard ones within errors (O(3): 1.25 and 1.25; O(2): 2.80 and 2.51 ± 0.28).
- **O(3): influence falls off quickly with distance and is stable in lattice size.** Ring 2 adds about 0.2 and axis 3 about 0. Ring 1 alone (0.97–1.01) is close to the 12-neighbour value at L = 32 (1.06–1.09), which also includes the 4 axis-2 neighbours.
- **O(2): influence has a long tail and grows with lattice size.** Ring 2 adds about 0.75 and axis 3 is still nonzero. Ring 1 alone (1.6–1.9) already matches the whole 12-neighbour sum at L = 32. This fits a gapless model, whose influence decays slowly.
- **Correction to the earlier reading.** With longer range included, O(3) at b = 4 sums to about 1.2, not 1.06. The 12-neighbour sum understated it. The contraction from b = 2 to b = 4 was measured on 12 neighbours only. It still needs checking on the full 28-neighbour sum.

**Next, if agreed:** at L = 64, b = 2 and b = 8 with the same 28 neighbours and two seeds, for both models (about 15 minutes). This checks whether the full sum contracts with scale for O(3).

**Correction (review on PR #144).** The stage 2 claim that O(2) influence "grows with lattice size" is withdrawn. Comparing the same nearest eight neighbours, O(2) at b = 4 gives about 1.73 at L = 32 and 1.60–1.88 at L = 64, which are compatible. What stage 2 shows is that O(2) has a larger contribution from more distant neighbours at this coupling and block size.

## Stage 3: block sizes 2, 4 and 8 on L = 64

**Run:** [`stage3.py`](stage3.py), files `stage3_*.json`. L = 64, random boundaries, 8 outer boundaries × 2 sites, 150 burn-in and 500 measurement sweeps. At b = 2 and 4: the 28-neighbour stencil of stage 2. At b = 8: **all 63** other coarse spins (8 × 8 coarse lattice), so the sum is complete. Rings by Chebyshev distance. Also recorded: the sum of |δ| (no cancellation, but biased upward by noise), and a noise floor from a second, independent base chain.

**Like for like: rings 1 + 2 (the 24 neighbours within Chebyshev distance 2), signed sum**

| model | b = 2 | b = 4 | b = 8 |
|---|---|---|---|
| O(3), β = 1.5 | 1.46, 1.42 | 1.16 (stage 2: 1.26, 1.17, 1.21) | 0.75, 0.91 |
| O(2), β = 1.3 | 1.89, 1.89 | 2.03 (stage 2: 2.43, 2.34, 2.64) | 2.13, 2.42 |

**Complete sum over all 63 neighbours at b = 8:** O(3) 0.80 ± 0.09 and 0.89 ± 0.10 (two seeds); O(2) 3.09 ± 0.50 and 3.06 ± 0.23.

**Rings at b = 8** (seed A, seed B):
- O(3): ring 1 0.63, 0.64; ring 2 0.13, 0.27; rings 3 and 4 consistent with 0.
- O(2): ring 1 1.21, 1.40; ring 2 0.92, 1.01; ring 3 0.64, 0.45; ring 4 0.32, 0.20. That is a long tail.

The distant sample at b = 2 (coarse distance 4 to 6) is about 0 per neighbour for both models.

**Findings**
- **O(3) contracts on the like-for-like measure.** Rings 1 + 2 go from about 1.44 (b = 2) to about 1.2 (b = 4) to about 0.83 (b = 8). That is a factor of about 0.8 and then about 0.7 per doubling. The complete sum at b = 8 is 0.80–0.89, below 1. Influence stays concentrated in ring 1.
- **O(2) does not contract.** Rings 1 + 2 stay at about 1.9–2.4. The complete sum at b = 8 is about 3.1, with large contributions out to ring 4.

**What this does not show**
- **It is a lower bound on the influence, averaged over random boundaries.** Dobrushin's condition needs an upper bound on the worst case. A lower bound below 1 proves nothing about contraction.
- **Cancellation at large distance cannot be excluded.** At b = 2 and 4 the absolute sum exceeds the signed sum by about the noise level, so there is no sign of cancellation there. At b = 8 the absolute sum is dominated by noise (noise floor 1.7–1.8 for O(3), 4.6–5.9 for O(2)), so it cannot settle the question.
- **Small coarse lattice and few settings.** b = 8 on L = 64 leaves an 8 × 8 coarse lattice. There is one β per model and one kind of boundary.

**Reading.** The candidate statement survives this round. For O(3), the conditional influence measured here shrinks with each blocking step, by a factor of about 0.7–0.8, and stays local. For O(2) in its gapless phase it does not shrink and spreads out. Turning this into mathematics needs an *upper* bound on the influence of the coarse model, uniform over boundaries.

## Targeted test: structured "bad" boundaries

**Run:** [`adversarial.py`](adversarial.py), files `adversarial_*.json`. L = 64, b = 4, 6 boundaries × 2 sites, 400 burn-in and 500 measurement sweeps, grouped errors. The retained spins are set to a structured pattern: North–South checkerboard, North–South random, all aligned, or (O(3) only) random in a plane. N is z for O(3) and y for O(2). Two probes, both lower bounds on the TV influence of j on i, per neighbour, at coarse distance d:
- **tilt:** turn s_j 45° toward a sideways axis and measure the sideways response of s_i. This targets the spin-flop mechanism.
- **flip:** as before.

**Tilt response by distance** (per neighbour):

| model | boundary | d = 1 | d = 2 | d = 4 | d = 6 |
|---|---|---|---|---|---|
| O(2), β=1.3 | random | 0.090 ± 0.019 | 0.012 ± 0.007 | −0.010 ± 0.010 | −0.008 ± 0.006 |
| O(2), β=1.3 | N–S checkerboard | 0.030 ± 0.006 | 0.010 ± 0.006 | −0.000 ± 0.004 | 0.003 ± 0.005 |
| O(2), β=1.3 | **N–S random** | 0.110 ± 0.040 | 0.079 ± 0.031 | **0.044 ± 0.023** | **0.047 ± 0.019** |
| O(2), β=1.3 | aligned | 0.044 ± 0.007 | 0.005 ± 0.007 | 0.001 ± 0.008 | 0.001 ± 0.008 |
| O(3), β=1.5 | random | 0.053 ± 0.008 | −0.005 ± 0.006 | −0.011 ± 0.006 | −0.007 ± 0.007 |
| O(3), β=1.5 | N–S checkerboard | 0.077 ± 0.010 | 0.015 ± 0.009 | −0.002 ± 0.007 | −0.009 ± 0.008 |
| O(3), β=1.5 | **N–S random** | 0.087 ± 0.011 | 0.034 ± 0.007 | **0.007 ± 0.009** | **0.002 ± 0.012** |
| O(3), β=1.5 | aligned | 0.032 ± 0.005 | 0.000 ± 0.004 | −0.003 ± 0.004 | −0.002 ± 0.004 |
| O(3), β=1.5 | planar | 0.073 ± 0.007 | 0.014 ± 0.004 | −0.003 ± 0.004 | 0.003 ± 0.004 |

Flip responses (d = 1, 2) are similar across boundaries. They are smallest for aligned (O(2) 0.023, O(3) 0.039 at d = 1). Full numbers are in the JSON files.

**Findings** *(the O(2) part is superseded by the symmetry check below)*
- **O(2): North–South random boundaries produce a long tail.** The sideways response stays at about 0.045 per neighbour out to d = 6. That is about 2–2.5 standard errors each at d = 4 and 6, and the two agree. On random, checkerboard and aligned boundaries it is about 0 from d = 4 on. Because the number of neighbours at distance d grows like d, a flat tail makes the influence sum diverge. That fits the spin-flop picture for XY (D'Achille, van Enter and Le Ny 2022), whose paper notes that random North–South configurations work too.
- **O(3): no long tail on any boundary tried.** That includes North–South random, the one that is bad for O(2), and planar. North–South random raises the response at d = 2 (0.034 against about 0 for random boundaries), but from d = 4 on it is about 0 within errors of about 0.01. This fits the argument in [`../NOTE_O3_INFLUENCE.md`](../NOTE_O3_INFLUENCE.md): the obstruction that defeats XY needs a discrete choice for the hidden spins, and O(3) does not provide one. The test also finds no sign, at this β and b, of the other worry: hidden O(3) spins pushed into a plane acting like a gapless XY model.
- **An unexpected detail.** For O(2), the North–South *checkerboard* shows no tail at b = 4. The paper says alternating configurations become bad under more dilute decimation, so either b = 4 is not dilute enough at this β, or our probe misses it.

**Limits.** One β per model, b = 4 only, L = 64, a few structured classes, errors of about 0.01–0.02 per neighbour, and lower bounds only. A real worst case could lie outside the classes tried. Equilibrating the hidden spins on structured boundaries may be slow, especially near a spin-flop transition.

## Symmetry null control and mixing check (review on PR #144)

**Run:** [`symmetry_check.py`](symmetry_check.py), files `symmetry_*.json`. L = 64, b = 4, four fixed North–South random boundaries per model. With every retained spin along ±N, the conditional law is mirror-symmetric in the sideways axis e, so the **exact** sideways mean of every hidden spin is 0. Hidden spins start East, West or random. Short runs use 400 + 500 sweeps, as in `adversarial.py`. Long runs use 4000 + 4000 sweeps.

**O(2), β = 1.3: the chains are trapped in a sideways sector.**
- Untilted, the sideways magnetisation of all hidden spins stays at about ±0.4–0.5, with the sign set by the start. Random starts land in either sector. This persists in the long runs (|magnetisation| up to 0.51, target spin up to 0.75), whereas the exact value is 0.
- Tilted at distance 4, an East start gives +0.52 to +0.72 and a West start −0.47 to −0.74 on the same boundary and tilt. The answer depends on the start, not on the tilt.

**So the O(2) "tail" in the previous section is not a valid measurement of influence.** It reflects which sector each chain happened to fall into. What the check shows is **pronounced metastability and slow equilibration** between two sideways sectors (East and West) on North–South boundaries. The chains also switch sector now and then: on boundary 0 the long East-started run ended at −0.40 and the West-started one at +0.12. This is consistent with the spin-flop mechanism in the literature, but it is not by itself a proof of a phase transition. At finite volume the exact sideways mean is 0. Showing spontaneous ordering would need the two-sector structure to persist as the system grows. (Correction after review on PR #144; an earlier version said the spins "order".)

**O(3), β = 1.5: the chains mix, and the symmetry null holds.**
- Untilted, the sideways magnetisation of the hidden spins is |m| ≤ 0.016 from every start. In the long runs, the target's sideways mean is |·| ≤ 0.04, consistent with 0 within single-chain noise.
- Tilted at distance 4, East and West starts agree within noise in the long runs (for example −0.015 against +0.014, and 0.003 against −0.035).
- So the O(3) null result of the previous section stands as a measurement: no detectable long-range response, and **no sideways metastability** of the hidden spins. That is the specific difference from O(2).

**Three possibilities for the conditioned hidden system** (from review on PR #144):
1. uniform strong mixing, which would support a Dobrushin certificate;
2. a unique state without fast mixing, with possibly slowly decaying conditional correlations;
3. several infinite-volume conditioned states: phase coexistence, which can make the decimated measure non-Gibbsian.

The O(3) data fit 1 or 2. The O(2) data point toward 3, but only together with the existing literature.

**Consequences**
- **O(2) checkerboard:** the earlier no-tail result is also untrustworthy until checked for trapping.
- **The random-boundary experiments (stages 1–3) were not checked for trapping.** With uniformly random retained spins there is no exact mirror symmetry to test against, so trapping there is unknown. It is less likely, since the conditioning leaves no discrete symmetry, but not excluded.
- **Limits:** one β per model, b = 4, four boundaries, single chains.

## Planar symmetry check for O(3) (suggested in review)

**Run:** `python symmetry_check.py O3 1.5 planar` and `O3 2.0 planar`, files `symmetry_O3_b*_planar.json`. The retained spins point in random directions within the xy-plane. Only the reflection z → −z survives, so the hidden spins have a *discrete* choice, up or down. That is the O(3) analogue of the XY East/West choice. Hidden spins start up, down or random. Short runs use 400 + 500 sweeps, long runs 4000 + 4000. Four fixed boundaries per β. The tilt turns the coarse spin at distance 4 by 45° toward +z.

| | β = 1.5 | β = 2.0 | for comparison: O(2), N–S, β = 1.3 |
|---|---|---|---|
| untilted hidden z-magnetisation, long runs: mean (sd) | −0.001 (0.002) | −0.003 (0.016) | ±0.4–0.5, sign set by the start |
| largest \|hidden z-magnetisation\|, long runs | 0.004 | 0.044 | 0.51 |
| does the sign follow the start? | no | no | yes, mostly |
| tilted minus untilted, per boundary (mean ± s.e., 4 boundaries) | +0.0075 ± 0.0012 | +0.023 ± 0.007 | — |

**Findings**
- **No up/down trapping for O(3)** on planar boundaries, at β = 1.5 or β = 2.0. The candidate discrete choice does not produce O(2)-like metastability here.
- **The conditioned system responds globally to one tilted coarse spin.** With the four independent boundaries as units, and pairing tilted against untilted runs on the same boundary, the average z-magnetisation of all about 4000 hidden spins moves by **+0.0075 ± 0.0012 at β = 1.5** (per-boundary values 0.005–0.010) and **+0.023 ± 0.007 at β = 2.0** (per-boundary values 0.002–0.034, so heterogeneous). Each uses 3 degrees of freedom. On North–South boundaries at β = 1.5 the unpaired mean is similar (+0.0055). The response is larger at β = 2.0, but it varies a lot between boundaries. *(Corrected after review: an earlier version treated the 8 runs as independent and quoted "about 4 standard errors" for both.)*
- **A larger response is not slower mixing.** Mixing speed needs its own diagnostics, such as autocorrelation times, which were not measured. A global magnetisation near 0 does not guarantee local mixing either: at β = 2.0 one long untilted run leaves the target spin's z-mean at 0.124, against an exact 0, and without a Monte Carlo error estimate it is unclear whether that is noise or remaining autocorrelation. *(Corrected after review: an earlier version said "so mixing is slower".)*
- **Reading.** No sign of O(2)-like global metastability under the planar O(3) boundaries tried. That is not a uniform mixing bound. At these couplings the O(3) data fit possibility 1 or 2, not 3.

**Limits.** Two β values, b = 4, L = 64, four random planar boundaries per β. Periodic planar patterns (for example x, y, −x, −y in a fixed cycle) were not tried; for XY, periodic North–South patterns also work. Single chains.

## Periodic planar pattern at b = 2: a two-phase test (7 November 2026)

**Question.** Retained spins on (2Z)² are fixed to ((−1)^m e_x + (−1)^n e_y)/√2. At zero temperature the hidden odd–odd spins τ have exactly two energy minima, all +e_z or all −e_z. Does this survive at positive temperature as two phases of the hidden system? Leake and Li (arXiv:2611.05228, Theorem 5 and Remark 22, read at the source) exclude coexistence for β < 3/√8 ≈ 1.061: the hidden lattice is (4,2)-biregular with adjacency norm √8.

**Run.** `python periodic_b2.py L` for L = 16, 32, 64 at β = 0.8 (control), 1.0, 1.25, 1.5, 2.0, 2.5, 3.0, and `python periodic_b2.py L fine` at β = 2.6–2.9. Files `periodic_b2_L*.json`. Updates: Metropolis plus overrelaxation (`stage2.sweep2`). Measurement sweeps 40 000 / 20 000 / 8 000 for L = 16 / 32 / 64, plus a quarter of that for thermalisation. Starts near +z, near −z and random, two seeds each: 6 runs per (L, β). Observable: m_z, the mean z-component of the τ spins, and the Binder cumulant U4 = 1 − ⟨m_z⁴⟩/(3⟨m_z²⟩²), pooled over the 6 runs. Errors: jackknife over runs (computed for β ≥ 2.5 only).

| β | L = 16 | L = 32 | L = 64 |
|---|---|---|---|
| 0.8 (control) | 0.010 | 0.009 | 0.001 |
| 1.0 | 0.014 | 0.006 | −0.006 |
| 1.25 | 0.017 | 0.002 | −0.000 |
| 1.5 | 0.034 | 0.002 | 0.014 |
| 2.0 | 0.105 | 0.032 | −0.015 |
| 2.5 | 0.449 ± 0.003 | 0.250 ± 0.013 | 0.096 ± 0.044 |
| 2.6 | 0.534 ± 0.002 | 0.446 ± 0.007 | 0.287 ± 0.030 |
| **2.7** | **0.593 ± 0.001** | **0.593 ± 0.005** | **0.593 ± 0.009** |
| 2.8 | 0.627 ± 0.001 | 0.646 ± 0.002 | 0.660 ± 0.001 |
| 2.9 | 0.644 | 0.659 | 0.665 |
| 3.0 | 0.652 | 0.663 | 0.666 |

U4 = 0 for a centred Gaussian m_z and 2/3 for an almost constant |m_z|. U4 does not count phases: a chain that stays near one nonzero magnetisation also gives about 2/3. The reading below rests on the combination of the exact z → −z symmetry, the trend with L, and the two sectors seen from different starts. *(Wording corrected after review.)*

**Findings**
- **For β ≤ 2.0, including the control, U4 is near 0 and falls with L.** Compatible with a disordered regime. Autocorrelation times are short there (τ_mz up to about 7–10 sweeps at L = 64, β = 2.0).
- **For β ≥ 2.8, U4 rises with L toward 2/3.** Compatible with an ordered regime with two sectors. Run means of m_z are ±0.57 (β = 2.8) to ±0.67 (β = 3.0). From L = 32 on, the sign stays the one set by the start for the whole run: no tunnelling between the two sectors. At L = 16 the chains still switch (τ_mz from about 300 to 2600 sweeps per run at β = 2.8–2.9).
- **The curves for the three sizes cross at β ≈ 2.7**, where all three give U4 = 0.593 within the errors. The crossing does not drift between L = 16→32 and L = 32→64 at this resolution. This is the usual finite-size signature of a transition into a two-sector ordered regime, at β_c ≈ 2.65–2.75. The 2D Ising value on a periodic square is U4* = 0.61069… (Kamieniarz and Blöte, as quoted by Selke, arXiv:cond-mat/0701515). U4* depends on geometry and boundary conditions, and 0.593 from three sizes does not establish the Ising class. That is consistent with the Leake–Li bound β_c ≥ 1.061.
- **Autocorrelation near the crossing is long.** At β = 2.7, τ_mz is 200–460 sweeps for L = 16, 500–1600 for L = 32 and 100–640 for L = 64. The energy decorrelates faster: τ_E is 4–50 sweeps in all runs but one (L = 64, β = 2.7, start down, seed 9412: τ_E ≈ 115). τ of m_z² is at most 258 sweeps (same L and β). τ of m_z⁴ was not measured. *(Corrected after review: an earlier version said τ_E ≤ 50 everywhere.)*

**Limits**
- The jackknife uses 6 runs. Near β = 2.7 each run covers only about 10–40 autocorrelation times of m_z, so the errors there are rough.
- In the ordered regime, L ≥ 32 chains stay in one sector. The sectors are exact mirror images under z → −z, so the missing tunnelling does not bias the even moments, **provided each sector is equilibrated, including fluctuations of |m_z|**. τ of m_z² supports that (at most 258 sweeps, against 8 000–40 000 measurement sweeps); τ of m_z⁴ was not measured.
- Three sizes, one b, one pattern, one update scheme. No error bars below β = 2.5.
- **This is numerical evidence for step 2 of the argument below, not a proof.** It says nothing yet about step 3.

**Independent replication (posted on PR #144, code not in this repository).** A second implementation integrates out the connector spins exactly, giving the effective weight Π_e sinh(βr_e)/(βr_e) with r_e = ‖τ_u + τ_v + a_e‖. It samples only the τ spins with Metropolis, without overrelaxation, so its sweep counts differ from ours. Its ground-state energy matches the exact −2M²√6. Its Binder values, against ours (ours first):

| β | L = 32 | L = 64 |
|---|---|---|
| 2.5 | 0.250 / 0.345 | 0.096 / −0.060 |
| 2.6 | 0.446 / 0.456 | 0.287 / 0.267 |
| 2.7 | 0.593 / 0.593 | 0.593 / 0.612 |
| 2.8 | 0.646 / 0.641 | 0.660 / 0.654 |
| 2.9 | 0.659 / 0.655 | 0.665 / 0.664 |
| 3.0 | 0.663 / 0.660 | 0.666 / 0.648 |

The two agree from β = 2.6 to 2.9. They differ in two places:
- **β = 3.0, L = 64:** the replication has ⟨|m_z|⟩ = 0.640 and a long τ. A chain held by a straight domain wall around the torus would explain this; not checked.
- **β = 2.5, L = 32:** 0.345 against 0.250, about 2 to 3 standard errors.

Its long trajectories at L = 64, β = 2.7 also show no sector switching in 18 000 sweeps. Both codes were written by AI assistants, so this is not yet an independent human check.

**Where this sits in the argument for non-Gibbsianness of the decimated O(3) measure**
1. Two zero-temperature energy minima for this pattern: proven (review, checked).
2. Two infinite-volume phases of the hidden system at some finite β: this test is compatible with a disordered regime below β ≈ 2.7 and an ordered one above. Not proven. A proof must control interfaces and thermal fluctuations.
3. An essential discontinuity of the decimated conditional distributions: not addressed. Two phases alone are not enough. One must show that changing retained spins far away, around the periodic pattern, can switch the hidden system between phases and so move a retained spin's conditional law by a fixed amount, however far away the change is.

## Ring test at b = 2: does a far-away tilt move a freed retained spin? (7 November 2026)

**Question (step 3 of the argument above, protocol from review).** Free the retained spin at the centre, σ_0. Fix the other retained spins within distance R (sup-norm) to the periodic pattern η. In the annulus R < d ≤ 2R, set them to cos ε η ± sin ε e_z. Every hidden spin is free. Measure Δ_R = ⟨σ_0^z⟩₊ − ⟨σ_0^z⟩₋. This is the decimated conditional law of one retained spin, given all other retained spins. If Δ_R stays away from 0 as R grows, a change arbitrarily far away moves it.

**Run.** `python ring_b2.py BETA R [L [EPS]]`, files `ring_b2_*.json` (summaries, autocorrelation times) and `ring_b2_*.npz` (time series of σ_0^z and the inner hidden magnetisation, as means over blocks of 10 sweeps). Torus of side L = 4R, so the annulus fills everything outside the inner box. One check uses L = 8R, with the untilted pattern beyond 2R. ε = 0.3, with one check at ε = 0.1. Each ring is run from hidden starts near +z, near −z and random, two seeds each: 12 runs per row. Updates: Metropolis plus overrelaxation, plus once per sweep a global flip of the z-component of every free spin, accepted with the true energy change. 4 000 thermalisation and 16 000 measurement sweeps. Errors: standard error over the 6 runs of each ring.

| β | R | L | Δ_R | ⟨σ_0^z⟩₊ over the 6 starts | ⟨σ_0^z⟩₋ over the 6 starts |
|---|---|---|---|---|---|
| 3.0 | 4 | 16 | 0.792 ± 0.004 | +0.386 to +0.408 | −0.393 to −0.404 |
| 3.0 | 8 | 32 | 0.730 ± 0.003 | +0.357 to +0.372 | −0.358 to −0.373 |
| 3.0 | 8 | 64 | 0.725 ± 0.001 | +0.360 to +0.367 | −0.359 to −0.363 |
| 3.0 | 16 | 64 | 0.714 ± 0.003 | +0.352 to +0.360 | −0.352 to −0.367 |
| 3.0 (ε = 0.1) | 16 | 64 | 0.717 ± 0.003 | +0.353 to +0.369 | −0.353 to −0.362 |
| 3.0 | 32 | 128 | 0.715 ± 0.003 | +0.355 to +0.363 | −0.351 to −0.364 |
| 0.8 | 4 | 16 | 0.003 ± 0.002 | −0.004 to +0.005 | −0.008 to +0.002 |
| 0.8 | 8 | 32 | 0.001 ± 0.002 | −0.004 to +0.002 | −0.008 to +0.003 |
| 0.8 | 16 | 64 | 0.001 ± 0.003 | −0.007 to +0.006 | −0.007 to +0.004 |
| 0.8 | 32 | 128 | −0.003 ± 0.002 | −0.007 to +0.004 | −0.008 to +0.004 |

**Findings**
- **At β = 3.0, Δ_R levels off at about 0.71 for R = 8, 16, 32.** It does not decay. The inner hidden magnetisation follows the ring (+0.67 or −0.67 at R ≥ 16).
- **The result does not depend on the start.** For each ring, the six starts agree within about 0.02. A plus ring with a start near −z ends at the same value as with a start near +z. The first and second halves of each run differ by at most 0.023. So this is not the sector trapping of the Binder test.
- **The tilt angle does not matter here:** ε = 0.1 gives the same Δ_R as ε = 0.3 at R = 16. A larger outer box (L = 8R at R = 8) gives the same result.
- **At β = 0.8 (control), Δ_R is 0 within the errors at every R**, as the Leake–Li bound requires.
- Autocorrelation times are short in all runs: τ of the inner m, m², m⁴ and of the energy are at most 9 sweeps. The global flip was almost never accepted (at most 0.9%, at β = 0.8, R = 4); the starts converge through ordinary updates during thermalisation.

**Limits**
- Finite R (up to 32), finite tori, one β in the ordered regime, one pattern, one b.
- **This is not yet an essential discontinuity.** Both conditionings are single, exactly fixed configurations, which have probability zero. The argument must show that the separation survives on sets of positive measure, for example small neighbourhoods of these configurations (as in the framework of D'Achille, van Enter and Le Ny). Not tested.
- A negative result would not have excluded non-Gibbsianness. A positive one does not prove it.

## Ring test with noisy retained spins (7 November 2026)

**Question.** The ring test compares two exact configurations, and those have probability zero. Does Δ_R survive if every fixed retained spin is perturbed a little? This is a proxy for conditioning on small neighbourhoods of the two configurations.

**Run.** `python ring_noise_b2.py BETA R DELTA [NSAMP]`, files `ring_noise_b2_*.json`. As in the ring test, but each fixed retained spin is set to normalise(η_x + δ g_x), with g_x i.i.d. standard Gaussian vectors; in the annulus the tilt is applied as well. For each noise sample, the + ring and the − ring use the same g, so they differ only in the annulus. Each ring runs from starts near +z and near −z. β = 3.0, L = 4R, 4 000 + 6 000 sweeps, 4 noise samples per row. Errors: standard error over the noise samples.

| δ | R = 8 | R = 16 | R = 32 |
|---|---|---|---|
| 0 (ring test above) | 0.730 ± 0.003 | 0.714 ± 0.003 | 0.715 ± 0.003 |
| 0.03 | — | 0.685 ± 0.025 | 0.677 ± 0.018 |
| 0.1 | 0.544 ± 0.047 | 0.177 ± 0.079 | 0.015 ± 0.009 |
| 0.3 | 0.052 ± 0.027 | 0.011 ± 0.005 | 0.002 ± 0.003 |

**Findings**
- **At a fixed noise level, Δ_R dies out as R grows.** At δ = 0.3 it is gone by R = 8. At δ = 0.1 it falls from 0.54 to 0.18 to 0.015.
- **At smaller noise it survives:** δ = 0.03 gives about 0.68 at both R = 16 and R = 32.
- **Starts agree** within 0.06 in every sample, so this is not trapping.
- **The noise also breaks the inner region into ±z patches.** At δ = 0.1, R = 32, the inner magnetisation still differs between the two rings (for example +0.37 against −0.08), while σ_0 no longer feels the difference: it follows the local patch.

**Reading.** This is what one expects from a random field. The noise gives the retained spins small random z-components, a random field on the hidden ±z order. In two dimensions, an i.i.d. random field coupled to a two-valued order parameter destroys long-range order (Imry–Ma; proven by Aizenman and Wehr; not checked at the source here). The patches are then large but finite, and smaller when the noise is stronger.

This does **not** rule out an essential discontinuity. In that definition, the neighbourhoods may be chosen anew for every distance, with a tolerance that shrinks as R grows. The data fit that picture: δ = 0.03 keeps Δ_R ≈ 0.68 up to R = 32, where δ = 0.1 no longer does. The open mathematical step is now sharper: show that for every R a small enough tolerance δ(R) > 0 keeps the separation, while the conditional law outside the annulus is averaged over the decimated measure. Also untested here: unconstrained retained spins outside the annulus.

**Limits.** Four noise samples per row, one β, one ε, L = 4R, Gaussian noise on every retained spin. The decay at δ = 0.1 is not yet resolved in R.

## 4D gauge theory: does a continuous twist cost area? (7 November 2026, ROUTE.md first test)

**Question.** ROUTE.md proposes a gauge-invariant continuous family of defects in 4D SU(2) that becomes the 't Hooft twist at t = π. On the stack S of plaquettes P_01(y) with y_0 = y_1 = 0 (L² plaquettes), the Wilson weight is replaced by the average over the conjugacy class of D_t = exp(itσ_3). In closed form, with tr U_p = 2 cos θ:

  w_t(U_p) = exp(β cos θ cos t) · sinh(β sin θ sin t) / (β sin θ sin t).

Does the free energy of this defect grow with the area of the stack? If it does, Z(t)/Z(0) falls like exp(−f(t) L²) between the two cheap end points, and the continuous path that the O(3) argument needs is closed.

**Method.** `python gauge_twist.py su2|u1 BETA L [NT [NTHERM NMEAS]]`, files `gauge_twist_*.json`.
- Lattice L⁴, periodic. Metropolis with 3 hits per link, cold start. 500 thermalisation and 4 000 measurement sweeps at each of 9 values of t in [0, π].
- Measured: g(t) = (1/L²) d/dt log Z(t), the mean over S of ∂_t log w_t.
- Then f(t) = −(1/L²) log(Z(t)/Z(0)), by the trapezoid rule (Simpson's rule for f(π)).
- Errors use the integrated autocorrelation time of g (at most 17 sweeps; differences between the first and second half of each run are at most 0.05).
- **Control:** U(1), whose twist exp(β cos(φ_p + t)) on S is central and so always gauge invariant. β = 0.8 is confined and β = 1.3 is in the Coulomb phase.

**Expectation at strong coupling** (character expansion, derived here, not checked against a source). The ∫dU w_t(U) is independent of t, so a single plaquette feels nothing. The leading cost comes from the 2L² elementary cubes with two faces on S. Each picks up a factor (χ_{1/2}(D_t)/2)² = cos² t, which gives f(t) ≈ 8u⁶ sin² t with u = I₂(β)/I₁(β). For U(1) the two faces give e^{int} e^{−int} = 1, so no such term.

**Results** (cost per unit area f; at t = π the defect is the 't Hooft twist)

| | L | f(π/4) | f(π/2) | f(π) |
|---|---|---|---|---|
| SU(2), β = 1.8 | 4 | 0.024 ± 0.001 | 0.045 ± 0.003 | −0.003 ± 0.005 |
| | 6 | 0.024 ± 0.001 | 0.051 ± 0.002 | 0.004 ± 0.003 |
| | 8 | 0.023 ± 0.001 | 0.043 ± 0.001 | −0.007 ± 0.003 |
| SU(2), β = 2.2 | 4 | 0.098 ± 0.002 | 0.215 ± 0.004 | 0.025 ± 0.009 |
| | 6 | 0.084 ± 0.001 | 0.181 ± 0.003 | −0.012 ± 0.006 |
| | 8 | 0.088 ± 0.001 | 0.188 ± 0.002 | −0.005 ± 0.005 |
| SU(2), β = 2.5 | 4 | 0.168 ± 0.001 | 0.455 ± 0.006 | 0.102 ± 0.012 |
| | 6 | 0.166 ± 0.001 | 0.415 ± 0.006 | 0.016 ± 0.010 |
| U(1), β = 0.8 | 4 / 6 / 8 | ≤ 0.001 | 0.001 / 0.002 / 0.001 (± 0.001–0.002) | ≈ 0 |
| U(1), β = 1.3 | 4 | 0.018 | 0.081 ± 0.004 | 0.251 ± 0.008 |
| | 6 | 0.009 | 0.034 ± 0.003 | 0.138 ± 0.006 |
| | 8 | 0.003 | 0.019 ± 0.002 | 0.078 ± 0.004 |

**Findings**
- **SU(2): the intermediate defect costs area.** f(π/2) does not shrink from L = 4 to L = 8. It is about 0.045 at β = 1.8 and 0.19 at β = 2.2, and it grows with β. At L = 8 and β = 2.2 this means Z(π/2)/Z(0) ≈ e^{−12}.
- **SU(2): the end point is cheap.** f(π), the 't Hooft twist, is 0 within the errors from L = 6 on at β = 1.8 and 2.2, and falls with L at β = 2.5. This is what confinement and the Tomboulis–Yaffe picture lead one to expect.
- **So this path has a barrier proportional to the area between two cheap end points.** The O(3) argument needs min_t Z(t) / max_t Z(t) → 1, and that fails here.
- **Shape and size.** The shape fits the strong-coupling form: f(π/4)/f(π/2) is about 0.5 at β = 1.8, as sin² predicts. The size is larger than the leading term 8u⁶ (0.032 at β = 1.8, 0.080 at β = 2.2). Higher orders are not small here.
- **U(1) control.**
  - Confined (β = 0.8): no cost at any t.
  - Coulomb phase (β = 1.3): the cost per area falls like 1/L². L² f(π/2) ≈ 1.29, 1.23, 1.22 and L² f(π) ≈ 4.0, 5.0, 5.0. So the total cost is finite and independent of L, as expected for the energy of a magnetic flux with a massless photon.
- **Not a classical effect.** Every element of SU(2) is a commutator, so there is a configuration with zero action away from S in which every plaquette of S lies in the class of D_t. Take links in the 0- and 1-directions equal to fixed matrices a and b on one slice, with [a, b] in that class; the other links are 1. The area cost must therefore come from fluctuations. A rough heuristic: each plaquette of S loses the freedom to point its class in its own direction, which gives about log(β sin² t) per plaquette at weak coupling. Not derived.

**Limits**
- Small lattices (L ≤ 8) and β ≤ 2.5, which is the confined and crossover region, not the weak-coupling continuum.
- One candidate family of defects, on one stack.
- Metropolis only, cold starts, 9 points in t.

**Reading for ROUTE.md.** The goal carries over: the 't Hooft twist is cheap at these β. The continuous path does not: the natural gauge-invariant interpolation costs area. Unless a different interpolation is found, the OpenAI mechanism does not carry over directly to 4D SU(2).

## Annular twist cost in 2D sigma models: O(3), O(2), CP² (7 November 2026)

**Question (CPN_TWIST.md, protocol from review).** On the annulus N ≤ ‖x‖∞ ≤ 2N (radius ratio fixed at 2), pin the outer layer to s* and rotate the inner layer by t. Measure the free-energy cost f(t) = −log(Z(t)/Z(0)) as N grows.
- **O(3)** is the positive control: the theorem says f → 0, at most like C/log N.
- **O(2) at low temperature** is the negative control: spin stiffness should keep the cost finite at a fixed radius ratio.
- **CP²** is the new case: CPN_TWIST.md claims the same twist estimate as for O(3).

**Method.** `python annulus_twist.py o2|o3|cp2 BETA N [NT NTHERM NMEAS [warm]]`, files `annulus_twist_*.json`.
- **Updates.** O(n): Metropolis plus overrelaxation. CP²: Metropolis on z ∈ ℂ³ (2 hits).
- **Measurement.** Thermodynamic integration in t over 9 points, with d/dt log Z(t) the mean of the inner-bond derivative of the energy. CP² uses z(t) = cos(t/2)e₁ + sin(t/2)e₂, so t = π is the orthogonal state.
- **Run lengths.** 2 000 + 8 000 sweeps per point. CP² at β = 6 was rerun with 4 000 + 12 000 sweeps from a warm start on the classical twisted profile.

**Results**

| | N = 4 | 8 | 16 | 32 |
|---|---|---|---|---|
| O(2), β = 2.0: f(π/2) | 22.47 | 22.04 | 21.85 | 21.38 |
| O(2), β = 2.0: f(3π/4) | 49.47 | 49.40 | 48.70 | 48.48 |
| O(3), β = 1.5: f(π/2) | 11.45 | 8.72 | 5.86 | 2.56 |
| O(3), β = 2.0: f(π/2) | 18.30 | 16.19 | 14.30 | 12.29 |
| O(3), β = 2.0: f(3π/4) | 39.17 | 35.13 | 30.94 | 26.81 |
| CP², β = 3.0: f(π/2) | 6.58 | 0.99 | −0.03 ± 0.24 | −0.06 ± 0.32 |
| CP², β = 6.0: f(π/2), cold / warm start | 27.4 | 24.4 / 25.0 | 21.7 / 21.6 | 22.8 / 20.9 |
| CP², β = 6.0: f(3π/4), cold / warm start | 59.6 | 54.0 / 55.0 | 46.3 / 46.2 | 46.6 / 45.2 |

Errors are 0.03–0.3 for O(n) and 1–2 for CP² at β = 6 and N ≥ 16.

**Findings**
- **O(2), the negative control:** the cost stays nearly constant, falling by about 5% from N = 4 to 32.
- **O(3), the positive control:** the cost falls with N.
  - At β = 1.5 (correlation length of order 10) it falls quickly.
  - At β = 2.0 (correlation length far above 2N) it falls steadily, by 11–15% per doubling. That fits a coupling that weakens slowly with scale. We did not compare it quantitatively with the running coupling.
- **CP² at β = 3.0** goes to 0 within the errors by N = 16.
- **CP² at β = 6.0** falls from N = 4 to N = 16 at about the same rate as O(3) at β = 2.0. These are matched couplings: β divided by the number of complex components, 6/3 against 4/2 for CP¹ = O(3) at 2.0. From N = 16 to 32 the cost does not fall further within the errors. **This step is inconclusive.**
  - The simple Metropolis sampler mixes slowly here: τ is up to 700 sweeps at the point t = 7π/8, so the errors are probably underestimated.
  - f(π) depends on the start (cold 71 against warm 81 at N = 16), so f(π) for CP² at β = 6 is not reported.
  - Cold and warm starts agree for t ≤ 3π/4.

**Reading.** The controls behave as the theorem and the spin-wave picture predict. CP² behaves like O(3) where the sampler is reliable. The largest CP² lattice needs a better update, for example overrelaxation in the gauge-field formulation of CP^{N−1}. This tests the twist mechanism, not the proof: a falling cost is also what a mass gap would give.

**Limits.** One radius ratio, the square annulus, 9 points in t, single chains per point. The half-run differences reach 3 to 6 error bars in some runs, so the quoted errors are optimistic.
