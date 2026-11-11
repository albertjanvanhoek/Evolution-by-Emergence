namespace CumulativeAccessibility
namespace LearningVerbs

/-!
# The verbs of learning

What is learning made of?  This module states, for one turn of a learning
loop, a set of verbs that are together enough for learning.  For five of them
the failure blocks learning; for update and retain one named way of failing
does, and other departures need not
(entry D40 of `DIALOGUE.md`; `research/discovarianism/LEARNING_DECOMPOSITION.md`).

**The loop, alone.**  A learner keeps a set of worlds possible; one of them is
the actual world.  In a turn it picks an operation, which yields an outcome in
each world; it observes an outcome, records it, keeps the worlds that agree
with the record, and carries the result forward if the turn is paid for.
Learning in a turn means: nothing new is assumed, the actual world is still
kept possible, and at least one world that was kept possible is ruled out.

**Between learners.**  Where none of a learner's own operations yields a
different outcome in a wrong world than in the actual one, that world survives
every honest turn it takes alone.  If another learner has an operation that
does tell them apart, a second set of verbs removes it.

Results, alone:
* `seven_verbs_learn`: leave open, try, test, record, update, retain and
  afford together give learning in that turn.
* `sealed_blocks`, `no_try_blocks`, `untested_blocks`, `distorted_blocks`,
  `no_update_blocks`, `no_retain_blocks`, `unpaid_blocks`: with the other
  verbs in place, a failure blocks learning in that turn.  For leave open,
  try, test, record and afford the failure is the exact negation of the verb.
  For update and retain it is one named way of failing (nothing changes; the
  gain is dropped), not the negation.
* `update_not_necessary_in_general`, `retain_not_necessary_in_general`: a turn
  can depart from `Updates`, or from `Retains`, with the other six in place,
  and still learn.  So the seven are jointly sufficient, and not each
  individually necessary.  The counterexample for update is from an
  independent audit (D47).
* `sealed_possible` … `unpaid_possible`: each of those failures can occur
  with the other six verbs in place, so the results above are not empty.

Results, between learners:
* `blind_spot_survives`: a wrong world that no own operation tells from the
  actual one survives any set of own honest turns.
* `seven_verbs_correct`: the other tests, passes on honestly, the link holds,
  the learner takes in honestly, accepts, has left the truth open and retains:
  together these remove the blind spot and keep the truth.
* `other_untested_blocks`, `not_passed_on_blocks`, `broken_link_blocks`,
  `not_taken_in_blocks`, `not_accepted_blocks`, `sealed_blocks_correction`,
  `not_retained_blocks`: the failure of one leaves the blind spot uncorrected.
* `other_untested_possible` … `not_retained_possible`: each failure can occur
  with the other six in place.
* `accepting_false_signal_loses_truth`: if the other's observation is false
  and everything else is done, accepting it rules out the actual world.
  Accepting a correction is not safe in general.
* `own_evidence_cannot_evaluate_blind_correction`: any rule by which the
  receiver judges a signal from its own observations gives the same verdict in
  the actual world and in the wrong world it cannot tell apart.  For a blind
  spot, the receiver's own evidence cannot separate a true correction from a
  false one.  Further evidence can: about the source, or an additional direct
  test.  Neither is guaranteed to.
* Being told and being taught (D44).  A correction is a result; an operation
  is a means.  With an operation of its own the learner tests for itself:
  honest own testing never rules out the actual world, whatever the operation
  (`own_test_keeps_truth`), and removes the error if the operation tells it
  apart (`own_test_removes_error`).  Acquiring an operation that tells a blind
  error from the truth ends the blindness (`acquired_operation_opens_blind_spot`)
  and lets the learner's own evidence separate the two worlds
  (`after_acquiring_observations_differ`).  It removes a difference in methods:
  the teacher's operation can no longer tell apart what is still blind to the
  learner (`after_acquiring_other_adds_nothing`).  It does not remove the value
  of a second, independent execution: two learners using the same method who
  both test and record honestly get the same record
  (`same_method_honest_records_agree`), so a disagreement shows that one of
  them failed (`same_method_disagreement_reveals_failure`); agreement proves
  nothing if both failed alike (`agreement_is_not_proof`).
* The same verbs one level up (D45).  A method can itself be wrong: with a
  wrong account of what the operation yields, an honest record rules out the
  truth (`wrong_account_of_method_loses_truth`).  Checking a method on a known
  case is a learning turn whose "worlds" are the candidate accounts of the
  method: accounts that mispredict the known case are ruled out and the true
  one is kept (`method_check_filters_accounts`), and a wrong account
  that agrees on the known case survives (`validated_method_can_still_be_wrong`).
  A check can leave such an account standing; it need not, if the cases tested
  separate all the candidates.  The filtering result does not by itself say
  that anything was learned: that needs the candidate accounts to differ on
  the case (`method_check_learns_when_accounts_differ`).
* What cannot be checked from inside (D46).  "Test" and "leave open" are
  defined by the actual world, which the learner does not know.  Two turns can
  agree in everything the learner has and differ only in which world is
  actual, one learning and the other losing the truth
  (`tested_and_untested_look_alike`), one open and the other sealed
  (`open_and_sealed_look_alike`).  So these two are conditions of success and
  not things a learner can know it is doing.
* A world that moves (D46).  What an honest test rightly ruled out can be the
  actual world after a change (`retained_record_goes_stale`).  A result that is
  kept cannot be treated as an unchanged constraint on the present once the
  world has changed.  A record tied to its own time can stay true and useful.
* One joint space (D46).  A surprising outcome does not say whether the view of
  the world or the account of the method is wrong: both repairs survive
  (`surprise_does_not_say_which`).  The "levels" of D45 are a factoring that
  is available only when some cases are known.
* `same_view_cannot_correct`: if the other's operation does not tell the two
  worlds apart either, all seven verbs leave the wrong world in place.  The two
  learners have to differ.
* `error_survives_iff_never_linked`: over any number of turns, with the other
  verbs in place, the error is still there at the end exactly when the link
  held in no turn.  A break is a delay if it is repaired, permanent if not.
* `learning_verbs_witness`: a concrete turn in which all seven verbs hold.

Relation to earlier results in this repository.  The solo loop is what this
module adds: the seven verbs, jointly sufficient, with a result that a
failure of each blocks learning (for update and retain, one plain way of
failing; see `update_not_necessary_in_general`), and each such failure shown
to be possible.  The part between learners mostly restates earlier results in
one small model: `blind_spot_survives` is close to
`ModelOfLargerReality.inside_view_cannot_settle`,
`error_survives_iff_never_linked` to
`Persistence.forgiveness_turns_split_into_delay`, and
`same_view_cannot_correct` is the two-learner form of
`hub_determined_network_inherits_blind_spot`.  This was noticed in the review
of D42, after the module was written.

