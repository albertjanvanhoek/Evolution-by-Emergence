import CumulativeAccessibility.EmergentAssemblyBarrier
import CumulativeAccessibility.TransitionAccessibility
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

namespace CumulativeAccessibility
namespace TransitionMediatedEmergence

open RecursiveAccessibility
open TransitionAccessibility
open RetainedOrganizationCore

/-!
# Transition-mediated emergence

This module merges the mechanistic contribution of the independent
`EmergenceAccessibility` review branch into the single PR64 accessibility
semantics.

The abstract `EmergentAssemblyBarrier` theorem says that a future emergent
function cannot finance a positively costly proper intermediate by that future
function alone. Here we add the causal specialization:

* the function `phi` changes future accessibility by opening a transition;
* a proper subconfiguration of a strictly emergent whole does not realize
  `phi`;
* therefore its kernel receives no `phi`-mediated transition advantage;
* with non-decreasing upkeep relative to the ablated arm, it cannot exhibit
  positive paid opening through that mechanism.

The result is deliberately conditional. A proper part may still persist through
another function, reuse, exaptation, subsidy, drift, or another transition.
Concrete witnesses and countermodels below make those escape routes explicit.
-/

variable {Config Context Capacity σ : Type*}

/-- Add one function-mediated transition to a base kernel when the retained
configuration realizes the declared capacity. Existing base transitions keep
their original cost; the function can only add a previously unavailable edge in
this specialization. -/
open Classical in
noncomputable def phiKernel
    (K0 : WeightedKernel σ)
    (Realizes : CapacityRelation Config Context Capacity)
    (ctx : Context)
    (φ : Capacity)
    (src tgt : σ)
    (cφ : ℝ)
    (hcφ : 0 ≤ cφ)
    (config : Config) : WeightedKernel σ where
  allowed := fun u v =>
    K0.allowed u v ∨
      (Realizes config ctx φ ∧ u = src ∧ v = tgt)
  cost := fun u v =>
    if K0.allowed u v then K0.cost u v else cφ
  cost_nonneg := by
    intro u v hAllowed
    classical
    by_cases hBase : K0.allowed u v
    · simpa [hBase] using K0.cost_nonneg u v hBase
    · have hPhi :
          Realizes config ctx φ ∧ u = src ∧ v = tgt := by
        rcases hAllowed with h | h
        · exact False.elim (hBase h)
        · exact h
      simp [hBase, hcφ]

/-- If a configuration does not realize `φ`, its function-mediated kernel has
only base transitions. Any other configuration's `phiKernel` therefore
dominates it: every transition it has is preserved at the same cost. -/
theorem phiKernel_dominates_nonrealizer
    (K0 : WeightedKernel σ)
    (Realizes : CapacityRelation Config Context Capacity)
    (ctx : Context)
    (φ : Capacity)
    (src tgt : σ)
    (cφ : ℝ)
    (hcφ : 0 ≤ cφ)
    (sub other : Config)
    (hSub : ¬ Realizes sub ctx φ) :
    KernelDominates
      (phiKernel K0 Realizes ctx φ src tgt cφ hcφ other)
      (phiKernel K0 Realizes ctx φ src tgt cφ hcφ sub) := by
  constructor
  · intro u v hAllowed
    classical
    rcases hAllowed with hBase | hPhi
    · exact Or.inl hBase
    · exact False.elim (hSub hPhi.1)
  · intro u v hAllowed
    classical
    have hBase : K0.allowed u v := by
      rcases hAllowed with h | h
      · exact h
      · exact False.elim (hSub h.1)
    simp [phiKernel, hBase]

/-- **Mechanistic emergence barrier.**

If `φ` is strictly emergent at `whole`, a proper subconfiguration `sub`
does not realize `φ`. In the `phiKernel` specialization it therefore receives
no `φ`-mediated transition advantage. If retaining `sub` costs at least as
much as the comparison arm, positive paid opening through this mechanism is
impossible.

This is the transition-level specialization of the abstract assembly barrier;
it derives the missing benefit from the transition machinery instead of
postulating a separate benefit function. -/
theorem emergent_proper_subconfig_no_phi_paidOpening
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (whole sub rMinus : Config)
    (ctx : Context)
    (φ : Capacity)
    (K0 : WeightedKernel σ)
    (src tgt : σ)
    (cφ : ℝ)
    (hcφ : 0 ≤ cφ)
    (M : Maintenance Config)
    (T : ℕ)
    (grossBudget : ℝ)
    (s y : σ)
    (hEmergent : EmergentUnder Proper Realizes whole ctx φ)
    (hProper : Proper sub whole)
    (hUpkeep : M rMinus ≤ M sub) :
    ¬ PositivePaidOpening
      (fun config =>
        phiKernel K0 Realizes ctx φ src tgt cφ hcφ config)
      M T grossBudget rMinus sub s y := by
  intro hOpening
  have hNoRealize : ¬ Realizes sub ctx φ :=
    hEmergent.2 sub hProper
  have hNeedsAdvantage :
      ¬ KernelDominates
        (phiKernel K0 Realizes ctx φ src tgt cφ hcφ rMinus)
        (phiKernel K0 Realizes ctx φ src tgt cφ hcφ sub) :=
    positivePaidOpening_requires_kernel_advantage
      (fun config =>
        phiKernel K0 Realizes ctx φ src tgt cφ hcφ config)
      M T grossBudget rMinus sub s y hUpkeep hOpening
  exact hNeedsAdvantage
    (phiKernel_dominates_nonrealizer
      K0 Realizes ctx φ src tgt cφ hcφ
      sub rMinus hNoRealize)

