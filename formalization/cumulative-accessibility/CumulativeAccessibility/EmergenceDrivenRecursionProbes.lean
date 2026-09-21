import CumulativeAccessibility.EmergenceDrivenRecursionOpenEnded

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Adversarial probes for emergence-driven recursion

These are regression probes against the new strong synthesis surface. They are
not positive examples; they encode failure modes that should remain impossible
unless the semantics are intentionally changed.
-/

section ConstantRuleProbe

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Probe 1. A strong vocabulary-expansion event cannot be manufactured from a
generator that ignores retained repertoire, when the event child was internally
generated and is the isolated repertoire addition. -/
theorem probe_constantRule_cannot_satisfy_strongVocabularyEvent
    (targets : Set Capacity)
    (G : HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      EmergenceDrivenVocabularyExpansionAt
        targets (fun _ => G) Realizes Cost Budget E S m parent child) :
    False := by
  exact
    (constantRule_parentFaithfulPromotion_not_vocabularyExpansion
      targets G Realizes Cost Budget E S m h.1 h.2.1) h.2.2

end ConstantRuleProbe

section ToyCausalProbes

open EmergenceToy

/-- Probe 2. In the concrete synthesis witness, the rule for d cannot operate
unless c is already available. This checks that the new rule is genuinely a
function of retained organization rather than a time label. -/
theorem probe_toy_d_rule_requires_c
    (Available : EmergenceToy → Prop)
    (hNoC : ¬ Available c) :
    ¬ GeneratedFromAvailable Available (emergenceToyRuleOf Available) d := by
  rintro ⟨parents, hAvailable, hRule⟩
  change Available c ∧ parents = {b, c} at hRule
  exact hNoC hRule.1

/-- Probe 3. The first emergent child is absent from the pre-event repertoire
and present after the event. -/
theorem probe_toy_c_crosses_operational_boundary :
    c ∉ emergenceToyRepertoire 0 ∧
    c ∈ emergenceToyRepertoire 1 := by
  simp [emergenceToyRepertoire]

/-- Probe 4. The later product d is genuinely outside the old full generative
closure, not merely outside the old one-step frontier. -/
theorem probe_toy_d_really_outside_old_fullClosure :
    ¬ FixedGenerativeClosure
        (emergenceToyGenerator 0)
        (fun x => x ∈ emergenceToyRepertoire 0)
        d := by
  simpa [emergenceToyGenerator, GeneratorFromRepertoire] using
    emergenceToy_d_not_in_old_closure

/-- Probe 5. Retained c is an explicit member of the causal parent
configuration of the second emergent event. -/
theorem probe_second_emergence_explicitly_reuses_c :
    ∃ parents ctx,
      c ∈ parents ∧
      (∀ x, x ∈ parents → x ∈ emergenceToyRepertoire 1) ∧
      emergenceToyGenerator 1 parents d ∧
      EmergentUnder
        (FiniteProperSubconfig (Process := EmergenceToy))
        emergenceToyRealizes parents ctx d := by
  exact parentFaithful_has_emergent_parent_configuration
    emergenceToyGenerator emergenceToyRealizes
    emergenceToyCost emergenceToyBudget emergenceToyCriterion
    emergenceToyRepertoire 1
    emergenceToy_second_parentFaithfulEmergence

/-- Probe 6. The concrete end-to-end witness really crosses the full-closure
boundary in the required direction. -/
theorem probe_endToEnd_has_old_new_closure_separation :
    (¬ FixedGenerativeClosure
        (emergenceToyGenerator 0)
        (fun x => x ∈ emergenceToyRepertoire 0)
        d) ∧
    FixedGenerativeClosure
        (emergenceToyGenerator 1)
        (fun x => x ∈ emergenceToyRepertoire 1)
        d := by
  exact ⟨
    probe_toy_d_really_outside_old_fullClosure,
    by
      simpa [emergenceToyGenerator, GeneratorFromRepertoire] using
        emergenceToy_d_in_new_closure⟩

end ToyCausalProbes

#print axioms probe_constantRule_cannot_satisfy_strongVocabularyEvent
#print axioms probe_toy_d_rule_requires_c
#print axioms probe_toy_c_crosses_operational_boundary
#print axioms probe_toy_d_really_outside_old_fullClosure
#print axioms probe_second_emergence_explicitly_reuses_c
#print axioms probe_endToEnd_has_old_new_closure_separation

end RecursiveAccessibility
end CumulativeAccessibility
