import CumulativeAccessibility.QuantitativeAccessibility

namespace CumulativeAccessibility
namespace FunctionalOrganization

variable {σ φ : Type*}

/-!
# Functional organization and ratchet velocity

The quantitative-accessibility layer uses organization states themselves as
future targets. For functional organization we need a cleaner separation:

* `σ` -- organizational states of the underlying commons/network;
* `φ` -- functional targets: reliable transformations, capacities, or tasks;
* `FunctionalCost σ φ` -- the resource cost of realizing a functional target
  from an organizational state.

This avoids identifying the physical organization with what that organization
can do. A neural configuration and "understand this French sentence" are not
objects of the same type; neither are an ecosystem state and "perform nitrogen
cycling".

The primitive moving object is therefore not a universal scalar complexity
score. It is the target-indexed functional cost profile. Scalar summaries may
be added by an application, but the formal core keeps the geometry.

For a one-step transition, positive functional ratchet velocity means that no
declared function becomes more costly and at least one becomes strictly cheaper.
Acceleration compares two equal-duration/equal-resource steps and asks whether
the second cost-reduction profile dominates the first.

No claim is made that all functional targets are valuable, commensurable, or
independent.
-/

/-- Directed cost from an organizational state to a functional target. -/
abbrev FunctionalCost (σ φ : Type*) := σ → φ → ℝ

/-- A functional target is realizable within budget `B`. -/
def FunctionAccessibleWithin
    (Cost : FunctionalCost σ φ)
    (B : ℝ) (state : σ) (target : φ) : Prop :=
  Cost state target ≤ B

/-- Budget-thresholded access to declared functions. -/
def FunctionalBudgetAccess
    (Cost : FunctionalCost σ φ)
    (B : ℝ) (state : σ) : φ → Prop :=
  fun target => FunctionAccessibleWithin Cost B state target

/-- The declared functional repertoire available within budget. -/
def FunctionalRepertoireWithin
    (targets : Set φ)
    (Cost : FunctionalCost σ φ)
    (B : ℝ) (state : σ) : Set φ :=
  accessibleSet targets (FunctionalBudgetAccess Cost B state)

/-- A change in functional organization: at least one declared functional
target changes cost. No direction of improvement is asserted. -/
def FunctionalGeometryChangesOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) : Prop :=
  ∃ target, target ∈ targets ∧
    newCost newState target ≠ oldCost oldState target

/-- Directional opening: at least one declared function becomes cheaper, while
other functions may become more expensive. -/
def HasCheaperFunctionOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) : Prop :=
  ∃ target, target ∈ targets ∧
    newCost newState target < oldCost oldState target

/-- Pareto-like non-worsening of the declared functional cost profile. -/
def NoMoreFunctionallyViscousOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) : Prop :=
  ∀ target, target ∈ targets →
    newCost newState target ≤ oldCost oldState target

/-- Strict functional-organization improvement: no declared function becomes
more costly and at least one becomes strictly cheaper. -/
def StrictlyLessFunctionallyViscousOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) : Prop :=
  NoMoreFunctionallyViscousOn targets oldCost newCost oldState newState ∧
    ∃ target, target ∈ targets ∧
      newCost newState target < oldCost oldState target

/-- Signed per-step gain in a functional target. Positive means that the target
became cheaper over the step. -/
def FunctionalStepVelocity
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ)
    (target : φ) : ℝ :=
  oldCost oldState target - newCost newState target

/-- Every declared target has nonnegative functional velocity. -/
def NonnegativeFunctionalVelocityOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) : Prop :=
  ∀ target, target ∈ targets →
    0 ≤ FunctionalStepVelocity oldCost newCost oldState newState target

/-- Positive ratchet velocity: no declared target moves backward in cost and at
least one target moves strictly forward. -/
def PositiveFunctionalVelocityOn
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) : Prop :=
  NonnegativeFunctionalVelocityOn targets
      oldCost newCost oldState newState ∧
    ∃ target, target ∈ targets ∧
      0 < FunctionalStepVelocity oldCost newCost oldState newState target

theorem noMoreFunctionallyViscous_iff_nonnegativeVelocity
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) :
    NoMoreFunctionallyViscousOn targets oldCost newCost oldState newState ↔
      NonnegativeFunctionalVelocityOn targets
        oldCost newCost oldState newState := by
  constructor
  · intro h target htarget
    exact sub_nonneg.mpr (h target htarget)
  · intro h target htarget
    exact sub_nonneg.mp (h target htarget)

