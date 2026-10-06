import CumulativeAccessibility.CommonsDiscount

namespace CumulativeAccessibility
namespace CommonsTakers

open CommonsDiscount

/-!
# Several takers: the tragedy of the commons, and why rules matter more as the
number of takers grows

`CommonsInterest` and `CommonsDiscount` treat one taker, or the whole as one
taker.  The real tragedy of the commons has many takers: each one gains the
whole of what it takes beyond its share, and bears only its share of the
collapse that follows.

Setting, in whole units per step, with the discounting of `CommonsDiscount`
(factor `p / (p + d)`; `d = 0` is no discounting).
* `n` takers share a commons; living off the interest, each takes its share `i`
  every step, so the whole takes `n * i`.
* One taker **defects**: it eats the principal and takes the windfall `W` alone.
  A depleted commons regenerates nothing, so from then on every taker, the
  defector included, gets no share; each keeps only what it creates itself
  (`c`, which cancels in every comparison).

Results:
* `tragedy_of_the_commons`: the defector weighs `W` against its own share `i`,
  the whole weighs it against `n * i`.  When `i * (p + d) < W * d` and
  `W * d < n * i * (p + d)`, defecting is worth more to the defector at every
  horizon, while for the whole not cheating is worth more from an explicit
  horizon on.
* `share_falls_below_windfall`, `enough_takers_make_defection_pay`: for a fixed
  interest `I = n * i`, any windfall and any discount at all, once there are
  more than `I * (p + d)` takers, defecting pays each one of them.
* `sanction_deters_any_number_of_takers`: a sanction at least as large as the
  windfall makes defecting worth no more than nothing, at every horizon, for
  every discount and every number of takers.
* `detected_sanction_deters`: if defection is detected `k` times out of `m`,
  the sanction must be at least `m / k` times the windfall; then over `m`
  defections the sanctions paid are worth at least the windfalls taken.

So the more takers share a commons, the less each one's own share of the
damage restrains it, and the more the commons depends on rules that bind all
of them: the gain from not cheating that `CommonsInterest` proves for the whole
does not reach the individual unless rules carry it there.  Not covered:
several defectors at once, partial over-taking, takers who respond to one
another, and rules that are themselves captured.  Several of these results are
close to arithmetic; the substance is in the setting.
-/

/-- **The tragedy of the commons.**  If a taker's own share regenerates more
slowly than it discounts, but the whole's interest does not, defecting is worth
more to the defector at every horizon, while for the whole not cheating is
worth more from an explicit horizon on. -/
theorem tragedy_of_the_commons {p d c n i W : Nat}
    (hshare : i * (p + d) < W * d) (hwhole : W * d < n * i * (p + d)) :
    (∀ T, dval p (p + d) (interestStream c i) (T + 1) <
        dval p (p + d) (captureStream c W) (T + 1)) ∧
      (∀ T, n * i * (p + d) * p + W + 1 ≤ T →
        dval p (p + d) (captureStream c W) T < dval p (p + d) (interestStream c (n * i)) T) :=
  ⟨capture_wins_under_steep_discount hshare, not_cheating_wins_under_mild_discount hwhole⟩

/-- Splitting a fixed interest among more takers shrinks each share below what
the windfall is worth to it. -/
theorem share_falls_below_windfall {p d n i I W : Nat} (hsplit : n * i = I)
    (hmany : I * (p + d) < n * (W * d)) : i * (p + d) < W * d := by
  have h : n * (i * (p + d)) < n * (W * d) := by
    have e : n * (i * (p + d)) = I * (p + d) := by rw [← hsplit]; grind
    omega
  exact Nat.lt_of_mul_lt_mul_left h

/-- **Enough takers make defection pay.**  For a fixed interest `I = n * i`, a
windfall `W ≥ 1` and any discount `d ≥ 1`, once there are more than `I * (p + d)`
takers, defecting is worth more to each one of them, at every horizon. -/
theorem enough_takers_make_defection_pay {p d c n i I W : Nat} (hd : 0 < d) (hW : 0 < W)
    (hsplit : n * i = I) (hn : I * (p + d) < n) :
    ∀ T, dval p (p + d) (interestStream c i) (T + 1) <
      dval p (p + d) (captureStream c W) (T + 1) := by
  have hWd : 1 ≤ W * d := Nat.mul_pos hW hd
  have hmany : I * (p + d) < n * (W * d) := by
    have : n ≤ n * (W * d) := Nat.le_mul_of_pos_right _ hWd
    omega
  exact capture_wins_under_steep_discount (share_falls_below_windfall hsplit hmany)

/-- **A sanction deters any number of takers.**  If the sanction is at least the
windfall, defecting is worth no more than nothing, at every horizon, for every
discount, however many takers share the commons. -/
theorem sanction_deters_any_number_of_takers {p q W σ : Nat} (h : W ≤ σ) :
    ∀ T, dval p q (lump W) (T + 1) ≤ dval p q (lump σ) (T + 1) := by
  intro T
  rw [dval_lump, dval_lump]
  exact Nat.mul_le_mul_right _ h

/-- **A sanction that is detected only sometimes.**  If defection is detected
`k` times out of `m` and `m * W ≤ k * σ`, then over `m` defections the sanctions
paid are worth at least the windfalls taken, at every horizon and discount. -/
theorem detected_sanction_deters {p q k m W σ : Nat} (h : m * W ≤ k * σ) :
    ∀ T, m * dval p q (lump W) (T + 1) ≤ k * dval p q (lump σ) (T + 1) := by
  intro T
  rw [dval_lump, dval_lump]
  have := Nat.mul_le_mul_right (q ^ (T + 1)) h
  have e1 : m * (W * q ^ (T + 1)) = m * W * q ^ (T + 1) := by grind
  have e2 : k * (σ * q ^ (T + 1)) = k * σ * q ^ (T + 1) := by grind
  omega

/-- A concrete case.  Ten takers each take a share of 1 of an interest of 10; a
windfall of 20; each step counts 9/10 of the one before.  Over three steps, the
defector's share would have been worth about 2.7 against the windfall's 20, so
defecting pays it; the whole's interest would have been worth about 27, so the
whole loses. -/
theorem commons_takers_witness :
    dval 9 10 (interestStream 0 1) 3 < dval 9 10 (captureStream 0 20) 3 ∧
      dval 9 10 (captureStream 0 20) 3 < dval 9 10 (interestStream 0 10) 3 := by
  decide

end CommonsTakers
end CumulativeAccessibility
