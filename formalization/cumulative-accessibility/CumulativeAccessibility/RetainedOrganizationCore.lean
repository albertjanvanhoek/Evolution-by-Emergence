import CumulativeAccessibility.PaidRetentionTransfer

namespace CumulativeAccessibility
namespace RetainedOrganizationCore

/-!
# Retained organization as causal structure for future change

This is the substrate-agnostic retained-organization core.

Primitive language:

    S_t = (G_t, R_t, Gamma_t, B_gross_t)
    B_free = B_gross - M(R)
    K = K[G,R,Gamma;B_free]
    A_T = graded finite-horizon accessibility
    cumulative event = paid transfer by a particular retained item X
                       to an unvisited target.

The theory does not assume one substrate. The transition machinery may represent
stochastic mutation/development, reaction or rewrite dynamics, neural update,
language transmission, technological search/construction, or another declared
mechanism.

The core deliberately distinguishes:

* ordinary state dependence;
* a retained-item counterfactual;
* maintenance burden;
* causal reuse under ablation;
* graded transfer to a target not already visited.
-/

variable {G R Γ X Candidate Target : Type*}

/-- Substrate-agnostic system state. -/
structure State (G R Γ : Type*) where
  active : G
  retained : R
  context : Γ
  grossBudget : ℝ

/-- Declared total upkeep/storage/reconstruction burden of retained
organization. -/
abbrev Maintenance (R : Type*) := R → ℝ

/-- Resource remaining after retained organization is paid for. -/
def freeBudget
    (M : Maintenance R)
    (s : State G R Γ) : ℝ :=
  s.grossBudget - M s.retained

/-- Abstract effective transition machinery. -/
abbrev TransitionMachinery
    (G R Γ Candidate : Type*) :=
  G → R → Γ → ℝ → Candidate → Prop

/-- Candidate generation under the effective transition machinery. -/
def GeneratedBy
    (K : TransitionMachinery G R Γ Candidate)
    (M : Maintenance R)
    (s : State G R Γ)
    (candidate : Candidate) : Prop :=
  K s.active s.retained s.context (freeBudget M s) candidate

/-- Generic one-step retention/update operator for generated organization. -/
abbrev RetentionOperator
    (G R Candidate : Type*) :=
  G → R → Candidate → G × R

/-- State after applying a one-step retention/update operator. -/
def retainCandidate
    (Ret : RetentionOperator G R Candidate)
    (s : State G R Γ)
    (candidate : Candidate) : State G R Γ :=
  let next := Ret s.active s.retained candidate
  { active := next.1
    retained := next.2
    context := s.context
    grossBudget := s.grossBudget }

/-- Item-level retained/ablated counterfactual operators. They modify only the
retained organization of the comparison state. -/
abbrev RetainItem (R X : Type*) := R → X → R
abbrev LoseItem (R X : Type*) := R → X → R

/-- Counterfactual arm in which item X is retained. -/
def retainedArm
    (Retain : RetainItem R X)
    (base : State G R Γ)
    (x : X) : State G R Γ :=
  { active := base.active
    retained := Retain base.retained x
    context := base.context
    grossBudget := base.grossBudget }

/-- Counterfactual arm in which item X is absent/ablated. -/
def ablatedArm
    (Lose : LoseItem R X)
    (base : State G R Γ)
    (x : X) : State G R Γ :=
  { active := base.active
    retained := Lose base.retained x
    context := base.context
    grossBudget := base.grossBudget }

/-- The retained and ablated arms are automatically matched on active
organization, context, and gross budget. -/
theorem itemContrast_matches_background
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (base : State G R Γ)
    (x : X) :
    (retainedArm Retain base x).active = (ablatedArm Lose base x).active ∧
    (retainedArm Retain base x).context = (ablatedArm Lose base x).context ∧
    (retainedArm Retain base x).grossBudget =
      (ablatedArm Lose base x).grossBudget := by
  exact ⟨rfl, rfl, rfl⟩

/-- Higher means more accessible. The application chooses the interpretation:
probability, expected reach, feasible mass, reliability, or another declared
graded quantity. -/
abbrev Accessibility
    (G R Γ Target : Type*) :=
  ℕ → G → R → Γ → ℝ → Target → ℝ

/-- Accessibility must not decrease merely because more free budget is
available. This blocks a spurious "benefit" created solely by charging more
upkeep. -/
def BudgetMonotone
    (A : Accessibility G R Γ Target) : Prop :=
  ∀ T g r γ y b₁ b₂,
    b₁ ≤ b₂ →
    A T g r γ b₁ y ≤ A T g r γ b₂ y

/-- Accessibility of one target from one state after paying retained upkeep. -/
def stateAccessibility
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (s : State G R Γ)
    (y : Target) : ℝ :=
  A T s.active s.retained s.context (freeBudget M s) y

/-- Two arbitrary states are gross-budget matched. Item-level contrasts below
satisfy this automatically by construction. -/
def SameGrossBudget
    (sMinus sPlus : State G R Γ) : Prop :=
  sMinus.grossBudget = sPlus.grossBudget

