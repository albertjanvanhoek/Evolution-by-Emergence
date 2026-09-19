import CumulativeAccessibility.EvolutionByEmergenceCore
import CumulativeAccessibility.OpenEndedCapacity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

open FunctionalOrganization

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
      ∀ n : ℕ, ((fun _ => (Finset.univ : Finset Capacity)) n).card
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

section FiniteMasterCertificateBoundary

variable {Config Context Capacity : Type*}
variable [Fintype Capacity] [DecidableEq Capacity]

/-- The finite master certificate currently defined in
EvolutionByEmergenceCore.lean cannot be inhabited together with its stated
recursive conclusion over a fixed finite global capacity type. This turns the
finite-universe concern into an explicit theorem rather than an interpretive
warning. -/
theorem evolutionByEmergenceCoreCertificate_impossible
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (core :
      EvolutionByEmergenceCoreCertificate
        Proper Realizes Cost Budget E S H) :
    False := by
  exact
    finiteCapacity_uniformCriticalEmergenceReproduction_impossible
      Proper Realizes Cost Budget E S H
      core.retained core.seed
      (uniformCertifiedCritical_implies_uniformCritical
        Proper Realizes Cost Budget E S H
        core.factors core.certifiedCritical)

end FiniteMasterCertificateBoundary

section LocalCertifiedCore

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Event-specific calibrated criticality against the local moving-envelope
reproduction number rather than a globally finite successor universe. -/
def LocalCertifiedCriticalEmergenceEvent
    (U : ℕ → Finset Capacity)
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
    LocalEffectiveEmergenceReproductionNumber
      U Proper Realizes Cost Budget E S H m child

/-- A locally certified critical ledger yields an actual effective successor in
the next finite envelope. -/
theorem localCertifiedCriticalEmergenceEvent_implies_effective_successor
    (U : ℕ → Finset Capacity)
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
      LocalCertifiedCriticalEmergenceEvent
        U Proper Realizes Cost Budget E S H factors m child) :
    ∃ next,
      next ∈ U (m + 1) ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H (m + 1) child next := by
  have hCritical :
      1 ≤ LocalEffectiveEmergenceReproductionNumber
        U Proper Realizes Cost Budget E S H m child :=
    le_trans h.1 h.2
  exact
    (one_le_localEffectiveEmergenceReproductionNumber_iff_exists
      U Proper Realizes Cost Budget E S H m child).mp hCritical

/-- Every realized event receives an event-specific factor assignment whose
ledger is critical and certified below the local actual successor count. -/
def UniformLocalCertifiedCriticalEmergenceReproduction
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (factors : ℕ → Capacity → EmergenceReproductionFactors) : Prop :=
  ∀ m parent child,
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H m parent child →
    LocalCertifiedCriticalEmergenceEvent
      U Proper Realizes Cost Budget E S H
      (factors m child) m child

/-- Uniform local calibration implies the local deterministic criticality
predicate needed by the recursive continuation theorem. -/
theorem uniformLocalCertifiedCritical_implies_uniformLocalCritical
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (factors : ℕ → Capacity → EmergenceReproductionFactors)
    (hCertified :
      UniformLocalCertifiedCriticalEmergenceReproduction
        U Proper Realizes Cost Budget E S H factors) :
    UniformLocalCriticalEmergenceReproduction
      U Proper Realizes Cost Budget E S H := by
  intro m parent child hStep
  obtain ⟨next, hEnvelope, hNext⟩ :=
    localCertifiedCriticalEmergenceEvent_implies_effective_successor
      U Proper Realizes Cost Budget E S H
      (factors m child) m child
      (hCertified m parent child hStep)
  exact
    (one_le_localEffectiveEmergenceSuccessorCount_iff_exists
      U Proper Realizes Cost Budget E S H m child).mpr
      ⟨next, hEnvelope, hNext⟩

