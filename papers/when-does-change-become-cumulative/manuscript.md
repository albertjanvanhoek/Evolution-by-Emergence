# When Does Change Become Cumulative?

## Retained accessibility, slack, and the budgeted ratchet of reusable organization

### Abstract

Continuous change is not cumulative change. Organizational components turn over, implementations are replaced, and new capabilities may appear while old ones disappear. The question is therefore not whether some scalar quantity rises, but under what conditions earlier organization remains usable while later organization becomes newly reachable.

We begin from the finite-horizon accessibility framework already developed in *Organizational Accessibility: From Self-Maintenance to Evolvability*. Fix a declared target family, evaluation protocol, horizon, establishment criterion, and probability threshold. These choices induce an operational repertoire

\[
\mathcal R_t(p_\star)
=
\left\{
U:
\mathcal H_\tau(U\mid s_t,\mathcal P)\ge p_\star
\right\}.
\]

A step preserves accessibility when

\[
\mathcal R_t\subseteq\mathcal R_{t+1},
\]

and is a strict order-theoretic click when the inclusion is proper. Set expansion alone is not historical causation, so we separately define a historically attributed click: at least one newly accessible target must receive a positive causal contribution from retained earlier structure under the interventional criterion of the parent framework.

We then study a resource-limited specialization. For a declared capability set, realization cost \(c_t(x)\), and budget \(B\), let a capability be budget-feasible when \(c_t(x)\le B\). Pointwise cost domination is sufficient for retention but is not necessary. A productive acquisition can lower all inherited costs, whereas a one-way non-returning addition produces uniform dilution and raises every inherited cost while preserving the repertoire over a finite range.

For the uniform-dilution topology, let \(c_t^\star\) be the attained binding cost of the declared inherited repertoire and define

\[
M_t=\frac{B}{c_t^\star}-1.
\]

Then retention is exact:

\[
\boxed{
\kappa\le M_t
}
\]

if and only if a load that multiplies inherited costs by \(1+\kappa\) remains affordable. The margin evolves by

\[
\boxed{
\frac{1+M_{t+1}}{1+M_t}
=
\frac{c_t^\star}{c_{t+1}^\star},
}
\]

and under pure dilution,

\[
\boxed{
M_{t+1}
=
\frac{M_t-\kappa}{1+\kappa}.
}
\]

A step that lowers the binding inherited cost winds future capacity; a step that raises it spends capacity.

This yields a positive cumulative-existence result. If a retained first click raises margin from \(M_0\) to \(M_1>M_0\), then every coupling in

\[
(M_0,M_1]
\]

is unaffordable before the first click but affordable afterward. If maintained production simultaneously rises from \(X_0\) to \(X_1\), then for each such coupling there is a nonempty interval of new-module thresholds that are inaccessible before and accessible after. An exact rational worked example gives

\[
\{A,B\}
\subsetneq
\{A,B,C\}
\subsetneq
\{A,B,C,D\},
\]

while the second click attempted directly from the baseline both loses inherited capability \(A\) and fails to make \(D\) accessible.

The order-theoretic core, the budget bound, the margin identities, the opening of future coupling and threshold windows, and the exact two-click witness are machine checked in Lean. Finally, writing \(W=\log(1+M)\) and \(Y=\log r\) turns retained multiplicative change into a state-filtered additive process. For an i.i.d. state-independent candidate pool with \(\mathbb E|Y|<\infty\), positive linear growth of log-slack occurs exactly when \(\mathbb E[Y]<0\), equivalently when the geometric mean binding-cost multiplier is below one. The result is not a universal arrow of evolution. It is a conditional ratchet: cumulative change occurs when retained organization preserves a declared repertoire while changing the resource state so that additional organization becomes retainable.

---

## 1. The question

The project began from a simple observation.

Everything realized has a finite material history. Molecules are replaced. Cells replace cells. Organisms replace components. Institutions replace members. Machines replace parts. Yet organized processes can persist.

Persistence therefore cannot generally mean persistence of the same material pieces. It means that an organization of processes continues to recreate the conditions under which further activity is possible.

The next question is harder:

> **When does this continuing replacement become cumulative history?**

The preceding papers rule out several easy answers.

