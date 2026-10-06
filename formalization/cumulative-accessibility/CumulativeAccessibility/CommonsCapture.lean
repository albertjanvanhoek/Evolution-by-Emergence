namespace CumulativeAccessibility
namespace CommonsCapture

/-!
# Commons capture: taking more than the commons regenerates undermines the taker

Step 6 of the core says that a part which gains locally while the whole loses
undermines its own ground when it depends on the commons it captures.  The
existing results (`extraction_viable_iff`, `NetworkVortexLedger`) bound what a
host survives, but none lets the damage feed back onto the taker.  This file
does, in the simplest setting where it can.

Setting, in whole units and discrete time:

* A **commons** holds a stock `s`.  Each step it regenerates by `r`.
* A **node** draws its uptake from that commons alone.  It tries to take `e`
  per step, but it cannot take more than is there: it takes
  `min e (s + r)` (`take`), and the stock left is `s + r` minus what was taken
  (`next`).
* The node's **upkeep** is `u` per step, and its **slack** is uptake minus
  upkeep (`slack`), as on the ledger of step 1.
* Others who take a fixed amount from the same commons each step are folded
  into `r`: `r` is what regenerates after them.

**Capture** is taking more than the commons regenerates: `r < e`.

Results:

* `sustainable_take_persists`: taking no more than the commons regenerates,
  with upkeep covered by the take, the node is viable at every step and the
  stock never falls below where it started.
* `capture_pays_while_stock_lasts`: while the stock lasts, capture takes `e`,
  more than the regeneration `r`.  It pays locally.
* `capture_exhausts_commons`: under capture the stock falls by `e - r` a step
  and is gone by step `s0`; from then on the node takes only `r`, and nothing
  is left for anyone else.
* `capture_undermines_own_ground`: if upkeep exceeds what the commons
  regenerates, `r < u ≤ e`, capture is viable at first and fails from step
  `s0` on: the node outlives its gain only while the stock lasts.
* `no_take_lasts_above_regeneration`: if upkeep exceeds what the commons
  regenerates, no rate of taking lasts.  Taking more only buys time.
* `lasts_iff`: a node lasts on a commons exactly when its upkeep fits within
  both what it takes and what the commons regenerates.
* `capture_buys_no_lasting`: taking more than the commons regenerates never
  changes whether the node lasts; it only spends the stock.

What this does not cover: a node that can move on to another commons (capture
then lasts while there is somewhere to move to), a commons whose regeneration
depends on its stock, and correctives that might arrive.  Those remain open,
as `CORE.md` says.
-/

/-- What the node takes in one step from a commons with stock `s` that
regenerates by `r`: it tries to take `e`, but cannot take more than is there. -/
def take (r e s : Nat) : Nat := min e (s + r)

/-- The stock left after one step. -/
def next (r e s : Nat) : Nat := s + r - take r e s

/-- The stock of the commons at step `t`, starting from `s0`. -/
def stock (r e s0 : Nat) : Nat → Nat
  | 0 => s0
  | t + 1 => next r e (stock r e s0 t)

/-- The node's uptake at step `t`. -/
def uptake (r e s0 t : Nat) : Nat := take r e (stock r e s0 t)

/-- The node's slack at step `t`: uptake minus upkeep `u`. -/
def slack (r e u s0 t : Nat) : Int := (uptake r e s0 t : Int) - (u : Int)

/-- Under capture the stock falls by `e - r` each step until it is gone. -/
theorem stock_of_capture {r e s0 : Nat} (h : r < e) (t : Nat) :
    stock r e s0 t = s0 - t * (e - r) := by
  induction t with
  | zero => simp [stock]
  | succ t ih =>
    show next r e (stock r e s0 t) = s0 - (t + 1) * (e - r)
    rw [ih, Nat.succ_mul]
    unfold next take
    generalize t * (e - r) = k
    omega

/-- Taking no more than the commons regenerates, the stock grows by `r - e`
each step. -/
theorem stock_of_sustainable {r e s0 : Nat} (h : e ≤ r) (t : Nat) :
    stock r e s0 t = s0 + t * (r - e) := by
  induction t with
  | zero => simp [stock]
  | succ t ih =>
    show next r e (stock r e s0 t) = s0 + (t + 1) * (r - e)
    rw [ih, Nat.succ_mul]
    unfold next take
    generalize t * (r - e) = k
    omega

/-- Whatever the rate, the node takes at least `min e r` each step. -/
theorem uptake_ge_min (r e s0 t : Nat) : min e r ≤ uptake r e s0 t := by
  unfold uptake take
  omega

/-- Whatever the rate, the node never takes more than `e`. -/
theorem uptake_le (r e s0 t : Nat) : uptake r e s0 t ≤ e := by
  unfold uptake take
  omega

