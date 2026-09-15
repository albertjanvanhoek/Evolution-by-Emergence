# When Does Maintenance Debt Stabilize?

## Exact thresholds in a slow-fast feedback system

### Abstract

Self-maintaining systems can become dynamically unstable when the consequences of under-maintenance are visible only after a lag. A system may reduce costly maintenance while accumulated capacity remains high, discover the resulting deficit only after retained capacity has begun to fall, then over-correct once deterioration becomes visible. We study a minimal three-state system in which maintenance behavior \(x\) produces a retained stock \(K\), while the state \(h\) that enters behavioral incentives follows that stock with its own response rate:
\[
\dot x=x(1-x)[\alpha(1-h)-c],\qquad
\dot K=ax-\delta K,\qquad
\dot h=\varepsilon(K-h).
\]
The interior equilibrium is
\[
h^*=K^*=1-\frac{c}{\alpha},\qquad
x^*=\frac{\delta}{a}\left(1-\frac{c}{\alpha}\right).
\]
Writing \(b=x^*(1-x^*)\), the base equilibrium is Hurwitz exactly when
\[
\delta(\delta+\varepsilon)>a\alpha b.
\]
At equality the characteristic polynomial factorizes as
\[
(\lambda+\delta+\varepsilon)(\lambda^2+\delta\varepsilon),
\]
placing a conjugate pair on the imaginary axis.

We define maintenance debt as the current replacement shortfall
\[
D=\delta K-ax=-\dot K.
\]
Positive \(D\) means retained capacity is already declining even when visible state remains high. Adding debt-sensitive behavior,
\[
\dot x=x(1-x)[\alpha(1-h)-c+\gamma(\delta K-ax)],
\]
changes the local stability condition to
\[
(\delta+\varepsilon+ab\gamma)(\delta+ab\gamma)>a\alpha b.
\]
This gives the exact threshold
\[
\boxed{
\gamma_{\rm crit}
=
\frac{
\frac12\left(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon\right)-\delta
}{ab}.
}
\]
For nonnegative \(\gamma\), once the Hurwitz inequality holds, increasing \(\gamma\) cannot reverse it within this model.

The base system also has an exact periodic accounting result. Every differentiable interior periodic orbit satisfies
\[
\langle h\rangle=\langle K\rangle=1-\frac{c}{\alpha},
\qquad
\langle x\rangle=\frac{\delta}{a}\left(1-\frac{c}{\alpha}\right),
\]
and therefore \(\langle D\rangle=0\). Large oscillations can thus contain repeated episodes of under-maintenance and over-correction without constituting cumulative drift.

The model-specific derivation is machine checked in Lean 4 with pinned Mathlib. The formalization differentiates the nonlinear vector field, verifies the Jacobian, calculates the characteristic determinant, proves the required cubic root-location theorem directly over \(\mathbb C\), derives the critical gain, and derives the periodic averages from the ODE using the fundamental theorem of calculus. The remaining external bridge is the standard nonlinear linearization theorem from a Hurwitz Jacobian to local asymptotic stability.

The contribution is not the discovery that behavior-environment feedback can oscillate; that is established in evolutionary-game and eco-evolutionary models. The contribution is the explicit distinction between visible state and replacement balance, the exact debt-response threshold, the zero-mean cycle accounting result, and an end-to-end machine-checked model-to-spectrum derivation.

---

## 1. Successful maintenance can hide the need for maintenance

A maintained state is evidence of past successful maintenance. It is not necessarily evidence that current replacement is sufficient.

If maintenance is costly, a high visible state can reduce the incentive to maintain. The retained stock does not disappear immediately when maintenance falls. It must first decline, and a visible or perceived state can lag even further behind. By the time deterioration becomes visible, the system can already have accumulated a replacement shortfall.

The mechanism is

\[
\boxed{
\text{successful maintenance}
\rightarrow
\text{high visible state}
\rightarrow
\text{less maintenance}
\rightarrow
\text{hidden stock decline}
\rightarrow
\text{visible deterioration}
\rightarrow
\text{renewed maintenance}.
}
\]

This sequence can describe different substrates without implying that their causal mechanisms are identical. Infrastructure can remain usable while replacement is deferred. Institutional competence can erode before output collapses. Biological stores can buffer inadequate replacement before function falls.

The public-health prevention literature contains an analogous informational problem: successful prevention can make the avoided burden less visible, and individual observation need not reveal the population-level causes that keep incidence low (Rose, 1981, 1985). We use this only as an analogy, not as a mathematical antecedent.

