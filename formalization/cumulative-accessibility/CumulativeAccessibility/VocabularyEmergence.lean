import CumulativeAccessibility.EmergentCapacity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Vocabulary emergence

Compositional emergence and vocabulary expansion are distinct axes.

* Compositional emergence: a configuration realizes a capacity that no declared
  proper subconfiguration realizes, while the capacity already belongs to the
  current capacity type/vocabulary.
* Vocabulary expansion: a realized capacity belongs to a larger vocabulary and
  is not representable as the image of any capacity in the previous vocabulary.

The distinction is intentionally model-relative.  A vocabulary is a declared
capacity language, not a metaphysical claim about every property that could
exist.  The formalization asks whether a new realized capacity can be expressed
inside the old language under an explicit embedding.

A vocabulary-new capacity need not be compositionally emergent, and a
compositionally emergent capacity need not be vocabulary-new.  The two can also
co-occur.

The final section connects vocabulary expansion to future generativity: once a
vocabulary-new capacity is integrated as available material, any genuinely new
downstream realization that depends on the enlarged repertoire gives strict
accessibility expansion.
-/

section VocabularyCore

variable {OldCapacity NewCapacity Config Context : Type*}

/-- A capacity in the new vocabulary is vocabulary-new relative to an explicit
map from the old vocabulary when it is not representable as the image of any
old capacity. -/
def VocabularyNovel
    (embed : OldCapacity → NewCapacity)
    (φ : NewCapacity) : Prop :=
  φ ∉ Set.range embed

/-- An old-to-new vocabulary map counts as an embedding when it is injective. -/
def IsVocabularyEmbedding
    (embed : OldCapacity → NewCapacity) : Prop :=
  Function.Injective embed

/-- A strict vocabulary extension is witnessed by an injective embedding of
all old capacities plus at least one capacity outside its image. -/
def StrictVocabularyExtension
    (embed : OldCapacity → NewCapacity) : Prop :=
  IsVocabularyEmbedding embed ∧
    ∃ φ, VocabularyNovel embed φ

/-- Any explicitly vocabulary-new capacity proves that the old-to-new map is
not surjective. -/
theorem vocabularyNovel_implies_not_surjective
    (embed : OldCapacity → NewCapacity)
    {φ : NewCapacity}
    (hNovel : VocabularyNovel embed φ) :
    ¬ Function.Surjective embed := by
  intro hSurj
  exact hNovel (hSurj φ)

/-- An injective map with a vocabulary-new witness is a strict vocabulary
extension. -/
theorem strictVocabularyExtension_of_witness
    (embed : OldCapacity → NewCapacity)
    (hInjective : Function.Injective embed)
    {φ : NewCapacity}
    (hNovel : VocabularyNovel embed φ) :
    StrictVocabularyExtension embed := by
  exact ⟨hInjective, φ, hNovel⟩

/-- Lift an old capacity relation into the new vocabulary by translating its
capacity labels through the declared embedding. -/
def LiftOldCapacityRelation
    (embed : OldCapacity → NewCapacity)
    (OldRealizes : CapacityRelation Config Context OldCapacity) :
    CapacityRelation Config Context NewCapacity :=
  fun config ctx ψ =>
    ∃ φ, OldRealizes config ctx φ ∧ embed φ = ψ

/-- Every old realization remains expressible after lifting the old vocabulary
into the new one. -/
theorem old_realization_survives_vocabulary_lift
    (embed : OldCapacity → NewCapacity)
    (OldRealizes : CapacityRelation Config Context OldCapacity)
    {config : Config} {ctx : Context} {φ : OldCapacity}
    (h : OldRealizes config ctx φ) :
    LiftOldCapacityRelation embed OldRealizes config ctx (embed φ) := by
  exact ⟨φ, h, rfl⟩

