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
