# Tightness of the fixed-resolution bound, and the second factor it is missing

On $K_\delta^{\rm op} \le \delta^{-1}\sqrt{\Sigma_*\mathcal{N}_*/2}$ (Theorem 4 / Eq. 10.6).

*Revision 2. It replaces a first version whose central negative claim — that
depth-accumulating architectures cannot saturate the bound — was an artifact of the
construction used to test it. That claim is withdrawn; §3 explains the artifact
quantitatively, and the corrected result is stronger than the one it replaces.*

---

## Summary

**The bound is asymptotically tight.** The achieved-to-bound ratio is
$\sqrt{\epsilon/\mathrm{artanh}\,\epsilon}$, where $\epsilon=J/A$ is the drive
asymmetry. It is strictly below one at every $\epsilon>0$ and tends to one as
$\epsilon\to0$. Confirmed end-to-end on a master equation with explicitly
reconstructed rates. So Theorem 4 is the right object, not a loose artifact of stacked
Cauchy–Schwarz steps.

**Saturation is available at any depth.** A depth-2 shuttle and a depth-6 interior ring
give *identical* ratios to five figures at every $\epsilon$ tested — 0.95406, 0.99324,
0.99958, 0.99998. Nothing about saturating the transition bound requires the system to
be trivial.

**But Definition 1 counts the wrong thing.** It counts consecutive distinguishable
transitions. A two-state shuttle passes it forever while visiting two configurations.
That is a real definitional problem in the paper, independent of everything else here.

**The fix is a new theorem, not a new caveat.** Define packing depth
$D_\delta = \max\{|I| : d_{\rm op}(x_i,x_j)\ge\delta\ \forall i\ne j\in I\}$ over the
retained states. Then

$$\boxed{\;D_\delta \;\le\; \min\Big[\,1+\tfrac1\delta\sqrt{\tfrac{\Sigma_*\mathcal{N}_*}{2}}\;,\;\;
\mathcal{P}_\delta(X)\,\Big]\;}$$

— a **thermodynamic** factor and a **geometric** factor, each an independent obstruction.
The first is proved by the same Cauchy–Schwarz argument as Theorem 4, applied to the
chronologically ordered $\delta$-separated subsequence rather than to consecutive
transitions. The second is the $\delta$-packing number of the operational state space.
The thermodynamic factor is machine-checked (§9); the whole thing is drafted as a
drop-in manuscript section in `two_factor_section.tex`.

**Both factors are attained.** The thermodynamic factor is saturated to five figures by
an interior ring run for fewer steps than it has configurations; the geometric factor
binds as soon as the budget exceeds the repertoire. Neither is decorative.

**This rescues Theorem 4 rather than replacing it.** Theorem 4 becomes one half of a
two-factor no-go for organizational depth. The other half is geometry, and it carries
no thermodynamics at all.

---

## 1. Where the speed limit is tight

Drive a single edge at constant asymmetry $\epsilon = J/A$, where $J$ is net probability
flux and $A$ dynamical activity. Then $a = A(1+\epsilon)/2$, $b = A(1-\epsilon)/2$ and
$\sigma = J\ln(a/b) = 2\epsilon A\,\mathrm{artanh}\,\epsilon$. Over an interval of length
$\tau$ at constant $A$:

$$d = \epsilon A\tau,\qquad \mathcal{N} = A\tau,\qquad \Sigma = 2\epsilon A\tau\,\mathrm{artanh}\,\epsilon .$$

The achieved-to-bound ratio is

$$r_{\rm SFS}(\epsilon)\;=\;\frac{d}{\sqrt{\mathcal{N}\Sigma/2}} \;=\; \sqrt{\frac{\epsilon}{\mathrm{artanh}\,\epsilon}} \;<\;1\ \ (\epsilon>0),\qquad \xrightarrow[\epsilon\to0]{}\; 1 .$$

