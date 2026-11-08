# Annular twists with bounded-length extra edges

**Status (7 November 2026):** a written proof for review. The proposition below
follows from Proposition 2.2 of the cited preprint. It covers the bounded-range
O(3) conjecture, including arbitrary deletions and nonconstant strengths.
It has not had an independent mathematical review. No claim about a
four-dimensional gauge theory follows here.

The useful change is small: stop the frequency shells at
`floor(sqrt(N))`, and normalize by their *linear* frequency moment.
The gain is still logarithmic. The transfer needs an error of order
`1/log(N)`, not the stronger `1/N` obtained in the original paper.

## Source and scope

I checked Sections 2 and 3 in full, in both the PDF and the LaTeX sources of
OpenAI, *Exponential decay in two-dimensional classical O(n) models*
(September 2026), at `openai/math` commit
`4eaee87548250b2682affda7d05d947c05554bae`:

- [paper.pdf](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026/paper.pdf), pp. 3–12;
- [rotation.tex](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026/build/sections/rotation.tex);
- [annulus.tex](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/preprints/Exponential-decay-in-two-dimensional-classical-On-models-September-23-2026/build/sections/annulus.tex).

Equation numbers below refer to that PDF. The review of
[WORLDSHEET.md](WORLDSHEET.md) §6 uses its version at repository commit
`c3c995f607d5ac24127a74fea63d822dd0dca67d`.
I also read [CPN_TWIST.md](CPN_TWIST.md), the source's `clusters.tex`, and
[twist_graph.py](pilot/twist_graph.py) with its saved outputs.

## Part A. Check of §6

### A1. The finite-graph assertions are right

Proposition 2.2 is explicitly a finite-graph result. Its constant is

$$K_{\rm rot}(\beta)=6\beta^2+4\beta^{3/2}+\beta.$$

It is independent of the graph, the family size, and the prescribed spins.
The functions in the family must vanish on every pinned vertex. The
interaction, reference measure, and norm-one O(3) generators are still
essential hypotheses.

The boundary gauge identity (3.4) is also valid on every finite graph.
For any real vertex function equal to one on the inner pins and zero on
the outer pins, with gradient $h$,

$$W_t(shc)=Z(t+s)/Z(t),\qquad R_t(h,h)=-Z''(t)/Z(t).$$

This is an identity, with no graph-dependent constant. A useful upper
bound on $\|h\|_2$ is a separate geometric question. The counting-measure
energy $\sum_e h_e^2$ is the energy of the **unit-conductance** graph.
For conductances $b_e$, the corresponding energy is $\sum_e b_eh_e^2$.
The conductance comment in §6 should distinguish these two conventions.

### A2. The cancellation is right; the description of the geometry is incomplete

For a coordinate edge in direction $e_j$, a frequency group indexed by
$m\ne j$ is invariant under $p_j\mapsto-p_j$. Its sine sum vanishes.
For $m=j$, the two frequency signs give opposite coefficients.
Interchanging coordinates equates the two surviving coefficients.
This is exactly the proof of (3.8), following (3.11).

But **two orthogonal edge directions are not the only geometric input**.
The spatial estimates are concentrated in Lemma 3.2, including its proof:

| Step | Additional input |
|---|---|
| Profiles (3.5), modes (3.6) | Fixed smooth functions on a Euclidean annulus, with support away from both pinned layers. |
| Midpoint estimate (3.9) | Short coordinate increments, bounded profile derivatives, and $O(N^2)$ edges. |
| Mode norms (3.12) | The increment bound and the number of edges. |
| Shell sum (3.13), lower bound in (3.8) | Two-dimensional frequency shells have $O(r)$ points; a face supplies $2r+1$ points. |
| Fourier estimate (3.14) | The integer-coordinate embedding into a torus of side $16N$; distinct Fourier characters are orthogonal there. |
| Factorization (3.15) | Edges split into displacement classes; restriction to their origins is an operator of norm at most one. |

None of these steps uses a planar embedding or noncrossing edges. They
do use more than two named directions on an abstract graph. The torus
and shell arguments cannot simply be omitted. Below they survive with
constants depending on the range, by using finitely many displacement
classes. Translation invariance of the retained graph is unnecessary.

After Lemma 3.2, (3.16)–(3.20) use its estimates, rather than a new
planarity argument. The final integration uses positive, smooth,
$2\pi$-periodic $Z$. Section 4 has further geometric uses, including
separation by nearest-neighbour boundary layers. We do not transfer
that section here.

### A3. The claimed necessary accuracy is wrong

