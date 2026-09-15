# Response to the 15 September 2026 Lean audit

This file records the repository changes made in response to the independent audit preserved at [2026-09-15-lean-audit.md](2026-09-15-lean-audit.md).

The cleanup is intentionally **surgical**. The historical corpus is not being pruned or rewritten: earlier essays, intermediate models, superseded formulations, and old development paths are part of the provenance of a research programme developed over approximately 1.5 years.

| Audit item | Response | Repository action |
|---|---|---|
| Three unused hypotheses | Accepted | Retained where they encode manuscript interpretation/interface consistency; each is now explicitly commented, and the local unused-variable linter warning is suppressed only around that declaration. |
| 4.1 No paper-to-declaration mapping | Implemented | Added `FORMAL_VERIFICATION.md` to each of the six recent paper packages, mapping every manuscript-facing machine-checked ledger claim to exact Lean declaration names. Each `CLAIMS.md` and paper `README.md` links directly to its map. |
| 4.2 Inconsistent “Lean checked” / “machine checked” wording | Implemented | Standardized the sufficient-alignment ledger to **machine checked**, matching the rest of the corpus. |
| 4.3 Blanket `import Mathlib` | Implemented for the four audited `formalization/` projects | Replaced root imports with targeted Mathlib modules plus `Mathlib.Tactic` where needed. Existing project CI rebuilds the packages. |
| 4.4 Four separate Lake packages | Intentionally not changed | A unified workspace could reduce repeated dependency checkout cost, but the separate packages are retained as development provenance and to avoid restructuring historical work. This tradeoff is documented in `verification/README.md`. |
| Four dead organizational-depth appendix cross-references | Implemented | Removed the stale theorem/corollary-number parentheticals while preserving the correct A.3–A.6 appendix structure and declaration descriptions. |
| Audit correction concerning `finite_action_of_kinetic_floor` | Preserved | No theorem change was required; the audit record explicitly retracts the earlier criticism and confirms the committed theorem matches the appendix. |
| Exact witness/vacuity audit | Preserved as evidence | The independent recomputation and no-vacuity findings are archived unchanged in the audit record. |

## Resulting external check path

A sceptical reader can now take a claim such as `C16` and follow:

```text
papers/.../CLAIMS.md
    -> FORMAL_VERIFICATION.md
        -> exact Lean declaration name
            -> targeted-import Lean source
                -> package lakefile / pinned Mathlib
                    -> CI
```

This changes the role of the repository from “the author says the mathematics was machine checked” to “the machine-check claim has an explicit, reproducible path that another reader can inspect.”

## Preservation boundary

No historical essay, intermediate conceptual formulation, earlier book chapter, or old research-development artifact was removed as part of this cleanup.

The cleanup changes only current verification/routing material, current formalization imports/comments, explicit audit mappings, and broken cross-references.
