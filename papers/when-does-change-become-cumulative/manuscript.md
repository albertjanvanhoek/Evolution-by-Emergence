# When Does Change Become Cumulative?

## A monotone accessibility criterion for retained organization

### Abstract

The organizational-accessibility framework asks how realized organization changes which persistent successor organizations can later be reached. Its existing causal criterion for cumulative organizational contribution is deliberately broad: retained historical structure contributes cumulatively when it causally increases access to a later target. That criterion does not require global monotonicity, and accessibility may widen, narrow, or redirect.

Here we ask a narrower question: **when can a sequence of changes be called a ratchet in the stronger sense that previously accessible organization is retained while new organization becomes accessible?**

Fix a declared family of target organizations, an evaluation protocol, a finite horizon, an establishment criterion, and an accessibility threshold. These choices induce a declared accessible set at each historical state. We define an **accessibility-preserving step** when the later accessible set contains the earlier one, and a **strict accessibility click** when containment is proper. This relation is reflexive and transitive; after quotienting states that induce the same accessible set, it is a partial order. Consequently, a chain of preserving steps cannot lose a previously registered click relative to its baseline, and any strict step makes the final state strictly more accessible than the baseline so long as all intervening steps preserve the declared accessibility set.

The definition is intentionally resolution- and protocol-specific. It does not imply that evolution generally preserves all capabilities, nor that complexity increases. A new capability acquired at the cost of an old one is novelty but not a strict monotone accessibility click under the declared target family. We provide two sufficient conditions. First, pointwise non-decrease of finite-horizon target hitting scores preserves every thresholded accessible set; if one target crosses threshold, the step is strict. Second, in a mechanism-level cost representation, pointwise non-increase of realization cost preserves every budget-feasible target set; if one target crosses the budget boundary, the step is strict. Cost is treated as a determinant of accessibility, not as a replacement for the probabilistic accessibility kernel.

The algebra of preservation, strict expansion, score dominance, cost dominance, and loss is machine checked in Lean. The result supplies a compositional building block for cumulative emergence: **retained organization produces a monotone ratchet only when the historical change preserves the declared accessible region while adding at least one newly accessible target.**

---

## 1. The question left open by organizational accessibility

The existing framework *Organizational Accessibility: From Self-Maintenance to Evolvability* starts from continuous turnover. Molecules, cells, organisms, institutions, machines, and computational processes can all lose constituent parts while preserving an organization of processes that continually recreates the conditions for continued activity.

Its central object is a finite-horizon accessibility kernel,

\[
\mathcal A_\tau(S\mid\theta,z,E,Q),
\]

together with target hitting probabilities

\[
\mathcal H_\tau(U\mid\theta,z,E,Q),
\]

where \(\theta\) is architecture, \(z\) realized dynamical state, \(E\) environment, and \(Q\) the designated variation process. The framework separates several routes through which history can matter: hysteretic retention, inherited adaptive extension, compositional accessibility through recombination or transfer, and changes to the variation process itself.

It also defines a causal criterion for **cumulative organizational contribution**: structure acquired earlier, retained through an intermediate organization, contributes cumulatively when an intervention on that retained structure causally changes access to a prespecified later target that was absent at the designated baseline.

That criterion is intentionally not a law of monotone progress. The same framework explicitly allows accessibility to narrow, redirect, or collapse.

The present note therefore asks a stronger and more specific question:

> **When does history not merely change accessibility, but preserve previously declared accessibility while adding new accessibility?**

This is the sense in which the word *ratchet* becomes mathematically compositional.

---

## 2. Declared accessibility is evaluated relative to a protocol

A claim of cumulative change is meaningless until the comparison is fixed.

Let \(\mathscr U\) be a declared family of target organizations or functions. Fix:

- a finite horizon \(\tau\);
- an establishment criterion for each target;
- an evaluation protocol \(\mathcal P\), including whatever environmental and candidate-generation conditions are to be held common for the comparison;
- and a threshold \(p_\star\in[0,1]\).

For historical state \(s_t=(\theta_t,z_t)\), let

\[
h_t(U)
=
\mathcal H_\tau(U\mid s_t,\mathcal P)
\]

denote the finite-horizon probability that target \(U\in\mathscr U\) satisfies the chosen establishment criterion under that common evaluation protocol.

Define the **declared accessible set**

\[
\boxed{
\mathcal R_t(p_\star;\mathscr U,\mathcal P)
=
\left\{
U\in\mathscr U:
h_t(U)\ge p_\star
\right\}.
}
\]

