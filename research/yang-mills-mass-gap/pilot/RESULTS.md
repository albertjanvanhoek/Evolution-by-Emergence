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
| tilted, mean hidden z-magnetisation (sd), 8 runs | +0.006 (0.002) | +0.020 (0.014) | — |

**Findings**
- **No up/down trapping for O(3)** on planar boundaries, at β = 1.5 or β = 2.0. The candidate discrete choice does not produce O(2)-like metastability here.
- **The conditioned system does respond globally to one tilted coarse spin.** The average z-magnetisation of all about 4000 hidden spins moves by +0.006 at β = 1.5 and +0.020 at β = 2.0, about 4 standard errors each. The same holds on North–South boundaries at β = 1.5 (+0.0055). So the response is a finite susceptibility, and it grows about threefold from β = 1.5 to 2.0. Fluctuations are also larger at β = 2.0, so mixing is slower.
- **Reading.** At these couplings, the O(3) data fit possibility 1 or 2 (strong mixing, or a unique state with slower mixing), not 3 (coexisting states). The growing response with β points toward possibility 2 becoming more relevant at lower temperature.

**Limits.** Two β values, b = 4, L = 64, four random planar boundaries per β. Periodic planar patterns (for example x, y, −x, −y in a fixed cycle) were not tried; for XY, periodic North–South patterns also work. Single chains.
