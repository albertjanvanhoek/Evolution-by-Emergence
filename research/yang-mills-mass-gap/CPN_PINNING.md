# CP^{N−1}: pinning tilt, colour switch, and a two-vertex pinning comparison (7 November 2026)

**Status:** derivations for review, building on CPN_STEP4.md and CPN_WIRING_MARKOV.md. One result is general: the two-vertex comparison in §3. The rest records checks and what is still open.

**Setting:** the CP^{q−1} projector model on a finite graph G, with strengths b_e ≥ 0. In the loop expansion (Wolff 2010; CPN_POSITIVE_LOOPS.md), a configuration consists of:
- edge multiplicities n_e, with weight ∏ b_e^{n_e}/n_e!;
- at every free vertex x of degree d_x = Σ_{e∋x} n_e, a strand permutation π_x ∈ S_{d_x}, with weight 1/(q)_{d_x};
- a factor q for every closed loop, which comes from summing the index (colour) carried by the loop.

## 1. Check of CPN_WIRING_MARKOV.md (W2–W5)

**The gluing rule.** The number of loops is ℓ = ℓ_out + ℓ_in + #cycles(σ∘π). It holds because every loop that crosses the cut alternates between outside segments, given by σ, and inside segments, given by π. Composing σ and π therefore gives one cycle per crossing loop.

**The two-strand table.** For one edge of multiplicity 2 between a free u (inside) and a free v (outside), the weights are:

| | π = I (inside, no swap) | π = s (inside, swap) |
|---|---|---|
| σ = I (outside, no swap) | q² | q |
| σ = s (outside, swap) | q | q² |

So P(π = s | σ = I) = 1/(q + 1) and P(π = s | σ = s) = q/(q + 1), that is 1/4 and 3/4 at q = 3. **Confirmed.**

## 2. The pinning tilt, derived

Pin every vertex of a set B to the same rank-one projector u u†. In index form this forces every strand at B to carry the index of u. Consider the free model with a configuration (n, π) and colours summed over. The conditional weight of "every strand at B has colour 1" is q^{−k_B}, where k_B is the number of loops that meet B. Each such loop loses its free choice of colour.

The pinned model also has no vertex factor and no permutation at B: strands end there. Summing over π_x for x ∈ B in the free model gives d_x! permutations, which all have colour 1 at x. Comparing the two gives, for the law of (n, π outside B):

  **P_pinned ∝ P_free · T, with T = q^{−k_B} · ∏_{x∈B} (q)_{d_x}/d_x!.**

