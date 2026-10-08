import CumulativeAccessibility.CareTransfer

namespace CumulativeAccessibility
namespace PowerDistribution

open CareTransfer

/-!
# Power and distribution

`NetworkVortexLedger.internallyViable_iff_exists_viable_transfer` says a whole
is viable exactly when *some* transfer lets every part cover its upkeep.  It
does not say which transfer happens, who chooses it, which parts are counted,
or who is held to the rules.  This module makes those four questions explicit,
in the simplest settings.  It is the formal side of section 8 of
`research/health-of-intelligence/HEALTH_OF_THE_COMMONS.md`.

**Distribution.**  Parts `i` have reserves `R i` and, after transfers, a slack
`s i` per step; part `i`'s reserve after `n` steps is `R i + n * s i`.
* `arrangement_lasts_iff_every_part_holds`: an arrangement lasts at every step
  exactly when every part's slack is nonnegative.  The total does not enter.
* `aggregate_does_not_decide_persistence`: two arrangements of two parts with
  the same total slack: one lasts, the other drains a part to failure.  What
  the whole has decides whether a fair arrangement *exists*; how it is shared
  decides whether the arrangement *lasts*.

**Power over transfers.**
* `chooser_decides_who_fails`: whenever two parts together are viable, there is
  a transfer that keeps both, one that breaks the first, and one that breaks the
  second, all leaving the whole unchanged.  Whoever chooses the transfer chooses
  who fails.

**Power over the boundary.**
* `excluding_failing_parts_looks_viable`: counting only the parts that hold
  always gives a nonnegative total, whatever the arrangement.  So whoever sets
  the accounting boundary after seeing the result can make anything look
  viable; the boundary must be fixed in advance and include those who carry
  the costs.

**Power over enforcement.**  With `CommonsTakers.detected_sanction_deters`, a
sanction `σ` deters a taker detected `k` times in `m` when `m * W ≤ k * σ`.
* `deters_all_iff_deters_least_detected`: a uniform sanction deters every taker
  exactly when it deters the one least often detected.  A rule is only as strong
  as its weakest point of enforcement.
* `exempt_taker_not_deterred`: a taker that is never detected is deterred by no
  sanction, however large.  With `CommonsTakers`, one taker who eats the
  principal removes every share: one exemption suffices to undo the rule for all.
  This is the formal core of "no asymmetry without accountability"
  (`PREDICTIONS.md`, D1).

Scope.  These results are close to arithmetic; the substance is in the setting.
They are about persistence, not about what is owed.  A drained part fails, and
by step 2 of `CORE.md` so does whatever depended on it; but a part the whole
does not depend on gets no protection from these theorems.  Which parts have
claims that may not be traded against the whole's gain is a value that has to
be stated separately.  Not covered: power over what counts as evidence, rules
that are themselves captured, several powerful parties, and how power is
gained or lost.
-/

/-- Part `i`'s reserve after `n` steps, with reserve `R i` and slack `s i` per
step after transfers. -/
def partReserve {k : Nat} (R s : Fin k → Int) (i : Fin k) (n : Nat) : Int :=
  R i + (n : Int) * s i

/-- **An arrangement lasts exactly when every part holds.**  From nonnegative
reserves, every part keeps a nonnegative reserve at every step exactly when
every part's slack is nonnegative; the total plays no role. -/
theorem arrangement_lasts_iff_every_part_holds {k : Nat} {R s : Fin k → Int}
    (hR : ∀ i, 0 ≤ R i) :
    (∀ i n, 0 ≤ partReserve R s i n) ↔ ∀ i, 0 ≤ s i := by
  have e : ∀ i n, partReserve R s i n = carerReserve (R i) (s i) 0 0 n := by
    intro i n
    simp [partReserve, carerReserve]
  have h := care_lasts_iff_every_dimension (R := R) (s := s)
    (r := fun _ => 0) (c := fun _ => 0) hR
  simp only [e]
  rw [h]
  constructor
  · intro hc i
    have := hc i
    omega
  · intro hs i
    have := hs i
    omega