How much this says.  "Learning" here is ruling out: these are components of
successful elimination-based learning in this model, not a decomposition of
learning in general.  Two of the seven, leave open and afford, are conditions
more than operations.  Afford is needed by construction: `Retains` is defined
so that an unpaid turn carries the old state forward.  That is a modelling
decision, not a derived requirement (noted by an outside review, D43).  The
results between learners assume that the other has an operation that tells the
worlds apart, observes correctly and passes on faithfully; they do not show
that accepting a correction is beneficial in general.

The results are close to their definitions.  The one
step of argument is in `seven_verbs_learn`: two worlds with different outcomes
cannot both agree with an honest record of a real test.  "Needed" means that,
with the other verbs in place, one failure blocks learning in that turn; two
failures can cancel by luck.  "Update" and "retain" are shown to fail in one
plain way (nothing changes; the gain is dropped).

Not covered: saturation of a fixed finite space after a set number of turns
(checked with a solver for small sizes only), taking back a record that proved
false, adding a possibility the learner did not have, forgetting, noise and
degrees of belief, the choice of what to try, and learning that is not ruling
out (skill, perception, a new way of representing).  That real learners fit
this model is not claimed.
-/

/-! ## The loop, alone -/

/-- One turn of a learning loop over possible worlds. -/
structure Turn (World Outcome : Type) where
  /-- The actual world. -/
  actual : World
  /-- The worlds kept possible before the turn. -/
  kept : World → Prop
  /-- What the chosen operation yields in each world. -/
  out : World → Outcome
  /-- What the learner observes. -/
  observed : Outcome
  /-- What the learner records. -/
  recorded : Outcome
  /-- The worlds kept possible after the update. -/
  updated : World → Prop
  /-- The worlds kept possible that are carried into the next turn. -/
  carried : World → Prop
  /-- The cost of the turn is covered. -/
  paid : Prop

variable {World Outcome : Type}

/-- Leave open: the actual world is among those kept possible. -/
def LeavesOpen (t : Turn World Outcome) : Prop := t.kept t.actual

/-- Try: the operation yields different outcomes in two worlds kept possible. -/
def Tries (t : Turn World Outcome) : Prop :=
  ∃ w u, t.kept w ∧ t.kept u ∧ t.out w ≠ t.out u

/-- The failure of trying: the outcome is the same in every world kept possible. -/
def TriesNothing (t : Turn World Outcome) : Prop :=
  ∀ w u, t.kept w → t.kept u → t.out w = t.out u

/-- Test: what is observed is what the operation yields in the actual world. -/
def Tests (t : Turn World Outcome) : Prop := t.observed = t.out t.actual

/-- Record: what is recorded is what was observed. -/
def Records (t : Turn World Outcome) : Prop := t.recorded = t.observed

/-- Update: keep the worlds that agree with the record. -/
def Updates (t : Turn World Outcome) : Prop :=
  ∀ w, t.updated w ↔ (t.kept w ∧ t.out w = t.recorded)

/-- The plain failure of updating: the record changes nothing. -/
def UpdatesNothing (t : Turn World Outcome) : Prop := ∀ w, t.updated w ↔ t.kept w

/-- Retain: carry the update forward if the turn is paid for, and the old
state if it is not.  Keeping costs.  This definition is what makes `Affords`
necessary: a modelling decision. -/
def Retains (t : Turn World Outcome) : Prop :=
  ∀ w, t.carried w ↔ ((t.paid ∧ t.updated w) ∨ (¬ t.paid ∧ t.kept w))

/-- The plain failure of retaining: the old state is carried forward. -/
def RetainsNothing (t : Turn World Outcome) : Prop := ∀ w, t.carried w ↔ t.kept w

/-- Afford: the turn is paid for. -/
def Affords (t : Turn World Outcome) : Prop := t.paid

/-- Learning in one turn: nothing new is assumed, the actual world is still
kept possible, and at least one world that was kept possible is ruled out. -/
def Learns (t : Turn World Outcome) : Prop :=
  (∀ w, t.carried w → t.kept w) ∧ t.carried t.actual ∧ ∃ w, t.kept w ∧ ¬ t.carried w

/-- The seven verbs together give learning in that turn. -/
theorem seven_verbs_learn (t : Turn World Outcome)
    (hopen : LeavesOpen t) (htry : Tries t) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : Learns t := by
  have hrecorded : t.recorded = t.out t.actual := hrec.trans htest
  have carried_iff : ∀ w, t.carried w ↔ (t.kept w ∧ t.out w = t.out t.actual) := by
    intro w
    constructor
    · intro h
      cases (hret w).mp h with
      | inl h1 => have := (hupd w).mp h1.2; exact ⟨this.1, this.2.trans hrecorded⟩
      | inr h2 => exact absurd hpay h2.1
    · intro h
      exact (hret w).mpr (Or.inl ⟨hpay, (hupd w).mpr ⟨h.1, h.2.trans hrecorded.symm⟩⟩)
  refine ⟨fun w h => ((carried_iff w).mp h).1, (carried_iff _).mpr ⟨hopen, rfl⟩, ?_⟩
  obtain ⟨w, u, hw, hu, hne⟩ := htry
  cases Classical.em (t.out w = t.out t.actual) with
  | inl hwa =>
    refine ⟨u, hu, fun hc => hne ?_⟩
    exact hwa.trans ((carried_iff u).mp hc).2.symm
  | inr hwa => exact ⟨w, hw, fun hc => hwa ((carried_iff w).mp hc).2⟩

/-- Sealed: if the actual world was ruled out beforehand, no turn learns. -/
theorem sealed_blocks (t : Turn World Outcome) (h : ¬ LeavesOpen t) : ¬ Learns t :=
  fun hl => h (hl.1 _ hl.2.1)

/-- Without trying, an honest record of a real test rules nothing out. -/
theorem no_try_blocks (t : Turn World Outcome)
    (hopen : LeavesOpen t) (hno : TriesNothing t) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : ¬ Learns t := by
  intro hl
  obtain ⟨w, hw, hnc⟩ := hl.2.2
  apply hnc
  refine (hret w).mpr (Or.inl ⟨hpay, (hupd w).mpr ⟨hw, ?_⟩⟩)
  exact (hno w t.actual hw hopen).trans (hrec.trans htest).symm

/-- Untested: if the observation did not come from the world, the actual
world is ruled out. -/
theorem untested_blocks (t : Turn World Outcome)
    (hno : t.observed ≠ t.out t.actual) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : ¬ Learns t := by
  intro hl
  cases (hret _).mp hl.2.1 with
  | inl h1 => exact hno (hrec.symm.trans ((hupd _).mp h1.2).2.symm)
  | inr h2 => exact h2.1 hpay

/-- Distorted: if the record is not what was observed, the actual world is
ruled out. -/
theorem distorted_blocks (t : Turn World Outcome)
    (htest : Tests t) (hno : t.recorded ≠ t.observed)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : ¬ Learns t := by
  intro hl
  cases (hret _).mp hl.2.1 with
  | inl h1 => exact hno (((hupd _).mp h1.2).2.symm.trans htest.symm)
  | inr h2 => exact h2.1 hpay

