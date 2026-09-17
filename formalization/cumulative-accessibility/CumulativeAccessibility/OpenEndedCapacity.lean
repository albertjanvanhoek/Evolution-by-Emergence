import CumulativeAccessibility.FiniteGenerativeSaturation

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Open-ended cumulative novelty requires open-ended distinguishability capacity

The finite-saturation result used a fixed finite declared universe.  This file
moves one abstraction level up and lets the effective distinguishability
envelope itself vary with time.

The central result is deliberately one-way:

* if retained cumulative novelty is open-ended, then the cardinality of any
  envelope containing the retained repertoire must be unbounded;
* unbounded envelope capacity is not sufficient for novelty -- capacity may
  grow while the retained repertoire remains unchanged.

The theorem does not require the generative rule to be fixed.  In fact the
main bound does not mention the rule at all.  This makes precise the earlier
observation that rule evolution can change which states are reached, but cannot
by itself evade a uniformly bounded distinguishability capacity.
-/

section MovingEnvelope

variable {α : Type*} [DecidableEq α]

/-- Open-ended cumulative novelty means that for every requested number `K`
of strict retained repertoire expansions, some finite horizon has accumulated
at least `K` such expansions. -/
def OpenEndedCumulativeNovelty
    (S : ℕ → Finset α) : Prop :=
  ∀ K : ℕ, ∃ N : ℕ, K ≤ strictExpansionCount S N

/-- A time-dependent distinguishability envelope has unbounded capacity when
its finite cardinalities exceed every finite bound somewhere along the
trajectory. -/
def UnboundedEnvelopeCapacity
    (U : ℕ → Finset α) : Prop :=
  ∀ K : ℕ, ∃ N : ℕ, K ≤ (U N).card

/-- Moving-envelope novelty bound.  At any horizon, the initial retained
cardinality plus the number of strict cumulative expansions is bounded by the
cardinality of the envelope that contains the retained repertoire at that
horizon.

