import CumulativeAccessibility.EmergenceReproduction

namespace CumulativeAccessibility
namespace RecursiveAccessibility

open FunctionalOrganization

/-!
# Evolution by Emergence — master formal core

This file is intentionally a theorem surface, not another mechanism layer.

It composes the now-separated parts of the formal stack into one auditable
sufficient-condition architecture:

1. self-maintenance leverage can simultaneously enlarge endogenous response
   budget, energetic solvency buffer, and a declared future-access set;
2. a seed recursive-emergence event establishes the first retained
   composition-to-parent transition;
3. an event-specific reproduction ledger may be used only through an explicit
   calibration seam certifying it below the actual effective successor count;
4. uniform certified criticality (R_E >= 1) gives a child-reusing successor to
   every realized recursive-emergence event;
5. monotone retention turns that local continuation property into open-ended
   cumulative novelty.

The load-bearing non-theorem is explicit:

    self-maintenance leverage
      -/-> certified emergence reproduction.

The mapping from measured slack / persistence / barrier changes into the
reproduction factors and their calibration to actual effective successors is
application-specific. The universal formal core composes that bridge once an
application supplies it; it does not manufacture it.

This is the intended freeze-point surface for adversarial review.
-/

section CertifiedReproduction

variable {Config Context Capacity : Type*}
variable [Fintype Capacity] [DecidableEq Capacity]

/-- Event-wise reproduction-factor assignment. An application may derive these
factors analytically, empirically, or by a lower-bound argument. -/
abbrev EmergenceFactorAssignment :=
  ℕ → Capacity → EmergenceReproductionFactors

/-- Every realized recursive-emergence event carries a mechanism ledger at or
above criticality and an explicit certification that the ledger is no larger
than the actual deterministic effective successor count.

This predicate is the formal calibration seam between the continuous/rate
ledger and the discrete effective successor process. -/
def UniformCertifiedCriticalEmergenceReproduction
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (factors : EmergenceFactorAssignment) : Prop :=
  ∀ m parent child,
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H m parent child →
    CertifiedCriticalEmergenceEvent
      Proper Realizes Cost Budget E S H
      (factors m child) m child

/-- A uniformly certified critical ledger yields the actual deterministic
criticality predicate used by the recursive chain-reaction theorem. -/
theorem uniformCertifiedCritical_implies_uniformCritical
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (factors : EmergenceFactorAssignment)
    (hCertified :
      UniformCertifiedCriticalEmergenceReproduction
        Proper Realizes Cost Budget E S H factors) :
    UniformCriticalEmergenceReproduction
      Proper Realizes Cost Budget E S H := by
  intro m parent child hStep
  have hNext :
      ∃ next,
        RecursiveEmergenceStepAt
          Proper Realizes Cost Budget E S H (m + 1) child next :=
    certifiedCriticalEmergenceEvent_implies_effective_successor
      Proper Realizes Cost Budget E S H
      (factors m child) m child
      (hCertified m parent child hStep)
  exact
    (one_le_effectiveEmergenceSuccessorCount_iff_exists
      Proper Realizes Cost Budget E S H m child).mpr hNext

/-- The complete recursive-emergence certificate used by the master theorem.
Every premise is stored separately so an application or reviewer can attack
that seam directly. -/
structure EvolutionByEmergenceCoreCertificate
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) where
  retained : ∀ n, S n ⊆ S (n + 1)
  seedParent : Capacity
  seedChild : Capacity
  seed :
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H 0 seedParent seedChild
  factors : EmergenceFactorAssignment
  certifiedCritical :
    UniformCertifiedCriticalEmergenceReproduction
      Proper Realizes Cost Budget E S H factors

/-- Master recursive theorem: one retained seed plus calibrated event-wise
critical emergence reproduction is sufficient for open-ended cumulative
novelty. -/
theorem evolutionByEmergenceCore_openEnded
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
    OpenEndedCumulativeNovelty S := by
  exact seed_and_uniformCriticalEmergenceReproduction_imply_openEndedNovelty
    Proper Realizes Cost Budget E S H
    core.retained core.seed
    (uniformCertifiedCritical_implies_uniformCritical
      Proper Realizes Cost Budget E S H
      core.factors core.certifiedCritical)

