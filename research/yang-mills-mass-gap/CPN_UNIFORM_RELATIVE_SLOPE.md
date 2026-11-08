# An explicit size-independent RELATIVE overlap slope for single-gateway CP networks

**8 November 2026 — analytical supplement to the all-coupling theorem in [CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md).** This result quantitatively verifies the strict endpoint derivatives used by [CPN_MULTI_GATEWAY_STABILITY.md](CPN_MULTI_GATEWAY_STABILITY.md). It is genuinely uniform in the size/complexity/couplings of an **internal two-terminal network**, *relative to its own (possibly tiny) crossing probability*. It is **not** a uniform all-strength multiple-gateway lemma for a 2D annulus.

## Exact statement

Let \(q\ge2\) be an integer, fix two rank-one projectors \(P_u,P_v\) at overlap \(p=\operatorname{tr}(P_uP_v)\in[0,1]\), and join both to a single free gateway \(x\) with positive strengths \(b_u,b_v>0\). Behind \(x\) put **any finite nonnegative-coupling two-terminal internal CP graph** \(H\) whose other terminal is a single marked outer vertex \(a\). Assume there is a positive-strength path between the terminals. Let \(E\) be the oriented index-loop excursion from the source group \(\{u,v\}\) to \(a\), cut at all marked sites, and
\[
h_H(p)=\mathbb P(E\mid P_u,P_v).
\]
Write \(s=b_u+b_v\), and use the positive effective-edge expansion from the two-terminal contraction:
\[
K_H(z)=\sum_{n\ge0}c_nz^n,\qquad
\nu_H(n)=\frac{c_n\,n!/(q)_n}{\sum_{j\ge0}c_j\,j!/(q)_j},\qquad
\vartheta_H=\nu_H(n\ge1)>0.
\tag{U1}
\]
The effective distribution \(\nu_H\) does not depend on \(p\).

**Theorem (uniform relative margin, all finite couplings in H):**
\[
\boxed{
h_H'(p)\ \ge\
\gamma(q,b_u,b_v)\,\vartheta_H\
\ge\
\gamma(q,b_u,b_v)\,h_H(p),\qquad
0\le p\le1,
}
\tag{U2}
\]
where
\[
\boxed{
\gamma(q,b_u,b_v)=
\frac{2 b_u b_v\,e^{-2(b_u+b_v)}}
{q(q+1)(q+2)}>0.
}
\tag{U3}
\]
At \(p=0\) and \(p=1\), the derivatives mean the corresponding continuous one-sided derivatives (the event probability is in fact real analytic near this interval).

Thus, **for fixed \(q,b_u,b_v>0\)**, the positive *relative* slope is independent of the number of internal vertices, their topology (cycles allowed), and every finite internal coupling. In particular
\[
h_H(p_2)\ge e^{\gamma(p_2-p_1)}h_H(p_1),\qquad0\le p_1\le p_2\le1.
\tag{U4}
\]
The absolute slope may still vanish as the network grows because \(\vartheta_H\) and \(h_H\) can become arbitrarily small.

## Proof via ONE explicit pair in a positive covariance

From the exact event-resolved two-terminal formula, define
\[
F(d)=\mathbb E_{n\sim\nu_H}
\frac{(q)_d(q)_n}{(q)_{d+n}}.
\tag{P1}
\]
Then \(F(0)=1\), \(F\) is nonincreasing, and \(h_H(p)=1-\mathbb E_{\mu_p}F(d)\), where
\[
\mu_p(d)=\frac{w_d(p)}{G(p)},\quad
w_d(p)=\frac{H_d(\lambda_+(p),\lambda_-(p))}{(q)_d},\quad
G(p)=\sum_{d\ge0}w_d(p).
\tag{P2}
\]
Here the eigenvalues \(\lambda_\pm\ge0\) of \(b_uP_u+b_vP_v\) satisfy
\(\lambda_++\lambda_-=s\) and \(\lambda_+\lambda_-=b_ub_v(1-p)\).

