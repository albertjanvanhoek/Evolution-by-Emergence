import CumulativeAccessibility.GenerativeArity

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Emergent capacity

This module separates five concepts that are often conflated:

1. realization of a capacity by a configuration;
2. compositional emergence relative to a declared decomposition;
3. historical novelty;
4. model-relative surprise;
5. finite-parent generation.

The core notion is deliberately non-teleological.  An emergent capacity need
not be beneficial, persistent, resource-feasible, historically novel, or
unpredictable.  Those are downstream questions.

The generic core is formulated over an arbitrary configuration type and an
explicit proper-subconfiguration relation.  A finite-parent specialization
then connects the abstraction to the existing HyperGenerator architecture.
-/

section AbstractCore

variable {Config Context Capacity : Type*}

/-- A context-dependent capacity relation.  `Realizes c e φ` means that the
configuration `c`, in context `e`, realizes capacity `φ`. -/
abbrev CapacityRelation
    (Config Context Capacity : Type*) :=
  Config → Context → Capacity → Prop

/-- A capacity is emergent relative to a declared decomposition when the whole
realizes it and no declared proper subconfiguration does.

No claim about usefulness, persistence, novelty, or unpredictability is built
into this definition. -/
def EmergentUnder
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config) (ctx : Context) (φ : Capacity) : Prop :=
  Realizes config ctx φ ∧
    ∀ subconfig, Proper subconfig config →
      ¬ Realizes subconfig ctx φ

theorem emergentUnder_realizes
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    {config : Config} {ctx : Context} {φ : Capacity}
    (h : EmergentUnder Proper Realizes config ctx φ) :
    Realizes config ctx φ := by
  exact h.1

theorem emergentUnder_excludes_proper_subconfig
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    {config subconfig : Config} {ctx : Context} {φ : Capacity}
    (h : EmergentUnder Proper Realizes config ctx φ)
    (hProper : Proper subconfig config) :
    ¬ Realizes subconfig ctx φ := by
  exact h.2 subconfig hProper

/-- Two minimal realizers of the same capacity in the same context are
incomparable under the declared proper-subconfiguration relation. -/
theorem emergentUnder_minimal_realizers_incomparable
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    {c d : Config} {ctx : Context} {φ : Capacity}
    (hc : EmergentUnder Proper Realizes c ctx φ)
    (hd : EmergentUnder Proper Realizes d ctx φ) :
    ¬ Proper c d ∧ ¬ Proper d c := by
  constructor
  · intro hcd
    exact (hd.2 c hcd) hc.1
  · intro hdc
    exact (hc.2 d hdc) hd.1

/-- `fine` refines `coarse` when every decomposition recognized by the
coarse relation is also recognized by the fine relation.  The fine relation may
recognize additional proper subconfigurations. -/
def RefinesDecomposition
    (fine coarse : Config → Config → Prop) : Prop :=
  ∀ {part whole}, coarse part whole → fine part whole

