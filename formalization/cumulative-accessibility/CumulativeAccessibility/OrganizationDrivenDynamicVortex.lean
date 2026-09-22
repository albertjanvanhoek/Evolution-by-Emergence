import CumulativeAccessibility.OrganizationDrivenEmergenceRecurrence
import CumulativeAccessibility.EndogenousBudgetBridge

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Dynamic Vortex bridge for organization-driven emergence

The endogenous resource budget is attached only to persistence.

It does not determine whether an organization has a function and does not
determine whether that function is emergent.  Those facts are upstream in
Realizes and EmergentUnder.

The bridge says only:

    opportunity
      -> an emergent organization occurs
      -> the organization satisfies a persistence gate financed from
         organization-dependent uptake-minus-maintenance slack
      -> the organization remains reusable material.

A stronger vocabulary specialization additionally requires that the retained
whole realizes a function absent from all previously retained organization.

Thus resource availability filters persistence, not function.
-/

section EndogenousPersistence

variable {Sigma Organization Context Capacity : Type*}
variable [DecidableEq Organization]

def OpportunityConditionedVocabularyPersistenceWithin
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (state : ℕ -> Sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction Sigma)
    (maintenance : MaintenanceDemand Sigma)
    (beta : ReinvestmentFraction)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization) : Prop :=
  ∀ q : ℕ, Opportunity q ->
    ∃ r parents organization ctx phi,
      q ≤ r ∧
      r ≤ q + lag ∧
      RetainedVocabularyEmergenceAt
        Base Proper Realizes Use Cost
        (EndogenousResponseBudget state gradient uptake maintenance beta)
        Keep O r parents organization ctx phi

theorem recurringOpportunity_and_vocabularyPersistence_imply_recurringVocabulary
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (state : ℕ -> Sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction Sigma)
    (maintenance : MaintenanceDemand Sigma)
    (beta : ReinvestmentFraction)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedVocabularyPersistenceWithin
        lag Opportunity Base Proper Realizes Use Cost
        state gradient uptake maintenance beta Keep O) :
    RecurringRetainedVocabularyEmergence
      Base Proper Realizes Use Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta)
      Keep O := by
  intro n
  obtain ⟨q, hnq, hOpp⟩ := hOpportunity n
  obtain ⟨r, parents, organization, ctx, phi, hqr, hLag, hEvent⟩ :=
    hResponse q hOpp
  exact ⟨r, parents, organization, ctx, phi, le_trans hnq hqr, hEvent⟩

theorem recurringOpportunity_and_vocabularyPersistence_imply_openEndedOrganization
    (lag : ℕ)
    (Opportunity : ℕ -> Prop)
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (state : ℕ -> Sigma)
    (gradient : GradientStream)
    (uptake : UptakeFunction Sigma)
    (maintenance : MaintenanceDemand Sigma)
    (beta : ReinvestmentFraction)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (hRetained : ∀ t, O t ⊆ O (t + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedVocabularyPersistenceWithin
        lag Opportunity Base Proper Realizes Use Cost
        state gradient uptake maintenance beta Keep O) :
    OpenEndedCumulativeNovelty O := by
  exact recurringVocabularyEmergence_implies_openEndedOrganization
    Base Proper Realizes Use Cost
    (EndogenousResponseBudget state gradient uptake maintenance beta)
    Keep O hRetained
    (recurringOpportunity_and_vocabularyPersistence_imply_recurringVocabulary
      lag Opportunity Base Proper Realizes Use Cost
      state gradient uptake maintenance beta Keep O
      hOpportunity hResponse)

end EndogenousPersistence

#print axioms recurringOpportunity_and_vocabularyPersistence_imply_recurringVocabulary
#print axioms recurringOpportunity_and_vocabularyPersistence_imply_openEndedOrganization

end RecursiveAccessibility
end CumulativeAccessibility