$A$ and $\tau$ cancel completely: tightness depends only on how hard the system is
driven. **Saturation is asymptotic, not exact** — the `1.0000` entries in the tables
below are rounding. The same ratio carries through the counting step unchanged.

**The trade-off the bound encodes.** Holding $d = \delta$ per transition,

$$\mathcal{N}_n = \frac{\delta}{\epsilon} \to \infty, \qquad \Sigma_n = 2\delta\,\mathrm{artanh}\,\epsilon \to 0 .$$

Entropy per distinguishable transition can be made arbitrarily small; the activity cost
diverges in exactly compensating fashion. That is why the bound pairs the two budgets in
a product — and it is a sharp, quantitative version of §14's claim that the escape
resource is activity rather than energy.

### 1.1 The Zhang caveat closes

The previous version left open whether the sharper form in Zhang's Comment
(arXiv:1811.06978) moves the saturating regime. It does not. Zhang replaces
$2\langle A\rangle$ by a modified activity built from
$\big(\sqrt{W_{ji}p_i}+\sqrt{W_{ij}p_j}\big)^2$. Counting each unordered pair once —
$B=\sum_{i<j}\big(\sqrt{F_{ij}}+\sqrt{F_{ji}}\big)^2 \le 2A$ — the bound reads
$d\le\tfrac12\sqrt{\mathcal{B}\Sigma}$, which recovers SFS exactly when $B=2A$. (With
the all-$i$ summation convention $B$ doubles and the prefactor becomes
$\tfrac1{2\sqrt2}$; $r_Z$ below is the same either way.) On the driven edge
$B = A\big(1+\sqrt{1-\epsilon^2}\big)$, so

$$r_Z(\epsilon)\;=\;\sqrt{\frac{2\epsilon}{\mathrm{artanh}\,\epsilon\,\big(1+\sqrt{1-\epsilon^{2}}\big)}}\;\xrightarrow[\epsilon\to0]{}\;1 ,$$

and $B/2A\to1$: the two forms **coincide in exactly the limit where saturation occurs**.

| $\epsilon$ | 0.9 | 0.5 | 0.2 | 0.05 | 0.01 |
|---|---|---|---|---|---|
| $r_{\rm SFS}$ | 0.781871 | 0.954065 | 0.993238 | 0.999583 | 0.999983 |
| $r_Z$ | 0.922761 | 0.987720 | 0.998293 | 0.999896 | 0.999996 |
| $B/2A$ | 0.717945 | 0.933013 | 0.989898 | 0.999375 | 0.999975 |

The Zhang form is *closer* to saturation at every $\epsilon$ — as it must be, being
tighter — and the saturating construction is unchanged. The caveat can be deleted, or
kept as a remark that the constant improves away from equilibrium.

## 2. Confirmation on a real master equation

Every run below integrates a genuine master equation. Rates are **reconstructed
explicitly at each step** from the instantaneous distribution,

$$W_{{\rm dst},{\rm src}}(t) = \frac{a}{p_{\rm src}(t)},\qquad W_{{\rm src},{\rm dst}}(t) = \frac{b}{p_{\rm dst}(t)},$$

so that the driven edge carries constant fluxes, and the state is then advanced from the
rate matrix. $A$, $\sigma$ and $d_{\rm TV}$ are measured from that trajectory. The
maximum rate actually used is reported, because a schedule that drives the state onto a
simplex vertex needs $W\to\infty$ and is not a legitimate finite-rate construction.

Two architectures, $\delta = 0.5$, $K=40$ transitions:

- **shuttle** — two states, mass swept back and forth. Packing depth 2.
- **interior ring** — $q=(1-\delta)/m$, $p^{(k)} = q\mathbf{1}+\delta e_k$. All $m$
  configurations are pairwise exactly $\delta$ apart, and no coordinate falls below $q$,
  so every rate is bounded by $a/q$. Packing depth $m$, at finite rates.

