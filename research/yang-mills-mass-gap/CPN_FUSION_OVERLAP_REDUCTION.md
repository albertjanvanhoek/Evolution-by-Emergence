# Exact one-overlap reduction for CP layer fusion, and a coefficient-wise switching target

**7 November 2026 — next proof step after CPN_FUSION_TEST.md.** This note replaces the disproved *unrestricted* spin-overlap association Conjecture B from CPN_PINNING.md §9 with an exact scalar reduction for **one fusion edge**. It applies to the intended *annular excursion* event under a precise measurability condition. The reduction is an identity, not a proof that its remaining one-dimensional function is monotone. The elementary positive two-pin expansion is from CPN_POSITIVE_LOOPS.md, ultimately rooted in the CP loop construction of Wolff (2010); no claim of literature priority is made.

## Proposition 1 — event-restricted two-pin partition functions

Take any finite graph G for the standard \(\theta=0\) \(CP^{q-1}\) projector action, integer \(q\ge2\), and nonnegative finite couplings on its base edges. Let \(u,v\) be two distinct vertices in **the same marked layer**. Remove any variable \(u-v\) edge from the *base graph* and later add it with coupling \(t\ge0\).

Let \(E\) be a graphical event determined by:
- base-edge multiplicities \(n_e\) on edges other than \(u-v\); and
- local strand permutations **away from \(u,v\)**.

In particular, the *direct excursion event* obtained by cutting every marked layer vertex and demanding a strand excursion between consecutive layers is of this form: because \(u,v\) lie in the same marked layer, adding an \(u-v\) edge only creates an **intra-layer** excursion, which is not counted as a crossing, and the event ignores the permutations at the marked vertices. More general events depending on the \(u-v\) strands or on local permutations at \(u,v\) are **not** covered.

Pin only \(P_u,P_v\) in the base graph to prescribed rank-one projectors with squared overlap
\[
p=\operatorname{tr}(P_uP_v)\in[0,1].
\]
Integrate all other spins and form (i) the full two-pin base partition \(Z(p)\), and (ii) its **event-restricted** loop sum \(A(p)\), retaining only diagrams satisfying \(E\). Global SU(q) invariance ensures both depend on the pins only through p. The two-pinned oriented-index-loop representation gives absolutely convergent series
\[
\boxed{
Z(p)=\sum_{k\ge0}c_kp^k,\qquad
A(p)=\sum_{k\ge0}a_kp^k,\qquad
0\le a_k\le c_k.
}
\tag{R1}
\]
Here \(k\) is the total alternation count K between the two pinned directions across completed index loops; all unpinned loops have fugacity q. Restricting to E does not compromise coefficient positivity because E is defined at the diagram level. The series are entire in the finite graph couplings, and converge absolutely for \(0\le p\le1\).

## Proposition 2 — EXACT full-coupling fusion formula

Let \(\rho_q(dp)=(q-1)(1-p)^{q-2}dp\), the overlap distribution of two independent FS projectors. For the **free** spin/loop model, with the variable \(u-v\) edge of strength \(t\ge0\), the event probability obeys
\[
\boxed{
\mathbb P_t(E)
=\frac{\int_0^1 e^{tp}A(p)\,\rho_q(dp)}
{\int_0^1 e^{tp}Z(p)\,\rho_q(dp)}.
}
\tag{R2}
\]
**Proof:** expand all base edges, restrict their diagrams to E, and integrate the spins at \(u,v\) LAST. The event is independent of the local \(u,v\) pairings and of the count on the controlled edge, so the factor from that edge is simply \(e^{t\operatorname{tr}(P_uP_v)}=e^{tp}\). This disintegration is equivalent to the symmetric tensor moment formula used to reconstitute the free local permutations; nothing is assumed about positive association. QED.

Put
\[
h(p)=\frac{A(p)}{Z(p)}\in[0,1],\qquad
\nu_t(dp)=\frac{e^{tp}Z(p)\rho_q(dp)}
{\int e^{tp}Z(p)\rho_q(dp)}.
\tag{R3}
\]
Then differentiation gives the exact identity
\[
\boxed{
\frac{d}{dt}\mathbb P_t(E)
=\operatorname{Cov}_{\nu_t}(p,h(p)).
}
\tag{R4}
\]
Consequently, **if \(h(p)\) is nondecreasing**, fusion monotonicity follows for every \(t\ge0\) by one-dimensional Chebyshev covariance. This is a sufficient condition, **not a theorem that \(h\) always increases**; it replaces the false assertion of association for all increasing functions of multiple CP overlaps.

## Proposition 3 — the sharp coefficient-level switching target

