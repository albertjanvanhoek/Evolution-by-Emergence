# Evolution by Emergence v14 — Formal Core Closure

This is the curated release of the formal core developed across the maintenance, organizational-accessibility, and organizational-depth work.

`v13` was published immediately after PR #42 merged as a checkpoint. `v14` packages the same scientific milestone as a proper release: full release notes, reproducible public-site packaging, an explicit release version, and an automated release process that creates an annotated Git tag only after the tested Pages build succeeds.

The scientific claim is deliberately narrower than “the theory is proven.” What is closed is the **formal implication chain under explicit assumptions**. Whether real biological, cognitive, social, or technological systems satisfy those assumptions remains an empirical and modelling question.

## Central result

The repository now contains a machine-checked route of the following form:

```text
strict recurrent maintenance conditions
                ↓
recurring maintenance opportunity
                +
opportunity-conditioned validated realization
                +
retention
                ↓
validated generative uptake
                ↓
open-ended cumulative retained novelty
                +
representation inside a moving envelope
                ↓
unbounded effective distinguishability capacity
```

The pieces are kept separate on purpose. In particular:

- maintenance is not identified with learning;
- persistence is not identified with fitness;
- novelty is not identified with improvement;
- an external validation predicate is not identified with objective truth;
- unbounded capacity is necessary for the declared form of open-ended cumulative novelty, but is not sufficient by itself.

This separation is one of the main outcomes of the formalization.

## 1. Recurrent maintenance is now explicit

PR #41 added `MaintenanceReproduction.lean` and machine-checked finite closed-loop maintenance conditions.

For canonical two-node and three-node recurrent modules, the formalization derives the corresponding replacement/growth thresholds and gives positive witnesses above the boundary. Removing the return path destroys the closed maintenance mechanism in the explicit comparison case.

The three-node strict threshold has the form

```text
(1-rA)(1-rB)(1-rC) < kAB kBC kCA
```

under the stated positivity/non-negativity assumptions.

The formal claim is intentionally finite and concrete. The general Perron–Frobenius / spectral-radius result is established mathematical prior art and is not claimed as a new theorem of this project.

## 2. Maintenance was lifted from an algebraic witness to a trajectory

`MaintenanceDynamics.lean` turns the finite three-cycle witness into a deterministic time-indexed process.

Lean proves a forward-invariant cone above the canonical maintenance witness. Under positive deficits/couplings and the strict closed-loop condition, the canonical trajectory remains strictly positive for every time step.

This supplies the temporal statement that was previously missing:

```text
strict closed maintenance loop
        ↓
maintenance availability arbitrarily late in time
```

That result is used to discharge the abstract `RecurringOpportunity` premise in the cumulative-accessibility package.

## 3. Recursive accessibility and retained stepping stones

PR #42 substantially extends the cumulative-accessibility formalization.

`RecursiveAccessibility.lean` separates several claims that are easy to merge informally:

- persistence can increase the number of search opportunities when variation is non-zero;
- zero variation still produces zero search, regardless of persistence;
- a viable retained intermediate can make a target indirectly reachable even when it is absent as a direct baseline transition;
- search depth and expansion of the search operator are distinct;
- an expanded candidate set does not imply that a newly available transition is actually realized.

`SecondOrderClick` captures a viable transition that also strictly enlarges the declared candidate/search set.

Counterexamples are included to show that deeper reachability can occur without search-operator expansion, and search-operator expansion can occur without actual realization of the new candidate.

## 4. Evolvability is represented as structure, not as a slogan

`EvolvabilityStructure.lean` formalizes candidate-set inclusion and strict candidate-set expansion.

Raw organizational states form a preorder under generator inclusion: two distinct states can expose the same candidate set. Antisymmetry would require quotienting by equality of candidate sets.

The module also separates raw expansion from functional expansion through a feature projection. More raw candidates need not create more task-relevant possibilities unless the projection distinguishes them.

Recombination is represented explicitly as multi-parent generation: retained coexistence can open a candidate that neither parent can reach by a unary edge alone.

## 5. Generative arity, retained modules, and evolving rules

The formal stack now distinguishes three different ways accessibility can change.

### Multi-parent generation

`GenerativeArity.lean` treats unary descent as the cardinality-one case of a finite-parent generator. Binary recombination is therefore represented as genuinely arity-two generation rather than being hidden inside a unary transition graph.

### Repertoire-driven expansion

`ModuleGeneratedEvolvability.lean` derives the effective search operator from retained modules plus a finite-parent generative rule. Retaining more compatible parent material can make a previously unavailable candidate generable.

### Rule-driven expansion

`GeneratorRuleEvolution.lean` keeps the repertoire fixed while changing the generator itself. Strict expansion of the generative rule can therefore produce strict evolvability expansion even without adding a new retained module first.

These are mathematically different mechanisms and are represented separately.

## 6. Generated intermediates can become reusable infrastructure

`GenerativeClosure.lean` defines retained iterative generative closure.

