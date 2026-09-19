# Closest antecedents to the v17 recursive-emergence candidate

**Date:** 19 September 2026  
**Status:** second-pass prior-art stress test  
**Purpose:** identify literature that most strongly challenges any broad novelty
claim for the #57-#59 recursive-emergence architecture.

This file deliberately prioritizes **close antecedents** over supportive
citations. The goal is to find the work that makes the strongest version of the
EbE novelty claim untenable, then state the narrower residue that survives.

## 1. Banzhaf et al. 2016 — open-ended novelty architecture already exists

**Reference**

Banzhaf W, Baumgaertner B, Beslon G, Doursat R, Foster JA, McMullin B,
de Melo VV, Miconi T, Spector L, Stepney S, White R.
*Defining and Simulating Open-Ended Novelty: Requirements, Guidelines, and
Challenges.* Theory in Biosciences. 2016;135:131-161.
doi:10.1007/s12064-016-0229-7.

**Why it matters**

This work already:

- distinguishes kinds of novelty, including variation, innovation, and
  emergence;
- supplies a meta-model for levels of structure;
- proposes an architecture for open-ended novelty-generating simulations;
- treats emergence and major transitions as part of the OEE design problem.

Therefore EbE should not imply that it is the first formal architecture to
separate different novelty classes or to place emergence inside an OEE
architecture.

**Residual difference**

EbE's potential difference is theorem-level decomposition of a narrower
retained-recursion route, including explicit filters, parent reuse,
essential-parent generated-access expansion, finite local admission, and
finite-global saturation.

**Classification:** strong antecedent; broad architecture claim not novel.

## 2. Taylor et al. 2016 — hallmarks and mechanisms must be separated

**Reference**

Taylor T, Bedau M, Channon A, et al.
*Open-Ended Evolution: Perspectives from the OEE Workshop in York.*
Artificial Life. 2016;22(3):408-423.
doi:10.1162/ARTL_a_00210.

**Why it matters**

The OEE community explicitly emphasized two points that map directly onto the
v17 audit:

1. there are multiple interesting forms of OEE;
2. observable hallmarks of OEE must be distinguished from proposed mechanisms
   that produce them.

That means EbE should not use one formal endpoint
(`OpenEndedCumulativeNovelty`) as if it were the single definition of
open-ended evolution.

**Residual difference**

EbE can present its endpoint as one precise retained-novelty hallmark and its
promotion/reproduction chain as one sufficient mechanism architecture for that
hallmark.

**Classification:** conceptual framework antecedent; supports narrower EbE
language.

## 3. Adams et al. 2017 — finite-system limits and state-dependent dynamics

**Reference**

Adams AM, Zenil H, Davies PCW, Walker SI.
*Formal Definitions of Unbounded Evolution and Innovation Reveal Universal
Mechanisms for Open-Ended Evolution in Dynamical Systems.*
Scientific Reports. 2017;7:997.
doi:10.1038/s41598-017-00810-8.

**Why it matters**

Adams et al. formally define unbounded evolution and innovation relative to
counterfactual isolated systems. They explicitly note the recurrence limitation
of finite deterministic isolated systems and study time-/state-dependent rules
as mechanisms enabling scalable OEE-like behavior.

This is a close antecedent to any generic claim:

```text
fixed finite closed dynamics cannot generate indefinite novelty;
ongoing open-endedness requires some changing/externalized dynamical structure.
```

PR #58 therefore should **not** sell the finite-global correction as discovery
of the general principle that fixed finite closed systems saturate or recur.

**Residual difference**

PR #58 proves a different, simpler and more specific counting result:

```text
monotone retained repertoire
inside fixed finite declared capacity universe
    -> finitely many strict retained-set expansions.
```

It then gives the exact local-envelope correction needed by the EbE recursive
certificate.

**Classification:** broad no-go principle known; EbE result is a
model-specific formal specialization and repository-corrective theorem.

## 4. Taylor 2019 — generation, evaluation, reproduction and expansive OEE

