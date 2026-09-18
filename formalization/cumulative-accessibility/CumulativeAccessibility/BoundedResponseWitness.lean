import CumulativeAccessibility.ResponseDynamics
import CumulativeAccessibility.MaintenanceGatedWitness

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Bounded-response witnesses

This file stress-tests the bounded-delay resource-response interface with the
existing even/odd opportunity-gated architecture.

The main witness uses

* opportunity at even indexed times;
* successful validated uptake at odd indexed times;
* response lag exactly one step;
* zero declared response cost and zero budget, hence resource feasibility.

Every recurring even opportunity is answered one step later, so G follows.
Same-time W nevertheless remains false because opportunity and success never
coincide.

Two additional separation checks keep the resource term honest:

1. ordinary validated success need not satisfy an independently declared
   response budget;
2. resource feasibility by itself does not create generation or validated
   success.
-/

/-- Cost-free toy response used only to witness satisfiability of the resource
interface. -/
def zeroResponseCost : ResponseCost ℕ :=
  fun _ _ => 0

/-- Zero budget paired with zero cost in the positive resource witness. -/
def zeroResponseBudget : ResponseBudget :=
  fun _ => 0

/-- Deliberately infeasible unit response cost used in the resource-separation
witness. -/
def unitResponseCost : ResponseCost ℕ :=
  fun _ _ => 1

/-- Zero response cost is feasible under the zero budget at every time and for
every candidate. -/
theorem zeroResponseResourceFeasible
    (m z : ℕ) :
    ResourceFeasibleAt zeroResponseCost zeroResponseBudget m z := by
  simp [ResourceFeasibleAt, zeroResponseCost, zeroResponseBudget,
    AccessibleByCost]

/-- Every even opportunity is answered exactly one indexed step later by the
odd-gated architecture, with an explicit resource-feasibility witness. -/
theorem evenOpportunity_has_unitDelayedResourceResponse :
    OpportunityConditionedResourceResponseWithin
      1
      evenOpportunity
      zeroResponseCost
      zeroResponseBudget
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity) := by
  intro q hEven
  rcases hEven with ⟨k, hq⟩
  have hOdd : oddOpportunity (q + 1) := by
    refine ⟨k, ?_⟩
    omega
  have hSuccess :=
    opportunityGatedArchitecture_realizesValidatedAtOpportunity
      oddOpportunity (q + 1) hOdd
  obtain ⟨z, hzU, hzNot, hGen, hEval, hzNext⟩ := hSuccess
  refine ⟨q + 1, by omega, by omega, ?_⟩
  exact ⟨z, hzU, hzNot, hGen,
    zeroResponseResourceFeasible (q + 1) z,
    hEval, hzNext⟩

/-- Because even opportunities recur, the unit-delay response guarantee creates
a recurrent bounded validated response stream. -/
theorem evenOpportunity_has_recurring_unitDelayedResponse :
    RecurringValidatedResponseWithin
      1
      evenOpportunity
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity) := by
  exact
    recurringOpportunity_and_resourceResponseWithin_imply_recurringResponseWithin
      1
      evenOpportunity
      zeroResponseCost
      zeroResponseBudget
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      evenOpportunity_recurring
      evenOpportunity_has_unitDelayedResourceResponse

/-- The unit-delay resource-response route yields validated generative uptake. -/
theorem evenOpportunity_unitDelayedResponse_implies_validatedUptake :
    ValidatedGenerativeCapacityUptake
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity) := by
  exact
    recurringValidatedResponseWithin_implies_validatedUptake
      1
      evenOpportunity
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      evenOpportunity_has_recurring_unitDelayedResponse

/-- With monotone retention, the same delayed-response construction is
open-ended. -/
theorem evenOpportunity_unitDelayedResponse_implies_openEndedNovelty :
    OpenEndedCumulativeNovelty
      (opportunityGatedRepertoire oddOpportunity) := by
  exact
    recurringOpportunity_and_resourceResponseWithin_imply_openEndedNovelty
      1
      evenOpportunity
      zeroResponseCost
      zeroResponseBudget
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      (opportunityGatedRepertoire_retained oddOpportunity)
      evenOpportunity_recurring
      evenOpportunity_has_unitDelayedResourceResponse

