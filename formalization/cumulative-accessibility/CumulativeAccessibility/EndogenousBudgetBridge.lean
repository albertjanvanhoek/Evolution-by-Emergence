import CumulativeAccessibility.ResponseDynamics

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Endogenous response-budget bridge

The bounded-response layer makes response cost and response budget explicit, but
leaves the budget as an input.  The wider Evolution by Emergence stack already
contains the missing accounting idea: a maintained organization couples to an
external gradient, captures throughput from it, pays recurring maintenance, and
can reinvest the resulting slack.

This file closes that seam without claiming that the external gradient itself is
endogenous.

* the gradient is an external boundary-condition stream;
* uptake depends on the current organizational state and the gradient;
* maintenance demand depends on the current organizational state;
* internal slack is captured throughput minus maintenance demand;
* a declared reinvestment fraction maps internal slack into ResponseBudget.

Thus the usable response budget is endogenous to organization even when the
driving gradient is externally supplied.  Organization can enlarge its own
budget by increasing uptake, decreasing maintenance demand, or both.

A second bridge treats the existing dimensionless cumulative-accessibility
margin M = B/c* - 1 as a response budget in that mechanism-level
specialization.  This is deliberately kept distinct from physical free-energy
slack: both are budgets for future accessibility, but they need not share units
or empirical interpretation.
-/

section PhysicalLedger

variable {σ α : Type*} [DecidableEq α]

/-- External driving gradient or resource-opportunity stream.  The organization
does not create this quantity in the present model. -/
abbrev GradientStream := ℕ → ℝ

/-- Fraction of currently available slack routed into response/search. -/
abbrev ReinvestmentFraction := ℕ → ℝ

/-- Organization-dependent captured throughput from the external gradient. -/
abbrev UptakeFunction (σ : Type*) := σ → ℝ → ℝ

/-- Recurring maintenance demand of the current organizational state. -/
abbrev MaintenanceDemand (σ : Type*) := σ → ℝ

/-- Signed internally available slack at one indexed time:
captured gradient throughput minus recurring maintenance demand. -/
def InternalSlackAt
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (t : ℕ) : ℝ :=
  uptake (state t) (gradient t) - maintenance (state t)

/-- Viability at one indexed time means captured throughput covers recurring
maintenance demand. -/
def InternallyViableAt
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (t : ℕ) : Prop :=
  maintenance (state t) ≤ uptake (state t) (gradient t)

/-- The response budget generated inside the organization by routing a declared
fraction of current slack into response/search.

The budget is not a new external stock: it is a function of the current
organizational state, its uptake from the supplied gradient, maintenance demand,
and reinvestment rule. -/
def EndogenousResponseBudget
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction) : ResponseBudget :=
  fun t => beta t * InternalSlackAt state gradient uptake maintenance t

/-- Viability is exactly nonnegative internal slack. -/
theorem internallyViableAt_iff_internalSlack_nonneg
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (t : ℕ) :
    InternallyViableAt state gradient uptake maintenance t
      ↔ 0 ≤ InternalSlackAt state gradient uptake maintenance t := by
  unfold InternallyViableAt InternalSlackAt
  linarith

/-- If the organization is viable and the reinvestment fraction is
nonnegative, the internally generated response budget is nonnegative. -/
theorem endogenousResponseBudget_nonneg
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (t : ℕ)
    (hViable : InternallyViableAt state gradient uptake maintenance t)
    (hBeta : 0 ≤ beta t) :
    0 ≤ EndogenousResponseBudget state gradient uptake maintenance beta t := by
  unfold EndogenousResponseBudget
  exact mul_nonneg hBeta
    ((internallyViableAt_iff_internalSlack_nonneg
      state gradient uptake maintenance t).mp hViable)

