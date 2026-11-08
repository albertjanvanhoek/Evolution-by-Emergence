# Two CP gateways: the strong alternation-ordering fails, but normalized fusion ordering survives an exact finite polynomial test

**8 November 2026 — PR #144.** This is an **exact rational computer-assisted result for a finite, squarefree edge-multiplicity truncation** of the positive CP projector-loop measure, not a theorem about the complete exponential action at arbitrary couplings. It tests the first genuine multiple-gateway geometry missing from [CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md). The script [pilot/cpn_multi_gateway_exact_certificate.py](pilot/cpn_multi_gateway_exact_certificate.py) is self-contained and uses only integer and rational arithmetic.

## 1. Graph and observable

Use **five vertices** \(u=0,v=1,x=2,y=3,a=4\). Pin \(u,v\) to two rank-one CP projectors at overlap \(p\). The free gateways are x,y, and the **one free marked exterior vertex** is a. Use all seven edges
\[
\{ux,vx,uy,vy,xa,ya,xy\}.
\tag{G1}
\]
This is a genuine **two-gateway one-sided graph**: both pinned source vertices reach both x and y, both gateways reach the outer mark, and the gateways interact by the xy edge. There is no direct root-to-a bypass. The marked sites are u,v,a. Define \(E\) as the direct oriented index-strand **excursion from a to either u or v**, stopping at its first marked vertex. E is independent of permutations at u,v,a.

For EACH edge independently retain ONLY multiplicities \(n_e\in\{0,1\}\) in the Wolff-type positive index-loop expansion, and sum **all** permutations at free vertices x,y,a. For any integer \(q\ge2\) this yields two positive polynomials in the overlap \(p\):
\[
Z_q(p;\mathbf b)=c_0(\mathbf b)+c_1(\mathbf b)p+c_2(\mathbf b)p^2,
\quad
A_q(p;\mathbf b)=a_0(\mathbf b)+a_1(\mathbf b)p+a_2(\mathbf b)p^2.
\tag{G2}
\]
Here \(Z\) is the unrestricted diagram partition sum, \(A\) is restricted to E, and each coefficient is a multiaffine polynomial in the seven nonnegative couplings \(b_e\), with rational q-dependent coefficients. This is a **positive finite polynomial graph model**, but \(\prod_e(1+b_e\operatorname{tr}(P_iP_j))\), not \(\exp(\sum_e b_e\operatorname{tr}(P_iP_j))\).

## 2. Rigorous counterexample to universal coefficientwise ordering within the polynomial model

Fix \(q=3\) (CP²) and the following **symmetric, strictly positive** edge strengths in the order of (G1):
\[
\boxed{
(b_{ux},b_{vx},b_{uy},b_{vy},b_{xa},b_{ya},b_{xy})
=(1/8,\ 8,\ 8,\ 1/8,\ 8,\ 8,\ 1/4).
}
\tag{G3}
\]
This graph is symmetric under swapping u↔v AND x↔y simultaneously.

Full exact-rational permutation enumeration (4,222 local-pairing diagrams over all 128 edge subsets) gives
\[
(c_0,c_1,c_2)=
\left(\frac{5206485343}{24883200},
\frac{346063027}{24883200},
\frac{40207}{388800}\right),
\tag{G4}
\]
\[
(a_0,a_1,a_2)=
\left(\frac{2070859}{38880},
\frac{11589679}{1555200},
\frac{319}{6075}\right).
\tag{G5}
\]
Thus
\[
\begin{split}
r_0=a_0/c_0&=\frac{1325349760}{5206485343}\simeq0.254557475,\\
r_1=a_1/c_1&=\frac{185434864}{346063027}\simeq0.535841305,\\
r_2=a_2/c_2&=\frac{20416}{40207}\simeq0.507772278.
\end{split}
\tag{G6}
\]
The exact rational difference is
\[
\boxed{
r_2-r_1=-\frac{390556817616}{13914156126589}<0.
}
\tag{G7}
\]
Therefore the **strong coefficientwise conjecture** "conditional excursion probability \(r_k\) always increases with A/B alternation count k" fails in this bona fide multiple-gateway, one-sided graph under a positive finite strand cutoff, **even though there is no bypass**. It would be logically incorrect to say this refutes the same conjecture for the FULL exponential CP model, since the repeated-edge terms excluded here could change the sign.

## 3. Positive normalized ordering: a coefficientwise *polynomial sign certificate*

