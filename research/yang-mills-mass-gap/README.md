# Yang–Mills mass gap

**Aim:** contribute to the mass-gap half of the Clay problem: prove that four-dimensional quantum Yang–Mills theory has a strictly positive mass gap. This folder is a working space. It is not part of the EbE theory, and nothing here is a result until a human expert has checked it.

**Started:** 7 November 2026, by the author with two assistants from different model families.

## Where the problem stands

- **Existence (the other half).** On 26 October 2026, OpenAI announced an AI-produced existence proof for pure Yang–Mills, with a Lean formalization finished on 16 October. A group led by David Gross is reviewing it. It is not public, and it does not claim a mass gap. *Seen only in secondary reports.*
- **Gap and decay.** On a lattice, a positive gap corresponds to exponential decay of correlations under suitable boundary conditions. Decay for one kind of observable (say, plaquettes) is not yet a gap for the whole physical Hilbert space. That needs a rich enough family of gauge-invariant observables and a reconstruction (transfer-matrix) argument in the continuum.
- **Strong coupling on a lattice: solved.** Osterwalder and Seiler (1978); Shen, Zhu and Zhu (2023); a 2025 paper reaches the 't Hooft regime. It is formalized in Lean by Douglas and Rajasekaran ([LGT](https://github.com/mrdouglasny/lgt)): U(n) Wilson theory, β < 1/(32n(d−1)), decay of plaquette–plaquette correlations, uniform in the torus size, no `sorry`.
- **Small volumes: worked out, then stalled.** Lüscher (1983) and van Baal (Leiden) treated the zero-momentum modes on a small torus. Their quartic potential with flat directions gives a gap that scales as g^(2/3). The method breaks down at intermediate volumes, where instantons and the topology of field space take over.
- **Weak coupling, which the continuum limit needs: open.** That is the problem.

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

## Next steps

- [x] Transfer theorem with a residual term, and the combined physical rate (both terms).
- [x] Derive the covariance split from conditional expectations, on finite spaces.
- [ ] Only then decide whether depending on LGT adds anything.
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