For \(c_k>0\), write
\[
r_k=\frac{a_k}{c_k}
=\mathbb P_{\text{two-pin},\,p=1}(E\mid K=k).
\tag{R5}
\]
The conditional event probability is independent of p given K, because every diagram with K=k receives exactly the same multiplicative factor p^k. Therefore
\[
h(p)=\sum_{k\ge0}r_k\frac{c_kp^k}{Z(p)},\qquad
\boxed{p h'(p)=\operatorname{Cov}_{K\sim c_kp^k/Z(p)}(K,r_K)}
\quad(0<p\le1).
\tag{R6}
\]
If **\(r_k\) is nondecreasing in k**, then \(h'(p)\ge0\), hence \(\mathbb P'_t(E)\ge0\). This is a **strictly more focused sufficient condition**: more alternations between the two pinned projectors must favor the *specific layer-excursion event*. An even weaker, equivalent target for \(h'(p)\ge0\) is simply nonnegative covariance in (R6), without pointwise monotonicity of all r_k.

This identifies a concrete *weighted switching lemma* to seek. In contrast to Conjecture B, it conditions on the actual CP diagram ensemble and the actual event E, and it automatically includes changes in loop fugacity and exterior strand wiring **inside the coefficients** \(a_k,c_k\). It does not discard these difficulties; it packages them into an exact signed criterion.

## Independent two-hub / cyclic finite-polynomial checks

The companion script [pilot/cpn_fusion_overlap_coeff.py](pilot/cpn_fusion_overlap_coeff.py) computes c_k,a_k by enumerating every pairing in the **finite Taylor truncation** \(0\le n_e\le1\) on each base edge, but **does not truncate the new fusion parameter t in the scalar integrals** (higher t coefficients follow from beta moments). Illustrative q=3 results:

| Base graph | k | c_k | a_k | r_k=a_k/c_k |
|---|---:|---:|---:|---:|
| **Two free hubs tree:** I={0,1}, O={2}, free hubs 3,4; edges 0-3,1-3,3-4,4-2 | 0 | 28/9 | 1/180 | **1/560** |
| same | 1 | 4/27 | 1/1080 | **1/160** |
| **Two free hubs with a cycle:** I={0,1}, O={2,3}, free 4,5; edges 0-4,1-5,4-5,4-2,5-3 | 0 | 341/81 | 553/4050 | **553/17050** |
| same | 1 | 1/81 | 19/8100 | **19/100** |

Both have r_1>r_0: **a conditional sign check, not a proof for the untruncated model**.

**Exact cross-check against the prior independent two-hub enumerators.** Let \(m_j=\mathbb E_{\rho_q}[p^j]=j!/(q)_j\). Equation (R2) implies, at t=0,
\[
Z_0=\sum_k c_km_k,\quad A_0=\sum_k a_km_k,\quad
Z'_0=\sum_kc_km_{k+1},\quad A'_0=\sum_ka_km_{k+1}.
\tag{R7}
\]
For the two-hub tree above at q=3, inserting \((c_0,c_1)=(28/9,4/27)\) and \((a_0,a_1)=(1/180,1/1080)\) gives
\[
(Z_0,A_0,Z'_0,A'_0)
=(256/81,\;19/3240,\;86/81,\;13/6480),
\tag{R8}
\]
**exactly the independently obtained fractions** in CPN_FUSION_TEST.md and the other assistant's \`pilot/cpn_twohub_independent.py\`. Thus
\(\mathbb P'_0(E)=3/262144>0\) **in this stated finite Taylor-polynomial model**.

A deterministic seeded search using q=3, edge multiplicities 0/1, 5–6 vertices, positive heterogeneous couplings and at most 500 local-permutation combinations per multiplicity yielded 237 usable two-layer examples and 161 usable three-layer examples. In none was \(r_{k+1}<r_k\); **this is not a theorem** and the searches exclude harder larger-multiplicity diagrams.

## Positive special case: the occupied-cut event

For \(I=\{u,v\}\), let \(E_{\rm cut}\) be the event that **some base edge leaving I has at least one copy**. As proved independently in [CPN_TWO_SITE_CUT_FUSION.md](CPN_TWO_SITE_CUT_FUSION.md), the no-cut restricted sum is \(Z_O\), independent of the overlap p. Hence
\[
A(p)=Z(p)-Z_O,\quad a_0=c_0-Z_O,\quad a_k=c_k\ (k\ge1).
\tag{R9}
\]
Thus \(r_0\le r_1=r_2=\cdots=1\), proving fusion monotonicity for **any finite graph** and a complete graphical t→∞ limit for this local cut event. This validates the coefficient criterion in a nontrivial case; **it is not the annular path event**.

## What remains for the 2D CP gap

1. **Prove or refute the coefficient criterion (R6)** for the direct-excursion event on two adjacent annuli, possibly using a doubled-diagram weighted switching involution. In particular, **do not assume** the unrestricted overlap-FKG conjecture; [CPN_ASSOCIATION_COUNTEREXAMPLE.md](CPN_ASSOCIATION_COUNTEREXAMPLE.md) disproves it even for independent CP projectors.
2. **Lift single-edge fusion to a full layer:** if a suitable event-specific inequality holds for every added intra-layer edge and every intermediate positive-coupling base graph, integrate the edge couplings along a spanning tree within each layer. **Update (7 November, later):** the graphical t→∞ identification for a base-diagram-measurable *annular excursion* on every fixed finite graph is now proved in [CPN_FUSION_LIMIT_AND_SEPARATOR.md](CPN_FUSION_LIMIT_AND_SEPARATOR.md), Theorem (L3). What remains open is finite-t monotonicity for that event (and uniform control across graph sizes), not the event identification.
3. **Keep the mathematical scopes separate:** (R1)–(R8) are exact for their stated graph/finite-cutoff setting; the empirical coefficient monotonicity at low cutoff does NOT establish the all-coupling annulus comparison, exponential correlations or Yang–Mills.

**Research priority:** analyze the coefficient ratios \(r_k\) and/or their covariance in (R6) on the first graph with a genuine two-dimensional annular separator, rather than expanding the original multivariate overlap-association assumption.
