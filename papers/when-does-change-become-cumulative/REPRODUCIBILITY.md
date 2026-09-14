# Reproducibility

## 1. Operational repertoire

Fix target family \(\mathscr U\), protocol \(\mathcal P\), horizon \(\tau\), establishment criterion, and threshold \(p_\star\).

\[
\mathcal R_t
=
\{U\in\mathscr U:
\mathcal H_\tau(U\mid s_t,\mathcal P)\ge p_\star\}.
\]

Preservation:

\[
\mathcal R_t\subseteq\mathcal R_{t+1}.
\]

Strict click:

\[
\mathcal R_t\subsetneq\mathcal R_{t+1}.
\]

Historical attribution is separate and uses the intervention criterion of the parent Organizational Accessibility framework.

## 2. Cost specialization

For effective cost \(c_t(x)\) and common budget \(B\),

\[
\mathcal F_t(B)=\{x:c_t(x)\le B\}.
\]

Pointwise cost domination is

\[
c_{t+1}(x)\le c_t(x)
\quad\forall x,
\]

and is sufficient but not necessary for budget retention.

## 3. Uniform-dilution theorem

Fix a declared inherited set and let \(c_t^\star\) be its attained binding cost among currently budget-feasible declared capabilities.

Define

\[
M_t=\frac{B}{c_t^\star}-1.
\]

If a one-way non-returning load multiplies inherited costs by \(1+\kappa\), then

\[
\boxed{
\text{retention}\iff \kappa\le M_t.
}
\]

The Lean theorem is retainsCostOn_scaled_iff_margin.

## 4. Margin dynamics

For positive budget and binding costs,

\[
\boxed{
\frac{1+M_{t+1}}{1+M_t}
=
\frac{c_t^\star}{c_{t+1}^\star}.
}
\]

For a realized one-step dilution multiplier

\[
r_t=1+\kappa_t^{\rm eff},
\]

\[
\boxed{
M_{t+1}
=
\frac{M_t-\kappa_t^{\rm eff}}
{1+\kappa_t^{\rm eff}}.
}
\]

Here \(\kappa_t^{\rm eff}=r_t-1\) is the **current-state effective load**. It need not equal a topology-independent intrinsic module parameter.

The identity does not by itself imply finite-step exhaustion if accepted effective loads can become arbitrarily small.

## 5. General two-click region

If

\[
M_1>M_0\ge0,
\]

then the interval

\[
(M_0,M_1]
\]

is nonempty. Every coupling in it is too expensive before the first click but affordable afterward.

If also

\[
X_1>X_0
\]

and \(\kappa>0\), then

\[
\left(
\frac{X_0\kappa}{1+\kappa},
\frac{X_1\kappa}{1+\kappa}
\right]
\]

is a nonempty interval of module thresholds inaccessible before and accessible after.

Both existence statements are machine checked.

## 6. Exact rational witness

Budget:

\[
B=1.
\]

Thresholds:

\[
\theta_A=3/10,\quad
\theta_B=3/20,\quad
\theta_C=1/10,\quad
\theta_D=1/2.
\]

Baseline:

\[
c_0(A)=3/5,\qquad
c_0(B)=3/10,
\]

with \(C,D\) inaccessible.

Productive click:

\[
f=11/25,\qquad
v=2,\qquad
\lambda=6/5,\qquad
X_1=7/6.
\]

Costs:

\[
c_1(A)=33/70,\quad
c_1(B)=99/196,\quad
c_1(C)=3/7.
\]

Thus

\[
M_0=2/3,\qquad
M_1=97/99.
\]

Second click:

\[
\kappa_D=9/10,\qquad
\theta_D=1/2.
\]

Costs:

\[
c_2(A)=627/700,
\]

\[
c_2(B)=1881/1960,
\]

\[
c_2(C)=57/70,
\]

\[
c_2(D)=19/21.
\]

Therefore

