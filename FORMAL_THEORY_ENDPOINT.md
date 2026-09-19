# Formal theory endpoint for Evolution by Emergence

**Date:** 19 September 2026  
**Status:** target specification for the v17 formal theory  
**Purpose:** define when the formal core is mature enough to stand on its own and
be sent for broad independent peer review.

## 1. The purpose of the formal theory

The purpose of the formal theory is **not** to win a novelty claim.

It is not necessary that the main ideas be new. In fact, a stronger outcome is
possible when the framework can show that its component mechanisms are already
well supported across existing literatures.

The purpose is to provide a stable, explicit, auditable foundation for the
larger Evolution by Emergence project:

> **a formal account of how organized processes persist, change, generate new
> organization, retain useful changes, and thereby alter what can be generated
> next.**

The formal core should make the essays, conceptual arguments, applications, and
empirical proposals easier to evaluate because their descriptive assumptions
can be traced back to a small set of explicit mechanisms.

The formal theory should therefore function like an **intellectual load-bearing
structure**. It should not contain every implication developed elsewhere in the
repository. It should state the minimum architecture those implications may
legitimately build on.

## 2. What “stand on its own feet” means

The theory stands on its own feet when a technically competent reader can read
the formal core without reading the essays and answer:

1. What are the primitive objects?
2. What is assumed?
3. What follows deductively?
4. What does not follow?
5. Which mechanisms are imported from established fields?
6. Which parts are merely interfaces awaiting domain-specific instantiation?
7. Why does the architecture need emergence, retention, reuse, resources,
   validation, and changing accessibility as separate concepts?
8. What countermodels show that tempting stronger conclusions are invalid?
9. How can the theory be instantiated in a biological, technological,
   cognitive, social, or engineered system without changing its logic?
10. What observations would show that a proposed real-world mapping is wrong?

If those questions cannot be answered from the formal-theory package itself,
the package is not yet self-standing.

## 3. The intended descriptive thesis

The formal theory should support the following descriptive thesis, and no
stronger one unless a theorem explicitly warrants it:

> **Persistent organized systems are maintained by processes. Some changes in
> organization create capacities not realized by the declared parts alone. If a
> new capacity passes the relevant feasibility and selection/validation filters
> and is retained, it can become reusable material for later generation.
> Reusable retained organization can change what is accessible next. When this
> process recursively continues, cumulative retained novelty can occur. A fixed
> finite effective repertoire necessarily saturates; indefinite cumulative
> novelty therefore requires the effective space of distinguishable accessible
> capacities not to remain uniformly bounded.**

This is a theory of **conditional recursive organization**, not a theorem that
all systems evolve this way.

## 4. The causal grammar the theory must make explicit

The core should expose the following grammar:

```text
existing organization
    -> generation / recombination / transformation
    -> candidate organization
    -> capacity realization
    -> compositional emergence, if the whole realizes what proper parts do not
    -> resource feasibility
    -> external/domain validation or selection
    -> retention
    -> operational availability as reusable material
    -> changed downstream generability
    -> finite local search / admission
    -> next candidate event
    -> ...
```

The important point is not that every arrow always occurs.

The theory must show which arrows are:

- definitions;
- checked implications;
- sufficient conditions;
- application-specific assumptions;
- empirical questions.

A major function of the formalization is to prevent prose from silently
collapsing several arrows into one.

## 5. The minimum canonical theorem set

The v17 core is sufficient when it has one small, stable theorem spine covering
the following claims.

### T1 — relative compositional emergence

A declared configuration realizes a capacity and no declared proper
subconfiguration realizes that same capacity.

The theory must make explicit that this is relative to decomposition, context,
and realization semantics.

### T2 — filtered retained emergence

Compositional emergence by itself does not imply persistence.

A retained emergent event must separately satisfy the declared feasibility,
validation/selection, and retention conditions.

### T3 — retained products can become reusable generative material

A retained child can later participate in generation of another capacity.

The preferred strong version should distinguish:

- mere participation;
- essential contribution under a declared counterfactual;
- and, where possible, construction of the actual configuration witnessing the
  later emergent capacity.

### T4 — reuse can change future accessibility

Under explicit assumptions, adding retained reusable organization can strictly
expand a declared generated-access relation.

This theorem must hold generator change and parent-material change apart unless
their interaction is explicitly modeled.

### T5 — possibility, search, and realization are distinct

The theory must distinguish:

- all generable possibilities;
- the finite set admitted to local search/attention;
- realized candidates;
- validated/selected candidates;
- retained candidates.

A larger possibility space alone must not imply realized progress.

### T6 — local recursive continuation is sufficient for cumulative retained novelty

A seed recursive event plus monotone retained accumulation and a sufficient
event-wise continuation condition implies arbitrarily many strict retained
repertoire expansions.

The continuation condition must be displayed as a premise, not presented as if
it were derived automatically from emergence.

### T7 — fixed finite effective capacity saturates

A monotonically accumulating retained repertoire inside a fixed finite declared
capacity universe can undergo only finitely many strict expansions.

This is a consistency boundary, not a claim of novel mathematics.