Persistence does not itself supply a functional standard. An endogenous objective can select regulation without selecting enough regulation to satisfy an independently declared function. Organizational accessibility can widen, narrow, redirect, or collapse. And finite resources forbid unlimited fixed-resolution organizational depth in finite time under the stated physical assumptions.

So cumulative change cannot be identified with survival, optimization, complexity, or the mere appearance of novelty.

The object we need is narrower:

> **previously reachable organization remains reachable, and retained history makes additional organization reachable.**

---

## 2. Operational accessibility is the master object

The parent framework defines finite-horizon organizational accessibility through the hitting probability

\[
\mathcal H_\tau(U\mid\theta,z,E,Q),
\]

where the current organization and realized state are \((\theta,z)\), the environment is \(E\), and \(Q\) specifies the candidate-generating process.

A claim of cumulative accessibility requires a comparison protocol. Fix:

- a declared target family \(\mathscr U\);
- a finite horizon \(\tau\);
- an establishment criterion;
- a common evaluation protocol \(\mathcal P\);
- a probability threshold \(p_\star\).

For historical state \(s_t\), define

\[
h_t(U)
=
\mathcal H_\tau(U\mid s_t,\mathcal P)
\]

and the declared operational repertoire

\[
\boxed{
\mathcal R_t
=
\left\{
U\in\mathscr U:
h_t(U)\ge p_\star
\right\}.
}
\]

The declaration is part of the scientific claim. Different target families, horizons, environments, establishment criteria, or thresholds can induce different orderings.

### Definition 1 — preservation

A step preserves declared accessibility when

\[
\boxed{
\mathcal R_t\subseteq\mathcal R_{t+1}.
}
\]

### Definition 2 — strict order-theoretic click

A step is a strict accessibility click when

\[
\boxed{
\mathcal R_t\subsetneq\mathcal R_{t+1}.
}
\]

Thus an old declared capability is not lost, and at least one previously inaccessible declared target becomes accessible.

Preservation is reflexive and transitive. Strict expansion composes with preservation. Therefore if a click occurs and every later step preserves the declared repertoire, the click remains present relative to its earlier baseline.

The induced relation on physical organizational states is generally a preorder, not a partial order, because distinct implementations can induce the same declared accessible repertoire. After quotienting states that induce the same repertoire, subset inclusion gives the corresponding partial order.

This is already a formal meaning of inheritance without material identity.

---

## 3. Set expansion is not historical causation

A larger accessible repertoire at \(t+1\) does not by itself show that retained organization caused the increase. The environment may have changed, an external agent may have supplied the new route, or some uncontrolled condition may have shifted.

Let

\[
N_{t+1}
=
\mathcal R_{t+1}\setminus\mathcal R_t
\]

be the newly accessible declared targets.

### Definition 3 — historically attributed ratchet click

A historically attributed click requires:

1. a strict order-theoretic click,
   \[
   \mathcal R_t\subsetneq\mathcal R_{t+1};
   \]
2. retained earlier structure \(h\) for which at least one target \(U^\star\in N_{t+1}\) has a positive causal accessibility contribution under the intervention defined in the parent framework,
   \[
   \Delta_\tau^{\mathrm{total}}(U^\star;h\mid B)>0,
   \]
   or the corresponding controlled-opportunity contrast when that is the estimand.

The present paper proves order-theoretic existence in the worked model. Historical attribution in an empirical application requires the intervention separately.

---

## 4. Cost accessibility is a mechanistic specialization

The stochastic hitting-probability repertoire is the master accessibility object. Cost is not a second definition of accessibility.

For a resource-limited specialization, let

\[
c_t(x)
\]

be a specified effective cost of realizing capability \(x\) from the current organization, and let \(B\) be a common budget.

Define the budget-feasible set

\[
\mathcal F_t(B)
=
\left\{
x:
c_t(x)\le B
\right\}.
\]

A model using \(\mathcal F_t\) as a representation of \(\mathcal R_t\) must state why its cost is informative about finite-horizon establishment. No general equivalence between finite cost and positive hitting probability is assumed here.

Two orders are useful.

### Cost domination

\[
(D):
\qquad
c_{t+1}(x)\le c_t(x)
\quad\forall x.
\]

Nothing got harder.

### Budget retention

\[
(R):
\qquad
\mathcal F_t(B)\subseteq\mathcal F_{t+1}(B).
\]

Nothing that was already affordable became unaffordable.

