# A full-exponential CP fusion theorem for multiple gateways with weak additional source attachments

**8 November 2026 — analytic finite-volume result; no strand truncation.** This note supplements the fully nonperturbative **single-gateway** theorem in [CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md). It proves a local **stability under new gateway attachments** for the correct direct-excursion event. The new source-to-gateway strengths must be sufficiently small, but the existing internal network couplings may be *arbitrarily strong and nonnegative* (fixed, finite). This is an elementary, rigorous openness argument rather than a global transfer-order theorem. It does NOT yield a coupling threshold uniform in graph size, an arbitrary many-gateway annulus theorem, exponential CP decay, or Yang–Mills.

## 1. Model and theorem

Fix integer \(q\ge2\). Let \(u,v\) be the two marked source vertices, and \(a\) the sole marked outer site. Consider an arbitrary finite, nonnegative-coupling internal CP graph H with two distinguished terminal vertices \(x,a\), where \(x\) is free, \(a\) is marked and free, and all other vertices are free. Assume that H contains a path of **strictly positive** couplings from x to a. Fix **positive** source strengths \(b_u,b_v\) on the edges \(u-x\), \(v-x\), and separately pin \(P_u,P_v\) at overlap
\[
p=\operatorname{tr}(P_uP_v)\in[0,1].
\]

Choose ANY finite collection of additional allowed edges from \(u\) or \(v\) to other free vertices \(y\in V(H)\setminus\{x,a\}\). Give these extra edges nonnegative strengths \(\eta_e\). (Multiple extra edges and multiple new gateway vertices are allowed.) Denote by \(h_{\boldsymbol\eta}(p)\) the probability under the complete positive oriented-index-loop measure of the event
\[
E=\{\text{some oriented strand excursion from a to u or v, stopping at the marked sites }u,v,a\}.
\]
This event is independent of the local permutations at the marked source vertices and at a, so two-pin event-restricted partition functions apply.

**Theorem (multi-gateway stability at FULL exponential coupling).** There is an \(\varepsilon_*(G,H,q,\mathbf b)>0\), depending on the fixed graph, the existing source strengths and all fixed internal strengths, such that whenever
\[
0\le \eta_e <\varepsilon_*\quad\text{for every extra attachment }e,
\]
one has
\[
\boxed{\quad
\partial_p h_{\boldsymbol\eta}(p)>0\qquad\text{for ALL }p\in[0,1].
\quad}
\tag{S1}
\]
The original internal graph H may contain arbitrary cycles and arbitrarily large but finite positive couplings. The new attachments need not be symmetric.

This is a **genuine multiple-gateway theorem with the complete exponential CP action**, though only in a possibly tiny neighbourhood of the single-gateway coupling subspace.

## 2. Key point: the baseline derivative is strictly positive, including endpoints

At \(\boldsymbol\eta=\mathbf0\), every source strand enters H through the single gateway x. Apply the exact two-terminal contraction from [CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md). Its root occupation distribution is
\[
\mu_p(d)=\frac{w_d(p)}{G(p)},\quad
w_d(p)=\frac{H_d(\lambda_+(p),\lambda_-(p))}{(q)_d},\quad
G(p)=\sum_{d\ge0}w_d(p),
\tag{S2}
\]
with \(\lambda_++\lambda_-=s=b_u+b_v>0\), \(\lambda_+\lambda_-=\Delta(p)=b_ub_v(1-p)\). Define
\[
F(d)=\mathbb E_{n\sim\nu_H}\frac{(q)_d(q)_n}{(q)_{d+n}},
\tag{S3}
\]
where \(\nu_H(n)=\alpha_n/\sum_j\alpha_j\) is the positive effective x-a strand distribution. Because H has a positive-coupling path x-a, \(\nu_H(n\ge1)>0\), and therefore \(F(d)\) is **strictly decreasing** in d.

The baseline event probability is
\[
h_{\mathbf0}(p)=1-\mathbb E_{\mu_p}F(d).
\tag{S4}
\]

