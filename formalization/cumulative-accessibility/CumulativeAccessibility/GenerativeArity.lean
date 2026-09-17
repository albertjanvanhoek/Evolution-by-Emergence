import CumulativeAccessibility.EvolvabilityStructure

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Generative arity

A single-parent lineage edge is only one possible dependency structure for
organizational change. This file represents a generative event by a finite set
of parent modules together with a generated candidate. Unary descent is the
cardinality-one special case; recombination is naturally cardinality two.

The formalization is intentionally about dependency representation, not about
biological mechanism or the relative empirical prevalence of different
inheritance modes.
-/

section HyperGenerator

variable [DecidableEq α]

/-- A finite-parent generative operator. `Generate parents z` means that the
joint presence of every member of `parents` can generate candidate `z`. -/
abbrev HyperGenerator (α : Type*) := Finset α → α → Prop

/-- A candidate is available from an organizational repertoire when some
finite parent set is entirely present and that parent set generates it. -/
def GeneratedFromAvailable
    (Available : α → Prop)
    (Generate : HyperGenerator α) : α → Prop :=
  fun z => ∃ parents : Finset α,
    (∀ x, x ∈ parents → Available x) ∧ Generate parents z

/-- Enlarging the retained repertoire cannot destroy a generative event whose
parent set was already present. -/
theorem generatedFromAvailable_mono
    (targets : Set α)
    (oldAvailable newAvailable : α → Prop)
    (Generate : HyperGenerator α)
    (hAvail : ∀ x, oldAvailable x → newAvailable x) :
    PreservesOn targets
      (GeneratedFromAvailable oldAvailable Generate)
      (GeneratedFromAvailable newAvailable Generate) := by
  intro z hz
  rintro ⟨parents, hParents, hGen⟩
  refine ⟨parents, ?_, hGen⟩
  intro x hx
  exact hAvail x (hParents x hx)

/-- Lift an ordinary one-parent transition rule into the finite-parent
representation. -/
def UnaryLift
    (Unary : α → α → Prop) : HyperGenerator α :=
  fun parents z => ∃ x, parents = {x} ∧ Unary x z

/-- Unary generation under the hypergraph representation is exactly ordinary
single-parent generation from some retained parent. -/
theorem generatedFromAvailable_unaryLift_iff
    (Available : α → Prop)
    (Unary : α → α → Prop)
    (z : α) :
    GeneratedFromAvailable Available (UnaryLift Unary) z
      ↔
    ∃ x, Available x ∧ Unary x z := by
  constructor
  · rintro ⟨parents, hParents, x, hEq, hUnary⟩
    subst hEq
    exact ⟨x, hParents x (by simp), hUnary⟩
  · rintro ⟨x, hx, hUnary⟩
    refine ⟨{x}, ?_, ⟨x, rfl, hUnary⟩⟩
    intro y hy
    have hyx : y = x := by simpa using hy
    simpa [hyx] using hx

/-- Lift a two-parent recombination rule into the finite-parent
representation. Distinctness prevents the pair from collapsing to a
singleton parent set. -/
def BinaryLift
    (Recombine : RecombinationOperator α) : HyperGenerator α :=
  fun parents z => ∃ x y,
    x ≠ y ∧ parents = {x, y} ∧ Recombine x y z

/-- The binary hypergraph representation is extensionally equivalent to the
explicit two-parent accessibility predicate introduced previously. -/
theorem generatedFromAvailable_binaryLift_iff
    (Available : α → Prop)
    (Recombine : RecombinationOperator α)
    (z : α) :
    GeneratedFromAvailable Available (BinaryLift Recombine) z
      ↔
    RecombAccessible Available Recombine z := by
  constructor
  · rintro ⟨parents, hParents, x, y, hxy, hEq, hR⟩
    subst hEq
    exact ⟨x, y,
      hParents x (by simp),
      hParents y (by simp),
      hxy, hR⟩
  · rintro ⟨x, y, hx, hy, hxy, hR⟩
    refine ⟨{x, y}, ?_, ⟨x, y, hxy, rfl, hR⟩⟩
    intro w hw
    simp only [Finset.mem_insert, Finset.mem_singleton] at hw
    rcases hw with hwx | hwy
    · simpa [hwx] using hx
    · simpa [hwy] using hy

/-- A generator is unary-only when every realized parent set has cardinality
one. This is a dependency-structure definition, not a statement about how the
rule was encoded syntactically. -/
def UnaryOnly
    (Generate : HyperGenerator α) : Prop :=
  ∀ parents z, Generate parents z → parents.card = 1

/-- Every lifted ordinary one-parent rule is unary-only. -/
theorem unaryLift_is_unaryOnly
    (Unary : α → α → Prop) :
    UnaryOnly (UnaryLift Unary) := by
  intro parents z h
  rcases h with ⟨x, rfl, hUnary⟩
  simp

end HyperGenerator

section JointWitness

/-- The concrete `(a,b) -> c` recombination witness is not unary-only: its
minimal represented parent set contains two distinct retained modules. -/
theorem joint_binary_generator_not_unaryOnly :
    ¬ UnaryOnly (BinaryLift jointRecombine) := by
  intro hUnary
  have hCard := hUnary {Toy3.a, Toy3.b} Toy3.c
    ⟨Toy3.a, Toy3.b, by simp, rfl, by simp [jointRecombine]⟩
  simp at hCard

/-- With both parents retained, the hypergraph generator produces `c`. The
same fact can be read through the earlier binary accessibility predicate by
the equivalence theorem above. -/
theorem retained_pair_generates_joint_candidate_hypergraph :
    GeneratedFromAvailable availableAB
      (BinaryLift jointRecombine) Toy3.c := by
  apply (generatedFromAvailable_binaryLift_iff
    availableAB jointRecombine Toy3.c).2
  exact ⟨Toy3.a, Toy3.b, Or.inl rfl, Or.inr rfl,
    by simp, by simp [jointRecombine]⟩

/-- Consequently, this dependency cannot be represented as a unary-only
hyperedge over the same parent nodes without changing the representation
(e.g. by adding an auxiliary compound state). -/
theorem joint_witness_has_generative_arity_two :
    GeneratedFromAvailable availableAB
      (BinaryLift jointRecombine) Toy3.c
      ∧
    ¬ UnaryOnly (BinaryLift jointRecombine) := by
  exact ⟨retained_pair_generates_joint_candidate_hypergraph,
    joint_binary_generator_not_unaryOnly⟩

end JointWitness

#print axioms generatedFromAvailable_mono
#print axioms generatedFromAvailable_unaryLift_iff
#print axioms generatedFromAvailable_binaryLift_iff
#print axioms unaryLift_is_unaryOnly
#print axioms joint_binary_generator_not_unaryOnly
#print axioms retained_pair_generates_joint_candidate_hypergraph
#print axioms joint_witness_has_generative_arity_two

end RecursiveAccessibility
end CumulativeAccessibility
