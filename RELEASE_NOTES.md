# Unreleased — Quantitative Support and Response Separation

This post-v15 revision implements findings from adversarial review without changing the established direction of the central sufficient-condition chain.

The revision has a deliberately bounded scope:

- **complete package verification:** `AuditAll.lean` imports every module advertised by the cumulative-accessibility README, `VerificationSurface.lean` explicitly audits selected advertised theorem dependencies for `sorryAx`, and downstream CI now triggers on changes to the imported collective-alignment package;
- **positive quantitative maintenance support:** the three-cycle trajectory is proved to remain above a strictly positive canonical support vector under the non-strict product threshold, with a positive scalar floor as a corollary;
- **explicit support-to-opportunity connection:** persistent support yields recurring opportunity only through a declared `SupportImpliesOpportunity` relation;
- **response separation:** a complete successful event `F`, success-at-every-opportunity `V`, recurrent successful coincidence `W`, recurring opportunity `Q`, and recurring validated uptake `G` are separated explicitly;
- **checked logical boundaries:** Lean checks `Q ∧ V → W`, `W → Q`, `W → G`, together with witnesses for `Q ∧ ¬N`, `W ∧ ¬V`, and `Q ∧ G ∧ ¬W`;
- **auxiliary repairs:** the generator-rule witness now imports its actual dependency and the synchronous capacity-slack counterexample uses the correct strict-subset conversion.

Retention and representation remain explicit in the downstream arrows:

```text
R ∧ G → N
P ∧ R ∧ N → C
```

The canonical support vector is a mathematically explicit lower bound inside the model. Calling it an empirically operational threshold would still require an application-specific interpretation of units, normalization, and what those component levels enable.

This revision does **not** derive recurrent successful uptake from maintenance. `W` already assumes arbitrarily late same-time coincidence of opportunity and success. The next dynamical problem is to derive such recurrence from independent mechanisms governing support, resources, generation, validation, and, when needed, response delay.

The contribution being evaluated is the common formal architecture, its explicit implication boundaries, and its verified constructions. Whether that particular integration is novel remains a literature question.

The immutable v15 tag remains the historical verification-closure release described below.

---

# Evolution by Emergence v15 — Verification Closure

`v15` is a verification-focused release of the formal core.

The central mathematical claim is unchanged from the intended v14 result: under explicit assumptions, recurrent maintenance can supply recurring opportunity; combined with opportunity-conditioned validated realization and retention, this yields validated generative uptake, open-ended cumulative retained novelty, and—under representation inside a moving envelope—unbounded effective distinguishability capacity.

What changed materially is the **strength of the evidence that the repository actually machine-checks that route end to end**.

## Why v15 exists

After v14, an adversarial review of the repository's verification surface found an important infrastructure problem.

The cumulative-accessibility workflow ran:

```text
lake build
```

but the package default target was only `CumulativeAccessibility`. That command therefore did not, by itself, force every later formal-core module and the final witnesses through Lean.

This did **not** produce a counterexample to the mathematical results. It did mean that the v14 release language about end-to-end machine checking was stronger than the CI evidence actually established.

The repository now records that distinction explicitly instead of rewriting the historical v14 tag.

## The formal-core route

The checked implication chain remains:

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

The formalization continues to keep the following distinctions explicit:

- maintenance ≠ learning;
- persistence ≠ fitness;
- novelty ≠ improvement;
- external validation predicate ≠ objective truth;
- unbounded capacity ≠ realized novelty;
- joint satisfiability ≠ empirical realism.

## 1. The full formal-core dependency chain is now forced through Lean

The CI workflow now explicitly builds:

```text
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
```

The first target recursively forces the maintenance dynamics, maintenance-opportunity bridge, validated uptake, capacity uptake, open-ended-capacity, finite-saturation, and retained-generative dependencies used by the original end-to-end witness.

The second target independently checks the stronger opportunity-gated stress test described below.

A clean GitHub Actions runner successfully compiled the complete dependency chain under the pinned Lean/Mathlib environment.

## 2. The audit exposed compatibility/proof-term defects, not a failed theorem

Forcing the previously unbuilt modules through the current pinned toolchain exposed several local Lean issues, including:

- updated summation syntax;
- a reserved identifier conflict around `universe`;
- an outdated strict-subset proof expression;
- recursive definitions that required more explicit unfolding in simplification;
- under-specified toy witness arguments;
- decidability instances required by the new gated construction.

These were repaired without weakening the mathematical theorem statements.

The audit did **not** require changing the central claims that:

- finite retained novelty in a fixed finite distinguishability set is bounded;
- open-ended cumulative retained novelty implies unbounded envelope capacity under representation;
- unbounded capacity alone does not imply realized novelty;
- recurrent opportunity alone does not imply novelty;
- the combined premise set is jointly satisfiable.

