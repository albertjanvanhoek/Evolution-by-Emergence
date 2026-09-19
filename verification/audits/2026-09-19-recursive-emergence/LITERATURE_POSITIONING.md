# Recursive emergence after literature contact

**Date:** 19 September 2026  
**Status:** adversarial positioning audit in progress  
**Object under review:** PR #57 -> #58 -> #59, frozen initially at
`16812e8f306c783efc96c2e61c289343e3326e6c`

## Executive assessment

The current recursive-emergence stack should **not** be presented as discovering
open-ended evolution, the adjacent possible, co-option, modular reuse,
autocatalytic hierarchy, cumulative culture, technological recombination, or
changing evolutionary possibility spaces. All of those have substantial prior
literatures.

The strongest candidate contribution is narrower:

> **a machine-checked factorization of one sufficient route from retained
> emergent organization to recursively cumulative novelty, with explicit
> theorem-level separation of operational promotion, essential-parent
> generative expansion, finite local admission, filtering, deterministic local
> successor reproduction, finite-global saturation, and moving-envelope
> open-endedness.**

A targeted first-pass search did not locate an antecedent that packages this
exact conjunction with the same separation lemmas and finite-global/local
correction. That is **not proof of priority**. It is the residue that deserves
deeper specialist checking.

The project should therefore continue to use the repository's conservative
default:

```text
established mechanisms
    + exact model-specific theorems
    + explicit interfaces
    + machine-checked composition
    = candidate architecture / synthesis
```

not:

```text
new universal evolutionary law.
```

## 1. What the current formal object actually contains

### 1.1 Compositional emergence

`EmergentCapacity.lean` defines a capacity as emergent relative to a declared
configuration decomposition when the whole realizes it and no declared proper
subconfiguration does.

This is a **relative formal criterion**, not a metaphysical proof of strong
emergence.

It deliberately does not imply:

- historical novelty;
- model surprise;
- usefulness;
- persistence;
- validation;
- improvement.

### 1.2 Operational and representational vocabulary expansion

`VocabularyEmergence.lean` separates:

- operational novelty: a capacity was not active and becomes active/reusable;
- representational novelty: a capacity lies outside an explicitly embedded old
  representational vocabulary.

The recursive theory currently relies primarily on the **operational** notion.

This distinction is important when comparing EbE to literature arguing that
evolution changes its own phase space. The current moving-envelope formalism
does not yet prove creation of genuinely new mathematical types.

### 1.3 Filtered retained emergence

`EmergencePersistenceBridge.lean` conjoins emergence with:

- resource feasibility;
- external validation;
- actual next-step retention.

The result is intentionally conditional. Emergence alone does not cause
retention.

### 1.4 Recursive parent reuse

`RecursiveEmergence.lean` requires an earlier retained child to appear
explicitly in the finite parent set generating a later child.

This makes the recursion stronger than merely observing successive novelties.

### 1.5 Recurrent recursion and open-ended retained novelty

`RecursiveEmergenceOpenEnded.lean` proves that recurrent recursive-emergence
events plus monotone retention imply arbitrarily many strict retained repertoire
expansions.

The formal endpoint is **open-ended cumulative retained novelty**, not
unbounded complexity or adaptive progress.

### 1.6 Effective emergence reproduction

`EmergenceReproduction.lean` introduces a deterministic count of immediate
effective recursive successors and a mechanism ledger.

The actual successor count and the ledger are kept separate. A calibration
interface is required before a ledger lower bound can certify actual
successors.

### 1.7 Finite-global no-go and moving-envelope correction

PR #58 proves that the globally finite specialization cannot serve as the
state-space assumption of an indefinitely open-ended monotonically retained
process.

It then defines local successor reproduction inside finite moving envelopes
`U_t`, without requiring the ambient `Capacity` type to be finite.

Under the corrected certificate:

```text
seed + local critical reproduction + retention
    -> open-ended cumulative retained novelty

and, with S_t subseteq U_t,
    -> unbounded envelope capacity.
```

A progressive construction explicitly inhabits the certificate.

### 1.8 Endogenous envelope movement by primitive promotion

PR #59 adds a stronger sufficient mechanism.

A retained child is promoted to operational primitive status. A downstream
candidate is attributed to that primitive only when:

1. the child is explicitly used as a parent;
2. the candidate is not generable after removing that child from the same
   next-step retained repertoire;
3. the candidate was not generable from the pre-promotion repertoire;
4. the generator is held fixed at the same next-step rule.

This establishes strict generated-access expansion attributable to the promoted
primitive in the declared model.

