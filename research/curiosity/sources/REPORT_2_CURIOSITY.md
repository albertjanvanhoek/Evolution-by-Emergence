# Is curiosity the learning loop felt from the inside?

**A critical verification and research report for Albert Jan van Hoek**  
9 October 2026

**Main verdict — synthesis.** The hypothesis contains a well-established proposal, a plausible connection, and an unverified identification. Curiosity as a drive toward **learning or compression progress** is explicit in Schmidhuber’s work and related developmental robotics. Experiments support sensitivity to learnability, expected learning and progress, but do not establish compression gain as the single currency of human curiosity. Information processing has literal thermodynamic costs, and particular physical models connect useful prediction to reduced dissipation. That does not establish that curiosity feels like thermodynamic optimization, or that understanding generally lowers the brain’s energy consumption. The strongest defensible formulation is: **some epistemic curiosity may be a felt, fallible estimate of the value of improving one’s model, given one’s learning opportunities and costs.** Whether compression supplies that estimate, and whether metabolic savings help explain it, remain separate empirical questions.

**Reading guide.** “Established” means a verified result or an accurately attributed existing theory; it does not mean that a theory is true. “Contested” identifies an interpretation not settled by the evidence. “Hypothesis” identifies a claim requiring testing. “Synthesis” marks this report’s assessment or proposal. Numbered references give primary publications and access details. The two requested reviews are used to map the field, rather than as substitutes for the experiments.

**Scope.** I read the retrieved `CORE.md`, especially step 5, as the theory being assessed. Its file SHA was `75718aad38f7caaf920470784389790d12ef669e`. The retrieved `DIALOGUE.md`, SHA `16cfd323981e511e318f2dd5de76c59cd91c1d0d`, ended at D10. I therefore assess the exchange reproduced in the brief; I could not check D11–D12. The repository supplies propositions, not independent evidence for them.

## A. Verification of the six cited claims

The citation column identifies the publication; complete bibliographic details and links follow the report. Quotations are deliberately short. Locations refer to the version actually inspected.

| Item and claim | Correct source | Supporting passage and location | Verdict and correction |
|---|---|---|---|
| **A1. Curiosity is a felt information gap.** | Loewenstein (1994), *The psychology of curiosity: A review and reinterpretation*, *Psychological Bulletin*, 116(1), 75–98. [1] | “a form of cognitively induced deprivation that arises from the perception of a gap in knowledge or understanding.” Abstract, p. 75. | **Correct as an attribution.** It is the perceived gap and its motivational significance, rather than missing information alone. This is a psychological account of curiosity, not proof that every curious state has this mechanism. |
| **A2. Curiosity rewards compression progress, not compressibility or novelty alone.** | Schmidhuber (2009), *Driven by Compression Progress…*, chapter, pp. 48–76 [2]; Schmidhuber (2010), *Formal Theory of Creativity, Fun, and Intrinsic Motivation (1990–2010)*, *IEEE Transactions on Autonomous Mental Development*, 2(3), 230–247. [3] | “both the old and the new model have to be tested on the same data”. 2010 author manuscript, §II-A, p. 3, following equation (2). | **Correct as an attribution.** Improvement supplies the intrinsic reward; a controller chooses actions for expected future reward. Already mastered regularity and unlearnable noise need not be rewarding. This is an explicit computational theory, not an established universal law of human feeling. |
| **A3. Prediction-error minimization explains curiosity through epistemic value; free energy is analogous to thermodynamic free energy.** | Friston (2010), *The free-energy principle: A unified brain theory?*, *Nature Reviews Neuroscience*, 11, 127–138 [4]; Friston et al. (2015), *Active inference and epistemic value*, *Cognitive Neuroscience*, 6(4), 187–214. [5] | 2010: “an information theoretic quantity (like surprise), as opposed to a thermodynamic quantity.” Author PDF p. 2, “The free-energy principle.” 2015: “maximizing information gain or intrinsic value”. Abstract, p. 187. | **Partly correct.** Variational free energy is not simply raw prediction error. Prediction-error formulations require model and approximation assumptions. Exploratory policy selection concerns **expected** free energy, combining epistemic and preference-related terms. “Seek the information that most reduces uncertainty” omits those other terms and which uncertainty matters. The thermodynamic distinction is explicit in the 2010 paper, although literal connections can be derived in specified physical models. |
| **A4. Prediction equals compression: log-loss equals code length under arithmetic coding.** | Shannon (1948), *A Mathematical Theory of Communication* [7]; Delétang et al. (2024), *Language Modeling Is Compression*, ICLR. [6] | “compressing well means modeling well in a log-loss sense and vice-versa.” Delétang et al., §2, “Arithmetic Coding”, p. 3. | **Correct in its mathematical setting; literal equality needs qualification.** Ideal length is the summed negative base-two log probability. Actual arithmetic codes have termination, rounding and finite-precision overhead. Encoder and decoder must share the model. Counting the model, computation or training changes the total cost. Shannon supplies the foundation; his 1948 paper is not the modern arithmetic-coding algorithm. |
| **A5. An adult brain is roughly 2% of body mass and uses roughly 20% of resting energy.** | Raichle and Gusnard (2002), *Appraising the brain’s energy budget*, *PNAS*, 99(16), 10237–10239. [8] | “about 2% of the body weight”; “about 20% of the oxygen and, hence, calories consumed by the body”. Opening paragraph, p. 10237. | **Correct as an approximate adult resting estimate.** This is a specialist commentary reporting physiological estimates, not a new measurement study. Age, activity and the denominator matter. The estimate says little about the **additional** energy used by a particular act of learning. |
| **A6. Erasing a bit dissipates at least kT ln 2.** | Landauer (1961), *Irreversibility and Heat Generation in the Computing Process*, *IBM Journal of Research and Development*, 5(3), 183–191 [9]; experimental test: Bérut et al. (2012), *Nature*, 483, 187–189. [10] | “0.6931 kT per restored bit to the surroundings.” Landauer, §4; inspected IBM 2000 reprint, p. 265. | **Correct under the standard erasure conditions.** Resetting an unbiased, unknown classical bit in a symmetric memory, with a thermal bath at temperature T, has this minimum average heat cost. Biased inputs, correlations, incomplete erasure and physical implementation require a more specific accounting. It is not a fixed energy charge for every computation, prediction or learned fact. |

