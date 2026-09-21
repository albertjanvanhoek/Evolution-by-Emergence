# Formal verification map

This file maps the claims made in the three analytical documents to exact declarations in `TheRoom.lean`.

**Checked toolchain:** Lean 4.34.0.

**Permanent CI:** `.github/workflows/learning-constitution-check.yml`.

## 1. The Room: incompatible certainty

| Prose claim | Lean declaration | Status |
|---|---|---|
| Pairwise incompatible propositions cannot contain two truths. | `TheRoom.pairwise_incompatible_at_most_one` | Machine checked |
| With three pairwise incompatible propositions, at least two are false. | `TheRoom.pairwise_incompatible_at_least_two_false` | Machine checked |
| Two agents certain of incompatible propositions cannot both be truth-guaranteed. | `TheRoom.incompatible_certainties_no_joint_truth_guarantee` | Machine checked |
| Under same standing plus an explicit no-privileged-truth-access premise, neither peer receives a unilateral truth guarantee. | `TheRoom.same_standing_blocks_either_infallibility` | Machine checked conditional implication |

The last row is intentionally conditional. Pure incompatibility alone does not prove symmetric fallibility; the bridge premise is explicit.

## 2. Interdependence

| Prose claim | Lean declaration | Status |
|---|---|---|
| Different exclusive requirements leave no mutually acceptable shared outcome. | `Interdependence.incompatible_exclusive_requirements_block_shared_acceptance` | Machine checked |

This theorem does not determine which requirement is correct or which outcome should govern.

## 3. Corrective routes

| Prose claim | Lean declaration | Status |
|---|---|---|
| Permanent source exclusion blocks every corrective route from that source under the declared route model. | `Correctability.permanent_exclusion_blocks_corrective_route` | Machine checked |
| If a source is potentially corrective but permanently excluded, the declared source-robust correctability property fails. | `Correctability.possible_correction_plus_exclusion_breaks_robust_correctability` | Machine checked |

These results are definition-sensitive. They do not prove that direct access by every source is necessary when information can reach the system through redundant routes.

## 4. The Learning Constitution

The local constitutional predicate is `LearningConstitution.HoldsAt`. It contains five declared clauses:

- `challenge_access`
- `reopen_on_grounds`
- `standing_symmetry`
- `restriction_correctable`
- `exclusion_appealable`

These are proposed design conditions, not theorems derived from logic alone.

| Prose claim | Lean declaration | Status |
|---|---|---|
| A constitution satisfying the declared restriction-correctability clause blocks self-sealing restrictions on affected agents. | `LearningConstitution.constitution_blocks_self_sealing_restriction` | Machine checked |
| The declared constitution blocks unappealable exclusion of affected agents. | `LearningConstitution.constitution_blocks_unappealable_exclusion` | Machine checked |
| If the constitution holds initially and every allowed step preserves it, it holds in every reachable state. | `LearningConstitution.constitution_is_reachable_invariant` | Machine checked |
| Under the same preservation assumptions, no reachable state contains a self-sealing restriction on an affected participant. | `LearningConstitution.no_reachable_self_sealing_restriction` | Machine checked |

## 5. Formal / normative firewall

Lean checks the deductive statements above. Lean does not prove:

```text
correctability -> moral obligation
correctability -> legal right
procedural symmetry -> identical legal weight
source access -> equal credibility
appealability -> endless reopening
learning constitution -> guaranteed truth
```

The paper `procedural_corrigibility_human_rights.tex` is therefore a **candidate legal translation**, not a theorem corollary.
