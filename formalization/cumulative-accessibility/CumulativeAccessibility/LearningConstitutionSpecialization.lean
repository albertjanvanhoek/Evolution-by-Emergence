import CumulativeAccessibility.RetainedOrganizationCore
import CumulativeAccessibility.ConstrainedAgency
import CumulativeAccessibility.ConstitutionAccessibility
import CumulativeAccessibility.PaidLearningMaintenance

namespace CumulativeAccessibility
namespace LearningConstitutionSpecialization

open RetainedOrganizationCore
open IntelligentLearning
open ConstitutionAccessibility

/-!
# Intelligent-network specialization

This file is deliberately downstream of RetainedOrganizationCore.lean.

It does not define the EbE core. It instantiates the substrate-agnostic
retained-organization/accessibility language for networks of fallible learning
agents, and connects that specialization to the independently machine-checked
v18 Learning Constitution.

SCAP and named learning verbs remain candidate mechanisms. Their signs are not
universal axioms.
-/

universe uA uS uC uE uD
variable {Agent : Type uA}
variable {State : Type uS}
variable {Claim : Type uC}
variable {Evidence : Type uE}
variable {Decision : Type uD}
variable {α P : Type*}

/-- In the intelligent specialization, a constitutional state has finite paid
correction cost while a matched self-sealing comparison has infinite paid
correction cost. This is a specialization theorem, not part of the universal
retained-organization core. -/
theorem constitution_specializes_zero_accessibility_boundary
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (Upkeep : State → ℝ)
    (sPlus sMinus : State)
    (d : Decision)
    (a : Agent)
    (hConstitution : LearningConstitution.HoldsAt I sPlus)
    (hAffected : I.affected sPlus a)
    (hRestricts : I.restricts sPlus d a)
    (hSelfSeal :
      LearningConstitution.SelfSealingRestriction I sMinus d a) :
    PaidEffectiveCorrectionCost I BaseCost Upkeep sPlus d a <
      PaidEffectiveCorrectionCost I BaseCost Upkeep sMinus d a := by
  exact constitution_strictly_beats_selfSealing_on_paidCorrectionCost
    I BaseCost Upkeep sPlus sMinus d a
    hConstitution hAffected hRestricts hSelfSeal

/-- A named learning verb contributes to the EbE accessibility story only when
an application proves that the process transition improves paid accessibility.
The theorem then exposes the corresponding common gross-budget window. -/
theorem paid_learning_verb_specializes_accessibility
    (targets : Set α)
    (Upkeep : P → ℝ)
    (Γp : ProcessGeometry P α)
    (ApplyVerb : AppliesVerb P)
    (oldState newState : α)
    (oldProcess newProcess : P)
    (verb : LearningVerb)
    (hVerb :
      PaidVerbImprovementOn
        targets Upkeep Γp ApplyVerb
        oldState newState oldProcess newProcess verb) :
    ∃ z B,
      z ∈ targets ∧
      ¬ RecursiveAccessibility.AccessibleWithin
        (PaidProcessGeometry Upkeep Γp oldProcess)
        B oldState z ∧
      RecursiveAccessibility.AccessibleWithin
        (PaidProcessGeometry Upkeep Γp newProcess)
        B newState z := by
  exact paidVerbImprovement_opens_grossBudget_window
    targets Upkeep Γp ApplyVerb
    oldState newState oldProcess newProcess verb hVerb

#print axioms constitution_specializes_zero_accessibility_boundary
#print axioms paid_learning_verb_specializes_accessibility

end LearningConstitutionSpecialization
end CumulativeAccessibility
