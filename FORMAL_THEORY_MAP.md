# Formal Theory Map — v20 Peer-Review Surface

**Purpose:** trace the v20 prose claims to the exact Lean modules and distinguish definitions, necessary conditions, sufficient conditions, countermodels, and interpretation.

## Canonical review object

- Theory: THEORY_CORE_V20.md
- Formal package: formalization/cumulative-accessibility/
- Axiom audit: CumulativeAccessibility/VerificationSurface.lean
- Aggregate advertised import: CumulativeAccessibility/AuditAll.lean

## V20 theorem spine

| ID | Claim | Lean source | Formal status | What it does not establish |
|---|---|---|---|---|
| V20-T1 | Retain/ablate arms are matched on active organization, context, and gross budget. | RetainedOrganizationCore.lean: itemContrast_matches_background | machine-checked construction | that the application has identified the correct retained item |
| V20-T2 | Positive marginal upkeep lowers the retained arm's free budget. | RetainedOrganizationCore.lean: strictlyPaidItem_reduces_freeBudget | machine-checked implication | that retention is beneficial |
| V20-T3 | Under monotone accessibility and positive upkeep, positive paid transfer implies a retained structural advantage at the same free budget. | RetainedOrganizationCore.lean: positivePaidTransfer_implies_sameBudget_retention_advantage | machine-checked necessary consequence | a mechanism for the advantage |
| V20-T4 | If retention has no matched-budget structural effect, upkeep alone cannot create positive transfer. | RetainedOrganizationCore.lean: no_positiveTransfer_from_upkeep_penalty_alone | machine-checked regression guard | that every structural effect is cumulative |
| V20-T5 | Weighted transition-kernel dominance preserves finite-horizon accessibility at equal budget. | TransitionAccessibility.lean: kernelDominance_preserves_accessibility | machine-checked implication | empirical dominance in a real system |
| V20-T6 | With non-decreasing upkeep, positive paid opening requires that the ablated kernel does not dominate the retained kernel. | TransitionAccessibility.lean: positivePaidOpening_requires_kernel_advantage | machine-checked necessary condition | sufficiency; an iff characterization |
| V20-T7 | If retained route saving exceeds marginal upkeep relative to a lower bound on ablated routes, some common gross budget exhibits positive paid opening. | TransitionAccessibility.lean: route_saving_exceeds_marginal_upkeep_opens_paid_window | machine-checked sufficient condition | necessity |
| V20-T8 | Kernel-induced accessibility connects the abstract core transfer predicate to retained reachability and ablated non-reachability. | TransitionAccessibility.lean: core_positiveTransfer_iff_kernel_reach; core_positiveTransferForItem_iff_kernel_reach | machine-checked bridge | that 0/1 reachability is the only useful accessibility measure |
| V20-T9 | Under strict compositional emergence and target benefit only after realization, a positively costly proper intermediate has negative target-financed net value. | EmergentAssemblyBarrier.lean: emergent_proper_subconfig_negative_target_financed_net | machine-checked implication | that the intermediate cannot persist by another mechanism |
| V20-T10 | If such a proper intermediate is viable, strictly positive auxiliary support is required. | EmergentAssemblyBarrier.lean: viable_emergent_intermediate_requires_auxiliary_support | machine-checked consequence | the source or empirical meaning of auxiliary support |
| V20-T11 | If the emergent function itself adds a transition, a proper non-realizing part cannot obtain paid opening through that phi-mediated mechanism under non-decreasing upkeep. | TransitionMediatedEmergence.lean: emergent_proper_subconfig_no_phi_paidOpening | machine-checked mechanistic specialization | that proper parts cannot persist as stepping stones through other transitions |
| V20-T12 | The emergence specialization is non-vacuous and has drop-one-premise countermodels. | TransitionMediatedEmergence.lean: witness_emergent_whole_positive_paidOpening; countermodel_nonEmergent_part_transfers; countermodel_negative_upkeep; steppingStone_part_transfers | machine-checked witnesses/countermodels | empirical frequency of these cases |
| V20-T13 | Bounded single-unit reuse gives |A| <= |R| d. | GenerativeLeverage.lean: accessible_card_le_retained_mul_slots | machine-checked cardinality bound | unique causal ownership in real systems |
| V20-T14 | With minimum maintenance mu and budget B, bounded reuse gives |A| mu <= B d. | GenerativeLeverage.lean: accessible_card_mul_minCost_le_budget_mul_slots | machine-checked resource-normalized bound | that maintenance costs are uniform or easy to measure |
| V20-T15 | If every candidate costs at least mu > 0 and B < |C| mu, retaining all candidates is infeasible. | GenerativeLeverage.lean: candidate_set_exceeding_budget_cannot_all_be_retained | machine-checked no-go | which candidate is forgotten, compressed, replaced, or retained |
| V20-T16 | Uniformly bounded retained cardinality plus uniformly bounded single-unit reuse rules out unbounded accessible cardinality. | GenerativeLeverage.lean: bounded_memory_and_bounded_reuse_rule_out_unbounded_accessibility | machine-checked no-go | open-endedness under compositional support outside the encoding |
| V20-T17 | Repeated reuse can make paid retention advantageous under explicit cost thresholds. | PaidReuseHierarchy.lean; RepetitionDepth.lean | machine-checked specializations | a universal law that hierarchy must arise this way |
| V20-T18 | Internally generated slack can be joined to second-order accessibility updates in the Dynamic Vortex specialization. | EndogenousBudgetBridge.lean; DynamicVortex.lean | machine-checked conditional composition | that every retained change improves slack or future search |

