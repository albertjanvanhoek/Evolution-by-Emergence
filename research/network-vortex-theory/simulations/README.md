# Exploratory Simulations — status and reproduction plan

> **Important:** the numerical simulation results discussed during theory development have **not yet been reproduced by versioned code in this repository**.  
> Treat the results below as exploratory working notes, not verified or citable findings.

The purpose of preserving them here is to retain the hypotheses, controls, and failure modes that motivated the current theorem program.

The current EbE centre is broader than these simulations:

> **Retained organization becomes causal structure for future change.**

The simulations below test one specialization of that claim: retained organization changes later construction costs, routes, and budgeted accessibility.

## Reported exploratory findings

The research discussion reported the following qualitative patterns:

1. **Retention is not automatically beneficial.** Maintenance costs can make retained organization reduce rather than expand budgeted accessibility.
2. **Reuse centrality matters.** Modules participating in many downstream constructions were more likely to justify retention.
3. **Path dependence and lock-in can arise.** Finite maintenance resources can make different discovery/retention histories produce different later accessible sets.
4. **Full closure can remain unchanged while budgeted functional accessibility expands.** A Boolean-circuit toy model was used to illustrate this distinction.
5. **Equal-cost independent caching does not automatically generate hierarchy.**
6. **Complexity-aware but independent storage is not enough for robust hierarchy.** Shared representation matters.
7. **Compositional retention can generate nested reusable modules.**
8. **Null control: destroy repeated cross-task substructure and hierarchy largely disappears.**
9. **Increase reference cost and hierarchy weakens.**

## What must be reproduced

A reproducible implementation should include at least three experiments.

### A. Costed random construction system

- randomly generated typed construction/rewrite universe;
- finite task/construction budget;
- explicit maintenance cost;
- selectable retention;
- measurement of gain/loss sets;
- path-dependence and lock-in controls.

### B. Boolean-circuit functional control

Use a fixed gate vocabulary so that function is derived from circuit truth tables rather than assigned labels.

Required checks:

- full functional closure before/after retention;
- budgeted functional accessibility before/after;
- retained subcircuits as reusable modules;
- stepping-stone examples.

### C. Random typed network/hypergraph system

Remove Boolean semantics.

Compare:

1. independent caching;
2. compositional retention;
3. matched random retained dictionaries.

Controls:

- destroy cross-task shared substructure;
- vary reference cost;
- vary maintenance budget;
- measure historical hierarchy depth only in time direction.

## Required outputs

For every experiment, save:

- random seed;
- complete parameter configuration;
- generated universe;
- retention decisions over time;
- cost definitions;
- raw results;
- summary statistics;
- plots/tables;
- exact code commit.

## Avoid these mistakes

- Do not infer historical hierarchy from final mutual cheapness; this can create false cycles.
- Do not define "useful" modules by the quantity later used to prove that they were useful.
- Do not equate number of retained modules with accessibility.
- Do not use infinite closure as the only possibility-space measure.
- Do not call an exploratory numerical result a theorem.
- Do not treat Boolean truth tables as universal semantics; they are a controlled test bed.
- Do not claim network hierarchy is universal unless chemistry and other non-symbolic systems support the same mechanism.

## Current role

These experiments motivated the theorem statement:

\[
\text{direct reuse value}
+
\text{hierarchical compression value}
>
\text{retention/maintenance cost}.
\]

The next simulation should be designed *after* the network-level theorem is clarified, not used to substitute for it.
