import CumulativeAccessibility.EmergenceReproduction
import CumulativeAccessibility.OpenEndedCapacity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Local emergence reproduction in a moving envelope

The finite global Capacity specialization in EmergenceReproduction.lean is
useful for local counting, but a fixed finite universe cannot sustain
open-ended retained novelty. This module makes that boundary explicit and
defines a corrected local reproduction count over the finite time-dependent
candidate envelope U.

Thus every local search surface may be finite while the sequence of envelopes
can grow without a global finite bound.
-/

section FixedFiniteBoundary

variable {Config Context Capacity : Type*}
variable [Fintype Capacity] [DecidableEq Capacity]

/-- Over a fixed finite Capacity type, a seed, monotone retention, and uniform
critical deterministic reproduction cannot all persist forever. The previous
open-endedness implication is valid, but its premises are jointly
unsatisfiable in the globally finite specialization. -/
theorem finiteCapacity_uniformCriticalEmergenceReproduction_impossible
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
    False := by
  have hOpen : OpenEndedCumulativeNovelty S :=
    seed_and_uniformCriticalEmergenceReproduction_imply_openEndedNovelty
      Proper Realizes Cost Budget E S H hRetained hSeed hCritical
  have hRepresented :
      ∀ n, S n ⊆ (fun _ => (Finset.univ : Finset Capacity)) n := by
    intro n x hx
    simp
  have hBound :
      ∀ n, ((fun _ => (Finset.univ : Finset Capacity)) n).card
        ≤ Fintype.card Capacity := by
    intro n
    simp
  exact
    (uniformlyBoundedEnvelope_rules_out_openEndedNovelty
      (fun _ => (Finset.univ : Finset Capacity)) S
      hRepresented hRetained (Fintype.card Capacity) hBound) hOpen

end FixedFiniteBoundary

section LocalEnvelopeCount

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Immediate effective successors represented in the next finite local
candidate envelope. No global Fintype Capacity assumption is required. -/
noncomputable def LocalRecursiveEmergenceSuccessors
    (U : ℕ → Finset Capacity)
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
  exact (U (m + 1)).filter (fun next =>
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H (m + 1) child next)

/-- Integer local effective reproduction count. -/
noncomputable def LocalEffectiveEmergenceSuccessorCount
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) : ℕ :=
  (LocalRecursiveEmergenceSuccessors
    U Proper Realizes Cost Budget E S H m child).card

/-- Real-valued local deterministic reproduction number. -/
noncomputable def LocalEffectiveEmergenceReproductionNumber
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) : ℝ :=
  LocalEffectiveEmergenceSuccessorCount
    U Proper Realizes Cost Budget E S H m child

theorem mem_localRecursiveEmergenceSuccessors_iff
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child next : Capacity) :
    next ∈ LocalRecursiveEmergenceSuccessors
      U Proper Realizes Cost Budget E S H m child
      ↔
    next ∈ U (m + 1) ∧
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H (m + 1) child next := by
  classical
  simp [LocalRecursiveEmergenceSuccessors]

/-- Local criticality at one is exact: count at least one iff an actual
effective successor exists in the next finite envelope. -/
theorem one_le_localEffectiveEmergenceSuccessorCount_iff_exists
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) :
    1 ≤ LocalEffectiveEmergenceSuccessorCount
      U Proper Realizes Cost Budget E S H m child
      ↔
    ∃ next,
      next ∈ U (m + 1) ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next := by
  classical
  let succs :=
    LocalRecursiveEmergenceSuccessors
      U Proper Realizes Cost Budget E S H m child
  constructor
  · intro h
    have hpos : 0 < succs.card := by
      simpa [LocalEffectiveEmergenceSuccessorCount, succs] using h
    rcases Finset.card_pos.mp hpos with ⟨next, hmem⟩
    refine ⟨next, ?_⟩
    exact
      (mem_localRecursiveEmergenceSuccessors_iff
        U Proper Realizes Cost Budget E S H m child next).mp
        (by simpa [succs] using hmem)
  · rintro ⟨next, hEnvelope, hStep⟩
    have hmem :
        next ∈ LocalRecursiveEmergenceSuccessors
          U Proper Realizes Cost Budget E S H m child :=
      (mem_localRecursiveEmergenceSuccessors_iff
        U Proper Realizes Cost Budget E S H m child next).mpr
        ⟨hEnvelope, hStep⟩
    have hpos :
        0 < (LocalRecursiveEmergenceSuccessors
          U Proper Realizes Cost Budget E S H m child).card :=
      Finset.card_pos.mpr ⟨next, hmem⟩
    simpa [LocalEffectiveEmergenceSuccessorCount] using hpos

theorem one_le_localEffectiveEmergenceReproductionNumber_iff_exists
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child : Capacity) :
    1 ≤ LocalEffectiveEmergenceReproductionNumber
      U Proper Realizes Cost Budget E S H m child
      ↔
    ∃ next,
      next ∈ U (m + 1) ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next := by
  rw [LocalEffectiveEmergenceReproductionNumber]
  have hNat :=
    one_le_localEffectiveEmergenceSuccessorCount_iff_exists
      U Proper Realizes Cost Budget E S H m child
  exact_mod_cast hNat

end LocalEnvelopeCount