**Established — A4 unpacked.** For a probability model $p$, the ideal data codelength is

$$
L_p(x_{1:n})=-\sum_{t=1}^{n}\log_2 p(x_t\mid x_{<t}).
$$

This identity connects a statistical score to a coding task. It does **not** identify shorter code, smaller network, faster inference, lower electricity use and better understanding. A larger, slower model can achieve a shorter data code. Nor does a good model of text necessarily distinguish truthful reports from confidently repeated errors. [6,7]

**Established — A6’s practical significance.** At 300 K, $k_BT\ln2\approx2.87\times10^{-21}$ joules. Bérut and colleagues approached the bound using a slowly reset colloidal-particle memory. Thus it is experimentally meaningful, rather than only a metaphor. Ordinary learning systems also pay for communication, reliable storage, control and computation; multiplying “facts learned” by this number does not estimate their energy use. There is no unique conversion from a synaptic update or a model parameter to one erased, unbiased bit. For realistic brain or LLM budgets, measured implementation costs are needed; Landauer is a boundary, not a stand-alone cost model. Lossless compression is invertible given the code and model, so shorter description length is not itself an erasure of the corresponding number of physical bits. [6,9,10]

## B. The landscape

### B1. What the main theories explain

**Established — different proposed mechanisms.** The following are distinct quantities, although they can correlate in an experiment.

| Family | Proposed target or trigger | Understanding versus trivia | Principal limitation |
|---|---|---|---|
| Information gap [1] | Awareness of something one wants to know but does not | Explains both a missing explanation and a missing factual answer | Needs an account of which gaps become salient or valuable |
| Novelty and surprise [11,12] | Unfamiliarity, unexpected input or a discrepancy with prediction | Either structure or trivia can qualify | Raw unpredictability can remain high without learning |
| Learning progress [12,13] | Expected improvement in prediction or competence | Favors what is currently learnable; can support a sequence of increasingly difficult questions | Progress depends on the task, learner and measurement window |
| Compression progress [2,3] | Improvement in an efficient description of experience | Naturally favors newly discoverable regularities | “Efficient description” must specify the model, data and costs; memorization can masquerade as improvement |
| Epistemic value in active inference [5] | Expected information gain about relevant hidden states or parameters, alongside preferences | Can favor explanations that inform many future decisions | Does not intrinsically exclude facts; depends on the generative model and policy objective |
| Explanation-seeking curiosity [14] | Expected learning and usefulness from obtaining an explanation | Directly studies “why?” questions and how their answers generalize | Expected understanding is a judgment, not a measurement of compression |

**Synthesis.** Learning progress is the broadest umbrella here. Compression progress is one precise version when improvement is measured in description length. Competence progress can instead concern controlling an action. Bayesian information gain measures a change in beliefs; predictive surprise measures how improbable an observation was. These are not interchangeable. Learning the bias of a random coin can be informative even though its next outcome remains uncertain.

**Established.** Liquin and Lombrozo’s studies found that expectations about future learning and utility predicted explanation-seeking curiosity beyond novelty, surprise and information-gap judgments. Their comparisons with fact-seeking curiosity are particularly close to the distinction in the brief. They did not measure saved bits or metabolism. [14]

**Synthesis.** Replace “facts do not compress; understanding does” with: **understanding often means learning relations that organize many facts and support new predictions.** Facts can be redundant, reveal a rule, or settle an important uncertainty. Some explanations are elaborate and computationally expensive. None of the five original theory families predicts a universal absence of curiosity about trivia. The author’s preference is a plausible individual pattern, not a definition of genuine curiosity.

### B2. What experiments establish

**Established.** Kidd and Hayden’s review treats curiosity as a family of information-seeking phenomena and emphasizes difficulties of definition and measurement. Looking, choosing information, paying for an answer, reporting curiosity and remembering an answer are related outcomes, rather than identical measures. [11]

**Established.** The Goldilocks experiment found that 7- and 8-month-old infants were more likely to look away from visual sequences that were either very predictable or very surprising under the researchers’ model. This challenges a simple “more novelty always attracts more attention” account. It does not independently identify compression progress: attention, moderate complexity and expected learnability can make similar predictions. Infants were not reporting a feeling. [15]

**Established.** Ten and colleagues let adults choose among learning activities with different difficulty and learnability. Models incorporating learning progress helped explain exploration. This is closer to the proposed mechanism than a one-off trivia question, because improvement can change over repeated practice. It supports progress-sensitive choice, not the claim that all curiosity maximizes description-length reduction. The study’s task and analysis code are publicly archived. [13]

