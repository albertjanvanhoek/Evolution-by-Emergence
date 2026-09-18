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
- CostGeometryChangesOn;
- HasCheaperFutureOn;
- NoMoreViscousOn;
- StrictlyLessViscousOn;
- QuantitativeSecondOrderChange;
- QuantitativeSecondOrderOpening;
- QuantitativeSecondOrderClick.

Lean checks:

1. NoMoreViscousOn is reflexive.
2. NoMoreViscousOn composes transitively across changing geometries and states.
3. Strict improvement followed by a non-worsening retained change remains
   strict relative to the ancestor; the converse ordering and strict+strict
   composition are also checked.
4. A no-more-viscous transition preserves every target already affordable at a
   fixed budget.
5. Any directional cheaper-future event opens an exact budget threshold for
   that target, without assuming preservation of other targets.
6. QuantitativeSecondOrderOpening is weaker than Pareto-like viscosity
   improvement; a checked trade-off witness makes one target cheaper while
   making another more expensive.
7. That trade-off opening need not be a v16 binary SecondOrderClick because an
   old affordable target may be lost.
8. A strict Pareto-like quantitative improvement contains an explicit target
   and budget for which the target is unaffordable before and affordable after.
9. A strict Pareto-like improvement therefore induces strict binary candidate
   expansion at some budget threshold.
10. A state-dependent QuantitativeSecondOrderClick implies an existing v16
    SecondOrderClick at some budget.
11. An explicit two-state viscosity witness inhabits both the quantitative and
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
- RecursiveSelfImprovementOn;
- FunctionalProcessGeometry;
- MatchedLearningRateImprovementOn;
- RateGroundedRecursiveSelfImprovementOn;
- LearningMechanismCertificate;
- ProcessRateCertificate;
- MechanismGroundedRecursiveSelfImprovementOn.

Lean checks:

1. an internal process improvement has an explicit future target whose induced
   cost is lower;
2. a verb-labelled improvement opens an externally observable budget window;
3. an endogenous SelfImprovementOn has the same cheaper-future consequence;
4. RecursiveSelfImprovementOn implies SelfImprovementOn;
5. RecursiveSelfImprovementOn implies increased declared improvement
   productivity.
6. RateGroundedRecursiveSelfImprovementOn preserves declared retained
   functional targets at the matched starting organization.
7. RateGroundedRecursiveSelfImprovementOn contains an explicit held-out target
   whose duration/resource-normalized learning rate is strictly higher under
   the self-modified process.
8. A LearningMechanismCertificate maps a process to the application-justified
   tuple (K, Δ, g_min) and hence to a conservative guaranteed rate floor.
9. Holding opportunity access and minimum gain fixed, a strictly shorter
   validated-response lag raises that rate floor.
10. Holding response lag and minimum gain fixed, a strictly shorter maximum
    opportunity wait raises that rate floor.
11. Holding both delay coordinates fixed, a strictly larger minimum retained
    gain raises that rate floor.
12. An endogenous process change that preserves declared prior function and
    satisfies the shorter-response-lag route is sufficient for
    MechanismGroundedRecursiveSelfImprovementOn.

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

The generic inside translation is conditional:

\[
P_t \xrightarrow{\Gamma} C_t.
\]

An application must justify the map Γ. The formal theory deliberately does not
define intelligent-network verbs so that improvement is true by construction.


## Preferred rate-grounded recursive test

The earlier scalar `ImprovementProductivity ρ` remains a generic interface.
The preferred operational specialization now uses the companion
`FunctionalRatchetVelocity.lean` layer.

Clone or otherwise match the starting organization, hold the functional target
family fixed, normalize each episode by its positive duration/resource
interval, and compare the old and new process rate profiles.

A process change counts as rate-grounded recursive self-improvement only if the
old process generated and applied the intervention, declared retained functions
are not made more costly at the starting organization, and the new process
strictly dominates the old process on held-out functional learning rate for at
least one target without being slower on the others in the declared set.


## Two complementary recursive-improvement tests

The formalization now contains two non-equivalent tests.

**Observed-rate test**

`RateGroundedRecursiveSelfImprovementOn` compares matched held-out learning
episodes and requires the self-modified process to have a strictly better
normalized functional-rate profile.

**Mechanism-certificate test**

`MechanismGroundedRecursiveSelfImprovementOn` uses an application-justified
certificate

```math
(K,\Delta,g_{\min})
```

with conservative rate floor

```math
v_{\min}
=
\frac{g_{\min}}{K+\Delta+1}.
```

The old process must generate and apply the intervention, declared retained
functions must remain no more costly at the matched starting organization, and
the new process's certified rate floor must be strictly larger.

The mechanism test is intentionally weaker epistemically. Improving a justified
lower bound does not by itself prove that realized held-out learning velocity
increased. Agreement between the mechanism certificate and the observed-rate
test is therefore a substantive empirical prediction rather than a definition.