/-- A vocabulary-new capacity cannot be merely an old realization relabelled
through the declared embedding. -/
theorem vocabularyNovel_not_old_lift
    (embed : OldCapacity → NewCapacity)
    (OldRealizes : CapacityRelation Config Context OldCapacity)
    {config : Config} {ctx : Context} {ψ : NewCapacity}
    (hNovel : VocabularyNovel embed ψ) :
    ¬ LiftOldCapacityRelation embed OldRealizes config ctx ψ := by
  intro h
  rcases h with ⟨φ, hOld, hEq⟩
  apply hNovel
  exact ⟨φ, hEq⟩

/-- A realized vocabulary expansion event: the new system realizes a capacity
that cannot be expressed as the image of an old capacity. -/
def VocabularyExpansionRealization
    (embed : OldCapacity → NewCapacity)
    (NewRealizes : CapacityRelation Config Context NewCapacity)
    (config : Config) (ctx : Context) (φ : NewCapacity) : Prop :=
  NewRealizes config ctx φ ∧ VocabularyNovel embed φ

/-- Strong emergence across both axes: the capacity is compositionally emergent
in the new system and vocabulary-new relative to the old capacity language. -/
def CompositionalVocabularyEmergence
    (embed : OldCapacity → NewCapacity)
    (Proper : Config → Config → Prop)
    (NewRealizes : CapacityRelation Config Context NewCapacity)
    (config : Config) (ctx : Context) (φ : NewCapacity) : Prop :=
  EmergentUnder Proper NewRealizes config ctx φ ∧
    VocabularyNovel embed φ

theorem compositionalVocabularyEmergence_implies_compositional
    (embed : OldCapacity → NewCapacity)
    (Proper : Config → Config → Prop)
    (NewRealizes : CapacityRelation Config Context NewCapacity)
    {config : Config} {ctx : Context} {φ : NewCapacity}
    (h :
      CompositionalVocabularyEmergence
        embed Proper NewRealizes config ctx φ) :
    EmergentUnder Proper NewRealizes config ctx φ := by
  exact h.1

theorem compositionalVocabularyEmergence_implies_vocabularyExpansion
    (embed : OldCapacity → NewCapacity)
    (Proper : Config → Config → Prop)
    (NewRealizes : CapacityRelation Config Context NewCapacity)
    {config : Config} {ctx : Context} {φ : NewCapacity}
    (h :
      CompositionalVocabularyEmergence
        embed Proper NewRealizes config ctx φ) :
    VocabularyExpansionRealization embed NewRealizes config ctx φ := by
  exact ⟨h.1.1, h.2⟩

end VocabularyCore

section SeparationWitnesses

/-- The sole old capacity embeds as `false`; `true` is vocabulary-new. -/
def unitIntoBool : Unit → Bool :=
  fun _ => false

theorem unitIntoBool_injective :
    Function.Injective unitIntoBool := by
  intro a b h
  cases a
  cases b
  rfl

theorem true_is_vocabularyNovel_from_unit :
    VocabularyNovel unitIntoBool true := by
  intro h
  rcases h with ⟨u, hu⟩
  simp [unitIntoBool] at hu

theorem unitIntoBool_is_strictVocabularyExtension :
    StrictVocabularyExtension unitIntoBool := by
  exact strictVocabularyExtension_of_witness
    unitIntoBool unitIntoBool_injective true_is_vocabularyNovel_from_unit

/-- One declared proper relation used in the separation witnesses. -/
def boolProper : Bool → Bool → Prop :=
  fun part whole => part = false ∧ whole = true

/-- A capacity can be compositionally emergent while the vocabulary itself has
not expanded: the capacity is already expressible in the old language. -/
theorem compositional_emergence_without_vocabulary_expansion :
    ∃ (Realizes : CapacityRelation Bool Unit Unit),
      EmergentUnder boolProper Realizes true () () ∧
      ¬ VocabularyNovel (fun u : Unit => u) () := by
  refine ⟨(fun config _ _ => config = true), ?_, ?_⟩
  · constructor
    · rfl
    · intro part hProper hRealizes
      exact Bool.noConfusion (hProper.1.symm.trans hRealizes)
  · simp [VocabularyNovel]

