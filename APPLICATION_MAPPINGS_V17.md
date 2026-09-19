# Worked domain mappings and a deliberate non-mapping

**Date:** 19 September 2026  
**Status:** reviewer-facing application firewall for the v17 candidate core

The purpose of these mappings is not to prove universality.

It is to test whether the formal interfaces can be instantiated in substantially
different domains **without changing their meanings ad hoc**.

A valid mapping should specify, at minimum:

- configuration;
- capacity;
- realization relation;
- proper-subconfiguration relation;
- resource feasibility;
- external/domain validation;
- active repertoire;
- cumulative history, when distinct;
- generator or construction rule;
- finite local envelope;
- admission mechanism;
- retention mechanism.

The mapping should also identify which EbE assumptions are not justified.

---

## Mapping A — autocatalytic / reaction-network organization

### Why this is a useful test

RAF and related autocatalytic-network theories are strong antecedents rather
than targets to be replaced. They already formalize self-sustaining reaction
organization, generative/hierarchical RAFs, food-generated closure, and in some
work ordering constraints among reactions.

The purpose of the EbE mapping is therefore to ask whether its abstract
interfaces can reproduce a recognizable slice of that domain while preserving
the distinctions in the formal core.

### Candidate mapping

| EbE object | Reaction-network interpretation |
|---|---|
| configuration | a declared finite reaction/catalyst organization or realized reaction subnetwork |
| proper subconfiguration | a strict declared subnetwork/subset under the chosen decomposition |
| capacity | production of a target molecule, catalytic capability, flux-supporting function, or activation of a higher-tier reaction set |
| realizes(config, context, capacity) | the configuration can realize the target production/function under the declared food/catalyst/environment context |
| compositional emergence | the full declared configuration realizes the capacity while no declared proper subconfiguration does |
| active repertoire | reaction/catalytic capabilities currently available in the operative chemical organization |
| historical trace | capacities/reaction organizations that have appeared historically, if lineage/history is being tracked separately from current chemistry |
| generator | allowed reaction-network construction/activation rules from currently available material |
| constructive generator | an explicit reaction sequence/subnetwork assembled from available parent capabilities that yields the configuration witnessing the new capacity |
| resource feasibility | required substrates, catalysts, energy/flux or other declared material constraints are available |
| external criterion | domain-specific viability/persistence/production threshold; this is not supplied by EbE |
| retention | the new reaction/catalytic organization remains operational at the next declared time step |
| local envelope | finite set of reaction/network candidates actually represented/tested in the current model/experiment |
| admission | chemistry, stochastic encounter, experimental design, or computational search rule determining which generable possibilities are locally considered |

### What maps well

The following EbE distinctions have natural analogues:

```text
possible reaction/network
!= actually realized network
!= self-sustaining/viable network
!= retained network
!= network that becomes enabling material for a later tier.
```

Generative RAF theory is especially close to the parent-reuse/hierarchical
enabling layer.

The new constructive configuration bridge is also meaningful here: a reaction
set built from available material can be required to be the same reaction
organization whose joint behavior realizes the target capacity.

### What does not come for free

EbE does not establish:

- RAF existence;
- chemical kinetics;
- thermodynamic feasibility;
- catalysis rates;
- stochastic encounter probabilities;
- persistence of a chemical organization;
- or the correct decomposition into configurations/capacities.

Those must come from reaction-network theory and experiment.

### Verdict

**Good partial/full structural mapping.**

This domain supports the recursive-construction intuition strongly, but much of
that mechanism is already formalized more specifically by RAF theory. EbE's
potential value is in the wider filter/retention/accessibility bookkeeping and
cross-domain comparison.

---

## Mapping B — technological / cultural cumulative innovation

### Why this is a useful test

Technological evolution and cumulative culture are structurally different from
chemistry but have mature literatures on recombination, retained skills,
building blocks, acquisition costs, search, cultural transmission, and
open-endedness.

Recent work also models co-evolution of cultural/technological systems and
search spaces.

### Candidate mapping

| EbE object | Technological/cultural interpretation |
|---|---|
| configuration | a concrete artifact-system, workflow, technique bundle, institution, or coordinated socio-technical arrangement |
| proper subconfiguration | declared removal/subset of components, practices, or relations |
| capacity | a reproducible function the configuration can perform |
| realizes | demonstrated performance of that function in a stated operating context |
| compositional emergence | the assembled configuration performs a capacity that none of its declared proper subconfigurations can perform |
| active repertoire | skills, tools, standards, infrastructure, organizations, and techniques currently usable by the focal community |
| historical trace | accumulated record of previously realized techniques/capabilities, including items no longer operational |
| generator | recombination, design, learning, engineering, imitation, experimentation, or institutional construction using active components |
| constructive generator | an explicit design/build process mapping a finite parent set to the artifact/organization that realizes the new function |
| resource feasibility | time, labor, energy, materials, capital, compute, training, infrastructure or other declared implementation budget |
| external criterion | performance, safety, reliability, adoption, scientific validation, profitability, regulatory acceptance, or another domain-specific test |
| retention | the capability remains reproducible/available after the initial demonstration |
| local envelope | projects/ideas/designs actually considered by the community at that time |
| admission | R&D agenda, funding, attention, search algorithm, institutional priority, market exploration, scientific experiment selection |