\[
\{A,B\}\subsetneq\{A,B,C\}\subsetneq\{A,B,C,D\}.
\]

Direct second-click counterfactual:

\[
c_{\rm direct}(A)=57/50>1,
\]

\[
c_{\rm direct}(D)=19/18>1.
\]

The Lean specialization uses finite real costs above budget for capabilities that are structurally absent at baseline; this is an accessibility-equivalent sentinel for the thresholded theorem, not a claim that the physical cost is finite.

## 7. Productive domination witness

The standard-library Python verifier reproduces the corrected numerical witness

\[
v=100,\quad f=0.01,
\]

for which

\[
c(A):0.60000\to0.39775,
\]

\[
c(B):0.30000\to0.28125.
\]

The Lean source additionally checks exact rational strict domination using

\[
f=1/100,\quad v=125,\quad \lambda=3/2,
\]

with

\[
c(A)=753/2000<3/5,
\]

\[
c(B)=2259/8000<3/10.
\]

The corresponding binding margin rises exactly from

\[
2/3
\]

to

\[
1247/753.
\]

The Lean theorem checks the exact cost and margin arithmetic; the closed-form production-network mapping is documented in the manuscript and remains inherited model algebra rather than a formalized matrix-eigenvalue theorem.

## 8. Repeated-load topology

### Sequential renormalization

If each load is defined relative to the currently remaining host,

\[
\prod_{i=1}^{n}(1+\kappa_i)\le1+M_0,
\]

and for \(\kappa_i\ge\kappa_{\min}>0\),

\[
n\le
\frac{\log(1+M_0)}
{\log(1+\kappa_{\min})}.
\]

### Simultaneous shared pool

If several one-way loads are present simultaneously and each satisfies

\[
R_i=H\kappa_i,
\]

then

\[
X^\star=H\left(1+\sum_i\kappa_i\right).
\]

Retention becomes

\[
\sum_i\kappa_i\le M_0,
\]

and for \(\kappa_i\ge\kappa_{\min}>0\),

\[
n\le\frac{M_0}{\kappa_{\min}}.
\]

The two formulas describe different topologies and must not be interchanged.


## 9. Log-slack filtered dynamics

Define

\[
W=\log(1+M),\qquad Y=\log r.
\]

The identity below is topology-free **given the realized multiplier** \(r=c_{t+1}^\star/c_t^\star\). The stochastic theorem that follows additionally assumes that realized \(Y\) values themselves are i.i.d. and state independent. That assumption must not be confused with i.i.d. intrinsic module loads.

If a candidate is accepted exactly when it preserves the current declared repertoire, then

\[
W_{n+1}
=
\begin{cases}
W_n-Y_{n+1}, & Y_{n+1}\le W_n,\\
W_n, & Y_{n+1}>W_n.
\end{cases}
\]

For an i.i.d. state-independent **realized-multiplier** pool with \(\mathbb E|Y|<\infty\), the manuscript proves analytically that

\[
\mathbb E[Y]<0
\]

is exactly the condition for positive linear log-slack growth, and then

\[
W_n/n\to-\mathbb E[Y]
\]

almost surely.

This analytical probability result is not formalized in Lean. The proof uses the pathwise inequality

\[
W_n\ge W_0-\sum_{i=1}^nY_i,
\]

the strong law of large numbers, integrability of the positive tail, and Borel--Cantelli.


For a simultaneous shared-pool process with intrinsic candidate loads \(\kappa_i\) and accumulated accepted load

\[
S_t=\sum_{i\le t}\kappa_i,
\]

the realized multiplier of a newly accepted load is

\[
\boxed{
r_t=
\frac{1+S_t+\kappa_{t+1}}
{1+S_t}.
}
\]

Thus even i.i.d. intrinsic \(\kappa_i\) induce state-dependent realized \(Y_t=\log r_t\). The i.i.d.-\(Y\) theorem therefore does not directly apply to that shared-pool model.

