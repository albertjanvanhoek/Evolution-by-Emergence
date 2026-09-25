# Organization-driven emergence audit

**Branch:** research/emergence-driven-recursion  
**Baseline:** d92cd7d29dfddc2182095d88b639ac13c42bced4  
**PR:** #62  
**Status:** research / adversarial review required

## What changed

The branch originally explored two stronger generator-centered routes:

1. a generic repertoire-dependent RuleOf(S) construction;
2. a certification/operator construction.

The first improved the treatment of full closure but could derive generator
change without using emergence.

The second attempted to make emergence load-bearing by allowing only
emergence-certified capacities to contribute operators.

That second move was rejected after conceptual review. It changes the ontology
from organization-producing-function to permission-controlled capacity labels.

The certification/operator files have therefore been removed from the branch.

The current candidate is organization-first.

## Current causal architecture

    retained parts
      -> assemble organization
      -> organization realizes function
      -> proper parts do not realize that function
      -> function exists now
      -> persistence gate decides whether organization remains
      -> retained organization becomes reusable material
      -> every function it realizes is automatically available
      -> later organization/accessibility may change.

Key separation:

    function exists != organization persists.

## Review finding map

| Finding | Current status |
|---|---|
| F1/F2: emergence could be attached to an unrelated configuration | **Addressed on candidate path.** Causal parents must be retained, generate the exact organization, and are declared proper parts of that whole. |
| F3/P9: fixed-rule promotion was mistaken for closure expansion | **Addressed directly.** reachableOrganizationPromotion_preserves_fixedReach states the organization-level no-go. |
| F4: ledger calibration can be trivial | **Open.** Not part of this causal rewrite. |
| F5: finite envelope/admission may carry weak independent constraint | **Open.** |
| F6: uniform zero-lag continuation too strong | **Improved.** The new recurrence layer separates finite linked chains from arbitrary-late recurrence and does not identify recurrence with one empirical timing law. |
| F7: historical recurrence need not imply one lineage | **Addressed.** OrganizationEmergenceChain and recurring-event predicates are distinct. |
| F8/F9: bookkeeping clauses can be mistaken for mechanism | **Improved.** The candidate core uses organization, realization, persistence and reuse directly; historical accounting remains downstream. |
| F10: resource filter not load-bearing | **Addressed at the intended layer.** Resource budget now controls persistence only. It does not create or authorize function. |
| F11: prior art incomplete | **Open.** Must be updated before novelty claims. |
| F12: capacity/granularity dependence | **Open and explicit.** Organization, proper-part relation, context and realization mapping remain application choices. |
| F13: reproducibility/axiom audit | **Improved.** Candidate modules, witnesses and probes are direct CI/audit targets. |

## Candidate theorem surface

### Organization and function

- FunctionAvailable
- EffectiveOrganizationGenerator
- EmergentOrganizationAt
- emergentOrganization_function_exists
- emergentOrganization_excludes_proper_part_function

### Persistence is downstream

- OrganizationPersistenceGateAt
- IsolatedOrganizationPersistenceLawAt
- EmergentOrganizationPersistenceAt
- emergentPersistentOrganization_function_preexists_gate
- emergent_function_can_exist_without_persistence
- emergentOrganization_retained
- emergentOrganization_function_available_after_persistence

### Functional vocabulary

- FunctionallyNovelToRetainedSystem
- RetainedVocabularyEmergenceAt
- retainedVocabularyEmergence_strictly_expands_availableFunctions

### Accessibility

- OrganizationReach
- reachableOrganizationPromotion_preserves_fixedReach
- retainedOrganization_can_expand_oneStep_under_fixedRule
- retainedEmergentFunction_can_expand_fullReach

The latter theorem uses fixed Base, Realizes and Use laws. Accessibility can
change because the retained organizational state changed; no fundamental rule
mutation is required.

### Recursion

- OrganizationEmergenceStepAt
- OrganizationEmergenceChain
- RecurringEmergentOrganizationPersistence
- RecurringRetainedVocabularyEmergence
- recurringVocabularyEmergence_implies_openEndedOrganization

### Positive witness

- organizationLadder_emergence_event
- organizationLadder_function_exists_before_persistence
- organizationLadder_event
- organizationLadder_vocabulary_event
- organizationLadder_functions_strictly_expand
- organizationLadder_fullReach_click
- organizationLadder_recursive_reuse
- organizationLadder_chain
- organizationLadder_recurring_vocabulary
- organizationLadder_openEndedOrganization

### Negative/context probes

- organizationLadder_nonEmergent_whole_still_functions
- organizationLadder_nonEmergent
- organizationLadder_nonEmergent_function_already_available
- organizationLadder_nonEmergent_not_functionally_novel
- same_retained_organization_context_changes_expressed_function

These probes enforce the conceptual correction:

> non-emergence does not disable function.

Instead, in the twin model a proper part already supplies the same function, so
the whole is not a new functional building block.

## Resource layer

OrganizationDrivenDynamicVortex.lean feeds the endogenous
uptake-minus-maintenance response budget only into the persistence gate.

It does not occur in Realizes or EmergentUnder.

This protects the distinction between:

    organization has function

and:

    organization survives long enough to be reused.

## Chen et al. sanity check

Chen et al. (2025), Electronic Circuit Principles of Large Language Models
(arXiv:2502.03325v2), motivated one explicit regression probe: the same retained
organization can express different function in different contexts without a
parameter/fundamental-rule change.

The paper is not used as evidence for the evolutionary theory. It is used as a
conceptual check against equating all effective capability change with generator
mutation.

## Abandoned certification/operator route

The operator/certification prototype was useful because it exposed the
remaining Q1/Q2 problem, but it is not retained in the candidate core.

Reason:

    organization -> function

was being replaced by:

    label -> certification -> allowed operator.

That is a different theory.

The files were removed rather than merely hidden from the verification surface.

## Merge gate

Before this PR can become a successor core:

1. all organization-first Lean targets and axiom audits must be green;
2. the positive ladder, non-emergent twin, context probe and P9 boundary must remain green;
3. the persistence/resource bridge must remain downstream of realization;
4. reviewers should attack whether causal parents really deserve to be treated as proper parts in intended applications;
5. reviewers should test whether FunctionallyNovelToRetainedSystem is the right system-level vocabulary criterion;
6. prior-art positioning must be updated before any novelty claim;
7. empirical mappings must justify organization, decomposition, context, realization and use independently.