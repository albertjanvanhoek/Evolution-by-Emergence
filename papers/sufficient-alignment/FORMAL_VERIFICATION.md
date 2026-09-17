# Formal verification map

This table maps manuscript-facing machine-checked claims to exact Lean declarations.

Lean sources:

- `formalization/collective-alignment/CollectiveAlignment.lean`
- `formalization/collective-alignment/CollectiveAlignment/MaintenanceReproduction.lean`

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| A2 | `garbled_policy_lifts_exactly`; `ungarbled_can_match_any_garbled_policy` | Every policy using a deterministic garbling can be value-matched after observing the original signal. |
| A6 | `majority3_monotone` | Monotonicity of 2-out-of-3 reliability on the probability interval. |
| A7 | `majority3_half_threshold` | Exact half-viability threshold. |
| A8 | `majority3_redundancy_gain` | Strict redundancy gain for \(1/2<p<1\). |
| A10 | `protocolR_supercritical_iff` | Exact scalar threshold \(R_{protocol}>1\iff p>1/m\) for \(m>0\). |
| A11 | `expectedCarriers_step`; `supercritical_expected_growth`; `subcritical_expected_decline` | Homogeneous expected-carrier recursion and growth/decline on the two sides of \(R=1\). |
| A13 | `repair_weakly_better_iff`; `repair_strictly_better_iff`; `terminate_strictly_better_if_repair_too_costly` | Exact repair/termination boundary in the one-step model. |
| A15 | `alignmentObjective_gap`; `selectedAlignment_global_max`; `selectedAlignment_reaches_half_iff`; `selectedAlignment_insufficient_if` | Quadratic selected optimum and exact boundary between selected and sufficient alignment in the toy model. |
| A20 | `dyadMaintenanceRatio_supercritical_iff`; `dyad_open_loop_ratio_zero`; `dyad_open_loop_not_supercritical` | Exact two-process closed-loop product threshold and zero reproduction ratio when the return path is open. |
| A21 | `triadMaintenanceRatio_supercritical_iff`; `triad_open_loop_ratio_zero` | Exact three-process directed-cycle product threshold and collapse of the simple closed-loop ratio when the return edge is removed. |
| A22 | `triad_supercritical_with_all_induced_dyads_open`; `cycleDeficit_pos`; `cycleMaintenanceRatio_supercritical_iff` | An exact three-agent witness where the full triad is super-unit although every induced dyad is open-loop, plus the finite directed-cycle product threshold. |

The general Blackwell theorem, general \(k\)-out-of-\(n\) reliability theory, Galton-Watson extinction theorem, repeated-game forgiveness results, and the arbitrary-network Perron--Frobenius / next-generation-matrix spectral-radius threshold are prior external mathematics and are not re-proved here.

The [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md) independently checked the earlier model formulas and declarations. The maintenance-reproduction additions post-date that audit and therefore require a fresh CI/build result before they should be described as independently audited.

## Boundary

The formalization supplies conditional network-maintenance results. It does not derive universal moral duties from English labels such as “honesty,” “forgiveness,” or “love,” nor does it establish that one alignment architecture is optimal for every task. The maintenance-reproduction module also deliberately separates the machine-checked finite-cycle algebra from the broader classical spectral-radius theorem for arbitrary nonnegative networks.