| construction | $\mathcal{N}_*$ | $\Sigma_*$ | bound | $K_\delta$ | ratio | $D_\delta$ | max rate |
|---|---|---|---|---|---|---|---|
| shuttle, $\epsilon=0.5$ | 40.0 | 21.9722 | 41.926 | 40 | 0.95406 | 2 | 3.00 |
| shuttle, $\epsilon=0.2$ | 100.0 | 8.1093 | 40.272 | 40 | 0.99324 | 2 | 2.40 |
| shuttle, $\epsilon=0.05$ | 400.0 | 2.0017 | 40.017 | 40 | 0.99958 | 2 | 2.10 |
| shuttle, $\epsilon=0.01$ | 2000.0 | 0.4000 | 40.001 | 40 | **0.99998** | 2 | 2.02 |
| ring $m=6$, $\epsilon=0.5$ | 40.0 | 21.9722 | 41.926 | 40 | 0.95406 | 6 | 8.97 |
| ring $m=6$, $\epsilon=0.2$ | 100.0 | 8.1093 | 40.272 | 40 | 0.99324 | 6 | 7.18 |
| ring $m=6$, $\epsilon=0.05$ | 400.0 | 2.0017 | 40.017 | 40 | 0.99958 | 6 | 6.28 |
| ring $m=6$, $\epsilon=0.01$ | 2000.0 | 0.4000 | 40.001 | 40 | **0.99998** | **6** | 6.04 |
| ring $m=12$, $\epsilon=0.01$ | 2000.0 | 0.4000 | 40.001 | 40 | **0.99998** | **12** | 12.0 |

The two architectures agree to five figures at every $\epsilon$, and the ring's rates
stay bounded. **Depth costs nothing in saturation.**

## 3. Withdrawing the previous claim, and why it was wrong

The previous version reported that rings attain exactly 0.50 of the bound and concluded
that structures which do something meaningful are worse at saturating it. **That
conclusion is withdrawn.** The 0.50 was not schedule-specific and not about depth: the
ring used there moved *all* the probability mass from site to site, so every move
travelled $d_{\rm TV}=1$ while the counting resolution was $\delta = 0.5$. A move that
travels $s \ge \delta$ still counts once, so the surplus $s-\delta$ is spent for nothing
and the ratio is pinned at $\delta/s$ — even with a perfectly saturated speed limit.

The one-parameter family $p^{(k)} = q\mathbf{1}+s\,e_k$, $q=(1-s)/m$, makes this
quantitative. $m=6$, $\epsilon=0.01$, $\delta=0.5$ throughout:

| step size $s$ | 0.5 | 0.6 | 0.75 | 0.9 | 0.99 |
|---|---|---|---|---|---|
| measured ratio | 0.99998 | 0.83332 | 0.66666 | 0.55555 | 0.50504 |
| $\;(\delta/s)\cdot r_{\rm SFS}$ | 0.99998 | 0.83332 | 0.66666 | 0.55555 | 0.50504 |
| max rate used | 6.04 | 7.54 | 12.0 | 29.7 | 297 |

Every digit of the measured ratio is $\delta/s$ times the tightness ratio. The old
"$0.50$" was $\delta/s$ at $s\to1$. The last row shows the second defect: the rate
needed approaches $am/(1-s)$, so the vertex ring is not a finite-rate construction at
all.

**The corrected statement: a depthless shuttle and a finite-depth ring saturate the
transition bound equally well.** Saturation and depth are independent properties, which
is precisely why one bound cannot police both.

## 4. The real definitional problem

Definition 1 asks for infinitely many $n$ with $d_{\rm op}(x_n, x_{n+1}) \ge \delta$. A
shuttle between two distributions satisfies that for every $n$. Nothing in the criterion
requires $x_n$ to be distinguishable from $x_{n-2}$, or from any earlier state.