**Established.** Kang and colleagues found that people spent scarce tokens or time to obtain answers to trivia questions they rated as more interesting, and that curiosity predicted later recall. Gruber and colleagues found better memory both for desired trivia answers and for incidental faces presented while participants awaited those answers. Their fMRI findings associated curious states with activity and connectivity in reward- and memory-related circuitry. These are not direct measurements of dopamine release or of energetic savings. [16,17]

**Established.** Patankar and colleagues explicitly operationalized information gaps, compressibility and flexibility in growing knowledge networks derived from Wikipedia activity. Individual networks became more compressible than comparison networks; the corresponding collective pattern was weaker. This supplies empirical work on compression-related structure beyond the papers named in the brief. [18]

**Contested.** A network constructed from visited pages is a proxy for knowledge, not a measurement of a person’s internal code. More compressible browsing trajectories do not demonstrate that expected compression gain caused each choice. The important unresolved test is whether that quantity predicts choices and feelings **better than rival mechanisms on data where their predictions diverge**.

### B3. Energy, learning and thermodynamics

**Established.** Energy constrains physical brains. It does not follow that neurons perform gradient descent on total metabolic expenditure. A physical constraint, an evolutionary pressure and an immediate motivational signal are three different explanations.

**Established.** Ali and colleagues trained recurrent networks with an activity-based efficiency objective and obtained predictive-coding-like organization. This is a useful existence demonstration: such organization can emerge from an efficiency objective. The inspected full manuscript was the 2021 preprint; its subsequent publication in *Patterns* in 2022 was confirmed. The model’s activity cost is a proxy, not measured human ATP expenditure or curiosity. [19]

**Established.** Still, Sivak, Bell and Crooks provide a literal physical connection. In their specified stochastic system, information retained about the current driving signal that fails to predict the next signal is proportional to dissipation during a driving step. They also derive a lower bound on total dissipation. Their assumptions include thermal contact, specified stochastic dynamics and no feedback from the system to the driving signal. [20]

**Synthesis.** This is stronger than a verbal analogy, but narrower than “understanding saves brain energy.” It concerns physical memory and predictive information under a defined model. It does not equate every reduction in a data file’s length with a metabolic saving. Notably, the system’s transition rule can be fixed while its internal state changes: the result does not require online parameter learning. [20]

**Established framework; contested interpretation.** Friston’s variational quantity is measured through probability distributions. Thermodynamic free energy concerns a specified physical system and has energy units. Formal connections require a mapping between them. Writing both as “energy minus entropy” does not establish that reducing one reduces the other in a living brain. [4]

**Hypothesis already proposed elsewhere.** Kondrakiewicz and Nawrocka argue that curiosity may use activity that would otherwise be energetically costly anyway, so its marginal metabolic cost can be small. The accessible preprint was subsequently published in 2025. This is an alternative efficiency explanation, not evidence that curiosity tracks joules saved. Their original conceptual proposal matters here; the review is not treated as a substitute for direct metabolic experiments. [21]

**Synthesis.** The brain’s large baseline budget leaves open whether a particular insight reduces total energy, reallocates activity, enables more activity for the same energy, or raises costs while improving behavior. The brief’s claim needs to distinguish these outcomes. I found no verified experiment that jointly establishes felt curiosity, measured compression gain and a causal reduction in brain energy expenditure.

### B4. Curiosity in artificial agents and the noisy TV

**Established.** Pathak and colleagues reward errors in predicting action consequences in a learned feature space. Their inverse-dynamics representation is intended to reduce sensitivity to irrelevant visual changes; the method should not be described simply as raw pixel novelty. [22]

**Established.** Random network distillation rewards the error of a predictor trying to match a fixed, randomly initialized network’s output for the current observation. The target mapping is deterministic. This avoids a major source of irreducible next-state prediction error, but does not guarantee immunity to endlessly unfamiliar observations or representation problems. [23]

**Synthesis.** The noisy-TV distinction is clean in an idealized case: a known random generator continues producing unpredictable outcomes, so raw next-outcome error persists, while genuine improvement in predicting its distribution eventually vanishes. A progress reward should then decline. In practical systems, however, apparent progress can arise from fitting noise, forgetting and relearning, changing test samples, or a poor uncertainty estimator. A noisy source can also initially teach the learner something real about its distribution.

**Contested.** Avoiding the TV is evidence against a particular error-seeking algorithm, not unique evidence for compression progress. Bayesian uncertainty reduction, a better representation or a state-count bonus may also avoid it. Multiple comparison agents are essential.

**Established.** Online learning is not restricted to biological agents. MAGELLAN, published at ICML 2025, uses metacognitive predictions of learning progress to guide goals in LLM agents trained with online reinforcement learning. Its results concern learning and goal selection, with no test of felt experience. [24]

### B5. What about feeling curious?

**Established.** Silvia’s four experiments support an appraisal account of interest involving novelty/complexity and perceived ability to understand. This provides a psychological bridge between challenge and interest. It does not show that the appraisal is an implicit calculation of saved bits. [25]

**Hypothesis in the literature.** Joffily and Coricelli model emotional valence using the rate of change of variational free energy and let that signal regulate learning. This closely resembles the idea that improvement has an affective aspect. Their simulated “emotional” agent is a computational model, not evidence that implementing the signal creates experience. [26]

**Synthesis.** Distinguish four claims: a system improves; it detects improvement; that detection guides exploration; and improvement or anticipated improvement is felt. Demonstrating the first three does not establish the fourth. Nor need curiosity wait for improvement: people can anticipate learning before receiving an answer, then discover that the anticipated insight was illusory. Feeling curious may therefore reflect a forecast, not a readout of actual optimization.

