import CumulativeAccessibility

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Recursive accessibility

This file formalizes five narrow consequences of the cumulative-accessibility
framework.

1. Persistence enlarges finite-horizon search opportunity when the per-instance
   search rate is held fixed.
2. Retained viable intermediates can make a target reachable in two steps even
   when it is not directly reachable from baseline.
3. A viable transition can alter the search operator itself, giving a precise
   second-order accessibility click.
4. If retained history preserves the ancestor's candidate repertoire, a later
   second-order click composes into strict search-operator expansion relative
   to that ancestor.
5. Deeper retained reachability and search-operator expansion are distinct:
   explicit finite witnesses show that neither should be silently substituted
   for the other.

The results are deliberately operational. They do not identify persistence
with fitness, function, or indefinite survival, and they do not assume that
more search is always better.
-/

section SearchOpportunity

/-- Expected finite-horizon search opportunity in the homogeneous expectation
model: each viable instance produces `nu` candidate variations and expected
instance count at generation `t` is proportional to `R^t`. -/
noncomputable def finiteSearchOpportunity
    (nu R : ℝ) (H : ℕ) : ℝ :=
  nu * ∑ t in Finset.range (H + 1), R ^ t

/-- Powers are monotone in the nonnegative base. Proved here directly so the
search-opportunity theorem does not depend on a specialized library lemma. -/
theorem pow_mono_nonneg
    {R S : ℝ} (hR0 : 0 ≤ R) (hRS : R ≤ S) :
    ∀ n : ℕ, R ^ n ≤ S ^ n := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
      rw [pow_succ, pow_succ]
      have hS0 : 0 ≤ S := le_trans hR0 hRS
      exact mul_le_mul ih hRS hR0 (pow_nonneg hS0 n)

/-- Holding nonnegative per-instance search rate fixed, increasing the
nonnegative reproduction factor cannot reduce finite-horizon expected search
opportunity. -/
theorem finiteSearchOpportunity_mono
    {nu R S : ℝ} {H : ℕ}
    (hnu : 0 ≤ nu) (hR0 : 0 ≤ R) (hRS : R ≤ S) :
    finiteSearchOpportunity nu R H ≤
      finiteSearchOpportunity nu S H := by
  unfold finiteSearchOpportunity
  apply mul_le_mul_of_nonneg_left ?_ hnu
  apply Finset.sum_le_sum
  intro t ht
  exact pow_mono_nonneg hR0 hRS t

/-- At exact replacement `R = 1`, finite-horizon expected search opportunity
is linear in the number of generations observed. -/
theorem finiteSearchOpportunity_at_one
    (nu : ℝ) (H : ℕ) :
    finiteSearchOpportunity nu 1 H
      = nu * (((H + 1 : ℕ) : ℝ)) := by
  simp [finiteSearchOpportunity]

/-- Zero variation production gives zero search opportunity regardless of the
reproduction factor. This keeps persistence conceptually separate from
innovation. -/
theorem finiteSearchOpportunity_zero_variation
    (R : ℝ) (H : ℕ) :
    finiteSearchOpportunity 0 R H = 0 := by
  simp [finiteSearchOpportunity]

end SearchOpportunity

section ViableSteppingStones

/-- `ViableReach Step Viable start H y` means `y` can be reached from `start`
within at most `H` retained steps. A step may be delayed (`stay`), and every
newly entered state must satisfy the declared viability predicate. -/
inductive ViableReach
    (Step : α → α → Prop) (Viable : α → Prop) (start : α) :
    ℕ → α → Prop
  | refl : ViableReach Step Viable start 0 start
  | stay {n : ℕ} {y : α} :
      ViableReach Step Viable start n y →
      ViableReach Step Viable start (n + 1) y
  | step {n : ℕ} {y z : α} :
      ViableReach Step Viable start n y →
      Step y z →
      Viable z →
      ViableReach Step Viable start (n + 1) z

/-- The set of states reachable within the declared retained-step horizon. -/
def reachableWithin
    (Step : α → α → Prop) (Viable : α → Prop)
    (start : α) (H : ℕ) : Set α :=
  {y | ViableReach Step Viable start H y}

/-- Increasing the horizon by one never removes a state that was already
reachable. -/
theorem reachableWithin_mono_one
    (Step : α → α → Prop) (Viable : α → Prop)
    (start : α) (H : ℕ) :
    reachableWithin Step Viable start H ⊆
      reachableWithin Step Viable start (H + 1) := by
  intro y hy
  exact ViableReach.stay hy

/-- A viable direct successor is reachable within one retained step. -/
theorem viableReach_one_step
    (Step : α → α → Prop) (Viable : α → Prop)
    {x y : α}
    (hxy : Step x y) (hy : Viable y) :
    ViableReach Step Viable x 1 y := by
  simpa using
    (ViableReach.step
      (ViableReach.refl (Step := Step) (Viable := Viable) (start := x))
      hxy hy)