This is the same pathology the paper already identifies. Example 1 is "an ordinary finite
transformation partitioned into infinitely many increasingly small changes", and §9
insists that "different labels do not establish such a distinction". The shuttle shows
the pathology surviving *into* the operational criterion introduced to rule it out: it is
resolution-robust in the sense of Definition 1, at fixed $\delta$, under a fixed
measurement standard, and it still has no depth. The refinement example fails by having
$d_{\rm op}\to0$; the shuttle keeps $d_{\rm op} = \delta$ forever and fails a different
way.

**So Definition 1 measures fixed-resolution transitions, not organizational depth.**
Theorem 4 is a correct and tight theorem about the former.

## 5. The two-factor theorem

> **Definition (packing depth).** For retained states $x_0,\dots,x_n$ observed at times
> $t_0<\dots<t_n$ along a trajectory, at resolution $\delta$,
> $$D_\delta(x_0,\dots,x_n) \;=\; \max\big\{\,|I| \;:\; I\subseteq\{0,\dots,n\},\;\; d_{\rm op}(x_i,x_j)\ge\delta \ \ \forall\, i\ne j\in I \,\big\}.$$

Revisits, excursions and idling are all permitted; they simply do not enlarge $I$.

> **Theorem (two-factor no-go).** Under the hypotheses of Theorem 4 on $[t_0,t_n]$, with
> $\mathcal{N}_*=\int A$, $\Sigma_*=\int\sigma$ over the whole interval, and with $X$ the
> operational state space,
> $$D_\delta \;\le\; \min\left[\,1+\frac1\delta\sqrt{\frac{\Sigma_*\mathcal{N}_*}{2}}\;,\;\;\mathcal{P}_\delta(X)\,\right].$$

**Proof of the thermodynamic factor.** Let $I=\{i_1<i_2<\dots<i_D\}$ be a maximal
$\delta$-separated set, *ordered chronologically*. Consecutive members satisfy
$d_{\rm op}(x_{i_k},x_{i_{k+1}})\ge\delta$ because all members do. The intervals
$J_k=[t_{i_k},t_{i_{k+1}}]$, $k=1,\dots,D-1$, have pairwise disjoint interiors and lie in
$[t_0,t_n]$. By data processing (10.2) and the integrated speed limit (10.3) on $J_k$,
$$\delta \;\le\; d_{\rm op}(x_{i_k},x_{i_{k+1}}) \;\le\; d_{\rm TV}\big(p(t_{i_k}),p(t_{i_{k+1}})\big) \;\le\; \sqrt{\mathcal{N}_k\Sigma_k/2},$$
with $\mathcal{N}_k=\int_{J_k}A$, $\Sigma_k=\int_{J_k}\sigma$. Summing and applying
Cauchy–Schwarz,
$$(D-1)\,\delta \;\le\; \sum_{k=1}^{D-1}\sqrt{\tfrac{\mathcal{N}_k\Sigma_k}{2}} \;\le\; \tfrac1{\sqrt2}\Big(\textstyle\sum_k\mathcal{N}_k\Big)^{1/2}\Big(\sum_k\Sigma_k\Big)^{1/2} \;\le\; \sqrt{\tfrac{\mathcal{N}_*\Sigma_*}{2}},$$
the last step by disjointness and non-negativity of $A$ and $\sigma$. The geometric
factor is immediate from the definition of the packing number. $\blacksquare$

Three remarks.

- **It is not a corollary of Theorem 4, and Theorem 4 is not a corollary of it.** The two
  count different things and neither dominates. A trajectory can drift through many
  mutually far states in steps all smaller than $\delta$ — then $K_\delta = 0$ while
  $D_\delta$ is large. The shuttle is the reverse: $K_\delta = 40$, $D_\delta = 2$. Same
  proof technique, different index set, incomparable conclusions. Both are worth stating.
- **The $+1$ is not slack.** A single retained state needs no budget at all.
- **Only consecutive members of $I$ enter the proof.** Everything the trajectory does
  between them contributes budget but no constraint, which is why revisits are free.

