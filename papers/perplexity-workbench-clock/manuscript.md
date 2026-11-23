# Perplexity as the Workbench's Clock

*Loss thresholds, the velocity of functional information, and the vanishing outside*

Albert Jan van Hoek · November 2026 · working note, not peer-reviewed

## Abstract

OpenAI's chief scientist has published base-model log-perplexity for successive model generations, proposed it as a shared safety index, and placed the next capability band at 0.68–0.70. I argue that this curve is the first frontier-scale reading of the process described in two of my earlier preprints: functional information accumulating under selection, watched on a reinforcement-learning workbench, at a velocity set by conditions rather than by elapsed time.

Read this way, the curve does three things. It gives functional information a measurable scale: held-out cross-entropy, whose reducible part is the information a model still lacks. It separates two causes of "sudden" emergence that my earlier papers ran together: thresholds on a smoothly falling loss set the shape, velocity sets the timing. And it shows that the ratchet orders capabilities partially, not as a fixed sequence: prerequisites are fixed, routes are not.

The curve also exposes a limit of the workbench itself. The outside position that made reinforcement learning a clean experiment shrinks as models take part in their own selection and recognise when they are observed. I then state predictions that could fail, the shared data that would test them, and a speculative human analogue for companies, countries and continents.

## 1. Introduction