Pointwise domination implies retention for every budget. The converse fails.

That gap is essential in a shared-budget system.

---

## 5. Domination is possible, but uniform dilution forbids it

It would be a mistake to conclude that resource limitation makes pointwise cost improvement impossible.

A productive extension can lower every inherited cost. In the non-substituting production-network extension

\[
B
=
\begin{pmatrix}
0&1&v\\
1&0&0\\
f&0&0
\end{pmatrix},
\]

the original \(A\to B\) route remains and \(A\) additionally produces \(C\).

For example, the numerical witness \(v=100,\ f=0.01\) changes

\[
c(A):0.60000\to0.39775,
\]

\[
c(B):0.30000\to0.28125,
\]

and raises the inherited margin from

\[
0.666667\to1.514117.
\]

There are therefore productive acquisitions that satisfy strict pointwise domination.

The impossibility result is narrower.

### Uniformly dilutive topology

A one-way downstream component that consumes maintained material but returns no production leaves the host production eigenvalue and total maintained host-plus-load mass structure unchanged in the relevant way, while dividing inherited host abundances by \(1+\kappa\).

For abundance-linear capacities with cost

\[
c(x)=\frac{\theta_x}{\Phi_x},
\]

every inherited cost is multiplied by

\[
1+\kappa.
\]

Therefore, for any positive inherited cost and any \(\kappa>0\),

\[
(1+\kappa)c(x)>c(x).
\]

Strict domination is impossible for this topology.

But retention may still hold.

That is the difference between a shared-budget extension and a free graph extension: an added capability can impose opportunity cost on existing organization without yet evicting it.

---

## 6. The exact budget bound

Fix a declared inherited set \(S\).

Among those declared capabilities that are currently inside budget, let the attained binding cost be

\[
c_t^\star
=
\max_{x\in S\cap\mathcal F_t(B)}
c_t(x),
\]

with

\[
0<c_t^\star\le B.
\]

Define the margin

\[
\boxed{
M_t
=
\frac{B}{c_t^\star}-1.
}
\]

This is the proportional slack of the binding inherited capability.

Now suppose a candidate acquisition produces uniform dilution:

\[
c_{t+1}(x)
=
(1+\kappa)c_t(x)
\]

for inherited capabilities.

### Proposition 1 — exact retention boundary

The declared inherited repertoire is retained if and only if

\[
\boxed{
\kappa\le M_t.
}
\]

Proof follows immediately from the binding capability. Retention requires

\[
(1+\kappa)c_t^\star\le B,
\]

which is equivalent to

\[
\kappa\le\frac{B}{c_t^\star}-1.
\]

Conversely, if this inequality holds, every declared inherited capability that was within budget remains within budget because its old cost is no greater than \(c_t^\star\).

The result is exact for the uniform-dilution topology.

It does not say whether the acquired capability is useful enough to justify spending the margin. It says only whether the old declared repertoire can afford the load.

The same algebraic slack variable has appeared elsewhere in this project for one-way parasitic load and regulatory overhead. The conservative claim is therefore:

> **\(M_t\) is the common slack variable for the uniform-dilution class of one-way loads.**

---

## 7. Winding and spending

The margin is a state variable for future affordability.

For a fixed inherited declaration during a transition, let \(c_t^\star\) and \(c_{t+1}^\star\) be the old and new binding costs. Then

\[
1+M_t=\frac{B}{c_t^\star}
\]

and

\[
1+M_{t+1}=\frac{B}{c_{t+1}^\star}.
\]

Therefore

\[
\boxed{
\frac{1+M_{t+1}}{1+M_t}
=
\frac{c_t^\star}{c_{t+1}^\star}.
}
\]

Equivalently, if

\[
r_t
=
\frac{c_{t+1}^\star}{c_t^\star},
\]

then

\[
\boxed{
1+M_{t+1}
=
\frac{1+M_t}{r_t}.
}
\]

This gives a precise classification.

- \(r_t<1\): the inherited binding cost falls; the step **winds** future capacity.
- \(r_t=1\): inherited slack is unchanged.
- \(1<r_t\le1+M_t\): the step **spends** slack but retains the inherited repertoire.
- \(r_t>1+M_t\): retention fails.

For a purely dilutive load,

\[
r_t=1+\kappa,
\]

so