> **Corollary (what unbounded depth requires).** $\sup_n D_\delta(x_0,\dots,x_n)=\infty$
> at fixed $\delta$ requires **both** $\mathcal{P}_\delta(X)=\infty$ **and**
> $\mathcal{N}_*\Sigma_*=\infty$ over the whole history. Either a finite total
> activity–entropy product, or total boundedness of $X$ at scale $\delta$, forbids it
> outright — independently.

### 5.1 The thermodynamic factor is attained too

Interior ring, $m=12$, $\epsilon=0.01$, $\delta=0.5$, growing number of transitions $K$:

| $K$ | 2 | 4 | 6 | 8 | 11 | 20 | 40 | 80 |
|---|---|---|---|---|---|---|---|---|
| $\mathcal{N}_*$ | 100 | 200 | 300 | 400 | 550 | 1000 | 2000 | 4000 |
| thermodynamic factor | 3.00 | 5.00 | 7.00 | 9.00 | 12.00 | 21.00 | 41.00 | 81.00 |
| geometric factor | 12 | 12 | 12 | 12 | 12 | 12 | 12 | 12 |
| achieved $D_\delta$ | **3** | **5** | **7** | **9** | **12** | 12 | 12 | 12 |

For $K+1\le m$ the achieved depth equals the thermodynamic factor to five figures: the
new bound is asymptotically saturated too, and by a construction that *has* depth. Past
$K=m-1$ the geometric factor takes over and $D_\delta$ pins at 12 while the
thermodynamic factor keeps growing. Figure `figures/tightness.pdf` panel (b) is this
crossover; panel (a) is §1–§2.

## 6. The geometric factor

$\mathcal{P}_\delta(X)$ is the $\delta$-packing number of the operational state space —
a purely geometric quantity, containing no $\Sigma_*$, no $\mathcal{N}_*$, no time and no
temperature. For distributions on a finite $S$ under total variation it is finite and
computable.

**Upper bound.** Round $p$ to the lattice $L_k=\{m/k:\ m\in\mathbb{Z}_{\ge0}^n,\ \sum m=k\}$
by largest remainder. Writing $f=kp$, $m_i=\lfloor f_i\rfloor$, $r_i=f_i-m_i$ and
$D=\sum r_i\in\{0,\dots,n-1\}$, the $D$ largest remainders round up and
$d_{\rm TV}(p,q)=\tfrac1k\sum_{\rm down} r_i$. The down-remainders are each at most the
smallest up-remainder, so each is at most $D/n$, giving
$$d_{\rm TV}(p,L_k)\;\le\;\frac{(n-D)D}{nk}\;\le\;\frac{n}{4k}.$$
Two $\delta$-separated points therefore cannot share a lattice point once $n/(4k)<\delta/2$, so

$$\mathcal{P}_\delta(\Delta_{n-1})\;\le\;\binom{k+n-1}{n-1},\qquad k=\Big\lfloor\frac{n}{2\delta}\Big\rfloor+1 .$$

The lemma was checked on $4\times10^4$ random points for each $(n,k)$ tested; the worst
case found always sat just below $n/(4k)$ and matched the extremal configuration the
proof predicts. The bound is sharp to within one point at $n=2$, and is substantially
better than the volumetric $(1+2/\delta)^{n-1}$ used in the previous version.

**Values.** Achievable figures are lower bounds from randomized greedy search with
restarts and a swap local search on a $\delta$-commensurate lattice; $n=2$ is exact at
$\lfloor 1/\delta\rfloor+1$.

| $\lvert S\rvert$ | $\delta=0.9$ | $\delta=0.5$ | $\delta=0.25$ |
|---|---|---|---|
| 2 | **2** exact (ub 3) | **3** exact (ub 4) | **5** exact (ub 6) |
| 3 | $\ge3$ (ub 6) | $\ge6$ (ub 15) | $\ge15$ (ub 36) |
| 4 | $\ge4$ (ub 20) | $\ge11$ (ub 56) | $\ge38$ (ub 220) |
| 5 | $\ge5$ (ub 35) | $\ge16$ (ub 210) | $\ge86$ (ub 1365) |

