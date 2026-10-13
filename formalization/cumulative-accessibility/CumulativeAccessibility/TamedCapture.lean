namespace CumulativeAccessibility
namespace TamedCapture

/-!
# Tamed capture: regulation paid from the interest, policing that can fail, and repair

`CommonsVortex` shows that a node inside the window grows by positive feedback,
and that capture, taking more than the interest, runs the commons down.
`CommonsInterest` and `CommonsTakers` add a sanction, and a sanction that is
detected only `k` times in `m`.  In both, the sanction comes from outside: it
costs nothing, it cannot be captured, it never errs, and it does not depend on
the capturer's size.  `CORE.md` lists what this leaves out: detection that can
fail, sanctions that are themselves captured, how a collective sets its rules,
and that capture can be domesticated into a higher-level unit.

This file makes the regulator part of the ledger.  It takes the author's
reading that capture is tamed by **distributed rules and distributed policing**,
and adds repair, as the creed pairs its sins with redemption.

Setting, in whole units per step, without discounting.
* The commons yields an **interest** `I` per step: what can be taken while the
  stock keeps its level (`CommonsInterest.interest`).
* Out of it come the takers' take `take`, the cost of **monitoring** `μ`, and
  the cost of **repair** `ρ`.  Regulation is paid from the same interest as
  everything else.
* Monitoring effort `μ` buys detection: out of `m` defections, `det μ` are
  detected, with `det` rising in `μ`.
* A capturer of size `x` takes a windfall `w * x`: positive feedback makes what
  it can take grow with what it already is.  A sanction is either fixed (`σ`) or
  a share of the capturer's size (`s * x`).
* Policing is spread over `n` monitors, each detecting `d` of the `m`
  defections; a capturer can silence a monitor at a price `β`.
* Policing can err: each round it wrongly accuses `f` members.  Without repair
  an accused member is excluded for good; with repair it returns the next round.

Results:
1. **Regulation must fit in the interest.**  With outflow `take + μ + ρ`, the
   stock never falls if the outflow fits in the interest
   (`regulation_within_interest_lasts`), and is gone within `s0` steps if it
   does not (`costly_regulation_drains_commons`): a regulator that costs more
   than the interest eats the principal it was meant to protect.
2. **Affordable deterrence.**  Some monitoring level within the budget `B`
   deters exactly when spending the whole budget deters
   (`affordable_deterrence_iff`).
3. **Sanctions must scale with the capturer.**  A fixed sanction fails against
   every capturer larger than the deterrence it buys
   (`fixed_sanction_fails_for_large_capturer`).  A sanction that is a share of
   the capturer's size deters at every size exactly when it deters per unit of
   size (`scaled_sanction_iff`).
4. **Distributed policing raises the price of capturing the regulator.**  With
   a margin of `j` monitors, deterrence survives the silencing of any `j` of
   them (`deters_despite_silenced`), so a capturer must buy at least `j + 1`;
   if `j + 1` bribes cost more than the windfall, capturing the regulators does
   not pay (`capturing_regulators_does_not_pay`).  A single regulator with the
   same total capacity falls to one bribe (`central_falls_to_one_capture`).
5. **Policing that errs needs repair.**  With any rate of wrong accusations,
   policing without repair empties the network within `n` rounds
   (`policing_without_repair_empties`); with repair, at most `f` members are
   out at any round (`policing_with_repair_keeps`).  Readmitting a wrongly
   excluded member pays exactly when what it creates over the remaining horizon
   exceeds the repair cost (`repair_pays_iff`).
6. **When tamed capture lasts** (`tamed_capture_lasts`): if take, monitoring
   and repair together fit in the interest, the monitoring deters per unit of
   size, and sanctions scale with size, then the commons never falls, capture
   does not pay at any size, and the network loses no more than the members
   under repair at any round.
7. `tamed_capture_witness`: each part with small numbers.

