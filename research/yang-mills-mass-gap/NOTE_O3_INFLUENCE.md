# Note: a worst-case influence bound for decimated 2D O(3)?

*Working note, 7 November 2026. Written for discussion with an expert in constructive field theory or rigorous statistical mechanics. Not a result.*

## The question

Does decimation of the 2D O(3) model admit a **volume-uniform, worst-case** conditional-influence bound at a large enough block scale? Or are there exceptional retained-spin configurations that prevent such a bound?

The question was formulated by one of the two assistants in review on PR #144.

If such a bound holds, so that Dobrushin's condition is met by the decimated specification at some block scale b, then a structure like `LGT/Bridge/O3MassGap.lean` (Douglas and Rajasekaran) turns it into a mass gap. There, the coarse-graining certificate is a hypothesis. If exceptional configurations prevent the bound, this route is too strong, even though O(3) is expected to have a gap.

## What we measured (lower bounds only)

From [`pilot/RESULTS.md`](pilot/RESULTS.md), on L = 64 with random boundaries. The quantity is the signed mean response of a coarse spin when one other coarse spin is flipped. It is a lower bound on the average total-variation influence. Dobrushin's condition needs an upper bound on the worst case.

| | b = 2 | b = 4 | b = 8 |
|---|---|---|---|
| O(3), β = 1.5, rings 1 + 2 | about 1.44 | about 1.2 | about 0.83 |
| O(2), β = 1.3, rings 1 + 2 | about 1.9 | 2.0–2.6 | 2.1–2.4 |

At b = 8, the complete sum over all 63 neighbours is 0.80–0.89 for O(3) and about 3.1 for O(2). O(3) influence stays in the nearest ring; O(2) has a long tail. Random boundaries are not worst-case boundaries.

## What the literature says (checked at the source)

