# CP projector loops: exact two-point bridge, a path comparison, and a three-pin obstruction

**7 November 2026 — independent derivation for critical review.** Companion to [CPN_POSITIVE_LOOPS.md](CPN_POSITIVE_LOOPS.md) (especially its (L8)). This note is for the finite-volume, nearest-neighbour **projector** model at \(\theta=0\), integer \(q\ge2\), nonnegative finite couplings \(b_e\); it does **not** prove exponential decay or a mass gap. The CP loop representation itself is prior work: Wolff (2010), arXiv:1001.2231. The identities and examples below are derived from the two-pinned specialization, and must be independently checked for novelty.

## Result 1 — EXACT free two-point function from the equal-pinned loop count

Let \(G=(V,E)\) be any finite graph, and integrate all projectors \(P_v=z_vz_v^\dagger\) independently against normalized Fubini–Study measure:
\[
d\mu(\mathbf P)=\frac1{Z_{\rm free}}
e^{\sum_{e=\{u,v\}}b_e\operatorname{tr}(P_uP_v)}
\prod_{v\in V}d\omega(P_v).
\tag{B1}
\]
Fix **two distinct vertices** \(x,y\). For the auxiliary model, pin their projectors both to the same fixed rank-one projector \(P_*\), and integrate all other vertices. Retain the two *labels* x and y in the oriented-index-loop expansion. Let \(K\in\mathbb Z_{\ge0}\) count the total number of cyclic pairs of switches between these two labels in all loops, as in (L7). Write \(\mathbb E_{\rm pin}\) for the resulting **positive diagram law with equal pins**.

Define
\[
a_k:=\frac{k!}{(q)_k},\qquad (q)_k=q(q+1)\cdots(q+k-1),\quad a_0=1.
\tag{B2}
\]

**Proposition (exact).**
\[
\boxed{\quad
\mathbb E_{\rm free}[\operatorname{tr}(P_xP_y)]
=\frac{\mathbb E_{\rm pin}\!\left[a_K\frac{K+1}{q+K}\right]}
{\mathbb E_{\rm pin}[a_K]},
\quad
\mathbb E_{\rm free}[\operatorname{tr}(P_xP_y)]-\frac1q
=\frac{q-1}{q}
\frac{\mathbb E_{\rm pin}\!\left[a_K\frac{K}{q+K}\right]}
{\mathbb E_{\rm pin}[a_K]}.
\quad}
\tag{B3}
\]
In particular, the connected adjoint/projector two-point function is nonnegative.

**Proof.** With all remaining vertices free, global \(SU(q)\) invariance ensures that the partition function \(Z(P_x,P_y)\) with *these two* vertices pinned depends only on the overlap \(p=\operatorname{tr}(P_xP_y)\in[0,1]\). (The assertion would fail in the presence of other arbitrary fixed orientations.) The finite-volume two-pinned loop identity (L8) is
\[
Z(p)=Z(1)\,\mathbb E_{\rm pin}[p^K].
\tag{B4}
\]
When \(P_x,P_y\) are subsequently sampled independently from Fubini–Study measure, \(p\sim\mathrm{Beta}(1,q-1)\), so
\[
\int_0^1p^k(q-1)(1-p)^{q-2}dp=\frac{k!}{(q)_k}=a_k.
\tag{B5}
\]
Tonelli applies to (B4) because its two-pin coefficients are nonnegative. Integrating (B4), with or without one extra factor \(p\), gives
\[
Z_{\rm free}=Z(1)\,\mathbb E_{\rm pin}[a_K],
\qquad
Z_{\rm free}\,\mathbb E_{\rm free}[p]
=Z(1)\,\mathbb E_{\rm pin}[a_{K+1}].
\]
As \(a_{K+1}=a_K(K+1)/(q+K)\), the first identity in (B3) follows. Subtract \(1/q\) and use \((K+1)/(q+K)-1/q=(q-1)K/[q(q+K)]\) to obtain the second. QED.