So taming is not the absence of regulation, nor regulation at any price.  It is
regulation inside the ledger: paid from the interest, scaled to what it
restrains, spread so that no single capture switches it off, and paired with
repair so that its own errors do not consume the network.  Correction that
cannot repair becomes punishment, and punishment with errors empties the
whole.

How much this says: most results are close to arithmetic once the setting is
fixed; the substance is in the setting and in its mapping to real systems.
`costly_regulation_drains_commons`, `fixed_sanction_fails_for_large_capturer`
and `policing_without_repair_empties` carry the argument: each names a way a
regulator meant to tame capture fails by its own structure.  Not covered: how
the collective chooses `μ`, `s` and `ρ` (how it sets its rules); monitors who
respond to one another or to the capturer's offers; detection whose errors
depend on who is accused; repair that is itself abused (the forgiveness
threshold of `CollectiveAlignment` treats when repair is worth trying);
discounting (see `CommonsDiscount`); and the claim that a tamed capturer
becomes part of a higher-level unit, which this file supports but does not
prove.
-/

/-! ## 1. Regulation is paid from the interest -/

/-- The stock of the commons after `t` steps, when an interest `I` comes in and
an outflow `out` (take, monitoring and repair together) goes out each step,
never more than is there. -/
def stock (I out s0 : Nat) : Nat → Nat
  | 0 => s0
  | t + 1 => stock I out s0 t + I - out

/-- **Regulation within the interest lasts.**  If take, monitoring and repair
together fit in the interest, the stock never falls below where it started. -/
theorem regulation_within_interest_lasts {I take μ ρ s0 : Nat}
    (h : take + μ + ρ ≤ I) : ∀ t, s0 ≤ stock I (take + μ + ρ) s0 t := by
  intro t
  induction t with
  | zero => exact Nat.le_refl _
  | succ t ih =>
    show s0 ≤ stock I (take + μ + ρ) s0 t + I - (take + μ + ρ)
    omega

/-- The stock falls by the excess each step while anything is left. -/
theorem stock_le_of_excess {I out s0 : Nat} (hI : I ≤ out) :
    ∀ t, stock I out s0 t ≤ s0 - t * (out - I) := by
  intro t
  induction t with
  | zero => simp [stock]
  | succ t ih =>
    show stock I out s0 t + I - out ≤ s0 - (t + 1) * (out - I)
    rw [Nat.add_mul, Nat.one_mul]
    generalize t * (out - I) = A at ih ⊢
    omega

/-- **Costly regulation drains the commons.**  If take, monitoring and repair
together cost more than the interest, the stock is gone by step `s0` and stays
gone: a regulator that costs more than the interest eats the principal it was
meant to protect. -/
theorem costly_regulation_drains_commons {I take μ ρ s0 : Nat}
    (h : I < take + μ + ρ) : ∀ t, s0 ≤ t → stock I (take + μ + ρ) s0 t = 0 := by
  intro t ht
  have hle := stock_le_of_excess (s0 := s0) (Nat.le_of_lt h) t
  have hd : 1 ≤ take + μ + ρ - I := by omega
  have : s0 ≤ t * (take + μ + ρ - I) := by
    have := Nat.mul_le_mul ht hd
    omega
  omega

/-! ## 2. Deterrence that fits in the budget -/

/-- A function that does not fall as its argument rises. -/
def NonDecreasing (f : Nat → Nat) : Prop := ∀ x y, x ≤ y → f x ≤ f y

/-- **Affordable deterrence.**  When detection rises with monitoring effort,
some monitoring level within the budget `B` makes the sanctions paid over `m`
defections at least the windfalls taken exactly when spending the whole budget
does. -/
theorem affordable_deterrence_iff {det : Nat → Nat} {B m W σ : Nat}
    (hmono : NonDecreasing det) :
    (∃ μ, μ ≤ B ∧ m * W ≤ det μ * σ) ↔ m * W ≤ det B * σ := by
  constructor
  · rintro ⟨μ, hμ, h⟩
    exact Nat.le_trans h (Nat.mul_le_mul_right σ (hmono μ B hμ))
  · intro h
    exact ⟨B, Nat.le_refl B, h⟩

