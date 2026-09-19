import CumulativeAccessibility.RecursiveEmergence

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Constructive recursive emergence

RecursiveEmergenceStepAt deliberately keeps two facts separate:

1. a retained parent set generates a child capacity through a HyperGenerator;
2. some configuration/context realizes that same child capacity emergently and
   passes resource, validation, and retention filters.

That separation is useful for generic compatibility, but it leaves a mechanistic
seam: the generator need not identify the configuration whose organization
realizes the emergent child.

This module adds an optional stronger interface. A construction rule maps a
finite parent set to a specific configuration for a specific child capacity.
A constructive recursive-emergence event requires that this same generated
configuration is the witness of compositional emergence and filtered retention.

The stronger event projects to the existing recursive event, so no previous
theorem is invalidated. Applications that cannot justify the stronger bridge
may continue to use the weaker interface explicitly.
-/

section ConstructionRule

variable {Config Capacity : Type*}

/-- Build parents config child means that the finite parent set constructs
config as a carrier/configuration for candidate capacity child. -/
abbrev ConfigurationConstructionRule
    (Config Capacity : Type*) :=
  Finset Capacity → Config → Capacity → Prop

/-- Forget the constructed configuration and recover the existing
capacity-level HyperGenerator. -/
def ForgetConstructedConfiguration
    (Build : ConfigurationConstructionRule Config Capacity) :
    HyperGenerator Capacity :=
  fun parents child => ∃ config, Build parents config child

end ConstructionRule

section ConstructiveEvent

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A strong recursive-emergence event.

The same finite parent set that contains the designated retained parent
constructs a specific configuration for child; that same configuration, in the
witnessed context, must realize child compositionally emergently and pass the
existing resource/validation/retention bridge.

