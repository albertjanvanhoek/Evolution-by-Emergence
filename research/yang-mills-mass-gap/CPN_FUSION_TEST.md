# Fusion interpolation falsification screen for CP projector loops

**7 November 2026 — requested follow-up to CPN_PINNING.md §6 and CPN_STAR_LAYER_THEOREM.md.** Finite-graph numerical and exact-rational results, explicitly separated from conjectures about the untruncated Gibbs ensemble. The relevant observable is the **oriented-index-strand excursion** through an unmarked region, as in CPN_LAYER_ENUMERATION.md, not a physical spin observable.

**Subsequent progress (same date):** the graphical t→∞ limit and its identification with the contracted-graph *direct-excursion* event are now proved for arbitrary fixed finite graphs, provided the event uses only base-edge multiplicities and vertex permutations away from the fused marked sites. See [CPN_FUSION_LIMIT_AND_SEPARATOR.md](CPN_FUSION_LIMIT_AND_SEPARATOR.md), Section 1. Thus item 3 of the open list below is RESOLVED under that exact measurability condition. The full monotonicity conjecture is still OPEN. The stronger all-increasing-overlaps association hypothesis is refuted in [CPN_ASSOCIATION_COUNTEREXAMPLE.md](CPN_ASSOCIATION_COUNTEREXAMPLE.md). This document otherwise records the earlier falsification test at the time of writing.

## 1. Question and exact derivative identity

Choose disjoint marked layers \(\mathcal B_0,\ldots,\mathcal B_m\), and an additional ferromagnetic coupling \(t\operatorname{tr}(P_uP_v)\), \(t\ge0\), between two vertices \(u,v\) in **the same** marked layer. Let \(E=\bigcap_{j=0}^{m-1}E_j\), where \(E_j\) is the event that at least one **excursion through unmarked vertices** directly connects \(\mathcal B_j\) to \(\mathcal B_{j+1}\). This event is measurable after cutting the marked sites and is well-defined even with intra-layer edges.

Write \(\mathcal Z(t)\) for the full positive loop partition function, and \(\mathcal A(t)\) for its portion satisfying \(E\). Since the edge multiplicity \(k_{uv}\) has factor \(t^{k_{uv}}/k_{uv}!\), for every \(t>0\) the **exact full-model identity** is
\[
\boxed{
\frac{d}{dt}\mathbb P_t(E)
=\frac1t\,\operatorname{Cov}_t(\mathbf1_E,k_{uv}).
}
\tag{F1}
\]
Thus proving fusion monotonicity would require a **nontrivial positive association between a crossing event and the multiplicity of an intra-layer edge**. Standard Harris/FKG cannot simply be assumed: the CP loop ensemble does not have the independent edge-count law used in the star proof.

At \(t=0\), write \(\mathcal Z(t)=Z_0+tZ_1+O(t^2)\), \(\mathcal A(t)=A_0+tA_1+O(t^2)\). Then
\[
\boxed{
\left.\frac{d}{dt}\mathbb P_t(E)\right|_{t=0}
=\frac{A_1Z_0-A_0Z_1}{Z_0^2}.
}
\tag{F2}
\]
Both are full-model algebraic identities. Our **numerical values below** instead use finite Taylor truncations of the *other* edge exponentials.

## 2. Exact-rational finite-truncation test with TWO free hubs

Vertices \(I=\{0,1\}\), \(O=\{2\}\), free hubs \(3,4\), with existing couplings of strength \(1\) on
\[
(0,3),\ (1,3),\ (3,4),\ (4,2).
\]
Add the intra-layer coupling \(t\) on \((0,1)\). The excursions from I to O pass through both free hubs.

