import AnchoredEvolution.Anchor

/-!
# The room in one head: certainty is configuration, not a certificate

In the room, people hold incompatible certainties at the same moment, and the
anchor says at most one of them can be correct. Conversion puts the room inside
one person over time. The same brain, with the same neurons, holds one
certainty and later an incompatible one, and both feel certain from the inside.
Only the configuration of its connections changed in between.

This file states that lesson with the anchor indexed by the times of one
agent's life rather than by persons.

* `room_in_one_head`: if an agent's records at two times are incompatible, at
  most one of them is correct; the anchor applies across time as it does across
  persons.
* `certainty_is_not_a_certificate`: let `Certain` be any predicate on records,
  standing for how a record feels from the inside, which depends only on the
  record itself. If an agent was certain of both of two incompatible records,
  it was certain of a record that is not correct. So whatever makes a record
  feel certain cannot also guarantee that it is correct.
* `conversion_witness`: two worlds, a record that admits only one and a later
  record that admits only the other, both held with certainty; the theorems
  apply and are not vacuous.

What this file does **not** show: which record, if any, is correct, or that
truth is an illusion. The anchor still holds: of incompatible records, at most
one is correct. What it rules out is using the feeling of certainty to decide
which. Whether a change of record is a correction depends on whether it
follows reliable evidence (`Anchored.Persistence.learner_in_step`).
-/

universe u

namespace Anchored.RoomInOneHead

variable {World : Type u}

/-- An agent's record at each time: the worlds it admits. -/
abbrev Record (World : Type u) : Type u := World → Prop

/-- Two records are incompatible when no world satisfies both. -/
def Incompatible (r s : Record World) : Prop :=
  ∀ w, ¬ (r w ∧ s w)

/-- **The room in one head.** If the agent's records at times `t₁` and `t₂`
are incompatible, they are not both correct about the actual world `wstar`. -/
theorem room_in_one_head (rec : Nat → Record World) {t₁ t₂ : Nat}
    (hinc : Incompatible (rec t₁) (rec t₂)) (wstar : World) :
    ¬ (rec t₁ wstar ∧ rec t₂ wstar) :=
  hinc wstar

/-- The same statement through the anchor itself: indexed by the two times,
the records are pairwise incompatible, so two correct records cannot be at
distinct times. -/
theorem room_in_one_head_via_anchor (rec : Nat → Record World) {t₁ t₂ : Nat}
    (hinc : Incompatible (rec t₁) (rec t₂)) (wstar : World)
    (h₁ : rec t₁ wstar) (h₂ : rec t₂ wstar) : ¬ t₁ ≠ t₂ := by
  have hpair : PairwiseIncompatible
      (fun i : {t : Nat // t = t₁ ∨ t = t₂} => rec i.1 wstar) := by
    intro i j hij hboth
    rcases i with ⟨i, hi⟩
    rcases j with ⟨j, hj⟩
    have hne : i ≠ j := fun e => hij (Subtype.ext e)
    rcases hi with rfl | rfl <;> rcases hj with rfl | rfl
    · exact hne rfl
    · exact hinc wstar hboth
    · exact hinc wstar ⟨hboth.2, hboth.1⟩
    · exact hne rfl
  intro hne
  exact anchor_not_two hpair (i := ⟨t₁, Or.inl rfl⟩) (j := ⟨t₂, Or.inr rfl⟩) h₁ h₂
    (fun e => hne (congrArg Subtype.val e))

/-- **Certainty is not a certificate.** Let `Certain` be any predicate on
records: how a record feels from the inside, a function of the record alone. If
the agent was certain of two incompatible records, one of the records it was
certain of is not correct. -/
theorem certainty_is_not_a_certificate (Certain : Record World → Prop)
    (rec : Nat → Record World) {t₁ t₂ : Nat}
    (hinc : Incompatible (rec t₁) (rec t₂))
    (hc₁ : Certain (rec t₁)) (hc₂ : Certain (rec t₂)) (wstar : World) :
    ¬ (∀ r, Certain r → r wstar) :=
  fun hcert => hinc wstar ⟨hcert _ hc₁, hcert _ hc₂⟩

/-- The convert's records: before conversion (time `0`) only `true` is
admitted; afterwards only `false`. -/
def convertRecord : Nat → Record Bool := fun t w => if t = 0 then w = true else w = false

/-- **Non-vacuity.** Two worlds. Before conversion the record admits only
`true`; after, only `false`. Both are held with certainty. They are
incompatible, so the agent was certain of a record that is not correct,
whichever world is actual. -/
theorem conversion_witness :
    Incompatible (convertRecord 0) (convertRecord 1) ∧
      (∀ wstar : Bool, ¬ (∀ r : Record Bool, (fun _ => True) r → r wstar)) := by
  have hinc : Incompatible (convertRecord 0) (convertRecord 1) := by
    intro w h
    have h0 : w = true := by simpa [convertRecord] using h.1
    have h1 : w = false := by simpa [convertRecord] using h.2
    rw [h0] at h1
    exact Bool.noConfusion h1
  exact ⟨hinc, fun wstar =>
    certainty_is_not_a_certificate (fun _ => True) convertRecord hinc trivial trivial wstar⟩

end Anchored.RoomInOneHead

#print axioms Anchored.RoomInOneHead.room_in_one_head
#print axioms Anchored.RoomInOneHead.room_in_one_head_via_anchor
#print axioms Anchored.RoomInOneHead.certainty_is_not_a_certificate
#print axioms Anchored.RoomInOneHead.conversion_witness
