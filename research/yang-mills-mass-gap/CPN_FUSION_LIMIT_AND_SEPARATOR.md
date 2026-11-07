# CP fusion: a proved graphical contraction limit, separator factorization, and a ratio counterexample outside the separator class

**7 November 2026 — mathematical follow-up to [CPN_FUSION_OVERLAP_REDUCTION.md](CPN_FUSION_OVERLAP_REDUCTION.md).**

**Status summary.** Sections 1–2 are finite-volume identities and proofs for the standard positive CP projector model. Section 3 contains **exact rational results for a finite edge-multiplicity Taylor truncation**, not for the full exponential action. The counterexample in Section 3 **does not have a genuine separating middle layer**. The actual annulus monotonicity conjecture remains OPEN. All graphical representations used here rest on the prior CP loop construction of Wolff (2010); novelty is not established.

## 1. The graphical \(t\to\infty\) fusion limit is exact

Let \(G=(V,E)\) be any finite CP^{q−1} projector graph with \(q\ge2\), finite nonnegative base couplings \(b_e\), and **two distinct marked layer sites** \(u,v\). Remove any existing \(uv\)-edge from the base graph, and add an independent edge of strength \(t\ge0\). The Gibbs factor for that edge is
\[
e^{t\,\operatorname{tr}(P_uP_v)}=e^{tp},\qquad
p=\operatorname{tr}(P_uP_v)\in[0,1].
\]
An event \(E\) is **base-diagram-measurable away from \(u,v\)** if its indicator depends only on base-edge multiplicities and local index-permutations at vertices other than \(u,v\). In particular, the *direct-excursion* event obtained by cutting ALL marked-layer vertices and asking for strands connecting successive marked layers is of this form: the controlled \(uv\)-edge is internal to one marked layer and cannot itself be part of an excursion whose interior avoids marked vertices. The local permutations at marked vertices do not affect the excursion.

Pin \(P_u,P_v\) in the base graph at overlap \(p\), and let \(Z(p)\) be the base partition function and \(A(p)\) its **event-restricted** positive diagram sum. The two-pin expansion gives
\[
Z(p)=\sum_{k\ge0}c_kp^k,\quad
A(p)=\sum_{k\ge0}a_kp^k,\quad 0\le a_k\le c_k,
\tag{L1}
\]
with absolute and uniform convergence for \(p\in[0,1]\) on finite graphs. The exact scalar identity from the previous note is
\[
P_t(E)=\frac{\int_0^1e^{tp}A(p)\rho_q(dp)}
{\int_0^1e^{tp}Z(p)\rho_q(dp)},
\quad \rho_q(dp)=(q-1)(1-p)^{q-2}dp.
\tag{L2}
\]

**Theorem (graphical fusion, no monotonicity assumption).**
Let \(G/(u=v)\) denote the graph formed by contracting \(u,v\) to a **single marked vertex**, retaining all base-edge incidences (and summing weights of parallel bonds if desired), and omitting the controlled fusion edge as an additive constant. Let \(E_{\mathrm{fused}}\) be the natural excursion event defined by cutting the same marked layers in this contracted graph. Then
\[
\boxed{
\lim_{t\to\infty}\mathbb P_t^G(E)
=\mathbb P^{G/(u=v)}(E_{\mathrm{fused}})
=\frac{A(1)}{Z(1)}.
}
\tag{L3}
\]
For each fixed finite graph and fixed bounded base couplings,
\[
\mathbb P_t^G(E)=\mathbb P^{G/(u=v)}(E_{\mathrm{fused}})+O_{G,q,b}(t^{-1}).
\tag{L4}
\]
The constant in (L4) is **not** uniform in graph size or coupling strength.

**Proof.** Divide numerator and denominator of (L2) by \(M_q(t)=\int e^{tp}\rho_q(dp)\), and let \(\rho_{q,t}(dp)\propto e^{tp}\rho_q(dp)\). Under \(\rho_{q,t}\), \(p\to1\) in probability. Both \(A,Z\) are continuous at 1 and \(Z(1)>0\), so the ratio tends to \(A(1)/Z(1)\).

It remains to identify this ratio **graphically**, rather than only in the spin measure. Fix any finite set of base-edge multiplicities and all local strand permutations away from \(u,v\). At \(p=1\), the two pinned projectors are literally identical, \(P_u=P_v=P_*\). Their combined tensor factor is \(P_*^{\otimes(d_u+d_v)}\), with exactly the same free external index slots as a single fused vertex. Averaging the common rank-one \(P_*\) over normalized Fubini–Study measure produces
\[
\int d\omega(P)\;P^{\otimes(d_u+d_v)}
=\frac{1}{(q)_{d_u+d_v}}
\sum_{\pi\in S_{d_u+d_v}}
(\text{oriented index pairing indexed by }\pi),
\tag{L5}
\]
which is *exactly* the fused-vertex moment rule. The event indicator does not involve any new permutation at that marked vertex, so it is unaffected by replacing the two identical pinned sites with one fused spin and then averaging. The weights of each exterior base diagram therefore agree **after summing** over the local fused-vertex permutations. Positive absolute convergence justifies exchanging the finite-diagram identification and the infinite edge-multiplicity sum. The same holds for the unrestricted denominator. This proves (L3).

