# Yang–Mills mass gap

**Aim:** contribute to the mass-gap half of the Clay problem: prove that four-dimensional quantum Yang–Mills theory has a strictly positive mass gap. This folder is a working space. It is not part of the EbE theory, and nothing here is a result until a human expert has checked it.

**Started:** 7 November 2026, by the author with two assistants from different model families.

## Where the problem stands

- **Existence (the other half).** On 26 October 2026, OpenAI announced an AI-produced existence proof for pure Yang–Mills, with a Lean formalization finished on 16 October. A group led by David Gross is reviewing it. It is not public, and it does not claim a mass gap. *Seen only in secondary reports.*
- **Gap equals decay.** A positive mass gap is equivalent to exponential decay of correlations between distant gauge-invariant observables. The decay rate is the gap.
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

LGT already has the bridge for this (`LGT/Bridge/ScaleTransfer.lean`). If the model after k blocking steps decays with rate m, the original model decays with rate at least m/2^k. Two things are missing.

1. **Reaching strong coupling in time.** After k(β) steps, the coarse model must satisfy the Dobrushin condition, which says the sum of influences on one link is below 1. In epidemic terms, R < 1 for influence. The number of steps k(β) may grow at most linearly in β, at the rate set by asymptotic freedom, so that the physical mass m·2^(−k)/a stays bounded below as the lattice spacing a goes to 0.
2. **The term the bridge drops.** The bridge assumes |Cov_fine| ≤ |Cov_blocked|. In general:

   Cov(f, g) = Cov(E[f|B], E[g|B]) + E[Cov(f, g | B)]

   The bridge keeps the first term and drops the second. That is only valid for observables that are functions of the coarse variables B alone. Otherwise one needs a *conditional* gap: decay of correlations for the fine field once the coarse field is fixed.

## Next steps

- [ ] State steps 1 and 2 as precise Lean hypotheses on top of LGT, and prove the conditional theorem that they imply a volume-uniform gap.
- [ ] Prove the corrected bridge in Lean, with the conditional term included.
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