/-- Two retained viable transitions make the endpoint reachable within two
steps. -/
theorem viableReach_two_steps
    (Step : α → α → Prop) (Viable : α → Prop)
    {x y z : α}
    (hxy : Step x y) (hy : Viable y)
    (hyz : Step y z) (hz : Viable z) :
    ViableReach Step Viable x 2 z := by
  have h1 : ViableReach Step Viable x 1 y :=
    viableReach_one_step Step Viable hxy hy
  simpa using (ViableReach.step h1 hyz hz)

/-- Retained intermediates can open an indirect target that is not available
as a direct baseline transition. This is the minimal machine-checked
stepping-stone form of the accessibility ratchet. -/
theorem retained_intermediate_opens_indirect_target
    (Step : α → α → Prop) (Viable : α → Prop)
    {x y z : α}
    (hxy : Step x y) (hy : Viable y)
    (hyz : Step y z) (hz : Viable z)
    (hnotDirect : ¬ Step x z) :
    ViableReach Step Viable x 2 z ∧ ¬ Step x z := by
  exact ⟨viableReach_two_steps Step Viable hxy hy hyz hz, hnotDirect⟩

end ViableSteppingStones

section SecondOrderAccessibility

/-- A state-dependent search operator. `Search x z` means that organization
`x` can generate or propose candidate `z` in one search step. -/
abbrev SearchOperator (α : Type*) := α → α → Prop

/-- A second-order accessibility click is a viable organizational transition
that strictly expands the declared candidate family available from the new
state while preserving all previously available declared candidates. -/
def SecondOrderClick
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    (x y : α) : Prop :=
  Step x y ∧ Viable y ∧
    StrictExpandsOn targets (Search x) (Search y)

/-- Every second-order click contains an explicit newly accessible candidate. -/
theorem secondOrderClick_has_new_candidate
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    {x y : α}
    (h : SecondOrderClick Step Viable targets Search x y) :
    ∃ z, z ∈ targets ∧ ¬ Search x z ∧ Search y z := by
  rcases h with ⟨hxy, hy, hstrict⟩
  exact hstrict.2

/-- The candidate-set interpretation of a second-order click is exact: the
new state's declared one-step search set is a strict superset of the old
state's declared one-step search set. -/
theorem secondOrderClick_strictly_expands_candidate_set
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    {x y : α}
    (h : SecondOrderClick Step Viable targets Search x y) :
    accessibleSet targets (Search x) ⊂
      accessibleSet targets (Search y) := by
  exact (strictExpandsOn_iff_ssubset targets (Search x) (Search y)).mp h.2.2

/-- A second-order click is both a viable state transition and a change in
future possibility: the new organization is reachable in one retained step
and exposes at least one candidate absent from the previous search operator. -/
theorem secondOrderClick_reaches_new_search_state
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    {x y : α}
    (h : SecondOrderClick Step Viable targets Search x y) :
    ViableReach Step Viable x 1 y ∧
      ∃ z, z ∈ targets ∧ ¬ Search x z ∧ Search y z := by
  constructor
  · exact viableReach_one_step Step Viable h.1 h.2.1
  · exact secondOrderClick_has_new_candidate Step Viable targets Search h

/-- If an ancestor can reach `x` through retained history and the ancestor's
candidate repertoire has been preserved into `x`, then a second-order click
`x → y` composes into strict search expansion relative to the ancestor. -/
theorem retained_history_secondOrderClick_expands_ancestor
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    {ancestor x y : α} {H : ℕ}
    (hReach : ViableReach Step Viable ancestor H x)
    (hPres : PreservesOn targets (Search ancestor) (Search x))
    (hClick : SecondOrderClick Step Viable targets Search x y) :
    ViableReach Step Viable ancestor (H + 1) y ∧
      StrictExpandsOn targets (Search ancestor) (Search y) := by
  constructor
  · exact ViableReach.step hReach hClick.1 hClick.2.1
  · exact preserves_trans_strictExpandsOn
      targets (Search ancestor) (Search x) (Search y)
      hPres hClick.2.2

/-- The composed historical result exposes an explicit candidate generated by
the descendant that the ancestor's search operator could not generate. Thus
retained history can create a new way of evolving, not merely reach a more
distant state under a fixed search operator. -/
theorem retained_history_creates_ancestor_new_candidate
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    {ancestor x y : α} {H : ℕ}
    (hReach : ViableReach Step Viable ancestor H x)
    (hPres : PreservesOn targets (Search ancestor) (Search x))
    (hClick : SecondOrderClick Step Viable targets Search x y) :
    ViableReach Step Viable ancestor (H + 1) y ∧
      ∃ z, z ∈ targets ∧ ¬ Search ancestor z ∧ Search y z := by
  have hComp := retained_history_secondOrderClick_expands_ancestor
    Step Viable targets Search hReach hPres hClick
  exact ⟨hComp.1, hComp.2.2⟩

