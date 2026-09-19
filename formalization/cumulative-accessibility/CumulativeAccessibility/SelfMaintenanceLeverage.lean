import CumulativeAccessibility.EndogenousBudgetBridge
import CumulativeAccessibility.FunctionalRatchetVelocity
import CumulativeAccessibility.RecursiveEmergenceOpenEnded

namespace CumulativeAccessibility
namespace RecursiveAccessibility

open FunctionalOrganization

/-!
# Self-maintenance leverage and recursive-emergence continuation

This module formalizes the narrow "chain-reaction" mechanism suggested by the
emergence bridge without asserting a universal law of increasing efficiency.

Three effects are kept distinct:

1. **energetic leverage** -- organization raises internal slack
   (captured throughput minus maintenance demand);
2. **energetic stabilizing leverage** -- in the explicitly declared
   resource-solvency model, the same slack is the maximum additional energetic
   burden that can be absorbed while remaining solvent;
3. **accessibility leverage** -- future functional/acquisition costs do not
   increase on a declared target family.

The first two are linked only because this section chooses the same resource
ledger for solvency and response. Other forms of robustness remain outside the
claim.

The module then defines a separate successor-realization premise for recursive
emergence. Slack and cheaper future access enlarge the feasible successor
region; they do not by themselves imply generation, external validation, or
retention. An initial recursive-emergence event plus a guaranteed later
successor to every such event is sufficient for recurrent recursive emergence,
which the existing theorem turns into open-ended cumulative novelty.
-/

section EnergeticBuffer

variable {σ : Type*}

/-- Net resource margin of an organizational state at a fixed external
gradient. This is the state-local version of `InternalSlackAt`. -/
def StateSlack
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g : ℝ)
    (state : σ) : ℝ :=
  uptake state g - maintenance state

/-- In the explicitly declared resource-solvency model, an additional energetic
burden is tolerable exactly when it does not exceed current slack. -/
def EnergeticBurdenTolerated
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g : ℝ)
    (state : σ)
    (burden : ℝ) : Prop :=
  burden ≤ StateSlack uptake maintenance g state

/-- A state with at least as much slack tolerates every energetic burden
tolerated by the old state. -/
theorem slack_improvement_preserves_energetic_tolerance
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g : ℝ)
    (oldState newState : σ)
    (hSlack :
      StateSlack uptake maintenance g oldState
        ≤ StateSlack uptake maintenance g newState) :
    ∀ burden,
      EnergeticBurdenTolerated uptake maintenance g oldState burden →
      EnergeticBurdenTolerated uptake maintenance g newState burden := by
  intro burden hOld
  exact le_trans hOld hSlack

/-- A strict slack increase opens a nonempty interval of energetic burdens that
would break the old resource ledger but remain tolerable under the new one. -/
theorem strict_slack_improvement_opens_energetic_buffer
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g : ℝ)
    (oldState newState : σ)
    (hSlack :
      StateSlack uptake maintenance g oldState
        < StateSlack uptake maintenance g newState) :
    ∃ burden,
      ¬ EnergeticBurdenTolerated uptake maintenance g oldState burden
      ∧ EnergeticBurdenTolerated uptake maintenance g newState burden := by
  let burden :=
    (StateSlack uptake maintenance g oldState
      + StateSlack uptake maintenance g newState) / 2
  refine ⟨burden, ?_, ?_⟩
  · unfold EnergeticBurdenTolerated
    exact not_le.mpr (by
      dsimp [burden]
      linarith)
  · unfold EnergeticBurdenTolerated
    dsimp [burden]
    linarith

/-- The same strict slack gain simultaneously raises a positively reinvested
response budget and opens an energetic disturbance-buffer window.

This is the precise "double dividend" available when response funding and
energetic solvency use the same resource ledger. -/
theorem strict_slack_gain_is_budget_and_buffer_gain
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (hBeta : 0 < beta)
    (hSlack :
      StateSlack uptake maintenance g oldState
        < StateSlack uptake maintenance g newState) :
    beta * StateSlack uptake maintenance g oldState
        < beta * StateSlack uptake maintenance g newState
    ∧
    ∃ burden,
      ¬ EnergeticBurdenTolerated uptake maintenance g oldState burden
      ∧ EnergeticBurdenTolerated uptake maintenance g newState burden := by
  constructor
  · exact mul_lt_mul_of_pos_left hSlack hBeta
  · exact strict_slack_improvement_opens_energetic_buffer
      uptake maintenance g oldState newState hSlack

