import CumulativeAccessibility.RecursiveEmergence
import CumulativeAccessibility.ValidatedUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Recursive emergence to open-ended cumulative novelty

This module connects the local recursive-emergence step to the repository's
existing global uptake/open-endedness results.

The bridge keeps three assumptions distinct:

1. recursive emergence recurs arbitrarily late;
2. each recursively emergent child lies in the declared distinguishability
   envelope at the event time;
3. retained organization is monotone when open-ended cumulative novelty is
   concluded.

No theorem here derives recurrence, envelope coverage, or monotone retention
from emergence itself.

The main chain is

    recurring recursive emergence
      + event-time envelope coverage
      -> ValidatedGenerativeCapacityUptake
      + monotone retention
      -> OpenEndedCumulativeNovelty.

Because RecursiveEmergenceStepAt already contains explicit parent reuse,
compositional emergence, resource feasibility, external validation, and actual
next-step retention, this theorem closes the local-to-global emergence bridge
without defining a parallel uptake process.
-/

section RecurrenceDefinitions

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Recursive emergence events occur arbitrarily late.  Each event records an
explicit retained parent that participates in generation of the new child. -/
def RecurringRecursiveEmergence
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) : Prop :=
  ∀ n : ℕ, ∃ m parent child,
    n ≤ m ∧
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H m parent child

/-- Every child produced by a declared recursive-emergence step is represented
inside the distinguishability envelope at the same event time.

This is kept separate from recurrence because a process may repeatedly produce
retained emergent organization without the chosen envelope representing every
such event. -/
def RecursiveEmergenceEnvelopeCoverage
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S U : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) : Prop :=
  ∀ m parent child,
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H m parent child →
    child ∈ U m

end RecurrenceDefinitions

section LocalToExistingSuccess

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A recursive-emergence step whose child lies in the current envelope is an
instance of the repository's existing ResourceValidatedSuccessAt predicate.

This is the key compatibility theorem: recursive emergence feeds the established
response/uptake stack rather than creating a second success semantics. -/
theorem recursiveEmergenceStep_with_envelope_implies_resourceValidatedSuccessAt
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (U : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hEnvelope : child ∈ U m)
    (hStep :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child) :
    ResourceValidatedSuccessAt Cost Budget U H E S m := by
  rcases hStep.2.2 with ⟨config, ctx, hEmergentIntegration⟩
  exact
    resourceValidatedEmergentIntegration_with_generation_implies_resourceValidatedSuccessAt
      Proper Realizes Cost Budget U H E S
      m config ctx child
      hEnvelope
      (recursiveEmergenceStep_implies_generated
        Proper Realizes Cost Budget E S H m hStep)
      hEmergentIntegration

/-- Forgetting resource feasibility from the previous theorem produces the
ordinary validated success predicate used by the global uptake theorem. -/
theorem recursiveEmergenceStep_with_envelope_implies_validatedSuccessAt
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (U : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hEnvelope : child ∈ U m)
    (hStep :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child) :
    ValidatedSuccessAt U H E S m := by
  exact resourceValidatedSuccessAt_implies_validatedSuccessAt
    Cost Budget U H E S m
    (recursiveEmergenceStep_with_envelope_implies_resourceValidatedSuccessAt
      Proper Realizes Cost Budget U H E S m hEnvelope hStep)

end LocalToExistingSuccess

section GlobalBridge

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Recurrent recursive emergence plus event-time envelope coverage implies the
existing validated generative capacity uptake condition.

