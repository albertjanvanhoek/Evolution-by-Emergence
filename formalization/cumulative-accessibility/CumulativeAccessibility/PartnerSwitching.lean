namespace CumulativeAccessibility
namespace PartnerSwitching

/-!
# Partner switching: when defection pays a node that can find a new partner

`Reciprocity` proves that a defector that cannot live alone falls after the
partner it defected on, but only where it cannot find a new partner.  That is
exactly where defection might pay.  This file treats a **serial defector**: a
node that defects on one partner, moves on to the next, and defects again.

Setting, in whole units per step, without discounting.
* Cooperating, the node gets a net gain `e` from the exchange every step: what
  it receives, `e + g`, minus what giving costs it, `g`.
* Defecting, it stops giving, so it gets `e + g` while its partner still gives.
  The partner stops after `L` steps: when it notices, or, in `Reciprocity`,
  when it falls (`partner_falls` bounds `L` by the partner's reserve).
* Then the node must find a new partner: a search cost `S`, and `τ` steps
  without any exchange.  A cycle lasts `L + τ` steps; a cooperator gets `e` in
  every one of them.

Results:
* `switching_defection_pays_iff`: over any number of cycles, serial defection
  yields more than cooperation exactly when `S + τ * e < L * g`: what the node
  saves before it is found out exceeds what finding a new partner costs,
  counting the exchange forgone while searching.
* `switching_defection_does_not_pay`: otherwise it never yields more.  Faster
  detection (smaller `L`), costlier search (larger `S`) or longer search
  (larger `τ`) each close the gap.
* `reputation_ends_serial_defection`: if every known defection makes the next
  partner harder to find, so the `j`-th search takes `j * t₀` more steps, serial
  defection yields less than cooperation from an explicit number of cycles on,
  however much each defection saves.
* `partner_switching_witness`: both cases with small numbers.

So partner choice does not make defection pay by itself; what decides is how
soon a defector is found out and how much a known defector's search costs.
Both are correction routes run by the others: detection, and reputation that
passes the news on.  Not covered: discounting (see `CommonsDiscount`), partial
defection, partners that forgive, and reputations that can be faked.  The
first two results are close to arithmetic; the substance is in the setting.
-/

/-- **When serial defection pays.**  Over `k ≥ 1` cycles of `L + τ` steps, a
serial defector gets `k * L * (e + g)` and pays `k * S` for its searches; a
cooperator gets `(L + τ) * e` per cycle.  Defection yields more exactly when
`S + τ * e < L * g`. -/
theorem switching_defection_pays_iff {k L τ S e g : Nat} (hk : 0 < k) :
    k * S + k * ((L + τ) * e) < k * (L * (e + g)) ↔ S + τ * e < L * g := by
  have hexp : k * (L * (e + g)) = k * (L * e) + k * (L * g) := by grind
  have hcoop : k * ((L + τ) * e) = k * (L * e) + k * (τ * e) := by grind
  rw [hexp, hcoop]
  constructor
  · intro h
    have h' : k * (S + τ * e) < k * (L * g) := by
      have : k * (S + τ * e) = k * S + k * (τ * e) := Nat.mul_add _ _ _
      omega
    exact Nat.lt_of_mul_lt_mul_left h'
  · intro h
    have h' : k * (S + τ * e) < k * (L * g) := Nat.mul_lt_mul_of_pos_left h hk
    have : k * (S + τ * e) = k * S + k * (τ * e) := Nat.mul_add _ _ _
    omega

/-- **When it does not.**  If what a defector saves before it is found out is
at most what finding a new partner costs, serial defection never yields more
than cooperation, over any number of cycles. -/
theorem switching_defection_does_not_pay {k L τ S e g : Nat} (h : L * g ≤ S + τ * e) :
    k * (L * (e + g)) ≤ k * S + k * ((L + τ) * e) := by
  have h' : k * (L * g) ≤ k * (S + τ * e) := Nat.mul_le_mul_left _ h
  have e1 : k * (L * (e + g)) = k * (L * e) + k * (L * g) := by grind
  have e2 : k * ((L + τ) * e) = k * (L * e) + k * (τ * e) := by grind
  have e3 : k * (S + τ * e) = k * S + k * (τ * e) := Nat.mul_add _ _ _
  omega

/-- `tri k = 0 + 1 + ... + (k - 1)`. -/
def tri : Nat → Nat
  | 0 => 0
  | k + 1 => tri k + k

theorem two_tri (k : Nat) : 2 * tri k + k = k * k := by
  induction k with
  | zero => rfl
  | succ k ih => show 2 * (tri k + k) + (k + 1) = (k + 1) * (k + 1); grind

/-- **Reputation ends serial defection.**  If the `j`-th search takes `j * t₀`
steps beyond the base cycle, the extra exchange forgone over `k` cycles is
`tri k * t₀ * e`.  Once `k ≥ 2 * L * g + 2`, it exceeds everything the defector
saved, so serial defection yields less than cooperation, whatever the search
cost. -/
theorem reputation_ends_serial_defection {L S e g t₀ : Nat} (hpen : 0 < t₀ * e) :
    ∀ k, 2 * (L * g) + 2 ≤ k → k * (L * g) < k * S + tri k * (t₀ * e) := by
  intro k hk
  have h2 := two_tri k
  -- `2 * tri k = k * (k - 1) ≥ k * (2 * L * g + 1) > 2 * k * L * g`
  have hkk : k * (2 * (L * g) + 1) ≤ k * k - k := by
    have : k * (2 * (L * g) + 1) ≤ k * (k - 1) := Nat.mul_le_mul_left _ (by omega)
    have e : k * (k - 1) = k * k - k := by
      rw [Nat.mul_sub_one]
    omega
  have htri : k * (L * g) < tri k := by
    have e1 : k * (2 * (L * g) + 1) = 2 * (k * (L * g)) + k := by grind
    have hk1 : 1 ≤ k := by omega
    omega
  have hle : tri k ≤ tri k * (t₀ * e) := Nat.le_mul_of_pos_right _ hpen
  omega

/-- Concrete cases.  Each defection saves 2 per step for 3 steps (6 in all);
cooperating gains 1 per step; a search costs 1.  If a new partner is found in 2
steps (`1 + 2 < 6`), serial defection pays: per cycle the defector receives 9,
while cooperating yields 5 and the search costs 1.  If it takes 6 steps
(`1 + 6 ≥ 6`), it does not: 9 against 9 plus the search cost of 1.  With a reputation that adds
1 step per known defection, defection loses from the 14th cycle on. -/
theorem partner_switching_witness :
    1 * 1 + 1 * ((3 + 2) * 1) < 1 * (3 * (1 + 2)) ∧
      1 * (3 * (1 + 2)) ≤ 1 * 1 + 1 * ((3 + 6) * 1) ∧
      14 * (3 * 2) < 14 * 1 + tri 14 * (1 * 1) := by
  decide

end PartnerSwitching
end CumulativeAccessibility
