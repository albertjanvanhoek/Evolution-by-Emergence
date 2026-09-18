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

/-- Complete successful validated uptake event at one indexed time. This
factors the success condition from the opportunity predicate so recurrence,
response strength, and coincidence can be compared explicitly. -/
def ValidatedSuccessAt
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (m : ℕ) : Prop :=
  ∃ z,
    z ∈ U m ∧
    z ∉ S m ∧
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) z ∧
    E m z ∧
    z ∈ S (m + 1)

/-- Whenever an opportunity is present, the current architecture realizes at
least one genuinely new, distinguishable, generable, externally accepted, and
retained candidate.

This remains an explicit strong coupling premise: maintenance keeps the
organization available for further interaction, but does not by itself imply
novelty, validation, or learning. -/
def OpportunityConditionedValidatedRealization
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ m : ℕ, Opportunity m → ValidatedSuccessAt U H E S m

/-- Recurrently successful opportunity-response coincidence. From every
horizon there is a later time at which the declared opportunity is present and
a complete validated uptake event succeeds.

This is weaker than requiring success at every opportunity, but stronger than
separate recurrence of opportunities and successes. -/
def RecurringValidatedResponse
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ m : ℕ,
    n ≤ m ∧ Opportunity m ∧ ValidatedSuccessAt U H E S m

/-- Explicit declaration that a support predicate is sufficient for the chosen
opportunity predicate. Persistent quantitative support cannot imply recurrence
of an arbitrary opportunity stream without such a connection. -/
def SupportImpliesOpportunity
    (Support Opportunity : ℕ → Prop) : Prop :=
  ∀ n, Support n → Opportunity n

/-- Recurrent successful coincidence implies recurrent opportunity. -/
theorem recurringValidatedResponse_implies_recurringOpportunity
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hResponse : RecurringValidatedResponse Opportunity U H E S) :
    RecurringOpportunity Opportunity := by
  intro n
  obtain ⟨m, hnm, hOpportunity, hSuccess⟩ := hResponse n
  exact ⟨m, hnm, hOpportunity⟩

/-- Recurrent successful coincidence already contains arbitrarily late
validated uptake; forgetting the opportunity witness gives G. -/
theorem recurringValidatedResponse_implies_validatedUptake
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hResponse : RecurringValidatedResponse Opportunity U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  intro n
  obtain ⟨m, hnm, hOpportunity, z, hzU, hzNot, hGen, hEval, hzNext⟩ :=
    hResponse n
  exact ⟨m, z, hnm, hzU, hzNot, hGen, hEval, hzNext⟩

/-- Recurring opportunity plus success at every opportunity implies recurrent
successful coincidence. This is the precise Q ∧ V -> W step. -/
theorem recurringOpportunity_and_validatedRealization_imply_recurringValidatedResponse
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : RecurringOpportunity Opportunity)
    (hResponse :
      OpportunityConditionedValidatedRealization Opportunity U H E S) :
    RecurringValidatedResponse Opportunity U H E S := by
  intro n
  obtain ⟨m, hnm, hOpp⟩ := hOpportunity n
  exact ⟨m, hnm, hOpp, hResponse m hOpp⟩

/-- Persistent support supplies recurrent opportunity only through an explicit
support-to-opportunity connection. -/
theorem persistentSupport_and_connection_imply_recurringOpportunity
    (Support Opportunity : ℕ → Prop)
    (hSupport : ∀ n, Support n)
    (hConnection : SupportImpliesOpportunity Support Opportunity) :
    RecurringOpportunity Opportunity := by
  intro n
  exact ⟨n, le_rfl, hConnection n (hSupport n)⟩

/-- Recurring opportunities plus success at every opportunity imply the
packaged validated-generative-uptake condition through recurrent successful
coincidence. -/
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
  exact recurringValidatedResponse_implies_validatedUptake
    Opportunity U H E S
    (recurringOpportunity_and_validatedRealization_imply_recurringValidatedResponse
      Opportunity U H E S hOpportunity hResponse)

/-- With monotone retention, recurrent successful coincidence is sufficient for
open-ended cumulative retained novelty: R ∧ W -> N via W -> G. -/
theorem recurringValidatedResponse_implies_openEndedNovelty
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hResponse : RecurringValidatedResponse Opportunity U H E S) :
    OpenEndedCumulativeNovelty S := by
  exact validatedGenerativeCapacityUptake_implies_openEndedNovelty
    U H E S hRetained
    (recurringValidatedResponse_implies_validatedUptake
      Opportunity U H E S hResponse)

/-- With representation and retention, recurrent successful coincidence also
forces unbounded envelope capacity. The assumptions remain explicit:
P ∧ R ∧ W -> C. -/
theorem recurringValidatedResponse_implies_unboundedEnvelope
    (Opportunity : ℕ → Prop)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hResponse : RecurringValidatedResponse Opportunity U H E S) :
    UnboundedEnvelopeCapacity U := by
  exact validatedGenerativeCapacityUptake_implies_unboundedEnvelope
    U H E S hRepresented hRetained
    (recurringValidatedResponse_implies_validatedUptake
      Opportunity U H E S hResponse)

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