## Core definitions

### State

    State = (active G, retained R, context Gamma, grossBudget)
    freeBudget = grossBudget - Maintenance(retained)

Source: RetainedOrganizationCore.lean.

### Paid transfer

PositiveTransferForItem compares the retained and ablated arms created from the same base state and the same item X after each arm pays its own maintenance burden.

Source: RetainedOrganizationCore.lean.

### Weighted transition machinery

WeightedKernel declares allowed one-step transitions and nonnegative transition costs. ReachableWithin requires an actual finite route within both horizon and free budget.

Source: TransitionAccessibility.lean.

### Strict compositional emergence

EmergentUnder requires the whole to realize the declared capacity and every declared proper subconfiguration not to realize it.

Source: EmergentAssemblyBarrier.lean via the recursive-accessibility emergence interface.

### Bounded reuse

BoundedReuseEncoding injectively assigns each accessible target to one retained unit and one of d support slots.

Source: GenerativeLeverage.lean.

## Interpretation layer — not itself a Lean theorem

The v20 scientific interpretation combines the checked pieces into the recursive picture:

    history / interaction
      -> retained organization
      -> changed transition machinery
      -> changed future accessibility
      -> new organization
      -> budget-constrained retention
      -> ...

The proposed cross-scale reading is **learning-like dynamics**. Neural learning is one instance; other cellular, organismal, social, cultural, scientific, and technological mappings remain empirical/modeling hypotheses.

Lean does not prove that these domains instantiate one empirical mechanism.

## Important theorem-direction guardrails

- V20-T6 is **necessary**, not sufficient.
- V20-T7 is **sufficient**, not necessary.
- The pair is not an iff characterization.
- V20-T9 does not prove all emergent intermediates are impossible; it isolates failure of financing by the future target function alone.
- V20-T15 proves a finite-resource trade-off, not an optimizer or fitness rule.
- V20-T16 is conditional on the bounded single-unit reuse encoding; compositional support is an explicit escape.

## Verification contract

Run:

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
    lake env lean CumulativeAccessibility/VerificationSurface.lean

The advertised v20 theorem surface must compile and the audited output must contain no sorryAx.

## Review outcome classes

A useful review should classify findings as one of:

- formal defect;
- semantic mismatch;
- hidden modelling premise;
- prior-art correction;
- counterexample / universality failure;
- cross-domain mapping failure;
- empirical uncertainty;
- explanatory redundancy;
- interpretation or normative overreach.

This map deliberately separates conditional mathematics from the stronger scientific interpretation offered for falsification.