A generated object can be retained and become parent material in a later round. The concrete witness

```text
a → b → c
```

shows that `c` need not be available after one round even though it becomes available after two once `b` has been generated and retained.

This is the minimal formal form of the “successful previous organization becomes part of the starting point for later search” intuition.

## 7. Finite retained novelty saturates

`FiniteGenerativeSaturation.lean` establishes a combinatorial boundary that does not depend on a particular generator.

For a monotonically retained repertoire `S_n` contained in a fixed finite universe `U`, Lean proves

```text
|S_0| + strictExpansionCount(S,N) ≤ |S_N|
```

and therefore

```text
strictExpansionCount(S,N) ≤ |U| - |S_0|.
```

Arbitrary idle periods and time-varying update/generative rules do not evade this counting bound while the effective distinguishable universe remains fixed and finite.

For a fixed deterministic inflationary update closed in `U`, equality of consecutive states is a fixed point: the retained repertoire cannot begin expanding again later under the same update.

A changing generator alone therefore does not provide unlimited retained novelty inside a fixed finite distinguishability capacity.

## 8. Open-ended cumulative novelty requires open-ended capacity

`OpenEndedCapacity.lean` replaces the fixed universe with a moving finite envelope `U_t` and defines:

- `OpenEndedCumulativeNovelty` — arbitrarily many strict retained expansions occur over sufficiently long finite horizons;
- `UnboundedEnvelopeCapacity` — envelope cardinality becomes arbitrarily large.

For retained repertoires represented inside their envelopes, the formalization proves

```text
|M_0| + strictExpansionCount(M,N) ≤ |U_N|.
```

Hence the declared form of open-ended cumulative retained novelty implies unbounded effective distinguishability capacity.

The converse is false. A counterexample has an indefinitely growing envelope while the retained repertoire remains static.

This distinction is central:

```text
capacity for novelty ≠ realized novelty.
```

## 9. Capacity must be causally taken up

`CapacityUptake.lean` adds the missing causal link between available capacity, the current generator, and retained organization.

`GenerativeCapacityUptake` requires that, arbitrarily late in time, there is a candidate `z` such that it is:

- represented in the current envelope;
- not already retained;
- generated by the current generative rule from the current repertoire;
- retained at the next step.

This explicitly realizes

```text
U_t → H_t → M_{t+1}.
```

With monotone retention, recurring generative uptake implies open-ended cumulative novelty. With the representation condition, it also implies unbounded envelope capacity.

`CapacitySlack.lean` further decomposes a convenient sufficient mechanism into recurring unused capacity plus immediate generative realization. A synchronous-growth counterexample proves that recurring slack is sufficient but not necessary: `M_t = U_t` can hold at every time while both expand without bound.

## 10. External validation is separate from internal novelty

`ValidatedUptake.lean` extends the evolving architecture from

```text
(M_t, H_t, U_t)
```

to

```text
(M_t, H_t, U_t, E_t),
```

where `E_t(z)` is a declared external acceptance predicate.

The predicate is intentionally uninterpreted at the mathematical level. It is not defined to mean truth, utility, fitness, morality, or correctness.

Lean proves that repeated externally validated uptake implies ordinary generative uptake and therefore, with the existing retention assumptions, open-ended cumulative retained novelty.

Two witnesses make the boundary explicit:

- an accept-all criterion shows the validated condition is non-vacuous;
- a reject-all criterion gives an open-ended generative architecture that fails validated uptake.

Thus:

```text
open-ended novelty ↛ externally validated novelty.
```

## 11. The maintenance-to-accessibility bridge is now machine checked

`MaintenanceOpportunityBridge.lean` defines

```text
RecurringOpportunity(O) := ∀ n, ∃ m ≥ n, O_m
```

and separates recurring opportunity from the response made when an opportunity occurs.

The maintenance dynamics discharges `RecurringOpportunity` for the concrete strict three-cycle. Combined with opportunity-conditioned validated realization and retention, Lean derives validated generative uptake and then open-ended cumulative retained novelty.

With representation inside the moving envelope, the chain also yields unbounded effective distinguishability capacity.

A control example proves that recurring opportunity alone does not imply novelty.

This closes the formerly missing logical arrow without identifying survival with learning.

## 12. The complete premise set is inhabited

`FormalCoreWitness.lean` supplies a concrete joint witness rather than leaving the final theorem as a collection of compatible-looking implications.

One checked instance uses

```text
rA = rB = rC = 1/2
kAB = kBC = kCA = 1,
```

so that

```text
(1-rA)(1-rB)(1-rC) = 1/8 < 1 = kAB kBC kCA.
```

Together with the progressive generative architecture, monotone retention, and an accept-all external criterion, Lean checks the full route from recurrent maintenance through recurring opportunity and validated response to open-ended cumulative retained novelty and unbounded envelope capacity.

The formal core is therefore not only conditionally derived; its combined assumptions are demonstrably jointly satisfiable.

## 13. Organizational depth received an independent physical boundary

The organizational-depth work was also strengthened between `v12` and this release.

