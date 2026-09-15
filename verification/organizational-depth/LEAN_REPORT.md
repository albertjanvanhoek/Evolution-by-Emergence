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

The historical final-proofread build compiled `OrganizationalDepth` and `OperationalBridge` successfully in the pinned environment. The current project additionally builds `PackingDepth.lean`, which was independently supplied during the 15 September 2026 two-factor re-audit.

## Operational bridge

The companion `OperationalBridge.lean` verifies the purely mathematical bridge for finite-state measurement channels:

- `l1_push_le`
- `dTV_push_le`
- `dTV_push_idChannel`
- `speed_limit_operational`
- `operational_fixed_resolution`
- `pairwise_separated_adjacent`
- `pairwise_depth_resource_bound`

The Markov-jump speed limit `2 dTV^2 <= Sigma * Nact` remains a hypothesis in Lean; the file checks the data-processing comparison and its transfer to the operational counting result.

The original bridge-inclusive development was re-checked in the final proofread verification run `34742856500`. The 15 September 2026 depth correction adds a machine-checked finite-prefix bound for pairwise-separated retained representatives. Current CI rebuilds the expanded theorem stack.

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


## Retained packing-depth correction

A post-hoc tightness audit showed that the consecutive fixed-resolution count can be saturated by a two-state shuttle and therefore should not itself be called organizational depth. The corrected manuscript defines retained packing depth as the largest pairwise-separated retained repertoire visited at resolution delta.

`OperationalBridge.lean` now proves the finite-prefix resource implication:

- `pairwise_separated_adjacent`
- `pairwise_depth_resource_bound`

If `k+1` chronological retained representatives are pairwise delta-separated, then the `k` gaps between them obey

```text
k * delta <= sqrt(SigTot * NactTot / 2).
```

Equivalently, the retained depth satisfies
`D_delta <= 1 + delta^-1 * sqrt(SigTot*NactTot/2)`.

The separate finite-dimensional simplex packing bound is standard geometry and is not machine-formalized here.

## Numerical tightness audit

`tightness/` contains an analytic and numerical stress test. It confirms that the SFS transition bound is asymptotically sharp and that both a two-state shuttle and an interior finite-state ring can approach saturation. This demonstrates that transition-bound saturation is neutral about retained depth.


## Independent two-factor module

`PackingDepth.lean` provides a second, independent formalization of the current depth theorem in namespace `OrgDepth`.

It machine-checks:

- `gap_sum_le` — the finite-block Cauchy--Schwarz resource bound;
- `packing_depth_thermo` — the thermodynamic factor;
- `packing_depth_two_factor` — conjunction with an externally supplied geometric packing ceiling;
- `depth_le_of_budget_ceiling` — a non-vacuous uniform ceiling formulation;
- `packing_depth_thermo_witness` and `packing_depth_thermo_sharp` — explicit satisfiable/equality witnesses.

The speed-limit premise and the geometric packing-number theorem for a specific state space remain hypotheses/external mathematics rather than being smuggled into Lean.

The independent source package that produced this module is archived at `audits/2026-09-15-two-factor/`.