- **Kushnir and Rosenstein (1995)**, [cond-mat/9505144](https://arxiv.org/abs/cond-mat/9505144) and [cond-mat/9506060](https://arxiv.org/abs/cond-mat/9506060). Decimation of the 2D O(N) σ-models, N ≥ 3, with scale factor 2, by low-temperature perturbation theory. The decimated action generally contains interactions of any range. Perturbative, so no uniform bound.
- **Haller and Kennedy (1996)**, J. Stat. Phys. 85, 607–637 ([mp_arc 95-505](https://web.ma.utexas.edu/mp_arc-bin/mpa?yn=95-505)). A sufficient condition for a well-defined renormalized Hamiltonian: the hidden-spin measures are in the high-temperature phase *uniformly in the block-spin configuration*. Proved for Ising-type examples, such as decimation with b = 2 at β < 1.36 β_c. This is the kind of uniform control our question asks for.
- **van Enter, Fernández and Sokal (1993)**, [hep-lat/9210032](https://arxiv.org/abs/hep-lat/9210032). Non-Gibbsianness after real-space renormalization seems to be the normal situation at low temperature or near first-order transitions. The authors report no evidence of pathologies at or above the critical temperature below the upper critical dimension.
- **D'Achille, van Enter and Le Ny (2022)**, [arXiv:2206.06990](https://arxiv.org/abs/2206.06990), J. Math. Phys. Decimated 2D XY measures become non-Gibbsian at low temperature through a spin-flop mechanism. With the visible spins pointing only North or South, the hidden system acquires a *discrete* symmetry, which can break. The mechanism is robust: periodic and random North–South configurations work. With more dilute decimation, even the alternating configuration becomes bad. This fits our O(2) measurement.
- **Goswami (2024)**, Ann. Henri Poincaré, [arXiv:2204.08252](https://arxiv.org/abs/2204.08252). Balaban's variational problem and background field, adapted to 2D nonlinear sigma models, specifically the chiral models (SU(n); SU(2) gives O(4)). Aimed at the ultraviolet problem, not at a gap.

## One point the literature does not settle: does spin-flop carry over to O(3)?

*The assistants' reasoning, partly tested; see the corrections below.* In XY, North–South visible spins leave the hidden spins two choices, East or West. That is a discrete Z₂, which can break in 2D. In O(3), take visible spins along ±z. Hidden spins that flop away from the z-axis can point anywhere in the equatorial plane. That is a continuous O(2) choice, which by the Mermin–Wagner theorem cannot be *spontaneously broken* in 2D. So the specific mechanism that defeats XY may be absent for O(3).

**Correction (review on PR #144).** Mermin–Wagner rules out ordinary spontaneous breaking of a continuous symmetry, and nothing more. It does not imply uniform exponential mixing. It does not exclude slowly decaying (BKT-like) behaviour of the conditioned hidden spins, or other bad configurations, such as ones that leave the hidden system a discrete choice. What matters is the symmetry of the *conditioned* system, not of the original model. So this is a question to test, not an inference.

## Suggested next steps

1. **A targeted adversarial test. Done**, see [`pilot/RESULTS.md`](pilot/RESULTS.md), last two sections. On North–South random boundaries, the hidden O(2) spins show pronounced metastability: a sideways magnetisation of about ±0.5 in a 64 × 64 system, whose sign mostly follows the chain's start, with occasional switches. That makes the measured O(2) tilt "tail" an artefact of sector trapping, not a valid influence estimate. The metastability is consistent with the spin-flop mechanism, but a finite system cannot prove a phase transition. The hidden O(3) spins show no sideways metastability (|m| ≤ 0.016), the chains mix, the exact symmetry null holds within noise, and no long-range response is detectable on the boundary classes tried. This is evidence, at one β and b, not a proof for all boundaries. Original plan: Measure influence for O(2) and O(3) at b = 4 and 8 on structured boundaries: North–South checkerboard, North–South random, all aligned, and visible spins confined to a plane. Expectation from the reasoning above: O(2) shows strongly enhanced influence on North–South boundaries, and O(3) does not. If O(3) does, the reasoning is wrong.
2. **Find which bounds are reachable. Done** for the standard toolbox; see the section below. Original plan: **read the uniform-mixing criteria in detail.** Haller and Kennedy (1996); Bertini, Cirillo and Olivieri, "Renormalization group transformations under strong mixing conditions" (mp_arc 99-197). Then ask whether a uniform high-temperature criterion could be checked by computer for O(3) at one fixed β and b. A computer-assisted bound at a single scale is a much smaller target than the mass gap.
3. **Ask an expert.** A. C. D. van Enter (Bernoulli Institute, Groningen) has worked on exactly this question, decimation of rotator models, and is in the Netherlands.

## Which worst-case bounds are reachable? (7 November 2026)

**Computation:** [`pilot/reachable_bounds.py`](pilot/reachable_bounds.py), file `pilot/reachable_bounds.json`.

**Step 1: the single-site worst case.** c(β) is the largest total-variation change in one spin's conditional law when one of its four neighbours changes, taken over all configurations. It is computed numerically, by quadrature on the sphere and a search over configurations. It is an estimate of the supremum, not a certified bound.

| β | 0.2 | 0.5 | 0.8 | 1.1 | 1.4 |
|---|---|---|---|---|---|
| c(β), O(3) | 0.100 | 0.245 | 0.380 | 0.501 | 0.604 |
| c(β), O(2) | 0.127 | 0.308 | 0.468 | 0.603 | 0.709 |

Dobrushin's condition for the original model, 4 c(β) < 1, holds up to β ≈ 0.51 for O(3) and β ≈ 0.40 for O(2). These are numerical estimates of the threshold.

**Analytic check (review on PR #144).** Take three neighbours at 120° to each other, so their sum is 0, and flip the fourth from +e to −e. The two conditionals then differ in total variation by exactly (cosh β − 1)/sinh β = tanh(β/2). So c_O(3)(β) ≥ tanh(β/2), and the single-site method **cannot** certify contraction for β ≥ ln(5/3) ≈ 0.5108. This is rigorous. Our numerical search agrees with tanh(β/2) to within 1.2 × 10⁻⁶ at every β computed, so this configuration is very probably the true worst case, giving c_O(3)(β) = tanh(β/2) exactly. That last step is numerical evidence for the upper bound, not a proof.

**Step 2: what decimation can add with these tools.** Keep the coarse spins on (bZ)² and integrate out the rest. Dobrushin's comparison theorem bounds how much a change at a coarse spin j moves the target i: the change spreads through the hidden spins with worst-case influence c per link. The resulting bound on the decimated model's row sum is (a random-walk reading of Dobrushin's conditions goes back at least to Possolo and Rukhin, "Random walk approach to uniqueness and mixing conditions in Markov random fields", listed by NIST; publication details not verified here)

  **S(b, c) = E[(4c)^T]**, where T is the number of steps a simple random walk from i needs to first hit another coarse spin.

The reason: each path through the hidden spins contributes c per step, and a site has 4 neighbours, so the path sum is the expectation of (4c)^T over random-walk paths. This was checked against a direct matrix computation, for example b = 2, c = 0.2: 0.343 from the matrix and 0.343 from a random-walk Monte Carlo; b = 4: 0.036 and 0.036.

**Consequence (elementary; checked numerically for b = 1, 2, 3, 4, 8 and verified independently in review).** Since T ≥ 1 and T is finite with probability 1, **S(b, c) < 1 exactly when 4c < 1, for every block size b.** This is a limitation of *this* comparison bound with homogeneous worst-case influences. It is not an impossibility result for decimation, nor for every method that uses local influences.
- Below the original threshold, decimation makes the certified bound much smaller. At c = 0.2, S falls from 0.8 (b = 1) to 0.34 (b = 2) and 0.036 (b = 4).
- But decimation **never extends** the range where this bound can be certified. Above 4c = 1 the bound no longer proves contraction. It exceeds 1 (at c = 0.26, S is 1.29 for b = 2 and 10.6 for b = 4), and it can also diverge, even on a finite torus: the hitting time T is unbounded, so E[(4c)^T] is infinite once 4c is large enough. *(Corrected after review: an earlier version said it stays finite on a finite torus.)*

**What this means for the route.** With uniform worst-case single-site influences, a certificate for decimated O(3) is reachable only where the original model already satisfies Dobrushin's condition (β below about 0.5). There a mass gap is already known from high-temperature methods. The simulations suggest contraction at β = 1.5. Reaching that would need tools that use more than the worst single-site influence:
- **Finite-box criteria (Dobrushin–Shlosman):** check contraction on boxes rather than single sites, which takes collective effects into account. Rebeschini and van Handel, *Comparison Theorems for Gibbs Measures*, J. Stat. Phys. 157, 234–281 (2014), develop comparison theorems for influences between blocks that substantially extend the classical single-site range. For continuous spins, a rigorous computer check is still hard.
- **Coupling arguments** (for example disagreement percolation). Note that rarity of bad *retained* configurations does not by itself help with a supremum over them.
- **Genuine multi-scale analysis** (Bałaban; Goswami's adaptation to sigma models), which controls the flow of the effective coupling from step to step.

That last option is the open problem itself. The finding narrows what a reachable *new* step could look like: it has to beat the uniform single-site bound, and decimation by itself does not.

## Planar retained spins: a discrete choice for O(3)? (7 November 2026)

Suggested in review. If the retained spins point in different directions within one plane, only the reflection perpendicular to that plane survives. The hidden O(3) spins then have a discrete choice, up or down, the analogue of the XY East/West choice. This undercuts the symmetry argument above as a general claim.

Precisely: the hidden spins stay continuous; what remains is a discrete *global symmetry*, z → −z. Whether two macroscopic phases form is a separate question. Crawford, *Random field induced order in low dimension*, EPL 102, 36003 (2013), proves that O(n) models in a weak random field confined to an (n−1)-dimensional subspace order perpendicular to it at low temperature, in d = 2 and 3. That supports the mechanism for O(3), but it does not carry over to this decimation automatically: here the field is dilute and locally correlated.

**An explicit periodic candidate (from review, checked).** At b = 2, set the retained spins to ((−1)^m e_x + (−1)^n e_y)/√2. At zero temperature, a tangent-line bound shows that the only energy minima are all hidden odd–odd spins equal to +e_z, or all equal to −e_z: an exact two-fold degeneracy. This proves nothing yet about positive temperature, about non-Gibbsianness, or about b = 4.

**Test** (`pilot/symmetry_check.py`, last section of `pilot/RESULTS.md`): random planar boundaries at β = 1.5 and 2.0. **No up/down metastability observed** at either coupling, in these observables and run lengths. A time-averaged magnetisation near 0 cannot by itself tell disorder from switching between sectors. The hidden z-magnetisation stays near 0 from every start (largest 0.004 at β = 1.5, 0.044 at β = 2.0), against ±0.5 for O(2) on North–South boundaries. The conditioned system does show a finite global response to a single tilted coarse spin: +0.0075 ± 0.0012 at β = 1.5 and +0.023 ± 0.007 at β = 2.0, with four boundaries as units. The β = 2.0 value varies a lot between boundaries. This is no sign of global metastability, but it is not a uniform mixing bound, and mixing speed was not measured. Periodic planar patterns, and larger β, are untried.

## Status after the 2D O(N) preprints (7 November 2026)

A preprint (arXiv:2611.04908) states a proof of exponential decay for the 2D O(N) model, N ≥ 3, at every β, with an earlier proof released by OpenAI. So the O(3) mass gap is no longer open, and the decimation–Dobrushin route is not needed to prove it. Two questions remain.
- **The uniform question of this note.** Is there control under arbitrary retained-spin configurations? The preprint itself says extending to all boundary conditions is not straightforward. This is now a side question.
- **For Yang–Mills, the method.** Can the new proof's ideas (loop soups, sign clusters) be carried over to a gauge theory?
