import CumulativeAccessibility.EmergenceDrivenRecursion
import CumulativeAccessibility.CapacityUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Recurrence of emergence-driven vocabulary expansion

This module lifts the finite causal event from EmergenceDrivenRecursion.lean
into two deliberately distinct temporal notions.

1. EmergenceDrivenVocabularyChain is a linked lineage: each retained child is
   the designated parent of the next strong vocabulary event.
2. RecurringEmergenceDrivenVocabularyExpansion only says that strong
   vocabulary-expansion events occur arbitrarily late. It does not assert that
   all such events lie on one lineage.

The second notion is sufficient for open-ended counting under monotone
retention. The first notion is the stronger lineage object to use when an
application claims descent through explicit reuse.
-/

section LinkedChains

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A finite linked lineage of strong emergence-driven vocabulary events. -/
abbrev EmergenceDrivenVocabularyChain
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (start : ℕ)
    (seed : Capacity)
    (n : ℕ)
    (endpoint : Capacity) : Prop :=
  TimedRecursiveChain
    (EmergenceDrivenVocabularyExpansionAt
      targets RuleOf Realizes Cost Budget E S)
    start seed n endpoint

/-- Every linked strong-vocabulary chain projects to the earlier
resource-validated recursive-emergence chain. Thus the new strong event
strengthens rather than replaces the established recursion semantics. -/
theorem emergenceDrivenVocabularyChain_implies_recursiveEmergenceChain
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hChain :
      EmergenceDrivenVocabularyChain
        targets RuleOf Realizes Cost Budget E S start seed n endpoint) :
    ResourceValidatedRecursiveEmergenceChain
      (FiniteProperSubconfig (Process := Capacity))
      Realizes Cost Budget E S
      (GeneratorFromRepertoire RuleOf S)
      start seed n endpoint := by
  induction hChain with
  | base =>
      exact TimedRecursiveChain.base
  | @step n parent child hPrefix hLink ih =>
      exact TimedRecursiveChain.step ih
        (parentFaithful_implies_recursiveEmergenceStep
          (GeneratorFromRepertoire RuleOf S)
          Realizes Cost Budget E S
          (start + n) hLink.1)

/-- If the seed is active, the endpoint of every finite linked strong-vocabulary
chain is active at its corresponding endpoint time. -/
theorem emergenceDrivenVocabularyChain_endpoint_active
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hSeed : seed ∈ S start)
    (hChain :
      EmergenceDrivenVocabularyChain
        targets RuleOf Realizes Cost Budget E S start seed n endpoint) :
    endpoint ∈ S (start + n) := by
  exact recursiveEmergenceChain_endpoint_active
    (FiniteProperSubconfig (Process := Capacity))
    Realizes Cost Budget E S
    (GeneratorFromRepertoire RuleOf S)
    start seed hSeed
    (emergenceDrivenVocabularyChain_implies_recursiveEmergenceChain
      targets RuleOf Realizes Cost Budget E S start seed hChain)

/-- Under monotone retention, every link of a finite strong-vocabulary lineage
is also a strict retained-repertoire expansion. The closure-expansion clause is
part of the event qualification; the cardinality conclusion itself follows
from the event's retained-new-child component. -/
theorem emergenceDrivenVocabularyChain_strict_at_each_link
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hRetained : ∀ t, S t ⊆ S (t + 1))
    (hChain :
      EmergenceDrivenVocabularyChain
        targets RuleOf Realizes Cost Budget E S start seed n endpoint) :
    ∀ k, k < n → S (start + k) ⊂ S (start + k + 1) := by
  exact recursiveEmergenceChain_strict_at_each_link
    (FiniteProperSubconfig (Process := Capacity))
    Realizes Cost Budget E S
    (GeneratorFromRepertoire RuleOf S)
    start seed hRetained
    (emergenceDrivenVocabularyChain_implies_recursiveEmergenceChain
      targets RuleOf Realizes Cost Budget E S start seed hChain)

