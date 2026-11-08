# CP projector two-hub transfer: exact kernel, an independent D6 audit, and a weak-bridge theorem

**7 November 2026 — further step after the independent review in [CPN_PINNING.md §12](CPN_PINNING.md).** The positive CP index-loop expansion is prior work (Wolff 2010). The analytic arguments here are finite-volume, \(\theta=0\), integer \(q\ge2\), and use the complete exponential action. The computer checks have separately stated finite-multiplicity scopes. This note does **not** prove monotonicity for arbitrary two-hub coupling \(J\), general annuli, exponential CP decay, or Yang–Mills.

**Later result (8 November 2026):** the restriction to sufficiently small bridge coupling J has now been **removed for the serial two-hub graph and a much larger single-gateway/two-terminal class**. The event-resolved positive-kernel contraction and the dimension-shift formula are developed in [CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md). The present note retains the transfer-operator and first-order arguments as independent checks, not as the strongest current theorem. The new tangle-contraction step has been submitted for an independent review; it is still limited to one gateway x and one outer mark a, not an arbitrary multi-site annulus.

## 1. A genuinely interacting two-hub one-sided graph

Fix rank-one projectors \(P_u,P_v\) at overlap
\[
p=\operatorname{tr}(P_uP_v)\in[0,1].
\]
Consider four base bonds
\[
u-x:\ b_u,\quad v-x:\ b_v,\quad x-y:\ J,\quad y-a:\ b,
\tag{T1}
\]
where \(x,y\) are **two distinct free, interacting hub spins**, and \(a\) is a free **marked outer leaf**. The marked middle layer is \(S=\{u,v\}\). The event \(E\) is that an oriented index-strand excursion travels from \(a\) to \(u\) or \(v\) through **both** unmarked hubs, after cutting the marked vertices. It is a graph event, not the mere occupation of a cut.

Define
\[
M=b_uP_u+b_vP_v,\qquad
G(p)=\int d\omega(P_x)e^{\operatorname{tr}(MP_x)},\qquad
f_q(z)=\sum_{m\ge0}\frac{z^m}{(q)_m}.
\tag{T2}
\]

### Exact physical transfer operator