end CertifiedReproduction

section LeverageSurface

variable {σ φ : Type*}

/-- A strict self-maintenance opening at one declared organization transition.

It contains exactly the premises needed for the checked "double dividend" and
strict future-access expansion:

* positive reinvestment;
* strict internal-slack gain;
* no declared target becomes more costly;
* one declared target crosses from inaccessible to accessible.

It does not contain generation, validation, retention, or reproduction. -/
def SelfMaintenanceOpening
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (target : φ) : Prop :=
  0 < beta ∧
  StateSlack uptake maintenance g oldState
    < StateSlack uptake maintenance g newState ∧
  NoMoreFunctionallyViscousOn
    targets oldCost newCost oldState newState ∧
  target ∈ targets ∧
  ¬ SlackFundedFunctionalAccess
      oldCost uptake maintenance g beta oldState target ∧
  SlackFundedFunctionalAccess
      newCost uptake maintenance g beta newState target

/-- A self-maintenance opening has the two checked consequences we want to keep
visible at the master surface: energetic budget/buffer gain and strict
slack-funded future-access expansion. -/
theorem selfMaintenanceOpening_consequences
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (target : φ)
    (h :
      SelfMaintenanceOpening
        targets oldCost newCost uptake maintenance
        g beta oldState newState target) :
    (beta * StateSlack uptake maintenance g oldState
        < beta * StateSlack uptake maintenance g newState
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
        newCost uptake maintenance g beta newState) := by
  rcases h with
    ⟨hBeta, hSlack, hCost, hTarget, hOld, hNew⟩
  constructor
  · exact strict_slack_gain_is_budget_and_buffer_gain
      uptake maintenance g beta oldState newState hBeta hSlack
  · exact selfMaintenanceLeverage_strictly_expands_with_witness
      targets oldCost newCost uptake maintenance
      g beta oldState newState
      (le_of_lt hBeta)
      ⟨le_of_lt hSlack, hCost⟩
      target hTarget hOld hNew

end LeverageSurface

section MasterSurface

variable {σ φ Config Context Capacity : Type*}
variable [Fintype Capacity] [DecidableEq Capacity]

/-- Single review surface for the current formal theory.

The theorem intentionally concludes two coupled-but-not-universally-identified
legs:

1. positive self-maintenance leverage opens energetic and future-access room;
2. a separately calibrated critical recursive-emergence process is open-ended.

The missing empirical bridge from (1) into the factors/calibration used in (2)
is therefore impossible to overlook in the theorem statement. -/
theorem evolutionByEmergence_master_surface
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
    OpenEndedCumulativeNovelty S := by
  have hLeverage :=
    selfMaintenanceOpening_consequences
      targets oldCost newCost uptake maintenance
      g beta oldState newState target hOpening
  exact ⟨hLeverage.1, hLeverage.2,
    evolutionByEmergenceCore_openEnded
      Proper Realizes Cost Budget E S H core⟩

end MasterSurface

section SeparationCalibration

/-- A critical-looking mechanism ledger is not by itself an actual successor
certificate. Here every ledger factor equals one, so the ledger is exactly one,
while the declared actual successor count is zero. -/
theorem ledgerCritical_without_calibration_does_not_force_actualCritical :
    EmergenceReproductionLedger 1 1 1 1 1 1 = 1
    ∧ ¬ (1 : ℝ) ≤ 0 := by
  constructor
  · norm_num [EmergenceReproductionLedger, RetainedSuccessFraction]
  · norm_num

/-- Consequently the lower-bound calibration seam is genuinely additional:
the preceding critical ledger cannot be certified below actual count zero. -/
theorem ledgerCritical_actualZero_not_certified :
    ¬ ReproductionLedgerCertifiedLowerBound
        0 1 1 1 1 1 1 := by
  intro h
  unfold ReproductionLedgerCertifiedLowerBound at h
  norm_num [EmergenceReproductionLedger, RetainedSuccessFraction] at h

end SeparationCalibration

section SeparationSeed

