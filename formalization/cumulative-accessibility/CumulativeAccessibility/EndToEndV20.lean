import CumulativeAccessibility.ConstrainedAgency
import CumulativeAccessibility.ConstitutionAccessibility
import CumulativeAccessibility.PaidLearningMaintenance
import CumulativeAccessibility.PaidReuseHierarchy
import CumulativeAccessibility.EmergentPaidTransfer

namespace CumulativeAccessibility
namespace EndToEndV20

open RecursiveAccessibility
open PaidRetention
open IntelligentLearning
open ConstitutionAccessibility
open EmergentPaidTransfer

universe uA uS uC uE uD

variable {Agent : Type uA}
variable {State : Type uS}
variable {Claim : Type uC}
variable {Evidence : Type uE}
variable {Decision : Type uD}

variable {α P : Type*}

/-!
# End-to-end v20 verification surface

This module composes the previously separate formal surfaces into one checked
architecture.

The strongest theorem here is conditional by design. It does not prove that a
named social verb has a beneficial causal effect, that a constitution is
morally obligatory, or that every emergent structure should be retained.
Instead it checks that when an application supplies the declared bridge
premises, the following chain is deductively coherent:

1. a retained Learning Constitution keeps a shared restriction structurally
   correctable while an ablated/self-sealing comparison has infinite effective
   correction cost;
2. a learning-maintenance process change that improves *paid* accessibility
   opens a common gross-budget window;
3. an independently justified mechanism change can raise the certified learning
   rate floor;
4. an emergent retained organization can, separately, pass the paid-transfer
   test to an unvisited target.

This module is the common theorem surface intended for end-to-end review.
-/

/-- Integrated intelligent-network step: constitutional correctability, paid
accessibility improvement, and higher certified learning-rate floor. -/
theorem correctable_paid_learning_step
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (ConstitutionUpkeep : State → ℝ)
    (sPlus sMinus : State)
    (d : Decision)
    (a : Agent)
    (hConstitution : LearningConstitution.HoldsAt I sPlus)
    (hAffected : I.affected sPlus a)
    (hRestricts : I.restricts sPlus d a)
    (hSelfSeal :
      LearningConstitution.SelfSealingRestriction I sMinus d a)
    (targets : Set α)
    (ProcessUpkeep : P → ℝ)
    (Γ : ProcessGeometry P α)
    (ApplyVerb : AppliesVerb P)
    (oldState newState : α)
    (oldProcess newProcess : P)
    (verb : LearningVerb)
    (Certificate : ProcessRateCertificate P)
    (hVerb :
      PaidVerbImprovementOn
        targets ProcessUpkeep Γ ApplyVerb
        oldState newState oldProcess newProcess verb)
    (hRate :
      (Certificate oldProcess).rateFloor <
        (Certificate newProcess).rateFloor) :
    PaidEffectiveCorrectionCost
        I BaseCost ConstitutionUpkeep sPlus d a
      <
      PaidEffectiveCorrectionCost
        I BaseCost ConstitutionUpkeep sMinus d a
    ∧
    (∃ z B,
      z ∈ targets ∧
      ¬ AccessibleWithin
        (PaidProcessGeometry ProcessUpkeep Γ oldProcess)
        B oldState z ∧
      AccessibleWithin
        (PaidProcessGeometry ProcessUpkeep Γ newProcess)
        B newState z)
    ∧
    (Certificate oldProcess).rateFloor <
      (Certificate newProcess).rateFloor := by
  refine ⟨
    constitution_strictly_beats_selfSealing_on_paidCorrectionCost
      I BaseCost ConstitutionUpkeep
      sPlus sMinus d a
      hConstitution hAffected hRestricts hSelfSeal,
    ?_⟩
  exact paidVerbImprovement_and_higherRateFloor
    targets ProcessUpkeep Γ ApplyVerb
    oldState newState oldProcess newProcess verb
    Certificate hVerb hRate

section EmergentIntegration

variable {Config Context Capacity ρ : Type*}

/-- Full cross-layer certificate: an emergent retained organization passes the
paid-transfer test to an unvisited target while the intelligent-network
specialization simultaneously preserves finite corrective access, opens a paid
learning-access budget window, and raises a justified mechanism rate floor.

No implication between the emergence premise and the intelligent-network
premises is assumed; this theorem checks their composition without conflation.
-/
theorem emergent_correctable_learning_end_to_end
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config)
    (ctx : Context)
    (φcap : Capacity)
    (Visited : Set α)
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (transferMinus transferPlus transferTarget : α)
    (hEmergentTransfer :
      EmergentPaidTransferToUnvisited
        Proper Realizes config ctx φcap
        Visited M Rminus Rplus
        minusRunCost plusRunCost
        transferMinus transferPlus transferTarget)
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (ConstitutionUpkeep : State → ℝ)
    (sPlus sMinus : State)
    (d : Decision)
    (a : Agent)
    (hConstitution : LearningConstitution.HoldsAt I sPlus)
    (hAffected : I.affected sPlus a)
    (hRestricts : I.restricts sPlus d a)
    (hSelfSeal :
      LearningConstitution.SelfSealingRestriction I sMinus d a)
    (learningTargets : Set α)
    (ProcessUpkeep : P → ℝ)
    (Γ : ProcessGeometry P α)
    (ApplyVerb : AppliesVerb P)
    (oldState newState : α)
    (oldProcess newProcess : P)
    (verb : LearningVerb)
    (Certificate : ProcessRateCertificate P)
    (hVerb :
      PaidVerbImprovementOn
        learningTargets ProcessUpkeep Γ ApplyVerb
        oldState newState oldProcess newProcess verb)
    (hRate :
      (Certificate oldProcess).rateFloor <
        (Certificate newProcess).rateFloor) :
    (EmergentUnder Proper Realizes config ctx φcap ∧
      transferTarget ∉ Visited ∧
      ∃ B,
        ¬ AccessibleWithin
          (PaidAccessibilityCost M Rminus minusRunCost)
          B transferMinus transferTarget ∧
        AccessibleWithin
          (PaidAccessibilityCost M Rplus plusRunCost)
          B transferPlus transferTarget)
    ∧
    PaidEffectiveCorrectionCost
        I BaseCost ConstitutionUpkeep sPlus d a
      <
      PaidEffectiveCorrectionCost
        I BaseCost ConstitutionUpkeep sMinus d a
    ∧
    (∃ z B,
      z ∈ learningTargets ∧
      ¬ AccessibleWithin
        (PaidProcessGeometry ProcessUpkeep Γ oldProcess)
        B oldState z ∧
      AccessibleWithin
        (PaidProcessGeometry ProcessUpkeep Γ newProcess)
        B newState z)
    ∧
    (Certificate oldProcess).rateFloor <
      (Certificate newProcess).rateFloor := by
  refine ⟨
    emergentPaidTransfer_opens_unvisited_budget_window
      Proper Realizes config ctx φcap
      Visited M Rminus Rplus
      minusRunCost plusRunCost
      transferMinus transferPlus transferTarget
      hEmergentTransfer,
    ?_⟩
  exact correctable_paid_learning_step
    I BaseCost ConstitutionUpkeep
    sPlus sMinus d a
    hConstitution hAffected hRestricts hSelfSeal
    learningTargets ProcessUpkeep Γ ApplyVerb
    oldState newState oldProcess newProcess verb
    Certificate hVerb hRate

end EmergentIntegration

#print axioms correctable_paid_learning_step
#print axioms emergent_correctable_learning_end_to_end

end EndToEndV20
end CumulativeAccessibility
