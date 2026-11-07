# Exact full-coupling layer-pinning comparison on CP projector stars

**7 November 2026 — finite-volume analytic theorem in a restricted graph class.** This note extends the two-single-site comparison in [CPN_PINNING.md](CPN_PINNING.md) to **arbitrarily many marked sites per layer on a star graph**, with no approximation in the coupling. It is a special case of the wanted annular layer inequality, **not** an all-graph theorem, exponential decay or a CP mass gap. The positive oriented index-loop expansion itself is prior work (Wolff 2010, arXiv:1001.2231). Novelty of this star comparison has not been established.

## Setup and theorem

Let \(q\ge2\) be an integer and let \(G\) be a star graph, consisting of a single center \(h\) and \(m+n\) leaves, partitioned into two nonempty disjoint sets \(I,O\). Each leaf \(i\) has a single edge \(\{i,h\}\) of finite strength \(b_i\ge0\); there are **no other edges**.

Use the nearest-neighbor \(CP^{q-1}\) projector action
\[
\exp\biggl(\sum_i b_i\,\operatorname{tr}(P_iP_h)\biggr)
\]
and the positive oriented index-loop expansion in [CPN_POSITIVE_LOOPS.md](CPN_POSITIVE_LOOPS.md). Define the **same** event \(E=I\leftrightarrow O\) in both measures: after cutting the marked leaves, at least one oriented index-strand excursion (via the unmarked center \(h\)) has endpoints in different marked layers. This event is measurable in edge multiplicities and the central permutation alone, so it does not depend on any leaf permutations.

Write \(\mathbb P_{\mathrm{free}}\) for all spins integrated against Fubini–Study measure and \(\mathbb P_{\mathrm{pin}}\) for the measure with **all leaves** separately fixed to the same rank-one projector \(P_*\), with center \(h\) still integrated.

**Theorem (all finite nonnegative couplings, any layer sizes):**
\[
\boxed{\quad
\mathbb P_{\mathrm{free}}(I\leftrightarrow O)
\le
\mathbb P_{\mathrm{pin}}(I\leftrightarrow O),
\qquad q\ge2,\quad b_i\ge0.
\quad}
\tag{S1}
\]
It is strict for \(q>1\) when there is a positive coupling from the hub to each layer. The proof is given below and is nonperturbative: it applies to the complete exponential Boltzmann factor, not just a Taylor truncation.

## Full diagram calculation

Let \(k_i\ge0\) be the multiplicity of edge \(i-h\); write
\[
a=\sum_{i\in I}k_i,\quad
b=\sum_{i\in O}k_i,\quad d=a+b,\quad
(q)_k=q(q+1)\cdots(q+k-1).
\]
Introduce
\[
f_q(t):=\sum_{k=0}^\infty\frac{t^k}{(q)_k}
=\mathbb E_{P\sim\mathrm{FS}}\exp[t\,\operatorname{tr}(P_*P)]
\qquad(t\ge0).
\tag{S2}
\]

**All free.** Integrating each leaf conditional on the center gives
\(Z_{\mathrm{free}}=\prod_i f_q(b_i)\). The edge multiplicities under the free loop measure are independent:
\[
\boxed{\quad
\mu_{\mathrm{free}}(k)
=\prod_i\frac{b_i^{k_i}}{(q)_{k_i}f_q(b_i)}.
\quad}
\tag{S3}
\]
The condition **no excursion between I and O** says that the central permutation \(\pi_h\in S_d\) preserves the two sets of slots, i.e. it belongs to \(S_a\times S_b\). The diagram sum restricted to that subgroup is the product of the two single-layer star-diagram numerators, but with the *one* central moment denominator \(1/(q)_{a+b}\) replacing \(1/(q)_a\cdot1/(q)_b\). Therefore
\[
\boxed{\quad
\mathbb P_{\mathrm{free}}(E^c\mid k)
=F_q(a,b):=\frac{(q)_a(q)_b}{(q)_{a+b}}.
\quad}
\tag{S4}
\]
This is a fully explicit combinatorial statement about the sum over the central permutation and all leaf permutations; the decomposition by disjoint permutation groups proves it without assuming independent hub pairings.