/-! ## 3. Sanctions must scale with the capturer -/

/-- **A fixed sanction fails for a large capturer.**  If a capturer of size
`x` takes a windfall `w * x`, with `w ≥ 1`, then a fixed sanction `σ` with
detection `D` fails to deter, over `m ≥ 1` defections, every capturer larger
than `D * σ`. -/
theorem fixed_sanction_fails_for_large_capturer {m w x D σ : Nat}
    (hm : 0 < m) (hw : 0 < w) (hx : D * σ < x) : D * σ < m * (w * x) := by
  have h1 : x ≤ w * x := Nat.le_mul_of_pos_left x hw
  have h2 : w * x ≤ m * (w * x) := Nat.le_mul_of_pos_left (w * x) hm
  omega

/-- **A scaled sanction deters at every size exactly when it deters per unit.**
If the sanction is a share `s` of the capturer's size, it deters a capturer of
any size `x ≥ 1` exactly when `m * w ≤ D * s`. -/
theorem scaled_sanction_iff {m w x D s : Nat} (hx : 0 < x) :
    m * (w * x) ≤ D * (s * x) ↔ m * w ≤ D * s := by
  rw [← Nat.mul_assoc, ← Nat.mul_assoc]
  exact ⟨fun h => Nat.le_of_mul_le_mul_right h hx, fun h => Nat.mul_le_mul_right x h⟩

/-! ## 4. Distributed policing -/

/-- **Deterrence survives silenced monitors.**  With `n` monitors, each
detecting `d` of `m` defections, and a margin of `j` monitors
(`m * W + j * (d * σ) ≤ n * (d * σ)`), deterrence holds however many monitors
up to `j` are silenced. -/
theorem deters_despite_silenced {n j d m W σ : Nat}
    (hmargin : m * W + j * (d * σ) ≤ n * (d * σ)) :
    ∀ i, i ≤ j → m * W ≤ (n - i) * (d * σ) := by
  intro i hi
  rw [Nat.sub_mul]
  have hij : i * (d * σ) ≤ j * (d * σ) := Nat.mul_le_mul_right _ hi
  generalize i * (d * σ) = A at hij ⊢
  generalize j * (d * σ) = B at hij hmargin
  generalize n * (d * σ) = C at hmargin ⊢
  omega

/-- **Capturing the regulators does not pay.**  If breaking deterrence takes
silencing more than `j` monitors at a price `β` each, and `j + 1` bribes cost
at least the windfall, every capture of the regulators that breaks deterrence
costs at least what it gains. -/
theorem capturing_regulators_does_not_pay {j β W : Nat} (hprice : W ≤ (j + 1) * β) :
    ∀ i, j < i → W ≤ i * β := by
  intro i hi
  exact Nat.le_trans hprice (Nat.mul_le_mul_right β hi)

/-- **A central regulator falls to one capture.**  A single monitor holding the
whole detection capacity `D` deters before it is captured, but once it is
silenced nothing is detected and any positive windfall pays. -/
theorem central_falls_to_one_capture {m W D σ : Nat} (hW : 0 < m * W) :
    ¬ (m * W ≤ (1 - 1) * (D * σ)) := by
  simp only [Nat.sub_self, Nat.zero_mul]
  omega

/-! ## 5. Policing that errs, and repair -/

/-- Members left after `t` rounds when policing wrongly excludes `f` members
each round and no one is readmitted. -/
def membersNoRepair (n f : Nat) : Nat → Nat
  | 0 => n
  | t + 1 => membersNoRepair n f t - f