### T8 — finite local horizons can coexist with unbounded cumulative accessibility

The ambient capacity space need not be globally finite.

A sequence of finite local candidate envelopes can support the recursive theorem
without assuming an infinite search surface at any one time.

When the accumulated repertoire is represented in those envelopes, open-ended
retained novelty implies that the envelope cardinalities cannot remain uniformly
bounded.

### T9 — non-vacuity

At least one explicit machine-checked model must jointly satisfy the corrected
premises.

The witness proves consistency, not empirical realism.

### T10 — separation results

The core should retain explicit countermodels showing, at minimum:

```text
emergence            -/-> retention
promotion            -/-> downstream generative expansion
generability         -/-> admission
admission             -/-> successful realization
ledger R_E >= 1       -/-> actual successor without calibration
expanding envelope    -/-> realized novelty
self-maintenance      -/-> automatic recursive continuation
novelty              -/-> improvement
retention             -/-> truth
```

These negative results are part of the theory, not optional caveats.

## 6. The two boundaries the theory must preserve

### 6.1 Descriptive versus normative

The formal theory should explain how organization can be maintained, changed,
and recursively accumulated.

It does **not** by itself determine what humans ought to maintain, build, or
value.

For example, the theory may support the descriptive statement:

> Desired outcomes do not materialize merely because they are possible; they
> require processes that generate, select, realize, maintain, and reproduce the
> necessary organization.

But deciding that climate stabilization, biodiversity, health, peace,
scientific knowledge, or another goal **ought** to be pursued requires an
explicit value or collective objective plus domain-specific evidence.

The formal theory can then help analyze the organizational requirements for
making that chosen goal real.

This distinction makes the essays stronger, not weaker. It prevents the formal
core from being asked to smuggle values out of descriptive dynamics.

### 6.2 Universal architecture versus domain mechanism

The formal core should be substrate-agnostic.

A biological, technological, neural, institutional, or cultural application
must still specify what counts as:

- configuration;
- capacity;
- realization;
- resource budget;
- external criterion;
- retention;
- generator;
- active repertoire;
- candidate envelope;
- admission process.

A successful application is therefore a **model mapping**, not merely an
analogy.

## 7. What the formal core should borrow rather than reinvent

Where established work already exists, the theory should cite and reuse it.

The core does not need priority over:

- Darwinian selection;
- open-ended evolution;
- the adjacent possible;
- cumulative-culture ratchets;
- co-option and exaptation;
- evolvability and modularity;
- autocatalytic/RAF theory;
- major evolutionary transitions;
- niche construction;
- viability and reachability;
- reproduction-number / branching mathematics;
- technological recombination;
- changing search-space or phase-space theories;
- resource-limited maintenance;
- learning and adaptive networks.

The goal is to identify how these mechanisms fit together and where their
assumptions differ.

A mature EbE theory should be able to say:

> **this component is standard; this theorem specializes it; this interface
> connects it to the rest of the architecture; this is the consequence of the
> composition.**

That is sufficient scientific value even when no component is original.

## 8. What should remain outside the formal core

The formal core should not expand until it contains every idea in the
repository.

The following belong in application, implication, or research layers unless
they become necessary for the core theorem spine:

- ethical or political conclusions;
- climate-policy prescriptions;
- human relationship advice;
- detailed theories of cooperation;
- corrigibility norms;
- psychological interpretations;
- governance architectures;
- claims about intelligence or consciousness;
- empirical claims about specific diseases, ecosystems, economies, or
  technologies;
- specific “verbs” for intelligent networks;
- claims of historical directionality or progress;
- claims that one social arrangement is morally superior.

Those works may be **underpinned** by the core when their descriptive premises
map onto it, but they should not be embedded into the proof kernel.

## 9. The role of the essays after the formal endpoint

The essays should become a layered family of arguments:

```text
formal core
    -> domain mapping
    -> domain-specific evidence
    -> implication
    -> where relevant: explicit normative premise
    -> recommendation / interpretation
```

This creates traceability.

A reviewer should be able to disagree with an essay at the domain-mapping,
empirical, interpretive, or normative layer without thereby refuting the formal
core.

Likewise, a proof in the formal core should not be used as a shortcut around a
missing empirical or normative premise in an essay.

## 10. The strongest useful interpretation

If the formal core survives review, the broadest interpretation it should
support is:

> **Organization is not self-materializing. Possibility is not realization.
> Persistence is not automatic. Retained organization must be continually
> instantiated by processes, and future capability depends partly on which
> organization has actually been built, maintained, made available, and reused.
> Evolutionary and developmental change therefore acts not only on existing
> entities but also on the accessibility structure from which later entities
> can be generated.**

This statement is intentionally compatible with established evolutionary,
ecological, cultural, technological, and complex-systems science.

It is a unifying lens, not a replacement for those fields.

## 11. Readiness criterion for broad peer review

The theory is ready to send to approximately 100 independent reviewers when
**all** of the following are true.

### A. Formal closure

- all canonical theorems compile;
- the formal-core CI rejects unproved axioms / `sorryAx`;
- the canonical theorem graph has no known circular import or semantic
  dependency problem;