/-- If the record changes nothing, nothing is ruled out. -/
theorem no_update_blocks (t : Turn World Outcome)
    (hno : UpdatesNothing t) (hret : Retains t) (hpay : Affords t) : ¬ Learns t := by
  intro hl
  obtain ⟨w, hw, hnc⟩ := hl.2.2
  exact hnc ((hret w).mpr (Or.inl ⟨hpay, (hno w).mpr hw⟩))

/-- If the old state is carried forward, nothing is ruled out. -/
theorem no_retain_blocks (t : Turn World Outcome) (hno : RetainsNothing t) : ¬ Learns t := by
  intro hl
  obtain ⟨w, hw, hnc⟩ := hl.2.2
  exact hnc ((hno w).mpr hw)

/-- An unpaid turn carries the old state forward, so nothing is ruled out. -/
theorem unpaid_blocks (t : Turn World Outcome) (hret : Retains t) (hno : ¬ Affords t) :
    ¬ Learns t := by
  intro hl
  obtain ⟨w, hw, hnc⟩ := hl.2.2
  exact hnc ((hret w).mpr (Or.inr ⟨hno, hw⟩))

/-! ### What "needed" means

The blocking results above use the exact negation of the verb for leave open,
try, test, record and afford.  For update and retain they use one way of
failing.  Other departures from those two can still learn, by luck: the
definition of learning asks that the truth is kept and something is ruled
out, not that what was ruled out was ruled out for a reason. -/

/-- A turn in which the other six verbs hold, `Updates` fails, and the learner
still learns.  Worlds 0, 1 and 2 are kept possible; the operation tells 2 from
the others; the record is right; and the update drops world 1 as well, which
the record did not rule out.  Counterexample from an independent audit (D47). -/
theorem update_not_necessary_in_general : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ Tests t ∧ Records t ∧ ¬ Updates t ∧ Retains t ∧
    Affords t ∧ Learns t := by
  let t : Turn Nat Nat :=
    { actual := 0, kept := fun w => w = 0 ∨ w = 1 ∨ w = 2,
      out := fun w => if w = 2 then 1 else 0, observed := 0, recorded := 0,
      updated := fun w => w = 0, carried := fun w => w = 0, paid := True }
  refine ⟨t, Or.inl rfl, ⟨0, 2, Or.inl rfl, Or.inr (Or.inr rfl), by decide⟩, rfl, rfl,
    ?_, ?_, trivial, ?_⟩
  · intro h
    have := (h 1).mpr ⟨Or.inr (Or.inl rfl), rfl⟩
    exact absurd this (by decide)
  · intro w
    show w = 0 ↔ ((True ∧ w = 0) ∨ (¬ True ∧ (w = 0 ∨ w = 1 ∨ w = 2)))
    simp
  · exact ⟨fun w h => Or.inl h, rfl, 1, Or.inr (Or.inl rfl), by decide⟩

/-- The same for `Retains`: the update is exactly what the record licenses,
and what is carried forward drops one more world. -/
theorem retain_not_necessary_in_general : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ Tests t ∧ Records t ∧ Updates t ∧ ¬ Retains t ∧
    Affords t ∧ Learns t := by
  let t : Turn Nat Nat :=
    { actual := 0, kept := fun w => w = 0 ∨ w = 1 ∨ w = 2,
      out := fun w => if w = 2 then 1 else 0, observed := 0, recorded := 0,
      updated := fun w => w = 0 ∨ w = 1, carried := fun w => w = 0, paid := True }
  refine ⟨t, Or.inl rfl, ⟨0, 2, Or.inl rfl, Or.inr (Or.inr rfl), by decide⟩, rfl, rfl,
    ?_, ?_, trivial, ?_⟩
  · intro w
    show (w = 0 ∨ w = 1) ↔ ((w = 0 ∨ w = 1 ∨ w = 2) ∧ (if w = 2 then 1 else 0) = 0)
    constructor
    · intro h
      rcases h with h | h <;> subst h <;> simp
    · intro ⟨h1, h2⟩
      rcases h1 with h | h | h
      · exact Or.inl h
      · exact Or.inr h
      · subst h; simp at h2
  · intro h
    have := (h 1).mpr (Or.inl ⟨trivial, Or.inr rfl⟩)
    exact absurd this (by decide)
  · exact ⟨fun w h => Or.inl h, rfl, 1, Or.inr (Or.inl rfl), by decide⟩

/-! ### Each failure is possible with the other six verbs in place

Worlds and outcomes are natural numbers, and the operation yields the number
of the world unless stated otherwise. -/

/-- All seven verbs hold in a concrete turn: worlds 0 and 1 are kept possible,
the actual world is 0, and the turn rules out world 1. -/
def goodTurn : Turn Nat Nat where
  actual := 0
  kept := fun w => w = 0 ∨ w = 1
  out := fun w => w
  observed := 0
  recorded := 0
  updated := fun w => w = 0
  carried := fun w => w = 0
  paid := True

theorem learning_verbs_witness :
    LeavesOpen goodTurn ∧ Tries goodTurn ∧ Tests goodTurn ∧ Records goodTurn ∧
    Updates goodTurn ∧ Retains goodTurn ∧ Affords goodTurn ∧ Learns goodTurn := by
  have h1 : LeavesOpen goodTurn := Or.inl rfl
  have h2 : Tries goodTurn := ⟨0, 1, Or.inl rfl, Or.inr rfl, by decide⟩
  have h3 : Tests goodTurn := rfl
  have h4 : Records goodTurn := rfl
  have h5 : Updates goodTurn := by
    intro w
    show w = 0 ↔ ((w = 0 ∨ w = 1) ∧ w = 0)
    omega
  have h6 : Retains goodTurn := by
    intro w
    show w = 0 ↔ ((True ∧ w = 0) ∨ (¬ True ∧ (w = 0 ∨ w = 1)))
    simp
  have h7 : Affords goodTurn := trivial
  exact ⟨h1, h2, h3, h4, h5, h6, h7, seven_verbs_learn _ h1 h2 h3 h4 h5 h6 h7⟩

theorem sealed_possible : ∃ t : Turn Nat Nat,
    ¬ LeavesOpen t ∧ Tries t ∧ Tests t ∧ Records t ∧ Updates t ∧ Retains t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun w => w = 1 ∨ w = 2, out := fun w => w, observed := 0,
            recorded := 0, updated := fun _ => False, carried := fun _ => False,
            paid := True }, ?_, ⟨1, 2, Or.inl rfl, Or.inr rfl, by decide⟩, rfl, rfl, ?_, ?_, trivial⟩
  · show ¬ ((0 : Nat) = 1 ∨ (0 : Nat) = 2)
    decide
  · intro w
    show False ↔ ((w = 1 ∨ w = 2) ∧ w = 0)
    exact ⟨False.elim, fun h => by omega⟩
  · intro w
    show False ↔ ((True ∧ False) ∨ (¬ True ∧ (w = 1 ∨ w = 2)))
    simp