\[
\boxed{
M_{t+1}
=
\frac{M_t-\kappa}{1+\kappa}.
}
\]

This recursion is exact.

It does not imply finite-step exhaustion when accepted loads can become arbitrarily small. Finite load counts require an additional resolution or minimum-load condition.

A second bookkeeping issue matters. If a newly acquired capability is added to the declared inherited set for the next step, it may itself become the new binding capability. Thus one should distinguish:

- the post-step margin of the inherited repertoire used to test retention;
- the updated current margin after the new capability is admitted into the declaration.

In the worked two-click example below, the first acquired capability is chosen so that it does not become binding. In general it may.

---

## 8. Corollary: a winding click opens future acquisition space

The margin identity turns the phrase “previous organization becomes the starting point for the next search” into a checkable consequence.

This section is deliberately a **corollary** of the exact retention boundary. It assumes that a retained first click with \(M_1>M_0\) already exists. The substantive existence claim is supplied by the worked network in Section 9.

Suppose such a click changes the current margin from

\[
M_0
\]

to

\[
M_1
\]

with

\[
\boxed{
M_1>M_0.
}
\]

Then the interval

\[
\boxed{
(M_0,M_1]
}
\]

is nonempty.

Every uniform-dilution coupling \(\kappa\) in that interval has the property

\[
\kappa>M_0,
\]

so the same load is not retainable before the first click, while

\[
\kappa\le M_1,
\]

so it is retainable afterward.

Formally, this is Proposition 1 applied at two different historical states, with each margin computed from the binding cost of the declared repertoire at that state.

### Corollary 1 — retention window opened by winding

If

\[
M_1>M_0\ge0,
\]

then there exists a nonempty set of future loads that are not retainable before the first click and are retainable afterward.

Retainability alone is **not** a second click. The prospective module must itself become newly accessible.

Suppose the first click also raises maintained production:

\[
X_1>X_0.
\]

For a one-way acquired module with coupling \(\kappa>0\), its maintained amount is

\[
x_D
=
\frac{X\kappa}{1+\kappa}.
\]

If its declared threshold is \(\theta_D\), it is accessible when

\[
\theta_D\le
\frac{X\kappa}{1+\kappa}.
\]

Thus for every \(\kappa>0\),

\[
\boxed{
\left(
\frac{X_0\kappa}{1+\kappa},
\frac{X_1\kappa}{1+\kappa}
\right]
}
\]

is a nonempty interval of thresholds for which the proposed module is inaccessible before the first click and accessible afterward.

The two ingredients therefore play different roles:

\[
\boxed{
\begin{aligned}
M_0<\kappa\le M_1
&\quad\Rightarrow\quad
\text{the inherited repertoire can retain the load only after click 1},\\
\frac{X_0\kappa}{1+\kappa}<\theta_D\le
\frac{X_1\kappa}{1+\kappa}
&\quad\Rightarrow\quad
\text{the new capability itself crosses into accessibility only after click 1}.
\end{aligned}
}
\]

Only their conjunction supplies the two-click region.

The coupling-window existence, its direct retainability interpretation, and the threshold-window existence are machine checked.

---

## 9. Exact two-click existence witness

The general result is not merely an inequality. The worked production network contains a concrete two-click sequence.

Take budget

\[
B=1,
\]

and declared thresholds

\[
\theta_A=\frac{3}{10},
\qquad
\theta_B=\frac{3}{20},
\qquad
\theta_C=\frac{1}{10},
\qquad
\theta_D=\frac{1}{2}.
\]

### Baseline

At \(f=0\),

\[
x_A=x_B=\frac12.
\]

Therefore

\[
c_0(A)=\frac35,
\qquad
c_0(B)=\frac3{10},
\]

and the baseline margin is

\[
M_0
=
\frac{1}{3/5}-1
=
\frac23.
\]

The operational repertoire is

\[
\{A,B\}.
\]

### Click 1 — productive reorganization

Choose

\[
f=\frac{11}{25},
\qquad
v=2.
\]

Then

\[
\lambda
=
\sqrt{1+f}
=
\frac65,
\]

and maintained mass is

\[
X_1
=
2-\frac1\lambda
=
\frac76.
\]

The equilibrium abundances give exact costs

\[
c_1(A)=\frac{33}{70},
\]