This derived set is not a replacement for the accessibility kernel. It is a thresholded summary used to ask a particular monotonicity question.

The target family, protocol, horizon, establishment criterion, and threshold are part of the claim. Changing them can change the ordering.

---

## 3. Accessibility preservation and a strict ratchet click

### Definition 1 — accessibility-preserving step

A historical step \(s_t\to s_{t+1}\) is **accessibility-preserving** relative to the declared comparison when

\[
\boxed{
\mathcal R_t
\subseteq
\mathcal R_{t+1}.
}
\]

Every target that met the declared accessibility criterion before the change still meets it afterward.

### Definition 2 — strict accessibility click

The step is a **strict accessibility click** when

\[
\boxed{
\mathcal R_t
\subsetneq
\mathcal R_{t+1}.
}
\]

Thus two conditions must hold:

1. no target already in the declared accessible set is lost;
2. at least one target not previously accessible crosses the declared criterion.

This is stronger than novelty. A system can acquire a new capacity while losing an old one. Such a change may be adaptive, transformative, or historically important, but it is not a strict monotone accessibility click under this definition.

### Proposition 1 — composition

Accessibility preservation is transitive. If

\[
\mathcal R_0\subseteq\mathcal R_1
\]

and

\[
\mathcal R_1\subseteq\mathcal R_2,
\]

then

\[
\boxed{
\mathcal R_0\subseteq\mathcal R_2.
}
\]

If either step is strict and the other preserves accessibility, then

\[
\boxed{
\mathcal R_0\subsetneq\mathcal R_2.
}
\]

Therefore a registered click cannot disappear relative to its earlier baseline so long as later steps continue to preserve the declared accessible set.

This is the minimal algebra of a cumulative ratchet.

### Preorder, not automatically a partial order

Define