A finite `PromotionAdmissionPolicy` then selects which newly enabled
possibilities enter the local search horizon. Admission is explicitly not the
same as the full generative closure.

Finally, the candidate must independently pass emergence, resource, validation,
and retention filters before it becomes an actual local recursive successor.

## 2. What this is not

The current formalization is **not** a proof of:

- universal open-ended evolution;
- increasing organismal or technological complexity;
- universal adaptive progress;
- universal natural selection for evolvability;
- a stochastic survival theorem;
- a new general reproduction-number theory;
- complete endogenization of the search space;
- automatic generation of novelty from self-maintenance;
- strong ontological/vocabulary emergence;
- unprestatability of future states;
- a physical theory of infinite state-space creation;
- objective truth from external validation;
- or empirical applicability to any domain without a separate mapping.

The progressive witness proves joint satisfiability/non-vacuity, not empirical
realism.

Monotone retention is a strong abstraction. Systems with extinction, forgetting,
replacement, destructive innovation, or repertoire compression require either a
different retained object or a generalized theory.

## 3. Literature comparison

### 3.1 Open-ended evolution

**Closest literature**

- Taylor T, Bedau M, Channon A, et al. *Open-Ended Evolution: Perspectives from
  the OEE Workshop in York.* Artificial Life. 2016;22(3):408-423.
  doi:10.1162/ARTL_a_00210.
- Taylor T. *Evolutionary Innovations and Where to Find Them: Routes to
  Open-Ended Evolution in Natural and Artificial Systems.* Artificial Life.
  2019;25(2):207-224. doi:10.1162/artl_a_00290.
- Packard N, Bedau M, Channon A, et al. *An Overview of Open-Ended Evolution.*
  Artificial Life. 2019;25(2):93-103. doi:10.1162/artl_a_00291.
- Corominas-Murtra B, Seoane LF, Solé RV. *Zipf's law, unbounded complexity and
  open-ended evolution.* J R Soc Interface. 2018;15:20180395.
  doi:10.1098/rsif.2018.0395.

**Already known**

OEE is a mature research problem. The literature explicitly distinguishes
different forms of open-endedness and discusses mechanisms involving changes in
the effective search/phenotypic space, evolutionary innovations, building
blocks, environmental structure, and major transitions.

Taylor's exploratory/expansive/transformational distinction is especially close
to EbE's concern with movement inside a space versus changes that alter what can
subsequently be generated.

**EbE difference**

EbE's current formal endpoint is narrower than many OEE definitions:
arbitrarily many strict retained repertoire expansions. Its potential
contribution is not a new definition of OEE but a machine-checked sufficient
architecture for one retained recursive route, with explicit filtering and
saturation boundaries.

**Provisional classification:** synthesis + exact formal specialization.

### 3.2 Adjacent possible and innovation triggering

**Closest literature**

- Tria F, Loreto V, Servedio VDP, Strogatz SH. *The dynamics of correlated
  novelties.* Scientific Reports. 2014;4:5890. doi:10.1038/srep05890.
- Tria F, Loreto V, Servedio VDP. *Zipf's, Heaps' and Taylor's Laws are
  Determined by the Expansion into the Adjacent Possible.* Entropy.
  2018;20:752. doi:10.3390/e20100752.

**Already known**

These models explicitly implement the idea that realizing novelty can trigger
new possibilities and dynamically enlarge the effective sample space. The urn
model with triggering is a direct mathematical antecedent to any generic claim
that novelty opens further novelty.

**EbE difference**

PR #59 does not merely stipulate "novelty adds new colors." It decomposes one
possible causal bridge:

```text
retained child
 -> reusable primitive
 -> essential contribution to downstream generability
 -> finite admission
 -> local representation
 -> independent survival filters.
```

The generated-access attribution holds the generator fixed and removes the
promoted parent as a counterfactual local test.

The admission layer also refuses to equate a finite local horizon with the full
set of newly generable possibilities.

**Provisional classification:** close conceptual antecedent; possible formal
sharpening in the decomposition, not novelty of adjacent-possible expansion.

### 3.3 Changing phase spaces and enablement

**Closest literature**

- Longo G, Montévil M, Kauffman S. *No entailing laws, but enablement in the
  evolution of the biosphere.* GECCO Companion 2012:1379-1392.
  doi:10.1145/2330784.2330946.
- Longo G, Montévil M. *Extended criticality, phase spaces and enablement in
  biology.* Chaos, Solitons & Fractals. 2013;55:64-79.
  doi:10.1016/j.chaos.2013.03.008.

