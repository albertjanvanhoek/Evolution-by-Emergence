# Independent audit: where two-terminal CP positivity ends and event-resolved gluing begins

**8 November 2026 — audit responding to Claude's CPN_PINNING.md §14 review.**

**Result.** The positive coefficients of the arbitrary two-terminal effective edge \(K_H(z)\) (including internal cycles) follow **directly and rigorously** from the standard positive CP projector index-loop expansion. The stronger **event-resolved** identity used in the network-independent relative-slope theorem has an additional combinatorial obligation: **deletion of same-terminal returns must preserve the marked source-to-outer crossing event after weighted summation over local boundary permutations**. The current manuscript's (B4) tensor trace equality proves physical partition contraction, but, *taken alone*, does **not** prove preservation of a graphical event. I independently tested the latter at repeated edge multiplicities and a genuine cycle; every exact-rational coefficient agrees. I see no counterexample, but the detailed deletion-fiber combinatorial identity should receive independent review before using it as a general black-box theorem. This is an **audit**, not a claim of a new annulus result.

## 1. Exactly which formula makes c_n≥0, even with cycles?

Source: [CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md), §2, **(B1)**:
\[
K_H(z)=\int\prod_{w\in V(H)\setminus\{x,a\}}d\omega(P_w)
\exp\left[\sum_{e\in E(H)} b_e\operatorname{tr}(P_{e_-}P_{e_+})\right]
=\sum_{n\ge0}c_nz^n,\qquad z=\operatorname{tr}(P_xP_a).
\tag{A1}
\]
Expand each edge \(e^{b_e\operatorname{tr}(P_iP_j)}=\sum_{k\ge0}b_e^k\operatorname{tr}(P_iP_j)^k/k!\), with \(b_e\ge0\), and at every INTERNAL free vertex use the exact CP moment identity
\[
\boxed{
\int d\omega(P)\,P^{\otimes d}
=\frac1{(q)_d}\sum_{\pi\in S_d}U_\pi.
}
\tag{A2}
\]
Every coefficient \(1/(q)_d\) is positive. After choosing every local permutation, each resulting oriented index loop carries the nonnegative factor:
- \(q\) if it touches neither pinned terminal;
- \(1\) if it touches only x or only a;
- \(z^{m_\gamma}\) if it visits **both** x and a, where \(m_\gamma\) counts alternations x→a in its cyclic word (equivalently half its number of changes of terminal).

Indeed rank-one projector idempotence and cyclicity give
\(\operatorname{tr}(P_x^{r_1}P_a^{s_1}\cdots P_x^{r_m}P_a^{s_m})
=z^m\) whenever each exponent is positive. Therefore each fixed diagram is a monomial \(q^\ell z^n\) with a positive combinatorial/Taylor prefactor. **There is no cancellation to worry about, including in graphs H with cycles**, since an internal cycle merely changes the set of possible positive diagrams. Summing these nonnegative terms proves \(c_n\ge0\) on every finite graph with exactly two pinned terminal projectors and nonnegative edge strengths.

The **two-terminal** restriction is essential: three or more different rank-one projectors can produce traces of cyclic products that are not determined by a single nonnegative overlap \(z\) and can have phases.

## 2. The stronger step to audit: event preservation, not just positivity

Source: same note, **(B3)–(B5)**. It claims, with two source projectors pinned at overlap p and both linked only to the one free gateway x, and a single free marked outer site a,
\[
Z(p)=G(p)\sum_n c_n\frac{n!}{(q)_n},
\qquad
Z_{\rm NC}(p)=\sum_d w_d(p)\sum_n c_n\frac{n!}{(q+d)_n}.
\tag{A3}
\]
Here \(Z_{\rm NC}\) restricts actual index-loop diagrams to **no direct excursion from the source group \(\{u,v\}\) to a after cutting these marked vertices**. It is a stronger, *graphical* claim than the ordinary two-terminal spin kernel (A1).

