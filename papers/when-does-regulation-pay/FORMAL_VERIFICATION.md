# Formal verification map

This table maps manuscript-facing machine-checked claims to the exact Lean declarations that support them.

Lean source: `formalization/persistence-drift/RegulatoryReturn.lean`.

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| R3 | `margin_nonneg_iff_load_le` | Exact equivalence between nonnegative functional margin and the load/control inequality. |
| R5 | `deltaGrowth_factor` | Exact factorization of regulatory advantage in the linear model. |
| R6 | `deltaGrowth_nonpos_of_returnGap_nonpos` | Nonpositive return when the declared return-gap condition is nonpositive. |
| R7 | `reducedRegulatoryCost_sub_at_stationary`; `reducedRegulatoryCost_min_of_stationary`; `growthObjective_le_of_stationary`; `stationarity_rearrangement` | Exact square-gap/global-optimum certificate around a stationary denominator in the linear model. |
| R15 | `boundaryDerivative_scaled`; `boundaryDerivative_nonpos_iff_alignment`; `alignment_iff_netMarginalValue` | The local boundary algebra linking functional alignment to the net marginal-value condition. The manuscript's concavity assumptions remain analytic assumptions, not encoded as a generic calculus theorem here. |
| R16 | `alignment_iff_netMarginalValue` together with the manuscript definition of effective penalty (Psi') | Exact rearrangement of the local alignment condition. |

### Audit note on R7

The audit found that `reducedRegulatoryCost_sub_at_stationary` does not mathematically need the hypothesis `d0 ≠ 0`; it is retained because the paper's stationary-denominator interpretation is positive/nonzero. The Lean source now says this explicitly and suppresses only that intentional unused-variable warning.

See the [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md).

## Boundary

The formalization checks the stated scalar model. It does not establish a universal theory of biological regulation, nor does it formalize every analytic concavity assumption in the generalized model.
