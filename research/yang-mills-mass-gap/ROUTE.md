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
| twist by π, a real change of boundary direction | 't Hooft twist: a stack of plaquettes multiplied by −1, a separate, discrete Z₂ sector. **Not the image of the O(3) π-twist**: SU(2) is the double cover of SO(3), the lift of an SO(3) rotation by π is iσ₃ (not central), and −1 is the lift of a rotation by 2π, which acts trivially on O(3) spins (correction from review). In our defect family D_t = exp(itσ₃) acts on the adjoint as a rotation by 2t. | the target, yes; the bridge, no |
| Z(π)/Z(0) → 1 | vortex free energy → 0; by the Tomboulis–Yaffe inequality (SU(2); extended to SU(N) and to classical spin systems by Kanazawa, arXiv:0808.3442) this gives an area law for Wilson loops | **yes**: this is the statement to prove |
| control: O(2) gapless | control: U(1) gapless at weak coupling (Coulomb phase); for U(1) every element is central, so a continuous twist is gauge invariant | yes |

**Reading.** The goal carries over: show that the 't Hooft twist costs almost nothing in a large volume. The tool does not: the OpenAI argument needs a continuous path of twists and a continuous global symmetry, and pure SU(2) gauge theory has neither.

## Four warnings

1. **The breakdown is at the first line.** It is not somewhere deep in Proposition 2.2.
2. **The scaling the two settings need differs.** The O(3) proof gets a twist cost of order 1/log N. Tomboulis–Yaffe needs a vortex free energy that is exponentially small in the transverse area. The first does not give the second (point from review).
3. **Confinement is not yet a gap.** Tomboulis–Yaffe gives an area law for Wilson loops. The Clay problem asks for a gap: decay of correlations of local gauge-invariant observables, plus the reconstruction of a quantum theory. The OpenAI paper also treats only the spin two-point function.
4. **A related route is disputed.** Tomboulis (arXiv:0707.2179) claimed confinement at all couplings via the vortex free energy and a decimation step. Ito and Seiler (arXiv:0711.4930, 0803.3019) pointed out missing links. Tomboulis replied (arXiv:0712.2620), and Ito and Seiler maintained their critique. The disputed part is the decimation step, the same kind of step that failed in our own pilot. The OpenAI proof avoids renormalisation; that is what makes it interesting here.

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

## The second proof: loop soups (Ding–Huang–Yang)

**Their mechanism** (introduction and outline, read in the text):
1. **A loop-soup representation of the O(N) model.** By Lupu's isomorphism, the squared spin components are the local times of independent loop soups, conditioned on their total. This works for real N, so N can be varied continuously.
2. **Split off one component.** Condition on the z-copy. What remains is an XY model with random, nonnegative couplings β r_u r_v, where r is the length of the projection onto the xy-plane. This step uses the fact that the interaction σ_u · σ_v is a **sum over components**.
3. **"Many loops" in the z-copy leave little local time for the x- and y-copies** at each scale with fixed probability. The good region becomes a fractal percolation with small volume.
4. **An improved spin-wave argument then makes crossings unlikely**, and a coarse-graining step gives exponential decay. Spin waves are the 2D argument of Mermin and Wagner, and they need the logarithmic softness of the 2D XY model.

The authors sum it up as "a slight perturbation of the XY model from the loop soup perspective produces exponential decay" (Remark 1.5). Non-commutativity is not used as such: what matters is the extra component.