theorem no_try_possible : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ TriesNothing t ∧ Tests t ∧ Records t ∧ Updates t ∧ Retains t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun _ => True, out := fun _ => 0, observed := 0,
            recorded := 0, updated := fun _ => True, carried := fun _ => True,
            paid := True }, trivial, fun _ _ _ _ => rfl, rfl, rfl, ?_, ?_, trivial⟩
  · intro w
    show True ↔ (True ∧ (0 : Nat) = 0)
    simp
  · intro w
    show True ↔ ((True ∧ True) ∨ (¬ True ∧ True))
    simp

theorem untested_possible : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ t.observed ≠ t.out t.actual ∧ Records t ∧ Updates t ∧
    Retains t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun w => w = 0 ∨ w = 1, out := fun w => w, observed := 1,
            recorded := 1, updated := fun w => w = 1, carried := fun w => w = 1,
            paid := True }, Or.inl rfl, ⟨0, 1, Or.inl rfl, Or.inr rfl, by decide⟩,
            by decide, rfl, ?_, ?_, trivial⟩
  · intro w
    show w = 1 ↔ ((w = 0 ∨ w = 1) ∧ w = 1)
    omega
  · intro w
    show w = 1 ↔ ((True ∧ w = 1) ∨ (¬ True ∧ (w = 0 ∨ w = 1)))
    simp

theorem distorted_possible : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ Tests t ∧ t.recorded ≠ t.observed ∧ Updates t ∧
    Retains t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun w => w = 0 ∨ w = 1, out := fun w => w, observed := 0,
            recorded := 1, updated := fun w => w = 1, carried := fun w => w = 1,
            paid := True }, Or.inl rfl, ⟨0, 1, Or.inl rfl, Or.inr rfl, by decide⟩,
            rfl, by decide, ?_, ?_, trivial⟩
  · intro w
    show w = 1 ↔ ((w = 0 ∨ w = 1) ∧ w = 1)
    omega
  · intro w
    show w = 1 ↔ ((True ∧ w = 1) ∨ (¬ True ∧ (w = 0 ∨ w = 1)))
    simp

theorem no_update_possible : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ Tests t ∧ Records t ∧ UpdatesNothing t ∧ Retains t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun w => w = 0 ∨ w = 1, out := fun w => w, observed := 0,
            recorded := 0, updated := fun w => w = 0 ∨ w = 1, carried := fun w => w = 0 ∨ w = 1,
            paid := True }, Or.inl rfl, ⟨0, 1, Or.inl rfl, Or.inr rfl, by decide⟩,
            rfl, rfl, fun _ => Iff.rfl, ?_, trivial⟩
  intro w
  show (w = 0 ∨ w = 1) ↔ ((True ∧ (w = 0 ∨ w = 1)) ∨ (¬ True ∧ (w = 0 ∨ w = 1)))
  simp

theorem no_retain_possible : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ Tests t ∧ Records t ∧ Updates t ∧ RetainsNothing t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun w => w = 0 ∨ w = 1, out := fun w => w, observed := 0,
            recorded := 0, updated := fun w => w = 0, carried := fun w => w = 0 ∨ w = 1,
            paid := True }, Or.inl rfl, ⟨0, 1, Or.inl rfl, Or.inr rfl, by decide⟩,
            rfl, rfl, ?_, fun _ => Iff.rfl, trivial⟩
  intro w
  show w = 0 ↔ ((w = 0 ∨ w = 1) ∧ w = 0)
  omega

theorem unpaid_possible : ∃ t : Turn Nat Nat,
    LeavesOpen t ∧ Tries t ∧ Tests t ∧ Records t ∧ Updates t ∧ Retains t ∧ ¬ Affords t := by
  refine ⟨{ actual := 0, kept := fun w => w = 0 ∨ w = 1, out := fun w => w, observed := 0,
            recorded := 0, updated := fun w => w = 0, carried := fun w => w = 0 ∨ w = 1,
            paid := False }, Or.inl rfl, ⟨0, 1, Or.inl rfl, Or.inr rfl, by decide⟩,
            rfl, rfl, ?_, ?_, fun h => h⟩
  · intro w
    show w = 0 ↔ ((w = 0 ∨ w = 1) ∧ w = 0)
    omega
  · intro w
    show (w = 0 ∨ w = 1) ↔ ((False ∧ w = 0) ∨ (¬ False ∧ (w = 0 ∨ w = 1)))
    simp

/-! ## The blind spot, and the verbs between learners -/

/-- A world that none of the learner's own operations tells from the actual one
survives any set of its own honest turns, and so does the truth.  The
statement does not ask that `b` differs from the actual world; reading it as
an error adds that. -/
theorem blind_spot_survives {Op : Type} (own : Op → World → Outcome) (used : Op → Prop)
    (kept after : World → Prop) (actual b : World)
    (hactual : kept actual) (hb : kept b)
    (hblind : ∀ o, own o b = own o actual)
    (hturns : ∀ w, after w ↔ (kept w ∧ ∀ o, used o → own o w = own o actual)) :
    after b ∧ after actual :=
  ⟨(hturns b).mpr ⟨hb, fun o _ => hblind o⟩, (hturns actual).mpr ⟨hactual, fun _ _ => rfl⟩⟩

/-- One exchange with another learner who has an operation of their own. -/
structure Exchange (World Outcome : Type) where
  /-- The actual world. -/
  actual : World
  /-- A wrong world the learner still keeps possible. -/
  blind : World
  /-- The worlds the learner keeps possible before the exchange. -/
  before : World → Prop
  /-- What the other learner's operation yields in each world. -/
  oth : World → Outcome
  /-- What the other learner observes. -/
  theirObservation : Outcome
  /-- What the other learner sends. -/
  sent : Outcome
  /-- What arrives. -/
  received : Outcome
  /-- What the learner takes in. -/
  taken : Outcome
  /-- The link is intact. -/
  link : Prop
  /-- The worlds kept possible after the update. -/
  updated : World → Prop
  /-- The worlds kept possible that are carried forward. -/
  carried : World → Prop

/-- The setting: the wrong world is kept possible, the other's operation tells
it from the actual world, and an intact link carries the signal. -/
def Setting (e : Exchange World Outcome) : Prop :=
  e.before e.blind ∧ e.oth e.blind ≠ e.oth e.actual ∧ (e.link → e.received = e.sent)

/-- The other tests: their observation comes from the world. -/
def OtherTests (e : Exchange World Outcome) : Prop := e.theirObservation = e.oth e.actual

/-- The other passes on honestly: what they send is what they observed. -/
def PassesOn (e : Exchange World Outcome) : Prop := e.sent = e.theirObservation

/-- The link holds. -/
def KeepsLink (e : Exchange World Outcome) : Prop := e.link

/-- Take in honestly: what the learner takes in is what arrived. -/
def TakesIn (e : Exchange World Outcome) : Prop := e.taken = e.received

/-- Accept the correction: update on what was taken in, when a signal arrived. -/
def Accepts (e : Exchange World Outcome) : Prop :=
  ∀ w, e.updated w ↔ (e.before w ∧ (e.link → e.oth w = e.taken))

