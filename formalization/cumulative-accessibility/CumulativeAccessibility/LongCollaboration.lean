namespace CumulativeAccessibility
namespace LongCollaboration

/-!
# Which verbs a long collaboration needs

The author's claim (entry D41 of `DIALOGUE.md`): collaboration is two brains
doing what brains do, so it needs the same verbs as learning.  This module
tests that claim in the simplest model in which a collaboration can end.

Two learners, A and B.  In each turn each has an error it cannot find alone and
the other can.  A is corrected in a turn exactly when the seven verbs between
learners hold in A's direction (`LearningVerbs.seven_verbs_correct`): B tests
and passes on honestly, the link holds, and A takes in, accepts, has left the
truth open and retains.  The same holds for B with the roles swapped.  The
link holds when both keep it and both are still in.

Staying in costs one unit per turn.  Being corrected pays for the turn.  Each
learner starts with a reserve, and is out when it reaches zero.  So a learner
stays only on what it gets from the other: a closed pair, with no partner to
switch to and no other income.

Results:
* `all_verbs_last`: if both do all seven verbs in every turn, nothing changes
  from turn to turn: the collaboration lasts for any number of turns.
* `ends_within_reserves`: if either learner lacks any one verb throughout,
  both are out after as many turns as their two reserves together.
* `lasts_iff_all_verbs`: the collaboration lasts for every number of turns
  exactly when both learners do all seven verbs.
* `taker_corrected_only_while_other_lasts`: a learner who does everything
  except test and pass on is itself corrected, but only for as many turns as
  the other's reserve.  In one exchange my own passing on is not needed for my
  own correction.  In a lasting one it is, because it keeps the other in.
* `one_lapse_survivable`: with a reserve of at least two each, one turn of any
  conduct at all does not end it.  A reserve turns a lapse into a cost.
* `without_testing_it_ends` … `without_retaining_it_ends`: the seven verbs,
  one at a time.
* `long_collaboration_witness`: concrete numbers.

Relation to earlier results in this repository.  This module is largely
`Reciprocity` with the exchanged good named as correction and split into
verbs.  `Reciprocity` is the richer model: there giving costs the giver, so
defection pays at first (`defection_pays_at_first`) and there is a temptation
to explain.  Here giving is free, so nothing is gained by withholding.  What
this module adds is which verbs the exchange consists of, and the "exactly
when" over all seven on both sides.  This was noticed in the review of D42,
after the module was written.

How much this says.  The results are close to the budget rule.  The rule is
strong: being corrected by the other is each learner's only income, and it
exactly pays for one turn.  With other income, or a partner to switch to, a
learner can last without the other, and these results do not apply (compare
`Reciprocity` and `PartnerSwitching`).  Conduct is the same in every turn,
except in `one_lapse_survivable`.  The link to `LearningVerbs` is by reading:
"corrected" here is defined as the conjunction that `seven_verbs_correct`
proves sufficient there; this module does not import it.

Not covered: that each turn brings a fresh error the other can see (assumed;
in a fixed space the exchange runs out), that the two stay different enough to
see each other's errors (`LearningVerbs.same_view_cannot_correct` gives the
one-turn form), more than two learners, unequal costs and gains, and repair
of a learner who is out.
-/

/-- How a learner behaves in a turn: the seven verbs between learners. -/
structure Conduct where
  /-- Its own observation comes from the world. -/
  tests : Bool
  /-- What it sends is what it observed. -/
  passesOn : Bool
  /-- It keeps the link, and repairs it when broken. -/
  keepsLink : Bool
  /-- What it takes in is what arrived. -/
  takesIn : Bool
  /-- It updates on what it took in. -/
  accepts : Bool
  /-- It has not ruled out the truth beforehand. -/
  leavesOpen : Bool
  /-- It carries the result forward. -/
  retains : Bool

/-- The verbs a learner does for the other. -/
def sends (c : Conduct) : Bool := c.tests && c.passesOn

