import CumulativeAccessibility.GenerativeArity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Generator-rule evolution

The earlier module-generated result expands the effective search operator by
changing the retained repertoire while holding the finite-parent generative
rule fixed. This file isolates the complementary mechanism: the repertoire is
held fixed while the generative rule itself changes.

Thus two distinct second-order mechanisms are kept separate:

1. repertoire-driven expansion: `M` changes while `H` is fixed;
2. rule-driven expansion: `H` changes while `M` is fixed.

Both can enlarge the effective one-step candidate set, but they are not the
same claim.
-/

section General

variable [DecidableEq α]

/-- Pointwise preservation of generative rules over all parent sets and
candidates. -/
def GeneratorRuleLe
    (oldRule newRule : HyperGenerator α) : Prop :=
  ∀ parents z, oldRule parents z → newRule parents z

/-- A pointwise rule extension preserves every candidate generable from a
fixed retained repertoire. -/
theorem generatorRuleLe_preserves_generated
    (targets : Set α)
    (Available : α → Prop)
    (oldRule newRule : HyperGenerator α)
    (hRule : GeneratorRuleLe oldRule newRule) :
    PreservesOn targets
      (GeneratedFromAvailable Available oldRule)
      (GeneratedFromAvailable Available newRule) := by
  intro z hz
  rintro ⟨parents, hParents, hOld⟩
  exact ⟨parents, hParents, hRule parents z hOld⟩

/-- Strict rule expansion at a fixed repertoire: all old generated declared
candidates remain available and at least one declared candidate is newly
generable. -/
def GeneratorRuleLt
    (targets : Set α)
    (Available : α → Prop)
    (oldRule newRule : HyperGenerator α) : Prop :=
  StrictExpandsOn targets
    (GeneratedFromAvailable Available oldRule)
    (GeneratedFromAvailable Available newRule)

/-- A pointwise rule extension plus one newly generated candidate gives strict
rule-driven evolvability expansion at fixed repertoire. -/
theorem new_rule_event_implies_GeneratorRuleLt
    (targets : Set α)
    (Available : α → Prop)
    (oldRule newRule : HyperGenerator α)
    (hRule : GeneratorRuleLe oldRule newRule)
    {z : α}
    (hzT : z ∈ targets)
    (hOld : ¬ GeneratedFromAvailable Available oldRule z)
    (hNew : GeneratedFromAvailable Available newRule z) :
    GeneratorRuleLt targets Available oldRule newRule := by
  exact ⟨generatorRuleLe_preserves_generated
      targets Available oldRule newRule hRule,
    z, hzT, hOld, hNew⟩

/-- State-dependent rules induce a search operator while the retained
repertoire is held fixed. -/
def SearchFromRules
    (Available : α → Prop)
    (RuleAt : α → HyperGenerator α) : SearchOperator α :=
  fun state z => GeneratedFromAvailable Available (RuleAt state) z

/-- Strict rule expansion between states is exactly strict evolvability
expansion of the induced effective search operator. -/
theorem generatorRuleLt_implies_evolvabilityLt
    (targets : Set α)
    (Available : α → Prop)
    (RuleAt : α → HyperGenerator α)
    {x y : α}
    (hRule : GeneratorRuleLt targets Available (RuleAt x) (RuleAt y)) :
    EvolvabilityLt targets (SearchFromRules Available RuleAt) x y := by
  exact hRule

/-- With a realized viable state transition, a strict change in the underlying
generative rule becomes a second-order accessibility click even though the
retained repertoire itself is unchanged. -/
theorem generatorRuleLt_implies_secondOrderClick
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Available : α → Prop)
    (RuleAt : α → HyperGenerator α)
    {x y : α}
    (hStep : Step x y)
    (hViable : Viable y)
    (hRule : GeneratorRuleLt targets Available (RuleAt x) (RuleAt y)) :
    SecondOrderClick Step Viable targets
      (SearchFromRules Available RuleAt) x y := by
  exact ⟨hStep, hViable,
    generatorRuleLt_implies_evolvabilityLt targets Available RuleAt hRule⟩

end General

section ConcreteWitness

/-- Baseline rule: retained `a` can generate `b`, but not `c`. -/
def toyRule0 : HyperGenerator Toy3
  | parents, Toy3.b => parents = {Toy3.a}
  | _, _ => False

/-- Expanded rule: preserves `a -> b` and adds a new `a -> c` generative
possibility without changing the retained repertoire. -/
def toyRule1 : HyperGenerator Toy3
  | parents, Toy3.b => parents = {Toy3.a}
  | parents, Toy3.c => parents = {Toy3.a}
  | _, Toy3.a => False

/-- The expanded rule pointwise preserves every event of the baseline rule. -/
theorem toyRule0_le_toyRule1 :
    GeneratorRuleLe toyRule0 toyRule1 := by
  intro parents z h
  cases z <;> simp [toyRule0, toyRule1] at h ⊢

/-- At the unchanged repertoire `{a}`, the new rule strictly expands the
candidate set by making `c` generable. -/
theorem fixed_repertoire_rule_expansion :
    GeneratorRuleLt Set.univ initialA toyRule0 toyRule1 := by
  apply new_rule_event_implies_GeneratorRuleLt
    Set.univ initialA toyRule0 toyRule1 toyRule0_le_toyRule1
    (z := Toy3.c)
  · simp
  · intro hOld
    rcases hOld with ⟨parents, hParents, hRule⟩
    simp [toyRule0] at hRule
  · exact ⟨{Toy3.a},
      (by
        intro x hx
        have hxa : x = Toy3.a := by simpa using hx
        exact hxa),
      by simp [toyRule1]⟩

/-- State `a` carries the baseline rule and state `b` the expanded rule. -/
def toyRuleAt : Toy3 → HyperGenerator Toy3
  | Toy3.a => toyRule0
  | Toy3.b => toyRule1
  | Toy3.c => toyRule1

/-- Concrete true rule-evolution witness: with the repertoire fixed at `{a}`,
a viable `a -> b` transition changes the generative rule and therefore creates
a second-order accessibility click. -/
theorem fixed_repertoire_rule_change_derives_secondOrderClick :
    SecondOrderClick operatorOnlyStep toyViable Set.univ
      (SearchFromRules initialA toyRuleAt) Toy3.a Toy3.b := by
  apply generatorRuleLt_implies_secondOrderClick
    operatorOnlyStep toyViable Set.univ initialA toyRuleAt
  · simp [operatorOnlyStep]
  · simp [toyViable]
  · exact fixed_repertoire_rule_expansion

end ConcreteWitness

#print axioms generatorRuleLe_preserves_generated
#print axioms new_rule_event_implies_GeneratorRuleLt
#print axioms generatorRuleLt_implies_evolvabilityLt
#print axioms generatorRuleLt_implies_secondOrderClick
#print axioms toyRule0_le_toyRule1
#print axioms fixed_repertoire_rule_expansion
#print axioms fixed_repertoire_rule_change_derives_secondOrderClick

end RecursiveAccessibility
end CumulativeAccessibility