Let \(\varepsilon_{xy}=\mathbb P_{\rm pin}(K\ge1)\). Since
\[
\frac{k\,k!}{(q)_{k+1}}\le\frac1{q(q+1)}\quad(k\ge1,q\ge2),
\tag{B6}
\]
and \(\mathbb E_{\rm pin}[a_K]\ge\mathbb P_{\rm pin}(K=0)=1-\varepsilon_{xy}>0\), we get the **explicit observable-to-connectivity upper bound**
\[
\boxed{\quad
0\le C_{xy}:=\mathbb E_{\rm free}[\operatorname{tr}(P_xP_y)]-\frac1q
\le\frac{q-1}{q^2(q+1)}\,
\frac{\varepsilon_{xy}}{1-\varepsilon_{xy}}.
\quad}
\tag{B7}
\]
To verify (B6), put \(h_k=k\,k!/(q)_{k+1}\), so \(h_1=1/[q(q+1)]\) and
\[
\frac{h_{k+1}}{h_k}=\frac{(k+1)^2}{k(q+k+1)}\le1
\quad\Longleftrightarrow\quad 1\le k(q-1).
\]
This holds for all \(k\ge1,q\ge2\).

**What this does NOT do:** (B7) concerns **two individually pinned sites** in an otherwise free graph. The earlier annular estimate (L12) concerns **whole inner and outer boundaries fixed to one projector**, a different diagram law and event. No uniform domination between these events follows from (B7) alone. Thus the principal open annular boundary-comparison problem remains.

## Result 2 — the smallest graph SUPPORTS, rather than refutes, equal-pin domination

Consider a three-vertex path \(A-x-B\), with nonnegative couplings \(b_1\) on \(A-x\) and \(b_2\) on \(x-B\). Let \(S=|z_1|^2\sim\mathrm{Beta}(1,q-1)\) and
\[
f_q(b)=\mathbb E[e^{bS}]=\sum_{k\ge0}\frac{b^k}{(q)_k}.
\tag{P1}
\]
Define two distinct loop laws on the same path:

* **Free:** all \(A,x,B\) integrated. The event is that some oriented index loop visits both vertices \(A,B\).
* **Equal-pin:** only \(x\) integrated, while \(P_A=P_B=P_*\). The two pinned vertices retain distinct labels, and the event is that a loop visits both labels.

Write \(\varepsilon_{\rm free}\) and \(\varepsilon_{\rm pin}\) for their respective crossing probabilities. Integrating the two free endpoints *conditional on x* gives
\[
Z_{\rm free}=f_q(b_1)f_q(b_2),\qquad
Z_{\rm pin}=f_q(b_1+b_2).
\tag{P2}
\]
If the boundary pins are orthogonal, \(P_A\perp P_B\), the central overlaps \(S_A=|z_1|^2\) and \(S_B=|z_2|^2\) are coordinates of one Dirichlet\((1,\ldots,1)\) vector, giving
\[
Z_\perp=\sum_{m,n\ge0}\frac{b_1^m b_2^n}{(q)_{m+n}}.
\tag{P3}
\]
By the existing two-pin loop identity, \(Z_{\rm pin,no\ cross}=Z_\perp\).

**A separate free-loop enumeration:** At multiplicities \(m,n\) on the two edges, absence of a loop visiting both endpoints is equivalent to the permutation of the \(m+n\) incoming strands at \(x\) preserving the two strand groups. Summing the endpoint permutations, the restricted central permutations, and loop fugacities yields the coefficient
\[
[b_1^m b_2^n]\,Z_{\rm free,no\ cross}=\frac1{(q)_{m+n}},
\]
and hence
\[
\boxed{\quad Z_{\rm free,no\ cross}=Z_\perp.\quad}
\tag{P4}
\]
This equality is special to the path geometry and **not** a general boundary-comparison principle.

Therefore
\[
\varepsilon_{\rm free}=1-\frac{Z_\perp}{f_q(b_1)f_q(b_2)},
\qquad
\varepsilon_{\rm pin}=1-\frac{Z_\perp}{f_q(b_1+b_2)}.
\tag{P5}
\]
Since \(b_1,b_2\ge0\), both \(e^{b_1S}\) and \(e^{b_2S}\) increase with \(S\), so their covariance is nonnegative; equivalently,
\[
f_q(b_1+b_2)=\mathbb E[e^{b_1S}e^{b_2S}]
\ge\mathbb E[e^{b_1S}]\mathbb E[e^{b_2S}]
=f_q(b_1)f_q(b_2).
\tag{P6}
\]
Combining (P5) and (P6) proves the **exact, all-coupling small-graph comparison**
\[
\boxed{\varepsilon_{\rm free}\le\varepsilon_{\rm pin}
\quad\text{on }A-x-B,\quad q\ge2,\ b_1,b_2\ge0.}
\tag{P7}
\]
This is a **positive necessary check** for the hoped-for domination, but says nothing about its validity on general graphs or annuli.

