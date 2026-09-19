import CumulativeAccessibility.SelfMaintenanceLeverage
import CumulativeAccessibility.RatchetVelocityLedger

namespace CumulativeAccessibility
namespace RecursiveAccessibility

open FunctionalOrganization

/-!
# Emergence reproduction number

This module quantifies the local recursive-emergence "chain reaction" without
identifying an expected-rate ledger with actual successors by definition.

There are two layers.

## Deterministic effective reproduction number

For a finite declared capacity universe, the effective reproduction number of
one realized recursive-emergence event is the number of distinct capacities
that can be the child of an immediate next recursive-emergence step reusing the
current child as parent.

Thus

  R_E = 0     means no immediate effective successor,
  R_E >= 1    means continuation is possible,
  R_E > 1     means at least two distinct immediate successor branches exist.

This is an actual successor count, not an expectation.

## Mechanism ledger

Separately, the model ledger

  tau * lambda * pGenerate * pResource * pValidate * pRetain

records a persistence/search window times opportunity rate times conditional
conversion fractions. If the p's are conditional probabilities, no independence
assumption is needed for this chain-rule decomposition.

The ledger becomes a deterministic continuation certificate only under an
explicit application seam proving that it is a lower bound on the actual
effective successor count. Without that seam, a mean/expected value above one
must not be read as deterministic continuation.

This keeps the deterministic theorem and the stochastic/mean-field
interpretation separate.
-/

section DeterministicCount

variable {Config Context Capacity : Type*}
variable [Fintype Capacity] [DecidableEq Capacity]

/-- Distinct immediate effective successor capacities of the event ending in
`child` at time `m+1`. Each listed successor must itself complete the full
recursive-emergence predicate at the next indexed step and must explicitly
reuse `child` as parent. -/
noncomputable def ImmediateRecursiveEmergenceSuccessors
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) : Finset Capacity := by
  classical
  exact Finset.univ.filter (fun next =>
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H (m + 1) child next)

/-- Integer effective reproduction count for one realized event endpoint. -/
noncomputable def EffectiveEmergenceSuccessorCount
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) : ℕ :=
  (ImmediateRecursiveEmergenceSuccessors
    Proper Realizes Cost Budget E S H m child).card

/-- Real-valued deterministic reproduction number, obtained by casting the
actual successor count. This is the quantity denoted R_E in the deterministic
finite-capacity specialization. -/
noncomputable def EffectiveEmergenceReproductionNumber
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) : ℝ :=
  EffectiveEmergenceSuccessorCount
    Proper Realizes Cost Budget E S H m child

theorem mem_immediateRecursiveEmergenceSuccessors_iff
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child next : Capacity) :
    next ∈ ImmediateRecursiveEmergenceSuccessors
      Proper Realizes Cost Budget E S H m child
      ↔
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H (m + 1) child next := by
  classical
  simp [ImmediateRecursiveEmergenceSuccessors]

/-- Criticality at one is exact in the deterministic count:
at least one effective successor exists iff the count is at least one. -/
theorem one_le_effectiveEmergenceSuccessorCount_iff_exists
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) :
    1 ≤ EffectiveEmergenceSuccessorCount
      Proper Realizes Cost Budget E S H m child
      ↔
    ∃ next,
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next := by
  classical
  let succs :=
    ImmediateRecursiveEmergenceSuccessors
      Proper Realizes Cost Budget E S H m child
  constructor
  · intro h
    have hpos : 0 < succs.card := by
      simpa [EffectiveEmergenceSuccessorCount, succs] using h
    rcases Finset.card_pos.mp hpos with ⟨next, hmem⟩
    refine ⟨next, ?_⟩
    exact (mem_immediateRecursiveEmergenceSuccessors_iff
      Proper Realizes Cost Budget E S H m child next).mp
      (by simpa [succs] using hmem)
  · rintro ⟨next, hStep⟩
    have hmem :
        next ∈ ImmediateRecursiveEmergenceSuccessors
          Proper Realizes Cost Budget E S H m child :=
      (mem_immediateRecursiveEmergenceSuccessors_iff
        Proper Realizes Cost Budget E S H m child next).mpr hStep
    have hpos :
        0 < (ImmediateRecursiveEmergenceSuccessors
          Proper Realizes Cost Budget E S H m child).card :=
      Finset.card_pos.mpr ⟨next, hmem⟩
    simpa [EffectiveEmergenceSuccessorCount] using hpos