The paper **obtains** $\|h-\widetilde h\|_1=O(N^{-1})$ from an
$O(N^{-3})$ bound on each edge. It does not **need** that accuracy to
obtain an $O(1/\log N)$ curvature bound.

Here is the same transfer with its tolerance left explicit. Put
$d=h-\widetilde h$ and $\varepsilon=\|d\|_1$. When $R_t(h,h)>0$,
(3.17) gives

$$\langle X_t(hc)^2\rangle_t\leq\beta\|h\|_2^2.$$

Using $|X_t(dc)|\leq\beta\varepsilon$ gives

$$
|\langle X_t(hc)^2-X_t(\widetilde h c)^2\rangle_t|
\leq 2\beta^{3/2}\|h\|_2\varepsilon+\beta^2\varepsilon^2.
$$

The local error is at most
$\beta\|h+\widetilde h\|_\infty\varepsilon$.
Thus $\varepsilon=O(1/\log N)$ suffices if $\|h\|_2=O(1)$ and
$\|h+\widetilde h\|_\infty=O(1/N)$.
A sufficient uniform per-edge error is consequently
$O(N^{-2}/\log N)$ on a bounded-degree annulus.
Uniform per-edge accuracy is itself only a sufficient condition.

Also, Lemma 2.1 says
$\langle|X((df)g)|^2\rangle\leq\beta\|df\|_2^2$ **in expectation**,
and requires $f=0$ on the pins. It is not a pointwise current bound.
The boundary potential defining $h$ does not satisfy that requirement.

### A4. The full-shell mismatch is real; its stated consequence is too strong

For a general displacement $v$, let $a_N=\pi/(8N)$ and define

$$
A_m^{(N)}(v)=\sum_{\substack{1\leq r_p\leq N\\p_m>0}}
r_p^{-3}\sin(a_N p\cdot v),\qquad r_p=\|p\|_\infty.
$$

Reflection in the other coordinate gives the exact expression

$$
A_m^{(N)}(v)=\sum_{\substack{1\leq r_p\leq N\\p_m>0}}
r_p^{-3}\sin(a_Np_mv_m)\cos(a_Np_nv_n),\quad n\ne m.
$$

For diagonal edges there is a transverse cosine. For longer axial
edges there is also the difference between $\sin(kz)$ and $k\sin z$.
So the issue is not confined to new direction classes.

A cubic Taylor bound gives, for fixed $\|v\|_\infty\leq\ell$,

$$
A_m^{(N)}(v)=\frac{3\pi}{8N}H_Nv_m+O_\ell(N^{-1}),
\qquad H_N=\sum_{r=1}^N r^{-1}.
$$

In particular the paper's normalization is
$\lambda_N=NA_1^{(N)}(e_1)=(3\pi/8)H_N+O(1)$.
After logarithmic normalization, this allows a per-edge error of
$O_\ell(1/(N\log N))$, hence an $\ell^1$ error bounded by
$O_{\ell,D}(N/\log N)$. This explains the rough estimate in §6.
Relative errors are meaningful only when the leading coefficient does
not vanish. A positive density of extra edges alone does not prove an
$N/\log N$ lower bound: their positions, directions and the profile
products also matter.

Thus the unchanged full-shell construction does not give the needed
transfer estimate. This is a limitation of that construction, not an
obstruction to the conjecture. Even capping at $N/\ell$ leaves this
power of $N$ unchanged for fixed $\ell$. The shorter cap below resolves
it, while retaining logarithmically many scales.

## Part B. Bounded-range annular twist

### Statement

Fix $0\leq\beta<\infty$, an integer $\ell\geq1$, and a degree bound $D<\infty$.
Let $N\geq2$ be an integer. Let $G=(V,E)$ be a finite simple undirected
graph with

$$
V\subseteq D_N=\{x\in\mathbb Z^2:N\leq\|x\|_\infty\leq2N\},
\qquad 0<\|x-y\|_\infty\leq\ell\quad(\{x,y\}\in E),
$$

and maximum degree at most $D$. Assign arbitrary strengths
$0\leq b_e\leq\beta$. Integrate all unpinned spins against uniform
probability measure on $S^2$, with weight
$\exp(\sum_e b_es_x\cdot s_y)$. For $s_*=(1,0,0)$, pin exactly the
present vertices on the two layers to

$$
s_x=e^{tc}s_*\quad(\|x\|_\infty=N),\qquad
s_x=s_*\quad(\|x\|_\infty=2N),
$$

where $c$ generates rotations about the third axis. Include interactions
between pinned vertices in $Z(t)$.

**Proposition.** There is a finite $C(\beta,\ell,D)$, independent of
$N$, $G$, the strengths and $t$, such that

