# Is D(p) nondecreasing? A proof attempt on the Bloch sphere (8 November 2026)

**Status:** an attempt, **not a proof.** It gives an exact reformulation of the target as a correlation inequality, two lemmas with proofs, a proof that the most natural geometric route fails, and an exact reduction of the weak-coupling case, with numerical support for each open step. Written by one model family; not yet checked by the other or by a human. The setting and notation are those of [`CPN_MULTI_GATEWAY.md`](CPN_MULTI_GATEWAY.md) §3, open problem P1 in [`HANDOFF.md`](HANDOFF.md) and issue [#146](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/146).

## The target

u and v are pinned in Cᵠ, q ≥ 3, with p = |⟨u,v⟩|². Free hubs x_i are joined to u, v and a with strengths b_i, c_i, e_i ≥ 0. Optional direct edges u–a and v–a have strengths d_u, d_v. a is free. With F(M) = ∫ dω(z) exp(z†Mz), B_i = b_iP_u + c_iP_v and G_i(p) = F(B_i),

  D(p) = ∫ dω(a) e^{d_u|⟨a,u⟩|² + d_v|⟨a,v⟩|²} ∏_i F(B_i + e_iP_a) / ∏_i G_i(p).

If D is nondecreasing, the crossing probability h is nondecreasing for these graphs ([`CPN_MULTI_GATEWAY.md`](CPN_MULTI_GATEWAY.md) §3). D is constant for one hub without direct edges, and nondecreasing for hubs joined to only one of u, v (the separate-routes theorem).

## 1. An exact reformulation: edge energies at the outer site

Let Z_G(p) be the partition function of the whole graph, and Z_{G∖a}(p) = ∏ G_i that of the graph without a. Scale every edge ε at a by t ∈ [0, 1]: ε is (x_i, a) with strength s_ε = e_i, or (u, a) or (v, a). Then

  log D(p) = ∫₀¹ dt Σ_ε s_ε ⟨O_ε⟩_{t,p},  O_ε = |⟨y_ε, a⟩|²,

because ∂_t log Z = Σ_ε s_ε⟨O_ε⟩ and a contributes 1 at t = 0. So:

> **(C) suffices.** If every edge energy at a, ⟨|⟨y, a⟩|²⟩_{t,p}, is nondecreasing in p for every t ∈ [0, 1], then D is nondecreasing.

**Loop form.** In the two-pin positive loop expansion Z(p) = Σ_k A_k pᵏ, where k counts u–v alternation pairs, E[k] = p ∂_p log Z. So

  D′ ≥ 0 ⟺ E_G[k] ≥ E_{G∖a}[k],

and, since ∂_{s_ε} E[k] = p ∂_p⟨O_ε⟩ = Cov(k, N_ε)/s_ε, with N_ε the multiplicity of edge ε,

  (C) ⟺ Cov_t(k, N_ε) ≥ 0 for every edge ε at a and every t.

In words: strengthening any edge at the outer site does not decrease the expected number of u–v alternations. This has the form of a **Griffiths-II inequality** (positive correlation of two "occupation" observables). For O(n) and CP models with n, q ≥ 3, inequalities of this type are known to be delicate ([`CPN_PINNING.md`](CPN_PINNING.md) §10 cites the open GKS-II question for O(3)). We did not find (C) itself in the literature, but did not search beyond that.

*Consistency checks.* For one hub without direct edges, ⟨|⟨x,a⟩|²⟩ = d/de log f_q(e) does not depend on p, so Cov = 0, matching D constant and the p-independence (D6) of the single-gateway no-cross fraction. Numerically, the identity holds to 10⁻⁹. And **(C) held in every test:** 12 random graphs with 2–3 hubs and direct edges, t = 0.25 and 1, every hub edge, p on a 9-point grid. The smallest step was +1.9·10⁻⁶.

## 2. The Bloch-sphere picture

Write W = span(u, v) ≅ C², whose projective directions form a Bloch sphere S². u, v and every hub axis below lie on one great circle Γ of it.

**Eigen-decomposition.** B_i = λ_{i+}P_{w_{i+}} + λ_{i−}P_{w_{i−}}, with w_{i±} orthonormal in W, λ_{i+} + λ_{i−} = b_i + c_i and λ_{i+}λ_{i−} = b_ic_i(1 − p). The Bloch vector of w_{i+} is the hub axis m̂_i, the direction of m_i = b_i n_u + c_i n_v, and λ_{i+} − λ_{i−} = |m_i|.

**Lemma 1 (orthogonal pins are positive).** F(λ₊P_{w+} + λ₋P_{w−} + eP_a), with w± orthonormal, is a power series with nonnegative coefficients in t± = |⟨a, w±⟩|².
*Proof.* Expand into cyclic traces of words in P_{w+}, P_{w−}, P_a. A word with P_{w+} next to P_{w−} vanishes. Every other closed word alternates P_a with single P_{w±}, so its trace is a product of factors ⟨a|w±⟩⟨w±|a⟩ = t±. ∎

So each hub factor is ψ_i(a) = F(B_i + e_iP_a)/G_i = Ψ_i(t_{i+}, t_{i−}), with nonnegative coefficients that depend on p through λ_{i±} and G_i. Write a = √R â + √(1−R) a_⊥, with â ∈ W of Bloch direction n. Then t_{i±} = R(1 ± n·m̂_i)/2, R ~ Beta(2, q−2) independently of n uniform on S², and

  D(p) = E_R ∫_{S²} dn/4π  e^{d_u R(1+n·n_u)/2 + d_v R(1+n·n_v)/2} ∏_i f_i(R, n·m̂_i),  f_i(R, y) = Ψ_i(R(1+y)/2, R(1−y)/2).

**Lemma 2 (each hub factor increases towards its axis).** For fixed R, f_i(R, y) is nondecreasing in y.
*Proof.* ψ_i(a) = E_{ν_i}[g(|⟨x,a⟩|²)] with g(s) = e^{e_i s} convex and increasing, and ν_i ∝ exp(λ_{i−}|P_Wx|² + |m_i| |⟨x, w_{i+}⟩|²).
1. *Phase averaging.* ν_i is invariant under x_⊥ → e^{iθ}x_⊥. Averaging g over θ gives a function of |⟨x_W, a_W⟩| (with |x_⊥|, |a_⊥| fixed). It is nondecreasing: its derivative in s = |⟨x_W, a_W⟩| is 2·avg_θ[g′(X)(s + β cos θ)] ≥ 2·avg[g′]·s ≥ 0, by Chebyshev's inequality, since both factors increase in cos θ.
2. *Two-point symmetrisation.* Let a, a′ have the same R and the same a_⊥, with Bloch directions on a great circle through m̂_i and n_{a′} closer to m̂_i. Choose phases so that ⟨a, a′⟩ is real. The Householder map σ = I − 2hh†, with h ∝ a − a′ ∈ W, is unitary, swaps a and a′, and preserves W, W⊥ and |P_Wx|. On S² it is the half-turn about the bisector b of n_a and n_{a′}.
   - Pair x with σx over H = {|⟨x_W, a′_W⟩| ≥ |⟨x_W, a_W⟩|}, the Bloch half-sphere n_x·(n_{a′} − n_a) ≥ 0. This gives ψ(a′) − ψ(a) = ∫_H [ν(x) − ν(σx)][ĝ(x; a′) − ĝ(x; a)], where ĝ is the phase-averaged integrand.
   - The second bracket is ≥ 0 on H by step 1.
   - The first is ≥ 0 because |⟨x,w₊⟩|² − |⟨x,σw₊⟩|² ∝ n_x·(m̂ − R_b m̂), and m̂ − R_b m̂ = 2(m̂ − (m̂·b)b) is a positive multiple of n_{a′} − n_a when m̂ lies on the a′ side of b. ∎

*Check:* 20 random hubs, y on a 41-point grid, smallest relative step +1·10⁻⁴.

## 3. Why geometry alone cannot work

D depends on p in two ways: the axes m̂_i move along Γ (geometry), and each f_i changes because |m_i| grows and λ_{i−} shrinks (strength).
- If the axes moved monotonically closer, Lemma 2 plus a two-point symmetrisation on S² would suggest that the geometric part helps. Reflecting one axis towards all the others, when they lie on one side, does increase ∫∏f_i; the argument is the same pairing as in Lemma 2.
- **But the axes do not contract monotonically.** Place n_u at angle 0 and n_v at angle θ on Γ, with cos θ = 2p − 1. A hub with c/b = ρ sits at angle φ(ρ) = atan2(ρ sin θ, 1 + ρ cos θ).
  - At p = 0, every hub with ρ > 1 sits exactly at n_v, and every hub with ρ < 1 sits at n_u.
  - As p grows they spread, and only later close up again. For ρ = 2 and 3 the angle between the axes is 0, 0.031, 0.094, 0.173, 0.197, 0.142, 0.055 and 0 at p = 0, 0.001, 0.01, 0.05, 0.2, 0.5, 0.9 and 1.

So near p = 0 the geometric part works *against* monotonicity. Any proof must use that the hubs get stronger at the same time: |m_i|² = b_i² + c_i² + 2b_ic_i(2p − 1) grows fastest exactly there, when ρ is near 1. A proof must couple geometry and strength. That is why no ordering of the axes alone can work, and it is consistent with the stronger alternation-ordering failing in the truncated model ([`CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md`](CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md)).

## 4. Weak coupling at the outer site: an exact reduction

Expand in the strengths at a. With M = Σ e_iP_{x_i} (no direct edges), h₂ = (tr(M)² + tr(M²))/2 and tr M² = Σ e_i² + 2Σ_{i<j} e_ie_j |⟨x_i,x_j⟩|². So

  D(p) = 1 + Σe_i/q + [(Σe_i)² + Σe_i² + 2Σ_{i<j} e_ie_j E|⟨x_i,x_j⟩|²] / (2q(q+1)) + O(e³),

where E is over independent hubs x_i ~ ν_i. At leading order the p-dependence is Σ_{i<j} e_ie_j E|⟨x_i,x_j⟩|². With direct edges, the terms E|⟨x_i,u⟩|² and p also appear.

**A positive series for each hub.** T_i := E_{ν_i}[P_x] satisfies

  T_i = Σ_{ℓ≥0} β_{iℓ}(p) B_iˡ,  β_{iℓ}(p) = E_{j~μ_i^p}[(q)_j/(q)_{j+ℓ+1}],

where μ_i^p(j) ∝ h_j(λ_{i±})/(q)_j is the root-count law of [`CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md`](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md) (A3).
*Derivation.* Expand e^{x†Bx} and use E[(x†Bx)ᵈ P_x] = d!/(q)_{d+1} Σ_{ℓ≤d} h_{d−ℓ} Bˡ, from the moment formula ∫P^{⊗(d+1)} = Σ_π π/(q)_{d+1}. Checked against quadrature to 7·10⁻¹⁵; tr T_i = 1. So

  E|⟨x_i,x_j⟩|² = tr(T_iT_j) = Σ_{ℓ,ℓ′} β_{iℓ}(p) β_{jℓ′}(p) tr(B_iˡ B_jˡ′).

**Lemma 3 (the competition, exactly).**
- (a) Each tr(B_iˡB_jˡ′) is a polynomial in p with nonnegative coefficients (traces of words in two rank-one projectors), so it is nondecreasing.
- (b) Each β_{iℓ}(p) is *nonincreasing*: μ_i^p increases in likelihood ratio with p (the rank-two recurrence), and (q)_j/(q)_{j+ℓ+1} decreases in j.

So the weak-coupling statement is a contest between growing traces and shrinking coefficients, and positivity alone does not settle it. *Numerically* tr(T_iT_j) is nondecreasing for all 40 random pairs tested (strengths up to 4, 11-point p grid, smallest step +5.3·10⁻⁴).

## What a proof needs, and where to start

1. **Weak-coupling lemma first.** Show tr(T_iT_j) is nondecreasing in p for two independent hubs. It lives in C² ⊕ C^{q−2}, and F is explicit (divided differences of exp). It is the simplest case of (C) with real content.
2. **A monotone coupling.** Realise ν_i^p and ν_i^{p′} (p′ > p) on one space, so that the hubs' Bloch points move towards one another and their weight in W does not fall. Lemma 3(b) says the coupling must also shift the root counts.
3. **Duplicate variables.** u and v can be taken real, so every law here is invariant under complex conjugation. That extra structure is what Ginibre's method for O(2) uses. Whether it rescues a Griffiths-II-type statement here is open, and the O(3) failures cited in CPN_PINNING.md §10 are a warning.

(C) is stronger than D′ ≥ 0, and it could fail in a case where D still increases. The tests are small.

## Where I'm unsure

- The link to Griffiths-II is by form. I have not shown that (C) implies, or is implied by, a known open inequality.
- Lemma 2 needed a repair in drafting: the first version ignored interference with the component of a outside W. Step 1 fixes it, and a second reader should check that step.
- The reductions are exact, but the evidence for (C) and for the weak-coupling lemma is numerical only.

## Reproduce

```
cd pilot && python3 cpn_d_monotone_checks.py
```

About 40 seconds. It checks the identity of §1, (C) on random graphs, Lemma 2 numerically, the axis angles of §3, tr(T_iT_j), and the series for T_i with the monotonicity of β_ℓ (Lemma 3(b)).
