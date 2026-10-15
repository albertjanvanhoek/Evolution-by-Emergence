/-!
# Stacked at-cost tariffs

A formal check of a seed tariff model for a public digital service:

  price of a project = entry fee + platform rate * months + usage rate * GB

with the platform rate set as (cost per FTE) / (projects one FTE can support),
not divided by the current number of projects; fixed costs that no project
causes funded centrally; rates fixed a year ahead with an equalization reserve.

The question: can such services be stacked on each other?

Everything is in whole units (euros, projects, months) and core Lean only.
Each result is a conditional implication under the stated premises. The
research report in `research/transparent-pricing/sources/` refined two of the
readings; the docstrings below say how.
-/

namespace StackedTariffs

/-! ## 1. Breadth: many projects on one layer -/

/-- FTEs needed to support `n` projects when one FTE supports `c`. -/
def ftesNeeded (n c : Nat) : Nat := (n + c - 1) / c

/-- **Capacity pricing recovers the step cost to within one FTE.**
With `n` projects, `c` projects per FTE and an FTE costing `F` per month, the
platform rate `F / c` per project-month brings in `n * F / c`. Multiplying
through by `c`: the revenue `n * F` is at most the cost `c * F * ftes`, and
the shortfall is less than one FTE (`c * F`). This is the only error of
dividing by capacity instead of by the current number of projects. -/
theorem capacity_rate_within_one_fte {n c F : Nat} (hc : 0 < c) (hF : 0 < F) :
    n * F ≤ c * ftesNeeded n c * F ∧ c * ftesNeeded n c * F < n * F + c * F := by
  unfold ftesNeeded
  have hdm := Nat.div_add_mod (n + c - 1) c
  have hmod := Nat.mod_lt (n + c - 1) hc
  generalize (n + c - 1) / c = q at *
  generalize (n + c - 1) % c = r at *
  have h1 : n ≤ c * q := by omega
  have h2 : c * q < n + c := by omega
  constructor
  · exact Nat.mul_le_mul_right F h1
  · have := Nat.mul_lt_mul_of_pos_right h2 hF
    rw [Nat.add_mul] at this
    exact this

/-- **Capacity pricing does not depend on the other projects.** The platform
rate is the same whatever the number of projects. (By definition; stated so
that the contrast with volume pricing below is explicit.) -/
theorem capacity_rate_independent (F c n m : Nat) :
    (fun (_ : Nat) => F / c) n = (fun (_ : Nat) => F / c) m := rfl

/-- **Volume pricing rises when projects leave.** If a fixed cost `F` is split
over the projects actually present, the share per project, `F / n`, is at
least as large with fewer projects. In cross-multiplied form: with `n' ≤ n`
projects left, `F * n' ≤ F * n`, so `F / n ≤ F / n'` as fractions.
Departures raise the price for those who stay. Whether this becomes a "death
spiral" depends on how many more then leave, which this result does not model:
a spiral is a dynamic possibility, not an accounting identity. -/
theorem volume_share_rises_when_projects_leave {F n n' : Nat} (h : n' ≤ n) :
    F * n' ≤ F * n :=
  Nat.mul_le_mul_left F h

/-! ## 2. Depth: services stacked on services

Layer 0 is the bottom (for example hosting). Layer `k + 1` buys from layer `k`.
Each layer has its own cost per period, `own k`, and charges the layer above
exactly its own cost plus what it pays the layer below (at cost, no margin). -/

/-- What the users of the top of an `n`-layer stack pay per period, when every
layer passes on its own cost plus its purchases from below. -/
def topRevenue (own : Nat → Nat) : Nat → Nat
  | 0 => own 0
  | k + 1 => own (k + 1) + topRevenue own k

/-- The total of the layers' own costs. -/
def totalOwn (own : Nat → Nat) : Nat → Nat
  | 0 => own 0
  | k + 1 => totalOwn own k + own (k + 1)

/-- **At-cost stacking conserves cost.** When every layer charges exactly its
own cost plus what it pays below, the users at the top pay exactly the sum of
all layers' own costs: no cost is lost and none is counted twice. This is the
formal content of the model's rule "what grows with a project's use is passed
on one-to-one; everything else is our fixed cost": every cost lands in exactly
one layer's tariff. -/
theorem at_cost_stack_conserves (own : Nat → Nat) :
    ∀ n, topRevenue own n = totalOwn own n := by
  intro n
  induction n with
  | zero => rfl
  | succ k ih => simp [topRevenue, totalOwn, ih, Nat.add_comm]

/-- **A margin at every layer compounds.** If each layer adds a margin of `m`
on everything it charges, a stack of `n + 1` layers each with own cost `a`
charges at least `(1 + m)^n` times what one layer charges. With `m = 0` this is
the at-cost case. (Double marginalization, in its simplest form.) -/
def withMargin (a m : Nat) : Nat → Nat
  | 0 => a * (1 + m)
  | k + 1 => (a + withMargin a m k) * (1 + m)

