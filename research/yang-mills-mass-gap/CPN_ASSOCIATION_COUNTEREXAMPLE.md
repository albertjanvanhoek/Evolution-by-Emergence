# An exact counterexample to unrestricted CP overlap association

**7 November 2026 — independent mathematical correction to Conjecture B in [CPN_PINNING.md §9](CPN_PINNING.md).**

## Summary

The conjecture

> For a ferromagnetic \(CP^{q-1}\) projector Gibbs measure, every coordinatewise nondecreasing function \(F\) of the bond overlaps is nonnegatively correlated with every single bond overlap.

is **FALSE for every integer \(q\ge2\)**. An elementary counterexample occurs already on a three-site graph with **all couplings zero** (three independent Fubini–Study projectors). By continuity it also fails for sufficiently small strictly positive interactions on the triangle. This does **not** refute the more restrictive fusion conjecture
\[
\frac{d}{dt}\mathbb P_t(\text{layer excursion})\ge0,
\]
because the particular function \(\Phi_E\) representing the excursion, and the *same Gibbs measure*, may have extra structure or compensating direct terms. Conjecture A (monotonicity of the conditional excursion probability on adding a strand) remains separately open.

The exact negative sign exposes a structural issue: **coordinatewise increase is not enough; the sign of a mixed/synergy derivative matters.**

## Proposition 1 — exact conditional regression on a CP triangle

Let \(P_1,P_2,P_3\) be three **independent**, uniformly Fubini–Study distributed rank-one projectors on \(\mathbb C^q\), \(q\ge2\). Define bond overlaps
\[
X=\operatorname{tr}(P_1P_2),\quad
Y=\operatorname{tr}(P_2P_3),\quad
Z=\operatorname{tr}(P_1P_3),\quad
\mu=\frac1q.
\tag{A1}
\]
Then \(X,Y\) are independent and each follows \(\mathrm{Beta}(1,q-1)\), with variance \(v=(q-1)/[q^2(q+1)]\). Moreover,
\[
\boxed{
\mathbb E[Z\mid X=x,Y=y]
=xy+\frac{(1-x)(1-y)}{q-1}
=\mu+\frac{q}{q-1}(x-\mu)(y-\mu).
}
\tag{A2}
\]

**Proof.** Condition on \(P_2=|e_1\rangle\langle e_1|\). Write representatives
\(z_1=\sqrt{x}e^{i\alpha}e_1+\sqrt{1-x}\,u\) and
\(z_3=\sqrt{y}e^{i\gamma}e_1+\sqrt{1-y}\,v\), where \(u,v\) are independent uniform unit vectors in \(\mathbb C^{q-1}\) (for \(q=2\) their phases are uniform). Average
\(|z_1^\dagger z_3|^2\) over the independent phases/directions. Mixed terms vanish, while \(\mathbb E|u^\dagger v|^2=1/(q-1)\). This gives (A2). The overlap beta laws follow from Haar/Fubini–Study invariance. QED.

Consequently, for **every bounded measurable** \(F:[0,1]^2\to\mathbb R\),
\[
\boxed{
\operatorname{Cov}\big(F(X,Y),Z\big)
=\frac{q}{q-1}
\mathbb E\!\left[(X-\mu)(Y-\mu)F(X,Y)\right].
}
\tag{A3}
\]
In particular, even a coordinatewise increasing \(F\) is not guaranteed to have positive covariance.

## Proposition 2 — an explicit SMOOTH, coordinatewise increasing counterexample

Choose
\[
\boxed{\quad F(x,y)=x+y-xy.\quad}
\tag{B1}
\]
For \(x,y\in[0,1]\), \(\partial_xF=1-y\ge0\), \(\partial_yF=1-x\ge0\), and \(0\le F\le1\). Despite being coordinatewise increasing,
\[
\boxed{
\operatorname{Cov}\big(F(X,Y),Z\big)
=-\frac{q}{q-1}\,v^2
=-\frac{q-1}{q^3(q+1)^2}<0.
}
\tag{B2}
\]
Indeed, the \(X\) and \(Y\) terms in (A3) vanish by independence and centering, while the \(-XY\) term contributes \(-v^2\).

For **CP²**, \(q=3\),
\[
\operatorname{Cov}\big(X+Y-XY,\ Z\big)
=\boxed{-1/216}\approx-0.00462962963.
\tag{B3}
\]
For **CP¹**, \(q=2\), the counterexample already gives \(-1/72\). This does not contradict the O(3) mass-gap proof, which uses positivity of a *special auxiliary Ising/cluster measure*, not association of every increasing overlap function.

