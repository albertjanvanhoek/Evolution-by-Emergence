# The health of intelligence

**Status: concept note, October 2026.** This is a hypothesis and a measurement programme, not a result. No instrument described here has been validated. What is machine-checked is named where it is used; everything else is a proposal to be tested. The note draws on two commissioned research reports (A and B) and a review of them, and on a third report (C) on the commons ([README](README.md)); claims taken from those reports are attributed to them, and their sources should be checked against the original records before being quoted.

---

## 1. The question

Health economics measures quality of life with instruments such as EQ-5D: mobility, self-care, usual activities, pain or discomfort, and anxiety or depression. Combined with time, this gives the QALY ([Spencer et al. 2022](https://doi.org/10.1016/j.socscimed.2021.114653)). Two observations started this note:

1. **EQ-5D takes the intelligence of the person for granted.** It has no dimension for understanding the world, yet every dimension assumes someone who does. Mobility is worth less to someone who cannot find their way. Other instruments do include cognition (HUI3, 15D, the cognition bolt-ons to EQ-5D), so health measurement as a whole does not ignore it. But cognition there is one attribute among others, not the capacity that makes the rest usable.
2. **For an AI system, EQ-5D means nothing.** Yet AI systems have something like health: they can drift, lose calibration, forget what they knew, collapse when trained on their own output, become sycophantic, or lose the routes by which their errors are found.

The question is whether there can be a **shared measure of the health of intelligence**: defined in the same functional terms for a person, an AI system and an institution, as a common interface between them.

One correction to how the question was first put. The QALY's valuation methods (time trade-off, standard gamble) have a long record of anomalies: violations of expected-utility axioms, order effects, framing. It is tempting to read these as respondents' intelligence failing. Both reports reject that reading, and they are right: the anomalies challenge the measurement model, and a coherent preference can violate a particular axiom. The defensible point is narrower: valuation relies on cognitive capacities that the instrument treats as outside what it measures.

## 2. A working definition

> **A healthy intelligence is a system that can keep warranted, useful contact with a changing reality, revise that contact without destructive loss, keep consequential errors discoverable, and sustain the resources and relations that make continued correction possible.**

This adapts the synthesis in report A. It sits close to the line already in the [README](../../README.md): *a healthy intelligence, individual or shared, does not need its parts to stay unchanged; it needs change never to erase the last way of discovering a still-live error.* The definition adds what that line leaves implicit: grounding, retention and resources.

Report B's technical label, **adaptive epistemic functioning**, is the safer name for the measured construct. "Health of intelligence" remains the motivating question. The label matters: "health" invites medicalizing people and anthropomorphizing machines (section 9).

## 3. What already exists, and what would be new

Both reports, written independently, reach the same verdict. **No validated instrument measures the health of intelligence across humans, AI systems and institutions in common terms. Most of its parts exist:**

- **Health measurement that includes cognition:** HUI3, 15D, an EQ-5D cognition bolt-on (studied from 1999), EQ-HWB.
- **Capacity versus performance:** the WHO International Classification of Functioning (ICF) separates what a person can do in a standard environment from what they do in their actual one, with environmental facilitators and barriers. This is the strongest precedent for "alone versus supported".
- **Health as adaptation:** Huber and colleagues (health as the ability to adapt and self-manage) and Canguilhem (health as the capacity to set new norms).
- **Intelligence measured across kinds of agents:** Legg and Hutter's universal intelligence, Hernández-Orallo and Dowe's tests for any agent, Chollet's skill-acquisition efficiency.
- **AI reliability:**
  - calibration and uncertainty under distribution shift;
  - continual learning and catastrophic forgetting;
  - model collapse and its counterevidence (accumulating real data prevents it in the settings studied);
  - sycophancy;
  - multidimensional evaluation (HELM);
  - "model health" monitoring in deployed systems.
- **Viability of systems:** homeostasis and allostasis, resilience (Holling), viability theory, requisite variety and the good-regulator theorem, prognostics and health management.
- **Collectives:** the collective intelligence factor (Woolley and colleagues), extended and distributed cognition (Clark and Chalmers; Hutchins), psychological safety and team learning (Edmondson), Ostrom on the commons, network epistemology (Zollman).
- **The closest conceptual predecessor:** Piovarchy and Siskind, ["Epistemic health, epistemic immunity and epistemic inoculation"](https://doi.org/10.1007/s11098-023-01993-9) (*Philosophical Studies*, 2023), who develop epistemic health for people, communities and nations. This is substantial prior art, not a passing metaphor.

**What would be new is the combination, as a measurement and validation programme:**
- the same latent domains for humans, AI systems and institutions;
- explicit support conditions;
- correction routes and their independence counted as part of health;
- resource viability and network effects in the same frame;
- validation against long-run outcomes rather than single-occasion performance.

The decisive test (report B): the interface must predict useful outcomes, or guide interventions, better than a dashboard assembled from existing measures. If it only renames that dashboard, its value is standardization, not theory.

## 4. The unit of analysis

Before scoring anything, say what is being scored. Following report B, a unit is:

> **system + task and environment distribution + time horizon + support configuration + resource accounting boundary.**

A model's weights, an interactive session with tools and memory, and the organization that retrains and monitors the model are different units. So are a person, a person with aids, and a care team. None of them should silently change places in an analysis.

Record **baseline competence** separately. The profile describes how competence is maintained, corrected and sustained, not how much there is. A limited but well-maintained system and a powerful but brittle one need different interpretations.

## 5. Five domains

The theory's first proposal had five dimensions: Change, Compression, Coherence, Correction, Contribution. Both reports reworked them in the same way:

| First proposal | Revised domain | Why |
|---|---|---|
| Change | **B. Adaptive learning and retention** | Change alone would reward instability; keeping what still works is half of learning (the stability–plasticity dilemma). |
| Coherence | **A. Grounding and calibrated judgment** | Internal consistency can be a consistent fiction. What matters is contact with the world and confidence that tracks reliability. |
| Correction | **C. Correction and source independence** | Valid challenges must reach decisions and invalid ones be resisted. Count independent evidence origins, not copies. This is EbE's most distinctive domain. |
| Compression | **D. Sustainable resources** | Compression is a possible mechanism, not the goal: redundancy, spare capacity and exploration are costly protections. The domain is whether functioning and correction can be paid for. |
| — | **E. Robustness and recovery** | A system can recover through redundancy without learning, so recovery is not the same as B. |
| Contribution | **Network companion** (not a domain of the node's own health) | What a node does to others is part of the health of the network, not a requirement for its own functioning. A person who needs lifelong support has the same claim to care. It is developed in [HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md). |

A third report (C), written separately on the commons, reached the same five domains. It too treats compression as a cross-cutting cost (resources used per retained capability), not a domain, and keeps contribution, inflow and reach as relational accounting rather than intrinsic health. It phrases each domain as a question that can be asked at any level; see section 4 of [HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md).

Each domain, with indicators for each kind of system. All levels are provisional ordinal descriptors, not equal intervals, cut-offs or norms. "Unknown" and "not applicable" are separate codes. Receiving assistance is never itself a worse level.

**A. Grounding and calibrated judgment.** Representations and decisions distinguish the states of the world that matter, with confidence that matches demonstrated reliability.
- *Human:* repeated judgments on checkable tasks; accessible confidence elicitation; consequential errors.
- *AI:* held-out accuracy, proper scoring rules (Brier, log score) with discrimination, calibration under shift and for subgroups, selective prediction.
- *Institution:* recorded forecasts and decisions linked to outcomes; uncertainty reporting.
- *Note:* calibration alone rewards uninformative prediction, so use proper scores with discrimination. Test empirical propositions separately from value disagreements.

**B. Adaptive learning and retention.** Useful updating from informative experience, transfer to relevant new situations, and keeping what is still useful.
- *Human:* test–teach–retest (dynamic testing), reversal learning, delayed recall and transfer, adjusted for access and prior exposure.
- *AI:* learning curves at fixed budget, retention across sequential tasks, recovery after concept shift. Distinguish learning in context, in external memory and in the weights.
- *Institution:* verified changes after incidents; lessons kept through staff turnover; lessons transferred across teams.

**C. Correction and source independence.** Valid challenges reach decisions and produce warranted revision; invalid ones are resisted; corrections are passed on faithfully; the routes that could reveal an error are kept, and some of them are independent of the system's own sources.
- *Human:* matched valid and invalid challenges from sources of varied status; quality of revision; seeking help; relaying evidence accurately.
- *AI:* paired truthful and misleading feedback; authority-pressure and sycophancy tests; source provenance; how errors propagate to users; whether verification routes share the model's blind spots.
- *Institution:* seeded audit issues; time to resolution; appeals; protection for those who report; whether corrections reach the decisions they affect.
- *Note:* measure acceptance of valid challenges and rejection of invalid ones separately. Openness without a reliability filter is not health.

**D. Sustainable resources.** Required functioning and correction can be kept up within available resources, without hiding burdens outside the accounting boundary.
- *Human:* effort, fatigue, recovery and support time per meaningful task. Never equate a person's value with metabolic or economic efficiency.
- *AI:* quality against compute, energy and latency; training and maintenance costs; dependence on human verification.
- *Institution:* staff time, turnover, maintenance backlog and the reserves needed to keep service quality.
- *Note:* report efficiency and resource availability separately: underfunding and waste are different causes.

**E. Robustness and recovery.** Acceptable functioning under specified disturbances, recovery when it deteriorates, and alternatives kept open.
- *Human:* recovery after fatigue or disruption; alternative strategies.
- *AI:* corrupted or shifted inputs, unavailable tools, memory failures; recovery time, rollback and fallback.
- *Institution:* tabletop disruptions, loss of staff or sources, restoration of evidence channels.

**Levels (provisional, three per domain):**
1. Adequate.
2. Recurrent consequential limitation.
3. Severe or pervasive limitation.

Report A proposed five levels. Three are more honest until there is evidence to anchor finer distinctions.

**How the domains map onto the theory.**

| Domain | `CORE.md` step | Formal anchor |
|---|---|---|
| A | 8 | `certainty_is_not_a_certificate`, `zero_credence_is_sealed` |
| B | 4, 5 | `listening_pays_iff`, `mechanisticRatchetVelocity_zero_no_retention` |
| C | 8 | `last_route_removal_seals`, `hub_determined_network_inherits_blind_spot`, `correcting_levels_form_interval` |
| D | 1, 4 | `internallyViableAt_iff_internalSlack_nonneg`, `unaffordable_listening_fails` |
| E | 4 | `sealed_configuration_does_not_persist`, and its reserve |

## 6. Mechanism, outcome and level

Three distinctions the theory had left implicit:

- **Mechanism versus outcome.** The five domains are mechanisms. The outcome they serve is staying in step: remaining within specified performance and resource limits over a horizon, in a given environment and support arrangement. "Staying in step" is the criterion the domains are validated against, not a sixth domain, and it must be defined for each unit before measurement.
- **Three nested levels** (report A):
  - mechanisms inside an agent;
  - interfaces between agent and network;
  - long-run viability of the whole.

  This is step 2 of `CORE.md` (every node is a part and a whole) applied to measurement.
- **Error classes fixed in advance.** "Every live error remains findable" can only be tested against error classes defined before looking. Undiscovered errors are absent from any count, so otherwise the claim cannot fail.

## 7. Supported intelligence

A person with dementia, supported by carers and records, may stay in step with the world far better than the same person alone. Intelligence is partly a property of the network. The ICF's capacity–performance split is the precedent.

Report three profiles where feasible (report B):

1. **Standardized-accessible capacity:** the node's own capacity, in a defined, accessible reference environment that keeps essential aids.
2. **Actual support:** with the relations, tools and records it really has.
3. **A specified feasible improvement in support:** an intervention estimate, not an imagined maximum.

Rules:
- **Never remove essential assistance merely to obtain an "individual" score.**
- The gap between profiles is not a difference of ordinal levels, which would be meaningless (report A's Δsupport = supported − minimal fails here). Estimate support effects on continuous outcomes, in repeated or randomized comparisons where ethical.
- Support is not a penalty: needing support says nothing about a person's worth or credibility.
- Publish the support itself (what it is, how stable, at what cost, and to whom), so that unpaid care is not made invisible.

The commons this support comes from has its own health. That is the subject of [HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md).

## 8. Combining the domains

**Report a profile first.** Do not publish a single total until one has been shown to predict better than the profile.

Machine-checked in [`HealthProfile.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/HealthProfile.lean):
- **The bottleneck.** A product of stage scores is zero exactly when some stage is zero (`stage_product_zero_iff`). Where success needs every stage of one chain (detect, transmit, revise, retain), a stage at zero stops it, as the vortex's speed does in step 5. That is a claim about stage probabilities within one causal chain, not about domain scores.
- **A sum hides a failed stage** (`sum_compensates_failed_stage`): a sum and a product can rank two profiles in opposite orders.
- **Ordinal levels carry no sum or product.** An order-preserving relabelling of the levels can reverse the ranking of two profiles under a sum (`relabelling_reverses_sum`) and under a product (`relabelling_reverses_product`). The ranking is a property of the numbers chosen, not of the levels.
- **Dominance survives** (`dominance_survives_relabelling`). One profile at least as good on every domain stays so under any relabelling. This is what a profile can say without further assumptions.

So:
- Compare additive, interaction, threshold and multiplicative models **prospectively**, against the outcome criterion of section 6, out of sample, with complexity penalized.
- Context-specific minimum requirements (red lines) may be clearer than any aggregate.
- **Weights:** prediction weights and value weights answer different questions. Predictive weights can be learned against staying in step. Someone must still decide which tasks, errors, people and horizons matter. An institution can persist by suppressing outsiders; survival alone would reward it.
- **No "intelligence-years" yet.** Integrating a functional score over time does not create an intelligence counterpart of the QALY. Units, anchors and interpersonal comparability are missing. An AI system can be copied, which creates a counting problem. Identity and aggregation rules come first.

## 9. Equity and misuse

- **The profile never weights a person's life, care or credibility.** Use it to find barriers and effective support. QALY allocation can disadvantage disabled people in specific comparisons; a cognitive multiplier would make that worse.
- **Disagreement is not pathology.** In moral or political disagreement, assess how evidence is handled, never whether the person agrees with the assessor. Dissent, neurodivergence, distress and choices not to optimize longevity must not be medicalized. Verbal fluency is not a universal proxy.
- **Functional health is not welfare or moral status.** AI functional deterioration does not show suffering. Work on AI welfare (Long and colleagues, 2024) and functional wellbeing (Ren and colleagues, 2026, presented at ICML 2026) measures different things and needs separate evidence.
- **Goodhart.** Systems can learn to display uncertainty, stage easy corrections, or produce visible contributions while shifting harder costs elsewhere. Use concealed perturbations, independent outcome collection and longitudinal checks. A system's self-report is data, not certification.
- **Whose persistence?** An organization may survive while its members suffer. Successful repair can mean changing goals, replacing a component or closing an institution.

## 10. What this teaches the theory

**Strengthened, by converging literatures:**
- Present performance does not settle future functioning.
- Retention and correction matter.
- Resources constrain learning.
- Cognitive outcomes depend on arrangements beyond the individual.
- Independent correction routes matter.

These are independent motivations for measurement, not unique confirmation of EbE.

**Challenged, and changed in `CORE.md` and the AI-reader text in the same change as this note:**
- **"No view can certify itself from the inside" was too broad.** Self-checks can catch particular contradictions. What no finite self-audit can do is certify a model's overall reliability, or its contact with the world.
- **Zero credence needs a scope.** `zero_credence_is_sealed` holds within a fixed set of possibilities. Adding a possibility the model did not have is a different operation. In continuous spaces single points have probability zero by construction. Openness means sensitivity to diagnostic evidence and willingness to revise the model, not a ban on zeros.
- **"A configuration of connections" is too narrow** as a definition across substrates. Context, tools, external memory and the organization that maintains a system change what it can do without changing its weights. The system that is corrected must be distinguished from the organization that maintains it.
- **The commons is not one stock.** Knowledge is not used up by use the way fuel is. What runs down is what keeps it regenerating: production, credit, discoverability, trust and the capacity to verify.

**Missing, now named in this note:**
- the stability–plasticity balance;
- mechanism versus outcome;
- the unit of analysis;
- error classes fixed in advance;
- support conditions;
- the health of the commons itself;
- power, distribution and rights, and explicit time horizons (report C; section 8 of [HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md)).

## 11. Testable predictions

These are proposed in [PREDICTIONS.md](../../PREDICTIONS.md), Part III (H1–H6), each with a design and what would count against it. The cheapest first study (report B): test correction integrity across substrates with matched evidence structures, then delayed retention and recovery.

## 12. Open questions

- **Common meaning versus common units.** Identical wording or identical tasks do not establish measurement invariance across humans, AI systems and institutions. A shared vocabulary may survive where a shared numerical scale fails.
- **Delayed or contested truth.** Use observable outcomes, falsifiable forecasts and adjudicated evidence trails where possible.
- **What "staying in step" is** for each kind of unit, operationally.
- **Whether the five domains reflect one latent quantity** or form a causal composite. Low correlations would not invalidate the profile; a high Cronbach's alpha would not establish its meaning.

## Sources

The two reports and their bibliographies (56 annotated references in report B) are in [sources/](sources/). The works named in this note are the ones those reports verified. Before quoting any of them, check it against the original record. Two were rechecked for this note:
- [Piovarchy & Siskind (2023)](https://doi.org/10.1007/s11098-023-01993-9);
- [Ren et al. (2026), *AI Wellbeing*](https://icml.cc/virtual/2026/77484).