/-- The real-valued deterministic R_E has the same critical threshold. -/
theorem one_le_effectiveEmergenceReproductionNumber_iff_exists
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) :
    1 ≤ EffectiveEmergenceReproductionNumber
      Proper Realizes Cost Budget E S H m child
      ↔
    ∃ next,
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next := by
  rw [EffectiveEmergenceReproductionNumber]
  have hNat :=
    one_le_effectiveEmergenceSuccessorCount_iff_exists
      Proper Realizes Cost Budget E S H m child
  exact_mod_cast hNat

/-- Supercritical deterministic reproduction contains at least two distinct
immediate successor branches. -/
theorem supercritical_effectiveEmergenceReproduction_has_two_successors
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity)
    (hSuper :
      1 < EffectiveEmergenceSuccessorCount
        Proper Realizes Cost Budget E S H m child) :
    ∃ next₁ next₂,
      next₁ ≠ next₂ ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next₁ ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next₂ := by
  classical
  let succs :=
    ImmediateRecursiveEmergenceSuccessors
      Proper Realizes Cost Budget E S H m child
  have hCard : 1 < succs.card := by
    simpa [EffectiveEmergenceSuccessorCount, succs] using hSuper
  have hPos : 0 < succs.card := by omega
  rcases Finset.card_pos.mp hPos with ⟨next₁, h₁⟩
  have hEraseCard : 0 < (succs.erase next₁).card := by
    rw [Finset.card_erase_of_mem h₁]
    omega
  rcases Finset.card_pos.mp hEraseCard with ⟨next₂, h₂Erase⟩
  have h₂Data := Finset.mem_erase.mp h₂Erase
  have h₂ne : next₂ ≠ next₁ := h₂Data.1
  have h₂ : next₂ ∈ succs := h₂Data.2
  refine ⟨next₁, next₂, ?_, ?_, ?_⟩
  · exact fun hEq => h₂ne hEq.symm
  · exact (mem_immediateRecursiveEmergenceSuccessors_iff
      Proper Realizes Cost Budget E S H m child next₁).mp
      (by simpa [succs] using h₁)
  · exact (mem_immediateRecursiveEmergenceSuccessors_iff
      Proper Realizes Cost Budget E S H m child next₂).mp
      (by simpa [succs] using h₂)

/-- Uniform deterministic criticality: every realized recursive-emergence event
has at least one immediate effective successor. -/
def UniformCriticalEmergenceReproduction
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) : Prop :=
  ∀ m parent child,
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H m parent child →
    1 ≤ EffectiveEmergenceSuccessorCount
      Proper Realizes Cost Budget E S H m child

/-- Uniform R_E >= 1 gives the local zero-additional-lag successor condition
used by the deterministic chain-reaction theorem. -/
theorem uniformCriticalEmergenceReproduction_implies_successorWithin_zero
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hCritical :
      UniformCriticalEmergenceReproduction
        Proper Realizes Cost Budget E S H) :
    RecursiveEmergenceSuccessorWithin
      0 Proper Realizes Cost Budget E S H := by
  intro m parent child hStep
  obtain ⟨next, hNext⟩ :=
    (one_le_effectiveEmergenceSuccessorCount_iff_exists
      Proper Realizes Cost Budget E S H m child).mp
      (hCritical m parent child hStep)
  exact ⟨m + 1, next, le_rfl, by simp, hNext⟩

/-- One seed event plus uniform deterministic criticality and retention closes
all the way to open-ended cumulative novelty. -/
theorem seed_and_uniformCriticalEmergenceReproduction_imply_openEndedNovelty
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    {seedParent seedChild : Capacity}
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H 0 seedParent seedChild)
    (hCritical :
      UniformCriticalEmergenceReproduction
        Proper Realizes Cost Budget E S H) :
    OpenEndedCumulativeNovelty S := by
  exact seed_and_successorWithin_imply_openEndedNovelty
    0 Proper Realizes Cost Budget E S H
    hRetained hSeed
    (uniformCriticalEmergenceReproduction_implies_successorWithin_zero
      Proper Realizes Cost Budget E S H hCritical)