The manuscript now distinguishes consecutive fixed-resolution transitions from **retained packing depth**: repeated shuttling can make arbitrarily many fixed-resolution transitions while visiting only finitely many mutually distinguishable retained states.

The two-factor bound combines a dynamical resource ceiling with the packing capacity of the operational state space. In the finite-state Markov setting, the analysis uses total-variation contraction under measurement together with activity–entropy speed limits.

The accompanying Lean module `PackingDepth.lean`, numerical checks, tightness simulations, and reproducible figure distinguish the two obstructions:

```text
not enough dynamical budget
        or
not enough distinguishable places to go.
```

Either factor can bind.

## 14. Verification and audit trail

The release contains a substantially expanded verification surface:

- Lean modules for recurrent maintenance and maintenance dynamics;
- the cumulative-accessibility Lake package with a local dependency on collective alignment;
- machine-checked finite saturation, open-ended-capacity, uptake, validation, and bridge results;
- a concrete end-to-end formal witness;
- the organizational-depth Lean verification and packing-depth extension;
- claim ledgers and `FORMAL_VERIFICATION.md` mappings for several paper modules;
- literature and theorem audits under `verification/audits/`;
- explicit non-claims and scope boundaries in the formalization documentation.

The formal core from PR #42 passed both the Collective Alignment and Cumulative Accessibility Lean workflows before merge. The organizational-depth Lean workflow also passed on the immediate `v13` checkpoint. No formal theorem code is changed by the release-packaging fixes introduced for `v14`.

## 15. Reproducible release engineering

`v14` also repairs the release mechanics themselves.

The previous post-merge Pages build failed in strict mode because one reproducibly generated organizational-depth figure was rewritten to three invalid documentation paths. PR #44 fixes the packaging rather than weakening strict-mode checking:

- the tightness figure is regenerated during the Pages workflow;
- a browser-safe SVG is produced in the shared documentation figure directory;
- the manuscript reference is rewritten to that shared asset;
- verification-only LaTeX audit/drop-in files are no longer treated as public site pages;
- `mkdocs build --strict` passes again.

The repository now carries explicit release metadata:

- `RELEASE_VERSION`;
- `RELEASE_TITLE`;
- `RELEASE_NOTES.md`.

The release workflow runs only after a successful `Build & Deploy Site` workflow on `main`. It checks out the exact tested commit, validates the metadata, creates an **annotated Git tag**, and publishes the GitHub Release from these notes. Existing tags are checked for SHA consistency rather than silently moved.

This makes the release tag a consequence of a successful reproducible build rather than a manual label attached beforehand.

## What “formal core closure” means

The phrase is intentionally specific.

It means that, for the declared theorem stack, there is no longer an unformalized logical arrow required to obtain the intended conclusion. The premises, intermediate implications, converse failures, and a concrete combined witness are represented explicitly enough for Lean to check the mathematical dependencies.

It does **not** mean:

- that all evolution is described by these assumptions;
- that the external criterion is objectively correct;
- that persistence guarantees adaptation;
- that every recurrent maintenance network learns;
- that unbounded capacity guarantees novelty;
- that the current three-cycle recurrence theorem is the most general possible network theorem;
- that the fixed ambient candidate type already represents the strongest notion of transformational open-endedness;
- or that empirical systems have been shown to satisfy the model.

Those are separate scientific questions.

## Remaining research directions

The next work is therefore no longer “add the next missing arrow.” It is robustness, generalization, literature positioning, and empirical interpretation. Natural directions include:

- generalizing the concrete recurrent-maintenance dynamics to arbitrary nonnegative networks while cleanly separating new results from classical spectral theory;
- replacing monotone active-state retention with turnover plus recoverable generative memory;
- studying changing representational spaces rather than expansion inside one fixed ambient meta-space;
- formalizing changing or competing external evaluation processes;
- connecting distinguishability capacity to explicit physical coding/resource models;
- testing where biological, organizational, cultural, and artificial systems satisfy or violate the formal premises.

These are extensions of a closed formal proposition, not prerequisites for the proposition itself.

## Release lineage

- **v12 — Sufficient Alignment and Collective Intelligence:** formalized alignment as a viability region and expanded the machine-checked collaboration stack.
- **v13 — Open for peer-review:** immediate checkpoint after PR #42 closed the maintenance-to-accessibility implication chain.
- **v14 — Formal Core Closure:** curated, documented, reproducible release of that milestone, including the repaired strict Pages build and verified release automation.

Key merged pull requests:

- PR #41 — `Formalize recurrent maintenance thresholds`
- PR #42 — `Formalize recursive accessibility, validated uptake, and recurrent maintenance bridge`
- PR #44 — `Prepare reproducible v14 release`

## Licensing and source

The repository remains open access under its existing licensing terms. GitHub automatically provides source archives for this tagged release. The formal sources, verification code, manuscripts, audit material, and documentation are all retained in the tagged repository state so that the release can be inspected as a single reproducible research object.
