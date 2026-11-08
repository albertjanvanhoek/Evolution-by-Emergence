# A symbolic all-q certificate for the CP squarefree two-gateway model

**8 November 2026 — correction and strengthening of [CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md](CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md).** The earlier computation checked \(q=2,3,5,8\) independently; this one gives a **single symbolic certificate for ALL real \(q\ge2\)**, and therefore for every physical integer \(q\ge2\), on the **same finite edge-multiplicity-0/1 model**. It still says nothing directly about the full exponential CP action. The machine-checked mathematical claim is a finite sign computation in \(\mathbb Z[q-2,b_1,\ldots,b_7]\), not a pointwise numerical test.

## 1. Statement

The graph has two pinned source sites u,v; two free gateways x,y; one free marked outer site a; and the seven edges
\[
u-x,\quad v-x,\quad u-y,\quad v-y,\quad x-a,\quad y-a,\quad x-y.
\]
For each edge, retain only its \(n_e\in\{0,1\}\) contributions from the positive CP projector index-loop expansion, and count a direct marked-root-to-a excursion after cutting u,v,a.

With the two projectors pinned at overlap \(p\in[0,1]\), write the positive finite-polynomial partition and restricted crossing sum as
\[
Z(p,\mathbf b;q)=c_0(\mathbf b;q)+c_1(\mathbf b;q)p+c_2(\mathbf b;q)p^2,\quad
A(p,\mathbf b;q)=a_0(\mathbf b;q)+a_1(\mathbf b;q)p+a_2(\mathbf b;q)p^2.
\]
All seven strengths \(b_e\) may be **arbitrary nonnegative real numbers**.

**Computer-assisted theorem (symbolic q, 7-edge squarefree ensemble).**
\[
\boxed{
\frac{\partial}{\partial p}\frac{A(p,\mathbf b;q)}{Z(p,\mathbf b;q)}
\ge0
\quad\text{for every }q\ge2,\ \mathbf b\in[0,\infty)^7,\
p\in[0,1].
}
\tag{Q1}
\]
The \(q\) extension to arbitrary real \(q\ge2\) is a statement about the **positive graphical polynomial with formal loop fugacity q**; the CP^{q−1} projector interpretation itself assumes **integer q≥2**.

## 2. Exact finite algebraic sign certificate

At the three **free** vertices x,y,a, the maximum local degree of any squarefree diagram is respectively 4,4,2. Thus every diagram's local tensor moment denominator divides the same strictly positive polynomial
\[
\boxed{L(q)=(q)_4^2(q)_2,\quad
(q)_d=q(q+1)\cdots(q+d-1).}
\tag{Q2}
\]
Multiplying \(Z,A\) by \(L(q)\) turns each of their monomial coefficients into a **nonnegative integer polynomial in q**. Indeed, a diagram with free degrees \(d_x,d_y,d_a\) and \(\ell\) free loops contributes exactly
\[
q^\ell\prod_{j=d_x}^{3}(q+j)
\prod_{j=d_y}^{3}(q+j)
\prod_{j=d_a}^{1}(q+j)
\tag{Q3}
\]
to the rescaled coefficient of its edge-strength monomial and overlap power \(p^K\). No decimal arithmetic or interpolation in q is used.

Write \(\widehat A=L A,\widehat Z=L Z\), and put hats on their p-coefficients \(\widehat a_i,\widehat c_i\). Then
\[
L(q)^2 Z^2\partial_p(A/Z)
=\widehat D_0+\widehat D_1p+\widehat D_2p^2,
\tag{Q4}
\]
where
\[
\widehat D_0=\widehat a_1\widehat c_0-\widehat a_0\widehat c_1,\quad
\widehat D_1=2(\widehat a_2\widehat c_0-\widehat a_0\widehat c_2),\quad
\widehat D_2=\widehat a_2\widehat c_1-\widehat a_1\widehat c_2.
\tag{Q5}
\]
The numerator is strictly proportional to the original derivative numerator by \(L^2>0\), so its sign is unchanged.

The independent pure-integer polynomial enumeration and convolution (see [pilot/cpn_multi_gateway_symbolic_q.py](pilot/cpn_multi_gateway_symbolic_q.py)) verifies **as a finite exact coefficient identity** that all coefficients, including every mixed monomial in
\[
t=q-2,\qquad b_{ux},b_{vx},b_{uy},b_{vy},b_{xa},b_{ya},b_{xy},
\tag{Q6}
\]
are **nonnegative** for the THREE polynomials
\[
\boxed{
\widehat D_0,\quad
\widehat D_1,\quad
\widehat D_0+\widehat D_1+\widehat D_2.
}
\tag{Q7}
\]
This is an explicit membership certificate in the positive-coefficient polynomial cone \(\mathbb N[t,b_1,\ldots,b_7]\) for the three expressions.

