namespace CumulativeAccessibility
namespace CuriosityValue

/-!
# When does exploring pay? Curiosity in the slack ledger

A learner pays upkeep from a reserve.  Exploring (looking, asking, reading,
experimenting) costs something now.  It pays only through what it changes
later.  This module states, in the simplest form, when an exploration raises
the learner's reserve, following the two research reports in
`research/curiosity/` and entry D12 of `DIALOGUE.md`.

Setting: over `n` periods the learner's net flow is `f` per period (uptake
minus upkeep minus misfit losses).  Without exploring, its reserve after `n`
periods is `B + n·f`.  An exploration costs `K` once.  If it improves the
learner's model, and the improvement is retained, upkeep or misfit falls by
`s` in every later period.  The reserve after `n` periods is then
`B - K + n·(f + s)`.

The premise is `s` itself: that improving the model lowers upkeep or misfit
at all, and by how much.  That a better (for example, more compressed) model
costs less to run is assumed here, not derived; the reports name it as the
link that needs evidence.

Results:
* `exploration_raises_reserve_iff`: an exploration raises the reserve after
  `n` periods exactly when the retained saving over those periods exceeds its
  cost, `n·s > K`.
* `gain_attributable_to_learning`: compared with the same exploration
  without model improvement (same cost, no saving), the whole difference is
  `n·s`.  Only the part caused by improving the model counts, which is why
  food, money or praise are not curiosity's value.
* `no_model_gain_lowers_reserve`: with no retained saving (`s = 0`, as for
  material already mastered, or for irreducible noise), a costly exploration
  lowers the reserve.  A curiosity reward can be earned without any slack.
* `long_enough_horizon_pays`: any positive retained saving pays for any cost
  over a long enough horizon.
* `short_horizon_does_not_pay`: over a horizon with `n·s ≤ K` it does not.
* `pays_but_unaffordable`: an exploration can pay over the horizon and still
  be unaffordable now, when the cost exceeds the reserve.  A positive return
  does not ensure survival until it is repaid.
* `curiosity_value_witness`: concrete numbers for each case.

Not covered: discounting, uncertain savings, savings that fade, several
explorations competing for one reserve, and whether felt curiosity tracks
`n·s - K` at all, which is an empirical question.  These results are close to
arithmetic; they fix what has to be shown for curiosity to be read as the
learning loop valued from the inside.
-/

/-- Reserve after `n` periods without exploring: start `B`, net flow `f`. -/
def reserveWithout (B f : Int) (n : Nat) : Int := B + n * f

/-- Reserve after `n` periods with an exploration that costs `K` once and,
through a retained model improvement, saves `s` in every period. -/
def reserveWith (B f K s : Int) (n : Nat) : Int := B - K + n * (f + s)

/-- An exploration raises the reserve after `n` periods exactly when the
retained saving over those periods exceeds its cost. -/
theorem exploration_raises_reserve_iff (B f K s : Int) (n : Nat) :
    reserveWithout B f n < reserveWith B f K s n ↔ K < n * s := by
  unfold reserveWithout reserveWith
  rw [Int.mul_add]
  generalize (n : Int) * f = a
  generalize (n : Int) * s = b
  omega

/-- Against the same exploration without model improvement (same cost, no
saving), the difference is exactly the retained saving `n·s`. -/
theorem gain_attributable_to_learning (B f K s : Int) (n : Nat) :
    reserveWith B f K s n - reserveWith B f K 0 n = n * s := by
  unfold reserveWith
  rw [Int.add_zero, Int.mul_add]
  generalize (n : Int) * f = a
  generalize (n : Int) * s = b
  omega

/-- With no retained saving (mastered material, or irreducible noise), a
costly exploration lowers the reserve. -/
theorem no_model_gain_lowers_reserve (B f K : Int) (n : Nat) (hK : 0 < K) :
    reserveWith B f K 0 n < reserveWithout B f n := by
  unfold reserveWith reserveWithout
  rw [Int.add_zero]
  omega

/-- Any positive retained saving pays for any cost over a long enough
horizon. -/
theorem long_enough_horizon_pays (K s : Int) (hs : 0 < s) :
    ∃ n : Nat, K < n * s := by
  refine ⟨K.toNat + 1, ?_⟩
  have h1 : (1 : Int) ≤ s := hs
  have hn : (0 : Int) ≤ ((K.toNat + 1 : Nat) : Int) := Int.natCast_nonneg _
  have h2 : ((K.toNat + 1 : Nat) : Int) * 1 ≤ ((K.toNat + 1 : Nat) : Int) * s :=
    Int.mul_le_mul_of_nonneg_left h1 hn
  have h3 : K < ((K.toNat + 1 : Nat) : Int) := by omega
  omega

/-- Over a horizon too short for the saving to repay the cost, exploring
does not raise the reserve. -/
theorem short_horizon_does_not_pay (B f K s : Int) (n : Nat) (h : n * s ≤ K) :
    ¬ reserveWithout B f n < reserveWith B f K s n := by
  rw [exploration_raises_reserve_iff]
  omega

/-- An exploration can pay over the horizon and still be unaffordable now:
its cost exceeds the reserve. -/
theorem pays_but_unaffordable :
    ∃ B f K s : Int, ∃ n : Nat,
      reserveWithout B f n < reserveWith B f K s n ∧ B - K < 0 :=
  ⟨1, 0, 2, 1, 5, by decide, by decide⟩

/-- Concrete numbers: a saving of 1 per period repays a cost of 3 over four
periods but not over two; with no saving the exploration only costs. -/
theorem curiosity_value_witness :
    reserveWithout 10 0 4 < reserveWith 10 0 3 1 4 ∧
    ¬ reserveWithout 10 0 2 < reserveWith 10 0 3 1 2 ∧
    reserveWith 10 0 3 0 4 < reserveWithout 10 0 4 := by
  decide

end CuriosityValue
end CumulativeAccessibility
