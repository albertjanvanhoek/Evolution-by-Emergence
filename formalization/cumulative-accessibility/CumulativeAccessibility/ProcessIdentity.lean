namespace CumulativeAccessibility
namespace ProcessIdentity

/-!
# Continuity without sameness: identity as a process

Entry D17 of `DIALOGUE.md` describes identity as being a process: an
organization that exists only while it rebuilds itself.  What lasts is the
organization, not the material.  This module states the simplest form of that
claim.

Setting: a process whose parts are numbered.  At step `t` it holds the `k`
parts `t, t+1, …, t+k-1`.  Each step drops its oldest part and takes in one
new part, so each step keeps all but one of the parts it had.  Two moments
overlap when some part is present at both.

Results:
* `step_keeps_all_but_one`: each step keeps every part except the oldest.
* `step_adds_one`: each step takes in exactly one new part.
* `ends_share_nothing`: the process at step `0` and at step `k` share no part.
* `overlap_not_transitive`: overlapping is not transitive.  So "the same
  process" cannot mean "sharing parts"; it has to mean a chain of steps.
* `renewed_commitment_holds`: a commitment that each step renews holds at
  every step, although every part has been replaced.
* `lapsed_commitment_can_change`: if one step does not renew it, the
  commitment can be different afterwards.  Continuity of a commitment is
  maintained, not given.
* `process_identity_witness`: concrete numbers.

Not covered: parts that change at different rates, partial overlap
thresholds, branching into copies, and how an agent chooses which
commitments to renew.  These results are close to their definitions; they fix
what "continuity without sameness" means.
-/

/-- Part `i` is present in the process at step `t`, with `k` parts at a time. -/
def present (k t i : Nat) : Prop := t ≤ i ∧ i < t + k

/-- Two moments overlap when some part is present at both. -/
def overlaps (k s t : Nat) : Prop := ∃ i, present k s i ∧ present k t i

/-- Each step keeps every part except the oldest. -/
theorem step_keeps_all_but_one (k t i : Nat) (h : present k t i) (hne : i ≠ t) :
    present k (t + 1) i := by
  unfold present at *
  omega

/-- Each step takes in exactly one new part: any part present after the step
was present before, or is the new part `t + k`. -/
theorem step_adds_one (k t i : Nat) (h : present k (t + 1) i) :
    present k t i ∨ i = t + k := by
  unfold present at *
  omega

/-- After `k` steps, no part is left from the start. -/
theorem ends_share_nothing (k i : Nat) : ¬ (present k 0 i ∧ present k k i) := by
  unfold present
  omega

/-- With two parts at a time, step 0 overlaps step 1 and step 1 overlaps
step 2, but step 0 does not overlap step 2. -/
theorem overlap_not_transitive :
    overlaps 2 0 1 ∧ overlaps 2 1 2 ∧ ¬ overlaps 2 0 2 := by
  refine ⟨⟨1, ?_, ?_⟩, ⟨2, ?_, ?_⟩, ?_⟩
  · unfold present; omega
  · unfold present; omega
  · unfold present; omega
  · unfold present; omega
  · intro ⟨i, h0, h2⟩
    unfold present at h0 h2
    omega

/-- A commitment that every step renews holds at every step. -/
theorem renewed_commitment_holds {α : Type} (c : Nat → α)
    (renew : ∀ t, c (t + 1) = c t) : ∀ t, c t = c 0 := by
  intro t
  induction t with
  | zero => rfl
  | succ n ih => rw [renew n, ih]

/-- If one step does not renew it, a commitment can be different afterwards. -/
theorem lapsed_commitment_can_change :
    ∃ c : Nat → Bool, (∀ t, t ≠ 3 → c (t + 1) = c t) ∧ c 10 ≠ c 0 :=
  ⟨fun t => decide (4 ≤ t), by
    intro t ht
    by_cases h : 4 ≤ t
    · have h' : 4 ≤ t + 1 := by omega
      simp [h, h']
    · have h' : ¬ 4 ≤ t + 1 := by omega
      simp [h, h'],
   by decide⟩

/-- Concrete numbers: with three parts at a time, each step keeps two of the
three, step 0 and step 3 share nothing, and a commitment renewed at every step
is the same at step 3 as at step 0. -/
theorem process_identity_witness :
    present 3 1 2 ∧ present 3 1 1 ∧ ¬ (present 3 0 1 ∧ present 3 3 1) ∧
      (fun _ : Nat => true) 3 = (fun _ : Nat => true) 0 := by
  refine ⟨?_, ?_, ?_, rfl⟩
  · unfold present; omega
  · unfold present; omega
  · exact ends_share_nothing 3 1

end ProcessIdentity
end CumulativeAccessibility