/-- Emergence under a finer decomposition implies emergence under any coarser
one.  Adding more admissible decompositions can only make the irreducibility
test harder to satisfy. -/
theorem emergentUnder_of_refined_decomposition
    (fine coarse : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    {config : Config} {ctx : Context} {φ : Capacity}
    (href : RefinesDecomposition fine coarse)
    (hFine : EmergentUnder fine Realizes config ctx φ) :
    EmergentUnder coarse Realizes config ctx φ := by
  refine ⟨hFine.1, ?_⟩
  intro part hCoarse
  exact hFine.2 part (href hCoarse)

/-- Historical novelty is deliberately separate from compositional emergence. -/
def HistoricallyNovel
    (seen : Set Capacity) (φ : Capacity) : Prop :=
  φ ∉ seen

/-- A model-predicted capacity relation. -/
abbrev CapacityModel
    (Config Context Capacity : Type*) :=
  Config → Context → Capacity → Prop

/-- Model-relative novelty/surprise: the capacity is realized but the declared
model did not predict it for this configuration and context. -/
def ModelNovel
    (Realizes : CapacityRelation Config Context Capacity)
    (Model : CapacityModel Config Context Capacity)
    (config : Config) (ctx : Context) (φ : Capacity) : Prop :=
  Realizes config ctx φ ∧ ¬ Model config ctx φ

/-- Any compositional emergence can be historically old: choose a history in
which the capacity has already been seen.  This is a logical separation result,
not a claim about any particular empirical history. -/
theorem emergence_compatible_with_historical_repetition
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    {config : Config} {ctx : Context} {φ : Capacity}
    (hEmergent : EmergentUnder Proper Realizes config ctx φ) :
    ∃ seen : Set Capacity,
      EmergentUnder Proper Realizes config ctx φ ∧
      ¬ HistoricallyNovel seen φ := by
  refine ⟨Set.univ, hEmergent, ?_⟩
  simp [HistoricallyNovel]

/-- Compositional emergence can be fully anticipated by a model.  Predictability
is therefore not part of the definition of emergence. -/
theorem emergence_compatible_with_model_prediction
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    {config : Config} {ctx : Context} {φ : Capacity}
    (hEmergent : EmergentUnder Proper Realizes config ctx φ) :
    ∃ Model : CapacityModel Config Context Capacity,
      EmergentUnder Proper Realizes config ctx φ ∧
      ¬ ModelNovel Realizes Model config ctx φ := by
  refine ⟨fun _ _ _ => True, hEmergent, ?_⟩
  simp [ModelNovel]

/-- Historical novelty alone does not imply compositional emergence.  Here the
capacity is new to the declared history, but both a configuration and one of
its declared proper parts already realize it. -/
theorem historical_novelty_without_emergence :
    ∃ (Proper : Bool → Bool → Prop)
      (Realizes : CapacityRelation Bool Unit Unit)
      (seen : Set Unit),
      HistoricallyNovel seen () ∧
      ¬ EmergentUnder Proper Realizes true () () := by
  refine ⟨
    (fun part whole => part = false ∧ whole = true),
    (fun _ _ _ => True),
    ∅,
    ?_,
    ?_⟩
  · simp [HistoricallyNovel]
  · intro h
    exact (h.2 false ⟨rfl, rfl⟩) trivial

/-- Model-relative surprise alone does not imply compositional emergence.  A
model can miss a capacity already realized by a declared proper part. -/
theorem model_novelty_without_emergence :
    ∃ (Proper : Bool → Bool → Prop)
      (Realizes : CapacityRelation Bool Unit Unit)
      (Model : CapacityModel Bool Unit Unit),
      ModelNovel Realizes Model true () () ∧
      ¬ EmergentUnder Proper Realizes true () () := by
  refine ⟨
    (fun part whole => part = false ∧ whole = true),
    (fun _ _ _ => True),
    (fun _ _ _ => False),
    ?_,
    ?_⟩
  · simp [ModelNovel]
  · intro h
    exact (h.2 false ⟨rfl, rfl⟩) trivial

end AbstractCore

section FiniteInteractionSpecialization

variable {Process Context Capacity : Type*}
variable [DecidableEq Process]

/-- A finite-parent emergence rule.  `E parents ctx z φ` means that the joint
configuration of `parents`, in `ctx`, can produce carrier/process `z` that
realizes capacity `φ`. -/
abbrev EmergenceRule
    (Process Context Capacity : Type*) :=
  Finset Process → Context → Process → Capacity → Prop

/-- The parent configuration realizes a capacity when some produced carrier
realizes it. -/
def RealizesCapacity
    (E : EmergenceRule Process Context Capacity)
    (parents : Finset Process)
    (ctx : Context)
    (φ : Capacity) : Prop :=
  ∃ z, E parents ctx z φ

/-- Proper finite subconfiguration. -/
def FiniteProperSubconfig
    (sub whole : Finset Process) : Prop :=
  sub ⊂ whole

/-- A finite parent set is a minimal realizer of a capacity when it realizes the
capacity and no proper parent subset does. -/
def MinimalCapacityRealizer
    (E : EmergenceRule Process Context Capacity)
    (parents : Finset Process)
    (ctx : Context)
    (φ : Capacity) : Prop :=
  EmergentUnder
    (FiniteProperSubconfig (Process := Process))
    (RealizesCapacity E)
    parents ctx φ

/-- Joint emergence additionally requires at least two participating processes,
excluding unary realization from the joint-emergence label. -/
def JointEmergentCapacity
    (E : EmergenceRule Process Context Capacity)
    (parents : Finset Process)
    (ctx : Context)
    (φ : Capacity) : Prop :=
  2 ≤ parents.card ∧
    MinimalCapacityRealizer E parents ctx φ

/-- Forget the realized capacity and recover the existing finite-parent
HyperGenerator interface. -/
def ForgetCapacity
    (E : EmergenceRule Process Context Capacity)
    (ctx : Context) : HyperGenerator Process :=
  fun parents z => ∃ φ, E parents ctx z φ

/-- A capacity-carrying emergence event is also an ordinary generation event
after forgetting the capacity label. -/
theorem emergence_event_implies_generatedFromAvailable
    (Available : Process → Prop)
    (E : EmergenceRule Process Context Capacity)
    (parents : Finset Process)
    (ctx : Context)
    (z : Process)
    (φ : Capacity)
    (hParents : ∀ x, x ∈ parents → Available x)
    (hEvent : E parents ctx z φ) :
    GeneratedFromAvailable Available (ForgetCapacity E ctx) z := by
  exact ⟨parents, hParents, ⟨φ, hEvent⟩⟩

/-- Minimal realizers of the same capacity are an antichain under strict finite
subset. -/
theorem minimalCapacityRealizers_form_antichain
    (E : EmergenceRule Process Context Capacity)
    {p q : Finset Process}
    {ctx : Context} {φ : Capacity}
    (hp : MinimalCapacityRealizer E p ctx φ)
    (hq : MinimalCapacityRealizer E q ctx φ) :
    ¬ p ⊂ q ∧ ¬ q ⊂ p := by
  exact emergentUnder_minimal_realizers_incomparable
    (FiniteProperSubconfig (Process := Process))
    (RealizesCapacity E) hp hq

/-- A genuinely joint emergent capacity cannot already be realized by any
singleton participating parent. -/
theorem jointEmergentCapacity_excludes_singleton_parent
    (E : EmergenceRule Process Context Capacity)
    {parents : Finset Process}
    {ctx : Context} {φ : Capacity}
    (h : JointEmergentCapacity E parents ctx φ)
    {x : Process}
    (hx : x ∈ parents) :
    ¬ RealizesCapacity E {x} ctx φ := by
  apply h.2.2 {x}
  show FiniteProperSubconfig (Process := Process) {x} parents
  refine Finset.ssubset_iff_subset_ne.mpr ⟨?_, ?_⟩
  · exact Finset.singleton_subset_iff.mpr hx
  · intro hEq
    have hCard : parents.card = 1 := by
      rw [← hEq]
      simp
    omega

end FiniteInteractionSpecialization

section ConcreteWitnesses

/-- A deliberately minimal joint-capacity witness: only the joint parent set
`{false,true}` produces the designated capacity. -/
def pairOnlyEmergence : EmergenceRule Bool Unit Unit :=
  fun parents _ z _ =>
    parents = {false, true} ∧ z = true

theorem pairOnly_joint_emergent :
    JointEmergentCapacity pairOnlyEmergence {false, true} () () := by
  constructor
  · simp
  · constructor
    · refine ⟨true, ?_⟩
      simp [pairOnlyEmergence]
    · intro sub hsub hreal
      rcases hreal with ⟨z, hz⟩
      have hne := (Finset.ssubset_iff_subset_ne.mp hsub).2
      exact hne hz.1

/-- The same compositional emergence can recur after the capacity is already in
history, so emergence and historical novelty remain distinct in the concrete
finite-parent model. -/
theorem pairOnly_emergence_without_historical_novelty :
    JointEmergentCapacity pairOnlyEmergence {false, true} () () ∧
      ¬ HistoricallyNovel (Set.univ : Set Unit) () := by
  exact ⟨pairOnly_joint_emergent, by simp [HistoricallyNovel]⟩

/-- Context can switch capacity realization on and off without changing the
parent set. -/
def contextGatedEmergence : EmergenceRule Bool Bool Unit :=
  fun parents ctx z _ =>
    ctx = true ∧ parents = {false, true} ∧ z = true

theorem same_parts_different_context :
    RealizesCapacity contextGatedEmergence {false, true} true () ∧
      ¬ RealizesCapacity contextGatedEmergence {false, true} false () := by
  constructor
  · refine ⟨true, ?_⟩
    simp [contextGatedEmergence]
  · intro h
    rcases h with ⟨z, hz⟩
    simp [contextGatedEmergence] at hz

end ConcreteWitnesses

#print axioms emergentUnder_realizes
#print axioms emergentUnder_excludes_proper_subconfig
#print axioms emergentUnder_minimal_realizers_incomparable
#print axioms emergentUnder_of_refined_decomposition
#print axioms emergence_compatible_with_historical_repetition
#print axioms emergence_compatible_with_model_prediction
#print axioms historical_novelty_without_emergence
#print axioms model_novelty_without_emergence
#print axioms emergence_event_implies_generatedFromAvailable
#print axioms minimalCapacityRealizers_form_antichain
#print axioms jointEmergentCapacity_excludes_singleton_parent
#print axioms pairOnly_joint_emergent
#print axioms pairOnly_emergence_without_historical_novelty
#print axioms same_parts_different_context

end RecursiveAccessibility
end CumulativeAccessibility