The proof chooses the recursively emergent child as the uptake witness and then
forgets the stronger resource-feasibility and explicit-parent-use information. -/
theorem recurringRecursiveEmergence_implies_validatedGenerativeCapacityUptake
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (U : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hRecurring :
      RecurringRecursiveEmergence
        Proper Realizes Cost Budget E S H)
    (hEnvelope :
      RecursiveEmergenceEnvelopeCoverage
        Proper Realizes Cost Budget E S U H) :
    ValidatedGenerativeCapacityUptake U H E S := by
  intro n
  obtain ⟨m, parent, child, hnm, hStep⟩ := hRecurring n
  have hSuccess :
      ResourceValidatedSuccessAt Cost Budget U H E S m :=
    recursiveEmergenceStep_with_envelope_implies_resourceValidatedSuccessAt
      Proper Realizes Cost Budget U H E S m
      (hEnvelope m parent child hStep) hStep
  rcases hSuccess with
    ⟨z, hzU, hzNot, hGen, hResource, hEval, hzNext⟩
  exact ⟨m, z, hnm, hzU, hzNot, hGen, hEval, hzNext⟩

/-- Main local-to-global emergence theorem.

If recursively emergent, explicitly parent-dependent, resource-feasible,
externally validated retained products continue to appear arbitrarily late; if
the chosen envelope represents each such new child at its event time; and if
retained repertoire is monotone, then cumulative retained novelty is open-ended
in the already-defined sense. -/
theorem recurringRecursiveEmergence_implies_openEndedNovelty
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (U : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hRecurring :
      RecurringRecursiveEmergence
        Proper Realizes Cost Budget E S H)
    (hEnvelope :
      RecursiveEmergenceEnvelopeCoverage
        Proper Realizes Cost Budget E S U H) :
    OpenEndedCumulativeNovelty S := by
  exact validatedGenerativeCapacityUptake_implies_openEndedNovelty
    U H E S hRetained
    (recurringRecursiveEmergence_implies_validatedGenerativeCapacityUptake
      Proper Realizes Cost Budget U H E S hRecurring hEnvelope)

/-- With the repository's ordinary representation premise, the same recursive
emergence process also forces unbounded distinguishability-envelope capacity. -/
theorem recurringRecursiveEmergence_implies_unboundedEnvelope
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (U : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hRecurring :
      RecurringRecursiveEmergence
        Proper Realizes Cost Budget E S H)
    (hEnvelope :
      RecursiveEmergenceEnvelopeCoverage
        Proper Realizes Cost Budget E S U H) :
    UnboundedEnvelopeCapacity U := by
  exact validatedGenerativeCapacityUptake_implies_unboundedEnvelope
    U H E S hRepresented hRetained
    (recurringRecursiveEmergence_implies_validatedGenerativeCapacityUptake
      Proper Realizes Cost Budget U H E S hRecurring hEnvelope)

end GlobalBridge

section ProgressiveRecursiveWitness

/-- A compositional-emergence realization relation for the existing progressive
architecture. At context/time `n`, the whole configuration realizes exactly
the next capacity `n+1`; the declared proper part does not. -/
def progressiveEmergentRealizes : CapacityRelation Bool ℕ ℕ :=
  fun config ctx z =>
    config = true ∧ z = ctx + 1

def progressiveEmergentCost : ResponseCost ℕ :=
  fun _ _ => 0

def progressiveEmergentBudget : ResponseBudget :=
  fun _ => 0

def progressiveEmergentCriterion : ExternalCriterion ℕ :=
  fun _ _ => True

/-- At every indexed time, the current terminal retained primitive `n`
explicitly participates in generation of the next candidate `n+1`. -/
theorem progressive_generated_using_current_parent
    (n : ℕ) :
    GeneratedUsingParent
      (fun x => x ∈ progressiveRepertoire n)
      (progressiveGenerator n)
      n (n + 1) := by
  refine ⟨{n}, by simp, ?_, ?_⟩
  · intro x hx
    have hxn : x = n := by simpa using hx
    subst x
    simp [progressiveRepertoire]
  · simp [progressiveGenerator]