Build is time indexed because the construction rule itself may evolve. -/
def ConstructiveRecursiveEmergenceStepAt
    (Build : ℕ → ConfigurationConstructionRule Config Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (parent child : Capacity) : Prop :=
  parent ∈ S m ∧
  ∃ parents config ctx,
    parent ∈ parents ∧
    (∀ x, x ∈ parents → x ∈ S m) ∧
    Build m parents config child ∧
    ResourceValidatedEmergentIntegrationAt
      Proper Realizes Cost Budget E S m config ctx child

/-- The construction rule induces a time-indexed ordinary capacity generator by
forgetting which configuration was built. -/
def ConstructiveCapacityGenerator
    (Build : ℕ → ConfigurationConstructionRule Config Capacity) :
    ℕ → HyperGenerator Capacity :=
  fun m => ForgetConstructedConfiguration (Build m)

/-- A constructive recursive event contains an explicit witness showing that
the exact generated configuration is also the configuration that realizes the
child emergently. -/
theorem constructiveRecursiveEmergenceStep_same_configuration
    (Build : ℕ → ConfigurationConstructionRule Config Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ConstructiveRecursiveEmergenceStepAt
        Build Proper Realizes Cost Budget E S m parent child) :
    ∃ parents config ctx,
      parent ∈ parents ∧
      (∀ x, x ∈ parents → x ∈ S m) ∧
      Build m parents config child ∧
      EmergentUnder Proper Realizes config ctx child := by
  rcases h with
    ⟨hParent, parents, config, ctx,
      hParentIn, hAvailable, hBuild, hEvent⟩
  exact
    ⟨parents, config, ctx,
      hParentIn, hAvailable, hBuild, hEvent.1⟩

/-- Forgetting the generated configuration turns every strong constructive
event into the existing RecursiveEmergenceStepAt.

This is the compatibility bridge: all existing recursive/open-ended results
remain available to an application that can justify the stronger construction
semantics. -/
theorem constructiveRecursiveEmergenceStep_implies_recursiveEmergenceStep
    (Build : ℕ → ConfigurationConstructionRule Config Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ConstructiveRecursiveEmergenceStepAt
        Build Proper Realizes Cost Budget E S m parent child) :
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S
      (ConstructiveCapacityGenerator Build)
      m parent child := by
  rcases h with
    ⟨hParent, parents, config, ctx,
      hParentIn, hAvailable, hBuild, hEvent⟩
  refine ⟨hParent, ?_, ?_⟩
  · exact
      ⟨parents, hParentIn, hAvailable, ⟨config, hBuild⟩⟩
  · exact ⟨config, ctx, hEvent⟩

/-- Constructive recursive emergence retains a genuinely new operational child,
by projection to the established recursive event. -/
theorem constructiveRecursiveEmergenceStep_retains_new_child
    (Build : ℕ → ConfigurationConstructionRule Config Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ConstructiveRecursiveEmergenceStepAt
        Build Proper Realizes Cost Budget E S m parent child) :
    RetainedIntegrationAt S m child := by
  exact
    recursiveEmergenceStep_retains_new_child
      Proper Realizes Cost Budget E S
      (ConstructiveCapacityGenerator Build) m
      (constructiveRecursiveEmergenceStep_implies_recursiveEmergenceStep
        Build Proper Realizes Cost Budget E S m h)

/-- Under monotone operational retention, the strong constructive event gives
the same strict repertoire expansion as the weaker recursive event. -/
theorem constructiveRecursiveEmergenceStep_strictly_expands_repertoire
    (Build : ℕ → ConfigurationConstructionRule Config Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (h :
      ConstructiveRecursiveEmergenceStepAt
        Build Proper Realizes Cost Budget E S m parent child) :
    S m ⊂ S (m + 1) := by
  exact
    recursiveEmergenceStep_strictly_expands_repertoire
      Proper Realizes Cost Budget E S
      (ConstructiveCapacityGenerator Build) m hRetained
      (constructiveRecursiveEmergenceStep_implies_recursiveEmergenceStep
        Build Proper Realizes Cost Budget E S m h)

end ConstructiveEvent

section ConstructiveToyWitness

open Toy3

/-- A concrete construction rule for the existing depth-two recursive toy.

At time 0 the parent set {a} constructs configuration true for child b.
At time 1 the retained child b constructs the same carrier configuration for
child c. The existing context-dependent realization relation then witnesses
that exact configuration as emergent for the respective child. -/
def recursiveToyConstruction
    (m : ℕ) : ConfigurationConstructionRule Bool Toy3 :=
  fun parents config child =>
    (m = 0 ∧ parents = {a} ∧ config = true ∧ child = b) ∨
    (m = 1 ∧ parents = {b} ∧ config = true ∧ child = c)

/-- First strong link: the configuration constructed from {a} is exactly the
configuration witnessing emergent realization of b. -/
theorem recursiveToy_a_to_b_is_constructiveRecursiveEmergenceStep :
    ConstructiveRecursiveEmergenceStepAt
      recursiveToyConstruction
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire
      0 a b := by
  refine ⟨?_, {a}, true, 0, ?_, ?_, ?_, ?_⟩
  · simp [recursiveToyRepertoire]
  · simp
  · intro x hx
    have hxa : x = a := by simpa using hx
    subst x
    simp [recursiveToyRepertoire]
  · simp [recursiveToyConstruction]
  · exact recursiveToy_b_emergent_integrated

/-- Second strong link: retained b is used to construct the exact configuration
witnessing emergent realization of c. -/
theorem recursiveToy_b_to_c_is_constructiveRecursiveEmergenceStep :
    ConstructiveRecursiveEmergenceStepAt
      recursiveToyConstruction
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire
      1 b c := by
  refine ⟨?_, {b}, true, 1, ?_, ?_, ?_, ?_⟩
  · simp [recursiveToyRepertoire]
  · simp
  · intro x hx
    have hxb : x = b := by simpa using hx
    subst x
    simp [recursiveToyRepertoire]
  · simp [recursiveToyConstruction]
  · exact recursiveToy_c_emergent_integrated

/-- The strong witness projects to the old event semantics, demonstrating
backward compatibility rather than a replacement of the existing theory. -/
theorem recursiveToy_constructive_a_to_b_projects_to_recursive :
    RecursiveEmergenceStepAt
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire
      (ConstructiveCapacityGenerator recursiveToyConstruction)
      0 a b := by
  exact
    constructiveRecursiveEmergenceStep_implies_recursiveEmergenceStep
      recursiveToyConstruction
      boolProper recursiveToyRealizes
      recursiveToyCost recursiveToyBudget recursiveToyCriterion
      recursiveToyRepertoire 0
      recursiveToy_a_to_b_is_constructiveRecursiveEmergenceStep

end ConstructiveToyWitness

#print axioms constructiveRecursiveEmergenceStep_same_configuration
#print axioms constructiveRecursiveEmergenceStep_implies_recursiveEmergenceStep
#print axioms constructiveRecursiveEmergenceStep_retains_new_child
#print axioms constructiveRecursiveEmergenceStep_strictly_expands_repertoire
#print axioms recursiveToy_a_to_b_is_constructiveRecursiveEmergenceStep
#print axioms recursiveToy_b_to_c_is_constructiveRecursiveEmergenceStep
#print axioms recursiveToy_constructive_a_to_b_projects_to_recursive

end RecursiveAccessibility
end CumulativeAccessibility