The question here is narrower:

> Can a system be destabilized because behavior reacts to maintained state rather than to current replacement balance, and can direct sensitivity to that balance restore stability?

---

## 2. Relation to environmental-feedback dynamics

Behavior-environment feedback is established. Weitz et al. (2016) showed that replicator dynamics coupled to an environmental variable can generate an oscillating tragedy of the commons. Tilman, Plotkin and Akçay (2020) generalized evolutionary games with environmental feedback. Ito and Yamamichi (2024) provided a broader classification with bistability and persistent oscillations across several game structures.

The present paper therefore does not claim that oscillatory environmental feedback is new.

Its narrower distinction is between:

1. a retained stock \(K\);
2. a visible state \(h\) that follows that stock;
3. the instantaneous replacement balance of the stock.

The stock can still be high while
\[
ax-\delta K<0.
\]
The state has not yet failed, but it is already shrinking.

This motivates
\[
\boxed{D=\delta K-ax.}
\]

The main comparison is

\[
\boxed{
\text{responding to current visible state}
\quad\text{versus}\quad
\text{responding to whether the retained state is currently being replaced}.
}
\]

---

## 3. Minimal maintenance model

Let \(x(t)\in[0,1]\) denote maintenance behavior, \(K(t)\ge0\) retained capacity, and \(h(t)\) the state entering behavioral incentives. The base model is

\[
\boxed{\dot x=x(1-x)[\alpha(1-h)-c],}
\tag{1}
\]

\[
\boxed{\dot K=ax-\delta K,}
\tag{2}
\]

\[
\boxed{\dot h=\varepsilon(K-h).}
\tag{3}
\]

We take
\[
\alpha,a,\delta,\varepsilon>0.
\]

Here \(\alpha\) is behavioral response to visible shortfall, \(c\) is the direct cost of maintenance, \(a\) converts maintenance into retained stock, \(\delta\) is turnover, and \(\varepsilon\) is the rate at which visible state follows stock.

The terms fast and slow are relational. No variable is assumed to be permanently fast or slow across all regimes.

---

## 4. Interior equilibrium

For \(0<x^*<1\), equation (1) requires
\[
\alpha(1-h^*)-c=0.
\]
Thus
\[
h^*=1-\frac{c}{\alpha}.
\]

Equations (2) and (3) then give
\[
\boxed{
K^*=h^*=1-\frac{c}{\alpha},
}
\tag{4}
\]
and
\[
\boxed{
x^*=\frac{\delta}{a}\left(1-\frac{c}{\alpha}\right).
}
\tag{5}
\]

The interior regime requires \(0<x^*<1\). Define
\[
\boxed{b=x^*(1-x^*)>0.}
\tag{6}
\]

---

## 5. Base spectral stability

At the interior equilibrium,
\[
J_0=
\begin{pmatrix}
0&0&-\alpha b\\
a&-\delta&0\\
0&\varepsilon&-\varepsilon
\end{pmatrix}.
\]

The characteristic polynomial is
\[
\boxed{
p_0(\lambda)
=
\lambda^3+(\delta+\varepsilon)\lambda^2
+\delta\varepsilon\lambda
+a\alpha b\varepsilon.
}
\tag{7}
\]

For positive coefficients, the cubic Hurwitz condition reduces to
\[
(\delta+\varepsilon)\delta\varepsilon>a\alpha b\varepsilon,
\]
or
\[
\boxed{
\delta(\delta+\varepsilon)>a\alpha b.
}
\tag{8}
\]

At equality,
\[
\delta(\delta+\varepsilon)=a\alpha b,
\]
and
\[
\boxed{
p_0(\lambda)
=
(\lambda+\delta+\varepsilon)(\lambda^2+\delta\varepsilon).
}
\tag{9}
\]

The roots are
\[
-(\delta+\varepsilon),\qquad
\pm i\sqrt{\delta\varepsilon}.
\]

Equation (9) is a spectral Hopf boundary. A full nonlinear Hopf bifurcation additionally requires the usual transversality and nondegeneracy conditions; we do not infer those from the factorization alone.

The linear oscillation period at the boundary is
\[
\boxed{
T_{\rm lin}=\frac{2\pi}{\sqrt{\delta\varepsilon}}.
}
\tag{10}
\]

---

## 6. Exact cycle averages