**Reference**

Taylor T.
*Evolutionary Innovations and Where to Find Them: Routes to Open-Ended
Evolution in Natural and Artificial Systems.*
Artificial Life. 2019;25(2):207-224.
doi:10.1162/artl_a_00290.

**Why it matters**

Taylor already formalizes three core evolutionary processes:

1. generation of phenotype from description;
2. evaluation of phenotype;
3. reproduction with variation according to evaluation.

He distinguishes exploratory, expansive, and transformational open-endedness,
and argues that the latter forms depend on features such as multiple behavior
domains, transdomain bridges, non-additive composition, and properties of the
building blocks and environment.

This is close to the EbE insistence that "generation", "validation", and later
evolutionary effects must not be collapsed.

**Residual difference**

EbE's event surface adds a different decomposition oriented around retained
organization:

```text
compositional capacity realization
+ resource feasibility
+ external validation
+ retention
+ explicit later parent reuse
+ essential-parent test
+ finite admission
+ successor existence.
```

The difference is in the exact interfaces and theorem composition, not in the
general insight that generation/evaluation/reproduction are separable.

**Classification:** very close formal-conceptual antecedent.

## 5. Taylor 2021 — persistent systems and hierarchical systems building

**Reference**

Taylor T.
*Evolutionary Innovation Viewed as Novel Physical Phenomena and Hierarchical
Systems Building.* OEE4 / ALIFE 2021 workshop.
arXiv:2107.09669.

**Why it matters**

This is one of the strongest conceptual challenges to an EbE novelty claim.

Taylor proposes that evolutionary innovations can be understood as:

- capturing previously unused physical phenomena; or
- creating **new persistent systems within the environment**.

That second route is strikingly close to the EbE idea that a realized and
retained organization becomes a reusable primitive that can alter later
possibilities.

Therefore the verbal thesis

```text
persistent organization is created
-> it becomes part of the environment / construction substrate
-> later systems can be built using it
-> hierarchical evolutionary novelty becomes possible
```

cannot be claimed as uniquely EbE.

**Residual difference**

The possible EbE residue is narrower and formal:

- compositional emergence is explicitly defined relative to decomposition;
- retention is separated from realization;
- a designated retained child must later be reused;
- PR #59 strengthens reuse to an **essential-parent** counterfactual test under
  a fixed next-step generator;
- generated possibilities are separated from finite admission;
- admission is separated from filtered retained success;
- the recursive successor relation is counted locally;
- global finite saturation and moving-local correction are machine checked.

**Classification:** strongest conceptual antecedent found so far; narrows EbE
to a formal sharpening / decomposition claim.

## 6. Tria et al. 2014 — adjacent-possible triggering is already mathematical

**Reference**

Tria F, Loreto V, Servedio VDP, Strogatz SH.
*The dynamics of correlated novelties.*
Scientific Reports. 2014;4:5890.
doi:10.1038/srep05890.

**Why it matters**

The urn-with-triggering model directly implements the principle:

```text
novelty occurs
-> new possibilities become available
-> the sampled possibility space expands.
```

This is a direct mathematical antecedent to any generic "novelty opens novelty"
claim.

**Residual difference**

PR #59 does not make envelope expansion definitional. It inserts a causal and
operational sequence:

```text
retained primitive
-> essential new generability
-> finite admission
-> envelope representation
-> independent full-event filtering.
```

That may be a useful decomposition, but it is not discovery of the expanding
adjacent possible.

**Classification:** direct mechanism antecedent; EbE may sharpen the event
factorization.

## 7. Winters & Charbonneau 2026 — cultural systems and search spaces co-evolve

**Reference**

Winters J, Charbonneau M.
*Modelling the emergence of open-ended cultural evolution.*
Philosophical Transactions of the Royal Society B. 2026;381:20250255.
doi:10.1098/rstb.2025.0255.

An earlier 2025 preprint circulated under the title *Modelling the emergence of open-ended technological evolution* (arXiv:2508.04828).