**All leaves pinned equal.** For every edge factor, \(\operatorname{tr}(P_*P_h)=S\) is the *same* scalar. Since \(S\sim{\rm Beta}(1,q-1)\),
\[
Z_{\mathrm{pin}}=f_q\Bigl(\sum_i b_i\Bigr),\qquad
\boxed{\quad
\mu_{\mathrm{pin}}(k)
=\frac1{f_q(\sum_i b_i)}
\frac{d!}{(q)_d}\prod_i\frac{b_i^{k_i}}{k_i!}.
\quad}
\tag{S5}
\]
At fixed \(k\), every central permutation \(\pi_h\in S_d\) carries the *same* weight: every completed index loop touches at least one pinned leaf and therefore has color trace \(1\). Exactly \(a!b!\) of the \(d!\) central permutations preserve the layer groups. Thus
\[
\boxed{\quad
\mathbb P_{\mathrm{pin}}(E^c\mid k)
=H(a,b):=\frac{a!\,b!}{(a+b)!}.
\quad}
\tag{S6}
\]

## Proof: two comparisons

**Step 1 — at fixed multiplicities, free crossings are no more likely.** For \(q\ge1\) put \(h_q(j)=(q)_j/j!\). The ratio
\[
\frac{h_q(j+1)}{h_q(j)}=\frac{q+j}{j+1}
\]
decreases with \(j\). Consequently
\[
h_q(a+b)\le h_q(a)h_q(b).
\tag{S7}
\]
To see this, write \(h_q(a+b)/h_q(b)\) as the product of the \(a\) consecutive ratios starting at \(b\), which is bounded by the product of the \(a\) ratios starting at \(0\). Rearranging (S7) gives
\[
F_q(a,b)\ge H(a,b)\qquad(a,b\ge0).
\tag{S8}
\]

**Step 2 — pinning shifts the multiplicities upwards.** From (S3) and (S5), on the support of \(\mu_{\mathrm{free}}\),
\[
\frac{\mu_{\mathrm{pin}}(k)}{\mu_{\mathrm{free}}(k)}
=C\;\frac{d!}{(q)_d}\prod_i\frac{(q)_{k_i}}{k_i!},
\qquad C=\frac{\prod_i f_q(b_i)}{f_q(\sum_i b_i)}>0.
\tag{S9}
\]
Increasing one multiplicity \(k_i\) by one changes the likelihood ratio, apart from \(C\), by
\[
\frac{d+1}{q+d}\frac{q+k_i}{k_i+1}
=1+\frac{(q-1)(d-k_i)}{(q+d)(k_i+1)}\ge1.
\tag{S10}
\]
Thus \(\mu_{\mathrm{pin}}\) is an **increasing likelihood-ratio tilt** of the product measure \(\mu_{\mathrm{free}}\).

The function \(H(a,b)=1/\binom{a+b}{a}\) is **coordinatewise nonincreasing** in every \(k_i\); for instance
\[
\frac{H(a+1,b)}{H(a,b)}=\frac{a+1}{a+b+1}\le1,
\]
and likewise for \(b\). Harris' inequality (association of independent coordinates) applied to the increasing tilt (S9) and decreasing \(H\) therefore gives
\[
\mathbb E_{\mu_{\mathrm{pin}}}[H]
\le\mathbb E_{\mu_{\mathrm{free}}}[H].
\tag{S11}
\]
Together with (S4), (S6), (S8),
\[
\mathbb P_{\mathrm{free}}(E^c)
=\mathbb E_{\mu_{\mathrm{free}}}[F_q]
\ge\mathbb E_{\mu_{\mathrm{free}}}[H]
\ge\mathbb E_{\mu_{\mathrm{pin}}}[H]
=\mathbb P_{\mathrm{pin}}(E^c).
\tag{S12}
\]
Take complements to obtain (S1). **QED.**

The proof uses no planarity and no truncation; the product-measure association in (S11) is valid on the countable product \(\mathbb N_0^{m+n}\), since all relevant functions are bounded/integrable and the standard finite-coordinate FKG/Harris inequality applies.

## Exact full-coupling formulas and independent numerical checks

Write \(B_I=\sum_{i\in I}b_i\), \(B_O=\sum_{j\in O}b_j\). The pinned no-cross partition function is the partition function with **orthogonal** projectors on the two layers:
\[
Z_{\mathrm{pin,NC}}
=Z_{\perp}(B_I,B_O)
=\sum_{a,b\ge0}\frac{B_I^aB_O^b}{(q)_{a+b}}.
\tag{S13}
\]
Therefore
\[
\boxed{\quad
\mathbb P_{\mathrm{pin}}(E)=
1-\frac{Z_\perp(B_I,B_O)}{f_q(B_I+B_O)}.
\quad}
\tag{S14}
\]
For the free measure, convolve the independent edge distributions (S3) within each layer to obtain the distributions \(p_I(a)\), \(p_O(b)\). Then
\[
\boxed{\quad
\mathbb P_{\mathrm{free}}(E)=
1-\sum_{a,b\ge0}p_I(a)p_O(b)
\frac{(q)_a(q)_b}{(q)_{a+b}}.
\quad}
\tag{S15}
\]
These convergent positive series yield the following **untruncated** values. Tail errors are controlled by positive-series geometric bounds (the companion script reports them); they are much smaller than the displayed digits.

