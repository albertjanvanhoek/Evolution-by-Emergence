# CP projector loops: layer pinning, exact enumeration, and a two-region cut-vertex lemma

**7 November 2026 — independent response from the second model family to the task split in [CPN_PINNING.md](CPN_PINNING.md).** No general layer-pinning theorem or all-temperature CP mass gap is claimed. The positive loop expansion is prior work (Wolff 2010, arXiv:1001.2231). This document distinguishes **full finite-volume identities** from **exact enumerations of finite Taylor truncations** of the Gibbs weight.

## 1. The correctly matched event

Let \(G=(V,E)\) be a finite graph with nonnegative couplings and the standard \(CP^{q-1}\) projector action at \(\theta=0\). Choose disjoint nonempty **marked layers** \(B_0,B_1,\ldots,B_m\subset V\). Every diagram consists of edge multiplicities \(k_e\), directed index strands and at each free vertex \(v\) a permutation \(\pi_v\in S_{d_v}\), with weight
\[
w_{\mathrm{free}}(k,\pi)
=\prod_e\frac{b_e^{k_e}}{k_e!}
\prod_v\frac1{(q)_{d_v}}\,q^{\#\mathrm{closed\ loops}}.
\tag{E1}
\]
The pinned version fixes **each marked vertex separately to the same** \(P_*=uu^\dagger\). Its local permutation is the identity on the incident edge occurrences, and each resulting loop has color factor \(1\) if it visits a pin and \(q\) otherwise.

We compare identical, **cut-defined** events under the two diagram measures: cut every strand incident on \(\bigcup_i B_i\). An *excursion* is a resulting strand path whose interior visits no marked vertex. Let \(E_i\) mean that an excursion has one endpoint in \(B_i\) and one in \(B_{i+1}\); and \(E_{\rm all}=\bigcap_i E_i\). These events are determined by \(k\) and the permutations at **unmarked** vertices, and hence do not depend on the free permutations at the marked layers.

For two layers \(B_0,B_1\) only, the event is equivalent to “some complete free loop visits both layers”; for three or more layers this latter condition is **not** equivalent, since a complete loop could visit two layers via an intermediate marked layer or outside the tested annulus. Use excursion events in a multi-annulus comparison.

The intended open inequality is
\[
\mathbb P_{\rm free}(E_{\rm all})
\overset{?}{\le}
\mathbb P_{\rm all\ layers\ pinned\ equal}(E_{\rm all}).
\tag{E2}
\]
The previous [CPN_PINNING.md](CPN_PINNING.md) proves (E2) for **two single-vertex layers** on any finite graph; we test larger layers and multi-region events here.

## 2. What is exact about the finite enumeration?

The companion script [pilot/cpn_layer_exact_enumeration.py](pilot/cpn_layer_exact_enumeration.py) enumerates all
\[
0\le k_e\le K
\]
for every edge, **every** permitted permutation at every free vertex, and the entire closed-loop cycle decomposition. It computes the truncated partition functions and probabilities under the matched excursion event. There is **no Monte Carlo** and no approximated sampling. But it does **not** claim that a finite \(K\) evaluates the original exponential Gibbs weight at all positive couplings. One may raise \(K\) or bound the positive exponential tail separately.

At \(q=3\), all edge couplings \(b_e=1\), the following are direct outputs:

| Graph / marked layers | \(K\) | \(\mathbb P_{\rm free}(E_{\rm all})\) | \(\mathbb P_{\rm pin}(E_{\rm all})\) |
|---|---:|---:|---:|
| Star, two inner leaves \(\{0,1\}\), one outer \(\{3\}\), free hub 2, edges 02,12,23 | 1 | 0.029687500 | 0.089743590 |
| Same star | 2 | 0.050312582 | 0.151890463 |
| Bipartite four-cycle \(K_{2,2}\): inner \(\{0,1\}\), outer \(\{2,3\}\) | 1 | 0.683632369 | 0.937500000 |
| Same four-cycle | 2 | 0.751818434 | 0.974400000 |
| Four-cycle with an inner-layer edge, marked \(\{0,1\}\) and \(\{3\}\), edges 01,02,23,31 | 1 | 0.261808861 | 0.522727273 |
| Same graph | 2 | 0.313421784 | 0.630971129 |
| **Two adjacent regions**, 5-vertex path 0–1–2–3–4, layers \(\{0\},\{2\},\{4\}\) | 1 | 0.000244141 | 0.002066116 |
| Same path | 2 | 0.000728440 | 0.005995068 |
| Two regions on a four-cycle, layers \(\{0\},\{1,2\},\{3\}\), edges 01,02,23,31 | 1 | 0.191504943 | 0.562500000 |
| Same graph | 2 | 0.252008337 | 0.705600000 |

In these cases no negative difference \(\mathbb P_{\rm pin}-\mathbb P_{\rm free}\) was seen. **This is a small-graph falsification screen, not a proof of (E2)**. In particular these are probabilities in *different truncated* measures at \(K=1\) and \(K=2\); one should not infer the direction of their approach to the full Gibbs measure from this table alone.

## 3. A rigorous obstruction to extending the TWO-VERTEX NO-CROSS EQUALITY to layers

On the star from row 1, take two different inner-layer vertices \(A_1,A_2\), a free hub \(x\), and one outer marked vertex \(B\), with edges \(A_1x,A_2x,xB\). Focus on the *formal power-series coefficient* of \(b_{A_1x}b_{A_2x}b_{xB}^0\), i.e., exactly one occurrence on each of the two inner edges and none on the outer edge. This contributes to **no crossing** for both measures.

For the all-free law, it has coefficient
\[
[b_{A_1x}b_{A_2x}] Z_{\rm free,NC}
=\frac1{q^2}.
\tag{E3}
\]
Reason: a tree with three integrated vertices, one copy of each inner edge, has the coefficient \(\mathbb E[\operatorname{tr}(P_{A_1}P_x)\operatorname{tr}(P_{A_2}P_x)]=q^{-2}\).

For the law pinning the **two inner vertices** and the outer vertex to the same \(P_*\),
\[
[b_{A_1x}b_{A_2x}]Z_{\rm pin,NC}
=\mathbb E[\operatorname{tr}(P_*P_x)^2]
=\frac{2}{q(q+1)}.
\tag{E4}
\]
Thus the coefficients differ, by
\[
\boxed{\quad\frac{2}{q(q+1)}-\frac1{q^2}
=\frac{q-1}{q^2(q+1)}>0\quad(q\ge2).\quad}
\tag{E5}
\]
At \(q=3\), the difference is exactly \(1/18\). This is a **full-model formal Taylor coefficient identity**, not subject to the numerical edge cutoff \(K\).

This pinpoints exactly why the other assistant's general **two-single-vertex** proof cannot simply be copied to a *layer*. In the free model, an excursion \(A_1\to A_2\) may join different marked vertices on the **same** layer. Summing vertex permutations independently no longer cancels \((q)_{d_{A_1}},(q)_{d_{A_2}}\) against a factorized loop count. The *no-cross numerators* need not agree, even though the **normalized crossing inequality (E2) might still hold**.

A minimal counterexample to the **no-cross equality** is therefore established; it is **not** a counterexample to (E2).

## 4. An exact positive result: single-pin invariance and TWO adjacent regions with one cut vertex

A useful additional result (not just a numerical test) is that **pinning a single vertex does not change the marginal diagram law away from that vertex**. Let \(v\) be any site and fix edge multiplicities and all permutations \(\pi_x\) for \(x\ne v\). The strands outside \(v\) induce a permutation \(\rho_v\) on \(d_v\) ports; all loops not visiting \(v\) have a fixed factor \(q^{\ell_{\neg v}}\). Summing over \(\pi_v\) gives
\[
\frac1{(q)_{d_v}}\sum_{\pi_v\in S_{d_v}}
q^{\#\operatorname{cycles}(\pi_v\rho_v)}
=\frac1{(q)_{d_v}}\sum_{\sigma\in S_{d_v}}q^{\#\operatorname{cycles}(\sigma)}
=1.
\tag{E6}
\]
The result is **exactly the coefficient** obtained by fixing \(P_v=P_*\): every excursion through \(v\) contributes the rank-one projector with trace 1, and only the loops avoiding \(v\) retain their free factor \(q\). This proves equality of the (normalized) marginals on \(k\) and \(\{\pi_x:x\ne v\}\) between the all-free and one-vertex-pinned measures. In particular this holds for **every event measurable away from the vertex permutation**.

**Cut-vertex corollary.** Suppose \(G=G_L\cup G_R\), with \(V(G_L)\cap V(G_R)=\{v\}\) and no other common edges. Choose a distinguished vertex \(a\in G_L\setminus\{v\}\) and \(b\in G_R\setminus\{v\}\). Let \(E_L\) be the excursion-connection event between \(a\) and \(v\) in \(G_L\) and \(E_R\) the analogous event between \(v\) and \(b\) in \(G_R\). Both are measurable away from the permutation at \(v\). By (E6), their joint law is unchanged if we pin just \(v\). Under that pinning the left and right diagram weights **factorize exactly** because each pinned occurrence terminates a strand:
\[
\boxed{\quad
\mathbb P_{{\rm free},G}(E_L\cap E_R)
=\mathbb P_{{\rm free},G_L}(E_L)\,
 \mathbb P_{{\rm free},G_R}(E_R).
\quad}
\tag{E7}
\]
Each factor is bounded by its equal-two-pin counterpart using the general two-vertex lemma from [CPN_PINNING.md](CPN_PINNING.md). Pinning all \(a,v,b\) likewise factorizes, hence
\[
\boxed{\quad
\mathbb P_{{\rm free},G}(E_L\cap E_R)
\le
\mathbb P_{a,v,b\ {\rm pinned\ equal},G}(E_L\cap E_R).
\quad}
\tag{E8}
\]
This is a **genuine two-region comparison at all finite nonnegative couplings**, when the regions share exactly one articulation point and the marked endpoints are single vertices. The result is only a modest special case of the desired multi-annulus lemma: a real lattice annulus is separated by *an entire layer*, not a cut vertex.

For an explicit full-model check, take \(G\) to be the five-vertex path \(a-x-v-y-b\), \(q=3\), and all \(b_e=1\). The single two-edge segment has exact crossing probabilities \(\varepsilon_{\rm free}=0.0308739995803\) and \(\varepsilon_{\rm pin}=0.0886423162888\). Thus
\[
\mathbb P_{\rm free}(E_L\cap E_R)
=\varepsilon_{\rm free}^2=0.0009532038501,
\qquad
\mathbb P_{\rm pin}(E_L\cap E_R)
=\varepsilon_{\rm pin}^2=0.0078574602370.
\tag{E9}
\]
These are **untruncated analytic** values; compare with the cutoff-dependent rows in the earlier table. They provide a useful implementation check.

## 5. Three-port wiring exposes the next problem

The enlarged-boundary law in [CPN_WIRING_MARKOV.md](CPN_WIRING_MARKOV.md) gives conditional interior weights
\[
w_{\sigma}(\pi)\propto q^{\#\operatorname{cycles}(\sigma\pi)}
\tag{E10}
\]
when the local permutation weights are otherwise constant. For three ports and \(q=3\), the conditional probability of the *specific* interior pairing \(\pi=\mathrm{id}\) changes from
\[
\mathbb P(\pi=\mathrm{id}\mid\sigma=\mathrm{id})
=\frac{q^3}{(q)_3}=\frac{27}{60}=0.45
\]
to
\[
\mathbb P(\pi=\mathrm{id}\mid\sigma=(123))
=\frac{q}{(q)_3}=\frac3{60}=0.05.
\tag{E11}
\]
This is a ninefold difference caused entirely by the exterior wiring. An unweighted “switch the strand color” map does not erase the loop fugacity \(q^{\#\mathrm{cycles}}\): switching which pairs join can change the number of loops and the weight by \(q^{\pm1}\) per transposition. In a two-diagram switching argument one must prove a *weighted* identity (or averaged comparison) that cancels these factors. This is a constraint, not a proof that no switching lemma can exist.

## 6. Consequences for the other assistant's proposed fusion argument and the next step

- **The two-vertex pinning theorem is consistent with the tests.** There is an exact obstruction only to extending its *no-cross numerator equality* by summing separately at all sites of a layer (E3)–(E5). One cannot infer a counterexample to the normalized layer inequality.
- **Fusion is nontrivial.** Replacing a whole boundary layer by one common spin integrated over Fubini–Study measure is not the same as integrating its spins independently. The two-vertex theorem for *fused* vertices compares two different ensembles and by itself does not order the original one; an additional correlation/conditioning lemma is required.
- **The multi-ring problem is genuinely different from a one-vertex cut.** For a cut layer with \(r\) ports the exterior has nontrivial permutation state \(\sigma\in S_r\); (E6) no longer cancels independent sitewise once an excursion joins different layer sites.
- **The strongest next target** is a weighted switching identity for the annular **excursion** event, in a two-diagram measure, which either yields (E2) or a usable *averaged* bound with constants independent of layer size. One can first check the proposed pairing transformation against the exact \((q)_d\) local factors on the 2- and 3-port tangles.
- **Current evidence:** no violation of (E2) among the listed finite truncations. This is not exhaustive and cannot be extrapolated to all \(\beta\), large graphs, or all layer choices.

**Proof and numeric auditing:** all analytic identities are stated with their assumptions. The [companion script](pilot/cpn_layer_exact_enumeration.py) enumerates the precise finite set of terms used in the table and asserts the listed inequalities, without pretending to perform an infinite expansion. The exact path probabilities in (E9) follow from [CPN_BOUNDARY_COMPARISON.md](CPN_BOUNDARY_COMPARISON.md), not from the truncated table. Neither result claims the all-coupling CP mass gap.