/-- A dead finite architecture used to show that uniform reproduction
conditions can be vacuous if no seed event ever occurs. -/
def deadRepertoire (_n : ℕ) : Finset Bool := {false}

def deadGenerator (_n : ℕ) : HyperGenerator Bool :=
  fun _ _ => False

def deadRealizes : CapacityRelation Bool Unit Bool :=
  fun _ _ _ => False

def deadCost : ResponseCost Bool := fun _ _ => 0

def deadBudget : ResponseBudget := fun _ => 0

def deadCriterion : ExternalCriterion Bool := fun _ _ => True

theorem deadRepertoire_retained :
    ∀ n, deadRepertoire n ⊆ deadRepertoire (n + 1) := by
  intro n
  simp [deadRepertoire]

theorem dead_has_no_recursiveEmergenceStep :
    ∀ m parent child,
      ¬ RecursiveEmergenceStepAt
        boolProper deadRealizes deadCost deadBudget deadCriterion
        deadRepertoire deadGenerator m parent child := by
  intro m parent child h
  rcases h.2.2 with ⟨config, ctx, hEvent⟩
  exact hEvent.1.1 (by simp [deadRealizes])

theorem dead_uniformCritical_is_vacuous :
    UniformCriticalEmergenceReproduction
      boolProper deadRealizes deadCost deadBudget deadCriterion
      deadRepertoire deadGenerator := by
  intro m parent child hStep
  exact False.elim
    (dead_has_no_recursiveEmergenceStep m parent child hStep)

theorem deadRepertoire_not_openEnded :
    ¬ OpenEndedCumulativeNovelty deadRepertoire := by
  intro hOpen
  obtain ⟨N, hN⟩ := hOpen 2
  have hBound :
      strictExpansionCount deadRepertoire N
        ≤ (Finset.univ : Finset Bool).card - (deadRepertoire 0).card :=
    strictExpansionCount_le_remaining_capacity
      (Finset.univ : Finset Bool) deadRepertoire
      (by intro n x hx; simp)
      deadRepertoire_retained N
  norm_num [deadRepertoire] at hBound
  omega

/-- Dropping the seed premise invalidates the core theorem: retention and
uniform criticality can both hold vacuously while no novelty occurs. -/
theorem uniformCritical_and_retention_without_seed_not_enough :
    (∀ n, deadRepertoire n ⊆ deadRepertoire (n + 1))
    ∧ UniformCriticalEmergenceReproduction
        boolProper deadRealizes deadCost deadBudget deadCriterion
        deadRepertoire deadGenerator
    ∧ ¬ OpenEndedCumulativeNovelty deadRepertoire := by
  exact ⟨deadRepertoire_retained,
    dead_uniformCritical_is_vacuous,
    deadRepertoire_not_openEnded⟩

end SeparationSeed

section SeparationCriticality

/-- One retained novelty event followed by permanent stasis. -/
def oneShotRepertoire : ℕ → Finset Bool
  | 0 => {false}
  | _ => {false, true}

def oneShotGenerator : ℕ → HyperGenerator Bool
  | 0 => fun parents child => false ∈ parents ∧ child = true
  | _ => fun _ _ => False

def oneShotRealizes : CapacityRelation Bool Unit Bool :=
  fun config _ child => config = true ∧ child = true

def oneShotCost : ResponseCost Bool := fun _ _ => 0

def oneShotBudget : ResponseBudget := fun _ => 0

def oneShotCriterion : ExternalCriterion Bool := fun _ _ => True

theorem oneShotRepertoire_retained :
    ∀ n, oneShotRepertoire n ⊆ oneShotRepertoire (n + 1) := by
  intro n x hx
  cases n with
  | zero =>
      simp [oneShotRepertoire] at hx ⊢
      exact Or.inl hx
  | succ n =>
      simpa [oneShotRepertoire] using hx

