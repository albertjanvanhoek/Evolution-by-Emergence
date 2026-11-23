namespace CumulativeAccessibility
namespace LearningRatchet

/-!
# The learning loop on the vortex ledger: a ratchet

This module was first named `LearningVortex`.  An outside review (entry D43 of
`DIALOGUE.md`) pointed out that the name claimed more than is shown: the space
of possibilities is fixed, so what is shown is a ratchet toward fit.  "Vortex"
is kept for the extension that models widening.

Entry D42 of `DIALOGUE.md`.  The core has two lines.  One is a ledger: slack,
selection, the vortex (steps 1 to 7).  The other is the Room: a learner is a
fallible model and needs correction (step 8).  They meet at feedback, which the
ledger treats as a number ("validated") and step 4 as given ("follows reliable
feedback").  This module puts the learning loop of `LearningVerbs` on the
ledger of step 1, in the simplest form, to state three things.

A learner holds a reserve.  It keeps some wrong worlds possible: `own`, which
its own operations can tell from the actual world, and `blind`, which they
cannot.  Each wrong world kept costs one unit per turn: misfit costs slack
(the premise of step 4).  If it has ruled out the actual world, that costs
`lost` per turn as well.  It takes up `u` per turn, and a try costs `t`.

**1. A learning turn lowers the cost of every later turn.**  It removes one
wrong world, so it raises slack by one, for good.  In `LearningVerbs` the verb
"afford" was given from outside; here it is paid from the reserve.  Raising
later slack is not the same as paying for the present try: a starting reserve
is needed (`loop_closes`), and a sealed learner fails only if its misfit
exceeds its uptake.

**2. The speed has a sign.**  A turn whose record is false (untested, or
distorted) and is retained cannot be told from a learning turn from inside
(`LearningVerbs.tested_and_untested_look_alike`).  But among the worlds it
removed is the actual one.  Slack changes by what the wrong worlds it happened
to remove were costing, minus what the lost world costs; it falls whenever the
second is larger (`false_turn_lowers_slack`).  The learner no longer leaves the truth open, so it no longer
does all seven verbs, whatever else it does; in this model no later try learns
anything until the record is taken back.  Whether it then runs out of reserve
depends on the ledger: with enough uptake a wrong model lasts.  How a false
record is recognised is not modelled: `revise` restores the truth by
definition.

**3. The speed has two terms.**  Alone, a learner removes only what its own
operations can tell apart, and then stops, with the blind errors still costing
it every turn.  Through a link to a learner with a different view it removes
those too, and in the same turn as its own (`both_terms_in_one_turn`).  With
the same view the link adds nothing.

Results:
* `learning_turn_raises_slack`, `learner_clears_own_errors`, `loop_closes`,
  `sealed_fails`, `futile_fails`, `efficiency_buys_duration`.
* `false_turn_slack`, `false_turn_lowers_slack`, `false_turn_excludes_truth`,
  `false_turn_blocks_later_learning`,
  `after_false_turn_no_learning`, `retained_false_record_fails`,
  `retaining_false_is_worse_than_discarding`, `revision_restores_learning`.
* `solo_keeps_blind`, `solo_fails_on_blind_spot`, `same_view_is_solo`,
  `errors_removed_two_terms`, `both_terms_in_one_turn`, `linked_lasts`,
  `link_decides`.
* `acquire_no_first_order_gain`, `acquire_widens`,
  `acquire_from_same_view_gains_nothing`, `taught_clears_all_alone`,
  `taught_lasts_alone`, `cut_off_after_telling_fails`.
* `learning_ratchet_witness`, `told_and_taught_witness`: concrete numbers.

**4. Being told and being taught (D44).**  Through a link the learner can be
told a result, one error per turn, or be taught the operation.  Acquiring the
operation needs a source with a different view, and removes no error and so raises no slack in that turn; what it
changes is which errors the learner can find by itself.  After it the learner
clears them alone, and a lost link no longer matters.  This is the smallest
case of a kept change that widens what can be tried, the second-order click
of step 5 (`new_parent_set_implies_secondOrderClick` states it in general);
here it is an instance, not a new principle.

An independent literature audit (D47) found no exact antecedent for this
ledger and judged its conclusions to follow largely from its stipulated prices
and transitions.  Two of its points belong here.  The count sets the bill:
splitting one wrong possibility into several raises the cost, and nothing
invariant (a probability, a loss, a value of information) stands behind the
count.  And the two terms of section 3 are two counters decremented
separately by definition; that is counting, not a general result about how
information from two sources combines.

How much this says.  The results are close to arithmetic once the setting is
fixed, and the setting carries them.  The strong assumptions: every wrong
world kept costs the same, each learning turn removes exactly one, and a kept
error costs in every turn (so there is no niche in which misfit is free, and
no one else who pays for it; step 4 of the core names both).  "Learns", "false
record" and "link" are defined here as kinds of turn; that they correspond to
the verbs is by reading `LearningVerbs` (`seven_verbs_learn`,
`untested_blocks`, `distorted_blocks`, `sealed_blocks`, `blind_spot_survives`,
`seven_verbs_correct`, `same_view_cannot_correct`), not by import.

Not covered: open-ended widening.  `acquire` widens what the learner can try,
but the set of errors is fixed, so the loop still closes and then stops
(`learner_clears_own_errors`): this is a ratchet toward fit.  It becomes a
vortex only when kept changes keep producing new things to try, which needs
new possibilities or a world that changes, and is not modelled here.  In this
model being taught costs more than being told (the cost of acquiring, and one
more turn of misfit); what it buys is independence from the link and from the
teller's honesty (`LearningVerbs.own_test_keeps_truth` against
`LearningVerbs.accepting_false_signal_loses_truth`).  Also not covered: recognising a
false record, a link that delivers a false signal
(`LearningVerbs.accepting_false_signal_loses_truth`), a
world that changes, errors of unequal cost, learning several things per turn,
a link that costs upkeep or can break (`LongCollaboration`, `Reciprocity`),
and choosing what to try.
-/

