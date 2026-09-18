import CumulativeAccessibility.MaintenanceOpportunityBridge

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Bounded-delay resource-feasible response

The maintenance bridge separates recurring opportunity Q from successful
validated uptake.  Its same-time coupling predicate W is intentionally strong:
an opportunity and a complete validated success must occur at the same indexed
time.

This module introduces the next layer without adding stochastic dynamics.

* response cost and response budget are explicit quantitative functions;
* a resource-feasible success is an ordinary validated success plus the
  inequality cost <= budget for the realized candidate;
* a response to an opportunity may occur after a bounded delay;
* recurrent opportunity plus a bounded resource-feasible response guarantee
  implies recurrent validated uptake G.

The old same-time predicate W is exactly the zero-delay special case of the new
recurring bounded-response predicate.  A positive delay can therefore support G
without W.  This module does not derive budgets, costs, generation, validation,
or retention from maintenance; they remain independently declared mechanisms.
-/

section Definitions

variable {α : Type*} [DecidableEq α]

/-- Candidate-specific response cost at each indexed time. -/
abbrev ResponseCost (α : Type*) := ℕ → α → ℝ

/-- Resource budget available for response at each indexed time. -/
abbrev ResponseBudget := ℕ → ℝ

/-- The candidate's declared response cost fits inside the declared budget at
this time.  This reuses the package's scalar cost-accessibility convention. -/
def ResourceFeasibleAt
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (m : ℕ)
    (z : α) : Prop :=
  AccessibleByCost (Cost m) (Budget m) z

/-- A complete validated success carrying an additional quantitative
resource-feasibility witness. -/
def ResourceValidatedSuccessAt
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (m : ℕ) : Prop :=
  ∃ z,
    z ∈ U m ∧
    z ∉ S m ∧
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) z ∧
    ResourceFeasibleAt Cost Budget m z ∧
    E m z ∧
    z ∈ S (m + 1)

/-- From every horizon there is a later opportunity and a validated success
that answers it within at most lag indexed steps.  The opportunity time q and
success time r are kept separate.

For lag = 0 this collapses to the same-time response predicate W. -/
def RecurringValidatedResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ q r : ℕ,
    n ≤ q ∧
    Opportunity q ∧
    q ≤ r ∧
    r ≤ q + lag ∧
    ValidatedSuccessAt U H E S r

/-- Every opportunity receives a resource-feasible validated response within a
declared finite lag.  Unlike RecurringValidatedResponseWithin, this is a local
per-opportunity response guarantee; recurrence comes from Q. -/
def OpportunityConditionedResourceResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ q : ℕ, Opportunity q → ∃ r : ℕ,
    q ≤ r ∧
    r ≤ q + lag ∧
    ResourceValidatedSuccessAt Cost Budget U H E S r

end Definitions

section Implications

variable {α : Type*} [DecidableEq α]

/-- Forgetting the quantitative resource witness recovers an ordinary complete
validated success at the same response time. -/
theorem resourceValidatedSuccessAt_implies_validatedSuccessAt
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (m : ℕ)
    (h : ResourceValidatedSuccessAt Cost Budget U H E S m) :
    ValidatedSuccessAt U H E S m := by
  obtain ⟨z, hzU, hzNot, hGen, hResource, hEval, hzNext⟩ := h
  exact ⟨z, hzU, hzNot, hGen, hEval, hzNext⟩

/-- The old same-time response W implies the new bounded response predicate at
lag zero. -/
theorem recurringValidatedResponse_implies_within_zero
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h : RecurringValidatedResponse Opportunity U H E S) :
    RecurringValidatedResponseWithin 0 Opportunity U H E S := by
  intro n
  obtain ⟨m, hnm, hOpportunity, hSuccess⟩ := h n
  exact ⟨m, m, hnm, hOpportunity, le_rfl, by simp, hSuccess⟩

/-- Conversely, zero bounded delay forces the response time to equal the
opportunity time, recovering W exactly. -/
theorem recurringValidatedResponseWithin_zero_implies_recurringValidatedResponse
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h : RecurringValidatedResponseWithin 0 Opportunity U H E S) :
    RecurringValidatedResponse Opportunity U H E S := by
  intro n
  obtain ⟨q, r, hnq, hOpportunity, hqr, hrq, hSuccess⟩ := h n
  have hrq' : r ≤ q := by
    simpa using hrq
  have hEq : q = r := Nat.le_antisymm hqr hrq'
  subst r
  exact ⟨q, hnq, hOpportunity, hSuccess⟩