theorem strictlyLessFunctionallyViscous_iff_positiveVelocity
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ) :
    StrictlyLessFunctionallyViscousOn
        targets oldCost newCost oldState newState ↔
      PositiveFunctionalVelocityOn
        targets oldCost newCost oldState newState := by
  constructor
  · rintro ⟨hweak, target, htarget, hstrict⟩
    refine ⟨(noMoreFunctionallyViscous_iff_nonnegativeVelocity
      targets oldCost newCost oldState newState).mp hweak, ?_⟩
    exact ⟨target, htarget, sub_pos.mpr hstrict⟩
  · rintro ⟨hweak, target, htarget, hpositive⟩
    refine ⟨(noMoreFunctionallyViscous_iff_nonnegativeVelocity
      targets oldCost newCost oldState newState).mpr hweak, ?_⟩
    exact ⟨target, htarget, sub_pos.mp hpositive⟩

/-- Non-worsening functional costs preserve every declared function already
available at a fixed budget. -/
theorem noMoreFunctionallyViscous_preserves_budget_access
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ)
    (B : ℝ)
    (h : NoMoreFunctionallyViscousOn
      targets oldCost newCost oldState newState) :
    PreservesOn targets
      (FunctionalBudgetAccess oldCost B oldState)
      (FunctionalBudgetAccess newCost B newState) := by
  intro target htarget hold
  exact le_trans (h target htarget) hold

/-- Any strict functional cost improvement opens an exact budget threshold at
which one declared function is unavailable before and available after. -/
theorem strictlyLessFunctionallyViscous_opens_budget_window
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ)
    (h : StrictlyLessFunctionallyViscousOn
      targets oldCost newCost oldState newState) :
    ∃ target B,
      target ∈ targets ∧
      ¬ FunctionAccessibleWithin oldCost B oldState target ∧
      FunctionAccessibleWithin newCost B newState target := by
  rcases h.2 with ⟨target, htarget, hlt⟩
  refine ⟨target, newCost newState target, htarget, ?_, ?_⟩
  · exact not_le.mpr hlt
  · exact le_rfl

/-- Strict functional cost improvement strictly expands the declared functional
repertoire at some budget threshold. -/
theorem strictlyLessFunctionallyViscous_induces_repertoire_expansion
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ)
    (h : StrictlyLessFunctionallyViscousOn
      targets oldCost newCost oldState newState) :
    ∃ B,
      FunctionalRepertoireWithin targets oldCost B oldState ⊂
        FunctionalRepertoireWithin targets newCost B newState := by
  rcases h.2 with ⟨target, htarget, hlt⟩
  let B : ℝ := newCost newState target
  have hExpand :
      StrictExpandsOn targets
        (FunctionalBudgetAccess oldCost B oldState)
        (FunctionalBudgetAccess newCost B newState) := by
    refine ⟨?_, target, htarget, ?_, ?_⟩
    · exact noMoreFunctionallyViscous_preserves_budget_access
        targets oldCost newCost oldState newState B h.1
    · exact not_le.mpr hlt
    · exact le_rfl
  refine ⟨B, ?_⟩
  exact (strictExpandsOn_iff_ssubset targets
    (FunctionalBudgetAccess oldCost B oldState)
    (FunctionalBudgetAccess newCost B newState)).mp hExpand

/-- Positive functional ratchet velocity is therefore not merely a signed
cost statement: at some budget it yields a strict repertoire expansion. -/
theorem positiveFunctionalVelocity_induces_repertoire_expansion
    (targets : Set φ)
    (oldCost newCost : FunctionalCost σ φ)
    (oldState newState : σ)
    (h : PositiveFunctionalVelocityOn
      targets oldCost newCost oldState newState) :
    ∃ B,
      FunctionalRepertoireWithin targets oldCost B oldState ⊂
        FunctionalRepertoireWithin targets newCost B newState := by
  apply strictlyLessFunctionallyViscous_induces_repertoire_expansion
  exact (strictlyLessFunctionallyViscous_iff_positiveVelocity
    targets oldCost newCost oldState newState).mpr h

/-- The second step has no lower per-target velocity than the first. This only
has a literal speed interpretation when the compared steps use the same time or
resource interval. -/
def NoLessFunctionalVelocityOn
    (targets : Set φ)
    (Cost₀ Cost₁ Cost₂ : FunctionalCost σ φ)
    (state₀ state₁ state₂ : σ) : Prop :=
  ∀ target, target ∈ targets →
    FunctionalStepVelocity Cost₀ Cost₁ state₀ state₁ target ≤
      FunctionalStepVelocity Cost₁ Cost₂ state₁ state₂ target

/-- Pareto-like increase in ratchet velocity: no declared target slows down and
at least one target improves faster in the second matched interval. -/
def StrictlyFasterFunctionalVelocityOn
    (targets : Set φ)
    (Cost₀ Cost₁ Cost₂ : FunctionalCost σ φ)
    (state₀ state₁ state₂ : σ) : Prop :=
  NoLessFunctionalVelocityOn targets
      Cost₀ Cost₁ Cost₂ state₀ state₁ state₂ ∧
    ∃ target, target ∈ targets ∧
      FunctionalStepVelocity Cost₀ Cost₁ state₀ state₁ target <
        FunctionalStepVelocity Cost₁ Cost₂ state₁ state₂ target