**Already known**

This literature explicitly argues that biological evolution can change the
pertinent phase space itself and that future biological possibilities may not
be prestated.

**EbE difference and limitation**

EbE currently uses a possibly infinite ambient `Capacity` type plus finite
time-local envelopes. This is mathematically tractable and enough for an
unbounded effective envelope, but it is **weaker** than a claim that the relevant
types/observables themselves are unprestatable or created through evolution.

The representational-vocabulary layer gestures toward stronger vocabulary
change, but the recursive open-ended theorem does not yet require changing
types.

**Provisional classification:** EbE should cite this as a stronger conceptual
neighbor and explicitly state that its current theorem is about expanding
effective accessibility within an ambient formal domain.

### 3.4 Evolutionary novelty, co-option, and exaptation

**Closest literature**

- Erwin DH. *A conceptual framework of evolutionary novelty and innovation.*
  Biological Reviews. 2021;96:1-15. doi:10.1111/brv.12643.
- True JR, Carroll SB. *Gene co-option in physiological and morphological
  evolution.* Annu Rev Cell Dev Biol. 2002;18:53-80.
  doi:10.1146/annurev.cellbio.18.020402.140619.
- Love AC, et al. *Reframing research on evolutionary novelty and co-option.*
  Semin Cell Dev Biol. 2023;145:3-12.
  doi:10.1016/j.semcdb.2022.03.030.

**Already known**

Evolution frequently reuses existing traits, genes, regulatory circuits, and
developmental modules in new contexts. Novelty and later ecological/evolutionary
success are also well known to be separable.

Erwin's distinction between novelty and innovation is especially important for
EbE: realization of a new capacity should not be conflated with later success.

**EbE difference**

"Operational primitive promotion" is best read as an abstract formal analogue
of retained/co-optable structure, not as discovery of co-option. PR #59 adds an
explicit counterfactual essential-parent criterion and ties it to later
generated-access expansion.

**Provisional classification:** known biological mechanism; formal abstraction
and decomposition may be useful.

### 3.5 Evolvability, modularity, and reusable building blocks

**Closest literature**

- Wagner GP, Altenberg L. *Complex adaptations and the evolution of
  evolvability.* Evolution. 1996;50:967-976.
  doi:10.1111/j.1558-5646.1996.tb02339.x.
- Wagner GP, Pavlicev M, Cheverud JM. *The road to modularity.* Nat Rev Genet.
  2007;8:921-931. doi:10.1038/nrg2267.
- Yatskievych et al. *Reusable building blocks in biological systems.*
  J R Soc Interface. 2018;15:20180595. doi:10.1098/rsif.2018.0595.

**Already known**

Modularity, reusable components, genotype-phenotype organization, robustness,
and evolvability are established research areas. Reuse of retained modules can
alter future evolutionary accessibility.

**EbE difference**

EbE makes the reuse relation event-level and explicit: the previous child must
be present as a parent of a later generated capacity, and PR #59 can require
that it be locally essential for that capacity under the fixed generator.

**Provisional classification:** formal bookkeeping specialization / synthesis.

### 3.6 Autocatalytic and RAF systems

**Closest literature**

- Hordijk W, Steel M. *Autocatalytic sets and boundaries.* Journal of Systems
  Chemistry. 2015;6:1. doi:10.1186/s13322-014-0006-2.
- Hordijk W. *Evolution of Autocatalytic Sets in Computational Models of
  Chemical Reaction Networks.* Origins Life Evol Biosph. 2016;46:233-245.
  doi:10.1007/s11084-015-9471-0.
- Peng Z, Linderoth J, Blum D, Baum DA. *The hierarchical organization of
  autocatalytic reaction networks and its relevance to the origin of life.*
  PLoS Comput Biol. 2022;18:e1010498. doi:10.1371/journal.pcbi.1010498.

**Already known**

RAF theory formally studies self-sustaining, collectively autocatalytic reaction
sets, hierarchical subRAFs, evolvability, and cases where lower-tier chemistry
enables higher-tier organization. The existing EbE literature audit had already
identified Peng et al. as a close antecedent for sequential historical
accessibility.

**EbE difference**

The current EbE route is not chemical/autocatalytic by definition. It explicitly
separates:

- emergence;
- resource feasibility;
- external validation;
- retention;
- reusable parent status;
- successor counting;
- finite search admission.

That separation may make it cross-domain, but it also means the causal content
is weaker until a domain-specific model instantiates those interfaces.

