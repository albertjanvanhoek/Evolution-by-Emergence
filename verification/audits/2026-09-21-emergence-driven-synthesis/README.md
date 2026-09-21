# Emergence-driven synthesis audit

**Branch:** research/emergence-driven-recursion  
**Baseline:** d92cd7d29dfddc2182095d88b639ac13c42bced4  
**PR:** #62  
**Status:** research / adversarial review required

## Purpose

This audit records which findings from the 21 September external adversarial
review are addressed by the emergence-driven synthesis and which remain open.
It is intentionally not a claim that the review has been fully resolved.

## Review finding map

| Review finding | Synthesis status | What changed |
|---|---|---|
| F1 / P1: weak emergence/filter interfaces can be decorated around retained generation | **Addressed on the candidate strong path** | The old weak interface remains for compatibility. The operator candidate uses the exact causal parent set as the configuration tested for emergence, and emergent provenance controls whether the child's operator can activate. |
| F2 / P7: constructive bridge can ignore configuration | **Addressed for the strong path** | `ParentSetConstructionFromGenerator` makes configuration equal to the causal parent set; proper subconfigurations are proper parent subsets. The generic constructive interface remains weaker by design. |
| F3 / P9: fixed-generator promotion changes one-step access, not full reach | **Addressed directly** | `FixedGenerativeClosure` and `generatedPromotion_preserves_fixedGeneratorClosure` formalize the no-go. Operational and vocabulary ratchets are now separate. |
| F4: calibrated ledger can be trivial under unit factors | **Open** | Not changed in this PR. |
| F5: finite local envelope/admission carries weak independent constraint | **Open** | Not changed in the finite causal core. |
| F6: uniform zero-lag continuation is too strong as an empirical recurrence model | **Partially addressed** | The new recurrence layer does not use the v17 uniform-zero-lag predicate. It separates finite linked chains from arbitrarily late strong events. Empirical lag/distribution modelling remains open. |
| F7: recurring historical events need not form a lineage | **Addressed conceptually/formally** | `EmergenceDrivenVocabularyChain` is a linked lineage; `RecurringEmergenceDrivenVocabularyExpansion` is explicitly weaker and documented as event frequency, not lineage. |
| F8: some pre-promotion clauses are redundant under retention | **Open in v17** | The synthesis does not rely on that old clause for its full-closure criterion. |
| F9: historical endpoint is primarily accounting | **Open / retained as separate endpoint** | No attempt is made to reinterpret historical accumulation as the strong EbE mechanism. |
| F10: resource/validation cost is not configuration-specific and lacks a shared maintenance/exploration budget | **Partially addressed** | In the operator candidate, feasibility and external validation now decide Active admission and therefore whether the new operator can activate; the Dynamic Vortex bridge can supply the endogenous slack budget. Configuration-specific costs and a fully shared simultaneous-event budget remain open. |
| F11: prior-art set incomplete | **Open** | Literature positioning is deliberately not altered until the formal synthesis stabilizes. |
| F12: capacity labels depend on granularity/equivalence choice | **Open** | No coarse-graining or observational equivalence theorem yet. |
| F13: reproducibility/axiom audit should be strengthened | **Partially addressed** | Both new modules are explicit CI build targets and direct axiom-audit targets. Repository-wide manifest policy is unchanged. |

## New theorem surfaces

### Fixed-generator boundary

- `FixedGenerativeClosure`
- `ClosureStrictExpandsOn`
- `generatedPromotion_preserves_fixedGeneratorClosure`
- `generatedPromotion_fixedGeneratorClosure_iff`
- `internallyGeneratedPromotion_not_closureStrictExpansion`

These establish that promotion of an already-generated child under a fixed
generator is closure-invariant.

### Parent-faithful emergence

- `ParentFaithfulRecursiveEmergenceStepAt`
- `parentFaithful_implies_constructiveRecursiveEmergence`
- `parentFaithful_has_emergent_parent_configuration`
- `parentFaithful_implies_recursiveEmergenceStep`
- `parentFaithful_retains_new_child`

This strong specialization makes the causal parent set the exact configuration
whose proper subsets are tested for absence of the emergent capacity.

### Operational ratchet

- `EmergenceDrivenTwoGenerationRatchetAt`
- `twoGenerationRatchet_strictlyExpands_oneStepAccess`

This is deliberately a one-step accessibility statement and is not called full
vocabulary expansion.

### Vocabulary ratchet

- `RepertoireDependentGenerator`
- `GeneratorFromRepertoire`
- `IsolatedRetainedIntegrationAt`
- `EmergenceDrivenVocabularyExpansionAt`
- `constantRule_parentFaithfulPromotion_not_vocabularyExpansion`