**Why it matters**

This recent model is unusually close to the high-level EbE story. It treats
technological systems as repertoires of interdependent skills, techniques, and
artifacts, search spaces as needs/problems/goals, and studies open-ended growth
when technological systems and search spaces **co-evolve**. The model also
retains resource production and selection-like maintenance in the story.

Therefore neither

```text
evolving repertoire <-> evolving search space
```

nor the addition of resources/maintenance to that picture is enough for a
strong novelty claim.

**Residual difference**

The current EbE stack is not primarily a macro-dynamical simulation. It is a
Lean-checked sufficient-condition architecture with explicit event interfaces
and countermodels. The published Winters-Charbonneau model is nevertheless a
particularly important contemporary comparison because it explicitly represents
both the evolving cultural repertoire and the evolving search space, and embeds
resource production and selection-like maintenance in that co-evolution.

A useful future comparison is to ask whether EbE's event-level decomposition can
be instantiated inside or used to analyze the Winters-Charbonneau model.

**Classification:** very close contemporary modeling antecedent; important for
reviewer positioning.

## 8. Longo, Montévil & Kauffman — changing phase spaces can be a stronger claim

**References**

Longo G, Montévil M, Kauffman S.
*No entailing laws, but enablement in the evolution of the biosphere.*
GECCO Companion 2012:1379-1392.
doi:10.1145/2330784.2330946.

Longo G, Montévil M.
*Extended criticality, phase spaces and enablement in biology.*
Chaos, Solitons & Fractals. 2013;55:64-79.
doi:10.1016/j.chaos.2013.03.008.

**Why it matters**

This literature argues for evolving pertinent observables and biological phase
spaces, potentially including possibilities that cannot be prestated.

The current EbE moving-envelope formalization is **weaker**:

```text
one ambient Capacity type
+ finite local envelopes
+ unbounded envelope cardinality over time.
```

That is not the same as formal creation of previously undefinable types.

**Residual difference**

EbE gains machine tractability and explicit local finiteness, but should not
equate its result with strong unprestatability.

**Classification:** stronger conceptual neighbor on ontology/phase-space change.

## 9. Generative RAFs — recursive enabling has a strong formal antecedent

**References**

Steel M, Hordijk W.
*Tractable models of self-sustaining autocatalytic networks.*
J Math Biol / related preprint lineage, 2018.
arXiv:1801.03953.

Huson DH, Xavier JC, Steel M.
*Self-generating autocatalytic networks: structural results, algorithms and
their relevance to early biochemistry.*
J R Soc Interface. 2024;21:20230732.
doi:10.1098/rsif.2023.0732.

**Why it matters**

Generative RAF theory explicitly studies autocatalytic sets that can be built
up from simpler RAFs. The newer structural work also analyzes when certain
reactions must occur before others in an F-generated or RAF system.

This is a particularly strong formal antecedent to the broad EbE idea:

```text
earlier organized structure
    -> supplies conditions/material for later organized structure
    -> hierarchical recursive construction.
```

Therefore EbE should not claim priority for recursive hierarchical enabling,
self-generating organization, or the idea that an earlier self-sustaining
network can make a later one reachable.

**Residual difference**

The current EbE stack asks a differently factorized question across arbitrary
capacity domains:

- did the whole realize a declared capacity emergently?
- was the event resource feasible?
- did it pass an external/application criterion?
- was it operationally retained?
- was the retained product explicitly reused later?
- was it essential to the later generated-access expansion under a fixed
  generator?
- which newly enabled candidates entered finite local search?
- which survived the next full filter?
- does event-wise continuation force cumulative retained novelty?
- what finite-universe consistency boundary follows?

Generative RAF theory may instantiate several of these interfaces in chemistry,
but the EbE architecture should be presented as a cross-domain decomposition,
not as a competing theory of autocatalytic generation.

**Classification:** very strong formal antecedent for recursive enabling;
potential EbE residue is the broader factorization and machine-checked
separation of interfaces.