- every major forward implication has either an explicit proof or is clearly
  labelled a modelling premise;
- the principal certificate is inhabited by at least one concrete witness;
- known tempting converses have explicit countermodels where feasible.

### B. Semantic closure

- every central term has one canonical definition;
- "emergence", "novelty", "capacity", "retention", "validation", "reproduction",
  "envelope", "accessibility", and "open-ended" are not used in mutually
  incompatible senses;
- the generated-capacity versus emergent-configuration seam has either been
  formally bridged or prominently declared;
- active repertoire versus historical cumulative trace has either been
  separated or monotone retention is explicitly declared as the v17
  idealization;
- strong representational/ontological novelty is clearly distinguished from the
  current ambient-type moving-envelope theorem.

### C. Literature closure

- the nearest antecedent is named for every central mechanism;
- no component is claimed as new merely because it has EbE notation;
- the exact remaining contribution is stated conservatively;
- at least one adversarial reviewer has been asked specifically to find an
  existing framework containing the same full factorization;
- any discovered stronger antecedent has been incorporated rather than argued
  away.

### D. Explanatory closure

A reader can understand why each layer exists.

The theory should answer:

```text
Why emergence?
Why retention?
Why reusable parent material?
Why resources?
Why validation/selection?
Why finite admission?
Why a moving envelope?
Why local reproduction?
Why saturation?
```

If removing a layer changes no theorem or interpretation, that layer should be
removed or demoted.

### E. Application firewall

At least two substantially different worked mappings should be documented, for
example one biological and one technological/cultural/engineered application.

The mappings need not prove the theory universally.

Their purpose is to demonstrate that the abstract interfaces can be
operationalized without changing definitions ad hoc.

At least one **failed or partial mapping** is also valuable: it should show where
a domain does not satisfy the premises.

### F. Reviewer usability

A reviewer landing on the repository should have a short path:

```text
README
 -> 2-5 page THEORY CORE
 -> theorem map
 -> literature positioning
 -> assumptions/non-claims
 -> machine-verification instructions
 -> applications
 -> full essays
```

A reviewer should not need to reconstruct the theory from PR history.

### G. Stability

Before the 100-reviewer release:

- freeze the core definitions for a review window;
- do not add another conceptual layer unless it fixes a demonstrated defect;
- assign stable theorem/claim IDs;
- tag the exact reviewed commit;
- archive the literature audit and known-open-questions list;
- make later revisions visible as revisions rather than silently changing the
  object under review.

## 12. The 100-reviewer test

The question for the first broad review should not be:

> “Is Evolution by Emergence true?”

That is too vague.

Reviewers should be asked to attack five concrete targets:

1. **Internal validity:** Do the formal conclusions actually follow from the
   stated assumptions?
2. **Semantic adequacy:** Do the definitions capture the intended concepts
   without hiding conclusions in premises?
3. **Prior art:** Does an existing theory already contain the same full
   architecture more clearly or more strongly?
4. **Explanatory usefulness:** Does the factorization clarify anything that is
   obscured when the parent literatures are kept separate?
5. **Applicability:** Can the interfaces be mapped to real systems without
   arbitrary choices or post-hoc relabeling?

A strong outcome is not universal agreement.

A strong outcome is that disagreement becomes **localized**:

- theorem defect;
- definition defect;
- literature-priority correction;
- mapping failure;
- empirical failure;
- interpretation dispute;
- normative disagreement.

That localization is one of the main reasons for building the formal core.

## 13. Definition of “sufficient confidence”

Sufficient confidence for broad peer review does **not** mean believing the
theory is correct in every domain.

It means:

> **we no longer know of an internal contradiction, hidden theorem assumption,
> obvious stronger antecedent, ambiguous core term, or missing distinction that
> would predictably waste reviewers' time.**

At that point, criticism from 100 external readers becomes more valuable than
another internal round of refinement.

The threshold is therefore not certainty.

It is **review maturity**.

## 14. Current status against the endpoint

As of the PR #60 audit:

**Already strong**

- machine-checked event and recursion surfaces;
- explicit no-`sorryAx` CI;
- non-vacuity witnesses;
- multiple separation countermodels;
- finite-global saturation correction;
- corrected moving local envelope;
- operational versus representational vocabulary distinction;
- explicit finite admission seam;
- essential-parent counterfactual under fixed generator;
- conservative literature positioning.

**Still open before broad review**

1. decide whether to add the generated-configuration bridge;
2. decide how to handle active repertoire versus cumulative history;
3. finish the closest-antecedent search for the exact full factorization;
4. refactor the canonical Lean dependency/core surface;
5. write the short self-standing theory core;
6. provide at least two worked domain mappings and one limitation/failure case;
7. rewrite the repository entry points around the final stable core;
8. freeze and tag the exact review object.

## 15. The endpoint in one sentence

> **Evolution by Emergence is ready for broad peer review when it is a
> self-contained, machine-auditable, literature-positioned theory of how
> retained organization can recursively alter future organizational
> accessibility, with its assumptions, limits, countermodels, and application
> interfaces explicit enough that reviewers can disagree with precise parts
> rather than with a slogan.**
