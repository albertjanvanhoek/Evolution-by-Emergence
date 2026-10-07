# Review of the research reports on the health of intelligence and of the commons

*7 October 2026. Reviews, by the AI assistant working on this repository, of the two reports produced from [research brief 1](briefs/BRIEF_1_HEALTH_OF_INTELLIGENCE.md) (first part) and of the report produced from [research brief 2](briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md) ("Report C", at the end). The reports are in [sources/](sources/). What was adopted is in [HEALTH_OF_INTELLIGENCE.md](HEALTH_OF_INTELLIGENCE.md), and in the repository changes listed at the end.*

- **Report A:** *Toward a Shared Measure of the Health of Intelligence*, 24 pages, about 8,700 words.
- **Report B:** *A shared measure of the health of intelligence: critical research overview and candidate measurement interface*, 15 pages, about 4,600 words, with 56 annotated references.

Both were written by research agents from the same brief, without sight of each other.

## The verdict they share

Reached independently, which is a useful signal in itself:

- **No validated cross-substrate instrument exists; most of the parts do.**
- **What would be new is a measurement and validation programme, not a discovery.** Report B is sharper: if the interface does not predict better than a dashboard of existing measures, its value is standardization, not theory.
- **The same reworking of the five proposed dimensions:**
  - Coherence becomes calibration and grounding.
  - Compression becomes resource viability, with compression only as a mechanism.
  - Change gains retention.
  - Correction gains source independence.
  - Contribution moves from the node's own health to the network's.
- **No product of ordinal scores.** A product is valid for conditional stage probabilities within one causal chain, not across domains. Report a profile first, and compare aggregation models prospectively.
- **The score never weights a person's worth, care or credibility.**

## Report A

**Strengths**
- It engages most directly with EbE:
  - three nested levels (agent mechanisms, agent–network interfaces, long-run viability);
  - "staying in step" as the outcome criterion rather than a domain;
  - a clear account of what the theory gains, what is challenged and what is missing.
- A good one-sentence definition, adapted in the concept note.
- It corrected a claim in the brief: expected-utility violations and order effects in QALY valuation do not show that respondents' intelligence is unhealthy.

**Weaknesses**
- **Misses the closest prior work:** it does not cite Piovarchy and Siskind (2023), nor Hernández-Orallo and Dowe.
- **Five levels per domain** suggest more precision than any evidence supports.
- **Δsupport = supported − minimal subtracts ordinal levels,** which is not meaningful.
- **"Staying in step" is left undefined,** as the report itself notes.
- **Production traces:** links carry chat-tool tracking parameters, and the text contains citation-marker leftovers. Clean these before quoting from it. The sources spot-checked are real.

## Report B

**Strengths**
- **Labelled evidence.** Every claim is marked established, synthesis or hypothesis. References are confirmed against retrieved records, with a statement of which were seen only as abstracts.
- **Finds the closest prior work:** Piovarchy and Siskind, *Epistemic health, epistemic immunity and epistemic inoculation*, *Philosophical Studies* 2023 (checked: real).
- **Defines the unit before scoring it:** system, task and environment, horizon, support configuration and resource boundary. This is its largest methodological contribution.
- **Support as three profiles:** standardized, actual and a feasible improvement. It adds a rule: never remove essential assistance to obtain an "individual" score.
- **Keeps three things apart:** functional health, AI welfare and moral status.
- **Notes that copying an AI makes "intelligence-years" ill-defined.**
- **Precise critiques of the repository:** the "from the inside" claim, zero credence, "configuration of connections", untestable error counts, and the commons as one stock.

**Weaknesses**
- It says less about EbE's structure and gives no definition.
- Three levels per domain are coarse, though more honest than five.
- One reference is out of date. Ren et al. (2026), *AI Wellbeing*, is marked "peer-review status not verified"; it is listed at ICML 2026.

## Where they differ, and what was followed

| Question | Report A | Report B | Followed |
|---|---|---|---|
| Robustness | inside resource viability | a separate domain | B: recovery through redundancy is not learning |
| Support | subtract levels | three profiles, continuous outcomes | B |
| Levels | five | three | B, until evidence anchors finer levels |
| Name | Intelligence Health Profile | "adaptive epistemic functioning", as the technical label | B for the construct, keeping "health of intelligence" as the question |
| Fit to EbE | nested levels, outcome criterion | unit of analysis, error classes | both |

## Critiques of the repository accepted

Each was checked against the text at the time:

1. **"No view can certify itself from the inside" was too broad.** Self-checks catch particular contradictions; no finite self-audit certifies overall reliability.
2. **`zero_credence_is_sealed` holds within a fixed set of possibilities.** Rebuilding the hypothesis space is a different operation, and in continuous spaces single points have probability zero.
3. **"A configuration of connections" is too narrow across substrates.** Context, tools, external memory and the maintaining organization matter.
4. **"Every live error remains findable" is testable only against error classes fixed in advance.**
5. **The commons needs several ledgers.** Facts are not used up; production, credit, discoverability, trust and verification capacity are what run down.

## What changed in the repository

- **New concept notes:** [HEALTH_OF_INTELLIGENCE.md](HEALTH_OF_INTELLIGENCE.md) and [HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md).
- **Text corrections 1–5,** in [CORE.md](../../CORE.md) (steps 6 and 8, the scope list, related work), [PREDICTIONS.md](../../PREDICTIONS.md) and [FOR_AI_READERS.md](../../scap-seed/FOR_AI_READERS.md).
- **Predictions H1–H9,** in [PREDICTIONS.md](../../PREDICTIONS.md), Part III.
- **Two Lean modules:**
  - [`HealthProfile.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/HealthProfile.lean): why a profile comes before a score.
  - [`CareTransfer.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CareTransfer.lean): care as a transfer, and what keeps it going.
