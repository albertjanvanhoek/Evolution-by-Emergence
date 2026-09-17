import CumulativeAccessibility.RecursiveAccessibility

namespace CumulativeAccessibility
namespace RecursiveAccessibility

variable {α : Type*}

/-!
# Evolvability order, functional projection, and recombination

This file adds three distinctions to the recursive-accessibility layer.

1. Inclusion of state-dependent candidate repertoires defines a preorder on
   organizational states. It is not antisymmetric on raw states: distinct
   organizations can expose the same declared generator. Candidate sets
   themselves are partially ordered by inclusion.
2. Strict expansion of a raw candidate set need not expand a declared
   functional repertoire after projection through a feature map.
3. Retained coexistence can open genuinely joint candidates through a
   two-parent recombination operator even when neither parent has a unary
   transition to the candidate.

These are structural statements only. They do not assign value to larger
candidate sets, feature repertoires, or recombination rates.
-/

section EvolvabilityPreorder

/-- Weak evolvability order on states: every declared candidate exposed by
`x` is still exposed by `y`. -/
def EvolvabilityLe
    (targets : Set α) (Search : SearchOperator α) (x y : α) : Prop :=
  PreservesOn targets (Search x) (Search y)

/-- Strict evolvability expansion on states: all old declared candidates are
preserved and at least one declared candidate is newly exposed. -/
def EvolvabilityLt
    (targets : Set α) (Search : SearchOperator α) (x y : α) : Prop :=
  StrictExpandsOn targets (Search x) (Search y)

theorem evolvabilityLe_refl
    (targets : Set α) (Search : SearchOperator α) (x : α) :
    EvolvabilityLe targets Search x x := by
  exact preservesOn_refl targets (Search x)

theorem evolvabilityLe_trans
    (targets : Set α) (Search : SearchOperator α)
    {x y z : α}
    (hxy : EvolvabilityLe targets Search x y)
    (hyz : EvolvabilityLe targets Search y z) :
    EvolvabilityLe targets Search x z := by
  exact preservesOn_trans targets (Search x) (Search y) (Search z) hxy hyz

theorem evolvabilityLt_implies_le
    (targets : Set α) (Search : SearchOperator α)
    {x y : α}
    (hxy : EvolvabilityLt targets Search x y) :
    EvolvabilityLe targets Search x y := by
  exact hxy.1

theorem evolvabilityLt_trans
    (targets : Set α) (Search : SearchOperator α)
    {x y z : α}
    (hxy : EvolvabilityLt targets Search x y)
    (hyz : EvolvabilityLt targets Search y z) :
    EvolvabilityLt targets Search x z := by
  exact strictExpandsOn_trans targets (Search x) (Search y) (Search z) hxy hyz

/-- Mutual weak evolvability is exactly equality of the declared candidate
sets. This is the equivalence relation one would quotient by to obtain an
antisymmetric order from the state-level preorder. -/
theorem mutual_evolvabilityLe_iff_candidate_sets_equal
    (targets : Set α) (Search : SearchOperator α)
    (x y : α) :
    (EvolvabilityLe targets Search x y ∧
      EvolvabilityLe targets Search y x)
      ↔
    accessibleSet targets (Search x) =
      accessibleSet targets (Search y) := by
  constructor
  · rintro ⟨hxy, hyx⟩
    exact Set.Subset.antisymm
      ((preservesOn_iff_subset targets (Search x) (Search y)).mp hxy)
      ((preservesOn_iff_subset targets (Search y) (Search x)).mp hyx)
  · intro heq
    constructor
    · apply (preservesOn_iff_subset targets (Search x) (Search y)).mpr
      intro z hz
      rw [← heq]
      exact hz
    · apply (preservesOn_iff_subset targets (Search y) (Search x)).mpr
      intro z hz
      rw [heq]
      exact hz

/-- Raw organizational states are not antisymmetric under generator inclusion:
`a` and `b` are distinct states but the fixed empty generator makes each weakly
at least as evolvable as the other. -/
theorem evolvability_state_preorder_not_antisymmetric :
    Toy3.a ≠ Toy3.b ∧
      EvolvabilityLe Set.univ fixedEmptySearch Toy3.a Toy3.b ∧
      EvolvabilityLe Set.univ fixedEmptySearch Toy3.b Toy3.a := by
  constructor
  · simp
  · constructor <;> simp [EvolvabilityLe, fixedEmptySearch, PreservesOn]

end EvolvabilityPreorder

section FunctionalProjection

variable {β : Type*}

/-- A declared functional feature is reachable from state `x` when at least
one declared candidate exposed by `x` maps to that feature. -/
def FeatureReachable
    (candidateTargets : Set α)
    (Search : SearchOperator α)
    (Feature : α → β)
    (x : α) : β → Prop :=
  fun f => ∃ z, z ∈ candidateTargets ∧ Search x z ∧ Feature z = f