end EnergeticBuffer

section CoupledAccessibility

variable {σ φ : Type*}

/-- Slack-funded access to a functional/future target. The budget is generated
from the current state-local slack with reinvestment fraction `beta`. -/
def SlackFundedFunctionalAccess
    (Cost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (state : σ)
    (target : φ) : Prop :=
  FunctionAccessibleWithin Cost
    (beta * StateSlack uptake maintenance g state)
    state target

/-- Joint weak self-maintenance leverage: the new organization has no less
internal slack and no declared target is more costly.

The definition intentionally does not claim that every such transition is
generated, valuable, stable under all perturbations, or retained. -/
def SelfMaintenanceLeverageOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g : ℝ)
    (oldState newState : σ) : Prop :=
  StateSlack uptake maintenance g oldState
      ≤ StateSlack uptake maintenance g newState
  ∧
  NoMoreFunctionallyViscousOn
    targets oldCost newCost oldState newState

/-- With nonnegative reinvestment, joint weak leverage preserves every declared
target that was previously affordable from endogenous slack. -/
theorem selfMaintenanceLeverage_preserves_slackFundedAccess
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (hBeta : 0 ≤ beta)
    (hLeverage :
      SelfMaintenanceLeverageOn targets oldCost newCost
        uptake maintenance g oldState newState) :
    PreservesOn targets
      (SlackFundedFunctionalAccess
        oldCost uptake maintenance g beta oldState)
      (SlackFundedFunctionalAccess
        newCost uptake maintenance g beta newState) := by
  intro target htarget hOld
  change oldCost oldState target
      ≤ beta * StateSlack uptake maintenance g oldState at hOld
  change newCost newState target
      ≤ beta * StateSlack uptake maintenance g newState
  have hBudget :
      beta * StateSlack uptake maintenance g oldState
        ≤ beta * StateSlack uptake maintenance g newState :=
    mul_le_mul_of_nonneg_left hLeverage.1 hBeta
  exact le_trans (hLeverage.2 target htarget)
    (le_trans hOld hBudget)

/-- If, in addition to weak joint leverage, one declared target is newly
affordable under the new slack-funded budget, the feasible target family
strictly expands. -/
theorem selfMaintenanceLeverage_strictly_expands_with_witness
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (hBeta : 0 ≤ beta)
    (hLeverage :
      SelfMaintenanceLeverageOn targets oldCost newCost
        uptake maintenance g oldState newState)
    (target : φ)
    (hTarget : target ∈ targets)
    (hOld :
      ¬ SlackFundedFunctionalAccess
        oldCost uptake maintenance g beta oldState target)
    (hNew :
      SlackFundedFunctionalAccess
        newCost uptake maintenance g beta newState target) :
    StrictExpandsOn targets
      (SlackFundedFunctionalAccess
        oldCost uptake maintenance g beta oldState)
      (SlackFundedFunctionalAccess
        newCost uptake maintenance g beta newState) := by
  exact ⟨
    selfMaintenanceLeverage_preserves_slackFundedAccess
      targets oldCost newCost uptake maintenance
      g beta oldState newState hBeta hLeverage,
    target, hTarget, hOld, hNew⟩

/-- A concrete sufficient witness for strict expansion: a target whose old cost
exceeds the old endogenous budget while its new cost fits inside the new one. -/
theorem slack_and_cost_leverage_open_target
    (oldCost newCost : FunctionalCost σ φ)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (g beta : ℝ)
    (oldState newState : σ)
    (target : φ)
    (hOld :
      beta * StateSlack uptake maintenance g oldState
        < oldCost oldState target)
    (hNew :
      newCost newState target
        ≤ beta * StateSlack uptake maintenance g newState) :
    ¬ SlackFundedFunctionalAccess
        oldCost uptake maintenance g beta oldState target
    ∧
    SlackFundedFunctionalAccess
        newCost uptake maintenance g beta newState target := by
  constructor
  · intro h
    unfold SlackFundedFunctionalAccess FunctionAccessibleWithin at h
    exact (not_le_of_gt hOld) h
  · unfold SlackFundedFunctionalAccess FunctionAccessibleWithin
    exact hNew

