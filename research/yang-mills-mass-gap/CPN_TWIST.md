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

## The general statements, step by step

**Setting.**
- G is a compact connected Lie group with an orthogonal representation ρ on a finite-dimensional real inner-product space (V, ⟨·,·⟩).
- M ⊂ {s ∈ V : ‖s‖ = 1} is a G-invariant compact set with a G-invariant probability measure μ.
- a, b, c ∈ Lie(G) satisfy [a, b] = c, [b, c] = a, [c, a] = b, and the skew operators dρ(a), dρ(b), dρ(c) have operator norm ≤ 1. Below, a, b, c also denote these operators.
- On a finite graph with oriented edges e = (x, y), strengths 0 ≤ b_e ≤ β, and arbitrary fixed spins s_x ∈ M on a set P, the other spins are integrated against μ with weight exp(Σ_e b_e ⟨s_x, s_y⟩).
- For an edge field A_e ∈ Lie(G), put H(A) = Σ_e b_e ⟨s_x, (ρ(exp A_e) − I) s_y⟩ and W(A) = ⟨exp H(A)⟩.

**Proposition 2.2′ (general).** The O(3) inequality (2.8) holds with the same K_rot(β) = 6β² + 4β^{3/2} + β, uniformly in the graph, the family, and the fixed spins.

**Proposition 3.1′ (general).** On any subgraph of the annulus D_N, pin the inner layer to ρ(exp(tc)) s* and the outer layer to s*, for any s* ∈ M. Then min_t Z(t) / max_t Z(t) ≥ 1 − C_β / log N.

**Check against the O(3) proof, equation by equation.**

| O(3) step | What it uses | Holds in the general setting because |
|---|---|---|
| (2.2) coefficient bound \|J_e(g₁…g_k)\| ≤ β | J_e is b_e times a symmetrised ⟨s_x, g_{π(1)}⋯g_{π(k)} s_y⟩ | ‖g‖_op ≤ 1 and ‖s‖ = 1 |
| Lemma 2.1, (2.5): W(t(df)g) = 1 | substitution s_x → ρ(exp(−t f_x g)) s_x off P; rotations about one axis commute | μ is G-invariant (Jacobian 1); f = 0 on P; ρ(exp(t f_x g)) ρ(exp(t(f_y − f_x)g)) ρ(exp(−t f_y g)) = I |
| (2.6) the formula for R and its bound | differentiating twice; (2.2) | as above |
| (2.10) W(dF) = W(B) | substitution with F_x ∈ span(a, b) | ρ is a homomorphism and orthogonal: ⟨ρ(u)s, ρ(v)s'⟩ = ⟨s, ρ(u⁻¹v)s'⟩; the product of group elements is exp(B_e) |
| (2.11) B_e = ½[F_x, F_y] + O(F³) | the Baker–Campbell–Hausdorff formula | BCH holds in any Lie algebra. B_e is a Lie series in a and b, so it lies in span(a, b, c), where the bounds (2.2) hold |
| (2.12) D₁₂₃₄B_e = 0 for the pattern (a, b, a, b) | half-turn conjugations fix a and negate b (and the reverse); their fixed spaces in so(3) are ℝa and ℝb | θ_a = Ad(exp(πa)) and θ_b are automorphisms of Lie(G). BCH is equivariant under automorphisms. On span(a, b, c) ≅ so(3) they act as the half-turns, and D₁₂₃₄B_e lies in that span |
| (2.13)–(2.15) the identity for R(Q, Q̄) | complex multilinear extension | it is pure algebra |
| (2.16)–(2.17) the cross terms | gradient invariance and (2.6) | as above |
| (2.19)–(2.20) the non-negative square | X and H₂ are real on real edge forms | ρ is real and the spins are real vectors |
| the eleven-row table | (2.2) and (2.22) | as above |
| (3.4) the boundary gauge | substitution with Θ(x/N)c; Θ = 1 on the inner layer and 0 on the outer layer | invariance of μ; the inner pinned value becomes ρ(exp((t + s)c)) s* |
| Section 3.1, Lemma 3.2 | Fourier modes on the planar annulus | it does not involve the target |
| Section 3.2, the final step | Z(t) is smooth, positive and periodic | Z depends on t only through ρ(exp(tc)) s*, whose period divides 4π. A period of 4π changes π²/2 into 2π² in the last line, which only affects the constant |

**CP² as an example.**
- **Spin and interaction.** V = Hermitian 3×3 matrices with ⟨A, B⟩ = tr(AB); M = {P = zz† : z ∈ ℂ³, ‖z‖ = 1}; ρ(U)P = UPU†; ⟨P_x, P_y⟩ = |z̄_x · z_y|².
- **Generators.** Take T₁, T₂, T₃ as the su(2) generators on (e₁, e₂), with eigenvalues ±i/2 in the fundamental and suitable signs so that [a, b] = c with a = ad T₁, and so on. The eigenvalues of ad T_k on V are 0, ±i/2 and ±i, so the norm is ≤ 1.
- **Boundary twist.** Choose s* = e₁e₁† and c = ad T, with T the real rotation generator in the (e₁, e₂)-plane. The inner boundary is then z(t) = cos(t/2) e₁ + sin(t/2) e₂. At t = π this is e₂, orthogonal to e₁ (the antipode in CP¹). The period of Z is 2π.

**Status.** Every step above has a reason. We have not written the proof out in full and nobody has reviewed it. The point most worth a second look is the claim that BCH equivariance gives (2.12) inside a larger Lie(G).

## Numerical companion (pilot/annulus_twist.py; pilot/RESULTS.md, last section)

The annulus N ≤ ‖x‖∞ ≤ 2N, with the inner layer rotated by t. The twist cost f(π/2), from N = 4 to 32:
- **O(2) at β = 2,** the negative control: 22.5 → 21.4, close to constant.
- **O(3) at β = 2,** the positive control: 18.3 → 12.3, falling 11–15% per doubling.
- **CP² at β = 3:** 6.6 → 0.
- **CP² at β = 6:** 27.4 → 21.7 at N = 16, at the same rate as O(3) at the matched coupling. N = 32 is inconclusive because the sampler mixes slowly.

This tests the mechanism, not the proof: a falling cost is also what a mass gap gives.

## What does not carry over: Part 2

Section 4 turns the twist estimate into exponential decay through:
- **Wolff's reflection embedding:** Ising signs with ferromagnetic couplings, coupled to Edwards–Sokal bonds;
- **FKG association**, including the amplitude association of Campbell and Chayes for O(3);
- **a path count** using the fact that the crossing probability equals 1 − Z(π)/Z(0).

Caracciolo, Edwards, Pelissetto and Sokal (Nucl. Phys. B 403 (1993) 475) argue that an embedding of this kind works well only when it is based on an involutive isometry whose fixed-point set has codimension 1, which is essentially only the sphere. **That is a heuristic argument about algorithms, not a theorem that rules out other cluster or correlation methods** (point from review).

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