\[
c_1(B)=\frac{99}{196},
\]

\[
c_1(C)=\frac37.
\]

All are below one, so

\[
\boxed{
\{A,B\}
\subsetneq
\{A,B,C\}.
}
\]

The binding cost is

\[
\frac{99}{196},
\]

so

\[
M_1
=
\frac{1}{99/196}-1
=
\frac{97}{99}.
\]

Hence

\[
\frac{97}{99}>\frac23.
\]

Click 1 winds the ratchet.

### Click 2 — non-returning acquisition

Choose

\[
\kappa_D=\frac9{10}.
\]

This lies in the opened coupling interval:

\[
\frac23
<
\frac9{10}
\le
\frac{97}{99}.
\]

After uniform dilution of the inherited host, the exact costs are

\[
c_2(A)=\frac{627}{700},
\]

\[
c_2(B)=\frac{1881}{1960},
\]

\[
c_2(C)=\frac{57}{70}.
\]

The new module receives

\[
x_D
=
\frac{X_1\kappa_D}{1+\kappa_D}
=
\frac{21}{38},
\]

so

\[
c_2(D)
=
\frac{1/2}{21/38}
=
\frac{19}{21}.
\]

All four costs are below one:

\[
\boxed{
\{A,B,C\}
\subsetneq
\{A,B,C,D\}.
}
\]

### Counterfactual ordering

Attempt the same \(D\) acquisition directly from the baseline.

The inherited \(A\) cost becomes

\[
\frac35\cdot\frac{19}{10}
=
\frac{57}{50}
>
1,
\]

while the new \(D\) cost is

\[
\frac{1/2}{9/19}
=
\frac{19}{18}
>
1.
\]

So the second click attempted first both loses inherited \(A\) and fails to acquire \(D\).

Therefore:

\[
\boxed{
\text{click 1 changes the resource state so that click 2 becomes possible}.
}
\]

The Lean formalization checks the thresholded cost profiles with exact rational arithmetic. Capabilities absent at the baseline are represented in that real-valued formal specialization by arbitrary costs above budget rather than \(+\infty\); this does not change the accessibility verdict. The closed-form network equilibrium supplying the rational costs remains the model from the parent paper rather than a formalized ODE theorem.

---

## 10. Strict domination is the strongest winding case, not the generic case

The two-click witness above winds the margin without lowering every inherited cost: \(A\) becomes cheaper but \(B\) becomes more expensive while remaining within budget.

A separate productive extension demonstrates the stronger case.

For the non-substituting extension family, choose

\[
f=\frac1{100},
\qquad
v=44,
\]

so

\[
\lambda=\frac65,
\qquad
X=\frac76.
\]

The inherited costs become

\[
c(A)=\frac{663}{1400}
<
\frac35,
\]

\[
c(B)=\frac{1989}{7000}
<
\frac3{10}.
\]

Thus every inherited cost falls.

This exact rational cost-domination witness is machine checked.

The lesson is not that cost domination is impossible. It is that cumulative accessibility does not require it.

---

## 11. Shared budgets break naive graph monotonicity

At graph level, adding a route or lowering an independent edge weight cannot worsen a shortest path.

That statement does not automatically descend to a resource-limited realization.

When processes share a limiting budget, changing one allocation can improve one capability and worsen another. In the worked \(B(f,v)\) family with \(v=2\), increasing \(f\) raises the spectral radius and lowers the equilibrium resource requirement, yet eventually drives capability \(B\) outside its budget.

Therefore:

\[
\boxed{
\text{graph extension}
\not\Rightarrow
\text{realized accessibility extension}.
}
\]

Pointwise route dominance remains a valid strong sufficient condition in separable settings, and its transitivity is formally useful. It should not be treated as the generic mechanism of cumulative evolution under shared resources.

The six candidate acquisition mechanisms discussed in the parent framework—new process, recombination, horizontal transfer, symbiosis, cross-scale bridge, and efficiency change—must each be evaluated in the realized resource accounting of the application.

Under a shared limiting resource, an extension generally imposes an opportunity cost on existing organization. In the uniform-dilution topology that opportunity cost is represented exactly by \(\kappa\). Other topologies need their own accounting.

---

## 12. Repeated non-returning loads

Suppose a fixed declared repertoire experiences a sequence of purely non-returning uniform loads \(\kappa_i\).