/-- Taking no more than the commons regenerates, with upkeep covered by the
take, the node is viable at every step and the commons never shrinks. -/
theorem sustainable_take_persists {r e u s0 : Nat} (he : e ≤ r) (hu : u ≤ e)
    (t : Nat) : 0 ≤ slack r e u s0 t ∧ s0 ≤ stock r e s0 t := by
  have hmin := uptake_ge_min r e s0 t
  refine ⟨?_, ?_⟩
  · unfold slack
    omega
  · rw [stock_of_sustainable he]
    omega

/-- While the stock lasts, capture takes `e`, more than the commons
regenerates: it pays locally. -/
theorem capture_pays_while_stock_lasts {r e s0 t : Nat} (h : r < e)
    (hlast : (t + 1) * (e - r) ≤ s0) : uptake r e s0 t = e ∧ r < uptake r e s0 t := by
  have hs := stock_of_capture (s0 := s0) h t
  rw [Nat.succ_mul] at hlast
  unfold uptake take
  rw [hs]
  generalize t * (e - r) = k at *
  omega

/-- Under capture the commons is gone by step `s0`, and from then on the node
takes only what regenerates. -/
theorem capture_exhausts_commons {r e s0 t : Nat} (h : r < e) (ht : s0 ≤ t) :
    stock r e s0 t = 0 ∧ uptake r e s0 t = r := by
  have hs := stock_of_capture (s0 := s0) h t
  have hmul : t ≤ t * (e - r) := Nat.le_mul_of_pos_right t (by omega)
  have h0 : stock r e s0 t = 0 := by
    rw [hs]
    omega
  refine ⟨h0, ?_⟩
  unfold uptake take
  rw [h0]
  omega

/-- **Capture undermines its own ground.**  If the node's upkeep exceeds what
its commons regenerates, capture is viable at first (as soon as the stock
covers one step of overtaking) and fails at every step from `s0` on. -/
theorem capture_undermines_own_ground {r e u s0 : Nat} (hru : r < u) (hue : u ≤ e)
    (hfirst : e - r ≤ s0) :
    0 ≤ slack r e u s0 0 ∧ ∀ t, s0 ≤ t → slack r e u s0 t < 0 := by
  have hre : r < e := Nat.lt_of_lt_of_le hru hue
  refine ⟨?_, ?_⟩
  · have hpay := capture_pays_while_stock_lasts (s0 := s0) (t := 0) hre (by omega)
    unfold slack
    omega
  · intro t ht
    have hex := capture_exhausts_commons (s0 := s0) hre ht
    unfold slack
    omega

/-- If upkeep exceeds what the commons regenerates, no rate of taking lasts:
from step `s0` on the node is not viable.  Taking more only buys time. -/
theorem no_take_lasts_above_regeneration {r e u s0 : Nat} (hru : r < u) :
    ∀ t, s0 ≤ t → slack r e u s0 t < 0 := by
  intro t ht
  unfold slack
  by_cases hre : r < e
  · have hex := capture_exhausts_commons (s0 := s0) hre ht
    omega
  · have hle := uptake_le r e s0 t
    omega

/-- A node lasts on a commons exactly when its upkeep fits within both what it
takes and what the commons regenerates. -/
theorem lasts_iff {r e u s0 : Nat} :
    (∀ t, 0 ≤ slack r e u s0 t) ↔ u ≤ e ∧ u ≤ r := by
  constructor
  · intro hall
    refine ⟨?_, ?_⟩
    · have h0 := hall 0
      have hle := uptake_le r e s0 0
      unfold slack at h0
      omega
    · apply Classical.byContradiction
      intro hnot
      have hneg := no_take_lasts_above_regeneration (e := e) (s0 := s0) (Nat.lt_of_not_le hnot) s0 (Nat.le_refl s0)
      have h := hall s0
      omega
  · intro ⟨hue, hur⟩ t
    have hmin := uptake_ge_min r e s0 t
    unfold slack
    omega

/-- Taking more than the commons regenerates never changes whether the node
lasts: it lasts under capture exactly when it would last taking only what
regenerates. -/
theorem capture_buys_no_lasting {r e u s0 : Nat} (h : r < e) :
    (∀ t, 0 ≤ slack r e u s0 t) ↔ (∀ t, 0 ≤ slack r r u s0 t) := by
  rw [lasts_iff, lasts_iff]
  omega

/-- A concrete case: a commons with stock 6 that regenerates 2 a step, and a
node with upkeep 3 that takes 5.  It is viable at step 0 and not at step 6. -/
theorem capture_witness :
    0 ≤ slack 2 5 3 6 0 ∧ slack 2 5 3 6 6 < 0 ∧ stock 2 5 6 6 = 0 := by
  decide

end CommonsCapture
end CumulativeAccessibility