$$
\frac{\min_t Z(t)}{\max_t Z(t)}
\geq 1-\frac{C(\beta,\ell,D)}{\log N}.
\tag{B1}
$$

Nearest-neighbour edges need not all be present. There is no stationarity,
planarity, connectedness or edge-density hypothesis. For a simple graph
the range already bounds the degree by $(2\ell+1)^2-1$; a separate $D$
is therefore optional. A fixed finite translation-invariant stencil is
a special case.

### B1. Profiles and the shortened family

Use the paper's fixed smooth $\Theta$, equal to one near $[-1,1]^2$
and compactly supported in $(-2,2)^2$. Write $g_m=\partial_m\Theta$.
Choose real smooth $\chi_m$, compactly supported in
$\{1<\|z\|_\infty<2\}$ and equal to one on $\operatorname{supp}g_m$.
Set

$$
\phi_{m,\pm}=(\chi_m\pm g_m)/2,
\qquad \phi_{m,+}^2-\phi_{m,-}^2=g_m.
$$

All constants below may depend on these fixed profiles and on $\ell,D$.
They do not depend on the graph or on $N$. It suffices to prove the result
for $N\geq N_0=\max(4,2\ell)$. Enlarge the final constant to at least
$\log N_0$ to cover smaller $N$, since the right side of (B1) is then
nonpositive.

Put $K=\lfloor\sqrt N\rfloor$ and $a_N=\pi/(8N)$. Replace (3.6) by

$$
f_{m,\pm,p}(x)=r_p^{-3/2}\phi_{m,\pm}(x/N)e^{ia_Np\cdot x},
\qquad 1\leq r_p\leq K,\quad \pm p_m>0.
\tag{B2}
$$

These functions vanish on all pins. Orient each edge as $e=(x,x+v)$,
using one representative of each pair $v,-v$.

### B2. Exact current, approximate boundary gradient

Define

$$
A_m(v)=\sum_{\substack{1\leq r_p\leq K\\p_m>0}}
r_p^{-3}\sin(a_Np\cdot v),\qquad
B_m(x,y)=\phi_{m,+}(x/N)\phi_{m,+}(y/N)
-\phi_{m,-}(x/N)\phi_{m,-}(y/N).
$$

Mapping $p\mapsto-p$ in the negative group gives the **exact** identity

$$
Q_e:=\sum_i S(f_i,\overline{f_i})_e
=-i\sum_{m=1}^2 A_m(v)B_m(x,y).
\tag{B3}
$$

The first frequency moment is particularly simple. For each shell,

$$
\sum_{\substack{r_p=r\\p_1>0}}p_1
=r(2r+1)+2\sum_{j=1}^{r-1}j=3r^2,
\qquad
\sum_{\substack{r_p=r\\p_1>0}}p_2=0.
$$

The corresponding identities for $m=2$ follow by interchanging coordinates.
Define

$$
\lambda=Na_N\sum_{\substack{1\leq r_p\leq K\\p_1>0}}r_p^{-3}p_1
=\frac{3\pi}{8}H_K.
\tag{B4}
$$

Since $H_K\geq\log(K+1)>\tfrac12\log N$, this is at least
$(3\pi/16)\log N$.
There are $4r-1$ frequencies in a positive half-shell. The inequality
$|\sin u-u|\leq |u|^3/6$ therefore gives

$$
\left|A_m(v)-\frac{\lambda v_m}{N}\right|
\leq \frac{a_N^3}{6}\sum_{\substack{1\leq r_p\leq K\\p_m>0}}
r_p^{-3}|p\cdot v|^3
\leq C\frac{|v|_1^3K^2}{N^3}.
\tag{B5}
$$

Now define a real edge form by the exact current itself:

$$
\widetilde h_e=\lambda^{-1}\sum_m A_m(v)B_m(x,y).
\tag{B6}
$$

Thus $Q=-i\lambda\widetilde h$ holds exactly on **every** retained edge.
There is no assertion that the paper's formula (3.7) holds there.

Let $h_e=\Theta(y/N)-\Theta(x/N)$ and $z=(x+y)/(2N)$.
Centered Taylor expansion gives, uniformly for $|v|_\infty\leq\ell$,

$$
h_e=N^{-1}v\cdot\nabla\Theta(z)+O_\ell(N^{-3}),
\qquad B_m(x,y)=g_m(z)+O_\ell(N^{-2}).
$$

The second expansion uses $\phi_{m,+}^2-\phi_{m,-}^2=g_m$.
Combining these expansions with (B5)–(B6) yields

