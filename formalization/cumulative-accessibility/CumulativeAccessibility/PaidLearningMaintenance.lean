import CumulativeAccessibility.IntelligentLearningMaintenance
import CumulativeAccessibility.PaidRetentionTransfer

namespace CumulativeAccessibility
namespace IntelligentLearning

open RecursiveAccessibility
open FunctionalOrganization
open PaidRetention

variable {α P I : Type*}

/-!
# Paid learning-maintenance processes

The existing intelligent-learning interface maps an internal process state to an
outside accessibility geometry. This module adds the v19 retention ledger to
that interface.

A process/protocol state can improve raw accessibility while still be net
burdensome once its own upkeep is included. The paid geometry therefore adds
process upkeep exactly once before applying the existing viscosity and
budget-window theorems.
-/

/-- Accessibility geometry of a process after its own maintenance burden is
charged exactly once. -/
def PaidProcessGeometry
    (Upkeep : P → ℝ)
    (Γ : ProcessGeometry P α) :
    ProcessGeometry P α :=
  fun p => PaidAccessibilityCost Upkeep p (Γ p)

/-- A learning verb is a paid improvement when the application declares that it
caused the process transition and the total paid accessibility geometry is
strictly less viscous on the declared targets. -/
def PaidVerbImprovementOn
    (targets : Set α)
    (Upkeep : P → ℝ)
    (Γ : ProcessGeometry P α)
    (ApplyVerb : AppliesVerb P)
    (oldState newState : α)
    (oldProcess newProcess : P)
    (verb : LearningVerb) : Prop :=
  VerbImprovementOn
    targets
    (PaidProcessGeometry Upkeep Γ)
    ApplyVerb
    oldState newState
    oldProcess newProcess
    verb

/-- Paid verb improvement opens a common gross-budget threshold. The upkeep of
the process has already been included in the geometry, so no second charge is
introduced here. -/
theorem paidVerbImprovement_opens_grossBudget_window
    (targets : Set α)
    (Upkeep : P → ℝ)
    (Γ : ProcessGeometry P α)
    (ApplyVerb : AppliesVerb P)
    (oldState newState : α)
    (oldProcess newProcess : P)
    (verb : LearningVerb)
    (h :
      PaidVerbImprovementOn
        targets Upkeep Γ ApplyVerb
        oldState newState oldProcess newProcess verb) :
    ∃ z B,
      z ∈ targets ∧
      ¬ AccessibleWithin
        (PaidProcessGeometry Upkeep Γ oldProcess)
        B oldState z ∧
      AccessibleWithin
        (PaidProcessGeometry Upkeep Γ newProcess)
        B newState z := by
  exact verbImprovement_opens_budget_window
    targets
    (PaidProcessGeometry Upkeep Γ)
    ApplyVerb
    oldState newState
    oldProcess newProcess
    verb h

/-- At one target, a raw run-cost saving pays for increased process upkeep
exactly when the resulting paid cost is lower. -/
theorem rawSaving_exceeds_upkeep_iff_paidTargetCheaper
    (Upkeep : P → ℝ)
    (Γ : ProcessGeometry P α)
    (oldState newState y : α)
    (oldProcess newProcess : P) :
    (Upkeep newProcess - Upkeep oldProcess) +
        Γ newProcess newState y <
      Γ oldProcess oldState y
      ↔
    PaidProcessGeometry Upkeep Γ newProcess newState y <
      PaidProcessGeometry Upkeep Γ oldProcess oldState y := by
  unfold PaidProcessGeometry PaidAccessibilityCost
  constructor <;> intro h <;> linarith

section PaidAccessAndRate

variable {σ φ : Type*}

/-- A paid accessibility improvement and an independently justified mechanism
rate-floor improvement can be reported together without conflating the two
quantities. -/
theorem paidVerbImprovement_and_higherRateFloor
    (targets : Set α)
    (Upkeep : P → ℝ)
    (Γ : ProcessGeometry P α)
    (ApplyVerb : AppliesVerb P)
    (oldState newState : α)
    (oldProcess newProcess : P)
    (verb : LearningVerb)
    (Certificate : ProcessRateCertificate P)
    (hVerb :
      PaidVerbImprovementOn
        targets Upkeep Γ ApplyVerb
        oldState newState oldProcess newProcess verb)
    (hRate :
      (Certificate oldProcess).rateFloor <
        (Certificate newProcess).rateFloor) :
    (∃ z B,
      z ∈ targets ∧
      ¬ AccessibleWithin
        (PaidProcessGeometry Upkeep Γ oldProcess)
        B oldState z ∧
      AccessibleWithin
        (PaidProcessGeometry Upkeep Γ newProcess)
        B newState z) ∧
      (Certificate oldProcess).rateFloor <
        (Certificate newProcess).rateFloor := by
  constructor
  · exact paidVerbImprovement_opens_grossBudget_window
      targets Upkeep Γ ApplyVerb
      oldState newState oldProcess newProcess verb hVerb
  · exact hRate

end PaidAccessAndRate

#print axioms paidVerbImprovement_opens_grossBudget_window
#print axioms rawSaving_exceeds_upkeep_iff_paidTargetCheaper

end IntelligentLearning
end CumulativeAccessibility
