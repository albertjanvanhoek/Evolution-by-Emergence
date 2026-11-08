# CP^{N−1}: several gateways to one outer site (8 November 2026)

**Status:** one general identity, one theorem for a new graph class, an exact numerical screen of the case that is still open, and a full-model test of the two-gateway graph from the other track (§4). Written by one assistant; not yet checked by the other model family or by a human. It builds on [`CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md`](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md) and uses its notation. **It is not an annulus theorem, not exponential decay for CP^{N−1}, and says nothing about four-dimensional Yang–Mills.**

## The question

Every proved fusion step so far sends the pinned pair {u, v} to the outer site a through **one** gateway hub x. That note names the obstruction: a real annulus has many ports. The smallest case with many ports has several routes from {u, v} to the **same** outer site a. This note treats that case.

Throughout, q ≥ 3, all strengths are finite and nonnegative, u and v are pinned to rank-one projectors with overlap p = tr(P_u P_v), a is a marked site whose direction is integrated, and

  h(p) = P(E | P_u, P_v),  E = some index loop visits both {u, v} and a.

The fusion argument needs h to be nondecreasing in p (identity (E1) in the two-terminal note).

## 1. A spin-level formula for h, on any finite graph

> **Identity.** For any finite graph with u, v pinned and one free marked site a, and q ≥ 3,
>
>   h(p) = 1 − Z(P_⊥; p) / ∫ dω(P_a) Z(P_a; p),
>
> where Z(P_a; p) is the partition function with a also pinned, and P_⊥ is any rank-one projector orthogonal to span(z_u, z_v).

**Proof.**
- The denominator is the free-a partition function: pinning a and averaging its direction gives back the free model.
- Pin a to P_⊥. In the positive loop expansion with three pinned sites, a loop's weight is the product of overlaps between consecutive pinned sites on it. A loop that visits a and {u, v} has at least one step between a and u or v, so a factor ⟨z_⊥|z_u⟩ or ⟨z_⊥|z_v⟩, which is 0. Loops that visit only a have weight 1. So Z(P_⊥) is the pinned weight restricted to the no-cross event.
- With u and v pinned, every strand leaving a either returns to a or ends at u or v. So the no-cross event does not depend on the permutation at a, and the sum over that permutation cancels the vertex factor 1/(q)_d, as in [`CPN_PINNING.md`](CPN_PINNING.md) §3. Hence the free-a no-cross weight equals the pinned weight restricted to no cross, which is Z(P_⊥). ∎

For q = 2 there is no direction orthogonal to span(u, v) when p < 1, so the identity needs q ≥ 3. (q = 2 is the O(3) model, which is covered by the O(3) proof.)

**Check.** For one hub joined to u, v and a, the identity reproduces the double-star formula h = 1 − Σ_d w_d f_{q+d}(b_a) / (f_q(b_a) G) of [`CPN_DOUBLE_STAR_FUSION_THEOREM.md`](CPN_DOUBLE_STAR_FUSION_THEOREM.md) to 10⁻¹⁰ relative error, for q = 3, 4, 5, three sets of strengths and p = 0, 0.4, 1. This is an independent check of that formula at general p, by a method that uses no loop enumeration. The published values h(0) = 0.05389 and h(1) = 0.063468 (q = 3, strengths 1) are reproduced.

**Check with two gateways, by hand.** Take u–x₁–a and v–x₂–a, each edge used once. In loop terms, sum over the permutations at x₁, x₂ (vertex factor 1/(q)₂ each) and at a (1/(q)₂):
- both hubs return their strands: the two a-arcs close into q² + q = (q)₂ loop weight, so the total is 1/(q(q+1))²;
- one hub crosses: q + 1 at a, so 1/(q·(q(q+1))²), twice;
- both cross: 1 + tr(P_u P_v) = 1 + p at a, so (1 + p)/(q(q+1))³.

