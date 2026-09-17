# Evolution by Emergence

## A formal model of maintenance, cumulative change, and open-ended accessibility

**This project is open for peer review.**

You do **not** need to read the whole book or understand the entire repository to review the current formal core.

The present milestone — **v14: Formal Core Closure** — asks a comparatively simple question:

> **Under what explicit conditions can recurrent maintenance support validated cumulative novelty, and what must be true if that process is to remain open-ended?**

The central implication chain is now represented explicitly and machine-checked in Lean:

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

The project does **not** claim that persistence automatically produces learning, that novelty is necessarily improvement, that an external validation criterion is objective truth, or that biological, cognitive, social, or technological systems automatically satisfy these assumptions.

Lean checks:

> **If the stated assumptions hold, do the stated conclusions follow?**

Science must still ask:

> **When do those assumptions hold in the world?**

That is where peer review begins.

For the authoritative description of the current formal milestone, read **[RELEASE_NOTES.md](RELEASE_NOTES.md)**.  
For repository-wide navigation and epistemic guidance, read **[RESEARCH_GUIDE.md](RESEARCH_GUIDE.md)**.

---

## Why this may be worth reviewing

Several parts of the model are deliberately exposed to criticism.

### 1. Maintenance is separated from learning

A recurrent organization may persist without learning anything.

The formalization therefore does **not** jump from

```text
persistence → evolution
```

to its conclusion. It represents the missing steps between recurrent maintenance, opportunity, generation, validation, retention, and cumulative change.

### 2. Previous organization can become infrastructure for future search

Generated intermediates can be retained and reused.

A minimal formal example is:

```text
a → b → c
```

where `c` is unavailable after one retained generative round but becomes available after `b` has been generated and retained.

This captures a simple but important idea: **successful previous organization can change the starting point for subsequent search.**

### 3. Recombination is different from unary descent

The formal stack allows finite-parent generation.

A candidate can become generable through retained combinations even when neither parent has a unary path to it.

The model therefore distinguishes changes caused by:

```text
new retained material
new combinations of retained material
changed generative rules
```

rather than hiding all three inside one transition graph.

### 4. A finite novelty space eventually saturates

For monotonically retained organization inside a fixed finite declared universe, the number of strict retained expansions is finite.

Changing the generative rule does not remove this counting boundary while effective distinguishability capacity remains fixed and finite.

For the particular form of **open-ended cumulative retained novelty** defined here:

```text
open-ended cumulative retained novelty
                ↓
unbounded effective distinguishability capacity
```

But the converse is false:

```text
unbounded capacity
        ↛
realized novelty
```

The repository contains a machine-checked counterexample.

### 5. External validation is not identified with truth

The evolving architecture includes a declared external predicate `E_t`.

Mathematically, that predicate is intentionally uninterpreted. It is **not defined to mean objective truth, fitness, morality, utility, or correctness**.

This lets reviewers ask separately whether the formal implication is valid and whether a proposed real-world validation process is meaningful.

### 6. The complete premise set has a machine-checked witness

`FormalCoreWitness.lean` supplies a concrete joint witness showing that the final theorem stack is not merely a collection of compatible-looking implications: its premise set can be inhabited simultaneously.

The witness is for **logical non-vacuity**, not biological realism.

So there are at least three distinct things to challenge:

```text
the mathematics
the assumptions
the interpretation
```

Finding a problem in any one of them is useful.

---

# How to peer-review this project

## Recommended approach: human + LLM

The repository is large enough that reading it linearly is inefficient.

A useful workflow is:

> **Let an LLM navigate. Let the human judge.**

An LLM can trace definitions, locate theorem dependencies, compare files, search for counterexamples, inspect claim ledgers and literature audits, and explain Lean code.

The human reviewer should remain responsible for deciding whether definitions are meaningful, whether assumptions correspond to real systems, whether interpretations overreach the formal result, and whether prior literature already contains the result in the same or a stronger form.

### Start here

For the current formal milestone, use this route:

1. **[`RELEASE_NOTES.md`](RELEASE_NOTES.md)** — current formal claim, implication chain, scope, non-claims, and remaining research questions.
2. **[`RESEARCH_GUIDE.md`](RESEARCH_GUIDE.md)** — routing and epistemic protocol. Use it as a map, **not as evidence that the claims are true**.
3. **[`formalization/cumulative-accessibility/README.md`](formalization/cumulative-accessibility/README.md)** — map of the cumulative-accessibility Lean package.
4. **[`FormalCoreWitness.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FormalCoreWitness.lean)** — concrete joint witness for the closed formal core.
5. **[`MaintenanceOpportunityBridge.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceOpportunityBridge.lean)** — bridge from concrete recurrent maintenance dynamics to recurring opportunity and onward to validated uptake.
6. **[`ValidatedUptake.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ValidatedUptake.lean)** — external validation kept separate from ordinary novelty.
7. **[`OpenEndedCapacity.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/OpenEndedCapacity.lean)** — necessity of unbounded effective distinguishability capacity for the declared form of open-ended cumulative retained novelty.
8. **[`FiniteGenerativeSaturation.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/FiniteGenerativeSaturation.lean)** — finite-capacity saturation boundary.
9. Relevant **`CLAIMS.md`**, **`FORMAL_VERIFICATION.md`**, and **`REPRODUCIBILITY.md`** files — manuscript-facing claim mappings and reproducibility information.
10. **[`verification/audits/`](verification/audits/)** — theorem and literature audits.

Do not accept terminology merely because it appears in *Evolution by Emergence*. Trace important claims back to their source and compare them with established literature.

---

## Give an LLM this prompt

```text
Act as an adversarial scientific peer reviewer of this repository:

https://github.com/albertjanvanhoek/Evolution-by-Emergence

Do not evaluate the theory from the README alone.

Start with RELEASE_NOTES.md to identify the current formal claim.
Then read RESEARCH_GUIDE.md as a routing and epistemic document.
Do not treat either file as evidence that the claims are true.
Trace substantive claims back to their manuscript, Lean source, claim ledger,
reproducibility material, and relevant prior literature.

Your first task is to reconstruct the formal implication chain of the current
"Formal Core Closure" release.

For every arrow in that chain:

1. locate the exact Lean definitions and theorem(s);
2. state the assumptions explicitly;
3. determine whether the conclusion follows from those assumptions;
4. identify any hidden strengthening introduced in prose;
5. look for included counterexamples and converse failures;
6. distinguish:
   - definitions,
   - machine-checked results,
   - established external mathematics,
   - modelling assumptions,
   - empirical interpretations,
   - conjectures or research directions;
7. search for prior literature containing the same or a stronger result;
8. actively try to construct counterexamples to claims that are not already
   formal theorems.

Pay particular attention to whether the repository accidentally equates:

- maintenance with learning;
- persistence with fitness or function;
- novelty with improvement;
- larger search spaces with realized innovation;
- external validation with objective truth;
- unbounded capacity with open-ended novelty.

Then inspect FormalCoreWitness.lean and determine whether the complete set
of premises is genuinely jointly satisfiable.

Where possible, run the Lean formalization rather than trusting descriptions
of it.

Report results as:

CLAIM
SOURCE / THEOREM
ASSUMPTIONS
WHAT IS ACTUALLY PROVED
COUNTEREXAMPLE OR CONVERSE STATUS
RELATION TO PRIOR LITERATURE
POTENTIAL PROBLEM
SEVERITY
SUGGESTED TEST OR CORRECTION

Do not try to make the theory sound coherent.
Try to find where it breaks.
A negative result is useful.
```

The objective of peer review here is not to confirm the model. It is to make it **harder for the model to be wrong unnoticed**.

---

# Reproduce the formal checks

Clone the repository and enter the cumulative-accessibility package:

```bash
git clone https://github.com/albertjanvanhoek/Evolution-by-Emergence.git
cd Evolution-by-Emergence/formalization/cumulative-accessibility

lake update
lake exe cache get
lake build
```

The package pins its Lean/mathlib environment.

A successful build tells you that Lean accepts the formal derivations.

It does **not** tell you that the premises describe nature.

---

# Where reviewers can contribute most

A useful review does not have to overturn the whole framework. A single good contribution is enough.

- Find a theorem whose prose interpretation is too strong.
- Find a hidden assumption.
- Produce a simpler counterexample.
- Show that a claimed mechanism is already known under another name.
- Identify a stronger or more general existing theorem.
- Weaken an assumption while preserving the result.
- Show that a sufficient condition is not necessary — or prove that it is.
- Construct an empirical system that violates one of the premises.
- Propose an observable quantity corresponding to a formal variable.
- Find a domain where the complete chain can actually be tested.
- Improve the definition of effective distinguishability or open-endedness.

**A successful falsification is a contribution.**

So is a substantial simplification.

**Prior art is a result.** If you can show that a result is already known in stronger or more general form, please tell us. Correct attribution and simplification improve the model.

The repository's own literature audits already find extensive antecedents across several relevant fields; the current project is therefore framed conservatively as a **synthesis and research architecture with exact model-specific results**, not as a bundle of newly discovered general mechanisms.

---

# What is — and is not — being claimed

The current release claims something deliberately narrower than:

> “Evolution by Emergence has been proved.”

The formal claim is closer to:

> **A specified set of recurrent-maintenance, generative, validation, retention, and representation conditions is sufficient to derive a declared form of open-ended cumulative retained novelty, and that form of open-ended novelty requires unbounded effective distinguishability capacity.**

The logical route is machine checked, including a concrete jointly satisfiable witness for the premise set.

Whether those conditions are common, rare, physically realizable, biologically important, organizationally useful, or the right abstraction of evolution remains open to investigation.

That distinction is intentional.

---

# Review the smallest thing you can break

You do not need to review the whole project.

Pick one arrow.

Pick one definition.

Pick one claimed interpretation.

Pick one literature connection.

Then try to break it.

If it survives, we learn something.

If it fails, we learn something better.

Open a GitHub **Issue** with the relevant theorem/file and a reproducible argument, or submit a **Pull Request** with a correction, counterexample, stronger theorem, test, or documentation improvement.

This project is intended to remain corrigible.

---

## Explore further

- **Current formal milestone:** [`RELEASE_NOTES.md`](RELEASE_NOTES.md)
- **Research map and epistemic protocol:** [`RESEARCH_GUIDE.md`](RESEARCH_GUIDE.md)
- **Formal cumulative-accessibility stack:** [`formalization/cumulative-accessibility/`](formalization/cumulative-accessibility/)
- **Organizational-depth verification:** [`verification/organizational-depth/`](verification/organizational-depth/)
- **Sufficient Alignment:** [`papers/sufficient-alignment/`](papers/sufficient-alignment/)
- **Website:** [Evolution by Emergence](https://albertjanvanhoek.github.io/Evolution-by-Emergence/)
- **Listen:** [Stream Emergence 🐠 on SoundCloud](https://soundcloud.com/emergence-223803727)
- **Watch:** [Autonomous Interdependence on YouTube](https://www.youtube.com/@AutonomousInterdependence)

---

*Evolution by Emergence is an open, active, corrigible research corpus by Albert Jan van Hoek, developed with AI collaboration. Formal verification establishes mathematical consequences of explicit assumptions. Broader scientific interpretations remain open to empirical testing, literature comparison, criticism, revision, and rejection.*