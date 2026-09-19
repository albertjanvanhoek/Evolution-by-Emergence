import CumulativeAccessibility.RecursiveEmergenceOpenEnded

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Active repertoire versus cumulative historical trace

The original open-ended recursive theorem uses one time-indexed finite set S
both as:

1. the capacities currently available as parent material; and
2. the cumulative retained repertoire whose strict expansions are counted.

That is a useful idealization, but it makes monotone operational retention
load-bearing. Real systems can forget, lose, replace, extinguish, or deactivate
capacities while still leaving a cumulative historical trace.

This module separates those roles.

- Active_t is the currently operational repertoire used for generation.
- History_t is a cumulative trace of capacities that have genuinely appeared.

A historical recursive-emergence event is an ordinary active-repertoire
recursive event whose child is also new to History and added to History at the
next step.

The main result shows that cumulative historical novelty can be open-ended even
when the active repertoire turns over and stays bounded. Thus monotone active
retention is not required for the weaker historical endpoint.

This does not make forgotten capacities reusable. Parent reuse still requires
current activity in Active_t.
-/

section ActiveHistoryDefinitions

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- The basic semantic consistency conditions for an active/history split.

Every currently active capacity is represented in the historical trace, and the
historical trace itself is monotone. -/
def ActiveHistoryConsistent
    (Active History : ℕ → Finset Capacity) : Prop :=
  (∀ n, Active n ⊆ History n) ∧
  (∀ n, History n ⊆ History (n + 1))

/-- A recursive-emergence event in the active repertoire that is also genuinely
new to cumulative history.

