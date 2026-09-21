import CumulativeAccessibility.EmergenceDrivenRecursionOpenEnded
import CumulativeAccessibility.EndogenousBudgetBridge

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Emergence-driven Dynamic Vortex bridge

This module reattaches the resource-fed Dynamic Vortex layer beneath the strong
emergence-driven recursion event.

The earlier DynamicVortex interface paired two simultaneous premises:

    resource-validated retained response
    AND
    second-order accessibility click.

Here the resource budget is instead instantiated directly inside the strong
emergence event:

    parent-faithful compositional emergence
      + feasibility under endogenous slack budget
      + external validation
      + retained integration
      + repertoire-dependent generator change
      + strict full-closure expansion.

The coupling from opportunity to such an event remains an explicit modelling
premise. Maintenance or resource slack alone is not claimed to cause
innovation.
-/

section EndogenousStrongResponse

variable {σ Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Bounded response to an opportunity by a *strong* emergence-driven
vocabulary event whose resource feasibility is evaluated against the response
budget generated from current uptake-minus-maintenance slack. -/
def OpportunityConditionedEmergenceDrivenVocabularyResponseWithin
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity) : Prop :=
  ∀ q : ℕ, Opportunity q → ∃ r parent child,
    q ≤ r ∧
    r ≤ q + lag ∧
    EmergenceDrivenVocabularyExpansionAt
      targets RuleOf Realizes Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      E S r parent child

/-- Recurring opportunities plus bounded strong responses imply that strong
emergence-driven vocabulary-expansion events recur arbitrarily late. -/
theorem recurringOpportunity_and_emergenceDrivenResponse_imply_recurringVocabularyExpansion
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEmergenceDrivenVocabularyResponseWithin
        lag Opportunity targets RuleOf Realizes Cost
        state gradient uptake maintenance beta E S) :
    RecurringEmergenceDrivenVocabularyExpansion
      targets RuleOf Realizes Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      E S := by
  intro n
  obtain ⟨q, hnq, hOpp⟩ := hOpportunity n
  obtain ⟨r, parent, child, hqr, hLag, hEvent⟩ := hResponse q hOpp
  exact ⟨r, parent, child, le_trans hnq hqr, hEvent⟩

/-- Resource-fed strong EbE recurrence is sufficient for open-ended retained
novelty under monotone retention.

The theorem keeps the causal firewall explicit: recurring opportunity does not
imply the response premise. -/
theorem recurringOpportunity_and_emergenceDrivenResponse_imply_openEndedNovelty
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEmergenceDrivenVocabularyResponseWithin
        lag Opportunity targets RuleOf Realizes Cost
        state gradient uptake maintenance beta E S) :
    OpenEndedCumulativeNovelty S := by
  exact
    recurringEmergenceDrivenVocabularyExpansion_implies_openEndedNovelty
      targets RuleOf Realizes Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      E S hRetained
      (recurringOpportunity_and_emergenceDrivenResponse_imply_recurringVocabularyExpansion
        lag Opportunity targets RuleOf Realizes Cost
        state gradient uptake maintenance beta E S
        hOpportunity hResponse)

/-- With representation of active retained organization in a moving envelope,
the same resource-fed strong recurrence forces unbounded envelope capacity. -/
theorem recurringOpportunity_and_emergenceDrivenResponse_imply_unboundedEnvelope
    (lag : ℕ)
    (Opportunity : ℕ → Prop)
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (E : ExternalCriterion Capacity)
    (S U : ℕ → Finset Capacity)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedEmergenceDrivenVocabularyResponseWithin
        lag Opportunity targets RuleOf Realizes Cost
        state gradient uptake maintenance beta E S) :
    UnboundedEnvelopeCapacity U := by
  exact
    recurringEmergenceDrivenVocabularyExpansion_implies_unboundedEnvelope
      targets RuleOf Realizes Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      E S U hRepresented hRetained
      (recurringOpportunity_and_emergenceDrivenResponse_imply_recurringVocabularyExpansion
        lag Opportunity targets RuleOf Realizes Cost
        state gradient uptake maintenance beta E S
        hOpportunity hResponse)

end EndogenousStrongResponse

#print axioms recurringOpportunity_and_emergenceDrivenResponse_imply_recurringVocabularyExpansion
#print axioms recurringOpportunity_and_emergenceDrivenResponse_imply_openEndedNovelty
#print axioms recurringOpportunity_and_emergenceDrivenResponse_imply_unboundedEnvelope

end RecursiveAccessibility
end CumulativeAccessibility