/-- Vocabulary expansion does not imply compositional emergence: a genuinely
new capacity can be realized both by the whole and by a declared proper part. -/
theorem vocabulary_expansion_without_compositional_emergence :
    ∃ (Realizes : CapacityRelation Bool Unit Bool),
      VocabularyExpansionRealization unitIntoBool Realizes true () true ∧
      ¬ EmergentUnder boolProper Realizes true () true := by
  refine ⟨(fun _ _ φ => φ = true), ?_, ?_⟩
  · exact ⟨rfl, true_is_vocabularyNovel_from_unit⟩
  · intro h
    exact (h.2 false ⟨rfl, rfl⟩) rfl

/-- The two axes can co-occur: `true` is outside the old vocabulary image and
is realized only by the whole configuration. -/
theorem compositional_and_vocabulary_emergence_can_cooccur :
    ∃ (Realizes : CapacityRelation Bool Unit Bool),
      CompositionalVocabularyEmergence
        unitIntoBool boolProper Realizes true () true := by
  refine ⟨(fun config _ φ => config = true ∧ φ = true), ?_⟩
  constructor
  · constructor
    · exact ⟨rfl, rfl⟩
    · intro part hProper hRealizes
      exact Bool.noConfusion (hProper.1.symm.trans hRealizes.1)
  · exact true_is_vocabularyNovel_from_unit

end SeparationWitnesses

section VocabularyIntegration

variable {OldCapacity NewCapacity : Type*}
variable [DecidableEq NewCapacity]

/-- The old vocabulary, represented inside the new capacity type. -/
def OldVocabularyAvailable
    (embed : OldCapacity → NewCapacity) : NewCapacity → Prop :=
  fun ψ => ψ ∈ Set.range embed

/-- Integrating one newly realized capacity extends the currently available
capacity vocabulary by that capacity. -/
def ExtendedVocabularyAvailable
    (embed : OldCapacity → NewCapacity)
    (φ : NewCapacity) : NewCapacity → Prop :=
  fun ψ => OldVocabularyAvailable embed ψ ∨ ψ = φ

/-- Integrating a capacity never removes an old vocabulary item. -/
theorem extendedVocabulary_preserves_old
    (embed : OldCapacity → NewCapacity)
    (φ : NewCapacity) :
    PreservesOn Set.univ
      (OldVocabularyAvailable embed)
      (ExtendedVocabularyAvailable embed φ) := by
  intro ψ hψ hOld
  exact Or.inl hOld

/-- A vocabulary-new capacity makes the declared available vocabulary strictly
larger once that capacity is integrated. -/
theorem vocabularyNovel_strictly_extends_available
    (embed : OldCapacity → NewCapacity)
    {φ : NewCapacity}
    (hNovel : VocabularyNovel embed φ) :
    StrictExpandsOn Set.univ
      (OldVocabularyAvailable embed)
      (ExtendedVocabularyAvailable embed φ) := by
  refine ⟨extendedVocabulary_preserves_old embed φ, φ, by simp, ?_, ?_⟩
  · exact hNovel
  · exact Or.inr rfl

/-- If integrating a vocabulary-new capacity permits a downstream capacity
that could not be generated from the old vocabulary, then the induced
generative accessibility relation strictly expands.

This is the formal version of the "new technology enables new products" step:
vocabulary expansion alone is insufficient; an actual new downstream
realization must exist. -/
theorem vocabulary_integration_enables_strict_downstream_expansion
    (embed : OldCapacity → NewCapacity)
    (Generate : HyperGenerator NewCapacity)
    {φ ψ : NewCapacity}
    (hNovel : VocabularyNovel embed φ)
    (hAfter :
      GeneratedFromAvailable
        (ExtendedVocabularyAvailable embed φ) Generate ψ)
    (hBefore :
      ¬ GeneratedFromAvailable
        (OldVocabularyAvailable embed) Generate ψ) :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable
        (OldVocabularyAvailable embed) Generate)
      (GeneratedFromAvailable
        (ExtendedVocabularyAvailable embed φ) Generate) := by
  refine ⟨?_, ψ, by simp, hBefore, hAfter⟩
  exact generatedFromAvailable_mono
    Set.univ
    (OldVocabularyAvailable embed)
    (ExtendedVocabularyAvailable embed φ)
    Generate
    (by
      intro x hx
      exact Or.inl hx)