/-- The plain failure of accepting: the signal is set aside. -/
def SetsAside (e : Exchange World Outcome) : Prop := ∀ w, e.updated w ↔ e.before w

/-- The truth was left open. -/
def LeftOpen (e : Exchange World Outcome) : Prop := e.before e.actual

/-- Retain: carry the update forward. -/
def Keeps (e : Exchange World Outcome) : Prop := ∀ w, e.carried w ↔ e.updated w

/-- The plain failure of retaining: the old state is carried forward. -/
def KeepsNothing (e : Exchange World Outcome) : Prop := ∀ w, e.carried w ↔ e.before w

/-- The blind spot is corrected: the wrong world is ruled out and the actual
world is still kept possible. -/
def Corrected (e : Exchange World Outcome) : Prop := ¬ e.carried e.blind ∧ e.carried e.actual

/-- The seven verbs between learners remove the blind spot and keep the truth. -/
theorem seven_verbs_correct (e : Exchange World Outcome) (hs : Setting e)
    (h1 : OtherTests e) (h2 : PassesOn e) (h3 : KeepsLink e) (h4 : TakesIn e)
    (h5 : Accepts e) (h6 : LeftOpen e) (h7 : Keeps e) : Corrected e := by
  have htaken : e.taken = e.oth e.actual := h4.trans ((hs.2.2 h3).trans (h2.trans h1))
  constructor
  · intro hc
    exact hs.2.1 ((((h5 _).mp ((h7 _).mp hc)).2 h3).trans htaken)
  · exact (h7 _).mpr ((h5 _).mpr ⟨h6, fun _ => htaken.symm⟩)

/-- Two learners with the same view cannot correct each other: if the other's
operation does not tell the wrong world from the actual one either, the wrong
world is still kept possible after all seven verbs. -/
theorem same_view_cannot_correct (e : Exchange World Outcome)
    (hblind : e.before e.blind) (hsame : e.oth e.blind = e.oth e.actual)
    (hcarries : e.link → e.received = e.sent)
    (h1 : OtherTests e) (h2 : PassesOn e) (h4 : TakesIn e)
    (h5 : Accepts e) (h7 : Keeps e) : e.carried e.blind :=
  (h7 _).mpr ((h5 _).mpr ⟨hblind, fun hl =>
    hsame.trans (h1.symm.trans (h2.symm.trans ((hcarries hl).symm.trans h4.symm)))⟩)

/-- Accepting a false signal rules out the actual world.  If the other's
observation did not come from the world, and it is passed on, carried, taken
in, accepted and retained, the actual world is no longer kept possible. -/
theorem accepting_false_signal_loses_truth (e : Exchange World Outcome)
    (hcarries : e.link → e.received = e.sent)
    (hno : e.theirObservation ≠ e.oth e.actual) (h2 : PassesOn e) (h3 : KeepsLink e)
    (h4 : TakesIn e) (h5 : Accepts e) (h7 : Keeps e) : ¬ e.carried e.actual := by
  intro hc
  have := ((h5 _).mp ((h7 _).mp hc)).2 h3
  exact hno (h2.symm.trans ((hcarries h3).symm.trans (h4.symm.trans this.symm)))

/-- For a blind spot, the receiver's own evidence cannot evaluate a correction.
Whatever rule it uses to judge a signal from its own observations gives the
same verdict in the actual world and in the wrong world it cannot tell apart.
So a rule that accepts the signal where it is true accepts the same signal
where it is false. -/
theorem own_evidence_cannot_evaluate_blind_correction {Op Signal : Type}
    (own : Op → World → Outcome) (actual b : World)
    (hblind : ∀ o, own o b = own o actual)
    (evaluate : (Op → Outcome) → Signal → Bool) (σ : Signal) :
    evaluate (fun o => own o b) σ = evaluate (fun o => own o actual) σ := by
  have h : (fun o => own o b) = (fun o => own o actual) := funext hblind
  rw [h]

theorem other_untested_blocks (e : Exchange World Outcome) (hs : Setting e)
    (hno : e.theirObservation ≠ e.oth e.actual) (h2 : PassesOn e) (h3 : KeepsLink e)
    (h4 : TakesIn e) (h5 : Accepts e) (h7 : Keeps e) : ¬ Corrected e := by
  intro hc
  have := ((h5 _).mp ((h7 _).mp hc.2)).2 h3
  exact hno (h2.symm.trans ((hs.2.2 h3).symm.trans (h4.symm.trans this.symm)))

theorem not_passed_on_blocks (e : Exchange World Outcome) (hs : Setting e)
    (h1 : OtherTests e) (hno : e.sent ≠ e.theirObservation) (h3 : KeepsLink e)
    (h4 : TakesIn e) (h5 : Accepts e) (h7 : Keeps e) : ¬ Corrected e := by
  intro hc
  have := ((h5 _).mp ((h7 _).mp hc.2)).2 h3
  exact hno ((hs.2.2 h3).symm.trans (h4.symm.trans (this.symm.trans h1.symm)))

theorem broken_link_blocks (e : Exchange World Outcome) (hs : Setting e)
    (hno : ¬ KeepsLink e) (h5 : Accepts e) (h7 : Keeps e) : ¬ Corrected e :=
  fun hc => hc.1 ((h7 _).mpr ((h5 _).mpr ⟨hs.1, fun h => absurd h hno⟩))

theorem not_taken_in_blocks (e : Exchange World Outcome) (hs : Setting e)
    (h1 : OtherTests e) (h2 : PassesOn e) (h3 : KeepsLink e)
    (hno : e.taken ≠ e.received) (h5 : Accepts e) (h7 : Keeps e) : ¬ Corrected e := by
  intro hc
  have := ((h5 _).mp ((h7 _).mp hc.2)).2 h3
  exact hno (this.symm.trans (h1.symm.trans (h2.symm.trans (hs.2.2 h3).symm)))

theorem not_accepted_blocks (e : Exchange World Outcome) (hs : Setting e)
    (hno : SetsAside e) (h7 : Keeps e) : ¬ Corrected e :=
  fun hc => hc.1 ((h7 _).mpr ((hno _).mpr hs.1))

theorem sealed_blocks_correction (e : Exchange World Outcome)
    (hno : ¬ LeftOpen e) (h5 : Accepts e) (h7 : Keeps e) : ¬ Corrected e :=
  fun hc => hno ((h5 _).mp ((h7 _).mp hc.2)).1

theorem not_retained_blocks (e : Exchange World Outcome) (hs : Setting e)
    (hno : KeepsNothing e) : ¬ Corrected e :=
  fun hc => hc.1 ((hno _).mpr hs.1)

/-! ### Each failure is possible with the other six verbs in place

The actual world is 0, the wrong world is 1, and the other's operation yields
the number of the world. -/

/-- A base exchange; the examples below change one field at a time. -/
def baseExchange : Exchange Nat Nat where
  actual := 0
  blind := 1
  before := fun w => w = 0 ∨ w = 1
  oth := fun w => w
  theirObservation := 0
  sent := 0
  received := 0
  taken := 0
  link := True
  updated := fun w => w = 0
  carried := fun w => w = 0