**Provisional classification:** distinct abstraction/synthesis; do not claim
priority for hierarchical enabling.

### 3.7 Major evolutionary transitions

**Closest literature**

- Maynard Smith J, Szathmáry E. *The major evolutionary transitions.* Nature.
  1995;374:227-232. doi:10.1038/374227a0.
- Szathmáry E. *Toward major evolutionary transitions theory 2.0.* PNAS.
  2015;112:10104-10111. doi:10.1073/pnas.1421398112.

**Already known**

Major-transitions theory explicitly studies origin, maintenance, and
transformation of new higher-level units, changes in information
storage/transmission, recursive transitions, and emergence of new units of
reproduction.

**EbE difference**

EbE does not require formation of a new Darwinian individual or unit of
reproduction. Its "primitive promotion" is therefore broader but less specific.
The formal question is whether retained organization becomes reusable material
that changes future generability.

**Provisional classification:** complementary abstraction, not replacement or
rediscovery of major-transitions theory.

### 3.8 Cumulative culture and ratchet effects

**Closest literature**

- Tennie C, Call J, Tomasello M. *Ratcheting up the ratchet: on the evolution of
  cumulative culture.* Phil Trans R Soc B. 2009;364:2405-2415.
  doi:10.1098/rstb.2009.0052.

**Already known**

The cumulative-culture literature explicitly treats faithful retention of
innovations as preventing slippage and allowing later modifications to build on
earlier ones. It also distinguishes latent individual solutions from genuinely
cumulative culture.

**EbE difference**

The formal retained repertoire is a cross-domain abstraction. It distinguishes
retention from generation and adds explicit resource, validation, generative
parent, moving-envelope, and saturation layers.

**Provisional classification:** known ratchet idea; formal cross-domain
decomposition is the possible contribution.

### 3.9 Technological recombinant/combinatorial evolution

**Closest literature**

- Fleming L. *Recombinant Uncertainty in Technological Search.* Management
  Science. 2001;47:117-132. doi:10.1287/mnsc.47.1.117.10671.
- Fleming L, Sorenson O. *Technology as a complex adaptive system: evidence from
  patent data.* Research Policy. 2001;30:1019-1039.
  doi:10.1016/S0048-7333(00)00135-9.
- Arthur WB. *The Nature of Technology: What It Is and How It Evolves.* Free
  Press, 2009.

**Already known**

Technological evolution is widely modeled as recombinant search. Arthur
explicitly describes new technologies becoming building blocks for further new
technologies: earlier technology enlarges what can be constructed later.

This is one of the closest conceptual antecedents to PR #59.

**EbE difference**

PR #59 turns the building-block story into a generic theorem interface and
requires an explicit essential-parent witness before attributing downstream
generated access to the promoted primitive. It also separates finite attention
/admission from all combinatorially available possibilities and separates
candidate generation from eventual retained success.

**Provisional classification:** very close conceptual antecedent; potential
contribution is formal factorization and machine checking, not the recursive
building-block idea itself.

## 4. Closest challenge to a novelty claim

The strongest existing conceptual overlap is approximately:

```text
novelty occurs
 -> becomes retained/reusable structure
 -> opens new possibilities
 -> later novelties build on earlier ones
 -> possibility/search space can expand.
```

That chain is already visible across adjacent-possible models, cumulative
culture, technological combinatorial evolution, co-option, autocatalytic
hierarchy, and OEE.

Therefore EbE should **not** claim novelty for that verbal chain.

The narrower formal residue is the explicit decomposition:

```text
compositional emergence
 -> resource-feasible externally validated retention
 -> operational promotion
 -> designated parent reuse
 -> essential-parent test under fixed generator
 -> strict generated-access expansion
 -> finite admission/compression
 -> local envelope representation
 -> full filtered recursive successor
 -> deterministic local R_E
 -> recurrent retained expansion
 -> open-ended cumulative retained novelty
 -> unbounded effective envelope capacity

with the complementary theorem:
fixed globally finite retained novelty universe
 -> saturation / incompatibility with indefinite uniform critical reproduction.
```

The audit has not yet located this exact full package in one prior formalism.

## 5. What may be genuinely useful even if no component is new

A synthesis earns scientific value only if it improves reasoning. The current
stack may do so in four ways.

### 5.1 It makes hidden conjunctions explicit

Many verbal accounts say "innovation opens possibilities." EbE forces separate
questions:

