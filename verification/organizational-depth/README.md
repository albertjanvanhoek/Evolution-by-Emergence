# Lean verification — Organizational Depth at Finite Time

Machine-checked companion to **“Organizational Depth at Finite Time: A Fixed-Resolution No-Go Boundary.”**

## Canonical source

- `OrganizationalDepth.lean` — canonical theorem stack used by the paper.
- `appendix/appendix_lean.tex` — paper-ready Appendix A.
- `LEAN_REPORT.md` — verification scope and environment.
- `compile_output.txt` — captured successful build and axiom audit.
- `archive/FixedResolution.lean` — an earlier independently developed formalization of the same core, retained as a cross-check rather than used as the canonical source.

## What is machine-checked

The canonical development verifies:

1. material accounting implies a realization-count bound;
2. `lambda_n = N_n * nu_n * p_n` is uniformly bounded under the paper's stated assumptions;
3. a uniformly bounded positive rate sequence has a nonsummable reciprocal series;
4. the weighted finite-action theorem;
5. the finite-action theorem under a positive kinetic floor `c_* <= c_n`;
6. the fixed-resolution counting bound and finiteness consequence.

The variable-coefficient bridge used by the manuscript is explicit in Lean:

- `finite_action_of_kinetic_floor`
- `fixed_resolution_count_of_kinetic_floor`
- `fixed_resolution_finite_of_kinetic_floor`

## Scope

This verifies the **conditional mathematics only**. It does not validate:

- the physical applicability of `eps_n * tau_n >= c_n * d_n^2`;
- the identification of physical distance with operational distinguishability;
- whether `eps_n` is the correct cumulatively charged physical cost;
- the classical pure-birth explosion theorem itself;
- the physical additivity assumption behind the material-to-count step.

Accordingly, the correct paper claim is:

> The mathematical core of the no-go argument was independently formalized and machine-checked in Lean.

It is **not** a formal verification of the physical theory as a whole.

## Reproduce

From this directory:

```bash
lake update
lake exe cache get
lake build
```

Pinned environment:

- Lean `4.33.0` (`leanprover/lean4:v4.33.0`)
- Mathlib commit `db584cd6d46c92f209a44c0f1c829460d327499d`

A successful canonical CI run before repository reorganization was GitHub Actions run `34739508434`, project commit `52eae06e3a19af6f041c16ff00a98e165eeff3de`. The workflow in this repository re-runs the same checks from this directory on subsequent changes.