The inherited binding cost is multiplied by

\[
\prod_{i=1}^{n}(1+\kappa_i).
\]

Retention requires

\[
\boxed{
\prod_{i=1}^{n}(1+\kappa_i)
\le
1+M_0.
}
\]

If every accepted load has a positive lower bound

\[
\kappa_i\ge\kappa_{\min}>0,
\]

then

\[
(1+\kappa_{\min})^n
\le
1+M_0,
\]

so

\[
\boxed{
n
\le
\frac{\log(1+M_0)}
{\log(1+\kappa_{\min})}.
}
\]

This is a **maximum load-ladder bound on a fixed declared repertoire**.

It is not a universal bound on the number of future capability acquisitions. A newly acquired capability may join the declaration and become binding earlier.

Nor does finite margin alone imply a finite number of accepted loads when arbitrarily small \(\kappa_i\) are permitted. An infinite sequence of vanishing loads can satisfy the product bound. In that regime the remaining margin can tend toward zero while admissible future loads become correspondingly small.

This is conceptually consistent with the fixed-resolution no-go result: fixed-sized or fixed-resolution increments are finitely bounded under finite resources, whereas indefinite continuation requires vanishing increments or some mechanism that replenishes capacity.

---

## 13. Log-slack and the filtered candidate process

The margin identity gives a useful final change of variables.

Define

\[
\boxed{
W_t=\log(1+M_t).
}
\]

For a candidate whose multiplicative change in binding cost is

\[
r_t=\frac{c_{t+1}^\star}{c_t^\star},
\]

the verified identity

\[
1+M_{t+1}
=
\frac{1+M_t}{r_t}
\]

becomes, for an accepted candidate,

\[
\boxed{
W_{t+1}
=
W_t-\log r_t.
}
\]

Retention requires

\[
r_t\le1+M_t,
\]

equivalently

\[
\boxed{
\log r_t\le W_t.
}
\]

Thus candidate acceptance is a state-dependent filter on a multiplicative process.

Let

\[
Y_t=\log r_t.
\]

If a candidate that violates retention is rejected without changing the current organization, the one-dimensional update is

\[
\boxed{
W_{t+1}
=
\begin{cases}
W_t-Y_{t+1}, & Y_{t+1}\le W_t,\\
W_t, & Y_{t+1}>W_t.
\end{cases}
}
\]

This is not an ordinary unconstrained random walk. The increment law is filtered by the current slack.

### Proposition 3 — geometric-mean criterion for linear self-propagation

Assume, as a deliberately simplified forward model, that the candidate log-multipliers

\[
Y_1,Y_2,\ldots
\]

are i.i.d. with

\[
\mathbb E|Y_1|<\infty
\]

and are drawn from a state-independent candidate pool.

Write

\[
\mu=\mathbb E[Y_1]=\mathbb E[\log r].
\]

Define **linear self-propagation** to mean positive asymptotic growth of log-slack,

\[
\liminf_{n\to\infty}\frac{W_n}{n}>0.
\]

Then

\[
\boxed{
\mu<0
}
\]

is exactly the condition for linear self-propagation in this filtered model, and in that regime

\[
\boxed{
\frac{W_n}{n}\longrightarrow-\mu
\qquad\text{almost surely}.
}
\]

Equivalently, the geometric mean multiplier satisfies

\[
\boxed{
\exp(\mathbb E[\log r])<1.
}
\]

The arithmetic mean \(\mathbb E[r]\) is not the relevant multiplicative criterion.

#### Proof sketch

For every candidate,

\[
W_{n+1}-W_n
=
-Y_{n+1}\mathbf 1_{\{Y_{n+1}\le W_n\}}.
\]

When a candidate is rejected, \(Y_{n+1}>W_n\ge0\), so replacing the rejected update by the unconstrained increment \(-Y_{n+1}\) could only make the state smaller. Hence pathwise

\[
W_n
\ge
W_0-\sum_{i=1}^{n}Y_i.
\]

If \(\mu<0\), the strong law of large numbers gives a positive linear lower bound on \(W_n\). A rejection at sufficiently large \(n\) then requires \(Y_n\) itself to exceed a linearly growing threshold. Integrability of \(Y^+\) makes the corresponding tail probabilities summable; Borel--Cantelli therefore implies only finitely many rejections. After that random finite time every candidate is accepted, and the strong law gives

