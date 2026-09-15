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

## Literature and novelty audit

- [2026-09-15 literature audit package](./audits/2026-09-15-literature/) — two adversarial literature audits, the repository's response, and the framing note [From synthesis to paradigm](./audits/2026-09-15-literature/FROM_SYNTHESIS_TO_PARADIGM.md).

The audits converge on a conservative status: most component mechanisms have substantial antecedents, so the recent stack is better presented as a **synthesis/research architecture with exact model-specific results** than as a collection of new general theorems. The audits are preserved as dated judgments rather than treated as exhaustive proof of priority.

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


## Import and package policy

The recent `formalization/` sources use targeted Mathlib imports rather than the root `import Mathlib`, so a sceptical reader can compile a focused project without requiring the entire Mathlib import surface.

The four formalization projects remain separate Lake packages. The audit correctly notes that a unified workspace could reduce repeated dependency checkout cost, but this cleanup deliberately does **not** collapse them: the separate packages document how the formal work was developed and keep the historical repository structure intact. This is an auditability-versus-provenance tradeoff made explicitly rather than accidentally.