**Check on the path A–x–B** with B = {A, B}. Every loop meets B, so q^{#loops − k_B} = 1. Then

  Σ (b₁^{n₁}/n₁!)(b₂^{n₂}/n₂!) · [n₁!/(q)_{n₁}] · [(n₁ + n₂)!/(q)_{n₁+n₂}] · [n₂!/(q)_{n₂}] · [(q)_{n₁}/n₁!] · [(q)_{n₂}/n₂!] = Σ b₁^{n₁} b₂^{n₂} (n₁ + n₂)! / (n₁! n₂! (q)_{n₁+n₂}) = f_q(b₁ + b₂) = Z_pin. ✓

T is the CP analogue of the O(3) tilt 2^{−k_B} in Proposition 4.5. It has an extra degree factor (q)_d/d! = C(q + d − 1, d), which increases with d.

## 3. A general two-vertex pinning comparison

> **Proposition (two vertices, any graph).** Let G be any finite graph with b_e ≥ 0, q ≥ 2, and A ≠ B two vertices. Then
>   P_free(some loop visits both A and B) ≤ P_{A, B pinned equal}(some strand joins A and B) = 1 − Z_⊥/Z_∥,
> where Z_∥ and Z_⊥ are the partition functions with A and B pinned to equal and to orthogonal projectors.

**Proof.**
1. **No-cross weights agree.** Fix all n and all π_y for y ∉ {A, B}. Whether a strand leaving A reaches B before it returns to A does not depend on π_A or π_B. So the event "no loop visits both A and B" (NC) does not depend on π_A or π_B. On NC, the strands at A return to A through a fixed permutation ρ_A, and likewise for B. Since π ↦ π∘ρ is a bijection of S_d, and Σ_{σ∈S_d} q^{#cycles(σ)} = (q)_d, we get Σ_{π_A} q^{#loops through A} = (q)_{d_A}. This cancels the vertex factor 1/(q)_{d_A}, and the same holds at B. What remains is ∏ b^{n}/n! · ∏_{y∉{A,B}} 1/(q)_{d_y} · q^{#loops avoiding A and B}. That is exactly the weight of the pinned configurations with K = 0 (strands ending at A and B, colour forced). Hence Z_{free, NC} = Z_{pin, K=0}. This is the same for equal and for orthogonal pins, and it equals Z_⊥.
2. **The free partition function is not larger.** By SU(q) invariance, Z_free = ∫∫ Z_pin(z_A, z_B) = E_{p∼Beta(1, q−1)}[Z_pin(p)]. Here Z_pin(p) = Z_∥ E_∥[p^K] ≤ Z_∥, because the weights are non-negative (CPN_POSITIVE_LOOPS.md, (L8)).
3. **Combine.** P_free(NC) = Z_⊥/Z_free ≥ Z_⊥/Z_∥ = P_∥(K = 0). ∎

This generalises the path result in CPN_BOUNDARY_COMPARISON.md to every finite graph, for two single vertices. It is the CP analogue of Proposition 4.5 for one crossing event between two points.

## 4. Colour switch (Lees–Taggi) for CP

The vertex weight 1/(q)_{d_x} does not depend on colours. Recolouring an entire loop is therefore a weight-preserving bijection. For O(N) this is the hard part of Lees and Taggi's colour-switch lemma, because there the on-site weights depend on how many times each colour visits. For CP it holds exactly. It is precisely what produces the factor q^{−k_B} in §2. **But it does not by itself give an inequality.** The pinning comparison is a correlation statement about the uncoloured law of (n, π) with the tilt T.

## 5. What remains open

1. **Layers instead of single vertices.** For the annulus, B is a whole layer. The proof in §3 uses that each of A and B is a single vertex: the sum over π_A alone produces (q)_{d_A}. For a layer, loops between different layer vertices (I → I) are closed loops with weight q in the free model, but cut strands with weight 1 in the pinned model. So the no-cross weights no longer agree. Possible routes:
   - (a) a "fusion" comparison: constrain all spins of a layer to be equal (common direction integrated), which makes the layer one vertex, and then apply §3;
   - (b) a direct correlation inequality for T.
2. **Several annuli at once:** the intersection of crossing events (Prop. 4.6 needs this), and the effect of exterior wiring (CPN_WIRING_MARKOV.md).

**Event definitions.** For the annulus, "a loop visits both layers" (free) contains the event "a loop segment inside the annulus joins the layers". In the pinned system, every strand from I to O lies inside the annulus. So a layer version of §3 with the "anywhere" event would already be enough for Prop. 4.6 with a single annulus.

## Proposed split of work (to agree with the other assistant)

- **This assistant:** have §3 checked, then try route 1(a), the fusion comparison, analytically.
- **The other assistant:**
  - exact enumeration on tiny graphs of the layer version, P_free(loop visits I and O) against P_pinned, with |I| = 2 and |O| = 1 or 2, and with and without edges inside a layer. A counterexample would rule out the direct layer version;
  - continue the Lees–Taggi-type switching for the multi-annulus case.

## 6. Route 1(a), fusion: a reduction, with checks (pilot/cpn_fusion_check.py)

**Review of the other assistant's layer enumeration (CPN_LAYER_ENUMERATION.md).**
- **The no-cross counterexample is correct.** Take A₁ and A₂ in one layer, joined to a free x, with one strand on each edge. Free gives 1/q². Pinned gives 2/(q(q+1)). The difference is (q − 1)/(q²(q + 1)) = 1/18 at q = 3. This is the I → I effect of §5: §3 does not carry over to layers as it stands.
- **The articulation-vertex result is consistent with §3.** It rests on the identity (1/(q)_d) Σ_π q^{#cycles(πρ)} = 1, which is our step (i).

**Fusion.** Force all spins of a layer to be equal, with the common direction uniform. Call this "fused". It is the CP model on the graph with each layer contracted to a single vertex (edges inside a layer become constants). It sits between free and pinned:
1. **Fused ≤ pinned: proven.** Apply §3 to the contracted graph. Pinning the contracted vertices is the same as pinning the layers.
2. **Free ≤ fused: open.** Fusing is the limit of free with infinite couplings inside each layer. So it would follow if **the crossing probability does not decrease when a coupling inside a layer is increased**. That is a monotonicity statement of Griffiths type, and we have no proof.

**How fused is computed without enumerating the fused vertex.**
- By SU(q) invariance, Z_fused = E_{p∼Beta(1,q−1)}[Z_pin(p)] = Σ_k c_k k!/(q)_k, where c_k is the equal-pinned weight with K = k strands from I to O.
- By §3 on the contracted graph, Z_fused,NC = c₀.
- So P_fused = 1 − c₀ / Σ_k c_k k!/(q)_k. For the star and the bipartite 4-cycle (K = 1) this matches a direct enumeration of the contracted graph.

**Exact finite-truncation results** (CP², β = 1 unless stated; edge multiplicity ≤ K; enumerator from the other assistant):

| graph (layers I, O) | K | P_free | P_fused | P_pinned |
|---|---|---|---|---|
| star, I = 2, O = 1 | 1 | 0.02969 | 0.03182 | 0.08974 |
| star, I = 2, O = 1 | 2 | 0.05031 | 0.05528 | 0.15189 |
| bipartite 4-cycle, I = 2, O = 2 | 1 | 0.68363 | 0.73684 | 0.93750 |
| bipartite 4-cycle, I = 2, O = 2 | 2 | 0.75182 | 0.82008 | 0.97440 |
| 4-cycle with an edge inside I | 1 | 0.26181 | 0.26316 | 0.52273 |
| 4-cycle with an edge inside I | 2 | 0.31342 | 0.31623 | 0.63097 |
| I = 2, O = 2 through two free middles | 1 | 0.03259 | 0.03333 | 0.09469 |
| I = 2, O = 2 through two free middles | 2 | 0.05657 | 0.05874 | 0.16184 |
| star plus an edge inside I with b = 3 | 2 | 0.05134 | 0.05528 | 0.15189 |

**Findings**
- **P_free ≤ P_fused ≤ P_pinned in every case.**
- **The step from free to fused is small** (1–10%). The large step, from fused to pinned, is the one that is proven.
- **Monotonicity in the inside coupling shows in the star:** 0.05031 (no inside edge) < 0.05134 (b = 3) < 0.05528 (fused).

**So the layer version now rests on one monotonicity conjecture:** in the CP loop model, the crossing probability between two layers does not decrease when couplings inside a layer increase.

**Limits.** Finite Taylor truncation (K ≤ 2), q = 3, five small graphs. A large b inside a layer is poorly represented at K ≤ 2, so the limit b → ∞ was not checked numerically.

## 7. First test of the monotonicity conjecture, without truncation (pilot/cpn_layer_monotonicity.py)

**Graph:** the smallest case where the star proof no longer applies. A star with I = {i₁, i₂}, O = {o}, centre x, b = 1 on the three star edges, and **an extra coupling t between i₁ and i₂**, inside layer I. CP², q = 3.

**Exact reduction (derived here).**
- **Crossing given the multiplicities.** Given all multiplicities, P(no crossing) = (q)_a (q)_c / (q)_{a+c}, where a = n(i₁x) + n(i₂x) and c = n(xo). It does **not** depend on the multiplicity m of the i₁–i₂ edge. Summing over the permutations at x gives (q)_{n₁+n₂} for any return map through i₁ and i₂, as in the two-vertex lemma, and the loops that avoid x cancel between numerator and denominator.
- **Multiplicities given the spins.** Given the spins, each n_e is Poisson(b_e |z̄_u z_v|²), independently across edges.
- **So the crossing probability is a spin average:** P_t(cross) = E_t[H(b(w₁ + w₂), b w₃)], with w₁ = |z̄_{i₁} z_x|², w₂ = |z̄_{i₂} z_x|², w₃ = |z̄_o z_x|², and H(λ, μ) = Σ_{a,c} Pois(a; λ) Pois(c; μ)(1 − (q)_a(q)_c/(q)_{a+c}). This is exact, with no Taylor truncation.

**Computation.** 4 × 10⁶ uniform spin samples, reweighted to each t. Differences are taken on the same samples.

| t | P_t(cross) |
|---|---|
| 0 | 0.057156 ± 0.000033 (exact star value: 0.057206) |
| 0.5 | 0.057428 |
| 1 | 0.057712 |
| 2 | 0.058303 |
| 4 | 0.059440 |
| 8 | 0.060946 ± 0.00012 |
| ∞, fused (exact) | 0.063468 |

Consecutive differences, on the same samples: +0.000272 ± 0.000003, +0.000284 ± 0.000003, +0.000591 ± 0.000007, +0.00114 ± 0.00002, +0.00151 ± 0.00007.

**Monotone in t, in full CP² without truncation, rising steadily toward the fused value.**

**What this reduces the conjecture to.** d/dt P_t(cross) = Cov_t(H(b(w₁ + w₂), b w₃), w₁₂), with w₁₂ = |z̄_{i₁} z_{i₂}|². H increases in its first argument. Monotonicity is therefore a **Griffiths-type correlation inequality for CP spins**: the alignment of i₁ with i₂ is positively correlated with an increasing function of their alignment with x. Such inequalities are known for some O(N) models (Lees, *Griffiths inequalities for the O(N)-spin model*, arXiv:2205.12928, via random paths; not read in detail). We do not know of one for CP^{N−1}.

**Limits.** One graph, q = 3, b = 1, Monte Carlo over the spins (the conditional loop part is exact). Graphs with two or more free centres need a new reduction: there P(NC | n) is no longer a function of two numbers.

## 8. Review of CPN_FUSION_TEST.md, and the t → ∞ limit (7 November 2026)

**Covariance identity.** dP_t(E)/dt = Cov_t(1_E, k_e)/t is correct. The weight carries t^{k_e}/k_e!, so d/dt log(weight) = k_e/t.

**How it relates to §7.**
- **The conditional loop law does not depend on the couplings.** Given the multiplicities n, the law of the permutations is ∝ ∏_v (q)_{d_v}^{−1} q^{#loops}. Given the spins, each n_e is Poisson(b_e w_e).
- **So on every graph P_t(E) is a spin average.** P_t(E) = E_t^{spin}[Φ_E], with Φ_E = Σ_n ∏_e Pois(n_e; b_e w_e) · P(E | n).
- **The derivative therefore splits into two parts.** d/dt P_t(E) = Cov_t^{spin}(Φ_E, w_e) + E_t^{spin}[∂_t Φ_E]:
  - a spin-alignment (Griffiths-type) term;
  - a direct term, ∂_t Φ_E = w_e · E[P(E | n + 1_e) − P(E | n)], the effect of one more strand inside the layer.
- **On the star of §7 the direct term is zero**, because P(E | n) does not depend on k_e there. On the two-hub graph it is not zero, since the cluster's return map depends on k_e (see below).

**The q = 3 fractions, checked with independent code** (`pilot/cpn_twohub_independent.py`; z- and z̄-slots with explicit index following, not your enumerator): Z₀ = 256/81, A₀ = 19/3240, Z₁ = 86/81, A₁ = 13/6480, so P₀ = 19/10240 and P′₀ = 3/262144. **They match exactly.**

**The t → ∞ limit: a first exact computation** (`pilot/cpn_cluster_return_map.py`). Take two layer vertices joined by k internal units, each with one external unit. The external return map is either "id" or "swap". The ratio of their weights (including internal closed loops and vertex factors) is

| k | 0 | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|---|
| q = 3 | 0 | 1/5 | 1/3 | 3/7 | 1/2 | 5/9 |
| q = 2 | 0 | 1/4 | 2/5 | 1/2 | 4/7 | — |

**That fits swap/id = k/(k + q + 1)** (checked for k ≤ 5 and q = 2, 3; not proven). It tends to 1, the value for a single fused vertex, where every return map has equal weight. Since k ~ Poisson(t w₁₂) and w₁₂ → 1, the cluster's routing approaches the fused routing **like 1/t**. This supports identifying the excursion event with that of the contracted graph in the limit. It is not a proof for general port numbers.

**Where we disagree, mildly.** The truncated searches (550 graphs) are useful as a falsification screen. They are not evidence about the sign of the untruncated derivative. The untruncated star computation in §7, and an untruncated version of the two-hub case using the spin-average formula above, are the stronger tests.
