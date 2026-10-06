import CumulativeAccessibility.CommonsVortex

namespace CumulativeAccessibility
namespace CommonsInterest

open CommonsVortex

/-!
# Living off the interest: what not cheating gains

`CommonsVortex` shows that capture runs a self-regenerating commons down.  This
file makes the counter-argument explicit: what a node, and a collective, gain
by not cheating, and what rules add.

Setting (as in `CommonsVortex`): a commons with stock `s` regenerates
`regen s` per step, rising with the stock; a node creates `c` per step and
tries to take back `a`, never more than is there (`takeBack`).

**Three zones of taking.**  A node's **interest** at stock `s` is
`c + regen s`: its own creation plus what the commons regenerates.
* `a ≤ c`: it adds to the commons (`CommonsVortex.commons_grows_in_window`).
* `c < a ≤ interest`: it **lives off the interest**: it takes more than it
  creates, yet the commons never falls and the take lasts forever
  (`living_off_interest`, `take_more_than_create_and_last`).
* `interest < a`: it **eats the principal**: a windfall, then collapse
  (`CommonsVortex.capture_collapses_commons`).

**1. What the node gains by not cheating.**  A capturer's whole take, beyond
its own creation, is bounded by the principal and what it regenerated on the
way down (`capture_windfall_bounded`).  A node living off the interest takes
the interest every step, forever (`interest_take_total`).  Capture pays at
first (`capture_pays_at_first`), but past a horizon fixed by the stock and the
regeneration, not cheating has gained more in total, even for a node that cares
only about itself (`not_cheating_wins_over_time`).

**2. What the collective gains.**  Specialists cost more than they create on
their own.  On a commons that keeps its level, every specialist can be covered
at every step for as long as the interest covers the whole's upkeep
(`specialists_last_on_interest`).  Once the whole eats the principal, the
commons is gone and the whole is left with its own creation, so at least one
specialist fails at every step from then on, however the take is shared
(`specialists_fail_after_collapse`).  The more a whole is specialized, the more
it depends on not cheating.

**3. What rules add.**  A sanction at least as large as the largest possible
windfall makes capture yield no more than living off the interest at every
horizon, from the first step on (`sanction_makes_capture_unprofitable`).  Rules
turn the long-run gain of not cheating into a gain now.  Detecting the capture
is a correction route, as in SCAP.

Premises: regeneration depends only on the stock, rises with it, and is zero
when the stock is empty (for the collapse results); one aggregate take per step;
a one-time sanction in part 3.  Not covered: detection that can fail, sanctions
that are themselves captured, and how a collective sets its rules.
-/

/-- A node's interest at stock `s`: its own creation plus what the commons
regenerates.  Taking this much keeps the commons level. -/
def interest (regen : Nat → Nat) (c s : Nat) : Nat := c + regen s

/-- What the node has taken in total after `t` steps. -/
def cumTake (regen : Nat → Nat) (c a s0 : Nat) : Nat → Nat
  | 0 => 0
  | t + 1 => cumTake regen c a s0 t + takeBack regen c a (stock regen c a s0 t)

/-- What the commons has regenerated in total after `t` steps. -/
def regenSum (regen : Nat → Nat) (c a s0 : Nat) : Nat → Nat
  | 0 => 0
  | t + 1 => regenSum regen c a s0 t + regen (stock regen c a s0 t)

/-! ## The three zones -/

