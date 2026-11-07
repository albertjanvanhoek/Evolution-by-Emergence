# An annular twist estimate for orthogonal SU(2) spin orbits

**7 November 2026 — independent adaptation/review of Part 1 of the OpenAI O(n) preprint.**

**Status and provenance.** This is a detailed mathematical adaptation of the argument in [OpenAI, *Exponential decay in two-dimensional classical O(n) models*, Sections 2–3](https://github.com/openai/math/tree/main/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026/build/sections), especially [rotation.tex](https://github.com/openai/math/blob/main/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026/build/sections/rotation.tex) (Lemma 2.1 and Proposition 2.2) and [annulus.tex](https://github.com/openai/math/blob/main/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026/build/sections/annulus.tex) (Proposition 3.1). It is not a new proof of that preprint, a Lean verification, or an independent peer review. The two source propositions are used and their *dependence on target-space geometry* is audited below. The conclusion concerns boundary-twist free energy only, **not** exponential clustering, a CP mass gap, or Yang–Mills.

## Theorem A — general orthogonal-orbit annular twist

Let \(H\) be a finite-dimensional real inner-product space, and let \(M\subset\{s\in H:\|s\|=1\}\) be compact with a Borel probability measure \(\omega\). Suppose there is a continuous orthogonal representation \(\rho:SU(2)\to O(H)\) preserving both \(M\) and \(\omega\). Choose the conventional \(\mathfrak{su}(2)\) basis \(T_1,T_2,T_3\), with
\[
[T_1,T_2]=T_3,\quad [T_2,T_3]=T_1,\quad [T_3,T_1]=T_2,
\quad T_j=-i\sigma_j/2
\]
(up to an orientation convention), and write \(a=d\rho(T_1)\), \(b=d\rho(T_2)\), \(c=d\rho(T_3)\). Assume
\[
\|a\|_{\rm op},\,\|b\|_{\rm op},\,\|c\|_{\rm op}\leq1.
\tag{A1}
\]

For an integer \(R\ge2\), take any finite nearest-neighbor subgraph \(G=(V,E)\) of the square annulus \(\{x\in\mathbb Z^2:R\le\|x\|_\infty\le2R\}\), with nonnegative edge couplings \(0\le b_e\le\beta<\infty\). Choose \(s_*\in M\). At every present inner-boundary vertex fix \(s_x=e^{tc}s_*\); at every present outer-boundary vertex fix \(s_x=s_*\). Integrate all other spins against \(\omega\), with Boltzmann weight
\[
\exp\left(\sum_{\{x,y\}\in E}b_{xy}\langle s_x,s_y\rangle\right).
\]
Let \(Z_R(t)>0\) denote this partition integral, including any edges between pinned vertices.

**Conclusion.** There is a finite \(C_\beta\), depending on \(\beta\) and fixed geometric test profiles but independent of \(R,G,b_e,H,M,\omega,s_*,t\), such that
\[
\boxed{\quad
\frac{\min_{t\in\mathbb R}Z_R(t)}
{\max_{t\in\mathbb R}Z_R(t)}
\ \geq\ 1-\frac{C_\beta}{\log R}.
\quad}
\tag{A2}
\]
The right-hand side is informative for sufficiently large \(R\); it is allowed to be negative at small \(R\). In particular, the free-energy difference between any two *fixed* twists obeys \(O_\beta(1/\log R)\) for sufficiently large \(R\).

**Scope:** (A2) is a generalization of the *twist bound*, not of the original paper's subsequent sign-cluster argument. The model is a positive, ferromagnetic, bilinear orbit model at \(\theta=0\); no arbitrary non-bilinear target-space interaction is included.

## Corollary B — the standard two-dimensional CP^{q−1} projector model

For every integer \(q\ge2\), put \(H=\operatorname{Herm}_q(\mathbb C)\) with real inner product \(\langle X,Y\rangle=\operatorname{tr}(XY)\). Let
\[
M=\{P=zz^\dagger:\ z\in\mathbb C^q,\ z^\dagger z=1\}\cong CP^{q-1},
\]
with the invariant Fubini–Study probability measure. Every \(P\in M\) has \(\|P\|_{\rm HS}^2=\operatorname{tr}(P^2)=1\). The interaction is
\[
b_{xy}\,\operatorname{tr}(P_xP_y)
=b_{xy}\,|z_x^\dagger z_y|^2.
\]
Embed \(SU(2)\subset SU(q)\) into the first two coordinates. It acts on \(H\) via \(\rho(U)P=UPU^\dagger\), so \(d\rho(T)P=[T,P]\).

For \(T=-i\sigma_j/2\) in the embedded \(2\times2\) block, the operator \(P\mapsto[T,P]\) on \(\operatorname{Herm}_q(\mathbb C)\) has norm **exactly 1**. To see this, decompose \(H\) orthogonally into its \(2\times2\) Hermitian block, the off-diagonal \(2\times(q-2)\) rectangular blocks, and the lower-right Hermitian block. The generator acts respectively at angular frequencies \(0,1\), at \(1/2\), and at \(0\). Consequently (A1) holds. The Lie brackets close on the embedded \(\mathfrak{su}(2)\).

Hence **Theorem A applies to this entire CP^{q−1} projector family**, with the same \(1/\log R\) order. For \(q=3\) this gives an explicit CP² candidate. For \(q=2\), the projector model is the O(3) model with \(\beta_{O(3)}=\beta_{CP^1}/2\) after removing an additive constant.

**Period caution.** The representation on all \(CP^{q-1}\) projectors for \(q>2\) may require \(4\pi\) for \(e^{tc}\) to return to identity, since \(\operatorname{diag}(-I_2,I_{q-2})\) is not central in \(SU(q)\). On the particular boundary orbit \(P_*=e_1e_1^\dagger\), the orbit is already \(2\pi\)-periodic. Theorem A uses the safe period \(4\pi\), so no model-dependent period assumption is hidden.

## Detailed transfer of the proof

We give every target-space-dependent step, and identify the unchanged spatial estimate. Orientation conventions for edges agree with the cited \`rotation.tex\`.

### 1. Finite-graph setup and uniform coefficient bound

For a skew-adjoint edge field \(A=(A_e)_{e\in E}\) inside the three-dimensional image of \(\mathfrak{su}(2)\), define
\[
\mathcal H(A)=\sum_{e=(x,y)}b_e\langle s_x,(e^{A_e}-I)s_y\rangle,
\qquad W(A)=\langle e^{\mathcal H(A)}\rangle_0.
\tag{B1}
\]
Here \(\langle\cdot\rangle_0\) denotes the normalized untwisted Gibbs expectation, with arbitrary frozen spins, and \(W(0)=1\). Denote by \(X=D\mathcal H\) and \(\mathcal H_k=D^k\mathcal H\) the derivatives at zero. Compactness permits differentiating finite partition integrals.

The local coefficients of \(\mathcal H_k\) have the form
\[
J_e(g_1,\ldots,g_k)=b_e\left\langle s_x,
\frac1{k!}\sum_{\pi\in S_k}
g_{\pi(1)}\cdots g_{\pi(k)}s_y\right\rangle,
\quad g_j\in\{a,b,c\}.
\tag{B2}
\]
The assumptions \(\|s_x\|=\|s_y\|=1\) and \(\|g_j\|_{\rm op}\le1\) imply **exactly**
\[
|J_e(g_1,\ldots,g_k)|\le b_e\le\beta.
\tag{B3}
\]
No coordinate formula for the spins, no spherical integration formula, and no reflection symmetry are used in (B2)–(B3).

### 2. Ward identity and gradient estimate (source Lemma 2.1)

For every real vertex function \(f\) vanishing on all pinned sites, and \(g\in\{a,b,c\}\), change each integrated spin by
\[
s_x^{\rm old}=e^{-tf_xg}s_x^{\rm new}.
\]
Orthogonality and invariance of \(\omega\) preserve the measure; pinned spins do not move. The change of variables yields \(W(t(df)g)=1\), where \((df)_{xy}=f_y-f_x\). Differentiating twice gives
\[
0=\langle \mathcal H_2((df)g,(df)g)+X((df)g)^2\rangle_0.
\]
By (B3),
\[
\langle |X((df)g)|^2\rangle_0\le\beta\|df\|_2^2.
\tag{B4}
\]
The complex case follows by splitting \(f\) into real and imaginary parts.

Define \(R(h,k)=-D^2W(hc,kc)\). From (B1)–(B3), for complex edge forms,
\[
R(h,\bar h)=-\langle\mathcal H_2(hc,\bar h c)+|X(hc)|^2\rangle_0
\le\beta\|h\|_2^2,
\quad R(h,df)=0.
\tag{B5}
\]
The last equality again follows by differentiating a measure-preserving change of variables. These are exactly the source's gradient estimates.

### 3. Noncommutative gauge identity (source 2.10–2.12)

For potentials \(F_x\in\operatorname{span}_{\mathbb R}\{a,b\}\) vanishing on pinned sites, the same substitution yields
\[
W(dF)=W(B),\qquad
e^{B_e}=e^{F_x}e^{F_y-F_x}e^{-F_y}.
\tag{B6}
\]
This is a product identity in the *orthogonal representation*. The right-hand product lies in the image of the embedded \(SU(2)\), and its logarithm near the identity is in \(\operatorname{span}\{a,b,c\}\).

Expanding to second order gives
\[
B_e=\tfrac12[F_x,F_y]+O(F^3),\qquad DB_e(0)=0.
\tag{B7}
\]
For directions \(fa\) and \(gb\),
\[
D^2B_e(fa,gb)=\tfrac12(f_xg_y-g_xf_y)c
=:S(f,g)_ec.
\tag{B8}
\]
This uses only \([a,b]=c\).

**Fourth-order cancellation.** Differentiate \(B_e\) in four independent directions with generator pattern \(a,b,a,b\). The coefficient \(K=D_{1234}B_e(0)\) lies in the embedded \(\mathfrak{su}(2)\) image. Conjugation by \(e^{\pi a}\) fixes \(a\) and negates \(b,c\), while conjugation by \(e^{\pi b}\) fixes \(b\) and negates \(a,c\). Each conjugation fixes \(K\), because the multilinear coefficient contains an *even* number of generators of the negated type. Within \(\operatorname{span}\{a,b,c\}\), the common fixed subspace is \(\mathbb Ra\cap\mathbb Rb=\{0\}\); therefore
\[
\boxed{D_{a,b,a,b}^4B_e(0)=0.}
\tag{B9}
\]
Importantly, \(e^{\pi a}\) need not act as an involution on *all of* \(H\), only as the stated adjoint half-turn on the three-dimensional Lie subalgebra. This distinction is essential for \(CP^2\).

### 4. Fourth-derivative family inequality (source Proposition 2.2)

For a finite family of complex vertex functions \(f_i\) vanishing on pins, set
\[
u_i=df_i,\quad
T_{e\ell}=\sum_i u_i(e)\overline{u_i(\ell)},\quad
Q_e=\sum_i S(f_i,\overline{f_i})_e.
\]
The fourth-derivative chain rule applied to (B6), using (B7)–(B9), gives
\[
D^4W(u_i a,\overline u_i b,\overline u_j a,u_j b)
=-R(S_i,\overline S_j)+R(S_{ij},\overline S_{ij}).
\tag{B10}
\]
The source proof now expands the fourth derivative of \(e^{\mathcal H}\) into **15 set partitions**. Exactly four of these group into the nonnegative square
\[
\left\langle\left|\sum_i
\big[X(u_i a)X(\overline u_i b)
+\mathcal H_2(u_i a,\overline u_i b)\big]\right|^2\right\rangle_0\ge0.
\tag{B11}
\]
The other 11 terms have the following bounds, using **only** (B3) and the gradient estimate (B4):

| Terms remaining | Number | Total upper bound |
|---|---:|---:|
| Mixed \(\mathcal H_2 X X\) | 4 | \(4\beta^2\|T\|_{\rm HS}^2\) |
| Other \(\mathcal H_2\mathcal H_2\) | 2 | \(2\beta^2\|T\|_{\rm HS}^2\) |
| \(\mathcal H_3 X\) | 4 | \(4\beta^{3/2}\|T\|_{\rm HS}^2\) |
| \(\mathcal H_4\) | 1 | \(\beta\|T\|_{\rm HS}^2\) |

Thus the same constant \(K_{\rm rot}(\beta)=6\beta^2+4\beta^{3/2}+\beta\) is obtained.

To bound the other term from (B10), use the purely edge-algebraic relation
\[
S(f,g)\pm\tfrac12d(fg)
=\begin{cases}
\tfrac12(f_x+f_y)dg,&+\\
-\tfrac12(g_x+g_y)df,&-
\end{cases}
\]
together with the gauge-gradient invariance in (B5). This gives the same min-bound as in the original paper, and hence
\[
\boxed{
R(Q,\bar Q)\le
K_{\rm rot}(\beta)\|T\|_{\rm HS}^2+
\beta\sum_{i,j}\min\{\|f_i\|_\infty^2\|df_j\|_2^2,\;
\|f_j\|_\infty^2\|df_i\|_2^2\}.
}
\tag{B12}
\]
This is the exact generalization of source Proposition 2.2 for our class of target spaces. The proof is a **term-by-term transfer of the published/preprint calculation**, not a separately machine-checked verification of its 15 contractions.

### 5. Geometric annulus lemma (source Section 3.1)

This portion never refers to \(H\), \(M\), \(\omega\), or the group action. Let \(\Theta\) be a real smooth cutoff equal to 1 near the inner square and 0 near the outer square, and let
\[
h_e=\Theta(y/R)-\Theta(x/R).
\]
Choose smooth \(\chi_m\) equal to 1 on \(\operatorname{supp}\partial_m\Theta\), supported inside the open annulus, and set
\(\phi_{m,\pm}=(\chi_m\pm\partial_m\Theta)/2\).
For frequencies \(p\in\mathbb Z^2\), \(r_p=\|p\|_\infty\), \(1\le r_p\le R\), \(\pm p_m>0\), take
\[
f_{m,\pm,p}(x)=r_p^{-3/2}\phi_{m,\pm}(x/R)
\exp(2\pi i\,p\cdot x/(16R)).
\tag{B13}
\]
These vanish at *all* pinned boundary spins. The combinatorial/Fourier calculations in source Lemma 3.2 give
\[
Q=-i\lambda_R\widetilde h,\quad
\lambda_R\ge\tfrac12\sum_{r=1}^{R}r^{-1},\quad
\|h-\widetilde h\|_1\le C/R,\quad
\|h\|_2\le C,
\tag{B14}
\]
and
\[
\|T\|_{\rm HS}^2+
\sum_{i,j}\min\{\|f_i\|_\infty^2\|df_j\|_2^2,\,
\|f_j\|_\infty^2\|df_i\|_2^2\}
\le C(1+\log R).
\tag{B15}
\]
In particular, the Hilbert–Schmidt estimate uses the *spatial* Fourier factorization
\(T_{\rm group}=U\,\operatorname{diag}(r_p^{-1})U^*\),
\(\|U\|_{\rm op}\le C\), and \(\sum_{p:r_p\le R}r_p^{-2}=O(\log R)\). It is unchanged under every substitution of the target orbit.

Applying (B12) to (B13) and dividing by \(\lambda_R^2\) yields
\[
R_t(\widetilde h,\widetilde h)\le C_\beta/\log R.
\tag{B16}
\]
The transfer from \(\widetilde h\) to \(h\) is also unchanged: when \(R_t(h,h)>0\), (B5) bounds \(\langle X_t(hc)^2\rangle\le\beta\|h\|_2^2\); the pointwise bound \(|X_t((h-\widetilde h)c)|\le\beta\|h-\widetilde h\|_1=O_\beta(1/R)\) controls the current difference; the local Hessian difference is \(O_\beta(1/R^2)\). Thus
\[
R_t(h,h)\le C_\beta/\log R.
\tag{B17}
\]

### 6. Boundary change of variables and periodic ODE argument

Here the test function \(\Theta\) is not zero on the inner pinned boundary. Instead, the same **real** site-dependent rotation converts the twist parameter \(t\) to \(t+s\), so
\[
W_t(shc)=\frac{Z_R(t+s)}{Z_R(t)},\qquad
-\frac{Z_R''(t)}{Z_R(t)}=R_t(h,h)\le\frac{C_\beta}{\log R}.
\tag{B18}
\]
The normalization by \(Z_R(t)\) is essential.

For any continuous representation of \(SU(2)\) with our standard generator normalization, \(e^{4\pi c}=I\) as an operator; hence \(Z_R(t)\) has a period dividing \(4\pi\). Let \(M_R=\max_tZ_R(t)\), attained at \(t_0\) with \(Z_R'(t_0)=0\). The curvature bound implies
\[
Z_R''(t)\ge-\delta_R Z_R(t)\ge-\delta_R M_R,\qquad
\delta_R=C_\beta/\log R.
\]
Every \(t\) is within distance \(2\pi\) of \(t_0\) modulo \(4\pi\). Integrating twice gives
\[
Z_R(t)\ge M_R\left(1-\frac{(2\pi)^2}{2}\delta_R\right)
=M_R(1-2\pi^2\delta_R),
\]
which is (A2), with the constant enlarged. **No assertion about the sign of the twist free energy or about which \(t\) maximizes \(Z\) is needed.**

## What is checked, and what remains

- **Directly checked algebra:** projector embedding, \(SU(2)\) commutation relations, operator norm 1 on \(\operatorname{Herm}_q\), the exact measure substitution (B6), the quadratic jet (B7)–(B8), and the fourth-jet vanishing via half-turn conjugations (B9).
- **Transferred from the existing proof:** the 15-term fourth-derivative estimate (B10)–(B12), the annulus Fourier-family estimates (B13)–(B15), and the ODE argument (B16)–(B18). All assumptions appear to survive unchanged. An independent reviewer should check the source proof and this adaptation before treating it as established.
- **Not yet formalized in Lean:** group/representation algebra and the analytic estimates. An appropriate Lean target is the finite-dimensional group identity plus the fourth-jet cancellation **without** importing the annular inequality as an axiom. A Lean lemma with analytic bounds merely assumed would be bookkeeping, not proof of Theorem A.
- **Does not imply a CP mass gap:** the O(3) proof's sign-cluster/positivity step does not transfer by the naive CP reflection. A natural sign splitting \(z_x=(\alpha_x,w_x)\) produces \(K_{xy}=2\beta\operatorname{Re}((\overline\alpha_x\alpha_y)\overline{w_x^\dagger w_y})\), which can be negative. A replacement for the Edwards–Sokal/FKG bridge is an **independent open task**.
- **Does not imply a Yang–Mills gap:** the site-spin \(SU(2)\) action here is a true global target-space action, not the local gauge redundancy of 4D Yang–Mills. The source's mass-gap theorem concerns the O(n) spin two-point function and itself has no full continuum spectral reconstruction.
- **Model distinctions:** This is the standard projector interaction at \(\theta=0\), with no independent dynamical U(1) link fields. Other CP lattice actions require separate checks. Real projectors \(RP^{q-1}\) do not satisfy (A1) with the same normalization: the natural \(\mathfrak{so}(3)\) action on real symmetric matrices has generator norm 2, so constant-preserving extension to that model should **not** be claimed.
- **Novelty not established:** a prior twist estimate may exist under other terminology. Do not claim a new theorem for publication until a substantive literature search and expert review.

## Suggested next proof obligation

**Find a positive mechanism replacing sign clusters.** One candidate target is a uniform finite-scale criterion of the form:

> Given (A2), together with a separately verified nonnegative representation or correlation-comparison inequality for CP projectors, obtain a bound on a suitable gauge-invariant connected two-point function at one scale that is strong enough to iterate.

The missing nonnegative representation/comparison must be stated and proved; it cannot be silently replaced by the O(3) sign-cluster construction. See also [CPN_TWIST.md](CPN_TWIST.md) and [ROUTE.md](ROUTE.md).