/-- The strict downstream-expansion theorem does not need vocabulary novelty
once the old and new availability predicates are explicitly supplied.  The
novelty premise above records why the enlargement counts as a vocabulary
extension rather than merely activating an old label. -/
theorem integrated_capacity_with_new_downstream_realization_expands_access
    (embed : OldCapacity → NewCapacity)
    (Generate : HyperGenerator NewCapacity)
    (φ ψ : NewCapacity)
    (hAfter :
      GeneratedFromAvailable
        (ExtendedVocabularyAvailable embed φ) Generate ψ)
    (hBefore :
      ¬ GeneratedFromAvailable
        (OldVocabularyAvailable embed) Generate ψ) :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable
        (OldVocabularyAvailable embed) Generate)
      (GeneratedFromAvailable
        (ExtendedVocabularyAvailable embed φ) Generate) := by
  refine ⟨?_, ψ, by simp, hBefore, hAfter⟩
  exact generatedFromAvailable_mono
    Set.univ
    (OldVocabularyAvailable embed)
    (ExtendedVocabularyAvailable embed φ)
    Generate
    (by
      intro x hx
      exact Or.inl hx)

end VocabularyIntegration

section ConcreteDownstreamWitness

/-- In the expanded Boolean vocabulary, the newly available capacity `true`
can act as the sole parent of a downstream `true` realization.  The old
vocabulary contains only `false`, so that downstream event is inaccessible
before integration.  This witness is intentionally structural rather than a
claim that every vocabulary expansion produces such a downstream event. -/
def trueEnabledGenerator : HyperGenerator Bool :=
  fun parents z => parents = {true} ∧ z = true

theorem true_vocabulary_expansion_enables_new_downstream_generation :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable
        (OldVocabularyAvailable unitIntoBool) trueEnabledGenerator)
      (GeneratedFromAvailable
        (ExtendedVocabularyAvailable unitIntoBool true)
        trueEnabledGenerator) := by
  apply vocabulary_integration_enables_strict_downstream_expansion
    unitIntoBool trueEnabledGenerator
    true_is_vocabularyNovel_from_unit
  · refine ⟨{true}, ?_, ?_⟩
    · intro x hx
      have hxTrue : x = true := by simpa using hx
      subst x
      exact Or.inr rfl
    · simp [trueEnabledGenerator]
  · intro h
    rcases h with ⟨parents, hParents, hRule⟩
    have hEq : parents = {true} := hRule.1
    subst parents
    have hTrueOld := hParents true (by simp)
    rcases hTrueOld with ⟨u, hu⟩
    simp [unitIntoBool] at hu

end ConcreteDownstreamWitness

#print axioms vocabularyNovel_implies_not_surjective
#print axioms strictVocabularyExtension_of_witness
#print axioms old_realization_survives_vocabulary_lift
#print axioms vocabularyNovel_not_old_lift
#print axioms compositionalVocabularyEmergence_implies_compositional
#print axioms compositionalVocabularyEmergence_implies_vocabularyExpansion
#print axioms unitIntoBool_is_strictVocabularyExtension
#print axioms compositional_emergence_without_vocabulary_expansion
#print axioms vocabulary_expansion_without_compositional_emergence
#print axioms compositional_and_vocabulary_emergence_can_cooccur
#print axioms vocabularyNovel_strictly_extends_available
#print axioms vocabulary_integration_enables_strict_downstream_expansion
#print axioms true_vocabulary_expansion_enables_new_downstream_generation

end RecursiveAccessibility
end CumulativeAccessibility