- **Research brief 2,** on the health of the commons: [briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md](briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md).

---

## Report C: the health of the commons

- **Report C:** *The Health of the Commons: Relational Health and Intelligence Across Persons, AI Systems, and Shared Conditions*, 23 pages, with 71 notes to sources.

It was written by a research agent from brief 2, which summarized reports A and B. The agent says it did not have the two reports themselves.

### Verdict

- **No instrument links the levels.** No validated instrument measures people, AI systems, institutions, their relations and their commons on one shared scale.
- **Relationality itself is not new.** The closest prior work:
  - the WHO's ICF;
  - Sen's conversion factors;
  - Sarah White's relational wellbeing;
  - family spillovers in health economics;
  - OECD and inclusive-wealth accounting;
  - Ostrom;
  - Piovarchy and Siskind.
- **What survives is a common measurement grammar.** It links capacity, inflow, shared conditions, outflow and reach across humans, AI systems and institutions. This is the narrow claim the commons note already made.

### What it corrects or adds
1. **"Stock" becomes "shared conditions".** Some shared conditions are stocks; others are states or processes. One word suggested a false conservation law and false substitutability.
2. **Every flow is a vector, not a number.** A flow can help on one dimension and harm on another.
3. **Reach** is the change a node can be shown to cause, by level and horizon, with target, direction, delay and causal confidence. Perceived reach is measured separately.
4. **Three missing variables:** power, distribution and rights, and an explicit time horizon. Power is the most important new point: the theory has capture and sanctions, but no variable for who sets the boundary, the evidence and the rules.
5. **New prior work:**
   - relational wellbeing (White);
   - the "dark side" of social capital;
   - trust is not truth;
   - risk-sharing with limited commitment;
   - viability theory as the dynamic analogue.
6. **Network association is not causal reach** (Christakis–Fowler and its critics).
7. **The AI commons is material and human:** energy, according to the IEA, and platform labour, according to the ILO. Model collapse depends on provenance and workflow.
8. **A definition of commons health,** including recovery "without systematically exhausting particular contributors or excluded groups".

### On the formal side
- **The transfer theorem.** It describes `internallyViable_iff_exists_viable_transfer` correctly: a budget-balanced feasibility statement, not a new theory of care.
- **It missed `CareTransfer.lean`.** It says the burnt-out carer "needs a dynamic theorem"; the single-reserve deterministic case already existed. Its proposal is therefore an extension:
  - a reserve with several dimensions, where failure on any one is failure;
  - a stochastic version.

  The first is now proved (`care_lasts_iff_every_dimension`, `surplus_does_not_cover_deficit`). The second remains a hypothesis.

### Where it agrees with what was already adopted
- **The same five domains.** Compression is a cross-cutting cost; contribution, inflow and reach are relational accounting.
- **A profile first,** with thresholds only where justified.
- **"Standardized-accessible" rather than "unsupported" capacity.**
- **A claim to care never depends on outflow.**

### Weaknesses
- **It did not see reports A and B,** nor `CareTransfer.lean` and `HealthProfile.lean`, although it read `PREDICTIONS.md` after they were merged.
- **Five levels (0–4) per domain,** without anchoring evidence.
- **Generous ratings in its coverage table,** for example Ostrom rated central for learning and grounding.
- **Citation faults:**
  - Siskind's initial given as "A." (it is S.);
  - one note pointing to a journal volume page rather than the article;
  - one note pointing to a different paper than the claim;
  - the Zarit reference resting on one Italian validation study;
  - two citation-marker leftovers.
- **Two sources not known from memory were checked and are real:** Shapira, Benade and Procaccia (ICML 2026), and the 2026 *Nature Communications* meta-analysis of the illusory truth effect.

### What changed in the repository
- **[HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md) revised:**
  - report C's definition;
  - "shared conditions";
  - vector flows and the working form of the loop;
  - a grammar shared across levels, with predictive homology as the test;
  - measurable reach;
  - a taxonomy of shared conditions;
  - the three missing variables;
  - the accounting boundary and the profiles to report;
  - the AI commons, including energy and labour;
  - the cautions.
- **[HEALTH_OF_INTELLIGENCE.md](HEALTH_OF_INTELLIGENCE.md):** notes the convergence of the third report, standardized-accessible capacity, and the missing variables.
- **[`CareTransfer.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CareTransfer.lean):**
  - `care_lasts_iff_every_dimension`, added to `EbECore` (87 results);
  - `surplus_does_not_cover_deficit`.
- **[PREDICTIONS.md](../../PREDICTIONS.md):**
  - H8 sharpened to an interaction;
  - H10 (distributions predict failures that averages miss);
  - H11 (delayed decline of carer and cared-for);
  - H12 (provenance protects the AI commons).
- **[CORE.md](../../CORE.md):**
  - care on every dimension in step 6;
  - power, distribution and rights, horizons, and uncertain care costs under "not yet formal";
  - relational wellbeing and risk-sharing under related work.
- **[FOR_AI_READERS.md](../../scap-seed/FOR_AI_READERS.md):** the human labour behind AI systems.
