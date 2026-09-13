# Formalization report — fixed-resolution no-go paper

## Status

**PASS.** The canonical Lean development compiled successfully in GitHub Actions from a pinned project environment.

- Lean: `4.33.0`, commit `d8b18978322de05a8f3dba51ef03cf5461676c17`
- Lake: `5.0.0-src+d8b1897`
- Mathlib: `db584cd6d46c92f209a44c0f1c829460d327499d` (10 August 2026)
- source: `OrganizationalDepth.lean`
- final proofread verification commit: `318df0da76c2ae94fa33f7b74c806b8e8451e55d`
- final proofread GitHub Actions run: `34742856500`

CI commands:

```bash
lake update
lake exe cache get
lake build
```

The final proofread build compiled both `OrganizationalDepth` and `OperationalBridge` successfully in the pinned environment.

## Operational bridge

The companion `OperationalBridge.lean` verifies the purely mathematical bridge for finite-state measurement channels:

- `l1_push_le`
- `dTV_push_le`
- `dTV_push_idChannel`
- `speed_limit_operational`
- `operational_fixed_resolution`

The Markov-jump speed limit `2 dTV^2 <= Sigma * Nact` remains a hypothesis in Lean; the file checks the data-processing comparison and its transfer to the operational counting result.

The bridge-inclusive development was re-checked unchanged in the final proofread verification run `34742856500`.

## Canonical theorem stack

1. `realizations_le_of_material`
2. `rate_le`
3. `sum_inv_rate_ge`
4. `not_summable_inv_rate`
5. `stochastic_route_closed`
6. `weighted_finite_action`
7. `finite_action`
8. `finite_action_of_kinetic_floor`
9. `fixed_resolution_count`
10. `fixed_resolution_finite`
11. `fixed_resolution_count_of_kinetic_floor`
12. `fixed_resolution_finite_of_kinetic_floor`

The three `*_of_kinetic_floor` declarations close the statement-to-code seam between the manuscript hypothesis
`c_n >= c_* > 0` with `c_n d_n^2 <= eps_n tau_n`
and the constant-coefficient helper inequality
`c_* d_n^2 <= eps_n tau_n`.

## Axiom audit

`#print axioms` is part of the compiled source. Every audited result reports only:

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorry` in the canonical source.

## Scope boundary

The formalization verifies conditional mathematical implications. It does **not** formalize or validate the physical speed-distance law, the charged-cost interpretation, the continuous-time pure-birth theorem, or material additivity in a concrete physical system. The finite-state total-variation-to-operational measurement-channel bridge is formalized in `OperationalBridge.lean`; no universal bridge for arbitrary physical metrics is claimed.

The archived `FixedResolution.lean` was independently developed before adoption of the canonical file. It is retained only as a useful cross-check; manuscript theorem names should refer to `OrganizationalDepth.lean`.