theorem exchange_witness :
    Setting baseExchange ∧ OtherTests baseExchange ∧ PassesOn baseExchange ∧
    KeepsLink baseExchange ∧ TakesIn baseExchange ∧ Accepts baseExchange ∧
    LeftOpen baseExchange ∧ Keeps baseExchange ∧ Corrected baseExchange := by
  have hs : Setting baseExchange := ⟨Or.inr rfl, by decide, fun _ => rfl⟩
  have h5 : Accepts baseExchange := by
    intro w
    show w = 0 ↔ ((w = 0 ∨ w = 1) ∧ (True → w = 0))
    simp
    omega
  have h6 : LeftOpen baseExchange := Or.inl rfl
  have h7 : Keeps baseExchange := fun _ => Iff.rfl
  exact ⟨hs, rfl, rfl, trivial, rfl, h5, h6, h7,
    seven_verbs_correct _ hs rfl rfl trivial rfl h5 h6 h7⟩

theorem other_untested_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ e.theirObservation ≠ e.oth e.actual ∧ PassesOn e ∧ KeepsLink e ∧
    TakesIn e ∧ Accepts e ∧ LeftOpen e ∧ Keeps e := by
  refine ⟨{ baseExchange with
            theirObservation := 1, sent := 1, received := 1, taken := 1,
            updated := fun w => w = 1, carried := fun w => w = 1 },
          ⟨Or.inr rfl, by decide, fun _ => rfl⟩, by decide, rfl, trivial, rfl, ?_,
          Or.inl rfl, fun _ => Iff.rfl⟩
  intro w
  show w = 1 ↔ ((w = 0 ∨ w = 1) ∧ (True → w = 1))
  simp
  omega

theorem not_passed_on_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ OtherTests e ∧ e.sent ≠ e.theirObservation ∧ KeepsLink e ∧
    TakesIn e ∧ Accepts e ∧ LeftOpen e ∧ Keeps e := by
  refine ⟨{ baseExchange with
            sent := 1, received := 1, taken := 1,
            updated := fun w => w = 1, carried := fun w => w = 1 },
          ⟨Or.inr rfl, by decide, fun _ => rfl⟩, rfl, by decide, trivial, rfl, ?_,
          Or.inl rfl, fun _ => Iff.rfl⟩
  intro w
  show w = 1 ↔ ((w = 0 ∨ w = 1) ∧ (True → w = 1))
  simp
  omega

theorem broken_link_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ OtherTests e ∧ PassesOn e ∧ ¬ KeepsLink e ∧
    TakesIn e ∧ Accepts e ∧ LeftOpen e ∧ Keeps e := by
  refine ⟨{ baseExchange with
            link := False, updated := fun w => w = 0 ∨ w = 1,
            carried := fun w => w = 0 ∨ w = 1 },
          ⟨Or.inr rfl, by decide, fun h => h.elim⟩, rfl, rfl, fun h => h, rfl, ?_,
          Or.inl rfl, fun _ => Iff.rfl⟩
  intro w
  show (w = 0 ∨ w = 1) ↔ ((w = 0 ∨ w = 1) ∧ (False → w = 0))
  simp

theorem not_taken_in_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ OtherTests e ∧ PassesOn e ∧ KeepsLink e ∧
    e.taken ≠ e.received ∧ Accepts e ∧ LeftOpen e ∧ Keeps e := by
  refine ⟨{ baseExchange with
            taken := 1, updated := fun w => w = 1, carried := fun w => w = 1 },
          ⟨Or.inr rfl, by decide, fun _ => rfl⟩, rfl, rfl, trivial, by decide, ?_,
          Or.inl rfl, fun _ => Iff.rfl⟩
  intro w
  show w = 1 ↔ ((w = 0 ∨ w = 1) ∧ (True → w = 1))
  simp
  omega

theorem not_accepted_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ OtherTests e ∧ PassesOn e ∧ KeepsLink e ∧
    TakesIn e ∧ SetsAside e ∧ LeftOpen e ∧ Keeps e :=
  ⟨{ baseExchange with
      updated := fun w => w = 0 ∨ w = 1, carried := fun w => w = 0 ∨ w = 1 },
   ⟨Or.inr rfl, by decide, fun _ => rfl⟩, rfl, rfl, trivial, rfl, fun _ => Iff.rfl,
   Or.inl rfl, fun _ => Iff.rfl⟩

theorem sealed_correction_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ OtherTests e ∧ PassesOn e ∧ KeepsLink e ∧
    TakesIn e ∧ Accepts e ∧ ¬ LeftOpen e ∧ Keeps e := by
  refine ⟨{ baseExchange with
            before := fun w => w = 1, updated := fun _ => False,
            carried := fun _ => False },
          ⟨rfl, by decide, fun _ => rfl⟩, rfl, rfl, trivial, rfl, ?_, ?_, fun _ => Iff.rfl⟩
  · intro w
    show False ↔ (w = 1 ∧ (True → w = 0))
    simp
    omega
  · show ¬ ((0 : Nat) = 1)
    decide

theorem not_retained_possible : ∃ e : Exchange Nat Nat,
    Setting e ∧ OtherTests e ∧ PassesOn e ∧ KeepsLink e ∧
    TakesIn e ∧ Accepts e ∧ LeftOpen e ∧ KeepsNothing e := by
  refine ⟨{ baseExchange with
            carried := fun w => w = 0 ∨ w = 1 },
          ⟨Or.inr rfl, by decide, fun _ => rfl⟩, rfl, rfl, trivial, rfl, ?_,
          Or.inl rfl, fun _ => Iff.rfl⟩
  intro w
  show w = 0 ↔ ((w = 0 ∨ w = 1) ∧ (True → w = 0))
  simp
  omega

/-! ## Being told and being taught

A correction passes on a result, which the receiver of a blind-spot correction
cannot check (`own_evidence_cannot_evaluate_blind_correction`) and which rules
out the truth if it is false (`accepting_false_signal_loses_truth`).  An
operation passes on a means.  The learner then asks the world itself.

Assumed here: the learner's account of the operation is right, that is, it
knows which outcome each world would give.  A wrong account of an instrument
is a false record in another form (`untested_blocks`).  Checking an instrument
on cases already known is not modelled. -/

/-- Honest own testing never rules out the actual world, whatever the
operation.  The worst a useless operation does is rule nothing out. -/
theorem own_test_keeps_truth (t : Turn World Outcome)
    (hopen : LeavesOpen t) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : t.carried t.actual :=
  (hret _).mpr (Or.inl ⟨hpay, (hupd _).mpr ⟨hopen, (hrec.trans htest).symm⟩⟩)

/-- If the operation tells a wrong world from the actual one, an honest own
test rules that world out.  No one else's honesty is needed. -/
theorem own_test_removes_error (t : Turn World Outcome) (b : World)
    (hne : t.out b ≠ t.out t.actual) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : ¬ t.carried b := by
  intro hc
  cases (hret b).mp hc with
  | inl h1 => exact hne (((hupd b).mp h1.2).2.trans (hrec.trans htest))
  | inr h2 => exact h2.1 hpay