/-- Positive response delay is a genuine generalization: recurrent unit-delay
response can hold while same-time W is false. -/
theorem unitDelayedResponse_without_sameTimeCoincidence :
    RecurringValidatedResponseWithin
        1
        evenOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity)
      ∧
    ¬ RecurringValidatedResponse
        evenOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity) := by
  constructor
  · exact evenOpportunity_has_recurring_unitDelayedResponse
  · exact recurringOpportunity_and_uptake_without_recurringCoincidence.2.2

/-- The bounded-response hierarchy is genuinely strict in this witness:
lag one is sufficient, while lag zero is impossible. -/
theorem unitDelayedResponse_without_zeroDelay :
    RecurringValidatedResponseWithin
        1
        evenOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity)
      ∧
    ¬ RecurringValidatedResponseWithin
        0
        evenOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity) := by
  constructor
  · exact evenOpportunity_has_recurring_unitDelayedResponse
  · intro hZero
    have hSame :
        RecurringValidatedResponse
          evenOpportunity
          progressiveEnvelope
          (opportunityGatedGenerator oddOpportunity)
          acceptAllCriterion
          (opportunityGatedRepertoire oddOpportunity) :=
      recurringValidatedResponseWithin_zero_implies_recurringValidatedResponse
        evenOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity)
        hZero
    exact unitDelayedResponse_without_sameTimeCoincidence.2 hSame

/-- Ordinary validated success does not imply feasibility under an independently
declared resource model.  The odd-gated architecture succeeds at time 1, but a
unit response cost does not fit inside a zero budget. -/
theorem validatedSuccess_without_declaredResourceFeasibility :
    ValidatedSuccessAt
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity)
        1
      ∧
    ¬ ResourceValidatedSuccessAt
        unitResponseCost
        zeroResponseBudget
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity)
        1 := by
  constructor
  · have hOdd : oddOpportunity 1 := by
      exact ⟨0, by omega⟩
    exact
      opportunityGatedArchitecture_realizesValidatedAtOpportunity
        oddOpportunity 1 hOdd
  · intro hResource
    obtain ⟨z, hzU, hzNot, hGen, hFeasible, hEval, hzNext⟩ := hResource
    norm_num [ResourceFeasibleAt, unitResponseCost, zeroResponseBudget,
      AccessibleByCost] at hFeasible

/-- Resource feasibility alone is also insufficient.  A zero-cost candidate can
fit the budget while the no-opportunity architecture has no enabled generator
event and therefore no validated success. -/
theorem resourceFeasibility_without_validatedSuccess :
    ResourceFeasibleAt zeroResponseCost zeroResponseBudget 0 0
      ∧
    ¬ ValidatedSuccessAt
        progressiveEnvelope
        (opportunityGatedGenerator noOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire noOpportunity)
        0 := by
  constructor
  · exact zeroResponseResourceFeasible 0 0
  · intro hSuccess
    obtain ⟨z, hzU, hzNot, hGenerated, hEval, hzNext⟩ := hSuccess
    obtain ⟨parents, hParents, hRule⟩ := hGenerated
    exact
      (noOpportunity_disables_response.2 0 parents z) hRule

#print axioms zeroResponseResourceFeasible
#print axioms evenOpportunity_has_unitDelayedResourceResponse
#print axioms evenOpportunity_has_recurring_unitDelayedResponse
#print axioms evenOpportunity_unitDelayedResponse_implies_validatedUptake
#print axioms evenOpportunity_unitDelayedResponse_implies_openEndedNovelty
#print axioms unitDelayedResponse_without_sameTimeCoincidence
#print axioms unitDelayedResponse_without_zeroDelay
#print axioms validatedSuccess_without_declaredResourceFeasibility
#print axioms resourceFeasibility_without_validatedSuccess

end RecursiveAccessibility
end CumulativeAccessibility
