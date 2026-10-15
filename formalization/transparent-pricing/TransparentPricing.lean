/-!
# A transparent pricing protocol for autonomous, interdependent providers

No central planner. Each provider in a supply network:
* decides its own margin (autonomy);
* buys inputs from other providers at their published prices (interdependence);
* publishes its own cost, its margin, and its inputs, in one shared format
  (transparency).

Its price is then `own cost + own margin + the published prices of its inputs`.
Each provider needs only its own figures and its direct suppliers' published
prices: local information.

What this file proves, each as a conditional implication:
1. **Traceability.** The final price is exactly the sum of all costs plus all
   margins in the network. Every unit above cost is a published decision by a
   named provider.
2. **Absolute margins do not compound; percentage margins do.** So the shared
   format should state margins as amounts per unit.
3. **Restricting supply has an exact cost, for any demand.** A margin never
   serves more, serves strictly fewer when anyone values the good between its
   cost and the price, and destroys exactly the value of the units it
   excludes. Under linear demand this has closed forms: the loss is `m^2 / 2`,
   and a seller maximising its own take serves half of those served at cost.
4. **A separate bounty beats a margin, for any demand.** The same reward paid
   separately, with the price at cost, serves at least as many and creates
   exactly the excluded value more.
5. **Hidden margins are deterred exactly when detection times what is lost
   outweighs the gain.** Transparency works only with some checking.
6. **Scarcity is handled by a declared charge routed into capacity.** A
   clearing charge always exists; it puts scarce units where they create the
   most value (a queue can waste them); routed into capacity it removes the
   shortage in finite time and then falls to zero; kept as margin, the shortage
   is permanent.
7. **Every other job of profit has a declared home.** Risk: a bounty that covers
   failed attempts keeps a risk fund whole. Cutting cost: shared savings reward
   it where cost-plus does not. Entry: open entry never raises the best price,
   and a cheaper entrant lowers it. Surplus: refunds in proportion to use make
   everyone pay exactly cost. Every unit above cost sits in a named field.
8. **The bounty can be sized with discipline.** A fixed pool shared by impact
   never overspends, pays more for more impact, and makes claims compete; a cap
   bounds every bounty; scarce tokens make demand signals costly; matching
   rewards many backers over one; payment in parts limits what a failed promise
   costs.

Not proved here: that providers adopt the format; that published costs are
true (only when lying stops paying); that sellers who see each other's prices
do not collude; who funds a bounty, and how without free-riding; demand that is
not linear.

Core Lean only (no Mathlib).
-/

namespace TransparentPricing

/-! ## 1. A supply network, and traceability -/

/-- A provider: its own cost per unit, its own margin per unit, and the
providers it buys one unit of input from. Inputs may themselves have inputs,
to any depth. -/
inductive Provider where
  | mk : (cost margin : Nat) → (inputs : List Provider) → Provider

mutual
/-- Published price: own cost + own margin + published prices of inputs. -/
def price : Provider → Nat
  | .mk c m ins => c + m + priceList ins
def priceList : List Provider → Nat
  | [] => 0
  | p :: ps => price p + priceList ps
end

mutual
/-- All costs in the network behind a provider. -/
def totalCost : Provider → Nat
  | .mk c _ ins => c + costList ins
def costList : List Provider → Nat
  | [] => 0
  | p :: ps => totalCost p + costList ps
end

mutual
/-- All margins in the network behind a provider. -/
def totalMargin : Provider → Nat
  | .mk _ m ins => m + marginList ins
def marginList : List Provider → Nat
  | [] => 0
  | p :: ps => totalMargin p + marginList ps
end

mutual
/-- **Traceability.** A price computed locally, by each provider from its own
figures and its suppliers' published prices, equals all costs plus all margins
in the network: nothing hidden, nothing counted twice. -/
theorem price_traceable : ∀ p : Provider, price p = totalCost p + totalMargin p
  | .mk c m ins => by
    have h := priceList_traceable ins
    simp only [price, totalCost, totalMargin]
    omega
theorem priceList_traceable :
    ∀ ps : List Provider, priceList ps = costList ps + marginList ps
  | [] => rfl
  | p :: ps => by
    have h1 := price_traceable p
    have h2 := priceList_traceable ps
    simp only [priceList, costList, marginList]
    omega
end

/-- **What is above cost is exactly the published margins.** -/
theorem above_cost_is_margins (p : Provider) : price p - totalCost p = totalMargin p := by
  have := price_traceable p
  omega

/-- **At cost everywhere, the price is the total cost.** -/
theorem all_at_cost (p : Provider) (h : totalMargin p = 0) : price p = totalCost p := by
  have := price_traceable p
  omega

/-! ## 2. Absolute versus percentage margins along a chain -/

/-- A chain of `n + 1` providers, each with own cost `a` and an absolute
margin `m` per unit. -/
def chainAbsolute (a m : Nat) : Nat → Nat
  | 0 => a + m
  | k + 1 => chainAbsolute a m k + a + m

/-- **Absolute margins add.** Along a chain, the total margin is the number of
providers times the margin: each provider's share stays its own decision. -/
theorem absolute_margins_add (a m : Nat) :
    ∀ n, chainAbsolute a m n = (n + 1) * a + (n + 1) * m := by
  intro n
  induction n with
  | zero => simp [chainAbsolute]
  | succ k ih =>
    simp only [chainAbsolute, ih, Nat.add_mul, Nat.one_mul]
    omega