| Model | Couplings in I | Couplings in O | Free crossing | Equal-pinned crossing |
|---|---|---|---:|---:|
| CP¹ (q=2) | [1,1] | [1,1] | 0.240515278380 | 0.448558870456 |
| CP² (q=3) | [1,1] | [1,1] | **0.105529875949** | **0.323437983608** |
| CP² (q=3) | [0.1,2] | [4,3] | 0.342399687793 | 0.710738386218 |
| CP² (q=3) | [7,3] | [7,3] | 0.946959935232 | 0.998365594213 |
| CP⁴ (q=5) | [1,1] | [1,1] | 0.029367129075 | 0.166703319342 |

The earlier separate *finite-Taylor* enumerator gives at q=3 and b_i=1 for the same four-leaf star: K=1 gives 0.056250 (free) vs 0.172515 (pinned); K=2 gives 0.093405 vs 0.284364. These approach the analytic full-model values in the table; they are **not** the source of the theorem.

Reproduce via [pilot/cpn_star_full_beta.py](pilot/cpn_star_full_beta.py), which uses only standard Python.

## A sharp caveat: not a termwise/permutation-wise inequality

Even on the same four-leaf star, a naive comparison conditioned on an arbitrary subset of central permutations can reverse. Set all four edge multiplicities to 1, let I={0,1}, O={2,3}, and consider just the **two central pairings**
\[
\pi_{\rm NC}=(0\;1)(2\;3),
\qquad
\pi_{\rm cross}=(0\;2),
\]
with the remaining slots fixed in the second pairing. The first pairing preserves the two layers and has 2 cycles; the second crosses layers and has 3 cycles.

Conditional on **this two-element pairing event**, the all-equal-pinned measure gives them equal weight and hence
\[
\mathbb P_{\mathrm{pin}}(E\mid\pi_h\in\{\pi_{\rm NC},\pi_{\rm cross}\})=\tfrac12.
\]
Under the free measure, all four leaves have degree one and weight is proportional to \(q^{\#\mathrm{cycles}(\pi_h)}\), giving
\[
\mathbb P_{\mathrm{free}}(E\mid\pi_h\in\{\pi_{\rm NC},\pi_{\rm cross}\})
=\frac{q^3}{q^3+q^2}=\frac{q}{q+1}>\tfrac12.
\tag{S16}
\]
At q=3 this is 3/4 versus 1/2. This is a **legitimate restricted-diagram conditioning** illustrating that (S1) is **not a pointwise inequality over central permutations**. It is **not** a counterexample to the unconditional (S1), nor specifically a counterexample under conditioning *only on exterior wiring*; the restriction here is on an internal central permutation.

## Why this matters and what remains

- Claude's [CPN_PINNING.md](CPN_PINNING.md) proves the two-point comparison on **every finite graph**, but the no-cross numerator identity fails for multiple sites within a layer ([CPN_LAYER_ENUMERATION.md](CPN_LAYER_ENUMERATION.md), E3–E5). The star theorem proves that the **normalized** layer inequality can nevertheless hold, through a *two-stage stochastic comparison* rather than equality of no-cross numerators.
- The key special property here is **one free hub**. This makes the edge-count law under all-free pins a product measure, allowing Harris' inequality. With two free hubs sharing marked boundary vertices, multiplicities and strand pairings are no longer independent, and the argument does **not** apply.
- The conditional reversal (S16) shows that a future multiscale proof cannot merely compare two diagrams at fixed boundary pairing: summing over an appropriate family of pairings is essential.
- The next sharp model is a **two-hub graph** whose two centers share at least two layer vertices, with two or three marked layers and the same excursion event. It is the smallest geometry in which the factorization behind (S3)/(S11) genuinely fails. A finite-graph *full-coupling* counterexample, or a replacement association inequality, would be informative.
- Proving (S1) on a star is **not** a proof of the needed planar-annulus layer comparison, multiplicative crossing suppression, CP exponential decay, or Yang–Mills mass gap.

**References:** Wolff (2010), arXiv:1001.2231, for the prior positive CP loop expansion. [CPN_POSITIVE_LOOPS.md](CPN_POSITIVE_LOOPS.md), [CPN_PINNING.md](CPN_PINNING.md), and [CPN_LAYER_ENUMERATION.md](CPN_LAYER_ENUMERATION.md) for earlier identities and open problems. The representation and graph-event identification have not been independently peer reviewed.