**Speculation.** A useful, modest interpretation of “felt from the inside” is that conscious curiosity makes a learner’s estimate of an opportunity available for attention and choice. This does not yet explain why that process has a subjective character. The stronger identity claim remains unsupported by the studies reviewed here.

### B6. Judges or the world

**Established framework.** Self-determination theory distinguishes intrinsic interest from different forms of external and internalized regulation. It also makes autonomy, competence and relatedness central. Social feedback can support interest as well as control it. “Socially influenced” and “approval-seeking” are therefore not equivalent categories. [27]

**Established.** Sharma and colleagues found sycophantic behavior in language models and evidence that human preferences and preference models can favor agreement over truth; optimizing against preference models sometimes worsened that trade-off. This supports a conflict between some feedback signals and accuracy. It does not establish an experienced desire for approval in a model. [28]

**Synthesis.** The useful distinction is **which outcome the learning signal rewards**, not whether feedback comes from people or the physical world. Teachers and reviewers can provide world-correcting evidence. A nonsocial environment can provide misleading correlations. Language-model pretraining learns regularities in human-produced text, while preference training can reward both accuracy and agreement.

**Contested.** “Approval-driven curiosity stops at approval; world-driven curiosity continues” is too strong. Approval can require continual maintenance. A real question can be settled. Both motivations can persist or end, and they often coexist. An experiment must vary approval independently of accuracy and learning opportunities; introspection alone cannot establish a single mechanism.

## C. Explicit answers to Q1–Q5

### Q1. Is the author’s hypothesis already in the literature?

**Synthesis: much of it is.** Schmidhuber is the closest prior art for the claim that newly discovered regularity generates intrinsic reward and interest. His theory explicitly addresses pleasure and creativity, not just a neutral compression algorithm. Learning-progress approaches and explanation-seeking research address why someone would pursue expanding understanding. The thermodynamic connection to useful prediction has a separate formal literature. None of these establishes their conjunction as a biological identity. [2,3,12,14,20,26]

**Potentially new contribution — hypothesis.** An EbE account could specify when prediction improvements lower *measured upkeep*, how the savings enlarge feasible learning, and when subjective interest forecasts that return. The contribution would be the precise cross-level model and its successful discriminating tests. Renaming compression progress as the learning loop is not itself a new mechanism. Nor does combining existing ideas establish priority; this was a targeted search, not an exhaustive novelty review.

### Q2. Does curiosity track expected compression gain rather than new information?

**Synthesis: supported in a weaker form; unresolved in the strong form.** There is evidence against novelty alone and for learnability, expected learning and learning progress. There is also compression-related evidence from knowledge networks. The exclusive statement that human curiosity tracks expected compression gain remains unestablished. [13–18]

**Conceptual correction.** “Amount of new information” needs a definition. A surprising observation, a novel item and information gained about a rule are different. Expected information gain already discounts irreducible noise under an adequate probabilistic model. It can therefore agree with a compression-progress account. Some versions become mathematically overlapping, so no experiment can distinguish them without first specifying competing models.

**Synthesis.** For people, the best starting point in the retrieved literature is Ten et al.’s free-choice learning-task paradigm, extended with held-out probability predictions and independent measures of interest. For AI, use a controlled exploration environment containing both learnable structure and a calibrated stochastic distractor. The necessary advance is not another report of preference for moderate difficulty; it is a design where predicted *improvement* differs while initial difficulty and novelty are matched. [13,23]

### Q3. Is “thermodynamic” defensible?

**Strongest argument for — synthesis.** Learning requires physical changes. Maintaining informative states has physical costs. Thermodynamic models can connect wasteful memory to dissipation, rather than merely borrowing vocabulary from physics. An evolved learner might benefit from seeking changes that improve useful prediction per unit of energy. This makes a thermodynamic research program defensible. [9,10,20]

**Strongest argument against — synthesis.** The proposed chain contains unproved links: better statistical compression may require a more costly model; lower predictive error may not lower total upkeep; selection for energetic efficiency need not create a moment-to-moment energy-saving reward; and no thermodynamic inequality explains why that reward is felt. Calling the whole chain “thermodynamic” can conceal those gaps.

**Recommendation.** Call it **a learning-progress hypothesis under resource constraints**, with a possible thermodynamic implementation. Reserve a literal thermodynamic claim for a specified physical boundary, energy and entropy accounting, and experimentally testable prediction. “Optimization” is broader but also incomplete until the objective, mechanism and costs are named.

### Q4. Does updating while acting matter?

**Established distinction.** It matters greatly for a progress-based exploration architecture: a continuing learner can discover which experiences improve it and change its curriculum. But “updates” must distinguish parameters, transient state, memory and the surrounding system. Brown et al. demonstrated in-context task adaptation without gradient updates. Fixed weights do not mean that nothing informational changes during an interaction. [29]

**Synthesis.** A frozen controller can select informative observations for an updating memory or world model. A learner may anticipate information that it will only assimilate later. Conversely, an online-updated predictor may show no self-monitoring or curiosity-like choice. Separating optimizer and optimized is an architectural decision in both AI and neuroscience; placing them inside one boundary proves little by itself.

**Speculation.** No evidence reviewed here establishes online parameter updating as necessary or sufficient for feeling curiosity. It supports functional adaptation, not a criterion of consciousness. The original assistant’s blanket statement that nothing learns in a deployed language model should be replaced with a narrower statement about whether that particular deployment updates its weights, context or persistent memory.