/-- The same chain when each provider adds a percentage `r` of everything it
charges. Provider `k` charges `chainPercent a r k` in units of `1 / 100^(k+1)`;
its own cost `a` is scaled to the same units. -/
def chainPercent (a r : Nat) : Nat → Nat
  | 0 => a * (100 + r)
  | k + 1 => (chainPercent a r k + a * 100 ^ (k + 1)) * (100 + r)

/-- **Percentage margins compound.** In units of 1/100^(n+1), a chain of
`n + 1` providers with percentage margins charges at least `(100 + r)^n` times
what a single provider charges: a margin taken on someone else's margin. -/
theorem percent_margins_compound (a r : Nat) :
    ∀ n, chainPercent a r 0 * (100 + r) ^ n ≤ chainPercent a r n := by
  intro n
  induction n with
  | zero => simp
  | succ k ih =>
    show chainPercent a r 0 * (100 + r) ^ (k + 1) ≤ (chainPercent a r k + a * 100 ^ (k + 1)) * (100 + r)
    rw [Nat.pow_succ, ← Nat.mul_assoc]
    exact Nat.mul_le_mul_right _ (Nat.le_trans ih (Nat.le_add_right _ _))

/-- A square is never negative. -/
theorem sq_nonneg (x : Int) : 0 ≤ x * x := by
  rcases Int.le_total 0 x with h | h
  · exact Int.mul_nonneg h h
  · exact Int.mul_nonneg_of_nonpos_of_nonpos h h

/-! ## 3. Restricting supply, under any demand

No demand curve is assumed. A market is a list of units that buyers might
buy. Each entry is one unit's value to its buyer above the cost per unit `c`
(its "headroom"; it may be negative). A buyer who wants several units appears
once per unit, with what that unit is worth to them. At a price `c + m` a unit
is bought exactly when its value covers the price, that is when `m ≤` its
headroom. Demand that slopes downward is then automatic, whatever its shape.

The value a bought unit creates, above its cost, is its headroom. It is split
between the buyer (`headroom - m`) and the seller (`m`). -/

/-- Units bought at margin `m`. -/
def servedAt : List Int → Int → Nat
  | [], _ => 0
  | h :: hs, m => (if m ≤ h then 1 else 0) + servedAt hs m

/-- Total value created above cost at margin `m` (buyers plus seller). -/
def valueAt : List Int → Int → Int
  | [], _ => 0
  | h :: hs, m => (if m ≤ h then h else 0) + valueAt hs m

/-- What buyers keep at margin `m`. -/
def buyersKeep : List Int → Int → Int
  | [], _ => 0
  | h :: hs, m => (if m ≤ h then h - m else 0) + buyersKeep hs m

/-- The value of the units that would be bought at cost but are not bought at
margin `m`: those whose headroom is at least 0 but below `m`. -/
def lostAt : List Int → Int → Int
  | [], _ => 0
  | h :: hs, m => (if 0 ≤ h ∧ h < m then h else 0) + lostAt hs m

/-- **Any demand: a higher margin never serves more.** -/
theorem higher_margin_serves_no_more (hs : List Int) {m m' : Int} (h : m ≤ m') :
    servedAt hs m' ≤ servedAt hs m := by
  induction hs with
  | nil => simp [servedAt]
  | cons x xs ih =>
    simp only [servedAt]
    split <;> split <;> omega

/-- **Any demand: a margin serves strictly fewer when anyone values the good
above its cost but below the price.** -/
theorem margin_excludes (hs : List Int) {m : Int} (hm : 0 ≤ m)
    (hx : ∃ x, x ∈ hs ∧ 0 ≤ x ∧ x < m) : servedAt hs m < servedAt hs 0 := by
  induction hs with
  | nil => obtain ⟨x, hmem, _⟩ := hx; cases hmem
  | cons y ys ih =>
    simp only [servedAt]
    have hle := higher_margin_serves_no_more ys hm
    by_cases hy : 0 ≤ y ∧ y < m
    · have h1 : ¬ (m ≤ y) := by omega
      have h2 : (0 : Int) ≤ y := hy.1
      simp only [h1, h2, if_true, if_false]
      omega
    · obtain ⟨x, hmem, hx0, hxm⟩ := hx
      cases hmem with
      | head => exact absurd ⟨hx0, hxm⟩ hy
      | tail _ hmem' =>
        have := ih ⟨x, hmem', hx0, hxm⟩
        split <;> split <;> omega

/-- **Any demand: the exact cost of a margin.** The value created at cost equals
the value created at margin `m` plus the value of the units the margin
excludes. Nothing else is lost, and this is lost to everyone. -/
theorem margin_cost_exact (hs : List Int) {m : Int} (hm : 0 ≤ m) :
    valueAt hs 0 = valueAt hs m + lostAt hs m := by
  induction hs with
  | nil => simp [valueAt, lostAt]
  | cons x xs ih =>
    simp only [valueAt, lostAt]
    split <;> split <;> split <;> omega

theorem lost_nonneg (hs : List Int) (m : Int) : 0 ≤ lostAt hs m := by
  induction hs with
  | nil => simp [lostAt]
  | cons x xs ih =>
    simp only [lostAt]
    split <;> omega