\[
s\preceq_{\mathcal R}s'
\quad\Longleftrightarrow\quad
\mathcal R(s)\subseteq\mathcal R(s').
\]

This relation is reflexive and transitive, but need not be antisymmetric on physical or organizational states: two different architectures can induce exactly the same declared accessible set. It is therefore a **preorder** on states.

If states that induce the same declared accessible set are identified,

\[
s\sim s'
\quad\Longleftrightarrow\quad
\mathcal R(s)=\mathcal R(s'),
\]

the quotient carries the corresponding partial order.

This matters conceptually. Cumulative accessibility does not require material identity or architectural identity. Different implementations can occupy the same accessibility class.

---

## 4. A stronger sufficient condition: score dominance

Set inclusion at one threshold is the minimal ratchet criterion. A stronger condition is pointwise improvement of the target hitting scores.

Suppose

\[
\boxed{
h_{t+1}(U)\ge h_t(U)
\qquad
\text{for every }U\in\mathscr U.
}
\]

Then for every fixed threshold \(p_\star\),

\[
h_t(U)\ge p_\star
\Longrightarrow
h_{t+1}(U)\ge p_\star.
\]

Therefore

\[
\boxed{
\mathcal R_t(p_\star)
\subseteq
\mathcal R_{t+1}(p_\star)
}
\]

for every threshold.

If there exists a target \(U^\star\) such that

\[
h_t(U^\star)<p_\star
\]

but

\[
h_{t+1}(U^\star)\ge p_\star,
\]

then the step is strict at that threshold:

\[
\boxed{
\mathcal R_t(p_\star)
\subsetneq
\mathcal R_{t+1}(p_\star).
}
\]

Pointwise score dominance is sufficient, not necessary. A step can preserve the thresholded accessible set even while some probabilities decline, provided none crosses downward through the chosen threshold.

This distinction separates **robust improvement of accessibility scores** from **preservation at a declared operational resolution**.

---

## 5. A mechanism-level cost specialization

The organizational-accessibility framework explicitly distinguishes accessibility from mechanisms that determine it. Energetic cost, material cost, time, mutation probability, route length, and basin geometry may shape the kernel, but are not interchangeable definitions of accessibility.

Nevertheless, a cost representation is useful as a sufficient mechanism.

Let

\[
c_t(U)
\]

be a specified effective realization cost for target \(U\) from historical state \(s_t\), under a fixed modelling convention. Let \(B\) be a finite budget and define the **budget-feasible target set**

\[
\boxed{
\mathcal F_t(B)
=
\left\{
U\in\mathscr U:
c_t(U)\le B
\right\}.
}
\]

If retained organization changes the cost landscape so that

\[
\boxed{
c_{t+1}(U)\le c_t(U)
\qquad
\forall U\in\mathscr U,
}
\]

then

\[
\boxed{
\mathcal F_t(B)
\subseteq
\mathcal F_{t+1}(B)
}
\]

for every budget \(B\).

If, for some \(U^\star\),

\[
c_{t+1}(U^\star)\le B<c_t(U^\star),
\]

then

\[
\boxed{
\mathcal F_t(B)
\subsetneq
\mathcal F_{t+1}(B).
}
\]

Again, this is a sufficient mechanism-level result. To infer a change in the probabilistic accessibility kernel from a cost reduction, an application must additionally specify how effective cost changes candidate generation, establishment, or hitting probability.

---

## 6. Why a production web can create a click

The cost specialization gives a precise version of the intuition that retained organization changes the starting point of future search.

Suppose a target can be reached through production or transformation routes \(p\), each with cost \(C_t(p)\). Define

\[
c_t(U)
=
\inf_{p\in\mathcal P_t(U)} C_t(p),
\]

where \(\mathcal P_t(U)\) is the set of admissible routes to \(U\).

A sufficient route-preservation condition is:

1. every old route remains available after the change;
2. the cost of each retained old route does not increase.

Then the infimum over the later route set cannot exceed the earlier one:

\[
\boxed{
c_{t+1}(U)\le c_t(U).
}
\]

Adding a new route, recombining two retained modules, importing a module by horizontal transfer, integrating a symbiotic partner, or introducing a cross-scale bridge can therefore create a strict budget-level click when it opens a route below the chosen budget without making previously feasible declared targets infeasible.

This is the network interpretation of the sentence:

\[
\boxed{
\text{Successful previous organization becomes the starting point for the next search.}
}
\]

The claim is conditional. Reorganization can also delete routes, increase dependencies, or raise costs elsewhere. Such changes need not be ratchet clicks.

---

## 7. Novelty is not cumulative change

Consider a declared target family

\[
\mathscr U=\{A,B,C\}
\]

and threshold \(p_\star=0.5\).

At time \(t\), suppose

\[
h_t(A)=0.9,\qquad
h_t(B)=0.7,\qquad
h_t(C)=0.2.
\]

Then

\[
\mathcal R_t=\{A,B\}.
\]

### Click

If the later scores are

\[
h_{t+1}(A)=0.9,\qquad
h_{t+1}(B)=0.75,\qquad
h_{t+1}(C)=0.6,
\]

then

\[
\mathcal R_{t+1}=\{A,B,C\},
\]

and

\[
\mathcal R_t\subsetneq\mathcal R_{t+1}.
\]

This is a strict accessibility click.

### Novelty with loss

If instead

\[
h_{t+1}(A)=0.4,\qquad
h_{t+1}(B)=0.8,\qquad
h_{t+1}(C)=0.7,
\]

then

\[
\mathcal R_{t+1}=\{B,C\}.
\]

Target \(C\) is newly accessible, but \(A\) has been lost. Neither set contains the other.

This is historical change and novelty, but not a monotone accessibility ratchet.

That distinction is important for evolution. Specialization, dependency, streamlining, and tradeoffs can all generate new organization while closing old possibilities.

---

## 8. Relation to the broader cumulative-emergence criterion

The existing organizational-accessibility framework uses a broader causal definition.

A retained structure \(h\) contributes cumulatively when, under a defined intervention, retaining \(h\) causally increases access to a prespecified later target. That criterion can be satisfied even if some unrelated targets become less accessible.

The present definition asks for something stronger:

\[
\text{target-specific historical contribution}
\quad\not\Rightarrow\quad
\text{monotone accessible-set expansion}.
\]

We therefore distinguish:

### Weak cumulative contribution

A retained historical structure causally increases access to a designated later target.

### Strong monotone accessibility ratchet

Under a fixed declared target family and evaluation protocol,

\[
\mathcal R_t
\subsetneq
\mathcal R_{t+1}.
\]

The strong criterion is useful when the scientific claim is not merely that history mattered, but that reusable organization accumulated in a way that preserved the declared prior repertoire while extending it.

The weaker criterion remains appropriate for systems dominated by tradeoffs or specialization.

---

## 9. Relation to function, regulation, and retention

The preceding papers establish two separations relevant here.

First, persistence and related endogenous organizational quantities do not by themselves determine an independently declared functional verdict.

Second, selected regulation need not be sufficient to preserve an independently declared functional boundary.

These results matter for cumulative change because a capability can count as retained only if the processes that maintain it remain adequate.

A candidate new route may therefore fail to create a ratchet click in at least three ways:

1. **functional loss:** an old target falls below its declared functional boundary;
2. **regulatory underprovision:** control remains selected but is insufficient to keep an old capability within bounds;
3. **route loss:** reorganization removes or makes unaffordable a pathway required for an old target.

The marginal-alignment theorem from *When Does Regulation Pay?* supplies one condition under which a regulated functional state is retained. The present note then asks what follows when such retained functions form part of a larger accessible repertoire.

This creates a clean logical stack:

\[
\boxed{
\text{function declared}
\rightarrow
\text{function maintained}
\rightarrow
\text{access preserved}
\rightarrow
\text{new access added}
\rightarrow
\text{strict ratchet click}.
}
\]

---

## 10. Relation to the finite-time no-go boundary

A monotone chain

\[
\mathcal R_0
\subsetneq
\mathcal R_1
\subsetneq
\mathcal R_2
\subsetneq
\cdots
\]

can contain arbitrarily many abstract indexing steps.

That does not imply that infinitely many fixed-resolution physical reorganizations can occur in finite time.

The fixed-resolution no-go result developed elsewhere in this project places a separate physical constraint on how many operationally distinguishable organizational transitions can occur within finite time under finite energy/action assumptions.

The two results therefore address different questions:

- the present note gives the **order structure** required for cumulative accessibility;
- the finite-time paper constrains the **physical rate and resolution** at which distinguishable clicks can be realized.

A mathematical ratchet is not an escape from physical cost.

---

## 11. Machine-verified core

The Lean development in

formalization/cumulative-accessibility/CumulativeAccessibility.lean

formalizes the abstract core without claiming to formalize the empirical interpretation of the accessibility kernel.

It verifies:

1. preservation is equivalent to subset inclusion of declared accessible sets;
2. strict expansion is equivalent to strict subset inclusion;
3. preservation is reflexive and transitive;
4. a strict click followed by preservation remains strict relative to the earlier baseline;
5. preservation followed by a strict click is strict relative to the earlier baseline;
6. strict clicks compose;
7. pointwise score dominance preserves thresholded accessibility;
8. a score crossing produces strict expansion;
9. pointwise cost non-increase preserves budget-feasible accessibility;
10. a cost crossing produces strict expansion;
11. loss of any previously accessible declared target rules out a monotone preservation step.

The formalization intentionally does not prove that any particular biological, institutional, technological, or chemical change satisfies the hypotheses. Those are empirical or model-specific questions.

---

## 12. What this result does not say

The result does not establish that:

- evolution generally moves upward in this preorder;
- all capabilities should be preserved;
- complexity is monotone;
- larger accessible sets are morally or biologically better;
- cost is the definition of organizational accessibility;
- every new module lowers future realization cost;
- recombination, transfer, or symbiosis necessarily produce ratchet clicks;
- a strong monotone ratchet is required for every meaningful form of cumulative evolution;
- an infinite sequence of fixed-resolution clicks can occur in finite physical time.

It establishes a conditional statement:

> **If historical change preserves a declared accessible repertoire and adds at least one newly accessible target, then accessibility has changed cumulatively in a composable monotone sense.**

---

## 13. The next scientific question

The order relation itself is elementary. The scientific problem is not.

The next question is:

\[
\boxed{
\text{Which mechanisms make accessibility-preserving strict expansion likely enough to recur?}
}
\]

The organizational-accessibility framework already identifies candidate mechanisms:

- hysteretic retention;
- inherited adaptive extension;
- compositional accessibility;
- evolvability;
- environmental feedback.

The present note tells us what those mechanisms must jointly accomplish to produce a strong cumulative ratchet:

\[
\boxed{
\text{retain enough of the old accessible repertoire}
+
\text{open at least one new accessible target}.
}
\]

This is the point where continuous turnover can become cumulative history.

---

## Conclusion

Continuous change is not cumulative change.

Persistence is not cumulative change.

Novelty is not cumulative change.

Even causal historical contribution need not imply monotone accumulation of capabilities.

A strict accessibility ratchet requires a stronger relation:

\[
\boxed{
\mathcal R_t
\subsetneq
\mathcal R_{t+1}.
}
\]

The significance of this simple condition is compositional. If each successive change preserves the declared accessible repertoire, strict clicks accumulate transitively. The material implementation may change completely; what is carried forward is the capacity to reach the declared targets.

That gives a precise sense in which organization can accumulate despite turnover:

> **the present inherits not necessarily the parts of the past, but a repertoire of reachable organization; cumulative change occurs when that repertoire is retained and extended.**