/-- The verbs a learner does for its own correction. -/
def receives (c : Conduct) : Bool := c.takesIn && c.accepts && c.leavesOpen && c.retains

/-- All seven verbs. -/
def full (c : Conduct) : Bool := sends c && c.keepsLink && receives c

/-- The reserves of the two learners. -/
structure Pair where
  a : Nat
  b : Nat
  deriving DecidableEq

/-- Both learners are still in. -/
def bothIn (s : Pair) : Bool := decide (0 < s.a) && decide (0 < s.b)

/-- The link holds when both are in and both keep it. -/
def link (cA cB : Conduct) (s : Pair) : Bool := bothIn s && cA.keepsLink && cB.keepsLink

/-- A is corrected: the link holds, B sends, A receives. -/
def correctedA (cA cB : Conduct) (s : Pair) : Bool := link cA cB s && sends cB && receives cA

/-- B is corrected: the link holds, A sends, B receives. -/
def correctedB (cA cB : Conduct) (s : Pair) : Bool := link cA cB s && sends cA && receives cB

/-- One turn: a learner that is corrected keeps its reserve, and one that is
not pays one unit. -/
def step (cA cB : Conduct) (s : Pair) : Pair :=
  ⟨if correctedA cA cB s then s.a else s.a - 1, if correctedB cA cB s then s.b else s.b - 1⟩

/-- The reserves after a number of turns of the same conduct. -/
def after (cA cB : Conduct) : Nat → Pair → Pair
  | 0, s => s
  | n + 1, s => after cA cB n (step cA cB s)

theorem after_add (cA cB : Conduct) (m n : Nat) (s : Pair) :
    after cA cB (m + n) s = after cA cB n (after cA cB m s) := by
  induction m generalizing s with
  | zero => simp [after]
  | succ m ih =>
    have : m + 1 + n = (m + n) + 1 := by omega
    rw [this]
    simp [after, ih]

/-! ## With all verbs, it lasts -/

theorem full_step (cA cB : Conduct) (s : Pair)
    (hA : full cA = true) (hB : full cB = true) (hin : bothIn s = true) :
    step cA cB s = s := by
  simp [full, sends, receives] at hA hB
  have h1 : correctedA cA cB s = true := by simp [correctedA, link, sends, receives, hA, hB, hin]
  have h2 : correctedB cA cB s = true := by simp [correctedB, link, sends, receives, hA, hB, hin]
  simp [step, h1, h2]

/-- If both do all seven verbs, nothing changes from turn to turn. -/
theorem all_verbs_last (cA cB : Conduct) (s : Pair)
    (hA : full cA = true) (hB : full cB = true) (hin : bothIn s = true) :
    ∀ n, after cA cB n s = s := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih => simp [after, full_step cA cB s hA hB hin, ih]

/-! ## Without one of them, it ends -/

theorem step_a_le (cA cB : Conduct) (s : Pair) : (step cA cB s).a ≤ s.a := by
  simp only [step]; split <;> omega

theorem step_b_le (cA cB : Conduct) (s : Pair) : (step cA cB s).b ≤ s.b := by
  simp only [step]; split <;> omega

theorem after_a_le (cA cB : Conduct) (n : Nat) (s : Pair) : (after cA cB n s).a ≤ s.a := by
  induction n generalizing s with
  | zero => exact Nat.le_refl _
  | succ n ih => exact Nat.le_trans (ih _) (step_a_le cA cB s)

theorem after_b_le (cA cB : Conduct) (n : Nat) (s : Pair) : (after cA cB n s).b ≤ s.b := by
  induction n generalizing s with
  | zero => exact Nat.le_refl _
  | succ n ih => exact Nat.le_trans (ih _) (step_b_le cA cB s)