end DeterministicCount

section ReproductionLedger

/-- Mean-field/mechanism ledger for the number of retained successful emergence
events generated over a declared persistence/search window.

If `opportunityRate` is opportunities per unit window and the remaining
factors are conditional conversion fractions, this is the expected retained
success count under the declared model. It is not definitionally equal to the
actual deterministic successor count. -/
def EmergenceReproductionLedger
    (window opportunityRate
      pGenerate pResource pValidate pRetain : ℝ) : ℝ :=
  window * opportunityRate *
    RetainedSuccessFraction pGenerate pResource pValidate pRetain

theorem emergenceReproductionLedger_nonneg
    {window opportunityRate
      pGenerate pResource pValidate pRetain : ℝ}
    (hW : 0 ≤ window)
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain) :
    0 ≤ EmergenceReproductionLedger
      window opportunityRate pGenerate pResource pValidate pRetain := by
  unfold EmergenceReproductionLedger
  have hSuccess :=
    retainedSuccessFraction_nonneg hG hR hV hT
  positivity

theorem emergenceReproductionLedger_zero_no_window
    (opportunityRate pGenerate pResource pValidate pRetain : ℝ) :
    EmergenceReproductionLedger
      0 opportunityRate pGenerate pResource pValidate pRetain = 0 := by
  simp [EmergenceReproductionLedger]

theorem emergenceReproductionLedger_zero_no_opportunity
    (window pGenerate pResource pValidate pRetain : ℝ) :
    EmergenceReproductionLedger
      window 0 pGenerate pResource pValidate pRetain = 0 := by
  simp [EmergenceReproductionLedger]

theorem emergenceReproductionLedger_mono_window
    {w₀ w₁ opportunityRate pGenerate pResource pValidate pRetain : ℝ}
    (hW : w₀ ≤ w₁)
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain) :
    EmergenceReproductionLedger
        w₀ opportunityRate pGenerate pResource pValidate pRetain
      ≤
    EmergenceReproductionLedger
        w₁ opportunityRate pGenerate pResource pValidate pRetain := by
  unfold EmergenceReproductionLedger
  have hSuccess :=
    retainedSuccessFraction_nonneg hG hR hV hT
  have hRest :
      0 ≤ opportunityRate *
        RetainedSuccessFraction pGenerate pResource pValidate pRetain :=
    mul_nonneg hO hSuccess
  simpa [mul_assoc] using mul_le_mul_of_nonneg_right hW hRest

theorem emergenceReproductionLedger_mono_opportunity
    {window o₀ o₁ pGenerate pResource pValidate pRetain : ℝ}
    (hW : 0 ≤ window)
    (hO : o₀ ≤ o₁)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain) :
    EmergenceReproductionLedger
        window o₀ pGenerate pResource pValidate pRetain
      ≤
    EmergenceReproductionLedger
        window o₁ pGenerate pResource pValidate pRetain := by
  unfold EmergenceReproductionLedger
  have hSuccess :=
    retainedSuccessFraction_nonneg hG hR hV hT
  have hInner :
      o₀ * RetainedSuccessFraction pGenerate pResource pValidate pRetain
        ≤
      o₁ * RetainedSuccessFraction pGenerate pResource pValidate pRetain :=
    mul_le_mul_of_nonneg_right hO hSuccess
  simpa [mul_assoc] using
    (mul_le_mul_of_nonneg_left hInner hW)

/-- The emergence-reproduction ledger is the persistence/search window times
the existing retained-success event-rate ledger with unit gain. This reuses the
already-audited conversion-pipeline algebra rather than introducing a second
probability model. -/
theorem emergenceReproductionLedger_eq_window_mul_mechanisticRate
    (window opportunityRate
      pGenerate pResource pValidate pRetain : ℝ) :
    EmergenceReproductionLedger
        window opportunityRate pGenerate pResource pValidate pRetain
      =
    window *
      MechanisticRatchetVelocity
        opportunityRate pGenerate pResource pValidate pRetain 1 := by
  unfold EmergenceReproductionLedger MechanisticRatchetVelocity
  ring

