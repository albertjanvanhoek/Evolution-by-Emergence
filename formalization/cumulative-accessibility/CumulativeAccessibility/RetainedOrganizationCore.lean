import CumulativeAccessibility.PaidRetentionTransfer

namespace CumulativeAccessibility
namespace RetainedOrganizationCore

/-!
# Retained organization as causal structure for future change

This is the substrate-agnostic v19/v20 core.

It deliberately does NOT use the older v17 recurrence/successor-count vocabulary
as its primitive language. The state variables and tests follow the retained-
organization formulation directly:

    S_t = (G_t, R_t, Gamma_t, B_gross_t)
    B_free = B_gross - M(R)
    K = K[G,R,Gamma;B_free]
    A_T = graded finite-horizon accessibility
    positive cumulative event = paid transfer to an unvisited target.

The transition machinery is kept abstract because it may be a stochastic kernel,
rewrite rule, reaction-rate structure, mutation/development distribution,
learning update, or construction/search process.
-/

variable {G R Γ Candidate Target : Type*}

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

/-- Abstract effective transition machinery. The codomain is intentionally only
a proposition-valued candidate relation; probability/rates can be carried in
richer application-specific Candidate types or separate structures. -/
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

/-- Generic retention/update operator. It may change both active and retained
organization. -/
abbrev RetentionOperator
    (G R Candidate : Type*) :=
  G → R → Candidate → G × R

/-- State after applying a retention/update operator to one candidate, keeping
the same declared context and gross budget for this one-step interface. -/
def retainCandidate
    (Ret : RetentionOperator G R Candidate)
    (s : State G R Γ)
    (candidate : Candidate) : State G R Γ :=
  let next := Ret s.active s.retained candidate
  { active := next.1
    retained := next.2
    context := s.context
    grossBudget := s.grossBudget }

/-- Higher means more accessible. The application chooses the interpretation:
probability, expected reach, feasible mass, reliability, or another declared
graded quantity. -/
abbrev Accessibility
    (G R Γ Target : Type*) :=
  ℕ → G → R → Γ → ℝ → Target → ℝ

/-- Accessibility of one target from one state after paying retained upkeep. -/
def stateAccessibility
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (s : State G R Γ)
    (y : Target) : ℝ :=
  A T s.active s.retained s.context (freeBudget M s) y

/-- Two counterfactual states are gross-budget matched when the comparison does
not hand the retained arm extra resources. -/
def SameGrossBudget
    (sMinus sPlus : State G R Γ) : Prop :=
  sMinus.grossBudget = sPlus.grossBudget

/-- Paid transfer gain in the v19 sense. Positive values favor the retained arm
after each arm pays its own total maintenance burden. -/
def transferGain
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) : ℝ :=
  stateAccessibility A M T sPlus y -
    stateAccessibility A M T sMinus y

/-- Positive paid transfer to one target. -/
def PositiveTransferAt
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) : Prop :=
  0 < transferGain A M T sMinus sPlus y

/-- The informative cumulative event: same-gross-budget paid retention improves
graded access to a target not already visited. -/
def PositiveTransferToUnvisited
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) : Prop :=
  SameGrossBudget sMinus sPlus ∧
  y ∉ Visited ∧
  PositiveTransferAt A M T sMinus sPlus y

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
  linarith

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

/-! ## Retention firewall

The five predicates are application interfaces. The core does not pretend to
derive empirical endogeneity, timescale separation, burden, causal reuse, or
transfer from labels alone.
-/

/-- Application says that retained organization X was generated by the
system's own dynamics. -/
abbrev Endogenous (X : Type*) := X → Prop

/-- Application says that X persists/reconstructs beyond the creating event on
a declared timescale separation. -/
abbrev SlowRetained (X : Type*) := X → Prop

/-- Application says that X carries an explicitly represented burden. -/
abbrev PaidRetained (X : Type*) := X → Prop

/-- Application supplies a later ablation/counterfactual showing causal reuse. -/
abbrev ReusedLater (X : Type*) := X → Prop

/-- Application supplies a later-context/episode/descendant/task transfer
criterion rather than mere persistence of the same instantaneous state. -/
abbrev TransferableLater (X : Type*) := X → Prop

structure RetainedOrganizationalMemory
    (X : Type*)
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Paid : PaidRetained X)
    (Reused : ReusedLater X)
    (Transferable : TransferableLater X)
    (x : X) : Prop where
  endogenous : Endo x
  slow : Slow x
  paid : Paid x
  reused : Reused x
  transferable : Transferable x

/-- A full cumulative paid-transfer event combines the retention firewall with
the graded unvisited-target test. -/
def CumulativePaidTransferEvent
    {X : Type*}
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Paid : PaidRetained X)
    (Reused : ReusedLater X)
    (Transferable : TransferableLater X)
    (x : X)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target) : Prop :=
  RetainedOrganizationalMemory
      X Endo Slow Paid Reused Transferable x ∧
  PositiveTransferToUnvisited
      Visited A M T sMinus sPlus y

theorem cumulativePaidTransfer_has_unvisited_positive_transfer
    {X : Type*}
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Paid : PaidRetained X)
    (Reused : ReusedLater X)
    (Transferable : TransferableLater X)
    (x : X)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (y : Target)
    (h :
      CumulativePaidTransferEvent
        Endo Slow Paid Reused Transferable x
        Visited A M T sMinus sPlus y) :
    SameGrossBudget sMinus sPlus ∧
    y ∉ Visited ∧
    stateAccessibility A M T sMinus y <
      stateAccessibility A M T sPlus y := by
  refine ⟨h.2.1, h.2.2.1, ?_⟩
  exact (positiveTransfer_iff_accessibility_strictly_higher
    A M T sMinus sPlus y).1 h.2.2.2

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

#print axioms positiveTransfer_iff_accessibility_strictly_higher
#print axioms sameGrossBudget_freeBudget_difference
#print axioms cumulativePaidTransfer_has_unvisited_positive_transfer
#print axioms transition_change_without_paid_transfer

end RetainedOrganizationCore
end CumulativeAccessibility
