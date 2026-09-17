import CumulativeAccessibility.OpenEndedCapacity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Capacity uptake: a sufficient mechanism for open-ended cumulative novelty

`OpenEndedCapacity.lean` proved a necessity boundary:

    open-ended cumulative retained novelty
      -> unbounded effective distinguishability capacity.

The converse is false: capacity may grow forever while retained organization
never uses it.  This file adds the missing causal coupling.

The sufficient condition below is intentionally transparent rather than
claimed minimal.  From every time onward, there must eventually be some
candidate which

1. lies inside the then-current distinguishability envelope;
2. is not yet in the retained repertoire;
3. is generated from currently retained material by the then-current
   generative rule; and
4. is actually retained at the next step.

This realizes the chain

    U_t -> H_t -> M_{t+1}.

Together with monotone retention, repeated availability of such uptake events
forces arbitrarily many strict cumulative repertoire expansions.
-/

section CountingLemmas

variable {α : Type*} [DecidableEq α]

/-- The strict-expansion counter can never decrease when the horizon is
extended by one step. -/
theorem strictExpansionCount_step_mono
    (S : ℕ → Finset α) (N : ℕ) :
    strictExpansionCount S N ≤ strictExpansionCount S (N + 1) := by
  rw [strictExpansionCount]
  split <;> omega

/-- The strict-expansion counter is monotone in the observation horizon. -/
theorem strictExpansionCount_monotone
    (S : ℕ → Finset α) :
    Monotone (strictExpansionCount S) := by
  exact monotone_nat_of_le_succ (strictExpansionCount_step_mono S)

end CountingLemmas

section UptakeDefinitions

variable {α : Type*} [DecidableEq α]

/-- Abstract eventual novelty uptake.  From every time onward, some later step
adds at least one genuinely new retained item which lies in the effective
distinguishability envelope at the moment of uptake. -/
def EventualNovelUptake
    (U S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ m z,
    n ≤ m ∧
    z ∈ U m ∧
    z ∉ S m ∧
    z ∈ S (m + 1)

/-- Mechanistic capacity uptake through the current generative rule.  This is
the explicit `U -> H -> M` coupling: a not-yet-retained candidate is inside the
current envelope, is generable from the currently retained repertoire, and is
then retained. -/
def GenerativeCapacityUptake
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ m z,
    n ≤ m ∧
    z ∈ U m ∧
    z ∉ S m ∧
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) z ∧
    z ∈ S (m + 1)

/-- Generative capacity uptake implies the abstract novelty-uptake property. -/
theorem generativeCapacityUptake_implies_eventualNovelUptake
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α)
    (hUptake : GenerativeCapacityUptake U H S) :
    EventualNovelUptake U S := by
  intro n
  obtain ⟨m, z, hnm, hzU, hzNot, hGen, hzNext⟩ := hUptake n
  exact ⟨m, z, hnm, hzU, hzNot, hzNext⟩

end UptakeDefinitions

section UptakeSufficiency

variable {α : Type*} [DecidableEq α]

/-- Any eventual novelty-uptake event is a strict repertoire expansion when
old repertoire is retained. -/
theorem eventualNovelUptake_gives_future_strict_step
    (U S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hUptake : EventualNovelUptake U S)
    (n : ℕ) :
    ∃ m,
      n ≤ m ∧
      S m ⊂ S (m + 1) := by
  obtain ⟨m, z, hnm, hzU, hzNot, hzNext⟩ := hUptake n
  refine ⟨m, hnm, Finset.ssubset_iff_subset_ne.mpr ⟨hRetained m, ?_⟩⟩
  intro hEq
  apply hzNot
  rw [hEq]
  exact hzNext

/-- Repeated eventual uptake plus retention is sufficient for open-ended
cumulative novelty.  No cardinality growth assumption on `U` is required as a
separate premise here because the uptake condition itself supplies a genuinely
new retained item arbitrarily far into the future. -/
theorem eventualNovelUptake_implies_openEndedNovelty
    (U S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hUptake : EventualNovelUptake U S) :
    OpenEndedCumulativeNovelty S := by
  intro K
  induction K with
  | zero =>
      exact ⟨0, by simp [strictExpansionCount]⟩
  | succ K ih =>
      obtain ⟨n, hCountN⟩ := ih
      obtain ⟨m, hnm, hStrict⟩ :=
        eventualNovelUptake_gives_future_strict_step U S hRetained hUptake n
      have hMonoCount :
          strictExpansionCount S n ≤ strictExpansionCount S m :=
        strictExpansionCount_monotone S hnm
      have hStep :
          strictExpansionCount S (m + 1)
            = strictExpansionCount S m + 1 := by
        rw [strictExpansionCount]
        simp [hStrict]
      refine ⟨m + 1, ?_⟩
      rw [hStep]
      omega

