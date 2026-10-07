namespace CumulativeAccessibility
namespace CareTransfer

/-!
# Care as a transfer, and what keeps it going

`NetworkVortexLedger.internallyViable_iff_exists_viable_transfer` says a whole
is viable exactly when some transfer lets every part cover its upkeep, and
`transfer_breaks_part_with_whole_unchanged` says a transfer can break a part
while the whole is unchanged.  This module makes both concrete for care: one
node that cannot cover its upkeep alone (the cared-for) and one that covers
the shortfall (the carer).  It is the formal side of
`research/health-of-intelligence/HEALTH_OF_THE_COMMONS.md`.

Setting, in whole units per step.
* The cared-for takes up `u` and needs `m > u`: alone, its reserve `Q` falls
  by the deficit `m - u` every step.
* The carer has slack `s` (uptake minus its own upkeep), gives care `c`
  every step, and receives respite `r` from the commons (other people,
  services, institutions).  Its reserve after `n` steps is
  `R + n * (s + r - c)` (`carerReserve`).

Results:
* `care_covers_need`: care equal to the deficit lets the cared-for cover its
  upkeep, keeps the carer viable exactly when it fits within the carer's
  slack, and leaves the sum of the two slacks unchanged: care moves slack, it
  does not create it.
* `care_lasts_iff`: from any reserve, care can be kept up at every step exactly
  when it is no more than the carer's slack plus respite.
* `carer_burns_out`: care beyond slack plus respite exhausts the carer's
  reserve by an explicit step.
* `cared_for_holds_while_cared_for`, `cared_for_falls_after_carer`: the
  cared-for holds its reserve while care lasts, and once care stops it falls
  within its own reserve.
* `respite_sustains_care`: respite that covers the gap keeps the carer's
  reserve from ever falling, so care can last indefinitely.
* `care_witness`: a carer with slack 1 giving care 3 from a reserve of 4 is
  exhausted at step 5; with respite 2 it never is.

So whether care lasts is decided by the carer's margin and by what the commons
returns to the carer, not by the cared-for.  The results are close to
arithmetic; the substance is in the setting, where the carer's own health is
part of the cared-for's.  Not covered: care whose cost or benefit changes over
time, several carers or cared-for, and the value of care beyond covering upkeep.
-/

/-- The carer's reserve after `n` steps: reserve `R`, slack `s`, respite `r`,
care given `c`. -/
def carerReserve (R s r c : Int) (n : Nat) : Int := R + (n : Int) * (s + r - c)

/-- The cared-for's reserve at step `k`, when care covering its deficit `d`
lasts until step `T`: it holds `Q` until then and falls by `d` each step after. -/
def caredReserve (Q d : Int) (T k : Nat) : Int :=
  if k ≤ T then Q else Q - ((k - T : Nat) : Int) * d

/-- **Care moves slack, it does not create it.**  A cared-for that cannot cover
its upkeep alone (`u < m`) covers it exactly with care `m - u`; the carer stays
viable exactly when that care fits in its slack; and the sum of the two slacks
is unchanged. -/
theorem care_covers_need (u m g mg : Int) :
    0 ≤ (u + (m - u)) - m ∧
    (0 ≤ (g - (m - u)) - mg ↔ m - u ≤ g - mg) ∧
    ((u + (m - u)) - m) + ((g - (m - u)) - mg) = (u - m) + (g - mg) := by
  refine ⟨by omega, by omega, by omega⟩

