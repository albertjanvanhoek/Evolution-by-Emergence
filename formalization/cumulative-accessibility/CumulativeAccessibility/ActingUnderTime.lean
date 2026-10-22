namespace CumulativeAccessibility
namespace ActingUnderTime

/-!
# Acting under time

Entry D35 of `DIALOGUE.md` and `research/cooperative-correction/ACTING_UNDER_TIME.md`.
The author's observation: an intelligence cannot escape the future; it has to
act, and not acting is also an action, so the regress of checking the checks
ends when the next decision has to be made.  This module is the smallest model
in which that can be stated and its limits seen.

Setting.  Two states of the world, `bad` and `good`, with prior weights `pb` and
`pg` (whole numbers, read as counts out of `pb + pg`).  Two actions: intervene
(`I`) or not (`N`), with payoffs `uIb, uIg, uNb, uNg` (integers; costs are
negative).  "Not intervening" is an action like any other: it has payoffs in
both states.  Waiting until the state is known costs `c` per unit of weight.

* `actNow`: the better of the two actions, chosen now, on the prior.
* `informed`: the value if the state were known before choosing, at no cost.
* `voi`: the value of that information, `informed - actNow`.
* `waitValue c`: learn the state, then choose, paying the delay cost.
* `reversibleValue r`: intervene now, and after learning undo it at cost `r` per
  unit of weight where not intervening would have been better.

Results.
1. `information_never_hurts`: `voi ≥ 0`.
2. `waiting_pays_iff`: waiting beats acting now exactly when the value of the
   information exceeds the cost of the delay.  This is the decision boundary.
3. `no_dependence_no_value`: if one action is at least as good in both states,
   the information is worth nothing, and any positive delay cost makes acting
   now strictly better.  When the decision does not depend on the unknown, the
   regress ends at once.
4. `free_reversal_recovers_information`: if intervening can be undone at no
   cost, intervening now and correcting later is worth as much as perfect
   information, without the delay.  `reversal_never_hurts`: a reversible
   intervention is never worse than the same intervention made irreversible.
   Together: reversibility lowers the value of waiting (the irreversibility
   effect of environmental economics, read the other way round).
5. `prevention_hides_the_counterfactual`: if the outcome observed after
   intervening is the same in both states, observing it cannot tell them apart.
   Successful prevention removes the evidence that it was needed.
6. `cheaper_delay_favours_waiting`: lowering the delay cost never makes waiting
   less attractive; a collective that pools evidence and so learns sooner
   shifts the boundary toward investigating.
7. `regress_has_finite_depth`: if each further level of checking-the-checks is
   worth at least one unit less than the level before, and each check costs at
   least one unit, some finite level is not worth its cost.  The regress ends
   by value, not by certainty.
8. `acting_under_time_witness`: an outbreak-shaped example in which waiting
   pays at a low delay cost and not at a high one, a cheaply reversible
   intervention beats both, and prevention hides the counterfactual.

Scope.  The results are close to arithmetic.  Not modelled: more than two
states or actions, partial information, learning that itself takes several
steps, payoffs that are uncertain or contested, and whose payoffs count.  The
payoffs are inputs: the module says when to stop investigating given what is
valued, not what should be valued (D7).
-/

/-- The weighted value of an action with payoffs `ub` in `bad` and `ug` in
`good`. -/
def ev (pb pg : Nat) (ub ug : Int) : Int := (pb : Int) * ub + (pg : Int) * ug

/-- Acting now, on the prior: the better action. -/
def actNow (pb pg : Nat) (uIb uIg uNb uNg : Int) : Int :=
  max (ev pb pg uIb uIg) (ev pb pg uNb uNg)

/-- Knowing the state before choosing, at no cost. -/
def informed (pb pg : Nat) (uIb uIg uNb uNg : Int) : Int :=
  (pb : Int) * max uIb uNb + (pg : Int) * max uIg uNg

/-- The value of perfect information. -/
def voi (pb pg : Nat) (uIb uIg uNb uNg : Int) : Int :=
  informed pb pg uIb uIg uNb uNg - actNow pb pg uIb uIg uNb uNg

/-- Waiting to learn the state, at delay cost `c` per unit of weight. -/
def waitValue (pb pg : Nat) (uIb uIg uNb uNg c : Int) : Int :=
  informed pb pg uIb uIg uNb uNg - ((pb : Int) + pg) * c