end CoupledAccessibility

section LifetimeOpportunity

/-- Finite-horizon adaptive budget in the constant-rate specialization.

This is deliberately a bookkeeping object, not a universal fitness measure:
`horizon * beta * slack` records how much positively reinvested slack is
available over a declared persistence horizon when those quantities are treated
as constant over that horizon. -/
noncomputable def LifetimeAdaptiveBudget
    (beta slack : ℝ)
    (horizon : ℕ) : ℝ :=
  (horizon : ℝ) * (beta * slack)

/-- More slack and a no-shorter persistence horizon cannot reduce lifetime
adaptive budget when the old slack and reinvestment fraction are nonnegative. -/
theorem lifetimeAdaptiveBudget_mono
    (beta oldSlack newSlack : ℝ)
    (oldHorizon newHorizon : ℕ)
    (hBeta : 0 ≤ beta)
    (hOldSlack : 0 ≤ oldSlack)
    (hSlack : oldSlack ≤ newSlack)
    (hHorizon : oldHorizon ≤ newHorizon) :
    LifetimeAdaptiveBudget beta oldSlack oldHorizon
      ≤ LifetimeAdaptiveBudget beta newSlack newHorizon := by
  have hBudget :
      beta * oldSlack ≤ beta * newSlack :=
    mul_le_mul_of_nonneg_left hSlack hBeta
  have hOldBudget : 0 ≤ beta * oldSlack :=
    mul_nonneg hBeta hOldSlack
  have hHorizonReal :
      (oldHorizon : ℝ) ≤ (newHorizon : ℝ) := by
    exact_mod_cast hHorizon
  have hFirst :
      (oldHorizon : ℝ) * (beta * oldSlack)
        ≤ (newHorizon : ℝ) * (beta * oldSlack) :=
    mul_le_mul_of_nonneg_right hHorizonReal hOldBudget
  have hSecond :
      (newHorizon : ℝ) * (beta * oldSlack)
        ≤ (newHorizon : ℝ) * (beta * newSlack) :=
    mul_le_mul_of_nonneg_left hBudget (by positivity)
  exact le_trans hFirst hSecond

/-- At a fixed positive persistence horizon, a strict slack increase with
positive reinvestment strictly raises lifetime adaptive budget. -/
theorem lifetimeAdaptiveBudget_strict_of_slack_gain
    (beta oldSlack newSlack : ℝ)
    (horizon : ℕ)
    (hBeta : 0 < beta)
    (hHorizon : 0 < horizon)
    (hSlack : oldSlack < newSlack) :
    LifetimeAdaptiveBudget beta oldSlack horizon
      < LifetimeAdaptiveBudget beta newSlack horizon := by
  unfold LifetimeAdaptiveBudget
  have hBudget : beta * oldSlack < beta * newSlack :=
    mul_lt_mul_of_pos_left hSlack hBeta
  exact mul_lt_mul_of_pos_left hBudget (by
    exact_mod_cast hHorizon)

end LifetimeOpportunity

section RecursiveContinuation

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Every realized recursive-emergence event eventually receives a later
recursive-emergence successor that explicitly reuses its child as the parent of
that successor. The successor is at least one indexed step later and no more
than `lag` additional steps beyond that.

This is the remaining generation/validation/retention seam. It is not derived
from slack or cost improvement alone. -/
def RecursiveEmergenceSuccessorWithin
    (lag : ℕ)
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
    ∃ r next,
      m + 1 ≤ r ∧
      r ≤ m + 1 + lag ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H r child next