/-- The loss is strictly positive when some unit has headroom strictly between
0 and `m`. -/
theorem lost_pos (hs : List Int) {m : Int} (hx : ∃ x, x ∈ hs ∧ 0 < x ∧ x < m) :
    0 < lostAt hs m := by
  induction hs with
  | nil => obtain ⟨x, hmem, _⟩ := hx; cases hmem
  | cons y ys ih =>
    simp only [lostAt]
    have hn := lost_nonneg ys m
    obtain ⟨x, hmem, hx0, hxm⟩ := hx
    rcases List.mem_cons.mp hmem with hxy | hmem'
    · subst hxy
      have h1 : 0 ≤ x ∧ x < m := ⟨by omega, hxm⟩
      rw [if_pos h1]
      omega
    · have := ih ⟨x, hmem', hx0, hxm⟩
      split <;> omega

/-- **Any demand: a margin is a transfer plus a loss.** What is created at
margin `m` is what buyers keep plus the seller's take `m` per unit sold. -/
theorem value_is_buyers_plus_take (hs : List Int) (m : Int) :
    valueAt hs m = buyersKeep hs m + m * (servedAt hs m : Int) := by
  induction hs with
  | nil => simp [valueAt, buyersKeep, servedAt]
  | cons x xs ih =>
    simp only [valueAt, buyersKeep, servedAt]
    split
    · rw [ih]; push_cast; rw [Int.mul_add]; omega
    · rw [Nat.zero_add, ih]; omega

/-- **Any demand: a separate bounty beats a margin.** Let the solver's reward
be what margin `m` would have earned it, `R = m * (units sold at m)`. Paid
instead as a separate bounty, with the price at cost:
* the solver receives exactly `R`;
* at least as many units are served;
* the whole gains exactly the value the margin excluded, which is never
  negative.
For every demand, of any shape. -/
theorem bounty_beats_margin_any_demand (hs : List Int) {m : Int} (hm : 0 ≤ m) :
    servedAt hs m ≤ servedAt hs 0 ∧
      valueAt hs 0 - valueAt hs m = lostAt hs m ∧
      0 ≤ valueAt hs 0 - valueAt hs m := by
  have h1 := higher_margin_serves_no_more hs hm
  have h2 := margin_cost_exact hs hm
  have h3 := lost_nonneg hs m
  refine ⟨h1, by omega, by omega⟩

/-- **Demand at cost does not reveal value.** Two markets can buy exactly the
same number of units at cost while the value created differs a hundredfold.
So a bounty cannot be sized from at-cost sales alone: it needs a second signal
(binding commitments, auctions, measured outcomes, matched contributions). -/
theorem at_cost_demand_does_not_reveal_value :
    servedAt [1, 1] 0 = servedAt [100, 100] 0 ∧
      valueAt [1, 1] 0 = 2 ∧ valueAt [100, 100] 0 = 200 := by
  decide

/-! ## 3b. The linear case, for closed-form numbers

With linear demand, `A` units have headroom above cost, spread evenly. Then
the figures above have closed forms.

Take a good whose cost per unit is `c`. With linear demand, `A` units are
valued above `c`. At a price `c + m`, the number served is `A - m`.

Twice the consumer value is `(A - m)^2`, twice the seller's take is
`2 * m * (A - m)`, and twice the total value is their sum. Working with twice
the value keeps everything in whole numbers. -/

/-- Number served at margin `m`. -/
def served (A m : Int) : Int := A - m

/-- Twice the total value created at margin `m` (consumers plus seller). -/
def totalValue2 (A m : Int) : Int := (A - m) * (A - m) + 2 * m * (A - m)

/-- Twice the seller's take at margin `m`. -/
def take2 (A m : Int) : Int := 2 * m * (A - m)

/-- **A margin costs the whole exactly `m^2`.** Twice the total value is
`A^2 - m^2`: the margin moves value from buyers to the seller, and in addition
destroys `m^2` that nobody gets. -/
theorem margin_destroys_value (A m : Int) : totalValue2 A m = A * A - m * m := by
  unfold totalValue2
  grind

/-- **A margin serves fewer people, one-for-one.** -/
theorem margin_serves_fewer (A m : Int) (hm : 0 < m) : served A m < served A 0 := by
  unfold served
  omega

/-- **The seller's own best margin is half the headroom.** For every margin,
four times the seller's take is at most `A^2`, with equality at `m = A / 2`
(for even `A`). So a seller maximising its own take serves half of those who
would be served at cost. -/
theorem selfish_take_bound (A m : Int) : 2 * take2 A m ≤ A * A := by
  unfold take2
  have h : 0 ≤ (A - 2 * m) * (A - 2 * m) := sq_nonneg (A - 2 * m)
  grind

theorem selfish_margin_serves_half (k : Int) :
    2 * take2 (2 * k) k = (2 * k) * (2 * k) ∧ served (2 * k) k = k := by
  unfold take2 served
  constructor <;> grind

/-! ## 4. The bounty, paid separately -/

/-- **A separate bounty beats a margin.** Suppose the solver is to receive the
reward a margin `m` would have given it, `R = m * (A - m)`. If instead the
price is set at cost and `R` is paid as a separate bounty (a transfer, which
adds or destroys no value), then:
* the solver receives exactly the same reward;
* `A` people are served instead of `A - m`;
* twice the total value is `A^2` instead of `A^2 - m^2`.
The gain to the whole is exactly the value the margin destroyed. -/
theorem bounty_beats_margin (A m : Int) :
    take2 A m = 2 * (m * (A - m)) ∧
      served A 0 - served A m = m ∧
      totalValue2 A 0 - totalValue2 A m = m * m := by
  unfold take2 served totalValue2
  refine ⟨?_, ?_, ?_⟩ <;> grind

/-! ## 5. Hidden margins: transparency needs some checking

A provider can hide margin by reporting a higher cost. Suppose that gains it
`W` per period, that hiding is detected in `k` of every `n` periods, and that
when detected it loses `L` (buyers leave, reputation, a penalty). -/

