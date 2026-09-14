import Mathlib

namespace RegulatoryReturn

/-- Steady-state deviation under proportional negative feedback. -/
noncomputable def zStar
    (eta gamma beta k : ℝ) : ℝ :=
  eta / (gamma + beta * k)

/-- Functional margin relative to tolerated deviation m. -/
noncomputable def functionalMargin
    (m eta gamma beta k : ℝ) : ℝ :=
  m - zStar eta gamma beta k

/-- Regulatory advantage over the unregulated state under the paper's
declared scalar growth/maintenance objective. -/
noncomputable def deltaGrowth
    (eta gamma beta k L c0 c1 : ℝ) : ℝ :=
  L * (eta / gamma - zStar eta gamma beta k)
    - c0 * k
    - c1 * k * zStar eta gamma beta k

/-- Net activity-return coefficient. -/
noncomputable def returnGap
    (gamma beta L c1 : ℝ) : ℝ :=
  beta * L - c1 * gamma

/-- Functional sufficiency is exactly the load-versus-control inequality. -/
theorem margin_nonneg_iff_load_le
    (m eta gamma beta k : ℝ)
    (hden : 0 < gamma + beta * k) :
    0 ≤ functionalMargin m eta gamma beta k
      ↔ eta ≤ m * (gamma + beta * k) := by
  unfold functionalMargin zStar
  constructor
  · intro h
    have hdiv : eta / (gamma + beta * k) ≤ m := by linarith
    exact (div_le_iff₀ hden).mp hdiv
  · intro h
    have hdiv : eta / (gamma + beta * k) ≤ m := by
      exact (div_le_iff₀ hden).2 h
    linarith

/-- Exact factorization of regulatory return. -/
theorem deltaGrowth_factor
    (eta gamma beta k L c0 c1 : ℝ)
    (hgamma : gamma ≠ 0)
    (hden : gamma + beta * k ≠ 0) :
    deltaGrowth eta gamma beta k L c0 c1
      =
      k *
        (eta * (beta * L - c1 * gamma)
          - c0 * gamma * (gamma + beta * k))
        /
        (gamma * (gamma + beta * k)) := by
  unfold deltaGrowth zStar
  field_simp [hgamma, hden]
  ring

/-- If the return numerator is positive, positive controller gain produces a
positive regulatory advantage. -/
theorem deltaGrowth_pos_of_return_condition
    (eta gamma beta k L c0 c1 : ℝ)
    (hgamma : 0 < gamma)
    (hden : 0 < gamma + beta * k)
    (hk : 0 < k)
    (hret :
      c0 * gamma * (gamma + beta * k)
        < eta * (beta * L - c1 * gamma)) :
    0 < deltaGrowth eta gamma beta k L c0 c1 := by
  rw [deltaGrowth_factor eta gamma beta k L c0 c1
    (ne_of_gt hgamma) (ne_of_gt hden)]
  have hnum :
      0 <
        eta * (beta * L - c1 * gamma)
          - c0 * gamma * (gamma + beta * k) := by
    linarith
  exact div_pos (mul_pos hk hnum) (mul_pos hgamma hden)

/-- If the activity-return coefficient is nonpositive and all charged costs
and loads are nonnegative, positive-gain regulation cannot have positive
return under this objective. -/
theorem deltaGrowth_nonpos_of_returnGap_nonpos
    (eta gamma beta k L c0 c1 : ℝ)
    (heta : 0 ≤ eta)
    (hgamma : 0 < gamma)
    (hden : 0 < gamma + beta * k)
    (hk : 0 ≤ k)
    (hc0 : 0 ≤ c0)
    (hgap : beta * L - c1 * gamma ≤ 0) :
    deltaGrowth eta gamma beta k L c0 c1 ≤ 0 := by
  rw [deltaGrowth_factor eta gamma beta k L c0 c1
    (ne_of_gt hgamma) (ne_of_gt hden)]
  have hfirst : eta * (beta * L - c1 * gamma) ≤ 0 := by
    exact mul_nonpos_of_nonneg_of_nonpos heta hgap
  have hcost : 0 ≤ c0 * gamma * (gamma + beta * k) := by positivity
  have hnum :
      eta * (beta * L - c1 * gamma)
        - c0 * gamma * (gamma + beta * k) ≤ 0 := by
    linarith
  have hmul :
      k *
        (eta * (beta * L - c1 * gamma)
          - c0 * gamma * (gamma + beta * k)) ≤ 0 := by
    exact mul_nonpos_of_nonneg_of_nonpos hk hnum
  exact div_nonpos_of_nonpos_of_nonneg hmul (le_of_lt (mul_pos hgamma hden))

/-- A candidate satisfying the first-order stationarity equation has the
paper's stated relation between selected denominator and cost-return balance. -/
theorem stationarity_rearrangement
    (eta gamma beta k A c0 : ℝ)
    (h :
      eta * A = c0 * (gamma + beta * k)^2) :
    eta * A - c0 * (gamma + beta * k)^2 = 0 := by
  linarith

/-- Pooling a constitutive cost across n beneficiaries replaces c0 by c0/n
algebraically; this theorem records the corresponding return numerator. -/
theorem pooled_return_numerator
    (eta gamma beta k L c0 c1 n : ℝ) :
    eta * (beta * L - c1 * gamma)
      - (c0 / n) * gamma * (gamma + beta * k)
    =
    eta * returnGap gamma beta L c1
      - (c0 / n) * gamma * (gamma + beta * k) := by
  unfold returnGap
  rfl

#print axioms margin_nonneg_iff_load_le
#print axioms deltaGrowth_factor
#print axioms deltaGrowth_pos_of_return_condition
#print axioms deltaGrowth_nonpos_of_returnGap_nonpos
#print axioms stationarity_rearrangement
#print axioms pooled_return_numerator

end RegulatoryReturn
