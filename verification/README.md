# Formal verification

Machine-checked companions to papers and technical results in this repository live here.

## Organizational depth at finite time

[`organizational-depth/`](./organizational-depth/) contains the Lean 4 + Mathlib verification for **“Organizational Depth at Finite Time: A Fixed-Resolution No-Go Boundary.”**

The paper source currently lives at:

`Individual_essays/Organizational Depth at Finite Time.tex`

The verification directory is deliberately self-contained: it has its own pinned Lean toolchain, Lake project, proof source, appendix text, verification report, and an archived independent formalization.


## Independent audit

- [2026-09-15 Lean audit](./audits/2026-09-15-lean-audit.md) — independent build, axiom, vacuity, and exact-witness audit of the four `formalization/` projects, with additional checks of the organizational-depth verification stack.

Headline result: **146 audited declarations, zero errors, zero `sorry`, no vacuous theorem, and independently reproduced exact witnesses.**

## Paper-to-declaration maps

Each recent paper package now contains a `FORMAL_VERIFICATION.md` file mapping manuscript-facing claims to the exact Lean declarations that support them:

- `papers/affinity-before-accessibility/FORMAL_VERIFICATION.md`
- `papers/when-does-change-become-cumulative/FORMAL_VERIFICATION.md`
- `papers/persistence-does-not-measure-function/FORMAL_VERIFICATION.md`
- `papers/when-does-regulation-pay/FORMAL_VERIFICATION.md`
- `papers/when-does-maintenance-debt-stabilize/FORMAL_VERIFICATION.md`
- `papers/sufficient-alignment/FORMAL_VERIFICATION.md`

## Preservation policy

The historical corpus is intentionally left intact. It records the development of the research programme over time; old essays, intermediate formulations, alternative framings, and superseded arguments are evidence of that development and are not removed merely because newer formalizations exist.

Cleanup in this verification layer is therefore additive and traceable: claim-to-declaration maps, audit records, comments clarifying proof assumptions, and corrections to broken current cross-references. Structural refactors that would erase the historical shape of the repository are avoided unless required for correctness.