/-- Corrected master recursive certificate. Global capacity may be infinite;
only the time-local envelope is finite. Representation is stored explicitly so
that open-ended recursive novelty also forces unbounded envelope capacity. -/
structure LocalEvolutionByEmergenceCoreCertificate
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) where
  retained : ∀ n, S n ⊆ S (n + 1)
  represented : ∀ n, S n ⊆ U n
  seedParent : Capacity
  seedChild : Capacity
  seed :
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H 0 seedParent seedChild
  factors : ℕ → Capacity → EmergenceReproductionFactors
  certifiedCritical :
    UniformLocalCertifiedCriticalEmergenceReproduction
      U Proper Realizes Cost Budget E S H factors

/-- Full recursive closure without global finiteness. -/
theorem evolutionByEmergenceLocalCore_openEnded
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (core :
      LocalEvolutionByEmergenceCoreCertificate
        U Proper Realizes Cost Budget E S H) :
    OpenEndedCumulativeNovelty S := by
  exact
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
      U Proper Realizes Cost Budget E S H
      core.retained core.seed
      (uniformLocalCertifiedCritical_implies_uniformLocalCritical
        U Proper Realizes Cost Budget E S H
        core.factors core.certifiedCritical)

/-- The same corrected certificate closes the recursive theory onto the
necessary open-ended distinguishability condition. -/
theorem evolutionByEmergenceLocalCore_unboundedEnvelope
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (core :
      LocalEvolutionByEmergenceCoreCertificate
        U Proper Realizes Cost Budget E S H) :
    UnboundedEnvelopeCapacity U := by
  exact
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_unboundedEnvelope
      U Proper Realizes Cost Budget E S H
      core.represented core.retained core.seed
      (uniformLocalCertifiedCritical_implies_uniformLocalCritical
        U Proper Realizes Cost Budget E S H
        core.factors core.certifiedCritical)

end LocalCertifiedCore

section LocalMasterSurface

variable {σ φ Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Corrected master surface: self-maintenance leverage and the locally
calibrated recursive-emergence certificate remain separate premises, while the
recursive leg now yields both open-ended retained novelty and the required
unbounded moving envelope without assuming a globally finite capacity type. -/
theorem evolutionByEmergence_local_master_surface
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (target : φ)
    (hOpening :
      SelfMaintenanceOpening
        targets oldCost newCost uptake maintenance
        g beta oldState newState target)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (core :
      LocalEvolutionByEmergenceCoreCertificate
        U Proper Realizes Cost Budget E S H) :
    ((beta * StateSlack uptake maintenance g oldState
        < beta * StateSlack uptake maintenance g newState)
      ∧
      ∃ burden,
        ¬ EnergeticBurdenTolerated
            uptake maintenance g oldState burden
        ∧ EnergeticBurdenTolerated
            uptake maintenance g newState burden)
    ∧
    StrictExpandsOn targets
      (SlackFundedFunctionalAccess
        oldCost uptake maintenance g beta oldState)
      (SlackFundedFunctionalAccess
        newCost uptake maintenance g beta newState)
    ∧
    OpenEndedCumulativeNovelty S
    ∧
    UnboundedEnvelopeCapacity U := by
  have hLeverage :=
    selfMaintenanceOpening_consequences
      targets oldCost newCost uptake maintenance
      g beta oldState newState target hOpening
  exact ⟨hLeverage.1, hLeverage.2,
    evolutionByEmergenceLocalCore_openEnded
      U Proper Realizes Cost Budget E S H core,
    evolutionByEmergenceLocalCore_unboundedEnvelope
      U Proper Realizes Cost Budget E S H core⟩

end LocalMasterSurface

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
#print axioms evolutionByEmergenceCoreCertificate_impossible
#print axioms localCertifiedCriticalEmergenceEvent_implies_effective_successor
#print axioms uniformLocalCertifiedCritical_implies_uniformLocalCritical
#print axioms evolutionByEmergenceLocalCore_openEnded
#print axioms evolutionByEmergenceLocalCore_unboundedEnvelope
#print axioms evolutionByEmergence_local_master_surface
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