/-- The learner's operations with one more, acquired from another. -/
def withAcquired {Op : Type} (own : Op → World → Outcome) (nu : World → Outcome) :
    Option Op → World → Outcome
  | none => nu
  | some o => own o

/-- Acquiring an operation that tells the wrong world from the actual one
ends the blindness: not all of the learner's operations agree on them now. -/
theorem acquired_operation_opens_blind_spot {Op : Type} (own : Op → World → Outcome)
    (nu : World → Outcome) (actual b : World) (hne : nu b ≠ nu actual) :
    ¬ ∀ o, withAcquired own nu o b = withAcquired own nu o actual :=
  fun h => hne (h none)

/-- After acquiring it, the learner's own observations differ between the two
worlds, so its own evidence can separate them.  Compare
`own_evidence_cannot_evaluate_blind_correction`. -/
theorem after_acquiring_observations_differ {Op : Type} (own : Op → World → Outcome)
    (nu : World → Outcome) (actual b : World) (hne : nu b ≠ nu actual) :
    (fun o => withAcquired own nu o b) ≠ (fun o => withAcquired own nu o actual) :=
  fun h => hne (congrFun h none)

/-- Teaching removes a difference in available methods.  Whatever is still
blind to the learner after it has acquired the other's operation is something
that operation does not tell apart either.  This is about methods only.  It
does not say the two can no longer correct each other: differences in
evidence, implementation and experience remain, and an independent execution
of the same method still catches failures
(`same_method_disagreement_reveals_failure`).  An earlier wording of this note
claimed more; an outside reader and the author corrected it (D45). -/
theorem after_acquiring_other_adds_nothing {Op : Type} (own : Op → World → Outcome)
    (nu : World → Outcome) (actual b : World)
    (hstill : ∀ o, withAcquired own nu o b = withAcquired own nu o actual) :
    nu b = nu actual :=
  hstill none

/-! ## The same method, run twice -/

/-- Two learners who run the same operation in the same world, and both test
and record honestly, get the same record. -/
theorem same_method_honest_records_agree (t1 t2 : Turn World Outcome)
    (hact : t1.actual = t2.actual) (hout : t1.out = t2.out)
    (h1 : Tests t1) (h2 : Records t1) (h3 : Tests t2) (h4 : Records t2) :
    t1.recorded = t2.recorded := by
  have e1 : t1.recorded = t1.out t1.actual := h2.trans h1
  have e2 : t2.recorded = t2.out t2.actual := h4.trans h3
  rw [e1, e2, hout, hact]

/-- So if their records disagree, at least one of them did not test or did not
record honestly.  Sharing a method does not remove the value of a second,
independent execution. -/
theorem same_method_disagreement_reveals_failure (t1 t2 : Turn World Outcome)
    (hact : t1.actual = t2.actual) (hout : t1.out = t2.out)
    (hdis : t1.recorded ≠ t2.recorded) :
    ¬ (Tests t1 ∧ Records t1 ∧ Tests t2 ∧ Records t2) :=
  fun h => hdis (same_method_honest_records_agree t1 t2 hact hout h.1 h.2.1 h.2.2.1 h.2.2.2)

/-- Agreement proves nothing if both failed alike: two records can agree and
both be false. -/
theorem agreement_is_not_proof : ∃ t1 t2 : Turn Nat Nat,
    t1.actual = t2.actual ∧ t1.out = t2.out ∧ t1.recorded = t2.recorded ∧
    t1.recorded ≠ t1.out t1.actual := by
  let t : Turn Nat Nat :=
    { actual := 0, kept := fun _ => True, out := fun w => w, observed := 0, recorded := 1,
      updated := fun _ => True, carried := fun _ => True, paid := True }
  exact ⟨t, t, rfl, rfl, rfl, by decide⟩

/-! ## The same verbs, one level up

A method can itself be wrong.  The learner works with an account of the
operation: which outcome each world would give.  Checking that account is a
learning problem of the same form, in which the candidate accounts take the
place of the worlds and a known case takes the place of the operation. -/

/-- With a wrong account of the operation, an honest record rules out the
actual world.  `real` is what the operation in fact yields; the learner
updates with `t.out`, its account of it. -/
theorem wrong_account_of_method_loses_truth (t : Turn World Outcome)
    (real : World → Outcome) (hobs : t.observed = real t.actual)
    (hwrong : real t.actual ≠ t.out t.actual) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : ¬ t.carried t.actual := by
  intro hc
  cases (hret _).mp hc with
  | inl h1 => exact hwrong ((((hupd _).mp h1.2).2.trans (hrec.trans hobs)).symm)
  | inr h2 => exact h2.1 hpay

/-- Checking a method on a known case is a learning turn.  The "worlds" are
the candidate accounts of the method, the actual one is the true account, and
the operation is to apply an account to the known case.  With the verbs in
place the true account is kept and every account that mispredicts the known
case is ruled out. -/
theorem method_check_filters_accounts {W O : Type} (t : Turn (W → O) O) (known : W)
    (hop : t.out = fun account => account known)
    (hopen : LeavesOpen t) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) :
    t.carried t.actual ∧ ∀ account, account known ≠ t.actual known → ¬ t.carried account := by
  refine ⟨own_test_keeps_truth t hopen htest hrec hupd hret hpay, ?_⟩
  intro account hne
  apply own_test_removes_error t account _ htest hrec hupd hret hpay
  rw [hop]
  exact hne

/-- A wrong account that agrees with the true one on the known case survives
the check.  This is the blind spot one level up: a method validated on the
cases one knows can still be wrong on the others. -/
theorem validated_method_can_still_be_wrong {W O : Type} (t : Turn (W → O) O) (known : W)
    (hop : t.out = fun account => account known) (account : W → O)
    (hwrong : account ≠ t.actual)
    (hkept : t.kept account) (hagree : account known = t.actual known)
    (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) :
    account ≠ t.actual ∧ t.carried account := by
  refine ⟨hwrong, (hret _).mpr (Or.inl ⟨hpay, (hupd _).mpr ⟨hkept, ?_⟩⟩)⟩
  have h : t.out account = t.out t.actual := by rw [hop]; exact hagree
  exact h.trans (hrec.trans htest).symm

/-- If the candidate accounts differ on the known case, the check is a
learning turn in the full sense: at least one account is ruled out.  Without
that, the check filters and may remove nothing. -/
theorem method_check_learns_when_accounts_differ {W O : Type} (t : Turn (W → O) O)
    (hopen : LeavesOpen t) (htry : Tries t) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : Learns t :=
  seven_verbs_learn t hopen htry htest hrec hupd hret hpay

/-! ### Witnesses for the three results above -/

