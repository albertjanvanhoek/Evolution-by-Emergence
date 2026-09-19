# Evolution by Emergence — formal theory core

**Candidate v17 review text**  
**Status:** draft until the v17 formal surface and review gates are frozen

## 1. What this theory is for

Evolution by Emergence (EbE) is a descriptive theory of **recursive
organization**.

Its purpose is not to replace evolutionary biology, autocatalytic-set theory,
open-ended-evolution research, cumulative-culture theory, technological
evolution, viability theory, learning theory, or other established fields.

Its purpose is to make one cross-domain question explicit:

> **How can organization that exists now become material that changes which
> organization can exist next?**

The theory therefore focuses on a sequence of distinctions that are often
compressed in ordinary language:

```text
possible
!= generated
!= realized
!= emergent
!= feasible
!= validated/selected
!= retained
!= operationally reusable
!= admitted to future search
!= recursively cumulative.
```

The formalization exists to keep these distinctions visible.

## 2. Primitive picture

At time t, a focal system has some organization that is operationally
available.

Call the currently active repertoire:

```text
Active_t.
```

A generative or construction process can combine available material into
candidate organization.

A configuration realizes a **capacity** when, in a declared context, it can
perform or instantiate the corresponding behavior/function.

A capacity is **compositionally emergent** relative to a declared decomposition
when:

```text
the whole configuration realizes the capacity
AND
no declared proper subconfiguration realizes it.
```

This definition is intentionally relative.

It does not mean:

- historically unprecedented;
- unpredictable;
- useful;
- true;
- beneficial;
- persistent.

Those are separate questions.

## 3. From emergence to retained organization

A realized emergent capacity does not automatically become part of the
continuing system.

The formal theory separates three further filters:

```text
resource feasibility
external/domain validation or selection
next-step retention.
```

A fully filtered retained event therefore has the form:

```text
emergent capacity
+ feasible implementation
+ passes declared external criterion
+ remains operational at the next step.
```

The external criterion is an interface. It is not assumed to mean the same thing in every domain.

Depending on the application, it may represent:

- viability;
- measured performance;
- survival;
- experimental validation;
- safety;
- adoption;
- another explicitly declared test.

It is **not** defined as truth or moral value.

## 4. Generation and construction

The theory distinguishes two strengths of generative description.

### 4.1 Capacity-level generation

The weak/generic interface states that a finite set of currently available
parents can generate a candidate capacity.

This is sufficient for many abstract accessibility arguments.

### 4.2 Configuration-level construction

The stronger interface states that a parent set constructs a **specific
configuration for the child capacity**, and that the same configuration is the
one whose organization realizes the capacity emergently and passes the
downstream filters.

This closes an important mechanistic gap:

```text
parents generate capacity phi
AND
some configuration realizes phi
```

is weaker than:

```text
parents construct configuration c for phi
AND
that same c realizes phi emergently.
```

The stronger constructive event projects to the weaker event, so the framework
can use whichever level an application can justify.

## 5. Recursive emergence

A retained child becomes operational material.

A later event is recursively connected to the earlier one when the retained
child is explicitly reused as parent material.

Thus:

```text
existing operational organization
    -> generates/builds candidate
    -> candidate realizes emergent capacity
    -> candidate passes filters
    -> child retained as operational primitive
    -> child reused in later generation.
```

This is the basic recursive motif.

It does not say that every retained child will be useful later.

## 6. Essential contribution and changing generability

Mere participation in a later parent set is weak evidence that the earlier
primitive mattered.

The stronger PR59 test asks whether the candidate is generable from the full
next-step repertoire but **not** generable when the promoted child is removed,
while holding the next-step generator fixed.

This establishes:

> the promoted child is an essential contributor to that declared downstream
> generated-access expansion.

It does not establish that the child is the sole cause.

Other simultaneous additions may also be required.

The fixed-generator counterfactual also isolates parent-material change from a
change in the generative rule itself.

## 7. Possibility is not search

A newly retained primitive may make many downstream possibilities generable.

A finite real system need not search all of them.

The theory therefore introduces a finite **admission** or **local-horizon** interface. The resulting local envelope is a finite representation of what is admitted/represented at that step; it need not be identical to every physically possible or mentally considered candidate.