*(The previous version's table reported 4 at $|S|=2,\delta=0.25$. The exact value is 5 —
$\{0,\tfrac14,\tfrac12,\tfrac34,1\}$ — and the search that returned 4 was a single greedy
pass on a lattice that could not represent it. The other entries were lower bounds then
too, and are now substantially better.)*

## 7. Where this leaves §14

§14 asks for a system completing infinitely many retained transformations that remain
distinguishable at one fixed operational resolution. The corollary in §5 says such a
system needs **unbounded operational packing capacity** — $X$ not totally bounded at
scale $\delta$ — **and** an unbounded activity–entropy product. Neither alone suffices.

Two corrections to how the previous version put this.

**"Unbounded state space" was the wrong phrase.** What is required is
$\mathcal{P}_\delta(X)=\infty$, i.e. failure of total boundedness *at that resolution*.
A fixed countably infinite $S$ already has it — the point masses $\delta_i$ are pairwise
at total-variation distance 1 — so no *growth* is needed for the geometric factor. The
distinction matters: growth is a material claim, a fixed infinite repertoire is not.

**And that is where Theorem 4 comes back.** Once the geometric factor is infinite, it
says nothing, and the thermodynamic factor is the *only* remaining obstruction — the one
that is tight, and the one that carries the resource accounting. The fork the synthesis
opened with therefore survives in a sharper form:

- **Finite or totally bounded repertoire.** Depth is capped outright by geometry, at any
  budget, any energy, any temperature, any time.
- **Unbounded repertoire.** Depth is capped by $1+\delta^{-1}\sqrt{\Sigma_*\mathcal{N}_*/2}$,
  which is tight, and the finite-action theorem applies to it directly. Sustaining
  unbounded depth then requires $\mathcal{N}_*\Sigma_*\to\infty$, and the question
  becomes **how fast** — and what realizing an unbounded distinguishable repertoire
  costs in the first place.

That is a sharper question than the one the paper currently poses, and the second horn
is the one the existing machinery already answers.

## 8. Verification

400 random master equations — random support, random log-normal base rates, random
time-dependent modulation, random dimension $2\le|S|\le6$, random
$\delta\in[0.05,0.6]$, random snapshot times. No ring, no shuttle, no structure.

| quantity | worst over 400 runs | must be |
|---|---|---|
| $\lVert\dot p\rVert_1/\sqrt{2A\sigma}$ | 1.000000 | $\le1$ |
| $d_{\rm TV}/\sqrt{\mathcal{N}\Sigma/2}$ | 0.547612 | $\le1$ |
| $D_\delta\,/\,[\,1+\delta^{-1}\sqrt{\mathcal{N}\Sigma/2}\,]$ | 0.474724 | $\le1$ |
| $D_\delta\,/\,\mathcal{P}_\delta$ (exact, $\lvert S\rvert=2$) | 1.000000 | $\le1$ |

Zero violations. The pointwise ratio touching 1 is the near-equilibrium saturation of
§1 appearing unprompted; the geometric ratio touching 1 is a two-state run realizing the
exact packing number.

## 9. The thermodynamic factor, machine-checked

`PackingDepth.lean` formalizes the §5 proof, in the conventions and namespace of
`OrganizationalDepth.lean`. Six declarations, Lean 4.33.0 against Mathlib
`db584cd`, compiled here: **zero errors, zero `sorry`, every declaration reporting
only `[propext, Classical.choice, Quot.sound]`**.

