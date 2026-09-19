import CumulativeAccessibility.EmergencePersistenceBridge
import CumulativeAccessibility.GenerativeClosure

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Recursive emergence

This module turns the one-event emergence/persistence bridge into an explicitly
recursive process.

The central operation is narrow:

1. a previously retained capacity is available as operational material;
2. that capacity is an actual member of a finite parent set generating a later
   candidate;
3. the later candidate is compositionally emergent, resource-feasible,
   externally validated, and retained;
4. the later candidate is therefore available as parent material for another
   round.

The time-indexed chain below iterates this operation.  It does not assert that
every retained primitive generates another emergence event, that the process is
open-ended, or that every downstream use is beneficial.
-/

section ParentUse

variable {Capacity : Type*}
variable [DecidableEq Capacity]

/-- A generated candidate explicitly uses a designated parent.  This is
stronger than ordinary `GeneratedFromAvailable`, which only records existence
of some available parent set. -/
def GeneratedUsingParent
    (Available : Capacity → Prop)
    (Generate : HyperGenerator Capacity)
    (parent child : Capacity) : Prop :=
  ∃ parents : Finset Capacity,
    parent ∈ parents ∧
    (∀ x, x ∈ parents → Available x) ∧
    Generate parents child

/-- Forgetting which parent was essential recovers ordinary generation from the
available repertoire. -/
theorem generatedUsingParent_implies_generatedFromAvailable
    (Available : Capacity → Prop)
    (Generate : HyperGenerator Capacity)
    {parent child : Capacity}
    (h : GeneratedUsingParent Available Generate parent child) :
    GeneratedFromAvailable Available Generate child := by
  rcases h with ⟨parents, hParent, hAvailable, hGenerate⟩
  exact ⟨parents, hAvailable, hGenerate⟩

/-- Explicit parent use implies that the designated parent itself is available. -/
theorem generatedUsingParent_implies_parent_available
    (Available : Capacity → Prop)
    (Generate : HyperGenerator Capacity)
    {parent child : Capacity}
    (h : GeneratedUsingParent Available Generate parent child) :
    Available parent := by
  rcases h with ⟨parents, hParent, hAvailable, hGenerate⟩
  exact hAvailable parent hParent

end ParentUse

section EmergenceEvents

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Hide the configuration/context witness while retaining the fully filtered
emergence event at one indexed time. -/
def ResourceValidatedEmergentEventAt
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (φ : Capacity) : Prop :=
  ∃ config ctx,
    ResourceValidatedEmergentIntegrationAt
      Proper Realizes Cost Budget E S m config ctx φ

/-- One recursive emergence step.  The old primitive `parent` must actually
participate in a parent set generating `child`, and `child` must then cross
the complete emergence -> feasibility -> validation -> retention bridge at the
same indexed step. -/
def RecursiveEmergenceStepAt
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (parent child : Capacity) : Prop :=
  parent ∈ S m ∧
  GeneratedUsingParent (fun x => x ∈ S m) (H m) parent child ∧
  ResourceValidatedEmergentEventAt
    Proper Realizes Cost Budget E S m child

theorem recursiveEmergenceStep_implies_generated
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child) :
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) child := by
  exact generatedUsingParent_implies_generatedFromAvailable
    (fun x => x ∈ S m) (H m) h.2.1

/-- The child produced by a recursive emergence step is absent before the step
and retained immediately after it. -/
theorem recursiveEmergenceStep_retains_new_child
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child) :
    RetainedIntegrationAt S m child := by
  rcases h.2.2 with ⟨config, ctx, hEvent⟩
  exact hEvent.2.1

/-- Under monotone retention, every recursive emergence step is a strict
retained-repertoire expansion. -/
theorem recursiveEmergenceStep_strictly_expands_repertoire
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (h :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child) :
    S m ⊂ S (m + 1) := by
  have hInt : RetainedIntegrationAt S m child :=
    recursiveEmergenceStep_retains_new_child
      Proper Realizes Cost Budget E S H m h
  exact Finset.ssubset_iff_subset_ne.mpr ⟨hRetained m, by
    intro hEq
    exact hInt.1 (by simpa [hEq] using hInt.2)⟩

end EmergenceEvents

section TimedRecursion

variable {Capacity : Type*}

/-- Generic time-indexed recursive chain.  A chain of length `n` starting at
time `start` contains `n` successive links at times
`start, ..., start+n-1`. -/
inductive TimedRecursiveChain
    (Link : ℕ → Capacity → Capacity → Prop)
    (start : ℕ)
    (seed : Capacity) : ℕ → Capacity → Prop
  | base : TimedRecursiveChain Link start seed 0 seed
  | step {n : ℕ} {parent child : Capacity} :
      TimedRecursiveChain Link start seed n parent →
      Link (start + n) parent child →
      TimedRecursiveChain Link start seed (n + 1) child

