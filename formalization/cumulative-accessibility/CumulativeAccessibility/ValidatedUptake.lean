import CumulativeAccessibility.CapacityUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Externally validated generative uptake

The preceding open-endedness results deliberately count cumulative retained
novelty without identifying novelty with adaptation, usefulness, correctness,
or truth. This file adds the smallest possible external-validation layer while
keeping that distinction explicit.

A time-dependent predicate `ExternalCriterion` records whether candidate `z`
passes a declared external criterion at time `t`. No mathematical claim is made
that the criterion is complete, infallible, or uniquely correct. It is simply
kept outside the internal generator and retained repertoire.

The resulting architecture can be read as

    (M_t, H_t, U_t, E_t)

where `M_t` is retained organization, `H_t` is the current generator, `U_t` is
the distinguishability envelope, and `E_t` is an external test predicate.

The main results are intentionally modest:

1. repeatedly retaining genuinely new candidates that are in the envelope,
   internally generable, and externally accepted implies the earlier
   generative-capacity-uptake condition;
2. therefore, under retention, it implies open-ended cumulative novelty;
3. with representation, it also implies unbounded distinguishability capacity;
4. the converse fails: open-ended cumulative novelty can occur while no new
   candidate ever passes the external criterion.

Thus `new` and `externally validated` are formally distinct.
-/

section Definitions

variable {α : Type*} [DecidableEq α]

/-- A time-dependent external test or acceptance predicate.

`E t z` means only that `z` passes the declared criterion at `t`. The
formalization does not identify this predicate with objective truth, fitness,
or utility. -/
abbrev ExternalCriterion (α : Type*) := ℕ → α → Prop

/-- From every time onward, some later transition retains a genuinely new item
that passes the declared external criterion. -/
def EventualValidatedNovelUptake
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ m z,
    n ≤ m ∧
    z ∉ S m ∧
    E m z ∧
    z ∈ S (m + 1)

/-- Mechanistic validated uptake through the current envelope and generator.
From every time onward, some later candidate is distinguishable, genuinely new,
generable from currently retained material, externally accepted, and actually
retained. -/
def ValidatedGenerativeCapacityUptake
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ m z,
    n ≤ m ∧
    z ∈ U m ∧
    z ∉ S m ∧
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) z ∧
    E m z ∧
    z ∈ S (m + 1)

end Definitions

section Implications

variable {α : Type*} [DecidableEq α]

/-- External validation is an additional filter on the earlier mechanistic
uptake condition. Forgetting the validation witness recovers ordinary
generative capacity uptake. -/
theorem validatedGenerativeCapacityUptake_implies_capacityUptake
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hValidated : ValidatedGenerativeCapacityUptake U H E S) :
    GenerativeCapacityUptake U H S := by
  intro n
  obtain ⟨m, z, hnm, hzU, hzNot, hGen, hEval, hzNext⟩ := hValidated n
  exact ⟨m, z, hnm, hzU, hzNot, hGen, hzNext⟩

/-- The same validated-uptake premise also directly records arbitrarily late
successful externally screened novelty events. -/
theorem validatedGenerativeCapacityUptake_implies_eventualValidatedNovelUptake
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hValidated : ValidatedGenerativeCapacityUptake U H E S) :
    EventualValidatedNovelUptake E S := by
  intro n
  obtain ⟨m, z, hnm, hzU, hzNot, hGen, hEval, hzNext⟩ := hValidated n
  exact ⟨m, z, hnm, hzNot, hEval, hzNext⟩

/-- Under monotone retention, repeated externally validated generative uptake
is sufficient for open-ended cumulative retained novelty. -/
theorem validatedGenerativeCapacityUptake_implies_openEndedNovelty
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hValidated : ValidatedGenerativeCapacityUptake U H E S) :
    OpenEndedCumulativeNovelty S := by
  apply generativeCapacityUptake_implies_openEndedNovelty U H S hRetained
  exact validatedGenerativeCapacityUptake_implies_capacityUptake
    U H E S hValidated

/-- With representation inside the current envelope, the same validated
mechanism also forces unbounded distinguishability capacity. -/
theorem validatedGenerativeCapacityUptake_implies_unboundedEnvelope
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hValidated : ValidatedGenerativeCapacityUptake U H E S) :
    UnboundedEnvelopeCapacity U := by
  apply generativeCapacityUptake_implies_unboundedEnvelope
    U H S hRepresented hRetained
  exact validatedGenerativeCapacityUptake_implies_capacityUptake
    U H E S hValidated

end Implications

section SeparationWitness

/-- An external criterion that rejects every candidate at every time. -/
def rejectAllCriterion : ExternalCriterion ℕ :=
  fun _t _z => False

/-- Open-ended cumulative novelty does not imply externally validated novelty.
The progressive architecture from `CapacityUptake.lean` remains open-ended, but
under a criterion that rejects every candidate there can be no validated uptake
event at all. -/
theorem openEndedNovelty_without_externalValidation :
    OpenEndedCumulativeNovelty progressiveRepertoire ∧
      ¬ EventualValidatedNovelUptake rejectAllCriterion progressiveRepertoire := by
  constructor
  · exact progressiveArchitecture_is_openEnded
  · intro hValidated
    obtain ⟨m, z, hnm, hzNot, hEval, hzNext⟩ := hValidated 0
    simpa [rejectAllCriterion] using hEval

end SeparationWitness

#print axioms validatedGenerativeCapacityUptake_implies_capacityUptake
#print axioms validatedGenerativeCapacityUptake_implies_eventualValidatedNovelUptake
#print axioms validatedGenerativeCapacityUptake_implies_openEndedNovelty
#print axioms validatedGenerativeCapacityUptake_implies_unboundedEnvelope
#print axioms openEndedNovelty_without_externalValidation

end RecursiveAccessibility
end CumulativeAccessibility