For every existing edge, retain only \(k_e\in\{0,1\}\); for the additional edge, retain \(k_{01}\in\{0,1\}\). These are **exact probabilities and derivatives for this finite Taylor polynomial model** (not for the complete exponentials). Exhaustive loop and permutation enumeration using exact Python \`fractions.Fraction\` gives:

| \(q\) | \(P_{t=0}(E)\) | \(P'_{t=0}(E)\) |
|---:|---:|---:|
| 2 | \(11/1458\) = 0.00754458 | \(4/59049\) = +0.0000677404 |
| 3 | \(19/10240\) = 0.00185547 | \(3/262144\) = +0.0000114441 |
| 5 | \(41/163296\) = 0.000251078 | \(5/7558272\) = +0.000000661527 |

At \(q=3\) the exact partition-polynomial coefficients are
\[
Z_0=256/81,\quad A_0=19/3240,\qquad
Z_1=86/81,\quad A_1=13/6480.
\tag{F3}
\]
Substitution into (F2) gives \(3/262144\) **exactly**, ruling out numerical rounding as the cause of the observed sign.

Raising the **existing-edge cutoff to \(k_e\le2\)**, retaining \(k_{01}\le1\), yields for \(q=3\):
\(P_{t=0}(E)=0.004181930863\), \(P'_{t=0}(E)=+0.000036808129\).
Every local permutation at the two free hubs is still enumerated; the result remains a finite-Taylor result.

## 3. Simultaneous crossing of TWO consecutive regions

Take marked layers \(\mathcal B_0=\{0\}\), \(\mathcal B_1=\{1,2\}\), \(\mathcal B_2=\{3\}\), free hub \(4\), and base edges
\((0,4),(1,4),(2,4),(3,4)\) with strength 1. Add \(t\) on \((1,2)\), **within the middle layer**, and let \(E=E_{01}\cap E_{12}\).

With \(q=3\), existing edge multiplicities \(k_e\le1\) and extra-edge multiplicity \(k_{12}\le2\), direct polynomial enumeration gives:

| \(t\) | \(P_t(E)\) | \(dP_t(E)/dt\) |
|---:|---:|---:|
| 0 | 0.0031250000 | +0.0000244141 |
| 0.2 | 0.0031299259 | +0.0000247527 |
| 0.5 | 0.0031373193 | +0.0000243904 |
| 1 | 0.0031490649 | +0.0000223895 |

**No local reversal** in this truncated two-region test for \(0\le t\le1\). It does not justify taking \(t\to\infty\), because the intra-layer polynomial is truncated at order two.

## 4. Reproducible small-graph search

The companion [pilot/cpn_fusion_derivative.py](pilot/cpn_fusion_derivative.py) carries out two deterministic seeded searches using one strand per existing edge and at most one strand on the new intra-layer edge:

* Two layers, \(I=\{0,1\}\), \(O=\{2,3\}\), seed 73: **250** graph/coupling trials, **245** with nontrivial \(P(E)>10^{-10}\). No derivative below \(-10^{-9}\).
* Three layers, \(\{0\},\{1,2\},\{3\}\), seed 117: **300** trials, **269** nontrivial. No derivative below \(-10^{-9}\).

Each uses \(n=5\) or 6 vertices, a random selection of 4–7 permitted edges, nonnegative heterogeneous baseline couplings (logarithmically sampled), and \(q\in\{2,3,5,8\}\). The search excludes additional edges directly joining two marked vertices, other than the designated intra-layer test edge. The code enumerates **all** permutations and edge multiplicities admitted by the chosen finite polynomial; no Markov chains or Monte Carlo estimates enter the partition-function calculation. Randomness only selects the finite graphs/couplings.

A nonnegative outcome at a chosen finite cutoff is **not a rigorous lower bound** for the untruncated model. The random searches are falsification screens, not evidence of an exact universal theorem.

## 5. What the evidence says and does NOT say

**Observed:** no negative derivative in the tested polynomial ensembles. The test with two free hubs directly escapes the product-edge-count hypothesis of CPN_STAR_LAYER_THEOREM.md. A simple pointwise diagram comparison is already known to fail (see that file's S16); hence a proof, if true, needs a summed or switched weighted comparison.

**Still unproved:**
1. \(\operatorname{Cov}_t(\mathbf1_E,k_{uv})\ge0\) for arbitrary finite CP projector graph, \(t\ge0\), with the complete exponential action.
2. An extension to sequentially strengthening enough intra-layer edges to fuse a full separating layer, uniformly for multiple annuli.
3. The identification of the *limiting graphical excursion event law* as \(t\to\infty\) with the proposed **contracted-vertex loop ensemble**. Convergence of the underlying spin measures to a fused spin state does **not alone** prove convergence of a graphical event that depends on arbitrarily many strands.
4. A general boundary-layer pinning comparison, an all-\(\beta\) exponential CP correlation theorem, or a Yang–Mills mass gap.

**Recommended next mathematical task:** seek a weighted switching/conditional association identity that proves the **covariance in (F1)** for two hubs (or exhibit a counterexample). Before invoking the fusion route for many annuli, also establish the convergence and event identification in item 3. The known Griffiths inequalities for spherical O(N) spins (e.g. Lees 2022, arXiv:2205.12928) do **not** automatically transfer to rank-one CP projector orbits.

**Provenance:** Our two-hub rational numbers are exact within the stated polynomial truncation. This is an internally checked computational note, not independently peer reviewed. Nothing is merged into the main branch.