/-- The hypotheses of the two validation results can hold together: accounts
are maps on `Bool`, the true one is the identity, the known case is `true`.
The constant account `true` is wrong and agrees on the known case. -/
theorem method_validation_witness : ∃ (t : Turn (Bool → Bool) Bool) (known : Bool),
    t.out = (fun account => account known) ∧ LeavesOpen t ∧ Tests t ∧ Records t ∧
    Updates t ∧ Retains t ∧ Affords t ∧
    t.kept (fun _ => true) ∧ (fun _ : Bool => true) known = t.actual known ∧
    (fun _ : Bool => true) ≠ t.actual := by
  refine ⟨{ actual := id, kept := fun _ => True, out := fun a => a true, observed := true,
            recorded := true, updated := fun a => a true = true,
            carried := fun a => a true = true, paid := True },
          true, rfl, trivial, rfl, rfl, ?_, ?_, trivial, trivial, rfl, ?_⟩
  · intro a; show a true = true ↔ (True ∧ a true = true); simp
  · intro a; show a true = true ↔ ((True ∧ a true = true) ∨ (¬ True ∧ True)); simp
  · intro h
    have := congrFun h false
    simp at this

/-- The hypotheses of `wrong_account_of_method_loses_truth` can hold together. -/
theorem wrong_account_witness : ∃ (t : Turn Nat Nat) (real : Nat → Nat),
    t.observed = real t.actual ∧ real t.actual ≠ t.out t.actual ∧ Records t ∧
    Updates t ∧ Retains t ∧ Affords t := by
  refine ⟨{ actual := 0, kept := fun _ => True, out := fun w => w, observed := 1,
            recorded := 1, updated := fun w => w = 1, carried := fun w => w = 1,
            paid := True }, fun _ => 1, rfl, by decide, rfl, ?_, ?_, trivial⟩
  · intro w; show w = 1 ↔ (True ∧ w = 1); simp
  · intro w; show w = 1 ↔ ((True ∧ w = 1) ∨ (¬ True ∧ True)); simp

/-! ## What cannot be checked from inside -/

/-- Two turns that agree in everything the learner has, and differ only in
which world is actual.  In the first all seven verbs hold and the learner
learns.  In the second the same record, update and retention rule out the
actual world.  Nothing the learner has tells them apart. -/
theorem tested_and_untested_look_alike : ∃ t1 t2 : Turn Nat Nat,
    t1.kept = t2.kept ∧ t1.out = t2.out ∧ t1.observed = t2.observed ∧
    t1.recorded = t2.recorded ∧ t1.updated = t2.updated ∧ t1.carried = t2.carried ∧
    t1.paid = t2.paid ∧ Learns t1 ∧ ¬ t2.carried t2.actual := by
  refine ⟨goodTurn, { goodTurn with actual := 1 }, rfl, rfl, rfl, rfl, rfl, rfl, rfl,
    learning_verbs_witness.2.2.2.2.2.2.2, ?_⟩
  show ¬ ((1 : Nat) = 0)
  decide

/-- The same for leaving open: whether the actual world is among those kept
possible is not something the learner can read off what it has.  Never having
thought of the truth and having ruled it out look the same. -/
theorem open_and_sealed_look_alike : ∃ t1 t2 : Turn Nat Nat,
    t1.kept = t2.kept ∧ t1.out = t2.out ∧ t1.observed = t2.observed ∧
    t1.recorded = t2.recorded ∧ t1.updated = t2.updated ∧ t1.carried = t2.carried ∧
    t1.paid = t2.paid ∧ LeavesOpen t1 ∧ ¬ LeavesOpen t2 := by
  refine ⟨goodTurn, { goodTurn with actual := 2 }, rfl, rfl, rfl, rfl, rfl, rfl, rfl,
    Or.inl rfl, ?_⟩
  show ¬ ((2 : Nat) = 0 ∨ (2 : Nat) = 1)
  decide

/-! ## A world that moves, and one joint space -/

/-- A world that agrees with the actual one on the operation is carried
forward. -/
theorem agreeing_world_is_carried (t : Turn World Outcome) (x : World)
    (hkept : t.kept x) (hagree : t.out x = t.out t.actual) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : t.carried x :=
  (hret _).mpr (Or.inl ⟨hpay, (hupd _).mpr ⟨hkept, hagree.trans (hrec.trans htest).symm⟩⟩)

/-- What an honest test rightly ruled out can be the actual world after a
change.  If the world moves to one that the old operation told apart from the
old world, the retained result excludes it.  What fails is treating the old
result as an unchanged constraint on the present; a record tied to its own
time can stay true.  The theorem changes which world is called actual; it
does not model time, or a way of noticing the change. -/
theorem retained_record_goes_stale (t : Turn World Outcome) (newActual : World)
    (hmoved : t.out newActual ≠ t.out t.actual) (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) : ¬ t.carried newActual :=
  own_test_removes_error t newActual hmoved htest hrec hupd hret hpay

/-- A surprise does not say which part is wrong.  The learner holds a view of
the world together with an account of its method, and what it expects is what
the account gives for that world.  When the outcome contradicts the pair it
held, that pair is ruled out; but a pair that changes only the world, and a
pair that changes only the account, both survive if they fit the outcome.
This is the same loop on the joint space, with nothing added. -/
theorem surprise_does_not_say_which {W O : Type} (t : Turn (W × (W → O)) O)
    (hop : t.out = fun h => h.2 h.1) (w w' : W) (account account' : W → O)
    (hmis : account w ≠ t.out t.actual)
    (hk1 : t.kept (w', account)) (h1 : account w' = t.out t.actual)
    (hk2 : t.kept (w, account')) (h2 : account' w = t.out t.actual)
    (htest : Tests t) (hrec : Records t)
    (hupd : Updates t) (hret : Retains t) (hpay : Affords t) :
    ¬ t.carried (w, account) ∧ t.carried (w', account) ∧ t.carried (w, account') := by
  have e0 : t.out (w, account) = account w := by rw [hop]
  have e1 : t.out (w', account) = account w' := by rw [hop]
  have e2 : t.out (w, account') = account' w := by rw [hop]
  refine ⟨?_, ?_, ?_⟩
  · exact own_test_removes_error t (w, account) (fun h => hmis (e0.symm.trans h))
      htest hrec hupd hret hpay
  · exact agreeing_world_is_carried t _ hk1 (e1.trans h1) htest hrec hupd hret hpay
  · exact agreeing_world_is_carried t _ hk2 (e2.trans h2) htest hrec hupd hret hpay

/-! ## Repair over time -/

/-- Whether the error is still kept possible after a run of turns.  In each
turn the other verbs are in place, so the error is removed exactly when the
link holds (`seven_verbs_correct`, `broken_link_blocks`).  `true` in the list
means the link held in that turn. -/
def errorSurvives : List Bool → Bool
  | [] => true
  | l :: ls => !l && errorSurvives ls

/-- The error is still there at the end exactly when the link held in no turn.
A break is a delay if it is repaired in some turn, and permanent if not. -/
theorem error_survives_iff_never_linked (links : List Bool) :
    errorSurvives links = true ↔ ∀ l ∈ links, l = false := by
  induction links with
  | nil => simp [errorSurvives]
  | cons l ls ih => simp [errorSurvives, ih]

end LearningVerbs
end CumulativeAccessibility
