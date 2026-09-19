import CumulativeAccessibility.VocabularyEmergence
import CumulativeAccessibility.ResponseDynamics

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Emergence to retained operational integration

This module closes one deliberately narrow bridge:

    compositional emergence
      -> resource/validation filtering
      -> one-step retained integration
      -> durable operational availability under monotone retention
      -> downstream generative expansion when an explicit witness exists.

The distinctions are load-bearing.

* Emergence does not imply resource feasibility.
* Resource feasibility does not imply external validation.
* Validation does not imply retention.
* One-step retention does not imply durable persistence without a retention law.
* Durable primitive integration does not by itself imply downstream novelty.

The file therefore does not define "successful emergence" as a single primitive.
It composes already separate predicates and proves the consequences that follow
once their premises are jointly supplied.
-/

section RetainedIntegration

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A capacity crosses the operational boundary at time `m`: it was absent
from the active repertoire and is present in the next retained repertoire. -/
def RetainedIntegrationAt
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (φ : Capacity) : Prop :=
  φ ∉ S m ∧ φ ∈ S (m + 1)

/-- The retained integration also passes the package's declared quantitative
resource-feasibility test and external validation criterion. -/
def ResourceValidatedRetentionAt
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (φ : Capacity) : Prop :=
  RetainedIntegrationAt S m φ ∧
  ResourceFeasibleAt Cost Budget m φ ∧
  E m φ

/-- A compositionally emergent capacity that also passes resource feasibility,
external validation, and actual next-step retention.

The predicate packages the bridge premises; it does not claim that emergence
causes any of the downstream filters. -/
def ResourceValidatedEmergentIntegrationAt
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (config : Config)
    (ctx : Context)
    (φ : Capacity) : Prop :=
  EmergentUnder Proper Realizes config ctx φ ∧
  ResourceValidatedRetentionAt Cost Budget E S m φ

/-- Once a filtered emergent capacity is actually retained, it is an
operational-vocabulary expansion relative to the previous active repertoire. -/
theorem resourceValidatedEmergentIntegration_implies_operationalExpansion
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (h :
      ResourceValidatedEmergentIntegrationAt
        Proper Realizes Cost Budget E S m config ctx φ) :
    OperationalVocabularyExpansion
      (fun ψ => ψ ∈ S m) Realizes config ctx φ := by
  refine ⟨h.1.1, ?_⟩
  exact h.2.1.1

/-- If the old active repertoire is retained into the next step, an actually
integrated new capacity makes the next active repertoire a strict expansion. -/
theorem retainedIntegration_strictly_expands_next
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (φ : Capacity)
    (hPreserve : S m ⊆ S (m + 1))
    (hIntegrate : RetainedIntegrationAt S m φ) :
    StrictExpandsOn Set.univ
      (fun ψ => ψ ∈ S m)
      (fun ψ => ψ ∈ S (m + 1)) := by
  refine ⟨?_, φ, by simp, hIntegrate.1, hIntegrate.2⟩
  intro ψ hψ hOld
  exact hPreserve hOld

/-- Actual next-step retention contains the minimal hypothetical integration
used in `VocabularyEmergence.lean`: every old active primitive remains
available and the newly integrated primitive is available. -/
theorem retainedIntegration_contains_minimal_operationalIntegration
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (φ : Capacity)
    (hPreserve : S m ⊆ S (m + 1))
    (hIntegrate : RetainedIntegrationAt S m φ) :
    ∀ ψ,
      IntegrateOperationalCapacity (fun x => x ∈ S m) φ ψ →
      ψ ∈ S (m + 1) := by
  intro ψ hψ
  change (ψ ∈ S m ∨ ψ = φ) at hψ
  rcases hψ with hOld | hEq
  · exact hPreserve hOld
  · subst ψ
    exact hIntegrate.2

/-- A capacity is durably operational from `start` when it remains in every
later active repertoire. -/
def PersistentFrom
    (S : ℕ → Finset Capacity)
    (start : ℕ)
    (φ : Capacity) : Prop :=
  ∀ n, start ≤ n → φ ∈ S n

