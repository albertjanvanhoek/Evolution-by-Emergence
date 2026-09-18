import CumulativeAccessibility.ResponseDynamics
import CumulativeAccessibility.FunctionalRatchetVelocity
import CumulativeAccessibility.RatchetVelocityLedger

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Bounded opportunity gaps and a deterministic update-rate bridge

The existing RecurringOpportunity predicate is qualitative: opportunities occur
arbitrarily late, but the waiting time may grow without bound. That is enough
for open-endedness, but it cannot imply any positive lower bound on update
frequency.

This module adds the minimal quantitative strengthening needed for a first
mechanism-to-speed theorem:

* opportunities occur within a bounded gap;
* each opportunity receives a resource-feasible validated response within a
  bounded lag.

Together they imply a bounded gap between resource-validated successful
updates. Equivalently, every sliding window of a derived finite width contains
at least one validated update.

A final application seam can connect each validated update to a minimum
functional gain on a declared target. This yields at least one such gain in
every derived window. It is a deterministic local rate certificate, not yet a
claim about a universal long-run stochastic average.
-/

section BoundedEventDefinitions

variable {α : Type*} [DecidableEq α]

/-- From every starting index, an opportunity occurs no later than gap steps
after that index. This strengthens qualitative RecurringOpportunity. -/
def OpportunityGapBound
    (gap : ℕ)
    (Opportunity : ℕ → Prop) : Prop :=
  ∀ n : ℕ, ∃ q : ℕ,
    n ≤ q ∧ q ≤ n + gap ∧ Opportunity q

/-- From every starting index, a complete resource-validated success occurs no
later than gap steps afterward. -/
def ResourceValidatedSuccessGapBound
    (gap : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    r ≤ n + gap ∧
    ResourceValidatedSuccessAt Cost Budget U H E S r

/-- Every sliding window of the declared positive width contains a
resource-validated success. The upper endpoint is exclusive. -/
def ResourceValidatedSuccessEveryWindow
    (window : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  0 < window ∧
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    r < n + window ∧
    ResourceValidatedSuccessAt Cost Budget U H E S r

end BoundedEventDefinitions

section BoundedEventImplications

variable {α : Type*} [DecidableEq α]

/-- A bounded opportunity gap immediately implies qualitative recurrence. -/
theorem opportunityGapBound_implies_recurringOpportunity
    (gap : ℕ)
    (Opportunity : ℕ → Prop)
    (h : OpportunityGapBound gap Opportunity) :
    RecurringOpportunity Opportunity := by
  intro n
  obtain ⟨q, hnq, hqBound, hOpp⟩ := h n
  exact ⟨q, hnq, hOpp⟩

/-- Core mechanism-to-frequency theorem.

If an opportunity appears within at most opportunityGap steps from every
starting index, and every opportunity receives a resource-feasible validated
response within responseLag steps, then a resource-validated success appears
within at most opportunityGap + responseLag steps from every starting index. -/
theorem boundedOpportunity_and_response_imply_successGapBound
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        responseLag Opportunity Cost Budget U H E S) :
    ResourceValidatedSuccessGapBound
      (opportunityGap + responseLag) Cost Budget U H E S := by
  intro n
  obtain ⟨q, hnq, hqBound, hOpp⟩ := hOpportunity n
  obtain ⟨r, hqr, hrBound, hSuccess⟩ := hResponse q hOpp
  refine ⟨r, le_trans hnq hqr, ?_, hSuccess⟩
  omega

/-- A gap bound of g is equivalently strong enough to certify one success in
every sliding window of width g+1. -/
theorem successGapBound_implies_everyWindow
    (gap : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h :
      ResourceValidatedSuccessGapBound gap Cost Budget U H E S) :
    ResourceValidatedSuccessEveryWindow
      (gap + 1) Cost Budget U H E S := by
  constructor
  · omega
  · intro n
    obtain ⟨r, hnr, hrBound, hSuccess⟩ := h n
    refine ⟨r, hnr, ?_, hSuccess⟩
    omega

/-- Direct window form of the mechanism-to-speed bridge. -/
theorem boundedOpportunity_and_response_imply_successEveryWindow
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        responseLag Opportunity Cost Budget U H E S) :
    ResourceValidatedSuccessEveryWindow
      (opportunityGap + responseLag + 1)
      Cost Budget U H E S := by
  have hGap :
      ResourceValidatedSuccessGapBound
        (opportunityGap + responseLag) Cost Budget U H E S :=
    boundedOpportunity_and_response_imply_successGapBound
      opportunityGap responseLag Opportunity Cost Budget U H E S
      hOpportunity hResponse
  simpa [Nat.add_assoc] using
    successGapBound_implies_everyWindow
      (opportunityGap + responseLag) Cost Budget U H E S hGap

