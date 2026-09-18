import CumulativeAccessibility.FunctionalRatchetVelocity

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Ratchet velocity ledger

FunctionalRatchetVelocity.lean defines the outside quantity: target-wise
functional gain and duration/resource-normalized rate.

This file adds a deliberately narrow mechanism ledger for one scalar projection
of that rate. It does **not** claim a universal stochastic law.

For a declared target projection, write

  lambda      = opportunity rate
  pGenerate   = conditional fraction of opportunities producing a candidate
  pResource   = conditional fraction of generated candidates that are
                resource-feasible
  pValidate   = conditional fraction of feasible candidates that validate
  pRetain     = conditional fraction of validated candidates that are retained
  meanGain    = mean retained functional gain per retained success

The ledger rate is

  lambda * pGenerate * pResource * pValidate * pRetain * meanGain.

If the fractions are interpreted as conditional probabilities, this is a chain
rule decomposition and does not require independence. An application must still
justify that its empirical process can be represented by this ledger and must
derive or estimate the factors.

The point of the formal layer is separation: opportunity, generation, resource
feasibility, validation, retention, and gain are distinct coordinates of
ratchet velocity.
-/

/-- Product of the conditional conversion fractions between opportunity and
retained successful functional change. -/
def RetainedSuccessFraction
    (pGenerate pResource pValidate pRetain : ℝ) : ℝ :=
  pGenerate * pResource * pValidate * pRetain

/-- Scalar velocity ledger for one declared target projection. -/
def MechanisticRatchetVelocity
    (opportunityRate pGenerate pResource pValidate pRetain meanGain : ℝ) : ℝ :=
  opportunityRate *
    RetainedSuccessFraction pGenerate pResource pValidate pRetain *
    meanGain

/-- Explicit seam between a measured/projected ratchet rate and the mechanism
ledger. It is an application assumption, not built into the definition of
functional velocity. -/
def VelocityLedgerMatches
    (measuredRate : ℝ)
    (opportunityRate pGenerate pResource pValidate pRetain meanGain : ℝ) : Prop :=
  measuredRate =
    MechanisticRatchetVelocity
      opportunityRate pGenerate pResource pValidate pRetain meanGain

theorem retainedSuccessFraction_nonneg
    {pGenerate pResource pValidate pRetain : ℝ}
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain) :
    0 ≤ RetainedSuccessFraction pGenerate pResource pValidate pRetain := by
  unfold RetainedSuccessFraction
  positivity

theorem mechanisticRatchetVelocity_nonneg
    {opportunityRate pGenerate pResource pValidate pRetain meanGain : ℝ}
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain)
    (hGain : 0 ≤ meanGain) :
    0 ≤ MechanisticRatchetVelocity
      opportunityRate pGenerate pResource pValidate pRetain meanGain := by
  unfold MechanisticRatchetVelocity
  have hSuccess :
      0 ≤ RetainedSuccessFraction pGenerate pResource pValidate pRetain :=
    retainedSuccessFraction_nonneg hG hR hV hT
  positivity

theorem mechanisticRatchetVelocity_zero_no_opportunity
    (pGenerate pResource pValidate pRetain meanGain : ℝ) :
    MechanisticRatchetVelocity
      0 pGenerate pResource pValidate pRetain meanGain = 0 := by
  simp [MechanisticRatchetVelocity]

theorem mechanisticRatchetVelocity_zero_no_generation
    (opportunityRate pResource pValidate pRetain meanGain : ℝ) :
    MechanisticRatchetVelocity
      opportunityRate 0 pResource pValidate pRetain meanGain = 0 := by
  simp [MechanisticRatchetVelocity, RetainedSuccessFraction]

theorem mechanisticRatchetVelocity_zero_no_resource_feasibility
    (opportunityRate pGenerate pValidate pRetain meanGain : ℝ) :
    MechanisticRatchetVelocity
      opportunityRate pGenerate 0 pValidate pRetain meanGain = 0 := by
  simp [MechanisticRatchetVelocity, RetainedSuccessFraction]

theorem mechanisticRatchetVelocity_zero_no_validation
    (opportunityRate pGenerate pResource pRetain meanGain : ℝ) :
    MechanisticRatchetVelocity
      opportunityRate pGenerate pResource 0 pRetain meanGain = 0 := by
  simp [MechanisticRatchetVelocity, RetainedSuccessFraction]

theorem mechanisticRatchetVelocity_zero_no_retention
    (opportunityRate pGenerate pResource pValidate meanGain : ℝ) :
    MechanisticRatchetVelocity
      opportunityRate pGenerate pResource pValidate 0 meanGain = 0 := by
  simp [MechanisticRatchetVelocity, RetainedSuccessFraction]

theorem mechanisticRatchetVelocity_zero_no_gain
    (opportunityRate pGenerate pResource pValidate pRetain : ℝ) :
    MechanisticRatchetVelocity
      opportunityRate pGenerate pResource pValidate pRetain 0 = 0 := by
  simp [MechanisticRatchetVelocity]