/-- **Hiding a margin does not pay exactly when expected loss covers the gain.**
Over `n` periods the hidden gain is `n * W`; the expected loss is `k * L`.
Honest reporting is at least as good exactly when `n * W ≤ k * L`. So the
format has to be checkable: by buyers, auditors, or peers, with some
frequency, and with a loss that matters. -/
theorem hiding_deterred_iff (n W k L : Nat) :
    (n * W ≤ k * L) ↔ ((n * W : Int) - (k * L : Int) ≤ 0) := by
  omega

/-- No checking at all (`k = 0`) means any positive hidden gain pays. -/
theorem no_checking_hiding_pays {n W L : Nat} (hn : 0 < n) (hW : 0 < W) :
    ¬ (n * W ≤ 0 * L) := by
  have : 0 < n * W := Nat.mul_pos hn hW
  omega

/-! ## 6. Scarcity: when capacity is short

So far supply was unlimited at a constant cost per unit, so a price at cost
never needed rationing. Now suppose only `K` units can be supplied this period,
while more are wanted at cost. Something must decide who is served. Three
options are compared:
* a queue (first come, first served);
* a **scarcity charge**: a declared amount `s` on top of cost, set so that no
  more than `K` units are wanted;
* where the charge's revenue goes: kept as margin, or **routed into capacity**.

The scarcity charge is published as its own field, next to cost and margin,
with its destination. It is not a margin. -/

/-- A number above every headroom in the list. -/
def above : List Int → Int
  | [] => 1
  | h :: hs => max (h + 1) (above hs)

theorem above_gt : ∀ (hs : List Int) (x : Int), x ∈ hs → x < above hs
  | [], x, hx => by cases hx
  | h :: hs, x, hx => by
    simp only [above]
    rcases List.mem_cons.mp hx with rfl | hx'
    · omega
    · have := above_gt hs x hx'; omega

theorem served_zero_above (hs : List Int) : servedAt hs (above hs) = 0 := by
  have key : ∀ (l : List Int) (s : Int), (∀ x, x ∈ l → x < s) → servedAt l s = 0 := by
    intro l s hl
    induction l with
    | nil => rfl
    | cons y ys ih =>
      simp only [servedAt]
      have hy : y < s := hl y (List.mem_cons_self ..)
      have := ih (fun x hx => hl x (List.mem_cons_of_mem _ hx))
      rw [if_neg (by omega), this]
  exact key hs (above hs) (above_gt hs)

/-- **A clearing charge always exists.** For any market and any capacity, some
charge makes no more units wanted than can be supplied. -/
theorem clearing_charge_exists (hs : List Int) (K : Nat) : ∃ s, servedAt hs s ≤ K :=
  ⟨above hs, by rw [served_zero_above]; omega⟩

/-- First come, first served: the first `k` units, in order of arrival, whose
headroom is nonnegative. -/
def queueValue : List Int → Nat → Int
  | [], _ => 0
  | _, 0 => 0
  | h :: hs, k + 1 => if 0 ≤ h then h + queueValue hs k else queueValue hs (k + 1)

/-- Capacity when the scarcity revenue is routed into capacity: while `D` units
are wanted at cost and capacity is below `D`, each period's scarcity revenue
buys at least `g` more units (a premise about the revenue and the price of
capacity). -/
def capRouted (D K0 g : Nat) : Nat → Nat
  | 0 => K0
  | t + 1 => if capRouted D K0 g t < D then capRouted D K0 g t + g else capRouted D K0 g t

theorem routed_grows (D K0 g : Nat) (hg : 0 < g) :
    ∀ t, min D (K0 + t) ≤ capRouted D K0 g t := by
  intro t
  induction t with
  | zero => simp [capRouted]; omega
  | succ t ih =>
    simp only [capRouted]
    split <;> omega

/-- **Routed into capacity, scarcity removes itself.** After at most `D - K0`
periods capacity covers everyone who wants the good at cost; from then on the
scarcity charge is zero and the price is at cost again. -/
theorem routed_removes_scarcity (D K0 g : Nat) (hg : 0 < g) :
    ∀ t, D - K0 ≤ t → D ≤ capRouted D K0 g t := by
  intro t ht
  have := routed_grows D K0 g hg t
  omega

/-- **A queue can waste scarce capacity.** First come, first served may give the
units to those who value them least. In the witness below, a queue serving two
units creates 3, while a scarcity charge serving two units creates 17. -/
theorem queue_can_waste : queueValue [1, 2, 9, 8] 2 = 3 ∧
    servedAt [1, 2, 9, 8] 8 = 2 ∧ valueAt [1, 2, 9, 8] 8 = 17 := by
  decide

/-! An arbitrary allocation of the scarce units is a flag on each unit: served
or not. The next results show that the units served under a scarcity charge
create at least as much value as any other allocation of no more units. -/

/-- Value of an arbitrary allocation: each unit carries a flag, served or not. -/
def allocValue : List (Int × Bool) → Int
  | [] => 0
  | (h, b) :: l => (if b then h else 0) + allocValue l

def allocCount : List (Int × Bool) → Nat
  | [] => 0
  | (_, b) :: l => (if b then 1 else 0) + allocCount l

/-- Served, below the charge. -/
def sbV (s : Int) : List (Int × Bool) → Int
  | [] => 0
  | (h, b) :: l => (if b = true ∧ h < s then h else 0) + sbV s l