So P(no cross) = 1 / [1 + 2/q + (1 + p)/(q(q + 1))] at these multiplicities. On the spin side, the coefficient of the four strengths in Z(P_a) is (1 + |⟨a,u⟩|²)(1 + |⟨a,v⟩|²)/(q(q + 1))². At P_⊥ this is 1/(q(q+1))², and averaged over a it is [1 + 2/q + (1 + p)/(q(q + 1))]/(q(q + 1))². The two sides agree exactly, including the p from the loop through both u and v.

## 2. Theorem: separate routes from u and from v

> **Theorem.** Let the graph consist of u, v (pinned), a (free, marked), and networks H_1, …, H_m that share no vertices except u, v and a. Suppose each network touches **at most two** of u, v, a. Then h(p) is nondecreasing on [0, 1], for all finite nonnegative strengths. It is strictly increasing if some network has a positive-strength path from u to a and some network has one from v to a.

The networks may have any number of free vertices, cycles and parallel paths. There may be any number of them. Direct edges u–a and v–a are networks with no interior.

**Proof.**
1. *Two-terminal factors.* Fix P_a. A network that touches only u and a contributes a factor K(|⟨z_a, z_u⟩|²) with K(z) = Σ c_n zⁿ, c_n ≥ 0. Reason: expand each edge exponential, integrate the interior vertices with Σ_π π/(q)_d; each term is a nonnegative multiple of a product of traces of words in two rank-one projectors, and such a trace is z^k. This is (B1) of the two-terminal note. The same holds for networks between v and a.
2. *Factors that cancel.* A network that touches only u and v gives a factor that depends on p but not on P_a. A network that touches only one of u, v, a gives a constant, by unitary invariance. Both multiply the numerator and the denominator of the identity by the same amount.
3. So, with A = ∏ K over the u–a networks and B = ∏ K over the v–a networks (both positive power series),

     1 − h(p) = A(0) B(0) / 𝔼_a[ A(|⟨a, u⟩|²) B(|⟨a, v⟩|²) ],

   since |⟨z_⊥, z_u⟩|² = |⟨z_⊥, z_v⟩|² = 0.
4. *Mixed moments.* Expanding A and B, the denominator is Σ α_m β_n M_{m,n}(p) with α_m, β_n ≥ 0 and

     M_{m,n}(p) = 𝔼_a[|⟨a,u⟩|^{2m} |⟨a,v⟩|^{2n}] = (1/(q)_{m+n}) Σ_{π ∈ S_{m+n}} ⟨u^{⊗m} v^{⊗n}| π |u^{⊗m} v^{⊗n}⟩.

   Each term is a product over the cycles of π of cyclic products of ⟨u|u⟩ = ⟨v|v⟩ = 1, ⟨u|v⟩ and ⟨v|u⟩. Around a cycle, steps from u to v and from v to u come in equal numbers, so each term is p^k for some k ≥ 0. So M_{m,n} is a polynomial in p with nonnegative coefficients, and so is the denominator (all sums converge absolutely).
5. The denominator is therefore nondecreasing in p, and h is nondecreasing. If both A and B are nonconstant, the term m = n = 1 is present with M_{1,1}(p) = (1 + p)/(q(q + 1)), so the increase is strict. ∎

**Exact check of step 4.** `M_{m,n}` was computed in exact rational arithmetic from Dirichlet moments for q = 3, 4, 7 and m, n < 8: no negative coefficient. For example, q = 3: M_{1,1} = (1 + p)/12 and M_{2,2} = (1 + 4p + p²)/90.

**Simplest example.** One edge u–a of strength c and one edge v–a of strength c′, nothing else: 1 − h(p) = 1 / ∫ dω(a) exp(c|⟨a,u⟩|² + c′|⟨a,v⟩|²), which grows with p by the rank-two recurrence.

**Two regions.** Glue two such graphs, each with its own outer site, along the shared middle layer {u, v}, with no edge bypassing it. Then the chain free ≤ middle-fused ≤ all-pinned of (E1)–(E2) in the two-terminal note goes through unchanged: it uses only that each side's h is nondecreasing, the fusion limit, and the two-vertex pinning comparison on each contracted side. Those steps were checked by the two assistants, not by a human.

