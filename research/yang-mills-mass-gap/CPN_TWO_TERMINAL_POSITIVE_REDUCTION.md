# A nonperturbative two-terminal reduction for CP projector-loop fusion

**8 November 2026 — next step following \`CPN_TWO_HUB_TRANSFER.md\`, PR #144.** A restricted but substantial **all-coupling** extension: a single free gateway hub attached to the two middle-layer projectors may connect to a single marked outer vertex through an **arbitrary finite two-terminal CP network**, including internal cycles. The one-sided *direct-excursion probability* is nondecreasing in the middle-projector overlap. Two such disjoint networks may be joined across the same two-site separator. **This is not a general annular layer theorem, exponential CP decay, or Yang–Mills mass gap.** The positive CP index-loop representation is prior work (Wolff 2010, arXiv:1001.2231); mathematical priority of this reduction is not claimed.

## 1. Exact setup and the boundary-event restriction

Fix integer \(q\ge2\), all couplings finite and nonnegative, and rank-one projectors \(P_u,P_v\) fixed with
\[
p=\operatorname{tr}(P_uP_v)\in[0,1].
\]
Two marked vertices \(u,v\) couple **only to one free gateway vertex \(x\)**, with strengths \(b_u,b_v\). Let \(H\) be any finite graph with **exactly two distinguished terminals** \(x,a\), all other vertices unmarked and integrated, and any finite nonnegative strengths. The vertex \(a\) is a single **free marked outer vertex**, and there are no further attachments to the source or outer marks besides those specified. H may have direct x-a edges, arbitrarily many free interior vertices, branching, parallel paths, or cycles.

The event E is the existence of an **oriented index-loop excursion** between \(\{u,v\}\) and \(a\), cut at the marked sites \(\{u,v,a\}\). Because these are the only marked sites, E is equivalent to **a completed diagram loop visiting both the source group \(\{u,v\}\) and a**, and does not depend on permutations at u,v,a. This equivalence is used in the tangle-reduction argument; it is not asserted for arbitrary multi-layer events with additional marked sites.

As in previous notes, let
\[
M=b_uP_u+b_vP_v,\qquad s=b_u+b_v,\qquad
\Delta=b_ub_v(1-p).
\tag{A1}
\]
Its nonzero eigenvalues \(\lambda_\pm(p)\ge0\) satisfy \(\lambda_++\lambda_-=s\), \(\lambda_+\lambda_-=\Delta\). Define
\[
H_d(\lambda_+,\lambda_-)=\sum_{j=0}^d \lambda_+^j\lambda_-^{d-j},\quad
w_d(p)=\frac{H_d(\lambda_+,\lambda_-)}{(q)_d},\quad
G(p)=\sum_{d\ge0} w_d(p).
\tag{A2}
\]
Here \((q)_d\) is the rising factorial and \(H_0=1\). The **root count law**
\[
\mu_p(d)=w_d(p)/G(p)
\tag{A3}
\]
has increasing likelihood-ratio order as p increases, by the rank-two recurrence already proved in \`CPN_DOUBLE_STAR_FUSION_THEOREM.md\`.

## 2. The exact two-terminal positive interaction and a graphical gluing lemma

Fix rank-one projectors \(P_x,P_a\) with overlap \(z=\operatorname{tr}(P_xP_a)\). Integrate **only the interior vertices** of H. The two-pinned oriented-loop expansion gives a positive entire series
\[
\boxed{
K_H(z)=Z_H(P_x,P_a)=\sum_{n\ge0}c_n z^n,\qquad c_n\ge0.
}
\tag{B1}
\]
The coefficient n counts alternations between the two terminal directions in the closed oriented index loops. Unpinned internal loops retain fugacity q, and the self-return contributions at only x or only a have weight 1. All edge couplings of H are in the coefficients \(c_n\), **not** in p.

Define
\[
\alpha_n=c_n\,\frac{n!}{(q)_n}\ge0,\qquad
C_H=\sum_{n\ge0}\alpha_n=\int d\omega(P_x)d\omega(P_a)\,K_H(\operatorname{tr}(P_xP_a))>0,
\tag{B2}
\]
and \(\nu_H(n)=\alpha_n/C_H\), a probability distribution independent of p.

**Two-terminal event-resolved gluing lemma.** For the graph of Section 1, the FULL and NO-CROSS positive loop sums are exactly
\[
\boxed{
Z(p)=G(p)\,C_H,
\qquad
Z_{\rm NC}(p)=\sum_{d,n\ge0}
w_d(p)\,\alpha_n\,F_q(d,n),
\quad
F_q(d,n)=\frac{(q)_d(q)_n}{(q)_{d+n}}.
}
\tag{B3}
\]

**Proof (index-tangle version; all sums positive).** Fix all H edge multiplicities and local permutations at its internal free vertices. Cut the incident oriented strands at the two terminals x,a. This produces closed interior loops and open strands with ends at x and/or a. Closing them with fixed **rank-one** terminal projectors produces, by the two-pin positive-loop identity, a monomial \(z^n\), where n counts x/a alternations. The remaining open tangle consists of n effective x–a strand pairs, plus same-terminal return arcs (x–x and a–a) and disjoint internal loops.

The terminal same-site returns can be **deleted by trace contraction** before summing the terminal permutations, without changing whether an external root-to-a loop exists. Algebraically, each deleted trace uses
\[
\operatorname{tr}_{\rm new}\!\left[\int d\omega(P)\,P^{\otimes(D+1)}\right]
=\int d\omega(P)\,P^{\otimes D},
\tag{B4}
\]
which follows from \(\operatorname{tr}(P)=1\). In the symmetric-group moment expansion, deleting an unmarked traced slot from each cycle and splicing predecessor to successor preserves the *cyclic order of all surviving marked slots*, and consequently preserves whether a completed loop hits both \(\{u,v\}\) and a. The sum of its possible reinsertion weights is \(q+D\) (D insertions into existing cycles, or a free singleton of weight q), exactly canceling the corresponding rise from \((q)_D\) to \((q)_{D+1}\). Repeating removes all same-terminal returns. Internal closed loops supply their unchanged q weights.

What remains is **precisely n parallel x–a strands**, with total positive coefficient \(c_n\), attached to the original u/v root-source tensor at x and the free marked site a. With n effective strands, the latter contributes its normalized FS moment \(n!/(q)_n\); at x, the source of total degree d contributes \(w_d(p)\). By the already independently checked **one-hub permutation identity D6**, the fraction of diagrams with *no* root-to-a excursion at fixed d,n is
\[
F_q(d,n)=\frac{(q)_d(q)_n}{(q)_{d+n}},
\tag{B5}
\]
independent of the u/v word or overlap p. Hence (B3) holds term by term in H multiplicities and in the root-source expansion. Positive absolute convergence on a finite graph with finite strengths justifies all gluing and summation. QED.

**Scope warning:** This is an **event-resolved**, not merely physical-spin, reduction. It works because there are only TWO H terminals and the marked connectivity event is root-group-to-SINGLE-a. The previous exterior-wiring obstruction persists for regions with multiple distinct entry or exit terminals, and the deletion step cannot be assumed for arbitrary events involving additional marked sites.

### A simpler equivalent form: the dimension-shift identity

Since \(\alpha_nF_q(d,n)=c_n\,n!/(q+d)_n\), define the positive linear functional
\[
\mathcal L_s K_H
:=\int_0^1 K_H(z)(s-1)(1-z)^{s-2}\,dz
=\sum_{n\ge0}c_n\frac{n!}{(s)_n}.
\tag{B6}
\]
Then the event-resolved result (B3) can be restated particularly simply:
\[
\boxed{
Z(p)=G(p)\,\mathcal L_q K_H,\qquad
Z_{\rm NC}(p)=\sum_{d\ge0}w_d(p)\,\mathcal L_{q+d}K_H.
}
\tag{B7}
\]
This is a genuine **effective-dimension shift \(q\mapsto q+d\)** in the no-cross sector. Since \(K_H(z)\) has nonnegative coefficients, it is nondecreasing in z; since \(\mathrm{Beta}(1,q+d-1)\) shifts stochastically toward smaller z as d increases, \(\mathcal L_{q+d} K_H\) is nonincreasing in d. Hence the proof of the theorem below may use either (B3) or directly (B7). For a single direct effective edge \(K_H(z)=e^{bz}\), (B7) reduces to the independently checked one-hub formula D6 with \(\mathcal L_{q+d}K_H=f_{q+d}(b)\).

**An exact cyclic test.** Take the five one-copy H edges \((x,3),(3,a),(x,4),(4,a),(3,4)\), with x=2, a=5, free 3,4, q=3. Explicitly summing all internal permutations gives
\[
K_H(z)=\frac1{400}+\frac{13}{1800}z+\frac1{400}z^2.
\]
The dimension-shift functionals are \(\mathcal L_3K_H=23/4320\) and \(\mathcal L_5K_H=37/9000\). For precisely one source strand at each u/v edge (total d=2), the *original graph's* full/NC polynomial coefficient ratio, computed by a separate all-permutation enumeration, is
\[
\frac{\mathcal L_5K_H}{\mathcal L_3K_H}
=\frac{444}{575},\qquad
\mathbb P(E\mid r=s=1,H)=\frac{131}{575}.
\]
The equality holds **coefficientwise in every power of the source overlap p**, not only after setting p=1. This calculation uses **fixed edge multiplicities** and is a check of (B7), not a full-coupling substitute for it.

## 3. A new ALL-COUPLING one-sided overlap theorem

From (B3), the actual one-sided probability is
\[
\boxed{
h_H(p):=\mathbb P(E\mid P_u,P_v)
=1-\mathbb E_{\substack{d\sim\mu_p\\ n\sim\nu_H}}F_q(d,n).
}
\tag{C1}
\]
Because
\[
\frac{F_q(d+1,n)}{F_q(d,n)}
=\frac{q+d}{q+d+n}\le1,
\tag{C2}
\]
the function \(\phi_H(d)=\mathbb E_{\nu_H}F_q(d,n)\) is nonincreasing in d. The rank-two recurrence
\[
H_{d+1}=s H_d-\Delta H_{d-1},\quad
R_d=H_{d+1}/H_d=s-\Delta/R_{d-1}
\]
shows that \(w_{d+1}(p)/w_d(p)=R_d(p)/(q+d)\) increases with p. Consequently \(\mu_{p'}\succeq_{\mathrm{st}}\mu_p\) whenever \(p'>p\), so
\[
\mathbb E_{\mu_{p'}}\phi_H(d)
\le\mathbb E_{\mu_p}\phi_H(d).
\]

**Theorem (arbitrary two-terminal interior network, full coupling range):**
\[
\boxed{\quad
p\longmapsto h_H(p)\ \text{is nondecreasing on }[0,1]
\quad\text{for ALL finite nonnegative strengths in H and at the two root bonds.}
\quad}
\tag{C3}
\]
If \(b_u,b_v>0\) and H has at least one positive-strength path from x to a, the inequality is **strict whenever \(p'>p\)**: \(h_H(p')>h_H(p)\). If either root strength is zero or x,a are disconnected at positive strength, the probability may be p-independent.

This **removes the 'small J' hypothesis** of \`CPN_TWO_HUB_TRANSFER.md\` on its serial two-hub example, and covers arbitrary finite interacting interior networks behind the **single x gateway**.

## 4. An explicit positive kernel for TWO interconnected free hubs, at ALL J and b

For the serial graph u/v–x–y–a, let x-y have strength J and y-a strength b, with the internal free y integrated. The exact effective terminal kernel is
\[
K_{J,b}(z)
=\int d\omega(P_y)
e^{J\operatorname{tr}(P_xP_y)+b\operatorname{tr}(P_yP_a)}.
\tag{D1}
\]
At fixed counts k,m on these bonds, the symmetric-group sum over y is
\[
S_{k,m}(z)
=k!m!\sum_{n=0}^{\min(k,m)}
\binom{k}{n}\binom{m}{n}z^n.
\tag{D2}
\]
One derivation is the exact cycle-index generating function
\[
\sum_{k,m\ge0}\frac{X^kY^m}{k!m!}S_{k,m}(z)
=\frac1{(1-X)(1-Y)-zXY}
=\sum_{n\ge0}
\frac{z^nX^nY^n}{(1-X)^{n+1}(1-Y)^{n+1}}.
\tag{D3}
\]
Thus
\[
\boxed{
c_n(J,b)=\sum_{k,m\ge n}
\binom{k}{n}\binom{m}{n}
\frac{J^kb^m}{(q)_{k+m}}\ge0.
}
\tag{D4}
\]
These series are absolutely convergent for any finite J,b≥0; unlike the preceding weak-bridge expansion there is NO restriction on J. Moreover
\[
\sum_n c_n(J,b)\frac{n!}{(q)_n}=f_q(J)f_q(b),
\tag{D5}
\]
by integrating the free terminal spins and using rotational invariance.

**Untruncated numerical check** for q=3, \(b_u=b_v=J=b=1\) (positive sums, deterministic integration):

| overlap p | exact-series one-sided crossing probability h(p) |
|---:|---:|
| 0 | 0.004826190176 |
| 0.25 | 0.005056163727 |
| 0.50 | 0.005281249142 |
| 0.75 | 0.005501599512 |
| 1 | 0.005717361678 |

The theorem is analytical; these are merely independent numerical checks. For \(J=3,b=1\), the endpoint values rise from 0.015255806822 at p=0 to 0.018056684581 at p=1. The positive coefficient sums are truncated only for evaluation; omitted tails can be bounded by exponential-series tails because each projector overlap lies in [0,1].

## 5. TWO annular regions with arbitrary internal two-terminal networks

Take two disjoint networks \(H_L,H_R\) of the preceding kind, sharing only the same marked **two-site middle layer** S={u,v}. On each side the two pinned sources couple only to **one gateway** \(x_L\) or \(x_R\), and the outer marked boundary is a **single site** \(a_L\) or \(a_R\). The internal networks may have many freely interacting vertices, loops, and arbitrarily strong nonnegative edges, but the two sides must be otherwise disjoint and no edge may bypass the separator S.

At fixed overlap p, the side partition functions and event-restricted sums factor exactly:
\(Z(p)=Z_L(p)Z_R(p)\), and \(A(E_L\cap E_R;p)=A_L(p)A_R(p)\). By Theorem (C3), each \(h_i(p)\) is nondecreasing, so their product is. Integrating the middle spins against the additional intralayer fusion tilt \(e^{tp}\) yields, for all finite t≥0,
\[
\frac{d}{dt}\mathbb P_t(E_L\cap E_R)
=\operatorname{Cov}_{\nu_t}\left(p,h_L(p)h_R(p)\right)\ge0.
\tag{E1}
\]
The previously proved **graphical fusion limit** then identifies t→∞ with contraction of u,v into one marked separator vertex. The contracted two side networks now meet at one articulation point; applying the general two-single-vertex pinning comparison on **each side** gives the full chain
\[
\boxed{
\mathbb P_{\rm free}(E_L\cap E_R)
\le \mathbb P_{\rm middle\ fused}(E_L\cap E_R)
\le \mathbb P_{\rm ALL\ marked\ equal\ pinned}(E_L\cap E_R).
}
\tag{E2}
\]
**This is an all-coupling two-region pinning theorem in a restricted BUT NOT JUST STAR/CHAIN graph class.** It does not cover arbitrary macroscopic annuli with an extended inner and outer boundary.

For two identical serial side graphs with \(q=3,\ b_u=b_v=J=b=1\), numerical positive series and 1D beta integration give:
\[
P_{\rm free}(E_L\cap E_R)\simeq0.00002645510583,\quad
P_{\rm middle\ fused}\simeq0.00003268822455,\quad
P_{\rm all\ pinned}\simeq0.00028895057414.
\tag{E3}
\]
The last value comes from the independent two-point pinning identity on each contracted side. These are checks, not inputs to the proof.

## 6. Independent exact finite-diagram verification and the remaining obstacle

The companion \`pilot/cpn_two_terminal_kernel_check.py\` computes every local pairing, cyclic loop, pin-alternation polynomial coefficient and direct root-to-outer marked excursion at FIXED edge multiplicities; it independently computes the two-pin H kernel and applies (B3). In addition to all small serial cases, it checks 30 randomly chosen small H networks with cycles/parallel/direct paths, for q=2,3,5, **with exact rational equality of both unrestricted and NC coefficients**. This is a falsification screen for the diagrammatic gluing step, not a replacement for the proof by partial-trace deletion. Another deterministic routine computes the full (untruncated) serial kernel through (D4).

The **remaining topological obstruction** is clear: we have reduced arbitrary H to two marked terminals **x,a**, with only one gateway from u/v and one outer mark. A real annulus has MANY boundary sites/ports; its effective boundary object is a non-scalar strand-wiring operator rather than the positive polynomial K_H(z). The new theorem does **not** assert that scalar positivity survives when there are three or more terminal projector directions, which can generate signed cyclic traces (see \`CPN_BOUNDARY_COMPARISON.md\`).

**Next target:** extend the two-terminal event-resolved gluing lemma to an entire multi-site boundary through a controlled **positive matrix kernel on boundary wiring states**, or find a small graph showing an order-preserving extension is false. Do not claim a 2D CP exponential-decay theorem or 4D Yang–Mills mass gap on the basis of (E2).