### What maps well

This domain makes the active/history distinction especially important.

A civilization may historically have demonstrated a capability while losing the
skills or infrastructure needed to reproduce it. Therefore:

```text
historically known
!= currently operational.
```

Similarly:

```text
combinatorially conceivable
!= admitted to search
!= prototyped
!= validated
!= maintained as reusable infrastructure.
```

The PR #59 essential-parent test has a natural interpretation as a local
counterfactual:

> holding the rest of the declared design repertoire and design rule fixed,
> does removing this newly retained component make the downstream design no
> longer generable?

That does not prove sole causation, but it is a useful necessity test.

### Climate-transition example

A climate target itself is **not** an EbE recursive-emergence event.

For example:

```text
"decarbonized electricity system"
```

is a desired system-level target.

To map the theory, one must specify actual organization:

- generation technology;
- grid infrastructure;
- storage;
- transmission;
- control systems;
- manufacturing;
- finance;
- regulation;
- skills;
- maintenance;
- institutional coordination.

Knowing that a technically feasible decarbonized configuration exists does not
instantiate it.

The EbE-relevant descriptive sequence is instead:

```text
possible system
    -> candidate designs
    -> admitted projects
    -> built infrastructure
    -> validated operation
    -> maintained capability
    -> reusable standards/skills/infrastructure
    -> changed feasibility of later projects.
```

This is a descriptive organizational claim.

The normative premise

```text
we ought to decarbonize
```

must come from values, policy choice, risk assessment, and climate evidence,
not from the formal EbE core.

### What does not come for free

EbE does not determine:

- which technologies should be developed;
- social welfare;
- justice/fairness;
- political legitimacy;
- correct climate policy;
- market dynamics;
- behavioral response;
- engineering reliability;
- or whether a proposed innovation is genuinely beneficial.

### Verdict

**Good structural mapping with a very important normative firewall.**

This is likely one of the most useful domains for the essays because it makes
the difference between possibility and materialized maintained organization
concrete.

---

## Non-mapping C — a fixed-operator genetic algorithm

### Why include a non-mapping?

A framework that can describe everything explains little.

A standard genetic algorithm operating on a fixed finite genotype space with a
fixed mutation/recombination operator and fixed fitness evaluation provides a
useful negative control.

### What maps

It has:

- candidate generation;
- finite search;
- evaluation/selection;
- retention/reproduction.

So several lower EbE interfaces can be instantiated.

### What does not necessarily map

A retained high-fitness genotype need not become a **new generative primitive**
that changes the mutation/recombination operator or expands the effective
candidate vocabulary.

The algorithm can therefore keep exploring or optimizing while remaining inside
one fixed generative architecture.

Unless an additional mechanism is added, there is no reason to assert:

```text
retained child
    -> essential new building block
    -> expanded generated access
    -> moving candidate envelope.
```

A finite fixed genotype universe also eventually hits the ordinary saturation /
recurrence limitations appropriate to its dynamics.

### Verdict

**Partial mapping only.**

The system instantiates variation/filter/retention but not necessarily the
recursive accessibility-expansion mechanism.

This is exactly the kind of case the formal theory should classify cleanly
rather than relabel as a full EbE example.

---

## Cross-mapping invariants

The mappings above suggest that the following meanings can remain stable across
domains.

### Configuration

A concrete organization whose parts/relations can be declared and compared with
proper subconfigurations.

### Capacity

A context-dependent function/ability/behavior that can be tested for
realization.

### Emergence

A relative compositional statement:

```text
whole realizes capacity
AND no declared proper subconfiguration realizes it.
```

Not automatically historical novelty or value.

### Active repertoire

What can currently participate as operational parent material.

### Historical trace

What has genuinely occurred and been recorded historically, even if it is no
longer operational.

### Generation

A relation from currently available parent material to a candidate.

### Construction

The stronger relation from parent material to the actual configuration that
purports to realize the candidate capacity.

### Validation

An external/domain criterion, explicitly not equivalent to truth or moral
value.

### Retention

Operational availability beyond the instant of realization.

### Admission

The finite-selection mechanism choosing which possibilities receive local
search/attention.

### Recursive accessibility change

A retained product becomes operational material whose presence changes what can
subsequently be generated.

---

## Application review rule

An essay or application should not cite the formal core merely because its
subject contains the words "network", "emergence", "evolution", or "learning".

It should provide a mapping table like those above and state:

1. which formal premises are instantiated;
2. which are only hypotheses;
3. which are not satisfied;
4. which domain evidence supports the mapping;
5. which conclusion is formal versus empirical versus normative.

That is the firewall that allows the formal core to underpin the essays without
turning it into an all-purpose metaphor.
