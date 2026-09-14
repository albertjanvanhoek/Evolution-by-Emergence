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

/-- Growth/maintenance objective used in the paper's linear worked model. -/
noncomputable def growthObjective
    (g0 eta gamma beta k L c0 c1 : ℝ) : ℝ :=
  g0
    - L * zStar eta gamma beta k
    - c0 * k
    - c1 * k * zStar eta gamma beta k

/-- Regulatory advantage over the unregulated state under the paper's
declared scalar growth/maintenance objective. -/
noncomputable def deltaGrowth
    (eta gamma beta k L c0 c1 : ℝ) : ℝ :=
  L * (eta / gamma - zStar eta gamma beta k)
    - c0 * k
    - c1 * k * zStar eta gamma beta k

/-- Net activity-return coefficient in the linear model. -/
noncomputable def returnGap
    (gamma beta L c1 : ℝ) : ℝ :=
  beta * L - c1 * gamma

/-- Reduced one-variable cost whose minimizer is the maximizer of the linear
growth objective after the change of variable d = gamma + beta*k. -/
noncomputable def reducedRegulatoryCost
    (eta A c0 d : ℝ) : ℝ :=
  c0 * d + eta * A / d

/-- Boundary derivative of the general z-coordinate objective, expressed only
through the marginal deviation value phiSlope = Φ'(m) and marginal
constitutive controller cost costSlope = C'(k_func). -/
noncomputable def boundaryDerivative
    (m eta gamma beta c1 phiSlope costSlope : ℝ) : ℝ :=
  -phiSlope
    + eta * costSlope / (beta * m^2)
    + c1 * gamma / beta

/-- Effective marginal value of reducing deviation after accounting for the
activity-dependent controller term. -/
noncomputable def netMarginalValue
    (phiSlope c1 gamma beta : ℝ) : ℝ :=
  phiSlope - c1 * gamma / beta

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

/-- The linear growth objective is, up to a k-independent constant and the
positive factor 1/beta, minus reducedRegulatoryCost at
d = gamma + beta*k. -/
theorem growthObjective_reducedCost
    (g0 eta gamma beta k L c0 c1 : ℝ)
    (hbeta : beta ≠ 0)
    (hden : gamma + beta * k ≠ 0) :
    growthObjective g0 eta gamma beta k L c0 c1
      =
      g0 + c0 * gamma / beta - c1 * eta / beta
        - reducedRegulatoryCost eta (returnGap gamma beta L c1) c0
            (gamma + beta * k) / beta := by
  unfold growthObjective zStar reducedRegulatoryCost returnGap
  field_simp [hbeta, hden]
  ring

/-- Exact square factorization around any positive stationary denominator d0
satisfying eta*A = c0*d0^2. -/
theorem reducedRegulatoryCost_sub_at_stationary
    (eta A c0 d d0 : ℝ)
    (hd : d ≠ 0)
    (hd0 : d0 ≠ 0)
    (hstationary : eta * A = c0 * d0^2) :
    reducedRegulatoryCost eta A c0 d
      - reducedRegulatoryCost eta A c0 d0
      =
      c0 * (d - d0)^2 / d := by
  unfold reducedRegulatoryCost
  rw [hstationary]
  field_simp [hd, hd0]
  ring

/-- A positive stationary denominator globally minimizes the reduced cost.
This supplies an algebraic global-optimum certificate for the linear model,
without relying only on a pointwise second-derivative check. -/
theorem reducedRegulatoryCost_min_of_stationary
    (eta A c0 d d0 : ℝ)
    (hc0 : 0 ≤ c0)
    (hd : 0 < d)
    (hd0 : 0 < d0)
    (hstationary : eta * A = c0 * d0^2) :
    reducedRegulatoryCost eta A c0 d0
      ≤ reducedRegulatoryCost eta A c0 d := by
  have hfac := reducedRegulatoryCost_sub_at_stationary
    eta A c0 d d0 (ne_of_gt hd) (ne_of_gt hd0) hstationary
  have hnon : 0 ≤ c0 * (d - d0)^2 / d := by positivity
  linarith