The ordinary recursive step still controls current parent availability,
generation, emergence, feasibility, validation, and next-step operational
integration. The additional history clauses say that the child has never yet
entered the cumulative trace and is recorded there after the event. -/
def HistoricalRecursiveEmergenceStepAt
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (Active History : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (parent child : Capacity) : Prop :=
  RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E Active H m parent child
  ∧ child ∉ History m
  ∧ child ∈ History (m + 1)

/-- Historical recursive-emergence events occur arbitrarily late. -/
def RecurringHistoricalRecursiveEmergence
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (Active History : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) : Prop :=
  ∀ n : ℕ, ∃ m parent child,
    n ≤ m ∧
    HistoricalRecursiveEmergenceStepAt
      Proper Realizes Cost Budget E Active History H m parent child

end ActiveHistoryDefinitions

section HistoricalAccumulation

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A historical recursive-emergence event strictly expands cumulative history
whenever old history is retained. No monotonicity assumption is imposed on the
currently active repertoire. -/
theorem historicalRecursiveEmergenceStep_strictly_expands_history
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (Active History : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hHistory : ∀ n, History n ⊆ History (n + 1))
    (h :
      HistoricalRecursiveEmergenceStepAt
        Proper Realizes Cost Budget E Active History H m parent child) :
    History m ⊂ History (m + 1) := by
  exact Finset.ssubset_iff_subset_ne.mpr ⟨hHistory m, by
    intro hEq
    exact h.2.1 (by simpa [hEq] using h.2.2)⟩

/-- Recurring historical recursive emergence supplies arbitrarily late strict
expansions of cumulative history. -/
theorem recurringHistoricalRecursiveEmergence_gives_future_strict_history_step
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (Active History : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hHistory : ∀ n, History n ⊆ History (n + 1))
    (hRecurring :
      RecurringHistoricalRecursiveEmergence
        Proper Realizes Cost Budget E Active History H)
    (n : ℕ) :
    ∃ m, n ≤ m ∧ History m ⊂ History (m + 1) := by
  obtain ⟨m, parent, child, hnm, hStep⟩ := hRecurring n
  exact ⟨m, hnm,
    historicalRecursiveEmergenceStep_strictly_expands_history
      Proper Realizes Cost Budget E Active History H m
      hHistory hStep⟩

/-- Historical open-endedness without monotone active retention.

If genuinely history-new recursive-emergence events continue arbitrarily late
and the cumulative historical trace is retained, then the history contains
arbitrarily many strict expansions.

The active repertoire may shrink, turn over, or remain bounded. -/
theorem recurringHistoricalRecursiveEmergence_implies_openEndedHistory
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (Active History : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hHistory : ∀ n, History n ⊆ History (n + 1))
    (hRecurring :
      RecurringHistoricalRecursiveEmergence
        Proper Realizes Cost Budget E Active History H) :
    OpenEndedCumulativeNovelty History := by
  intro K
  induction K with
  | zero =>
      exact ⟨0, by simp [strictExpansionCount]⟩
  | succ K ih =>
      obtain ⟨n, hCountN⟩ := ih
      obtain ⟨m, hnm, hStrict⟩ :=
        recurringHistoricalRecursiveEmergence_gives_future_strict_history_step
          Proper Realizes Cost Budget E Active History H
          hHistory hRecurring n
      have hMonoCount :
          strictExpansionCount History n ≤ strictExpansionCount History m :=
        strictExpansionCount_monotone History hnm
      have hStep :
          strictExpansionCount History (m + 1)
            = strictExpansionCount History m + 1 := by
        rw [strictExpansionCount]
        simp [hStrict]
      refine ⟨m + 1, ?_⟩
      rw [hStep]
      omega

/-- The active/history architecture packages the monotone-history condition, so
its recurring historical recursion immediately yields open-ended cumulative
history. -/
theorem activeHistoryArchitecture_recursion_implies_openEndedHistory
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (Active History : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hArchitecture : ActiveHistoryConsistent Active History)
    (hRecurring :
      RecurringHistoricalRecursiveEmergence
        Proper Realizes Cost Budget E Active History H) :
    OpenEndedCumulativeNovelty History := by
  exact recurringHistoricalRecursiveEmergence_implies_openEndedHistory
    Proper Realizes Cost Budget E Active History H
    hArchitecture.2 hRecurring

end HistoricalAccumulation

section TurnoverHistoryWitness

/-- A permanently bounded active repertoire: exactly the current capacity n is
operational at time n. -/
def turnoverHistoryActive (n : ℕ) : Finset ℕ := {n}

/-- The cumulative historical trace records every capacity that has appeared up
through time n. -/
def turnoverHistoryTrace (n : ℕ) : Finset ℕ := Finset.range (n + 1)

/-- The current active capacity generates the next capacity. -/
def turnoverHistoryGenerator (n : ℕ) : HyperGenerator ℕ :=
  fun parents child => n ∈ parents ∧ child = n + 1

def turnoverHistoryRealizes : CapacityRelation Bool ℕ ℕ :=
  fun config ctx child => config = true ∧ child = ctx + 1

def turnoverHistoryCost : ResponseCost ℕ := fun _ _ => 0

def turnoverHistoryBudget : ResponseBudget := fun _ => 0

def turnoverHistoryCriterion : ExternalCriterion ℕ := fun _ _ => True

/-- Active capacities are always represented in history and history is
monotone. -/
theorem turnoverHistory_is_consistent :
    ActiveHistoryConsistent turnoverHistoryActive turnoverHistoryTrace := by
  constructor
  · intro n x hx
    have hxn : x = n := by
      simpa [turnoverHistoryActive] using hx
    subst x
    simp [turnoverHistoryTrace]
  · intro n x hx
    simp [turnoverHistoryTrace] at hx ⊢
    omega

/-- Every turnover transition is a full ordinary recursive-emergence event in
the active repertoire. -/
theorem turnoverHistory_recursiveEmergenceStep
    (n : ℕ) :
    RecursiveEmergenceStepAt
      boolProper turnoverHistoryRealizes
      turnoverHistoryCost turnoverHistoryBudget turnoverHistoryCriterion
      turnoverHistoryActive turnoverHistoryGenerator
      n n (n + 1) := by
  refine ⟨?_, ?_, ?_⟩
  · simp [turnoverHistoryActive]
  · refine ⟨{n}, by simp, ?_, ?_⟩
    · intro x hx
      have hxn : x = n := by simpa using hx
      subst x
      simp [turnoverHistoryActive]
    · simp [turnoverHistoryGenerator]
  · refine ⟨true, n, ?_⟩
    constructor
    · constructor
      · simp [turnoverHistoryRealizes]
      · intro part hProper hPart
        have hPartFalse : part = false := hProper.1
        subst part
        simp [turnoverHistoryRealizes] at hPart
    · refine ⟨?_, ?_, ?_⟩
      · simp [RetainedIntegrationAt, turnoverHistoryActive]
      · simp [ResourceFeasibleAt, turnoverHistoryCost, turnoverHistoryBudget,
          AccessibleByCost]
      · simp [turnoverHistoryCriterion]

/-- Every active turnover event is genuinely new to cumulative history. -/
theorem turnoverHistory_historicalRecursiveEmergenceStep
    (n : ℕ) :
    HistoricalRecursiveEmergenceStepAt
      boolProper turnoverHistoryRealizes
      turnoverHistoryCost turnoverHistoryBudget turnoverHistoryCriterion
      turnoverHistoryActive turnoverHistoryTrace turnoverHistoryGenerator
      n n (n + 1) := by
  refine ⟨turnoverHistory_recursiveEmergenceStep n, ?_, ?_⟩
  · simp [turnoverHistoryTrace]
  · simp [turnoverHistoryTrace]

/-- Historical recursive-emergence events occur at every time. -/
theorem turnoverHistory_has_recurringHistoricalRecursiveEmergence :
    RecurringHistoricalRecursiveEmergence
      boolProper turnoverHistoryRealizes
      turnoverHistoryCost turnoverHistoryBudget turnoverHistoryCriterion
      turnoverHistoryActive turnoverHistoryTrace turnoverHistoryGenerator := by
  intro n
  exact
    ⟨n, n, n + 1, le_rfl,
      turnoverHistory_historicalRecursiveEmergenceStep n⟩

/-- The cumulative history is open-ended even though the active repertoire can
turn over completely. -/
theorem turnoverHistory_history_is_openEnded :
    OpenEndedCumulativeNovelty turnoverHistoryTrace := by
  exact activeHistoryArchitecture_recursion_implies_openEndedHistory
    boolProper turnoverHistoryRealizes
    turnoverHistoryCost turnoverHistoryBudget turnoverHistoryCriterion
    turnoverHistoryActive turnoverHistoryTrace turnoverHistoryGenerator
    turnoverHistory_is_consistent
    turnoverHistory_has_recurringHistoricalRecursiveEmergence

/-- The currently operational repertoire has cardinality exactly one at every
time. Thus open-ended cumulative history does not imply an unbounded active
repertoire. -/
theorem turnoverHistory_active_card_eq_one
    (n : ℕ) :
    (turnoverHistoryActive n).card = 1 := by
  simp [turnoverHistoryActive]

/-- The active repertoire itself is not monotone retained. -/
theorem turnoverHistory_active_not_monotone :
    ¬ (∀ n, turnoverHistoryActive n ⊆ turnoverHistoryActive (n + 1)) := by
  intro h
  have h0 := h 0
  have hz : 0 ∈ turnoverHistoryActive 0 := by
    simp [turnoverHistoryActive]
  have hzNext := h0 hz
  simp [turnoverHistoryActive] at hzNext

/-- Explicit separation result: history can accumulate without either monotone
or growing active repertoire. -/
theorem openEndedHistory_with_bounded_turnover_active :
    OpenEndedCumulativeNovelty turnoverHistoryTrace
    ∧ (∀ n, (turnoverHistoryActive n).card = 1)
    ∧ ¬ (∀ n, turnoverHistoryActive n ⊆ turnoverHistoryActive (n + 1)) := by
  exact
    ⟨turnoverHistory_history_is_openEnded,
      turnoverHistory_active_card_eq_one,
      turnoverHistory_active_not_monotone⟩

end TurnoverHistoryWitness

#print axioms historicalRecursiveEmergenceStep_strictly_expands_history
#print axioms recurringHistoricalRecursiveEmergence_gives_future_strict_history_step
#print axioms recurringHistoricalRecursiveEmergence_implies_openEndedHistory
#print axioms activeHistoryArchitecture_recursion_implies_openEndedHistory
#print axioms turnoverHistory_is_consistent
#print axioms turnoverHistory_recursiveEmergenceStep
#print axioms turnoverHistory_historicalRecursiveEmergenceStep
#print axioms turnoverHistory_has_recurringHistoricalRecursiveEmergence
#print axioms turnoverHistory_history_is_openEnded
#print axioms turnoverHistory_active_card_eq_one
#print axioms turnoverHistory_active_not_monotone
#print axioms openEndedHistory_with_bounded_turnover_active

end RecursiveAccessibility
end CumulativeAccessibility
