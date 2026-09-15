import Mathlib

namespace CollectiveAlignment

/-!
# Collective alignment: machine-checked algebraic core

This file formalizes five narrow results used in the paper
"Sufficient Alignment: A Viability Framework for Collective Intelligence".

1. Signal fidelity: a policy acting on a deterministic garbling of a signal
   can be lifted to the ungarbled signal with identical weighted value.
2. Redundant correction: a 2-out-of-3 independent reliability model has
   reliability R(p)=3p^2-2p^3, is monotone on [0,1], crosses 1/2 exactly
   at p=1/2, and strictly improves on individual reliability for p>1/2.
3. Selected vs sufficient alignment: a quadratic private objective has
   selected optimum e=v/c, which can fall below the network viability threshold.
4. Protocol inheritance: R_protocol=m*p has exact threshold p>1/m for
   R_protocol>1, and expected carrier counts grow/decline on the two sides.
5. Repair: restoring a damaged edge weakly dominates termination exactly
   when expected recovered edge surplus exceeds repair cost.

The full stochastic Blackwell theorem, general k-out-of-n reliability theory,
Galton--Watson extinction theorem, and repeated-game forgiveness results are
classical external results and are not re-proved here.
-/

section SignalFidelity

variable {Ω S Y A : Type*} [Fintype Ω]

/-- Weighted decision value for a finite set of world states. The weights
may be probabilities, unnormalized probabilities, or other declared
nonnegative importance weights; the lifting identity itself does not require
normalization. -/
noncomputable def weightedValue
    (w : Ω → ℝ) (u : Ω → A → ℝ)
    (obs : Ω → S) (π : S → A) : ℝ :=
  ∑ ω, w ω * u ω (π (obs ω))

/-- A policy on a garbled signal can be implemented after observing the
ungarbled signal by first applying the garbling map. -/
def liftPolicy (g : S → Y) (π : Y → A) : S → A :=
  fun s => π (g s)

/-- Finite deterministic signal-fidelity theorem: every policy available
after a deterministic garbling has an exactly value-matched lifted policy
on the original signal. -/
theorem garbled_policy_lifts_exactly
    (w : Ω → ℝ) (u : Ω → A → ℝ)
    (obs : Ω → S) (g : S → Y) (πY : Y → A) :
    weightedValue w u (fun ω => g (obs ω)) πY
      =
    weightedValue w u obs (liftPolicy g πY) := by
  rfl

/-- Equivalent existential form: the ungarbled signal's policy class contains
a policy matching any declared policy that uses only the garbled signal. -/
theorem ungarbled_can_match_any_garbled_policy
    (w : Ω → ℝ) (u : Ω → A → ℝ)
    (obs : Ω → S) (g : S → Y) (πY : Y → A) :
    ∃ πS : S → A,
      weightedValue w u obs πS
        =
      weightedValue w u (fun ω => g (obs ω)) πY := by
  refine ⟨liftPolicy g πY, ?_⟩
  symm
  exact garbled_policy_lifts_exactly w u obs g πY

end SignalFidelity

section RedundantCorrection

/-- Reliability of an independent 2-out-of-3 system whose three component
channels each function with probability p. -/
def majority3Reliability (p : ℝ) : ℝ :=
  3 * p^2 - 2 * p^3

/-- Reliability is monotone in component reliability on the probability
interval. -/
theorem majority3_monotone
    {p q : ℝ}
    (hp0 : 0 ≤ p) (hpq : p ≤ q) (hq1 : q ≤ 1) :
    majority3Reliability p ≤ majority3Reliability q := by
  have hp1 : p ≤ 1 := hpq.trans hq1
  have hp2 : p^2 ≤ p := by
    nlinarith [mul_nonneg hp0 (sub_nonneg.mpr hp1)]
  have hq0 : 0 ≤ q := hp0.trans hpq
  have hq2 : q^2 ≤ q := by
    nlinarith [mul_nonneg hq0 (sub_nonneg.mpr hq1)]
  have hsq : 0 ≤ (p - q)^2 := sq_nonneg (p - q)
  have hbracket :
      0 ≤ 3 * (p + q) - 2 * (p^2 + p*q + q^2) := by
    nlinarith
  have hprod :
      0 ≤ (q - p) * (3 * (p + q) - 2 * (p^2 + p*q + q^2)) :=
    mul_nonneg (sub_nonneg.mpr hpq) hbracket
  unfold majority3Reliability
  nlinarith

