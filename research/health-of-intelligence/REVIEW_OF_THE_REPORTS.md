# Review of the two reports on the health of intelligence

*7 October 2026. A review, by the AI assistant working on this repository, of the two reports produced from [research brief 1](briefs/BRIEF_1_HEALTH_OF_INTELLIGENCE.md). The reports are in [sources/](sources/). What was adopted is in [HEALTH_OF_INTELLIGENCE.md](HEALTH_OF_INTELLIGENCE.md), and in the repository changes listed at the end.*

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