**Where it does not carry over to 4D SU(2)** (our reading):
- **Step 2 needs an interaction that splits by component.** For a gauge theory, tr(U₁U₂U₃†U₄†) multiplies group elements, which mixes their components. Restricting SU(2) to a U(1) subgroup is not closed under products (for U = [[α, −β̄], [β, ᾱ]], the α of a product is α₁α₂ − β̄₁β₂). Conditioning therefore does not leave a U(1) gauge theory with random couplings, unless one fixes a gauge (abelian projection).
- **Step 1 has an analogue, but not a positive one.** Cao, Park and Sheffield (arXiv:2307.06790, abstract checked) write Wilson-loop expectations as sums over embedded planar maps, for any β and any dimension. The weights involve Weingarten functions. As we understand it these take both signs, so the result is not a probability measure as Lupu's loop soup is. Not checked in the text.
- **Step 4 needs the abelian part to be only just ordered.** In 2D the XY model has only quasi-long-range order, and a slight perturbation can destroy it. The 4D analogue, U(1) gauge theory, has a genuine Coulomb phase at weak coupling, proven by Guth (Phys. Rev. D 21 (1980) 2291, as cited by Ito and Seiler; not read), and our own U(1) control shows its finite twist cost. It is not marginal in the same way.

## What the two proofs point to

