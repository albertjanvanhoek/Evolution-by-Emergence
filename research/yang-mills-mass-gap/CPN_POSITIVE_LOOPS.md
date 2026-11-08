# A positive loop representation for the CP projector model, and an exact boundary-crossing identity

**7 November 2026 — independent mathematical derivation, for critical review.**

**Prior-work correction (important).** Ulli Wolff, *Simulating the All-Order Strong Coupling Expansion IV: CP(N−1) as a loop model*, Nucl. Phys. B 832 (2010) 520–537, arXiv:1001.2231, Section 2.2, **already derived an exact positive oriented-loop representation for this same quartic CP action** (his Eq. (17), with our edge coupling (b_e=2\beta_q)); his Eqs. (21)–(23) also give loop/worm representations of adjoint two-point correlations. Neither the general loop expansion nor the existence of a graphical correlator representation is new here. What needs independent comparison is the **specific two-pinned-projector boundary-crossing identity** (L8)–(L11) and whether it supports the boundary-comparison estimates needed for decay.

**Scope.** This note concerns the *finite-volume* nearest-neighbour \(CP^{q-1}\) **projector** model at \(\theta=0\), integer \(q\ge2\), nonnegative couplings, and two kinds of rank-one pinned boundary projectors. It uses a standard symmetric-tensor (high-temperature) expansion; any novelty claim requires a literature search. The exact loop identity below is an **alternative to a sign-cluster identity for this restricted boundary setup**; it does **not** supply the missing boundary comparison or an all-temperature CP mass-gap theorem. It should be read together with [CPN_TWIST_THEOREM.md](CPN_TWIST_THEOREM.md).

## 1. Finite graph and positive expansion

Let \(G=(V,E)\) be a finite undirected graph and write \(P_x=z_xz_x^\dagger\) with \(z_x\in\mathbb C^q\), \(\|z_x\|=1\), modulo its scalar phase. Fix a subset \(D\subset V\) to prescribed rank-one projectors, integrating each other spin against the invariant Fubini–Study probability measure. Define
\[
Z_D(\eta)=\int\exp\left(\sum_{\{x,y\}\in E}
b_{xy}\operatorname{tr}(P_xP_y)\right)
\prod_{x\notin D}d\omega(P_x),\qquad b_{xy}\ge0.
\tag{L1}
\]
For each edge \(e\), expand its exponential:
\[
e^{b_e|z_x^\dagger z_y|^2}
=\sum_{k_e=0}^\infty \frac{b_e^{k_e}}{k_e!}
\bigl(z_x^\dagger z_y\,z_y^\dagger z_x\bigr)^{k_e}.
\tag{L2}
\]
All terms of this *scalar* expansion are nonnegative functions; to obtain a loop decomposition we further expand the internal color indices. For a free vertex \(x\) incident on \(d_x=\sum_{e\ni x}k_e\) replicated edge factors, the basic projective moment is
\[
\int\prod_{r=1}^{d_x}z_{i_r}\overline z_{j_r}\,d\omega(z)
=\frac1{(q)_{d_x}}\sum_{\pi\in\mathfrak S_{d_x}}
\prod_{r=1}^{d_x}\delta_{i_r,j_{\pi(r)}},
\qquad
(q)_d=q(q+1)\cdots(q+d-1).
\tag{L3}
\]
Here \((q)_0=1\). **Justification:** \(\int P^{\otimes d}d\omega(P)\) is the orthogonal projector onto the symmetric tensor power, divided by its dimension \(\binom{q+d-1}{d}\); the symmetrizer equals \((d!)^{-1}\sum_{\pi\in S_d}U_\pi\). Equation (L3) follows.

Choose every edge multiplicity \(k_e\) and every vertex pairing \(\pi_x\) from (L3). Contraction of the Kronecker deltas creates closed oriented index loops. At a pinned vertex, each incident occurrence inserts its fixed rank-one projector on the loop rather than a free-vertex pairing. The resulting term has coefficient
\[
w(k,\pi;\eta)=
\left(\prod_{e\in E}\frac{b_e^{k_e}}{k_e!}\right)
\left(\prod_{x\notin D}\frac1{(q)_{d_x}}\right)
\prod_{\gamma\in\mathcal L(k,\pi)}
\operatorname{tr}\!\left(\prod_{\substack{\text{pinned visits}\\\text{along }\gamma}}
P_{\eta_v}\right).
\tag{L4}
\]
The product inside each trace is in the cyclic visitation order along the loop; an *unpinned* loop has empty product, giving \(\operatorname{tr}(I_q)=q\). Pairing terms are counted individually, with multiplicity; there is no extra unproved combinatorial symmetry factor.