/-- Quantitative support stream supplied by the canonical three-cycle lower
bound. Unlike the Boolean opportunity predicate, this retains the actual
positive support vector through cycle3SupportedBy. -/
def cycle3MaintenanceSupport
    (rA rB rC kAB kBC kCA : ℝ) : ℕ → Prop :=
  fun n =>
    CollectiveAlignment.cycle3SupportedBy
      (CollectiveAlignment.cycle3CanonicalState rB rC kAB kBC)
      (CollectiveAlignment.cycle3Trajectory rA rB rC kAB kBC kCA n)

/-- The non-strict product threshold suffices to preserve the strictly positive
canonical support vector at every time. -/
theorem cycle3MaintenanceSupport_persistent
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA) :
    ∀ n, cycle3MaintenanceSupport rA rB rC kAB kBC kCA n := by
  intro n
  simpa [cycle3MaintenanceSupport] using
    (CollectiveAlignment.cycle3Trajectory_supported_by_canonical
      hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop n)

/-- For the historical positivity-based opportunity stream, quantitative
support is an explicit sufficient condition for opportunity. -/
theorem cycle3MaintenanceSupport_implies_opportunity
    (rA rB rC kAB kBC kCA : ℝ) :
    SupportImpliesOpportunity
      (cycle3MaintenanceSupport rA rB rC kAB kBC kCA)
      (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA) := by
  intro n hSupport
  unfold cycle3MaintenanceSupport at hSupport
  unfold cycle3MaintenanceOpportunity
  unfold CollectiveAlignment.cycle3MaintenanceAvailable
  exact CollectiveAlignment.cycle3SupportedBy_implies_positive hSupport

/-- A maintained positive support floor yields recurrent opportunity for any
chosen opportunity predicate only when an explicit support-to-opportunity
connection is supplied. -/
theorem supportedCycle3Maintenance_supplies_recurringOpportunity
    (Opportunity : ℕ → Prop)
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA)
    (hConnection :
      SupportImpliesOpportunity
        (cycle3MaintenanceSupport rA rB rC kAB kBC kCA)
        Opportunity) :
    RecurringOpportunity Opportunity := by
  exact persistentSupport_and_connection_imply_recurringOpportunity
    (cycle3MaintenanceSupport rA rB rC kAB kBC kCA)
    Opportunity
    (cycle3MaintenanceSupport_persistent
      hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop)
    hConnection

/-- The existing positivity opportunity stream is therefore recurrent already
under the non-strict replacement threshold, because the support-to-opportunity
connection is proved explicitly. -/
theorem cycle3Maintenance_supplies_recurringOpportunity
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA) :
    RecurringOpportunity
      (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA) := by
  exact supportedCycle3Maintenance_supplies_recurringOpportunity
    (cycle3MaintenanceOpportunity rA rB rC kAB kBC kCA)
    hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop
    (cycle3MaintenanceSupport_implies_opportunity
      rA rB rC kAB kBC kCA)

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
  exact cycle3Maintenance_supplies_recurringOpportunity
    hrA hrB hrC hdB hdC hkAB hkBC (le_of_lt hkCA) (le_of_lt hloop)

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
is one sufficient coupling condition; this witness does not establish its necessity. -/
theorem recurringOpportunity_alone_does_not_imply_openEndedNovelty :
    RecurringOpportunity alwaysOpportunity ∧
      ¬ OpenEndedCumulativeNovelty staticRepertoire := by
  exact ⟨alwaysOpportunity_is_recurring,
    unboundedCapacity_without_openEndedNovelty.2⟩

end Separation

#print axioms recurringValidatedResponse_implies_recurringOpportunity
#print axioms recurringValidatedResponse_implies_validatedUptake
#print axioms recurringOpportunity_and_validatedRealization_imply_recurringValidatedResponse
#print axioms persistentSupport_and_connection_imply_recurringOpportunity
#print axioms recurringValidatedResponse_implies_openEndedNovelty
#print axioms recurringValidatedResponse_implies_unboundedEnvelope
#print axioms recurringOpportunity_and_validatedRealization_imply_validatedUptake
#print axioms recurringOpportunity_and_validatedRealization_imply_openEndedNovelty
#print axioms recurringOpportunity_and_validatedRealization_imply_unboundedEnvelope
#print axioms cycle3MaintenanceSupport_persistent
#print axioms cycle3MaintenanceSupport_implies_opportunity
#print axioms supportedCycle3Maintenance_supplies_recurringOpportunity
#print axioms cycle3Maintenance_supplies_recurringOpportunity
#print axioms strictCycle3Maintenance_supplies_recurringOpportunity
#print axioms strictCycle3Maintenance_and_validatedResponse_imply_openEndedNovelty
#print axioms strictCycle3Maintenance_and_validatedResponse_imply_unboundedEnvelope
#print axioms alwaysOpportunity_is_recurring
#print axioms recurringOpportunity_alone_does_not_imply_openEndedNovelty

end RecursiveAccessibility
end CumulativeAccessibility
