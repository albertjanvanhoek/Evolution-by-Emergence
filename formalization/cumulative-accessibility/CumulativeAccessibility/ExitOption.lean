namespace CumulativeAccessibility
namespace ExitOption

/-!
# Agency that works through its possibility

Why do agents with so much freedom behave so predictably?  This module states,
in the simplest form, two reasons discussed in entry D15 of `DIALOGUE.md`.

**An exit that is never used still sets the terms.**  An agent receives `r`
per period from a partner who needs it to stay.  The agent stays as long as
`r` is at least the floor it can count on: its outside option `o` if it can
leave, and in any case the minimum `m` it needs to keep going.  The partner
keeps the rest, so it offers the least that keeps the agent: the floor.  At
that offer the agent stays, so the exit is never used, but the floor is
`max o m` with an exit and only `m` without.  (This is the logic of exit in
Hirschman's *Exit, Voice, and Loyalty*, 1970.)

**Deliberating is costly, so habit is optimal until the world shifts.**
Reconsidering costs `c` once.  If the world has shifted, the habit costs a
misfit `h` per period, which reconsidering removes.  Over `n` periods
reconsidering pays exactly when `n·h > c`; in a world that has not shifted
(`h = 0`) it never pays, and the habit, which is predictable, is optimal.

Results:
* `best_offer_is_floor`: of all offers that keep the agent, the floor leaves
  the partner the most.
* `exit_unused_at_best_offer`: at that offer the agent stays.
* `exit_raises_floor`: a credible exit (`m < o`) raises what the agent
  receives by `o - m`, although it is never used.
* `worthless_exit_adds_nothing`: an exit worth no more than the minimum
  (`o ≤ m`) changes nothing.
* `deliberation_pays_iff`: reconsidering pays exactly when the misfit it
  removes over the horizon exceeds its cost.
* `habit_optimal_without_shift`: with no shift, a costly reconsideration never
  pays.
* `exit_option_witness`: concrete numbers.

Not covered: partners who misjudge the outside option, bargaining over a
surplus rather than a take-it-or-leave-it offer, several partners competing
for the agent, and why an agent experiences a commitment as its own, which
these results do not touch.  They are close to arithmetic; they fix the
point that freedom can shape every outcome while hardly ever being used.
-/

/-- The least the agent will accept to stay: its outside option if it can
leave, and in any case the minimum it needs. -/
def floorWithExit (o m : Int) : Int := max o m

/-- Without an exit, the floor is only the minimum the agent needs. -/
def floorWithoutExit (m : Int) : Int := m

/-- The agent stays when what it receives is at least its floor. -/
def stays (floor r : Int) : Prop := floor ≤ r

/-- What the partner keeps from a surplus `S` after offering `r`. -/
def partnerKeeps (S r : Int) : Int := S - r

/-- Of all offers that keep the agent, offering exactly the floor leaves the
partner the most. -/
theorem best_offer_is_floor (S floor r : Int) (h : stays floor r) :
    partnerKeeps S r ≤ partnerKeeps S floor := by
  unfold partnerKeeps stays at *
  omega

/-- At the partner's best offer, the agent stays: the exit is not used. -/
theorem exit_unused_at_best_offer (o m : Int) :
    stays (floorWithExit o m) (floorWithExit o m) := by
  unfold stays
  omega

/-- A credible exit raises what the agent receives by `o - m`, although it is
never used. -/
theorem exit_raises_floor (o m : Int) (h : m < o) :
    floorWithExit o m - floorWithoutExit m = o - m := by
  unfold floorWithExit floorWithoutExit
  omega

/-- An exit worth no more than the minimum changes nothing. -/
theorem worthless_exit_adds_nothing (o m : Int) (h : o ≤ m) :
    floorWithExit o m = floorWithoutExit m := by
  unfold floorWithExit floorWithoutExit
  omega

/-- Reconsidering, at cost `c` once, removes a misfit of `h` per period.  Over
`n` periods it pays exactly when the misfit removed exceeds the cost. -/
theorem deliberation_pays_iff (c h : Int) (n : Nat) :
    (0 : Int) < n * h - c ↔ c < n * h := by
  omega

/-- If the world has not shifted, there is no misfit to remove, and a costly
reconsideration never pays: the habit is optimal. -/
theorem habit_optimal_without_shift (c : Int) (n : Nat) (hc : 0 < c) :
    ¬ c < n * (0 : Int) := by
  rw [Int.mul_zero]
  omega

/-- Concrete numbers: with an outside option of 5 and a minimum of 2, the
partner offers 5, the agent stays, and the unused exit is worth 3; with an
outside option of 1 it is worth nothing. -/
theorem exit_option_witness :
    floorWithExit 5 2 = 5 ∧ stays (floorWithExit 5 2) 5 ∧
    floorWithExit 5 2 - floorWithoutExit 2 = 3 ∧
    floorWithExit 1 2 = floorWithoutExit 2 := by
  unfold floorWithExit floorWithoutExit stays
  decide

end ExitOption
end CumulativeAccessibility