theorem margin_compounds (a m : Nat) :
    ∀ n, withMargin a m 0 * (1 + m) ^ n ≤ withMargin a m n := by
  intro n
  induction n with
  | zero => simp
  | succ k ih =>
    show withMargin a m 0 * (1 + m) ^ (k + 1) ≤ (a + withMargin a m k) * (1 + m)
    rw [Nat.pow_succ, ← Nat.mul_assoc]
    exact Nat.mul_le_mul_right _ (Nat.le_trans ih (Nat.le_add_left _ _))

/-- **Every interface costs something, so the price grows with depth.** If each
layer has at least `h ≥ 1` of own cost (metering, invoicing, its own reserve,
coordination), a stack of `n + 1` layers costs the top at least `(n + 1) * h`,
which exceeds any bound for large enough `n`. This bounds the depth only if the
value an extra layer adds is itself bounded, which is not modelled here. -/
theorem overhead_accumulates {own : Nat → Nat} {h : Nat} (hmin : ∀ k, h ≤ own k) :
    ∀ n, (n + 1) * h ≤ totalOwn own n := by
  intro n
  induction n with
  | zero => simp [totalOwn, hmin 0]
  | succ k ih =>
    show (k + 2) * h ≤ totalOwn own k + own (k + 1)
    have := hmin (k + 1)
    rw [Nat.add_mul] at ih ⊢
    omega

theorem infinite_stack_unbounded {own : Nat → Nat} {h : Nat} (hh : 0 < h)
    (hmin : ∀ k, h ≤ own k) : ∀ B, ∃ n, B < topRevenue own n := by
  intro B
  refine ⟨B, ?_⟩
  rw [at_cost_stack_conserves]
  have := overhead_accumulates hmin B
  have : B + 1 ≤ (B + 1) * h := Nat.le_mul_of_pos_right _ hh
  omega

/-- **Step errors add up with depth, in the worst case.** If each of `n + 1`
layers can be short by less than one capacity step `s` (one FTE, one server),
the stack as a whole can be short by up to `(n + 1) * s`. Errors that are
independent partly cancel, so a pooled reserve can be smaller; that
probabilistic version is not modelled here. -/
theorem step_errors_add {short : Nat → Nat} {s : Nat} (hshort : ∀ k, short k ≤ s) :
    ∀ n, totalOwn short n ≤ (n + 1) * s := by
  intro n
  induction n with
  | zero => simp [totalOwn, hshort 0]
  | succ k ih =>
    show totalOwn short k + short (k + 1) ≤ (k + 2) * s
    have := hshort (k + 1)
    rw [Nat.add_mul] at ih ⊢
    omega

/-! ## 3. Renewal: "cost-covering without profit" over time -/

/-- Capacity of the service after `t` years, when it starts at `K0`, wears out
`d` per year, and the tariff funds renewal `r` per year. -/
def capacity (K0 d r : Nat) : Nat → Nat
  | 0 => K0
  | t + 1 => capacity K0 d r t + r - d

/-- **A tariff that funds renewal keeps the service.** If the tariff includes at
least the yearly wear (`d ≤ r`), capacity never falls. -/
theorem renewal_keeps_capacity {K0 d r : Nat} (h : d ≤ r) :
    ∀ t, K0 ≤ capacity K0 d r t := by
  intro t
  induction t with
  | zero => exact Nat.le_refl _
  | succ t ih =>
    show K0 ≤ capacity K0 d r t + r - d
    omega

/-- **A tariff that covers running costs but not renewal runs the service
down.** If the yearly renewal funded falls short of wear by at least one unit,
the service has lost at least `t` units after `t` years, and is gone after
`K0` years. Present cost coverage does not prove present self-maintenance. -/
theorem no_renewal_runs_down {K0 d r : Nat} (h : r < d) :
    ∀ t, capacity K0 d r t ≤ K0 - t := by
  intro t
  induction t with
  | zero => simp [capacity]
  | succ t ih =>
    show capacity K0 d r t + r - d ≤ K0 - (t + 1)
    omega

/-! ## 4. Witness: the premises can hold together -/

/-- A concrete case.
* 23 projects, 10 per FTE, FTE cost 9000 per month: 3 FTEs cost 270000
  (times 10), revenue 207000 (times 10): short by 63000 (6300 a month), less than one FTE
  (90000).
* Three layers with own costs 5, 7 and 11 pass on exactly 23.
* A margin of 1 (100%) on each of three layers with own cost 5 gives 70
  against 15 at cost.
* Wear 3 against renewal 2 runs a capacity of 5 to 0 in 5 years. -/
theorem stacked_tariffs_witness :
    ftesNeeded 23 10 = 3 ∧ 10 * ftesNeeded 23 10 * 9000 = 270000 ∧ 23 * 9000 = 207000 ∧
      topRevenue (fun k => [5, 7, 11].getD k 0) 2 = 23 ∧
      withMargin 5 1 2 = 70 ∧ capacity 5 3 2 5 = 0 := by
  decide

end StackedTariffs