For \(CP^2\), \(q=3\), \(b_1=b_2=1\), one has \(Z_\perp=2\), \(Z_{\rm pin}=(e^2-3)/2\), \(Z_{\rm free}=[2(e-2)]^2\), giving
\[
\varepsilon_{\rm free}\approx0.03087399958,\quad
\varepsilon_{\rm pin}\approx0.08864231629,\quad
C_{AB}\approx0.00519990322,
\]
while the upper bound in (B7) is \(0.00540355693\). The last two values are independently obtained from the exact rank-one transfer kernel: with \(t(b)=f_q'(b)/f_q(b)\),
\[
C_{AB}=\frac{q-1}{q}
\left[\frac{q t(b_1)-1}{q-1}\right]
\left[\frac{q t(b_2)-1}{q-1}\right].
\tag{P8}
\]
See [pilot/cpn_path_boundary_check.py](pilot/cpn_path_boundary_check.py), which checks these values without Monte Carlo.

## Result 3 — three different pinned orientations can produce NEGATIVE diagram weights

The two-pin nonnegative representation does not survive arbitrary prescribed exterior orientations. A smallest explicit obstruction is a star with one free center \(x\) and three *pinned* leaves \(A,B,C\). Let
\[
u=(1,0,0)^T,\qquad
v=(1,1,0)^T/\sqrt2,\qquad
w=(1,-2,0)^T/\sqrt5
\]
in \(\mathbb C^3\), and \(P_u=uu^\dagger\), etc. A valid index loop that visits the three pinned leaves once (take one copy of each star edge and a cyclic central permutation) has the factor
\[
\boxed{\operatorname{tr}(P_uP_vP_w)
=\langle u,v\rangle\langle v,w\rangle\langle w,u\rangle
=-\frac1{10}<0.}
\tag{O1}
\]
The reverse loop has the same negative real factor. All edge-coupling and free-center tensor-moment coefficients multiplying this trace are positive.

Therefore **individual loop diagrams are not generally nonnegative when three or more independent boundary orientations are pinned**. The total partition function remains positive, but one cannot use (L4) as a probability measure under arbitrary fixed CP boundaries. This does **not** disprove the possible free-vs-equal-pin domination on general finite graphs: it establishes a distinct obstruction to conditioning and annulus factorization.

## Status and next test

| Link | Status |
|---|---|
| Two-point function \(\leftrightarrow\) equal-pinned \(K\)-distribution on two sites | **Exact (B3)** |
| Two-point function bounded by equal-pinned two-site crossing | **Exact finite-volume inequality (B7)** |
| All-free versus equal-pinned crossing on the 3-site path | **Proved (P7)** |
| Nonnegative loop diagrams with three arbitrary pinned projectors | **False, explicit star (O1)** |
| General free-vs-equal-pin comparison on arbitrary graphs / planar annuli | **Open** |
| Relating two-site pinned crossing to whole-boundary annulus crossing | **Open** |
| Independent annular iterability, uniformly over exteriors | **Open** |
| Exponential decay, full CP mass gap, or Yang–Mills mass gap | **Not proved** |

**Research priority:** Attempt an actual free-vs-equal-pin crossing inequality on trees with more than one internal branching vertex, then on a single square, with an **identical definition of crossing** in the two diagram laws. A finite counterexample would be a clean falsifier; a proof requires a nontrivial switching/comparison argument. In a separate direction, find a way to bound the *two-point pinned* crossing in (B7) from a sequence of *fully pinned annular* estimates; this is not supplied by the three-site path result. Do not infer a general monotonicity from this one successful example.

**Prior work:** Wolff, *Simulating the All-Order Strong Coupling Expansion IV: CP(N−1) as a loop model*, Nucl. Phys. B 832 (2010), 520–537, arXiv:1001.2231; the loop expansion itself is not claimed as novel. The overlap-to-\(K\) derivation relies on [CPN_POSITIVE_LOOPS.md](CPN_POSITIVE_LOOPS.md). Independently verify the stated extensions before claiming novelty.
