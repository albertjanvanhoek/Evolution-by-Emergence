namespace CumulativeAccessibility
namespace LearningVerbs

/-!
# The verbs of learning

What is learning made of?  This module states, for one turn of a learning
loop, a set of verbs that are together enough for learning and each needed
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
  verbs in place, the failure of one blocks learning in that turn.
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
* `same_view_cannot_correct`: if the other's operation does not tell the two
  worlds apart either, all seven verbs leave the wrong world in place.  The two
  learners have to differ.
* `error_survives_iff_never_linked`: over any number of turns, with the other
  verbs in place, the error is still there at the end exactly when the link
  held in no turn.  A break is a delay if it is repaired, permanent if not.
* `learning_verbs_witness`: a concrete turn in which all seven verbs hold.

Relation to earlier results in this repository.  The solo loop is what this
module adds: the seven verbs, each shown to be needed, each failure shown to
be possible.  The part between learners mostly restates earlier results in
one small model: `blind_spot_survives` is close to
`ModelOfLargerReality.inside_view_cannot_settle`,
`error_survives_iff_never_linked` to
`Persistence.forgiveness_turns_split_into_delay`, and
`same_view_cannot_correct` is the two-learner form of
`hub_determined_network_inherits_blind_spot`.  This was noticed in the review
of D42, after the module was written.

How much this says.  The results are close to their definitions.  The one
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
state if it is not.  Keeping costs. -/
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

/-- A wrong world that none of the learner's own operations tells from the
actual one survives any set of its own honest turns, and so does the truth. -/
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