/-- The world's side of the ledger: uptake per turn, the cost of a try, the
cost per turn of having ruled out the actual world beyond one unit, and the
cost of taking a record back.  Having ruled out the actual world costs
`lostCost + 1` per turn: at least as much as one wrong world kept.  With a
cost that could be zero, a false record would leave no trace in the state and
would not block later learning; an independent audit found that (D47). -/
structure Terms where
  u : Nat
  t : Nat
  lostCost : Nat
  reviseCost : Nat
  /-- The cost of acquiring an operation from another. -/
  acquireCost : Nat

/-- The learner's state. -/
structure State where
  /-- The reserve.  The learner is viable while it is nonnegative. -/
  reserve : Int
  /-- Wrong worlds kept possible that its own operations can tell apart. -/
  own : Nat
  /-- Wrong worlds kept possible that its own operations cannot tell apart. -/
  blind : Nat
  /-- The cost per turn of having ruled out the actual world; zero if it has not. -/
  lost : Nat
  deriving DecidableEq

/-- Misfit: what the kept errors cost in a turn. -/
def misfit (s : State) : Nat := s.own + s.blind + s.lost

/-- Slack in a turn without trying: uptake minus the cost of misfit. -/
def slack (p : Terms) (s : State) : Int := (p.u : Int) - (misfit s : Int)

/-- A turn without trying: the sealed learner. -/
def idle (p : Terms) (s : State) : State :=
  { s with reserve := s.reserve + p.u - misfit s }

/-- A try that learns nothing because one of the verbs fails. -/
def futile (p : Terms) (s : State) : State :=
  { s with reserve := s.reserve + p.u - misfit s - p.t }

