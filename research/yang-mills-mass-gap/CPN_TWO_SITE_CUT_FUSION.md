# A rigorous all-coupling CP fusion inequality for a TWO-SITE CUT event

**7 November 2026 — analytic response to the fusion test programme.** This is a finite-volume theorem for a specific **local cut-occupation** event, plus an exact contracted-graph limit. It is **not** the desired probability that a loop traverses a macroscopic annulus through an unmarked bulk. Read alongside [CPN_ASSOCIATION_COUNTEREXAMPLE.md](CPN_ASSOCIATION_COUNTEREXAMPLE.md), which disproves the unrestricted overlap-FKG conjecture while leaving the event-specific method below intact.

## Theorem — any finite graph, but only the occupied-cut event

Take a finite undirected graph \(G=(V,E)\), integer \(q\ge2\), standard \(\theta=0\) \(CP^{q-1}\) rank-one projector measure, and finite nonnegative couplings \(b_e\) on the **base edges**. Mark two distinct sites \(u,v\), let \(O=V\setminus\{u,v\}\), and add a variable intra-layer coupling \(t\ge0\) on edge \(\{u,v\}\) (assume this is the only \(u-v\) edge; an existing such coupling can be absorbed into \(t\)). Other base edges may lie within \(O\) or connect \(O\) to either \(u\) or \(v\).

In the standard positive oriented-index-loop / high-temperature expansion, denote the multiplicity of a base edge \(e\) by \(k_e\). Define
\[
E_{\rm cut}=\left\{\sum_{e\in\delta\{u,v\}}k_e\ge1\right\},
\tag{T1}
\]
i.e., **at least one strand occupies a base edge crossing the vertex cut** separating \(\{u,v\}\) from \(O\).

Then
\[
\boxed{\qquad
\frac{d}{dt}\mathbb P_t(E_{\rm cut})\ge0
\quad\text{for every finite }t\ge0,\ q\ge2,\ b_e\ge0.
\qquad}
\tag{T2}
\]
The inequality is strict for finite \(t\) whenever the graph with edge \(\{u,v\}\) removed has a positive-coupling connection between \(u\) and \(v\) through \(O\) (so the two-pinned partition function depends nontrivially on their overlap).

Moreover, \(\mathbb P_t(E_{\rm cut})\) has the exact **fusion limit**
\[
\boxed{\qquad
\lim_{t\to\infty}\mathbb P_t(E_{\rm cut})
=1-\frac{Z_O}{Z_{\rm fused}},
\qquad}
\tag{T3}
\]
where \(Z_O\) is the partition function of the induced graph on \(O\), and \(Z_{\rm fused}\) is the full projector-model partition function obtained by identifying \(P_u=P_v=P\), with a **single** Fubini–Study spin at the fused vertex, and retaining all other base edges and weights.

This is a stronger result than the three-site triangle example alone: \(O\) can have arbitrarily many vertices, arbitrary cycles and inhomogeneous nonnegative couplings. The restriction is the **choice of observable**, not the graph.

## Proof: reduce the entire problem to one overlap variable

Let
\[
p=\operatorname{tr}(P_uP_v)\in[0,1],\qquad
\rho_q(dp)=(q-1)(1-p)^{q-2}dp.
\tag{T4}
\]
For two independent FS projectors \(P_u,P_v\), \(p\) has this beta law. By global \(SU(q)\) invariance, after fixing \(P_u,P_v\) with overlap \(p\), integrating all other spins in the **base graph without the \(t\)-edge** yields a function \(g(p)>0\), independent of the particular representatives.

**Key positive monotonicity.** The earlier two-pinned-projector loop identity in [CPN_POSITIVE_LOOPS.md, (L8)](CPN_POSITIVE_LOOPS.md) implies
\[
g(p)=g(1)\,\mathbb E_{\rm equal\ pin}[p^K],
\tag{T5}
\]
where \(K\ge0\) counts the A/B alternations on loops. Every diagram coefficient is nonnegative, so **\(g(p)\) is nondecreasing on [0,1]**. This uses the full exponential interaction, not a Taylor cutoff or a general second Griffiths inequality.