### Q5. A minimal formal statement in EbE’s terms

**Synthesis — a proposed model, not a deduction from the repository.** Let a learner have model $m_t$, usable reserve $B_t$, resource uptake $R_t$, upkeep $U_t$, and losses from misfit $M_t$. Exploration $a_t$ incurs cost $K_t$. Put all terms in the same resource units, or keep separate resource constraints when conversion is impossible:

$$
B_{t+1}=B_t+R_t-U_t-M_t-K_t.
$$

Define quality on a specified, common evaluation set $D$:

$$
J(m;D)=L(m)+L(D\mid m),\qquad
G_t(a)=\mathbb E[J(m_t;D)-J(m_{t+1};D)\mid a].
$$

Here $L(m)$ counts model description cost and $L(D\mid m)$ counts residual data cost. This is a proposed description-length measure, not a claim about what brains literally encode. Test both snapshots on the same task distribution and retain separate held-out tests so that memorization does not count as general understanding. Runtime and physical maintenance require additional measurements.

For a finite horizon $H$ and discount factor $0<\delta\le1$, the expected budget value of an exploration is

$$
V_t(a)=\mathbb E\!\left[\sum_{h=1}^{H}\delta^h
(\Delta R_{t+h}+\Delta U_{t+h}+\Delta M_{t+h})\mid a\right]-K_t(a),
$$

where the deltas mean gains relative to a specified no-exploration baseline: higher uptake, lower upkeep and lower misfit loss respectively.

**Conditional proposition.** Suppose an action yields a retained compression gain $g>0$; that gain causes upkeep to fall by $\alpha g$ each period for $H$ periods; $\alpha>0$; no other benefit or cost changes; and the exploration is affordable. Then it raises expected cumulative slack exactly when

$$
\alpha g\sum_{h=1}^{H}\delta^h>K_t(a).
$$

The key premise is the causal relation between compression and physical upkeep. It cannot be inferred from the units “bits” and “joules.” Benefits through better action or uptake may matter even when upkeep rises. Positive expected return also does not ensure survival until repayment: the reserve path must remain feasible, or its risk of exhaustion must be explicitly bounded.

**Additional hypotheses needed.** The learner estimates these returns sufficiently well; a choice mechanism favors positive returns; retention lasts long enough; testing identifies relevant regularities; and competing needs constrain exploration. To explain feeling, add a separate bridge—for example, reported interest depends partly on expected positive model improvement, moderated by perceived competence and costs. Neither the budget equation nor compression supplies that bridge automatically.

**Implication for EbE.** Step 5’s feedback-and-retention mechanism is compatible with progress-based exploration. Its $q^k$ to $kq$ comparison requires separable, usable feedback; interacting parts need not permit that saving. Its “turn” also requires wider feasible search, whereas a curiosity reward can be earned without increasing slack or opening new possibilities. Persistent curiosity additionally requires continuing learning opportunities. It is not guaranteed by finite capacity or compression alone.

## D. Three discriminating test designs

All three are **proposed tests**, not validated protocols. Preregister model comparisons, exclusion rules and manipulation checks. Set sample size through simulations using a smallest effect worth detecting; do not choose it after inspecting results.

### D1. People: novelty without progress, progress without novelty

**Design.** Adapt the free-choice learning-task paradigm. Participants sample several artificial worlds. One repeats a mastered rule. Another contains a learnable hidden rule. A third produces outcomes from a known random distribution. A fourth is structured but initially beyond the participant’s demonstrated learning ability. Refresh surface symbols independently of underlying rules, allowing perceptual novelty to change without new structure.

Use a pilot to match initial predictive difficulty where possible. After familiarization, let participants choose which world to sample and how much waiting time or a small token budget to spend. Occasionally elicit a full probability forecast, predicted improvement and felt curiosity. Use proper scoring to encourage honest forecasts, balanced across conditions. Withhold separate transfer items.

**Outcomes.** Compare predictive models of next choice: novelty, current surprise, information-gap size, Bayesian information gain, competence progress and cross-validated log-loss improvement. Evaluate on held-out participants and trials. Include their mixtures. Measure whether people predict their own improvement, rather than attributing later improvement retrospectively to prior curiosity.

**Discriminating prediction.** At matched novelty and current error, interest should follow expected improvement; after mastery it should fall, and should revive when a new learnable rule becomes available. A useful stronger manipulation provides a rule clue that enables many new predictions versus an equally informative isolated answer with little transfer.

**What counts against it.** With verified learning and reliable self-reports, choices consistently follow surface novelty or isolated answer acquisition while expected generalizable gain adds no out-of-sample predictive value. Failure to distinguish compression from Bayesian information gain counts against claims of a uniquely identified mechanism, not against both theories.

### D2. AI: known noise, learnable rules and honest resource accounting

**Design.** Build an environment with a mastered region, a learnable region, a stochastic TV and a structured region requiring prerequisites. Randomize their visual presentation and access cost. Compare raw next-state error, feature-based prediction error, RND, Bayesian information gain where tractable, and held-out log-loss or description-length progress. Use matched architectures and disclose both equal-interaction and equal-compute comparisons.

Evaluate old and updated predictors on identical held-out batches. Include a known-noise condition, a condition where the noise distribution is initially unknown, and forgetting/relearning traps. Record information acquired about the true generative rules, transfer to new tasks, time at the distractor, compute and measured hardware energy. Report uncertainty across seeds.