/-- **The total does not decide persistence.**  Two parts, each with reserve 2.
Shared as slacks 3 and -1, the total is 2 and the second part is exhausted at
step 3; shared as 1 and 1, the total is the same and both last. -/
theorem aggregate_does_not_decide_persistence :
    let R : Fin 2 → Int := fun _ => 2
    let drained : Fin 2 → Int := fun i => if i.val = 0 then 3 else -1
    let shared : Fin 2 → Int := fun _ => 1
    drained 0 + drained 1 = shared 0 + shared 1 ∧
      partReserve R drained 1 3 < 0 ∧
      ∀ i n, 0 ≤ partReserve R shared i n := by
  refine ⟨by decide, by decide, ?_⟩
  exact (arrangement_lasts_iff_every_part_holds (fun _ => by decide)).2 (fun _ => by decide)

/-- **Whoever chooses the transfer chooses who fails.**  When two parts with
slacks `a` and `b` are viable together, a transfer `t` from the first to the
second can keep both, break the first, or break the second; the whole's slack
`a + b` is the same in every case. -/
theorem chooser_decides_who_fails {a b : Int} (h : 0 ≤ a + b) :
    (∃ t : Int, 0 ≤ a - t ∧ 0 ≤ b + t) ∧
    (∃ t : Int, a - t < 0 ∧ 0 ≤ b + t) ∧
    (∃ t : Int, 0 ≤ a - t ∧ b + t < 0) :=
  ⟨⟨a, by omega, by omega⟩, ⟨a + 1, by omega, by omega⟩, ⟨-(b + 1), by omega, by omega⟩⟩

/-- The total of a list of slacks. -/
def total : List Int → Int
  | [] => 0
  | x :: xs => x + total xs

/-- **Excluding the failing parts always looks viable.**  Counting only the
parts whose slack is nonnegative gives a nonnegative total, for every
arrangement. -/
theorem excluding_failing_parts_looks_viable (l : List Int) :
    0 ≤ total (l.filter (fun x => decide (0 ≤ x))) := by
  induction l with
  | nil => simp [total]
  | cons x xs ih =>
    by_cases hx : 0 ≤ x
    · simp only [List.filter_cons, hx, decide_true, if_true, total]
      omega
    · simp only [List.filter_cons, hx, decide_false]
      exact ih

/-- **A rule is only as strong as its weakest point of enforcement.**  If taker
`j` is the one least often detected, a uniform sanction deters every taker
exactly when it deters `j`. -/
theorem deters_all_iff_deters_least_detected {n m W σ : Nat} {k : Fin n → Nat} {j : Fin n}
    (hj : ∀ i, k j ≤ k i) :
    (∀ i, m * W ≤ k i * σ) ↔ m * W ≤ k j * σ :=
  ⟨fun h => h j, fun h i => Nat.le_trans h (Nat.mul_le_mul_right σ (hj i))⟩

/-- **An exempt taker is deterred by no sanction.**  A taker that is never
detected, taking a positive windfall, is not deterred by any sanction. -/
theorem exempt_taker_not_deterred {m W σ : Nat} (hm : 0 < m) (hW : 0 < W) :
    ¬ m * W ≤ 0 * σ := by
  rw [Nat.zero_mul]
  exact Nat.not_le.mpr (Nat.mul_pos hm hW)

/-- Concrete cases: two parts with slacks 2 and -1 are viable together, and the
transfers 2, 3 and -2 keep both, break the first, and break the second;
counting only `[3, -5]`'s holding part gives 3 although the full total is -2;
and with detection rates 1 and 3 in 4, a windfall of 1 is deterred for both by
a sanction of 4 and for neither by a sanction of 1. -/
theorem power_distribution_witness :
    (0 ≤ (2 : Int) - 2 ∧ 0 ≤ (-1 : Int) + 2) ∧
    ((2 : Int) - 3 < 0 ∧ 0 ≤ (-1 : Int) + 3) ∧
    (0 ≤ (2 : Int) - (-2) ∧ (-1 : Int) + (-2) < 0) ∧
    total [3, -5] < 0 ∧ total ([3, -5].filter (fun x => decide (0 ≤ x))) = 3 ∧
    (4 * 1 ≤ 1 * 4 ∧ 4 * 1 ≤ 3 * 4) ∧ ¬ (4 * 1 ≤ 1 * 1) := by
  decide

end PowerDistribution
end CumulativeAccessibility