## 3. `sorryAx` is now an explicit CI failure condition

A green compile is no longer treated as the entire verification contract.

`FormalCoreWitness.lean` and `MaintenanceGatedWitness.lean` contain `#print axioms` statements for their central theorems. CI re-runs both source files and fails if the printed output contains:

```text
sorryAx
```

The checked formal-core theorems use ordinary Lean/Mathlib axioms such as `propext`, `Classical.choice`, and `Quot.sound`; the relevant release condition is that no central result depends on an unproved `sorry` placeholder.

The clean v15 verification run contains no `sorryAx` in the central witness outputs.

## 4. The original witness keeps its proper role

`FormalCoreWitness.lean` remains the concrete **logical non-vacuity witness**.

It shows that the premises of the cross-stack theorem can be inhabited simultaneously. Its progressive architecture deliberately realizes a new accepted retained candidate at every time step.

Therefore the opportunity hypothesis is not load-bearing in that particular construction.

That is not a defect in the sufficiency theorem. It means only that this witness establishes **joint satisfiability**, not necessity, minimality, or causal dependence of novelty on the maintenance-opportunity stream.

The file is kept independent of the new gated witness so those two evidentiary roles remain separate in the dependency graph.

## 5. New opportunity-gated dependency and ablation witness

`MaintenanceGatedWitness.lean` adds a stronger constructive stress test.

It defines one architecture family parameterized by an opportunity stream `O`.

At transition `n → n+1`:

```text
O n true
    → generator enabled
    → candidate n+1 can be produced
    → retained repertoire expands

O n false
    → generator disabled
    → retained repertoire unchanged
```

Lean checks both sides of the test.

### Positive construction

The concrete strict three-cycle maintenance dynamics supply a recurrent opportunity stream. Under that stream, the gated architecture has open-ended cumulative retained novelty.

### Ablation

Replacing the opportunity stream by the constant predicate `False` leaves the same architecture family at its initial repertoire, disables the generator, and rules out open-ended cumulative novelty.

This is a genuine **within-model dependency / ablation result**: the opportunity input is now structurally load-bearing in the construction.

It is still a toy formal witness. It does **not** establish that maintenance physically causes innovation in empirical biological, cognitive, social, organizational, or technological systems.

## 6. Verification and reproduction

From the tagged release:

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build \
  CumulativeAccessibility.FormalCoreWitness \
  CumulativeAccessibility.MaintenanceGatedWitness
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
```

The central printed theorem axioms should contain no `sorryAx`.

The CI workflow performs the same substantive checks automatically.

## 7. Reviewer interface cleanup

The repository entry points were simplified at the same time:

- `README.md` is now a concise human-facing peer-review entry point;
- `PEER_REVIEW_PROMPT.md` contains the operational LLM review protocol, including access, file-resolution, logical-direction, witness, literature, severity, and verification-status safeguards;
- `RESEARCH_GUIDE.md` is again primarily a routing and epistemic document;
- `formalization/cumulative-accessibility/README.md` documents the actual verification contract and both witness roles.

This separates human explanation from agent instructions and makes the review protocol independently versionable.

## What v15 establishes

For the declared theorem stack, v15 supports the following statement:

> **Under the explicit formal assumptions, the stated implication chain is machine-checked end to end in the pinned Lean environment, the combined premise set has a concrete non-vacuity witness, and a separate gated construction demonstrates that the opportunity interface can be made genuinely load-bearing inside the model.**

## What v15 does not establish

It does **not** establish:

- that all evolution is described by these assumptions;
- that persistence automatically produces learning;
- that every recurrent maintenance network has the concrete three-cycle property;
- that novelty is beneficial;
- that the external acceptance criterion is objectively correct;
- that unbounded capacity is sufficient for novelty;
- that the current formalization already captures the strongest possible notion of transformational open-endedness;
- that the opportunity-gated witness proves empirical causality;
- or that real systems have been shown to satisfy the model assumptions.

Those remain separate mathematical, modelling, empirical, and interpretive questions.

## Release lineage

- **v12 — Sufficient Alignment and Collective Intelligence:** alignment and collaboration stack.
- **v13 — Open for peer-review:** immediate checkpoint after the maintenance-to-accessibility formal work.
- **v14 — Formal Core Closure:** declared the completed formal implication architecture and packaged the reproducible site/release pipeline; later audit showed the cumulative-accessibility CI did not itself force every downstream formal-core module.
- **v15 — Verification Closure:** repairs that verification gap, adds an explicit `sorryAx` gate, and adds the opportunity-gated dependency/ablation witness.

v14 remains immutable as the historical object it was. v15 is the recommended fixed object for formal-core peer review.

## Licensing and source

The repository remains open access under its existing licensing terms. The tag contains the Lean sources, manuscripts, audit material, review protocol, release metadata, and reproducibility instructions needed to inspect this release as one fixed research object.