/-- Holding the conversion pipeline and mean gain nonnegative and fixed, more
opportunity cannot reduce ledger velocity. -/
theorem mechanisticRatchetVelocity_mono_opportunity
    {o₀ o₁ pGenerate pResource pValidate pRetain meanGain : ℝ}
    (hO : o₀ ≤ o₁)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain)
    (hGain : 0 ≤ meanGain) :
    MechanisticRatchetVelocity
        o₀ pGenerate pResource pValidate pRetain meanGain ≤
      MechanisticRatchetVelocity
        o₁ pGenerate pResource pValidate pRetain meanGain := by
  unfold MechanisticRatchetVelocity
  have hSuccess :
      0 ≤ RetainedSuccessFraction pGenerate pResource pValidate pRetain :=
    retainedSuccessFraction_nonneg hG hR hV hT
  have hFactor :
      0 ≤ RetainedSuccessFraction pGenerate pResource pValidate pRetain *
        meanGain := mul_nonneg hSuccess hGain
  simpa [mul_assoc] using mul_le_mul_of_nonneg_right hO hFactor

/-- Holding all other nonnegative factors fixed, improving conditional
generation cannot reduce ledger velocity. -/
theorem mechanisticRatchetVelocity_mono_generation
    {opportunityRate g₀ g₁ pResource pValidate pRetain meanGain : ℝ}
    (hO : 0 ≤ opportunityRate)
    (hG : g₀ ≤ g₁)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain)
    (hGain : 0 ≤ meanGain) :
    MechanisticRatchetVelocity
        opportunityRate g₀ pResource pValidate pRetain meanGain ≤
      MechanisticRatchetVelocity
        opportunityRate g₁ pResource pValidate pRetain meanGain := by
  unfold MechanisticRatchetVelocity RetainedSuccessFraction
  have hRest : 0 ≤ pResource * pValidate * pRetain := by positivity
  have hInner :
      g₀ * (pResource * pValidate * pRetain) ≤
        g₁ * (pResource * pValidate * pRetain) :=
    mul_le_mul_of_nonneg_right hG hRest
  have hOuter :
      opportunityRate * (g₀ * (pResource * pValidate * pRetain)) ≤
        opportunityRate * (g₁ * (pResource * pValidate * pRetain)) :=
    mul_le_mul_of_nonneg_left hInner hO
  exact mul_le_mul_of_nonneg_right
    (by simpa [mul_assoc] using hOuter) hGain

/-- Holding all other nonnegative factors fixed, improving resource feasibility
cannot reduce ledger velocity. -/
theorem mechanisticRatchetVelocity_mono_resource
    {opportunityRate pGenerate r₀ r₁ pValidate pRetain meanGain : ℝ}
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : r₀ ≤ r₁)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain)
    (hGain : 0 ≤ meanGain) :
    MechanisticRatchetVelocity
        opportunityRate pGenerate r₀ pValidate pRetain meanGain ≤
      MechanisticRatchetVelocity
        opportunityRate pGenerate r₁ pValidate pRetain meanGain := by
  unfold MechanisticRatchetVelocity RetainedSuccessFraction
  have hRest : 0 ≤ pValidate * pRetain := by positivity
  have hInner :
      r₀ * (pValidate * pRetain) ≤ r₁ * (pValidate * pRetain) :=
    mul_le_mul_of_nonneg_right hR hRest
  have hGen :
      pGenerate * (r₀ * (pValidate * pRetain)) ≤
        pGenerate * (r₁ * (pValidate * pRetain)) :=
    mul_le_mul_of_nonneg_left hInner hG
  have hOpp :
      opportunityRate * (pGenerate * (r₀ * (pValidate * pRetain))) ≤
        opportunityRate * (pGenerate * (r₁ * (pValidate * pRetain))) :=
    mul_le_mul_of_nonneg_left hGen hO
  exact mul_le_mul_of_nonneg_right
    (by simpa [mul_assoc] using hOpp) hGain

/-- Holding all other nonnegative factors fixed, improving validation cannot
reduce ledger velocity. -/
theorem mechanisticRatchetVelocity_mono_validation
    {opportunityRate pGenerate pResource v₀ v₁ pRetain meanGain : ℝ}
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : v₀ ≤ v₁)
    (hT : 0 ≤ pRetain)
    (hGain : 0 ≤ meanGain) :
    MechanisticRatchetVelocity
        opportunityRate pGenerate pResource v₀ pRetain meanGain ≤
      MechanisticRatchetVelocity
        opportunityRate pGenerate pResource v₁ pRetain meanGain := by
  unfold MechanisticRatchetVelocity RetainedSuccessFraction
  have hInner : v₀ * pRetain ≤ v₁ * pRetain :=
    mul_le_mul_of_nonneg_right hV hT
  have hResource :
      pResource * (v₀ * pRetain) ≤ pResource * (v₁ * pRetain) :=
    mul_le_mul_of_nonneg_left hInner hR
  have hGen :
      pGenerate * (pResource * (v₀ * pRetain)) ≤
        pGenerate * (pResource * (v₁ * pRetain)) :=
    mul_le_mul_of_nonneg_left hResource hG
  have hOpp :
      opportunityRate * (pGenerate * (pResource * (v₀ * pRetain))) ≤
        opportunityRate * (pGenerate * (pResource * (v₁ * pRetain))) :=
    mul_le_mul_of_nonneg_left hGen hO
  exact mul_le_mul_of_nonneg_right
    (by simpa [mul_assoc] using hOpp) hGain