/-- Intervening now, and undoing it at cost `r` per unit of weight wherever not
intervening turns out better. -/
def reversibleValue (pb pg : Nat) (uIb uIg uNb uNg r : Int) : Int :=
  (pb : Int) * max uIb (uNb - r) + (pg : Int) * max uIg (uNg - r)

theorem ev_le_informed_I (pb pg : Nat) (uIb uIg uNb uNg : Int) :
    ev pb pg uIb uIg ≤ informed pb pg uIb uIg uNb uNg := by
  unfold ev informed
  have h1 : (pb : Int) * uIb ≤ (pb : Int) * max uIb uNb :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_left _ _) (Int.natCast_nonneg _)
  have h2 : (pg : Int) * uIg ≤ (pg : Int) * max uIg uNg :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_left _ _) (Int.natCast_nonneg _)
  omega

theorem ev_le_informed_N (pb pg : Nat) (uIb uIg uNb uNg : Int) :
    ev pb pg uNb uNg ≤ informed pb pg uIb uIg uNb uNg := by
  unfold ev informed
  have h1 : (pb : Int) * uNb ≤ (pb : Int) * max uIb uNb :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_right _ _) (Int.natCast_nonneg _)
  have h2 : (pg : Int) * uNg ≤ (pg : Int) * max uIg uNg :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_right _ _) (Int.natCast_nonneg _)
  omega

/-- **Information never hurts.** -/
theorem information_never_hurts (pb pg : Nat) (uIb uIg uNb uNg : Int) :
    0 ≤ voi pb pg uIb uIg uNb uNg := by
  unfold voi actNow
  have := ev_le_informed_I pb pg uIb uIg uNb uNg
  have := ev_le_informed_N pb pg uIb uIg uNb uNg
  have : max (ev pb pg uIb uIg) (ev pb pg uNb uNg) ≤ informed pb pg uIb uIg uNb uNg :=
    Int.max_le.mpr ⟨by assumption, by assumption⟩
  omega

/-- **The decision boundary.**  Waiting beats acting now exactly when the value
of the information exceeds the cost of the delay. -/
theorem waiting_pays_iff (pb pg : Nat) (uIb uIg uNb uNg c : Int) :
    actNow pb pg uIb uIg uNb uNg < waitValue pb pg uIb uIg uNb uNg c ↔
      ((pb : Int) + pg) * c < voi pb pg uIb uIg uNb uNg := by
  unfold waitValue voi
  omega

/-- **No dependence, no value.**  If intervening is at least as good as not in
both states, the information is worth nothing. -/
theorem no_dependence_no_value_I (pb pg : Nat) (uIb uIg uNb uNg : Int)
    (hb : uNb ≤ uIb) (hg : uNg ≤ uIg) : voi pb pg uIb uIg uNb uNg = 0 := by
  have h := information_never_hurts pb pg uIb uIg uNb uNg
  unfold voi at *
  have e1 : max uIb uNb = uIb := Int.max_eq_left hb
  have e2 : max uIg uNg = uIg := Int.max_eq_left hg
  have hi : informed pb pg uIb uIg uNb uNg = ev pb pg uIb uIg := by
    unfold informed ev; rw [e1, e2]
  have : ev pb pg uIb uIg ≤ actNow pb pg uIb uIg uNb uNg := Int.le_max_left _ _
  omega

/-- **No dependence, act now.**  When intervening is at least as good in both
states, any positive delay cost makes acting now strictly better than waiting. -/
theorem no_dependence_no_value (pb pg : Nat) (uIb uIg uNb uNg c : Int)
    (hb : uNb ≤ uIb) (hg : uNg ≤ uIg) (hc : 0 < c) (hw : 0 < pb + pg) :
    waitValue pb pg uIb uIg uNb uNg c < actNow pb pg uIb uIg uNb uNg := by
  have h0 := no_dependence_no_value_I pb pg uIb uIg uNb uNg hb hg
  unfold voi at h0
  unfold waitValue
  have hw' : (0 : Int) < (pb : Int) + pg := by omega
  have : 0 < ((pb : Int) + pg) * c := Int.mul_pos hw' hc
  omega