An independent moment check uses \(\mathbb E[X^2]=2/[q(q+1)]\):
\[
\mathbb E[XYZ]=
\frac{q(\mathbb E X^2)^2-2\mu\,\mathbb E X^2+\mu^2}{q-1}.
\]
At \(q=3\), \(\mathbb E[XYZ]=1/24\) and
\(\operatorname{Cov}(XY,Z)=1/24-1/27=1/216\), verifying the negative sign in (B3).

## Proposition 3 — the exact mixed-derivative sign kernel

For any \(F\in C^2([0,1]^2)\), integrating by parts twice in (A3) yields
\[
\boxed{
\operatorname{Cov}(F(X,Y),Z)
=\frac{q-1}{q}\int_0^1\!\int_0^1
x(1-x)^{q-1}\,y(1-y)^{q-1}\,
\partial_{xy}^2F(x,y)\,dx\,dy.
}
\tag{C1}
\]

To derive (C1), put \(f_q(x)=(q-1)(1-x)^{q-2}\) for the beta density and
\[
M_q(x)=\int_0^x (s-\mu)f_q(s)\,ds
=-\frac{q-1}{q}\,x(1-x)^{q-1}.
\tag{C2}
\]
The boundary terms vanish because \(M_q(0)=M_q(1)=0\); the product of the two integration-by-parts signs is positive. The kernel in (C1) is strictly positive in the interior.

**Interpretation:** on this independent three-spin triangle, supermodular \(F\) (nonnegative \(\partial_{xy}F\)) gives nonnegative covariance; submodular \(F\) (nonpositive \(\partial_{xy}F\)) gives nonpositive covariance. The simple function \(x+y-xy\) is submodular, *despite being increasing in both variables*. This is an exact conditional-regression criterion, **not** a general Gibbs-state or multi-spin Griffiths inequality.

For an additional discontinuous example, set
\(F=\mathbf 1\{X>\mu\ \text{or}\ Y>\mu\}\), an increasing indicator. Since
\(\mathbb E[(X-\mu)\mathbf 1_{\{X\le\mu\}}]=-(1-1/q)^q/q\), (A3) gives
\[
\operatorname{Cov}(F,Z)=
-\frac1{q(q-1)}\left(1-\frac1q\right)^{2q}<0.
\tag{C3}
\]

## Consequence for the fusion programme

The two sufficient conjectures in [CPN_PINNING.md §9](CPN_PINNING.md) must **NOT** be promoted together to a theorem: the broad overlap-association assertion (B) is false. In particular, the proposed inference

> \(F\) increasing in bond overlaps \(\Longrightarrow\operatorname{Cov}_{\mathrm{spin}}(F,w_e)\ge0\)

is invalid without additional hypotheses. This remains false for sufficiently small **strictly positive** edge couplings on this finite triangle, by continuity of finite-dimensional Gibbs integrals at zero coupling.

Suggested replacement targets:
1. **Event-specific covariance:** prove the combination
\(\operatorname{Cov}^{\mathrm{spin}}_t(\Phi_E,w_e)+\mathbb E_t[w_e\Delta_e\Phi_E]\ge0\)
directly for the *actual* CP loop excursion observable \(\Phi_E\), rather than separately imposing a universal spin-FKG assertion.
2. **A more selective function class:** identify stronger structural conditions on \(\Phi_E\) which control mixed interactions. The explicit kernel (C1) demonstrates why supermodularity may help in the simple independent triangle, but **does not** establish it for the actual Gibbs measure or show \(\Phi_E\) is supermodular.
3. **Combinatorial conjecture A:** continue checking whether \(\mathbb P(E\mid n+\mathbf1_e)\ge\mathbb P(E\mid n)\), with genuinely distinct graph-event definitions and enough port multiplicities. This conjecture is **not falsified** by (B2).

The companion [pilot/cpn_association_counterexample.py](pilot/cpn_association_counterexample.py) evaluates all rational moments exactly for \(q=2,3,4,5\) without sampling.

**Research status:** rigorous finite-volume counterexample to the overly general **proof tool**, not to fusion monotonicity, the layer pinning inequality, exponential CP correlations, or the Yang–Mills problem. Novelty is not claimed; this is an elementary Haar/projector moment identity used here as an internal critical test.