/-- A turn of a learner that does all seven verbs alone.  If there is an error
its own operations can tell apart, it tries; the try removes it, unless the
actual world has been ruled out, in which case nothing is learned.  If there
is nothing it can try, it does not try. -/
def learnOwn (p : Terms) (s : State) : State :=
  if 0 < s.own then
    if s.lost = 0 then
      { s with reserve := s.reserve + p.u - misfit s - p.t, own := s.own - 1 }
    else futile p s
  else idle p s

/-- A try whose record is false and is retained: the actual world is ruled out.
A false record keeps the worlds that agree with it, so it can also rule out
some wrong worlds, `r` of them here.  How many depends on what the record
happened to say; the model does not fix it. -/
def falseTurn (p : Terms) (r : Nat) (s : State) : State :=
  { s with reserve := s.reserve + p.u - misfit s - p.t, own := s.own - r,
           lost := s.lost + p.lostCost + 1 }

/-- Taking the false record back. -/
def revise (p : Terms) (s : State) : State :=
  { s with reserve := s.reserve + p.u - misfit s - p.reviseCost, lost := 0 }

/-- A turn of a learner with a link to another.  In the same turn it can
remove one error it can tell apart itself, by a try of its own, and, if the
other has a different view, one error it could not tell apart, by a try of
the other's.  Each try costs `t`.  If it has ruled out the actual world it
does as it would alone. -/
def linked (p : Terms) (differs : Bool) (s : State) : State :=
  if s.lost = 0 then
    if 0 < s.own then
      if differs = true ∧ 0 < s.blind then
        { s with reserve := s.reserve + p.u - misfit s - p.t - p.t,
                 own := s.own - 1, blind := s.blind - 1 }
      else
        { s with reserve := s.reserve + p.u - misfit s - p.t, own := s.own - 1 }
    else
      if differs = true ∧ 0 < s.blind then
        { s with reserve := s.reserve + p.u - misfit s - p.t, blind := s.blind - 1 }
      else idle p s
  else learnOwn p s

/-- A run of turns of one kind. -/
def run (f : State → State) : Nat → State → State
  | 0, s => s
  | n + 1, s => run f n (f s)

theorem run_add (f : State → State) (m n : Nat) (s : State) :
    run f (m + n) s = run f n (run f m s) := by
  induction m generalizing s with
  | zero => simp [run]
  | succ m ih =>
    have : m + 1 + n = (m + n) + 1 := by omega
    rw [this]
    simp [run, ih]

/-- If a property is kept by every turn, it holds after any run. -/
theorem run_keeps (f : State → State) (Inv : State → Prop)
    (h : ∀ s, Inv s → Inv (f s)) : ∀ n s, Inv s → Inv (run f n s) := by
  intro n
  induction n with
  | zero => intro s hs; exact hs
  | succ n ih => intro s hs; exact ih (f s) (h s hs)

/-- If, while a property holds, every turn keeps it and costs at least one
unit, the reserve after `n` turns is at least `n` lower. -/
theorem run_drains (f : State → State) (Inv : State → Prop)
    (hkeep : ∀ s, Inv s → Inv (f s))
    (hcost : ∀ s, Inv s → (f s).reserve ≤ s.reserve - 1) :
    ∀ n s, Inv s → (run f n s).reserve ≤ s.reserve - n := by
  intro n
  induction n with
  | zero => intro s _; simp [run]
  | succ n ih =>
    intro s hs
    have h1 := ih (f s) (hkeep s hs)
    have h2 := hcost s hs
    simp only [run]
    omega

/-- A reserve that falls by at least one unit per turn runs out. -/
theorem drained_fails (f : State → State) (Inv : State → Prop)
    (hkeep : ∀ s, Inv s → Inv (f s))
    (hcost : ∀ s, Inv s → (f s).reserve ≤ s.reserve - 1)
    (s : State) (hs : Inv s) : ∃ n, (run f n s).reserve < 0 := by
  refine ⟨s.reserve.toNat + 1, ?_⟩
  have := run_drains f Inv hkeep hcost (s.reserve.toNat + 1) s hs
  omega

/-! ## 1. A learning turn lowers the cost of every later turn -/

