import CumulativeAccessibility.ValidatedUptake
import MaintenanceDynamics

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Maintenance opportunity bridge

The repository's maintenance-reproduction formalization establishes finite
algebraic conditions under which recurrent maintenance loops have positive
replacement/growth witnesses. `MaintenanceDynamics.lean` promotes the concrete
three-cycle witness to a time-indexed positive trajectory and proves arbitrarily
late maintenance availability under explicit sign and closed-loop assumptions.

This file connects that result to the cumulative-accessibility stack without
identifying persistence with learning. A separate response condition states what
the generative/validation system does when a maintenance opportunity occurs.
Together they imply the validated-uptake condition from `ValidatedUptake.lean`.

The resulting architecture is

    strict closed maintenance loop
      -> arbitrarily late maintenance availability
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

This remains an explicit coupling premise: maintenance keeps the organization
available for further interaction, but does not by itself imply novelty,
validation, or learning. -/
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

section ConcreteThreeCycleBridge

variable {α : Type*} [DecidableEq α]

/-- The concrete opportunity stream supplied by the maintained three-cycle
trajectory: an opportunity is present exactly when all three maintained
components of the canonical trajectory are strictly positive. -/
def cycle3MaintenanceOpportunity
    (rA rB rC kAB kBC kCA : ℝ) : ℕ → Prop :=
  fun n => CollectiveAlignment.cycle3MaintenanceAvailable
    rA rB rC kAB kBC kCA n

/-- The strict three-cycle maintenance conditions discharge the abstract
`RecurringOpportunity` premise.  This is the machine-checked cross-package
bridge from maintenance dynamics to the accessibility interface. -/
theorem strictCycle3Maintenance_supplies_recurringOpportunity
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdA : 0 < CollectiveAlignment.maintenanceDeficit rA)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC) (hkCA : 0 < kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        < kAB * kBC * kCA) :
    RecurringOpportunity
      (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA) := by
  intro n
  obtain ⟨m, hnm, havail⟩ :=
    CollectiveAlignment.cycle3_strict_loop_has_arbitrarily_late_availability
      hrA hrB hrC hdA hdB hdC hkAB hkBC hkCA hloop n
  exact ⟨m, hnm, by
    simpa [cycle3MaintenanceOpportunity] using havail⟩

/-- Cross-stack theorem: a strict positive three-cycle maintenance process,
plus a validated realization response whenever that maintained process is
available, is sufficient for open-ended cumulative retained novelty. -/
theorem strictCycle3Maintenance_and_validatedResponse_imply_openEndedNovelty
    {rA rB rC kAB kBC kCA : ℝ}
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdA : 0 < CollectiveAlignment.maintenanceDeficit rA)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC) (hkCA : 0 < kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        < kAB * kBC * kCA)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hResponse : OpportunityConditionedValidatedRealization
      (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA) U H E S) :
    OpenEndedCumulativeNovelty S := by
  apply recurringOpportunity_and_validatedRealization_imply_openEndedNovelty
    (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA)
    U H E S hRetained
  · exact strictCycle3Maintenance_supplies_recurringOpportunity
      hrA hrB hrC hdA hdB hdC hkAB hkBC hkCA hloop
  · exact hResponse

/-- With representation of retained organization inside the current envelope,
the same concrete maintenance-to-validation chain also forces unbounded
distinguishability capacity. -/
theorem strictCycle3Maintenance_and_validatedResponse_imply_unboundedEnvelope
    {rA rB rC kAB kBC kCA : ℝ}
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdA : 0 < CollectiveAlignment.maintenanceDeficit rA)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC) (hkCA : 0 < kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        < kAB * kBC * kCA)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hResponse : OpportunityConditionedValidatedRealization
      (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA) U H E S) :
    UnboundedEnvelopeCapacity U := by
  apply recurringOpportunity_and_validatedRealization_imply_unboundedEnvelope
    (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA)
    U H E S hRepresented hRetained
  · exact strictCycle3Maintenance_supplies_recurringOpportunity
      hrA hrB hrC hdA hdB hdC hkAB hkBC hkCA hloop
  · exact hResponse

end ConcreteThreeCycleBridge

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
#print axioms strictCycle3Maintenance_supplies_recurringOpportunity
#print axioms strictCycle3Maintenance_and_validatedResponse_imply_openEndedNovelty
#print axioms strictCycle3Maintenance_and_validatedResponse_imply_unboundedEnvelope
#print axioms alwaysOpportunity_is_recurring
#print axioms recurringOpportunity_alone_does_not_imply_openEndedNovelty

end RecursiveAccessibility
end CumulativeAccessibility