/-- Every progressive update satisfies the full recursive-emergence predicate:
explicit parent reuse, compositional emergence, resource feasibility, external
validation, and next-step retention. -/
theorem progressive_recursiveEmergenceStep
    (n : ℕ) :
    RecursiveEmergenceStepAt
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator
      n n (n + 1) := by
  refine ⟨?_, progressive_generated_using_current_parent n, ?_⟩
  · simp [progressiveRepertoire]
  · refine ⟨true, n, ?_⟩
    constructor
    · constructor
      · simp [progressiveEmergentRealizes]
      · intro part hProper hPart
        have hPartFalse : part = false := hProper.1
        subst part
        simp [progressiveEmergentRealizes] at hPart
    · refine ⟨?_, ?_, ?_⟩
      · constructor
        · simp [progressiveRepertoire]
        · simp [progressiveRepertoire]
      · simp [ResourceFeasibleAt, progressiveEmergentCost,
          progressiveEmergentBudget, AccessibleByCost]
      · simp [progressiveEmergentCriterion]

/-- The progressive architecture supplies recursively emergent events at every
time, hence in particular arbitrarily late. -/
theorem progressive_has_recurringRecursiveEmergence :
    RecurringRecursiveEmergence
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator := by
  intro n
  exact ⟨n, n, n + 1, le_rfl, progressive_recursiveEmergenceStep n⟩

/-- Every recursively emergent progressive child is represented by the existing
progressive distinguishability envelope at its event time. -/
theorem progressive_has_recursiveEmergenceEnvelopeCoverage :
    RecursiveEmergenceEnvelopeCoverage
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveEnvelope progressiveGenerator := by
  intro m parent child hStep
  have hInt : RetainedIntegrationAt progressiveRepertoire m child :=
    recursiveEmergenceStep_retains_new_child
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator m hStep
  simp [progressiveEnvelope, progressiveRepertoire] at hInt ⊢
  omega

/-- Non-vacuity witness: the existing progressive architecture satisfies
validated generative uptake specifically through recurrent recursive emergence,
not merely through the weaker original generation predicate. -/
theorem progressive_validatedUptake_via_recursiveEmergence :
    ValidatedGenerativeCapacityUptake
      progressiveEnvelope progressiveGenerator
      progressiveEmergentCriterion progressiveRepertoire := by
  exact recurringRecursiveEmergence_implies_validatedGenerativeCapacityUptake
    boolProper progressiveEmergentRealizes
    progressiveEmergentCost progressiveEmergentBudget
    progressiveEnvelope progressiveGenerator
    progressiveEmergentCriterion progressiveRepertoire
    progressive_has_recurringRecursiveEmergence
    progressive_has_recursiveEmergenceEnvelopeCoverage

/-- Concrete global consequence: recurrent recursive emergence makes the
progressive retained repertoire open-ended. -/
theorem progressive_openEnded_via_recursiveEmergence :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  exact recurringRecursiveEmergence_implies_openEndedNovelty
    boolProper progressiveEmergentRealizes
    progressiveEmergentCost progressiveEmergentBudget
    progressiveEnvelope progressiveGenerator
    progressiveEmergentCriterion progressiveRepertoire
    progressiveRepertoire_retained
    progressive_has_recurringRecursiveEmergence
    progressive_has_recursiveEmergenceEnvelopeCoverage

end ProgressiveRecursiveWitness

#print axioms recursiveEmergenceStep_with_envelope_implies_resourceValidatedSuccessAt
#print axioms recursiveEmergenceStep_with_envelope_implies_validatedSuccessAt
#print axioms recurringRecursiveEmergence_implies_validatedGenerativeCapacityUptake
#print axioms recurringRecursiveEmergence_implies_openEndedNovelty
#print axioms recurringRecursiveEmergence_implies_unboundedEnvelope
#print axioms progressive_generated_using_current_parent
#print axioms progressive_recursiveEmergenceStep
#print axioms progressive_has_recurringRecursiveEmergence
#print axioms progressive_has_recursiveEmergenceEnvelopeCoverage
#print axioms progressive_validatedUptake_via_recursiveEmergence
#print axioms progressive_openEnded_via_recursiveEmergence

end RecursiveAccessibility
end CumulativeAccessibility