/-- Same-time W is exactly the zero-delay member of the bounded-response
family. -/
theorem recurringValidatedResponseWithin_zero_iff
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) :
    RecurringValidatedResponseWithin 0 Opportunity U H E S
      ↔ RecurringValidatedResponse Opportunity U H E S := by
  constructor
  · exact recurringValidatedResponseWithin_zero_implies_recurringValidatedResponse
      Opportunity U H E S
  · exact recurringValidatedResponse_implies_within_zero
      Opportunity U H E S

/-- Any recurrent bounded response stream contains arbitrarily late validated
uptake.  Positive response delay does not obstruct G because the response time
is constrained to occur after the recurrent opportunity time. -/
theorem recurringValidatedResponseWithin_implies_validatedUptake
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h : RecurringValidatedResponseWithin lag Opportunity U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  intro n
  obtain ⟨q, r, hnq, hOpportunity, hqr, hrBound, hSuccess⟩ := h n
  obtain ⟨z, hzU, hzNot, hGen, hEval, hzNext⟩ := hSuccess
  exact ⟨r, z, le_trans hnq hqr, hzU, hzNot, hGen, hEval, hzNext⟩

/-- Recurrent opportunities plus a local resource-feasible bounded-response
guarantee produce recurrent bounded validated response. -/
theorem recurringOpportunity_and_resourceResponseWithin_imply_recurringResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        lag Opportunity Cost Budget U H E S) :
    RecurringValidatedResponseWithin lag Opportunity U H E S := by
  intro n
  obtain ⟨q, hnq, hOpp⟩ := hOpportunity n
  obtain ⟨r, hqr, hrBound, hResourceSuccess⟩ := hResponse q hOpp
  exact ⟨q, r, hnq, hOpp, hqr, hrBound,
    resourceValidatedSuccessAt_implies_validatedSuccessAt
      Cost Budget U H E S r hResourceSuccess⟩

/-- Therefore recurrent opportunity plus bounded resource-feasible response is
already sufficient for G.  This removes same-time coincidence W as a necessary
interface when delayed response is allowed. -/
theorem recurringOpportunity_and_resourceResponseWithin_imply_validatedUptake
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        lag Opportunity Cost Budget U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  exact recurringValidatedResponseWithin_implies_validatedUptake
    lag Opportunity U H E S
    (recurringOpportunity_and_resourceResponseWithin_imply_recurringResponseWithin
      lag Opportunity Cost Budget U H E S hOpportunity hResponse)

/-- With monotone retention, the bounded resource-response route implies
open-ended cumulative retained novelty. -/
theorem recurringOpportunity_and_resourceResponseWithin_imply_openEndedNovelty
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        lag Opportunity Cost Budget U H E S) :
    OpenEndedCumulativeNovelty S := by
  exact validatedGenerativeCapacityUptake_implies_openEndedNovelty
    U H E S hRetained
    (recurringOpportunity_and_resourceResponseWithin_imply_validatedUptake
      lag Opportunity Cost Budget U H E S hOpportunity hResponse)

/-- With representation and retention, the same route implies unbounded
effective distinguishability capacity. -/
theorem recurringOpportunity_and_resourceResponseWithin_imply_unboundedEnvelope
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        lag Opportunity Cost Budget U H E S) :
    UnboundedEnvelopeCapacity U := by
  exact validatedGenerativeCapacityUptake_implies_unboundedEnvelope
    U H E S hRepresented hRetained
    (recurringOpportunity_and_resourceResponseWithin_imply_validatedUptake
      lag Opportunity Cost Budget U H E S hOpportunity hResponse)

end Implications

#print axioms resourceValidatedSuccessAt_implies_validatedSuccessAt
#print axioms recurringValidatedResponseWithin_zero_iff
#print axioms recurringValidatedResponseWithin_implies_validatedUptake
#print axioms recurringOpportunity_and_resourceResponseWithin_imply_recurringResponseWithin
#print axioms recurringOpportunity_and_resourceResponseWithin_imply_validatedUptake
#print axioms recurringOpportunity_and_resourceResponseWithin_imply_openEndedNovelty
#print axioms recurringOpportunity_and_resourceResponseWithin_imply_unboundedEnvelope

end RecursiveAccessibility
end CumulativeAccessibility
