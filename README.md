# Evolution by Emergence

## Maintenance, cumulative change, and open-ended accessibility

**This project is open for peer review.**

You do not need to read the whole book to review the current formal core.

The current milestone — **v15: Verification Closure** — asks a focused question:

> **Under what explicit conditions can recurrent maintenance support validated cumulative novelty, and what must be true if that process is to remain open-ended?**

The formal route is:

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

The important words are **conditional** and **explicit**.

Lean checks whether the stated conclusions follow from the stated assumptions. Science must still ask whether those assumptions hold in real biological, cognitive, social, organizational, or technological systems.

## What v15 changes

The mathematical implication chain was already the intended result of v14, but an adversarial verification audit found that the old CI command `lake build` only forced the package root target and therefore did **not** by itself demonstrate compilation of the entire formal-core dependency chain.

v15 closes that verification gap.

The repository now explicitly builds the two end-to-end verification targets:

```text
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
```

and CI separately re-runs their `#print axioms` output and fails if any central theorem depends on `sorryAx`.

The compatibility/proof-term repairs required to make the full stack compile did **not** require weakening the theorem statements.

## Two complementary witnesses

### 1. Logical non-vacuity

[`FormalCoreWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FormalCoreWitness.lean) shows that the final premise set can be inhabited simultaneously.

Its progressive architecture deliberately realizes novelty at every time step. Therefore the opportunity premise is not load-bearing in that particular witness. This makes it a **joint-satisfiability witness**, not a causal demonstration.

### 2. Opportunity-gated dependency

[`MaintenanceGatedWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceGatedWitness.lean) adds a stronger stress test.

One architecture family is parameterized by an opportunity stream:

```text
opportunity present
    → generator enabled
    → repertoire may expand

opportunity absent
    → generator disabled
    → repertoire unchanged
```

With the concrete recurrent maintenance opportunity stream, the architecture has open-ended cumulative retained novelty. Replacing the opportunity stream by `False` leaves the same architecture family static and not open-ended.

That establishes a genuine **within-model dependency / ablation result**. It does not establish empirical causality.

## Other results worth attacking

The formal stack deliberately keeps several claims separate:

- **maintenance ≠ learning**;
- **persistence ≠ fitness**;
- **novelty ≠ improvement**;
- **external validation ≠ objective truth**;
- **unbounded capacity ≠ realized novelty**;
- **joint satisfiability ≠ empirical realism**.

It also machine-checks:

- retained intermediates can become reusable infrastructure for later search;
- unary descent and multi-parent recombination are distinct generative structures;
- changing retained parent material and changing the generative rule are distinct mechanisms;
- a fixed finite distinguishability space bounds cumulative retained novelty;
- open-ended cumulative retained novelty, under representation in a moving envelope, implies unbounded effective distinguishability capacity;
- the converse is false.

A minimal retained-closure example is:

```text
a → b → c
```

where `c` is unavailable after one retained generative round but becomes available after two once `b` has been generated and retained.

## What is *not* claimed

The project does **not** claim that:

- persistence automatically creates learning;
- every recurrent maintenance network evolves;
- novelty is necessarily beneficial;
- the external acceptance predicate is objectively correct;
- unbounded capacity guarantees novelty;
- the current three-cycle theorem is already the most general possible network theorem;
- physical reality has a fixed finite state space;
- or real systems have already been shown to satisfy the formal assumptions.

## Review the fixed object

For comparable independent reviews, use the immutable **[`v15` tagged release](https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/v15)** and record the commit SHA you inspected.

Start with:

1. [`RELEASE_NOTES.md`](RELEASE_NOTES.md) — what changed, what is checked, and what remains open.
2. [`formalization/cumulative-accessibility/README.md`](formalization/cumulative-accessibility/README.md) — the Lean package and verification contract.
3. [`FormalCoreWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FormalCoreWitness.lean) — joint non-vacuity witness.
4. [`MaintenanceGatedWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceGatedWitness.lean) — opportunity-gated dependency and ablation witness.
5. [`MaintenanceOpportunityBridge.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceOpportunityBridge.lean) — recurrent maintenance to recurring opportunity and validated response.
6. [`ValidatedUptake.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ValidatedUptake.lean) — external validation kept separate from ordinary novelty.
7. [`OpenEndedCapacity.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/OpenEndedCapacity.lean) — open-ended novelty and capacity boundary.
8. [`FiniteGenerativeSaturation.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FiniteGenerativeSaturation.lean) — fixed finite-capacity saturation.
9. [`verification/audits/`](verification/audits/) — theorem and literature audits.
10. [`RESEARCH_GUIDE.md`](RESEARCH_GUIDE.md) — broader corpus navigation and epistemic guidance.

For an LLM-assisted adversarial review, use the versioned copy-paste protocol in **[`PEER_REVIEW_PROMPT.md`](PEER_REVIEW_PROMPT.md)**.

> **Let an LLM navigate. Let the human judge.**

An LLM can trace definitions, imports, theorem dependencies, counterexamples, and prior literature. The human reviewer remains responsible for deciding whether definitions are meaningful, assumptions are realistic, interpretations overreach, and prior work already contains the result in the same or stronger form.

## Reproduce the formal core

```bash
git clone https://github.com/albertjanvanhoek/Evolution-by-Emergence.git
cd Evolution-by-Emergence
git checkout v15
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

The central printed theorem axioms must contain no `sorryAx`.

## How to contribute

Useful contributions include:

- a genuine counterexample to a stated theorem;
- a hidden assumption or overclaim;
- a simpler or stronger proof;
- a more general network theorem;
- a more realistic validation or turnover model;
- a stronger empirical test;
- prior literature showing that a claimed contribution is already known;
- or a cleaner formalization of the same distinction.

**A successful falsification is a contribution. Prior art is a result. Review the smallest thing you can break.**

---

*Evolution by Emergence is an active, corrigible research corpus by Albert Jan van Hoek with AI collaboration. Formal verification establishes mathematical implications under explicit assumptions; broader scientific interpretation remains open to evidence and peer review.*