| declaration | content |
|---|---|
| `gap_sum_le` | the Cauchy–Schwarz step: $\sum_k d_k \le \sqrt{\mathcal{N}_*\Sigma_*/2}$ from the per-block law $2d_k^2\le \mathcal{N}_k\Sigma_k$ and the two summation hypotheses |
| `packing_depth_thermo` | the thermodynamic factor, $m+1 \le 1+\delta^{-1}\sqrt{\mathcal{N}_*\Sigma_*/2}$ |
| `packing_depth_two_factor` | the $\min$ of the two factors |
| `depth_le_of_budget_ceiling` | a uniform ceiling on $\mathcal{N}\Sigma$ uniformly bounds depth |
| `packing_depth_thermo_witness` | the hypotheses are satisfiable — an explicit instance |
| `packing_depth_thermo_sharp` | that instance meets the bound with **equality**, $3 = 1+\sqrt{4\cdot2/2}$ |

Two deliberate choices. Block disjointness enters only through
$\sum_k\mathcal{N}_k\le\mathcal{N}_*$ and $\sum_k\Sigma_k\le\Sigma_*$, which is all the
proof uses and keeps the statement free of any interval formalism. And the "unbounded
depth requires an unbounded budget" corollary is stated as a *uniform ceiling*
($\forall j,\ \mathcal{N}_j\Sigma_j\le C \Rightarrow \forall j,\ D_j \le
1+\delta^{-1}\sqrt{C/2}$) rather than as "there exists a bound on every $m$" — the
latter is unsatisfiable on its face, so proving it would establish that its own
hypotheses are contradictory rather than establishing a bound. The last two
declarations exist because a conditional implication is worth nothing if its
hypotheses cannot be met; here they can, and tightly.

As with the existing appendix, this verifies conditional implications only. It does not
formalize or validate the speed limit, the readout channel, or the identification of any
metric with operational distinguishability.

## 10. Caveats

- **Saturation is asymptotic.** At any $\epsilon>0$ the ratio is strictly below one, and
  approaching one costs activity as $1/\epsilon$. Nothing here exhibits exact saturation
  at finite drive, and the analysis says none exists.
- **The tightness construction is a single driven edge.** The ratio
  $\sqrt{\epsilon/\mathrm{artanh}\,\epsilon}$ is derived for constant-asymmetry driving
  on one edge, and the rings are built from such edges. I have not characterized the
  optimal multi-edge protocol; it cannot do better than 1, but it may approach it
  differently.
- **$\mathcal{P}_\delta$ values for $|S|\ge3$ are lower bounds**, from search. The upper
  bounds are proved. The gap is genuine and I have not closed it.
- **Packing depth may still be stronger than "depth" requires.** A system might
  legitimately revisit configurations while accumulating something else — a record, a
  history, a position in a larger space. Packing depth permits revisits, which the
  previous version's pairwise-distinct criterion did not, so it is a weaker demand; but
  if the retained quantity is genuinely something other than the operational state, the
  paper owes an account of what, and the same two-factor argument will then apply to
  *that* space instead.
- **$d_{\rm op}$ is assumed to arise from a fixed readout channel**, so that data
  processing gives $d_{\rm op}\le d_{\rm TV}$ with constant 1. A time-varying or
  state-dependent readout is outside this.

## 11. Files

| file | what it does |
|---|---|
| `analytic.py` | symbolic derivation of $r_{\rm SFS}$, $r_Z$, and the $\mathcal{N}_n\Sigma_n$ trade-off |
| `simulate.py` | master-equation integration with explicit rate reconstruction; shuttle and interior-ring families; both counts |
| `packing.py` | packing numbers: exact $n=2$, randomized search lower bounds, lattice-rounding upper bound and its lemma check |
| `verify.py` | adversarial check of all four inequalities on random master equations |
| `PackingDepth.lean` | the §5 proof, machine-checked |
| `make_figure.py`, `figures/tightness.pdf` | the two-panel figure |

Reproduction: `python3 analytic.py`, `simulate.py`, `packing.py`, `verify.py`,
`make_figure.py`; and `lean PackingDepth.lean` with Lean 4.33.0 and Mathlib `db584cd`
on `LEAN_PATH`.