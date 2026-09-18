# Evolution by Emergence

## Maintenance, cumulative change, and open-ended accessibility

**This project is open for peer review.**

You do not need to read the whole book to review the current formal core.

The current development revision builds on the immutable **v15: Verification Closure** release and asks a sharper question:

> **What quantitative maintenance support is actually preserved, what must be declared to turn that support into opportunity, and exactly which response assumptions are sufficient for open-ended cumulative novelty?**

The formal route is now:

```text
positive canonical support + non-strict maintenance threshold
                ↓
persistent quantitative support
                +
declared support → opportunity connection
                ↓
recurring opportunity Q

Q + success at every opportunity V
                ↓
recurrent successful coincidence W
                ↓
validated generative uptake G

retention R + G
                ↓
open-ended cumulative retained novelty N

representation P + retention R + N
                ↓
unbounded effective distinguishability capacity C
```

The revision also machine-checks that `W` is a genuine coupling condition: `W ∧ ¬V` is possible, and `Q ∧ G` does not imply `W`.

The important words are **conditional** and **explicit**.

Lean checks whether the stated conclusions follow from the stated assumptions. Science must still ask whether those assumptions hold in real biological, cognitive, social, organizational, or technological systems.

## What the post-v15 revision changes

The v15 central implication chain survived adversarial review, but the review exposed a lossy interface and incomplete auxiliary verification coverage.

This revision therefore:

- preserves the **positive quantitative canonical support vector** instead of reducing maintenance immediately to mere positivity;
- proves the support bound under the **non-strict** closed-loop replacement threshold;
- requires an explicit `SupportImpliesOpportunity` connection before support can establish recurrence of a chosen opportunity predicate;
- separates success at every opportunity (`V`) from recurrent successful coincidence (`W`) and recurrent validated uptake (`G`);
- machine-checks `Q ∧ V → W → G`, plus the separation witnesses `W ∧ ¬V` and `Q ∧ G ∧ ¬W`;
- fixes two auxiliary Lean defects identified by review;
- adds `AuditAll` so every advertised module compiles in CI;
- adds `VerificationSurface` so selected advertised theorem dependencies are explicitly checked for `sorryAx`;
- and makes changes to the imported collective-alignment package trigger the downstream cumulative-accessibility check.

The further dynamical problem—deriving recurrent successful uptake from independently specified support, resource, generation, validation, and delay mechanisms—is deliberately left open.

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

The immutable **[`v15` tagged release](https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/v15)** remains the historical verification-closure object. To review the newer quantitative-support/response-separation revision, pin and report the exact commit SHA on `main` (or the revision pull request before merge) rather than silently mixing it with v15.

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
# optionally checkout an exact commit SHA for a fixed review object
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build \
  CumulativeAccessibility.AuditAll \
  CumulativeAccessibility.VerificationSurface \
  CumulativeAccessibility.FormalCoreWitness \
  CumulativeAccessibility.MaintenanceGatedWitness
lake env lean CumulativeAccessibility/VerificationSurface.lean
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
