import CumulativeAccessibility.EmergenceDrivenOperatorRecurrence
import CumulativeAccessibility.EndogenousBudgetBridge

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Dynamic Vortex bridge for emergence-driven operator evolution

This replaces the older pattern

    validated retained response AND second-order click

with one strong event whose pieces have distinct causal roles:

    opportunity
      -> emergent construction
      -> feasibility / validation under endogenous slack budget
      -> Active admission
      -> emergent provenance certification
      -> operator activation
      -> derived full-closure click.

The opportunity-to-success response remains an explicit modelling premise.
Resource slack is not claimed to cause innovation by itself.
-/

section EndogenousOperatorResponse

variable {sigma Context Capacity : Type*}
variable [DecidableEq Capacity]

def OpportunityConditionedEmergenceDrivenOperatorResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ -> sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction sigma)
    (maintenance : MaintenanceDemand sigma)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop) : Prop :=
  ∀ q : ℕ, Opportunity q ->
    ∃ r parents ctx child,
      q ≤ r ∧
      r ≤ q + lag ∧
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost
        (EndogenousResponseBudget state gradient uptake maintenance beta)
        E S Certified r parents ctx child

theorem recurringOpportunity_and_operatorResponse_imply_recurringOperatorEvents
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ -> sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction sigma)
    (maintenance : MaintenanceDemand sigma)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEmergenceDrivenOperatorResponseWithin
        lag Opportunity Base Op Realizes Cost
        state gradient uptake maintenance beta E S Certified) :
    RecurringEmergenceDrivenOperatorEvents
      Base Op Realizes Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      E S Certified := by
  intro n
  obtain ⟨q, hnq, hOpp⟩ := hOpportunity n
  obtain ⟨r, parents, ctx, child, hqr, hLag, hEvent⟩ :=
    hResponse q hOpp
  exact ⟨r, parents, ctx, child, le_trans hnq hqr, hEvent⟩

theorem recurringOpportunity_and_operatorResponse_imply_openEndedNovelty
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ -> sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction sigma)
    (maintenance : MaintenanceDemand sigma)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEmergenceDrivenOperatorResponseWithin
        lag Opportunity Base Op Realizes Cost
        state gradient uptake maintenance beta E S Certified) :
    OpenEndedCumulativeNovelty S := by
  exact recurringOperatorEvents_imply_openEndedNovelty
    Base Op Realizes Cost
    (EndogenousResponseBudget state gradient uptake maintenance beta)
    E S Certified hRetained
    (recurringOpportunity_and_operatorResponse_imply_recurringOperatorEvents
      lag Opportunity Base Op Realizes Cost
      state gradient uptake maintenance beta E S Certified
      hOpportunity hResponse)

theorem recurringOpportunity_and_operatorResponse_imply_unboundedEnvelope
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ -> sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction sigma)
    (maintenance : MaintenanceDemand sigma)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S U : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEmergenceDrivenOperatorResponseWithin
        lag Opportunity Base Op Realizes Cost
        state gradient uptake maintenance beta E S Certified) :
    UnboundedEnvelopeCapacity U := by
  apply openEndedNovelty_implies_unboundedEnvelopeCapacity
    U S hRepresented hRetained
  exact recurringOpportunity_and_operatorResponse_imply_openEndedNovelty
    lag Opportunity Base Op Realizes Cost
    state gradient uptake maintenance beta E S Certified
    hRetained hOpportunity hResponse

end EndogenousOperatorResponse

#print axioms recurringOpportunity_and_operatorResponse_imply_recurringOperatorEvents
#print axioms recurringOpportunity_and_operatorResponse_imply_openEndedNovelty
#print axioms recurringOpportunity_and_operatorResponse_imply_unboundedEnvelope

end RecursiveAccessibility
end CumulativeAccessibility
