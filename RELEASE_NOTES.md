# Evolution by Emergence v18 — The Learning Constitution: Correctable Interdependence

`v18` adds a separate machine-checked companion to the v17 Recursive Organization Core.

The new question is:

> **What minimal procedural architecture prevents fallible interdependent agents from making their own possible error structurally uncorrectable?**

The release does **not** change the canonical v17 recursive-organization theorems. It adds a focused formal and conceptual layer about incompatible certainty, corrective routes, self-sealing restrictions, and preservation of a declared learning constitution.

## 1. Release object

Start with:

1. `papers/the-room-learning-constitution/README.md` — reviewer entry, reading order, and scope.
2. `papers/the-room-learning-constitution/the_room_problem.pdf` — **The Room**: the fundamental problem.
3. `papers/the-room-learning-constitution/the_learning_constitution.pdf` — **The Learning Constitution**: the logical/systemic solution.
4. `papers/the-room-learning-constitution/FORMAL_VERIFICATION.md` — exact paper-to-Lean traceability.
5. `papers/the-room-learning-constitution/TheRoom.lean` — machine-checked formal backbone.
6. `papers/the-room-learning-constitution/procedural_corrigibility_human_rights.pdf` — candidate human-rights translation.
7. `papers/the-room-learning-constitution/the_elephant_and_the_agreement.pdf` — accessible parable.
8. `papers/the-room-learning-constitution/CLAIMS.md` — local claims and non-claims.

The `.tex` sources for all four standalone documents are committed beside the PDFs.

## 2. The Room: the problem

The formal starting point is deliberately small.

If several propositions are pairwise incompatible, they cannot all be true. If agents are certain of incompatible propositions, their certainties cannot all carry a truth guarantee.

The formal layer keeps an important bridge explicit:

```text
incompatible certainty
does not by itself imply
symmetric individual fallibility.
```

To block identity-based self-exemption, the model declares same relevant standing plus a `NoPrivilegedTruthAccess` premise.

This yields a disciplined conclusion:

> **certainty alone is not a truth certificate.**

## 3. Interdependence

When convictions imply incompatible exclusive requirements for one shared outcome, there may be no mutually acceptable substantive result.

The formalization does not decide which participant is correct or which outcome should prevail. It isolates the need for a procedure when incompatible private models have shared consequences.

The key separation is:

```text
freedom of conviction
!=
unreviewable shared authority.
```

## 4. Corrective routes

The correctability layer distinguishes:

```text
evidence that could correct a state
from
evidence that the current procedure admits.
```

Under the declared source-robust correctability model:

```text
potentially corrective source
+ permanent source exclusion
-> failure of source-robust correctability.
```

This is a conditional theorem under the stated source-based route definition. It does not prove that every source requires direct access when equivalent information can travel through redundant or independent channels.

## 5. The Learning Constitution

The local constitutional predicate `LearningConstitution.HoldsAt` declares five conditions:

1. **challenge access** for affected, non-excluded participants;
2. **reopening on recognized grounds for review**;
3. **standing symmetry** in the basic capacity to challenge shared claims;
4. **correctability of restrictions** on affected participants;
5. **appealability of exclusion**.

These clauses are proposed design conditions. Lean does not derive them from pure logic.

Given those clauses, Lean proves that affected participants cannot be subject to a **self-sealing restriction**: a restriction that simultaneously removes the ability to challenge the restriction or the procedure's ability to revise it.

The formalization also defines reachability through process steps. If the constitution holds initially and every allowed step preserves it, then it holds in every reachable state.

Therefore:

> **under the declared preservation assumptions, self-sealing restrictions cannot become reachable.**

This is the recursive core of v18:

```text
the correction mechanism
must itself remain correctable.
```

## 6. Human-rights translation

The legal paper asks a separate normative question: whether the architecture of correctability should receive explicit protection in human-rights law.

It proposes a candidate symmetry:

```text
freedom of conscience:
    nobody may own my mind

procedural corrigibility:
    nobody's conviction alone should become
    uncorrectable authority over a shared process
```

The paper develops a draft **Article X — Right to a Correctable Process**.

This is a proposal for legal discussion. It is **not** machine-derived law and is not presented as a statement that existing international human-rights law already contains the proposed general right.

## 7. Accessible parable

`The Elephant and the Agreement` presents the architecture as a story of blind observers encountering different parts of one elephant.

Its central symmetry is:

> **Protect the observer, because no collective has direct access to another person's experience.**

> **Protect the relationship, because no observer has direct access to the whole truth.**

The parable is explanatory, not part of the theorem surface.

## 8. Machine verification

The permanent workflow is:

```text
.github/workflows/learning-constitution-check.yml
```

It has two independent jobs.

### Lean

The workflow pins **Lean 4.34.0**, rejects `sorry` / `admit` placeholders, and compiles:

```text
papers/the-room-learning-constitution/TheRoom.lean
```

### Standalone papers

The workflow independently compiles:

```text
the_room_problem.tex
the_learning_constitution.tex
procedural_corrigibility_human_rights.tex
the_elephant_and_the_agreement.tex
```

The checked theorem-to-paper map is in `FORMAL_VERIFICATION.md`.

## 9. What v18 does not prove

The formal surface does not establish:

```text
correctability -> truth
correctability -> moral obligation
correctability -> legal right
same standing -> equal expertise
procedural standing -> equal evidential weight
challengeability -> endless debate
appealability -> endless reopening
source exclusion -> loss of all correction under redundant channels
five constitutional clauses -> unique minimal constitution
machine proof -> empirical validity.
```

The legal and philosophical steps remain open to criticism, comparison with existing doctrine, empirical testing, and revision.

## 10. Relation to v17

v17 remains the canonical recursive-organization formal core:

```text
retained organization
-> operational reuse
-> changed generability
-> later recursive organization.
```

v18 adds a separate agent/interdependence companion:

```text
fallible partial models
-> incompatible consequential claims
-> corrective procedure
-> restrictions kept correctable
-> recursive preservation of correctability.
```

The two surfaces should not be conflated.

## 11. Review targets

Reviewers are invited to attack:

1. formal validity;
2. whether `NoPrivilegedTruthAccess` is the right bridge;
3. whether source-based correctability is too strong relative to channel/reachability formulations;
4. whether the five constitutional clauses are redundant or incomplete;
5. whether `ConstitutionPreserved` is substantively useful or merely restates the desired invariant;
6. stronger prior art in epistemology, deliberative procedure, constitutional law, due process, administrative law, or human-rights doctrine;
7. the normative bridge from correctability to rights;
8. conflicts with finality, privacy, safety, association, expertise, disability rights, child rights, and emergency powers.

A counterexample, narrower theorem, stronger antecedent, better legal doctrine, or cleaner formalization is a successful review result.

## Release lineage

- **v18 — The Learning Constitution: Correctable Interdependence**
- **v17 — Recursive Organization Core**
- **v16 — Full Theory Peer-Review Release**
- **v15 — Verification Closure**

Use the immutable `v18` tag and record its commit SHA when reviewing this release.