/-! ## Finite-component witness and adversarial countermodels -/

abbrev ToyOrg := Fin 3

def toyBaseKernel : WeightedKernel ToyOrg where
  allowed := fun _ _ => False
  cost := fun _ _ => 0
  cost_nonneg := by
    intro u v h
    contradiction

def properSubset (P X : Finset Bool) : Prop :=
  P ⊂ X

def realizesBoth
    (R : Finset Bool) (_ : Unit) (_ : Unit) : Prop :=
  R = Finset.univ

def realizesTrue
    (R : Finset Bool) (_ : Unit) (_ : Unit) : Prop :=
  true ∈ R

noncomputable def toyUpkeep : Maintenance (Finset Bool) :=
  fun R => (R.card : ℝ) / 10

theorem realizesBoth_emergent :
    EmergentUnder
      properSubset realizesBoth
      (Finset.univ : Finset Bool) () () := by
  refine ⟨rfl, ?_⟩
  intro P hP hRealize
  exact (Finset.ssubset_iff_subset_ne.mp hP).2 hRealize

def toyPhiKernel (R : Finset Bool) : WeightedKernel ToyOrg :=
  phiKernel toyBaseKernel realizesBoth () ()
    0 1 1 (by norm_num) R

def toyNonEmergentKernel (R : Finset Bool) : WeightedKernel ToyOrg :=
  phiKernel toyBaseKernel realizesTrue () ()
    0 1 1 (by norm_num) R

def toyRetainWholeRoute :
    Route (toyPhiKernel Finset.univ) 0 1 1 :=
  .step (by
    right
    exact ⟨rfl, rfl, rfl⟩)
    (.stay 1)

/-- The empty ablated arm has no route from 0 to 1. -/
theorem toy_empty_not_reachable :
    ¬ ReachableWithin (toyPhiKernel ∅) 1 2 0 1 := by
  intro h
  rcases h with ⟨n, hn, route, hCost⟩
  cases route with
  | step hEdge rest =>
      rcases hEdge with hBase | hPhi
      · exact hBase
      · simp [realizesBoth] at hPhi

/-- **Non-vacuity.** The whole emergent configuration opens a transition that
still pays after its positive upkeep. -/
theorem witness_emergent_whole_positive_paidOpening :
    PositivePaidOpening
      toyPhiKernel toyUpkeep
      1 2 ∅ Finset.univ 0 1 := by
  apply route_advantage_overcomes_upkeep
    toyPhiKernel toyUpkeep
    1 1 2 ∅ Finset.univ 0 1
    toyRetainWholeRoute
  · norm_num
  · norm_num [toyRetainWholeRoute, Route.cost, toyPhiKernel,
      phiKernel, toyBaseKernel, toyUpkeep]
  · simpa [PaidReachableWithin, toyUpkeep] using
      toy_empty_not_reachable

/-- Any single component is a proper part of the two-component emergent whole. -/
theorem singleton_proper_univ (c : Bool) :
    properSubset {c} (Finset.univ : Finset Bool) := by
  rw [properSubset, Finset.ssubset_iff_subset_ne]
  refine ⟨Finset.subset_univ _, ?_⟩
  intro hEq
  have hCard := congrArg Finset.card hEq
  simp at hCard

/-- The future emergent function cannot fund the first single-component step
through its own transition effect. -/
theorem witness_single_component_no_phi_paidOpening
    (c : Bool) :
    ¬ PositivePaidOpening
      toyPhiKernel toyUpkeep
      1 2 ∅ {c} 0 1 := by
  apply emergent_proper_subconfig_no_phi_paidOpening
    properSubset realizesBoth
    (Finset.univ : Finset Bool) {c} ∅
    () () toyBaseKernel
    0 1 1 (by norm_num)
    toyUpkeep 1 2 0 1
    realizesBoth_emergent
    (singleton_proper_univ c)
  simp [toyUpkeep]

def toyNonEmergentRoute :
    Route (toyNonEmergentKernel {true}) 0 1 1 :=
  .step (by
    right
    exact ⟨by simp [realizesTrue], rfl, rfl⟩)
    (.stay 1)