/-- Set-theoretic corollary: under the same historical premises, the declared
candidate set of the descendant is a strict superset of the ancestor's. -/
theorem retained_history_strictly_expands_ancestor_candidate_set
    (Step : α → α → Prop) (Viable : α → Prop)
    (targets : Set α) (Search : SearchOperator α)
    {ancestor x y : α} {H : ℕ}
    (hReach : ViableReach Step Viable ancestor H x)
    (hPres : PreservesOn targets (Search ancestor) (Search x))
    (hClick : SecondOrderClick Step Viable targets Search x y) :
    accessibleSet targets (Search ancestor) ⊂
      accessibleSet targets (Search y) := by
  have hComp := retained_history_secondOrderClick_expands_ancestor
    Step Viable targets Search hReach hPres hClick
  exact (strictExpandsOn_iff_ssubset targets (Search ancestor) (Search y)).mp hComp.2

end SecondOrderAccessibility

section IndependenceWitnesses

/-- Three states suffice to separate deeper reachability from search-operator
expansion. -/
inductive Toy3
  | a | b | c
  deriving DecidableEq

open Toy3

/-- A two-step chain `a → b → c`, with no direct `a → c` transition. -/
def depthOnlyStep : Toy3 → Toy3 → Prop
  | a, b => True
  | b, c => True
  | _, _ => False

/-- Every toy state is viable. -/
def toyViable : Toy3 → Prop := fun _ => True

/-- A fixed empty search generator: organizational depth can increase while
the generator itself remains unchanged. -/
def fixedEmptySearch : SearchOperator Toy3 := fun _ _ => False

/-- Concrete independence witness: the retained history reaches `c` through
`b` although `c` is not a direct baseline transition, while the search
operator at the endpoint has not strictly expanded at all. -/
theorem depth_expansion_without_search_operator_expansion :
    ViableReach depthOnlyStep toyViable a 2 c ∧
      ¬ StrictExpandsOn Set.univ (fixedEmptySearch a) (fixedEmptySearch c) := by
  constructor
  · exact viableReach_two_steps depthOnlyStep toyViable
      (by simp [depthOnlyStep]) (by simp [toyViable])
      (by simp [depthOnlyStep]) (by simp [toyViable])
  · intro h
    rcases h.2 with ⟨z, hzT, hzOld, hzNew⟩
    simpa [fixedEmptySearch] using hzNew

/-- A single realized state transition `a → b`; there is deliberately no
realized `b → c` transition. -/
def operatorOnlyStep : Toy3 → Toy3 → Prop
  | a, b => True
  | _, _ => False

/-- State `b` can generate candidate `c`, while state `a` generates no declared
candidate. This changes the generator without asserting realization of `c`. -/
def expandingSearch : SearchOperator Toy3
  | b, c => True
  | _, _ => False

/-- Concrete converse-style separation witness: a second-order click can
strictly expand the candidate generator even though the newly generated
candidate is not itself a realized next transition in `Step`. -/
theorem search_operator_expansion_without_realized_candidate_step :
    SecondOrderClick operatorOnlyStep toyViable Set.univ expandingSearch a b ∧
      ¬ operatorOnlyStep b c := by
  constructor
  · refine ⟨by simp [operatorOnlyStep], by simp [toyViable], ?_⟩
    refine ⟨?_, c, by simp, ?_, ?_⟩
    · intro z hz hOld
      exfalso
      simpa [expandingSearch] using hOld
    · simp [expandingSearch]
    · simp [expandingSearch]
  · simp [operatorOnlyStep]

end IndependenceWitnesses

#print axioms pow_mono_nonneg
#print axioms finiteSearchOpportunity_mono
#print axioms finiteSearchOpportunity_at_one
#print axioms finiteSearchOpportunity_zero_variation
#print axioms reachableWithin_mono_one
#print axioms viableReach_one_step
#print axioms viableReach_two_steps
#print axioms retained_intermediate_opens_indirect_target
#print axioms secondOrderClick_has_new_candidate
#print axioms secondOrderClick_strictly_expands_candidate_set
#print axioms secondOrderClick_reaches_new_search_state
#print axioms retained_history_secondOrderClick_expands_ancestor
#print axioms retained_history_creates_ancestor_new_candidate
#print axioms retained_history_strictly_expands_ancestor_candidate_set
#print axioms depth_expansion_without_search_operator_expansion
#print axioms search_operator_expansion_without_realized_candidate_step

end RecursiveAccessibility
end CumulativeAccessibility