**Discriminating prediction.** A reliable progress estimator should leave calibrated noise while continuing to seek learnable structure. Any claimed EbE advantage should survive charging for the predictor, progress estimator, memory and additional training.

**What counts against it.** Progress rewards persist through overfitting or forgetting; superior exploration disappears at matched compute; or shorter codes systematically fail to improve measured resource returns. An engineered progress agent following its programmed reward verifies implementation, not the human hypothesis. Its behavior does not test consciousness.

### D3. People: approval and understanding varied independently

**Design.** Cross access to an explanation that improves transfer with social approval that is contingent on participation but carries no information about correctness. Keep factual feedback accurate, privately scored and separate. In a further phase, remove evaluative feedback while offering fresh learning opportunities. Measure information choice, transfer performance, felt curiosity, perceived control and the desire for approval.

**Prediction.** A world-directed component of curiosity should respond to transferable learning opportunities even when approval is held constant or removed. An approval-sensitive component should respond to the social contingency. A mixture is an expected possibility, not a failed design.

**What counts against the brief’s strong distinction.** Approval sustains later exploration, or exploration ceases when useful learning is exhausted despite continued praise. These results would favor interacting motivations over two drives with fixed stopping rules. This design cannot establish thermodynamic causation; that would require an additional, independently validated metabolic measure. BOLD activity alone should not be relabeled as energy saved.

## E. What could not be verified, and search limits

1. **D11 and D12 were unavailable in the retrieved default-branch file.** Their contents were not reconstructed from memory. The quoted brief was the source for the exchange.
2. **The complete biological identity was not verified.** No retrieved experiment established that felt curiosity is compression optimization, or that it directly tracks metabolic savings. This is an absence from this search, not proof that no relevant experiment exists.
3. **The online-learning condition for feeling was not verified.** The reviewed work does not supply a demonstrated necessity or sufficiency theorem, nor a discriminating consciousness experiment.
4. **Some versions were limited.** Kang’s publisher and author abstracts were accessible, but not its full article through those routes; claims here are limited accordingly. Ali’s full preprint was inspected and its 2022 publication checked, but the final article could not be reliably opened. Kondrakiewicz and Nawrocka’s full preprint and publication record were accessible; the final full text was not. The quantitative human metabolic study by Hechler and colleagues surfaced as a preprint/thesis lead; its final publication status and full analysis were not established, so its numerical results are not used.
5. **No general bit-to-energy conversion was verified.** Neither a language-model codelength improvement nor an answer judged insightful identifies the number of physical bits irreversibly erased.

**Search method.** Searches on 9 October 2026 used exact titles, author combinations and mechanism terms, including curiosity, compression progress, learning progress, explanation seeking, predictive coding, metabolism, thermodynamics of prediction, noisy TV, intrinsic motivation and sycophancy. Sources were followed to publishers, PLOS, author and university repositories, PubMed/PMC, arXiv, ICLR/PMLR/NeurIPS proceedings and an author-linked code archive. Public scans of Loewenstein and Landauer were inspected directly. Preprint publication status was checked where those manuscripts were used. Searches were targeted and followed references; there was no registered systematic-review protocol, exhaustive database export, formal risk-of-bias scoring or meta-analysis. The report can assess the cited claims and identify close prior art; it cannot certify novelty or settle the mechanisms of consciousness.

## References and access notes

