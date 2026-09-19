# v17 formal-core peer-review protocol

Use this protocol for independent review of the candidate **Evolution by Emergence v17 formal core**.

The goal is not to ask whether a slogan is true. The goal is to localize defects.

Before broad review, the repository will provide an exact tagged commit. Until then, PR #60 is a moving draft and reviewers must record the exact commit SHA they inspected.

## Copy-paste reviewer prompt

```text
Act as an adversarial scientific peer reviewer of an exact commit of:

https://github.com/albertjanvanhoek/Evolution-by-Emergence

Resolve the supplied branch, PR, release, or commit to an exact commit SHA before analysis and report it.

PURPOSE OF THE REVIEW

Evolution by Emergence is not asking you to endorse a new universal law or a priority claim.

The candidate contribution under review is a machine-checked descriptive architecture for how retained organization can become reusable material that changes later organizational accessibility.

Your job is to determine whether:

1. the formal implications are correct;
2. the definitions mean what the prose says they mean;
3. an equal or stronger architecture already exists in the literature;
4. the factorization provides explanatory value;
5. the abstract interfaces can be mapped to real systems without arbitrary relabeling.

ACCESS GATE

Report:

REPOSITORY ACCESS: yes / no
EXACT COMMIT SHA: <sha / unresolved>
SOURCE-FILE ACCESS: yes / no
LEAN EXECUTION: yes / no
LITERATURE SEARCH: yes / no

If you cannot access the repository or exact files, do not invent file contents or theorem names.

CORE READING ORDER

README.md
THEORY_CORE_V17.md
FORMAL_THEORY_ENDPOINT.md
APPLICATION_MAPPINGS_V17.md
FORMAL_THEORY_MAP.md
CLAIMS.md
verification/audits/2026-09-19-recursive-emergence/THEOREM_INVENTORY.md
verification/audits/2026-09-19-recursive-emergence/ADVERSARIAL_REVIEW.md
verification/audits/2026-09-19-recursive-emergence/CLOSEST_ANTECEDENTS.md
verification/audits/2026-09-19-recursive-emergence/LITERATURE_DIFFERENCE_MATRIX.md

CORE LEAN FILES

formalization/cumulative-accessibility/CumulativeAccessibility/EmergentCapacity.lean
formalization/cumulative-accessibility/CumulativeAccessibility/VocabularyEmergence.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EmergencePersistenceBridge.lean
formalization/cumulative-accessibility/CumulativeAccessibility/RecursiveEmergence.lean
formalization/cumulative-accessibility/CumulativeAccessibility/ConstructiveRecursiveEmergence.lean
formalization/cumulative-accessibility/CumulativeAccessibility/ActiveHistory.lean
formalization/cumulative-accessibility/CumulativeAccessibility/RecursiveEmergenceOpenEnded.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EmergenceReproduction.lean
formalization/cumulative-accessibility/CumulativeAccessibility/LocalEmergenceReproduction.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousEnvelopePromotion.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EvolutionByEmergenceV17Core.lean
formalization/cumulative-accessibility/CumulativeAccessibility/AuditAll.lean
formalization/cumulative-accessibility/CumulativeAccessibility/VerificationSurface.lean

RECONSTRUCT THE THEORY BEFORE CRITICIZING IT

Reconstruct the logical direction of these layers:

A. compositional emergence
whole realizes capacity
+ no declared proper subconfiguration realizes it

B. filtered retained emergence
emergence
+ resource feasibility
+ declared external validation / selection
+ next-step operational retention

C. recursive reuse
currently active retained parent
+ generation / construction of later child
+ full later filtered event

D. essential-parent generated-access expansion
later candidate generable with promoted child
+ not generable when that child is removed from the same next-step repertoire
+ not generable from the pre-promotion repertoire
+ same next-step generator held fixed

E. finite local search
new generability
+ finite admission
+ next-envelope representation
+ full filtering
-> actual local successor

F. operational accumulation
seed
+ monotone active retention
+ sufficient event-wise local continuation
-> arbitrarily many strict active-repertoire expansions

G. historical accumulation
recurring genuinely history-new recursive events
+ monotone cumulative History
-> arbitrarily many strict History expansions
without requiring monotone Active

H. finite boundary
fixed finite cumulative operational universe
+ monotone strict accumulation
-> saturation

I. moving local envelope
finite U_t at every time
+ corrected local recursive continuation
-> operational accumulation
and, when the cumulative repertoire is represented in U_t, unbounded envelope cardinality over time

LOGICAL-DIRECTION RULE

For every theorem, write the implication explicitly.

If the theorem is A -> B, it establishes sufficiency, not necessity.

If a strong predicate contains much of the desired outcome, criticize its explanatory strength or modelling burden; do not call the Lean implication false unless the conclusion fails under the exact premises.

SEPARATIONS YOU MUST PRESERVE

compositional emergence != historical novelty
emergence != retention
validation != truth
novelty != improvement
generation != construction of the emergent configuration unless the stronger constructive interface is used
parent participation != essential parent contribution
essential contribution != sole causation
generability != finite admission
admission != realized filtered success
deterministic local R_E != stochastic branching reproduction number
operational accumulation != historical accumulation
unbounded history != unbounded active repertoire
moving envelope within one ambient Capacity type != strong unprestatable ontology creation
machine proof != empirical validation

FIVE REVIEW TARGETS

TARGET 1 — FORMAL VALIDITY

Try to find a theorem whose conclusion does not follow from its exact premises.
If you can execute Lean, run the advertised proof surface.
Distinguish source inspection, repository-reported CI, and independent execution.

TARGET 2 — SEMANTIC ADEQUACY

Attack whether the formal predicates capture the prose interpretations.
Pay special attention to:
- decomposition dependence of emergence;
- the stronger generated-configuration bridge;
- active repertoire versus cumulative history;
- external validation semantics;
- finite admission;
- the essential-parent counterfactual;
- uniform continuation as a strong premise.

TARGET 3 — PRIOR ART

Search specifically for an existing framework that already combines, at equal or greater precision:

generation / construction
+ emergence or new function
+ feasibility / viability filtering
+ validation / selection
+ retention
+ reusable parent material
+ essential contribution to later generability
+ finite search / admission
+ recursive successor continuation
+ finite-space saturation / moving accessibility.

Do not report a broad neighbor as an exact duplicate unless it actually supplies the same conjunction.
Conversely, if one framework does contain the conjunction more clearly, report it directly.

TARGET 4 — EXPLANATORY USEFULNESS

Ask whether separating the interfaces changes reasoning or measurement.
If the architecture merely renames existing concepts without improving comparison, diagnosis, prediction, or falsification, say so.

TARGET 5 — APPLICATION VALIDITY

Inspect APPLICATION_MAPPINGS_V17.md.
Try to map the definitions to a domain you know well.
Identify where the mapping becomes arbitrary, unobservable, circular, or domain-specific.
A failed mapping is a useful result.

KNOWN LOAD-BEARING SEAMS

Do not waste time rediscovering these as if hidden:

- event-wise continuation is a strong premise;
- finite admission is not universally derived;
- the mechanism ledger requires calibration to actual successors;
- the ambient Capacity type is weaker than strong ontology creation;
- resource slack does not automatically cause recursive innovation;
- the formal core does not derive moral goals.

You may argue that any of these seams is too strong for the theory to be useful.

LITERATURE NEIGHBORS THAT MUST BE CONSIDERED

- Darwinian selection / inheritance;
- open-ended evolution: Banzhaf, Taylor, Packard, Adams, Hernández-Orozco and related work;
- adjacent possible / triggering: Tria, Loreto, Servedio, Strogatz;
- changing phase spaces / enablement: Longo, Montévil, Kauffman;
- evolutionary novelty and co-option: Erwin and related evo-devo literature;
- evolvability / modularity: Wagner, Altenberg and related work;
- autocatalytic / generative RAF theory: Hordijk, Steel, Peng, Huson and colleagues;
- cumulative culture and cultural loss;
- technological recombination / building blocks;
- Winters & Charbonneau on co-evolving cultural systems and search spaces;
- viability / reachability;
- formal component construction and reuse.

OUTPUT FORMAT

1. Exact version and access report.
2. One-paragraph reconstruction of what the formal core actually claims.
3. Findings table with columns:
   - ID
   - category: theorem / definition / literature / mapping / empirical / interpretation
   - severity: blocking / major / moderate / minor / note
   - exact source / theorem
   - criticism
   - why it matters
   - concrete repair or narrowing.
4. Strongest part of the formal architecture.
5. Weakest load-bearing premise.
6. Closest prior framework you found.
7. One proposed empirical or domain mapping and whether it works.
8. Merge/review recommendation:
   - not ready for broad review;
   - ready for broad review with named caveats;
   - no blocking issue found.

Do not give an overall novelty score.
Do not praise the project for ambition.
Do not reject it merely because individual mechanisms are known.
Judge whether the exact integrated formal object is correct, honest about ancestry, and useful.
```

## Recommended allocation for a 100-reviewer round

Do not ask every reviewer to do everything.

A useful distribution is:

- **25 formal/mathematical reviewers** — Lean surface, logical direction, hidden assumptions, countermodels;
- **25 literature/domain-theory reviewers** — find equal or stronger antecedents in their fields;
- **25 application reviewers** — attempt mappings in biology, ecology, technology, culture, cognition, organizations, engineering, economics, etc.;
- **15 conceptual/semantic reviewers** — definitions of emergence, capacity, retention, history, accessibility, causation, open-endedness;
- **10 synthesis reviewers** — read across all layers and judge whether the architecture provides explanatory value.

Overlap is useful, but collecting reviewer expertise and review lane makes disagreements interpretable.

## What counts as success

The review round succeeds if criticism becomes localized.

Useful outcomes include:

- theorem defect;
- definition defect;
- stronger prior art;
- overclaim narrowed;
- mapping failure;
- missing measurement;
- empirical counterexample;
- clearer non-claim;
- simpler architecture;
- or no blocking problem found.

The purpose is not consensus. It is to make the next revision more correct and more legible.