The sequence becomes:

```text
new generability
    -> finite admission/compression
    -> local candidate envelope
    -> attempted/realized candidates
    -> validation/filtering
    -> retention.
```

The admission process is application specific.

It may represent:

- finite experimental capacity;
- bounded attention;
- R&D portfolio selection;
- mutation neighborhood;
- sampling;
- resource-constrained search;
- another finite selection process.

The formal theory does not derive the admission policy universally.

## 8. Deterministic effective successor reproduction

For one realized recursive-emergence event, the theory can count actual full
successors represented inside the next finite local candidate envelope.

Call this deterministic local effective successor number:

```text
R_E^local(t, child).
```

By construction:

```text
R_E^local >= 1
iff
at least one actual full recursive successor exists
inside the next local envelope.
```

This is a deterministic count.

It is **not** automatically:

- an expected number of offspring;
- a branching-process reproduction number;
- a stochastic survival probability;
- a spectral-radius threshold.

A separate mechanism ledger can decompose factors such as opportunity,
generation, resource feasibility, validation, and retention, but that ledger is
not identified with the actual successor count without an explicit calibration
bridge.

## 9. Two cumulative endpoints

The audit exposed an important distinction between **currently active
organization** and **cumulative historical trace**.

### 9.1 Operational accumulation

The strongest original endpoint assumes:

```text
Active_t subseteq Active_(t+1).
```

If:

- there is a seed recursive event;
- active organization is monotonically retained;
- every realized event has a sufficient next local successor;

then the active repertoire undergoes arbitrarily many strict expansions.

This is:

> **open-ended cumulative operational novelty.**

It is a strong idealization appropriate to domains where previously acquired
capabilities remain operational.

### 9.2 Historical accumulation with turnover

Operational repertoires can also forget, lose, replace, or deactivate
capacities.

The v17 extension therefore separates:

```text
Active_t
History_t.
```

Parents must come from Active_t.

History_t is a declared cumulative trace of capacities that the application records as having been realized. The formal theory does not independently establish the empirical truth of that record.

If history-new recursive events continue and History is monotonically recorded, then History can accumulate open-endedly **without monotone active retention**.

This theorem is deliberately an accounting implication: it does not explain why history-new events continue. That causal burden remains in the recurrence premise.

The formal witness is deliberately extreme:

```text
|Active_t| = 1 for every t
```

while:

```text
History_t
```

keeps expanding.

Thus:

```text
open-ended historical accumulation
does not imply
ever-growing current operational repertoire.
```

This distinction is important for biology, culture, technology, institutions,
and cognition.

## 10. The finite-capacity boundary

Suppose a monotonically accumulating retained repertoire lives inside one fixed
finite effective capacity universe.

Then it can undergo only finitely many strict expansions.

Therefore the combination:

```text
fixed globally finite effective capacity universe
+ monotone cumulative retention
+ indefinitely recurring strict novelty
```

is inconsistent.

This is elementary finite-set mathematics.

Its role in EbE is not to claim a new fundamental law.

Its role is to prevent the global theory from quietly placing an indefinitely
expanding retained repertoire inside a finite vocabulary.

## 11. Moving finite envelopes

The correction is not to give a real system an infinite search set at each
moment.

Instead:

```text
U_t
```

is finite for every t.

The ambient capacity domain need not be finite.

A recursive process can therefore have:

```text
finite local search at every step
AND
no uniform finite upper bound on the effective horizons encountered over time.
```

For the strong operational-accumulation theorem, if the entire accumulated
repertoire is represented inside each relevant local envelope, then open-ended
accumulation forces the envelope capacities to be unbounded over time.

The active/history split shows why the representation assumption matters:
historical accumulation can be unbounded while the **currently active** set
remains bounded.

## 12. A sufficient recursive route

The strongest current operational route can be summarized as:

```text
one recursive-emergence seed
+ monotone active retention
+ finite local candidate envelopes
+ event-wise certified local successor existence
    -> arbitrarily many retained operational expansions.
```

A stronger event-level sufficient mechanism is:

```text
retained child
    -> operational primitive promotion
    -> essential downstream generative contribution
    -> finite admission
    -> next-envelope representation
    -> independent full filtering
    -> actual recursive successor.
```