Let \(s_d(p)=\partial_p\log w_d(p)\). The earlier rank-two recurrence
\[
H_{d+1}=sH_d-\Delta H_{d-1},\quad
R_d=\frac{H_{d+1}}{H_d}
=s-\frac{\Delta(p)}{R_{d-1}},\quad R_0=s
\tag{S5}
\]
implies
\[
s_{d+1}(p)-s_d(p)=\partial_p\log R_d(p)\ge0.
\tag{S6}
\]
The inequality is **strict at d=1**: indeed
\[
R_1(p)=s-\frac{b_ub_v(1-p)}{s},
\quad\text{so}\quad
\partial_p\log R_1(p)=\frac{b_ub_v}{sR_1(p)}>0
\tag{S7}
\]
uniformly over \(p\in[0,1]\). Since \(\mu_p\) gives positive probability to \(d=0\) and \(d=2\), \(F\) is strictly decreasing, and \(s_d\) is nondecreasing and nonconstant, the elementary pairwise covariance identity yields
\[
\boxed{
h'_{\mathbf0}(p)
=-\operatorname{Cov}_{\mu_p}(F(d),s_d(p))>0
\quad\text{for every }p\in[0,1].
}
\tag{S8}
\]
All series are uniformly differentiable in p for fixed finite base strengths, including the endpoints. Hence \(h'_{\mathbf0}\) is continuous and strictly positive on the compact interval \([0,1]\). Set
\[
\delta:=\min_{0\le p\le1}h'_{\mathbf0}(p)>0.
\tag{S9}
\]

## 3. Analytic stability under new source edges

For any finite graph, the ordinary two-pin partition \(Z_{\boldsymbol\eta}(p)\) and the event-restricted positive loop partition \(A_{\boldsymbol\eta}(p)\) have absolutely convergent power series in every finite nonnegative coupling, with nonnegative coefficients of the pin overlap p:
\[
Z_{\boldsymbol\eta}(p)=\sum_{k\ge0}c_k(\boldsymbol\eta)p^k,
\qquad
A_{\boldsymbol\eta}(p)=\sum_{k\ge0}a_k(\boldsymbol\eta)p^k,\quad
0\le a_k\le c_k.
\tag{S10}
\]
Their first p derivatives and their dependence on \(\boldsymbol\eta\) are jointly continuous on compact subsets of \(p\in[0,1]\) and finite coupling ranges: the series and its termwise derivative are dominated by an exponential bound on the total edge multiplicity. Also \(Z_{\boldsymbol\eta}(p)\ge1\), so
\[
\partial_p h_{\boldsymbol\eta}(p)
=\frac{A'_{\boldsymbol\eta}(p)Z_{\boldsymbol\eta}(p)
-A_{\boldsymbol\eta}(p)Z'_{\boldsymbol\eta}(p)}
{Z_{\boldsymbol\eta}(p)^2}
\tag{S11}
\]
is jointly uniformly continuous on \([0,1]\times[0,\eta_{\max}]^{\#\text{extra edges}}\).

By (S9), for sufficiently small nonnegative \(\boldsymbol\eta\),
\[
\sup_{p\in[0,1]}
|\partial_p h_{\boldsymbol\eta}(p)-h'_{\mathbf0}(p)|
<\delta/2,
\]
and hence \(\partial_p h_{\boldsymbol\eta}(p)\ge\delta/2>0\) uniformly in p. This proves (S1). **QED.**

No false general CP Griffiths/FKG conjecture is used. The new inequality holds for the **actual annular-type direct excursion**, but with only one marked outer site a and new gateway attachments controlled by a small parameter.

## 4. Consequence for two successive regions

Let two disjoint one-sided graphs of the class in Section 1 share only the same middle-layer sites u,v, but have distinct outer marks a_L,a_R. Give both sides sufficiently weak extra source attachments, as allowed by the theorem, while their internal couplings may be large. At fixed p, the two side event probabilities factor:
\(h_{\rm both}(p)=h_L(p)h_R(p)\), each positive and nondecreasing. The exact overlap-tilt identity for an added u-v fusion edge of strength t gives
\[
\frac{d}{dt}\mathbb P_t(E_L\cap E_R)
=\operatorname{Cov}_{\nu_t}(p,h_L(p)h_R(p))\ge0.
\]
The previously proved graphical \(t\to\infty\) contraction of u,v produces the fused middle vertex s, which is an articulation point. Two separate applications of the two-single-vertex pinning comparison then yield
\[
\boxed{
P_{\rm free}(E_L\cap E_R)
\le P_{\rm middle\ fused}(E_L\cap E_R)
\le P_{\rm all\ three\ marked\ vertices\ pinned\ equal}(E_L\cap E_R).
}
\tag{S12}
\]
This is a **full-exponential multi-gateway two-region comparison** under the explicit small-new-attachment assumption.

## 5. Relation to the finite polynomial counterexample

[CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md](CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md) shows that on a full two-gateway graph with seven edges, the stronger condition \(r_{k+1}\ge r_k\) fails in an **exact finite squarefree strand model**, although normalized overlap monotonicity survives and even admits a nonnegative monomial coefficient certificate for q=2,3,5,8.

That example does NOT contradict this theorem. Its additional root attachments are not assumed small, and it is not the full exponential model. Conversely, the present analytic stability theorem does NOT prove arbitrary-strength multi-gateway monotonicity, nor does it establish coefficientwise monotonicity. The mathematically relevant property is the directly normalized derivative \(h'(p)\), with full exterior-wiring information retained in the event restriction.

**Next target:** find a quantitatively useful bound for \(\varepsilon_*\) that does not deteriorate with the number of internal vertices, or derive a new multigateway order-preserving transfer lemma. Without such a bound, even this exact local stability theorem does not iterate on macroscopic planar annuli.