## 3. The open case, tested exactly: gateways that touch u, v and a

When a free hub is joined to all three of u, v and a, its factor depends on three directions. The theorem's argument breaks there: traces of words in three projectors are complex in general. The two-terminal theorem handles **one** such hub (with any network behind it). Two or more such hubs, or one such hub together with separate routes, are not covered by any proof here.

**Method** (`pilot/cpn_multi_gateway.py`). Take free hubs x_1, …, x_k, each joined only to u, v and a, plus optional direct edges u–a and v–a. Given u, v and a, the hubs are independent, and each integrates in closed form:

  ∫ dω(z) exp(z†Mz) = Σ_d h_d(eigenvalues of M) / (q)_d,

with h_d the complete homogeneous symmetric polynomial. The average over a uses the exact law of a uniform unit vector of C^q projected on the plane span(u, v): (|c_1|², |c_2|²) is Dirichlet(1, 1, q − 2) and the relative phase is uniform. Quadrature is Gauss–Jacobi × Gauss–Legendre × periodic trapezoid. The value of h for a three-hub graph with direct edges agrees to 15 digits at 16, 24, 32 and 48 nodes per axis. The series is cut at degree 80. With strengths of at most 6, the omitted tail is below 10⁻²⁰.

**Results** (seed 20261108; about one minute in total):

| q | graphs | kind | smallest step of h on an 11-point p grid |
|---|---|---|---|
| 3 | 15 | separate routes only (theorem applies) | −2·10⁻¹⁶ |
| 3 | 25 | 2–4 hubs touching u, v, a; some strengths 0; direct edges | −2·10⁻¹⁶ |
| 4 | 15 / 25 | as above | −1·10⁻¹⁶ / −2·10⁻¹⁶ |
| 6 | 15 / 25 | as above | −2·10⁻¹⁶ / −2·10⁻¹⁶ |

Negative steps of order 10⁻¹⁶ are rounding in graphs where h does not depend on p. An earlier, larger screen (120 graphs, q = 3, 4, 6, 32 nodes per axis) gave the same.

**Adversarial search.** A local search over the eight strengths of two three-terminal hubs plus direct edges (q = 3, strengths in [0, 4], four restarts) tried to make 1 − h increase between neighbouring p. Its best result was a graph in which one hub is cut off from a and h does not depend on p (largest step 6·10⁻¹⁵, rounding). A first version measured absolute steps and was drawn to strong couplings where h saturates near 1. That is why the objective is relative.

**A reduction that may help a proof.** For hubs attached only to u, v and a, the no-cross weight factors: Z_NC = ∏_i G_i(p) 𝔼_{μ_p^{(i)}}[f_{q+d}(b_{a,i})]. Each factor is the single-hub quantity already proved to be nonincreasing in p after dividing by G_i. So h is nondecreasing whenever

  D(p) = ∫ dω(a) ∏_i F(b_{u,i} P_u + b_{v,i} P_v + b_{a,i} P_a) / ∏_i G_i(p)

is nondecreasing. Here F(M) = ∫ dω(z) exp(z†Mz) and G_i(p) = F(b_{u,i} P_u + b_{v,i} P_v). Numerically, D is nondecreasing in all 50 graphs tested (q = 3, 5). In words: as u and v align, the hubs align with each other, and a shared outer site gains weight. For a single hub, D is constant. The three-projector traces stop the positivity argument of §2. A proof would need a different ordering argument, for example on the Bloch sphere of span(u, v), where the position of a relative to the geodesic through u and v is what matters.

## 4. Joined gateways in the full model: graph (G1)