/-- Monotone retention turns one retained membership fact into durable
operational availability. -/
theorem monotoneRetention_persistsFrom
    (S : ℕ → Finset Capacity)
    (start : ℕ)
    (φ : Capacity)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hStart : φ ∈ S start) :
    PersistentFrom S start φ := by
  intro n hStartLe
  exact Nat.le_induction hStart
    (fun k hk ih => hRetained k ih) hStartLe

/-- A resource-feasible, validated emergent integration is therefore durable
under the repository's monotone-retention assumption. -/
theorem resourceValidatedEmergentIntegration_persists
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (h :
      ResourceValidatedEmergentIntegrationAt
        Proper Realizes Cost Budget E S m config ctx φ) :
    PersistentFrom S (m + 1) φ := by
  exact monotoneRetention_persistsFrom
    S (m + 1) φ hRetained h.2.1.2

end RetainedIntegration

section GenerativeConsequence

variable {Capacity : Type*}
variable [DecidableEq Capacity]

/-- Preservation of the active repertoire preserves every previously generated
candidate under the same generator. -/
theorem retainedRepertoire_preserves_generated
    (S : ℕ → Finset Capacity)
    (Generate : HyperGenerator Capacity)
    (m : ℕ)
    (hPreserve : S m ⊆ S (m + 1)) :
    PreservesOn Set.univ
      (GeneratedFromAvailable (fun x => x ∈ S m) Generate)
      (GeneratedFromAvailable (fun x => x ∈ S (m + 1)) Generate) := by
  exact generatedFromAvailable_mono
    Set.univ
    (fun x => x ∈ S m)
    (fun x => x ∈ S (m + 1))
    Generate
    (by
      intro x hx
      exact hPreserve hx)

/-- If the actual next repertoire enables a downstream candidate that could not
be generated before, generated accessibility strictly expands. -/
theorem retainedRepertoire_with_new_downstream_strictly_expands_generation
    (S : ℕ → Finset Capacity)
    (Generate : HyperGenerator Capacity)
    (m : ℕ)
    (ψ : Capacity)
    (hPreserve : S m ⊆ S (m + 1))
    (hAfter :
      GeneratedFromAvailable (fun x => x ∈ S (m + 1)) Generate ψ)
    (hBefore :
      ¬ GeneratedFromAvailable (fun x => x ∈ S m) Generate ψ) :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable (fun x => x ∈ S m) Generate)
      (GeneratedFromAvailable (fun x => x ∈ S (m + 1)) Generate) := by
  refine ⟨
    retainedRepertoire_preserves_generated S Generate m hPreserve,
    ψ, by simp, hBefore, hAfter⟩

/-- A downstream witness stated against the minimal operational integration
lifts to the actual retained next repertoire. -/
theorem minimalIntegration_generation_lifts_to_retained_next
    (S : ℕ → Finset Capacity)
    (Generate : HyperGenerator Capacity)
    (m : ℕ)
    (φ ψ : Capacity)
    (hPreserve : S m ⊆ S (m + 1))
    (hIntegrate : RetainedIntegrationAt S m φ)
    (hAfterMinimal :
      GeneratedFromAvailable
        (IntegrateOperationalCapacity (fun x => x ∈ S m) φ)
        Generate ψ) :
    GeneratedFromAvailable
      (fun x => x ∈ S (m + 1)) Generate ψ := by
  rcases hAfterMinimal with ⟨parents, hParents, hRule⟩
  refine ⟨parents, ?_, hRule⟩
  intro x hx
  exact retainedIntegration_contains_minimal_operationalIntegration
    S m φ hPreserve hIntegrate x (hParents x hx)

/-- Main bridge theorem.

A compositionally emergent capacity that is resource-feasible, externally
validated, genuinely new to the active repertoire, and retained at the next
step becomes a durable operational primitive under monotone retention.  If that
primitive enables an explicit downstream realization that was impossible
before, both the active repertoire and the generated repertoire strictly
expand.