Each of the two 2D proofs maps onto one of the classic physical pictures of confinement in 4D:
- **OpenAI, twist and sign clusters → centre vortices.** A goal that carries over (cheap 't Hooft twist; Tomboulis–Yaffe), but no continuous path. Tested above: the natural path costs area.
- **Ding–Huang–Yang, an abelian part destabilised by an extra component → abelian projection.** A U(1) part plus charged components, the "dual superconductor" picture. In 4D this needs the charged components to destroy a robust Coulomb phase, which is itself a long-standing open problem.

Both pictures are decades old and unproven in 4D. So the new 2D proofs do not shorten the way to Yang–Mills directly. They do give each picture a 2D model in which it is now a theorem.

**This is our reading, not established.** It is the question to put to an expert.

## Why there is no 4D analogue of the twist mechanism (sources checked as stated)

The measured area cost has a structural explanation.
- **The twist in the O(3) proof uses a global symmetry.** It is a continuous, non-abelian 0-form symmetry, SO(3), and the proof uses rotations about two non-commuting axes.
- **In a gauge theory, twists such as the 't Hooft twist are generated by 1-form symmetries.** These act on lines, not on points.
- **Higher-form symmetries are always abelian.** The operators that generate them live on surfaces of codimension 2 or more, so they can be moved past each other, and their order does not matter. This is in Gaiotto, Kapustin, Seiberg and Willett, *Generalized global symmetries* (arXiv:1412.5148; stated in Seiberg's lecture slides and in Lake, arXiv:1802.07747, which also cites Henneaux–Teitelboim).
- **So there is no non-abelian twist to rotate.** Pure SU(2) has only the discrete 1-form symmetry Z₂.
- **A twist is cheap when it is a symmetry operator,** because such operators are topological and their position does not matter. A non-central twist is not a symmetry operator: it is a physical surface, and it generically costs energy per unit area. That is what we measured.

**The dimension count points the same way.** A continuous q-form symmetry cannot be spontaneously broken unless the spacetime dimension is larger than q + 2 (Seiberg's slides; Lake, arXiv:1802.07747). For 0-form symmetries the borderline dimension is 2, and that is where the O(N) models live. For 1-form symmetries it is 3. There the abelian gauge model, 3D compact U(1), is already proven to confine at all couplings:
- Göpfert and Mack, Commun. Math. Phys. 82 (1982) 545, for the Villain action;
- a short proof for groups with a central U(1): Chatterjee, arXiv:2602.00436 (abstract checked).

4D SU(2) sits at the borderline for a different reason: its coupling has no dimension. Its gap is not tied to any continuous symmetry. **The symmetry route from 2D O(3) does not lead to 4D Yang–Mills.** This is our conclusion from the sources above, not a theorem.

## A rung that may be within reach: 2D sigma models beyond spheres

Both 2D proofs depend on the target being a sphere in at least one step.
- **OpenAI.**
  - **Part 1, the twist estimate** (Propositions 2.2 and 3.1), uses only an so(3) of isometries acting on the target. That includes [a, b] = c and the half-turn argument for the fourth-order cancellation. Our reading is that it should carry over to any target with an isometric SU(2) or SO(3) action. Not checked in detail.
  - **Part 2, sign clusters and association** (Section 4), uses Wolff's reflection embedding: Ising signs with ferromagnetic couplings, Edwards–Sokal bonds, FKG association (Campbell–Chayes).
  - **Part 3, the reduction from n components to 3,** uses spherical disintegration.
- **Ding–Huang–Yang** use loop soups and Lupu's isomorphism, which are built on the components of a vector in a sphere.

Caracciolo, Edwards, Pelissetto and Sokal, *Wolff-type embedding algorithms for general nonlinear σ-models* (Nucl. Phys. B 403 (1993) 475; abstract and talk checked), argue that such an embedding works well, for asymptotically free models, only when it is based on an involutive isometry whose fixed-point set has codimension 1. That is essentially the sphere.

For **CP^{N−1}**, our own short calculation gives an indefinite sign:
- write z = αe + w and reflect α → −α;
- the term |z̄_x z_y|² then gives an Ising coupling 2 Re(ᾱ_x α_y · conj(w̄_x w_y)), which can be negative, so the embedding is frustrated.

**Open question for us:**

> Does the twist estimate (Part 1) hold for the 2D CP^{N−1} model, N ≥ 3, or the SU(N) principal chiral model, N ≥ 3? And what can replace sign clusters (Part 2) when no unfrustrated Ising embedding exists?

Remarks:
- The SU(2) principal chiral model is the O(4) model (SU(2) ≅ S³), so it is already covered by the O(n) proof. The suggestion from review to use it as an intermediate step is therefore already settled.
- CP^{N−1} is closer to Yang–Mills than O(3): it has a U(1) gauge field, instantons and a θ angle.
- As far as we have found, its mass gap at all couplings has no rigorous proof. The literature we found is heuristic: large N, instantons, resurgence. Not exhaustively searched.

## Not started

- **A Lean statement** of the gauge-invariance claim for w_t, and of the triviality of a constant gluing twist.
- **Experts:** Erhard Seiler (Max Planck Institute for Physics, Munich; co-author of the critique of Tomboulis). For the decimation side question, Aernout van Enter (Groningen).

## Sources

- D. Gaiotto, A. Kapustin, N. Seiberg, B. Willett, *Generalized global symmetries*, arXiv:1412.5148; N. Seiberg, lecture slides (2015); E. Lake, arXiv:1802.07747.
- M. Göpfert, G. Mack, Commun. Math. Phys. 82 (1982) 545; S. Chatterjee, arXiv:2602.00436.
- S. Caracciolo, R. G. Edwards, A. Pelissetto, A. D. Sokal, Nucl. Phys. B 403 (1993) 475 (arXiv:hep-lat/9205005).

- OpenAI, *Exponential decay in two-dimensional classical O(n) models* (September 2026), github.com/openai/math, `preprints/`. Propositions 2.2 and 3.1 checked in the text.
- J. Ding, F. Huang, H. Yang, arXiv:2611.04908 (introduction and outline read; Remark 1.5 quoted).
- S. Cao, M. Park, S. Sheffield, *Random surfaces and lattice Yang–Mills*, arXiv:2307.06790 (abstract checked).
- E. T. Tomboulis, L. G. Yaffe, Commun. Math. Phys. 100 (1985) 313 (as cited by Kanazawa; not read here).
- T. Kanazawa, *Generalizing the Tomboulis–Yaffe inequality to SU(N) lattice gauge theories and general classical spin systems*, arXiv:0808.3442 (abstract checked).
- E. T. Tomboulis, arXiv:0707.2179 (as cited by Ito and Seiler; not read), and reply, arXiv:0712.2620 (abstract checked).
- K. R. Ito, E. Seiler, arXiv:0711.4930 and arXiv:0803.3019 (abstracts checked).
