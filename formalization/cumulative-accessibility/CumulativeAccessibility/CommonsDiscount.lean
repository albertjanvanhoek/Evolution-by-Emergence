namespace CumulativeAccessibility
namespace CommonsDiscount

/-!
# Discounting: when eating the principal pays the taker

`CommonsInterest.not_cheating_wins_over_time` compares undiscounted totals: a
gain later counts as much as a gain now.  A taker that values the present more
than the future can reach the opposite verdict.  This file finds the dividing
line, which resource economics has long known (Gordon, Schaefer, Clark): it is
the discount rate against the regeneration rate.

Setting, in whole units per step.
* **Discounting.** A gain `t` steps from now is worth `δ^t` of a gain now, with
  `δ = p / (p + d)`.  `d = 0` is no discounting; the per-step discount rate is
  `1 - δ = d / (p + d)`.  To stay in whole numbers, `dval` is the discounted
  value up to horizon `T` multiplied by `(p + d)^T`.
* **The two streams.**  A taker creates `c` per step either way.
  - *Capture* eats the principal: a windfall `W` now, and afterwards only what
    it creates, because a depleted commons regenerates nothing
    (`CommonsInterest.capture_windfall_bounded` bounds `W`).
  - *Living off the interest* takes `c + r` every step, where `r` is what the
    commons regenerates at its level (`CommonsInterest.living_off_interest`).

  Taking the whole windfall at once is the case most favourable to capture.

Results:
* `capture_wins_under_steep_discount`: if `r * (p + d) < W * d`, that is
  `r / W < 1 - δ`, the commons regenerates more slowly than the taker
  discounts, and capture is worth more at every horizon.
* `not_cheating_wins_under_mild_discount`: if `W * d < r * (p + d)`, not
  cheating is worth more from an explicit horizon on.  With `d = 0` (no
  discounting) this is the undiscounted result again.
* `commons_discount_witness`: both cases with small numbers.

So "not cheating wins, even for the node alone" holds exactly for takers whose
discount rate is below the rate at which the commons regenerates.  For a
taker that discounts steeply, not cheating has to be made to pay now: by rules
and sanctions (`CommonsInterest.sanction_makes_capture_unprofitable`), or by
a horizon that its dependence on others lengthens.  Not covered: several
takers, a capture spread over time, and a discount that changes.
-/

/-- The discounted value of a stream `x` up to horizon `T`, with discount factor
`p / q`, multiplied by `q ^ T`.  Step `t` contributes `x t * p ^ t * q ^ (T - t)`. -/
def dval (p q : Nat) (x : Nat → Nat) : Nat → Nat
  | 0 => 0
  | T + 1 => q * dval p q x T + x T * p ^ T * q

/-- Capture: its own creation `c` every step, plus a windfall `W` now. -/
def captureStream (c W : Nat) : Nat → Nat := fun t => c + if t = 0 then W else 0

/-- Living off the interest: its own creation `c` plus the regeneration `r`. -/
def interestStream (c r : Nat) : Nat → Nat := fun _ => c + r

/-- A one-time amount now. -/
def lump (W : Nat) : Nat → Nat := fun t => if t = 0 then W else 0

/-- The same amount every step. -/
def steady (r : Nat) : Nat → Nat := fun _ => r

theorem dval_add (p q : Nat) (x y : Nat → Nat) :
    ∀ T, dval p q (fun t => x t + y t) T = dval p q x T + dval p q y T := by
  intro T
  induction T with
  | zero => rfl
  | succ T ih =>
    show q * dval p q (fun t => x t + y t) T + (x T + y T) * p ^ T * q =
      (q * dval p q x T + x T * p ^ T * q) + (q * dval p q y T + y T * p ^ T * q)
    rw [ih]
    grind

theorem dval_lump (p q W : Nat) : ∀ T, dval p q (lump W) (T + 1) = W * q ^ (T + 1) := by
  intro T
  induction T with
  | zero => show q * 0 + (if (0 : Nat) = 0 then W else 0) * p ^ 0 * q = W * q ^ 1; simp
  | succ T ih =>
    show q * dval p q (lump W) (T + 1) + (if T + 1 = 0 then W else 0) * p ^ (T + 1) * q =
      W * q ^ (T + 2)
    rw [ih]
    simp only [Nat.add_one_ne_zero, if_false, Nat.zero_mul, Nat.add_zero, Nat.pow_succ]
    grind

/-- The geometric sum, without subtraction: `(q - p) * dval = r * q * (q^T - p^T)`. -/
theorem dval_steady_geom (p q r : Nat) :
    ∀ T, p * dval p q (steady r) T + r * q * q ^ T = q * dval p q (steady r) T + r * q * p ^ T := by
  intro T
  induction T with
  | zero => show p * 0 + r * q * q ^ 0 = q * 0 + r * q * p ^ 0; simp
  | succ T ih =>
    show p * (q * dval p q (steady r) T + r * p ^ T * q) + r * q * q ^ (T + 1) =
      q * (q * dval p q (steady r) T + r * p ^ T * q) + r * q * p ^ (T + 1)
    generalize dval p q (steady r) T = D at ih ⊢
    grind