/-- Hence any feasible k0 whose denominator satisfies the stationary square
relation is a global maximizer of the paper's linear growth objective over all
k with positive denominator. -/
theorem growthObjective_le_of_stationary
    (g0 eta gamma beta L c0 c1 k k0 : ℝ)
    (hbeta : 0 < beta)
    (hc0 : 0 ≤ c0)
    (hden : 0 < gamma + beta * k)
    (hden0 : 0 < gamma + beta * k0)
    (hstationary :
      eta * returnGap gamma beta L c1
        = c0 * (gamma + beta * k0)^2) :
    growthObjective g0 eta gamma beta k L c0 c1
      ≤ growthObjective g0 eta gamma beta k0 L c0 c1 := by
  rw [growthObjective_reducedCost g0 eta gamma beta k L c0 c1
    (ne_of_gt hbeta) (ne_of_gt hden)]
  rw [growthObjective_reducedCost g0 eta gamma beta k0 L c0 c1
    (ne_of_gt hbeta) (ne_of_gt hden0)]
  have hmin := reducedRegulatoryCost_min_of_stationary
    eta (returnGap gamma beta L c1) c0
    (gamma + beta * k) (gamma + beta * k0)
    hc0 hden hden0 hstationary
  have hscaled :
      reducedRegulatoryCost eta (returnGap gamma beta L c1) c0
          (gamma + beta * k0) / beta
        ≤
      reducedRegulatoryCost eta (returnGap gamma beta L c1) c0
          (gamma + beta * k) / beta := by
    exact (div_le_div_iff_of_pos_right hbeta).2 hmin
  linarith

/-- A candidate satisfying the first-order stationarity equation has the
paper's stated relation between selected denominator and cost-return balance. -/
theorem stationarity_rearrangement
    (eta gamma beta k A c0 : ℝ)
    (h :
      eta * A = c0 * (gamma + beta * k)^2) :
    eta * A - c0 * (gamma + beta * k)^2 = 0 := by
  linarith

/-- Scaling the general boundary derivative by the positive denominator
beta*m^2 exposes the exact marginal-alignment numerator. -/
theorem boundaryDerivative_scaled
    (m eta gamma beta c1 phiSlope costSlope : ℝ)
    (hbeta : beta ≠ 0)
    (hm : m ≠ 0) :
    beta * m^2 *
        boundaryDerivative m eta gamma beta c1 phiSlope costSlope
      =
      -beta * m^2 * phiSlope
        + eta * costSlope
        + c1 * gamma * m^2 := by
  unfold boundaryDerivative
  field_simp [hbeta, hm]
  ring

/-- General marginal-alignment theorem in local form. Under beta>0 and m>0,
the boundary derivative is nonpositive exactly when the marginal value of
holding the functional boundary covers the marginal constitutive price of the
gain required there, including the activity-cost correction. -/
theorem boundaryDerivative_nonpos_iff_alignment
    (m eta gamma beta c1 phiSlope costSlope : ℝ)
    (hbeta : 0 < beta)
    (hm : 0 < m) :
    boundaryDerivative m eta gamma beta c1 phiSlope costSlope ≤ 0
      ↔
      eta * costSlope + c1 * gamma * m^2
        ≤ beta * m^2 * phiSlope := by
  have hscale : 0 < beta * m^2 := by positivity
  have hid := boundaryDerivative_scaled
    m eta gamma beta c1 phiSlope costSlope
    (ne_of_gt hbeta) (ne_of_gt hm)
  constructor <;> intro h <;> nlinarith

/-- The effective-value form of the same alignment inequality. -/
theorem alignment_iff_netMarginalValue
    (m eta gamma beta c1 phiSlope costSlope : ℝ)
    (hbeta : beta ≠ 0) :
    eta * costSlope + c1 * gamma * m^2
        ≤ beta * m^2 * phiSlope
      ↔
      eta * costSlope
        ≤ beta * m^2 *
            netMarginalValue phiSlope c1 gamma beta := by
  unfold netMarginalValue
  field_simp [hbeta]
  constructor <;> intro h <;> nlinarith

/-- Linear-cost, linear-penalty specialization of the master inequality. -/
theorem linear_alignment_iff_returnGap
    (m eta gamma beta L c0 c1 : ℝ) :
    eta * c0 + c1 * gamma * m^2
        ≤ beta * m^2 * L
      ↔
      eta * c0
        ≤ (beta * L - c1 * gamma) * m^2 := by
  constructor <;> intro h <;> nlinarith

/-- For the scaled power penalty Φ_p(z)=L*m*(z/m)^p, whose boundary slope is
L*p, the alignment criterion is the exact un-divided p-threshold inequality. -/
theorem power_penalty_alignment_iff
    (m eta gamma beta L c0 c1 p : ℝ) :
    eta * c0 + c1 * gamma * m^2
        ≤ beta * m^2 * (L * p)
      ↔
      eta * c0 + c1 * gamma * m^2
        ≤ beta * L * p * m^2 := by
  ring_nf

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
#print axioms growthObjective_reducedCost
#print axioms reducedRegulatoryCost_sub_at_stationary
#print axioms reducedRegulatoryCost_min_of_stationary
#print axioms growthObjective_le_of_stationary
#print axioms stationarity_rearrangement
#print axioms boundaryDerivative_scaled
#print axioms boundaryDerivative_nonpos_iff_alignment
#print axioms alignment_iff_netMarginalValue
#print axioms linear_alignment_iff_returnGap
#print axioms power_penalty_alignment_iff
#print axioms pooled_return_numerator

end RegulatoryReturn