/-- Holding all other nonnegative factors fixed, improving retention cannot
reduce ledger velocity. -/
theorem mechanisticRatchetVelocity_mono_retention
    {opportunityRate pGenerate pResource pValidate t₀ t₁ meanGain : ℝ}
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : t₀ ≤ t₁)
    (hGain : 0 ≤ meanGain) :
    MechanisticRatchetVelocity
        opportunityRate pGenerate pResource pValidate t₀ meanGain ≤
      MechanisticRatchetVelocity
        opportunityRate pGenerate pResource pValidate t₁ meanGain := by
  unfold MechanisticRatchetVelocity RetainedSuccessFraction
  have hValid :
      pValidate * t₀ ≤ pValidate * t₁ :=
    mul_le_mul_of_nonneg_left hT hV
  have hResource :
      pResource * (pValidate * t₀) ≤
        pResource * (pValidate * t₁) :=
    mul_le_mul_of_nonneg_left hValid hR
  have hGen :
      pGenerate * (pResource * (pValidate * t₀)) ≤
        pGenerate * (pResource * (pValidate * t₁)) :=
    mul_le_mul_of_nonneg_left hResource hG
  have hOpp :
      opportunityRate * (pGenerate * (pResource * (pValidate * t₀))) ≤
        opportunityRate * (pGenerate * (pResource * (pValidate * t₁))) :=
    mul_le_mul_of_nonneg_left hGen hO
  exact mul_le_mul_of_nonneg_right
    (by simpa [mul_assoc] using hOpp) hGain

/-- Holding the nonnegative event pipeline fixed, larger mean retained gain per
success cannot reduce ledger velocity. -/
theorem mechanisticRatchetVelocity_mono_meanGain
    {opportunityRate pGenerate pResource pValidate pRetain gain₀ gain₁ : ℝ}
    (hO : 0 ≤ opportunityRate)
    (hG : 0 ≤ pGenerate)
    (hR : 0 ≤ pResource)
    (hV : 0 ≤ pValidate)
    (hT : 0 ≤ pRetain)
    (hGain : gain₀ ≤ gain₁) :
    MechanisticRatchetVelocity
        opportunityRate pGenerate pResource pValidate pRetain gain₀ ≤
      MechanisticRatchetVelocity
        opportunityRate pGenerate pResource pValidate pRetain gain₁ := by
  unfold MechanisticRatchetVelocity
  have hSuccess :
      0 ≤ RetainedSuccessFraction pGenerate pResource pValidate pRetain :=
    retainedSuccessFraction_nonneg hG hR hV hT
  have hPrefix : 0 ≤ opportunityRate *
      RetainedSuccessFraction pGenerate pResource pValidate pRetain :=
    mul_nonneg hO hSuccess
  exact mul_le_mul_of_nonneg_left hGain hPrefix

/-- If a measured scalar rate is represented exactly by the ledger, a zero
retention bottleneck forces the measured rate to zero. This illustrates the
role of the explicit modelling seam. -/
theorem matchedLedger_zero_retention_implies_zero_measuredRate
    (measuredRate opportunityRate pGenerate pResource pValidate meanGain : ℝ)
    (hMatch : VelocityLedgerMatches measuredRate
      opportunityRate pGenerate pResource pValidate 0 meanGain) :
    measuredRate = 0 := by
  rw [hMatch]
  exact mechanisticRatchetVelocity_zero_no_retention
    opportunityRate pGenerate pResource pValidate meanGain

#print axioms retainedSuccessFraction_nonneg
#print axioms mechanisticRatchetVelocity_nonneg
#print axioms mechanisticRatchetVelocity_zero_no_opportunity
#print axioms mechanisticRatchetVelocity_zero_no_generation
#print axioms mechanisticRatchetVelocity_zero_no_resource_feasibility
#print axioms mechanisticRatchetVelocity_zero_no_validation
#print axioms mechanisticRatchetVelocity_zero_no_retention
#print axioms mechanisticRatchetVelocity_zero_no_gain
#print axioms mechanisticRatchetVelocity_mono_opportunity
#print axioms mechanisticRatchetVelocity_mono_generation
#print axioms mechanisticRatchetVelocity_mono_resource
#print axioms mechanisticRatchetVelocity_mono_validation
#print axioms mechanisticRatchetVelocity_mono_retention
#print axioms mechanisticRatchetVelocity_mono_meanGain
#print axioms matchedLedger_zero_retention_implies_zero_measuredRate

end FunctionalOrganization
end CumulativeAccessibility