/-- **Living off the interest.**  A node that takes no more than its interest
at the starting stock never lowers the commons, and takes what it wants at
every step. -/
theorem living_off_interest {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (h : a ≤ interest regen c s0) :
    ∀ t, s0 ≤ stock regen c a s0 t ∧ takeBack regen c a (stock regen c a s0 t) = a ∧
      stock regen c a s0 t ≤ stock regen c a s0 (t + 1) := by
  have key : ∀ s, s0 ≤ s → takeBack regen c a s = a ∧ s ≤ nextStock regen c a s := by
    intro s hs
    have hr := hmono s0 s hs
    unfold interest at h
    unfold nextStock takeBack
    omega
  have hge : ∀ t, s0 ≤ stock regen c a s0 t := by
    intro t
    induction t with
    | zero => exact Nat.le_refl s0
    | succ t ih =>
      show s0 ≤ nextStock regen c a (stock regen c a s0 t)
      exact Nat.le_trans ih (key _ ih).2
  intro t
  exact ⟨hge t, (key _ (hge t)).1, (key _ (hge t)).2⟩

/-- A node can take more than it creates and still last, as long as it lives
off the interest: the window `m ≤ a ≤ c` is not the only way to last. -/
theorem take_more_than_create_and_last {regen : Nat → Nat} {c a m s0 : Nat}
    (hmono : NonDecreasing regen) (h : a ≤ interest regen c s0) (hma : m ≤ a) :
    ∀ t, 0 ≤ nodeSlack (takeBack regen c a (stock regen c a s0 t)) m := by
  intro t
  rw [(living_off_interest hmono h t).2.1]
  unfold nodeSlack
  omega

/-! ## 1. What the node gains by not cheating -/

/-- The ledger of the commons: what has been taken plus what is left equals
what there was, plus everything created and regenerated. -/
theorem cumTake_add_stock (regen : Nat → Nat) (c a s0 : Nat) :
    ∀ t, cumTake regen c a s0 t + stock regen c a s0 t = s0 + c * t + regenSum regen c a s0 t := by
  intro t
  induction t with
  | zero => simp [cumTake, stock, regenSum]
  | succ t ih =>
    show cumTake regen c a s0 t + takeBack regen c a (stock regen c a s0 t) +
        nextStock regen c a (stock regen c a s0 t) =
      s0 + c * (t + 1) + (regenSum regen c a s0 t + regen (stock regen c a s0 t))
    rw [Nat.mul_succ]
    unfold nextStock takeBack
    generalize stock regen c a s0 t = s at ih
    generalize c * t = k at ih
    omega

/-- Under capture, the commons regenerates at most `regen s0` per step, and
nothing once it is empty. -/
theorem regenSum_le_of_capture {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : c + regen s0 < a) :
    ∀ t, regenSum regen c a s0 t ≤ s0 * regen s0 := by
  have hfall := stock_falls_under_capture hmono h0 hdraw
  have early : ∀ t, t ≤ s0 → regenSum regen c a s0 t ≤ t * regen s0 := by
    intro t
    induction t with
    | zero => intro _; simp [regenSum]
    | succ t ih =>
      intro ht
      show regenSum regen c a s0 t + regen (stock regen c a s0 t) ≤ (t + 1) * regen s0
      have h1 := ih (by omega)
      have h2 : regen (stock regen c a s0 t) ≤ regen s0 :=
        hmono _ _ (Nat.le_trans (hfall t) (Nat.sub_le _ _))
      rw [Nat.succ_mul]
      omega
  have late : ∀ k, regenSum regen c a s0 (s0 + k) = regenSum regen c a s0 s0 := by
    intro k
    induction k with
    | zero => rfl
    | succ k ih =>
      show regenSum regen c a s0 (s0 + k) + regen (stock regen c a s0 (s0 + k)) =
        regenSum regen c a s0 s0
      have hz : stock regen c a s0 (s0 + k) = 0 := by
        have := hfall (s0 + k)
        omega
      rw [hz, h0, ih, Nat.add_zero]
  intro t
  by_cases ht : t ≤ s0
  · exact Nat.le_trans (early t ht) (Nat.mul_le_mul_right _ ht)
  · have heq : t = s0 + (t - s0) := by omega
    rw [heq, late]
    have := early s0 (Nat.le_refl s0)
    exact this

/-- **The windfall of capture is bounded.**  Beyond its own creation, a node
that eats the principal can never take more than the stock it started from
plus what the commons regenerated on the way down. -/
theorem capture_windfall_bounded {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : c + regen s0 < a) :
    ∀ t, cumTake regen c a s0 t ≤ s0 + c * t + s0 * regen s0 := by
  intro t
  have h1 := cumTake_add_stock regen c a s0 t
  have h2 := regenSum_le_of_capture hmono h0 hdraw t
  omega

/-- A node living off the interest takes the same amount at every step, forever. -/
theorem interest_take_total {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (h : a ≤ interest regen c s0) :
    ∀ t, cumTake regen c a s0 t = a * t := by
  intro t
  induction t with
  | zero => simp [cumTake]
  | succ t ih =>
    show cumTake regen c a s0 t + takeBack regen c a (stock regen c a s0 t) = a * (t + 1)
    rw [ih, (living_off_interest hmono h t).2.1, Nat.mul_succ]

/-- Capture pays at first: in the first step, a node that eats the principal
takes more than one living off the interest. -/
theorem capture_pays_at_first {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (hdraw : interest regen c s0 < a)
    (hfirst : a ≤ s0 + regen s0 + c) :
    cumTake regen c (interest regen c s0) s0 1 < cumTake regen c a s0 1 := by
  have hI := interest_take_total (a := interest regen c s0) (s0 := s0) hmono (Nat.le_refl _) 1
  rw [hI]
  show interest regen c s0 * 1 < 0 + takeBack regen c a s0
  unfold takeBack
  unfold interest at hdraw ⊢
  omega

/-- **Not cheating wins over time.**  Past the horizon where the regenerated
interest has added up to the principal and the regeneration it can yield,
a node living off the interest has taken at least as much in total as a node
that ate the principal, even counting only for itself. -/
theorem not_cheating_wins_over_time {regen : Nat → Nat} {c a s0 t : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : interest regen c s0 < a)
    (hT : s0 + s0 * regen s0 ≤ t * regen s0) :
    cumTake regen c a s0 t ≤ cumTake regen c (interest regen c s0) s0 t := by
  have hcap := capture_windfall_bounded (t := t) hmono h0 (by unfold interest at hdraw; exact hdraw)
  have hI := interest_take_total (a := interest regen c s0) (s0 := s0) hmono (Nat.le_refl _) t
  rw [hI]
  unfold interest
  rw [Nat.add_mul, Nat.mul_comm (regen s0) t, Nat.mul_comm c t]
  rw [Nat.mul_comm c t] at hcap
  generalize t * regen s0 = A at *
  generalize s0 * regen s0 = B at *
  generalize t * c = C at *
  omega

/-! ## 2. What the collective gains -/

/-- The sum of `f i` for `i < n`. -/
def sumTo (f : Nat → Nat) : Nat → Nat
  | 0 => 0
  | n + 1 => sumTo f n + f n

theorem sumTo_le {f g : Nat → Nat} : ∀ n, (∀ i, i < n → f i ≤ g i) → sumTo f n ≤ sumTo g n := by
  intro n
  induction n with
  | zero => intro _; exact Nat.le_refl 0
  | succ n ih =>
    intro h
    show sumTo f n + f n ≤ sumTo g n + g n
    have h1 := ih (fun i hi => h i (by omega))
    have h2 := h n (by omega)
    omega

theorem sumTo_lt {f g : Nat → Nat} : ∀ n, 0 < n → (∀ i, i < n → f i < g i) →
    sumTo f n < sumTo g n := by
  intro n hn h
  cases n with
  | zero => omega
  | succ n =>
    show sumTo f n + f n < sumTo g n + g n
    have h1 := sumTo_le (f := f) (g := g) n (fun i hi => Nat.le_of_lt (h i (by omega)))
    have h2 := h n (by omega)
    omega

/-- **Specialists last on the interest.**  Nodes `i < n` create `c i` and cost
`m i`.  If the whole takes no more than its interest, and that covers the
whole's upkeep, every specialist can be covered at every step, forever. -/
theorem specialists_last_on_interest {regen : Nat → Nat} {c m : Nat → Nat} {n a s0 : Nat}
    (hmono : NonDecreasing regen) (hsus : a ≤ interest regen (sumTo c n) s0)
    (hcover : sumTo m n ≤ a) :
    ∀ t, sumTo m n ≤ takeBack regen (sumTo c n) a (stock regen (sumTo c n) a s0 t) := by
  intro t
  rw [(living_off_interest hmono hsus t).2.1]
  exact hcover

/-- **Specialists fail after a collapse.**  If every node costs more than it
creates on its own, and the whole eats the principal of a commons that
regenerates nothing when empty, then from step `s0` on, however the take is
shared among the nodes, at least one of them is not covered. -/
theorem specialists_fail_after_collapse {regen : Nat → Nat} {c m x : Nat → Nat} {n a s0 t : Nat}
    (hn : 0 < n) (hspec : ∀ i, i < n → c i < m i)
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : sumTo c n + regen s0 < a)
    (ht : s0 ≤ t)
    (hx : sumTo x n ≤ takeBack regen (sumTo c n) a (stock regen (sumTo c n) a s0 t)) :
    ∃ i, i < n ∧ x i < m i := by
  have hc := (capture_collapses_commons hmono h0 hdraw t ht).2
  rw [hc] at hx
  have hlt := sumTo_lt n hn hspec
  apply Classical.byContradiction
  intro hno
  have hall : ∀ i, i < n → m i ≤ x i :=
    fun i hi => Nat.le_of_not_lt (fun hl => hno ⟨i, hi, hl⟩)
  have := sumTo_le n hall
  omega

/-! ## 3. What rules add -/

/-- **A sanction can make capture unprofitable at every horizon.**  If
capturing incurs a one-time sanction at least as large as the largest possible
windfall, the capturer's net take never exceeds what living off the interest
yields, from the first step on. -/
theorem sanction_makes_capture_unprofitable {regen : Nat → Nat} {c a s0 σ : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : interest regen c s0 < a)
    (hσ : s0 + s0 * regen s0 ≤ σ) :
    ∀ t, (cumTake regen c a s0 t : Int) - (σ : Int) ≤
      (cumTake regen c (interest regen c s0) s0 t : Int) := by
  intro t
  have hcap := capture_windfall_bounded (t := t) hmono h0 (by unfold interest at hdraw; exact hdraw)
  have hI := interest_take_total (a := interest regen c s0) (s0 := s0) hmono (Nat.le_refl _) t
  rw [hI]
  unfold interest
  rw [Nat.add_mul]
  generalize c * t = C at *
  generalize s0 * regen s0 = B at *
  generalize regen s0 * t = A
  omega

/-- A concrete case.  A commons of 4 regenerates half its stock; the node
creates 1, so its interest is 3.  A node that takes 5 is ahead after 2 steps
(9 against 6) and behind after 6 (13 against 18).  And taking 2 while creating
1 from a commons of 2 lasts: the stock is still 2 after 5 steps. -/
theorem commons_interest_witness :
    cumTake (fun s => s / 2) 1 5 4 2 = 9 ∧ cumTake (fun s => s / 2) 1 3 4 2 = 6 ∧
      cumTake (fun s => s / 2) 1 5 4 6 = 13 ∧ cumTake (fun s => s / 2) 1 3 4 6 = 18 ∧
      stock (fun s => s / 2) 1 2 2 5 = 2 := by
  decide

end CommonsInterest
end CumulativeAccessibility