/-- Mechanistic sufficiency theorem: generative access to novel envelope states,
actual retention of those generated states, and monotone retention together
force open-ended cumulative novelty. -/
theorem generativeCapacityUptake_implies_openEndedNovelty
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hUptake : GenerativeCapacityUptake U H S) :
    OpenEndedCumulativeNovelty S := by
  exact eventualNovelUptake_implies_openEndedNovelty
    U S hRetained
    (generativeCapacityUptake_implies_eventualNovelUptake U H S hUptake)

/-- If the retained repertoire is also represented inside the envelope, the
same sufficient mechanism necessarily drives unbounded distinguishability
capacity, recovering the necessity theorem from the constructive side. -/
theorem generativeCapacityUptake_implies_unboundedEnvelope
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (S : ℕ → Finset α)
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hUptake : GenerativeCapacityUptake U H S) :
    UnboundedEnvelopeCapacity U := by
  apply openEndedNovelty_implies_unboundedEnvelopeCapacity
    U S hRepresented hRetained
  exact generativeCapacityUptake_implies_openEndedNovelty
    U H S hRetained hUptake

end UptakeSufficiency

section ConcreteProgressiveWitness

/-- Retained repertoire containing exactly `0, ..., n`. -/
def progressiveRepertoire (n : ℕ) : Finset ℕ :=
  Finset.range (n + 1)

/-- Distinguishability envelope containing one additional currently unused
state `n+1`. -/
def progressiveEnvelope (n : ℕ) : Finset ℕ :=
  Finset.range (n + 2)

/-- At time `n`, the current terminal retained state `n` generates the next
state `n+1`.  This is deliberately unary; higher arity is not needed for the
sufficiency witness. -/
def progressiveGenerator (n : ℕ) : HyperGenerator ℕ :=
  fun parents z => parents = {n} ∧ z = n + 1

/-- The progressive repertoire is monotonically retained. -/
theorem progressiveRepertoire_retained :
    ∀ n, progressiveRepertoire n ⊆ progressiveRepertoire (n + 1) := by
  intro n x hx
  simp [progressiveRepertoire] at hx ⊢
  omega

/-- Every retained state is represented in the current envelope. -/
theorem progressiveRepertoire_represented :
    ∀ n, progressiveRepertoire n ⊆ progressiveEnvelope n := by
  intro n x hx
  simp [progressiveRepertoire, progressiveEnvelope] at hx ⊢
  omega

/-- Concrete `U -> H -> M` witness: at every time, the currently unused next
state lies in the envelope, is generated from retained material, and is
retained one step later. -/
theorem progressiveArchitecture_has_generativeCapacityUptake :
    GenerativeCapacityUptake
      progressiveEnvelope progressiveGenerator progressiveRepertoire := by
  intro n
  refine ⟨n, n + 1, le_rfl, ?_, ?_, ?_, ?_⟩
  · simp [progressiveEnvelope]
  · simp [progressiveRepertoire]
  · refine ⟨{n}, ?_, ?_⟩
    · intro x hx
      have hxn : x = n := by simpa using hx
      subst x
      simp [progressiveRepertoire]
    · simp [progressiveGenerator]
  · simp [progressiveRepertoire]

/-- The concrete architecture therefore realizes open-ended cumulative
novelty. -/
theorem progressiveArchitecture_is_openEnded :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  exact generativeCapacityUptake_implies_openEndedNovelty
    progressiveEnvelope progressiveGenerator progressiveRepertoire
    progressiveRepertoire_retained
    progressiveArchitecture_has_generativeCapacityUptake

/-- And, consistently with the necessity theorem, its distinguishability
envelope is unbounded. -/
theorem progressiveEnvelope_is_unbounded :
    UnboundedEnvelopeCapacity progressiveEnvelope := by
  exact generativeCapacityUptake_implies_unboundedEnvelope
    progressiveEnvelope progressiveGenerator progressiveRepertoire
    progressiveRepertoire_represented
    progressiveRepertoire_retained
    progressiveArchitecture_has_generativeCapacityUptake

end ConcreteProgressiveWitness

#print axioms strictExpansionCount_step_mono
#print axioms strictExpansionCount_monotone
#print axioms generativeCapacityUptake_implies_eventualNovelUptake
#print axioms eventualNovelUptake_gives_future_strict_step
#print axioms eventualNovelUptake_implies_openEndedNovelty
#print axioms generativeCapacityUptake_implies_openEndedNovelty
#print axioms generativeCapacityUptake_implies_unboundedEnvelope
#print axioms progressiveRepertoire_retained
#print axioms progressiveRepertoire_represented
#print axioms progressiveArchitecture_has_generativeCapacityUptake
#print axioms progressiveArchitecture_is_openEnded
#print axioms progressiveEnvelope_is_unbounded

end RecursiveAccessibility
end CumulativeAccessibility