/-- **Free reversal recovers the information, without the delay.** -/
theorem free_reversal_recovers_information (pb pg : Nat) (uIb uIg uNb uNg : Int) :
    reversibleValue pb pg uIb uIg uNb uNg 0 = informed pb pg uIb uIg uNb uNg := by
  unfold reversibleValue informed
  simp

/-- **Reversal never hurts.**  A reversible intervention is never worse than
the same intervention made irreversible. -/
theorem reversal_never_hurts (pb pg : Nat) (uIb uIg uNb uNg r : Int) :
    ev pb pg uIb uIg ≤ reversibleValue pb pg uIb uIg uNb uNg r := by
  unfold ev reversibleValue
  have h1 : (pb : Int) * uIb ≤ (pb : Int) * max uIb (uNb - r) :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_left _ _) (Int.natCast_nonneg _)
  have h2 : (pg : Int) * uIg ≤ (pg : Int) * max uIg (uNg - r) :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_left _ _) (Int.natCast_nonneg _)
  omega

/-- **Prevention hides the counterfactual.**  If the outcome observed after
intervening is the same whether the state was bad or good, observing it cannot
tell the two states apart. -/
theorem prevention_hides_the_counterfactual {Out : Type} (outcomeIfIntervened : Bool → Out)
    (hsame : outcomeIfIntervened true = outcomeIfIntervened false) (o : Out) :
    (outcomeIfIntervened true = o ↔ outcomeIfIntervened false = o) := by
  rw [hsame]

/-- **Cheaper delay favours waiting.**  Lowering the delay cost never lowers the
value of waiting. -/
theorem cheaper_delay_favours_waiting (pb pg : Nat) (uIb uIg uNb uNg c c' : Int)
    (hc : c' ≤ c) :
    waitValue pb pg uIb uIg uNb uNg c ≤ waitValue pb pg uIb uIg uNb uNg c' := by
  unfold waitValue
  have : ((pb : Int) + pg) * c' ≤ ((pb : Int) + pg) * c :=
    Int.mul_le_mul_of_nonneg_left hc (by omega)
  omega

/-- **The regress has finite depth.**  If every further level of checking is
worth at least one unit less than the level before (while it is worth
anything), and each check costs at least one unit, then some level is worth
less than its cost. -/
theorem regress_has_finite_depth (v : Nat → Nat) (cost : Nat) (hcost : 1 ≤ cost)
    (hdec : ∀ n, 0 < v n → v (n + 1) < v n) : ∃ n, v n < cost := by
  apply Classical.byContradiction
  intro h
  have hall : ∀ n, cost ≤ v n := fun n => Nat.le_of_not_lt (fun hlt => h ⟨n, hlt⟩)
  have key : ∀ n, v n + n ≤ v 0 := by
    intro n
    induction n with
    | zero => omega
    | succ n ih =>
      have := hdec n (by have := hall n; omega)
      omega
  have := key (v 0 + 1)
  omega

/-- An outbreak-shaped example, in units of 1, with prior 3 in 10 that the
situation is bad.  Intervening costs 2 in either state; not intervening costs 10
if bad and nothing if good.
* Acting now: intervene, value -20.  Knowing the state: value -6, so the
  information is worth 14.
* Waiting at a delay cost of 1 per unit is worth -16 and beats acting now; at a
  cost of 2 it is worth -26 and does not.
* Intervening now and lifting the measure at cost 1 where it proves unneeded is
  worth -13, better than both.
* After a successful intervention the observed outcome is "no outbreak" either
  way: prevention hides the counterfactual. -/
theorem acting_under_time_witness :
    actNow 3 7 (-2) (-2) (-10) 0 = -20 ∧
    informed 3 7 (-2) (-2) (-10) 0 = -6 ∧
    voi 3 7 (-2) (-2) (-10) 0 = 14 ∧
    waitValue 3 7 (-2) (-2) (-10) 0 1 = -16 ∧
    waitValue 3 7 (-2) (-2) (-10) 0 2 = -26 ∧
    reversibleValue 3 7 (-2) (-2) (-10) 0 1 = -13 ∧
    ((fun _ : Bool => "no outbreak") true = (fun _ : Bool => "no outbreak") false) := by
  decide

end ActingUnderTime
end CumulativeAccessibility