Set \(h_q(p;\mathbf b)=A_q(p;\mathbf b)/Z_q(p;\mathbf b)\), and write its derivative as
\[
Z_q(p;\mathbf b)^2\,\partial_p h_q(p;\mathbf b)
=D_0(\mathbf b)+D_1(\mathbf b)p+D_2(\mathbf b)p^2,
\tag{C1}
\]
where
\[
D_0=a_1c_0-a_0c_1,\quad
D_1=2(a_2c_0-a_0c_2),\quad
D_2=a_2c_1-a_1c_2.
\tag{C2}
\]
Every \(D_i\) is a multivariate polynomial of degree at most two **per coupling** (since it is a product of multiaffine polynomials).

**Exact rational certificate.** An exhaustive symbolic-coefficient enumeration, implemented in the companion script, verifies **for each \(q\in\{2,3,5,8\}\)** that every monomial coefficient of
\[
\boxed{D_0,\quad D_1,\quad D_0+D_1+D_2}
\tag{C3}
\]
is **nonnegative**. In each q case the respective counts of strictly positive monomial coefficients are 1348, 348, and 1328; \(D_2\) alone has 52 negative coefficients, so the result is not a trivial consequence of each \(D_i\) being separately nonnegative.

For \(0\le p\le1\) the exact identity
\[
D_0+D_1p+D_2p^2
=(1-p^2)D_0+(p-p^2)D_1+p^2(D_0+D_1+D_2)
\tag{C4}
\]
has only nonnegative scalar factors. Evaluating each polynomial with arbitrary \(b_e\ge0\) therefore gives:

> **Computer-assisted finite-polynomial theorem.** On graph (G1), with every edge multiplicity restricted to 0 or 1, and for any **nonnegative real edge strengths** and each \(q=2,3,5,8\), the event-restricted normalized crossing probability \(h_q(p;\mathbf b)\) is **nondecreasing in \(p\in[0,1]\)**.

This is an *exhaustive coefficient-sign proof* for the finite model and listed q values, not a sampling experiment. The exhaustive script explicitly constructs every local pairing, loop color weight, event indicator, monomial exponent tuple, and exact rational D coefficients before assertions. It does NOT prove the same claim for all q≥2 or unbounded edge multiplicity.

For the strict CP² witness (G3),
\[
(D_0,D_1,D_2)\simeq
(818.525397632,\ 10.958041022,\ -0.040369348).
\tag{C5}
\]
So even this example with **\(r_2<r_1\)** has \(h'(p)>0\) for the entire overlap interval. Numerically, \(h(0)\simeq0.254557475\), \(h(1)\simeq0.272197686\). The sign is an exact rational consequence of (C4), not of those approximate values.

## 4. Why this matters for the complete CP proof

- **The obstruction is not merely a bypass.** The earlier [CPN_FUSION_LIMIT_AND_SEPARATOR.md](CPN_FUSION_LIMIT_AND_SEPARATOR.md) exhibited decreasing r_k only in a *three-layer* finite graph containing a forbidden bypass. Here there is **one outer marked vertex**, two separate gateways, and no bypass. The stronger coefficientwise lemma is still false in the finite polynomial class.
- **The right conjecture is the normalized derivative.** The exact full-model overlap reduction, when the fusion sites u,v are the only pinned sites, remains
  \[
  \partial_p(A/Z)=Z(p)^{-2}(A'Z-AZ'),
  \]
  equivalently \(\mathrm{Cov}_{K|p}(K,\mathbf1_E)/p\). A proof need only control this **averaged** correlation, not demand all r_k be ordered.
- **The two-terminal positive-kernel theorem is a distinct success.** It covers an arbitrary complex interior graph \(H\) **behind a single gateway** x. Graph (G1) has two source gateways, so it does not follow from that theorem. Scalar effective-edge deletion also cannot be asserted without checking a matrix-valued boundary wiring state.
- **Next target:** derive a positive operator/matrix kernel for the two x/y gateways that controls the *normalized* event derivative, or find a counterexample in the **untruncated exponential** model. A robust way to explore the latter would retain full exponential edge multiplicities through spin-integration/transfer rather than inferring it from a low-order cutoff.

## 5. Verification commands

From the PR's pilot directory, run
\`\`\`sh
python3 cpn_multi_gateway_exact_certificate.py
\`\`\`

The code uses only the Python standard library; all coefficients, including (G4)–(G7) and (C3), are verified as exact rational equalities/inequalities. It does not depend on or reuse the earlier pinned-coefficient enumerator.

**Status:** the strong \(r_k\) property is refuted in the finite strand model, but the more relevant normalized derivative sign has been certified for this finite graph and four q values. Whether that stronger positive result survives *full* untruncated CP interactions remains OPEN. No mass-gap theorem is implied.
