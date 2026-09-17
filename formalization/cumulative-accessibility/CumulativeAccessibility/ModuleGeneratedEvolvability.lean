import CumulativeAccessibility.GenerativeArity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Module-generated evolvability

This file connects retained internal repertoire to second-order accessibility.
Instead of taking a state's search operator as primitive, the operator is
derived from the modules retained in that state together with a finite-parent
generative rule.

The central implication is:

retention of old modules + a newly realizable parent set
  -> preservation of old generated candidates + a new candidate
  -> strict expansion of the search operator.
-/

section General

variable [DecidableEq α]

/-- The one-step search operator induced by the modules retained in each state
and a finite-parent generative rule. -/
def SearchFromModules
    (Modules : α → α → Prop)
    (Generate : HyperGenerator α) : SearchOperator α :=
  fun state z => GeneratedFromAvailable (Modules state) Generate z

/-- If state `y` retains every module present in state `x`, then every declared
candidate generated from `x` remains generable from `y`. -/
theorem module_retention_implies_evolvabilityLe
    (targets : Set α)
    (Modules : α → α → Prop)
    (Generate : HyperGenerator α)
    {x y : α}
    (hModules : ∀ m, Modules x m → Modules y m) :
    EvolvabilityLe targets (SearchFromModules Modules Generate) x y := by
  exact generatedFromAvailable_mono
    targets (Modules x) (Modules y) Generate hModules

/-- Under module retention, any newly realizable parent set that generates a
declared candidate absent from the ancestor creates strict evolvability
expansion. -/
theorem new_parent_set_implies_evolvabilityLt
    (targets : Set α)
    (Modules : α → α → Prop)
    (Generate : HyperGenerator α)
    {x y z : α}
    (parents : Finset α)
    (hModules : ∀ m, Modules x m → Modules y m)
    (hParentsY : ∀ m, m ∈ parents → Modules y m)
    (hGenerate : Generate parents z)
    (hzT : z ∈ targets)
    (hnotOld : ¬ SearchFromModules Modules Generate x z) :
    EvolvabilityLt targets (SearchFromModules Modules Generate) x y := by
  refine ⟨module_retention_implies_evolvabilityLe
      targets Modules Generate hModules,
    z, hzT, hnotOld, ?_⟩
  exact ⟨parents, hParentsY, hGenerate⟩

/-- Adding a realized viable state transition turns the structural generator
expansion above into a genuine second-order accessibility click. -/
theorem new_parent_set_implies_secondOrderClick
    (Step : α → α → Prop)
    (Viable : α → Prop)
    (targets : Set α)
    (Modules : α → α → Prop)
    (Generate : HyperGenerator α)
    {x y z : α}
    (parents : Finset α)
    (hStep : Step x y)
    (hViable : Viable y)
    (hModules : ∀ m, Modules x m → Modules y m)
    (hParentsY : ∀ m, m ∈ parents → Modules y m)
    (hGenerate : Generate parents z)
    (hzT : z ∈ targets)
    (hnotOld : ¬ SearchFromModules Modules Generate x z) :
    SecondOrderClick Step Viable targets
      (SearchFromModules Modules Generate) x y := by
  exact ⟨hStep, hViable,
    new_parent_set_implies_evolvabilityLt
      targets Modules Generate parents hModules hParentsY
      hGenerate hzT hnotOld⟩

end General

section ConcreteWitness

/-- State `a` retains only module `a`; states `b` and `c` retain both `a` and
`b`. This is a deliberately minimal retained-diversity witness. -/
def toyModules : Toy3 → Toy3 → Prop
  | Toy3.a, m => availableA m
  | Toy3.b, m => availableAB m
  | Toy3.c, m => availableAB m

/-- The retained addition of module `b` derives a strict expansion of the
state's search operator through the binary `(a,b) -> c` generative rule. -/
theorem retained_module_diversity_expands_generator :
    EvolvabilityLt Set.univ
      (SearchFromModules toyModules (BinaryLift jointRecombine))
      Toy3.a Toy3.b := by
  apply new_parent_set_implies_evolvabilityLt
    Set.univ toyModules (BinaryLift jointRecombine)
    (parents := {Toy3.a, Toy3.b}) (z := Toy3.c)
  · intro m hm
    exact Or.inl hm
  · intro m hm
    simp only [Finset.mem_insert, Finset.mem_singleton] at hm
    rcases hm with rfl | rfl
    · exact Or.inl rfl
    · exact Or.inr rfl
  · exact ⟨Toy3.a, Toy3.b, by simp, rfl, by simp [jointRecombine]⟩
  · simp
  · intro hOld
    have hOld' : GeneratedFromAvailable availableA
        (BinaryLift jointRecombine) Toy3.c := by
      simpa [SearchFromModules, toyModules] using hOld
    have hRec :=
      (generatedFromAvailable_binaryLift_iff
        availableA jointRecombine Toy3.c).1 hOld'
    rcases hRec with ⟨x, y, hx, hy, hxy, hR⟩
    exact hxy (hx.trans hy.symm)

/-- With an actual viable transition `a -> b`, the same retained-diversity
mechanism is a derived second-order click rather than an assumed one. -/
theorem retained_module_diversity_derives_secondOrderClick :
    SecondOrderClick operatorOnlyStep toyViable Set.univ
      (SearchFromModules toyModules (BinaryLift jointRecombine))
      Toy3.a Toy3.b := by
  exact ⟨by simp [operatorOnlyStep], by simp [toyViable],
    retained_module_diversity_expands_generator⟩

/-- The resulting descendant generator exposes `c`, while the ancestor's
derived generator does not. -/
theorem retained_module_diversity_creates_new_candidate :
    ¬ SearchFromModules toyModules (BinaryLift jointRecombine) Toy3.a Toy3.c
      ∧
    SearchFromModules toyModules (BinaryLift jointRecombine) Toy3.b Toy3.c := by
  have hClick := retained_module_diversity_derives_secondOrderClick
  have hNew := secondOrderClick_has_new_candidate
    operatorOnlyStep toyViable Set.univ
    (SearchFromModules toyModules (BinaryLift jointRecombine)) hClick
  rcases hNew with ⟨z, hzT, hOld, hNew⟩
  have hz : z = Toy3.c := by
    by_contra hne
    cases z with
    | a =>
        have hGen := hNew
        rcases hGen with ⟨parents, hParents, hRule⟩
        rcases hRule with ⟨x, y, hxy, hEq, hR⟩
        simp [jointRecombine] at hR
    | b =>
        have hGen := hNew
        rcases hGen with ⟨parents, hParents, hRule⟩
        rcases hRule with ⟨x, y, hxy, hEq, hR⟩
        simp [jointRecombine] at hR
    | c => exact hne rfl
  subst hz
  exact ⟨hOld, hNew⟩

end ConcreteWitness

#print axioms module_retention_implies_evolvabilityLe
#print axioms new_parent_set_implies_evolvabilityLt
#print axioms new_parent_set_implies_secondOrderClick
#print axioms retained_module_diversity_expands_generator
#print axioms retained_module_diversity_derives_secondOrderClick
#print axioms retained_module_diversity_creates_new_candidate

end RecursiveAccessibility
end CumulativeAccessibility
