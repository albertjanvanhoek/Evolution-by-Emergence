# Formal verification map

This table maps manuscript-facing machine-checked claims to the exact Lean declarations that support them.

Primary sources:
- `formalization/persistence-drift/EquilibriumExposure.lean`
- `formalization/persistence-drift/FunctionalThresholds.lean`

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| C2 | `r_star_strictly_decreases`; `x_star_strictly_increases` | The relevant monotonicities of equilibrium replacement rate and maintained mass with efficiency/spectral scale. |
| C8 | `hollowing_threshold_iff_cubic`; `hollowB_strictly_decreases_on_physical_branch` | Exact threshold algebra and monotonic hollowing component used in the worked counterexample. The numerical crossing value remains a worked calculation outside this theorem statement. |
| C9 | `homogeneous_margin_under_uniform_dilution`; `extraction_margin_eq` | Exact degree-one homogeneous margin transformation under uniform dilution. |
| C10 | `extraction_viable_iff`; `extraction_margin_zero_at_budget`; `single_channel_extraction_threshold` | Exact viability threshold and critical extraction/load boundary. |

### Audit note on C8

The independent audit found that `hollowB_strictly_decreases_on_physical_branch` is mathematically stronger than stated: the proof does not need the upper physical-branch hypothesis `lambda2^2 < 2`. That hypothesis is intentionally retained to keep the theorem statement aligned with the manuscript's (0\le f<1) interpretation, and is now annotated in the Lean source.

See the [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md).

## Boundary

Machine verification certifies deductions from the declared capacity and production models. It does not validate the empirical choice of functional thresholds or establish that persistence and function are generally negatively related.
