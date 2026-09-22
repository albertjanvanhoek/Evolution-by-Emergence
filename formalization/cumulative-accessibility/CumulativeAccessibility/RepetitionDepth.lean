import CumulativeAccessibility.PaidReuseHierarchy

namespace CumulativeAccessibility
namespace PaidReuseDepth

open scoped BigOperators

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-!
# Nonseparable repetition-depth theorem

This module formalizes the stronger RD0-RD3 statement from the retained-
organization theorem notes.

Unlike `DictionaryObjective`, the objective `F : Finset ι → ℝ` is arbitrary.
The theorem assumes only an explicit marginal identity for adding an omitted
module together with lower bounds on exposed occurrence count and inline cost.

Thus full retention is not obtained by defining the global objective as a sum
of independent per-level gains.
-/

/-- Actual exposed occurrence count of module i before i is retained, allowed
to depend on all other retained modules D. It is real-valued here so the
theorem can cover weighted/effective occurrence counts as well as natural
counts embedded in ℝ. -/
abbrev ExposedCount (ι : Type*) :=
  ι → Finset ι → ℝ

/-- Actual inline/reconstruction cost per exposed occurrence, also allowed to
depend on the rest of the retained dictionary. -/
abbrev InlineOccurrenceCost (ι : Type*) :=
  ι → Finset ι → ℝ

/-- RD0: exact marginal objective identity for adding one omitted module. -/
def RepetitionMarginalIdentity
    (F : Finset ι → ℝ)
    (N : ExposedCount ι)
    (C : InlineOccurrenceCost ι)
    (r h : ι → ℝ) : Prop :=
  ∀ D i, i ∉ D →
    F (insert i D) - F D =
      h i + N i D * r i - (N i D - 1) * C i D

/-- Worst-case threshold data for every level. -/
structure RepetitionDepthBounds
    (N : ExposedCount ι)
    (C : InlineOccurrenceCost ι)
    (r h : ι → ℝ) where
  nMin : ι → ℝ
  cMin : ι → ℝ
  atLeastTwo : ∀ i, 2 ≤ nMin i
  occurrenceLower :
    ∀ D i, i ∉ D → nMin i ≤ N i D
  costLower :
    ∀ D i, i ∉ D → cMin i ≤ C i D
  referenceBelowInline :
    ∀ i, r i < cMin i
  strictThreshold :
    ∀ i,
      nMin i * r i + h i <
        (nMin i - 1) * cMin i

/-- The saving function used in the RD monotonicity argument. -/
def depthGain
    (N c r h : ℝ) : ℝ :=
  (N - 1) * c - N * r - h

/-- If occurrence count and inline cost are no smaller than their declared
worst-case bounds, and cMin > r, then the actual gain is at least the gain at
the worst-case corner. -/
theorem depthGain_ge_worstCase
    (N c nMin cMin r h : ℝ)
    (hn2 : 2 ≤ nMin)
    (hN : nMin ≤ N)
    (hC : cMin ≤ c)
    (hcr : r < cMin) :
    depthGain nMin cMin r h ≤ depthGain N c r h := by
  have hNm1 : 0 ≤ N - 1 := by
    linarith
  have hInline :
      (N - 1) * cMin ≤ (N - 1) * c :=
    mul_le_mul_of_nonneg_left hC hNm1
  have hNdiff : 0 ≤ N - nMin := by
    linarith
  have hCr : 0 ≤ cMin - r := by
    linarith
  have hProduct :
      0 ≤ (N - nMin) * (cMin - r) :=
    mul_nonneg hNdiff hCr
  unfold depthGain
  nlinarith

/-- RD1 implies that adding any omitted level strictly improves the arbitrary
objective F, provided RD0 and the structural lower bounds hold. -/
theorem repetitionThreshold_strictly_improves_any_omitted_level
    (F : Finset ι → ℝ)
    (N : ExposedCount ι)
    (C : InlineOccurrenceCost ι)
    (r h : ι → ℝ)
    (hMarginal : RepetitionMarginalIdentity F N C r h)
    (bounds : RepetitionDepthBounds N C r h)
    (D : Finset ι)
    (i : ι)
    (hi : i ∉ D) :
    F (insert i D) < F D := by
  have hGainWorst :
      0 < depthGain
        (bounds.nMin i)
        (bounds.cMin i)
        (r i)
        (h i) := by
    unfold depthGain
    linarith [bounds.strictThreshold i]
  have hGainActual :
      depthGain
          (bounds.nMin i)
          (bounds.cMin i)
          (r i)
          (h i)
        ≤
      depthGain
          (N i D)
          (C i D)
          (r i)
          (h i) :=
    depthGain_ge_worstCase
      (N i D) (C i D)
      (bounds.nMin i) (bounds.cMin i)
      (r i) (h i)
      (bounds.atLeastTwo i)
      (bounds.occurrenceLower D i hi)
      (bounds.costLower D i hi)
      (bounds.referenceBelowInline i)
  have hGainPositive :
      0 < depthGain
        (N i D)
        (C i D)
        (r i)
        (h i) :=
    lt_of_lt_of_le hGainWorst hGainActual
  have hDelta := hMarginal D i hi
  unfold depthGain at hGainPositive
  linarith

/-- RD2: for any finite set of candidate reusable levels, if the real marginal
objective satisfies RD0 and every level satisfies the worst-case repetition
threshold, then every global minimizer is the full retained set. -/
theorem repetitionDepth_every_global_minimizer_is_full
    (F : Finset ι → ℝ)
    (N : ExposedCount ι)
    (C : InlineOccurrenceCost ι)
    (r h : ι → ℝ)
    (hMarginal : RepetitionMarginalIdentity F N C r h)
    (bounds : RepetitionDepthBounds N C r h)
    (D : Finset ι)
    (hOptimal : ∀ D', F D ≤ F D') :
    D = Finset.univ := by
  exact PaidReuse.every_global_minimizer_is_full
    F
    (repetitionThreshold_strictly_improves_any_omitted_level
      F N C r h hMarginal bounds)
    D
    hOptimal

#print axioms depthGain_ge_worstCase
#print axioms repetitionThreshold_strictly_improves_any_omitted_level
#print axioms repetitionDepth_every_global_minimizer_is_full

end PaidReuseDepth
end CumulativeAccessibility