section LocalRecursiveClosure

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Every realized recursive-emergence event has at least one immediate
effective successor inside the next finite local envelope. -/
def UniformLocalCriticalEmergenceReproduction
    (U : ℕ → Finset Capacity)
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
    1 ≤ LocalEffectiveEmergenceSuccessorCount
      U Proper Realizes Cost Budget E S H m child

theorem uniformLocalCriticalEmergenceReproduction_implies_successorWithin_zero
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hCritical :
      UniformLocalCriticalEmergenceReproduction
        U Proper Realizes Cost Budget E S H) :
    RecursiveEmergenceSuccessorWithin
      0 Proper Realizes Cost Budget E S H := by
  intro m parent child hStep
  obtain ⟨next, hEnvelope, hNext⟩ :=
    (one_le_localEffectiveEmergenceSuccessorCount_iff_exists
      U Proper Realizes Cost Budget E S H m child).mp
      (hCritical m parent child hStep)
  exact ⟨m + 1, next, le_rfl, by simp, hNext⟩

/-- Corrected recursive closure: locally finite critical reproduction is
sufficient for open-ended novelty without a globally finite capacity type. -/
theorem seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
    (U : ℕ → Finset Capacity)
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
      UniformLocalCriticalEmergenceReproduction
        U Proper Realizes Cost Budget E S H) :
    OpenEndedCumulativeNovelty S := by
  exact seed_and_successorWithin_imply_openEndedNovelty
    0 Proper Realizes Cost Budget E S H
    hRetained hSeed
    (uniformLocalCriticalEmergenceReproduction_implies_successorWithin_zero
      U Proper Realizes Cost Budget E S H hCritical)

/-- With repertoire representation, the same recursive mechanism necessarily
forces unbounded effective envelope capacity. -/
theorem seed_and_uniformLocalCriticalEmergenceReproduction_imply_unboundedEnvelope
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    {seedParent seedChild : Capacity}
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H 0 seedParent seedChild)
    (hCritical :
      UniformLocalCriticalEmergenceReproduction
        U Proper Realizes Cost Budget E S H) :
    UnboundedEnvelopeCapacity U := by
  exact openEndedNovelty_implies_unboundedEnvelopeCapacity
    U S hRepresented hRetained
    (seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
      U Proper Realizes Cost Budget E S H hRetained hSeed hCritical)

/-- No-go complement: a uniformly bounded moving envelope rules out sustained
uniform local critical reproduction once a seed, retention, and representation
are present. -/
theorem uniformlyBoundedEnvelope_rules_out_uniformLocalCriticalEmergenceReproduction
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    {seedParent seedChild : Capacity}
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H 0 seedParent seedChild)
    (B : ℕ)
    (hCapacity : ∀ n, (U n).card ≤ B) :
    ¬ UniformLocalCriticalEmergenceReproduction
        U Proper Realizes Cost Budget E S H := by
  intro hCritical
  have hOpen : OpenEndedCumulativeNovelty S :=
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
      U Proper Realizes Cost Budget E S H hRetained hSeed hCritical
  exact
    (uniformlyBoundedEnvelope_rules_out_openEndedNovelty
      U S hRepresented hRetained B hCapacity) hOpen

end LocalRecursiveClosure

section ProgressiveLocalWitness

/-- Existing progressive architecture witnesses non-vacuity of the corrected
local theory: each finite envelope supplies a successor while the envelopes
grow without a global finite bound. -/
theorem progressive_has_uniformLocalCriticalEmergenceReproduction :
    UniformLocalCriticalEmergenceReproduction
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator := by
  intro m parent child hStep
  apply
    (one_le_localEffectiveEmergenceSuccessorCount_iff_exists
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator m child).mpr
  have hChild : child = m + 1 := by
    rcases hStep.2.1 with ⟨parents, hParent, hAvailable, hRule⟩
    exact hRule.2
  subst child
  refine ⟨(m + 1) + 1, ?_, ?_⟩
  · simp [progressiveEnvelope]
  · exact progressive_recursiveEmergenceStep (m + 1)

theorem progressive_openEnded_via_localEmergenceReproduction :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  exact
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator
      progressiveRepertoire_retained
      (progressive_recursiveEmergenceStep 0)
      progressive_has_uniformLocalCriticalEmergenceReproduction

theorem progressive_unboundedEnvelope_via_localEmergenceReproduction :
    UnboundedEnvelopeCapacity progressiveEnvelope := by
  exact
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_unboundedEnvelope
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator
      progressiveRepertoire_represented
      progressiveRepertoire_retained
      (progressive_recursiveEmergenceStep 0)
      progressive_has_uniformLocalCriticalEmergenceReproduction

end ProgressiveLocalWitness

#print axioms finiteCapacity_uniformCriticalEmergenceReproduction_impossible
#print axioms one_le_localEffectiveEmergenceSuccessorCount_iff_exists
#print axioms one_le_localEffectiveEmergenceReproductionNumber_iff_exists
#print axioms uniformLocalCriticalEmergenceReproduction_implies_successorWithin_zero
#print axioms seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
#print axioms seed_and_uniformLocalCriticalEmergenceReproduction_imply_unboundedEnvelope
#print axioms uniformlyBoundedEnvelope_rules_out_uniformLocalCriticalEmergenceReproduction
#print axioms progressive_has_uniformLocalCriticalEmergenceReproduction
#print axioms progressive_openEnded_via_localEmergenceReproduction
#print axioms progressive_unboundedEnvelope_via_localEmergenceReproduction

end RecursiveAccessibility
end CumulativeAccessibility
