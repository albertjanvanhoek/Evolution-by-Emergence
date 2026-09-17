# Formal verification map

This table maps manuscript-facing machine-checked claims to exact Lean declarations.

Lean sources:

- `formalization/collective-alignment/CollectiveAlignment.lean`
- `formalization/collective-alignment/MaintenanceReproduction.lean`

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| A2 | `garbled_policy_lifts_exactly`; `ungarbled_can_match_any_garbled_policy` | Every policy using a deterministic garbling can be value-matched after observing the original signal. |
| A6 | `majority3_monotone` | Monotonicity of 2-out-of-3 reliability on the probability interval. |
| A7 | `majority3_half_threshold` | Exact half-viability threshold. |
| A8 | `majority3_redundancy_gain` | Strict redundancy gain for \(1/2<p<1\). |
| A10 | `protocolR_supercritical_iff` | Exact scalar threshold \(R_{\rm protocol}>1\iff p>1/m\) for \(m>0\). |
| A11 | `expectedCarriers_step`; `supercritical_expected_growth`; `subcritical_expected_decline` | Homogeneous expected-carrier recursion and growth/decline on the two sides of \(R=1\). |
| A13 | `repair_weakly_better_iff`; `repair_strictly_better_iff`; `terminate_strictly_better_if_repair_too_costly` | Exact repair/termination boundary in the one-step model. |
| A15 | `alignmentObjective_gap`; `selectedAlignment_global_max`; `selectedAlignment_reaches_half_iff`; `selectedAlignment_insufficient_if` | Quadratic selected optimum and exact boundary between selected and sufficient alignment in the toy model. |
| A20 | `dyad_threshold_fixed_point`; `dyad_supercritical_witness`; `dyad_subcritical_witness` | Exact dyadic product boundary and explicit fixed/growing/declining algebraic witness. |
| A21 | `triad_threshold_fixed_point`; `triad_supercritical_witness`; `triad_subcritical_witness` | Exact directed-three-cycle product boundary and explicit fixed/growing/declining algebraic witness. |
| A22 | `delete_return_edge_makes_A_autonomous`; `one_way_dyad_characteristic_factor` | Deleting the return edge removes A's cross-maintenance term; a one-way dyad has no closed-loop characteristic cross term. |

The general Blackwell theorem, general \(k\)-out-of-\(n\) reliability theory, Galton-Watson extinction theorem, repeated-game forgiveness results, and the arbitrary-network Perron-Frobenius / M-matrix maintenance threshold are prior external mathematics and are not re-proved here.

In particular, the general statement based on

\[
G=(I-R)^{-1}K
\]

and the threshold \(\rho(G)=1\) is currently an externally grounded extension of the small-network Lean module. The present machine-checked contribution stops at explicit polynomial witnesses for the dyad and directed triad, plus the edge-deletion identities listed above.

The [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md) independently checked the earlier model formulas, including `majority3Reliability` and the exact half-threshold. The maintenance-reproduction module postdates that audit and requires its own CI proof state before being described as verified on `main`.

## Boundary

The formalization supplies conditional network-maintenance results. It does not derive universal moral duties from English labels such as “honesty,” “forgiveness,” “love,” or “fear,” nor does it establish that one alignment architecture is optimal for every task. It also does not establish that persistence of a network is desirable: maintenance reproduction must remain distinguished from externally validated adaptive performance.