/-- Bounded successful-update gaps imply the earlier qualitative validated
uptake predicate. This connects the rate layer back to the open-endedness
stack. -/
theorem successGapBound_implies_validatedUptake
    (gap : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h :
      ResourceValidatedSuccessGapBound gap Cost Budget U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  intro n
  obtain ⟨r, hnr, hrBound, hSuccess⟩ := h n
  obtain ⟨z, hzU, hzNot, hGen, hResource, hEval, hzNext⟩ := hSuccess
  exact ⟨r, z, hnr, hzU, hzNot, hGen, hEval, hzNext⟩

end BoundedEventImplications

end RecursiveAccessibility

namespace FunctionalOrganization

/-!
## Functional-gain specialization

A resource-validated novelty event is not automatically a functional
improvement. The bridge below therefore keeps one explicit application premise:
every declared successful update used in the rate calculation must yield at
least minGain on the chosen functional target.

Under that premise, the bounded opportunity/response theorem yields at least
one functional gain of minGain in every finite window of derived width.
-/

section FunctionalGainBridge

variable {α σ φ : Type*} [DecidableEq α]

/-- Application seam connecting a complete resource-validated update to a
minimum one-step functional gain on a declared target. -/
def ValidatedSuccessImpliesMinimumFunctionalGain
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ) : Prop :=
  ∀ r : ℕ,
    RecursiveAccessibility.ResourceValidatedSuccessAt
      CostResponse Budget U H E S r →
    minGain ≤
      TrajectoryFunctionalVelocity CostFunctional trajectory r target

/-- The chosen target realizes at least minGain once in every sliding window
of the declared width. -/
def FunctionalGainEveryWindow
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ) : Prop :=
  0 < window ∧
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    r < n + window ∧
    minGain ≤
      TrajectoryFunctionalVelocity CostFunctional trajectory r target

/-- Main deterministic mechanism-to-functional-speed theorem.

Bounded opportunity gaps plus bounded resource-feasible validated response,
together with a declared minimum functional gain per validated update, force
at least one gain of minGain in every window of width
opportunityGap + responseLag + 1. -/
theorem boundedMechanism_implies_functionalGainEveryWindow
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hOpportunity :
      RecursiveAccessibility.OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      RecursiveAccessibility.OpportunityConditionedResourceResponseWithin
        responseLag Opportunity CostResponse Budget U H E S)
    (hGain :
      ValidatedSuccessImpliesMinimumFunctionalGain
        CostResponse Budget U H E S
        CostFunctional trajectory target minGain) :
    FunctionalGainEveryWindow
      (opportunityGap + responseLag + 1)
      CostFunctional trajectory target minGain := by
  have hWindow :
      RecursiveAccessibility.ResourceValidatedSuccessEveryWindow
        (opportunityGap + responseLag + 1)
        CostResponse Budget U H E S :=
    RecursiveAccessibility.boundedOpportunity_and_response_imply_successEveryWindow
      opportunityGap responseLag Opportunity
      CostResponse Budget U H E S
      hOpportunity hResponse
  refine ⟨hWindow.1, ?_⟩
  intro n
  obtain ⟨r, hnr, hrWindow, hSuccess⟩ := hWindow.2 n
  exact ⟨r, hnr, hrWindow, hGain r hSuccess⟩

/-- Sliding-window gain immediately yields the same gain guarantee on each
non-overlapping block of that width. This is the deterministic block-rate
interpretation. -/
theorem functionalGainEveryWindow_implies_everyBlock
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (h :
      FunctionalGainEveryWindow
        window CostFunctional trajectory target minGain) :
    ∀ k : ℕ, ∃ r : ℕ,
      k * window ≤ r ∧
      r < (k + 1) * window ∧
      minGain ≤
        TrajectoryFunctionalVelocity CostFunctional trajectory r target := by
  intro k
  obtain ⟨r, hkr, hrUpper, hGain⟩ := h.2 (k * window)
  refine ⟨r, hkr, ?_, hGain⟩
  simpa [Nat.add_mul] using hrUpper

/-- Conservative scalar attached to a block certificate: minimum gain divided
by block width. This number is meaningful as an average-rate floor only when an
application also rules out offsetting negative gains between certified events.
The formal core therefore keeps the block certificate as the stronger primitive
statement. -/
noncomputable def CertifiedBlockGainRate
    (minGain : ℝ)
    (window : ℕ) : ℝ :=
  minGain / (window : ℝ)

theorem certifiedBlockGainRate_positive
    (minGain : ℝ)
    (window : ℕ)
    (hGain : 0 < minGain)
    (hWindow : 0 < window) :
    0 < CertifiedBlockGainRate minGain window := by
  unfold CertifiedBlockGainRate
  exact div_pos hGain (by exact_mod_cast hWindow)

#print axioms boundedMechanism_implies_functionalGainEveryWindow
#print axioms functionalGainEveryWindow_implies_everyBlock
#print axioms certifiedBlockGainRate_positive

end FunctionalGainBridge

end FunctionalOrganization
end CumulativeAccessibility