/-- A learning turn raises slack by one, for good. -/
theorem learning_turn_raises_slack (p : Terms) (s : State)
    (hown : 0 < s.own) (hlost : s.lost = 0) :
    slack p (learnOwn p s) = slack p s + 1 := by
  simp [learnOwn, hown, hlost, slack, misfit]
  omega

/-- A learner with no blind errors removes one error per turn until none is left. -/
theorem learner_clears_own_errors (p : Terms) :
    ∀ n s, s.lost = 0 → (run (learnOwn p) n s).own = s.own - n := by
  intro n
  induction n with
  | zero => intro s _; simp [run]
  | succ n ih =>
    intro s hlost
    have hl : (learnOwn p s).lost = 0 := by
      unfold learnOwn; split <;> simp [hlost, idle]
    have ho : (learnOwn p s).own = s.own - 1 := by
      unfold learnOwn; split
      · simp
      · simp [idle]; omega
    simp only [run]
    rw [ih _ hl, ho]
    omega

/-- The reserve that covers learning away `e` errors with no uptake at all:
each turn pays for the errors still kept, and for the try. -/
def need (p : Terms) : Nat → Nat
  | 0 => 0
  | e + 1 => need p e + (e + 1) + p.t

theorem need_succ (p : Terms) (e : Nat) : need p (e + 1) = need p e + (e + 1) + p.t := rfl

/-- The loop closes.  A learner with no blind errors whose reserve covers the
way down is viable in every turn: after its errors are gone its slack is its
uptake, which is not negative. -/
theorem loop_closes (p : Terms) (s : State)
    (hlost : s.lost = 0) (hblind : s.blind = 0) (hres : (need p s.own : Int) ≤ s.reserve) :
    ∀ n, 0 ≤ (run (learnOwn p) n s).reserve := by
  intro n
  let Inv : State → Prop := fun s => s.lost = 0 ∧ s.blind = 0 ∧ (need p s.own : Int) ≤ s.reserve
  have hkeep : ∀ s, Inv s → Inv (learnOwn p s) := by
    intro s ⟨h1, h2, h3⟩
    unfold learnOwn
    split
    · rename_i hpos
      have hk : s.own = (s.own - 1) + 1 := by omega
      rw [hk, need_succ] at h3
      simp [h1, Inv, h2, misfit]
      omega
    · rename_i hzero
      have h0 : s.own = 0 := by omega
      simp [idle, Inv, h1, h2, misfit, h0]
      simp [h0, need] at h3
      simp [need]
      omega
  have := run_keeps (learnOwn p) Inv hkeep n s ⟨hlost, hblind, hres⟩
  have hn : (0 : Int) ≤ (need p (run (learnOwn p) n s).own : Int) := Int.natCast_nonneg _
  exact Int.le_trans hn this.2.2

/-- A sealed learner whose misfit exceeds its uptake runs out of reserve. -/
theorem sealed_fails (p : Terms) (s : State) (h : p.u < misfit s) :
    ∃ n, (run (idle p) n s).reserve < 0 := by
  refine drained_fails (idle p) (fun x => p.u < misfit x) ?_ ?_ s h
  · intro x hx; simpa [idle, misfit] using hx
  · intro x hx; simp only [idle]; omega

/-- So does one that tries and learns nothing, and sooner. -/
theorem futile_fails (p : Terms) (s : State) (h : p.u < misfit s) :
    ∃ n, (run (futile p) n s).reserve < 0 := by
  refine drained_fails (futile p) (fun x => p.u < misfit x) ?_ ?_ s h
  · intro x hx; simpa [futile, misfit] using hx
  · intro x hx; simp only [futile]; omega

/-- Efficiency buys duration.  From the same start, with misfit above uptake,
the learner is viable in every turn and the sealed one is not. -/
theorem efficiency_buys_duration (p : Terms) (s : State)
    (hlost : s.lost = 0) (hblind : s.blind = 0)
    (hres : (need p s.own : Int) ≤ s.reserve) (hmis : p.u < misfit s) :
    (∀ n, 0 ≤ (run (learnOwn p) n s).reserve) ∧ (∃ n, (run (idle p) n s).reserve < 0) :=
  ⟨loop_closes p s hlost hblind hres, sealed_fails p s hmis⟩

