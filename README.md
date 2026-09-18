# Evolution by Emergence

## Maintenance, cumulative change, and open-ended accessibility

**This project is open for peer review.**

You do not need to read the whole book to review the current formal core.

The canonical entry point is **[Evolution by Emergence — The Current Theory](THEORY.md)**.

For different levels of detail:

- **[THEORY.md](THEORY.md)** — the full accessible theory, including scope, limits, extensions, and open problems;
- **[DYNAMIC_OVERVIEW.md](DYNAMIC_OVERVIEW.md)** — the resource-fed recursive accessibility vortex in detail;
- **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)** — exact theory-claim → Lean-declaration traceability;
- **[formalization/README.md](formalization/README.md)** — all proof packages and reproduction commands.

The current development revision builds on the immutable **v15: Verification Closure** release and asks a sharper compositional question:

> **How do maintenance, organization-dependent slack, internally funded response, validated retention, and second-order accessibility compose into one recurring dynamic process?**

The formal route is now:

```text
positive canonical support + non-strict maintenance threshold
                ↓
persistent quantitative support
                +
declared support → opportunity connection
                ↓
recurring opportunity Q

external gradient + organization-dependent uptake - maintenance
                ↓
internal slack
                ↓
endogenous response budget

Q + internally financed validated response within bounded lag Δ
                ↓
recurrent validated response within lag Δ
                ↓
validated generative uptake G

retention R + G
                ↓
open-ended cumulative retained novelty N

representation P + retention R + N
                ↓
unbounded effective distinguishability capacity C

retained organizational update
                ↓
reusable parent material and/or changed generative rule
                ↓
second-order accessibility click
                ↓
changed future search
                ↺
```

The earlier same-time coupling predicate `W` is now proved to be exactly the `Δ = 0` special case. A lag-1 even/odd witness has recurrent validated response and open-ended novelty while same-time `W` is false.

The important words are **conditional** and **explicit**.

Lean checks whether the stated conclusions follow from the stated assumptions. Science must still ask whether those assumptions hold in real biological, cognitive, social, organizational, or technological systems.

## What the post-v15 revision changes

The v15 central implication chain survived adversarial review, but the review exposed a lossy interface and incomplete auxiliary verification coverage.

This revision therefore:

- preserves the **positive quantitative canonical support vector** instead of reducing maintenance immediately to mere positivity;
- proves the support bound under the **non-strict** closed-loop replacement threshold;
- requires an explicit `SupportImpliesOpportunity` connection before support can establish recurrence of a chosen opportunity predicate;
- separates success at every opportunity (`V`) from recurrent successful coincidence (`W`) and recurrent validated uptake (`G`);
- generalizes same-time response to bounded delay `D_Δ`, proving `W ↔ D_0`;
- adds explicit time-dependent response budget and candidate-specific response cost;
- then closes the budget seam by defining internal slack as organization-dependent captured throughput minus maintenance demand and routing a declared fraction of that slack into response budget;
- proves `Q ∧ B_Δ → D_Δ → G`, where `B_Δ` can now be instantiated by an internally generated response budget;
- machine-checks a fixed-gradient witness in which uptake improves `10 → 11`, slack/budget rises `4 → 5`, and a `9/2` response becomes feasible;
- connects the existing cumulative-accessibility margin `2/3 → 97/99` to the same response interface, making the existing `9/10` second-click load newly feasible;
- machine-checks a lag-1 witness with `D_1 ∧ ¬W`, plus resource-independence witnesses in both directions;
- fixes two auxiliary Lean defects identified by review;
- adds `AuditAll` so every advertised module compiles in CI;
- adds `VerificationSurface` so selected advertised theorem dependencies are explicitly checked for `sorryAx`;
- and makes changes to the imported collective-alignment package trigger the downstream cumulative-accessibility check.

The resource-budget seam is now closed: the external gradient remains exogenous, but usable response budget is generated internally from uptake minus maintenance. The complementary recursive structural step was already formalized elsewhere: retained intermediates can become future parent material, retained module changes can expand the effective search operator, and retained rule changes can create second-order accessibility clicks.

This revision now also packages those routes together. `DynamicVortex.lean` defines an explicit integration interface in which an internally funded validated response is accompanied by a second-order organizational update. Under recurring opportunity, retention, and representation, Lean derives open-ended cumulative retained novelty, unbounded effective distinguishability capacity, and arbitrarily late second-order updates in one theorem. `DynamicVortexWitness.lean` supplies a concrete jointly inhabited construction.

The coupling from a retained response to a particular physical organizational update remains an explicit modelling assumption; the formalization does not claim that every retained novelty improves physical efficiency or expands search.

