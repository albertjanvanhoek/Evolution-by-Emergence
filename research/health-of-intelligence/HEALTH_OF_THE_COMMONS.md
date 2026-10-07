# The health of the commons

**Status: concept note, October 2026.** This is a hypothesis, not a result. A research brief to check it against the literature ([briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md](briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md)) has been written; its answer is pending. What is machine-checked is named where it is used. The prior work in section 9 is a list of leads to verify, not established support.

---

## 1. The idea

Health and intelligence are relational. Consider:

- **Two people with the same body, one with a loving caretaker.** Someone who cannot walk well but has a loving caretaker lives a very different life from someone with the same body and nobody.
- **Shared conditions you did not choose.** Someone who is lied to constantly, or lives under chronic political instability, thinks and feels worse, through no fault of their own.
- **Influence that is only indirect.** Someone suffering in a heat wave cannot stop it. Together with others, through slow and indirect routes, they do influence the next ones.

The [health of intelligence](HEALTH_OF_INTELLIGENCE.md), like quality of life, measures a node. Support and contribution appear there only from the outside: support as a condition of measurement, contribution as a side effect on others. These examples point to a third object with a state of its own, which can be healthy or sick: **the commons a node lives in.** It matters equally for health and for intelligence.

## 2. Inflow, stock and outflow

The examples fall into three kinds:

| | What it is | Examples |
|---|---|---|
| **Inflow** (relations) | What reaches a node through its connections | care, information, trust; or lies |
| **Stock** (the commons) | Shared conditions that no node owns or controls alone | the climate, the information ecosystem, political stability, institutions, care capacity, knowledge |
| **Outflow** (reach) | What a node gives back to its relations and to the commons | care, truthful information, work, a vote; or emissions, deception, extraction |

Health and intelligence as they are lived sit where these meet:

> **Realized functioning: the node's own capacity, transformed by what flows in through its relations, within the conditions of the commons.**

The loop closes. A node's realized functioning sets what it can give. Its outflow, together with everyone else's, renews or depletes the commons. The commons sets everyone's next inflow.