/-- Same gross budget yields the exact free-budget difference implied by the
difference in retained maintenance burden. -/
theorem sameGrossBudget_freeBudget_difference
    (M : Maintenance R)
    (sMinus sPlus : State G R Γ)
    (hGross : SameGrossBudget sMinus sPlus) :
    freeBudget M sPlus - freeBudget M sMinus
      =
    M sMinus.retained - M sPlus.retained := by
  unfold SameGrossBudget at hGross
  unfold freeBudget
  rw [hGross]
  ring

/-- Paid transfer gain. Positive values favor the retained arm after each arm
pays its own total maintenance burden. -/
def transferGain
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) : ℝ :=
  stateAccessibility A M T sPlus y -
    stateAccessibility A M T sMinus y

def PositiveTransferAt
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) : Prop :=
  0 < transferGain A M T sMinus sPlus y

/-- Item-specific paid transfer. The two arms are generated from the same base
state and the same retained item X. -/
def PositiveTransferForItem
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (x : X)
    (y : Target) : Prop :=
  PositiveTransferAt A M T
    (ablatedArm Lose base x)
    (retainedArm Retain base x)
    y

/-- Positive item-specific transfer to a target not already visited. -/
def PositiveTransferToUnvisitedForItem
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (x : X)
    (y : Target) : Prop :=
  y ∉ Visited ∧
  PositiveTransferForItem Retain Lose A M T base x y

theorem positiveTransfer_iff_accessibility_strictly_higher
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) :
    PositiveTransferAt A M T sMinus sPlus y
      ↔
    stateAccessibility A M T sMinus y <
      stateAccessibility A M T sPlus y := by
  unfold PositiveTransferAt transferGain
  constructor <;> intro h <;> linarith

/-- The item is genuinely paid for when the retained arm has strictly greater
declared maintenance burden than the ablated arm. -/
def StrictlyPaidItem
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (M : Maintenance R)
    (base : State G R Γ)
    (x : X) : Prop :=
  M (Lose base.retained x) < M (Retain base.retained x)

/-- Strictly positive marginal upkeep lowers the retained arm's free budget. -/
theorem strictlyPaidItem_reduces_freeBudget
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (M : Maintenance R)
    (base : State G R Γ)
    (x : X)
    (hPaid : StrictlyPaidItem Retain Lose M base x) :
    freeBudget M (retainedArm Retain base x) <
      freeBudget M (ablatedArm Lose base x) := by
  unfold StrictlyPaidItem at hPaid
  simp [freeBudget, retainedArm, ablatedArm]
  linarith

/-- Causal reuse under ablation: at some positive horizon and a matched free
budget, the retained organization changes accessibility to some target. This is
a later-use criterion, independent of whether that target is itself novel. -/
def CausallyReused
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (A : Accessibility G R Γ Target)
    (base : State G R Γ)
    (x : X) : Prop :=
  ∃ T : ℕ, 0 < T ∧
    ∃ b y,
      A T base.active (Retain base.retained x) base.context b y ≠
        A T base.active (Lose base.retained x) base.context b y

/-! ## Retention firewall

Endogeneity and time-scale separation remain empirical/application predicates.
Paid burden and causal reuse are now encoded directly in the retained-item
counterfactual, and transferability is the positive paid-transfer test itself.
-/

abbrev Endogenous (X : Type*) := X → Prop
abbrev SlowRetained (X : Type*) := X → Prop

/-- Full cumulative paid-transfer certificate for a particular retained item.
This encodes the five firewall ideas as:

1. endogenous — application-supplied;
2. slow/reconstructibly persistent — application-supplied;
3. paid — strictly greater upkeep in the retained arm;
4. reused — later matched-budget ablation changes accessibility;
5. transferable — positive paid access to an unvisited target.

Budget monotonicity is part of the accessibility semantics so that paying more
cannot manufacture a positive result.
-/
structure CumulativePaidTransferEvent
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (x : X)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (y : Target) : Prop where
  endogenous : Endo x
  slow : Slow x
  budgetMonotone : BudgetMonotone A
  paid : StrictlyPaidItem Retain Lose M base x
  reused : CausallyReused Retain Lose A base x
  unvisited : y ∉ Visited
  transfer : PositiveTransferForItem Retain Lose A M T base x y

/-- A cumulative paid-transfer certificate gives the intended unvisited-target
graded accessibility inequality for the same retained item X. -/
theorem cumulativePaidTransfer_has_unvisited_positive_transfer
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (x : X)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (y : Target)
    (h :
      CumulativePaidTransferEvent
        Endo Slow Retain Lose x
        Visited A M T base y) :
    y ∉ Visited ∧
    stateAccessibility A M T (ablatedArm Lose base x) y <
      stateAccessibility A M T (retainedArm Retain base x) y := by
  refine ⟨h.unvisited, ?_⟩
  exact
    (positiveTransfer_iff_accessibility_strictly_higher
      A M T
      (ablatedArm Lose base x)
      (retainedArm Retain base x)
      y).1 h.transfer