/-- At a fixed external gradient, higher captured throughput and no larger
maintenance demand cannot reduce internally available slack.  This is the
formal statement that organization can enlarge its usable budget without
creating the gradient. -/
theorem organization_improvement_increases_internalSlack
    (oldState newState : σ)
    (g : ℝ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (hUptake :
      uptake oldState g ≤ uptake newState g)
    (hMaintenance :
      maintenance newState ≤ maintenance oldState) :
    uptake oldState g - maintenance oldState
      ≤ uptake newState g - maintenance newState := by
  linarith

/-- Pure uptake improvement at a fixed gradient weakly increases slack when
maintenance demand is unchanged. -/
theorem uptake_improvement_increases_internalSlack
    (oldState newState : σ)
    (g : ℝ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (hUptake :
      uptake oldState g ≤ uptake newState g)
    (hMaintenance :
      maintenance newState = maintenance oldState) :
    uptake oldState g - maintenance oldState
      ≤ uptake newState g - maintenance newState := by
  exact organization_improvement_increases_internalSlack
    oldState newState g uptake maintenance hUptake (by simpa [hMaintenance])

/-- Pure maintenance-efficiency improvement at fixed uptake weakly increases
slack. -/
theorem maintenance_efficiency_increases_internalSlack
    (oldState newState : σ)
    (g : ℝ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (hUptake :
      uptake oldState g = uptake newState g)
    (hMaintenance :
      maintenance newState ≤ maintenance oldState) :
    uptake oldState g - maintenance oldState
      ≤ uptake newState g - maintenance newState := by
  exact organization_improvement_increases_internalSlack
    oldState newState g uptake maintenance (by simpa [hUptake]) hMaintenance

/-- With a nonnegative reinvestment fraction, an organizational improvement at
the same external gradient cannot reduce the response budget it generates. -/
theorem organization_improvement_increases_endogenousResponseBudget
    (oldState newState : σ)
    (g beta : ℝ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (hBeta : 0 ≤ beta)
    (hUptake :
      uptake oldState g ≤ uptake newState g)
    (hMaintenance :
      maintenance newState ≤ maintenance oldState) :
    beta * (uptake oldState g - maintenance oldState)
      ≤ beta * (uptake newState g - maintenance newState) := by
  exact mul_le_mul_of_nonneg_left
    (organization_improvement_increases_internalSlack
      oldState newState g uptake maintenance hUptake hMaintenance)
    hBeta

/-- Resource feasibility is monotone in the available response budget. -/
theorem resourceFeasibleAt_mono_budget
    (Cost : ResponseCost α)
    (oldBudget newBudget : ResponseBudget)
    (t : ℕ)
    (z : α)
    (hBudget : oldBudget t ≤ newBudget t)
    (hOld : ResourceFeasibleAt Cost oldBudget t z) :
    ResourceFeasibleAt Cost newBudget t z := by
  unfold ResourceFeasibleAt AccessibleByCost at hOld ⊢
  exact le_trans hOld hBudget

/-- A strict increase in usable response budget opens a nonempty interval of
response costs that were unaffordable before and affordable afterward. -/
theorem responseBudget_increase_opens_cost_window
    {oldBudget newBudget : ℝ}
    (hIncrease : oldBudget < newBudget) :
    ∃ responseCost : ℝ,
      oldBudget < responseCost ∧ responseCost ≤ newBudget := by
  refine ⟨(oldBudget + newBudget) / 2, ?_, ?_⟩ <;> linarith

/-- Candidate-level crossing form of the budget window theorem. -/
theorem resourceFeasibility_switches_across_budget_window
    (Cost : ResponseCost α)
    (oldBudget newBudget : ResponseBudget)
    (t : ℕ)
    (z : α)
    (hTooExpensive : oldBudget t < Cost t z)
    (hAffordable : Cost t z ≤ newBudget t) :
    ¬ ResourceFeasibleAt Cost oldBudget t z
      ∧ ResourceFeasibleAt Cost newBudget t z := by
  constructor
  · intro hOld
    unfold ResourceFeasibleAt AccessibleByCost at hOld
    exact (not_le_of_gt hTooExpensive) hOld
  · unfold ResourceFeasibleAt AccessibleByCost
    exact hAffordable

/-- Specialization of the local bounded-response premise in which the response
budget is generated from internal slack rather than supplied independently. -/
def OpportunityConditionedEndogenousResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  OpportunityConditionedResourceResponseWithin
    lag Opportunity Cost
    (EndogenousResponseBudget state gradient uptake maintenance beta)
    U H E S

/-- Recurring opportunity plus a bounded response financed from internally
generated slack implies recurrent validated uptake.  The resource budget is no
longer an independent input; the successful response premise remains explicit. -/
theorem recurringOpportunity_and_endogenousResponseWithin_imply_validatedUptake
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEndogenousResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  exact recurringOpportunity_and_resourceResponseWithin_imply_validatedUptake
    lag Opportunity Cost
    (EndogenousResponseBudget state gradient uptake maintenance beta)
    U H E S hOpportunity hResponse

/-- Adding retention gives open-ended cumulative retained novelty through the
same downstream theorem; no retention premise is hidden by the budget bridge. -/
theorem recurringOpportunity_and_endogenousResponseWithin_imply_openEndedNovelty
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEndogenousResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta U H E S) :
    OpenEndedCumulativeNovelty S := by
  exact validatedGenerativeCapacityUptake_implies_openEndedNovelty
    U H E S hRetained
    (recurringOpportunity_and_endogenousResponseWithin_imply_validatedUptake
      lag Opportunity Cost state gradient uptake maintenance beta
      U H E S hOpportunity hResponse)

/-- Representation plus retention gives unbounded envelope capacity, with the
same assumptions kept explicit. -/
theorem recurringOpportunity_and_endogenousResponseWithin_imply_unboundedEnvelope
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEndogenousResponseWithin
        lag Opportunity Cost state gradient uptake maintenance beta U H E S) :
    UnboundedEnvelopeCapacity U := by
  exact validatedGenerativeCapacityUptake_implies_unboundedEnvelope
    U H E S hRepresented hRetained
    (recurringOpportunity_and_endogenousResponseWithin_imply_validatedUptake
      lag Opportunity Cost state gradient uptake maintenance beta
      U H E S hOpportunity hResponse)

end PhysicalLedger

section MarginSpecialization

/-- Mechanism-level specialization that routes a nonnegative fraction of the
existing cumulative-accessibility margin M = B/c* - 1 into response budget.

This is not an assertion that dimensionless margin is physical free energy; it
is a bridge internal to the shared-budget accessibility specialization. -/
noncomputable def MarginFundedResponseBudget
    (beta budget : ℝ)
    (bindingCost : ℕ → ℝ) : ResponseBudget :=
  fun t => beta * Margin budget (bindingCost t)

/-- If cumulative-accessibility margin rises and its coupling to response is
nonnegative, the margin-funded response budget cannot fall. -/
theorem margin_increase_increases_marginFundedResponseBudget
    {beta budget oldBinding newBinding : ℝ}
    (hBeta : 0 ≤ beta)
    (hMargin :
      Margin budget oldBinding ≤ Margin budget newBinding) :
    beta * Margin budget oldBinding
      ≤ beta * Margin budget newBinding := by
  exact mul_le_mul_of_nonneg_left hMargin hBeta

/-- A strict increase of nonnegative cumulative-accessibility margin opens a
strictly positive interval of response costs that the earlier organization
cannot fund and the later organization can. -/
theorem margin_increase_opens_response_cost_window
    {budget oldBinding newBinding : ℝ}
    (hOldMargin : 0 ≤ Margin budget oldBinding)
    (hIncrease :
      Margin budget oldBinding < Margin budget newBinding) :
    ∃ responseCost : ℝ,
      0 ≤ responseCost ∧
      Margin budget oldBinding < responseCost ∧
      responseCost ≤ Margin budget newBinding := by
  exact margin_increase_opens_coupling_window hOldMargin hIncrease

end MarginSpecialization

#print axioms internallyViableAt_iff_internalSlack_nonneg
#print axioms endogenousResponseBudget_nonneg
#print axioms organization_improvement_increases_internalSlack
#print axioms uptake_improvement_increases_internalSlack
#print axioms maintenance_efficiency_increases_internalSlack
#print axioms organization_improvement_increases_endogenousResponseBudget
#print axioms resourceFeasibleAt_mono_budget
#print axioms responseBudget_increase_opens_cost_window
#print axioms resourceFeasibility_switches_across_budget_window
#print axioms recurringOpportunity_and_endogenousResponseWithin_imply_validatedUptake
#print axioms recurringOpportunity_and_endogenousResponseWithin_imply_openEndedNovelty
#print axioms recurringOpportunity_and_endogenousResponseWithin_imply_unboundedEnvelope
#print axioms margin_increase_increases_marginFundedResponseBudget
#print axioms margin_increase_opens_response_cost_window

end RecursiveAccessibility
end CumulativeAccessibility