For any differentiable interior periodic orbit of period \(T\), define
\[
L(t)=\log x(t)-\log(1-x(t)).
\]
Equation (1) gives
\[
\frac{dL}{dt}=\alpha(1-h)-c.
\]
Periodicity therefore implies
\[
0=\int_0^T[\alpha(1-h)-c]\,dt,
\]
so
\[
\boxed{
\langle h\rangle=1-\frac{c}{\alpha}.
}
\tag{11}
\]

Integrating equation (3) over a period gives
\[
\boxed{
\langle K\rangle=\langle h\rangle.
}
\tag{12}
\]

Integrating equation (2) gives
\[
\boxed{
\langle x\rangle
=
\frac{\delta}{a}
\left(1-\frac{c}{\alpha}\right).
}
\tag{13}
\]

Thus the cycle averages equal the equilibrium coordinates.

Now define
\[
\boxed{
D(t)=\delta K(t)-ax(t).
}
\tag{14}
\]

Because
\[
\dot K=ax-\delta K,
\]
we have
\[
\boxed{D=-\dot K.}
\tag{15}
\]

Hence every periodic orbit covered above satisfies
\[
\boxed{\langle D\rangle=0.}
\tag{16}
\]

This gives a useful negative control for cumulative-change claims:

\[
\boxed{
\text{large excursions}
\neq
\text{cumulative change}.
}
\]

A cycle can be dynamically dangerous if temporary excursions cross irreversible thresholds, but that requires an additional mechanism.

---

## 7. Debt-aware behavior

Positive \(D\) means replacement is below current loss: the retained stock is already declining. We add a response to that signal:

\[
\boxed{
\dot x=
x(1-x)
[\alpha(1-h)-c+\gamma(\delta K-ax)],
}
\tag{17}
\]
with
\[
\gamma\ge0.
\]

The debt term is not a forecast of an unknown future. It is current flow information. Its temporal advantage is that it can change before the retained stock has become low and before the visible state has followed.

At equilibrium,
\[
\delta K^*-ax^*=0,
\]
so the debt term vanishes and the equilibrium location remains (4)-(5).

---

## 8. Debt-aware Jacobian

At the interior equilibrium, the nonlinear vector field has Jacobian

\[
\boxed{
J_\gamma=
\begin{pmatrix}
-a\gamma b&\delta\gamma b&-\alpha b\\
a&-\delta&0\\
0&\varepsilon&-\varepsilon
\end{pmatrix}.
}
\tag{18}
\]

The characteristic polynomial is

\[
\boxed{
p_\gamma(\lambda)
=
\lambda^3
+(\delta+\varepsilon+ab\gamma)\lambda^2
+(\delta\varepsilon+ab\varepsilon\gamma)\lambda
+a\alpha b\varepsilon.
}
\tag{19}
\]

Let
\[
y=\delta+ab\gamma.
\]
Then the Hurwitz inequality is

\[
\boxed{
y(y+\varepsilon)>a\alpha b.
}
\tag{20}
\]

---

## 9. Exact critical debt sensitivity

The equality boundary of (20) is
\[
y^2+\varepsilon y-a\alpha b=0.
\]
The nonnegative root is
\[
\boxed{
y_{\rm crit}
=
\frac{\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon}{2}.
}
\tag{21}
\]

Therefore
\[
\boxed{
\gamma_{\rm crit}
=
\frac{
\frac12(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon)-\delta
}{ab}.
}
\tag{22}
\]

If the base system already satisfies (8), then \(\gamma_{\rm crit}<0\) and no positive debt response is required for Hurwitz stability.

If
\[
\delta(\delta+\varepsilon)<a\alpha b,
\]
then \(\gamma_{\rm crit}>0\), and
\[
\boxed{
\gamma>\gamma_{\rm crit}
}
\tag{23}
\]
places every characteristic root in the open left half-plane.

Moreover,
\[
(\delta+ab\gamma)(\delta+\varepsilon+ab\gamma)
\]
is increasing in nonnegative \(\gamma\). Thus, within this model,

\[
\boxed{
\text{once debt response satisfies the Hurwitz criterion,
more of the same response does not undo it.}
}
\tag{24}
\]

This monotonicity is not asserted for delayed, noisy, saturating, or costly debt sensing.

---

## 10. Worked example

Take
\[
\alpha=1,\quad c=0.2,\quad a=1,\quad
\delta=\varepsilon=0.2.
\]

Then
\[
h^*=K^*=0.8,
\qquad
x^*=0.16,
\qquad
b=0.1344.
\]