## 10. Existing EbE-adjacent literature already identified in the repository

The September 15 audit remains relevant:

- autocatalytic/RAF hierarchy already supplies retained historical enabling;
- cumulative-culture theory already contains ratchet/retention logic;
- niche construction already contains history-generated future constraints;
- technological evolution already contains recombinant building-block logic;
- viability/reachability already supplies constrained-accessibility mathematics;
- reproduction thresholds and branching/next-generation methods are mature.

The v17 audit therefore **inherits**, rather than resets, the conservative
position of the existing literature audit.

## 11. Targeted search for proof-assistant antecedents

A targeted search was run for Lean, Coq/Rocq, Isabelle, and generic proof
assistant formalizations of:

- open-ended evolution;
- adjacent-possible expansion;
- evolutionary novelty;
- cumulative innovation.

The searches did **not surface a clear proof-assistant antecedent** to the
specific #57-#59 theorem chain.

This should be stated only as:

> no clear antecedent was located in the targeted search.

It must **not** be converted into:

> none exists.

Formal methods literature is large, terminology varies, and absence from the
search results is not evidence of priority.

## 12. Revised novelty ladder

After the second pass, the claims should be ordered from safest to riskiest.

### High-confidence defensible

1. The repository contains a reproducible Lean formalization of the stated
   event/reproduction architecture.
2. It machine-checks the finite-global saturation conflict in its own retained
   repertoire semantics.
3. It machine-checks a corrected finite-local moving-envelope sufficient
   condition.
4. It machine-checks separation countermodels that prevent several common
   inference collapses.
5. It machine-checks an essential-parent generated-access expansion under a
   fixed generator.

These are claims about **this formal object**.

### Plausible but needs priority review

6. The exact combination of:
   - compositional emergence;
   - resource/validation/retention filtering;
   - operational promotion;
   - essential-parent counterfactual reuse;
   - finite admission;
   - local deterministic successor reproduction;
   - finite-global saturation;
   - moving-local recursive closure
   may be a useful formal sharpening not previously assembled in this exact
   way.

This is the main surviving literature question.

### Not defensible as novelty claims

Do not claim invention of:

- open-ended evolution;
- persistent systems building persistent systems;
- novelty opening an adjacent possible;
- evolving search spaces;
- reusable evolutionary/technological building blocks;
- retention-based ratchets;
- co-option;
- hierarchy;
- autocatalytic enabling;
- major transitions;
- finite closed-system limits on indefinite novelty;
- or the general idea that state-dependent dynamics can support ongoing novelty.

## 13. Revised reviewer-facing sentence

A stronger reviewer-safe formulation after the second pass is:

> **Evolution by Emergence is not proposed as the first theory in which
> innovations expand future possibilities or persistent systems become building
> blocks for later evolution. Those ideas have strong antecedents in
> open-ended-evolution, adjacent-possible, hierarchical-systems,
> autocatalytic, cumulative-culture, and technological-evolution research. The
> contribution under review is narrower: a machine-checked sufficient-condition
> architecture that factorizes one retained recursive route into explicit
> realization, filtering, operational promotion, essential parent reuse,
> finite admission, successor reproduction, and finite-versus-moving-envelope
> conditions, together with checked separation countermodels. Whether that exact
> factorization constitutes a novel formal contribution remains a priority
> question, not an assumption.**

## 14. Immediate consequence for PR #60

The integration PR should not yet rewrite the repository around a claim of a
new universal theory.

The next tasks should be:

1. compare the exact EbE predicate chain against Taylor's formalism in detail;
2. compare the local-envelope/repertoire semantics against
   Winters-Charbonneau's co-evolving technological/search-space model;
3. search process-calculus, Petri-net, category-theoretic, RAF, and formal
   methods literature for an exact generation-filter-retention-reuse
   factorization;
4. run an adversarial circularity audit of the continuation premises;
5. only then decide what wording deserves to become canonical in `THEORY.md`.
