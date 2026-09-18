import CumulativeAccessibility.CapacityUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Recurring capacity slack and local realization

`CapacityUptake.lean` gives a transparent sufficient mechanism for open-ended
cumulative novelty, but its `GenerativeCapacityUptake` premise already packages
both opportunity and successful uptake into one condition.

This file separates those roles.

* `RecurringCapacitySlack` says that from every time onward there is some later
  moment at which the represented repertoire is a strict subset of the
  distinguishability envelope.
* `ImmediateGenerativeRealization` says that whenever such unused capacity is
  present, the current generative rule can generate at least one not-yet-
  retained envelope item and that item is retained at the next step.

Together they imply the earlier capacity-uptake condition, hence open-ended
cumulative novelty under monotone retention.

The result is deliberately only sufficient.  A final counterexample shows that
open-ended cumulative novelty can occur with `M_t = U_t` at every time, so
recurring slack is not necessary: capacity and repertoire may expand in exact
synchrony.
-/

section SlackAndRealization

variable {α : Type*} [DecidableEq α]

/-- Unused distinguishability capacity recurs arbitrarily far into the future. -/
def RecurringCapacitySlack
    (U S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ m : ℕ,
    n ≤ m ∧ S m ⊂ U m

/-- Whenever the current repertoire leaves some envelope capacity unused, the
current generative rule realizes at least one genuinely new envelope item and
that item is retained in the next repertoire. -/
def ImmediateGenerativeRealization
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, S n ⊂ U n → ∃ z,
    z ∈ U n ∧
    z ∉ S n ∧
    GeneratedFromAvailable (fun x => x ∈ S n) (H n) z ∧
    z ∈ S (n + 1)

/-- Recurring unused capacity plus local generative realization gives the
mechanistic uptake condition from `CapacityUptake.lean`. -/
theorem recurringSlack_and_realization_imply_capacityUptake
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α)
    (hSlack : RecurringCapacitySlack U S)
    (hRealize : ImmediateGenerativeRealization U H S) :
    GenerativeCapacityUptake U H S := by
  intro n
  obtain ⟨m, hnm, hStrict⟩ := hSlack n
  obtain ⟨z, hzU, hzNot, hGen, hzNext⟩ := hRealize m hStrict
  exact ⟨m, z, hnm, hzU, hzNot, hGen, hzNext⟩

/-- Sufficient open-endedness theorem in decomposed form. -/
theorem recurringSlack_and_realization_imply_openEndedNovelty
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSlack : RecurringCapacitySlack U S)
    (hRealize : ImmediateGenerativeRealization U H S) :
    OpenEndedCumulativeNovelty S := by
  apply generativeCapacityUptake_implies_openEndedNovelty U H S hRetained
  exact recurringSlack_and_realization_imply_capacityUptake
    U H S hSlack hRealize

/-- If the repertoire is represented inside the envelope, the same decomposed
mechanism also forces unbounded envelope capacity. -/
theorem recurringSlack_and_realization_imply_unboundedEnvelope
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSlack : RecurringCapacitySlack U S)
    (hRealize : ImmediateGenerativeRealization U H S) :
    UnboundedEnvelopeCapacity U := by
  apply generativeCapacityUptake_implies_unboundedEnvelope U H S
    hRepresented hRetained
  exact recurringSlack_and_realization_imply_capacityUptake
    U H S hSlack hRealize

end SlackAndRealization

section ProgressiveWitness

/-- In the progressive witness from `CapacityUptake.lean`, one unused envelope
state is present at every time. -/
theorem progressiveArchitecture_has_recurringSlack :
    RecurringCapacitySlack progressiveEnvelope progressiveRepertoire := by
  intro n
  refine ⟨n, le_rfl, ?_⟩
  apply Finset.ssubset_iff_subset_ne.mpr
  constructor
  · exact progressiveRepertoire_represented n
  · intro hEq
    have hMem : n + 1 ∈ progressiveEnvelope n := by
      simp [progressiveEnvelope]
    have hNot : n + 1 ∉ progressiveRepertoire n := by
      simp [progressiveRepertoire]
    apply hNot
    rw [hEq]
    exact hMem

/-- The progressive unary rule immediately realizes the currently unused next
state. -/
theorem progressiveArchitecture_has_immediateRealization :
    ImmediateGenerativeRealization
      progressiveEnvelope progressiveGenerator progressiveRepertoire := by
  intro n hSlack
  refine ⟨n + 1, ?_, ?_, ?_, ?_⟩
  · simp [progressiveEnvelope]
  · simp [progressiveRepertoire]
  · refine ⟨{n}, ?_, ?_⟩
    · intro x hx
      have hxn : x = n := by simpa using hx
      subst x
      simp [progressiveRepertoire]
    · simp [progressiveGenerator]
  · simp [progressiveRepertoire]

/-- The concrete witness is therefore open-ended by the decomposed
capacity-slack plus local-realization theorem. -/
theorem progressiveArchitecture_openEnded_via_slack_realization :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  exact recurringSlack_and_realization_imply_openEndedNovelty
    progressiveEnvelope progressiveGenerator progressiveRepertoire
    progressiveRepertoire_retained
    progressiveArchitecture_has_recurringSlack
    progressiveArchitecture_has_immediateRealization

end ProgressiveWitness

section SlackIsNotNecessary

/-- Synchronous expansion: the distinguishability envelope is exactly the
retained repertoire at every time. -/
def synchronousEnvelope (n : ℕ) : Finset ℕ :=
  progressiveRepertoire n

/-- There is never unused capacity when envelope and repertoire coincide. -/
theorem synchronousExpansion_has_no_recurringSlack :
    ¬ RecurringCapacitySlack synchronousEnvelope progressiveRepertoire := by
  intro hSlack
  obtain ⟨m, hm, hStrict⟩ := hSlack 0
  have hEq : progressiveRepertoire m = synchronousEnvelope m := rfl
  exact (Finset.ssubset_iff_subset_ne.mp hStrict).2 hEq

/-- Counterexample to necessity of the slack premise: the retained repertoire
is still open-ended while the envelope expands in exact synchrony, leaving no
strict slack at any time. -/
theorem openEndedNovelty_without_recurringSlack :
    OpenEndedCumulativeNovelty progressiveRepertoire
      ∧
    ¬ RecurringCapacitySlack synchronousEnvelope progressiveRepertoire := by
  exact ⟨progressiveArchitecture_is_openEnded,
    synchronousExpansion_has_no_recurringSlack⟩

end SlackIsNotNecessary

#print axioms recurringSlack_and_realization_imply_capacityUptake
#print axioms recurringSlack_and_realization_imply_openEndedNovelty
#print axioms recurringSlack_and_realization_imply_unboundedEnvelope
#print axioms progressiveArchitecture_has_recurringSlack
#print axioms progressiveArchitecture_has_immediateRealization
#print axioms progressiveArchitecture_openEnded_via_slack_realization
#print axioms synchronousExpansion_has_no_recurringSlack
#print axioms openEndedNovelty_without_recurringSlack

end RecursiveAccessibility
end CumulativeAccessibility