$$
|h_e-\widetilde h_e|
\leq C_\ell\left(\frac1{N^3}+\frac{K^2}{N^3H_K}\right).
\tag{B7}
$$

There are at most $D|D_N|/2\leq C DN^2$ edges. Also
$|h_e|\leq C\ell/N$. Since $K^2\leq N$, (B7) proves

$$
\|h\|_2\leq C_{\ell,D},\qquad
\|h+\widetilde h\|_\infty\leq C_\ell/N,
$$

$$
\varepsilon_N:=\|h-\widetilde h\|_1
\leq C_{\ell,D}\left(\frac1N+\frac{K^2}{NH_K}\right)
\leq \frac{C_{\ell,D}}{\log N}.
\tag{B8}
$$

This is the weaker, sufficient replacement for (3.9).

### B3. Both family costs remain logarithmic

Let $u_i=df_i$ and $T_{el}=\sum_i u_i(e)\overline{u_i(l)}$.
The discrete product rule and $|e^{iu}-1|\leq|u|$ give, on shell $r$,

$$
\|f_i\|_\infty\leq Cr^{-3/2},\qquad
\|df_i\|_2^2\leq C_{\ell,D}r^{-3}(1+r)^2
\leq C_{\ell,D}r^{-1}.
\tag{B9}
$$

There are $O(r)$ modes on shell $r$, including all four groups.
For $s\leq r$, take the supremum norm from the shell-$r$ mode.
Each pair costs at most $C_{\ell,D}r^{-3}s^{-1}$.
Counting $O(rs)$ pairs, then summing, gives

$$
\sum_{i,j}\min\{\|f_i\|_\infty^2\|df_j\|_2^2,
                 \|f_j\|_\infty^2\|df_i\|_2^2\}
\leq C_{\ell,D}\sum_{r=1}^K\sum_{s=1}^r r^{-2}
\leq C_{\ell,D}H_K.
\tag{B10}
$$

For the Hilbert–Schmidt bound, fix one profile group and let $U$ have
columns $r_p^{1/2}df_p$. Use the same torus
$Q_N=(\mathbb Z/(16N)\mathbb Z)^2$ as the paper. Its Fourier matrix
$F_{x,p}=e^{ia_Np\cdot x}$ satisfies

$$F^*F=(16N)^2I,\qquad \|F\|_{\rm op}=16N.$$

The frequencies are distinct modulo $16N$. Extend the profiles
periodically on that torus. Their support lies away from its boundary.

For each allowed oriented displacement $v$, let $P_v$ restrict to the
origins of its retained edges. Simplicity of the graph gives
$\|P_v\|_{\rm op}\leq1$. Put
$\Delta_v\phi(x)=\phi((x+v)/N)-\phi(x/N)$ and
$\phi^{(v)}(x)=\phi((x+v)/N)$, using the periodic extension.
The exact directional factorization is

$$
U_v=P_vM_{\Delta_v\phi}F\operatorname{diag}(r_p^{-1})
+P_vM_{\phi^{(v)}}F
\operatorname{diag}\left(\frac{e^{ia_Np\cdot v}-1}{r_p}\right).
\tag{B11}
$$

Here $M$ denotes multiplication. Both
$\|\Delta_v\phi\|_\infty$ and the norm of the last diagonal factor
are at most $C|v|_1/N$. Thus $\|U_v\|_{\rm op}\leq C|v|_1$.
There are at most $2\ell(\ell+1)$ oriented displacement classes.
Stacking these blocks gives $\|U\|_{\rm op}\leq C_\ell$.
No assumption about which origins are retained has entered.

Consequently

$$
T_{\rm group}=U\operatorname{diag}(r_p^{-1})U^*,\qquad
\|T_{\rm group}\|_{\rm HS}^2
\leq \|U\|_{\rm op}^4\sum_p r_p^{-2}
\leq C_\ell H_K.
$$

The triangle inequality over four groups gives
$\|T\|_{\rm HS}^2\leq C_\ell H_K$ for the whole family.
Together with (B10), this is the required version of (3.10).

### B4. Transfer and conclusion

Apply Proposition 2.2 with (B2). The exact identity (B3)–(B6) and
the bounds just proved give, uniformly in $t$,

$$
\lambda^2R_t(\widetilde h,\widetilde h)
=R_t(Q,\overline Q)\leq C_{\beta,\ell,D}H_K,
\qquad
R_t(\widetilde h,\widetilde h)\leq
\frac{C_{\beta,\ell,D}}{\log N}.
\tag{B12}
$$

