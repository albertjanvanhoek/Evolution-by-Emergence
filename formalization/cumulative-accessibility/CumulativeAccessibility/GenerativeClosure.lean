import CumulativeAccessibility.GenerativeArity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Generative closure

This file formalizes retained recursive production. A generative round keeps
all organization already present and adds anything generated from currently
available parent sets. Newly generated organization is therefore available as
parent material in later rounds.

This is deliberately a reachability/retention model. It does not assign
probabilities, costs, or selective value to candidate generation.
-/

section Closure

variable [DecidableEq α]

/-- One retained generative round: keep everything already available and add
all candidates generated from the current repertoire. -/
def GenerativeClosureStep
    (Available : α → Prop)
    (Generate : HyperGenerator α) : α → Prop :=
  fun z => Available z ∨ GeneratedFromAvailable Available Generate z

/-- A retained generative round never removes an already available declared
item. -/
theorem generativeClosureStep_preserves
    (targets : Set α)
    (Available : α → Prop)
    (Generate : HyperGenerator α) :
    PreservesOn targets Available (GenerativeClosureStep Available Generate) := by
  intro z hz hAvail
  exact Or.inl hAvail

/-- If one repertoire contains another, applying the same retained generative
round preserves that inclusion. -/
theorem generativeClosureStep_mono
    (oldAvailable newAvailable : α → Prop)
    (Generate : HyperGenerator α)
    (hAvail : ∀ x, oldAvailable x → newAvailable x) :
    ∀ z,
      GenerativeClosureStep oldAvailable Generate z →
      GenerativeClosureStep newAvailable Generate z := by
  intro z hz
  rcases hz with hOld | hGen
  · exact Or.inl (hAvail z hOld)
  · exact Or.inr ((generatedFromAvailable_mono Set.univ
      oldAvailable newAvailable Generate hAvail) z (by simp) hGen)

/-- Iterated retained generative closure. -/
def GenerativeClosureN
    (Generate : HyperGenerator α)
    (initial : α → Prop) : ℕ → α → Prop
  | 0 => initial
  | n + 1 => GenerativeClosureStep (GenerativeClosureN Generate initial n) Generate

/-- Increasing the number of retained generative rounds by one never removes
an item already reached. -/
theorem generativeClosureN_mono_one
    (Generate : HyperGenerator α)
    (initial : α → Prop)
    (n : ℕ) :
    PreservesOn Set.univ
      (GenerativeClosureN Generate initial n)
      (GenerativeClosureN Generate initial (n + 1)) := by
  intro z hz hOld
  change GenerativeClosureStep
    (GenerativeClosureN Generate initial n) Generate z
  exact Or.inl hOld

/-- If the current repertoire generates a declared candidate not already
present, one retained generative round is a strict accessibility expansion. -/
theorem novel_generated_candidate_strictly_expands
    (targets : Set α)
    (Available : α → Prop)
    (Generate : HyperGenerator α)
    {z : α}
    (hzT : z ∈ targets)
    (hNew : GeneratedFromAvailable Available Generate z)
    (hOld : ¬ Available z) :
    StrictExpandsOn targets Available
      (GenerativeClosureStep Available Generate) := by
  exact ⟨generativeClosureStep_preserves targets Available Generate,
    z, hzT, hOld, Or.inr hNew⟩

end Closure

section TwoRoundWitness

/-- Initial repertoire containing only `a`. -/
def initialA : Toy3 → Prop := fun x => x = Toy3.a

/-- A unary hypergenerator with two sequential rules:
`{a} -> b` and `{b} -> c`. There is no direct `{a} -> c` rule. -/
def chainHyper : HyperGenerator Toy3
  | parents, Toy3.b => parents = {Toy3.a}
  | parents, Toy3.c => parents = {Toy3.b}
  | _, Toy3.a => False

/-- The first retained round generates `b`. -/
theorem chain_round_one_reaches_b :
    GenerativeClosureN chainHyper initialA 1 Toy3.b := by
  change GenerativeClosureStep initialA chainHyper Toy3.b
  exact Or.inr ⟨{Toy3.a},
    (by
      intro x hx
      have hxa : x = Toy3.a := by simpa using hx
      exact hxa),
    rfl⟩

/-- `c` is not available after only one round: its only generating parent is
`b`, which was not in the initial repertoire. -/
theorem chain_round_one_c_unavailable :
    ¬ GenerativeClosureN chainHyper initialA 1 Toy3.c := by
  intro hc
  change GenerativeClosureStep initialA chainHyper Toy3.c at hc
  rcases hc with hInitial | hGenerated
  · simp [initialA] at hInitial
  · rcases hGenerated with ⟨parents, hParents, hRule⟩
    have hEq : parents = {Toy3.b} := hRule
    subst parents
    have hb := hParents Toy3.b (by simp)
    simp [initialA] at hb

/-- After the first round has retained `b`, the second round can use `b` as
parent material and generate `c`. -/
theorem chain_round_two_reaches_c :
    GenerativeClosureN chainHyper initialA 2 Toy3.c := by
  change GenerativeClosureStep
    (GenerativeClosureN chainHyper initialA 1) chainHyper Toy3.c
  exact Or.inr ⟨{Toy3.b},
    (by
      intro x hx
      have hxb : x = Toy3.b := by simpa using hx
      subst x
      exact chain_round_one_reaches_b),
    rfl⟩

/-- Minimal recursive-production witness: `c` is inaccessible after one
retained generative round but accessible after two. The difference is exactly
that the generated intermediate `b` becomes reusable substrate. -/
theorem retained_intermediate_creates_second_round_access :
    ¬ GenerativeClosureN chainHyper initialA 1 Toy3.c
      ∧
    GenerativeClosureN chainHyper initialA 2 Toy3.c := by
  exact ⟨chain_round_one_c_unavailable, chain_round_two_reaches_c⟩

end TwoRoundWitness

#print axioms generativeClosureStep_preserves
#print axioms generativeClosureStep_mono
#print axioms generativeClosureN_mono_one
#print axioms novel_generated_candidate_strictly_expands
#print axioms chain_round_one_reaches_b
#print axioms chain_round_one_c_unavailable
#print axioms chain_round_two_reaches_c
#print axioms retained_intermediate_creates_second_round_access

end RecursiveAccessibility
end CumulativeAccessibility
