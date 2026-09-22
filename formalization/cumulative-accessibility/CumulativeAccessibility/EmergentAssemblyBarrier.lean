import CumulativeAccessibility.EmergentCapacity
import CumulativeAccessibility.TransitionAccessibility
import Mathlib.Tactic

namespace CumulativeAccessibility
namespace EmergentAssemblyBarrier

open RecursiveAccessibility

/-!
# Emergent assembly barrier

This module gives emergence a non-decorative mathematical role.

If a target function is strictly compositional-emergent at a whole X, no proper
subconfiguration realizes that target function. If retention of an intermediate
must be financed by benefit from that target function alone, and maintenance is
strictly positive, every proper intermediate has negative net target value.

Therefore a gradual retained path to the emergent whole cannot be financed by
the future emergent function alone. A retained intermediate requires some
additional support: another function, reuse elsewhere, subsidy/drift, or a
direct assembly event that does not require retaining the intermediate.

The theorem does not claim that parts cannot physically persist. It identifies
the financing barrier created specifically by strict emergence.
-/

variable {Config Context Capacity : Type*}

/-- Application-specific benefit attributed specifically to one target
function. -/
abbrev TargetBenefit (Config : Type*) := Config → ℝ

/-- Application-specific maintenance/retention burden of a configuration. -/
abbrev Upkeep (Config : Type*) := Config → ℝ

/-- The target function contributes no target-specific benefit before it is
actually realized. -/
def BenefitOnlyWhenRealized
    (Realizes : CapacityRelation Config Context Capacity)
    (ctx : Context)
    (φ : Capacity)
    (Benefit : TargetBenefit Config) : Prop :=
  ∀ config,
    ¬ Realizes config ctx φ →
      Benefit config = 0

/-- Net value when an intermediate must pay for itself from the target function
alone. -/
def TargetFinancedNet
    (Benefit : TargetBenefit Config)
    (M : Upkeep Config)
    (config : Config) : ℝ :=
  Benefit config - M config

/-- A proper subconfiguration of a strictly emergent whole cannot realize the
target function. -/
theorem emergent_proper_subconfig_not_realize
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (whole sub : Config)
    (ctx : Context)
    (φ : Capacity)
    (hEmergent : EmergentUnder Proper Realizes whole ctx φ)
    (hProper : Proper sub whole) :
    ¬ Realizes sub ctx φ := by
  exact hEmergent.2 sub hProper

/-- Core assembly-barrier theorem: if the emergent target is the only source of
benefit and retention has positive cost, every proper intermediate has negative
net value before the whole exists. -/
theorem emergent_proper_subconfig_negative_target_financed_net
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (whole sub : Config)
    (ctx : Context)
    (φ : Capacity)
    (Benefit : TargetBenefit Config)
    (M : Upkeep Config)
    (hEmergent : EmergentUnder Proper Realizes whole ctx φ)
    (hBenefit :
      BenefitOnlyWhenRealized Realizes ctx φ Benefit)
    (hProper : Proper sub whole)
    (hCost : 0 < M sub) :
    TargetFinancedNet Benefit M sub < 0 := by
  have hNoRealize :
      ¬ Realizes sub ctx φ :=
    emergent_proper_subconfig_not_realize
      Proper Realizes whole sub ctx φ hEmergent hProper
  have hZero : Benefit sub = 0 :=
    hBenefit sub hNoRealize
  unfold TargetFinancedNet
  rw [hZero]
  linarith

/-- A whole list of proper, positively costly intermediates lies behind the same
target-financing barrier. -/
theorem emergent_assembly_path_barrier
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (whole : Config)
    (ctx : Context)
    (φ : Capacity)
    (Benefit : TargetBenefit Config)
    (M : Upkeep Config)
    (intermediates : List Config)
    (hEmergent : EmergentUnder Proper Realizes whole ctx φ)
    (hBenefit :
      BenefitOnlyWhenRealized Realizes ctx φ Benefit)
    (hProper :
      ∀ sub, sub ∈ intermediates → Proper sub whole)
    (hCost :
      ∀ sub, sub ∈ intermediates → 0 < M sub) :
    ∀ sub, sub ∈ intermediates →
      TargetFinancedNet Benefit M sub < 0 := by
  intro sub hMem
  exact emergent_proper_subconfig_negative_target_financed_net
    Proper Realizes whole sub ctx φ
    Benefit M hEmergent hBenefit
    (hProper sub hMem)
    (hCost sub hMem)

/-- If a proper intermediate of an emergent whole is nevertheless viable after
paying positive upkeep, then target-specific benefit alone cannot explain its
persistence. Any additive auxiliary support must be strictly positive.

This captures, at the abstract level, independently useful stepping stones,
reuse/exaptation, external subsidy, or other support not supplied by the future
emergent target itself.
-/
theorem viable_emergent_intermediate_requires_auxiliary_support
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (whole sub : Config)
    (ctx : Context)
    (φ : Capacity)
    (Benefit Auxiliary : TargetBenefit Config)
    (M : Upkeep Config)
    (hEmergent : EmergentUnder Proper Realizes whole ctx φ)
    (hBenefit :
      BenefitOnlyWhenRealized Realizes ctx φ Benefit)
    (hProper : Proper sub whole)
    (hCost : 0 < M sub)
    (hViable :
      0 ≤ Benefit sub + Auxiliary sub - M sub) :
    0 < Auxiliary sub := by
  have hNoRealize :
      ¬ Realizes sub ctx φ :=
    emergent_proper_subconfig_not_realize
      Proper Realizes whole sub ctx φ hEmergent hProper
  have hZero : Benefit sub = 0 :=
    hBenefit sub hNoRealize
  rw [hZero] at hViable
  linarith

/-- If every proper intermediate must be retained only when its target-financed
net value is nonnegative, strict emergence plus positive upkeep rules out every
proper intermediate as a retained stepping stone. -/
def TargetOnlyRetainable
    (Benefit : TargetBenefit Config)
    (M : Upkeep Config)
    (config : Config) : Prop :=
  0 ≤ TargetFinancedNet Benefit M config

theorem emergent_barrier_rules_out_target_only_retention
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (whole sub : Config)
    (ctx : Context)
    (φ : Capacity)
    (Benefit : TargetBenefit Config)
    (M : Upkeep Config)
    (hEmergent : EmergentUnder Proper Realizes whole ctx φ)
    (hBenefit :
      BenefitOnlyWhenRealized Realizes ctx φ Benefit)
    (hProper : Proper sub whole)
    (hCost : 0 < M sub) :
    ¬ TargetOnlyRetainable Benefit M sub := by
  intro hRetain
  have hNeg :=
    emergent_proper_subconfig_negative_target_financed_net
      Proper Realizes whole sub ctx φ
      Benefit M hEmergent hBenefit hProper hCost
  exact not_lt_of_ge hRetain hNeg

#print axioms emergent_proper_subconfig_not_realize
#print axioms emergent_proper_subconfig_negative_target_financed_net
#print axioms emergent_assembly_path_barrier
#print axioms viable_emergent_intermediate_requires_auxiliary_support
#print axioms emergent_barrier_rules_out_target_only_retention

end EmergentAssemblyBarrier
end CumulativeAccessibility
