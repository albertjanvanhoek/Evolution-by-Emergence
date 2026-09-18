import CumulativeAccessibility.DynamicVortex

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Concrete full-dynamic vortex witness

This file supplies a single internally funded architecture that inhabits the
composition interface from \`DynamicVortex.lean\`.

The witness uses natural numbers both as indexed organizational states and as
candidate labels.

* the external gradient is fixed at 10;
* maintenance demand is fixed at 6;
* state 0 captures 10 units, while every later state captures 11;
* all slack is routed into response budget, so the budget is 4 at baseline and
  5 thereafter;
* a response costs 9/2, so the initial 0 -> 1 organizational improvement opens
  that response window;
* opportunities start at time 1 and recur forever;
* the progressive generator retains one genuinely new candidate each round;
* the organizational search operator at state n exposes exactly candidates
  z <= n, so every n -> n+1 transition is a second-order click.

This is a satisfiability/composition witness, not a claim that real systems have
these numerical laws.
-/

section Definitions

/-- Indexed organizational state: the time index itself. -/
def vortexState (t : ℕ) : ℕ := t

/-- Fixed environmental driving value. -/
def vortexGradient : GradientStream := fun _ => 10

/-- Baseline state captures the supplied value; every later organization
captures one additional unit in this toy ledger. -/
def vortexUptake : UptakeFunction ℕ :=
  fun s g => if s = 0 then g else g + 1

/-- Constant maintenance demand. -/
def vortexMaintenance : MaintenanceDemand ℕ := fun _ => 6

/-- Full reinvestment is used only to keep the numerical witness transparent. -/
def vortexReinvestment : ReinvestmentFraction := fun _ => 1

/-- Response cost lies strictly between baseline and post-improvement budgets:
4 < 9/2 <= 5. -/
noncomputable def vortexResponseCost : ResponseCost ℕ :=
  fun _ _ => 9 / 2

/-- Opportunities begin after the budget-winding baseline transition. -/
def vortexOpportunity (t : ℕ) : Prop := 1 ≤ t

/-- Realized organizational transitions are successor steps. -/
def vortexStep (x y : ℕ) : Prop := y = x + 1

/-- Every state in the toy witness is viable. -/
def vortexViable (_x : ℕ) : Prop := True

/-- State n can search exactly the prefix of candidates up to n. -/
def vortexSearch : SearchOperator ℕ :=
  fun state z => z ≤ state

end Definitions

section LocalTurn

theorem vortex_baseline_slack :
    vortexUptake 0 10 - vortexMaintenance 0 = 4 := by
  norm_num [vortexUptake, vortexMaintenance]

theorem vortex_postImprovement_slack :
    vortexUptake 1 10 - vortexMaintenance 1 = 5 := by
  norm_num [vortexUptake, vortexMaintenance]

/-- Every successor transition strictly expands the declared prefix search
operator. -/
theorem vortex_successor_is_secondOrderClick
    (n : ℕ) :
    SecondOrderClick vortexStep vortexViable Set.univ vortexSearch n (n + 1) := by
  refine ⟨by simp [vortexStep], by simp [vortexViable], ?_⟩
  refine ⟨?_, n + 1, by simp, ?_, ?_⟩
  · intro z hz hOld
    simp [vortexSearch] at hOld ⊢
    omega
  · simp [vortexSearch]
  · simp [vortexSearch]

/-- The first organizational transition is simultaneously slack-improving and
second-order. -/
theorem vortex_baseline_to_one_is_dynamicTurn :
    DynamicVortexTurn
      vortexUptake vortexMaintenance
      vortexStep vortexViable Set.univ vortexSearch
      10 1 0 1 := by
  refine ⟨by norm_num, ?_, vortex_successor_is_secondOrderClick 0⟩
  norm_num [vortexUptake, vortexMaintenance]

/-- Exact numerical and search consequences of the first turn. -/
theorem vortex_baseline_to_one_opens_exact_response_and_search :
    (4 : ℝ) < 9 / 2 ∧
    (9 / 2 : ℝ) ≤ 5 ∧
    ¬ vortexSearch 0 1 ∧
    vortexSearch 1 1 := by
  constructor
  · norm_num
  constructor
  · norm_num
  constructor
  · simp [vortexSearch]
  · simp [vortexSearch]

end LocalTurn

section RecurrentWitness

theorem vortexOpportunity_recurring :
    RecurringOpportunity vortexOpportunity := by
  intro n
  refine ⟨n + 1, by omega, ?_⟩
  simp [vortexOpportunity]
  omega

/-- After the initial improvement, the internally generated response budget is
exactly 5 at every opportunity time. -/
theorem vortex_budget_at_opportunity
    (q : ℕ)
    (hq : vortexOpportunity q) :
    EndogenousResponseBudget
      vortexState vortexGradient vortexUptake vortexMaintenance vortexReinvestment q
      = 5 := by
  have hq0 : q ≠ 0 := by
    simp [vortexOpportunity] at hq
    omega
  norm_num [EndogenousResponseBudget, InternalSlackAt,
    vortexState, vortexGradient, vortexUptake, vortexMaintenance,
    vortexReinvestment, hq0]

/-- Every opportunity is answered immediately by a resource-feasible validated
novelty event and by a second-order organizational update. -/
theorem vortex_has_integrated_zeroLag_response :
    OpportunityConditionedEndogenousVortexResponseWithin
      0
      vortexOpportunity
      vortexResponseCost
      vortexState
      vortexGradient
      vortexUptake
      vortexMaintenance
      vortexReinvestment
      progressiveEnvelope
      progressiveGenerator
      acceptAllCriterion
      progressiveRepertoire
      vortexStep
      vortexViable
      Set.univ
      vortexSearch := by
  intro q hOpportunity
  refine ⟨q, le_rfl, by simp, ?_, ?_⟩
  · refine ⟨q + 1, ?_, ?_, ?_, ?_, ?_, ?_⟩
    · simp [progressiveEnvelope]
    · simp [progressiveRepertoire]
    · refine ⟨{q}, ?_, ?_⟩
      · intro x hx
        have hxq : x = q := by simpa using hx
        subst x
        simp [progressiveRepertoire]
      · simp [progressiveGenerator]
    · unfold ResourceFeasibleAt AccessibleByCost
      rw [vortex_budget_at_opportunity q hOpportunity]
      norm_num [vortexResponseCost]
    · simp [acceptAllCriterion]
    · simp [progressiveRepertoire]
  · simpa [vortexState] using vortex_successor_is_secondOrderClick q

/-- One concrete theorem now inhabits the combined dynamic core: internally
funded validated novelty is open-ended, the distinguishability envelope is
unbounded, and second-order organizational/search updates recur arbitrarily
late. -/
theorem vortex_full_dynamic_witness :
    OpenEndedCumulativeNovelty progressiveRepertoire ∧
    UnboundedEnvelopeCapacity progressiveEnvelope ∧
    RecurringSecondOrderUpdate
      vortexState vortexStep vortexViable Set.univ vortexSearch := by
  exact
    recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences
      0
      vortexOpportunity
      vortexResponseCost
      vortexState
      vortexGradient
      vortexUptake
      vortexMaintenance
      vortexReinvestment
      progressiveEnvelope
      progressiveGenerator
      acceptAllCriterion
      progressiveRepertoire
      vortexStep
      vortexViable
      Set.univ
      vortexSearch
      progressiveRepertoire_represented
      progressiveRepertoire_retained
      vortexOpportunity_recurring
      vortex_has_integrated_zeroLag_response

end RecurrentWitness

#print axioms vortex_baseline_to_one_is_dynamicTurn
#print axioms vortex_baseline_to_one_opens_exact_response_and_search
#print axioms vortexOpportunity_recurring
#print axioms vortex_budget_at_opportunity
#print axioms vortex_has_integrated_zeroLag_response
#print axioms vortex_full_dynamic_witness

end RecursiveAccessibility
end CumulativeAccessibility
