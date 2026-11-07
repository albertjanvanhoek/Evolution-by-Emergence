# Route: from the 2D O(3) proof to 4D SU(2)? (7 November 2026)

**Status:** a working plan, not a result. It records which parts of the new 2D O(N) proofs might carry over to lattice SU(2) in four dimensions, where they break, and the first open question.

## Why 2D O(3)

2D O(N) with N ≥ 3 is the standard toy model for 4D Yang–Mills. Both are asymptotically free and both are believed to have a mass gap. The abelian case, 2D O(2), is gapless, much as 4D U(1) is gapless at weak coupling. Two proofs of exponential decay for 2D O(N), N ≥ 3, now exist:
- the OpenAI preprint (read in full);
- Ding, Huang and Yang, arXiv:2611.04908 (structure read).

Neither has been peer reviewed. The question here is which *mechanism* can be carried over.

## The mechanism of the OpenAI proof (checked in the text)

- **Proposition 2.2**, a fourth-order rotation inequality. Spins are rotated by spatially varying rotations about two different axes. Because the rotations do not commute, the result has a component along their commutator axis. Summing a fourth derivative of the partition function controls this response, with constants that do not depend on the graph or on the fixed spins.
- **Proposition 3.1**, the annular twist. On an annulus with inner radius N, rotate the inner boundary spins by an angle t. Then min_t Z(t) / max_t Z(t) ≥ 1 − C_β / log N, uniformly over subgraphs and coupling strengths. In particular Z(π)/Z(0) ≥ 1 − C_β / log N.
- **After that,** sign clusters and a coarse path count turn "twisting costs almost nothing" into exponential decay of the spin two-point function. No renormalisation group is used: one scale plus the log N gain.

## Dictionary O(3) → SU(2), corrected

| 2D O(3) | 4D SU(2) | Carries over? |
|---|---|---|
| a continuous global symmetry SO(3) | the continuous SU(2) is a gauge redundancy, not a symmetry; the global symmetry of pure SU(2) is the centre Z₂ | **no** |
| spatially varying rotations change the action (Proposition 2.2) | local SU(2) rotations leave the action exactly invariant; the identity that starts Proposition 2.2 becomes 0 = 0 | **no** |
| boundary twist by a continuous angle t | gluing the boundary with one fixed matrix Ω = exp(tτ₃) can be gauged away (SU(2) is connected), so Z(t) = Z(0); putting exp(tτ₃) into plaquettes is not gauge invariant unless it is central | **no**, as it stands |
| twist by π | 't Hooft twist: a stack of plaquettes multiplied by −1; a separate, discrete Z₂ sector, not the end of a continuous path | the target, yes |
| Z(π)/Z(0) → 1 | vortex free energy → 0; by the Tomboulis–Yaffe inequality (SU(2); extended to SU(N) and to classical spin systems by Kanazawa, arXiv:0808.3442) this gives an area law for Wilson loops | **yes**: this is the statement to prove |
| control: O(2) gapless | control: U(1) gapless at weak coupling (Coulomb phase); for U(1) every element is central, so a continuous twist is gauge invariant | yes |

**Reading.** The goal carries over: show that the 't Hooft twist costs almost nothing in a large volume. The tool does not: the OpenAI argument needs a continuous path of twists and a continuous global symmetry, and pure SU(2) gauge theory has neither.

## Three warnings

1. **The breakdown is at the first line.** It is not somewhere deep in Proposition 2.2.
2. **Confinement is not yet a gap.** Tomboulis–Yaffe gives an area law for Wilson loops. The Clay problem asks for a gap: decay of correlations of local gauge-invariant observables, plus the reconstruction of a quantum theory. The OpenAI paper also treats only the spin two-point function.
3. **A related route is disputed.** Tomboulis (arXiv:0707.2179) claimed confinement at all couplings via the vortex free energy and a decimation step. Ito and Seiler (arXiv:0711.4930, 0803.3019) pointed out missing links. Tomboulis replied (arXiv:0712.2620), and Ito and Seiler maintained their critique. The disputed part is the decimation step, the same kind of step that failed in our own pilot. The OpenAI proof avoids renormalisation; that is what makes it interesting here.

