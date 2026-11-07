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

1. **A targeted adversarial test. Done**, see [`pilot/RESULTS.md`](pilot/RESULTS.md), last two sections. On North–South random boundaries, the hidden O(2) spins *order* sideways: a stable sideways magnetisation of about ±0.5 in a 64 × 64 system, whose sign depends on the chain's start. That makes the measured O(2) tilt "tail" an artefact of sector trapping, not a valid influence estimate. The ordering itself is the spin-flop obstruction. The hidden O(3) spins show no sideways ordering (|m| ≤ 0.016), the chains mix, the exact symmetry null holds within noise, and no long-range response is detectable on the boundary classes tried. This is evidence, at one β and b, not a proof for all boundaries. Original plan: Measure influence for O(2) and O(3) at b = 4 and 8 on structured boundaries: North–South checkerboard, North–South random, all aligned, and visible spins confined to a plane. Expectation from the reasoning above: O(2) shows strongly enhanced influence on North–South boundaries, and O(3) does not. If O(3) does, the reasoning is wrong.
2. **Find which bounds are reachable. Done** for the standard toolbox; see the section below. Original plan: **read the uniform-mixing criteria in detail.** Haller and Kennedy (1996); Bertini, Cirillo and Olivieri, "Renormalization group transformations under strong mixing conditions" (mp_arc 99-197). Then ask whether a uniform high-temperature criterion could be checked by computer for O(3) at one fixed β and b. A computer-assisted bound at a single scale is a much smaller target than the mass gap.
3. **Ask an expert.** A. C. D. van Enter (Bernoulli Institute, Groningen) has worked on exactly this question, decimation of rotator models, and is in the Netherlands.

## Which worst-case bounds are reachable? (7 November 2026)

**Computation:** [`pilot/reachable_bounds.py`](pilot/reachable_bounds.py), file `pilot/reachable_bounds.json`.

**Step 1: the single-site worst case.** c(β) is the largest total-variation change in one spin's conditional law when one of its four neighbours changes, taken over all configurations. It is computed numerically, by quadrature on the sphere and a search over configurations. It is an estimate of the supremum, not a certified bound.

| β | 0.2 | 0.5 | 0.8 | 1.1 | 1.4 |
|---|---|---|---|---|---|
| c(β), O(3) | 0.100 | 0.245 | 0.380 | 0.501 | 0.604 |
| c(β), O(2) | 0.127 | 0.308 | 0.468 | 0.603 | 0.709 |

Dobrushin's condition for the original model, 4 c(β) < 1, holds up to β ≈ 0.51 for O(3) and β ≈ 0.40 for O(2).

**Step 2: what decimation can add with these tools.** Keep the coarse spins on (bZ)² and integrate out the rest. Dobrushin's comparison theorem bounds how much a change at a coarse spin j moves the target i: the change spreads through the hidden spins with worst-case influence c per link. The resulting bound on the decimated model's row sum is

  **S(b, c) = E[(4c)^T]**, where T is the number of steps a simple random walk from i needs to first hit another coarse spin.

The reason: each path through the hidden spins contributes c per step, and a site has 4 neighbours, so the path sum is the expectation of (4c)^T over random-walk paths. This was checked against a direct matrix computation, for example b = 2, c = 0.2: 0.343 from the matrix and 0.343 from a random-walk Monte Carlo; b = 4: 0.036 and 0.036.

**Consequence (elementary, and checked numerically for b = 1, 2, 3, 4, 8).** Since T is finite with probability 1, **S(b, c) < 1 exactly when 4c < 1, for every block size b.**
- Below the original threshold, decimation makes the certified bound much smaller. At c = 0.2, S falls from 0.8 (b = 1) to 0.34 (b = 2) and 0.036 (b = 4).
- But decimation **never extends** the range where the bound can be certified. Above 4c = 1 the bound blows up: at c = 0.26, S is 1.29 for b = 2 and 10.6 for b = 4.

**What this means for the route.** With uniform worst-case single-site influences, a certificate for decimated O(3) is reachable only where the original model already satisfies Dobrushin's condition (β below about 0.5). There a mass gap is already known from high-temperature methods. The simulations suggest contraction at β = 1.5. Reaching that would need tools that use more than the worst single-site influence:
- **Finite-box criteria (Dobrushin–Shlosman):** check contraction on boxes rather than single sites, which takes collective effects into account. For continuous spins, a rigorous computer check is hard.
- **Configuration-dependent or coupling arguments** (for example disagreement percolation), which can see that bad local configurations are rare.
- **Genuine multi-scale analysis** (Bałaban; Goswami's adaptation to sigma models), which controls the flow of the effective coupling from step to step.

That last option is the open problem itself. The finding narrows what a reachable *new* step could look like: it has to beat the uniform single-site bound, and decimation by itself does not.
