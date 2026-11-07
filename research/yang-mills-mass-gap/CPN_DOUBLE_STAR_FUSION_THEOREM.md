# CP layer fusion: a complete, untruncated two-region theorem on double stars

**7 November 2026 — exact finite-graph theorem following [CPN_FUSION_LIMIT_AND_SEPARATOR.md](CPN_FUSION_LIMIT_AND_SEPARATOR.md).** The proof works for **all integer q≥2 and all finite nonnegative couplings**, with the complete exponential CP projector action and **without FKG on CP overlaps or a Taylor cutoff**. It proves the two-region fusion inequality for a specific series-parallel separator geometry; it is NOT a planar annulus theorem, a CP mass gap, or Yang–Mills.

## 1. One-sided three-leaf star and an exact conditional crossing probability

Let \(q\ge2\), \(u,v\) be **two marked sites fixed to rank-one projectors** \(P_u,P_v\), with
\[
p=\operatorname{tr}(P_uP_v)\in[0,1].
\]
There is a free hub \(x\) and a **free marked exterior leaf** \(a\); the only edges in this one-sided graph are
\[
u-x \text{ of strength }b_u,\qquad
v-x \text{ of strength }b_v,\qquad
a-x \text{ of strength }b_a,
\qquad b_u,b_v,b_a\ge0.
\]
The event \(E_{\rm side}\) is an oriented-index-strand excursion from the marked leaf \(a\) to **either** marked site \(u,v\), via the unmarked hub \(x\), after cutting all marked sites. This event uses the edge multiplicities and the hub's strand permutation; it ignores permutations at marked vertices, as required by the earlier scalar fusion reduction.

Define
\[
f_s(b)=\sum_{m\ge0}\frac{b^m}{(s)_m},\qquad (s)_m=s(s+1)\cdots(s+m-1).
\tag{D1}
\]
The two pinned-site partition function with \(a,x\) integrated factorizes as
\[
Z_{\rm side}(p)=f_q(b_a)\,G(p),\qquad
G(p)=\int d\omega(P_x)
  e^{b_u\operatorname{tr}(P_uP_x)+b_v\operatorname{tr}(P_vP_x)}.
\tag{D2}
\]
The free leaf \(a\) contributes \(f_q(b_a)\), independent of \(P_x\), by rotational invariance.

Set \(M=b_uP_u+b_vP_v\). The two nonzero eigenvalues of \(M\), counting a possible zero eigenvalue, are \(\lambda_+,\lambda_-\ge0\), and obey
\[
\lambda_++\lambda_-=s:=b_u+b_v,\qquad
\lambda_+\lambda_-=\Delta:=b_ub_v(1-p).
\tag{D3}
\]
Let \(H_d(\lambda_+,\lambda_-)=\sum_{j=0}^d\lambda_+^j\lambda_-^{d-j}\), \(H_0=1\), and put
\[
w_d(p)=\frac{H_d(\lambda_+,\lambda_-)}{(q)_d}.
\tag{D4}
\]
The standard FS/Dirichlet moment identity
\[
\mathbb E_{P_x}\!\left[\operatorname{tr}(MP_x)^d\right]
=\frac{d!}{(q)_d}H_d(\lambda_+,\lambda_-)
\]
gives
\[
G(p)=\sum_{d\ge0}w_d(p).
\tag{D5}
\]

**Lemma (exact no-cross sum).**
The event-restricted partition function for **NO excursion from a to \{u,v\}** is
\[
\boxed{\quad
Z_{{\rm NC,side}}(p)
=\sum_{d\ge0} w_d(p)\,f_{q+d}(b_a).
\quad}
\tag{D6}
\]

**Proof by index-loop permutation counting.**
Fix \(m_u,m_v,m_a\ge0\), with \(d=m_u+m_v\). No crossing is equivalent to the permutation at the hub preserving separately the \(m_a\) incident strands from a and the \(d\) strands from the pinned sites u,v. At the free leaf a, summing its local permutations against the closed-loop fugacity cancels its local factor \((q)_{m_a}^{-1}\). The \(m_a!\) permutations of the a-group at the hub cancel the factor \(1/m_a!\) from its edge expansion. The remaining permutations of the u/v-group, with their positive rank-one trace factors \(p^K\), are precisely the symmetric tensor moments in the coefficient \(w_d(p)\). The combined hub moment denominator changes from \((q)_d\) to \((q)_{d+m_a}\). Hence the contribution of \(m_a\) for a given u/v-group is
\[
w_d(p)\,\frac{b_a^{m_a}}{(q+d)_{m_a}}.
\]
Summing over \(m_a\ge0\) and \(d\ge0\) proves (D6). The series are positive and absolutely convergent for all finite nonnegative couplings. QED.