This is a sufficient-condition architecture.

The theory does **not** currently derive that every retained primitive will
satisfy this chain.

That remains a mechanistic and empirical question.

## 13. What the theory says about self-maintenance

Other EbE formalizations study:

- persistence thresholds;
- maintenance;
- resource slack;
- cost geometry;
- accessibility;
- future search;
- functional ratchet velocity.

These can explain how maintained organization changes the budget or
accessibility conditions under which future responses become feasible.

But the formal firewall remains:

```text
more slack / better maintenance
-/-> automatically another validated recursive innovation.
```

The bridge from maintenance conditions into actual recursive successor
production must be supplied by a domain model or evidence.

This is a feature of the theory.

It prevents "capacity to innovate" from being defined as "innovation occurred."

## 14. Relationship to established science

The component ideas have strong antecedents.

The current theory should therefore be read as an attempted synthesis and
formal factorization.

Important neighbors include:

- Darwinian selection and evolutionary theory;
- open-ended evolution;
- adjacent-possible models;
- state-dependent dynamics;
- generative and hierarchical RAF theory;
- co-option and exaptation;
- modularity and evolvability;
- cumulative culture;
- technological recombination;
- major evolutionary transitions;
- niche construction;
- viability/reachability;
- complex adaptive systems;
- learning and adaptive networks.

Several of these literatures already contain recursive enabling:

```text
earlier organization makes later organization reachable.
```

Several already contain changing search spaces.

Several already contain retained building blocks.

EbE's current research question is whether the **explicit conjunction and
separation of interfaces** is useful enough to serve as a common audit language
across those fields.

## 15. What is machine checked

The Lean formalization currently checks, among other things:

- relative compositional emergence properties;
- separation of emergence from historical/model novelty;
- retained-emergence filtering;
- recursive parent reuse;
- configuration-level constructive projection to the weaker recursive event;
- strict generated-access expansion under the essential-parent
  counterfactual;
- finite admission to local envelopes;
- deterministic local successor-count equivalences;
- sufficient recursive closure under explicit continuation premises;
- finite-global saturation;
- moving-local-envelope correction;
- concrete non-vacuity witnesses;
- active/history separation with open-ended history under bounded active
  turnover;
- multiple countermodels preventing invalid converse claims.

Machine checking establishes deductive correctness relative to formal premises.

It does not establish:

- empirical truth;
- universality;
- novelty in the literature;
- moral value;
- or correctness of a real-world mapping.

## 16. What the theory does not say

EbE does not imply:

```text
novelty -> improvement
persistence -> function
validation -> truth
retention -> goodness
possibility -> realization
larger possibility space -> progress
self-maintenance -> innovation
open-ended retained novelty -> increasing complexity
historical accumulation -> ever-growing active repertoire
machine proof -> empirical validity.
```

It also does not derive a moral objective.

A society may choose goals such as health, peace, biodiversity conservation,
decarbonization, scientific knowledge, or prosperity for reasons outside this
formal theory.

EbE can then ask:

> What organization would have to be generated, validated, implemented,
> maintained, transmitted, and reused for that chosen outcome to become and
> remain real?

## 17. Why this matters for action

The most practical statement supported by the architecture is simple:

```text
possibility is not realization
and realization is not persistence.
```

A technically possible future does not materialize because it is desirable.

Knowledge of a problem does not construct its solution.

A desired outcome requires a causal chain capable of producing and maintaining
the relevant organization.

This applies whether the focal object is:

- an enzyme pathway;
- a public-health system;
- an energy grid;
- a scientific method;
- an institution;
- a skill;
- a technology;
- a cooperative network.

The formal theory does not tell us what to want.

It tells us not to confuse **wanting, possibility, generation, realization, and
maintenance**.

## 18. The central proposition

The candidate v17 theory can therefore be compressed to:

> **Organization that persists can become material for later organization.
> When retained products alter what can subsequently be generated, and when
> enough of those newly accessible possibilities are actually searched,
> realized, validated, and retained, organization can accumulate recursively.
> This accumulation is not automatic: every arrow is a process that can fail.**

That final sentence is as important as the recursive mechanism.

Emergence is not a promise that the future will appear.

The future still has to be built.