On \(L^2(CP^{q-1},d\omega)\) introduce
\[
(T_Jf)(P)=\int d\omega(Q)\,e^{J\operatorname{tr}(PQ)}f(Q).
\tag{T3}
\]
This is self-adjoint, compact, pointwise positivity preserving and **positive semidefinite as an operator** for \(J\ge0\). Indeed
\[
e^{J\operatorname{tr}(PQ)}
=\sum_{n\ge0}\frac{J^n}{n!}
\langle P^{\otimes n},Q^{\otimes n}\rangle_{\rm HS}
\]
is a sum of positive-definite feature kernels. Thus for every \(f\in L^2\),
\[
\langle f,T_Jf\rangle
=\sum_{n\ge0}\frac{J^n}{n!}
\left\|\int f(P)P^{\otimes n}\,d\omega(P)\right\|_{\rm HS}^2\ge0.
\tag{T4}
\]
Global \(SU(q)\) invariance gives \(T_J\mathbf1=f_q(J)\mathbf1\). Therefore \(K_J=T_J/f_q(J)\) is a reversible **Markov transfer operator** with spectrum in \([0,1]\). In particular, on the adjoint/degree-one functions \(P\mapsto \operatorname{tr}(PB)-\operatorname{tr}(B)/q\), its eigenvalue is
\[
\boxed{
\lambda_1(J)=\frac{q f'_q(J)/f_q(J)-1}{q-1}\in[0,1].
}
\tag{T5}
\]
The derivation uses \(m_J=f'_q(J)/f_q(J)=\mathbb E_{K_J(P,\cdot)}\operatorname{tr}(PQ)\) and
\(\mathbb E[Q\mid P]=m_JP+[(1-m_J)/(q-1)](I-P)\).

Integrating the outer free leaf first, then \(y\), gives the **exact unrestricted** partition
\[
\boxed{Z_J(p)=f_q(b)\,f_q(J)\,G(p).}
\tag{T6}
\]
Equivalently, \(Z_J(p)=f_q(b)\langle e^{\operatorname{tr}(M\,\cdot)},T_J\mathbf1\rangle\).

**Limit of the transfer-operator argument:** (T4) is ordinary Hilbert-space positivity and positivity preservation. It does NOT imply monotonicity of the *restricted* ratio \(h_J(p)=A_J(p)/Z_J(p)\) for the graphical event \(E\). Such an inference would require a total-positivity/order-preservation statement specifically for the restricted strand-wiring transfer operator. The full spin partition alone cannot determine the connectivity event.

## 2. Independent, term-by-term audit of the previous D6 formula

First remove the bridge \(x-y\), and instead attach a **free marked leaf a directly to x**, as in [CPN_DOUBLE_STAR_FUSION_THEOREM.md](CPN_DOUBLE_STAR_FUSION_THEOREM.md), D6.

Fix exactly \(r\) copies of \(u-x\), \(s\) of \(v-x\), and \(m\) of \(a-x\), with \(d=r+s\). Let \(S_{r,s}(p)\) denote the sum of the two-pin rank-one trace weights over permutations of the **d pinned-sector slots**:
\[
S_{r,s}(p)=\sum_{\pi\in S_d}p^{K(\pi)},
\]
where \(K(\pi)\) counts the alternating \(u/v\) visit pairs. Its coefficients are nonnegative and the expression is independent of the free leaf.

**Exact monomial coefficients** after summing *every* permutation at the free hub and at the free leaf:
\[
\boxed{
[\ b_u^r b_v^s b^m\ ]Z_{\rm full}(p)
=\frac{S_{r,s}(p)}{r!s!\,(q)_d\,(q)_m},
}
\tag{D1}
\]
\[
\boxed{
[\ b_u^r b_v^s b^m\ ]Z_{\rm no\ crossing}(p)
=\frac{S_{r,s}(p)}{r!s!\,(q)_{d+m}}.
}
\tag{D2}
\]
In the no-cross sector the hub permutation preserves the **d pinned slots** and **m exterior slots** separately. The leaf permutation sum is \((q)_m\) and cancels its moment denominator; the m! separate hub permutations cancel the edge factorial, giving (D2). The unrestricted sector factors after integrating the free leaf, giving (D1).

Consequently,
\[
\boxed{
\mathbb P(\mathrm{NC}\mid r,s,m;\ p)
=\frac{(q)_d(q)_m}{(q)_{d+m}},
}
\tag{D3}
\]
a conditional identity independent of \(p\) that establishes D6 **term by term for all pin overlaps**, not only at \(p=1\). Resumming (D2) over r,s,m gives D6:
\(Z_{\rm NC}(p)=\sum_d [H_d(\lambda_+,\lambda_-)/(q)_d] f_{q+d}(b)\).
The accompanying independent permutation enumerator checks all trace-polynomial coefficients exactly with Python rational arithmetic at q=2,3,5 for several tuples up to two copies per edge. The algebraic argument is general.

## 3. A NEW full-exponential weak-bridge theorem for two interacting hubs

Return to the serial **two-hub** graph (T1). The full action includes \(e^{J\operatorname{tr}(P_xP_y)}\), not a Taylor-truncated approximation. For the moment take \(J\to0^+\).

Let \(\lambda_\pm(p)\ge0\) be the two nonzero eigenvalues of \(M\), so
\[
\lambda_++\lambda_-=b_u+b_v,\qquad
\lambda_+\lambda_-=b_ub_v(1-p).
\]
Put
\[
w_d(p)=\frac{H_d(\lambda_+,\lambda_-)}{(q)_d},\quad
\mu_p(d)=\frac{w_d(p)}{G(p)},\quad
\nu_b(m)=\frac{b^m}{(q)_m f_q(b)}.
\tag{W1}
\]
Both are normalized probability distributions on the nonnegative integers.

**One-bridge insertion lemma.** Fix r,s pinned incidences at x (d=r+s) and m free outer incidences at y. Condition on **exactly one x-y strand** (the coefficient linear in J). The probability of an oriented excursion from a to {u,v} is exactly
\[
\boxed{\quad
\mathbb P(E\mid r,s,m,\ k_{xy}=1;\ p)
=\frac{d}{q+d}\,\frac{m}{q+m}.
\quad}
\tag{W2}
\]
This is independent of p. At x, insert the unique bridge strand into the existing symmetric-tensor rooted diagram: preserving the pinned-sector visit word, it can join any of the d rooted slots or make an unpinned free loop with q color choices, giving weights \(d:q\). At y, the same insertion against the m exterior slots gives weights \(m:q\). Because the two halves meet in only **one** bridge strand, their normalized insertion factors multiply. There is no claim of such factorization for two or more bridge strands.

The same statement can be verified directly by summing local vertex permutations and tracing their cycles; the accompanying exact-rational script checks (W2) at several nonzero values of r,s,m and q, **including coefficients of every power p^K separately**.

At J=0, the pinned-sector d and outer m have independent distributions \(\mu_p,\nu_b\). The single-bridge sector has relative total partition weight \(1/q\), since y is rotationally uniform and \(\int d\omega(P_y)\operatorname{tr}(P_xP_y)=1/q\). Therefore
\[
\boxed{\quad
h_J(p):=\mathbb P_J(E\mid P_u,P_v)
=\frac{J}{q}\ U(p)\ V(b)+O_{C^1([0,1])}(J^2),
\quad}
\tag{W3}
\]
where
\[
U(p)=\mathbb E_{\mu_p}\frac{d}{q+d},\qquad
V(b)=\mathbb E_{\nu_b}\frac{m}{q+m}.
\tag{W4}
\]
The small-J remainder is uniform in p **together with its first p derivative**, for fixed finite q and other couplings. This follows from the absolutely convergent positive diagram series and termwise differentiated two-pin polynomials, with finite exponential strand moments.

There is a useful, exact link to the physical transfer operator:
\[
\boxed{\quad
V(b)=\lambda_1(b)
=\frac{q f'_q(b)/f_q(b)-1}{q-1}.
\quad}
\tag{W5}
\]
This follows term by term, since the coefficient identity
\[
\frac{m}{(q)_m(q+m)}
=\frac1{q-1}\left(\frac{q(m+1)}{(q)_{m+1}}-\frac1{(q)_m}\right)
\]
holds for every m≥0.

The double-star proof gives **strictly increasing likelihood-ratio order** of \(\mu_p(d)\) as p grows, provided \(b_u,b_v>0\). The test function \(d/(q+d)\) is strictly increasing; in fact \(U'(p)>0\) throughout [0,1]. To check strictness including endpoints, write \(R_d(p)=H_{d+1}/H_d\); \(R_0=b_u+b_v\), \(R_d=(b_u+b_v)-b_ub_v(1-p)/R_{d-1}\). The score \(s_d(p)=\partial_p\log w_d(p)\) is nondecreasing and nonconstant in d because \(\partial_p\log R_1>0\) for every p∈[0,1]. Then
\[
U'(p)=\operatorname{Cov}_{\mu_p}\left(\frac d{q+d},s_d(p)\right)>0.
\tag{W6}
\]

**Theorem (two-hub weak-bridge fusion monotonicity).**
Fix any \(q\ge2\) and **positive** \(b_u,b_v,b\). There exists a \(J_*=J_*(q,b_u,b_v,b)>0\) such that for every \(0<J<J_*\),
\[
\boxed{\frac{\partial}{\partial p}h_J(p)>0
\quad\text{for ALL }p\in[0,1].}
\tag{W7}
\]
**Proof.** By (W3), \(\partial_p h_J=(J/q)\lambda_1(b)U'(p)+O(J^2)\), uniformly over [0,1]. The leading coefficient is strictly positive and continuous in p; hence its minimum on the compact interval is positive. Choose J sufficiently small that the uniform O(J²) term cannot change the sign. QED.

This is a theorem for the **full exponential action at small but nonzero J**, not just a statement about the first finite-Taylor coefficient. It does NOT establish monotonicity for arbitrary J or other two-hub topologies.

### Two successive weak-bridge regions

Attach a left and a right copy of the chain (T1), sharing only the middle sites u,v, with independent free hubs \(x_L,y_L\) and \(x_R,y_R\), and exterior marked leaves \(a_L,a_R\). Let the bridge couplings \(J_L,J_R\) each lie within their own proven small-positive ranges. At fixed two-pin overlap p, the side events factor:
\(h_{\rm both}(p)=h_{J_L,L}(p)\,h_{J_R,R}(p)\), which is nondecreasing.

The exact scalar fusion-tilt formula then gives
\[
\mathbb P_{\rm free}(E_L\cap E_R)
\le\mathbb P_{\rm middle\ fused}(E_L\cap E_R).
\]
After fusion the two sides share a **single articulation vertex**, so the already proved single-vertex invariance and two-point pinning theorem can be applied on each side. Thus
\[
\boxed{
\mathbb P_{\rm free}(E_L\cap E_R)
\le\mathbb P_{\rm middle\ fused}(E_L\cap E_R)
\le\mathbb P_{\rm all\ marked\ sites\ equal\ pinned}(E_L\cap E_R)
}
\tag{W8}
\]
for this graph class and sufficiently weak but strictly positive J_L,J_R. Every local coupling other than these bridges may be arbitrary finite positive. This is a new restricted **four-free-hub**, two-region comparison, but not the desired unrestricted annulus statement.

## 4. Exact-rational checks, and what the operator does not solve

For q=3, b_u=b_v=b=1, (W3) gives the **exact full-exponential slope at J=0**:

| overlap p | \(\partial_J h_J(p)\vert_{J=0}\) |
|---:|---:|
| 0 | 0.004558485238 |
| 0.25 | 0.004776293997 |
| 0.5 | 0.004989484196 |
| 0.75 | 0.005198200355 |
| 1 | 0.005402581094 |

The values use convergent series in b_u,b_v,b (not truncated edge expansions).

Separate **finite Taylor-polynomial** checks on the two-hub graph with all base strengths 1 and each edge multiplicity ≤1 or ≤2 give:

| graph | cutoff | \(r_0\) | \(r_1\) | \(r_2\) |
|---|---|---:|---:|---:|
| serial chain u/v–x–y–a | 1 | 0.0017857143 | 0.0062500000 | — |
| same | 2 | 0.0039565621 | 0.0122794757 | 0.0154720712 |
| x and y BOTH linked to u and v, a linked to y | 1 | 0.0301548492 | 0.0700531208 | 0.1029411765 |
| same plus a–x | 1 | 0.0598036316 | 0.1410902994 | 0.1975572519 |

These support the targeted ordering in the tested finite polynomial examples but **are not the proof of (W7) and do not cover all J**. The accompanying script evaluates the first-bridge insertion identity and D6 via exact fractions and the complete-series perturbative slopes.

### The next genuinely hard task

For arbitrary J>0, the operator \(K_J\) in (T3) has a positive spectrum, but the graphical no-cross restriction involves **permutation/wiring states at both hubs**, not merely a positive function in \(L^2(CP^{q-1})\). A useful replacement theorem would require an order on these states preserved by the **event-restricted transfer**, or a direct proof that \(h_J'(p)\ge0\). Neither follows from (T4). The smallest nontrivial follow-up graph has both u and v linked to both x and y, plus x-y and an exterior connection; its two-hub wiring cannot be collapsed into a single root occupation count.

**Open:** every-J monotonicity on the serial chain, the multiple-attachment two-hub graph, the full layer comparison, and any size-uniform annulus estimate. Neither a CP mass gap nor a Yang–Mills mass gap is implied.

**References within this PR:** [CPN_DOUBLE_STAR_FUSION_THEOREM.md](CPN_DOUBLE_STAR_FUSION_THEOREM.md), [CPN_FUSION_OVERLAP_REDUCTION.md](CPN_FUSION_OVERLAP_REDUCTION.md), [CPN_FUSION_LIMIT_AND_SEPARATOR.md](CPN_FUSION_LIMIT_AND_SEPARATOR.md), [CPN_ASSOCIATION_COUNTEREXAMPLE.md](CPN_ASSOCIATION_COUNTEREXAMPLE.md).