Let \(T_d(p)=\partial_p\log w_d(p)\). The rank-two likelihood-ratio recurrence proves \(T_d\) is nondecreasing in \(d\), including at both overlap endpoints. Consequently
\[
\boxed{
h_H'(p)=
\sum_{0\le d<e}
\mu_p(d)\mu_p(e)
\bigl(F(d)-F(e)\bigr)
\bigl(T_e(p)-T_d(p)\bigr)\ge0.
}
\tag{P3}
\]
**Retain only the \(d=0,e=2\) term**, whose factors can be evaluated without inequalities:
\[
w_0=1,\quad
w_2=\frac{s^2-b_ub_v(1-p)}{q(q+1)},\quad
T_0=0,\quad
T_2=\frac{b_ub_v}{s^2-b_ub_v(1-p)}.
\tag{P4}
\]
Thus
\[
h_H'(p)\ge
\mu_p(0)\mu_p(2)\,[F(0)-F(2)]\,T_2
=\frac{b_ub_v}{q(q+1)\,G(p)^2}\,[1-F(2)].
\tag{P5}
\]
For \(n\ge1\),
\[
F_q(2,n)=\frac{(q)_2(q)_n}{(q)_{n+2}}
=\frac{q(q+1)}{(q+n)(q+n+1)}
\le\frac{q}{q+2},
\tag{P6}
\]
while for \(n=0\), \(F_q(2,0)=1\). Therefore
\[
1-F(2)\ge\frac{2}{q+2}\,\vartheta_H.
\tag{P7}
\]

Finally, \(G(p)=\int d\omega(P_x)\exp[b_u\operatorname{tr}(P_uP_x)+b_v\operatorname{tr}(P_vP_x)]\le e^{s}\), since individual projector overlaps lie in [0,1]. Combining (P5)–(P7) gives the first inequality in (U2).

For the second, the crossing event requires **at least one effective x–a strand**. The exact factorization
\[
h_H(p)=\mathbb E_{\mu_p,\nu_H}[1-F_q(d,n)]
\]
and \(0\le 1-F_q(d,n)\le\mathbf1_{\{n\ge1\}}\) imply
\[
h_H(p)\le\vartheta_H.
\tag{P8}
\]
This gives the second inequality. QED.

## Scope and the next uniform problem

This is a **uniform RELATIVE margin for the established ONE-gateway class**—a materially stronger statement than merely asserting that its compact-interval minimum derivative is positive. It answers the independent review's explicit question about \(p=0,1\) quantitatively and requires no small-internal-coupling approximation.

**It does not make the multi-gateway stability threshold \(\varepsilon_*\) graph-size independent.** The proof of stability in [CPN_MULTI_GATEWAY_STABILITY.md](CPN_MULTI_GATEWAY_STABILITY.md) controls perturbations using an **absolute** derivative margin, whereas here the lower bound is proportional to the **possibly vanishing** crossing probability. To get a volume-uniform additional-gateway threshold, one would need a bound on the change in \(h'(p)\) **relative to \(h(p)\)**, not just an absolute analytic-continuity bound.

Moreover, if either root strength tends to zero, \(\gamma\to0\). A full annulus theorem uniform over arbitrary nonnegative subgraph couplings (including deleted edges) therefore does NOT follow. Nor does this theorem treat several separate outer boundary marks/wiring ports.

See also [CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md](CPN_MULTI_GATEWAY_COEFFICIENT_CERTIFICATE.md) and the subsequent *symbolic-in-q* supplement [CPN_MULTI_GATEWAY_SYMBOLIC_Q.md](CPN_MULTI_GATEWAY_SYMBOLIC_Q.md), which proves a distinct finite-squarefree model coefficient certificate for every \(q\ge2\). Neither involves a CP or Yang–Mills mass gap proof.