The technical reason given is to delete terminal-to-same-terminal return arcs after tracing all internal H vertices, using
\[
\operatorname{tr}_{\text{last}}\int P^{\otimes(D+1)}d\omega(P)
=\int P^{\otimes D}d\omega(P).
\tag{A4}
\]
At the level of local permutations, deleting the corresponding unmarked slot must **splice its predecessor and successor without changing the cyclic order of surviving marked ports**; the total q-weighted reinsertion fiber is \(q+D\), matching the rising-factorial denominator shift. For an event-resolved proof, one must additionally check that this splicing leaves invariant the **existence/nonexistence** of a marked root-to-a excursion. This is plausible for a graph with **only two H terminals**, but it is NOT a consequence of the trace identity (A4) alone. An explicit weighted partition of deletion fibers into crossing and noncrossing classes would make this a self-contained mathematical lemma.

After that step, one has n effective x-a strands, for which the independently checked one-hub conditional no-cross fraction is
\[
\frac{(q)_d(q)_n}{(q)_{d+n}}.
\]
Together with the effective outer-site normalization \(n!/(q)_n\), this yields (A3) and the dimension-shift formula
\(Z_{\rm NC}(p)=\sum_d w_d(p)\mathcal L_{q+d}K_H\).

**Do not confuse:** (A1) positivity is established by the moment expansion and does **not** require proving (A3). Conversely, the size-uniform relative-slope theorem in [CPN_UNIFORM_RELATIVE_SLOPE.md](CPN_UNIFORM_RELATIVE_SLOPE.md) **does rely on (A3)**, not just on (A1).

## 3. Independent fixed-multiplicity audit, including repeated strands AND a cycle

I implemented a separate pure-stdlib port-following enumerator, [pilot/cpn_two_terminal_independent_glue_audit.py](pilot/cpn_two_terminal_independent_glue_audit.py), using a different function structure from the earlier \`cpn_two_terminal_kernel_check.py\`. For each fixed edge multiset it enumerates **all permutations at free vertices**, traces oriented loops to obtain the coefficient of each power \(p^k\), and checks whether a strand excursion from u/v hits the marked outer vertex a. Separately it computes the H two-terminal kernel coefficients \(c_n\) with x,a pinned and forms the predictions (A3), **without using crossing data from the original graph**.

The 18 exact tests use \(q=2,3,5\) and six fixed-edge cases at each q:
- serial H with both H edge counts 2, source counts (1,1);
- serial H with H edge counts (2,1), source counts (2,1);
- triangular cyclic H with H edge counts (1,1,1), source counts (2,2);
- triangular cyclic H with each one of its three edges doubled in turn and the other two at one copy, source counts (1,1).

**Result:** all 18 cases agree **coefficient by coefficient in the source overlap p** for both unrestricted and no-cross partition weights, as exact Python \`Fraction\` values. These are finitely many **fixed-multiplicity checks** (not a truncated Gibbs conclusion or a proof for every H).

A particularly short reproducible example: let q=3, x=2, a=4, internal y=3, H triangle with
\[
n_{xy}=2,\quad n_{ya}=1,\quad n_{xa}=1,
\]
and exactly one source strand from each pinned u,v to x. The independent calculation gives
\[
K_H(z)=\frac1{60}z+\frac1{30}z^2;
\quad
Z(p)=\frac1{1080}(1+p);
\quad
Z_{\rm NC}(p)=\frac1{2160}(1+p).
\tag{A5}
\]
Every coefficient agrees with (A3); the unrestricted graph contributes 1440 free-vertex permutation diagrams in this test and the pinned-terminal kernel has six. The example includes both repeated strands and a cycle.

## 4. Review recommendation

**Positive coefficients:** (A1) is mathematically clear and rigorously follows from (A2), including arbitrary finite cyclic H graphs.

**Event-resolved replacement:** (A3) has survived the original tests and additional exact checks with repeated multiplicities and cycles. It remains the substantive step on which the claimed network-uniform relative-slope bound rests. A referee-level review should focus on an **explicit marked-connectivity-preserving deletion / insertion bijection** for an arbitrary two-terminal H tangle, or identify an obstruction where two tangles sharing the same \(c_n\) give different event-restricted gluing weights.

**Scope:** only two H terminals x,a, one source gateway x and one outer marked point a. It does not settle strongly coupled multiple source gateways, multi-site outer boundaries, uniform planar annuli, or CP/Yang–Mills mass gaps. The algebraic two-terminal positivity by itself is not enough to assert those stronger results.