- Was the capacity actually realized?
- Was it novel relative to the retained repertoire?
- Was it resource feasible?
- Did it pass the declared external criterion?
- Was it retained?
- Was it actually reused as a parent?
- Was it essential to the newly generated candidate?
- Was that candidate admitted into finite local search?
- Did the candidate itself survive the same filters?
- Can this recur?
- Can it recur in a bounded effective universe?

Those distinctions are scientifically useful even when the underlying ideas are
old.

### 5.2 It contains explicit separation countermodels

The stack does not only prove forward implications. It checks failures such as:

- emergence without retention;
- promotion without downstream generative expansion;
- critical ledger without actual successor calibration;
- retention and criticality without seed;
- seed and retention without continuation;
- recurrent events without cumulative retention;
- growing envelope without realized novelty.

This reduces the chance that prose silently converts correlation or possibility
into causal sufficiency.

### 5.3 It exposes the finite-global/local distinction

A globally finite candidate vocabulary is sufficient for local enumeration but
incompatible with indefinitely accumulating strict novelty.

The corrected local construction keeps every operational horizon finite while
allowing the sequence of horizons to remain unbounded.

The counting fact is elementary; the value lies in catching and correcting the
formal master certificate before presenting it as an open-ended theory.

### 5.4 It is machine-auditable

The theorem chain, witnesses, and separation results are on an explicit Lean
verification surface and CI rejects `sorryAx`.

This is evidence of deductive correctness relative to formal premises, not
evidence of empirical truth or literature priority.

## 6. Review questions that remain open

Before a v17 release, reviewers should attack:

1. **Circularity:** Is `UniformPromotionDrivenContinuation` materially weaker
   than simply assuming indefinite novelty, or does it only restate the desired
   outcome one event at a time?
2. **Attribution:** Does the essential-parent test sufficiently isolate the
   causal contribution of the promoted primitive when several other repertoire
   changes happen simultaneously?
3. **Admission:** What empirical or mechanistic process determines the finite
   admission policy? Does moving this into an uninterpreted function merely move
   the explanatory gap?
4. **Retention:** How should the theory generalize from monotone finite-set
   retention to turnover, forgetting, extinction, and replacement?
5. **Vocabulary:** Can strong representational vocabulary creation be integrated
   into the recursive theorem without presupposing one ambient capacity type?
6. **Probability:** What branching-process assumptions would be required for a
   stochastic local reproduction theorem?
7. **Resources:** Can self-maintenance/slack mechanisms be connected to a lower
   bound on actual local reproduction in any nontrivial domain?
8. **Measurement:** What is an empirically observable proxy for a capacity,
   operational primitive, local envelope, and essential-parent contribution?
9. **Novelty residue:** Does a specialist literature contain an existing formal
   framework with the same candidate/generation/filter/retention/reuse/admission
   factorization?
10. **Explanatory payoff:** Does the factorization generate predictions or
    measurements that are difficult to express in the parent literatures?

## 7. Provisional reviewer-facing statement

Until the second-pass literature audit is complete, a reviewer-safe statement
would be:

> Evolution by Emergence does not claim to discover cumulative evolution,
> co-option, expanding adjacent possibilities, or reusable evolutionary
> building blocks. The current contribution under review is a machine-checked
> architecture that separates these ideas into explicit interfaces and proves a
> sufficient recursive route from retained emergent capacity to arbitrarily
> many retained novelty events. It also proves that the corresponding
> indefinitely retained process cannot live inside a fixed finite effective
> capacity universe, and replaces that inconsistent global specialization with
> finite moving local envelopes. A further theorem gives one sufficient
> mechanism for envelope movement: a retained primitive is shown to be essential
> for new downstream generability under a fixed generator, after which a finite
> admission policy and independent filtering determine whether that possibility
> becomes the next retained recursive event.

That is a claim about **formal architecture and precision**. Any stronger claim
of scientific novelty must be earned against the literature above.

## 8. Next audit steps

This document is a first targeted pass, not a priority proof.

Before changing the canonical repository narrative:

- search specifically for formal models combining adjacent-possible triggering
  with selection/retention filters;
- search formal OEE work for expanding-type or dynamically generated state-space
  semantics;
- search RAF/category-theoretic and Petri-net literature for parent-essential
  generative expansion;
- search cumulative-culture and technology literature for finite attention /
  admission models;
- compare the EbE local reproduction threshold with branching and innovation
  diffusion formalisms without borrowing their stochastic interpretation;
- ask at least one independent reviewer/agent to try to find an exact
  antecedent to the full factorization.

If a stronger antecedent is found, this document should be updated by narrowing
the novelty residue rather than defending the older wording.