For the rate, \(A,Z\) are continuously differentiable on \([0,1]\): on the finite graph their two-pin loop series have nonnegative coefficients, bounded total edge weights, and every derivative is dominated by a finite exponential moment of the strand number. Since \(Z\ge1\), \(h=A/Z\) is Lipschitz, so
\[
|P_t(E)-h(1)|\le\mathrm{Lip}(h)\,\mathbb E_{\nu_t}(1-p).
\]
Here \(\nu_t(dp)\propto e^{tp}Z(p)\rho_q(dp)\). Setting \(s=1-p\) and applying the elementary beta/Laplace integral yields
\(\mathbb E_{\nu_t}(1-p)=(q-1)t^{-1}+O(t^{-2})\).
This proves (L4). QED.

**Important:** (L3) does not establish that \(P_t(E)\) is nondecreasing before the limit. It settles the previously open **event identification**, conditional on the precise base-diagram measurability assumption.

## 2. A genuine two-site separator reduces two annuli to two one-sided problems

Let \(G=G_L\cup G_R\), where \(V(G_L)\cap V(G_R)=S=\{u,v\}\), the edge sets are disjoint, and **every path from the left distinguished layer \(B_0\) to the right distinguished layer \(B_2\) meets \(S\)**. Assume no controlled \(uv\)-edge is included in the base sides. Let \(E_L\) and \(E_R\) be the *direct excursion* events connecting \(B_0\) to \(S\) inside \(G_L\), and \(S\) to \(B_2\) inside \(G_R\), respectively, with the marked separator sites cut.

With both \(u,v\) pinned at overlap \(p\), integrations and diagram enumerations on the **two disjoint sides are independent**. Therefore the (unrestricted and event-restricted) two-pin partition functions satisfy the EXACT identities
\[
Z(p)=Z_L(p)Z_R(p),\qquad
A(p)=A_L(p)A_R(p),
\tag{S1}
\]
and
\[
h(p)=\frac{A(p)}{Z(p)}
=\underbrace{\frac{A_L(p)}{Z_L(p)}}_{h_L(p)}
\,\underbrace{\frac{A_R(p)}{Z_R(p)}}_{h_R(p)}.
\tag{S2}
\]
All factors are in \([0,1]\). **Consequently, if the two ONE-SIDED functions \(h_L,h_R\) are nondecreasing on \([0,1]\), so is the joint two-region \(h\), and (L2) makes the whole joint event nondecreasing under fusion.** This is a rigorous conditional implication, not an all-graph proof of the one-sided hypothesis.

The scalar overlap reduction and factorization **both fail to be this simple for a separator of three or more free sites**: the boundary state is a nontrivial Gram matrix of several projectors, not a single \(p\). One can fuse them one edge at a time, but each step still needs its own event-specific comparison.

**Exact finite-Taylor sanity check.** Let \(q=3\) and choose the true two-site separator \(S=\{1,2\}\), with \(B_0=\{0\}\), \(B_2=\{3\}\), free left hub 4, free right hub 5, and six base edges
\[
(0,4),(4,1),(4,2)\qquad\text{and}\qquad
(1,5),(2,5),(5,3)
\]
of unit coupling. Retain **only 0 or 1 strand on each base edge**. For either side:
\[
Z_L(p)=Z_R(p)=\frac73+\frac19p,\qquad
A_L(p)=A_R(p)=\frac1{15}+\frac1{90}p.
\tag{S3}
\]
Thus the full two-sided coefficients, calculated either by direct loop enumeration or by multiplication, are
\[
(c_0,c_1,c_2)=\left(\frac{49}9,\frac{14}{27},\frac1{81}\right),
\quad
(a_0,a_1,a_2)=\left(\frac1{225},\frac1{675},\frac1{8100}\right).
\tag{S4}
\]
For this **finite Taylor-polynomial model**,
\[
(r_0,r_1,r_2)=\left(\frac1{1225},\frac1{350},\frac1{100}\right),
\tag{S5}
\]
which is strictly increasing, as expected. No inference to untruncated beta/coupling follows from a cutoff alone; the **factorization identities (S1)–(S2), however, are exact for the complete model**.

## 3. Exact counterexample to coefficient-wise r_k monotonicity WITHOUT a separator

The stronger, **unqualified** assertion that \(r_k=a_k/c_k\) must increase with \(k\) for ANY marked-layer excursion event on ANY finite graph is **false even in a positive CP loop polynomial**. It is important to distinguish this from the untruncated CP measure.