/-- With monotone accessibility and positive upkeep, observed positive paid
transfer cannot be an artifact of having *less* free budget. At the retained
arm's lower free budget, the retained organization still strictly outperforms
the ablated organization at that exact same budget.

This is the machine-checked "gain exceeds upkeep penalty" interpretation. -/
theorem positivePaidTransfer_implies_sameBudget_retention_advantage
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (x : X)
    (y : Target)
    (hMono : BudgetMonotone A)
    (hPaid : StrictlyPaidItem Retain Lose M base x)
    (hTransfer : PositiveTransferForItem Retain Lose A M T base x y) :
    A T base.active (Lose base.retained x) base.context
        (freeBudget M (retainedArm Retain base x)) y
      <
    A T base.active (Retain base.retained x) base.context
        (freeBudget M (retainedArm Retain base x)) y := by
  have hBudget :
      freeBudget M (retainedArm Retain base x) ≤
        freeBudget M (ablatedArm Lose base x) :=
    le_of_lt (strictlyPaidItem_reduces_freeBudget
      Retain Lose M base x hPaid)
  have hMinusMono :=
    hMono T base.active (Lose base.retained x) base.context y
      (freeBudget M (retainedArm Retain base x))
      (freeBudget M (ablatedArm Lose base x))
      hBudget
  have hPaidTransfer :
      stateAccessibility A M T (ablatedArm Lose base x) y <
        stateAccessibility A M T (retainedArm Retain base x) y :=
    (positiveTransfer_iff_accessibility_strictly_higher
      A M T
      (ablatedArm Lose base x)
      (retainedArm Retain base x)
      y).1 hTransfer
  simp [stateAccessibility, retainedArm, ablatedArm] at hPaidTransfer
  exact lt_of_le_of_lt hMinusMono hPaidTransfer

/-- The full certificate inherits the same-budget structural advantage. -/
theorem cumulativePaidTransfer_gain_exceeds_upkeep_penalty
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (x : X)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (y : Target)
    (h :
      CumulativePaidTransferEvent
        Endo Slow Retain Lose x
        Visited A M T base y) :
    A T base.active (Lose base.retained x) base.context
        (freeBudget M (retainedArm Retain base x)) y
      <
    A T base.active (Retain base.retained x) base.context
        (freeBudget M (retainedArm Retain base x)) y := by
  exact positivePaidTransfer_implies_sameBudget_retention_advantage
    Retain Lose A M T base x y
    h.budgetMonotone h.paid h.transfer

/-! ## Weak state dependence is not the cumulative criterion -/

/-- The effective transition relation differs on at least one candidate. This is
the weak state-dependence notion; it says nothing about paid transfer. -/
def TransitionMachineryChanges
    (K : TransitionMachinery G R Γ Candidate)
    (M : Maintenance R)
    (s0 s1 : State G R Γ) : Prop :=
  ∃ c,
    GeneratedBy K M s0 c ↔ ¬ GeneratedBy K M s1 c

/-- Exact logical separation witness: transition machinery can change while
graded accessibility is identical for every target, hence no positive transfer
occurs. -/
theorem transition_change_without_paid_transfer :
    ∃ (K : TransitionMachinery Bool Bool Unit Bool)
      (M : Maintenance Bool)
      (A : Accessibility Bool Bool Unit Unit)
      (s0 s1 : State Bool Bool Unit),
      TransitionMachineryChanges K M s0 s1 ∧
      SameGrossBudget s0 s1 ∧
      ¬ PositiveTransferAt A M 1 s0 s1 () := by
  let K : TransitionMachinery Bool Bool Unit Bool :=
    fun g _ _ _ candidate => candidate = g
  let M : Maintenance Bool := fun _ => 0
  let A : Accessibility Bool Bool Unit Unit :=
    fun _ _ _ _ _ _ => 0
  let s0 : State Bool Bool Unit :=
    { active := false, retained := false, context := (), grossBudget := 1 }
  let s1 : State Bool Bool Unit :=
    { active := true, retained := false, context := (), grossBudget := 1 }
  refine ⟨K, M, A, s0, s1, ?_, ?_, ?_⟩
  · refine ⟨false, ?_⟩
    simp [GeneratedBy, K, s0, s1, freeBudget, M]
  · rfl
  · simp [PositiveTransferAt, transferGain, stateAccessibility, A,
      s0, s1, freeBudget, M]

#print axioms itemContrast_matches_background
#print axioms positiveTransfer_iff_accessibility_strictly_higher
#print axioms strictlyPaidItem_reduces_freeBudget
#print axioms cumulativePaidTransfer_has_unvisited_positive_transfer
#print axioms positivePaidTransfer_implies_sameBudget_retention_advantage
#print axioms cumulativePaidTransfer_gain_exceeds_upkeep_penalty
#print axioms transition_change_without_paid_transfer

end RetainedOrganizationCore
end CumulativeAccessibility