def sbC (s : Int) : List (Int × Bool) → Nat
  | [] => 0
  | (h, b) :: l => (if b = true ∧ h < s then 1 else 0) + sbC s l
/-- Served, at or above the charge. -/
def saV (s : Int) : List (Int × Bool) → Int
  | [] => 0
  | (h, b) :: l => (if b = true ∧ s ≤ h then h else 0) + saV s l
def saC (s : Int) : List (Int × Bool) → Nat
  | [] => 0
  | (h, b) :: l => (if b = true ∧ s ≤ h then 1 else 0) + saC s l
/-- Not served, at or above the charge. -/
def uaV (s : Int) : List (Int × Bool) → Int
  | [] => 0
  | (h, b) :: l => (if b = false ∧ s ≤ h then h else 0) + uaV s l
def uaC (s : Int) : List (Int × Bool) → Nat
  | [] => 0
  | (h, b) :: l => (if b = false ∧ s ≤ h then 1 else 0) + uaC s l

theorem alloc_split (s : Int) (l : List (Int × Bool)) : allocValue l = saV s l + sbV s l := by
  induction l with
  | nil => rfl
  | cons p l ih =>
    obtain ⟨h, b⟩ := p
    simp only [allocValue, saV, sbV]
    cases b <;> simp <;> (repeat' split) <;> omega

theorem count_split (s : Int) (l : List (Int × Bool)) : allocCount l = saC s l + sbC s l := by
  induction l with
  | nil => rfl
  | cons p l ih =>
    obtain ⟨h, b⟩ := p
    simp only [allocCount, saC, sbC]
    cases b <;> simp <;> (repeat' split) <;> omega

theorem value_split (s : Int) (l : List (Int × Bool)) :
    valueAt (l.map Prod.fst) s = saV s l + uaV s l := by
  induction l with
  | nil => rfl
  | cons p l ih =>
    obtain ⟨h, b⟩ := p
    simp only [List.map, valueAt, saV, uaV]
    cases b <;> simp <;> (repeat' split) <;> omega

theorem served_split (s : Int) (l : List (Int × Bool)) :
    servedAt (l.map Prod.fst) s = saC s l + uaC s l := by
  induction l with
  | nil => rfl
  | cons p l ih =>
    obtain ⟨h, b⟩ := p
    simp only [List.map, servedAt, saC, uaC]
    cases b <;> simp <;> (repeat' split) <;> omega

theorem sb_bound (s : Int) (l : List (Int × Bool)) : sbV s l ≤ (sbC s l : Int) * (s - 1) := by
  induction l with
  | nil => simp [sbV, sbC]
  | cons p l ih =>
    obtain ⟨h, b⟩ := p
    simp only [sbV, sbC]
    split
    · next hc => push_cast; rw [Int.add_mul]; omega
    · rw [Nat.zero_add]; omega

theorem ua_bound (s : Int) (l : List (Int × Bool)) : (uaC s l : Int) * s ≤ uaV s l := by
  induction l with
  | nil => simp [uaV, uaC]
  | cons p l ih =>
    obtain ⟨h, b⟩ := p
    simp only [uaV, uaC]
    split
    · next hc => push_cast; rw [Int.add_mul]; omega
    · rw [Nat.zero_add]; omega


/-- **A scarcity charge puts scarce units where they create the most value.**
Any other allocation that serves no more units than the charge does creates no
more value, measured as headroom above cost. (For a nonnegative charge.) -/
theorem charge_allocates_best (s : Int) (hs0 : 0 ≤ s) (l : List (Int × Bool))
    (hcap : allocCount l ≤ servedAt (l.map Prod.fst) s) :
    allocValue l ≤ valueAt (l.map Prod.fst) s := by
  rw [alloc_split s, value_split s]
  rw [count_split s, served_split s] at hcap
  have hc : sbC s l ≤ uaC s l := by omega
  have h1 := sb_bound s l
  have h2 := ua_bound s l
  have h3 : (sbC s l : Int) * (s - 1) ≤ (sbC s l : Int) * s :=
    Int.mul_le_mul_of_nonneg_left (by omega) (by omega)
  have h4 : (sbC s l : Int) * s ≤ (uaC s l : Int) * s :=
    Int.mul_le_mul_of_nonneg_right (by exact_mod_cast hc) hs0
  omega

/-- Capacity when the scarcity revenue is kept as margin: it never grows. -/
def capKept (K0 : Nat) : Nat → Nat
  | _ => K0

/-- **Kept as margin, scarcity is permanent.** If `D` units are wanted at cost
and capacity stays at `K0 < D`, the shortage, and with it the scarcity charge,
never ends. That is the incentive the user started from: a seller who keeps the
scarcity rent gains from not expanding. -/
theorem kept_scarcity_permanent {D K0 : Nat} (h : K0 < D) : ∀ t, capKept K0 t < D := by
  intro t; simp [capKept]; exact h

/-! ## 7. The other jobs profit does

Profit is not only a reward for solving problems. It also bears risk, funds
renewal, signals scarcity, rewards cutting cost, invites entry and discovery,
and leaves a surplus that goes somewhere. The protocol gives each job its own
declared home:

| Job of profit          | Home in the protocol                      | Result                         |
|------------------------|-------------------------------------------|--------------------------------|
| Reward for solving     | separate bounty                           | `bounty_beats_margin_any_demand` |
| Risk-bearing           | risk fund, bounty covers failed attempts  | `risk_pool_solvent_iff`        |
| Renewal                | renewal field                             | `renewal_keeps_service`        |
| Scarcity signal        | declared charge routed into capacity      | `routed_removes_scarcity`      |
| Cutting cost           | shared savings against a benchmark        | `shared_rewards_saving`        |
| Entry and discovery    | open entry, published prices              | `cheaper_entrant_lowers`       |
| Residual surplus       | refund in proportion to use               | `patronage_at_cost_all`        |
| Honesty of figures     | checking with a loss on detection         | `hiding_deterred_iff`          |
-/

/-- **Risk-bearing: a bounty must pay for the attempts that fail.** A risk fund
finances `n` attempts at cost `C` each; `k` succeed and each earns bounty `B`.
The fund stays whole exactly when `n * C ≤ k * B`: the bounty per success has
to carry the cost of the failures too. That is the explicit risk premium, and
the "permission to fail" it buys. -/
theorem risk_pool_solvent_iff (n k C B : Nat) :
    (n * C ≤ k * B) ↔ (0 ≤ (k * B : Int) - (n * C : Int)) := by omega

/-- A bounty that only repays the successful attempt's own cost (`B = C`) makes
the risk fund lose whenever some attempts fail. -/
theorem cost_only_bounty_loses {n k C : Nat} (hk : k < n) (hC : 0 < C) :
    (k * C : Int) - (n * C : Int) < 0 := by
  have : k * C < n * C := Nat.mul_lt_mul_of_pos_right hk hC
  omega


/-- **Cost discipline.** Under pure pass-through (cost-plus), the provider's
take is its margin, whatever its cost. -/
def costPlusPayoff (m _c : Int) : Int := m
/-- Cost-plus gives no reward for cutting cost: the take is the same at any cost. -/
theorem cost_plus_no_incentive (m c c' : Int) : costPlusPayoff m c = costPlusPayoff m c' := rfl

/-- Shared savings: the provider keeps `σ` percent of any saving below a
published benchmark `b` (all amounts times 100). -/
def sharedPayoff (m b σ c : Int) : Int := 100 * m + σ * (b - c)
/-- The price under shared savings (times 100). -/
def sharedPrice (m b σ c : Int) : Int := 100 * c + 100 * m + σ * (b - c)

/-- **With shared savings, cutting cost pays the provider.** -/
theorem shared_rewards_saving {m b σ c c' : Int} (hσ : 0 < σ) (hc : c' < c) :
    sharedPayoff m b σ c < sharedPayoff m b σ c' := by
  unfold sharedPayoff
  have : σ * (b - c) < σ * (b - c') := Int.mul_lt_mul_of_pos_left (by omega) hσ
  omega

/-- **And it lowers the price for buyers,** as long as the share is below 100%. -/
theorem shared_lowers_price {m b σ c c' : Int} (hσ : σ < 100) (hσ0 : 0 ≤ σ) (hc : c' < c) :
    sharedPrice m b σ c' < sharedPrice m b σ c := by
  unfold sharedPrice
  have h1 : σ * (b - c) = σ * b - σ * c := Int.mul_sub σ b c
  have h2 : σ * (b - c') = σ * b - σ * c' := Int.mul_sub σ b c'
  have h3 : (100 - σ) * c' < (100 - σ) * c := Int.mul_lt_mul_of_pos_left hc (by omega)
  have e1 : (100 - σ) * c = 100 * c - σ * c := Int.sub_mul 100 σ c
  have e2 : (100 - σ) * c' = 100 * c' - σ * c' := Int.sub_mul 100 σ c'
  omega


/-- **Entry and discovery.** The best published price among providers (with a
default `d` when there are none). Anyone may enter by publishing a price. -/
def best : List Nat → Nat → Nat
  | [], d => d
  | p :: ps, d => min p (best ps d)

/-- Open entry never raises the best price buyers can get. -/
theorem entry_never_raises (p : Nat) (ps : List Nat) (d : Nat) : best (p :: ps) d ≤ best ps d := by
  simp [best]; omega

/-- **A cheaper entrant lowers the best price.** Discovery of a cheaper way to
do the same job reaches buyers through the published price, with no planner. -/
theorem cheaper_entrant_lowers {p : Nat} (ps : List Nat) (d : Nat) (h : p < best ps d) :
    best (p :: ps) d < best ps d := by
  simp [best]; omega


/-- **Renewal.** The service's capacity after `t` years, starting at `K0`, wearing
out `d` a year, with `r` a year funded by the renewal field. -/
def serviceAfter (K0 d r : Nat) : Nat → Nat
  | 0 => K0
  | t + 1 => serviceAfter K0 d r t + r - d

/-- A renewal field at least as large as yearly wear keeps the service whole. -/
theorem renewal_keeps_service {K0 d r : Nat} (h : d ≤ r) : ∀ t, K0 ≤ serviceAfter K0 d r t := by
  intro t
  induction t with
  | zero => exact Nat.le_refl _
  | succ t ih => show K0 ≤ serviceAfter K0 d r t + r - d; omega

/-- Without it, the service runs down by at least a unit a year. -/
theorem no_renewal_runs_down {K0 d r : Nat} (h : r < d) : ∀ t, serviceAfter K0 d r t ≤ K0 - t := by
  intro t
  induction t with
  | zero => simp [serviceAfter]
  | succ t ih => show serviceAfter K0 d r t + r - d ≤ K0 - (t + 1); omega

/-- **Residual surplus: the cooperative refund.** A user pays a provisional
price `p` per unit; the realised cost turns out to be `c ≤ p`; the difference is
refunded per unit used. The user ends up paying exactly cost. -/
theorem patronage_at_cost_each {p c q : Nat} (h : c ≤ p) : p * q - (p - c) * q = c * q := by
  rw [← Nat.sub_mul]; congr 1; omega


/-- What a list of users pays in total after the refund. -/
def netPaid (p c : Nat) : List Nat → Nat
  | [] => 0
  | q :: qs => (p * q - (p - c) * q) + netPaid p c qs
/-- Total units used. -/
def totalUse : List Nat → Nat
  | [] => 0
  | q :: qs => q + totalUse qs
/-- **Ex post, everyone pays at cost.** With refunds in proportion to use, the
users together pay exactly cost times total use: no surplus is left without a
declared destination. -/
theorem patronage_at_cost_all {p c : Nat} (h : c ≤ p) :
    ∀ qs, netPaid p c qs = c * totalUse qs := by
  intro qs
  induction qs with
  | nil => simp [netPaid, totalUse]
  | cons q qs ih =>
    simp only [netPaid, totalUse]
    rw [patronage_at_cost_each h, ih, Nat.mul_add]

/-- **The published price, every field named.** Each job that profit used to do
in one hidden markup gets its own declared field. The innovation reward is not
a field: it is the bounty, paid separately. -/
structure Fields where
  cost : Nat
  renewal : Nat
  risk : Nat
  scarcity : Nat
  efficiency : Nat
  margin : Nat

def Fields.price (f : Fields) : Nat :=
  f.cost + f.renewal + f.risk + f.scarcity + f.efficiency + f.margin

/-- **Every unit above cost has a named field.** -/
theorem every_euro_has_a_field (f : Fields) :
    f.price - f.cost = f.renewal + f.risk + f.scarcity + f.efficiency + f.margin := by
  unfold Fields.price; omega

/-! ## 8. Sizing the bounty

Demand at cost does not reveal value (`at_cost_demand_does_not_reveal_value`),
so a bounty needs its own signals and its own discipline. The design follows
the research report on this protocol: a share of measured value, capped; paid
from a fixed pool; in parts; with demand signals that cost something to give.

What is proved below is that each device does its job: the budget holds, more
impact earns more, claims compete, tokens force trade-offs, matching rewards
breadth, payment in parts limits exposure. What is not proved, and cannot be by
arithmetic: that impact is measured well and honestly, and that the measure is
not gamed. -/

/-- Total of a list of measured impacts. -/
def total : List Nat → Nat
  | [] => 0
  | v :: vs => v + total vs

/-- **A fixed pool shared by impact.** A pool `P` is shared among claimants in
proportion to their measured impact, out of total impact `V` (rounded down).
This is the Health Impact Fund design. -/
def payouts (P V : Nat) : List Nat → Nat
  | [] => 0
  | v :: vs => P * v / V + payouts P V vs

/-- Helper: payouts times total impact never exceed the pool times total impact. -/
theorem scaled_payouts_le (P V : Nat) : ∀ vs, V * payouts P V vs ≤ P * total vs := by
  intro vs
  induction vs with
  | nil => simp [payouts, total]
  | cons v vs ih =>
    simp only [payouts, total, Nat.mul_add]
    have h2 : V * (P * v / V) ≤ P * v := Nat.mul_div_le (P * v) V
    omega

/-- **Hard budget.** However many claims there are, the payouts never exceed
the pool. No open-ended liability, no bailout needed. -/
theorem pool_never_overspent (P : Nat) (vs : List Nat) (hV : 0 < total vs) :
    payouts P (total vs) vs ≤ P := by
  have h := scaled_payouts_le P (total vs) vs
  rw [Nat.mul_comm P] at h
  exact Nat.le_of_mul_le_mul_left h hV

/-- **More impact, more pay.** Within a round, a larger measured impact never earns less. -/
theorem more_impact_more_pay (P V : Nat) {v w : Nat} (h : v ≤ w) : P * v / V ≤ P * w / V :=
  Nat.div_le_div_right (Nat.mul_le_mul_left P h)

/-- **Claims compete.** More total impact claimed by others never raises one's
own payout. That is the price of the hard budget: the reward per unit of
impact is not known in advance. -/
theorem more_claims_less_each (P v : Nat) {V V' : Nat} (hV : 0 < V) (h : V ≤ V') :
    P * v / V' ≤ P * v / V :=
  Nat.div_le_div_left h hV

/-- **A cap.** A bounty that is a share `a` of measured value `V`, capped at `Bmax`. -/
def capped (Bmax a V : Nat) : Nat := min Bmax (a * V)
/-- The cap bounds every bounty. -/
theorem cap_bounds (Bmax a V : Nat) : capped Bmax a V ≤ Bmax := Nat.min_le_left _ _


/-- **Scarce tokens.** Each participant has `T` tokens to spread over problems
(here two, A and B). Support for A from all participants. -/
def supportA : List (Nat × Nat) → Nat
  | [] => 0
  | (a, _) :: ps => a + supportA ps
/-- Support for B from all participants. -/
def supportB : List (Nat × Nat) → Nat
  | [] => 0
  | (_, b) :: ps => b + supportB ps

/-- **Backing one problem costs backing another.** With `T` tokens each, total
support over all problems is at most participants times `T`, and no
participant adds more than `T`. That is what makes the signal costly, and so
informative. (False identities are not covered.) -/
theorem tokens_bound (T : Nat) : ∀ ps : List (Nat × Nat), (∀ p ∈ ps, p.1 + p.2 ≤ T) →
    supportA ps + supportB ps ≤ ps.length * T := by
  intro ps hps
  induction ps with
  | nil => simp [supportA, supportB]
  | cons p ps ih =>
    obtain ⟨a, b⟩ := p
    have h1 := hps (a, b) (List.mem_cons_self ..)
    have h2 := ih (fun q hq => hps q (List.mem_cons_of_mem _ hq))
    simp only [supportA, supportB, List.length_cons, Nat.succ_mul] at *
    omega


/-- Sum of square roots of contributions (contributions are written as squares `r * r`). -/
def sumR : List Nat → Nat
  | [] => 0
  | r :: rs => r + sumR rs
/-- Sum of contributions. -/
def sumSq : List Nat → Nat
  | [] => 0
  | r :: rs => r * r + sumSq rs

/-- **Matching rewards breadth.** Quadratic funding funds a problem with the
square of the summed square roots of contributions. That is never less than the
contributions themselves, and grows with the number of backers: four backers
of 1 raise 16, one backer of 4 raises 4. Many small backers count for more
than one large one. (Collusion and false identities are not covered.) -/
theorem matching_rewards_breadth : ∀ rs : List Nat, sumSq rs ≤ sumR rs * sumR rs := by
  intro rs
  induction rs with
  | nil => simp [sumSq, sumR]
  | cons r rs ih =>
    simp only [sumSq, sumR]
    have e : (r + sumR rs) * (r + sumR rs) = r * r + 2 * (r * sumR rs) + sumR rs * sumR rs := by
      simp only [Nat.add_mul, Nat.mul_add, Nat.two_mul, Nat.mul_comm (sumR rs) r]; omega
    rw [e]; omega

/-- **Payment in parts.** A milestone `M` is paid when the solution is verified;
the remainder `R` only when an independent evaluation finds impact. -/
def tranchePaid (M R : Nat) (impactFound : Bool) : Nat := M + (if impactFound then R else 0)

/-- **Parts limit what a failed promise costs the fund.** If the evaluation finds
no impact, the fund has paid only the milestone. -/
theorem tranches_limit_exposure (M R : Nat) : tranchePaid M R false = M ∧
    tranchePaid M R true = M + R := by
  simp [tranchePaid]


/-! ## 9. Witness: the premises can hold together -/

/-- A concrete case.
* A platform (cost 3, margin 0) buys hosting (cost 2, margin 1) and a licence
  (cost 4, margin 0). Its published price is 10 = costs 9 + margins 1.
* Three providers each with cost 10: with a 10% margin each, the chain charges
  36.41 (36410000 in millionths), against 33 with an absolute margin of 1
  each, though 10% of 10 is also 1. The extra 0.41 is margin on margin.
* Headroom 10, margin 5: 5 served and twice the value 75; at cost 10 served
  and twice the value 100. The seller's take is the same if paid as a bounty.
* Any demand: five units with headroom 10, 6, 3, 1 and -2. At margin 5, two
  are bought and 16 is created (buyers keep 6, the seller takes 10). At cost,
  four are bought and 20 is created. The difference, 4, is the value of the
  two excluded units (3 + 1).
* Scarcity: 5 units wanted at cost, capacity 2. Routing buys one unit per
  period, so capacity is 5 after 3 periods; kept as margin, it stays 2.
* Risk: four attempts at 10, one succeeds: a bounty of 40 keeps the fund whole.
* Entry: best price 12; an entrant at 9 brings it to 9.
* Surplus: provisional price 12, cost 10, use 5 and 3: after refunds the users
  pay 80, exactly cost.
* Bounty pool of 100, impacts 3 and 1: payouts 75 and 25. A third claimant
  with impact 4: payouts 37, 12 and 50, total 99 (rounding), still within 100.
* Matching: four backers of 1 raise 16; one backer of 4 raises 4.
* A bounty of twice a value of 30, capped at 50: 50. -/
theorem transparent_pricing_witness :
    price (.mk 3 0 [.mk 2 1 [], .mk 4 0 []]) = 10 ∧
      totalCost (.mk 3 0 [.mk 2 1 [], .mk 4 0 []]) = 9 ∧
      totalMargin (.mk 3 0 [.mk 2 1 [], .mk 4 0 []]) = 1 ∧
      chainAbsolute 10 1 2 = 33 ∧ chainPercent 10 10 2 = 36410000 ∧
      served 10 5 = 5 ∧ totalValue2 10 5 = 75 ∧ totalValue2 10 0 = 100 ∧
      servedAt [10, 6, 3, 1, -2] 5 = 2 ∧ servedAt [10, 6, 3, 1, -2] 0 = 4 ∧
      valueAt [10, 6, 3, 1, -2] 5 = 16 ∧ valueAt [10, 6, 3, 1, -2] 0 = 20 ∧
      lostAt [10, 6, 3, 1, -2] 5 = 4 ∧ buyersKeep [10, 6, 3, 1, -2] 5 = 6 ∧
      capRouted 5 2 1 3 = 5 ∧ capKept 2 3 = 2 ∧
      4 * 10 ≤ 1 * 40 ∧ best [15, 12] 100 = 12 ∧ best [9, 15, 12] 100 = 9 ∧
      netPaid 12 10 [5, 3] = 80 ∧
      payouts 100 4 [3, 1] = 100 ∧ payouts 100 8 [3, 1, 4] = 99 ∧
      sumR [1, 1, 1, 1] * sumR [1, 1, 1, 1] = 16 ∧ sumR [2] * sumR [2] = 4 ∧
      capped 50 2 30 = 50 := by
  decide

end TransparentPricing
