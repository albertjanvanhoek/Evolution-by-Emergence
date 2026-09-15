# Formal verification map

This table maps the manuscript-facing claims marked **machine checked** in `CLAIMS.md` to the exact Lean declarations that support them.

Lean source: `formalization/affinity-layer/AffinityLayer.lean`.

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| A4 | `costScore_difference_of_stationary`; `costScore_le_of_stationary` | Exact square-gap identity and global maximality of a positive stationary point under the stated assumptions. |
| A5 | `costAStar_pos`; `costAStar_stationary`; `costAStar_global_max` | Positivity, stationarity, and global optimality of the explicit (a^\star) construction. |
| A6 | `costScore_at_aStar`; `costMargin_at_aStar` | Exact score/margin evaluation at the explicit optimizer. |
| A9 | `turnoverShape_pos`; `turnoverShape_le_one`; `turnoverShape_eq_one_iff` | Positivity, unit ceiling, and equality only at (a=1) for the turnover factor. |
| A10 | `turnoverLambda_le_peak`; `turnoverMass_le_peak` | Peak productive coupling/mass at the turnover optimum. |
| A11 | `turnover_exact_witness` | Exact rational margins at (a=1,1/2,2). |
| A12 | `turnover_exact_two_sided_failure` | Exact reciprocal two-sided failure at (a=1/10) and (a=10). |
| A13 | `turnoverShape_inv`; `turnoverShape_exp_neg` | Reciprocal symmetry and log-affinity symmetry of the minimal turnover law. |

The exact witness theorems were independently recomputed in rational arithmetic in the [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md).

## Boundary

Lean checks the algebraic consequences of the stated model. It does not establish that the reduced affinity/turnover laws are universal microscopic laws or empirically adequate in a particular substrate.
