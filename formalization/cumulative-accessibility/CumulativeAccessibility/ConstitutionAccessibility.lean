import TheRoom
import CumulativeAccessibility.PaidRetentionTransfer

namespace CumulativeAccessibility
namespace ConstitutionAccessibility

universe uA uS uC uE uD

variable {Agent : Type uA}
variable {State : Type uS}
variable {Claim : Type uC}
variable {Evidence : Type uE}
variable {Decision : Type uD}

/-!
# Learning Constitution as an accessibility boundary

This module imports the actual v18 `TheRoom.lean` theorem surface and places it
inside the quantitative-accessibility formal stack.

The bridge is deliberately narrow:

* the v18 constitution supplies structural permission to challenge and revise a
  restriction;
* if either permission is structurally absent, effective correction cost is
  represented as `⊤`;
* if both are present, effective correction cost is the declared finite base
  cost;
* adding finite upkeep preserves the finite-vs-infinite distinction.

Thus "self-sealing = infinite correction viscosity" becomes a theorem under the
declared effective-cost definition rather than only a prose analogy.
-/

/-- A shared decision has a structurally available correction route when the
affected agent can challenge it and the procedure can revise it. -/
def DecisionCorrectionAvailable
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (s : State)
    (d : Decision)
    (a : Agent) : Prop :=
  I.canChallengeDecision s a d ∧ I.canReviseDecision s d

/-- A self-sealing restriction blocks structural decision correction. -/
theorem selfSealing_blocks_decisionCorrection
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (s : State)
    (d : Decision)
    (a : Agent)
    (hSeal : LearningConstitution.SelfSealingRestriction I s d a) :
    ¬ DecisionCorrectionAvailable I s d a := by
  intro hAvailable
  rcases hSeal.2 with hNoChallenge | hNoRevision
  · exact hNoChallenge hAvailable.1
  · exact hNoRevision hAvailable.2

/-- The Learning Constitution supplies structural correction availability for
any restriction on an affected participant. -/
theorem constitution_supplies_decisionCorrection
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (s : State)
    (d : Decision)
    (a : Agent)
    (hConstitution : LearningConstitution.HoldsAt I s)
    (hAffected : I.affected s a)
    (hRestricts : I.restricts s d a) :
    DecisionCorrectionAvailable I s d a := by
  exact hConstitution.restriction_correctable d a hAffected hRestricts

/-- Base empirical/procedural cost of using a structurally available correction
route. This cost is finite by type; structural closure is represented
separately by `⊤`. -/
abbrev BaseCorrectionCost
    (State Decision Agent : Type*) :=
  State → Decision → Agent → ℝ

/-- Effective correction cost: finite declared cost when the structural route
exists, and `⊤` when challenge/revision is structurally closed. -/
noncomputable def EffectiveCorrectionCost
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (s : State)
    (d : Decision)
    (a : Agent) : WithTop ℝ := by
  classical
  exact if DecisionCorrectionAvailable I s d a
    then (BaseCost s d a : WithTop ℝ)
    else ⊤

/-- A self-sealing restriction has infinite effective correction cost under the
declared cost semantics. -/
theorem selfSealing_effectiveCorrectionCost_eq_top
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (s : State)
    (d : Decision)
    (a : Agent)
    (hSeal : LearningConstitution.SelfSealingRestriction I s d a) :
    EffectiveCorrectionCost I BaseCost s d a = ⊤ := by
  have hClosed := selfSealing_blocks_decisionCorrection I s d a hSeal
  simp [EffectiveCorrectionCost, hClosed]

/-- Under the constitution, a restriction on an affected participant has the
finite declared base correction cost. -/
theorem constitution_effectiveCorrectionCost_eq_coe
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (s : State)
    (d : Decision)
    (a : Agent)
    (hConstitution : LearningConstitution.HoldsAt I s)
    (hAffected : I.affected s a)
    (hRestricts : I.restricts s d a) :
    EffectiveCorrectionCost I BaseCost s d a =
      (BaseCost s d a : WithTop ℝ) := by
  have hAvailable :=
    constitution_supplies_decisionCorrection
      I s d a hConstitution hAffected hRestricts
  simp [EffectiveCorrectionCost, hAvailable]

/-- Finite maintenance/upkeep of the correction architecture is added exactly
once to effective correction cost. -/
noncomputable def PaidEffectiveCorrectionCost
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (Upkeep : State → ℝ)
    (s : State)
    (d : Decision)
    (a : Agent) : WithTop ℝ :=
  (Upkeep s : WithTop ℝ) + EffectiveCorrectionCost I BaseCost s d a

/-- Finite upkeep cannot rescue a self-sealing restriction from infinite
effective correction cost. -/
theorem selfSealing_paidEffectiveCorrectionCost_eq_top
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (Upkeep : State → ℝ)
    (s : State)
    (d : Decision)
    (a : Agent)
    (hSeal : LearningConstitution.SelfSealingRestriction I s d a) :
    PaidEffectiveCorrectionCost I BaseCost Upkeep s d a = ⊤ := by
  rw [PaidEffectiveCorrectionCost,
    selfSealing_effectiveCorrectionCost_eq_top I BaseCost s d a hSeal]
  simp

/-- A constitutional retained state has strictly lower paid effective correction
cost than an otherwise compared self-sealing state, regardless of the finite
real-valued upkeep assigned to either state. -/
theorem constitution_strictly_beats_selfSealing_on_paidCorrectionCost
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
  have hAvailable :=
    constitution_supplies_decisionCorrection
      I sPlus d a hConstitution hAffected hRestricts
  have hClosed :=
    selfSealing_blocks_decisionCorrection
      I sMinus d a hSelfSeal
  simp [PaidEffectiveCorrectionCost, EffectiveCorrectionCost,
    hAvailable, hClosed]

/-- Reachable preservation of the v18 constitution carries the finite
correction-cost guarantee to every reachable affected restriction. -/
theorem reachable_constitution_keeps_paidCorrectionCost_finite
    (I : LearningConstitution.Interface
      Agent State Claim Evidence Decision)
    (BaseCost : BaseCorrectionCost State Decision Agent)
    (Upkeep : State → ℝ)
    (s0 s : State)
    (d : Decision)
    (a : Agent)
    (hInitial : LearningConstitution.HoldsAt I s0)
    (hPreserved : LearningConstitution.ConstitutionPreserved I)
    (hReach : LearningConstitution.Reachable (LearningConstitution.Next I) s0 s)
    (hAffected : I.affected s a)
    (hRestricts : I.restricts s d a) :
    PaidEffectiveCorrectionCost I BaseCost Upkeep s d a ≠ ⊤ := by
  have hConstitution :=
    LearningConstitution.constitution_is_reachable_invariant
      I s0 s hInitial hPreserved hReach
  have hAvailable :=
    constitution_supplies_decisionCorrection
      I s d a hConstitution hAffected hRestricts
  simp [PaidEffectiveCorrectionCost, EffectiveCorrectionCost, hAvailable]

#print axioms selfSealing_effectiveCorrectionCost_eq_top
#print axioms constitution_strictly_beats_selfSealing_on_paidCorrectionCost
#print axioms reachable_constitution_keeps_paidCorrectionCost_finite

end ConstitutionAccessibility
end CumulativeAccessibility