/-- **Care lasts exactly when it fits.**  From a nonnegative reserve, the carer
keeps a nonnegative reserve at every step exactly when the care it gives is no
more than its slack plus respite. -/
theorem care_lasts_iff {R s r c : Int} (hR : 0 ≤ R) :
    (∀ n : Nat, 0 ≤ carerReserve R s r c n) ↔ c ≤ s + r := by
  constructor
  · intro h
    apply Classical.byContradiction
    intro hlt
    have hx : s + r - c ≤ -1 := by omega
    have hn := h (R.toNat + 1)
    unfold carerReserve at hn
    have hnn : (0 : Int) ≤ ((R.toNat + 1 : Nat) : Int) := Int.natCast_nonneg _
    have hmul := Int.mul_le_mul_of_nonneg_left hx hnn
    have htoNat : ((R.toNat + 1 : Nat) : Int) = R + 1 := by
      rw [Int.natCast_add, Int.toNat_of_nonneg hR]; rfl
    rw [htoNat] at hmul hn
    rw [Int.mul_neg_one] at hmul
    generalize (R + 1) * (s + r - c) = P at hmul hn
    omega
  · intro hc n
    unfold carerReserve
    have hx : 0 ≤ s + r - c := by omega
    have hmul := Int.mul_nonneg (Int.natCast_nonneg n) hx
    generalize (n : Int) * (s + r - c) = P at hmul ⊢
    omega

/-- **The carer burns out.**  Care beyond slack plus respite exhausts the
carer's reserve by step `R + 1`. -/
theorem carer_burns_out {R s r c : Int} (hR : 0 ≤ R) (hc : s + r < c) :
    carerReserve R s r c (R.toNat + 1) < 0 := by
  unfold carerReserve
  have hx : s + r - c ≤ -1 := by omega
  have hnn : (0 : Int) ≤ ((R.toNat + 1 : Nat) : Int) := Int.natCast_nonneg _
  have hmul := Int.mul_le_mul_of_nonneg_left hx hnn
  have htoNat : ((R.toNat + 1 : Nat) : Int) = R + 1 := by
    rw [Int.natCast_add, Int.toNat_of_nonneg hR]; rfl
  rw [htoNat] at hmul ⊢
  rw [Int.mul_neg_one] at hmul
  generalize (R + 1) * (s + r - c) = P at hmul ⊢
  omega

/-- **Respite sustains care.**  When respite covers the gap between care and
slack, the carer's reserve never falls below where it started. -/
theorem respite_sustains_care {R s r c : Int} (hc : c ≤ s + r) (n : Nat) :
    R ≤ carerReserve R s r c n := by
  unfold carerReserve
  have hx : 0 ≤ s + r - c := by omega
  have hmul := Int.mul_nonneg (Int.natCast_nonneg n) hx
  generalize (n : Int) * (s + r - c) = P at hmul ⊢
  omega

/-- **The cared-for holds while cared for.** -/
theorem cared_for_holds_while_cared_for {Q d : Int} {T k : Nat} (hk : k ≤ T) :
    caredReserve Q d T k = Q := by
  simp [caredReserve, hk]

/-- **The cared-for falls after the carer.**  Once care stops at step `T`, a
cared-for that cannot live alone (`0 < d`) exhausts its own reserve by step
`T + Q + 1`. -/
theorem cared_for_falls_after_carer {Q d : Int} {T : Nat} (hQ : 0 ≤ Q) (hd : 0 < d) :
    caredReserve Q d T (T + Q.toNat + 1) < 0 := by
  unfold caredReserve
  have hgt : ¬ (T + Q.toNat + 1 ≤ T) := by omega
  rw [if_neg hgt]
  have hsub : T + Q.toNat + 1 - T = Q.toNat + 1 := by omega
  rw [hsub]
  have htoNat : ((Q.toNat + 1 : Nat) : Int) = Q + 1 := by
    rw [Int.natCast_add, Int.toNat_of_nonneg hQ]; rfl
  rw [htoNat]
  have hd1 : 1 ≤ d := by omega
  have hmul := Int.mul_le_mul_of_nonneg_left hd1 (by omega : (0 : Int) ≤ Q + 1)
  rw [Int.mul_one] at hmul
  generalize (Q + 1) * d = P at hmul ⊢
  omega

/-- A carer with reserve 4 and slack 1 giving care 3 is exhausted at step 5;
with respite 2 from the commons its reserve never falls. -/
theorem care_witness :
    carerReserve 4 1 0 3 5 < 0 ∧ ∀ n : Nat, 4 ≤ carerReserve 4 1 2 3 n := by
  refine ⟨by decide, fun n => respite_sustains_care (by decide) n⟩

end CareTransfer
end CumulativeAccessibility