For **arbitrary** pinned projectors, an individual trace of three or more noncommuting projectors need not be real or nonnegative. Do **not** claim (L4) is a positive representation for every pinned configuration.

## 2. Two pinned states: the weights are nonnegative

Partition the pinned set into two disjoint labeled groups \(D_A,D_B\) and fix
\[
P_A=|u\rangle\langle u|,\qquad
P_B(t)=|v_t\rangle\langle v_t|,\qquad
|\langle u,v_t\rangle|^2=p(t)\in[0,1].
\tag{L5}
\]
All sites in \(D_A\) carry \(P_A\), all sites in \(D_B\) carry \(P_B(t)\). A loop has one of three kinds of weight in (L4):

- no pinned visits: \(q\);
- pinned visits of only one label \(A\) or \(B\): \(1\), since rank-one projectors are idempotent and trace one;
- visits of *both* labels: \(p(t)^{r_\gamma}\), where \(r_\gamma\ge1\) counts pairs of switches between the two labels in the cyclic, reduced pinned-visit word.

Indeed, after deleting consecutive repetitions of \(A\) and \(B\), the mixed cyclic word is \((P_AP_B)^{r_\gamma}\) and
\[
\operatorname{tr}[(P_AP_B)^{r_\gamma}]
=|\langle u,v_t\rangle|^{2r_\gamma}=p(t)^{r_\gamma}\ge0.
\tag{L6}
\]
Thus **every diagram weight is nonnegative for this two-state pinning** and the absolutely convergent expansion defines a probability measure at \(p=1\).

## 3. Exact boundary-crossing identity

Let \(Z(p)\) denote (L1) with the two pinned types chosen at squared overlap \(p\). Keep the labels \(A,B\) even at \(p=1\), when \(P_A=P_B\). Under the positive loop probability measure \(\mathbb P_1\) defined by the normalized diagram weights at \(p=1\), let
\[
K=\sum_{\gamma:\,\gamma\text{ visits both }D_A,D_B}r_\gamma\in\{0,1,2,\ldots\}.
\tag{L7}
\]
The weights (L4)–(L6) imply the **exact generating-function identity**
\[
\boxed{\quad\frac{Z(p)}{Z(1)}=\mathbb E_1[p^K].\quad}
\tag{L8}
\]
In particular, when \(P_A\perp P_B\), so \(p=0\),
\[
\boxed{
1-\frac{Z(0)}{Z(1)}
=\mathbb P_1(K\ge1)
=\mathbb P_1(\text{some index loop visits both pinned sets}).
}
\tag{L9}
\]
The \(Z(0)\) in (L9) means **zero overlap**, not a zero twist angle. This identity is finite-volume exact and does not require reflection positivity, FKG, Wolff's Ising embedding, or a mass gap.

For the specific embedded \(SU(2)\) boundary path
\[
u=e_1,\qquad
v_t=e^{-it\sigma_y/2}e_1,\qquad
p(t)=\cos^2(t/2),
\tag{L10}
\]
the ordinary twist angle satisfies \(Z_R(t)=Z(p(t))\). The endpoint \(t=\pi\) is an **orthogonal CP-projector boundary direction**, so
\[
1-\frac{Z_R(\pi)}{Z_R(0)}
=\mathbb P_{\text{equal-pinned}}\bigl(
\text{an index loop touches both annular boundaries}\bigr).
\tag{L11}
\]
This also shows \(Z_R(t)\le Z_R(0)\) for this particular choice of boundary orbit, independent of the general twist bound.

## 4. Consequence of the annular twist estimate

Assume Theorem A of [CPN_TWIST_THEOREM.md](CPN_TWIST_THEOREM.md), i.e. the correctly adapted OpenAI Propositions 2.2 and 3.1. Theorem A gives
\[
\frac{Z_R(\pi)}{Z_R(0)}
\ge1-\frac{C_\beta}{\log R}
\]
uniformly in finite square-annulus subgraphs and \(0\le b_e\le\beta\), with inner and outer pinned to the same rank-one projector at \(t=0\).

Combining with (L11) gives the **candidate derived boundary-crossing bound**
\[
\boxed{
\mathbb P_{\text{equal-pinned}}\left(
\exists\text{ index loop connecting the inner and outer boundary sets}
\right)\le\frac{C_\beta}{\log R}.
}
\tag{L12}
\]
Note the exact scope: this is a **pinned-boundary** crossing probability in the diagram measure at \(t=0\). It is **not** a crossing bound under arbitrary exterior conditionings or the free-boundary CP measure.

This identifies a more precise possible replacement for the O(3) sign-cluster step: **positive colored-index loops** and their boundary-crossing probabilities. It does *not* yet carry out the original paper's subsequent boundary comparison, multiple-annulus factorization, or observable-to-connectivity reduction.

