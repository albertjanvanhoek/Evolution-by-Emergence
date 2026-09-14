import Mathlib

namespace PersistenceDrift

open Finset
open scoped BigOperators

variable {Arch Cap : Type*}

def FunctionallyEquivalent (capacity : Arch → Cap) (a b : Arch) : Prop :=
  capacity a = capacity b

def slack (returnRate maintenanceCost : ℝ) : ℝ :=
  returnRate - maintenanceCost

theorem cheaper_functionally_equivalent_increases_slack
    (capacity : Arch → Cap)
    (returnRate : Cap → ℝ)
    (cost : Arch → ℝ)
    (a b : Arch)
    (hfun : FunctionallyEquivalent capacity a b)
    (hcost : cost b ≤ cost a) :
    slack (returnRate (capacity a)) (cost a)
      ≤ slack (returnRate (capacity b)) (cost b) := by
  unfold FunctionallyEquivalent at hfun
  unfold slack
  rw [hfun]
  linarith

theorem strictly_cheaper_functionally_equivalent_increases_slack
    (capacity : Arch → Cap)
    (returnRate : Cap → ℝ)
    (cost : Arch → ℝ)
    (a b : Arch)
    (hfun : FunctionallyEquivalent capacity a b)
    (hcost : cost b < cost a) :
    slack (returnRate (capacity a)) (cost a)
      < slack (returnRate (capacity b)) (cost b) := by
  unfold FunctionallyEquivalent at hfun
  unfold slack
  rw [hfun]
  linarith

theorem cheaper_functionally_equivalent_increases_exploration
    (capacity : Arch → Cap)
    (returnRate : Cap → ℝ)
    (cost : Arch → ℝ)
    (candidateRate : ℝ → ℝ)
    (hmono : Monotone candidateRate)
    (a b : Arch)
    (hfun : FunctionallyEquivalent capacity a b)
    (hcost : cost b ≤ cost a) :
    candidateRate (slack (returnRate (capacity a)) (cost a))
      ≤ candidateRate (slack (returnRate (capacity b)) (cost b)) := by
  apply hmono
  exact cheaper_functionally_equivalent_increases_slack
    capacity returnRate cost a b hfun hcost

variable {I : Type*} [Fintype I]

noncomputable def pairedDrift
    (weight gain pPlus pMinus : I → ℝ) : ℝ :=
  ∑ i, weight i * gain i * (pPlus i - pMinus i)

theorem paired_drift_nonneg
    (weight gain pPlus pMinus : I → ℝ)
    (hweight : ∀ i, 0 ≤ weight i)
    (hgain : ∀ i, 0 ≤ gain i)
    (hselect : ∀ i, pMinus i ≤ pPlus i) :
    0 ≤ pairedDrift weight gain pPlus pMinus := by
  unfold pairedDrift
  refine Finset.sum_nonneg ?_
  intro i hi
  have hdiff : 0 ≤ pPlus i - pMinus i := sub_nonneg.mpr (hselect i)
  exact mul_nonneg (mul_nonneg (hweight i) (hgain i)) hdiff

theorem paired_drift_mono_in_selection
    (weight gain pPlus₁ pMinus₁ pPlus₂ pMinus₂ : I → ℝ)
    (hweight : ∀ i, 0 ≤ weight i)
    (hgain : ∀ i, 0 ≤ gain i)
    (hsel :
      ∀ i, pPlus₁ i - pMinus₁ i ≤ pPlus₂ i - pMinus₂ i) :
    pairedDrift weight gain pPlus₁ pMinus₁
      ≤ pairedDrift weight gain pPlus₂ pMinus₂ := by
  unfold pairedDrift
  refine Finset.sum_le_sum ?_
  intro i hi
  exact mul_le_mul_of_nonneg_left
    (hsel i)
    (mul_nonneg (hweight i) (hgain i))

theorem functional_efficiency_opens_search
    (capacity : Arch → Cap)
    (returnRate : Cap → ℝ)
    (cost : Arch → ℝ)
    (candidateRate : ℝ → ℝ)
    (hmono : Monotone candidateRate)
    (a b : Arch)
    (hfun : FunctionallyEquivalent capacity a b)
    (hcost : cost b < cost a) :
    slack (returnRate (capacity a)) (cost a)
        < slack (returnRate (capacity b)) (cost b)
    ∧
    candidateRate (slack (returnRate (capacity a)) (cost a))
        ≤ candidateRate (slack (returnRate (capacity b)) (cost b)) := by
  constructor
  · exact strictly_cheaper_functionally_equivalent_increases_slack
      capacity returnRate cost a b hfun hcost
  · apply hmono
    exact (strictly_cheaper_functionally_equivalent_increases_slack
      capacity returnRate cost a b hfun hcost).le