/-- Strong accelerating ratchet: both consecutive matched steps are positive
functional ratchet steps, and the second velocity profile strictly dominates
the first. -/
def AcceleratingFunctionalRatchetOn
    (targets : Set φ)
    (Cost₀ Cost₁ Cost₂ : FunctionalCost σ φ)
    (state₀ state₁ state₂ : σ) : Prop :=
  PositiveFunctionalVelocityOn targets
      Cost₀ Cost₁ state₀ state₁ ∧
  PositiveFunctionalVelocityOn targets
      Cost₁ Cost₂ state₁ state₂ ∧
  StrictlyFasterFunctionalVelocityOn targets
      Cost₀ Cost₁ Cost₂ state₀ state₁ state₂

theorem acceleratingFunctionalRatchet_has_faster_target
    (targets : Set φ)
    (Cost₀ Cost₁ Cost₂ : FunctionalCost σ φ)
    (state₀ state₁ state₂ : σ)
    (h : AcceleratingFunctionalRatchetOn
      targets Cost₀ Cost₁ Cost₂ state₀ state₁ state₂) :
    ∃ target, target ∈ targets ∧
      FunctionalStepVelocity Cost₀ Cost₁ state₀ state₁ target <
        FunctionalStepVelocity Cost₁ Cost₂ state₁ state₂ target := by
  exact h.2.2.2

/-- Trajectory velocity under one common state-dependent functional geometry. -/
def TrajectoryFunctionalVelocity
    (Cost : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (t : ℕ) (target : φ) : ℝ :=
  FunctionalStepVelocity Cost Cost
    (trajectory t) (trajectory (t + 1)) target

/-- Positive retained functional change along one trajectory step. -/
def TrajectoryRatchetStepOn
    (targets : Set φ)
    (Cost : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (t : ℕ) : Prop :=
  PositiveFunctionalVelocityOn targets Cost Cost
    (trajectory t) (trajectory (t + 1))

/-!
## Minimal witness

The same two organizational states support two different functional targets.
The transition keeps one target at the same cost and makes the other cheaper.
The network has therefore changed organization without changing its node type,
and its declared functional repertoire strictly expands at a suitable budget.
-/

inductive CommonsState
  | undifferentiated
  | differentiated
  deriving DecidableEq

inductive CommonsFunction
  | maintain
  | specialized
  deriving DecidableEq

open CommonsState CommonsFunction

def commonsFunctionalCost :
    FunctionalCost CommonsState CommonsFunction
  | undifferentiated, maintain => 0
  | undifferentiated, specialized => 2
  | differentiated, maintain => 0
  | differentiated, specialized => 1

theorem commons_positive_functional_velocity :
    PositiveFunctionalVelocityOn Set.univ
      commonsFunctionalCost commonsFunctionalCost
      undifferentiated differentiated := by
  constructor
  · intro target htarget
    cases target <;>
      norm_num [FunctionalStepVelocity, commonsFunctionalCost]
  · exact ⟨specialized, by simp,
      by norm_num [FunctionalStepVelocity, commonsFunctionalCost]⟩

theorem commons_repertoire_expands_at_budget_one :
    FunctionalRepertoireWithin Set.univ
        commonsFunctionalCost 1 undifferentiated ⊂
      FunctionalRepertoireWithin Set.univ
        commonsFunctionalCost 1 differentiated := by
  apply (strictExpandsOn_iff_ssubset Set.univ
    (FunctionalBudgetAccess commonsFunctionalCost 1 undifferentiated)
    (FunctionalBudgetAccess commonsFunctionalCost 1 differentiated)).mp
  refine ⟨?_, specialized, by simp, ?_, ?_⟩
  · intro target htarget hold
    cases target with
    | maintain =>
        norm_num [FunctionalBudgetAccess, FunctionAccessibleWithin,
          commonsFunctionalCost]
    | specialized =>
        norm_num [FunctionalBudgetAccess, FunctionAccessibleWithin,
          commonsFunctionalCost] at hold
  · norm_num [FunctionalBudgetAccess, FunctionAccessibleWithin,
      commonsFunctionalCost]
  · norm_num [FunctionalBudgetAccess, FunctionAccessibleWithin,
      commonsFunctionalCost]

#print axioms noMoreFunctionallyViscous_iff_nonnegativeVelocity
#print axioms strictlyLessFunctionallyViscous_iff_positiveVelocity
#print axioms noMoreFunctionallyViscous_preserves_budget_access
#print axioms strictlyLessFunctionallyViscous_opens_budget_window
#print axioms strictlyLessFunctionallyViscous_induces_repertoire_expansion
#print axioms positiveFunctionalVelocity_induces_repertoire_expansion
#print axioms acceleratingFunctionalRatchet_has_faster_target
#print axioms commons_positive_functional_velocity
#print axioms commons_repertoire_expands_at_budget_one

end FunctionalOrganization
end CumulativeAccessibility