theorem emergenceReproductionLedger_mono_generation
    {window opportunityRate g₀ g₁ pResource pValidate pRetain : ℝ}
    (hW : 0 ≤ window)
    (hO : 0 ≤ opportunityRate)
    (hG : g₀ ≤ g₁)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain) :
    EmergenceReproductionLedger
        window opportunityRate g₀ pResource pValidate pRetain
      ≤
    EmergenceReproductionLedger
        window opportunityRate g₁ pResource pValidate pRetain := by
  have hRate :=
    mechanisticRatchetVelocity_mono_generation
      (opportunityRate := opportunityRate)
      (g₀ := g₀) (g₁ := g₁)
      (pResource := pResource)
      (pValidate := pValidate)
      (pRetain := pRetain)
      (meanGain := 1)
      hO hG hR hV hT (by norm_num)
  rw [emergenceReproductionLedger_eq_window_mul_mechanisticRate,
      emergenceReproductionLedger_eq_window_mul_mechanisticRate]
  exact mul_le_mul_of_nonneg_left hRate hW

theorem emergenceReproductionLedger_mono_resource
    {window opportunityRate pGenerate r₀ r₁ pValidate pRetain : ℝ}
    (hW : 0 ≤ window)
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : r₀ ≤ r₁)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain) :
    EmergenceReproductionLedger
        window opportunityRate pGenerate r₀ pValidate pRetain
      ≤
    EmergenceReproductionLedger
        window opportunityRate pGenerate r₁ pValidate pRetain := by
  have hRate :=
    mechanisticRatchetVelocity_mono_resource
      (opportunityRate := opportunityRate)
      (pGenerate := pGenerate)
      (r₀ := r₀) (r₁ := r₁)
      (pValidate := pValidate)
      (pRetain := pRetain)
      (meanGain := 1)
      hO hG hR hV hT (by norm_num)
  rw [emergenceReproductionLedger_eq_window_mul_mechanisticRate,
      emergenceReproductionLedger_eq_window_mul_mechanisticRate]
  exact mul_le_mul_of_nonneg_left hRate hW

theorem emergenceReproductionLedger_mono_validation
    {window opportunityRate pGenerate pResource v₀ v₁ pRetain : ℝ}
    (hW : 0 ≤ window)
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : v₀ ≤ v₁)
    (hT : 0 ≤ pRetain) :
    EmergenceReproductionLedger
        window opportunityRate pGenerate pResource v₀ pRetain
      ≤
    EmergenceReproductionLedger
        window opportunityRate pGenerate pResource v₁ pRetain := by
  have hRate :=
    mechanisticRatchetVelocity_mono_validation
      (opportunityRate := opportunityRate)
      (pGenerate := pGenerate)
      (pResource := pResource)
      (v₀ := v₀) (v₁ := v₁)
      (pRetain := pRetain)
      (meanGain := 1)
      hO hG hR hV hT (by norm_num)
  rw [emergenceReproductionLedger_eq_window_mul_mechanisticRate,
      emergenceReproductionLedger_eq_window_mul_mechanisticRate]
  exact mul_le_mul_of_nonneg_left hRate hW

theorem emergenceReproductionLedger_mono_retention
    {window opportunityRate pGenerate pResource pValidate t₀ t₁ : ℝ}
    (hW : 0 ≤ window)
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : t₀ ≤ t₁) :
    EmergenceReproductionLedger
        window opportunityRate pGenerate pResource pValidate t₀
      ≤
    EmergenceReproductionLedger
        window opportunityRate pGenerate pResource pValidate t₁ := by
  have hRate :=
    mechanisticRatchetVelocity_mono_retention
      (opportunityRate := opportunityRate)
      (pGenerate := pGenerate)
      (pResource := pResource)
      (pValidate := pValidate)
      (t₀ := t₀) (t₁ := t₁)
      (meanGain := 1)
      hO hG hR hV hT (by norm_num)
  rw [emergenceReproductionLedger_eq_window_mul_mechanisticRate,
      emergenceReproductionLedger_eq_window_mul_mechanisticRate]
  exact mul_le_mul_of_nonneg_left hRate hW

