import CumulativeAccessibility.ValidatedUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Maintenance opportunity bridge

The repository's maintenance-reproduction formalization establishes finite
algebraic conditions under which recurrent maintenance loops have positive
replacement/growth witnesses.  Those results do not, by themselves, imply that
a maintained organization generates, externally validates, and retains novel
organization.

This file therefore formalizes the missing *interface* rather than asserting an
unproved cross-domain implication.

A maintenance process may supply arbitrarily late opportunities.  A separate
response condition states what the generative/validation system does when such
an opportunity occurs.  Together they imply the validated-uptake condition from
`ValidatedUptake.lean`.

This gives the conditional architecture

    recurrent opportunity
      + opportunity-conditioned validated realization
      -> validated generative capacity uptake
      -> open-ended cumulative retained novelty
      -> unbounded distinguishability capacity

under the same retention and representation assumptions as before.
-/

section OpportunityInterface

variable {α : Type*} [DecidableEq α]

/-- Opportunities recur arbitrarily far into the future.  This definition does
not say what physical or organizational mechanism supplies them. -/
def RecurringOpportunity (Opportunity : ℕ → Prop) : Prop :=
  ∀ n : ℕ, ∃ m : ℕ, n ≤ m ∧ Opportunity m

/-- Whenever an opportunity is present, the current architecture realizes at
least one genuinely new, distinguishable, generable, externally accepted, and
retained candidate.

This is the explicit coupling assumption that a maintenance theorem would have
to discharge (or help discharge) before persistence can be used to infer
cumulative learning. -/
def OpportunityConditionedValidatedRealization
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ m : ℕ, Opportunity m → ∃ z,
    z ∈ U m ∧
    z ∉ S m ∧
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) z ∧
    E m z ∧
    z ∈ S (m + 1)

/-- Recurring opportunities plus a validated realization response imply the
packaged validated-generative-uptake condition. -/
theorem recurringOpportunity_and_validatedRealization_imply_validatedUptake
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedValidatedRealization Opportunity U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  intro n
  obtain ⟨m, hnm, hOpp⟩ := hOpportunity n
  obtain ⟨z, hzU, hzNot, hGen, hEval, hzNext⟩ := hResponse m hOpp
  exact ⟨m, z, hnm, hzU, hzNot, hGen, hEval, hzNext⟩

/-- End-to-end conditional theorem at the accessibility level: if maintenance
or another mechanism keeps supplying opportunities and each supplied
opportunity is converted into externally screened retained novelty, then
monotone retention makes cumulative novelty open-ended. -/
theorem recurringOpportunity_and_validatedRealization_imply_openEndedNovelty
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedValidatedRealization Opportunity U H E S) :
    OpenEndedCumulativeNovelty S := by
  apply validatedGenerativeCapacityUptake_implies_openEndedNovelty
    U H E S hRetained
  exact recurringOpportunity_and_validatedRealization_imply_validatedUptake
    Opportunity U H E S hOpportunity hResponse

/-- With representation inside the moving envelope, the same conditional
bridge also forces unbounded distinguishability capacity. -/
theorem recurringOpportunity_and_validatedRealization_imply_unboundedEnvelope
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedValidatedRealization Opportunity U H E S) :
    UnboundedEnvelopeCapacity U := by
  apply validatedGenerativeCapacityUptake_implies_unboundedEnvelope
    U H E S hRepresented hRetained
  exact recurringOpportunity_and_validatedRealization_imply_validatedUptake
    Opportunity U H E S hOpportunity hResponse

end OpportunityInterface

section Separation

/-- A maximally permissive opportunity stream: an opportunity is declared at
every time. -/
def alwaysOpportunity (_n : ℕ) : Prop := True

/-- The always-present opportunity stream trivially satisfies recurrence. -/
theorem alwaysOpportunity_is_recurring :
    RecurringOpportunity alwaysOpportunity := by
  intro n
  exact ⟨n, le_rfl, by simp [alwaysOpportunity]⟩

/-- Recurring opportunity alone is not sufficient for open-ended novelty.
Even opportunities at every time are compatible with the static repertoire from
`OpenEndedCapacity.lean`, which never expands.  The response/coupling premise
is therefore logically necessary for this bridge theorem. -/
theorem recurringOpportunity_alone_does_not_imply_openEndedNovelty :
    RecurringOpportunity alwaysOpportunity ∧
      ¬ OpenEndedCumulativeNovelty staticRepertoire := by
  exact ⟨alwaysOpportunity_is_recurring,
    unboundedCapacity_without_openEndedNovelty.2⟩

end Separation

#print axioms recurringOpportunity_and_validatedRealization_imply_validatedUptake
#print axioms recurringOpportunity_and_validatedRealization_imply_openEndedNovelty
#print axioms recurringOpportunity_and_validatedRealization_imply_unboundedEnvelope
#print axioms alwaysOpportunity_is_recurring
#print axioms recurringOpportunity_alone_does_not_imply_openEndedNovelty

end RecursiveAccessibility
end CumulativeAccessibility