end LinkedChains

section RecurringStrongEvents

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Strong emergence-driven vocabulary-expansion events occur arbitrarily late.

This is an event-frequency property, not a single-lineage claim. Each counted
event nevertheless contains parent-faithful compositional emergence, filtered
retention, isolated integration, and strict full-closure expansion. -/
def RecurringEmergenceDrivenVocabularyExpansion
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity) : Prop :=
  ∀ n : ℕ, ∃ m parent child,
    n ≤ m ∧
    EmergenceDrivenVocabularyExpansionAt
      targets RuleOf Realizes Cost Budget E S m parent child

/-- Recurring strong vocabulary events imply ordinary eventual novelty uptake
when the event's next retained repertoire is used as the bookkeeping envelope.

No extra empirical envelope claim is introduced by this theorem; the auxiliary
envelope is only a way to reuse the already-checked counting result. -/
theorem recurringEmergenceDrivenVocabularyExpansion_implies_eventualNovelUptake
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hRecurring :
      RecurringEmergenceDrivenVocabularyExpansion
        targets RuleOf Realizes Cost Budget E S) :
    EventualNovelUptake (fun m => S (m + 1)) S := by
  intro n
  obtain ⟨m, parent, child, hnm, hEvent⟩ := hRecurring n
  have hIntegration :
      RetainedIntegrationAt S m child :=
    parentFaithful_retains_new_child
      (GeneratorFromRepertoire RuleOf S)
      Realizes Cost Budget E S m hEvent.1
  exact ⟨m, child, hnm, hIntegration.2, hIntegration.1, hIntegration.2⟩

/-- If strong vocabulary-expansion events recur arbitrarily late and old
organization is monotonically retained, then the retained repertoire undergoes
arbitrarily many strict expansions.

This theorem does not say that compositional emergence alone causes
open-endedness. It says that repeatedly realized *strong* EbE events, each of
which already includes the full emergence -> retention -> closure-expansion
chain, are sufficient for open-ended retained novelty. -/
theorem recurringEmergenceDrivenVocabularyExpansion_implies_openEndedNovelty
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hRecurring :
      RecurringEmergenceDrivenVocabularyExpansion
        targets RuleOf Realizes Cost Budget E S) :
    OpenEndedCumulativeNovelty S := by
  exact eventualNovelUptake_implies_openEndedNovelty
    (fun m => S (m + 1)) S hRetained
    (recurringEmergenceDrivenVocabularyExpansion_implies_eventualNovelUptake
      targets RuleOf Realizes Cost Budget E S hRecurring)

/-- If the active retained repertoire is represented in a declared moving
envelope, recurring strong vocabulary events also force that envelope to have
unbounded capacity. -/
theorem recurringEmergenceDrivenVocabularyExpansion_implies_unboundedEnvelope
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S U : ℕ → Finset Capacity)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hRecurring :
      RecurringEmergenceDrivenVocabularyExpansion
        targets RuleOf Realizes Cost Budget E S) :
    UnboundedEnvelopeCapacity U := by
  apply openEndedNovelty_implies_unboundedEnvelopeCapacity
    U S hRepresented hRetained
  exact
    recurringEmergenceDrivenVocabularyExpansion_implies_openEndedNovelty
      targets RuleOf Realizes Cost Budget E S hRetained hRecurring

end RecurringStrongEvents

#print axioms emergenceDrivenVocabularyChain_implies_recursiveEmergenceChain
#print axioms emergenceDrivenVocabularyChain_endpoint_active
#print axioms emergenceDrivenVocabularyChain_strict_at_each_link
#print axioms recurringEmergenceDrivenVocabularyExpansion_implies_eventualNovelUptake
#print axioms recurringEmergenceDrivenVocabularyExpansion_implies_openEndedNovelty
#print axioms recurringEmergenceDrivenVocabularyExpansion_implies_unboundedEnvelope

end RecursiveAccessibility
end CumulativeAccessibility
