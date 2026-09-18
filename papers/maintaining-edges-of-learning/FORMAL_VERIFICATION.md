# Formal Verification Map — Maintaining the Edges of Learning

## Status

The paper is a focused **agent-network interpretation** of already existing Evolution by Emergence formal objects.

No theorem in the current Lean stack proves that a named social verb such as listening, honesty, repair, forgiveness, or re-engagement necessarily improves learning.

Those are empirical/mechanistic hypotheses.

The machine-checked layer establishes conditional implications once an application supplies the bridge from an inside process to an outside cost geometry.

Evidence labels:

- **MC** — machine checked implication under stated assumptions.
- **MODEL** — application-specific modelling bridge.
- **INT** — interpretation or empirical hypothesis.

---

## Claim 1 — directed correction/accessibility cost

**Paper object**

\[
C_t(X,y\mid R_t)
\]

is the declared cost of reaching future target state \(y\) from current network state \(X\), subject to preserving declared retained function.

**Status:** MODEL + MC infrastructure.

**Lean source**

\`CumulativeAccessibility/QuantitativeAccessibility.lean\`

**Relevant definitions**

- \`AccessibilityCost\`
- \`AccessibleWithin\`
- \`BudgetSearch\`
- \`CostGeometryChangesOn\`
- \`HasCheaperFutureOn\`
- \`NoMoreViscousOn\`
- \`StrictlyLessViscousOn\`

No metric axioms are assumed.

---

## Claim 2 — lower viscosity can open a budget window

If every declared target is no more costly under the new geometry and at least one is strictly cheaper, then some budget threshold exhibits strict accessibility expansion.

**Status:** MC.

**Lean source**

\`CumulativeAccessibility/QuantitativeAccessibility.lean\`

**Relevant theorems**

- \`strictlyLessViscousOn_opens_budget_window\`
- \`strictlyLessViscousOn_induces_strictExpansionAtBudget\`
- \`noMoreViscousOn_preserves_budget_access\`
- \`strictlyLessViscousOn_trans\`

This is the formal basis for the paper's statement that lowering future correction cost can make a previously unaffordable correction affordable.

---

## Claim 3 — inside processes and outside geometry are distinct objects

The paper distinguishes internal learning-maintenance process state \(P\) from the externally measured accessibility geometry.

\[
P \xrightarrow{\Gamma} C.
\]

**Status:** MC interface + MODEL for empirical interpretation.

**Lean source**

\`CumulativeAccessibility/IntelligentLearningMaintenance.lean\`

**Relevant definitions**

- \`LearningVerb\`
- \`ProcessGeometry\`
- \`AppliesVerb\`
- \`ProcessImprovementOn\`
- \`VerbImprovementOn\`

Current verb labels include:

- \`seek\`
- \`listen\`
- \`signalFaithfully\`
- \`exposeUncertainty\`
- \`test\`
- \`revise\`
- \`maintainEdge\`
- \`repair\`
- \`reengage\`
- \`retain\`
- \`recombine\`

The constructors are descriptive labels only. Their causal effects are not axiomatized.

---

## Claim 4 — an inside process improvement has an outside consequence

If an application establishes that a process change is strictly less viscous on the declared target set, then at least one future transition is cheaper and some budget window opens.

**Status:** MC conditional on the application-specific bridge.

**Lean source**

\`CumulativeAccessibility/IntelligentLearningMaintenance.lean\`

**Relevant theorems**

- \`processImprovement_has_cheaper_future\`
- \`verbImprovement_opens_budget_window\`

This is the formal inside/outside seam used by the paper.

---

## Claim 5 — functional gain and velocity are distinct from accessibility

The paper distinguishes the cost of future reorganization from the current cost of performing a function.

**Status:** MC formal separation.

**Lean source**

\`CumulativeAccessibility/FunctionalRatchetVelocity.lean\`

The organizational state type and functional target type are separate.

The paper uses this layer to distinguish:

- **plasticity/accessibility:** how expensive future correction is;
- **learning velocity:** how quickly retained functional performance improves.

---

## Claim 6 — mechanism ledger

A reduced scalar projection is available:

\[
v_{\mathrm{ledger}}
=
\lambda p_G p_R p_V p_T \bar g.
\]

**Status:** MC algebraic properties; MODEL as a mechanism representation.

**Lean source**

\`CumulativeAccessibility/RatchetVelocityLedger.lean\`

Lean checks zero-bottleneck and ceteris-paribus monotonicity results.

The paper explicitly does not claim that this exact product is a universal law of social or intelligent learning.

---

## Claim 7 — bounded opportunity and response give a rate certificate

Let:

- \(K\) be a bounded opportunity gap;
- \(\Delta\) be a bounded validated-response lag.

Then every sliding window of width

\[
K+\Delta+1
\]

contains a resource-validated update.

**Status:** MC.

**Lean source**

\`CumulativeAccessibility/BoundedUpdateRate.lean\`

**Relevant definitions/theorems**

- \`OpportunityGapBound\`
- \`ResourceValidatedSuccessGapBound\`
- \`ResourceValidatedSuccessEveryWindow\`
- \`boundedOpportunity_and_response_imply_successGapBound\`
- \`boundedOpportunity_and_response_imply_successEveryWindow\`

With an additional minimum retained functional-gain premise, the formal layer yields the corresponding local rate lower bound used in the paper.

---

## Claim 8 — more search/contact need not increase retained velocity

Reduced shared-budget model:

\[
v(x)=x(1-x)
\]

where \(x\) is allocated to candidate generation/search and \(1-x\) to validation.

**Status:** MC reduced model.

**Lean source**

\`CumulativeAccessibility/SearchValidationTradeoff.lean\`

**Relevant theorems**

- \`searchValidationVelocity_eq\`
- \`searchValidationVelocity_le_quarter\`
- \`searchValidationVelocity_eq_quarter_iff\`
- \`searchValidationVelocity_strictMono_left\`
- \`searchValidationVelocity_strictAnti_right\`
- \`more_search_can_reduce_velocity\`

Lean proves the unique optimum at \(x=1/2\) for this declared toy model.

This supports only the narrow claim that coupled mechanisms can generate an interior optimum. It does not establish a universal optimum for human communication.

---

## Claim 9 — repair, edge option value, and differential edge timescales

The paper proposes:

- edge viscosity can rise after interaction failure;
- successful repair can lower it again;
- an informative edge can have future option value;
- content disagreement can evolve on a faster timescale than irreversible edge loss.

**Status:** INT/MODEL.

These claims are not yet formalized as universal theorems.

They are intended as experimentally testable hypotheses at the fixed agent-network scale.

A future formalization should avoid encoding their desired sign by definition. The preferred route is to define an explicit repeated-learning environment, edge state, repair transition, and future target distribution, then compare expected acquisition costs or retained functional rates under alternative edge-update rules.

---

## Non-claims

The formal layer does not prove that:

- more connectivity improves learning;
- an edge should always be retained;
- trust is always beneficial;
- disagreement is beneficial;
- forgiveness or re-engagement should always occur;
- all informative edges have positive option value;
- human relationships are reducible to information channels;
- the same mechanism applies inside brains, inside LLM parameters, and between human agents.

The paper's empirical programme begins exactly where the current machine-checked implications stop.
