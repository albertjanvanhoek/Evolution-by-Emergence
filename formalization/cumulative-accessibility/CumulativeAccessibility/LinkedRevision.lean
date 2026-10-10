namespace CumulativeAccessibility
namespace LinkedRevision

/-!
# Revision against replacement: the capacity to link

Entry D18 of `DIALOGUE.md` separates two ways a model can change.  In a
revision ("I believed A; I observed x, y and z; now I believe B") the new state
is computed from the old state and the evidence.  In a replacement ("B is
real") the new state is not computed from the old one.  The process goes on in
both cases; only in the first does the model keep its continuity.

Setting: states of type `S`, evidence of type `E`, and a revision rule
`rev : S → E → S`.  A course of states `x : Nat → S` is linked to an evidence
stream `ev` when every step is a revision: `x (t+1) = rev (x t) (ev t)`.

Results:
* `linked_courses_agree`: two linked courses with the same start and the same
  evidence agree at every step.  A partner who knows where you started and
  sees the same evidence can follow you.
* `unlinked_not_determined`: without linking, the start and the evidence do not
  determine the state.  A partner cannot follow.
* `mismatch_reveals_unlinked_step`: if a partner computes the revision and it
  differs from the stated new state, that step was not a revision under the
  stated evidence.  A stated link gives the partner something to check.
* `zero_weight_stays_zero`: under multiplicative updating of weights, a view
  held with weight zero keeps weight zero after any evidence.
* `certainty_change_is_replacement`: so if a view starts with weight zero and
  ends with positive weight, the change was not made by updating.  Moving from
  full certainty in A to belief in B is a replacement, not a revision.
* `linked_revision_witness`: concrete numbers.

Not covered: why a model replaces rather than revises, partial linking, rules
that change over time, and noisy evidence.  These results are close to their
definitions; they fix what "the capacity to link" means.  The clinical reading
in D18 is an analogy, not a result.
-/

/-- A course of states is linked to an evidence stream when every step is a
revision of the previous state by that step's evidence. -/
def Linked {S E : Type} (rev : S → E → S) (ev : Nat → E) (x : Nat → S) : Prop :=
  ∀ t, x (t + 1) = rev (x t) (ev t)

/-- Two linked courses with the same start and the same evidence agree at
every step. -/
theorem linked_courses_agree {S E : Type} (rev : S → E → S) (ev : Nat → E)
    (x y : Nat → S) (hx : Linked rev ev x) (hy : Linked rev ev y)
    (h0 : x 0 = y 0) : ∀ t, x t = y t := by
  intro t
  induction t with
  | zero => exact h0
  | succ n ih => rw [hx n, hy n, ih]

/-- Without linking, the start and the evidence do not determine the state:
two courses can share both and still differ. -/
theorem unlinked_not_determined :
    ∃ (rev : Bool → Unit → Bool) (ev : Nat → Unit) (x y : Nat → Bool),
      Linked rev ev x ∧ x 0 = y 0 ∧ y 1 ≠ x 1 :=
  ⟨fun b _ => b, fun _ => (), fun _ => true, fun t => decide (t = 0),
    fun _ => rfl, rfl, by decide⟩

/-- If the revision of the stated old state by the stated evidence differs
from the stated new state, that step was not a revision. -/
theorem mismatch_reveals_unlinked_step {S E : Type} (rev : S → E → S)
    (ev : Nat → E) (x : Nat → S) (t : Nat)
    (h : rev (x t) (ev t) ≠ x (t + 1)) : ¬ Linked rev ev x :=
  fun hl => h (hl t).symm

/-- Updating a weight multiplies it by the likelihood of each piece of
evidence. -/
def updated (w : Nat) : List Nat → Nat
  | [] => w
  | l :: ls => updated (w * l) ls

/-- A view held with weight zero keeps weight zero after any evidence. -/
theorem zero_weight_stays_zero (ls : List Nat) : updated 0 ls = 0 := by
  induction ls with
  | nil => rfl
  | cons l ls ih => simp [updated, Nat.zero_mul, ih]

/-- If a view starts with weight zero and ends with positive weight, no
sequence of updates produced the change: it was a replacement. -/
theorem certainty_change_is_replacement (w : Nat) (hw : 0 < w) :
    ¬ ∃ ls : List Nat, updated 0 ls = w := by
  intro ⟨ls, h⟩
  rw [zero_weight_stays_zero] at h
  omega

/-- Concrete numbers: a counter that adds each piece of evidence is a linked
course; a weight of zero stays zero after evidence `[5, 7]`, while a weight of
1 becomes 35. -/
theorem linked_revision_witness :
    Linked (fun n e : Nat => n + e) (fun _ => 1) (fun t => t) ∧
      updated 0 [5, 7] = 0 ∧ updated 1 [5, 7] = 35 := by
  refine ⟨fun _ => rfl, ?_, ?_⟩ <;> decide

end LinkedRevision
end CumulativeAccessibility