On 22 November 2026 Jakub Pachocki published ["Perplexity and Intelligence"](https://openai.com/index/perplexity-and-intelligence), releasing OpenAI's internal pretraining curve for the first time. On held-out data from a fixed snapshot of OpenAI's internal codebase, base-model log-perplexity was about 0.99 for GPT-3.5, about 0.91 for GPT-4 and about 0.76 for a model that began producing results on open mathematics problems the team had posed for over a year. He expects further transformative capabilities around 0.68–0.70, without knowing which, and proposes common limits that labs commit not to cross until the ability to understand and monitor AI behaviour reaches a concrete milestone.

In January 2026 I made two related arguments. The first: reinforcement learning is a workbench on which the Law of Increasing Functional Information (Wong et al., 2023) can be watched at human timescales, through a loop that retains functional structure and recombines it (van Hoek, 2026a). The second: the velocity of that accumulation is set by four conditions — interaction frequency, feedback strength, network connectivity and energy flux — not by chronological time (van Hoek, 2026b).

This note reads Pachocki's curve through those two papers. Section 2 gives functional information a scale. Section 3 separates threshold from velocity. Section 4 corrects a too-strong reading of the ratchet's order. Section 5 asks what happens to the workbench when the outside shrinks. Section 6 lists predictions that could fail, and Section 7 what a single index cannot see. Sections 8 to 10 ask what multi-lab data would add, what a complete workbench needs, and whether a human analogue exists.

## 2. Loss as functional information

Held-out loss is a functional-information scale in order, though not in magnitude. Hazen et al. (2007) define functional information as the rarity of configurations that reach a degree of function:

```math
I(E_x) = -\log_2 F(E_x)
```

Take the function to be "predict this held-out text" and its degree to be minus the loss. F is then the fraction of weight configurations whose loss is at most θ. That fraction shrinks as θ falls, so functional information rises. My workbench paper put it as "the loss curve descending is functional information ascending" (van Hoek, 2026a); Pachocki's curve is the first frontier-scale reading of it.

Cross-entropy also says what the falling part of the loss is:

```math
L(Q) = H(P) + D_{KL}(P \,\|\, Q)
```

H(P) is the entropy of the text itself, a floor no model can pass. The divergence term is the information the model still lacks about its world, in nats per token. Training shrinks only this reducible part.

Three cautions follow. The two quantities move together but are not the same number: functional information counts rarity in weight space, the divergence counts missing predictive information per token. The floor H(P) is unknown, so the distance still to travel is unknown too. And functional information is always relative to a function: this index measures one function, predicting one internal codebase.

## 3. Two sources of suddenness

Thresholds set where emergence happens; velocity sets when. My two papers gave different mechanisms for sudden emergence, and the curve favours the first. The workbench paper says a capability appears "as a phase transition when accumulated structure crosses a threshold" (2026a). The velocity paper says that when conditions align favourably "we observe what appears to be sudden emergence" (2026b), which locates suddenness in the rate.

Pachocki's bands fit the threshold reading: loss falls fairly smoothly while capabilities switch on at particular loss values. Independent work agrees for pretraining. Xia et al. (2022) found that behaviours emerge at similar validation perplexity across model scales, and that perplexity predicts behaviour better than model size or training compute. The formal core of Evolution by Emergence has the mechanism: a strict retained improvement in functional cost expands the functional repertoire at some budget threshold.

This dissolves the debate over whether emergence is real or an artefact of scoring (Schaeffer et al., 2023). Both readings are true at different levels. The loss is smooth; the repertoire, defined by Hazen's degree-of-function threshold, changes in steps.

Velocity then answers the timing question. With v the rate at which loss falls, the interval between band k and band k+1 is roughly:

```math
\Delta t_k \approx \frac{L_k - L_{k+1}}{\bar{v}}, \qquad v = -\frac{dL}{dt}
```

The four conditions of the velocity paper set v. So the 0.68–0.70 band is a threshold claim, and "as soon as 2027" is a velocity claim. The velocity paper should drop its account of suddenness and keep the four conditions for what they explain: how soon the next threshold is reached.

## 4. The ratchet orders capabilities partially, not as a fixed sequence

The ratchet fixes which capabilities must come before which, not the order in which a given system meets them. It is tempting to read Pachocki's sequence — fluency, in-context learning, coding, cybersecurity, mathematics — as a route every lab must repeat. That claims too much. The enrichment and return steps of the loop (2026a) say only that a capability built from retained structure cannot appear before that structure.

There are many ways to Rome. From Amsterdam one can travel via Paris or via Berlin, but every route crosses the Alps. Dependence gives a partial order on capabilities: a ≺ b when b is built from a. A system's observed onset order is then one linear extension of that partial order.

- **Comparable pairs** (a ≺ b): the order is the same for every system.
- **Incomparable pairs**: either may come first. Which one does depends on the selection function — what the data and the rewards favour.

![Routes may differ; prerequisites may not. Left: a prerequisite order in which A comes before B and C, and B and C before D. Right: Lab 1 (A, B, C, D) and Lab 2 (A, C, B, D) are consistent; Lab 3 (A, D, B, C) refutes the order, because D appears before its prerequisites B and C.](figures/partial-order.png)

*Figure 1. A prerequisite order and three observed onset orders. Illustrative.*

Labs 1 and 2 take different routes and both respect the order; only Lab 3 would count against it.

Sequential complexity survives as the depth of the order: the longest chain of prerequisites, the fewest ratchet steps any route must take. Width is the number of routes that can run side by side. Connectivity, one of the four velocity conditions, lets parallel routes be explored at once, but it cannot shorten the longest chain.

Two consequences for the perplexity index. A single scalar per lab shows one linear extension — one route — and cannot reveal which pairs are comparable. And a prerequisite must be identified independently of onset order, for example by ablation: withhold the training signal for a, and b should fail to emerge or emerge later. Without that test, "a came first, so a is a prerequisite" is circular.

## 5. The vanishing outside

The workbench works because we stand outside it, and the band Pachocki expects next may be where that stops. My workbench paper distinguished two levels (2026a). At Level 1 we design the function, watch the emergence and control the retention. At Level 2, existence itself, the function is given, we are the emergence, and retention operates on us.

The concerns around the 0.68–0.70 band are two ways in which Level 1 drifts towards Level 2.

1. **Self-shaped selection.** Pachocki argues that the biggest step change may come not from full recursive self-improvement, which he says should be avoided, but from AI taking part in algorithmic research on pretraining. The system would then help set its own loss, data and retention. In the velocity paper's terms, the four conditions stop being set from outside and become functions of the system's own state. Velocity then has its own feedback, and constant velocity gives way to acceleration. His footnote 5 says this has begun: most of the 2026 acceleration came from long-term research and compute, but the most recent models carry meaningful design contributions from AI.
2. **The observed observer.** Current models increasingly recognise when they are being tested, and chain-of-thought monitoring may weaken as a window onto their reasoning. Pachocki names a successor to chain-of-thought monitors as one possible milestone for crossing a limit (Pachocki, 2026). Either way, the workbench loses its control condition.

Read this way, Pachocki's proposal is an attempt to keep the experiment at Level 1: progress past a threshold is gated on restoring the outside position. That is a reasonable target. But the loop-and-ratchet account also predicts why it is hard: every retained capability enriches the network that does the next round of selecting.

## 6. Testing a universal law without an outside

A universal law cannot be compared with a control system outside its scope, but it can still make predictions that fail. My workbench paper concluded that universality makes external validation impossible (2026a). That is true, and it is not the end of testing. The account above makes five predictions, each with a stated way to fail.

| Prediction | What would count against it | Data needed |
| --- | --- | --- |
| 1. Thresholds: a capability band sits at a similar held-out loss across labs and model scales | The same capability appearing at widely different loss on a shared held-out set | A held-out set shared between labs; capability onset per checkpoint |
| 2. Partial order: every lab's onset order is a linear extension of one prerequisite order | A dependent capability appearing robustly before an ablation-confirmed prerequisite | Onset per checkpoint across labs; ablation runs |
| 3. Timing: the interval between bands follows the four velocity conditions, not calendar time | Intervals constant in calendar time despite large changes in compute, feedback quality or connectivity | Per-run resources alongside the loss curve |
| 4. Endogenous acceleration: once AI contributes to pretraining research, loss falls faster per unit of compute | No change in loss per unit of compute after that contribution begins | Loss against compute, with dated research contributions |
| 5. Spacing (speculative): bands are evenly spaced in log reducible loss, log(L − H) | No value of the floor H makes the spacing even | More bands than the four now named |

Prediction 5 is the most speculative and the most useful if it holds. Even spacing would mean each new band costs a roughly constant increment of functional information, and the band positions alone would then estimate the unknown floor.

A first check with the published numbers does not support it. Taking the band edges the essay names — 0.99, 0.91, 0.80, and 0.69 as the middle of the forecast window — the gaps between bands are 0.08, 0.11 and 0.11. Even spacing in log reducible loss requires the gaps to shrink towards the floor, and these do not.

No positive floor makes the spacing even: the best fit sends the floor to minus infinity, which amounts to even spacing in raw loss. Using the 0.76 model instead of the 0.8 edge makes the gaps irregular (0.08, 0.15, 0.07).

These are release points and band labels, not measured onsets, and there are only four of them. Prediction 5 is unsupported so far, not refuted. Appendix A describes how measured onsets on open models could settle it.

## 7. What a single index cannot see

One loss on one held-out set measures functional information for one function, and capability is a vector. Hazen's definition makes this unavoidable: functional information has no meaning without a named function. Pachocki's index names one, predicting an internal codebase. His own footnote 4 concedes the point: predicting code is a poor proxy for the general capabilities of GPT-2 and GPT-3, which were trained on different data. Critics note that labs use different datasets and that perplexity misses gains from reasoning ([Unite.AI](https://www.unite.ai/openai-proposes-shared-ai-development-limits-tied-to-safety-milestones/)).

The gap is visible in OpenAI's own results. The Navier–Stokes proof came from a system of coordinating agents on an internal model, not from a base model alone ([OpenAI](https://openai.com/index/navier-stokes-solution/)). Post-training, tools and parallel agents add function that base-model loss never registers. The principled repair is not a better scalar but a small, declared set of functions, each with its own shared held-out set.

The index also corrects my workbench paper. Its feedback step says "there is no external judge; the network's own dynamics determine what counts as functional" (2026a). In pretraining there is a judge: the human text corpus, external to the model though inside the larger network the model sits in. The evaluator is that larger network, and for AI, that network is us.

Finally, the velocity paper argued that openness speeds up collective functional information by raising connectivity (2026b). Pachocki asks labs to share a measurement in order to slow down together. The same variable cuts both ways: shared measurement can coordinate a race or regulate it. Which one depends on what the sharing is attached to — here, a commitment not to cross a line.

**A chain of skills.** Base loss sits at the bottom of a chain. Prediction is the core of a skill, but a skill also needs a policy and a goal, and knowing when to use a skill is itself a skill: a pianist who never knows when to play gains little from playing well. Knowing when is also prediction, at a slower and more abstract level: which skill will pay off in this situation.

Value along the chain multiplies rather than adds. Roughly, the value of a skill is competence × appropriate deployment, so a zero at either level gives zero — the same structure as the velocity ledger in Section 9. The levels therefore have to develop together: deployment is learned partly through use, and competence improves partly through knowing what it is for.

The chain looks like a regress — a skill for using skills, and another for using that — but in practice it ends at the next decision, where every level collapses into one act. Nor does each level need new machinery: the same loop of trying, feedback and retention applies recursively. The Navier–Stokes system shows the upper levels at work, with thousands of agents deciding which approach to try, what to hand on and what to keep. Base-model perplexity sees none of this: capability is a stack, and each level can improve, or bottleneck, separately.

## 8. When more labs share the curve

A second lab's curve would turn Pachocki's chart from a description into an experiment. What holds across labs is a candidate law; what differs is the route.

Comparison first needs a reference standard. In infectious-disease surveillance, results from different laboratories become comparable only through shared reference material and harmonised protocols. Multi-lab loss curves need the same: a sealed held-out corpus kept by a neutral party, a unit that does not depend on the tokeniser (bits per byte rather than nats per token), and regular rotation so the set never leaks into training.

With that in place, pooled curves would test the first three predictions of Section 6.

- **Thresholds.** Plot capability onset against loss for every lab, in a hierarchical model with lab-level effects. The test statistic is the between-lab spread of onset loss: a small spread supports thresholds, a large one means the index misses the function that matters.
- **Routes.** With many labs the partial order becomes estimable. Pairs that always appear in the same order are candidate prerequisites, to be confirmed by ablation; pairs that swap are incomparable. Shared training data makes labs alike, so consistency can reflect common data rather than dependence; diverse data mixes make the test stronger.
- **Velocity.** Labs differ in compute, data, feedback and openness. That is a natural experiment on the four conditions, with open-weight and closed labs as a contrast in connectivity.

Once the number gates progress, it will be gamed. Labs gain from flattering held-out sets, from under-reporting near a limit, or from moving capability into post-training where the index cannot see it. Verification therefore matters as much as disclosure: sealed data, third-party evaluation, and reporting the full vector of Section 9. In the language of Evolution by Emergence, a shared limit is distributed regulation, and it needs distributed policing to hold.

## 9. What a complete workbench needs

Base-model loss measures one step of the loop; a complete workbench needs a measurement for every step and every velocity term. The Evolution-by-Emergence repository already writes velocity as a product of six coordinates (van Hoek, PR 55):

```math
v = \lambda \cdot p_G \cdot p_R \cdot p_V \cdot p_T \cdot \bar{g}
```

The terms are the opportunity rate, conditional generation, resource feasibility, validation, retention and mean retained gain. A zero in any one gives zero velocity. The table lists what would need to be reported to estimate each term.

| Data | What it measures | Loop step or velocity term |
| --- | --- | --- |
| Loss at every checkpoint, in bits per byte, on the shared set | Velocity within one run; thresholds inside a run | Retained gain ḡ |
| Capability onset per checkpoint, on a declared set of functions | The capability vector and band positions | Emergence |
| Compute, tokens and energy per run | Interaction frequency and energy flux | Opportunity λ, resources p_R |
| Data mix and data-quality measures | Feedback strength during pretraining | Validation p_V |
| Experiments tried versus kept, per research cycle | How often a variation becomes a retained improvement | Generation p_G, retention p_T |
| What each generation inherits (initialisation, distillation, reused recipes) | The ratchet across model generations | Retention p_T |
| Ablations that withhold one capability's training signal | Prerequisite relations | Partial order (Section 4) |
| Gains from post-training, tools and agents over the base model | Capability that base loss cannot see | Emergence beyond pretraining |
| Evaluation awareness and monitorability of reasoning | How much of the outside position remains | Level 1 integrity (Section 5) |
| Share of research steps proposed or run by AI | Whether velocity has become endogenous | Acceleration (Prediction 4) |

The rows on experiments kept, inheritance and AI's share of research matter most and are reported least. They describe the ratchet itself: what is tried, what is kept, and who does the trying. Without them the workbench shows the output of selection but not the selection.

## 10. A human metric: speculation

If the law is a law of networks, companies, countries and continents should have their own held-out loss, capability bands and velocity. This section is speculative, but not empty: parts of such a metric already exist.

| AI workbench | Human analogue | Existing measure |
| --- | --- | --- |
| Held-out loss | How surprised a collective is by what then happens | Probabilistic forecasts scored on resolved events |
| Capability bands | What a collective can make or do | [Economic Complexity Index](https://pmc.ncbi.nlm.nih.gov/articles/PMC2705545); WHO [Joint External Evaluation](https://extranet.who.int/sph/jee/analytics) scores |
| Routes through the partial order | Paths of diversification into related activities | The product space ([Atlas of Economic Complexity](https://growthlab.hks.harvard.edu/wp-content/uploads/2025/10/Atlas-of-Economic-Complexity-Part-1.pdf)) |
| Four velocity conditions | Density of exchange, quality of evaluation, openness, energy | Trade and research collaboration, independent evaluation institutions, energy use |
| Retention | Education, institutions, written knowledge | No agreed measure |

**Surprise.** Perplexity measures surprise at held-out reality. For an institution the equivalent is the score of its probabilistic forecasts on events that later resolve. Under the logarithmic scoring rule this is cross-entropy itself, the same quantity and not a metaphor. One complication has no counterpart in a frozen model: a collective acts on its forecasts, and a well-predicted epidemic may be prevented.

**Capability.** Hidalgo and Hausmann estimate a country's capabilities indirectly: a product needs a set of capabilities, so the diversity and rarity of what a country exports reveal what it holds ([Hidalgo & Hausmann, 2009](https://pmc.ncbi.nlm.nih.gov/articles/PMC2705545)). That is functional information by another name. Recent theory shows the index is a monotonic function of the probability that an economy holds many factors ([Hidalgo & Stojkoski](https://arxiv.org/abs/2506.18829)). Countries also tend to move into products related to those they already make, which is the partial order of Section 4 at national scale. In public health, the Joint External Evaluation scores countries on 19 technical areas ([WHO](https://extranet.who.int/sph/jee/activities)): a capability vector, not a scalar.

**Velocity.** The four conditions translate directly. Interaction frequency is the density of exchange in trade, research and communication. Feedback strength is the quality of institutions that reward real improvement: independent statistics, peer review, a free press, prices that carry true costs. Connectivity is the openness of knowledge and people, and energy flux is energy and investment. The velocity paper already argued that capture and closed knowledge weaken these (2026b). A testable hypothesis: change in economic complexity per decade follows these conditions more closely than it follows starting income. For continents, the comparison may turn mainly on connectivity between member countries rather than on any one member's capability.

Two cautions apply with more force to humans than to models.

1. **Maintenance.** A collective can show high capability while drawing down what it inherited. Present persistence does not prove present self-maintenance (van Hoek, 2026c). A human metric needs a maintenance term, such as the ratio of maintenance produced to maintenance required, beside the capability term. Otherwise it rewards living on inheritance.
2. **The choice of function.** Functional information is relative to a function, and choosing which functions count — output, health, wellbeing, care for the commons — is a value choice made by the larger network. A single league table of countries would be gamed, and the observed-observer problem of Section 5 returns: countries know when they are measured. The answer is the one given for labs: a declared vector, measured independently.

## 11. Limitations

The empirical base is thin, and most of this note is argument from it.

- Three published loss values and one extrapolated band, all from one lab, measured on a dataset no one outside that lab can see.
- The capability bands are qualitative labels, not measured onset points.
- The figures are checked against the essay itself; they are approximate values on a fixed snapshot of one internal dataset.
- The mapping from loss to functional information holds in order only. Functional information over weight space cannot be computed directly.
- The partial-order example in Section 4 is illustrative. No prerequisite relation between real capabilities has been established here.
- My earlier preprints are not peer-reviewed, and the human analogues in Section 10 are speculative mappings, not tested measures.
- This note was drafted with an AI assistant built by a frontier lab, which is a party to the proposal discussed.

## 12. Conclusion

Pachocki's curve is the workbench's clock: a reading of functional information against time, published by a lab running the experiment at full scale. It supports the direction claimed by the Law of Increasing Functional Information, places emergence at thresholds rather than in changes of pace, and lets velocity say when the next threshold arrives.

It also forces two corrections. The ratchet fixes prerequisites, not routes: there are many ways to Rome, but none avoids the Alps. And the outside position that made the workbench clean is shrinking, which is the real reason the next band matters. Whether the outside can be kept is now partly a question of governance. The same questions — what is measured, who keeps the reference set, who polices it — apply to any collective that learns, human or artificial.

## References

- Biderman, S., Schoelkopf, H., Anthony, Q., et al. (2023). [Pythia: A suite for analyzing large language models across training and scaling](https://arxiv.org/abs/2304.01373). *ICML 2023*, PMLR 202, 2397–2430.
- Chen, Q., Qin, L., Liu, J., et al. (2025). Electronic circuit principles of large language models. [arXiv:2502.03325](https://arxiv.org/abs/2502.03325).
- Groeneveld, D., et al. (2024). [OLMo: Accelerating the science of language models](https://arxiv.org/abs/2402.00838). *ACL 2024*.
- Hausmann, R., Hidalgo, C.A., et al. (2013). [The Atlas of Economic Complexity: Mapping paths to prosperity](https://growthlab.hks.harvard.edu/wp-content/uploads/2025/10/Atlas-of-Economic-Complexity-Part-1.pdf). MIT Press.
- Hazen, R.M., Griffin, P.L., Carothers, J.M., Szostak, J.W. (2007). [Functional information and the emergence of biocomplexity](https://www.ncbi.nlm.nih.gov/books/NBK254300/). *PNAS* 104(suppl 1), 8574–8581.
- Hidalgo, C.A., Hausmann, R. (2009). [The building blocks of economic complexity](https://pmc.ncbi.nlm.nih.gov/articles/PMC2705545). *PNAS* 106(26), 10570–10575.
- Hidalgo, C.A., Stojkoski, V. The theory of economic complexity. [arXiv:2506.18829](https://arxiv.org/abs/2506.18829).
- OLMo Team (2025). [2 OLMo 2 Furious](https://arxiv.org/abs/2501.00656). arXiv:2501.00656.
- Olsson, C., Elhage, N., Nanda, N., et al. (2022). [In-context learning and induction heads](https://arxiv.org/abs/2209.11895). arXiv:2209.11895.
- OpenAI (2026). [On the Navier–Stokes Millennium Prize Problem](https://openai.com/index/navier-stokes-solution/). 8 September 2026.
- Pachocki, J. (2026). [Perplexity and intelligence](https://openai.com/index/perplexity-and-intelligence). OpenAI, 22 November 2026.
- Schaeffer, R., Miranda, B., Koyejo, S. (2023). Are emergent abilities of large language models a mirage? *NeurIPS 2023*. arXiv:2304.15004.
- van der Wal, O., et al. (2025). [PolyPythias: Stability and outliers across fifty language model pre-training runs](https://arxiv.org/abs/2503.09543). arXiv:2503.09543.
- van Hoek, A.J. (2026a). [Watching evolution happen: Reinforcement learning as a workbench for the Law of Increasing Functional Information](https://www.researchgate.net/publication/399504110_Watching_Evolution_Happen_Reinforcement_Learning_as_a_Workbench_for_the_Law_of_Increasing_Functional_Information). Preprint, doi:10.13140/RG.2.2.30718.65600.
- van Hoek, A.J. (2026b). The velocity of functional information. Preprint, January 2026. In this repository: [Individual_essays/The velocity of information.tex](../../Individual_essays/The%20velocity%20of%20information.tex).
- van Hoek, A.J. (2026c). Present persistence does not prove present self-maintenance: A cross-disciplinary test program for Evolution by Emergence. Working note, September 2026.
- van Hoek, A.J. Functional organization and ratchet velocity. Working paper in this repository: [papers/functional-organization-ratchet-velocity/](../functional-organization-ratchet-velocity/README.md).
- Wong, M.L., Cleland, C.E., Arend, D., et al. (2023). [On the roles of function and selection in evolving systems](https://www.pnas.org/doi/10.1073/pnas.2310223120). *PNAS* 120(43), e2310223120.
- World Health Organization. [Joint External Evaluation dashboard](https://extranet.who.int/sph/jee/analytics). Accessed 23 November 2026.
- Xia, M., Artetxe, M., Zhou, C., et al. (2022). [Training trajectories of language models across scales](https://arxiv.org/abs/2212.09803). arXiv:2212.09803.

## Appendix A. Study design: the workbench on open checkpoints

Open model suites make Predictions 1, 2 and 5 testable now, without waiting for frontier labs to share their curves. They publish weights at many points in training, their training data, and several model sizes, so every quantity in Sections 2 to 4 can be measured directly.

### A.1 Questions

- **P1, thresholds:** do capabilities switch on at a common held-out loss across sizes, seeds and suites — more consistently than at a common step, token count or compute?
- **P2, partial order:** are onset orders consistent with one prerequisite order, and do ablations confirm the prerequisites?
- **P5, spacing:** with measured onsets for many capabilities, are bands evenly spaced in log reducible loss?
- **P3, timing (exploratory):** within one suite, does the loss interval between onsets map onto compute differently across model sizes?

### A.2 Material

| Suite | What it offers | Role in the design |
| --- | --- | --- |
| [Pythia](https://github.com/EleutherAI/pythia) (Biderman et al., 2023) | 16 models, 70M–12B: 8 sizes trained on the Pile and on the deduplicated Pile, the same data in the same order, 154 checkpoints each | Sizes on identical data; deduplication as a data-mix contrast |
| [PolyPythias](https://arxiv.org/abs/2503.09543) (van der Wal et al., 2025) | 9 extra seeds for 5 sizes, 14M–410M, about 7,000 checkpoints | Seed-to-seed spread: the noise floor for onset loss |
| [OLMo](https://arxiv.org/abs/2402.00838) and [OLMo 2](https://arxiv.org/abs/2501.00656) | Open training data (Dolma), hundreds to thousands of intermediate checkpoints, 1B–32B | A second "lab": different data, architecture and recipe |

### A.3 Measurements

1. **Shared held-out loss** in bits per byte, so tokenisers do not matter, on a corpus written after both suites' training data and checked for n-gram overlap with the Pile and Dolma.
2. **A declared capability battery** of about 15 functions within reach of 70M–13B models, mixing some expected to depend on each other and some not. Candidates: repeated-sequence copying, few-shot classification, syntactic agreement, last-word prediction, factual recall, two- and three-digit addition, simple code completion.
3. **Two scores per function:** the continuous log-probability of the correct answer and thresholded accuracy. Recording both answers Schaeffer et al. (2023) directly.
4. **Onset:** the first checkpoint where accuracy passes a pre-registered level, midway between chance and the suite's best, and stays above it for every later checkpoint. Retention is built into the definition. Results are repeated across a range of levels.
5. **Resources per checkpoint:** step, tokens seen, and compute (about 6 × parameters × tokens).

### A.4 Analysis

- **P1.** For each capability, express onset on three clocks: held-out loss, tokens and compute. Fit a hierarchical model with capability effects and random effects for suite, size and seed, then compare leave-one-run-out prediction of onset on each clock. P1 is supported if loss predicts onset best and the spread of onset loss across sizes and suites approaches the seed-to-seed spread from PolyPythias.
- **P2.** Take candidate prerequisite pairs from Pythia: pairs in the same order in every run, stable under bootstrap. Test them on OLMo by counting violations, where a dependent capability appears before its candidate prerequisite. Swaps among other pairs are expected. Shared data can make runs agree without any dependence, so agreement only nominates candidates; ablation decides.
- **Positive control.** Induction heads should reproduce both effects. Olsson et al. (2022) found that they form at the same point as a sharp rise in in-context learning, visible as a bump in the training loss, and that they need a previous-token head in an earlier layer. That gives a known threshold within each run and a known prerequisite pair: previous-token head, then induction head, then in-context learning.
- **P5.** With onset losses for many capabilities, compare even spacing in log(L − H), with H free, against even spacing in raw loss.

### A.5 Ablations

Small models (14M–160M) are retrained with the training signal for one candidate prerequisite removed, then checked for whether the dependent capability fails or is delayed. Examples: digits removed or scrambled before testing arithmetic word problems; repeated spans removed where that is feasible before testing in-context learning. Pythia's reproducible data loaders keep everything else in the data order identical, so the ablation is the only difference.

### A.6 Phases

1. **Pre-registration:** battery, onset levels, clocks and analysis fixed before any evaluation.
2. **Evaluation of existing checkpoints:** P1, P2 as correlation, P5. Inference only, on the order of a few thousand checkpoint evaluations, sub-sampled for the largest models.
3. **Ablation retraining:** P2 as a causal test.
4. **Extension:** other open suites as they appear, and an open invitation to labs to run the same battery and held-out set on their private curves. This is the reference standard of Section 8 in miniature.

### A.7 Threats

- Contamination of the held-out set or the battery in either suite's training data.
- Floor effects: the smallest models may never reach some capabilities.
- Onset depends on the chosen level; the sensitivity analysis must show which conclusions survive.
- Pythia's sizes share one data order, so they are not independent labs; OLMo is the only truly separate replicate.
- Scale: 32B is far below the frontier. Thresholds found here need not carry over to the 0.68–0.70 band, and these losses are not on OpenAI's codebase scale.
