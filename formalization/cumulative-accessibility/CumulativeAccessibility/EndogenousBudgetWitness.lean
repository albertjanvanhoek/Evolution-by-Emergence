import CumulativeAccessibility.EndogenousBudgetBridge
import CumulativeAccessibility.BoundedResponseWitness

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Endogenous budget witnesses

Two concrete witnesses close the resource seam from opposite sides.

1. Physical-gradient witness:
   the external gradient is held fixed at 10; organization improves uptake from
   10 to 11 while maintenance remains 6.  Internal slack therefore rises from
   4 to 5.  With full reinvestment, a response costing 9/2 is infeasible at the
   baseline and feasible after the organizational change.  The same internally
   generated budget finances the existing one-step even/odd response witness,
   yielding recurrent validated uptake and open-ended novelty.

2. Cumulative-margin witness:
   the exact first click from the shared-budget paper winds the dimensionless
   margin from 2/3 to 97/99.  Treating that margin as the response budget inside
   the same mechanism-level specialization makes the existing 9/10 second-click
   load unaffordable before and affordable after.

The two witnesses intentionally do not identify physical free-energy slack with
dimensionless cumulative-accessibility margin.  They show that each existing
resource account can instantiate the response-budget interface in its own
declared units.
-/

section PhysicalGradientWitness

inductive GradientRobotState
  | baseline
  | higherUptake
  deriving DecidableEq

open GradientRobotState

/-- One fixed external gradient.  The witness changes organization, not the
environmental driving value. -/
def fixedExternalGradient : GradientStream :=
  fun _ => 10

/-- Baseline organization captures the supplied gradient directly; the improved
organization captures one additional unit from the same supplied gradient. -/
def gradientRobotUptake : UptakeFunction GradientRobotState
  | baseline, g => g
  | higherUptake, g => g + 1

/-- Maintenance demand is unchanged in the uptake-improvement witness. -/
def gradientRobotMaintenance : MaintenanceDemand GradientRobotState :=
  fun _ => 6

/-- Baseline at t=0, then the higher-uptake organization from t=1 onward. -/
def gradientRobotTrajectory : ℕ → GradientRobotState
  | 0 => baseline
  | _ + 1 => higherUptake

/-- Route all available slack into the response budget for this satisfiability
witness.  This is not a claim that real systems use beta=1. -/
def fullReinvestment : ReinvestmentFraction :=
  fun _ => 1

/-- Internally generated response budget for the fixed-gradient witness. -/
def gradientRobotResponseBudget : ResponseBudget :=
  EndogenousResponseBudget
    gradientRobotTrajectory
    fixedExternalGradient
    gradientRobotUptake
    gradientRobotMaintenance
    fullReinvestment

/-- Response cost chosen strictly between the baseline and improved internal
budgets: 4 < 9/2 <= 5. -/
noncomputable def gradientFundedResponseCost : ResponseCost ℕ :=
  fun _ _ => 9 / 2

theorem gradientRobot_baseline_slack :
    InternalSlackAt
      gradientRobotTrajectory
      fixedExternalGradient
      gradientRobotUptake
      gradientRobotMaintenance
      0 = 4 := by
  norm_num [InternalSlackAt, gradientRobotTrajectory,
    fixedExternalGradient, gradientRobotUptake, gradientRobotMaintenance]

theorem gradientRobot_improved_slack
    (n : ℕ) :
    InternalSlackAt
      gradientRobotTrajectory
      fixedExternalGradient
      gradientRobotUptake
      gradientRobotMaintenance
      (n + 1) = 5 := by
  norm_num [InternalSlackAt, gradientRobotTrajectory,
    fixedExternalGradient, gradientRobotUptake, gradientRobotMaintenance]

theorem gradientRobot_baseline_budget :
    gradientRobotResponseBudget 0 = 4 := by
  norm_num [gradientRobotResponseBudget, EndogenousResponseBudget,
    fullReinvestment, gradientRobot_baseline_slack,
    InternalSlackAt, gradientRobotTrajectory,
    fixedExternalGradient, gradientRobotUptake, gradientRobotMaintenance]

theorem gradientRobot_improved_budget
    (n : ℕ) :
    gradientRobotResponseBudget (n + 1) = 5 := by
  norm_num [gradientRobotResponseBudget, EndogenousResponseBudget,
    fullReinvestment, gradientRobot_improved_slack,
    InternalSlackAt, gradientRobotTrajectory,
    fixedExternalGradient, gradientRobotUptake, gradientRobotMaintenance]

/-- The organizational uptake improvement opens a response-cost window at fixed
external gradient. -/
theorem gradient_uptake_improvement_opens_response_feasibility :
    (¬ ResourceFeasibleAt
        gradientFundedResponseCost gradientRobotResponseBudget 0 0)
      ∧
    ResourceFeasibleAt
      gradientFundedResponseCost gradientRobotResponseBudget 1 0 := by
  constructor
  · intro h
    unfold ResourceFeasibleAt AccessibleByCost at h
    rw [gradientRobot_baseline_budget] at h
    norm_num [gradientFundedResponseCost] at h
  · unfold ResourceFeasibleAt AccessibleByCost
    rw [gradientRobot_improved_budget 0]
    norm_num [gradientFundedResponseCost]