/-! ## 2. The speed has a sign

From inside, a turn with a false record cannot be told from a learning turn:
the learner does the same thing in both, and nothing it has shows which world
is actual (`LearningVerbs.tested_and_untested_look_alike`). -/

/-- What a retained false record does to slack: it gains what the wrong worlds
it happened to remove were costing, and loses what the lost world costs. -/
theorem false_turn_slack (p : Terms) (r : Nat) (s : State) (hr : r ≤ s.own) :
    slack p (falseTurn p r s) = slack p s + r - p.lostCost - 1 := by
  simp [falseTurn, slack, misfit]
  omega

/-- A false turn always leaves its mark: the actual world is ruled out,
whatever the costs. -/
theorem false_turn_excludes_truth (p : Terms) (r : Nat) (s : State) :
    0 < (falseTurn p r s).lost := by
  simp [falseTurn]

/-- So after any false turn, an honest try learns nothing until the record is
taken back.  This holds by the rule of `learnOwn`; it is not derived from
`LearningVerbs`. -/
theorem false_turn_blocks_later_learning (p : Terms) (r : Nat) (s : State)
    (hown : 0 < (falseTurn p r s).own) :
    learnOwn p (falseTurn p r s) = futile p (falseTurn p r s) := by
  have h := false_turn_excludes_truth p r s
  have hne : ¬ ((falseTurn p r s).lost = 0) := by omega
  simp [learnOwn, hown, hne]

/-- It lowers slack whenever the lost world costs more than the wrong worlds
it removed were costing.  The condition is needed. -/
theorem false_turn_lowers_slack (p : Terms) (r : Nat) (s : State)
    (hr : r ≤ s.own) (h : r ≤ p.lostCost) :
    slack p (falseTurn p r s) < slack p s := by
  rw [false_turn_slack p r s hr]
  omega

/-- Once the actual world is ruled out, an honest try learns nothing. -/
theorem after_false_turn_no_learning (p : Terms) (s : State)
    (hown : 0 < s.own) (hlost : 0 < s.lost) : learnOwn p s = futile p s := by
  have : ¬ (s.lost = 0) := by omega
  simp [learnOwn, hown, this]

/-- If the misfit that a retained false record leaves exceeds the uptake, the
learner runs out of reserve, although it goes on trying.  The condition is
needed: with enough uptake a wrong model lasts.  And the learner is no longer
doing all seven verbs, since it has not left the truth open. -/
theorem retained_false_record_fails (p : Terms) (s : State)
    (hlost : 0 < s.lost) (hmis : p.u < misfit s) :
    ∃ n, (run (learnOwn p) n s).reserve < 0 := by
  refine drained_fails (learnOwn p) (fun x => 0 < x.lost ∧ p.u < misfit x) ?_ ?_ s ⟨hlost, hmis⟩
  · intro x ⟨h1, h2⟩
    have hne : ¬ (x.lost = 0) := by omega
    unfold learnOwn
    split
    · simp [hne, futile, misfit] at *; exact ⟨h1, h2⟩
    · simp [idle, misfit] at *; exact ⟨h1, h2⟩
  · intro x ⟨h1, h2⟩
    have hne : ¬ (x.lost = 0) := by omega
    unfold learnOwn
    split
    · simp [futile]; omega
    · simp [idle]; omega

/-- Retaining a false record is worse than discarding the try, under the same
condition. -/
theorem retaining_false_is_worse_than_discarding (p : Terms) (r : Nat) (s : State)
    (hr : r ≤ s.own) (h : r ≤ p.lostCost) :
    slack p (falseTurn p r s) < slack p (futile p s) ∧
    (falseTurn p r s).reserve = (futile p s).reserve := by
  constructor
  · simp [falseTurn, futile, slack, misfit]; omega
  · simp [falseTurn, futile]

