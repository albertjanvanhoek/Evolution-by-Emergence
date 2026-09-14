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

#print axioms cheaper_functionally_equivalent_increases_slack
#print axioms strictly_cheaper_functionally_equivalent_increases_slack
#print axioms cheaper_functionally_equivalent_increases_exploration
#print axioms paired_drift_nonneg
#print axioms paired_drift_mono_in_selection
#print axioms functional_efficiency_opens_search

end PersistenceDrift