/-- In the symmetric 2-out-of-3 model, system reliability reaches one half
exactly when individual channel reliability reaches one half. -/
theorem majority3_half_threshold
    {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1) :
    (1 / 2 : ℝ) ≤ majority3Reliability p ↔ (1 / 2 : ℝ) ≤ p := by
  have hfac : 0 < -2*p^2 + 2*p + 1 := by
    have hm : 0 ≤ p * (1 - p) := mul_nonneg hp0 (sub_nonneg.mpr hp1)
    nlinarith
  have hid :
      majority3Reliability p - (1/2 : ℝ)
        =
      (p - (1/2 : ℝ)) * (-2*p^2 + 2*p + 1) := by
    unfold majority3Reliability
    ring
  constructor
  · intro hR
    by_contra hnot
    have hpneg : p - (1/2 : ℝ) < 0 := by
      exact sub_neg.mpr (lt_of_not_ge hnot)
    have hneg :
        (p - (1/2 : ℝ)) * (-2*p^2 + 2*p + 1) < 0 :=
      mul_neg_of_neg_of_pos hpneg hfac
    nlinarith
  · intro hp
    have hnonneg : 0 ≤ p - (1/2 : ℝ) := sub_nonneg.mpr hp
    have hprod :
        0 ≤ (p - (1/2 : ℝ)) * (-2*p^2 + 2*p + 1) :=
      mul_nonneg hnonneg (le_of_lt hfac)
    nlinarith

/-- Above one-half individual reliability (and below perfection), 2-out-of-3
redundancy is strictly more reliable than a single channel. -/
theorem majority3_redundancy_gain
    {p : ℝ} (hp : (1/2 : ℝ) < p) (hp1 : p < 1) :
    p < majority3Reliability p := by
  have hp0 : 0 < p := lt_trans (by norm_num) hp
  have h1 : 0 < 1 - p := sub_pos.mpr hp1
  have h2 : 0 < 2*p - 1 := by nlinarith
  have hprod : 0 < p * (1-p) * (2*p-1) :=
    mul_pos (mul_pos hp0 h1) h2
  unfold majority3Reliability
  nlinarith

section SelectedVsSufficient

/-- Minimal private objective for investment in alignment/correction effort. -/
noncomputable def alignmentObjective (v cost e : ℝ) : ℝ :=
  v * e - (cost / 2) * e^2

/-- Interior selected effort in the quadratic toy model. -/
noncomputable def selectedAlignment (v cost : ℝ) : ℝ :=
  v / cost

/-- Completing the square gives a global optimum certificate when cost > 0. -/
theorem alignmentObjective_gap
    {v cost e : ℝ} (hcost : cost ≠ 0) :
    alignmentObjective v cost (selectedAlignment v cost)
      - alignmentObjective v cost e
      =
    (cost / 2) * (e - selectedAlignment v cost)^2 := by
  unfold alignmentObjective selectedAlignment
  field_simp [hcost]
  ring

/-- With positive convex cost, selectedAlignment is a global maximizer. -/
theorem selectedAlignment_global_max
    {v cost e : ℝ} (hcost : 0 < cost) :
    alignmentObjective v cost e
      ≤
    alignmentObjective v cost (selectedAlignment v cost) := by
  have hgap := alignmentObjective_gap (v := v) (cost := cost) (e := e) hcost.ne'
  have hsq : 0 ≤ (e - selectedAlignment v cost)^2 := sq_nonneg _
  have hc2 : 0 ≤ cost / 2 := by positivity
  have hnonneg : 0 ≤ (cost / 2) * (e - selectedAlignment v cost)^2 :=
    mul_nonneg hc2 hsq
  nlinarith

/-- Exact boundary: the selected private optimum reaches the 2-out-of-3
half-viability threshold exactly when private marginal value is large enough
relative to convex alignment cost. -/
theorem selectedAlignment_reaches_half_iff
    {v cost : ℝ} (hcost : 0 < cost) :
    (1/2 : ℝ) ≤ selectedAlignment v cost
      ↔
    cost ≤ 2 * v := by
  unfold selectedAlignment
  constructor
  · intro h
    have hm := (le_div_iff₀ hcost).1 h
    nlinarith
  · intro h
    apply (le_div_iff₀ hcost).2
    nlinarith

/-- Private selection can underprovide the network's declared half-threshold. -/
theorem selectedAlignment_insufficient_if
    {v cost : ℝ} (hcost : 0 < cost) (hunder : 2 * v < cost) :
    selectedAlignment v cost < (1/2 : ℝ) := by
  unfold selectedAlignment
  apply (div_lt_iff₀ hcost).2
  nlinarith

end SelectedVsSufficient

end RedundantCorrection

section ProtocolInheritance

/-- Mean protocol reproduction number: m teaching opportunities per carrier,
each retained successfully with probability/efficacy p. -/
def protocolR (m p : ℝ) : ℝ := m * p