/-- Preserving a candidate repertoire preserves every feature already
represented by that repertoire. -/
theorem featureReachable_preserved
    (candidateTargets : Set α)
    (Search : SearchOperator α)
    (Feature : α → β)
    {x y : α}
    (hPres : PreservesOn candidateTargets (Search x) (Search y)) :
    PreservesOn Set.univ
      (FeatureReachable candidateTargets Search Feature x)
      (FeatureReachable candidateTargets Search Feature y) := by
  intro f hf
  rintro ⟨z, hzT, hxz, hfeat⟩
  exact ⟨z, hzT, hPres z hzT hxz, hfeat⟩

/-- A toy generator in which state `a` exposes `{b}` and state `b` exposes
`{b,c}`. -/
def duplicateCandidateSearch : SearchOperator Toy3
  | Toy3.a, Toy3.b => True
  | Toy3.b, Toy3.b => True
  | Toy3.b, Toy3.c => True
  | _, _ => False

/-- All candidates project to the same coarse feature. -/
def constantFeature : Toy3 → Unit := fun _ => ()

/-- Raw candidate-set expansion need not create a new functional dimension:
`a -> b` adds candidate `c`, but under a constant feature projection both
states expose exactly the same feature repertoire. -/
theorem raw_candidate_expansion_without_feature_expansion :
    StrictExpandsOn Set.univ
      (duplicateCandidateSearch Toy3.a)
      (duplicateCandidateSearch Toy3.b)
    ∧
    ¬ StrictExpandsOn Set.univ
      (FeatureReachable Set.univ duplicateCandidateSearch constantFeature Toy3.a)
      (FeatureReachable Set.univ duplicateCandidateSearch constantFeature Toy3.b) := by
  have hCand : StrictExpandsOn Set.univ
      (duplicateCandidateSearch Toy3.a)
      (duplicateCandidateSearch Toy3.b) := by
    refine ⟨?_, Toy3.c, by simp, ?_, ?_⟩
    · intro z hz hOld
      cases z <;> simp [duplicateCandidateSearch] at hOld ⊢
    · simp [duplicateCandidateSearch]
    · simp [duplicateCandidateSearch]
  refine ⟨hCand, ?_⟩
  intro hFeat
  rcases hFeat.2 with ⟨f, hfT, hnotOld, hnew⟩
  cases f
  apply hnotOld
  exact ⟨Toy3.b, by simp, by simp [duplicateCandidateSearch], rfl⟩

/-- A feature map that distinguishes the newly added candidate `c`. -/
def distinguishingFeature : Toy3 → Bool
  | Toy3.c => true
  | _ => false

/-- The same raw candidate expansion can be a genuine functional expansion
under a feature map that distinguishes the new candidate. This makes the
notion of an "independent/useful dimension" explicitly representation- or
task-dependent rather than a consequence of candidate count alone. -/
theorem candidate_expansion_can_expand_feature_repertoire :
    StrictExpandsOn Set.univ
      (FeatureReachable Set.univ duplicateCandidateSearch distinguishingFeature Toy3.a)
      (FeatureReachable Set.univ duplicateCandidateSearch distinguishingFeature Toy3.b) := by
  have hCand : PreservesOn Set.univ
      (duplicateCandidateSearch Toy3.a)
      (duplicateCandidateSearch Toy3.b) := by
    intro z hz hOld
    cases z <;> simp [duplicateCandidateSearch] at hOld ⊢
  refine ⟨featureReachable_preserved Set.univ duplicateCandidateSearch
      distinguishingFeature hCand, true, by simp, ?_, ?_⟩
  · intro hOld
    rcases hOld with ⟨z, hzT, hSearch, hFeat⟩
    cases z <;> simp [duplicateCandidateSearch, distinguishingFeature] at hSearch hFeat
  · exact ⟨Toy3.c, by simp, by simp [duplicateCandidateSearch],
      by simp [distinguishingFeature]⟩

end FunctionalProjection

section Recombination

/-- A two-parent generative operator. `Recombine x y z` means that the
co-presence of `x` and `y` can generate candidate `z`. -/
abbrev RecombinationOperator (α : Type*) := α → α → α → Prop

/-- Candidate `z` is recombinationally accessible when two distinct available
parents jointly generate it. -/
def RecombAccessible
    (Available : α → Prop)
    (Recombine : RecombinationOperator α) : α → Prop :=
  fun z => ∃ x y,
    Available x ∧ Available y ∧ x ≠ y ∧ Recombine x y z