No monotonicity assumption on `U` is required. -/
theorem strictExpansionCount_le_moving_envelope
    (U S : ℕ → Finset α)
    (hContained : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (N : ℕ) :
    (S 0).card + strictExpansionCount S N ≤ (U N).card := by
  have hGrowth := strictExpansionCount_card_growth S hRetained N
  have hEnvelope : (S N).card ≤ (U N).card :=
    Finset.card_le_card (hContained N)
  exact le_trans hGrowth hEnvelope

/-- If every envelope has cardinality at most `B`, the number of strict
cumulative novelty events at every horizon is bounded by the remaining
capacity relative to the initial repertoire. -/
theorem uniform_envelope_bound_limits_novelty
    (U S : ℕ → Finset α)
    (hContained : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (B N : ℕ)
    (hCapacity : ∀ n, (U n).card ≤ B) :
    strictExpansionCount S N ≤ B - (S 0).card := by
  have hMove := strictExpansionCount_le_moving_envelope
    U S hContained hRetained N
  have hUN : (U N).card ≤ B := hCapacity N
  have h0U : (S 0).card ≤ (U 0).card :=
    Finset.card_le_card (hContained 0)
  have h0B : (S 0).card ≤ B := le_trans h0U (hCapacity 0)
  omega

/-- Strong necessity statement: open-ended cumulative novelty forces the
containing distinguishability envelopes to exceed the initial retained
cardinality by arbitrarily large amounts. -/
theorem openEndedNovelty_forces_capacity_above_initial
    (U S : ℕ → Finset α)
    (hContained : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpen : OpenEndedCumulativeNovelty S) :
    ∀ K : ℕ, ∃ N : ℕ,
      (S 0).card + K ≤ (U N).card := by
  intro K
  obtain ⟨N, hK⟩ := hOpen K
  refine ⟨N, ?_⟩
  have hMove := strictExpansionCount_le_moving_envelope
    U S hContained hRetained N
  omega

/-- In particular, open-ended cumulative novelty implies unbounded envelope
cardinality. -/
theorem openEndedNovelty_implies_unboundedEnvelopeCapacity
    (U S : ℕ → Finset α)
    (hContained : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hOpen : OpenEndedCumulativeNovelty S) :
    UnboundedEnvelopeCapacity U := by
  intro K
  obtain ⟨N, hN⟩ :=
    openEndedNovelty_forces_capacity_above_initial
      U S hContained hRetained hOpen K
  refine ⟨N, ?_⟩
  omega

/-- Contrapositive-style boundary: a uniform finite envelope-capacity bound
rules out open-ended cumulative novelty, regardless of how the update or
generative rule changes over time. -/
theorem uniformlyBoundedEnvelope_rules_out_openEndedNovelty
    (U S : ℕ → Finset α)
    (hContained : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (B : ℕ)
    (hCapacity : ∀ n, (U n).card ≤ B) :
    ¬ OpenEndedCumulativeNovelty S := by
  intro hOpen
  obtain ⟨N, hN⟩ :=
    openEndedNovelty_forces_capacity_above_initial
      U S hContained hRetained hOpen (B + 1)
  have hBN : (U N).card ≤ B := hCapacity N
  omega

end MovingEnvelope

section Architecture

variable {α : Type*} [DecidableEq α]

/-- A minimal evolving generative architecture making the `(M_t,H_t,U_t)`
separation explicit.

`repertoire` is retained organization `M_t`, `generator` is the possibly
changing finite-parent rule `H_t`, and `envelope` is the currently declared
finite distinguishability capacity `U_t`.

The open-ended-capacity theorem below intentionally makes no assumptions about
`generator`: its variation is free, because the necessity result is stronger
than any particular generative mechanism. -/
structure EvolvingGenerativeArchitecture (α : Type*) [DecidableEq α] where
  repertoire : ℕ → Finset α
  generator : ℕ → HyperGenerator α
  envelope : ℕ → Finset α
  retained : ∀ n, repertoire n ⊆ repertoire (n + 1)
  represented : ∀ n, repertoire n ⊆ envelope n

/-- Open-ended cumulative novelty for an evolving architecture. -/
def EvolvingGenerativeArchitecture.OpenEnded
    (A : EvolvingGenerativeArchitecture α) : Prop :=
  OpenEndedCumulativeNovelty A.repertoire

/-- Unbounded effective distinguishability capacity for an evolving
architecture. -/
def EvolvingGenerativeArchitecture.UnboundedCapacity
    (A : EvolvingGenerativeArchitecture α) : Prop :=
  UnboundedEnvelopeCapacity A.envelope

/-- Architecture-level necessity theorem: whatever sequence of generative
rules `H_t` is used, open-ended cumulative retained novelty in `M_t` requires
unbounded effective envelope capacity `U_t`. -/
theorem evolvingArchitecture_openEnded_requires_unboundedCapacity
    (A : EvolvingGenerativeArchitecture α)
    (hOpen : A.OpenEnded) :
    A.UnboundedCapacity := by
  exact openEndedNovelty_implies_unboundedEnvelopeCapacity
    A.envelope A.repertoire A.represented A.retained hOpen

/-- If an architecture's distinguishability envelopes are uniformly bounded,
changing its generative rule indefinitely cannot by itself sustain open-ended
cumulative retained novelty. -/
theorem boundedArchitecture_rules_out_openEnded
    (A : EvolvingGenerativeArchitecture α)
    (B : ℕ)
    (hCapacity : ∀ n, (A.envelope n).card ≤ B) :
    ¬ A.OpenEnded := by
  exact uniformlyBoundedEnvelope_rules_out_openEndedNovelty
    A.envelope A.repertoire A.represented A.retained B hCapacity

end Architecture

section CapacityIsNotSufficient

/-- A simple envelope whose declared capacity grows without bound. -/
def growingEnvelope (n : ℕ) : Finset ℕ :=
  Finset.range (n + 1)

/-- A retained repertoire that never changes. -/
def staticRepertoire (_n : ℕ) : Finset ℕ :=
  {0}

/-- The static repertoire is represented inside every member of the growing
envelope. -/
theorem staticRepertoire_contained_in_growingEnvelope :
    ∀ n, staticRepertoire n ⊆ growingEnvelope n := by
  intro n x hx
  have hx0 : x = 0 := by
    simpa [staticRepertoire] using hx
  subst x
  simp [growingEnvelope]

/-- The example's envelope capacity is genuinely unbounded. -/
theorem growingEnvelope_has_unboundedCapacity :
    UnboundedEnvelopeCapacity growingEnvelope := by
  intro K
  refine ⟨K, ?_⟩
  simp [growingEnvelope]

/-- A constant retained repertoire accumulates no strict expansion events. -/
theorem staticRepertoire_strictExpansionCount_zero :
    ∀ N, strictExpansionCount staticRepertoire N = 0 := by
  intro N
  induction N with
  | zero => simp [strictExpansionCount]
  | succ N ih =>
      rw [strictExpansionCount]
      simp [staticRepertoire, ih]

/-- Therefore unbounded distinguishability capacity is necessary but not
sufficient for open-ended cumulative novelty.  Capacity can expand forever
while the retained organization never uses it. -/
theorem unboundedCapacity_without_openEndedNovelty :
    UnboundedEnvelopeCapacity growingEnvelope
      ∧ ¬ OpenEndedCumulativeNovelty staticRepertoire := by
  constructor
  · exact growingEnvelope_has_unboundedCapacity
  · intro hOpen
    obtain ⟨N, hN⟩ := hOpen 1
    rw [staticRepertoire_strictExpansionCount_zero] at hN
    omega

end CapacityIsNotSufficient

#print axioms strictExpansionCount_le_moving_envelope
#print axioms uniform_envelope_bound_limits_novelty
#print axioms openEndedNovelty_forces_capacity_above_initial
#print axioms openEndedNovelty_implies_unboundedEnvelopeCapacity
#print axioms uniformlyBoundedEnvelope_rules_out_openEndedNovelty
#print axioms evolvingArchitecture_openEnded_requires_unboundedCapacity
#print axioms boundedArchitecture_rules_out_openEnded
#print axioms staticRepertoire_contained_in_growingEnvelope
#print axioms growingEnvelope_has_unboundedCapacity
#print axioms staticRepertoire_strictExpansionCount_zero
#print axioms unboundedCapacity_without_openEndedNovelty

end RecursiveAccessibility
end CumulativeAccessibility