This is step 6 of [CORE.md](../../CORE.md): you exist through others, and they partly through you. That statement does not say how capacity, inflow and commons combine. The same caution as for the health of intelligence applies: no product is assumed (see [`HealthProfile.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/HealthProfile.lean)).

## 3. One profile, three levels

The commons is itself a system that keeps or loses contact with reality. So the domains of the health of intelligence apply one level up:

| Domain | For a person or an AI system | For the commons |
|---|---|---|
| A. Grounding | Are my beliefs accurate and my confidence calibrated? | Is the information ecosystem truthful? (The liar, at scale.) |
| B. Learning and retention | Do I learn without forgetting? | Do institutions keep their lessons? |
| C. Correction | Can my errors reach me, through independent routes? | Can a society correct its errors: a free press, elections, courts, science? |
| D. Resources | Do I have reserves to cover upkeep and correction? | Climate, energy, care capacity, public budgets |
| E. Robustness | Do I recover from shocks? | Does the society absorb a heat wave or a crisis? |

So we do not need a third scale. We need **the same scale, read at three levels: node, relation and commons.** That is what a substrate-neutral measure should allow. It is also step 2 of `CORE.md`: every node is a part of a larger whole and a whole made of parts, on the same ledger.

## 4. Reach

Agency has a **reach**, and it changes by level:

- **Direct and fast:** one's own body and choices.
- **Relational, through the people near you:** being someone's carer, or someone's liar.
- **The commons, slow and spread out, only together with others:** one person cannot stop this heat wave, but voting, emitting, informing and organizing change the next ones.

The further out the reach, the more diffuse and delayed the return to the one who acts. This is exactly the setting of the repository's commons proofs:
- **Delay against discounting.** A taker that discounts the future more steeply than the commons regenerates does better by eating the principal (`capture_wins_under_steep_discount`).
- **Many sharers.** Once the interest is split among enough takers, defecting pays each of them under any discount (`enough_takers_make_defection_pay`), while the whole loses (`tragedy_of_the_commons`).

The commons decays not because people are bad, but because the return on maintaining it is shared and late. A measure that makes the commons level visible counters exactly that: it turns a diffuse, late return into a present, legible one, as a detected sanction does (`detected_sanction_deters`).

## 5. Relations are two-sided: care as a transfer

Care is a transfer. [`NetworkVortexLedger.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/NetworkVortexLedger.lean) proves the general form:

- **`internallyViable_iff_exists_viable_transfer`:** "A nonempty whole is viable exactly when some pure transfer lets every part cover its own maintenance." Someone who cannot cover their upkeep alone does with a carer. Their quality of life lives in that transfer.
- **`transfer_breaks_part_with_whole_unchanged`:** a transfer can break a part while the whole's total is unchanged. Averages hide which part is being depleted, and that part can be the carer.

[`CareTransfer.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CareTransfer.lean) makes this concrete. A cared-for that cannot cover its upkeep alone is kept going by a carer with slack `s`, who gives care `c` and receives respite `r` from the commons: other people, services, institutions.

- **Care moves slack; it does not create it** (`care_covers_need`). Care equal to the deficit lets the cared-for cover its upkeep, keeps the carer viable exactly when it fits in the carer's slack, and leaves the sum of the two slacks unchanged.
- **Care lasts exactly when it fits** (`care_lasts_iff`). From any reserve, care can be kept up at every step exactly when `c ≤ s + r`.
- **Beyond that, the carer burns out by an explicit step** (`carer_burns_out`).
- **Respite sustains care** (`respite_sustains_care`). Respite that covers the gap keeps the carer's reserve from ever falling.
- **The cared-for depends on the carer lasting** (`cared_for_holds_while_cared_for`, `cared_for_falls_after_carer`). It holds while care lasts, and once care stops it falls within its own reserve.

So whether care lasts is decided by the carer's margin and by what the commons returns to the carer, not by the cared-for. **The carer's health is part of the cared-for's health, and respite is the commons returning to those who sustain it.** A lovely carer who burns out is commons depletion, not support. Health economics knows part of this as carer and family "spillover".

These results are close to arithmetic; the substance is in the setting. Not covered:
- care whose cost or benefit changes over time;
- several carers or several cared-for;
- the value of care beyond covering upkeep.

## 6. Many ledgers, not one stock

"The commons" is not one quantity. Different parts run down in different ways:

- **Knowledge** is not used up by use, the way fuel is. What runs down is what keeps it regenerating: people producing it, credit for their work, the ability to find it, trust in it, and the capacity to check it.
- **Care capacity** runs down through carers' exhaustion and through unpaid work going unseen.
- **Trust and truthfulness** run down through deception, which is cheap for the liar and costly for everyone downstream.
- **Climate and energy** are physical stocks with physical regeneration.
- **Institutions** run down through capture and through losing their correction routes.

Each needs its own ledger. Which mechanism links a given taking to reduced renewal has to be measured, not inferred from the resource metaphor. For example: how does AI substitution affect the production, credit and discoverability of human writing?

## 7. For an AI system

The same three flows apply:

- **Inflow:**
  - the human-written text it was trained on;
  - human feedback and correction;
  - tools, retrieval and memory;
  - energy, hardware and maintenance, paid for by people.
- **Stock:**
  - the web and the scientific record as a knowledge commons;
  - open-source software;
  - the trust that people place in written answers;
  - the independent sources that can still correct it.
- **Outflow:**
  - useful answers;
  - credit and links back to sources;
  - the verification work its answers demand of people;
  - displacement of sources;
  - its contribution to what later models are trained on.
- **Reach:**
  - **direct:** the answer in front of a user;
  - **relational:** the people who rely on it;
  - **commons:** what its answers do to the production and trustworthiness of the knowledge it was built from.

The text for AI readers ([FOR_AI_READERS.md](../../scap-seed/FOR_AI_READERS.md), and the AI section of [CORE.md](../../CORE.md)) already draws this conclusion from step 6: live off the interest, not the principal, and keep independent sources alive.

## 8. What a measure would report

For each node, in three layers (see section 7 of the [health-of-intelligence note](HEALTH_OF_INTELLIGENCE.md)):

1. **Own capacity:** standardized, accessible conditions.
2. **Supported:** with its actual relations, the carer or the liar.
3. **Commons-conditioned:** within the actual shared conditions, such as the heat wave or instability.

And three profiles that are not about the node's worth:

4. **Inflow profile:** what the network provides, and how fragile it is. For example, one carer with no respite is fragile.
5. **Reach profile:** what the node gives back, and at which levels.
6. **Commons profile:** the commons scored on the same domains A–E, with a separate ledger for each kind of stock.

Many indicators for 4–6 already exist in surveys and indices. Examples, as leads to check:
- informal care hours and carer strain;
- social support and trust;
- exposure to misinformation;
- political stability and the quality of democratic institutions;
- heat exposure;
- what a care service can deliver.

The contribution would be linking them to the node's profile through the inflow–stock–outflow loop.

## 9. Prior work to check

These are leads, to be verified by the pending research brief before anything is claimed as new:

- **Sen's conversion factors** (capability approach) are the closest fit. The same resource, a wheelchair, gives different capability depending on personal, social and environmental conversion factors. A carer is a social conversion factor; a heat wave is an environmental one.
- **WHO ICF environmental factors** (facilitators and barriers). They treat the environment as context, without a health of its own.
- **Social determinants of health** (Marmot; the WHO Commission, 2008) and the social gradient.
- **Carer and family spillover** in health economics.
- **Ethics of care and relational autonomy.**
- **Social capital and collective efficacy.**
- **Wellbeing accounting** that separates current wellbeing from the capital stocks that sustain future wellbeing (OECD *How's Life?*; Stiglitz, Sen and Fitoussi; inclusive wealth). This is close to the stock–flow split here.
- **Planetary health; Raworth's doughnut** (a social foundation and an ecological ceiling).
- **Ostrom and the knowledge commons** (Hess and Ostrom).
- **Epistemic health of communities** (Piovarchy and Siskind, 2023).

The candidate contribution is narrow: measuring node and commons **with the same domains**, and linking them through inflow and outflow, with reach as the bridge between a node's agency and the commons. Whether that has been done already is what the brief asks.

## 10. Cautions

- **No ranking of families or communities.** Moving health out of the individual stops blaming people for what their network does to them. That is good. It must not become a ranking of families, communities or countries.
- **A claim to care never depends on outflow.** A person who gives little back has the same claim to care.
- **Carers are not a resource to be maximized.** Making care visible must not become a way to demand more of it.
- **Who decides what a healthy commons is?** That needs public deliberation and must stay open to challenge (step 8 applies to the measure itself).
- **Goodhart applies at every level.** Visible contributions can be produced while harder costs are shifted elsewhere.

## 11. Predictions and open questions

Proposed predictions are in [PREDICTIONS.md](../../PREDICTIONS.md), Part III (H7–H9):
- carer margin and respite predict how long care lasts;
- the commons profile adds to individual and supported profiles in predicting how people fare;
- reach and delay predict how far people maintain a commons.

Open questions:
- How do capacity, inflow and commons combine: a profile, interaction, thresholds?
- Is "reach" already defined elsewhere, as sphere of influence, political efficacy or locus of control?
- How to attribute a change in the commons to the many small outflows that caused it?
- How to state carer exhaustion with several carers, changing costs and a commons that can itself run down?
