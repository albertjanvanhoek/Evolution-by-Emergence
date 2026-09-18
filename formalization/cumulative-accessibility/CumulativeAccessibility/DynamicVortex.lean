import CumulativeAccessibility.EndogenousBudgetBridge
import CumulativeAccessibility.ModuleGeneratedEvolvability

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Dynamic vortex composition

The repository already proves the component mechanisms of the Evolution by
Emergence dynamic core:

* maintained organization can keep opportunities available;
* organization-dependent gradient uptake minus maintenance generates internal
  slack and therefore response budget;
* resource-feasible validated responses can be retained;
* retained organization can become reusable parent material;
* retained modules or changed generative rules can expand future search;
* a viable transition with strict search expansion is a \`SecondOrderClick\`;
* repeated retained novelty requires an unbounded effective distinguishability
  envelope.

This file does not introduce a new physical law. It packages the key
composition seam explicitly.

An integrated vortex response is a resource-feasible validated response,
financed from endogenous slack, whose realized organizational update is also a
second-order accessibility click. The coupling between the retained response and
that organizational update is deliberately explicit: the formalization does not
claim that every retained novelty must improve physical organization or expand
future search.
-/

section OneTurn

variable {α : Type*} [DecidableEq α]

/-- A one-turn dynamic-vortex event at a fixed external gradient.

The same organizational transition has two declared effects:

1. it strictly raises net internal slack, so positive reinvestment strictly
   raises internally available response budget;
2. it is a \`SecondOrderClick\`, so the new organization exposes at least one
   declared future candidate unavailable to the old organization.

The definition does not assert why the transition occurred. -/
def DynamicVortexTurn
    (uptake : UptakeFunction α)
    (maintenance : MaintenanceDemand α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α)
    (g beta : ℝ)
    (oldState newState : α) : Prop :=
  0 < beta ∧
  uptake oldState g - maintenance oldState
    < uptake newState g - maintenance newState ∧
  SecondOrderClick Step Viable targets Search oldState newState

/-- A dynamic-vortex turn simultaneously opens a nonempty response-cost window
and a genuinely new future-search candidate.

This is the compact composition theorem joining the physical slack ledger to
second-order accessibility. -/
theorem dynamicVortexTurn_opens_budget_and_futureSearch
    (uptake : UptakeFunction α)
    (maintenance : MaintenanceDemand α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α)
    (g beta : ℝ)
    (oldState newState : α)
    (hTurn :
      DynamicVortexTurn uptake maintenance Step Viable targets Search
        g beta oldState newState) :
    ∃ responseCost z,
      beta * (uptake oldState g - maintenance oldState) < responseCost ∧
      responseCost ≤
        beta * (uptake newState g - maintenance newState) ∧
      z ∈ targets ∧
      ¬ Search oldState z ∧
      Search newState z := by
  rcases hTurn with ⟨hBeta, hSlack, hClick⟩
  have hBudget :
      beta * (uptake oldState g - maintenance oldState)
        < beta * (uptake newState g - maintenance newState) :=
    mul_lt_mul_of_pos_left hSlack hBeta
  obtain ⟨responseCost, hOld, hNew⟩ :=
    responseBudget_increase_opens_cost_window hBudget
  obtain ⟨z, hzTargets, hzOld, hzNew⟩ :=
    secondOrderClick_has_new_candidate
      Step Viable targets Search hClick
  exact ⟨responseCost, z, hOld, hNew, hzTargets, hzOld, hzNew⟩

end OneTurn

section RecurrentIntegratedResponse

variable {α : Type*} [DecidableEq α]

/-- The organizational state undergoes arbitrarily late second-order updates. -/
def RecurringSecondOrderUpdate
    (state : ℕ → α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α) : Prop :=
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    SecondOrderClick Step Viable targets Search (state r) (state (r + 1))

/-- Per-opportunity integrated response.

Every opportunity receives, within the declared lag,

* a complete resource-feasible validated response financed by the endogenous
  response budget; and
* an organizational update at that response time which is a second-order click.

This is the explicit modelling seam between retained candidate uptake and
organizational-state change. -/
def OpportunityConditionedEndogenousVortexResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → α)
    (gradient : GradientStream)
    (uptake : UptakeFunction α)
    (maintenance : MaintenanceDemand α)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α) : Prop :=
  ∀ q : ℕ, Opportunity q → ∃ r : ℕ,
    q ≤ r ∧
    r ≤ q + lag ∧
    ResourceValidatedSuccessAt
      Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      U H E S r ∧
    SecondOrderClick Step Viable targets Search (state r) (state (r + 1))

/-- Forgetting the second-order update recovers the endogenous bounded-response
premise already used by the validated-uptake theorems. -/
theorem endogenousVortexResponseWithin_implies_endogenousResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → α)
    (gradient : GradientStream)
    (uptake : UptakeFunction α)
    (maintenance : MaintenanceDemand α)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α)
    (hVortex :
      OpportunityConditionedEndogenousVortexResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta
        U H E S Step Viable targets Search) :
    OpportunityConditionedEndogenousResponseWithin
      lag Opportunity Cost state gradient uptake maintenance beta U H E S := by
  intro q hOpportunity
  obtain ⟨r, hqr, hlag, hSuccess, hClick⟩ := hVortex q hOpportunity
  exact ⟨r, hqr, hlag, hSuccess⟩

/-- Recurring opportunity plus integrated vortex response yields arbitrarily
late second-order organizational updates. -/
theorem recurringOpportunity_and_endogenousVortexResponse_imply_recurringSecondOrderUpdate
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → α)
    (gradient : GradientStream)
    (uptake : UptakeFunction α)
    (maintenance : MaintenanceDemand α)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hVortex :
      OpportunityConditionedEndogenousVortexResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta
        U H E S Step Viable targets Search) :
    RecurringSecondOrderUpdate state Step Viable targets Search := by
  intro n
  obtain ⟨q, hnq, hOpp⟩ := hOpportunity n
  obtain ⟨r, hqr, hlag, hSuccess, hClick⟩ := hVortex q hOpp
  exact ⟨r, le_trans hnq hqr, hClick⟩

/-- Canonical full dynamic consequence theorem.

Under explicit retention and representation assumptions, recurring opportunity
plus an internally funded integrated vortex response gives all three downstream
properties at once:

1. open-ended cumulative retained novelty;
2. unbounded effective distinguishability capacity;
3. arbitrarily late second-order organizational/search updates.

This theorem packages previously separate checked routes into one reviewable
statement. It does not derive the integrated-response premise itself. -/
theorem recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → α)
    (gradient : GradientStream)
    (uptake : UptakeFunction α)
    (maintenance : MaintenanceDemand α)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Search : SearchOperator α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hVortex :
      OpportunityConditionedEndogenousVortexResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta
        U H E S Step Viable targets Search) :
    OpenEndedCumulativeNovelty S ∧
    UnboundedEnvelopeCapacity U ∧
    RecurringSecondOrderUpdate state Step Viable targets Search := by
  have hResponse :
      OpportunityConditionedEndogenousResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta U H E S :=
    endogenousVortexResponseWithin_implies_endogenousResponseWithin
      lag Opportunity Cost state gradient uptake maintenance beta
      U H E S Step Viable targets Search hVortex
  have hOpen :=
    recurringOpportunity_and_endogenousResponseWithin_imply_openEndedNovelty
      lag Opportunity Cost state gradient uptake maintenance beta
      U H E S hRetained hOpportunity hResponse
  have hCapacity :=
    recurringOpportunity_and_endogenousResponseWithin_imply_unboundedEnvelope
      lag Opportunity Cost state gradient uptake maintenance beta
      U H E S hRepresented hRetained hOpportunity hResponse
  have hSecond :=
    recurringOpportunity_and_endogenousVortexResponse_imply_recurringSecondOrderUpdate
      lag Opportunity Cost state gradient uptake maintenance beta
      U H E S Step Viable targets Search hOpportunity hVortex
  exact ⟨hOpen, hCapacity, hSecond⟩

end RecurrentIntegratedResponse

#print axioms dynamicVortexTurn_opens_budget_and_futureSearch
#print axioms endogenousVortexResponseWithin_implies_endogenousResponseWithin
#print axioms recurringOpportunity_and_endogenousVortexResponse_imply_recurringSecondOrderUpdate
#print axioms recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences

end RecursiveAccessibility
end CumulativeAccessibility