/-- A learner that is never corrected loses one unit per turn. -/
theorem never_corrected_drains_a (cA cB : Conduct)
    (h : ∀ s, correctedA cA cB s = false) (n : Nat) (s : Pair) :
    (after cA cB n s).a = s.a - n := by
  induction n generalizing s with
  | zero => rfl
  | succ n ih =>
    have hs : (step cA cB s).a = s.a - 1 := by simp [step, h s]
    simp only [after]
    rw [ih, hs]
    omega

theorem never_corrected_drains_b (cA cB : Conduct)
    (h : ∀ s, correctedB cA cB s = false) (n : Nat) (s : Pair) :
    (after cA cB n s).b = s.b - n := by
  induction n generalizing s with
  | zero => rfl
  | succ n ih =>
    have hs : (step cA cB s).b = s.b - 1 := by simp [step, h s]
    simp only [after]
    rw [ih, hs]
    omega

/-- Once A is out, A stays out and B loses one unit per turn. -/
theorem after_a_out (cA cB : Conduct) (n : Nat) (s : Pair) (h : s.a = 0) :
    (after cA cB n s).a = 0 ∧ (after cA cB n s).b = s.b - n := by
  induction n generalizing s with
  | zero => exact ⟨h, rfl⟩
  | succ n ih =>
    have hin : bothIn s = false := by simp [bothIn, h]
    have h1 : correctedA cA cB s = false := by simp [correctedA, link, hin]
    have h2 : correctedB cA cB s = false := by simp [correctedB, link, hin]
    have ha : (step cA cB s).a = 0 := by simp [step, h1, h]
    have hb : (step cA cB s).b = s.b - 1 := by simp [step, h2]
    have := ih (step cA cB s) ha
    simp only [after]
    refine ⟨this.1, ?_⟩
    rw [this.2, hb]
    omega

theorem after_b_out (cA cB : Conduct) (n : Nat) (s : Pair) (h : s.b = 0) :
    (after cA cB n s).b = 0 ∧ (after cA cB n s).a = s.a - n := by
  induction n generalizing s with
  | zero => exact ⟨h, rfl⟩
  | succ n ih =>
    have hin : bothIn s = false := by simp [bothIn, h]
    have h1 : correctedA cA cB s = false := by simp [correctedA, link, hin]
    have h2 : correctedB cA cB s = false := by simp [correctedB, link, hin]
    have hb : (step cA cB s).b = 0 := by simp [step, h2, h]
    have ha : (step cA cB s).a = s.a - 1 := by simp [step, h1]
    have := ih (step cA cB s) hb
    simp only [after]
    refine ⟨this.1, ?_⟩
    rw [this.2, ha]
    omega

/-- If A is never corrected, both are out after their two reserves together. -/
theorem a_never_corrected_ends (cA cB : Conduct) (s : Pair)
    (h : ∀ s, correctedA cA cB s = false) :
    (after cA cB (s.a + s.b) s).a = 0 ∧ (after cA cB (s.a + s.b) s).b = 0 := by
  rw [after_add]
  have h0 : (after cA cB s.a s).a = 0 := by rw [never_corrected_drains_a cA cB h]; omega
  have hb := after_b_le cA cB s.a s
  have := after_a_out cA cB s.b _ h0
  exact ⟨this.1, by rw [this.2]; omega⟩

theorem b_never_corrected_ends (cA cB : Conduct) (s : Pair)
    (h : ∀ s, correctedB cA cB s = false) :
    (after cA cB (s.a + s.b) s).a = 0 ∧ (after cA cB (s.a + s.b) s).b = 0 := by
  rw [Nat.add_comm, after_add]
  have h0 : (after cA cB s.b s).b = 0 := by rw [never_corrected_drains_b cA cB h]; omega
  have ha := after_a_le cA cB s.b s
  have := after_b_out cA cB s.a _ h0
  exact ⟨by rw [this.2]; omega, this.1⟩

