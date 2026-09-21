# The Room and the Learning Constitution

A self-contained four-document sequence about fallible interdependent agents, correctability, and one possible human-rights translation.

## Reading order

1. **[The Room](the_room_problem.pdf)** — the problem.
2. **[The Learning Constitution](the_learning_constitution.pdf)** — the logical/systemic solution.
3. **[Freedom of Conscience and the Right to a Correctable Process](procedural_corrigibility_human_rights.pdf)** — a possible legal translation.
4. **[The Elephant and the Agreement](the_elephant_and_the_agreement.pdf)** — an accessible parable about autonomy and interdependence.

The formal backbone for the first two papers is **[TheRoom.lean](TheRoom.lean)**.

## Core sequence

```text
incompatible sincere certainty
    -> certainty is not a truth guarantee
    -> interdependent incompatible requirements need procedure
    -> a correctable process must preserve routes of correction
    -> restrictions on corrective access must themselves remain correctable
    -> the correction mechanism must itself remain correctable
```

The human-rights paper then asks a separate normative question: whether and how this logical architecture should be protected in law.

## Machine-checked scope

`TheRoom.lean` is checked with Lean 4.34.0 by the repository workflow
`.github/workflows/learning-constitution-check.yml`.

The exact prose-to-Lean map is in **[FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md)**.

Machine checking establishes implications under declared definitions and assumptions. It does **not** establish that:

- the Learning Constitution is the unique or universally minimal architecture for learning;
- every human disagreement instantiates the formal model;
- every source must always be heard;
- all claims deserve equal evidential weight;
- every exclusion is illegitimate;
- a correctable process guarantees truth;
- the proposed human-rights article follows from logic alone.

## Review targets

High-value criticism includes:

1. Does the formalization smuggle the desired conclusion into its definitions?
2. Is `NoPrivilegedTruthAccess` the right explicit bridge from incompatible certainty to symmetric fallibility?
3. Is source-based correctability too strong where corrective information can travel through redundant channels?
4. Are challenge, reopening, appeal, and revision the right constitutional primitives?
5. Is `ConstitutionPreserved` a useful invariant rather than merely a restatement of the design goal?
6. Does the legal translation overreach beyond what the formal argument supports?
7. Is an existing legal or philosophical doctrine already an equal-or-stronger formulation?

The package is intended to remain corrigible: narrowing, counterexamples, stronger antecedents, or replacement by a cleaner formalism are useful review outcomes.