/-- Starting from one recursive-emergence event, a guaranteed successor to every
event yields events at arbitrarily large indexed depths. -/
theorem recursiveEmergenceSuccessorWithin_iterates
    (lag : ℕ)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (start : ℕ)
    {seedParent seedChild : Capacity}
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H start seedParent seedChild)
    (hSuccessor :
      RecursiveEmergenceSuccessorWithin
        lag Proper Realizes Cost Budget E S H) :
    ∀ k : ℕ, ∃ m parent child,
      start + k ≤ m ∧
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child := by
  intro k
  induction k with
  | zero =>
      exact ⟨start, seedParent, seedChild, by simp, hSeed⟩
  | succ k ih =>
      obtain ⟨m, parent, child, hmk, hStep⟩ := ih
      obtain ⟨r, next, hLater, hBound, hNext⟩ :=
        hSuccessor m parent child hStep
      refine ⟨r, child, next, ?_, hNext⟩
      omega

/-- A seed event at time zero plus the local successor guarantee is sufficient
for the previously assumed `RecurringRecursiveEmergence` condition.

This is the deterministic chain-reaction theorem: recurrence is reduced from a
global assumption to one initial event plus a local reproduction rule. -/
theorem seed_and_successorWithin_imply_recurringRecursiveEmergence
    (lag : ℕ)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    {seedParent seedChild : Capacity}
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H 0 seedParent seedChild)
    (hSuccessor :
      RecursiveEmergenceSuccessorWithin
        lag Proper Realizes Cost Budget E S H) :
    RecurringRecursiveEmergence
      Proper Realizes Cost Budget E S H := by
  intro n
  obtain ⟨m, parent, child, hnm, hStep⟩ :=
    recursiveEmergenceSuccessorWithin_iterates
      lag Proper Realizes Cost Budget E S H
      0 hSeed hSuccessor n
  refine ⟨m, parent, child, ?_, hStep⟩
  simpa using hnm

/-- Adding monotone retention closes the deterministic chain all the way to
open-ended cumulative novelty. -/
theorem seed_and_successorWithin_imply_openEndedNovelty
    (lag : ℕ)
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
    (hSuccessor :
      RecursiveEmergenceSuccessorWithin
        lag Proper Realizes Cost Budget E S H) :
    OpenEndedCumulativeNovelty S := by
  exact recurringRecursiveEmergence_implies_openEndedNovelty
    Proper Realizes Cost Budget H E S hRetained
    (seed_and_successorWithin_imply_recurringRecursiveEmergence
      lag Proper Realizes Cost Budget E S H hSeed hSuccessor)

end RecursiveContinuation

section ProgressiveContinuationWitness

/-- In the existing progressive architecture, every recursive-emergence event
has an immediate recursive-emergence successor. The generator equation forces
the current child to be exactly `m+1`, which is then reused as parent at the
next indexed step.

This is a non-vacuity witness for the local chain-reaction premise. -/
theorem progressive_has_recursiveEmergenceSuccessorWithin_zero :
    RecursiveEmergenceSuccessorWithin
      0
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator := by
  intro m parent child hStep
  rcases hStep.2.1 with ⟨parents, hParent, hAvailable, hRule⟩
  have hChild : child = m + 1 := hRule.2
  subst child
  refine ⟨m + 1, m + 2, le_rfl, ?_, ?_⟩
  · simp
  · simpa [Nat.add_assoc] using
      progressive_recursiveEmergenceStep (m + 1)

/-- The progressive architecture is therefore open-ended through the stronger
local chain-reaction route: one seed event plus immediate successor realization
at every recursive-emergence event. -/
theorem progressive_openEnded_via_local_chainReaction :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  exact seed_and_successorWithin_imply_openEndedNovelty
    0
    boolProper progressiveEmergentRealizes
    progressiveEmergentCost progressiveEmergentBudget
    progressiveEmergentCriterion
    progressiveRepertoire progressiveGenerator
    progressiveRepertoire_retained
    (progressive_recursiveEmergenceStep 0)
    progressive_has_recursiveEmergenceSuccessorWithin_zero

end ProgressiveContinuationWitness

section MinimalLeverageWitness

inductive LeverageState
  | old
  | improved
  deriving DecidableEq

inductive LeverageFunction
  | maintained
  | newCapacity
  deriving DecidableEq

open LeverageState LeverageFunction

def leverageUptake : UptakeFunction LeverageState
  | old, _ => 10
  | improved, _ => 11