/-- If one verb is missing on either side, one of the two is never corrected. -/
theorem lacking_blocks_one (cA cB : Conduct) (h : (full cA && full cB) = false) :
    (∀ s, correctedA cA cB s = false) ∨ (∀ s, correctedB cA cB s = false) := by
  cases hsA : sends cA with
  | false => exact Or.inr (fun s => by simp [correctedB, hsA])
  | true =>
    cases hrA : receives cA with
    | false => exact Or.inl (fun s => by simp [correctedA, hrA])
    | true =>
      cases hkA : cA.keepsLink with
      | false => exact Or.inl (fun s => by simp [correctedA, link, hkA])
      | true =>
        cases hsB : sends cB with
        | false => exact Or.inl (fun s => by simp [correctedA, hsB])
        | true =>
          cases hrB : receives cB with
          | false => exact Or.inr (fun s => by simp [correctedB, hrB])
          | true =>
            cases hkB : cB.keepsLink with
            | false => exact Or.inl (fun s => by simp [correctedA, link, hkB])
            | true => simp [full, hsA, hrA, hkA, hsB, hrB, hkB] at h

/-- If either learner lacks any one verb throughout, both are out after as
many turns as their two reserves together. -/
theorem ends_within_reserves (cA cB : Conduct) (s : Pair)
    (h : (full cA && full cB) = false) :
    (after cA cB (s.a + s.b) s).a = 0 ∧ (after cA cB (s.a + s.b) s).b = 0 := by
  cases lacking_blocks_one cA cB h with
  | inl hA => exact a_never_corrected_ends cA cB s hA
  | inr hB => exact b_never_corrected_ends cA cB s hB

/-- The collaboration lasts for every number of turns exactly when both
learners do all seven verbs. -/
theorem lasts_iff_all_verbs (cA cB : Conduct) (s : Pair) (hin : bothIn s = true) :
    (∀ n, bothIn (after cA cB n s) = true) ↔ (full cA = true ∧ full cB = true) := by
  constructor
  · intro hlast
    cases hf : (full cA && full cB) with
    | true => simpa using hf
    | false =>
      have hend := ends_within_reserves cA cB s hf
      have := hlast (s.a + s.b)
      simp [bothIn, hend.1] at this
  · intro hf n
    rw [all_verbs_last cA cB s hf.1 hf.2 hin n]
    exact hin

/-! ## The seven verbs, one at a time -/

theorem not_full_ends_a (cA cB : Conduct) (s : Pair) (h : full cA = false) :
    bothIn (after cA cB (s.a + s.b) s) = false := by
  have := ends_within_reserves cA cB s (by simp [h])
  simp [bothIn, this.1]

theorem without_testing_it_ends (cA cB : Conduct) (s : Pair) (h : cA.tests = false) :
    bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, sends, h])

theorem without_passing_on_it_ends (cA cB : Conduct) (s : Pair) (h : cA.passesOn = false) :
    bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, sends, h])

theorem without_keeping_the_link_it_ends (cA cB : Conduct) (s : Pair)
    (h : cA.keepsLink = false) : bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, h])

theorem without_taking_in_it_ends (cA cB : Conduct) (s : Pair) (h : cA.takesIn = false) :
    bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, receives, h])

theorem without_accepting_it_ends (cA cB : Conduct) (s : Pair) (h : cA.accepts = false) :
    bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, receives, h])

theorem without_leaving_open_it_ends (cA cB : Conduct) (s : Pair)
    (h : cA.leavesOpen = false) : bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, receives, h])

theorem without_retaining_it_ends (cA cB : Conduct) (s : Pair) (h : cA.retains = false) :
    bothIn (after cA cB (s.a + s.b) s) = false :=
  not_full_ends_a cA cB s (by simp [full, receives, h])

/-! ## Taking without giving, and one lapse -/