/-- Expanding the set of available modules cannot destroy an already available
recombination route. -/
theorem recombAccessible_mono
    (targets : Set α)
    (oldAvailable newAvailable : α → Prop)
    (Recombine : RecombinationOperator α)
    (hAvail : ∀ x, oldAvailable x → newAvailable x) :
    PreservesOn targets
      (RecombAccessible oldAvailable Recombine)
      (RecombAccessible newAvailable Recombine) := by
  intro z hz
  rintro ⟨x, y, hx, hy, hxy, hR⟩
  exact ⟨x, y, hAvail x hx, hAvail y hy, hxy, hR⟩

/-- General retained-coexistence click: if availability is preserved, a newly
co-available distinct module can combine with an old module to expose a
candidate that was not recombinationally accessible before. -/
theorem new_module_opens_recombination_candidate
    (targets : Set α)
    (oldAvailable newAvailable : α → Prop)
    (Recombine : RecombinationOperator α)
    (hAvail : ∀ x, oldAvailable x → newAvailable x)
    {p q z : α}
    (hpOld : oldAvailable p)
    (hqNew : newAvailable q)
    (hpq : p ≠ q)
    (hR : Recombine p q z)
    (hzT : z ∈ targets)
    (hnotOld : ¬ RecombAccessible oldAvailable Recombine z) :
    StrictExpandsOn targets
      (RecombAccessible oldAvailable Recombine)
      (RecombAccessible newAvailable Recombine) := by
  refine ⟨recombAccessible_mono targets oldAvailable newAvailable Recombine hAvail,
    z, hzT, hnotOld, ?_⟩
  exact ⟨p, q, hAvail p hpOld, hqNew, hpq, hR⟩

/-- Initially only module `a` is retained. -/
def availableA : Toy3 → Prop := fun x => x = Toy3.a

/-- After retention of a second module, both `a` and `b` coexist. -/
def availableAB : Toy3 → Prop := fun x => x = Toy3.a ∨ x = Toy3.b

/-- A genuinely joint generative event: `a` together with `b` can produce `c`. -/
def jointRecombine : RecombinationOperator Toy3
  | Toy3.a, Toy3.b, Toy3.c => True
  | _, _, _ => False

/-- The retained addition of `b` opens `c` as a new recombinational candidate.
The effect is relational: `c` was unavailable when only `a` existed. -/
theorem retained_coexistence_opens_joint_candidate :
    StrictExpandsOn Set.univ
      (RecombAccessible availableA jointRecombine)
      (RecombAccessible availableAB jointRecombine) := by
  apply new_module_opens_recombination_candidate
    Set.univ availableA availableAB jointRecombine
    (fun x hx => Or.inl hx)
    (p := Toy3.a) (q := Toy3.b) (z := Toy3.c)
  · rfl
  · exact Or.inr rfl
  · simp
  · simp [jointRecombine]
  · simp
  · intro hOld
    rcases hOld with ⟨x, y, hx, hy, hxy, hR⟩
    have hxeq : x = Toy3.a := hx
    have hyeq : y = Toy3.a := hy
    exact hxy (hxeq.trans hyeq.symm)

/-- No single-parent transition is present in this witness. -/
def noUnaryGeneration : Toy3 → Toy3 → Prop := fun _ _ => False

/-- Hyperedge-style witness: `c` is generated by the pair `(a,b)` even though
neither `a` nor `b` has a unary generative edge to `c`. Thus a single-parent
lineage graph is insufficient to represent the dependency structure without
adding extra encoding. -/
theorem joint_candidate_requires_two_parent_relation :
    RecombAccessible availableAB jointRecombine Toy3.c ∧
      ¬ noUnaryGeneration Toy3.a Toy3.c ∧
      ¬ noUnaryGeneration Toy3.b Toy3.c := by
  constructor
  · exact ⟨Toy3.a, Toy3.b, Or.inl rfl, Or.inr rfl,
      by simp, by simp [jointRecombine]⟩
  · simp [noUnaryGeneration]

end Recombination

#print axioms evolvabilityLe_refl
#print axioms evolvabilityLe_trans
#print axioms evolvabilityLt_implies_le
#print axioms evolvabilityLt_trans
#print axioms mutual_evolvabilityLe_iff_candidate_sets_equal
#print axioms evolvability_state_preorder_not_antisymmetric
#print axioms featureReachable_preserved
#print axioms raw_candidate_expansion_without_feature_expansion
#print axioms candidate_expansion_can_expand_feature_repertoire
#print axioms recombAccessible_mono
#print axioms new_module_opens_recombination_candidate
#print axioms retained_coexistence_opens_joint_candidate
#print axioms joint_candidate_requires_two_parent_relation

end RecursiveAccessibility
end CumulativeAccessibility
