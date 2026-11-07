# Yang–Mills mass gap

**Aim:** contribute to the mass-gap half of the Clay problem: prove that four-dimensional quantum Yang–Mills theory has a strictly positive mass gap. This folder is a working space. It is not part of the EbE theory, and nothing here is a result until a human expert has checked it.

**Started:** 7 November 2026, by the author with two assistants from different model families.

## Where the problem stands

- **Existence (the other half).** On 26 October 2026, OpenAI announced an AI-produced existence proof for pure Yang–Mills, with a Lean formalization finished on 16 October. A group led by David Gross is reviewing it. It is not public, and it does not claim a mass gap. *Seen only in secondary reports.*
- **Gap and decay.** On a lattice, a positive gap corresponds to exponential decay of correlations under suitable boundary conditions. Decay for one kind of observable (say, plaquettes) is not yet a gap for the whole physical Hilbert space. That needs a rich enough family of gauge-invariant observables and a reconstruction (transfer-matrix) argument in the continuum.
- **Strong coupling on a lattice: solved.** Osterwalder and Seiler (1978); Shen, Zhu and Zhu (2023); a 2025 paper reaches the 't Hooft regime. It is formalized in Lean by Douglas and Rajasekaran ([LGT](https://github.com/mrdouglasny/lgt)): U(n) Wilson theory, β < 1/(32n(d−1)), decay of plaquette–plaquette correlations, uniform in the torus size, no `sorry`.
- **Small volumes: worked out, then stalled.** Lüscher (1983) and van Baal (Leiden) treated the zero-momentum modes on a small torus. Their quartic potential with flat directions gives a gap that scales as g^(2/3). The method breaks down at intermediate volumes, where instantons and the topology of field space take over.
- **Weak coupling, which the continuum limit needs: open.** That is the problem.
- **News for the 2D test model (seen 7 November 2026).** The preprint [arXiv:2611.04908](https://arxiv.org/abs/2611.04908) (3 November 2026) states a proof of exponential decay of spin correlations in the 2D O(N) model, N ≥ 3, at every β > 0. That confirms Polyakov's 1975 prediction for O(3). It mentions an earlier proof released by OpenAI on 6 October 2026, and remarks that extending its result to all boundary conditions is not straightforward. A follow-up, [arXiv:2611.01532](https://arxiv.org/abs/2611.01532), extends it to small anisotropy. *Seen in the arXiv HTML and abstract; author names and details not verified here.* The O(3) gap is no longer the open question in our pilot. Its method (loop soups, sign clusters) is what to study next for a gauge-theory analogue.

## Controls any mechanism must pass

| Theory | Gap? | Why it matters |
|---|---|---|
| U(1) lattice gauge theory in 4D | gapless at weak coupling (Coulomb phase) | interactions alone do not give a gap |
| Supersymmetric matrix models (de Wit, Lüscher and Nicolai, 1989) | continuous spectrum down to zero | lifting of flat directions can be cancelled |
| N=4 super-Yang–Mills | gapless (conformal) | being non-Abelian is not enough |
| Pure SU(N) Yang–Mills | gap expected | the target |

*The first three rows are from memory and secondary reading. They still need checking at the source.*

## The open step, as we currently see it

The route is renormalization: coarse-grain step by step until the theory reaches strong coupling, where decay is known.

LGT already has a bridge for this (`LGT/Bridge/ScaleTransfer.lean`). If the model after k blocking steps decays with rate m, and its explicit hypotheses hold, the original model decays with rate at least m/2^k. Three things are missing.

1. **Reaching strong coupling in time.** After k blocking steps, the coarse model must satisfy a contraction (Dobrushin-type) condition: the sum of influences on one link is below 1. In epidemic terms, R < 1 for influence. A sufficient condition for a positive physical rate is that the coarse length a·2^k stays below a fixed physical length ℓ, with the contraction constant bounded away from 1. Fix ℓ and the continuum trajectory independently of the gap, or the argument is circular.
2. **The residual term.** The bridge assumes |Cov_fine| ≤ |Cov_blocked| as an explicit hypothesis. In general:

   Cov(f, g) = Cov(E[f|B], E[g|B]) + E[Cov(f, g | B)]

   The second, residual term need not vanish and can have either sign. It vanishes for observables that are functions of the coarse variables B alone, but that is not the only case. In general one needs a *conditional* gap: decay of correlations for the fine field once the coarse field is fixed. It is enough for that decay to happen over one block rather than one lattice spacing (`blockScale_residual_suffices`).
3. **The effective model after blocking.** A blocked weak-coupling SU(2) measure is in general not another nearest-neighbour Wilson measure. It has extended and multi-loop interactions. The strong-coupling theorem in LGT cannot be applied to it without proving that the actual effective model satisfies a contraction condition.

## Lean

[`lean/`](lean/) is checked by CI (`.github/workflows/yang-mills-mass-gap-check.yml`):
- `blocked_bound_fails`: a two-point counterexample to the bridge's assumption.
- `corrected_transfer`, `corrected_transfer_min`: transfer with a residual term kept. The fine rate is the minimum of the coarse rate divided by the blocking scale and the residual rate. Here the split |covF| ≤ |covB| + |covC| is a hypothesis.
- `physical_rate_lower_bound`, `physical_decay`: if a·s ≤ ℓ and the coarse rate is at least m⋆, the physical rate is at least m⋆/ℓ, whatever the lattice spacing. Sufficient, not necessary.
- `combined_physical_rate`, `combined_physical_rate_pos`, `physical_decay_combined`: with both terms, if also the residual rate satisfies m₂ ≥ a·μ_R, the physical rate is at least min(m⋆/ℓ, μ_R), which is positive when m⋆, μ_R and ℓ are.
- `blockScale_residual_suffices`: residual decay at rate c per block gives the residual condition with μ_R = c/ℓ.
- `expect_condExp`, `total_covariance`, `split_bound`, `transfer_of_blocking`: on a finite configuration space with nonnegative weights, the tower property and the law of total covariance for actual conditional expectations given a coarse variable. The split is then a theorem, and the transfer runs on real blocked covariances and real residual terms. Continuous gauge groups (Haar measure) need the measure-theoretic version.

These are bookkeeping. All of the physics sits in their hypotheses. They are statements about correlation decay, not yet about the spectral gap, and uniformity of the prefactors in volume and cutoff is outside them.

## Pilot

[`pilot/`](pilot/RESULTS.md): Monte Carlo for 2D O(2) and O(3). The residual (conditional) part of the correlations is short-range in all cases, including gapless O(2). The gap lives entirely in the coarse part. So the residual condition is not where the difficulty is. A second experiment measures how much coarse spins influence one another (a lower bound on Dobrushin's quantity). With atypical boundaries, that influence contracts under coarse-graining for O(3) (by about 0.8 from block 2 to block 4, stable across seeds and burn-in) and does not contract for gapless O(2). Later stages on 64 × 64 (block sizes 2, 4, 8, up to all 63 neighbours) give the same picture: for O(3), the influence summed over the nearest two rings goes from about 1.44 to 1.2 to 0.83; for O(2) it stays at about 1.9–2.4, with a long tail. These are lower bounds averaged over boundaries, not Dobrushin's worst-case upper bound.

## Next steps

- [x] Transfer theorem with a residual term, and the combined physical rate (both terms).
- [x] Derive the covariance split from conditional expectations, on finite spaces.
- [ ] Only then decide whether depending on LGT adds anything.
- [x] Measure the coarse model's conditional sensitivity (Dobrushin-type) across block scales in O(2) and O(3): small pilot done.
- [x] 64² at block sizes 2, 4, 8: O(3) keeps contracting (factor about 0.7–0.8 per doubling), O(2) does not.
- [ ] Look for an upper bound on the coarse model's influence for O(3), uniform over boundaries: the mathematical step. See [`NOTE_O3_INFLUENCE.md`](NOTE_O3_INFLUENCE.md).
- [ ] **Main line now:** carry the mechanism of the 2D O(3) proof over to 4D SU(2). The goal carries over (the 't Hooft twist costs almost nothing), the tool does not (no continuous twist). First test done: the natural gauge-invariant continuous twist in 4D SU(2) costs area (L = 4–8), while the 't Hooft end point is cheap; this path is closed. The loop-soup proof does not carry over directly either. The two 2D proofs map onto the centre-vortex and abelian-projection pictures of confinement, both open in 4D. Structural reason: twists in gauge theory come from 1-form symmetries, which are always abelian. A rung that may be within reach: the twist estimate of the O(3) proof seems to need only five properties that 2D CP^{N−1} also has ([`CPN_TWIST.md`](CPN_TWIST.md)); the sign clusters do not carry over, but a positive loop representation gives an exact replacement for the crossing identity. One lemma is missing, a pinning comparison for loop crossings ([`CPN_STEP4.md`](CPN_STEP4.md)). See [`ROUTE.md`](ROUTE.md).
- [x] Sign clusters for the gauge theory itself, through its centre ([`NOTE_SU2_FRUSTRATION.md`](NOTE_SU2_FRUSTRATION.md)). Conditioning 4D SU(2) on the coset leaves, exactly and without gauge fixing, a Z₂ gauge theory with couplings (β/2) Tr V_p. Its irreducible frustration is exactly the Z₂ monopoles; without them it is a ferromagnet in an 't Hooft twist sector. Pilot (8⁴, Wilson action): monopoles fill 17% of 3-cubes at β = 2.4 and grow in physical units as a → 0, so this positivity is available only in a monopole-suppressed action. *Prior work found afterwards: this decomposition and its positivity are Tomboulis' SO(3) × Z(2) formulation (Kovács and Tomboulis, hep-lat/9711009).*
- [x] Repeat that pilot with Z₂ monopoles forbidden. The positive centre sector is there but frozen: forbidding monopoles also removes almost all negative plaquettes, because a sign excitation is now a closed surface. Confinement proxies stay close to the Wilson values at similar plaquette, and the disorder sits in the coset and at scale 2a, where the signs are as frustrated as before. The route through the thin centre sector closes; thick vortices remain the question. Kovács and Tomboulis argued the same in 1997; the pilot reproduces it. See [`NOTE_SU2_FRUSTRATION.md`](NOTE_SU2_FRUSTRATION.md), step 2.
- [ ] Blocked centre variables: is there a blocking whose effective signs are unfrustrated, or frustrated only dilutely?
- [ ] Five approaches that might be new, one per axis (scale, parameter, dimension, source of positivity, representation): [`FIVE_APPROACHES.md`](FIVE_APPROACHES.md). The first, gradient flow, gives no positive-and-disordered window on 8⁴. The most promising is the third: a thick vortex as a 2D O(3) field on its own world-sheet. Worked out in [`WORLDSHEET.md`](WORLDSHEET.md): the sheet field is RP² (the disputed 2D case), its point vortices are probably absent, but the theorem's hypotheses do not hold on vortex sheets and the colour on sheets is noise at the lattice scale. Now a conditional question about an infrared vortex model. A closer reading shows the O(3) twist estimate needs the two edge directions of the square lattice, not planarity as such; on non-planar graphs with short extra edges the twist cost still falls (consistent with, not proof of, a lemma stated in WORLDSHEET.md §6), while long extra edges destroy it.
- [ ] Side question, parked, apart from the O(3) gap: does an explicit periodic planar pattern of retained spins make decimated 2D O(3) non-Gibbsian? Numerics at b = 2: a Binder crossing at β ≈ 2.7 (L = 16, 32, 64), and at β = 3 a far-away tilt of retained spins moves a freed retained spin by a fixed amount (ring radius up to 32). Small random noise on the retained spins removes this unless the noise shrinks with the radius. Proof steps 2 and 3 are open. See [`NOTE_O3_INFLUENCE.md`](NOTE_O3_INFLUENCE.md).
- [ ] Add an SU(n) instance to LGT, which currently covers U(n) only. Open an issue on LGT first to coordinate; the author does this.
- [ ] Read the existence proof when it is released, and see where its control over scales stops.
- [ ] Find a human expert in constructive field theory or probability.

## Sources

- Douglas and Rajasekaran, [LGT: Lattice Gauge Theory in Lean 4](https://github.com/mrdouglasny/lgt), commit `b8793cc`, read 7 November 2026.
- Shen, Zhu and Zhu, [A stochastic analysis approach to lattice Yang–Mills at strong coupling](https://arxiv.org/abs/2204.12737), Commun. Math. Phys. 400 (2023).
- [U(N) lattice Yang–Mills in the 't Hooft regime](https://arxiv.org/abs/2510.22788) (2025).
- Lüscher, [Some analytic results concerning the mass spectrum of Yang–Mills gauge theories on a torus](https://inspirehep.net/literature/183485), Nucl. Phys. B219 (1983).
- van Baal, [Intermediate volumes and the role of instantons](https://arxiv.org/abs/hep-th/9705112) (1997).
- Chatterjee, [A probabilistic mechanism for quark confinement](https://arxiv.org/abs/2006.16229) (2020).
