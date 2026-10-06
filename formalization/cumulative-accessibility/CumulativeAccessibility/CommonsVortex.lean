namespace CumulativeAccessibility
namespace CommonsVortex

/-!
# The commons as the vortex of the whole

The vortex of one organization runs on its slack: a kept change that raises
slack funds more trying.  A network has a vortex too, and it runs on the
whole's balance, the **commons**: what all nodes create from the gradient minus
what they cost.  `NetworkVortexLedger` proves the static part: the whole's
budget is the sum of the parts' slack, transfers between parts cancel, and only
creation enlarges the whole.  This file adds the dynamics: how a node lasts and
grows inside the commons, and how the commons keeps itself in balance.

A node **creates** `c` for the whole each step, **takes back** `a` (through
prices, exchange, symbiosis: the return path), and its **upkeep** is `m`.  Its
own slack is `a - m`; what it leaves in the commons is `c - a`.  All quantities
are whole units per step (per unit of the node's size where size appears).

Results:

1. **The window** (`window`, `grows_with_commons_iff`, `window_nonempty_iff`):
   the node lasts and the commons does not lose exactly when `m ≤ a ≤ c`, and
   it grows while the commons does not lose exactly when `m < a ≤ c`.  Such a
   share exists exactly when the node creates more than its upkeep, `m < c`.
   Below the window a node can create a surplus for the whole and still starve
   (`unrewarded_creator_starves`); above it, the node takes back more than it
   creates and the commons loses on its account (`capture_iff`), the only way
   a node whose upkeep exceeds its own creation can last
   (`capture_covers_what_creation_cannot`).  Whether that is capture in the
   sense of `CORE.md`, eating the principal, depends on whether the take also
   exceeds what the commons regenerates (`CommonsInterest`).
2. **The positive loop** (`positive_loop`): a node inside the window that
   reinvests its surplus grows at least geometrically, and so does what it
   leaves in the commons each step.
3. **Saturation** (`no_growth_at_capacity`, `saturation_bounds_growth`): if
   what comes back per unit falls as the node grows and drops to its upkeep at
   some size `K`, the node stops growing there.  Growth levels off instead of
   running on exponentially.
4. **The commons regenerates itself** (`commons_grows_in_window`): a commons
   whose regeneration rises with its stock, and whose nodes take back no more
   than they create, never shrinks, and regenerates more as it holds more.
   This is the vortex at the level of the whole.
5. **Capture turns it backward** (`capture_collapses_commons`,
   `capture_pays_then_fails`): if a node takes back more than it creates plus
   what the commons regenerates, and a depleted commons regenerates nothing,
   the commons is gone by step `s0` and never returns.  The capturer is then
   left with only what it creates itself: capture pays at first and then
   fails, whenever its upkeep exceeds its own creation.

So the network keeps itself in balance through two loops: creators inside the
window are pulled up, and a node that takes more than its own creation plus
what the commons regenerates spends the ground it stands on.  Between the two
lies living off the interest (`CommonsInterest`).

Premises: the return share is fixed per step (part 1, 2) or falls with size
(part 3); regeneration depends only on the stock, rises with it, and is zero
at zero (parts 4 and 5); and others' fixed takes are folded into
regeneration.  Not covered: return paths that change over time, several
interacting capturers, a capturer that moves on to another commons, and
correctives.  `CommonsCapture` treats the case of fixed regeneration.
-/

/-! ## 1. The window -/

/-- The node's own slack: what comes back minus its upkeep. -/
def nodeSlack (a m : Nat) : Int := (a : Int) - (m : Int)

/-- What the node leaves in the commons: what it creates minus what it takes
back. -/
def commonsGain (c a : Nat) : Int := (c : Int) - (a : Int)

/-- The node lasts and the commons does not lose exactly inside the window. -/
theorem window (c a m : Nat) :
    (0 ≤ nodeSlack a m ∧ 0 ≤ commonsGain c a) ↔ m ≤ a ∧ a ≤ c := by
  unfold nodeSlack commonsGain
  omega

/-- The node grows while the commons does not lose exactly when what comes
back exceeds its upkeep and does not exceed what it creates. -/
theorem grows_with_commons_iff (c a m : Nat) :
    (0 < nodeSlack a m ∧ 0 ≤ commonsGain c a) ↔ m < a ∧ a ≤ c := by
  unfold nodeSlack commonsGain
  omega

/-- A share that lets the node grow without capturing exists exactly when it
creates more than its upkeep. -/
theorem window_nonempty_iff (c m : Nat) : (∃ a, m < a ∧ a ≤ c) ↔ m < c := by
  constructor
  · intro ⟨a, h1, h2⟩
    omega
  · intro h
    exact ⟨c, h, Nat.le_refl c⟩

/-- Below the window: a node can create a surplus for the whole and still
starve, when too little comes back to it. -/
theorem unrewarded_creator_starves {c a m : Nat} (ham : a < m) (hmc : m ≤ c) :
    0 < commonsGain c a ∧ nodeSlack a m < 0 := by
  unfold nodeSlack commonsGain
  omega

/-- Above the window: the commons loses exactly when the node takes back more
than it creates. -/
theorem capture_iff (c a : Nat) : commonsGain c a < 0 ↔ c < a := by
  unfold commonsGain
  omega

/-- A node whose upkeep exceeds what it creates can cover that upkeep only by
taking back more than it creates: it lasts this step while the commons loses on
its account. -/
theorem capture_covers_what_creation_cannot {c a m : Nat} (hcm : c < m) (hma : m ≤ a) :
    commonsGain c a < 0 ∧ 0 ≤ nodeSlack a m := by
  unfold nodeSlack commonsGain
  omega

/-! ## 2. The positive loop -/

/-- A node of size `x` gets back `a` and spends `m` per unit of size, and
reinvests its surplus in growth. -/
def grow (a m x : Nat) : Nat := x + (a - m) * x

/-- The node's size over time, from `x0`. -/
def size (a m x0 : Nat) : Nat → Nat
  | 0 => x0
  | t + 1 => grow a m (size a m x0 t)

/-- What the commons holds over time, from `s0`, from this node alone: each
step it gains `c - a` per unit of the node's size. -/
def stockFrom (c a m x0 s0 : Nat) : Nat → Nat
  | 0 => s0
  | t + 1 => stockFrom c a m x0 s0 t + (c - a) * size a m x0 t

theorem size_closed (a m x0 t : Nat) : size a m x0 t = x0 * (1 + (a - m)) ^ t := by
  induction t with
  | zero => simp [size]
  | succ t ih =>
    show grow a m (size a m x0 t) = x0 * (1 + (a - m)) ^ (t + 1)
    rw [ih, Nat.pow_succ, ← Nat.mul_assoc]
    unfold grow
    generalize x0 * (1 + (a - m)) ^ t = y
    rw [Nat.mul_add, Nat.mul_one, Nat.mul_comm (a - m) y]

/-- **The positive loop.**  Strictly inside the window, `m < a < c`, a node
that reinvests its surplus at least doubles every step, and what it leaves in
the commons each step is at least its size, so the commons grows at least as
fast as the node. -/
theorem positive_loop {c a m x0 : Nat} (hma : m < a) (hac : a < c)
    (s0 t : Nat) :
    x0 * 2 ^ t ≤ size a m x0 t ∧
      stockFrom c a m x0 s0 t + x0 * 2 ^ t ≤ stockFrom c a m x0 s0 (t + 1) := by
  have hbase : 2 ≤ 1 + (a - m) := by omega
  have hpow : 2 ^ t ≤ (1 + (a - m)) ^ t := Nat.pow_le_pow_left hbase t
  have hsize : x0 * 2 ^ t ≤ size a m x0 t := by
    rw [size_closed]
    exact Nat.mul_le_mul_left x0 hpow
  refine ⟨hsize, ?_⟩
  show stockFrom c a m x0 s0 t + x0 * 2 ^ t ≤
    stockFrom c a m x0 s0 t + (c - a) * size a m x0 t
  have hgain : size a m x0 t ≤ (c - a) * size a m x0 t :=
    Nat.le_mul_of_pos_left _ (by omega)
  omega

/-! ## 3. Saturation -/

/-- A node whose return per unit, `ret x`, depends on its size. -/
def growS (ret : Nat → Nat) (m x : Nat) : Nat := x + (ret x - m) * x

/-- Its size over time. -/
def sizeS (ret : Nat → Nat) (m x0 : Nat) : Nat → Nat
  | 0 => x0
  | t + 1 => growS ret m (sizeS ret m x0 t)

/-- A function that does not rise. -/
def NonIncreasing (f : Nat → Nat) : Prop := ∀ x y, x ≤ y → f y ≤ f x

/-- At and beyond the size where what comes back per unit has fallen to the
upkeep, the node no longer grows. -/
theorem no_growth_at_capacity {ret : Nat → Nat} {m K : Nat} (hanti : NonIncreasing ret)
    (hK : ret K ≤ m) : ∀ x, K ≤ x → growS ret m x = x := by
  intro x hx
  have h := hanti K x hx
  unfold growS
  have : ret x - m = 0 := by omega
  rw [this, Nat.zero_mul, Nat.add_zero]

/-- **Saturation bounds growth.**  If what comes back per unit falls as the
node grows and drops to its upkeep at size `K`, the node never exceeds
`max x0 (K * (1 + ret 0))`, however long it runs. -/
theorem saturation_bounds_growth {ret : Nat → Nat} {m K x0 : Nat} (hanti : NonIncreasing ret)
    (hK : ret K ≤ m) : ∀ t, sizeS ret m x0 t ≤ max x0 (K * (1 + ret 0)) := by
  intro t
  induction t with
  | zero => exact Nat.le_max_left _ _
  | succ t ih =>
    show growS ret m (sizeS ret m x0 t) ≤ max x0 (K * (1 + ret 0))
    generalize hx : sizeS ret m x0 t = x at ih
    by_cases hKx : K ≤ x
    · rw [no_growth_at_capacity hanti hK x hKx]
      exact ih
    · have hxK : x ≤ K := by omega
      have hr : ret x ≤ ret 0 := hanti 0 x (Nat.zero_le x)
      have h1 : (ret x - m) * x ≤ ret 0 * K :=
        Nat.mul_le_mul (Nat.le_trans (Nat.sub_le _ _) hr) hxK
      have h2 : K * (1 + ret 0) = K + ret 0 * K := by
        rw [Nat.mul_add, Nat.mul_one, Nat.mul_comm K (ret 0)]
      unfold growS
      have h3 : K * (1 + ret 0) ≤ max x0 (K * (1 + ret 0)) := Nat.le_max_right _ _
      omega

/-! ## 4 and 5. The commons regenerates itself, and capture turns it backward -/

/-- A function that does not fall. -/
def NonDecreasing (f : Nat → Nat) : Prop := ∀ x y, x ≤ y → f x ≤ f y

/-- What the node takes back in one step: it wants `a`, but cannot take more
than the stock, its regeneration and what the node itself created. -/
def takeBack (regen : Nat → Nat) (c a s : Nat) : Nat := min a (s + regen s + c)

/-- The commons' stock after one step. -/
def nextStock (regen : Nat → Nat) (c a s : Nat) : Nat :=
  s + regen s + c - takeBack regen c a s

/-- The commons' stock over time, from `s0`. -/
def stock (regen : Nat → Nat) (c a s0 : Nat) : Nat → Nat
  | 0 => s0
  | t + 1 => nextStock regen c a (stock regen c a s0 t)

/-- **The commons regenerates itself.**  If the node takes back no more than it
creates, the stock never falls, and when regeneration rises with the stock, the
commons regenerates at least as much each step as the step before. -/
theorem commons_grows_in_window {regen : Nat → Nat} {c a : Nat} (hmono : NonDecreasing regen)
    (hac : a ≤ c) (s0 t : Nat) :
    stock regen c a s0 t ≤ stock regen c a s0 (t + 1) ∧
      regen (stock regen c a s0 t) ≤ regen (stock regen c a s0 (t + 1)) := by
  have hle : stock regen c a s0 t ≤ stock regen c a s0 (t + 1) := by
    show stock regen c a s0 t ≤ nextStock regen c a (stock regen c a s0 t)
    unfold nextStock takeBack
    omega
  exact ⟨hle, hmono _ _ hle⟩

/-- Under capture the stock falls by at least one each step until it is gone. -/
theorem stock_falls_under_capture {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : c + regen s0 < a) :
    ∀ t, stock regen c a s0 t ≤ s0 - t := by
  intro t
  induction t with
  | zero => simp [stock]
  | succ t ih =>
    show nextStock regen c a (stock regen c a s0 t) ≤ s0 - (t + 1)
    generalize hs : stock regen c a s0 t = s at ih
    have hsle : s ≤ s0 := by omega
    have hr : regen s ≤ regen s0 := hmono s s0 hsle
    unfold nextStock takeBack
    by_cases hs0 : s = 0
    · subst hs0
      rw [h0]
      omega
    · omega

/-- **Capture collapses the commons.**  If a node takes back more than it
creates plus what the commons regenerates at its starting stock, and a
depleted commons regenerates nothing, the commons is gone by step `s0` and
stays gone; from then on the node gets back only what it creates itself. -/
theorem capture_collapses_commons {regen : Nat → Nat} {c a s0 : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : c + regen s0 < a) :
    ∀ t, s0 ≤ t → stock regen c a s0 t = 0 ∧ takeBack regen c a (stock regen c a s0 t) = c := by
  intro t ht
  have hfall := stock_falls_under_capture hmono h0 hdraw t
  have hz : stock regen c a s0 t = 0 := by omega
  refine ⟨hz, ?_⟩
  rw [hz]
  unfold takeBack
  rw [h0]
  have : c ≤ c + regen s0 := Nat.le_add_right c _
  omega

/-- **Capture pays, then fails.**  A capturer whose upkeep `m` exceeds what it
creates itself, but is covered by what it takes, is viable while the commons
lasts (at the start, when the stock covers its take) and not viable from step
`s0` on, once the commons is gone. -/
theorem capture_pays_then_fails {regen : Nat → Nat} {c a m s0 : Nat}
    (hmono : NonDecreasing regen) (h0 : regen 0 = 0) (hdraw : c + regen s0 < a)
    (hcm : c < m) (hma : m ≤ a) (hfirst : a ≤ s0 + regen s0 + c) :
    0 ≤ nodeSlack (takeBack regen c a s0) m ∧
      ∀ t, s0 ≤ t → nodeSlack (takeBack regen c a (stock regen c a s0 t)) m < 0 := by
  refine ⟨?_, ?_⟩
  · unfold nodeSlack takeBack
    omega
  · intro t ht
    have h := (capture_collapses_commons hmono h0 hdraw t ht).2
    rw [h]
    unfold nodeSlack
    omega

/-- A concrete case.  Regeneration is half the stock.  A node that creates 5
and takes back 3 leaves a commons of 4 growing; a node that creates 1 and
takes back 5 empties a commons of 4 in two steps and is then left with 1. -/
theorem commons_vortex_witness :
    stock (fun s => s / 2) 5 3 4 2 = 14 ∧
      stock (fun s => s / 2) 1 5 4 2 = 0 ∧
      takeBack (fun s => s / 2) 1 5 (stock (fun s => s / 2) 1 5 4 2) = 1 ∧
      size 3 1 1 3 = 27 := by
  decide

end CommonsVortex
end CumulativeAccessibility
