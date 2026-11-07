# Does the twist estimate of the O(3) proof hold beyond spheres? (7 November 2026)

**Status:** a line-by-line reading of Part 1 of the OpenAI O(n) preprint (Section 2, Lemma 2.1 and Proposition 2.2; Section 3, Proposition 3.1), checked against the text. It is a claim about which assumptions the argument uses. It is **not** a written proof for other models and has not been reviewed.

## Claim

The twist estimate (Proposition 3.1) uses only the following properties of the O(3) model:

| | Property | Where it is used |
|---|---|---|
| P1 | a compact group G acting **orthogonally** on a real vector space, ρ(g)ᵀ = ρ(g⁻¹) | the substitution s_x → ρ(exp(−F_x)) s_x turns the edge factor into ρ(exp F_x · exp(F_y − F_x) · exp(−F_y)) (2.10) |
| P2 | spins on a G-orbit M in the unit sphere, with a **G-invariant** reference measure | every change of variables (Lemma 2.1, (2.10), (3.4)) |
| P3 | an interaction **linear in each spin**, b_e s_xᵀ s_y with 0 ≤ b_e ≤ β | the coefficient bound \|J_e(g₁…g_k)\| ≤ β (2.2): every product of the ρ(g) has operator norm ≤ 1 and \|s\| = 1 |
| P4 | an **su(2) ⊂ Lie(G)** with generators a, b, c, [a, b] = c, and ‖ρ(a)‖, ‖ρ(b)‖, ‖ρ(c)‖ ≤ 1 | (2.11) B_e = ½[F_x, F_y] + O(F³), and the fourth-order cancellation (2.12), which uses half-turn conjugations inside this su(2); D₁₂₃₄B_e is a Lie polynomial in a, b, so it lies in that su(2), where the two fixed spaces meet only in 0 |
| P5 | the graph is a planar annulus | the test family with λ_N ≥ ½ log N (Section 3.1); this concerns the plane, not the target |

Nothing in Sections 2 and 3 uses that M is a sphere: no coordinates of s and no reflection. The reflections and sign clusters enter only in Section 4.

**One change from the O(3) text.** Z(t) is periodic with the period of exp(tρ(c)). In the general case this can be 4π instead of 2π. The final step of Proposition 3.1 then integrates over a distance of at most 2π instead of π. This changes only the constant.

## Models that satisfy P1–P5

- **CP^{N−1}, N ≥ 3.** Use the projector P = z z† as the spin, a vector in the Hermitian N×N matrices with the Frobenius inner product. Then:
  - |z̄_x · z_y|² = tr(P_x P_y), which is linear in each spin (P3), and ‖P‖ = 1;
  - G = SU(N) acts by conjugation, which is orthogonal (P1);
  - the uniform measure on CP^{N−1} is invariant (P2);
  - an su(2) acting on two coordinates gives P4. In the adjoint, its generators (normalised so that [a, b] = c) have eigenvalues 0, ±i/2 and ±i, so the operator norm is ≤ 1.
- **The SU(N) principal chiral model,** Re tr(U_x† U_y) on SU(N) ⊂ ℝ^{2N²}, with G = SU(N) × SU(N) acting by left and right multiplication.
- **RP^{N−1} and Grassmannians,** through the projector embedding in the same way.
- **O(n), n ≥ 4, directly,** with SO(3) ⊂ SO(n) acting on three coordinates. This does not need the reduction to three components.

**Reading (if the claim holds):** for all of these 2D models, rotating the inner boundary of an annulus within an SU(2)-orbit costs at most C_β / log N in the partition function, uniformly over subgraphs and couplings. For CP^{N−1} we have not found this statement in the literature.

## What does not carry over: Part 2

Section 4 turns the twist estimate into exponential decay through:
- **Wolff's reflection embedding:** Ising signs with ferromagnetic couplings, coupled to Edwards–Sokal bonds;
- **FKG association**, including the amplitude association of Campbell and Chayes for O(3);
- **a path count** using the fact that the crossing probability equals 1 − Z(π)/Z(0).

This needs an involutive isometry whose fixed-point set has codimension 1. Caracciolo, Edwards, Pelissetto and Sokal (Nucl. Phys. B 403 (1993) 475) argue that this exists essentially only for spheres.

**For CP^{N−1} the natural embedding is frustrated.** Write z = αe + w and reflect α → −α. Then

  |z̄_x z_y|² = |ᾱ_x α_y|² + |w̄_x w_y|² + 2 Re(ᾱ_x α_y · conj(w̄_x w_y)),

and the Ising coupling 2 Re(…) takes both signs. There are no FK bonds and no association, so Section 4 cannot be used as it stands.

## Open questions, in order of reach

1. **Write out Part 1 for CP^{N−1}** as a proposition with proof, following P1–P5, and have it checked. The algebraic core is the group identity (2.10) together with the fourth-order cancellation (2.12), which could be stated in Lean.
2. **Find a substitute for Part 2.** Options:
   - a frustration-free embedding of a smaller structure, such as the CP¹ = S² inside CP^{N−1};
   - a disintegration in the style of Ding–Huang–Yang;
   - a direct argument from "twist costs nothing" to decay.

   This is where new mathematics is needed.
3. **Only then:** does the result for CP^{N−1}, a 2D model with a U(1) gauge field, instantons and a θ angle, teach anything about 4D? ROUTE.md explains why the symmetry route itself stops at 4D gauge theory.

## Sources

- OpenAI, *Exponential decay in two-dimensional classical O(n) models* (September 2026), github.com/openai/math, `preprints/`: Sections 2–3 read in full; Section 4 read for its ingredients.
- S. Caracciolo, R. G. Edwards, A. Pelissetto, A. D. Sokal, Nucl. Phys. B 403 (1993) 475, arXiv:hep-lat/9205005 (abstract and conference summary checked).