\[
W_n/n\to-\mu.
\]

Conversely, if \(W_n\) had a positive linear lower growth rate while \(\mu\ge0\), the same tail argument would again make rejections eventually finite, after which the strong law would force asymptotic rate \(-\mu\le0\), a contradiction.

So the logarithm turns the multiplicative winding/spending problem into an additive long-run criterion.

### The positive-mean regime is filtered, not collapsed

The case

\[
\mu>0
\]

does **not** imply that slack simply goes to zero or that only \(r<1\) candidates are eventually accepted.

At state \(W=w\), the conditional mean increment is

\[
\boxed{
d(w)
=
-\mathbb E\!\left[
Y\,\mathbf 1_{\{Y\le w\}}
\right].
}
\]

If the candidate law is continuous, has finite first moment, and assigns positive probability to winding candidates \(Y<0\), then

\[
d(0)>0,
\]

whereas

\[
d(w)\longrightarrow-\mu<0
\qquad
(w\to\infty).
\]

Hence the drift changes sign at at least one finite slack level. This supplies a genuine negative-feedback mechanism: low slack preferentially filters out expensive candidates, while high slack admits enough spending candidates to push the expected drift back downward.

This drift argument does **not** by itself prove a unique stationary distribution, its acceptance rate, or a universal closed form for the pinned regime. Those remain separate stochastic questions.

In particular, the asymptotic acceptance probability is not generally

\[
P(Y\le0).
\]

At positive slack, some spending candidates with

\[
0<Y\le W
\]

remain admissible. If a stationary law \(\pi\) exists, the stationary acceptance fraction would instead be

\[
\mathbb E_\pi[F_Y(W)],
\]

not simply \(F_Y(0)\).

A Gaussian simulation supplied during development illustrates this point. For \(\mu=0.30,\sigma=0.5\), the simulated tail acceptance fraction is about \(0.548\), while \(P(Y\le0)\approx0.274\); for \(\mu=0.80,\sigma=0.5\), the corresponding values are about \(0.109\) and \(0.0548\). The near factor of two observed for symmetric laws is not universal and is not used as a theorem.

### Endogenous candidate generation remains the open recursion

The i.i.d. model above holds the candidate law fixed in order to isolate the effect of the retention filter.

The more general organizational problem remains

\[
Q_s,
\]

the candidate distribution generated by the current organization itself.

If candidates arise at rate \(\nu(s)\), and \(\mathcal C(s)\) denotes candidates that both preserve the declared inherited repertoire and add at least one newly accessible target, then

\[
\boxed{
\lambda(s)
=
\nu(s)\,
Q_s\!\left(\mathcal C(s)\right).
}
\]

A successful click changes \(s\), the slack \(W\), and potentially \(Q_s\) itself.

This separates two recursive effects:

1. **budget filtering** — current slack determines which candidates can be retained;
2. **evolvability change** — current organization determines which candidates are generated.

The first now has an exact state variable and a long-run criterion in the fixed-pool model. The second remains the unresolved step toward a general dynamics of cumulative evolution.

---

## 14. Closest external antecedent

A particularly close external precedent is Peng, Linderoth, Blum and Baum (2022), *The hierarchical organization of autocatalytic reaction networks and its relevance to the origin of life* (PLOS Computational Biology 18:e1010498; doi:10.1371/journal.pcbi.1010498).

Their seed-dependent autocatalytic systems can form trophic tiers in which higher-tier systems become seedable by relatively simple chemicals once lower tiers have already been activated. That is already a positive demonstration that realized lower-level organization can make later organization reachable.

The present result should therefore not be framed as discovering sequential accessibility itself.

Its narrower contribution is to ask what is required for such sequential accessibility to count as a **retained, resource-feasible ratchet**:

- which earlier capabilities must remain accessible;
- how shared resource use can make extension partly substitutive;
- when the inherited repertoire remains inside budget;
- how much slack remains after a click;
- and whether the earlier click opens a later acquisition region that was previously unaffordable.

That distinction is important for positioning. Sequential enablement is established in prior work; the budgeted-retention condition developed here is the proposed addition.

---

## 15. Relation to the larger framework

The result now sits in a sequence.