end TimedRecursion

section EmergenceChain

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- The recursive emergence chain obtained by instantiating the generic timed
chain with the filtered parent-reuse step above. -/
abbrev ResourceValidatedRecursiveEmergenceChain
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (start : ℕ)
    (seed : Capacity)
    (n : ℕ)
    (endpoint : Capacity) : Prop :=
  TimedRecursiveChain
    (RecursiveEmergenceStepAt Proper Realizes Cost Budget E S H)
    start seed n endpoint

/-- If the seed is active at the starting time, every finite recursive-emergence
chain ends in a capacity active at its corresponding endpoint time.  Thus each
newly retained child is legitimate parent material for a later link. -/
theorem recursiveEmergenceChain_endpoint_active
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hSeed : seed ∈ S start)
    (hChain :
      ResourceValidatedRecursiveEmergenceChain
        Proper Realizes Cost Budget E S H start seed n endpoint) :
    endpoint ∈ S (start + n) := by
  induction hChain with
  | base =>
      simpa using hSeed
  | @step n parent child hPrefix hLink ih =>
      have hInt : RetainedIntegrationAt S (start + n) child :=
        recursiveEmergenceStep_retains_new_child
          Proper Realizes Cost Budget E S H (start + n) hLink
      simpa [Nat.add_assoc] using hInt.2

/-- Every link in a finite recursive-emergence chain is a strict retained
repertoire expansion when old repertoire is monotonically retained. -/
theorem recursiveEmergenceChain_strict_at_each_link
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hRetained : ∀ t, S t ⊆ S (t + 1))
    (hChain :
      ResourceValidatedRecursiveEmergenceChain
        Proper Realizes Cost Budget E S H start seed n endpoint) :
    ∀ k, k < n → S (start + k) ⊂ S (start + k + 1) := by
  induction hChain with
  | base =>
      intro k hk
      omega
  | @step n parent child hPrefix hLink ih =>
      intro k hk
      by_cases hkn : k < n
      · exact ih k hkn
      · have hEq : k = n := by omega
        subst k
        exact recursiveEmergenceStep_strictly_expands_repertoire
          Proper Realizes Cost Budget E S H (start + n)
          hRetained hLink

end EmergenceChain

section ConcreteRecursiveWitness

open Toy3

/-- A three-stage retained repertoire: `a` is initially available, `b` is
retained after the first emergence event, and `c` after the second. -/
def recursiveToyRepertoire : ℕ → Finset Toy3
  | 0 => {a}
  | 1 => {a, b}
  | _ => {a, b, c}

/-- The retained toy repertoire is monotone. -/
theorem recursiveToyRepertoire_retained :
    ∀ n, recursiveToyRepertoire n ⊆ recursiveToyRepertoire (n + 1) := by
  intro n x hx
  cases n with
  | zero =>
      simp [recursiveToyRepertoire] at hx ⊢
      exact Or.inl hx
  | succ n =>
      cases n with
      | zero =>
          simp [recursiveToyRepertoire] at hx ⊢
          rcases hx with hx | hx
          · exact Or.inl hx
          · exact Or.inr (Or.inl hx)
      | succ n =>
          simpa [recursiveToyRepertoire] using hx

/-- The existing sequential generator is used at every indexed round. -/
def recursiveToyGenerator : ℕ → HyperGenerator Toy3 :=
  fun _ => chainHyper

/-- At context 0 the whole realizes `b`; at context 1 it realizes `c`.
The declared proper part realizes neither. -/
def recursiveToyRealizes : CapacityRelation Bool ℕ Toy3 :=
  fun config ctx φ =>
    config = true ∧
      ((ctx = 0 ∧ φ = b) ∨ (ctx = 1 ∧ φ = c))

def recursiveToyCost : ResponseCost Toy3 :=
  fun _ _ => 0

def recursiveToyBudget : ResponseBudget :=
  fun _ => 0

def recursiveToyCriterion : ExternalCriterion Toy3 :=
  fun _ _ => True

theorem recursiveToy_b_emergent_integrated :
    ResourceValidatedEmergentIntegrationAt
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire
      0 true 0 b := by
  constructor
  · constructor
    · simp [recursiveToyRealizes]
    · intro part hProper hPart
      rcases hProper with ⟨rfl, rfl⟩
      simp [recursiveToyRealizes] at hPart
  · refine ⟨?_, ?_, ?_⟩
    · simp [RetainedIntegrationAt, recursiveToyRepertoire]
    · simp [ResourceFeasibleAt, recursiveToyCost, recursiveToyBudget,
        AccessibleByCost]
    · simp [recursiveToyCriterion]