/-- Recovery, given that the retraction succeeds.  `revise` sets the cost of
the lost world to zero by definition; then slack is restored by what the lost
world cost, and the next honest try learns again.  How a false record is
recognised and taken back is not modelled here. -/
theorem revision_restores_learning (p : Terms) (s : State) (hown : 0 < s.own) :
    slack p (revise p s) = slack p s + s.lost ∧
    (learnOwn p (revise p s)).own = s.own - 1 := by
  constructor
  · simp [revise, slack, misfit]; omega
  · simp [learnOwn, revise, hown]

/-! ## 3. The speed has two terms -/

/-- Alone, the blind errors stay. -/
theorem solo_keeps_blind (p : Terms) : ∀ n s, (run (learnOwn p) n s).blind = s.blind := by
  intro n
  induction n with
  | zero => intro s; rfl
  | succ n ih =>
    intro s
    have : (learnOwn p s).blind = s.blind := by
      unfold learnOwn; split
      · split <;> simp [futile]
      · simp [idle]
    simp only [run]
    rw [ih, this]

/-- Alone, a learner whose blind errors cost more than its uptake runs out of
reserve, although it does all seven verbs and however much it tries. -/
theorem solo_fails_on_blind_spot (p : Terms) (s : State) (h : p.u < s.blind) :
    ∃ n, (run (learnOwn p) n s).reserve < 0 := by
  refine drained_fails (learnOwn p) (fun x => p.u < x.blind) ?_ ?_ s h
  · intro x hx
    unfold learnOwn; split
    · split <;> simpa [futile] using hx
    · simpa [idle] using hx
  · intro x hx
    unfold learnOwn; split
    · split
      · simp [misfit]; omega
      · simp [futile, misfit]; omega
    · simp [idle, misfit]; omega

/-- A link to a learner with the same view adds nothing. -/
theorem same_view_is_solo (p : Terms) (s : State) : linked p false s = learnOwn p s := by
  unfold linked learnOwn
  by_cases hl : s.lost = 0 <;> by_cases ho : 0 < s.own <;> simp [hl, ho]

/-- The errors removed in a turn are the sum of two terms: one from the
learner's own operations, and one that arrives only through a link to a
different view.  Both can be active in the same turn. -/
theorem errors_removed_two_terms (p : Terms) (d : Bool) (s : State) (hlost : s.lost = 0) :
    (linked p d s).own + (linked p d s).blind + (if 0 < s.own then 1 else 0)
      + (if d = true ∧ 0 < s.blind then 1 else 0) = s.own + s.blind := by
  unfold linked
  by_cases h1 : 0 < s.own
  · by_cases h2 : d = true ∧ 0 < s.blind
    · have := h2.2
      simp [hlost, h1, h2]
      omega
    · simp [hlost, h1, h2]
      omega
  · have h0 : s.own = 0 := by omega
    by_cases h2 : d = true ∧ 0 < s.blind
    · have := h2.2
      simp [hlost, h0, h2]
      omega
    · simp [hlost, h0, h2, idle]

/-- With an error of each kind and a link to a different view, one turn
removes two errors: the two terms add. -/
theorem both_terms_in_one_turn (p : Terms) (s : State) (hlost : s.lost = 0)
    (ho : 0 < s.own) (hb : 0 < s.blind) :
    (linked p true s).own + (linked p true s).blind + 2 = s.own + s.blind := by
  simp [linked, hlost, ho, hb]
  omega