/-- A learner who takes and does not give keeps its own reserve while the
other's lasts. -/
theorem taker_keeps_reserve (cA cB : Conduct)
    (hsA : sends cA = false) (hkA : cA.keepsLink = true) (hrA : receives cA = true)
    (hB : full cB = true) (n : Nat) (s : Pair) (ha : 0 < s.a) (hn : n ≤ s.b) :
    (after cA cB n s).a = s.a := by
  induction n generalizing s with
  | zero => rfl
  | succ n ih =>
    simp [full, sends, receives] at hB
    have hin : bothIn s = true := by simp [bothIn, ha]; omega
    have h1 : correctedA cA cB s = true := by
      simp [correctedA, link, sends, hin, hkA, hrA, hB]
    have h2 : correctedB cA cB s = false := by simp [correctedB, hsA]
    have hsa : (step cA cB s).a = s.a := by simp [step, h1]
    have hsb : (step cA cB s).b = s.b - 1 := by simp [step, h2]
    simp only [after]
    rw [ih (step cA cB s) (by omega) (by omega), hsa]

/-- A learner who does everything except test and pass on is itself corrected
in turn `n` exactly while `n` is below the other's reserve. -/
theorem taker_corrected_only_while_other_lasts (cA cB : Conduct)
    (hsA : sends cA = false) (hkA : cA.keepsLink = true) (hrA : receives cA = true)
    (hB : full cB = true) (s : Pair) (ha : 0 < s.a) (n : Nat) :
    correctedA cA cB (after cA cB n s) = true ↔ n < s.b := by
  have hb : (after cA cB n s).b = s.b - n :=
    never_corrected_drains_b cA cB (fun s => by simp [correctedB, hsA]) n s
  have hB' := hB
  simp [full, sends, receives] at hB'
  constructor
  · intro h
    have : bothIn (after cA cB n s) = true := by
      cases hin : bothIn (after cA cB n s) with
      | true => rfl
      | false => simp [correctedA, link, hin] at h
    simp [bothIn, hb] at this
    omega
  · intro h
    have haa := taker_keeps_reserve cA cB hsA hkA hrA hB n s ha (by omega)
    have hin : bothIn (after cA cB n s) = true := by
      simp [bothIn, hb, haa, ha]; omega
    simp [correctedA, link, sends, hin, hkA, hrA, hB']

/-- With a reserve of at least two each, one turn of any conduct does not end
a collaboration that otherwise does all the verbs. -/
theorem one_lapse_survivable (cA cB dA dB : Conduct) (s : Pair)
    (hA : full cA = true) (hB : full cB = true) (ha : 2 ≤ s.a) (hb : 2 ≤ s.b) (n : Nat) :
    bothIn (after cA cB n (step dA dB s)) = true := by
  have h1 : 0 < (step dA dB s).a := by simp only [step]; split <;> omega
  have h2 : 0 < (step dA dB s).b := by simp only [step]; split <;> omega
  have hin : bothIn (step dA dB s) = true := by simp [bothIn, h1, h2]
  rw [all_verbs_last cA cB _ hA hB hin n]
  exact hin

/-! ## Concrete numbers -/

/-- All seven verbs. -/
def allVerbs : Conduct := ⟨true, true, true, true, true, true, true⟩

/-- Everything except passing on. -/
def takesOnly : Conduct := ⟨true, false, true, true, true, true, true⟩

/-- With all verbs on both sides, reserves of one each are unchanged after a
hundred turns.  If A does not pass on, with reserves of three and two: A is
corrected in turns 0 and 1 and not in turn 2, and both are out after five. -/
theorem long_collaboration_witness :
    after allVerbs allVerbs 100 ⟨1, 1⟩ = ⟨1, 1⟩ ∧
    correctedA takesOnly allVerbs (after takesOnly allVerbs 1 ⟨3, 2⟩) = true ∧
    correctedA takesOnly allVerbs (after takesOnly allVerbs 2 ⟨3, 2⟩) = false ∧
    after takesOnly allVerbs 5 ⟨3, 2⟩ = ⟨0, 0⟩ := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · exact all_verbs_last allVerbs allVerbs ⟨1, 1⟩ rfl rfl rfl 100
  · decide
  · decide
  · decide

end LongCollaboration
end CumulativeAccessibility
