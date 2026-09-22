import Mathlib.Data.Fintype.Card
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace CumulativeAccessibility
namespace GenerativeLeverage

/-!
# Bounded-memory generative leverage

A finite retained repertoire can support a larger accessible repertoire through
reuse. To make "bounded reuse" operational rather than verbal, this module asks
for an injective encoding of every accessible target by:

1. one retained unit that supports it; and
2. one of at most d support slots associated with that unit.

If such an encoding exists, A.card <= R.card * d.

Therefore uniformly bounded retained cardinality and uniformly bounded
per-unit reuse imply uniformly bounded accessible cardinality. Unbounded
accessible repertoire forces at least one premise to fail: retained cardinality
grows, per-unit leverage grows, or accessibility depends on genuinely
compositional support that cannot be assigned injectively to one retained
unit/slot pair.

This is a structural no-go theorem, not the arithmetic statement
R.card <= B / mu_min.
-/

variable {ι τ : Type*} [DecidableEq ι] [DecidableEq τ]

/-- An operational certificate that each accessible target can be assigned to
one retained unit and one of d bounded support slots, without two accessible
targets sharing the same unit/slot pair. -/
structure BoundedReuseEncoding
    (R : Finset ι)
    (A : Finset τ)
    (d : ℕ) where
  owner : {y // y ∈ A} → {i // i ∈ R}
  slot : {y // y ∈ A} → Fin d
  injective :
    Function.Injective
      (fun y => (owner y, slot y))

/-- A bounded reuse encoding gives the fundamental cardinality bound:
accessible repertoire cannot exceed retained units times support slots. -/
theorem accessible_card_le_retained_mul_slots
    (R : Finset ι)
    (A : Finset τ)
    (d : ℕ)
    (enc : BoundedReuseEncoding R A d) :
    A.card ≤ R.card * d := by
  have hCard :
      Fintype.card {y // y ∈ A} ≤
        Fintype.card ({i // i ∈ R} × Fin d) :=
    Fintype.card_le_of_injective
      (fun y => (enc.owner y, enc.slot y))
      enc.injective
  simpa using hCard

/-- If retained repertoire itself is bounded by N, bounded reuse d yields the
uniform accessibility bound N*d. -/
theorem accessible_card_le_memoryBound_mul_slots
    (R : Finset ι)
    (A : Finset τ)
    (N d : ℕ)
    (hR : R.card ≤ N)
    (enc : BoundedReuseEncoding R A d) :
    A.card ≤ N * d := by
  have hA :
      A.card ≤ R.card * d :=
    accessible_card_le_retained_mul_slots R A d enc
  have hRD :
      R.card * d ≤ N * d :=
    Nat.mul_le_mul_right d hR
  exact le_trans hA hRD

/-- A family of finite repertoires has unbounded cardinal growth when every
finite bound is eventually exceeded. -/
def UnboundedCardinality
    (A : ℕ → Finset τ) : Prop :=
  ∀ K : ℕ, ∃ t : ℕ, K < (A t).card

/-- Uniformly bounded retained repertoire plus uniformly bounded per-unit reuse
rules out unbounded accessible repertoire. -/
theorem bounded_memory_and_bounded_reuse_rule_out_unbounded_accessibility
    (R : ℕ → Finset ι)
    (A : ℕ → Finset τ)
    (N d : ℕ)
    (hMemory : ∀ t, (R t).card ≤ N)
    (hReuse :
      ∀ t, BoundedReuseEncoding (R t) (A t) d) :
    ¬ UnboundedCardinality A := by
  intro hUnbounded
  rcases hUnbounded (N * d) with ⟨t, hLarge⟩
  have hBound :
      (A t).card ≤ N * d :=
    accessible_card_le_memoryBound_mul_slots
      (R t) (A t) N d
      (hMemory t)
      (hReuse t)
  exact (not_lt_of_ge hBound) hLarge

/-- Contrapositive at one time point: if accessible repertoire exceeds N*d
while retained cardinality is at most N, then no d-slot single-unit reuse
encoding can explain that accessibility. At least one target needs greater
per-unit leverage or genuinely compositional support. -/
theorem excess_accessibility_breaks_bounded_single_unit_reuse
    (R : Finset ι)
    (A : Finset τ)
    (N d : ℕ)
    (hR : R.card ≤ N)
    (hLarge : N * d < A.card) :
    ¬ BoundedReuseEncoding R A d := by
  intro enc
  have hBound :=
    accessible_card_le_memoryBound_mul_slots
      R A N d hR enc
  exact (not_lt_of_ge hBound) hLarge

#print axioms accessible_card_le_retained_mul_slots
#print axioms accessible_card_le_memoryBound_mul_slots
#print axioms bounded_memory_and_bounded_reuse_rule_out_unbounded_accessibility
#print axioms excess_accessibility_breaks_bounded_single_unit_reuse

end GenerativeLeverage
end CumulativeAccessibility