theorem toy_nonEmergent_empty_not_reachable :
    ¬ ReachableWithin (toyNonEmergentKernel ∅) 1 2 0 1 := by
  intro h
  rcases h with ⟨n, hn, route, hCost⟩
  cases route with
  | step hEdge rest =>
      rcases hEdge with hBase | hPhi
      · exact hBase
      · simp [realizesTrue] at hPhi

/-- **Drop emergence.** When one component already realizes the function, that
single component can produce positive paid opening. -/
theorem countermodel_nonEmergent_part_transfers :
    PositivePaidOpening
      toyNonEmergentKernel toyUpkeep
      1 2 ∅ {true} 0 1 := by
  apply route_advantage_overcomes_upkeep
    toyNonEmergentKernel toyUpkeep
    1 1 2 ∅ {true} 0 1
    toyNonEmergentRoute
  · norm_num
  · norm_num [toyNonEmergentRoute, Route.cost,
      toyNonEmergentKernel, phiKernel, toyBaseKernel, toyUpkeep]
  · simpa [PaidReachableWithin, toyUpkeep] using
      toy_nonEmergent_empty_not_reachable

/-- A kernel with one transition costing 5/2. -/
def costlyKernel : WeightedKernel ToyOrg where
  allowed := fun u v => u = 0 ∧ v = 2
  cost := fun _ _ => 5 / 2
  cost_nonneg := by
    intro u v h
    norm_num

def sameCostlyKernel (_ : Bool) : WeightedKernel ToyOrg :=
  costlyKernel

def subsidizedMaintenance : Maintenance Bool
  | false => 0
  | true => -1

def costlyRoute :
    Route costlyKernel 0 2 1 :=
  .step ⟨rfl, rfl⟩ (.stay 2)

theorem costly_not_reachable_at_budget_two :
    ¬ ReachableWithin costlyKernel 1 2 0 2 := by
  intro h
  rcases h with ⟨n, hn, route, hCost⟩
  cases route with
  | step hEdge rest =>
      norm_num [Route.cost, costlyKernel] at hCost

/-- **Drop non-decreasing upkeep.** A subsidized retained arm can show apparent
paid opening even when retention changes no transition at all. -/
theorem countermodel_negative_upkeep :
    PositivePaidOpening
      sameCostlyKernel subsidizedMaintenance
      1 2 false true 0 2 := by
  apply route_advantage_overcomes_upkeep
    sameCostlyKernel subsidizedMaintenance
    1 1 2 false true 0 2
    costlyRoute
  · norm_num
  · norm_num [costlyRoute, Route.cost, sameCostlyKernel,
      costlyKernel, subsidizedMaintenance]
  · simpa [PaidReachableWithin, sameCostlyKernel,
      subsidizedMaintenance] using
      costly_not_reachable_at_budget_two

/-- A stepping-stone kernel. The final emergent function still opens 0 -> 1,
but component `false` independently opens 0 -> 2. -/
def steppingKernel (R : Finset Bool) : WeightedKernel ToyOrg where
  allowed := fun u v =>
    (realizesBoth R () () ∧ u = 0 ∧ v = 1) ∨
      (false ∈ R ∧ u = 0 ∧ v = 2)
  cost := fun _ _ => 1
  cost_nonneg := by
    intro u v h
    norm_num

def steppingStoneRoute :
    Route (steppingKernel {false}) 0 2 1 :=
  .step (by
    right
    exact ⟨by simp, rfl, rfl⟩)
    (.stay 2)

theorem stepping_empty_not_reachable :
    ¬ ReachableWithin (steppingKernel ∅) 1 2 0 2 := by
  intro h
  rcases h with ⟨n, hn, route, hCost⟩
  cases route with
  | step hEdge rest =>
      rcases hEdge with hPhi | hStep
      · simp [realizesBoth] at hPhi
      · simp at hStep

/-- **Stepping-stone escape.** A proper part can pay for itself through another
transition while the final function remains strictly emergent. This is the
transition-level realization of the abstract theorem's auxiliary support. -/
theorem steppingStone_part_transfers :
    PositivePaidOpening
      steppingKernel toyUpkeep
      1 2 ∅ {false} 0 2 := by
  apply route_advantage_overcomes_upkeep
    steppingKernel toyUpkeep
    1 1 2 ∅ {false} 0 2
    steppingStoneRoute
  · norm_num
  · norm_num [steppingStoneRoute, Route.cost,
      steppingKernel, toyUpkeep]
  · simpa [PaidReachableWithin, toyUpkeep] using
      stepping_empty_not_reachable

#print axioms phiKernel_dominates_nonrealizer
#print axioms emergent_proper_subconfig_no_phi_paidOpening
#print axioms realizesBoth_emergent
#print axioms witness_emergent_whole_positive_paidOpening
#print axioms witness_single_component_no_phi_paidOpening
#print axioms countermodel_nonEmergent_part_transfers
#print axioms countermodel_negative_upkeep
#print axioms steppingStone_part_transfers

end TransitionMediatedEmergence
end CumulativeAccessibility