While this note was being written, the other track added [`CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md`](CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md) and [`CPN_MULTI_GATEWAY_STABILITY.md`](CPN_MULTI_GATEWAY_STABILITY.md).
- The certificate studies graph (G1): two gateways x, y, each joined to u, v and a, and **joined to each other**. It works in a truncated model where each edge is used at most once. There, ordering by alternation count fails (r₂ < r₁ with strengths (1/8, 8, 8, 1/8, 8, 8, 1/4)), but h(p) still increases.
- The stability theorem proves h′ > 0 in the full model when the extra gateway attachments are weak enough, with a threshold that depends on the graph.

The certificate leaves the full model open. The identity of §1 makes it computable. Integrate x in closed form given u, v, a and y. Integrate y, and a in the denominator, with scrambled Sobol points mapped to uniform unit vectors. Use the same points at every p, so that differences in p are more accurate than the values (`pilot/cpn_two_gateway_full.py`).

**Validation.** With b_xy = 0 the gateways decouple, and §3's quadrature applies. At 2¹⁶, 2¹⁸ and 2²⁰ points, the estimates approach the quadrature values: h(0) gives 0.16261, 0.16200, 0.16183 against 0.161816. At p = 1 the error is about 3·10⁻⁴ at 2²⁰ points.

**Results**, q = 3, 2¹⁸ points, 4 independent scramblings, p = 0, 0.2, …, 1:

| strengths (ux, vx, uy, vy, xa, ya, xy) | h(p) | smallest step, all scramblings |
|---|---|---|
| all 1 | 0.1141 → 0.1380 | 4.3·10⁻³ |
| (G3): (1/8, 8, 8, 1/8, 8, 8, 1/4) | 0.9881 → 0.9981 | 5.7·10⁻⁴ |
| (1, 1, 1, 1, 1, 1, 5), strong gateway link | 0.1487 → 0.1866 | 6.4·10⁻³ |
| (3, 0.2, 0.2, 3, 2, 2, 3), crossed | 0.3971 → 0.4757 | 1.2·10⁻² |

The spread of h(0) over scramblings is at most 3·10⁻⁴, and every step is positive in every scrambling. **In the full model, h increases on (G1) in all four cases, including the certificate's witness.** At the witness couplings, the full model gives h near 1, against about 0.25 in the truncated one: with strengths of 8, edges used several times dominate. The failure of alternation ordering is a property of the truncation; whether it also happens in the full model was not tested here (it needs coefficients, not h).

These are numerical estimates with error bars, not proofs.

## What remains, in order

1. **Three-terminal gateways.** Prove that D(p) is nondecreasing, or find a graph where h decreases. The exact method of §3 makes a wider search cheap. Joined gateways can be tested with the method of §4, at a cost of minutes per graph.
2. **Many outer sites.** Here the outer layer is a single site. An unfused outer layer needs a version of the identity with several free marked sites, where pinning them orthogonally is no longer the right measure.
3. **From h to the annulus lemma.** Monotone h for the pair being fused is one step. The full pinning lemma of [`CPN_STEP4.md`](CPN_STEP4.md) needs it for every fusion step of every layer, uniformly in the graph.

## Where I'm unsure

- The identity in §1 is now written out in full, for a vertex shared by any number of networks, as step 1 of [`CPN_TWO_TERMINAL_GLUING_PROOF.md`](CPN_TWO_TERMINAL_GLUING_PROOF.md). The argument is local to a. It still needs a second reader.
- The theorem in §2 is elementary. That makes me suspect it, or something stronger, is already known in the literature on positive loop representations (Wolff 2010; Lees–Taggi). I did not search for it.
- The two-region step reuses the fusion limit and the articulation comparison. They were checked by the two assistants only.
- The numerical screen is small (about 120 graphs and one local search). It supports the conjecture; it does not prove it.

## Reproduce

```
cd pilot && python3 cpn_multi_gateway.py
```

Needs numpy and scipy, and takes about one minute. It runs the single-hub checks against the double-star formula (and exits with an error if they fail), the screens, and the adversarial search.

```
cd pilot && python3 cpn_two_gateway_full.py
```

Graph (G1) in the full model (§4): about six minutes.