/-- Explicit calibration seam: the mechanism ledger is certified as a lower
bound on the actual deterministic effective successor count for this event.
This is an application assumption, not a universal theorem. -/
def ReproductionLedgerCertifiedLowerBound
    (actualRE : ℝ)
    (window opportunityRate
      pGenerate pResource pValidate pRetain : ℝ) : Prop :=
  EmergenceReproductionLedger
      window opportunityRate pGenerate pResource pValidate pRetain
    ≤ actualRE

theorem certifiedLedger_at_least_one_implies_actual_at_least_one
    {actualRE window opportunityRate
      pGenerate pResource pValidate pRetain : ℝ}
    (hCertified :
      ReproductionLedgerCertifiedLowerBound
        actualRE window opportunityRate
        pGenerate pResource pValidate pRetain)
    (hCritical :
      1 ≤ EmergenceReproductionLedger
        window opportunityRate pGenerate pResource pValidate pRetain) :
    1 ≤ actualRE := by
  exact le_trans hCritical hCertified

end ReproductionLedger

section CertifiedDeterministicBridge

variable {Config Context Capacity : Type*}
variable [Fintype Capacity] [DecidableEq Capacity]

/-- Event-specific factors used to certify a deterministic lower bound from a
mechanism ledger. The fields may be empirical estimates, analytical lower
bounds, or externally justified application quantities. -/
structure EmergenceReproductionFactors where
  window : ℝ
  opportunityRate : ℝ
  pGenerate : ℝ
  pResource : ℝ
  pValidate : ℝ
  pRetain : ℝ

def emergenceReproductionLedgerOf
    (f : EmergenceReproductionFactors) : ℝ :=
  EmergenceReproductionLedger
    f.window f.opportunityRate
    f.pGenerate f.pResource f.pValidate f.pRetain

/-- A factor assignment is a deterministic continuation certificate when its
ledger is at least one and is separately certified below the actual successor
count. -/
def CertifiedCriticalEmergenceEvent
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (factors : EmergenceReproductionFactors)
    (m : ℕ)
    (child : Capacity) : Prop :=
  1 ≤ emergenceReproductionLedgerOf factors ∧
  emergenceReproductionLedgerOf factors ≤
    EffectiveEmergenceReproductionNumber
      Proper Realizes Cost Budget E S H m child

theorem certifiedCriticalEmergenceEvent_implies_effective_successor
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (factors : EmergenceReproductionFactors)
    (m : ℕ)
    (child : Capacity)
    (h :
      CertifiedCriticalEmergenceEvent
        Proper Realizes Cost Budget E S H factors m child) :
    ∃ next,
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next := by
  have hOne :
      1 ≤ EffectiveEmergenceReproductionNumber
        Proper Realizes Cost Budget E S H m child :=
    le_trans h.1 h.2
  exact
    (one_le_effectiveEmergenceReproductionNumber_iff_exists
      Proper Realizes Cost Budget E S H m child).mp hOne

end CertifiedDeterministicBridge

#print axioms one_le_effectiveEmergenceSuccessorCount_iff_exists
#print axioms one_le_effectiveEmergenceReproductionNumber_iff_exists
#print axioms supercritical_effectiveEmergenceReproduction_has_two_successors
#print axioms uniformCriticalEmergenceReproduction_implies_successorWithin_zero
#print axioms seed_and_uniformCriticalEmergenceReproduction_imply_openEndedNovelty
#print axioms emergenceReproductionLedger_nonneg
#print axioms emergenceReproductionLedger_mono_window
#print axioms emergenceReproductionLedger_mono_opportunity
#print axioms emergenceReproductionLedger_eq_window_mul_mechanisticRate
#print axioms emergenceReproductionLedger_mono_generation
#print axioms emergenceReproductionLedger_mono_resource
#print axioms emergenceReproductionLedger_mono_validation
#print axioms emergenceReproductionLedger_mono_retention
#print axioms certifiedLedger_at_least_one_implies_actual_at_least_one
#print axioms certifiedCriticalEmergenceEvent_implies_effective_successor

end RecursiveAccessibility
end CumulativeAccessibility
