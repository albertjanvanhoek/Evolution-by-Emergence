import CumulativeAccessibility.OrganizationDrivenEmergence
import CumulativeAccessibility.RecursiveEmergence

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Recurrence of organization-driven emergence

This file keeps two temporal claims separate:

1. linked lineage: a retained emergent organization is explicitly reused as a
   causal parent of a later emergent organization;
2. recurrence: emergent persistence events occur arbitrarily late.

The state variable is retained organization.  Functions remain properties of
organizations through Realizes; no function-state or certification state is
introduced.
-/

section LinkedLineage

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

/-- Binary recursive link: the designated retained parent participates in the
exact parent set of the next organization-driven emergence event. -/
def OrganizationEmergenceStepAt
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (parent child : Organization) : Prop :=
  ∃ parents ctx phi,
    parent ∈ parents ∧
    EmergentOrganizationPersistenceAt
      Base Proper Realizes Use Cost Budget Keep O
      t parents child ctx phi

abbrev OrganizationEmergenceChain
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (start : ℕ)
    (seed : Organization)
    (n : ℕ)
    (endpoint : Organization) : Prop :=
  TimedRecursiveChain
    (OrganizationEmergenceStepAt
      Base Proper Realizes Use Cost Budget Keep O)
    start seed n endpoint

theorem organizationEmergenceChain_endpoint_retained
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (start : ℕ)
    (seed : Organization)
    {n : ℕ}
    {endpoint : Organization}
    (hSeed : seed ∈ O start)
    (hChain :
      OrganizationEmergenceChain
        Base Proper Realizes Use Cost Budget Keep O
        start seed n endpoint) :
    endpoint ∈ O (start + n) := by
  induction hChain with
  | base =>
      simpa using hSeed
  | @step n parent child hPrefix hLink ih =>
      rcases hLink with ⟨parents, ctx, phi, hParent, hEvent⟩
      simpa [Nat.add_assoc] using
        (emergentOrganization_retained
          Base Proper Realizes Use Cost Budget Keep O
          (start + n) hEvent)

end LinkedLineage

section Recurrence

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

def RecurringEmergentOrganizationPersistence
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization) : Prop :=
  ∀ n : ℕ, ∃ t parents organization ctx phi,
    n ≤ t ∧
    EmergentOrganizationPersistenceAt
      Base Proper Realizes Use Cost Budget Keep O
      t parents organization ctx phi

def RecurringRetainedVocabularyEmergence
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization) : Prop :=
  ∀ n : ℕ, ∃ t parents organization ctx phi,
    n ≤ t ∧
    RetainedVocabularyEmergenceAt
      Base Proper Realizes Use Cost Budget Keep O
      t parents organization ctx phi

theorem recurringVocabularyEmergence_implies_recurringOrganizationEmergence
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (h :
      RecurringRetainedVocabularyEmergence
        Base Proper Realizes Use Cost Budget Keep O) :
    RecurringEmergentOrganizationPersistence
      Base Proper Realizes Use Cost Budget Keep O := by
  intro n
  obtain ⟨t, parents, organization, ctx, phi, hnt, hEvent⟩ := h n
  exact ⟨t, parents, organization, ctx, phi, hnt, hEvent.1⟩

/-- Recurrent emergence-and-persistence events are non-vacuously recurrent
retained-novelty events at the organization level. -/
theorem recurringOrganizationEmergence_implies_eventualNovelUptake
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (h :
      RecurringEmergentOrganizationPersistence
        Base Proper Realizes Use Cost Budget Keep O) :
    EventualNovelUptake (fun t => O (t + 1)) O := by
  intro n
  obtain ⟨t, parents, organization, ctx, phi, hnt, hEvent⟩ := h n
  have hNew : organization ∉ O t := hEvent.2.2.2.2.2.1
  have hNext : organization ∈ O (t + 1) :=
    emergentOrganization_retained
      Base Proper Realizes Use Cost Budget Keep O t hEvent
  exact ⟨t, organization, hnt, hNext, hNew, hNext⟩

theorem recurringOrganizationEmergence_implies_openEndedOrganization
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (hRetained : ∀ t, O t ⊆ O (t + 1))
    (h :
      RecurringEmergentOrganizationPersistence
        Base Proper Realizes Use Cost Budget Keep O) :
    OpenEndedCumulativeNovelty O := by
  exact eventualNovelUptake_implies_openEndedNovelty
    (fun t => O (t + 1)) O hRetained
    (recurringOrganizationEmergence_implies_eventualNovelUptake
      Base Proper Realizes Use Cost Budget Keep O h)

theorem recurringVocabularyEmergence_implies_openEndedOrganization
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (hRetained : ∀ t, O t ⊆ O (t + 1))
    (h :
      RecurringRetainedVocabularyEmergence
        Base Proper Realizes Use Cost Budget Keep O) :
    OpenEndedCumulativeNovelty O := by
  exact recurringOrganizationEmergence_implies_openEndedOrganization
    Base Proper Realizes Use Cost Budget Keep O hRetained
    (recurringVocabularyEmergence_implies_recurringOrganizationEmergence
      Base Proper Realizes Use Cost Budget Keep O h)

end Recurrence

#print axioms organizationEmergenceChain_endpoint_retained
#print axioms recurringVocabularyEmergence_implies_recurringOrganizationEmergence
#print axioms recurringOrganizationEmergence_implies_openEndedOrganization
#print axioms recurringVocabularyEmergence_implies_openEndedOrganization

end RecursiveAccessibility
end CumulativeAccessibility