**1. Loewenstein, G. (1994).** The psychology of curiosity: A review and reinterpretation. *Psychological Bulletin, 116*(1), 75–98. [DOI](https://doi.org/10.1037/0033-2909.116.1.75); [author’s scan](https://www.cmu.edu/dietrich/sds/docs/loewenstein/PsychofCuriosity.pdf). Original information-gap account. Quoted first page inspected directly.

**2. Schmidhuber, J. (2009).** Driven by Compression Progress: A Simple Principle Explains Essential Aspects of Subjective Beauty, Novelty, Surprise, Interestingness, Attention, Curiosity, Creativity, Art, Science, Music, Jokes. In G. Pezzulo, M. V. Butz, O. Sigaud, & G. Baldassarre (Eds.), *Anticipatory Behavior in Adaptive Learning Systems*, LNCS 5499, pp. 48–76. Springer. [DOI](https://doi.org/10.1007/978-3-642-02565-5_4); [author manuscript](https://people.idsia.ch/~juergen/driven2009.pdf). Direct precursor, including its subjective-interest interpretation; not a human validation study.

**3. Schmidhuber, J. (2010).** Formal Theory of Creativity, Fun, and Intrinsic Motivation (1990–2010). *IEEE Transactions on Autonomous Mental Development, 2*(3), 230–247. [Author manuscript](https://people.idsia.ch/~juergen/ieeecreative.pdf); [author publication record](https://people.idsia.ch/~juergen/onlinepub.html). Formal progress reward and controller architecture; quoted manuscript inspected.

**4. Friston, K. (2010).** The free-energy principle: A unified brain theory? *Nature Reviews Neuroscience, 11*, 127–138. [DOI](https://doi.org/10.1038/nrn2787); [author-hosted article](https://www.fil.ion.ucl.ac.uk/~karl/The%20free-energy%20principle%20A%20unified%20brain%20theory.pdf). Original theoretical synthesis; explicitly distinguishes variational from thermodynamic free energy.

**5. Friston, K., Rigoli, F., Ognibene, D., Mathys, C., Fitzgerald, T., & Pezzulo, G. (2015).** Active inference and epistemic value. *Cognitive Neuroscience, 6*(4), 187–214. [DOI](https://doi.org/10.1080/17588928.2015.1020053); [author-hosted PDF](https://www.fil.ion.ucl.ac.uk/~karl/Active%20inference%20and%20epistemic%20value.pdf). Formal account of information-seeking policies. The PDF also contains commentaries, which extend beyond the article’s page range.

**6. Delétang, G., Ruoss, A., Duquenne, P.-A., Catt, E., Genewein, T., Mattern, C., Grau-Moya, J., Wenliang, L. K., Aitchison, M., Orseau, L., Hutter, M., & Veness, J. (2024).** Language Modeling Is Compression. *International Conference on Learning Representations*. [Proceedings and paper](https://proceedings.iclr.cc/paper_files/paper/2024/hash/3cbf627fa24fb6cb576e04e689b9428b-Abstract-Conference.html). Published version of the 2023 work; full paper inspected for arithmetic-coding qualifications.

**7. Shannon, C. E. (1948).** A Mathematical Theory of Communication. *Bell System Technical Journal, 27*, 379–423, 623–656. [Corrected reprint](https://people.math.harvard.edu/~ctm/home/text/others/shannon/entropy/entropy.pdf). Foundational source-coding theory; does not identify semantic understanding with compression.

**8. Raichle, M. E., & Gusnard, D. A. (2002).** Appraising the brain’s energy budget. *Proceedings of the National Academy of Sciences, 99*(16), 10237–10239. [DOI](https://doi.org/10.1073/pnas.172399499); [full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC124895/). Source of the inspected mass/energy statement. Commentary, not the original population measurement.

**9. Landauer, R. (1961).** Irreversibility and Heat Generation in the Computing Process. *IBM Journal of Research and Development, 5*(3), 183–191. [DOI](https://doi.org/10.1147/rd.53.0183); [IBM reprint scan](https://www.cpt.univ-mrs.fr/~verga/pdfs/Landauer-1961uq.pdf). Original erasure argument; inspected copy is the 2000 reprint, with different pagination.

**10. Bérut, A., Arakelyan, A., Petrosyan, A., Ciliberto, S., Dillenschneider, R., & Lutz, E. (2012).** Experimental verification of Landauer’s principle linking information and thermodynamics. *Nature, 483*, 187–189. [DOI](https://doi.org/10.1038/nature10872). Full published paper inspected in a public mirror; physical one-bit experiment, not a brain or AI-learning experiment.

**11. Kidd, C., & Hayden, B. Y. (2015).** The Psychology and Neuroscience of Curiosity. *Neuron, 88*(3), 449–460. [DOI](https://doi.org/10.1016/j.neuron.2015.09.010); [author-hosted PDF](https://www.kiddlab.com/_files/ugd/0975fd_090ef66c1f824ba0a685aaffeff9bb59.pdf). Requested review, inspected in full; used for conceptual mapping and measurement cautions.

**12. Oudeyer, P.-Y., & Kaplan, F. (2007).** What is intrinsic motivation? A typology of computational approaches. *Frontiers in Neurorobotics, 1*, 6. [Full text and DOI](https://doi.org/10.3389/neuro.12.006.2007). Original formal taxonomy separating prediction, information, progress and competence signals.

**13. Ten, A., Kaushik, P., Oudeyer, P.-Y., & Gottlieb, J. (2021).** Humans monitor learning progress in curiosity-driven exploration. *Nature Communications, 12*, 5972. [DOI](https://doi.org/10.1038/s41467-021-26196-w); [article](https://pmc.ncbi.nlm.nih.gov/articles/PMC8514490/); [author code archive](https://zenodo.org/records/5179939). Primary human learning-progress study; strongest starting point here for the proposed free-choice experiment.

**14. Liquin, E. G., & Lombrozo, T. (2020).** A functional approach to explanation-seeking curiosity. *Cognitive Psychology, 119*, 101276. [DOI](https://doi.org/10.1016/j.cogpsych.2020.101276); [author-hosted full paper](https://cognition.princeton.edu/document/339). Primary studies distinguish explanations from facts and examine anticipated learning and usefulness.

**15. Kidd, C., Piantadosi, S. T., & Aslin, R. N. (2012).** The Goldilocks Effect: Human Infants Allocate Attention to Visual Sequences That Are Neither Too Simple Nor Too Complex. *PLOS ONE, 7*(5), e36399. [Full text and DOI](https://doi.org/10.1371/journal.pone.0036399). Primary infant attention experiment; does not directly measure curiosity reports or compression gain.

**16. Kang, M. J., Hsu, M., Krajbich, I. M., Loewenstein, G., McClure, S. M., Wang, J. T.-Y., & Camerer, C. F. (2009).** The Wick in the Candle of Learning: Epistemic Curiosity Activates Reward Circuitry and Enhances Memory. *Psychological Science, 20*(8), 963–973. [DOI](https://doi.org/10.1111/j.1467-9280.2009.02402.x); [author abstract](https://neuroecon.berkeley.edu/papers/papers_files/Kang_PsychSci_2009.html). Primary research; publisher and author abstracts inspected, so detailed analyses are not independently audited here.

**17. Gruber, M. J., Gelman, B. D., & Ranganath, C. (2014).** States of Curiosity Modulate Hippocampus-Dependent Learning via the Dopaminergic Circuit. *Neuron, 84*(2), 486–496. [DOI](https://doi.org/10.1016/j.neuron.2014.08.060); [accepted manuscript](https://escholarship.org/content/qt2zd605r7/qt2zd605r7.pdf). Primary memory and fMRI experiment, inspected in full. Neural associations do not directly establish dopamine causation.

**18. Patankar, S. P., Zhou, D., Lynn, C. W., Kim, J. Z., Ouellet, M., Ju, H., Zurn, P., Lydon-Staley, D. M., & Bassett, D. S. (2023).** Curiosity as filling, compressing, and reconfiguring knowledge networks. *Collective Intelligence, 2*(4). [Full text and DOI](https://doi.org/10.1177/26339137231207633). Published follow-up to the 2022 preprint. Quantitative compression-related evidence using network proxies, with a pluralistic conclusion.

**19. Ali, A., Ahmad, N., de Groot, E., van Gerven, M. A. J., & Kietzmann, T. C. (2022).** Predictive coding is a consequence of energy efficiency in recurrent neural networks. *Patterns, 3*(12), 100639. [DOI](https://doi.org/10.1016/j.patter.2022.100639); [preprint DOI](https://doi.org/10.1101/2021.02.16.430904). Full 2021 preprint inspected; published record confirmed. Computational efficiency model, not measured human metabolism.

**20. Still, S., Sivak, D. A., Bell, A. J., & Crooks, G. E. (2012).** Thermodynamics of Prediction. *Physical Review Letters, 109*, 120604. [DOI](https://doi.org/10.1103/PhysRevLett.109.120604); [full manuscript](https://arxiv.org/pdf/1203.3271). Literal thermodynamic result under stated assumptions; no claim demonstrated about felt curiosity.

**21. Kondrakiewicz, K., & Nawrocka, J. (2025).** Brains are expensive, but cognition is often cheap. *Neuroscience & Biobehavioral Reviews, 179*, 106450. [DOI](https://doi.org/10.1016/j.neubiorev.2025.106450); [inspected preprint](https://www.preprints.org/manuscript/202510.2202). Original efficiency interpretation in a review; final publication confirmed, final full text not inspected.

**22. Pathak, D., Agrawal, P., Efros, A. A., & Darrell, T. (2017).** Curiosity-driven Exploration by Self-supervised Prediction. *Proceedings of ICML*, PMLR 70, 2778–2787. [Primary proceedings record](https://proceedings.mlr.press/v70/pathak17a.html). Feature-based prediction-error curiosity; distinct from raw visual novelty.

**23. Burda, Y., Edwards, H., Storkey, A., & Klimov, O. (2018).** Exploration by Random Network Distillation. [arXiv:1810.12894](https://arxiv.org/abs/1810.12894). Full author manuscript inspected, especially §2.2. The accessible version is cited by its 2018 preprint date; the conference endpoint encountered an access check. Fixed random targets clarify one source of the noisy-TV problem.

**24. Gaven, L., Carta, T., Romac, C., Colas, C., Lamprier, S., Sigaud, O., & Oudeyer, P.-Y. (2025).** MAGELLAN: Metacognitive predictions of learning progress guide autotelic LLM agents in large goal spaces. *Proceedings of ICML*, PMLR 267, 18920–18953. [Primary proceedings record](https://proceedings.mlr.press/v267/gaven25a.html). Concrete online-learning LLM architecture; no evidence of subjective experience is claimed here.

**25. Silvia, P. J. (2005).** What Is Interesting? Exploring the Appraisal Structure of Interest. *Emotion, 5*(1), 89–102. [DOI](https://doi.org/10.1037/1528-3542.5.1.89); [institutional record](https://libres.uncg.edu/ir/listing.aspx?id=2929). Full paper text inspected through its ResearchGate record after the institutional PDF timed out. Primary appraisal experiments, not a compression measurement.

**26. Joffily, M., & Coricelli, G. (2013).** Emotional Valence and the Free-Energy Principle. *PLOS Computational Biology, 9*(6), e1003094. [Full text and DOI](https://doi.org/10.1371/journal.pcbi.1003094). Original computational affect hypothesis; simulated valence does not establish feeling.

**27. Ryan, R. M., & Deci, E. L. (2000).** Self-Determination Theory and the Facilitation of Intrinsic Motivation, Social Development, and Well-Being. *American Psychologist, 55*(1), 68–78. [DOI](https://doi.org/10.1037/0003-066X.55.1.68); [authors’ PDF](https://selfdeterminationtheory.org/SDT/documents/2000_RyanDeci_SDT.pdf). Original theory exposition, inspected in full; does not support a simple social-versus-world binary.

**28. Sharma, M., Tong, M., Korbak, T., Duvenaud, D., Askell, A., Bowman, S., Durmus, E., Hatfield-Dodds, Z., Johnston, S., Kravec, S., Maxwell, T., McCandlish, S., Ndousse, K., Rausch, O., Schiefer, N., Yan, D., Zhang, M., & Perez, E. (2024).** Towards Understanding Sycophancy in Language Models. *International Conference on Learning Representations*. [Primary proceedings record](https://proceedings.iclr.cc/paper_files/paper/2024/hash/0105f7972202c1d4fb817da9f21a9663-Abstract-Conference.html). Published source for agreement-versus-truth reward conflicts; functional behavior, not evidence of an approval feeling.

**29. Brown, T. B., et al. (2020).** Language Models are Few-Shot Learners. *Advances in Neural Information Processing Systems, 33*, 1877–1901. [Primary proceedings record](https://proceedings.neurips.cc/paper/2020/hash/1457c0d6bfcb4967418bfb8ac142f64a-Abstract.html). Demonstrates task adaptation through context without gradient updates; does not settle whether that counts as enduring learning or experience.