/-- Every even opportunity can be answered one step later by the odd-gated
architecture, and the successful response is financed by internally generated
slack from the fixed external gradient. -/
theorem evenOpportunity_has_endogenouslyFunded_unitDelayedResponse :
    OpportunityConditionedEndogenousResponseWithin
      1
      evenOpportunity
      gradientFundedResponseCost
      gradientRobotTrajectory
      fixedExternalGradient
      gradientRobotUptake
      gradientRobotMaintenance
      fullReinvestment
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity) := by
  intro q hEven
  rcases hEven with ⟨k, hq⟩
  have hOdd : oddOpportunity (q + 1) := by
    refine ⟨k, ?_⟩
    omega
  have hSuccess :=
    opportunityGatedArchitecture_realizesValidatedAtOpportunity
      oddOpportunity (q + 1) hOdd
  obtain ⟨z, hzU, hzNot, hGen, hEval, hzNext⟩ := hSuccess
  refine ⟨q + 1, by omega, by omega, ?_⟩
  refine ⟨z, hzU, hzNot, hGen, ?_, hEval, hzNext⟩
  change ResourceFeasibleAt
    gradientFundedResponseCost gradientRobotResponseBudget (q + 1) z
  unfold ResourceFeasibleAt AccessibleByCost
  rw [gradientRobot_improved_budget q]
  norm_num [gradientFundedResponseCost]

/-- The fixed-gradient, internally funded response architecture therefore has
recurrent validated generative uptake. -/
theorem fixedGradient_endogenousBudget_implies_validatedUptake :
    ValidatedGenerativeCapacityUptake
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity) := by
  exact
    recurringOpportunity_and_endogenousResponseWithin_imply_validatedUptake
      1
      evenOpportunity
      gradientFundedResponseCost
      gradientRobotTrajectory
      fixedExternalGradient
      gradientRobotUptake
      gradientRobotMaintenance
      fullReinvestment
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      evenOpportunity_recurring
      evenOpportunity_has_endogenouslyFunded_unitDelayedResponse

/-- Retention then carries the internally funded response route to open-ended
cumulative novelty. -/
theorem fixedGradient_endogenousBudget_implies_openEndedNovelty :
    OpenEndedCumulativeNovelty
      (opportunityGatedRepertoire oddOpportunity) := by
  exact
    recurringOpportunity_and_endogenousResponseWithin_imply_openEndedNovelty
      1
      evenOpportunity
      gradientFundedResponseCost
      gradientRobotTrajectory
      fixedExternalGradient
      gradientRobotUptake
      gradientRobotMaintenance
      fullReinvestment
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      (opportunityGatedRepertoire_retained oddOpportunity)
      evenOpportunity_recurring
      evenOpportunity_has_endogenouslyFunded_unitDelayedResponse

end PhysicalGradientWitness

section ExactMarginWitness

/-- Binding-cost history from the exact first click of the cumulative-
accessibility paper. -/
noncomputable def exactFirstClickBindingCost : ℕ → ℝ
  | 0 => 3 / 5
  | _ + 1 => 99 / 196

/-- Use the already-defined cumulative-accessibility margin itself as the
response budget in this mechanism-level specialization. -/
noncomputable def exactMarginFundedResponseBudget : ResponseBudget :=
  MarginFundedResponseBudget 1 1 exactFirstClickBindingCost

/-- The same 9/10 load used as the exact second click is read here as a response
cost in margin units. -/
noncomputable def exactSecondClickResponseCost : ResponseCost Unit :=
  fun _ _ => 9 / 10

theorem exactMarginFundedResponseBudget_baseline :
    exactMarginFundedResponseBudget 0 = 2 / 3 := by
  norm_num [exactMarginFundedResponseBudget, MarginFundedResponseBudget,
    exactFirstClickBindingCost, Margin]

theorem exactMarginFundedResponseBudget_after_first_click :
    exactMarginFundedResponseBudget 1 = 97 / 99 := by
  norm_num [exactMarginFundedResponseBudget, MarginFundedResponseBudget,
    exactFirstClickBindingCost, Margin]

/-- The exact productive first click closes the response-resource seam inside
the existing shared-budget specialization: the 9/10 second-click cost is outside
the old margin budget and inside the wound margin budget. -/
theorem exact_first_click_opens_marginFunded_response_feasibility :
    (¬ ResourceFeasibleAt
        exactSecondClickResponseCost exactMarginFundedResponseBudget 0 ())
      ∧
    ResourceFeasibleAt
      exactSecondClickResponseCost exactMarginFundedResponseBudget 1 () := by
  constructor
  · intro h
    unfold ResourceFeasibleAt AccessibleByCost at h
    rw [exactMarginFundedResponseBudget_baseline] at h
    norm_num [exactSecondClickResponseCost] at h
  · unfold ResourceFeasibleAt AccessibleByCost
    rw [exactMarginFundedResponseBudget_after_first_click]
    norm_num [exactSecondClickResponseCost]

/-- The response-feasibility crossing is exactly the same numerical window
already certified for the second cumulative click. -/
theorem exact_response_window_matches_second_click_window :
    Margin 1 (3 / 5) < (9 / 10 : ℝ)
      ∧
    (9 / 10 : ℝ) ≤ Margin 1 (99 / 196) := by
  exact exact_second_coupling_in_opened_window

end ExactMarginWitness

#print axioms gradientRobot_baseline_slack
#print axioms gradientRobot_improved_slack
#print axioms gradient_uptake_improvement_opens_response_feasibility
#print axioms evenOpportunity_has_endogenouslyFunded_unitDelayedResponse
#print axioms fixedGradient_endogenousBudget_implies_validatedUptake
#print axioms fixedGradient_endogenousBudget_implies_openEndedNovelty
#print axioms exactMarginFundedResponseBudget_baseline
#print axioms exactMarginFundedResponseBudget_after_first_click
#print axioms exact_first_click_opens_marginFunded_response_feasibility
#print axioms exact_response_window_matches_second_click_window

end RecursiveAccessibility
end CumulativeAccessibility