The shared-pool remaining allowance is

\[
L_t=M_0-S_t,
\]

and acceptance is

\[
\kappa_{t+1}\le L_t.
\]

With a positive minimum intrinsic load, accepted count is finite. If the candidate distribution has support arbitrarily close to zero, indefinitely many vanishing accepted loads are not excluded over an unbounded proposal horizon.

For positive mean, the manuscript uses the conditional-drift identity

\[
d(w)=-\mathbb E[Y\mathbf 1_{Y\le w}].
\]

Writing

\[
g(w)=\mathbb E[Y\mathbf 1_{Y\le w}],
\]

an absolutely continuous candidate law gives

\[
g'(w)=wf(w)\ge0
\qquad (w\ge0)
\]

where the derivative exists. If \(P(Y<0)>0\), \(\mathbb E[Y]>0\), and the density is positive on every nontrivial interval of \((0,\infty)\), then there is a unique zero \(w^\star\), with positive drift below and negative drift above.

This is a mean-drift equilibrium scale, not a proof of a stationary distribution. The paper does not identify \(w^\star\) with the stationary mean or acceptance rate.

The illustrative Gaussian simulation is:

    python papers/when-does-change-become-cumulative/verify_log_slack.py

It intentionally checks that the filtered acceptance fraction is not simply \(P(Y\le0)\).

## 10. Local reproduction

Lean:

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build

Budget-ratchet checks:

    python papers/when-does-change-become-cumulative/verify_budget_ratchet.py
    python papers/when-does-change-become-cumulative/verify_log_slack.py

Both scripts use only the Python standard library. The budget-ratchet script uses exact Fraction arithmetic for the two-click witness; the log-slack script is an illustrative simulation rather than a proof.

## 11. Formalization scope

CumulativeAccessibility.lean machine-checks:

- preservation/subset equivalence;
- strict expansion/proper-subset equivalence;
- preservation and strict-click composition;
- score dominance and threshold crossing;
- cost dominance and budget crossing;
- existence of strict pointwise cost domination;
- impossibility of cost domination under positive uniform dilution;
- margin nonnegativity;
- margin ratio;
- general multiplicative margin update;
- winding iff the positive binding-cost multiplier is below one;
- positivity after accepting a strict fraction of positive margin;
- monotonic contraction of the accepted candidate set as log-slack falls;
- zero-slack exclusion of strictly spending candidates;
- acceptance of winding candidates at every nonnegative log-slack;
- pure-dilution margin recursion;
- exact declared-set retention boundary;
- opened coupling window after margin increase;
- opened threshold window after production increase;
- exact two-click rational witness;
- direct second-click failure;
- exact winding and window inequalities;
- exact productive strict-domination cost witness;
- route-dominance reflexivity/transitivity and its sufficient implications.

It does not formalize:

- the full stochastic accessibility kernel;
- empirical causal identification;
- the production-network ODE/eigenvector derivation;
- the external declaration of target families;
- the SLLN/Borel--Cantelli log-slack theorem;
- a stationary law for the positive-mean filtered process;
- a directional theorem for the state-dependent candidate generator \(Q_s\).

## 12. Verification record

Current verified PR head:

    6c0e32cbd025b035b76365415d0f2f48d370c1ee

GitHub Actions run:

    34852545903

Result:

    Cumulative Accessibility Check: PASS
    lean: PASS
    budget-ratchet: PASS

The budget-ratchet job runs both:

    verify_budget_ratchet.py
    verify_log_slack.py

The Lean log reports no `sorryAx` dependency for the new shared-budget, margin-update, winding-equivalence, vanishing-load, margin-window, exact two-click, direct-counterfactual, or productive-domination theorems. Reported dependencies such as `propext`, `Classical.choice`, and `Quot.sound` are standard Mathlib/Lean axioms rather than unproved placeholders.