/-- With a link to a different view, a learner whose reserve covers the way
down for all its errors is viable in every turn. -/
theorem linked_lasts (p : Terms) (s : State) (hlost : s.lost = 0)
    (hres : (need p (s.own + s.blind) : Int) ≤ s.reserve) :
    ∀ n, 0 ≤ (run (linked p true) n s).reserve := by
  intro n
  let Inv : State → Prop := fun s => s.lost = 0 ∧ (need p (s.own + s.blind) : Int) ≤ s.reserve
  have hkeep : ∀ s, Inv s → Inv (linked p true s) := by
    intro s ⟨h1, h3⟩
    unfold linked
    by_cases ho : 0 < s.own
    · by_cases hb : 0 < s.blind
      · have hk : s.own + s.blind = ((s.own - 1 + (s.blind - 1)) + 1) + 1 := by omega
        rw [hk, need_succ, need_succ] at h3
        simp [h1, ho, hb, Inv, misfit]
        omega
      · have hb0 : s.blind = 0 := by omega
        have hk : s.own + s.blind = (s.own - 1 + s.blind) + 1 := by omega
        rw [hk, need_succ] at h3
        simp [h1, ho, hb0, Inv, misfit] at h3 ⊢
        omega
    · have h0 : s.own = 0 := by omega
      by_cases hb : 0 < s.blind
      · have hk : s.own + s.blind = (s.blind - 1) + 1 := by omega
        rw [hk, need_succ] at h3
        simp [h1, h0, hb, Inv, misfit]
        omega
      · have hb0 : s.blind = 0 := by omega
        simp [h0, hb0, need] at h3
        simp [h1, h0, hb0, Inv, idle, misfit, need]
        omega
  have := run_keeps (linked p true) Inv hkeep n s ⟨hlost, hres⟩
  have hn : (0 : Int) ≤ (need p ((run (linked p true) n s).own + (run (linked p true) n s).blind) : Int) :=
    Int.natCast_nonneg _
  exact Int.le_trans hn this.2

/-- The link decides.  From the same start, with blind errors that cost more
than the uptake: alone the learner fails, with a link to the same view it
fails, and with a link to a different view it is viable in every turn. -/
theorem link_decides (p : Terms) (s : State) (hlost : s.lost = 0)
    (hres : (need p (s.own + s.blind) : Int) ≤ s.reserve) (hblind : p.u < s.blind) :
    (∃ n, (run (learnOwn p) n s).reserve < 0) ∧
    (∃ n, (run (linked p false) n s).reserve < 0) ∧
    (∀ n, 0 ≤ (run (linked p true) n s).reserve) := by
  refine ⟨solo_fails_on_blind_spot p s hblind, ?_, linked_lasts p s hlost hres⟩
  have hfun : linked p false = learnOwn p := funext (same_view_is_solo p)
  rw [hfun]
  exact solo_fails_on_blind_spot p s hblind

/-! ## 4. Being told and being taught -/

/-- Acquiring an operation from another.  If the other has an operation the
learner lacks, the errors the learner could not tell apart become errors it
can; no error is removed in this turn.  If the other has the same view there
is nothing to acquire, and the cost is paid for nothing.  Developing a method
without anyone to acquire it from is not modelled: that would need an account
of where a new operation comes from. -/
def acquire (p : Terms) (differs : Bool) (s : State) : State :=
  if differs = true then
    { s with reserve := s.reserve + p.u - misfit s - p.acquireCost,
             own := s.own + s.blind, blind := 0 }
  else
    { s with reserve := s.reserve + p.u - misfit s - p.acquireCost }

/-- Acquiring removes no error: misfit and slack are unchanged. -/
theorem acquire_no_first_order_gain (p : Terms) (d : Bool) (s : State) :
    misfit (acquire p d s) = misfit s ∧ slack p (acquire p d s) = slack p s := by
  cases d <;> simp [acquire, misfit, slack]

/-- From a different view, what it changes is what the learner can find by
itself. -/
theorem acquire_widens (p : Terms) (s : State) :
    (acquire p true s).own = s.own + s.blind ∧ (acquire p true s).blind = 0 := by
  simp [acquire]

/-- From the same view there is nothing to acquire. -/
theorem acquire_from_same_view_gains_nothing (p : Terms) (s : State) :
    (acquire p false s).own = s.own ∧ (acquire p false s).blind = s.blind := by
  simp [acquire]

