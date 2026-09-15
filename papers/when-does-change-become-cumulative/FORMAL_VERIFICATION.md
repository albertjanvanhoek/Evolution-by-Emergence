# Formal verification map

This table maps the manuscript-facing claims marked **machine checked** in `CLAIMS.md` to the Lean declarations that support them.

Lean source: `formalization/cumulative-accessibility/CumulativeAccessibility.lean`.

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| C4 | `preservesOn_refl`; `preservesOn_trans`; `strictExpandsOn_trans_preserves`; `preserves_trans_strictExpandsOn`; `strictExpandsOn_trans` | Order-theoretic preservation/click composition. |
| C6 | `scoreDominates_preservesOn`; `strictExpandsOn_of_score_crossing` | Score dominance preserves threshold accessibility; upward crossing gives strict expansion. |
| C7 | `costDominates_preservesOn` | Pointwise cost domination preserves budget-feasible accessibility. |
| C8 | `exists_strictCostDominatingStep` | Existence of a strict cost-dominating step. |
| C9 | `exact_productive_extension_strictly_dominates`; `exact_productive_extension_winds_margin` | Exact rational productive-extension inequalities and margin winding for the formal witness. |
| C10 | `not_costDominates_scaled` | Positive uniform dilution cannot pointwise dominate a positive inherited cost. |
| C11 | `retainsCostOn_scaled_iff_margin` | Exact retention threshold under uniform scaling. |
| C12 | `margin_ratio` | Exact ratio identity for (1+M). |
| C13 | `margin_update`; `winds_iff_binding_cost_falls` | Margin update under a multiplicative cost change and exact winding criterion. |
| C13a | `margin_dilute` | Exact one-step dilution recursion. |
| C14 | `margin_increase_opens_coupling_window`; `coupling_between_margins_switches_retention` | Nonempty opened interval and before/after retention switch. |
| C15 | `production_increase_opens_threshold_window` | Exact nonempty production-threshold interval. |
| C16 | `exact_two_click_witness` | Exact strict repertoire chain ({A,B}\subsetneq{A,B,C}\subsetneq{A,B,C,D}). |
| C17 | `exact_second_click_unavailable_at_baseline` | Exact baseline failure of the direct second click. |
| C18 | `exact_first_click_winds`; `exact_second_coupling_in_opened_window` | Exact first-click margin winding and opened coupling interval. |
| C19 | `exact_second_threshold_in_opened_window` | Exact second-stage production-threshold witness. |
| C20 | `routeDominatesOn_refl`; `routeDominatesOn_trans`; `routeDominates_preservesOn`; `strictExpandsOn_of_new_route` | Route-dominance order properties and accessibility preservation/expansion. |
| C24 | `accepted_fraction_margin_positive` | A strict fractional load of positive current margin leaves positive margin. |
| C28 | `acceptedAtSlack_mono`; `acceptedAtZero_iff_nonpositive`; `spending_rejected_at_zero`; `winding_accepted_at_nonnegative_slack` | Exact deterministic acceptance filter in log-slack coordinates. |

The audit independently recomputed `exact_two_click_witness` and `exact_second_click_unavailable_at_baseline` and found no vacuity; see the [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md).

## Boundary

The Lean file formalizes the declared accessibility/cost objects and exact witnesses. It does not prove the full production-network ODE/eigenvalue derivation, the stochastic long-run propositions not marked machine checked, or a universal direction of evolution.