## Three complementary witnesses

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

### 3. Full dynamic composition

[`DynamicVortexWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortexWitness.lean) is the **integrated composition witness**.

It uses an internally generated response budget, validated retained novelty, and a state-dependent search operator in one architecture. Its endpoint `vortex_full_dynamic_witness` jointly certifies:

```text
open-ended cumulative retained novelty
+
unbounded effective distinguishability capacity
+
recurring second-order organizational/search updates
```

The integration premise remains explicit: the model declares that the retained response is accompanied by the relevant organizational state update. This witness establishes joint dynamic realizability inside the formal model, not a universal empirical law.

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

## The full theory surface

The present theory is deliberately broader than the cumulative-accessibility package. It now brings together:

- encounter/affinity before productive coupling;
- recurrent maintenance and quantitative support;
- organization-dependent solvency and slack;
- bounded resource-feasible response;
- retention and generative closure;
- repertoire- and rule-driven evolvability;
- second-order accessibility;
- implementation competition and slack/search drift;
- persistence/function and selected/sufficient separations;
- collective corrective architecture;
- open-ended-capacity requirements;
- finite-time/fixed-resolution physical bounds.

The repository's own literature audit recommends treating this as **primarily a synthesis/architecture with exact model-specific results**, not as a collection of newly discovered universal laws.

## Review the fixed object

The immutable **[`v15` tagged release](https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/v15)** remains the historical verification-closure object. To review the newer quantitative-support and bounded-response revisions, pin and report the exact commit SHA on `main` (or the relevant stacked pull request before merge) rather than silently mixing them with v15.

Start with:

1. [`THEORY.md`](THEORY.md) — the current full theory.
2. [`DYNAMIC_OVERVIEW.md`](DYNAMIC_OVERVIEW.md) — the integrated recursive dynamics.
3. [`FORMAL_THEORY_MAP.md`](FORMAL_THEORY_MAP.md) — exact claim-to-Lean proof map.
4. [`formalization/README.md`](formalization/README.md) — repository-wide formalization and reproduction guide.
5. [`RELEASE_NOTES.md`](RELEASE_NOTES.md) — what changed and what remains open.
6. [`formalization/cumulative-accessibility/README.md`](formalization/cumulative-accessibility/README.md) — the integrated cumulative-accessibility package.
7. [`DynamicVortex.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortex.lean) — composition theorem joining endogenous response and second-order accessibility.
8. [`DynamicVortexWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortexWitness.lean) — concrete full-dynamic witness.
9. [`FormalCoreWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FormalCoreWitness.lean) — joint non-vacuity witness.
10. [`MaintenanceGatedWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceGatedWitness.lean) — opportunity-gated dependency and ablation witness.
11. [`MaintenanceOpportunityBridge.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceOpportunityBridge.lean) — recurrent maintenance to recurring opportunity and same-time response.
12. [`ResponseDynamics.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ResponseDynamics.lean) — bounded-delay and quantitative resource-feasibility layer.
13. [`BoundedResponseWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/BoundedResponseWitness.lean) — lag-1 and resource-independence witnesses.
14. [`EndogenousBudgetBridge.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousBudgetBridge.lean) — gradient/uptake/maintenance slack mapped into response budget; cumulative margin specialization.
15. [`EndogenousBudgetWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousBudgetWitness.lean) — fixed-gradient and exact-margin seam witnesses.
16. [`ValidatedUptake.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ValidatedUptake.lean) — external validation kept separate from ordinary novelty.
17. [`OpenEndedCapacity.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/OpenEndedCapacity.lean) — open-ended novelty and capacity boundary.
18. [`FiniteGenerativeSaturation.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FiniteGenerativeSaturation.lean) — fixed finite-capacity saturation.
19. [`verification/audits/`](verification/audits/) — theorem and literature audits.
20. [`RESEARCH_GUIDE.md`](RESEARCH_GUIDE.md) — broader corpus navigation and epistemic guidance.

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
  CumulativeAccessibility.MaintenanceGatedWitness \
  CumulativeAccessibility.BoundedResponseWitness \
  CumulativeAccessibility.EndogenousBudgetWitness \
  CumulativeAccessibility.DynamicVortexWitness
lake env lean CumulativeAccessibility/VerificationSurface.lean
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
lake env lean CumulativeAccessibility/BoundedResponseWitness.lean
lake env lean CumulativeAccessibility/EndogenousBudgetWitness.lean
lake env lean CumulativeAccessibility/DynamicVortex.lean
lake env lean CumulativeAccessibility/DynamicVortexWitness.lean
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