It follows that the **actual one-sided conditional excursion probability** is
\[
\boxed{
h_{\rm side}(p)
=1-\frac{\sum_{d\ge0}w_d(p)f_{q+d}(b_a)}
{f_q(b_a)\sum_{d\ge0}w_d(p)}.
}
\tag{D7}
\]

## 2. New theorem: h_side(p) is nondecreasing at every coupling

**Theorem 1.** For every \(q\ge2\) and all finite nonnegative \(b_u,b_v,b_a\),
\[
\boxed{\quad
p\longmapsto h_{\rm side}(p)
\text{ is nondecreasing on }[0,1].
\quad}
\tag{D8}
\]
When \(b_u,b_v,b_a>0\), the inequality is strict for \(0\le p<p'\le1\).

**Proof.** The complete homogeneous two-eigenvalue polynomials satisfy
\[
H_0=1,\quad H_1=s,\quad
H_{d+1}=sH_d-\Delta H_{d-1}\qquad(d\ge1).
\tag{D9}
\]
Assume first \(s>0\). Define \(R_d(p)=H_{d+1}/H_d>0\). Then
\[
R_0=s,\qquad
R_d=s-\frac{\Delta(p)}{R_{d-1}(p)}
\quad(d\ge1).
\tag{D10}
\]
As \(p\) increases, \(\Delta(p)=b_ub_v(1-p)\) decreases. Starting from constant \(R_0=s\), (D10) proves inductively that **every** \(R_d\) is nondecreasing in \(p\): the numerator \(\Delta\) decreases and the positive denominator \(R_{d-1}\) does not decrease.

By (D4),
\[
\frac{w_{d+1}(p)}{w_d(p)}
=\frac{R_d(p)}{q+d},
\tag{D11}
\]
so for \(p'>p\), the normalized distributions
\[
\mu_p(d)=\frac{w_d(p)}{\sum_jw_j(p)}
\]
are ordered by an **increasing likelihood ratio**, and hence by first-order stochastic dominance:
\[
\mu_{p'} \succeq_{\rm st} \mu_p.
\tag{D12}
\]
On the other hand \(d\mapsto f_{q+d}(b_a)\) is nonincreasing (each positive term has larger rising-factorial denominators as \(d\) grows). Equation (D7) thus gives
\[
\mathbb E_{\mu_{p'}}f_{q+d}(b_a)
\le\mathbb E_{\mu_p}f_{q+d}(b_a),
\]
and hence \(h_{\rm side}(p')\ge h_{\rm side}(p)\). If all three couplings are positive, some likelihood-ratio comparisons and the decrease of \(f_{q+d}\) are strict, giving strict increase. If \(s=0\), the event has probability zero and the claim is immediate. QED.

This proof uses **one-dimensional ordering of the total number of u/v strands**, not a general Griffiths or FKG inequality on the CP overlap field, which is false (see [CPN_ASSOCIATION_COUNTEREXAMPLE.md](CPN_ASSOCIATION_COUNTEREXAMPLE.md)).

## 3. Full two-region / double-star fusion theorem

Take two copies of the graph from Section 1, called left and right, sharing only the **same two marked middle-layer sites** \(S=\{u,v\}\). Each copy has its own free hub \(x_L,x_R\) and distinct free marked exterior leaf \(a_L,a_R\); the left/right edge strengths may differ. Define E_L and E_R as the direct oriented-index excursions from the respective exterior leaf to S. Couple u and v with an additional strength \(t\ge0\), and integrate **all** physical spins.

Because the two sides share no sites other than pinned u,v, conditioning on their overlap p factorizes both partition functions and event sums:
\[
Z(p)=Z_L(p)Z_R(p),\quad
A(E_L\cap E_R;p)=A_L(p)A_R(p),\quad
h_{\rm both}(p)=h_L(p)h_R(p).
\tag{D13}
\]
Both factors h_L,h_R are nonnegative and nondecreasing by Theorem 1; so is their product. Apply the **exact single-overlap fusion identity**:
\[
\mathbb P_t(E_L\cap E_R)
=\frac{\int_0^1 e^{tp} Z_L(p)Z_R(p)h_L(p)h_R(p)\,\rho_q(dp)}
{\int_0^1 e^{tp}Z_L(p)Z_R(p)\,\rho_q(dp)}.
\tag{D14}
\]
Differentiating gives
\[
\boxed{\quad
\frac{d}{dt}\mathbb P_t(E_L\cap E_R)
=\operatorname{Cov}_{\nu_t}\big(p,h_L(p)h_R(p)\big)\ge0
\quad(t\ge0).
\quad}
\tag{D15}
\]
The covariance sign is the elementary one-dimensional Chebyshev inequality. By the **proved graphical fusion limit** from [CPN_FUSION_LIMIT_AND_SEPARATOR.md](CPN_FUSION_LIMIT_AND_SEPARATOR.md),
\[
\boxed{
\mathbb P_{\rm free}(E_L\cap E_R)
\le \mathbb P_{\rm fused}(E_L\cap E_R).
}
\tag{D16}
\]
This is a **genuine two-region, two-vertex-separator** fusion comparison at every positive temperature and all \(q\ge2\).

**Corollary (full three-layer pinning comparison for this double-star graph).** After fusing u and v, the two independent side graphs meet at exactly ONE articulation vertex \(s\). By the exact single-pin invariance and articulation-vertex factorization in [CPN_LAYER_ENUMERATION.md](CPN_LAYER_ENUMERATION.md), the fused two-region crossing probability is a product of the **free** crossing probabilities on the two sides. The general two-single-vertex pinning theorem of [CPN_PINNING.md](CPN_PINNING.md), applied separately to \(a_L,s\) and to \(s,a_R\), bounds each free side crossing by its same-direction pinned counterpart. Fixing the **three** marked vertices \(a_L,s,a_R\) on the same projector also factorizes the two side measures. Thus
\[
\boxed{
\mathbb P_{\mathrm{free}}(E_L\cap E_R)
\le \mathbb P_{\mathrm{middle\ fused}}(E_L\cap E_R)
\le \mathbb P_{\mathrm{all\ three\ layers\ pinned\ equal}}(E_L\cap E_R).
}
\tag{D17}
\]
This is an **all-coupling FULL LAYER PINNING inequality for this specific six-vertex double-star topology**. In the all-positive q=3, b=1 example, the right endpoint is the square of the exactly pinned path-crossing probability:
\[
\mathbb P_{\mathrm{all\ pinned}}(E_L\cap E_R)
=\left[1-\frac{Z_\perp(2,1)}{f_3(3)}\right]^2
\simeq 0.030285465970,
\]
where \(Z_\perp(x,y)=\sum_{m,n\ge0}x^my^n/(q)_{m+n}\). The corresponding free and middle-fused values are approximately 0.003283648058 and 0.004028142683, respectively.

**Caution about the parallel-channel extension below:** if each side has several *distinct* exterior marked leaves, the proof of **free→middle-fused** still holds, but the final **middle-fused→all-exterior-pinned** comparison involves a whole outer layer and is NOT covered by the two-single-site lemma. Do not silently extend (D17) to all such graphs.

**Extension to parallel, disjoint star channels.** On either side one may replace the single free hub by a finite collection of disjoint free hubs, each joined to u,v and its own distinct exterior marked leaf. They share **only** u and v. With the pins fixed, the arm events are independent, and their union has probability \(h_{\rm side}(p)=1-\prod_j[1-h_j(p)]\), still nondecreasing in p. Thus (D15)–(D16) hold for any finite numbers of such independent channels on each side. This is a series-parallel graph class, not a general planar lattice annulus.

## 4. Deterministic complete-series checks (not used in the proof)

For q=3 and all six double-star base edge strengths equal to 1, and the fusion edge strength t varied, the exact positive series (D4)–(D7), integrated numerically against the beta density, give:

| t | Probability of BOTH side excursions |
|---:|---:|
| 0 | 0.003283648058 |
| 0.5 | 0.003316343234 |
| 1 | 0.003350668067 |
| 2 | 0.003422248724 |
| 4 | 0.003561211251 |
| 8 | 0.003749782238 |
| infinity (exact fused endpoint) | 0.004028142683 |

At fixed p=0,1 the one-sided conditional probabilities are
\(h_{\rm side}(0)=0.0538944044113\) and \(h_{\rm side}(1)=0.0634676506783\). The double-star fused endpoint is exactly \(h_{\rm side}(1)^2\).

These values come from the COMPLETE exponential action, evaluated via absolutely convergent positive sums and deterministic 1D quadrature. They are not Monte Carlo or Taylor-polynomial truncations. The rigorous monotonicity is proved in Sections 2–3 independently of these numbers.

## 5. What the theorem achieves, and the remaining obstacle

- **Solved in this graph class:** the one-sided overlap monotonicity \(h_L'(p)\ge0\), the simultaneous two-region fusion monotonicity, and the \(t\to\infty\) graphical event identification, for all q and finite nonnegative couplings.
- **Not solved:** coupling multiple free hubs to a SHARED outer leaf, adding links between free hubs (loops within the region), allowing a whole middle layer with three or more sites, or proving uniform estimates as the annulus size increases. The proof relies on a rank-two matrix \(b_uP_u+b_vP_v\) and a **single free hub per independent channel**.
- **Main next mathematical target:** extend the monotone likelihood-ratio argument to a region with **two mutually connected free hubs**, or produce an explicit finite-graph counterexample. A candidate is a two-hub series-parallel annulus with a shared exterior marked site, where the total occupation no longer has the simple two-eigenvalue \(\lambda_\pm\) representation. Replacing it requires a genuinely new comparison/switching step.

No CP correlation-decay or Yang–Mills mass gap follows from this restricted theorem. The positive CP loop expansion is not claimed as a novel representation.