The base stability side is
\[
\delta(\delta+\varepsilon)=0.08,
\]
while
\[
a\alpha b=0.1344.
\]
The base equilibrium is therefore not Hurwitz.

The critical root is
\[
y_{\rm crit}
=
\frac{\sqrt{0.04+0.5376}-0.2}{2}
=
0.28.
\]

Hence
\[
\boxed{
\gamma_{\rm crit}
=
\frac{0.28-0.2}{0.1344}
=
0.595238\ldots
}
\]

At \(\gamma=0\), the eigenvalues are approximately
\[
0.02280\pm0.24455\,i,\qquad -0.44561.
\]

At \(\gamma=0.6\), just above the exact threshold, they are approximately
\[
-0.000170\pm0.23657\,i,\qquad -0.48030.
\]

The example illustrates the threshold; it is not a fitted empirical model.

---

## 11. Why retaining both \(K\) and \(h\) matters

A previous two-state attempt with linearly relaxing visible state damped rather than sustained the desired oscillation. Merely renaming the environment variable as a stock does not create a new degree of freedom.

The minimal architecture used here retains both:
\[
x\rightarrow K\rightarrow h\rightarrow x.
\]

This does not mean that three variables are universally necessary for oscillation. Two-dimensional nonlinear systems can cycle, and environmental-feedback game models already provide examples. The narrower point is that in this linear stock-and-observation architecture, separating retained stock from visible state creates the lag structure of interest and makes the replacement balance \(D\) definable.

---

## 12. Fast and slow are relational

The stock turnover scale is approximately
\[
\tau_K\sim\frac1\delta,
\]
and visible-state adjustment has scale
\[
\tau_h\sim\frac1\varepsilon.
\]

Behavioral response depends on \(\alpha\), the local replicator factor \(b\), and the debt gain.

Nothing fixes one variable permanently as fast or slow. Timescales can themselves change through evolution, technology, organization, or intervention.

The exact inequality
\[
(\delta+\varepsilon+ab\gamma)(\delta+ab\gamma)>a\alpha b
\]
is therefore preferable to the slogan that slow feedback causes cycles. It shows which rates are competing.

---

## 13. Machine-checked derivation

The model-specific mathematical chain is formalized in Lean 4 using pinned Mathlib.

The relevant files are

- verification/organizational-depth/MaintenanceDynamics.lean
- verification/organizational-depth/MaintenanceDynamicsEndToEnd.lean

The formalization checks:

1. the equilibrium balance equations;
2. the derivatives of the nonlinear debt-aware vector field at equilibrium;
3. the Jacobian entries in (18);
4. the explicit characteristic determinant in (19);
5. a direct cubic theorem: for \(A,B,C>0\) and \(AB>C\), every complex root of \(z^3+Az^2+Bz+C\) has negative real part;
6. the exact quadratic root (21);
7. the implication \(\gamma>\gamma_{\rm crit}\Rightarrow\Re\lambda_i<0\);
8. monotonicity of the stability-side expression in \(\gamma\);
9. the periodic-average identities (11)-(13) from the base ODE using the fundamental theorem of calculus.

The cubic root-location theorem is proved directly rather than imported as an unchecked Routh-Hurwitz premise.

The axiom audit contains no sorryAx for the reported declarations.

### Formalization boundary

The machine-checked endpoint is spectral:

\[
\boxed{
\gamma>\gamma_{\rm crit}
\Rightarrow
\Re\lambda_i(J_\gamma)<0
\quad\forall i.
}
\]

The standard nonlinear linearization theorem then implies local asymptotic stability for a \(C^1\) autonomous vector field with a Hurwitz Jacobian. That generic theorem is not currently formalized in this repository. We therefore separate the machine-checked model-specific chain from this standard external theorem.

Lean 4 is described by de Moura and Ullrich (2021), and Mathlib by The mathlib Community (2020).

---

## 14. Empirical predictions

The model makes several testable predictions.

First, a replacement-balance signal should lead a lagged state signal. Periods should exist in which current performance remains acceptable while replacement input is already below turnover.

Second, holding model structure fixed, stronger sensitivity to the replacement shortfall should move the critical complex eigenpair leftward near the interior equilibrium.

Third, faster observation and debt awareness are distinct interventions. Increasing \(\varepsilon\) makes visible state follow stock faster; increasing \(\gamma\) responds to replacement imbalance directly.

