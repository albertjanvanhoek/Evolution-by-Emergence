import CumulativeAccessibility.OrganizationDrivenEmergenceWitness

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Adversarial probes for organization-driven emergence

These probes encode the conceptual corrections that motivated the organization-
first rewrite.
-/

section ContextExpression

/-- One retained organization; context determines whether it realizes the
declared function.  No weights/rules/state are rewritten. -/
def contextExpressionRealizes :
    CapacityRelation Bool Bool Unit :=
  fun organization ctx _ => organization = true ∧ ctx = true

def contextExpressionRetained : Bool -> Prop :=
  fun organization => organization = true

theorem same_retained_organization_context_changes_expressed_function :
    FunctionAvailable
        contextExpressionRealizes true
        contextExpressionRetained () ∧
    ¬ FunctionAvailable
        contextExpressionRealizes false
        contextExpressionRetained () := by
  constructor
  · exact ⟨true, rfl, ⟨rfl, rfl⟩⟩
  · rintro ⟨organization, hRetained, hRealizes⟩
    exact Bool.noConfusion hRealizes.2

end ContextExpression

section ConceptualKnockouts

/-- A function can exist at the emergent-organization layer independently of
whether a later persistence gate succeeds. -/
theorem organizationProbe_function_is_upstream_of_persistence
    (t : ℕ) :
    organizationLadderRealizes
      (organizationLadderWhole t) () (t + 2) :=
  organizationLadder_function_exists_before_persistence t

/-- Non-emergence does not disable function. -/
theorem organizationProbe_nonEmergent_whole_still_functions
    (t : ℕ) :
    organizationLadderNonEmergentRealizes
      (organizationLadderWhole t) () (t + 2) :=
  organizationLadder_nonEmergent_whole_still_functions t

/-- In the non-emergent twin the same function is already available through a
retained proper part, so the whole contributes no new functional vocabulary. -/
theorem organizationProbe_nonEmergence_means_not_functionally_novel
    (t : ℕ) :
    ¬ FunctionallyNovelToRetainedSystem
      organizationLadderNonEmergentRealizes ()
      organizationLadderRetained t (t + 2) :=
  organizationLadder_nonEmergent_not_functionally_novel t

/-- The positive ladder separates the same concepts in the other direction:
the whole's function is genuinely new to the retained system. -/
theorem organizationProbe_emergent_whole_adds_functional_vocabulary
    (t : ℕ) :
    FunctionallyNovelToRetainedSystem
      organizationLadderRealizes ()
      organizationLadderRetained t (t + 2) :=
  organizationLadder_function_novel t

/-- Retention of the emergent whole then makes that already-existing function
available without any additional certification state. -/
theorem organizationProbe_persistence_makes_function_available
    (t : ℕ) :
    FunctionAvailable
      organizationLadderRealizes ()
      (fun x => x ∈ organizationLadderRetained (t + 1))
      (t + 2) := by
  exact emergentOrganization_function_available_after_persistence
    organizationLadderBase organizationLadderProper
    organizationLadderRealizes organizationLadderUse
    organizationLadderCost organizationLadderBudget organizationLadderKeep
    organizationLadderRetained t
    (organizationLadder_event t)

end ConceptualKnockouts

#print axioms same_retained_organization_context_changes_expressed_function
#print axioms organizationProbe_function_is_upstream_of_persistence
#print axioms organizationProbe_nonEmergent_whole_still_functions
#print axioms organizationProbe_nonEmergence_means_not_functionally_novel
#print axioms organizationProbe_emergent_whole_adds_functional_vocabulary
#print axioms organizationProbe_persistence_makes_function_available

end RecursiveAccessibility
end CumulativeAccessibility
