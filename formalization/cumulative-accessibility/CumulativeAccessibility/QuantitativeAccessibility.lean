import CumulativeAccessibility.RecursiveAccessibility

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Quantitative recursive accessibility

The existing recursive-accessibility layer is binary: a candidate is either
exposed by a state-dependent search operator or it is not.

This file lifts that structure to a quantitative accessibility geometry.

\`AccessibilityCost x z\` is the declared cost of reaching or generating future
state/candidate \`z\` from organizational state \`x\`. The cost may represent time,
energy, update budget, coordination burden, or another application-specific
resource. This formal layer does not choose the empirical meaning of cost.

The central distinction is:

* **binary second-order accessibility**: a retained transition exposes a
  candidate that was previously absent;
* **quantitative second-order accessibility**: a retained transition lowers the
  declared cost of future transitions, possibly even when those transitions
  were already possible.

The old binary \`SecondOrderClick\` is recovered at a suitable budget whenever a
single state-dependent cost geometry strictly improves on a target set.
-/

/-- Directed state-dependent accessibility cost. No metric axioms are assumed:
costs may be asymmetric and need not satisfy a triangle inequality. -/
abbrev AccessibilityCost (α : Type*) := α → α → ℝ

/-- Candidate \`z\` is accessible from \`x\` within budget \`B\` under \`Cost\`. -/
def AccessibleWithin
    (Cost : AccessibilityCost α) (B : ℝ) (x z : α) : Prop :=
  Cost x z ≤ B

/-- The budget-thresholded search operator induced by an accessibility-cost
geometry. -/
def BudgetSearch
    (Cost : AccessibilityCost α) (B : ℝ) : SearchOperator α :=
  fun x z => AccessibleWithin Cost B x z

/-- \`newCost\` is no more viscous than \`oldCost\` on the declared target set,
comparing future transitions from \`oldState\` and \`newState\`. -/
def NoMoreViscousOn
    (targets : Set α)
    (oldCost newCost : AccessibilityCost α)
    (oldState newState : α) : Prop :=
  ∀ z, z ∈ targets →
    newCost newState z ≤ oldCost oldState z

/-- Strict quantitative accessibility improvement: every declared target is no
more costly from the new condition, and at least one target is strictly
cheaper. -/
def StrictlyLessViscousOn
    (targets : Set α)
    (oldCost newCost : AccessibilityCost α)
    (oldState newState : α) : Prop :=
  NoMoreViscousOn targets oldCost newCost oldState newState ∧
    ∃ z, z ∈ targets ∧
      newCost newState z < oldCost oldState z

theorem noMoreViscousOn_refl
    (targets : Set α)
    (Cost : AccessibilityCost α)
    (x : α) :
    NoMoreViscousOn targets Cost Cost x x := by
  intro z hz
  exact le_rfl

theorem noMoreViscousOn_trans
    (targets : Set α)
    (Cost₀ Cost₁ Cost₂ : AccessibilityCost α)
    (x₀ x₁ x₂ : α)
    (h01 : NoMoreViscousOn targets Cost₀ Cost₁ x₀ x₁)
    (h12 : NoMoreViscousOn targets Cost₁ Cost₂ x₁ x₂) :
    NoMoreViscousOn targets Cost₀ Cost₂ x₀ x₂ := by
  intro z hz
  exact le_trans (h12 z hz) (h01 z hz)

/-- A strict viscosity improvement followed by a weakly non-worsening change
remains strict relative to the ancestor. This is the quantitative retained
ratchet in one direction. -/
theorem strictlyLessViscousOn_trans_noMoreViscousOn
    (targets : Set α)
    (Cost₀ Cost₁ Cost₂ : AccessibilityCost α)
    (x₀ x₁ x₂ : α)
    (h01 : StrictlyLessViscousOn targets Cost₀ Cost₁ x₀ x₁)
    (h12 : NoMoreViscousOn targets Cost₁ Cost₂ x₁ x₂) :
    StrictlyLessViscousOn targets Cost₀ Cost₂ x₀ x₂ := by
  constructor
  · exact noMoreViscousOn_trans
      targets Cost₀ Cost₁ Cost₂ x₀ x₁ x₂ h01.1 h12
  · rcases h01.2 with ⟨z, hz, hStrict⟩
    exact ⟨z, hz, lt_of_le_of_lt (h12 z hz) hStrict⟩

/-- A weakly non-worsening change followed by a strict viscosity improvement is
also strict relative to the ancestor. -/
theorem noMoreViscousOn_trans_strictlyLessViscousOn
    (targets : Set α)
    (Cost₀ Cost₁ Cost₂ : AccessibilityCost α)
    (x₀ x₁ x₂ : α)
    (h01 : NoMoreViscousOn targets Cost₀ Cost₁ x₀ x₁)
    (h12 : StrictlyLessViscousOn targets Cost₁ Cost₂ x₁ x₂) :
    StrictlyLessViscousOn targets Cost₀ Cost₂ x₀ x₂ := by
  constructor
  · exact noMoreViscousOn_trans
      targets Cost₀ Cost₁ Cost₂ x₀ x₁ x₂ h01 h12.1
  · rcases h12.2 with ⟨z, hz, hStrict⟩
    exact ⟨z, hz, lt_of_lt_of_le hStrict (h01 z hz)⟩

/-- Strict quantitative accessibility improvement composes transitively. -/
theorem strictlyLessViscousOn_trans
    (targets : Set α)
    (Cost₀ Cost₁ Cost₂ : AccessibilityCost α)
    (x₀ x₁ x₂ : α)
    (h01 : StrictlyLessViscousOn targets Cost₀ Cost₁ x₀ x₁)
    (h12 : StrictlyLessViscousOn targets Cost₁ Cost₂ x₁ x₂) :
    StrictlyLessViscousOn targets Cost₀ Cost₂ x₀ x₂ :=
  strictlyLessViscousOn_trans_noMoreViscousOn
    targets Cost₀ Cost₁ Cost₂ x₀ x₁ x₂ h01 h12.1

/-- Weak viscosity improvement preserves every candidate already affordable at
a fixed budget. -/
theorem noMoreViscousOn_preserves_budget_access
    (targets : Set α)
    (oldCost newCost : AccessibilityCost α)
    (oldState newState : α)
    (B : ℝ)
    (h : NoMoreViscousOn targets oldCost newCost oldState newState) :
    PreservesOn targets
      (BudgetSearch oldCost B oldState)
      (BudgetSearch newCost B newState) := by
  intro z hz hOld
  exact le_trans (h z hz) hOld

/-- Any strict cost improvement contains a target and an exact budget at which
that target is unaffordable before and affordable after. This is the
quantitative-to-binary threshold bridge. -/
theorem strictlyLessViscousOn_opens_budget_window
    (targets : Set α)
    (oldCost newCost : AccessibilityCost α)
    (oldState newState : α)
    (h :
      StrictlyLessViscousOn targets oldCost newCost oldState newState) :
    ∃ z B,
      z ∈ targets ∧
      ¬ AccessibleWithin oldCost B oldState z ∧
      AccessibleWithin newCost B newState z := by
  rcases h.2 with ⟨z, hz, hlt⟩
  refine ⟨z, newCost newState z, hz, ?_, ?_⟩
  · exact not_le.mpr hlt
  · exact le_rfl

/-- A strict quantitative improvement induces strict expansion of the
budget-thresholded candidate family at some budget. -/
theorem strictlyLessViscousOn_induces_strictExpansionAtBudget
    (targets : Set α)
    (oldCost newCost : AccessibilityCost α)
    (oldState newState : α)
    (h :
      StrictlyLessViscousOn targets oldCost newCost oldState newState) :
    ∃ B,
      StrictExpandsOn targets
        (BudgetSearch oldCost B oldState)
        (BudgetSearch newCost B newState) := by
  rcases h.2 with ⟨z, hz, hlt⟩
  let B : ℝ := newCost newState z
  refine ⟨B, ?_, z, hz, ?_, ?_⟩
  · exact noMoreViscousOn_preserves_budget_access
      targets oldCost newCost oldState newState B h.1
  · exact not_le.mpr hlt
  · exact le_rfl

/-- State-dependent quantitative second-order improvement under one common cost
geometry. This is the direct weighted analogue of the binary search expansion
used by \`SecondOrderClick\`. -/
def QuantitativeSecondOrderClick
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Cost : AccessibilityCost α)
    (x y : α) : Prop :=
  Step x y ∧
  Viable y ∧
  StrictlyLessViscousOn targets Cost Cost x y

/-- Every quantitative second-order click creates an ordinary binary
\`SecondOrderClick\` at some budget threshold. Therefore the existing v16 binary
formalization is recovered as a thresholded special case of the weighted
geometry. -/
theorem quantitativeSecondOrderClick_implies_secondOrderClick_at_some_budget
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Cost : AccessibilityCost α)
    {x y : α}
    (h : QuantitativeSecondOrderClick Step Viable targets Cost x y) :
    ∃ B,
      SecondOrderClick Step Viable targets (BudgetSearch Cost B) x y := by
  rcases h with ⟨hStep, hViable, hCost⟩
  obtain ⟨B, hExpand⟩ :=
    strictlyLessViscousOn_induces_strictExpansionAtBudget
      targets Cost Cost x y hCost
  exact ⟨B, hStep, hViable, hExpand⟩

/-- A strict quantitative improvement supplies an explicit target whose future
transition cost is lower. -/
theorem quantitativeSecondOrderClick_has_cheaper_future
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Cost : AccessibilityCost α)
    {x y : α}
    (h : QuantitativeSecondOrderClick Step Viable targets Cost x y) :
    ∃ z, z ∈ targets ∧ Cost y z < Cost x z := by
  exact h.2.2.2

/-!
## Minimal exact witness

The witness deliberately uses only two organizational states. State \`fluid\`
has lower future cost to the declared target \`fluid\` than state \`viscous\`,
while never increasing the cost of any target. The transition therefore
constitutes a quantitative second-order click and, at a suitable budget,
an ordinary binary second-order click.
-/

inductive ViscosityToy
  | viscous
  | fluid
  deriving DecidableEq

open ViscosityToy

def viscosityToyStep : ViscosityToy → ViscosityToy → Prop
  | viscous, fluid => True
  | _, _ => False

def viscosityToyViable : ViscosityToy → Prop := fun _ => True

def viscosityToyCost : AccessibilityCost ViscosityToy
  | viscous, viscous => 0
  | viscous, fluid => 2
  | fluid, viscous => 0
  | fluid, fluid => 1

theorem viscosityToy_quantitative_click :
    QuantitativeSecondOrderClick
      viscosityToyStep viscosityToyViable Set.univ viscosityToyCost
      viscous fluid := by
  refine ⟨by simp [viscosityToyStep], by simp [viscosityToyViable], ?_⟩
  constructor
  · intro z hz
    cases z <;> norm_num [viscosityToyCost]
  · exact ⟨fluid, by simp, by norm_num [viscosityToyCost]⟩

theorem viscosityToy_binary_click_at_budget_one :
    SecondOrderClick
      viscosityToyStep viscosityToyViable Set.univ
      (BudgetSearch viscosityToyCost 1)
      viscous fluid := by
  refine ⟨by simp [viscosityToyStep], by simp [viscosityToyViable], ?_⟩
  refine ⟨?_, fluid, by simp, ?_, ?_⟩
  · intro z hz hOld
    cases z with
    | viscous =>
        norm_num [BudgetSearch, AccessibleWithin, viscosityToyCost]
    | fluid =>
        norm_num [BudgetSearch, AccessibleWithin, viscosityToyCost] at hOld
  · norm_num [BudgetSearch, AccessibleWithin, viscosityToyCost]
  · norm_num [BudgetSearch, AccessibleWithin, viscosityToyCost]

#print axioms noMoreViscousOn_refl
#print axioms noMoreViscousOn_trans
#print axioms strictlyLessViscousOn_trans_noMoreViscousOn
#print axioms noMoreViscousOn_trans_strictlyLessViscousOn
#print axioms strictlyLessViscousOn_trans
#print axioms noMoreViscousOn_preserves_budget_access
#print axioms strictlyLessViscousOn_opens_budget_window
#print axioms strictlyLessViscousOn_induces_strictExpansionAtBudget
#print axioms quantitativeSecondOrderClick_implies_secondOrderClick_at_some_budget
#print axioms quantitativeSecondOrderClick_has_cheaper_future
#print axioms viscosityToy_quantitative_click
#print axioms viscosityToy_binary_click_at_budget_one

end RecursiveAccessibility
end CumulativeAccessibility