/-- Bernoulli's inequality, multiplied out: `p * (p + d)^T ≥ p^T * (p + T * d)`. -/
theorem bernoulli_ineq (p d : Nat) : ∀ T, p ^ T * (p + T * d) ≤ p * (p + d) ^ T := by
  intro T
  induction T with
  | zero => simp
  | succ T ih =>
    have h1 : p ^ (T + 1) * (p + (T + 1) * d) ≤ (p + d) * (p ^ T * (p + T * d)) := by
      have e1 : p ^ (T + 1) * (p + (T + 1) * d) = p ^ T * (p * (p + T * d) + p * d) := by
        rw [Nat.pow_succ]; grind
      have e2 : (p + d) * (p ^ T * (p + T * d)) =
          p ^ T * (p * (p + T * d) + p * d + T * (d * d)) := by grind
      rw [e1, e2]
      exact Nat.mul_le_mul_left _ (Nat.le_add_right _ _)
    have h2 : (p + d) * (p ^ T * (p + T * d)) ≤ (p + d) * (p * (p + d) ^ T) :=
      Nat.mul_le_mul_left _ ih
    have e3 : (p + d) * (p * (p + d) ^ T) = p * (p + d) ^ (T + 1) := by
      rw [Nat.pow_succ]; grind
    omega

/-- The two streams differ only by the windfall against the regeneration. -/
theorem dval_streams (p q c W r : Nat) (T : Nat) :
    dval p q (captureStream c W) T = dval p q (steady c) T + dval p q (lump W) T ∧
      dval p q (interestStream c r) T = dval p q (steady c) T + dval p q (steady r) T :=
  ⟨dval_add p q (steady c) (lump W) T, dval_add p q (steady c) (steady r) T⟩

/-- **Capture wins under a steep discount.**  If the commons regenerates more
slowly than the taker discounts (`r / W < d / (p + d)`), capture is worth more
than living off the interest at every horizon. -/
theorem capture_wins_under_steep_discount {p d c W r : Nat}
    (hsteep : r * (p + d) < W * d) :
    ∀ T, dval p (p + d) (interestStream c r) (T + 1) <
      dval p (p + d) (captureStream c W) (T + 1) := by
  intro T
  have hpd : 0 < p + d := by
    rcases Nat.eq_zero_or_pos (p + d) with h | h
    · have hd : d = 0 := by omega
      subst hd
      simp at hsteep
    · exact h
  have hQ : 0 < (p + d) ^ (T + 1) := Nat.pow_pos hpd
  obtain ⟨hc, hi⟩ := dval_streams p (p + d) c W r (T + 1)
  rw [hc, hi, dval_lump]
  have hgeom := dval_steady_geom p (p + d) r (T + 1)
  generalize dval p (p + d) (steady r) (T + 1) = D at hgeom ⊢
  generalize (p + d) ^ (T + 1) = Q at hgeom hQ ⊢
  generalize p ^ (T + 1) = P at hgeom
  -- `d * D = r * (p + d) * (Q - P) ≤ r * (p + d) * Q < W * d * Q`
  have hdD : d * D + r * (p + d) * P = r * (p + d) * Q := by grind
  have hlt : d * D < d * (W * Q) := by
    have h1 : r * (p + d) * Q < W * d * Q := Nat.mul_lt_mul_of_pos_right hsteep hQ
    have h2 : d * (W * Q) = W * d * Q := by grind
    omega
  have hD : D < W * Q := Nat.lt_of_mul_lt_mul_left hlt
  omega

/-- Without discounting (`d = 0`), the steady stream is worth `T * r` units. -/
theorem dval_steady_flat (p r : Nat) : ∀ T, dval p p (steady r) T = T * r * p ^ T := by
  intro T
  induction T with
  | zero => show (0 : Nat) = 0 * r * p ^ 0; simp
  | succ T ih =>
    show p * dval p p (steady r) T + r * p ^ T * p = (T + 1) * r * p ^ (T + 1)
    rw [ih, Nat.pow_succ]
    grind