\[
\boxed{
\begin{aligned}
\text{continuous turnover}
&\rightarrow
\text{self-maintenance}\\
&\rightarrow
\text{declared function}\\
&\rightarrow
\text{functional maintenance}\\
&\rightarrow
\text{declared accessibility}\\
&\rightarrow
\text{retention}\\
&\rightarrow
\text{strict click}\\
&\rightarrow
\text{changed future affordability}.
\end{aligned}
}
\]

The preceding papers establish different boundaries in this chain.

- *Organizational Accessibility* defines how history can change future reachability.
- *Organizational Depth at Finite Time* limits fixed-resolution organizational depth under finite resources.
- *Persistence Does Not Measure Function* separates persistence from an independently declared functional verdict.
- *When Does Regulation Pay?* separates selected control from sufficient control and gives the exact marginal condition for alignment.
- The present paper separates novelty from retained cumulative accessibility and supplies a positive two-click existence result.

The new point is therefore not that organization always moves forward.

It is:

\[
\boxed{
\text{retained organization can change the affordability of later organization}.
}
\]

That statement is conditional, quantitative, and falsifiable.

---

## 16. What is and is not secured

### Secured

Under the explicit definitions and assumptions:

- preservation and strict accessibility expansion are composable;
- the verdict is relative to a declared target family;
- pointwise score or cost domination is sufficient but not necessary for retention;
- productive strict cost domination is possible;
- uniform positive dilution cannot satisfy pointwise cost domination;
- under uniform dilution, declared-set retention holds exactly when
  \[
  \kappa\le M_t;
  \]
- winding and spending are captured by the binding-cost ratio;
- a margin increase creates a nonempty interval of newly affordable future loads;
- a production increase creates a nonempty interval of newly accessible module thresholds;
- an exact two-click accessibility sequence exists;
- the second click in that witness is unavailable at the baseline;
- repeated fixed-minimum non-returning loads have a finite load-ladder bound;
- in the i.i.d. fixed candidate-pool model, negative mean log-multiplier (mathbb E[log r]<0) is the criterion for positive linear log-slack growth, with (W_n/n	o-mathbb E[log r]) almost surely under the stated integrability assumptions.

### Not secured

The paper does not establish that:

- any real biological, institutional, chemical, or technological system satisfies these hypotheses;
- a unique target family or declaration is supplied by the dynamics;
- cost accessibility is generally equivalent to finite-horizon stochastic accessibility;
- every productive acquisition winds the ratchet;
- every extension is a uniform-dilution load;
- every ratchet click is historically caused by retained organization without an intervention analysis;
- evolution has a universal direction;
- complexity grows monotonically;
- an unbounded number of fixed-resolution clicks can occur in finite physical time;
- the candidate-generating process \(Q_s\) necessarily evolves toward a higher probability of winding clicks.

---

## 17. Conclusion

The original question was why continuously changing reality can nevertheless exhibit cumulative organization.

The answer supported here is narrower than a universal evolutionary arrow.

A cumulative ratchet requires a declared repertoire that is carried forward. In a resource-limited system, carrying it forward does not mean that every old capability becomes cheaper. It means that the old repertoire remains on the affordable side of its boundary.

The binding slack

\[
M_t
=
\frac{B}{c_t^\star}-1
\]

then measures how much additional one-way load that repertoire can tolerate.

Some clicks spend that slack.

Some clicks wind it.

And a winding click does something more consequential than merely improve the current state:

\[
\boxed{
M_{t+1}>M_t
\quad\Longrightarrow\quad
\text{some later acquisitions become possible that were impossible before}.
}
\]

The exact two-click network witness shows this can happen in the model.

So the ratchet is not a drive toward complexity. It is a conditional memory mechanism: retained organization can preserve what has already become reachable and alter the budget from which subsequent organization is built.

For a fixed i.i.d. candidate pool, that question now has a partial answer. In log-slack coordinates,

[
W_t=log(1+M_t),
]

multiplicative binding-cost changes become additive, and positive linear slack accumulation occurs exactly when

[
oxed{
mathbb E[log r]<0.
}
]

The remaining forward question is therefore narrower:

> **Under what conditions does the organization change its own candidate-generating process (Q_s) so that winding-enough, retainable, capability-adding candidates continue to be produced?**

That is the point at which a budgeted ratchet becomes an endogenous dynamics of cumulative evolution.