The full partition function, after introducing \(t\), is
\[
Z(t)=\int_0^1 e^{tp}g(p)\,\rho_q(dp).
\tag{T6}
\]
The event \(E_{\rm cut}^c\) is **exactly** the absence of copies of every base edge crossing the cut. The corresponding positive high-temperature weight therefore has **those cross-edge couplings set to zero**. Only the \(t\)-edge joins \(u,v\), and the spin measure on \(O\) factors, giving
\[
Z_{\rm no\ cut}(t)=Z_O\int_0^1 e^{tp}\,\rho_q(dp).
\tag{T7}
\]
Define the tilted probability law
\[
\nu_t(dp)=\frac{e^{tp}g(p)\rho_q(dp)}{Z(t)}.
\tag{T8}
\]
Combining (T6)–(T8) gives an **exact event-specific conditional expression**
\[
\boxed{
\mathbb P_t(E_{\rm cut})
=1-\frac{Z_{\rm no\ cut}(t)}{Z(t)}
=\mathbb E_{\nu_t}\left[1-\frac{Z_O}{g(p)}\right].
}
\tag{T9}
\]
Notice \(g(p)\ge Z_O\), since each cut-edge Boltzmann factor \(e^{b_e\operatorname{tr}(PP')}\) is at least one. Because \(g\) is nondecreasing, \(h(p)=1-Z_O/g(p)\) is bounded, nonnegative and nondecreasing.

Differentiating a **bounded** one-dimensional exponential tilt gives
\[
\frac{d}{dt}\mathbb P_t(E_{\rm cut})
=\operatorname{Cov}_{\nu_t}\left(h(p),p\right)\ge0,
\tag{T10}
\]
by the elementary Chebyshev covariance inequality for two nondecreasing functions of a *single real random variable*. Explicitly,
\(2\operatorname{Cov}(h(p),p)=\mathbb E[(h(p)-h(p'))(p-p')]\ge0\),
for two i.i.d. copies \(p,p'\sim\nu_t\). This proves (T2), **without assuming the false multivariate CP overlap-association Conjecture B**.

For the fusion limit, \(\nu_t\Rightarrow\delta_1\) as \(t\to\infty\), since \(\rho_q\) has support arbitrarily near \(1\) and \(g\) is continuous, finite and strictly positive. Therefore (T9) gives \(1-Z_O/g(1)\). At \(p=1\), \(P_u=P_v\) exactly; the global rotation invariance of \(g\) implies \(g(1)=Z_{\rm fused}\), hence (T3). **This also establishes the GRAPHICAL event-identification limit for this specific cut-occupation event**, not for general annular strand excursions. QED.

## Examples and scope

### Three-site triangle

Let \(I=\{1,3\}\), \(O=\{2\}\), base couplings \(b_{12}=b\), \(b_{23}=c\), and variable intra-layer \(t\) on \(\{1,3\}\). Then \(Z_O=1\) and
\[
g_{b,c}(p)
=\int d\omega(P_2)
\exp\big[b\operatorname{tr}(P_1P_2)+c\operatorname{tr}(P_2P_3)\big].
\]
Thus \(P_t(E)=1-\frac{\int e^{tp}\rho_q(dp)}
{\int e^{tp}g_{b,c}(p)\rho_q(dp)}\) increases in \(t\).

For \(CP^2\), \(q=3\), \(b=c=1\), a deterministic nested one-dimensional quadrature gives:
\[
\begin{array}{c|cccccc}
t&0&0.5&1&2&4&8\\\hline
P_t(E)&0.5154370&0.5167341&0.5180956&0.5209349&0.5264465&0.5338756
\end{array}
\]
and the exact fused limit is
\[
\lim_{t\to\infty}P_t(E)
=1-\frac1{f_3(2)}
=1-\frac2{e^2-3}
\simeq0.54432115814.
\]
These numerics check the theorem but do not establish it.

### Four-site square and larger graphs

On the square \(u-a-b-v-u\), mark \(I=\{u,v\}\), let \(O=\{a,b\}\), choose any nonnegative strengths on \(u-a\), \(a-b\), and \(b-v\), and let \(t\) be the strength of the fourth edge \(v-u\). The theorem covers it immediately, even though \(O\) has an internal edge and the underlying graph has a cycle. No independent product-edge occupation law or two-hub decomposition is required.

### Why this does not yet solve the annulus

A macroscopic annulus requires the event that **one strand excursion travels from its inner boundary to its outer boundary through unmarked interior spins** (and, for many annuli, an *intersection* of such events). In contrast, \(E_{\rm cut}\) merely checks **occupation of at least one edge leaving the two-site layer**. On any nontrivial annulus this occupied-cut event is vastly weaker than a complete crossing condition. Thus (T2)–(T3) do **not** prove the needed layer fusion inequality, complete annulus crossing, or a mass gap.

The productive conceptual replacement for false Conjecture B is nevertheless concrete:

> Rather than assuming every increasing function of all overlaps is positively associated, **reduce the actual event to a bounded increasing function of one overlap**, where one-dimensional positive association is automatic.

**Next proof obligation:** Can the annular *excursion* event, or its appropriate marked-loop generating function, admit a similarly nondecreasing **conditional probability as a function of the overlap p** of two sites about to be fused? On general graphs the conditional excursion law also depends on exterior wiring, so the present scalar reduction need not hold.

**Literature scope:** The graph expansion (T5) is an application of the Wolff (2010) CP loop representation and the two-pinned specialization already recorded in this PR. The monotonicity theorem above is a new deduction within this repository, not a claim of priority in the literature or an independently published theorem.