/-! ###########################################################################
# 5. Direction derived from competition among equivalent implementations

This section removes the directional establishment assumption used by
`paired_drift_nonneg` and derives a sign directly from a two-type replicator
model.

The two types are assumed to realize the SAME focal capacity. Their difference
is implementation cost. If higher cost lowers net reproduction, competition
pushes the mean cost downward.

For two implementations A and B, let p be the frequency of A and 1-p the
frequency of B. The standard two-type replicator velocity is

  p_dot = p (1-p) (rA - rB).

The instantaneous velocity of mean implementation cost is therefore

  cbar_dot = p_dot (cA - cB).

No direction has yet been assumed. Direction follows when reproduction is
anti-monotone in implementation cost.
############################################################################ -/

/-- Two-type replicator velocity for the frequency of implementation A. -/
def twoTypeShareVelocity
    (p rA rB : ℝ) : ℝ :=
  p * (1 - p) * (rA - rB)

/-- Instantaneous velocity of the mean implementation cost
    cbar = p*cA + (1-p)*cB. -/
def twoTypeMeanCostVelocity
    (p cA cB rA rB : ℝ) : ℝ :=
  twoTypeShareVelocity p rA rB * (cA - cB)

/-- General directional theorem.

If p is a valid mixture fraction and cost and reproduction are oppositely
ordered, then competition cannot increase mean implementation cost.
-/
theorem two_type_competition_mean_cost_nonincreasing
    (p cA cB rA rB : ℝ)
    (hp0 : 0 ≤ p)
    (hp1 : p ≤ 1)
    (hanti : (cA - cB) * (rA - rB) ≤ 0) :
    twoTypeMeanCostVelocity p cA cB rA rB ≤ 0 := by
  unfold twoTypeMeanCostVelocity twoTypeShareVelocity
  have hmix : 0 ≤ p * (1 - p) := by
    exact mul_nonneg hp0 (sub_nonneg.mpr hp1)
  have hrewrite :
      p * (1 - p) * (rA - rB) * (cA - cB)
        = (p * (1 - p)) * ((cA - cB) * (rA - rB)) := by
    ring
  rw [hrewrite]
  exact mul_nonpos_of_nonneg_of_nonpos hmix hanti

/-- Linear cost law: both implementations provide the same functional benefit
    b, while implementation cost reduces net reproduction with coefficient
    alpha >= 0. -/
def costFitness (benefit alpha cost : ℝ) : ℝ :=
  benefit - alpha * cost

/-- Exact identity: under the linear cost law, mean-cost velocity is a negative
quadratic in the cost difference. This is the two-type variance identity. -/
theorem two_type_linear_cost_exact
    (p benefit alpha cA cB : ℝ) :
    twoTypeMeanCostVelocity p cA cB
      (costFitness benefit alpha cA)
      (costFitness benefit alpha cB)
    =
    -alpha * p * (1 - p) * (cA - cB)^2 := by
  unfold twoTypeMeanCostVelocity twoTypeShareVelocity costFitness
  ring

/-- Consequently, for alpha >= 0 and a valid mixture, mean implementation cost
cannot increase. Direction is derived from the dynamics rather than inserted as
an establishment-probability assumption. -/
theorem two_type_linear_cost_nonincreasing
    (p benefit alpha cA cB : ℝ)
    (hp0 : 0 ≤ p)
    (hp1 : p ≤ 1)
    (halpha : 0 ≤ alpha) :
    twoTypeMeanCostVelocity p cA cB
      (costFitness benefit alpha cA)
      (costFitness benefit alpha cB)
      ≤ 0 := by
  rw [two_type_linear_cost_exact]
  have hmix : 0 ≤ p * (1 - p) := by
    exact mul_nonneg hp0 (sub_nonneg.mpr hp1)
  have hsq : 0 ≤ (cA - cB)^2 := sq_nonneg (cA - cB)
  have hprod : 0 ≤ alpha * p * (1 - p) * (cA - cB)^2 := by
    exact mul_nonneg (mul_nonneg (mul_nonneg halpha hp0) (sub_nonneg.mpr hp1)) hsq
  linarith