If $R_t(h,h)\leq0$, the desired upper bound already holds.
Otherwise use (3.17) and the transfer in A3, with (B8). Its current
error is at most $C_{\beta,\ell,D}(\varepsilon_N+\varepsilon_N^2)$.
Its local error is at most $C_{\beta,\ell,D}\varepsilon_N/N$.
Thus, in both cases,

$$
-Z''(t)/Z(t)=R_t(h,h)\leq C_{\beta,\ell,D}/\log N=:\delta_N.
\tag{B13}
$$

This step uses Cauchy–Schwarz for random variables, not for $R_t$.
No positivity of $R_t$ is asserted.

Finally let $M=\max_t Z(t)=Z(t_0)$. Positivity and periodicity give
$Z'(t_0)=0$ and $Z''(t)\geq-\delta_NM$.
Every angle is within distance $\pi$ of $t_0$ on the circle.
Twice integrating yields

$$Z(t)\geq M(1-\pi^2\delta_N/2).$$

This proves (B1), after increasing the constant. $\square$

### What this changes

The translation-invariant special case and the full stated bounded-range
case have the same proof. Neither extra direction-dependent families nor
a gradient/remainder decomposition is needed. Keeping all shells up to
$N$ was unnecessary: $\log\sqrt N=\tfrac12\log N$ retains the gain.
Any fixed power cap $N^\alpha$, $0<\alpha\leq1/2$, works by the same
estimates, with constants depending on $\alpha$.

This proof is for the bilinear O(3) interaction. The real-projector
interaction has the norm-2 generators noted in `CPN_TWIST.md`.
The spatial estimates above do not depend on that choice of target,
but applying them there still needs the appropriate finite-graph
rotation inequality. That calculation remains with the other track.

## Numerical checks and limits

The deterministic companion is
[twist_nonplanar_checks.py](pilot/twist_nonplanar_checks.py).
Its outputs are in [twist_nonplanar_out/](pilot/twist_nonplanar_out/).
It checks the shell moments and the sine-remainder bound, compares full
and shortened frequency cutoffs on finite-range graphs with deletions,
and checks the current and operator factorizations directly on a small
graph. These are checks for algebra and scaling errors, not a substitute
for the proof.

The existing Monte Carlo table in §6 agrees with the saved JSON costs
except for one rounding discrepancy: the short-edge $\rho=0.1$, $N=4$
value is 20.834985 (20.83 to two decimals, rather than 20.84).
It uses only extra edges between free vertices. The proposition above
also allows extra edges touching the pins. For simple short-range graphs,
the sampler's range bound automatically bounds degree, though it does
not impose a smaller explicit maximum degree.

Two limits matter when reading that experiment. Growth up to $N=32$
does not prove nonvanishing cost as $N\to\infty$, and the predicted
eventual decrease at $\rho=0.3$ was an extrapolation. Also, the stored
`f_err` recurrence adds neighbouring trapezoids as if they were
independent. They share angle estimates. With independent angle runs,
the cumulative variance should use the squared *combined* weights:

$$
\operatorname{Var}(f_j)=\Delta t^2\left[
\tfrac14\sigma_0^2+\sum_{k=1}^{j-1}\sigma_k^2+\tfrac14\sigma_j^2\right].
$$

This observation does not change the saved point estimates. Sampling
uncertainty also excludes quadrature bias and possible mixing bias.
No Monte Carlo result is used in the proof.

All deterministic assertions passed in about one second. The largest
direct-current discrepancy was below $3\times10^{-15}$, and the largest
operator-factorization discrepancy was below $7\times10^{-16}$.
The original sampler also ran from `pilot/` as a small execution check:
`short 2.0 4 0.1 4 5 100 200 271828`. It took about one second after
compilation. Its coarse-angle, short-run estimate is not new evidence
for the asymptotic statement. Commands and limitations are recorded in
the output folder's [README](pilot/twist_nonplanar_out/README.md).

## Where I'm unsure or disagree

- I disagree with §6's statement that $O(N^{-1})$ in the transfer norm
  is necessary. $O(1/\log N)$ suffices, and is the reason the shortened
  family works.
- I disagree with reducing the geometric input to two directions.
  The two-dimensional shell count and the torus operator bound are
  essential too. They extend to fixed finite range as shown above.
- The proposition is proved here from the preprint's Proposition 2.2.
  It still needs an independent review, especially (B5)–(B8) and
  the displacement-block estimate (B11). No claim of novelty is made.
- This does not cover ranges growing with $N$, arbitrary abstract
  non-planar surfaces, annealed geometries without a suitable conditional
  spin law, multibody interactions, or the norm-2 projector constants.
  It establishes only the stated two-dimensional O(3) twist estimate.