Fourth, zero mean debt does not imply a harmless trajectory. If failure depends nonlinearly on peak debt, duration above a threshold, or irreversible damage, temporal arrangement matters even when \(\langle D\rangle=0\).

A useful empirical comparison is therefore between
\[
\langle D\rangle,\qquad
\max_t D(t),\qquad
\int D_+(t)\,dt
\]
and actual failure risk.

---

## 15. Relation to the companion papers

The companion paper When Does Regulation Pay? distinguishes selected regulation from sufficient regulation:
\[
\text{selected control}\neq\text{sufficient control}.
\]

The present paper asks a different question: what information enters the feedback? A controller can be responsive and still respond too late if it waits for visible failure.

The cumulative-change paper asks whether retained change expands future accessibility. Equation (16) provides a useful negative control. A periodic maintenance cycle can repeatedly move through deficit and surplus while having zero net maintenance debt. That is not yet a ratchet.

If a system retains a new sensing architecture that exposes \(D\) earlier and changes future reachable states, that could become a cumulative organizational change. The present model does not itself prove that evolutionary step.

---

## 16. Limits and non-claims

The model is deliberately minimal.

- \(x\) is scalar; real maintenance is multiplex.
- Debt sensing is instantaneous, noiseless, and costless.
- \(K\) and \(h\) are single aggregate states.
- The model does not derive the evolution or adoption of debt-sensitive control.
- The system is deterministic.
- Hurwitz stability is local, not global.
- The periodic-average theorem does not prove that a periodic orbit exists.
- The imaginary-axis crossing is not by itself a full nonlinear Hopf proof.
- Maintenance debt is a signed flow imbalance, not a moral category.
- Cross-domain reuse of the equations does not establish a shared causal mechanism.

---

## 17. Discussion

The core distinction is elementary:

\[
K>0\not\Rightarrow\dot K\ge0.
\]

A maintained stock can look healthy while moving in the wrong direction.

Once behavior responds to a lagged state, this difference becomes dynamical. Earlier successful maintenance can suppress current maintenance effort, which allows the stock to decline, which is only later reflected in visible state.

Maintenance debt adds a derivative-like signal:
\[
D=-\dot K.
\]

It does not predict the future by simulation. It reports whether the system is currently reproducing the stock on which its future condition depends.

The exact threshold sharpens the claim. The relevant balance is not simply fast versus slow; it is
\[
\gamma_{\rm crit}
=
\frac{
\frac12(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon)-\delta
}{ab}.
\]

The result also shows why average accounting can mislead. Because every covered periodic orbit satisfies
\[
\langle D\rangle=0,
\]
a system can appear balanced in long-run averages while repeatedly passing through dangerous under-maintenance phases.

Thus

\[
\boxed{
\text{balanced average flow}
\not\Rightarrow
\text{safe trajectory}.
}
\]

---

## 18. Conclusion

A self-maintaining system can fail dynamically before it fails statically.

The minimal model distinguishes visible condition, retained stock, and current replacement balance. That distinction produces an exact signal:
\[
\boxed{D=\delta K-ax=-\dot K.}
\]

Adding sensitivity to \(D\) leaves the equilibrium location unchanged but changes the local dynamics. The exact spectral threshold is

\[
\boxed{
\gamma_{\rm crit}
=
\frac{
\frac12(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon)-\delta
}{ab}.
}
\]

Above this boundary, every characteristic root of the equilibrium Jacobian has negative real part under the stated assumptions.

Separately, every differentiable interior periodic orbit of the base system has
\[
\boxed{
\langle h\rangle=\langle K\rangle=h^*,\qquad
\langle x\rangle=x^*,\qquad
\langle D\rangle=0.
}
\]

The combined result separates three ideas:

\[
\boxed{
\text{current state}
\neq
\text{replacement balance}
\neq
\text{cumulative change}.
}
\]

A system can look healthy while entering debt. It can oscillate through debt while remaining balanced on average. And, in this minimal model, responding to replacement shortfall before visible failure arrives can move an unstable equilibrium across an exact stability boundary.

---

## Data and code availability

All source material is available in the public Evolution by Emergence repository. The Lean proof is under verification/organizational-depth. This paper package includes a claim ledger, literature-positioning note, reproducibility note, bibliography, and a small numerical verification script.

## AI collaboration

The manuscript and formalization were developed through iterative human-AI collaboration. Mathematical claims were repeatedly checked and then formalized in Lean. The author remains responsible for the modelling assumptions, scientific claims, literature positioning, and interpretation.