Consider \(CP^2\), \(q=3\), with \(B_0=\{0\}\), \(B_1=\{1,2\}\), \(B_2=\{3\}\), free hub \(4\), and pinned for the two-pin coefficients \(u=1,v=2\). Use these SIX base edges, with the indicated nonnegative couplings:
\[
(2,4):\tfrac1{10},\quad (1,4):1,\quad
(0,1):\tfrac1{50},\quad (0,3):8,\quad
(3,4):\tfrac1{10},\quad(0,2):2.
\tag{C1}
\]
Retain \(\,0\le n_e\le1\,\) on each base edge and enumerate **all** permitted local permutations (377 weighted diagram terms). Define \(E=E_{01}\cap E_{12}\), with direct marked-layer excursions (not arbitrary completed-loop intersections), exactly as in the previous notes. The resulting positive two-pin coefficients are
\[
\begin{array}{c|cc|c}
k & c_k & a_k & r_k=a_k/c_k\\\hline
0 & 235837823/27000000 & 68611/9000000
  & 205833/235837823\\
1 & 240589/3375000 & 34967/27000000
  & 34967/1924712\\
2 & 2843/27000000 & 19/13500000
  & 38/2843
\end{array}
\tag{C2}
\]
Numerically,
\[
r_0\simeq0.00087277349,\quad
r_1\simeq0.01816739336,\quad
r_2\simeq0.01336616250.
\tag{C3}
\]
Therefore \(r_2<r_1\) **exactly**, disproving the unrestricted coefficient-level monotonicity principle **in this finite polynomial expansion**.

**But the actual fusion derivative still has positive sign in this example:** setting \(h(p)=A(p)/Z(p)\), direct polynomial calculation gives
\[
Z(p)^2 h'(p)=D_0+D_1p+D_2p^2,\quad
(D_0,D_1,D_2)\simeq
(0.01076868575,\ 0.00002298122,\ -0.00000003604).
\tag{C4}
\]
Since \(D_0>|D_2|\) and \(D_1\ge0\), \(h'(p)>0\) throughout \(0\le p\le1\). Thus \(\{r_k\}\) can be nonmonotone **while fusion monotonicity survives**. The weaker covariance requirement in [CPN_FUSION_OVERLAP_REDUCTION.md](CPN_FUSION_OVERLAP_REDUCTION.md), eq. (R6), is more natural than imposing increasing \(r_k\) term by term.

**MOST IMPORTANT SCOPE LIMIT:** the edge \((0,3)\) in (C1) **bypasses the marked middle layer \(\{1,2\}\)**. Hence it is NOT a pair of genuine annuli separated by that layer. The statement falsified is only the over-strong unrestricted coefficient criterion **within a finite Taylor truncation**. No full-exponential CP counterexample, no false annulus fusion claim, and no mass-gap claim follows. Removing the bypass edge eliminates the decrease in this example.

## 4. A targeted finite search preserving the separator

A reproducible test (see [pilot/cpn_separator_ratio_check.py](pilot/cpn_separator_ratio_check.py)) restricts to the six-vertex graph with middle layer \(S=\{1,2\}\), left marked site 0, right marked site 3, free hubs 4 (left) and 5 (right), and possible base edges:
\[
(0,4),(0,1),(0,2),(4,1),(4,2),\;
(1,5),(2,5),(5,3),(1,3),(2,3).
\]
**No edge may connect the two sides while avoiding S**, so S is a genuine separator. With q=2,3,5, random positive rational couplings, and each base-edge multiplicity 0/1, more than 1,900 usable trials per q had no decreasing adjacent coefficient ratios; only roundoff-size errors (~10^-16) occurred in the original floating-point probe. This is a falsification screen, not a theorem. The exact six-edge test (S3)–(S5) gives an auditable baseline.

## 5. What should now be proved

The above results suggest a simpler order of attack:

1. **One-sided monotonicity for a TWO-SITE boundary.** On any finite graph with boundary layer \(\{u,v\}\), a disjoint exterior marked layer, and no forbidden bypass, is the *one-sided* conditional direct-excursion probability \(h_L(p)\) nondecreasing in overlap \(p\)? This is strictly narrower than a generic CP overlap-Griffiths inequality, which was disproved by [CPN_ASSOCIATION_COUNTEREXAMPLE.md](CPN_ASSOCIATION_COUNTEREXAMPLE.md).
2. If that holds for both sides, (S2) proves the **two-region joint** result immediately.
3. (L3) then gives the **exact graphical fusion limit**, so the only missing step is monotonicity over finite \(t\), not identification of the limit.
4. For larger layers, sequentially fuse vertices with additional positive edges and extend the scalar one-overlap lemma to the intermediate contracted graphs. The necessary one-sided statement must remain uniform under the relevant graph and boundary conditions.

**No general CP annulus crossing theorem, exponential decay, or Yang–Mills mass gap is proved here.**
