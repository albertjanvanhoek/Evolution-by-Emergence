# Formal verification

## Scope

The paper has two formal layers.

### Outside layer

Source:

formalization/cumulative-accessibility/CumulativeAccessibility/QuantitativeAccessibility.lean

This layer is intended to become part of the substrate-independent Evolution by
Emergence stack.

It defines:

- AccessibilityCost;
- AccessibleWithin;
- BudgetSearch;
- NoMoreViscousOn;
- StrictlyLessViscousOn;
- QuantitativeSecondOrderClick.

Lean checks:

1. NoMoreViscousOn is reflexive.
2. NoMoreViscousOn composes transitively across changing geometries and states.
3. Strict improvement followed by a non-worsening retained change remains
   strict relative to the ancestor; the converse ordering and strict+strict
   composition are also checked.
4. A no-more-viscous transition preserves every target already affordable at a
   fixed budget.
5. Any strict quantitative improvement contains an explicit target and budget
   for which the target is unaffordable before and affordable after.
6. Any strict quantitative improvement therefore induces strict binary
   candidate expansion at some budget threshold.
7. A state-dependent QuantitativeSecondOrderClick implies an existing v16
   SecondOrderClick at some budget.
8. An explicit two-state viscosity witness inhabits both the quantitative and
   thresholded binary forms.

The key theorem is:

quantitativeSecondOrderClick_implies_secondOrderClick_at_some_budget

This theorem establishes that the weighted formulation generalizes rather than
replaces the v16 binary second-order accessibility concept.

### Inside layer

Source:

formalization/cumulative-accessibility/CumulativeAccessibility/IntelligentLearningMaintenance.lean

This layer is a specialization for intelligent learning networks.

It defines:

- LearningVerb;
- ProcessGeometry;
- AppliesVerb;
- ProcessImprovementOn;
- VerbImprovementOn;
- SelfImprovementOn;
- ImprovementProductivity;
- RecursiveSelfImprovementOn.

Lean checks:

1. an internal process improvement has an explicit future target whose induced
   cost is lower;
2. a verb-labelled improvement opens an externally observable budget window;
3. an endogenous SelfImprovementOn has the same cheaper-future consequence;
4. RecursiveSelfImprovementOn implies SelfImprovementOn;
5. RecursiveSelfImprovementOn implies increased declared improvement
   productivity.

## Important non-claims

Lean does not prove that:

- honesty lowers transition cost;
- exposing uncertainty is always beneficial;
- more trust is better;
- repair is always worth its cost;
- forgiveness always preserves useful edges;
- more diversity is always beneficial;
- a particular LLM implements the declared process state P;
- a human relationship has a single scalar edge viscosity;
- recursive self-improvement occurs;
- recursive self-improvement accelerates without bound.

Those require application-specific models or empirical tests.

## Verification route

Both modules are imported by:

CumulativeAccessibility.AuditAll

Selected declarations are printed by:

CumulativeAccessibility.VerificationSurface

The cumulative-accessibility CI and repository-wide Full Theory Proof Check
explicitly compile and source-audit both modules. Review should reject an
advertised result if its printed axiom dependencies contain sorryAx.

## Conceptual proof boundary

The universal theorem is on the outside:

\[
\text{lower declared transition cost}
\Rightarrow
\text{larger thresholded accessibility at some budget}.
\]

The inside translation is conditional:

\[
P_t \xrightarrow{\Gamma} C_t.
\]

An application must justify the map Γ. The formal theory deliberately does not
define intelligent-network verbs so that improvement is true by construction.
