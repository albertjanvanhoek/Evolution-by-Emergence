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
| A10 | `protocolR_supercritical_iff` | Exact scalar threshold \(R_{protocol}>1\iff p>1/m\) for \(m>0\). |
| A11 | `expectedCarriers_step`; `supercritical_expected_growth`; `subcritical_expected_decline` | Homogeneous expected-carrier recursion and growth/decline on the two sides of \(R=1\). |
| A13 | `repair_weakly_better_iff`; `repair_strictly_better_iff`; `terminate_strictly_better_if_repair_too_costly` | Exact repair/termination boundary in the one-step model. |
| A15 | `alignmentObjective_gap`; `selectedAlignment_global_max`; `selectedAlignment_reaches_half_iff`; `selectedAlignment_insufficient_if` | Quadratic selected optimum and exact boundary between selected and sufficient alignment in the toy model. |
| A20 | `dyad_canonical_threshold_iff`; `dyad_canonical_witness_positive` | Exact closed-loop product boundary for the declared canonical two-node maintenance witness and positivity of that witness under positive deficit/gain assumptions. |
| A21 | `cycle3_canonical_threshold_iff`; `cycle3_canonical_witness_positive` | Exact three-cycle product boundary for the declared canonical witness and positivity of that witness under positive deficit/gain assumptions. |
| A22 | `cycle3_strict_threshold_gives_growth_witness` | Strict three-cycle loop gain gives an explicit positive state with strict one-step growth at A and exact replacement at B and C. |
| A23 | `deleting_return_edge_makes_source_decline` | With the return edge deleted, a positive subcritical A strictly declines on the next update regardless of C's current state. |

The general Blackwell theorem, general \(k\)-out-of-\(n\) reliability theory, Galton-Watson extinction theorem, repeated-game forgiveness results, and the general Perron-Frobenius / next-generation-matrix threshold for arbitrary nonnegative maintenance networks are prior external mathematics and are not re-proved here.

In particular, the broader maintenance interpretation introduces the normalized matrix

\[
G=(I-R)^{-1}K
\]

and uses the classical external threshold idea \(\rho(G)>1\) for a locally supercritical recurrent maintenance architecture. The current Lean extension does **not** formalize spectral radius, irreducibility, strongly connected components, or the equivalence of that matrix criterion to local growth. It machine-checks only the finite two-node and three-node algebra listed above.

The [15 September 2026 audit](../../verification/audits/2026-09-15-lean-audit.md) independently checked the earlier model formulas, including `majority3Reliability` and the exact half-threshold. The maintenance-reproduction extension postdates that audit and therefore requires its own CI/build evidence.

## Boundary

The formalization supplies conditional network-maintenance results. It does not derive universal moral duties from the English labels “honesty,” “forgiveness,” “love,” or “fear,” nor does it establish that one alignment architecture is optimal for every task. Internal reproduction of a maintenance architecture is also not, by itself, evidence of external epistemic correctness; that remains tied to the declared task-level success functional \(\Gamma_H\).