/-- Under a mild discount, a steady `r` overtakes a windfall `W` from an explicit
horizon on. -/
theorem lump_lt_steady_of_mild {p d W r : Nat} (hmild : W * d < r * (p + d)) :
    ∀ T, r * (p + d) * p + W + 1 ≤ T → dval p (p + d) (lump W) T < dval p (p + d) (steady r) T := by
  intro T hT
  obtain ⟨T', rfl⟩ : ∃ T', T = T' + 1 := ⟨T - 1, by omega⟩
  rw [dval_lump]
  rcases Nat.eq_zero_or_pos d with hd | hd
  · -- no discounting: `W < (T' + 1) * r`
    subst hd
    simp only [Nat.mul_zero, Nat.add_zero] at hmild hT ⊢
    rw [dval_steady_flat]
    have hp : 0 < p := Nat.pos_of_ne_zero (fun h => by subst h; simp at hmild)
    have hr : 0 < r := Nat.pos_of_ne_zero (fun h => by subst h; simp at hmild)
    have hP : 0 < p ^ (T' + 1) := Nat.pow_pos hp
    have hTr : T' + 1 ≤ (T' + 1) * r := Nat.le_mul_of_pos_right _ hr
    have hW : W < (T' + 1) * r := by omega
    exact Nat.mul_lt_mul_of_pos_right hW hP
  · -- discounting: compare through the geometric sum and Bernoulli
    obtain ⟨k, hk⟩ := Nat.exists_eq_add_of_lt hmild
    have hgeom := dval_steady_geom p (p + d) r (T' + 1)
    have hQ : 0 < (p + d) ^ (T' + 1) := Nat.pow_pos (by omega)
    have key : r * (p + d) * p ^ (T' + 1) < (k + 1) * (p + d) ^ (T' + 1) := by
      rcases Nat.eq_zero_or_pos p with hp | hp
      · subst hp
        simp only [Nat.zero_pow (Nat.succ_pos T'), Nat.mul_zero]
        exact Nat.mul_pos (Nat.succ_pos k) hQ
      · have hb := bernoulli_ineq p d (T' + 1)
        have hP : 0 < p ^ (T' + 1) := Nat.pow_pos hp
        have hTd : T' + 1 ≤ (T' + 1) * d := Nat.le_mul_of_pos_right _ hd
        have hgt : r * (p + d) * p < p + (T' + 1) * d := by omega
        have h1 : p ^ (T' + 1) * (r * (p + d) * p) < p ^ (T' + 1) * (p + (T' + 1) * d) :=
          Nat.mul_lt_mul_of_pos_left hgt hP
        have h2 : p * (r * (p + d) * p ^ (T' + 1)) < p * (p + d) ^ (T' + 1) := by
          have e : p * (r * (p + d) * p ^ (T' + 1)) = p ^ (T' + 1) * (r * (p + d) * p) := by
            grind
          omega
        have h3 : r * (p + d) * p ^ (T' + 1) < (p + d) ^ (T' + 1) :=
          Nat.lt_of_mul_lt_mul_left h2
        have h4 : (p + d) ^ (T' + 1) ≤ (k + 1) * (p + d) ^ (T' + 1) :=
          Nat.le_mul_of_pos_left _ (Nat.succ_pos k)
        omega
    generalize dval p (p + d) (steady r) (T' + 1) = D at hgeom ⊢
    generalize (p + d) ^ (T' + 1) = Q at hgeom key ⊢
    generalize p ^ (T' + 1) = P at hgeom key
    have e1 : d * D + r * (p + d) * P = r * (p + d) * Q := by grind
    have e2 : r * (p + d) * Q = d * (W * Q) + (k + 1) * Q := by rw [hk]; grind
    have hlt : d * (W * Q) < d * D := by omega
    exact Nat.lt_of_mul_lt_mul_left hlt

/-- **Not cheating wins under a mild discount.**  If the commons regenerates
faster than the taker discounts (`W / r < (p + d) / d`), living off the interest
is worth more than capture from an explicit horizon on (a bound, not the
crossing point).  With `d = 0` there is no discounting, and this is the
undiscounted result again. -/
theorem not_cheating_wins_under_mild_discount {p d c W r : Nat}
    (hmild : W * d < r * (p + d)) :
    ∀ T, r * (p + d) * p + W + 1 ≤ T →
      dval p (p + d) (captureStream c W) T < dval p (p + d) (interestStream c r) T := by
  intro T hT
  obtain ⟨hc, hi⟩ := dval_streams p (p + d) c W r T
  rw [hc, hi]
  have := lump_lt_steady_of_mild hmild T hT
  omega

/-- Concrete cases.  A windfall of 10 against a regeneration of 2 per step.
Discounting by half each step (`p = d = 1`), capture is worth 10 and the
interest 3 at horizon 2 (scaled: 40 against 12), and the interest never
catches up.  Discounting by a tenth (`p = 9, d = 1`), the interest overtakes
capture at horizon 8 and is worth about 13 against 10 at horizon 10.  The
horizon in `not_cheating_wins_under_mild_discount` is a bound, not the
crossing point. -/
theorem commons_discount_witness :
    dval 1 2 (interestStream 0 2) 2 < dval 1 2 (captureStream 0 10) 2 ∧
      dval 9 10 (captureStream 0 10) 10 < dval 9 10 (interestStream 0 2) 10 := by
  decide

end CommonsDiscount
end CumulativeAccessibility