The exact counts of strictly positive joint \((t,\mathbf b)\)-coefficients and negative coefficients are:

| Expression | Positive | Negative | Max nonzero degree in t |
|---|---:|---:|---:|
| \(\widehat D_0\) | 15,746 | 0 | 16 |
| \(\widehat D_1\) | 3,752 | 0 | 14 |
| \(\widehat D_2\) | 1,210 | **432** | 12 |
| \(\widehat D_0+\widehat D_1+\widehat D_2\) | 15,598 | 0 | 16 |

The negative coefficients of \(\widehat D_2\) are real and **not** discarded. The correct identity is
\[
\boxed{
\widehat D_0+\widehat D_1 p+\widehat D_2p^2
=(1-p^2)\widehat D_0
+p(1-p)\widehat D_1
+p^2(\widehat D_0+\widehat D_1+\widehat D_2).
}
\tag{Q8}
\]
Since \(0\le p\le1\) and all three coefficient-polynomials on the right evaluate nonnegatively for \(t=q-2\ge0,\mathbf b\ge0\), (Q1) follows.

This proves the normalized crossing inequality **without** requiring every conditional alternation ratio \(r_k=a_k/c_k\) to increase. Indeed the previously independently confirmed asymmetric-coupling witness has \(r_2<r_1\).

### A concrete negative term that is compensated

For q=3, consider the monomial in edge-strength order (ux,vx,uy,vy,xa,ya,xy)
\[
b_{ux}\,b_{vx}^{\,2}\,b_{uy}^{\,2}\,b_{vy}\,b_{xa}\,b_{ya}
\qquad\text{(no }b_{xy}\text{ factor)}.
\]
In the **unscaled** derivative numerator \(Z^2h'\), its three coefficient values are **exactly**
\[
D_0:\frac{269}{2073600},\qquad
D_1:\frac{287}{3110400},\qquad
D_2:-\frac1{248832},
\]
but
\[
(D_0+D_1+D_2):\frac{113}{518400}>0.
\]
This illustrates concretely why the negative \(D_2\) entries cannot invalidate (Q8), and supplies a small exact-rational target for a reviewer without requiring inspection of all thousands of symbolic terms. The symbolic \(q-2\) certificate controls the same monomial and all others for every q≥2.

## 3. Reproducibility and independent cross-checks

Run from \`research/yang-mills-mass-gap/pilot/\`:
\`\`\`sh
python3 cpn_multi_gateway_symbolic_q.py
\`\`\`

The script consumes the q-independent loop-diagram enumeration from the already committed \`cpn_multi_gateway_exact_certificate.py\`. It then computes all remaining polynomial algebra using **only Python integers**, not rational interpolation or a prechosen finite list of q values. For robustness, a **separate independently written port-following enumerator** reconstructed all 4,222 diagrams, obtained identical sign counts, and recomputed rational coefficient arrays for q=2,3,5,8,10,50. In the committed script there is an additional exact cross-check that evaluates the symbolic coefficient arrays at q=2,3,5,8,50 and compares them coefficient-by-coefficient with the original rational arrays.

The symbolic claim is **conditional on exhaustive correctness of the finite enumeration and sign script**. It is mechanically auditable and independently reproduced, but no formal proof assistant or human mathematical referee has certified the code.

## 4. Implications and limitations

This extends the earlier **finite-polynomial** certificate to **every physical integer q**, and is a stronger counterexample to the proposed idea that the normalized event order only works at a few special q. It does NOT establish the same inequality for the full \(\exp(\sum_e b_e\operatorname{tr} P_iP_j)\) model, because that contains arbitrarily many copies of each edge.

A distinct **full-exponential** result remains valid for weak added gateway connections ([CPN_MULTI_GATEWAY_STABILITY.md](CPN_MULTI_GATEWAY_STABILITY.md)). A further new result ([CPN_UNIFORM_RELATIVE_SLOPE.md](CPN_UNIFORM_RELATIVE_SLOPE.md)) supplies a network-size-independent **relative** positive derivative bound for the single-gateway baseline, including p=0 and p=1, without creating a uniform multi-gateway theorem.

**Next frontier:** establish a sign certificate or order-preserving boundary-wiring transfer for the **untruncated** CP model at arbitrary couplings. One can first use the finite-algebraic sign language of (Q7)–(Q8) at cutoff two, where the overlap degree and boundary wiring states grow, before claiming an operator inequality.
