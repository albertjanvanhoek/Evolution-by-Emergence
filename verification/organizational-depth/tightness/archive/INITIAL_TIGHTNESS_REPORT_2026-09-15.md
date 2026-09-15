# How tight is the fixed-resolution bound, and what saturates it?

On $K_\delta^{\rm op} \le \delta^{-1}\sqrt{\Sigma_*\mathcal{N}_*/2}$ (Theorem 4 / Eq. 10.6).

---

## Summary

**The bound is tight.** It is saturated exactly in the near-equilibrium limit, by an
explicit construction, confirmed end-to-end on a simulated master equation. So it is the
right object, not a loose artifact of stacked Cauchy–Schwarz steps.

**But the construction that saturates it has no depth.** The optimum is a two-state shuttle
that oscillates between two distributions forever. It passes the fixed-resolution test of
Definition 1 arbitrarily many times while visiting exactly two distinguishable states. The
6-state ring — which does accumulate distinct configurations — reaches only half the bound.
Structures that do something meaningful are *worse* at saturating it.

**Budget buys transitions, not distinctions.** Scaling the activity budget by 125× scales
the bound by 125× and the Definition-1 count by 125×, while the number of mutually
distinguishable states visited does not move at all.

**The fix is free and gives something much stronger.** Requiring the retained states to be
*pairwise* distinguishable, rather than only consecutively, replaces the thermodynamic bound
with a packing number of the state simplex:
$$K^{\rm pairwise}_\delta \;\le\; \left(1+\tfrac{2}{\delta}\right)^{|S|-1},$$
which contains no $\Sigma_*$, no $\mathcal{N}_*$, no time and no temperature. On a finite
state space, retained depth is capped outright.

---

## 1. Where the speed limit is tight

Drive a single edge at constant asymmetry $\epsilon = J/A$, where $J$ is net probability
flux and $A$ dynamical activity. Then $a = A(1+\epsilon)/2$, $b = A(1-\epsilon)/2$ and
$\sigma = J\ln(a/b) = 2\epsilon A\,\mathrm{artanh}\,\epsilon$. Over an interval of length
$\tau$ at constant $A$:

$$d = \epsilon A\tau,\qquad \mathcal{N} = A\tau,\qquad \Sigma = 2\epsilon A\tau\,\mathrm{artanh}\,\epsilon .$$

The achieved-to-bound ratio is

$$\frac{d}{\sqrt{\mathcal{N}\Sigma/2}} \;=\; \sqrt{\frac{\epsilon}{\mathrm{artanh}\,\epsilon}} \;\xrightarrow[\epsilon\to0]{}\; 1 .$$

$A$ and $\tau$ cancel completely: tightness depends only on how hard the system is driven.
The same ratio carries through the counting step, so $K_\delta \to$ the bound exactly.

**The trade-off the bound encodes.** Holding $d = \delta$ per transition,

$$\mathcal{N}_n = \frac{\delta}{\epsilon} \to \infty, \qquad \Sigma_n = 2\delta\,\mathrm{artanh}\,\epsilon \to 0 .$$

Entropy per distinguishable transition can be made arbitrarily small; the activity cost
diverges in exactly compensating fashion. That is why the bound pairs the two budgets in a
product — and it is a sharp, quantitative version of §14's claim that the escape resource is
activity rather than energy.

## 2. Confirmation on a real master equation

Integrated a driven two-state chain holding $A$ and $\epsilon$ constant, measuring $A$,
$\sigma$ and $d_{\rm TV}$ from the trajectory rather than from the closed forms above:

| construction | $\mathcal{N}_*$ | $\Sigma_*$ | bound | $K_\delta$ (consecutive) | ratio | distinct states visited |
|---|---|---|---|---|---|---|
| shuttle, $\epsilon=0.5$ | 40 | 21.97 | 41.9 | 40 | 0.9541 | 2 |
| shuttle, $\epsilon=0.2$ | 100 | 8.11 | 40.3 | 40 | 0.9932 | 2 |
| shuttle, $\epsilon=0.05$ | 400 | 2.00 | 40.0 | 40 | 0.9996 | 2 |
| shuttle, $\epsilon=0.01$ | 2000 | 0.400 | 40.0 | 40 | **1.0000** | **2** |
| ring, $|S|=3$ | 2000 | 1.600 | 80.0 | 40 | 0.5000 | 3 |
| ring, $|S|=6$ | 2000 | 1.600 | 80.0 | 40 | 0.5000 | 6 |
| ring, $|S|=12$ | 2000 | 1.600 | 80.0 | 40 | 0.5000 | 12 |

$\delta = 0.5$ throughout. Two things to read off. The bound is attained to four decimal
places. And the attaining construction visits **two** distributions, while every construction
that visits more attains only half.

## 3. Budget does not buy depth

Six-state ring, $\delta = 0.5$, scaling the number of driven steps:

| steps | $\mathcal{N}_*$ | $\Sigma_*$ | thermodynamic bound | $K_\delta$ consecutive | pairwise-distinguishable |
|---|---|---|---|---|---|
| 12 | 600 | 0.480 | 24.0 | 12 | 6 |
| 60 | 3 000 | 2.400 | 120.0 | 60 | 6 |
| 300 | 15 000 | 12.00 | 600.0 | 300 | 6 |
| 1 500 | 75 000 | 60.01 | 3 000.2 | 1 500 | **6** |

A 125-fold increase in budget buys a 125-fold increase in the bound and in the
Definition-1 count, and buys **nothing** in depth.

## 4. Why: Definition 1 counts consecutive, not mutual, distinguishability

Definition 1 asks for infinitely many $n$ with $d_{\rm op}(x_n, x_{n+1}) \ge \delta$. A
shuttle between two distributions satisfies that for every $n$. Nothing in the criterion
requires $x_n$ to be distinguishable from $x_{n-2}$, or from any earlier state.

This is the same pathology the paper already identifies. Example 1 is "an ordinary finite
transformation partitioned into infinitely many increasingly small changes", and §9 insists
that "different labels do not establish such a distinction". The shuttle shows the pathology
surviving *into* the operational criterion that was introduced to rule it out: it is
resolution-robust in the sense of Definition 1, at fixed $\delta$, under a fixed measurement
standard, and it still has no depth. The refinement example fails by having $d_{\rm op}\to0$;
the shuttle keeps $d_{\rm op} = \delta$ forever and fails a different way.

## 5. The strengthening

Take "retained organizational depth" to mean mutually distinguishable retained states:
$d_{\rm op}(x_m, x_n) \ge \delta$ for all $m \ne n$. Then the count is bounded by the
$\delta$-packing number of the state simplex under total variation — a purely geometric
quantity of a compact metric space of diameter 1:

$$K^{\rm pairwise}_\delta \;\le\; \mathcal{P}(\Delta_{|S|-1}, \delta) \;\le\; \left(1+\tfrac{2}{\delta}\right)^{|S|-1},$$

with the exact value $\lfloor 1/\delta\rfloor + 1$ for two states. Computed achievable values
(lower bounds by lattice search) against that volumetric upper bound:

| $\lvert S\rvert$ | $\delta=0.9$ | $\delta=0.5$ | $\delta=0.25$ |
|---|---|---|---|
| 2 | 2 (ub 3) | 3 (ub 5) | 4 (ub 9) |
| 3 | 3 (ub 10) | 6 (ub 25) | 11 (ub 81) |
| 4 | 4 (ub 33) | 10 (ub 125) | 24 (ub 729) |
| 5 | 5 (ub 108) | 15 (ub 625) | 51 (ub 6561) |

**No thermodynamics appears.** Finite state space plus fixed resolution caps retained depth,
regardless of energy, activity, time or temperature. This is a strictly stronger no-go than
Theorem 4 for the quantity the paper actually cares about, and it costs nothing to state.

## 6. Where this leaves §14

The challenge in §14 asks for a system completing infinitely many retained transformations
that remain distinguishable at one fixed operational resolution. Section 5 above says such a
system must have an **unbounded state space** — no finite-state architecture can do it, at
any budget.

And that lands the question back on the fork the synthesis opened with. A growing state space
is an *amount*: distinguishable states must be physically realized, and realizing more of
them is a material claim, not a configurational one. So §14's escape route, followed
carefully, returns to resource accounting — but now with a specific mechanism and a specific
question: **how fast must $|S|$ grow to sustain depth, and what does that growth cost?**
That is a sharper question than the one the paper currently poses, and it is answerable.

## 7. Caveats

- **Saturation is against the SFS form as the paper states it.** Under the tighter form in
  Zhang's Comment (arXiv:1811.06978), with modified activity $\langle B\rangle \le 4\langle A\rangle$,
  the saturating regime would need rechecking; I could not do that without $B$'s definition.
  My reading is that the two forms coincide in the near-equilibrium limit where saturation
  occurs, but that is a conjecture, not a check.
- **The packing bound assumes organizational states are distributions on a fixed finite state
  space.** If the state space itself is what grows, the bound does not apply — which is
  precisely the escape route it identifies, not a defect in it.
- **Pairwise separation may be stronger than "depth" requires.** A system might legitimately
  revisit configurations while accumulating something else — a record, a history, a position
  in a larger space. But then the paper owes an account of what that something else is, and
  the packing argument will apply to *it* instead.
- The ring's ratio of exactly $0.50$ is an artifact of that particular drive schedule, not a
  universal figure for depth-accumulating architectures. The robust claim is the qualitative
  one: the saturating optimum is depthless.

## 8. Files

`analytic.py` (symbolic derivation), `simulate.py` (master-equation integration),
`packing.py`, `packing2.py` (packing numbers and the budget test), `make_figure.py`,
`figures/tightness.pdf`.