/-- More successful transmission cannot lower the mean reproduction number. -/
theorem protocolR_monotone
    {m p q : ℝ} (hm : 0 ≤ m) (hpq : p ≤ q) :
    protocolR m p ≤ protocolR m q := by
  unfold protocolR
  exact mul_le_mul_of_nonneg_left hpq hm

/-- Exact scalar threshold for a super-unit mean reproduction number. -/
theorem protocolR_supercritical_iff
    {m p : ℝ} (hm : 0 < m) :
    1 < protocolR m p ↔ 1 / m < p := by
  unfold protocolR
  constructor
  · intro h
    exact (div_lt_iff₀ hm).2 (by simpa [mul_comm] using h)
  · intro h
    have := (div_lt_iff₀ hm).1 h
    simpa [mul_comm] using this

/-- Expected number of carriers after n homogeneous generations. -/
def expectedCarriers (N0 R : ℝ) (n : ℕ) : ℝ :=
  N0 * R^n

theorem expectedCarriers_step (N0 R : ℝ) (n : ℕ) :
    expectedCarriers N0 R (n+1)
      =
    expectedCarriers N0 R n * R := by
  unfold expectedCarriers
  rw [pow_succ]
  ring

/-- Above unit reproduction, a positive expected carrier count grows each
generation in the homogeneous expectation model. -/
theorem supercritical_expected_growth
    {N0 R : ℝ} (hN : 0 < N0) (hR : 1 < R) (n : ℕ) :
    expectedCarriers N0 R n < expectedCarriers N0 R (n+1) := by
  have hR0 : 0 < R := lt_trans zero_lt_one hR
  have hpow : 0 < R^n := pow_pos hR0 n
  have hE : 0 < expectedCarriers N0 R n := by
    unfold expectedCarriers
    positivity
  rw [expectedCarriers_step]
  nlinarith

/-- Between zero and one reproduction, a positive expected carrier count
declines each generation. -/
theorem subcritical_expected_decline
    {N0 R : ℝ} (hN : 0 < N0) (hR0 : 0 < R) (hR1 : R < 1) (n : ℕ) :
    expectedCarriers N0 R (n+1) < expectedCarriers N0 R n := by
  have hpow : 0 < R^n := pow_pos hR0 n
  have hE : 0 < expectedCarriers N0 R n := by
    unfold expectedCarriers
    positivity
  rw [expectedCarriers_step]
  nlinarith

end ProtocolInheritance

section RepairBoundary

/-- Expected value of attempting repair of a damaged collaborative edge.
With probability r, repair restores edge value V; otherwise the system falls
back to outside-option value W. C is the repair cost. -/
def repairValue (r V W C : ℝ) : ℝ :=
  r * V + (1-r) * W - C

def terminateValue (W : ℝ) : ℝ := W

/-- Exact repair/forgiveness boundary: repair weakly dominates termination
iff expected recovered surplus exceeds repair cost. -/
theorem repair_weakly_better_iff
    (r V W C : ℝ) :
    terminateValue W ≤ repairValue r V W C
      ↔
    C ≤ r * (V - W) := by
  unfold repairValue terminateValue
  constructor <;> intro h <;> nlinarith

/-- Strict version of the repair boundary. -/
theorem repair_strictly_better_iff
    (r V W C : ℝ) :
    terminateValue W < repairValue r V W C
      ↔
    C < r * (V - W) := by
  unfold repairValue terminateValue
  constructor <;> intro h <;> nlinarith

/-- If repair cost exceeds expected recovered surplus, termination is strictly
better in this one-step model. -/
theorem terminate_strictly_better_if_repair_too_costly
    {r V W C : ℝ}
    (h : r * (V - W) < C) :
    repairValue r V W C < terminateValue W := by
  unfold repairValue terminateValue
  nlinarith

end RepairBoundary

#print axioms garbled_policy_lifts_exactly
#print axioms ungarbled_can_match_any_garbled_policy
#print axioms majority3_monotone
#print axioms majority3_half_threshold
#print axioms majority3_redundancy_gain
#print axioms alignmentObjective_gap
#print axioms selectedAlignment_global_max
#print axioms selectedAlignment_reaches_half_iff
#print axioms selectedAlignment_insufficient_if
#print axioms protocolR_monotone
#print axioms protocolR_supercritical_iff
#print axioms supercritical_expected_growth
#print axioms subcritical_expected_decline
#print axioms repair_weakly_better_iff
#print axioms repair_strictly_better_iff
#print axioms terminate_strictly_better_if_repair_too_costly

end CollectiveAlignment
