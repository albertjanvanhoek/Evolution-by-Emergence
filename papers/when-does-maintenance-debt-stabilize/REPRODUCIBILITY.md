# Reproducibility

## Lean sources

The relevant project is verification/organizational-depth.

Primary files:

- MaintenanceDynamics.lean
- MaintenanceDynamicsEndToEnd.lean

Run:

    cd verification/organizational-depth
    lake build

The GitHub workflow Lean organizational-depth verification runs the same project in CI.

## Key declarations

Core algebra and threshold:

- cycle_average_balances
- mean_maintenance_debt_zero
- debt_stability_rewrite
- debt_stability_lhs_monotone
- debt_stability_upward_closed
- criticalY_nonneg
- criticalY_root
- stable_above_criticalY
- stable_above_criticalGamma

End-to-end checks:

- debtXFlow_dx_at_equilibrium
- debtXFlow_dK_at_equilibrium
- debtXFlow_dh_at_equilibrium
- debtKFlow_partials
- debtHFlow_partials
- cubic_hurwitz_root_negative
- debtCharMatrix_det
- debt_jacobian_hurwitz
- critical_gain_implies_jacobian_hurwitz
- hasDerivAt_logit_of_maintenance
- periodic_maintenance_cycle_averages
- maintenance_equilibrium_balances
- maintenance_equilibrium_flow_zero
- maintenance_equilibrium_has_jacobian
- maintenance_end_to_end_spectral

## What Lean checks

The formalization checks the equilibrium balances, nonlinear coordinate derivatives, Jacobian transcription, explicit characteristic determinant, cubic root-location theorem, critical threshold, monotonicity in debt-response gain, and the periodic-average identities derived from the base ODE by the fundamental theorem of calculus.

The CI axiom audit contains no `sorryAx`; the reported declarations depend only on the standard Lean/Mathlib axioms shown by `#print axioms` (`propext`, `Classical.choice`, and `Quot.sound`).

## What Lean does not check

The formalization does not establish empirical applicability, global stability, existence of a periodic orbit, the full nonlinear Hopf theorem, or the generic \(C^1\) linearization theorem from a Hurwitz Jacobian to local asymptotic stability.

## Numerical worked example

Run:

    python papers/when-does-maintenance-debt-stabilize/verify_maintenance_dynamics.py

For
\[
\alpha=1,\quad c=0.2,\quad a=1,\quad \delta=\varepsilon=0.2,
\]
the script reproduces
\[
h^*=K^*=0.8,\qquad x^*=0.16,\qquad b=0.1344,
\]
and
\[
\gamma_{\rm crit}=0.595238095238\ldots
\]

## Proof commit

The complete proof + paper state was verified at commit `7de2a573eb5bb9de0fbe6724210801800d66a12d`.

GitHub Actions workflow run: `34935524688`  
Job: `104272464669`

That run passed:

- Lean 4.33.0 installation;
- pinned Mathlib resolution;
- `lake build`, including `maintenance_end_to_end_spectral`;
- the worked numerical reproduction script;
- the axiom audit with no `sorryAx`.

Subsequent commits before merge are documentation-only unless explicitly noted.