No downstream expansion is claimed without `hAfterMinimal` and `hBefore`. -/
theorem resourceValidatedEmergentIntegration_operationalRatchet
    {Config Context : Type*}
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (Generate : HyperGenerator Capacity)
    (m : ℕ)
    (config : Config)
    (ctx : Context)
    (φ ψ : Capacity)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hEmergentIntegration :
      ResourceValidatedEmergentIntegrationAt
        Proper Realizes Cost Budget E S m config ctx φ)
    (hAfterMinimal :
      GeneratedFromAvailable
        (IntegrateOperationalCapacity (fun x => x ∈ S m) φ)
        Generate ψ)
    (hBefore :
      ¬ GeneratedFromAvailable (fun x => x ∈ S m) Generate ψ) :
    OperationalVocabularyExpansion
        (fun x => x ∈ S m) Realizes config ctx φ
    ∧ PersistentFrom S (m + 1) φ
    ∧ StrictExpandsOn Set.univ
        (fun x => x ∈ S m)
        (fun x => x ∈ S (m + 1))
    ∧ StrictExpandsOn Set.univ
        (GeneratedFromAvailable (fun x => x ∈ S m) Generate)
        (GeneratedFromAvailable (fun x => x ∈ S (m + 1)) Generate) := by
  have hStepRetained : S m ⊆ S (m + 1) := hRetained m
  have hIntegrate : RetainedIntegrationAt S m φ :=
    hEmergentIntegration.2.1
  have hAfter :
      GeneratedFromAvailable
        (fun x => x ∈ S (m + 1)) Generate ψ :=
    minimalIntegration_generation_lifts_to_retained_next
      S Generate m φ ψ hStepRetained hIntegrate hAfterMinimal
  exact ⟨
    resourceValidatedEmergentIntegration_implies_operationalExpansion
      Proper Realizes Cost Budget E S m config ctx φ hEmergentIntegration,
    resourceValidatedEmergentIntegration_persists
      Proper Realizes Cost Budget E S m config ctx φ
      hRetained hEmergentIntegration,
    retainedIntegration_strictly_expands_next
      S m φ hStepRetained hIntegrate,
    retainedRepertoire_with_new_downstream_strictly_expands_generation
      S Generate m ψ hStepRetained hAfter hBefore⟩

end GenerativeConsequence

section SeparationWitness

/-- Minimal witness showing that compositional emergence alone does not force
retained operational integration. -/
theorem emergence_alone_does_not_force_retained_integration :
    ∃ (Realizes : CapacityRelation Bool Unit Bool)
      (S : ℕ → Finset Bool),
      EmergentUnder boolProper Realizes true () true
      ∧ ¬ RetainedIntegrationAt S 0 true := by
  let Realizes : CapacityRelation Bool Unit Bool :=
    fun config _ φ => config = true ∧ φ = true
  let S : ℕ → Finset Bool := fun _ => ∅
  refine ⟨Realizes, S, ?_, ?_⟩
  · constructor
    · exact ⟨rfl, rfl⟩
    · intro part hProper hPart
      exact Bool.noConfusion (hProper.1.symm.trans hPart.1)
  · simp [RetainedIntegrationAt, S]

end SeparationWitness

#print axioms resourceValidatedEmergentIntegration_implies_operationalExpansion
#print axioms retainedIntegration_strictly_expands_next
#print axioms retainedIntegration_contains_minimal_operationalIntegration
#print axioms monotoneRetention_persistsFrom
#print axioms resourceValidatedEmergentIntegration_persists
#print axioms retainedRepertoire_preserves_generated
#print axioms retainedRepertoire_with_new_downstream_strictly_expands_generation
#print axioms minimalIntegration_generation_lifts_to_retained_next
#print axioms resourceValidatedEmergentIntegration_operationalRatchet
#print axioms emergence_alone_does_not_force_retained_integration

end RecursiveAccessibility
end CumulativeAccessibility