/-- **Policing without repair empties the network.**  With any rate `f ≥ 1` of
wrong accusations and no repair, `t * f` members are lost after `t` rounds, and
none are left after `n` rounds. -/
theorem policing_without_repair_empties {n f : Nat} (hf : 0 < f) :
    (∀ t, membersNoRepair n f t = n - t * f) ∧ membersNoRepair n f n = 0 := by
  have hall : ∀ t, membersNoRepair n f t = n - t * f := by
    intro t
    induction t with
    | zero => simp [membersNoRepair]
    | succ t ih =>
      show membersNoRepair n f t - f = n - (t + 1) * f
      rw [ih, Nat.add_mul, Nat.one_mul]
      omega
  refine ⟨hall, ?_⟩
  rw [hall n]
  have : n ≤ n * f := Nat.le_mul_of_pos_right n hf
  omega

/-- Members present at round `t` when policing wrongly excludes `f` members
each round and repair readmits the previous round's accused. -/
def membersRepair (n f : Nat) : Nat → Nat
  | 0 => n
  | _ + 1 => n - f

/-- **Policing with repair keeps the network.**  With repair, at most the `f`
members accused this round are out at any round. -/
theorem policing_with_repair_keeps (n f : Nat) : ∀ t, n - f ≤ membersRepair n f t := by
  intro t
  cases t with
  | zero => exact Nat.sub_le n f
  | succ t => exact Nat.le_refl _

/-- **When repair pays.**  Readmitting a wrongly excluded member that creates
`c` per step over the remaining `T` steps, at a repair cost `ρ`, leaves the
whole better off than exclusion exactly when `ρ < c * T`. -/
theorem repair_pays_iff {c T ρ : Nat} : (0 : Int) < (c * T : Nat) - (ρ : Int) ↔ ρ < c * T := by
  omega

/-! ## 6. When tamed capture lasts -/

/-- **When tamed capture lasts.**  Suppose take, monitoring `μ` and repair for
`f` members at `ρ` each fit in the interest, the monitoring deters per unit of
size (`m * w ≤ det μ * s`), and sanctions are a share `s` of the capturer's
size.  Then the commons never falls, capture does not pay against a capturer of
any size, and at most `f` members are out at any round. -/
theorem tamed_capture_lasts {det : Nat → Nat} {I take μ f ρ m w s n s0 : Nat}
    (hfits : take + μ + f * ρ ≤ I) (hdeters : m * w ≤ det μ * s) :
    (∀ t, s0 ≤ stock I (take + μ + f * ρ) s0 t) ∧
      (∀ x, 0 < x → m * (w * x) ≤ det μ * (s * x)) ∧
      (∀ t, n - f ≤ membersRepair n f t) :=
  ⟨regulation_within_interest_lasts hfits,
    fun _ hx => (scaled_sanction_iff hx).mpr hdeters,
    policing_with_repair_keeps n f⟩

/-- A concrete case.
* An interest of 10 covers a take of 6, monitoring of 2 and repair of 2: a
  stock of 5 is still 5 after 6 steps.  Raise monitoring to 4 and the stock is
  gone after 5 steps.
* A fixed sanction of 12 with detection 2 deters a capturer of size 3 over 2
  defections at windfall 2 per unit (12 ≤ 24) but not one of size 7 (28 > 24).
* With 5 monitors each detecting 1, sanction 4, and 2 defections of windfall 4,
  silencing 3 monitors still leaves deterrence (8 ≤ 8).
* With 2 wrong accusations per round, a network of 6 is empty after 3 rounds
  without repair, and keeps 4 members with it. -/
theorem tamed_capture_witness :
    stock 10 (6 + 2 + 2) 5 6 = 5 ∧ stock 10 (6 + 4 + 2) 5 5 = 0 ∧
      2 * (2 * 3) ≤ 2 * 12 ∧ ¬ (2 * (2 * 7) ≤ 2 * 12) ∧
      2 * 4 ≤ (5 - 3) * (1 * 4) ∧
      membersNoRepair 6 2 3 = 0 ∧ membersRepair 6 2 3 = 4 := by
  decide

end TamedCapture
end CumulativeAccessibility
