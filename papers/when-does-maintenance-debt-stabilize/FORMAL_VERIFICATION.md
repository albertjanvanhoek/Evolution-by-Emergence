# Formal verification map

This table maps manuscript-facing machine-checked claims to exact Lean declarations.

Primary sources:
- `verification/organizational-depth/MaintenanceDynamics.lean`
- `verification/organizational-depth/MaintenanceDynamicsEndToEnd.lean`

| Claim | Lean declaration(s) | What is machine checked |
|---|---|---|
| M1 | `maintenance_equilibrium_balances`; `maintenance_equilibrium_flow_zero` | Exact interior equilibrium identities and zero nonlinear flow at the stated equilibrium. |
| M2 | `debtCharMatrix_det` specialized to (gamma=0) | Exact debt-aware characteristic determinant; the base polynomial is its zero-debt-sensitivity specialization. |
| M6 | `periodic_maintenance_cycle_averages` | Periodic average identities derived directly from the ODE using derivatives/FTC. |
| M9 | `maintenance_equilibrium_balances`; `maintenance_equilibrium_flow_zero` | Equilibrium location remains unchanged when debt sensitivity is added because debt vanishes at equilibrium. |
| M10 | `debtXFlow_dx_at_equilibrium`; `debtXFlow_dK_at_equilibrium`; `debtXFlow_dh_at_equilibrium`; `debtKFlow_partials`; `debtHFlow_partials`; `maintenance_equilibrium_has_jacobian` | Coordinate derivatives of the nonlinear flow and assembled Jacobian at equilibrium. |
| M11 | `debtCharMatrix_det` | Exact characteristic determinant/polynomial identity. |
| M13 | `criticalY_nonneg`; `criticalY_root` | Exact critical-(y) root and nonnegativity statement. |
| M14 | `stable_above_criticalGamma`; `critical_gain_implies_jacobian_hurwitz`; `maintenance_end_to_end_spectral` | Critical-gain implication through equilibrium, Jacobian, characteristic determinant, and negative real parts of roots. |
| M15 | `debt_stability_lhs_monotone`; `debt_stability_upward_closed` | Monotonicity/upward closure of the stability-side expression. |

The formalization stops at the spectral endpoint; the generic nonlinear theorem that a Hurwitz Jacobian implies local asymptotic stability under the usual smoothness assumptions is external to this Lean development.

## Boundary

Lean verifies the model-to-spectrum mathematics and periodic-average identities. It does not establish that maintenance debt is the correct empirical state variable for any particular real system.
