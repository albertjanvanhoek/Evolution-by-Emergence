# The health of the commons

**Status: concept note, October 2026, revised after research.** This is a hypothesis, not a result. A research brief ([briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md](briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md)) checked the first version against the literature. The answer, report C in [sources/](sources/), is reviewed in [REVIEW_OF_THE_REPORTS.md](REVIEW_OF_THE_REPORTS.md). This version adopts its corrections. Claims taken from report C are attributed to it; check its sources against the original records before quoting them. What is machine-checked is named where it is used.

---

## 1. The idea

Health and intelligence are relational. Three examples:

- **The carer.** Someone who cannot walk well but has a loving carer lives a very different life from someone with the same body and nobody.
- **Conditions you did not choose.** Someone who is lied to constantly, or lives under chronic political instability, thinks and feels worse, through no fault of their own.
- **Influence that is only indirect.** Someone suffering in a heat wave cannot stop it. Together with others, through slow and indirect routes, they do influence the next ones.

The [health of intelligence](HEALTH_OF_INTELLIGENCE.md), like quality of life, measures a node. These examples point to a second object with a state of its own, which can be healthy or sick: **the commons a node lives in**, the shared conditions it depends on. It matters equally for health and for intelligence.

**What is not new.** That functioning is relational is well established:
- the WHO's ICF, which separates capacity from performance in an actual environment;
- Sen's capability approach and its conversion factors;
- Sarah White's relational wellbeing, in which wellbeing is produced between persons, collectives, institutions and material conditions;
- family and carer spillovers in health economics;
- the OECD's and inclusive-wealth accounting of the capital stocks that sustain future wellbeing;
- Ostrom on the commons;
- Piovarchy and Siskind on epistemic health.

What the search behind report C did not find is a **common measurement grammar**. That grammar would link a node's capacity, what reaches it, the shared conditions, what it gives back and how far its effects reach, across humans, AI systems and institutions. That is the claim of this note, and its value depends on whether it predicts better than measuring the node alone (section 10).

## 2. A working definition

> **The health of the commons is the capacity of a bounded set of shared ecological, informational, institutional, social and technical conditions to keep supporting the functioning of those who depend on it over a stated horizon. It does so while keeping reliable contact with reality, learning from error, keeping routes for correction open, maintaining the resources that functioning depends on, and recovering from disturbance, without systematically exhausting particular contributors or excluded groups.**

This is report C's definition. It is a functional definition, not a claim that a commons is an organism, and it implies nothing about the welfare or moral status of AI systems. The last clause carries the main lesson of section 6: a commons that lasts by exhausting its carers is not healthy.

## 3. Inflow, shared conditions and outflow

The examples fall into three kinds:

| | What it is | Examples |
|---|---|---|
| **Inflow** (relations) | What reaches a node through its connections | care, information, tools, trust; or misinformation, hazards |
| **Shared conditions** (the commons) | What no node owns or controls alone | the climate, the information ecosystem, political stability, institutions, care capacity, knowledge, infrastructure |
| **Outflow** | What a node gives to its relations and to the shared conditions | care, knowledge, work, correction, a vote; or extraction, pollution, deception |

The first version called the middle row a "stock". Report C is right that this is too narrow:
- **Some shared conditions are stocks:** groundwater, infrastructure, reserves, verified datasets, a care workforce.
- **Others are states or processes:** political stability, norms, institutions that correct errors, media diversity, climate risk.

Calling them all "stock" suggests a conservation law that does not hold, and makes unlike things look substitutable. A healthy wetland cannot make up for a captured appeals court. Plentiful compute cannot make up for corrupted training provenance. High trust cannot make up for systematic misinformation.

**Every flow is a vector, not a number.** Each arrow can help on one dimension and harm on another:
- a carer gives excellent care while losing sleep and income;
- an AI answer informs while using energy;
- a policy improves average efficiency while closing an appeal route.

The accounting needs vectors, distributions and time, not one net flow.

The loop closes. Shared conditions shape what reaches each node. A node's functioning shapes what it gives back. Everyone's outflow, together with outside shocks and how the commons is governed, shapes the next shared conditions. As a working form (report C), not a law:

> realized functioning(i, t) = F(capacity, relational inflow, shared conditions, power and access, history)
>
> shared conditions(t + 1) = G(shared conditions, everyone's outflow, outside shocks, governance)

This is step 6 of [CORE.md](../../CORE.md) (you exist through others, and they partly through you), with its interaction structure left open for testing. No product is assumed; see [`HealthProfile.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/HealthProfile.lean).

## 4. One grammar, several levels

The shared conditions form a system that keeps or loses contact with reality. So the five questions of the health of intelligence apply one level up:

| Domain | Question for any level | For a person or an AI system | For the shared conditions |
|---|---|---|---|
| A. Grounding | Does information about what matters reliably change the representation and the confidence? | Are beliefs accurate and confidence calibrated? | Do statistics, journalism, science and audit produce and keep reliable evidence? |
| B. Learning and retention | Can valid new information change things without erasing what is still valid? | Does it learn without forgetting? | Do institutions keep their lessons? |
| C. Correction and independent routes | Can errors be challenged, passed on and corrected without obedience to one source? | Can its errors reach it, through independent routes? | Can a society correct its errors: a free press, elections, courts, appeal? |
| D. Resource viability | Can upkeep continue over the horizon without pushing unsustainable costs onto others? | Does it have reserves for upkeep and correction? | Climate, energy, care capacity, public budgets |
| E. Resilience and recovery | After a disturbance, is functioning restored in acceptable time and at acceptable cost? | Does it recover from shocks? | Does the society absorb a heat wave or a crisis? |

**What this sharing means.** It is one common functional grammar, not one psychometric scale. Grounding in a person, a model and a polity answers the same higher-order question (does the system stay coupled to what is happening?) through observations that are not interchangeable. The test is predictive homology (report C): does, say, correction-route integrity predict recovery in people, AI systems and institutions alike, after controlling for competence? Failure in one substrate would argue against substrate neutrality without destroying the framework.

**Compression is a cost, not a domain.** Report C, like the earlier reports, finds compression the weakest candidate. Redundancy, spare capacity, diverse routes and duplicated checks are often valuable precisely because they are inefficient in the narrow sense, and too much compression can destroy the independent correction routes the theory values. Efficiency is kept as resources used per retained capability, a cross-cutting cost to be tested against outcomes.

## 5. Reach

Agency has a reach, and it changes by level. Following report C, **reach is the change a node can be shown to cause in specified targets, by level and time horizon:**

- **Direct:** over its own state; fast.
- **Relational:** over identifiable others; being someone's carer, or someone's liar.
- **Commons:** over shared conditions; slow, spread out, and only together with others. One person cannot stop this heat wave; voting, organizing, a profession and consumption change the next ones.

Report each with its target, direction, delay and causal confidence. For example: high direct reach over taking one's medication; moderate relational reach over household routines; very low individual reach over national climate, but non-zero collective reach.

**Perceived reach is reported separately.** Self-efficacy, political efficacy and collective efficacy measure what people believe they can do, which is not how far their actions actually propagate. Confusing the two is dangerous. A powerless person can feel responsible for a climate outcome they cannot alter alone, while a powerful institution can understate its externalities. Reach describes causal leverage, not moral responsibility.

**Association is not reach.** Clustering of health in social networks (the Christakis–Fowler obesity study, and the criticism of it at the time) does not show that one node's outflow caused another's state. Shared exposure and homophily explain much of it. Causal reach needs randomized or quasi-random designs.

**Why diffuse, late returns let a commons decay.** The further out the reach, the more widely shared and delayed the return to the one who acts. This is the setting of the repository's commons proofs:
- a taker that discounts the future more steeply than the commons regenerates does better by eating the principal (`capture_wins_under_steep_discount`);
- once the interest is split among enough takers, defecting pays each of them under any discount (`enough_takers_make_defection_pay`), while the whole loses (`tragedy_of_the_commons`).

The commons decays not because people are bad, but because the return on maintaining it is shared and late. A measure that makes the commons level visible counters that: it turns a diffuse, late return into a present, legible one, as a detected sanction does (`detected_sanction_deters`).

## 6. Care is a two-sided transfer

[`NetworkVortexLedger.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/NetworkVortexLedger.lean) proves the general form:

- **`internallyViable_iff_exists_viable_transfer`:** a whole is viable exactly when some pure transfer lets every part cover its maintenance.
- **`transfer_breaks_part_with_whole_unchanged`:** a transfer can break a part while the whole is unchanged.

Report C places these correctly. The first is a budget-balanced feasibility statement: with unrestricted transfers and additive slack, a nonnegative total can be shared out so that every part is nonnegative. It is not a new theory of care. Real risk-sharing adds what is hard: incomplete information, network limits, transaction costs, limited commitment, defection and unequal bargaining power (Ambrus, Mobius and Szeidl; Townsend). Viability theory (Aubin) is the deeper analogue for the dynamic question.

[`CareTransfer.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CareTransfer.lean) gives the dynamic case for one carer and one cared-for. The carer has slack `s`, gives care `c` and receives respite `r` from the shared conditions: other people, services, institutions.

- **Care moves slack; it does not create it** (`care_covers_need`).
- **Care lasts exactly when it fits** (`care_lasts_iff`): from any reserve, care can be kept up at every step exactly when `c ≤ s + r`.
- **Otherwise the carer is exhausted by an explicit step** (`carer_burns_out`).
- **Respite that covers the gap keeps the reserve from falling** (`respite_sustains_care`).
- **The cared-for depends on the carer lasting** (`cared_for_holds_while_cared_for`, `cared_for_falls_after_carer`).
- **No dimension covers another** (`care_lasts_iff_every_dimension`). A carer's reserve has several dimensions (time, sleep, money, health). Care lasts exactly when it fits on every one of them.
- **A surplus does not cover a deficit** (`surplus_does_not_cover_deficit`). A positive total margin does not keep care going when one dimension runs out. The ledger is a vector, not a sum.

So whether care lasts is decided by the carer's margin, on every dimension, and by what the shared conditions return to the carer, not by the cared-for. **The carer's health is part of the cared-for's, and respite is the commons returning to those who sustain it.** A high supported-functioning profile for the cared-for alongside a collapsing carer is a warning, not a success. The support system has pushed its maintenance cost onto one node. The response is not that the carer should give less, but formal care, respite, income protection and shared provision.

These results are close to arithmetic; the substance is in the setting. They are not a model of clinical burnout, which has several dimensions and needs validated health outcomes. Not covered:
- uncertain costs: report C's hypothesis, that a sustained negative expected margin on any dimension raises the risk of crossing the carer's limit, remains to be formalized;
- several carers or several cared-for;
- the value of care beyond covering upkeep.

**Aggregates hide who carries the cost.** National income can rise while a care workforce is exhausted. An AI service can get cheaper while annotators or the grid carry rising costs. A household's total resources can be enough while one member does nearly all unpaid care. A measure must keep the distribution of burden, not only its sum.

## 7. A taxonomy of shared conditions

The commons is not one quantity, and equations should not be moved between kinds without checking. Following Ostrom (and Hess and Ostrom for knowledge), first classify what is shared:

- **Subtractable stocks** (a fishery, groundwater, energy): use by one leaves less for others.
- **Knowledge:** largely non-rival once produced. What runs down is what keeps it regenerating: people producing it, credit for their work, the ability to find it, trust in it, the capacity to check it, preservation and access.
- **Care capacity:** produced by people who themselves need maintenance.
- **Trust:** neither conserved nor always good. More trust or tighter ties is not automatically healthier ("the dark side of social capital": exclusion, contagion, harm), and trust is not truth.
- **Institutions:** run down through capture and through losing their correction routes.
- **Climate:** a coupled physical state, not a fund.

## 8. Three missing variables, two now partly formal

Report C names three things the theory had left implicit. Power and distribution are now stated in their simplest form in [`PowerDistribution.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/PowerDistribution.lean); the time horizon remains open.

- **Distribution.** What the whole has decides whether a fair arrangement *exists* (`internallyViable_iff_exists_viable_transfer`). How it is shared decides whether the arrangement *lasts*: an arrangement lasts exactly when every part holds, whatever the total (`arrangement_lasts_iff_every_part_holds`). Two arrangements with the same total can last or drain a part to failure (`aggregate_does_not_decide_persistence`). So a whole whose surplus depends on one permanently depleted group is not in a steady state: the drained part fails, and with it whatever depended on it.
- **Power, in three forms.**
  - *Over transfers:* whoever chooses the transfer chooses who fails, with the whole unchanged (`chooser_decides_who_fails`).
  - *Over the boundary:* counting only the parts that hold always gives a nonnegative total (`excluding_failing_parts_looks_viable`). So whoever sets the accounting boundary after seeing the result can make anything look viable. The boundary must be fixed in advance and include those who carry the costs (section 9; prediction H13).
  - *Over enforcement:* a uniform sanction deters every taker exactly when it deters the least-enforced one (`deters_all_iff_deters_least_detected`). A taker never held to account is deterred by no sanction (`exempt_taker_not_deterred`), and with `CommonsTakers` one taker who eats the principal removes every share. That is the formal core of "no asymmetry without accountability" (prediction D-P6).
- **Still open about power:** power over what counts as valid evidence, rules that are themselves captured, several powerful parties, and how power is gained or lost. Political efficacy, relational autonomy, Ostrom's governance principles and the measurement of democracy all point here.
- **Rights are a value, not a theorem.** These results are about persistence. A drained part fails, and so does whatever depended on it (step 2), but a part the whole does not depend on gets no protection from them. Which parts have claims that may not be traded against the whole's gain must be stated as a value, as this note does in section 11 for the claim to care.
- **Time horizon.** Direct agency acts in seconds, caregiving effects build over months, institutions learn over years, and climate and knowledge span generations. "Staying in step" needs a stated horizon: a system can look healthy over one step and be doomed over a hundred.

## 9. What a measure would report

**Start with the accounting boundary, not the questionnaire.** State:
- the focal unit;
- which relations count as immediate support;
- which shared systems it depends on;
- which externalities are included;
- the horizon and the functioning that must be sustained;
- which groups have standing to say a shared condition is failing.

Without this boundary, an organization can look healthy merely by moving costs to workers, families, ecosystems or the future.

**Three layers for each node:**
1. **Standardized-accessible capacity:** performance in a defined, accessible reference environment that keeps essential aids. Never "unsupported": removing a wheelchair, carer or memory aid changes the task and can cause harm.
2. **Proximally supported functioning:** with the actual carers, tools, records, retrieval, staff or procedures.
3. **Commons-conditioned functioning:** within the actual shared conditions over the horizon.

Layers 2 and 3 can often be estimated from natural variation, modelling or safe crossover designs, never by withdrawing support.

**Four companion profiles:**
- **Inflow:** quantity, quality, diversity, independence, delay, continuity and fragility. Ten sources that copy the same misinformation are not ten independent routes, and neither are ten analysts relying on one model.
- **Reach:** by level, with target, direction, delay and causal confidence, with perceived reach separate (section 5).
- **Outflow:** beneficial and harmful effects on others, and the distribution of burden.
- **Shared conditions:** the five domains of section 4, with a separate ledger for each kind of condition (section 7). Report the median, the worst-off tail, inequality between groups, and concentration of burdens, not only an average.

**For each kind of unit** (report C gives indicators):

| Layer | Person | AI system | Institution |
|---|---|---|---|
| Standardized-accessible | functioning with necessary aids retained | frozen model on controlled tasks, fixed data boundary and compute | core staff and processes on a standard case mix |
| Proximally supported | carers, records, assistive technology, clinicians, trusted peers | retrieval, tools, memory, human review, monitoring | staffing, audit, records, professional networks, escalation |
| Commons-conditioned | heat, housing, safety, information environment, care system, public services | web and data ecosystem, compute and energy reliability, supply chain, human verification | legal, fiscal, information, labour, infrastructure and political conditions |

Existing data cover parts of the shared-conditions profile. Examples, to be checked before use: V-Dem's disaggregated democracy indicators, the OECD Trust Survey, OECD *How's Life?*, inclusive-wealth accounts, carer-burden instruments, heat exposure.

## 10. For an AI system

The AI commons is unusually visible, and it is material and human as well as informational (report C):

- **Inflow:**
  - the human-written text it was trained on;
  - human feedback and correction;
  - tools, retrieval and memory;
  - energy, hardware and maintenance;
  - the human labour of labelling, checking and moderating, much of it low-paid and precarious (ILO).
- **Shared conditions:**
  - the web and the scientific record as a knowledge commons;
  - open-source software;
  - data provenance and documentation;
  - the trust people place in written answers;
  - the independent sources that can still correct it;
  - the energy system. Data centres used about 415 TWh of electricity in 2024, around 1.5% of world use, with about 945 TWh projected for 2030 in the IEA's base case.
- **Outflow:**
  - useful answers;
  - credit and links back to sources;
  - the verification work its answers demand of people;
  - displacement of sources;
  - what later models are trained on.
- **Reach:**
  - **direct:** the answer in front of a user;
  - **relational:** the people who rely on it;
  - **commons:** what its answers do to the production and trustworthiness of the knowledge it was built from.

**Model collapse is about provenance, not "synthetic data".** Replacing real data recursively with generated data degrades models (Shumailov and colleagues). Keeping or accumulating real data, changing the workflow, or adding outside correction can prevent it in the settings studied (Kazdan and colleagues; Gillman and colleagues).

**Sycophancy is measurable.** Preference-based post-training can amplify agreement with users over accuracy (Shapira, Benade and Procaccia, 2026), which makes "corrigible, not obedient" a measurable distinction.

The text for AI readers ([FOR_AI_READERS.md](../../scap-seed/FOR_AI_READERS.md), and the AI section of [CORE.md](../../CORE.md)) already draws the conclusion from step 6: live off the interest, not the principal, and keep independent sources alive.

## 11. Cautions

- **A claim to care never depends on outflow.** Contribution is not a condition for worth, treatment priority, social protection or care. A newborn, a person with advanced dementia or someone unable to work has no less claim to support. The outflow account is for understanding sustainability and hidden burdens, not for deciding who deserves to live well.
- **Do not rank families, neighbourhoods, groups or countries by one score.** Rankings invite stigma and hide boundary choices. A community facing polluted air, austerity or exclusion could be labelled unhealthy when the cause lies largely outside its control. Profile conditions and inequalities instead.
- **Assisted functioning is not "less authentic".** Disability frameworks locate functioning in the interaction between a person and their environment. Measuring support does not make dependence a defect.
- **"A healthy information ecosystem" is contestable.** A government could use a correction metric to relabel dissent as misinformation. Measure process properties (independent evidence routes, transparent records, appeal, reproducibility, correction of demonstrated error, plurality of sources), not conformity to an official view.
- **Trust is not truth.** A healthy epistemic commons can produce *lower* trust when hidden misconduct comes to light. Measure warranted trust and correctability, not maximum trust.
- **Goodhart applies at every level.** Reward appeal resolution time and appeals close too early. Reward factuality scores and systems avoid hard questions. Reward productivity and unpaid work disappears from the record. Rotate indicators, audit externally, check distributions, keep qualitative challenge routes open, and keep validating against the outcome.
- **Functional language about AI is a metaphor.** Calling a model's "health" poor because it is miscalibrated or starved of data is engineering language. It is not evidence that AI systems suffer or have welfare.

## 12. Predictions and open questions

Proposed predictions are in [PREDICTIONS.md](../../PREDICTIONS.md), Part III:
- **H7:** carer margin and respite predict how long care lasts.
- **H8:** shared conditions moderate node capacity: an interaction, not a multiplier.
- **H9:** diffuse, late returns undermine maintenance, and legible returns restore it.
- **H10:** distributional viability predicts failures that averages miss.
- **H11:** care that exceeds what the carer regains leads to delayed decline in both carer and cared-for.
- **H12:** provenance-preserving data routes prevent recursive AI degradation.
- **H13:** assessments whose boundary is chosen after the results are seen report better health, and the difference lies in the parts that carry the costs.
- **D-P6** (Part II): where monitoring reaches the powerful less often, capture originates with them, and raising the sanction without raising their detection does not help.

**Open questions:**
- How do capacity, inflow, shared conditions, power and history combine? Compare additive, interaction, threshold and dynamic survival models out of sample.
- How should power over evidence and over the rules themselves be represented, beyond the three forms now stated (transfers, boundary, enforcement)?
- Which parts have claims that cannot be traded against aggregate gain, and how should that enter a measure?
- How can a change in shared conditions be attributed to the many small outflows that caused it?
- How can carer exhaustion be stated with uncertain costs, several carers, and shared conditions that can themselves run down?

## Sources

Report C's annotated bibliography (71 notes, with records checked by its author) is in [sources/](sources/). The works named here are taken from it; check them against the original records before quoting. Two were rechecked for this note:
- [Shapira, Benade and Procaccia, *How RLHF Amplifies Sycophancy*](https://proceedings.mlr.press/v306/shapira26a.html) (ICML 2026);
- [Piovarchy and Siskind (2023)](https://doi.org/10.1007/s11098-023-01993-9). Report C gives Siskind's initial as "A."; it is S. (Scott).