## First open question

> **Is there a gauge-invariant, continuous family of defects in 4D SU(2) that becomes the 't Hooft twist at t = π, and for which an inequality like Proposition 2.2 holds? Or can one show that no such family exists?**

**A candidate (not checked beyond gauge invariance).** On the same stack of plaquettes as the 't Hooft twist, replace each plaquette weight exp(β tr U_p / 2) by

  w_t(U_p) = ∫ dh exp(β tr(U_p h D_t h⁻¹) / 2),   D_t = exp(tτ₃), h Haar on SU(2).

- **Gauge invariance:** w_t depends only on the conjugacy class of U_p, so it is gauge invariant.
- **The end points:** at t = 0 it is the usual weight; at t = π, D_π = −1 is central and w_π is the 't Hooft twist.
- **Expected difference from O(3):** for 0 < t < π the stack is *not* topological. Its position matters, so it is a physical surface with a cost per unit area.

**The first test.** Z(t)/Z(0) for this defect in 4D SU(2), for growing L, in the confined (strong-coupling) regime:
- If it decays like exp(−τ(t)L²) with τ(t) > 0 for 0 < t < π, this path is closed. The OpenAI argument needs min_t Z(t)/max_t Z(t) close to 1. The profile would then also have to become singular at t = π as L grows.
- If τ(t) → 0, the path is open, and the commutator estimate is worth trying.

**Control:** U(1), with a continuous central twist, in both its confined and its Coulomb phase.

**Result** (`pilot/gauge_twist.py`, last section of `pilot/RESULTS.md`). For 4D SU(2) at β = 1.8, 2.2 and 2.5 on L = 4, 6, 8:
- **The intermediate defect costs area.** f(π/2) = −(1/L²) log(Z(π/2)/Z(0)) stays at about 0.045 (β = 1.8) and 0.19 (β = 2.2) as L grows.
- **The 't Hooft end point costs nothing within the errors** (L ≥ 6).
- **The U(1) control behaves as expected:** no cost when confined, and a finite total cost in the Coulomb phase.

So **this candidate path is closed:** there is a barrier proportional to the area between two cheap end points. The cost is not classical. Every element of SU(2) is a commutator, so a configuration with zero action away from the stack exists for every t. The cost comes from fluctuations.

**What this leaves.** The O(3) mechanism needs a family of twists whose cost vanishes uniformly. In 4D SU(2) the cheap twists found so far are only the discrete centre twists. Options:
1. a different gauge-invariant interpolation (none known to us);
2. a mechanism that works with the discrete Z₂ twist directly, which is the setting of Tomboulis–Yaffe;
3. the loop-soup route of Ding–Huang–Yang, whose gauge-theory analogue would involve random surfaces. Not yet read.

## Not started

- **A Lean statement** of the gauge-invariance claim for w_t, and of the triviality of a constant gluing twist.
- **Experts:** Erhard Seiler (Max Planck Institute for Physics, Munich; co-author of the critique of Tomboulis). For the decimation side question, Aernout van Enter (Groningen).

## Sources

- OpenAI, *Exponential decay in two-dimensional classical O(n) models* (September 2026), github.com/openai/math, `preprints/`. Propositions 2.2 and 3.1 checked in the text.
- J. Ding, F. Huang, H. Yang, arXiv:2611.04908.
- E. T. Tomboulis, L. G. Yaffe, Commun. Math. Phys. 100 (1985) 313 (as cited by Kanazawa; not read here).
- T. Kanazawa, *Generalizing the Tomboulis–Yaffe inequality to SU(N) lattice gauge theories and general classical spin systems*, arXiv:0808.3442 (abstract checked).
- E. T. Tomboulis, arXiv:0707.2179 (as cited by Ito and Seiler; not read), and reply, arXiv:0712.2620 (abstract checked).
- K. R. Ito, E. Seiler, arXiv:0711.4930 and arXiv:0803.3019 (abstracts checked).