theorem oneShot_seed :
    RecursiveEmergenceStepAt
      boolProper oneShotRealizes
      oneShotCost oneShotBudget oneShotCriterion
      oneShotRepertoire oneShotGenerator
      0 false true := by
  refine ⟨?_, ?_, ?_⟩
  · simp [oneShotRepertoire]
  · refine ⟨{false}, by simp, ?_, ?_⟩
    · intro x hx
      have hxf : x = false := by simpa using hx
      subst x
      simp [oneShotRepertoire]
    · simp [oneShotGenerator]
  · refine ⟨true, (), ?_⟩
    constructor
    · constructor
      · simp [oneShotRealizes]
      · intro part hProper hPart
        have hPartFalse : part = false := hProper.1
        subst part
        simp [oneShotRealizes] at hPart
    · refine ⟨?_, ?_, ?_⟩
      · simp [RetainedIntegrationAt, oneShotRepertoire]
      · simp [ResourceFeasibleAt, oneShotCost, oneShotBudget,
          AccessibleByCost]
      · simp [oneShotCriterion]

theorem oneShot_no_successor_after_seed :
    ¬ ∃ next,
      RecursiveEmergenceStepAt
        boolProper oneShotRealizes
        oneShotCost oneShotBudget oneShotCriterion
        oneShotRepertoire oneShotGenerator
        1 true next := by
  rintro ⟨next, hNext⟩
  rcases hNext.2.1 with ⟨parents, hParent, hAvailable, hRule⟩
  simpa [oneShotGenerator] using hRule

theorem oneShot_not_uniformCritical :
    ¬ UniformCriticalEmergenceReproduction
      boolProper oneShotRealizes
      oneShotCost oneShotBudget oneShotCriterion
      oneShotRepertoire oneShotGenerator := by
  intro hCritical
  have hCount :=
    hCritical 0 false true oneShot_seed
  have hExists :=
    (one_le_effectiveEmergenceSuccessorCount_iff_exists
      boolProper oneShotRealizes
      oneShotCost oneShotBudget oneShotCriterion
      oneShotRepertoire oneShotGenerator 0 true).mp hCount
  exact oneShot_no_successor_after_seed hExists

theorem oneShotRepertoire_not_openEnded :
    ¬ OpenEndedCumulativeNovelty oneShotRepertoire := by
  intro hOpen
  obtain ⟨N, hN⟩ := hOpen 2
  have hBound :
      strictExpansionCount oneShotRepertoire N
        ≤ (Finset.univ : Finset Bool).card - (oneShotRepertoire 0).card :=
    strictExpansionCount_le_remaining_capacity
      (Finset.univ : Finset Bool) oneShotRepertoire
      (by intro n x hx; simp)
      oneShotRepertoire_retained N
  norm_num [oneShotRepertoire] at hBound
  omega

/-- Dropping the critical-reproduction premise also invalidates the core:
there may be a valid seed and perfect retention but only a finite one-shot
innovation. -/
theorem seed_and_retention_without_criticality_not_enough :
    RecursiveEmergenceStepAt
      boolProper oneShotRealizes
      oneShotCost oneShotBudget oneShotCriterion
      oneShotRepertoire oneShotGenerator
      0 false true
    ∧ (∀ n, oneShotRepertoire n ⊆ oneShotRepertoire (n + 1))
    ∧ ¬ UniformCriticalEmergenceReproduction
        boolProper oneShotRealizes
        oneShotCost oneShotBudget oneShotCriterion
        oneShotRepertoire oneShotGenerator
    ∧ ¬ OpenEndedCumulativeNovelty oneShotRepertoire := by
  exact ⟨oneShot_seed, oneShotRepertoire_retained,
    oneShot_not_uniformCritical, oneShotRepertoire_not_openEnded⟩

end SeparationCriticality

#print axioms uniformCertifiedCritical_implies_uniformCritical
#print axioms evolutionByEmergenceCore_openEnded
#print axioms selfMaintenanceOpening_consequences
#print axioms evolutionByEmergence_master_surface
#print axioms ledgerCritical_without_calibration_does_not_force_actualCritical
#print axioms ledgerCritical_actualZero_not_certified
#print axioms uniformCritical_and_retention_without_seed_not_enough
#print axioms oneShot_seed
#print axioms oneShot_not_uniformCritical
#print axioms seed_and_retention_without_criticality_not_enough

end RecursiveAccessibility
end CumulativeAccessibility
