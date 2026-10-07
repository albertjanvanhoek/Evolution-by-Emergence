> **Research brief 1, October 2026.** Written to be given to a separate research agent, with the QALY paper (Spencer et al. 2022, [doi:10.1016/j.socscimed.2021.114653](https://doi.org/10.1016/j.socscimed.2021.114653)) attached. It produced the two reports in [../sources/](../sources/), reviewed in [../REVIEW_OF_THE_REPORTS.md](../REVIEW_OF_THE_REPORTS.md). Kept verbatim as the record of what was asked; its framing was revised by the answers (see [../HEALTH_OF_INTELLIGENCE.md](../HEALTH_OF_INTELLIGENCE.md)).

# Research brief: a shared measure of the health of intelligence, for humans and AI systems

## Background
I am developing a theory called Evolution by Emergence (EbE): https://github.com/albertjanvanhoek/Evolution-by-Emergence (start with CORE.md). In brief:
- Intelligence is a configuration of connections, as in a neural network, that keeps itself in step with a changing world through a learning loop: feedback from outside, retention of what works, and upkeep paid from a budget.
- Any intelligence (a human, an AI model, an institution) is a node in a network. It depends on others for its upkeep and for correction, and it draws on a shared commons of knowledge.
- No intelligence can certify itself from the inside. Views that exclude each other cannot both be right, so confidence is not evidence of being right.

From health economics I know quality of life, measured by instruments such as EQ-5D (mobility, self-care, usual activities, pain/discomfort, anxiety/depression) and combined with time in the QALY. Two observations started this brief:
1. **EQ-5D takes the intelligence of the person for granted.** It has no dimension for comprehending the world consistently, yet every dimension assumes a subject who does. The QALY's valuation methods (time trade-off, standard gamble) also assume a coherent chooser. Much of their methodological history (violations of expected-utility axioms, order effects, framing) can be read as that assumption failing.
2. **For AI systems, EQ-5D means nothing.** But AI systems also have something like health: they can drift, degrade, become miscalibrated, collapse when trained on their own output, become sycophantic, or lose the routes by which their errors are found.

## The question
Is there, or could there be, a **shared, substrate-neutral measure of the health or quality of intelligence**, defined in the same terms for humans, AI systems and collectives, as a common interface between them? If so, what are its dimensions, how would each be measured for each kind of system, and what does building it teach us about the underlying model of intelligence?

## A working proposal to test, not to defend
These five dimensions come from the theory. Challenge them, merge them, split them or replace them as the literature suggests.
1. **Change:** capacity to learn: reconfigure from feedback and retain what works.
2. **Compression:** doing more with less, capturing structure at low upkeep without discarding the distinctions that matter.
3. **Coherence:** consistent where evidence is stable, revisable where it changes; confidence that tracks accuracy; never certain of what is still possible.
4. **Correction:** giving and receiving correction faithfully, being corrigible without being obedient, keeping independent sources.
5. **Contribution:** adding to the commons it draws on, rather than depleting it.

Two structural claims to test:
- **Product, not sum.** The dimensions may combine like a product: a system with zero correctability is sealed, however well it learns. If so, an additive index would be misleading.
- **Individual versus supported.** Intelligence may be partly a property of the network. A person with dementia, supported by carers and records, may stay in step with the world far better than the same person alone. So there may be an individual and a supported quality of intelligence, and the gap between them measures what support restores.

## What to investigate
Search widely. Verify every source you cite; if you recall a work but cannot confirm it, say so. Relevant areas include, but are not limited to:
- **Health and quality-of-life measurement:**
  - instruments that include cognition (Health Utilities Index Mark 3, 15D, AQoL), cognition bolt-ons to EQ-5D, EQ-HWB, ICECAP and the capability approach (Sen, Nussbaum);
  - dementia and proxy valuation;
  - the WHO International Classification of Functioning (ICF), especially mental functions and environmental factors;
  - definitions of health as the ability to adapt and self-manage (Huber et al., 2011, "positive health");
  - Canguilhem's view of health as the capacity to set new norms;
  - equity critiques of the QALY, especially disability discrimination.
- **Theories and measures of intelligence:**
  - psychometrics (g, CHC theory);
  - universal or formal definitions (Legg and Hutter; Chollet, "On the Measure of Intelligence");
  - intelligence as compression (minimum description length, Hutter);
  - collective intelligence (Woolley et al., the c factor);
  - extended and distributed cognition (Clark and Chalmers; Hutchins);
  - cognitive reserve.
- **The health of AI systems:**
  - calibration, robustness and distribution shift;
  - continual learning and catastrophic forgetting;
  - model collapse and data provenance;
  - sycophancy and honesty;
  - evaluation frameworks (for example HELM), model monitoring and drift detection;
  - any work explicitly framing "model health", "AI wellbeing" or "AI welfare". Keep moral status separate from functional health and say which is which.
- **Health and viability of systems in general:**
  - homeostasis and allostasis;
  - resilience (Holling);
  - viability theory;
  - cybernetics (Ashby's requisite variety, the good-regulator theorem);
  - autopoiesis; the free-energy principle;
  - prognostics and health management in engineering;
  - organizational health;
  - Ostrom on long-lived commons;
  - the health of epistemic networks and information ecosystems (Zollman).

## Deliverable
A structured overview of about 3,000–5,000 words, plus an annotated bibliography, with these sections:
1. **The question restated** in one paragraph, in your own words.
2. **Map of existing work:** for each literature above, what it measures, at what level (individual, system, network), and how it relates to each of the five proposed dimensions. Include a table of literatures against dimensions.
3. **Is this new?** The closest prior art to a substrate-neutral health of intelligence. Say plainly what already exists, what is partly new, and what seems genuinely missing.
4. **A candidate shared interface:** the dimensions you would actually recommend, each with:
   - a substrate-neutral definition;
   - how to measure it in a human, an AI system and an institution;
   - its levels, for example three or five, as in EQ-5D.
5. **Combining and valuing:**
   - Sum, product, or profile with no single index?
   - Who or what sets the weights, and could they come from what predicts staying in step rather than from preferences?
   - The equity risks, especially for people with cognitive impairment, and how the individual-versus-supported distinction affects them.
6. **What this teaches the meta-model:**
   - Which parts of the theory are strengthened, which are challenged, and which are missing?
   - Name at least three testable predictions a shared measure would make, and what would count against each.
7. **Open questions and risks,** including where a shared measure would mislead, for example anthropomorphizing AI systems or medicalizing humans.
8. **Annotated bibliography:** about 30–60 sources, each with one line on why it matters and a link or DOI where possible.

## Standards
- Be critical. A finding that existing work already covers this, or that the five dimensions are poorly chosen, is as valuable as support.
- Separate clearly:
  - established findings, with sources;
  - your synthesis;
  - speculation.
- Do not treat the theory's own claims as evidence for themselves.
- Where literatures use different words for the same thing (for example "adaptability", "plasticity", "resilience", "change"), say so explicitly; the mapping is part of the value.