## 5. One-site sanity check on a two-edge graph

Consider a path \(A-x-B\), with the endpoints pinned and the central spin \(P_x\) free, in \(CP^2\) (so \(q=3\)) and two couplings \(b=1\). For coincident endpoints \(P_A=P_B=|e_1\rangle\langle e_1|\),
\[
Z(1)=\mathbb E e^{2|z_1|^2}
=2\int_0^1(1-s)e^{2s}ds
=\frac{e^2-3}{2}\simeq2.19452805.
\]
For orthogonal endpoints \(P_A=|e_1\rangle\langle e_1|\), \(P_B=|e_2\rangle\langle e_2|\),
\[
Z(0)=\mathbb E e^{|z_1|^2+|z_2|^2}
=2\int_0^1 s e^s ds=2.
\]
Thus
\[
1-\frac{Z(0)}{Z(1)}\simeq0.08864232>0.
\tag{L13}
\]
This is consistent with the loop-crossing identity. The leading low-coupling difference is \(\beta^2/[q(q+1)]\), corresponding to the diagram with one copy of each path edge and the cross-pairing at the central vertex.

## 6. The actual open bridge

The original O(3) Section 4 does more than establish an *equal-pinned* annulus crossing identity. It compares boundary conditions, uses association/monotonicity, identifies a physical two-point observable with cluster connectivity, and then controls crossings over many annuli.

For CP projectors, (L8)–(L12) provide the positive **two-boundary** loop representation, but the following are **NOT proved**:

1. **Boundary comparison.** Is the probability of an index loop crossing an annulus under the relevant free/exterior CP Gibbs measure bounded above by the equal-pinned crossing probability (or by some usable multiple of it)? The loop fugacity \(q\) for unpinned loops changes to weight \(1\) upon touching pinned projectors. No stochastic ordering follows from positivity alone.
2. **Several annuli.** Do useful conditional or multiplicative crossing estimates follow when annular boundaries are pinned simultaneously? Positive weight at two projector values need not survive arbitrary additional pinned orientations.
3. **Adapt Wolff's existing observable-to-loop representation to this boundary problem.** Wolff (2010), Eqs. (21)–(23), *already* represents adjoint two-point correlations with two active loops/worm defects. The open work is to compare that **marked** loop ensemble (with appropriate free/exterior conditions) to the **unmarked equal-pinned** annular crossing law in (L12), with uniform constants. An unmarked crossing estimate alone does not imply an exponentially decaying two-point correlation.
4. **Lattice-model dependence.** The argument is for the exact nearest-neighbour \(e^{\beta\operatorname{tr}(P_xP_y)}\) projector model. Do not silently import it to a version with explicit independent dynamical \(U(1)\) links or \(\theta\ne0\).

These are sharp proof obligations, not evidence that the full CP mass gap is settled. A successful comparison/observable bridge would be substantive new mathematics and must be independently checked before being used to claim exponential decay.

## References and priority for review

- OpenAI (2026), *Exponential decay in two-dimensional classical O(n) models*, especially Sections 2–4 and the sign-cluster boundary comparison: https://github.com/openai/math/tree/main/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026
- This PR: [CPN_TWIST.md](CPN_TWIST.md), [CPN_TWIST_THEOREM.md](CPN_TWIST_THEOREM.md), [ROUTE.md](ROUTE.md).
- **Direct prior work:** Ulli Wolff, *Simulating the All-Order Strong Coupling Expansion IV: CP(N−1) as a loop model*, Nucl. Phys. B 832 (2010) 520–537, arXiv:1001.2231, https://arxiv.org/abs/1001.2231. Section 2.2, Eq. (17) is the **same quartic action** up to the coupling normalization; Eqs. (18)–(19) provide its loop weights; Eqs. (21)–(23) relate adjoint correlations to active-loop observables. Read at source on 7 November 2026. The note's (L3)–(L11) is an independent transparent derivation of a *particular pinned-boundary specialization*, not a claim to have originated CP loop representations.
- Related but different CP/loop literature: Nahum, Chalker, Serna, Ortuño and Somoza, *3D Loop Models and the CP^{n−1} Sigma Model*, Phys. Rev. Lett. 107, 110601 (2011), https://arxiv.org/abs/1104.4096.
- The tensor moment (L3) is standard symmetric-power/Haar integration. Search for earlier random-loop or graphical expansions before claiming novelty.

**Research priority:** compare the two-pinned-boundary specialization (L8)–(L11) directly against Wolff's 2010 graphical formalism, then try to prove or disprove item 1 (boundary comparison) using a small explicit graph. Next bridge from Wolff's marked-loop correlator to our unmarked annular crossing law; do not claim the all-β CP gap until both steps are proved.