def leverageMaintenance : MaintenanceDemand LeverageState
  | old => 6
  | improved => 6

def leverageFunctionalCost :
    FunctionalCost LeverageState LeverageFunction
  | old, maintained => 2
  | old, newCapacity => 5
  | improved, maintained => 2
  | improved, newCapacity => 4

/-- The minimal witness has slack 4 -> 5 and no functional target becomes more
costly; with full reinvestment the new capacity crosses from unaffordable to
affordable. -/
theorem leverageToy_selfMaintenanceLeverage :
    SelfMaintenanceLeverageOn Set.univ
      leverageFunctionalCost leverageFunctionalCost
      leverageUptake leverageMaintenance
      0 old improved := by
  constructor
  · norm_num [StateSlack, leverageUptake, leverageMaintenance]
  · intro target htarget
    cases target <;>
      norm_num [leverageFunctionalCost]

theorem leverageToy_newCapacity_opens :
    ¬ SlackFundedFunctionalAccess
        leverageFunctionalCost leverageUptake leverageMaintenance
        0 1 old newCapacity
    ∧
    SlackFundedFunctionalAccess
        leverageFunctionalCost leverageUptake leverageMaintenance
        0 1 improved newCapacity := by
  apply slack_and_cost_leverage_open_target
  · norm_num [StateSlack, leverageUptake, leverageMaintenance,
      leverageFunctionalCost]
  · norm_num [StateSlack, leverageUptake, leverageMaintenance,
      leverageFunctionalCost]

theorem leverageToy_strict_access_expansion :
    StrictExpandsOn Set.univ
      (SlackFundedFunctionalAccess
        leverageFunctionalCost leverageUptake leverageMaintenance
        0 1 old)
      (SlackFundedFunctionalAccess
        leverageFunctionalCost leverageUptake leverageMaintenance
        0 1 improved) := by
  exact selfMaintenanceLeverage_strictly_expands_with_witness
    Set.univ leverageFunctionalCost leverageFunctionalCost
    leverageUptake leverageMaintenance
    0 1 old improved
    (by norm_num)
    leverageToy_selfMaintenanceLeverage
    newCapacity (by simp)
    leverageToy_newCapacity_opens.1
    leverageToy_newCapacity_opens.2

theorem leverageToy_budget_and_buffer_gain :
    1 * StateSlack leverageUptake leverageMaintenance 0 old
      < 1 * StateSlack leverageUptake leverageMaintenance 0 improved
    ∧
    ∃ burden,
      ¬ EnergeticBurdenTolerated
          leverageUptake leverageMaintenance 0 old burden
      ∧ EnergeticBurdenTolerated
          leverageUptake leverageMaintenance 0 improved burden := by
  exact strict_slack_gain_is_budget_and_buffer_gain
    leverageUptake leverageMaintenance 0 1 old improved
    (by norm_num)
    (by norm_num [StateSlack, leverageUptake, leverageMaintenance])

end MinimalLeverageWitness

#print axioms slack_improvement_preserves_energetic_tolerance
#print axioms strict_slack_improvement_opens_energetic_buffer
#print axioms strict_slack_gain_is_budget_and_buffer_gain
#print axioms selfMaintenanceLeverage_preserves_slackFundedAccess
#print axioms selfMaintenanceLeverage_strictly_expands_with_witness
#print axioms slack_and_cost_leverage_open_target
#print axioms lifetimeAdaptiveBudget_mono
#print axioms lifetimeAdaptiveBudget_strict_of_slack_gain
#print axioms recursiveEmergenceSuccessorWithin_iterates
#print axioms seed_and_successorWithin_imply_recurringRecursiveEmergence
#print axioms seed_and_successorWithin_imply_openEndedNovelty
#print axioms progressive_has_recursiveEmergenceSuccessorWithin_zero
#print axioms progressive_openEnded_via_local_chainReaction
#print axioms leverageToy_selfMaintenanceLeverage
#print axioms leverageToy_newCapacity_opens
#print axioms leverageToy_strict_access_expansion
#print axioms leverageToy_budget_and_buffer_gain

end RecursiveAccessibility
end CumulativeAccessibility