theorem recursiveToy_c_emergent_integrated :
    ResourceValidatedEmergentIntegrationAt
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire
      1 true 1 c := by
  constructor
  · constructor
    · simp [recursiveToyRealizes]
    · intro part hProper hPart
      rcases hProper with ⟨rfl, rfl⟩
      simp [recursiveToyRealizes] at hPart
  · refine ⟨?_, ?_, ?_⟩
    · simp [RetainedIntegrationAt, recursiveToyRepertoire]
    · simp [ResourceFeasibleAt, recursiveToyCost, recursiveToyBudget,
        AccessibleByCost]
    · simp [recursiveToyCriterion]

/-- The retained first product `b` is an explicit parent of the second
candidate `c`. -/
theorem recursiveToy_b_generates_c_using_b :
    GeneratedUsingParent
      (fun x => x ∈ recursiveToyRepertoire 1)
      (recursiveToyGenerator 1) b c := by
  refine ⟨{b}, by simp, ?_, ?_⟩
  · intro x hx
    have hxb : x = b := by simpa using hx
    subst x
    simp [recursiveToyRepertoire]
  · simp [recursiveToyGenerator, chainHyper]

/-- The second event is therefore a genuine recursive-emergence step: the
product retained by the first event is reused as parent material for the next
emergent, filtered, retained product. -/
theorem recursiveToy_b_to_c_is_recursiveEmergenceStep :
    RecursiveEmergenceStepAt
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire recursiveToyGenerator
      1 b c := by
  refine ⟨?_, recursiveToy_b_generates_c_using_b, ?_⟩
  · simp [recursiveToyRepertoire]
  · exact ⟨true, 1, recursiveToy_c_emergent_integrated⟩

/-- Concrete two-event recursive process:
first `b` crosses the emergence/persistence bridge at time 0; then, at time 1,
that retained product is reused to generate the next emergent retained product
`c`. -/
theorem recursiveToy_two_event_recursive_emergence :
    ResourceValidatedEmergentEventAt
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire 0 b
    ∧
    ResourceValidatedRecursiveEmergenceChain
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire recursiveToyGenerator
      1 b 1 c := by
  constructor
  · exact ⟨true, 0, recursiveToy_b_emergent_integrated⟩
  · exact TimedRecursiveChain.step
      (TimedRecursiveChain.base
        (Link := RecursiveEmergenceStepAt
          boolProper recursiveToyRealizes
          recursiveToyCost recursiveToyBudget recursiveToyCriterion
          recursiveToyRepertoire recursiveToyGenerator)
        (start := 1) (seed := b))
      recursiveToy_b_to_c_is_recursiveEmergenceStep

/-- The concrete recursive process contains two strict repertoire expansions:
`{a} -> {a,b}` for the seed event and `{a,b} -> {a,b,c}` for the recursive
step. -/
theorem recursiveToy_two_strict_expansions :
    recursiveToyRepertoire 0 ⊂ recursiveToyRepertoire 1
    ∧ recursiveToyRepertoire 1 ⊂ recursiveToyRepertoire 2 := by
  constructor
  · exact recursiveEmergenceStep_strictly_expands_repertoire
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire recursiveToyGenerator 0
      recursiveToyRepertoire_retained
      ⟨by simp [recursiveToyRepertoire],
       ⟨by
          refine ⟨{a}, by simp, ?_, ?_⟩
          · intro x hx
            have hxa : x = a := by simpa using hx
            subst x
            simp [recursiveToyRepertoire]
          · simp [recursiveToyGenerator, chainHyper],
        ⟨true, 0, recursiveToy_b_emergent_integrated⟩⟩⟩
  · exact recursiveEmergenceStep_strictly_expands_repertoire
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire recursiveToyGenerator 1
      recursiveToyRepertoire_retained
      recursiveToy_b_to_c_is_recursiveEmergenceStep

end ConcreteRecursiveWitness

#print axioms generatedUsingParent_implies_generatedFromAvailable
#print axioms generatedUsingParent_implies_parent_available
#print axioms recursiveEmergenceStep_implies_generated
#print axioms recursiveEmergenceStep_retains_new_child
#print axioms recursiveEmergenceStep_strictly_expands_repertoire
#print axioms recursiveEmergenceChain_endpoint_active
#print axioms recursiveEmergenceChain_strict_at_each_link
#print axioms recursiveToy_b_emergent_integrated
#print axioms recursiveToy_c_emergent_integrated
#print axioms recursiveToy_b_generates_c_using_b
#print axioms recursiveToy_b_to_c_is_recursiveEmergenceStep
#print axioms recursiveToy_two_event_recursive_emergence
#print axioms recursiveToy_two_strict_expansions

end RecursiveAccessibility
end CumulativeAccessibility