/-- After acquiring, the learner removes all its errors alone, one per turn. -/
theorem taught_clears_all_alone (p : Terms) (s : State) (hlost : s.lost = 0) (n : Nat) :
    (run (learnOwn p) n (acquire p true s)).own = s.own + s.blind - n ∧
    (run (learnOwn p) n (acquire p true s)).blind = 0 := by
  constructor
  · rw [learner_clears_own_errors p n (acquire p true s) (by simpa [acquire] using hlost)]
    simp [acquire]
  · rw [solo_keeps_blind]
    simp [acquire]

/-- After acquiring, a learner whose reserve covers the acquiring and the way
down is viable in every turn without any link. -/
theorem taught_lasts_alone (p : Terms) (s : State) (hlost : s.lost = 0)
    (hres : (need p (s.own + s.blind) : Int) + misfit s + p.acquireCost ≤ s.reserve + p.u) :
    ∀ n, 0 ≤ (run (learnOwn p) n (acquire p true s)).reserve := by
  apply loop_closes
  · simpa [acquire] using hlost
  · simp [acquire]
  · simp only [acquire]
    simp
    omega

/-- A learner that was only told, and is then cut off, keeps the blind errors
it had not yet been told about; if they cost more than its uptake it fails. -/
theorem cut_off_after_telling_fails (p : Terms) (s : State) (m : Nat)
    (h : p.u < (run (linked p true) m s).blind) :
    ∃ n, (run (learnOwn p) n (run (linked p true) m s)).reserve < 0 :=
  solo_fails_on_blind_spot p _ h

/-! ## Concrete numbers -/

/-- Uptake 1, a try costs 1, a lost world costs 3 per turn, revising costs 2,
acquiring an operation costs 2. -/
def terms : Terms := ⟨1, 1, 3, 2, 2⟩

/-- Reserve 10, two errors the learner can find and two it cannot. -/
def start : State := ⟨10, 2, 2, 0⟩

/-- Alone, the learner clears its two own errors and is then stuck with the
two blind ones: after 12 turns its reserve is negative.  With a link to a
different view, after 4 turns all errors are gone and after 12 its reserve
has grown.  One retained false record, and after 5 further honest turns the
reserve is negative. -/
theorem learning_ratchet_witness :
    (run (learnOwn terms) 2 start).own = 0 ∧
    (run (learnOwn terms) 12 start).blind = 2 ∧
    (run (learnOwn terms) 12 start).reserve < 0 ∧
    (run (linked terms true) 4 start).own + (run (linked terms true) 4 start).blind = 0 ∧
    0 < (run (linked terms true) 12 start).reserve ∧
    (run (learnOwn terms) 5 (falseTurn terms 0 start)).reserve < 0 := by
  decide

/-- Reserve 20, no errors the learner can find and four it cannot. -/
def startBlind : State := ⟨20, 0, 4, 0⟩

/-- Told twice and then cut off: two blind errors stay and after 20 further
turns alone the reserve is negative.  Taught once and then cut off: after 4
turns alone no error is left and the reserve grows from then on.  Told four
times with the link intact is cheaper than being taught: it ends with a
larger reserve. -/
theorem told_and_taught_witness :
    (run (linked terms true) 2 startBlind).blind = 2 ∧
    (run (learnOwn terms) 20 (run (linked terms true) 2 startBlind)).reserve < 0 ∧
    (run (learnOwn terms) 4 (acquire terms true startBlind)).own = 0 ∧
    (run (learnOwn terms) 4 (acquire terms true startBlind)).blind = 0 ∧
    0 ≤ (run (learnOwn terms) 4 (acquire terms true startBlind)).reserve ∧
    (run (learnOwn terms) 4 (acquire terms true startBlind)).reserve
      < (run (learnOwn terms) 24 (acquire terms true startBlind)).reserve ∧
    (run (learnOwn terms) 4 (acquire terms true startBlind)).reserve
      < (run (linked terms true) 4 startBlind).reserve := by
  decide

end LearningRatchet
end CumulativeAccessibility