/-- If functional return is fixed, slack velocity is the negative of mean-cost
velocity. -/
def twoTypeSlackVelocity
    (p cA cB rA rB : ℝ) : ℝ :=
  - twoTypeMeanCostVelocity p cA cB rA rB

/-- Under the same cost law, competition among equivalent implementations makes
slack nondecreasing. -/
theorem two_type_linear_cost_slack_nondecreasing
    (p benefit alpha cA cB : ℝ)
    (hp0 : 0 ≤ p)
    (hp1 : p ≤ 1)
    (halpha : 0 ≤ alpha) :
    0 ≤ twoTypeSlackVelocity p cA cB
      (costFitness benefit alpha cA)
      (costFitness benefit alpha cB) := by
  unfold twoTypeSlackVelocity
  exact neg_nonneg.mpr
    (two_type_linear_cost_nonincreasing
      p benefit alpha cA cB hp0 hp1 halpha)

/-- Strict version: when both implementations are present, costs differ, and
cost matters positively for reproduction, slack increases strictly. -/
theorem two_type_linear_cost_slack_strict
    (p benefit alpha cA cB : ℝ)
    (hp0 : 0 < p)
    (hp1 : p < 1)
    (halpha : 0 < alpha)
    (hcost : cA ≠ cB) :
    0 < twoTypeSlackVelocity p cA cB
      (costFitness benefit alpha cA)
      (costFitness benefit alpha cB) := by
  unfold twoTypeSlackVelocity
  rw [two_type_linear_cost_exact]
  have h1mp : 0 < 1 - p := sub_pos.mpr hp1
  have hdiff : 0 < (cA - cB)^2 := sq_pos_of_ne_zero (sub_ne_zero.mpr hcost)
  have hprod : 0 < alpha * p * (1 - p) * (cA - cB)^2 := by
    exact mul_pos (mul_pos (mul_pos halpha hp0) h1mp) hdiff
  nlinarith


/-- Local search-rate velocity when a fraction/budget-coupling beta of released
slack is reinvested into candidate generation. -/
def linearSearchVelocity (beta slackVelocity : ℝ) : ℝ :=
  beta * slackVelocity

/-- If released slack is coupled nonnegatively to exploration, cost selection
among functionally equivalent implementations cannot decrease the search-rate
velocity. This is the formal bridge:
  implementation competition -> slack -> exploration.
-/
theorem two_type_cost_selection_search_nondecreasing
    (p benefit alpha beta cA cB : ℝ)
    (hp0 : 0 ≤ p)
    (hp1 : p ≤ 1)
    (halpha : 0 ≤ alpha)
    (hbeta : 0 ≤ beta) :
    0 ≤ linearSearchVelocity beta
      (twoTypeSlackVelocity p cA cB
        (costFitness benefit alpha cA)
        (costFitness benefit alpha cB)) := by
  unfold linearSearchVelocity
  exact mul_nonneg hbeta
    (two_type_linear_cost_slack_nondecreasing
      p benefit alpha cA cB hp0 hp1 halpha)

/-- Strict search acceleration when both competing implementations are present,
their costs differ, cost matters for reproduction, and released slack has a
strictly positive coupling to exploration. -/
theorem two_type_cost_selection_search_strict
    (p benefit alpha beta cA cB : ℝ)
    (hp0 : 0 < p)
    (hp1 : p < 1)
    (halpha : 0 < alpha)
    (hbeta : 0 < beta)
    (hcost : cA ≠ cB) :
    0 < linearSearchVelocity beta
      (twoTypeSlackVelocity p cA cB
        (costFitness benefit alpha cA)
        (costFitness benefit alpha cB)) := by
  unfold linearSearchVelocity
  exact mul_pos hbeta
    (two_type_linear_cost_slack_strict
      p benefit alpha cA cB hp0 hp1 halpha hcost)

#print axioms two_type_cost_selection_search_nondecreasing
#print axioms two_type_cost_selection_search_strict

#print axioms two_type_competition_mean_cost_nonincreasing
#print axioms two_type_linear_cost_exact
#print axioms two_type_linear_cost_nonincreasing
#print axioms two_type_linear_cost_slack_nondecreasing
#print axioms two_type_linear_cost_slack_strict


#print axioms cheaper_functionally_equivalent_increases_slack
#print axioms strictly_cheaper_functionally_equivalent_increases_slack
#print axioms cheaper_functionally_equivalent_increases_exploration
#print axioms paired_drift_nonneg
#print axioms paired_drift_mono_in_selection
#print axioms functional_efficiency_opens_search

end PersistenceDrift