The rule is explicitly a function of retained repertoire. Strong vocabulary
expansion requires a strict change in full generative closure.

### End-to-end finite witness

- `emergenceToy_first_parentFaithfulEmergence`
- `emergenceToy_second_parentFaithfulEmergence`
- `emergenceToy_closure_strictly_expands`
- `emergenceToy_first_is_vocabularyExpansion`
- `emergenceToy_endToEnd_emergenceDrivenRecursion`

The witness checks:

    {a,b}
      -> emergent c
      -> c retained as the only repertoire addition
      -> repertoire-dependent rule changes
      -> d enters full closure
      -> c is reused in {b,c}
      -> emergent d.

It is a logical satisfiability witness, not an empirical model.

### Temporal lift

- `EmergenceDrivenVocabularyChain`
- `RecurringEmergenceDrivenVocabularyExpansion`
- `recurringEmergenceDrivenVocabularyExpansion_implies_openEndedNovelty`
- `recurringEmergenceDrivenVocabularyExpansion_implies_unboundedEnvelope`

The lineage and event-frequency notions are intentionally not identified.

## Remaining semantic seam

The strongest remaining application-specific interface is now visible:

    retained emergent organization
      -> RuleOf(new retained repertoire).

The formalization requires `RuleOf` to be an explicit function of retained
organization and, for the isolated event, requires that the emergent child is
the only repertoire addition. This blocks mere time-index correlation in the
formal object.

However, Lean cannot establish that a chosen empirical `RuleOf` is the right
causal representation of chemistry, biology, technology, culture, or an
institution. That remains a domain mapping and empirical validation problem.


## Second review: Q1–Q3 and the operator candidate

A follow-up external review of PR #62 supplied three additional probes.

- **Q1:** the first `RuleOf(S)` generator-change theorem could be proved
  without emergence.
- **Q2:** replacing the toy realization with a non-emergent realization did
  not change the already-assumed closure expansion.
- **Q3:** the recurring strong-event premise was shown non-vacuous by an
  infinite ladder model.

Q1 and Q2 are accepted criticisms of the first synthesis route.  That route is
kept for comparison, but is not the preferred causal core.

The replacement is the operator/provenance surface:

- `EmergenceDrivenOperatorEvolution.lean`
- `EmergenceDrivenOperatorRecurrence.lean`
- `EmergenceDrivenOperatorWitness.lean`
- `EmergenceDrivenOperatorDynamicVortex.lean`

The key change is that full-closure expansion is no longer a field of the
event.  The current generator is built from `Base` plus operators belonging
only to capacities that are simultaneously Active and emergence-certified.
Emergence updates certification; feasibility/validation updates Active.
Therefore both links are needed before `Op(child)` enters the generator.

### Q1 replacement

`emergenceDrivenOperatorEvent_click` derives full-closure expansion from the
event, and `emergenceDrivenOperatorEvent_forces_generatorChange` derives rule
change from that click plus the fixed-generator P9 no-go.

### Q2 replacement

`certificationLaw_nonEmergence_blocks_child` states directly that a
non-emergent child cannot acquire the new provenance certificate under the
isolated certification law.

`uncertified_generated_promotion_no_closure_click` then proves that admitting
an already-generated child as material without certifying it cannot create a
full-closure click.

The ladder witness adds a concrete non-emergent twin and a matching
whole-versus-parts attribution countermodel.

### Q3 replacement

The operator ladder supplies both:

- `operatorLadder_recurring`: a witness of the generic arbitrary-late
  recurrence premise;
- `operatorLadder_chain`: arbitrarily long explicit linked lineages.

`operatorLadder_openEndedNovelty` then instantiates the generic open-ended
consequence.

### Stronger emergence attribution

`emergent_operator_product_irreducible` uses an adversarial counterfactual in
which every capacity realized by every proper subassembly is granted material
availability and its operator.  Under a uniqueness condition for the witness
product, the product remains unreachable.  The matching
`nonEmergent_part_operator_reaches_product` shows why the emergence premise is
load-bearing for whole-versus-parts attribution.

## Merge gate

Do not promote this branch to a canonical EbE core merely because the toy
witness compiles.

Before merge/canonicalization:

1. Lean CI and axiom audits must be green.
2. Require the non-emergent, uncertified-promotion, fixed-operator, and whole-versus-parts knock-outs to remain green.
3. Require the infinite operator ladder and linked-chain witness to remain green.
4. Review whether the isolated admission/certification laws are too strong for the intended empirical mappings or best retained as causal-identification specializations.
5. Review the additive-operator assumption and document when inhibitory or context-dependent rule evolution requires a generalization.
6. Update prior-art positioning before any novelty claim.
