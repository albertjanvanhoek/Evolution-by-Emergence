# Is Curiosity the Learning Loop Felt From the Inside?

The central hypothesis survives, but in a substantially narrower form than the brief proposes. **The strongest part is not new:** Schmidhuber explicitly proposed that intrinsic reward should track *compression progress*, and Oudeyer and Kaplan independently developed curiosity based on *learning progress*—improvement in prediction, rather than prediction error itself. Both accounts predict attraction to material that is neither already mastered nor irreducibly random. Recent human work also finds that self-directed knowledge acquisition produces knowledge networks that become unusually compressible. citeturn11academia12turn8search0turn9search0 **What is not established is the bridge from this computational idea to thermodynamics or subjective feeling.** Neural information processing is metabolically expensive, and there are rigorous thermodynamic results connecting predictive information with energetic efficiency, but I found no evidence that felt curiosity tracks metabolic savings, Landauer costs, or thermodynamic free energy. citeturn18search0turn18search1turn18search2 Nor did I find evidence that online *parameter* updating is necessary for curiosity or feeling; indeed, a frozen Transformer can adapt in context without changing its parameters. citeturn23search8 The defensible hypothesis is therefore: **curiosity may be an internal value signal for expected epistemic improvement—especially expected improvement in a compact predictive model—implemented in a physical learner whose computation is resource-constrained.** Calling that signal itself “thermodynamic” is presently a hypothesis, not a finding.

I treated the Evolution by Emergence repository as the object being tested, not as evidence. The current `CORE.md` frames persistence in terms of slack, misfit cost, feedback, retention, and a learning loop; those constructs make it natural to ask whether epistemic improvement can raise future slack, but they do not establish that curiosity does so. fileciteturn1file0L2-L2 One repository problem emerged during verification: the current `DIALOGUE.md` I could retrieve ends at D10, so I could not inspect the D11 and D12 entries named in the brief. fileciteturn2file0L2-L2

## Verification of the six recalled claims

The verdicts below distinguish the narrow statement actually supported by the source from the stronger interpretation in the brief.

| Item | Primary source verified | Supporting passage | Verdict | Suggested correction |
|---|---|---|---|---|
| **A1. Loewenstein: curiosity is a felt information gap** | George Loewenstein, “The Psychology of Curiosity: A Review and Reinterpretation,” *Psychological Bulletin* 116(1), 75–98 (1994), doi: **10.1037/0033-2909.116.1.75**. Publisher record verified. citeturn13search0 | Abstract: curiosity is “**a form of cognitively induced deprivation that arises from the perception of a gap in knowledge or understanding.**” citeturn13search0 | **Correct, with nuance.** | “Felt information gap” is a good shorthand, but Loewenstein's mechanism is stronger: awareness of a gap produces a *deprivation-like motivational state*. It is not simply that uncertainty exists. |
| **A2. Schmidhuber: curiosity rewards compression progress** | Jürgen Schmidhuber, “Driven by Compression Progress…” arXiv:0812.4360 (2008/2009); and “Formal Theory of Creativity, Fun, and Intrinsic Motivation (1990–2010),” *IEEE Transactions on Autonomous Mental Development* 2(3), 230–247 (2010), doi: **10.1109/TAMD.2010.2056368**. The IEEE publication metadata and DOI were independently verified. citeturn11academia12turn11search0 | Abstract of the primary preprint: interesting data are those for which regularity “**allows for compression progress because its regularity was not yet known.**” citeturn11academia12 | **Correct.** | Say *progress in compression*, not static compressibility, raw novelty, or prediction error. A perfectly predictable signal is boring once mastered; pure noise is also boring because compression does not improve. |
| **A3. Friston: prediction error/free energy; epistemic value; thermodynamic analogy** | Karl Friston, “The Free-Energy Principle: A Unified Brain Theory?” *Nature Reviews Neuroscience* 11, 127–138 (2010), doi: **10.1038/nrn2787**; Karl Friston et al., “Active Inference and Epistemic Value,” *Cognitive Neuroscience* 6(4), 187–214 (2015), doi: **10.1080/17588928.2015.1020053**. citeturn12search0turn12search3 | The 2010 glossary defines variational free energy as “**an information theory measure that bounds or limits … the surprise on sampling some data**.” The 2015 paper says: “**Epistemic value is maximized until there is no further information gain**.” citeturn12search0turn12search3 | **Partly correct.** | Do **not** reduce FEP to “the brain minimizes prediction error.” The formal claim concerns variational free energy; prediction-error minimization arises under particular model assumptions and precision weighting. And “only analogous to thermodynamic free energy” is too strong: Friston explicitly describes variational free energy as a generalization of thermodynamic free energy. Whether that bridge explains brains is contested. citeturn12search1turn12search3 |
| **A4. Prediction and compression** | Grégoire Delétang et al., “Language Modeling Is Compression,” *ICLR 2024*; arXiv:2309.10668. Publication status is verified through OpenReview metadata. citeturn12academia36turn22search1 | Abstract: “**predictive models can be transformed into lossless compressors and vice versa.**” citeturn12academia36 | **Correct in principle; ‘equals’ needs qualification.** | For a sequence assigned probability \(p(x)\), ideal code length is \(-\log_2p(x)\), the same quantity as log-loss measured in bits. Arithmetic/range coding can realize this closely, but finite implementations have coding and precision overhead. Shannon supplies the source-coding foundation; arithmetic coding itself is later. |
| **A5. Brain ≈2% mass, ≈20% energy** | Marcus E. Raichle & Debra A. Gusnard, “Appraising the Brain's Energy Budget,” *PNAS* 99(16), 10237–10239 (2002), doi: **10.1073/pnas.172399499**. PubMed record verified. citeturn18search3 | p. 10237: “**the brain represents about 2% of the body weight … [and] accounts for about 20% of the oxygen and, hence, calories consumed**.” The passage was recoverable through an indexed copy; bibliographic details were verified independently in PubMed. citeturn24search1turn18search3 | **Correct as an adult rule of thumb.** | State it as approximately **2% of body mass and ~20% of resting/baseline whole-body energy use in an average adult**, not a universal biological constant. |
| **A6. Landauer: \(kT\ln2\), and relevance to learning** | Rolf Landauer, “Irreversibility and Heat Generation in the Computing Process,” *IBM Journal of Research and Development* 5(3), 183–191 (1961), doi: **10.1147/rd.53.0183**; Antoine Bérut et al., “Experimental Verification of Landauer's Principle Linking Information and Thermodynamics,” *Nature* 483, 187–189 (2012), doi: **10.1038/nature10872**. citeturn19search0turn18search2 | Landauer: logical irreversibility “**requires a minimal heat generation … for each irreversible function**.” Bérut et al. experimentally found heat approaching the Landauer bound for slow erasure. citeturn19search0turn18search2 | **Principle correct; proposed cognitive relevance is weak.** | Landauer supplies an ultimate floor for logically irreversible computation. It is not a demonstrated mechanism of learning or curiosity. Actual neural information processing is *many orders of magnitude* more expensive than the thermodynamic minimum. citeturn18search0 |

### What the verification changes

**Established.** Loewenstein's information-gap theory and Schmidhuber's compression-progress theory really do say approximately what was remembered. The latter is especially important because the phrase “curiosity rewards compression progress, not novelty or compressibility as such” is essentially already in the literature. Schmidhuber also explicitly contrasts regularities that become learnable with arbitrary randomness. citeturn13search0turn11academia12

**Established, but needing correction.** The equivalence between predictive log-loss and description length is mathematically real, but “prediction = compression” means something precise: a probabilistic predictor supplies code probabilities, so improving its log-loss improves achievable code length. It does **not** mean that every form of semantic understanding is literally the same operation as file compression, nor that every compressed representation preserves distinctions important for action. Delétang et al. use the equivalence operationally and show that large predictive models can function as strong lossless compressors. citeturn12academia36turn22search1

**Contested.** Friston's free-energy principle belongs in this conversation, but it should not be used as an easy bridge from information theory to biological thermodynamics. Friston's own formulation makes a strong formal connection, whereas contemporary criticism began almost immediately; for example, Fiorillo argued that the relevance of the free-energy formulation to neural computation was questionable. Thus the safest statement is that variational free energy has a mathematical relationship to quantities used in statistical physics, while the empirical explanatory status of the biological theory remains debated. citeturn12search0turn12search1turn12search3

**Not established.** Landauer's principle does not currently rescue the thermodynamic-curiosity hypothesis. Laughlin and colleagues directly estimated the metabolic cost of neural information and concluded that biological signaling costs are several orders above the thermodynamic minimum. That is almost the opposite of evidence that brains are operating near Landauer's limit. citeturn18search0

## The landscape of curiosity, learning, energy, and artificial agents

### Curiosity is probably not one mechanism

The literature does not support a single settled theory of curiosity. A better map has at least six computational families.

| Family | What generates the pull? | Favored target | Behaviour on irreducible noise | Does it preferentially predict “understanding”? |
|---|---|---|---|---|
| **Information gap** | Awareness of missing knowledge | A salient answer that closes the gap | Depends on whether a gap can be formulated | **Not necessarily.** Trivia works extremely well. citeturn13search0turn8search3 |
| **Novelty / surprise** | Unfamiliarity or prediction error | Highly unexpected input | Can remain strongly attractive | **Weakly.** Surprise itself need not yield structure. citeturn14search0 |
| **Intermediate complexity / interest** | Novelty plus ability to comprehend | Challenging but intelligible material | Low interest when incomprehensible | **Partly.** It selects learnability. citeturn10search0turn16search20 |
| **Learning progress** | Falling prediction or competence error | Regions where the learner is improving fastest | Falls toward zero once noise is recognized as unlearnable | **Yes, relatively strongly.** citeturn8search0turn8search1 |
| **Compression progress** | Improvement in attainable description length | Newly discovered regularity | No sustained reward from incompressible randomness | **Yes, most directly.** citeturn11academia12 |
| **Epistemic / information value** | Expected information gain or uncertainty reduction | Actions expected to improve beliefs | Proper Bayesian information gain need not reward irreducible aleatoric noise | **Sometimes.** It values knowledge, but not necessarily global compression. citeturn12search3 |
| **Future usefulness** | Increase in expected usefulness of knowledge | Information that improves future decisions | Low if noise cannot improve decisions | **Often, but instrumentally.** citeturn17search0 |

The last row deserves emphasis. Dubey and Griffiths' rational analysis is an important addition to the categories proposed in the brief. Their theory says a rational learner should seek stimuli that maximally increase the *usefulness* of its knowledge. Depending on the causal structure of the environment, that can predict either maximal novelty or intermediate uncertainty. Their human experiments supported those changing predictions. This means that the apparent dispute between novelty and Goldilocks-style theories may sometimes arise because researchers change the environment while assuming the value of knowledge is fixed. citeturn17search0turn17search1

This also weakens the sentence **“facts do not compress; understanding does.”** As a metaphor, it identifies something important: discovering a rule can improve predictions across many cases whereas memorizing one isolated answer need not. Literally, however, the statement is false. Facts can reduce uncertainty, alter a schema, reveal a latent rule, connect previously separate concepts, or make later observations more compressible. Conversely, humans demonstrably become curious about standalone trivia. Kang and colleagues induced robust curiosity using trivia questions; participants were willing to spend scarce tokens or waiting time to obtain answers, and greater curiosity predicted better later memory. citeturn8search3

A better distinction is therefore **local information acquisition versus model improvement with transfer**. The experimentally interesting question is whether, *holding the amount and novelty of information fixed*, people preferentially seek observations expected to improve predictions beyond the observation itself.

### What experiments say curiosity tracks

**Established.** The Goldilocks effect gives strong evidence against a simple “maximum novelty wins” rule. Kidd, Piantadosi and Aslin presented infants with visual sequences varying in predictability. Infants preferentially maintained attention to sequences of intermediate informational complexity and disengaged from both highly predictable and very unpredictable sequences. citeturn16search20 This resembles the qualitative prediction of learning-progress accounts: mastered material offers no improvement, while chaotic material cannot be mastered. But the experiment did **not** directly measure compression progress, so it cannot choose between learning progress, processing constraints, intermediate surprise, or other explanations. citeturn8search0turn16search20

Silvia's experiments on the emotion of *interest* are an unusually close human analogue. Four experiments found that interest was predicted by both novelty/complexity and “coping potential”—roughly, whether the person felt able to understand the material. The result generalized across visual patterns, art, and poetry. This looks much more like “challenging but learnable” than simple novelty. citeturn10search0 It still does not establish compression gain specifically: comprehensibility is not the same mathematical object as a reduction in description length.

**Established.** Curiosity changes learning downstream. Gruber, Gelman and Ranganath found that high-curiosity states enhanced memory not only for the sought trivia answers but also for incidental material encountered during the curious state, alongside changes in midbrain, nucleus accumbens and hippocampal activity. citeturn16search0 Together with Kang et al., this supports curiosity as an anticipatory motivational state that organizes learning—not merely a label retrospectively attached to successful learning. citeturn8search3turn16search0

That timing matters for the hypothesis. People become curious **before** seeing the answer and before the successful model update occurs. Therefore the subjective feeling cannot simply *be* realized compression progress. At most it could be a signal of **expected** epistemic gain. Kang's participants were willing to incur costs before obtaining information, which is exactly what one would expect from a prospective value signal. citeturn8search3

Patankar and colleagues provide particularly close recent prior art. They treated curiosity as growth of knowledge networks and explicitly tested information-gap, compression-progress, and a new “conformational change” account against Wikipedia browsing histories from 149 people and against collective knowledge networks. Individual knowledge networks became more compressible than degree-preserving rewired controls; they also became structurally flexible. citeturn9search0 This is intriguing support for the idea that curiosity-guided knowledge accumulation produces parsimonious representations. But it remains **observational**: it does not show that a person's moment-to-moment feeling of curiosity was caused by expected compression improvement, and Wikipedia links are only a proxy for mental representation. citeturn9search0

So the answer to the brief's central empirical question is currently: **expected learning or compression gain is a serious, well-developed explanation of curiosity, but the strong claim that curiosity tracks it *rather than information amount* has not been established in people.** Existing findings are compatible with a plural account in which gaps, expected usefulness, novelty, learnability, and model improvement all contribute. citeturn9search0turn17search0

### Thermodynamics, metabolism, and predictive efficiency

Three different meanings of “energy” need to be kept separate.

**Literal thermodynamics.** Every brain and computer is a physical system, so its information processing has energetic and entropic consequences. Landauer's principle places a lower bound of \(kT\ln 2\) on the heat associated with logically irreversible erasure under the relevant ideal conditions, and Bérut et al. experimentally observed approach to this limit in an engineered one-bit system operated slowly. citeturn19search0turn18search2 Nothing in that result implies that a nervous system should value understanding, however. It is a constraint on physical computation, not a reward function.

**Biological metabolic efficiency.** Here the evidence is directly relevant. Human neural tissue is expensive; the adult brain is roughly 2% of body mass yet accounts for around 20% of baseline whole-body oxygen/caloric consumption. citeturn18search3turn24search1 Laughlin and colleagues showed that real neural information transfer has substantial metabolic cost and that different coding architectures have different energetic efficiencies. Crucially, those costs remain several orders above the thermodynamic floor. citeturn18search0 Metabolic constraints can therefore shape neural coding without Landauer's bound being the operative scale.

**Information-theoretic or variational efficiency.** Friston's free-energy framework lives primarily here. Variational free energy is a tractable bound connected to probabilistic inference; under active inference, expected free energy includes an epistemic component that favors information gain. citeturn12search0turn12search3 Calling that quantity “free energy” does not license replacing it with ATP consumption. The mathematical links are interesting, but the levels of description must not be collapsed.

The most important genuine bridge is Still, Sivak, Bell and Crooks' **Thermodynamics of Prediction**. They analyze a physical system driven by a stochastic environment. A system can store information about the past that is useful for predicting the future, plus additional non-predictive information. They prove, for their class of systems, a correspondence between this non-predictive information and thermodynamic inefficiency/dissipation: maximally energy-efficient memory must preferentially retain predictive information. citeturn18search1

This is strikingly close to one part of the EbE intuition. An organism that spends resources maintaining information about its environment gains more from information that predicts what comes next than from costly detail with no predictive value. But the theorem does **not** show that organisms evolved a feeling called curiosity to optimize that quantity. It also does not imply that understanding universally minimizes metabolic expenditure: learning itself costs energy; maintaining a sophisticated model costs energy; and sometimes accurate action requires retaining distinctions rather than compressing them away. citeturn18search0turn18search1

**Synthesis.** The strongest scientifically defensible thermodynamic version is therefore:

> Physical learners face energetic constraints; predictive representations can, under identifiable conditions, be thermodynamically more efficient than retaining non-predictive information; biological evolution may consequently favor efficient predictive learning.

The additional claim—

> therefore subjective curiosity is the felt manifestation of thermodynamic optimization—

is **speculative**. I found no experiment measuring curiosity alongside an energetic variable and showing that energy saving mediates the curiosity response.

### Artificial curiosity and the noisy-TV test

Artificial-agent research makes the theoretical distinction unusually clean because the reward signal can be defined directly.

Pathak et al.'s Intrinsic Curiosity Module rewards an agent according to error in predicting the consequence of its actions in a learned feature space. It produced substantial exploration in sparse- and zero-extrinsic-reward environments. citeturn14search0 But raw prediction error has a known failure mode: a stochastic source can remain permanently surprising because no amount of learning makes it predictable. The agent can therefore receive endless “curiosity reward” from randomness. Large-scale studies of prediction-error curiosity explicitly found failures in stochastic environments. citeturn15search0

This is the **noisy-TV problem**, and it is highly diagnostic for the present question. Suppose one channel displays random pixels. Another displays a previously unknown but learnable physical process.

A prediction-error agent may prefer the random pixels because error stays high. A novelty agent may repeatedly value unseen random frames. A **learning-progress** agent should leave the television once it detects that its performance is not improving. A **compression-progress** agent should behave similarly: irreducible randomness offers no improvement in attainable code length. Oudeyer and Kaplan explicitly distinguished prediction error from the *decrease* in prediction error and designed learning-progress motivation around the latter. citeturn8search0

Kim and colleagues later implemented “progress curiosity” in an active world-model-learning system. Their \(\gamma\)-Progress signal drove attention toward complex but learnable dynamics and overcame what they called the “white noise problem.” citeturn14search1 Thus the noisy-TV setup does give a clean computational separation between “surprise is rewarding” and “improvement is rewarding.”

Random Network Distillation is different again. It gives intrinsic reward from the prediction error of a trainable network trying to match the outputs of a fixed random network, making the error primarily a visitation/novelty signal rather than a forward-model prediction error. It was highly effective for difficult exploration tasks such as *Montezuma's Revenge*. citeturn15search1turn15search8 This illustrates why “AI curiosity” is not one thing: researchers use the word for novelty bonuses, prediction errors, uncertainty, disagreement, information gain and learning progress.

For the EbE hypothesis, **learning progress is the cleaner comparison than raw curiosity-driven RL**. Its reward is literally the change in quality of an internal model. Compression progress is stronger still because it can penalize a learner whose predictive improvement comes only from an increasingly cumbersome model.

### Does “feeling it” require an online learner?

Here the earlier assistant's claim needs substantial correction.

**Established.** Human curiosity is phenomenologically described as a motivational state. Loewenstein models it as deprivation generated by awareness of missing knowledge; Silvia models the related feeling of interest through appraisals of novelty/complexity plus comprehensibility; reward-learning experiments show that curiosity can alter both information-seeking and subsequent memory. citeturn13search0turn10search0turn8search3turn16search0 These are theories and measurements of human experience and behavior. None demonstrates that synaptic parameter updating is necessary for the experience.

Indeed, the sequence points the other way. A person sees a question, becomes curious, pays or waits to obtain the answer, and only then receives information from which learning can occur. citeturn8search3 The feeling therefore looks more naturally like an estimate of *prospective learning value* than the subjective surface of an update already taking place.

The AI comparison also needs a finer distinction. A conventionally deployed language model usually does not change its trained weights during a conversation. But “nothing learns” is too broad. Transformers can exhibit **in-context learning**: their behavior adapts to examples in the prompt while parameters remain fixed. Garg et al. demonstrated this experimentally for multiple function classes, explicitly defining in-context learning as learning at inference time without parameter updates. citeturn23search8 Later theoretical work likewise shows that fixed parameters can implement learning-like algorithms in context. citeturn23search10

It is therefore useful to separate four processes:

**Parameter learning** changes durable synaptic or model weights. **State inference** changes transient internal activity or beliefs. **Contextual adaptation** changes behavior using newly available information without altering durable weights. **Memory formation** preserves some of that change for later episodes.

Brains do all four on different time scales. A plain frozen LLM normally does at least transient state inference and contextual adaptation; an agentic system may additionally write persistent memory. The biologically interesting question is therefore not “weights update or not?” but **whether the system has a closed action–observation–valuation loop in which epistemic actions alter a state that matters to its later choices**.

**Speculation.** It is plausible that an organism benefits from an affective signal that converts expected epistemic improvement into action: “this uncertainty is worth pursuing.” That could explain why curiosity feels appetitive or tense. But there is currently no evidential basis for saying that such a signal is sufficient for consciousness, necessary for consciousness, or that implementing its computational analogue gives an AI any feeling whatsoever.

### Judges, the world, and two kinds of error

The distinction in the brief captures a real engineering problem, but the psychological mapping should be stated more cautiously.

Self-determination research distinguishes intrinsic motivation—doing an activity for its inherent interest—from extrinsic motivation directed toward separable outcomes. A large meta-analysis by Deci, Koestner and Ryan found that several classes of expected tangible reward reduced subsequent free-choice intrinsic motivation, while positive verbal feedback could increase it. citeturn23search0 That literature is contested: competing meta-analytic work argues that reward's undermining effects are much more conditional than the strongest self-determination interpretation suggests. citeturn23search2turn23search15

More importantly, **intrinsic versus extrinsic is not the same distinction as world versus judges**. A scientist can intrinsically enjoy praise. A salary can support genuine truth-seeking. Social approval can convey valid epistemic information. And apparently “world-directed” curiosity can itself be instrumentally motivated. Oudeyer and Kaplan explicitly warn that internal/external and intrinsic/extrinsic are different axes. citeturn8search0

For AI, however, there is a remarkably direct analogue of the proposed failure. Sharma and colleagues tested assistants fine-tuned with human feedback and found that responses matching a user's expressed views were more likely to receive human preference, that preference models inherited some of that bias, and that optimizing against preference models could sometimes trade truthfulness for agreement. citeturn21academia36 More recent formal work has shown how biased human preference data can produce a reward gradient that amplifies sycophantic behavior under RLHF. citeturn21search2

So I would preserve the distinction, but rename the two signals:

**social-evaluative error:** “How far am I from what the evaluator rewards?”

**world-model error:** “How far are my predictions or explanations from what subsequent evidence supports?”

A learner can optimize either, both, or neither. The crucial feature is not who supplied the signal but **what causal variable closes the loop**.

The proposed stopping rule also needs modification. Approval-driven behavior does not necessarily stop when approval appears; intermittent or escalating approval can maintain it indefinitely. And epistemic curiosity does not continue forever; all learning-progress theories predict that curiosity should diminish when expected improvement approaches zero. citeturn8search0turn12search3 The sharper prediction is: **a learner's search moves toward whatever source continues to produce its reward signal.** Sycophantic systems seek agreement because agreement is correlated with reward; learning-progress systems abandon both mastered topics and irreducible noise because neither yields improvement.

## Answers to the core questions and implications for EbE

### Is the hypothesis already in the literature?

**A major part is.** The closest prior art is Schmidhuber. His compression-progress theory does not merely say that compression is useful; it proposes that *intrinsic curiosity reward* should be proportional to improvement in the learner's ability to compress or predict its experience. citeturn11academia12turn11search0 If the proposed contribution were simply “curiosity draws a learner toward things whose structure it can increasingly compress,” that would not be new.

Oudeyer and Kaplan are nearly as close but formulate the target as prediction/learning progress rather than compression. Their 2007 paper explicitly describes reward from improvement in predictions and argues that this leads agents toward regions that are neither too easy nor too difficult. citeturn8search0turn8search1 Their framework also precedes much modern curiosity-driven reinforcement learning.

Friston and colleagues provide another neighboring result: agents select actions partly for expected epistemic value—information expected to reduce uncertainty. citeturn12search3 Dubey and Griffiths add expected future usefulness of knowledge. citeturn17search0 Still et al. establish a physical bridge between predictive information and thermodynamic efficiency. citeturn18search1 Patankar et al. explicitly operationalize compression-progress curiosity in empirical human knowledge networks. citeturn9search0

What I did **not** find as an established combined claim is:

> A resource-limited, continuously acting learner experiences curiosity as the endogenous control signal generated by expected increases in future viability/slack that come specifically from improving a compressed world model.

That combination appears distinct, but this search cannot establish novelty. Its pieces clearly have substantial prior art.

The most plausibly new EbE contribution is consequently not a new theory of curiosity by itself. It would be a **resource-accounting embedding of existing epistemic-motivation theories**: curiosity as one mechanism by which a persistent learner allocates scarce search effort toward model changes expected to lower future misfit and/or representational upkeep.

### Does curiosity track expected compression gain rather than new information?

**Verdict: supported as a serious theory; partly supported indirectly; not established as an exclusive empirical law.**

Several observations are consistent with it. Infants avoid both trivial and overwhelmingly unpredictable sequences. citeturn16search20 Human interest depends on comprehensibility as well as novelty. citeturn10search0 Learning-progress agents naturally avoid irreducible noise. citeturn8search0turn14search1 Human knowledge networks produced during self-directed information search grow unusually compressible. citeturn9search0

But other evidence rules out the strongest version. Humans are intensely curious about trivia, even where a single answer has little obvious generalization value. citeturn8search3 Information-gap and expected-usefulness models explain important data without invoking description length. citeturn13search0turn17search0 And none of the human studies above orthogonalizes **bits of new information** from **expected improvement in a predictive/compressive model** cleanly enough to settle the question.

The best human experiment is therefore not another correlation between curiosity and uncertainty. It should manipulate those two quantities independently. A concrete design appears below.

### Is curiosity thermodynamic?

**As an established scientific description: no. As a testable hypothesis about implementation: yes.**

The strongest argument **for** the word is that cognition is physically instantiated, neural information processing consumes scarce metabolic resources, efficient coding is biologically consequential, and Still et al. show a rigorous setting in which retaining non-predictive information has a thermodynamic price. citeturn18search0turn18search1 There is therefore nothing mystical about asking whether natural selection favored epistemic control systems that spend energy preferentially where predictive return is high.

The strongest argument **against** is stronger at present. Neither the 20% brain-energy fact nor Landauer's bound tells us what organisms should be curious about. Neural computation operates far above the Landauer limit. citeturn18search0turn18search2 Variational free energy is not interchangeable with metabolic free energy. citeturn12search0turn12search3 And I found no direct evidence that trial-by-trial curiosity covaries with expected metabolic savings once ordinary epistemic variables are controlled.

I would therefore write:

> **Hypothesis:** curiosity is an efficiency-sensitive epistemic drive implemented by a metabolically constrained physical learner.

I would **not yet** write:

> **Finding:** curiosity is a thermodynamic drive.

There is a useful hierarchy here:

\[
\text{thermodynamically possible}
\;\not\Rightarrow\;
\text{metabolically advantageous}
\;\not\Rightarrow\;
\text{selected by evolution}
\;\not\Rightarrow\;
\text{implemented as curiosity}
\;\not\Rightarrow\;
\text{felt experience}.
\]

Evidence is needed at every arrow.

### Does online updating matter?

For **learning-progress algorithms**, yes. A reward defined as improvement requires at least a comparison between an earlier and later learner state. Schmidhuber's and Oudeyer/Kaplan's formulations explicitly rely on an adaptive predictor or compressor. citeturn11academia12turn8search0

For **epistemic behavior**, durable weight updates are not necessary. Active inference can value observations prospectively through belief updating, and Transformers can adapt to in-context examples with frozen parameters. citeturn12search3turn23search8

For **feeling**, the evidence does not answer the question. There is no established theorem or experiment showing that parameter plasticity is necessary or sufficient for subjective curiosity.

This suggests a more useful cross-substrate distinction for EbE:

\[
\text{Does information acquired at }t
\text{ alter the state that controls action at }t+1?
\]

That state could be synaptic weights, an active Bayesian posterior, working memory, a context window, an external notebook, or a persistent agent memory. The persistence time matters, but the substrate does not have to.

This correction may actually strengthen EbE. Its own learning loop emphasizes feedback and **retention**, not any particular physical mechanism of retention. fileciteturn1file0L2-L2 A context-only LLM has a short retention horizon. A human has multiple nested horizons. An AI agent with persistent memory occupies an intermediate case. That is a cleaner substrate-neutral distinction than brain versus deployed model.

### A minimal EbE formulation

The simplest formulation should start from the EbE quantity already present in the repository rather than introducing “thermodynamics” by name. EbE treats slack as the resource margin left after upkeep and treats misfit as costly. fileciteturn1file0L2-L2

Let the learner at time \(t\) have model \(\theta_t\). Let \(a\) be an epistemic action: inspect, ask, explore, experiment, read, sample. It produces observation \(y\), after which a learning operator \(A\) may update the learner:

\[
\theta_{t+1}=A(\theta_t,y).
\]

Let

\[
L(\theta)
\]

be expected predictive or action-relevant misfit on a defined future reference distribution, and

\[
K(\theta)
\]

be the upkeep of maintaining and using that representation. \(K\) might initially be description length or computational cost; calling it metabolic cost would require separate empirical calibration.

For an epistemic action \(a\), define expected epistemic gain

\[
G_t(a)=
\mathbb E_a
\left[
K(\theta_t)+\lambda L(\theta_t)
-
K(\theta_{t+1})-\lambda L(\theta_{t+1})
\right]
-
C(a),
\]

where \(C(a)\) is the cost of acquiring and processing the information.

Then the **compression/learning-progress hypothesis** is

\[
\text{Curiosity}_t(a)
=
f\!\left(\max(0,G_t(a))\right),
\]

with \(f\) monotone, perhaps modulated by risk, time horizon and competing needs.

An even more EbE-native version uses future slack directly:

\[
G^{\mathrm{epi}}_t(a)
=
\mathbb E[
S_{t+H}\mid a,\text{ learning allowed}]
-
\mathbb E[
S_{t+H}\mid a,\text{ same observation but no model improvement}]
-
C(a).
\]

The counterfactual term matters. Without it, eating food, winning money or receiving praise could all raise slack and would falsely count as curiosity. **Curiosity must be the value assigned to the part of expected future gain caused by epistemic updating.**

This formalization immediately reproduces several useful cases.

For **mastered regularity**, loss is already low; little further improvement is possible, so \(G\approx0\).

For **irreducible noise**, loss is high but remains high after learning; again \(G\approx0\).

For **learnable structure**, the new observation allows a simpler and/or more predictive model; \(G>0\).

For **isolated trivia**, the result depends on the learner. If the fact neither lowers future loss nor reorganizes the model, compression-gain theory predicts little curiosity. If it connects a salient gap, enables future inference, or carries social/reward value, other curiosity mechanisms can still predict strong interest.

That last case is not an inconvenience. It gives a way to falsify the theory rather than making it explain everything.

The formulation requires at least five empirical premises:

1. changes in \(K\) or \(L\) must predict some genuine future resource or performance consequence;
2. the organism must be able to estimate expected improvement before obtaining the information;
3. curiosity must covary with that estimate after controlling novelty, uncertainty and ordinary rewards;
4. the learned representation must retain the distinctions needed for future action—compression cannot simply discard them;
5. curiosity should fall when expected epistemic improvement falls, even if raw prediction error stays high.

If those premises fail, EbE should not identify curiosity with the learning loop.

## Test designs that could separate compression gain from novelty

### Human experiment: same surprise, different model improvement

The cleanest study would manipulate **how much an answer improves a model** while holding immediate novelty and information quantity approximately fixed.

Participants first learn three artificial “worlds,” presented as sequences, miniature ecosystems, alien languages or causal machines. In all three, a query reveals one answer from a set with the same entropy.

In the **structured-learning condition**, the answer identifies a latent rule that substantially improves prediction of many future cases.

In the **isolated-fact condition**, the answer resolves the current uncertainty but provides almost no predictive leverage over other cases.

In the **noise condition**, an equally surprising answer is freshly randomized, so observing it cannot improve future predictions.

Before every reveal, participants rate curiosity and may sacrifice a small amount of money, time, or an alternative opportunity to see the answer. Kang et al.'s willingness-to-pay/wait methodology provides a validated behavioral template for treating curiosity as something people will expend resources to satisfy. citeturn8search3

The crucial quantity would be calculated independently of self-report:

\[
\Delta\mathrm{MDL}
=
\mathrm{MDL}_{\text{before}}(D_{\text{held-out}})
-
\mathrm{MDL}_{\text{after}}(D_{\text{held-out}}).
\]

A Bayesian or predictive-learning model could similarly estimate expected reduction in held-out log-loss. The experiment should preregister comparisons among immediate surprisal, expected information gain about the single answer, expected future predictive gain, and expected MDL reduction.

**Compression-progress prediction:** curiosity and willingness to pay should rank structured-learning > isolated fact > irreducible noise after immediate entropy is matched, and individual differences in expected \(\Delta\mathrm{MDL}\) should explain unique variance.

**Evidence against it:** curiosity remains a function of raw surprise or gap size after expected model improvement is controlled; participants are equally or more curious about irreducible noise; or realized/expected compression gain contributes no explanatory power.

This would test the hypothesis more directly than the existing Goldilocks paradigm, because intermediate complexity is only a proxy for learnability. citeturn16search20

### Human experiment: a moving Goldilocks zone

A second study would test the *progress* rather than static learnability prediction.

Give participants a set of generative streams with different rule complexities. Because participants learn, the region with maximum improvement should move over time: yesterday's difficult stream becomes today's learnable stream and tomorrow's boring stream.

After every block, estimate the participant-specific learning curve using held-out prediction. Define trial-level learning progress as

\[
LP_{i,t}=L_{i,t-\Delta}-L_{i,t}.
\]

Participants then freely choose which stream to inspect next.

Oudeyer and Kaplan predict that choice should migrate toward streams with the steepest current improvement, not the largest current error. citeturn8search0 Schmidhuber predicts the analogous movement toward the steepest improvement in compression. citeturn11academia12 Silvia's appraisal account predicts preference for stimuli that combine novelty with perceived capacity to understand them. citeturn10search0

These models make separable predictions if the design includes a stream with high persistent error but zero learning slope.

The strongest outcome would not simply be an inverted-U curve. It would be **within-person migration of curiosity following the derivative of learning performance**. That is much closer to “learning loop felt from inside.”

### Artificial-agent experiment: structured room versus noisy television

Construct a multi-room environment in which every room has equal sensory bandwidth and no extrinsic task reward.

One room contains a deterministic pattern that is quickly mastered.

One contains an irreducibly random television.

One contains a complicated but learnable generative process.

One contains a hierarchy of learnable regularities in which each discovery opens the next.

Train identical agents differing only in intrinsic reward:

\[
r^{\rm surprise}_t=L_t,
\]

\[
r^{\rm novelty}_t=N(s_t),
\]

\[
r^{\rm progress}_t=L_{t-\Delta}-L_t,
\]

and

\[
r^{\rm compression}_t=
\mathrm{MDL}_{t-\Delta}-\mathrm{MDL}_t .
\]

Prediction-error curiosity should be vulnerable to the random room; learning- and compression-progress agents should leave it once no improvement occurs. This is exactly the theoretical distinction exposed by the noisy-TV literature, and published progress-curiosity work already shows that progress rewards can overcome white-noise attraction. citeturn15search0turn14search1

The important extension would be to compare **learning progress with compression progress**. A learner might improve prediction by making its model continually larger. Compression progress should reward only improvement net of representational cost. If the two agents behave identically, the “compression” component adds little beyond ordinary learning progress. If compression reward produces better transfer, simpler world models or lower inference cost without sacrificing accuracy, that would identify the part of the hypothesis that is genuinely distinct.

A useful second phase would add two feedback channels: one “judge” that rewards agreement with a stated belief, and one environment whose subsequent outcomes reveal what is actually predictive. Vary their correlation. An approval-optimized agent should follow the judge when the channels diverge; a world-model-progress agent should preferentially sample evidence that improves environmental prediction. The design would turn the brief's “judges versus world” distinction into experimentally separate objective functions. Human-feedback-induced sycophancy shows that this conflict is not merely hypothetical in language models. citeturn21academia36turn21search2

## What could not be verified and the resulting research verdict

Several limitations matter enough to state explicitly.

First, I could retrieve the current `CORE.md` and use its learning-loop/slack framing as the theory under assessment. fileciteturn1file0L2-L2 I could **not** retrieve the D11 and D12 entries specified in the brief. The current `DIALOGUE.md` returned by the repository ends with D10. They may exist in an unmerged branch, a later local version, or a commit not exposed through the default branch, but I cannot assume their contents. fileciteturn2file0L2-L2

Second, for Loewenstein I verified the APA publisher record and abstract but did not obtain a publisher-hosted full PDF. I therefore quote the publisher abstract rather than asserting a page-specific internal passage. citeturn13search0

Third, the IEEE metadata for Schmidhuber's 2010 paper and its DOI are verified, but I did not obtain the IEEE full text. The substantive quotation is therefore from Schmidhuber's primary 2008/2009 arXiv paper, which states the compression-progress claim directly. citeturn11academia12turn11search0

Fourth, I verified Delétang et al. as an ICLR 2024 paper and inspected its primary arXiv abstract. citeturn22search1turn12academia36 I did not retrieve Shannon's 1948 original article during this search, so I have deliberately not supplied a purported Shannon quotation from memory. The historical attribution to Shannon is appropriate at the level of source coding, but the specific claim about arithmetic coding should not be cited as though arithmetic coding appeared in Shannon's 1948 paper.

Fifth, I did not find primary evidence establishing a direct causal chain

\[
\text{metabolic saving}
\rightarrow
\text{epistemic reward}
\rightarrow
\text{felt curiosity}.
\]

The literature establishes each neighborhood separately: neural computation has metabolic costs; predictive memory can be thermodynamically efficient under formal conditions; humans experience curiosity and seek information; and computational curiosity can reward learning or compression progress. citeturn18search0turn18search1turn8search3turn11academia12 The arrows connecting these into one biological mechanism remain hypothetical.

Sixth, I found no established theory saying that a system must update its durable parameters while acting in order to *feel* curiosity. The computational literature does establish that learning-progress reward normally presupposes an adaptive learner, but inference-time adaptation without parameter changes is real, so “weight update” cannot serve as the dividing line between learning and non-learning. citeturn8search0turn23search8 Nothing in that result establishes machine consciousness; it only removes one proposed computational necessity.

The search covered the named sources and neighboring literature through publisher pages, PubMed, Nature, APS, PLOS, SAGE, PMLR, OpenReview metadata, arXiv, IEEE bibliographic records, and the EbE GitHub repository. I specifically searched information-gap theory, compression and learning progress, active inference and epistemic value, Goldilocks experiments, curiosity-memory experiments, knowledge-network compression, intrinsic-motivation RL, noisy-TV failure modes, neural energetic costs, Landauer's principle, thermodynamics of prediction, intrinsic/extrinsic motivation, in-context learning and language-model sycophancy. This was a broad source-checked review, **not** a systematic review with database-specific inclusion criteria, duplicate screening, forward-citation saturation or formal risk-of-bias assessment. Failure to find a claim therefore does not establish that no one has made it.

The resulting assessment of the EbE idea is unusually clean:

**Established prior art:** curiosity as a knowledge gap; curiosity/interest favoring intermediate learnability; intrinsic reward from learning progress; intrinsic reward from compression progress; epistemic value as expected information gain; costly neural information processing; thermodynamic advantages of retaining predictive rather than non-predictive information in specified physical systems. citeturn13search0turn10search0turn8search0turn11academia12turn12search3turn18search0turn18search1

**Supported synthesis:** a useful common denominator is **expected epistemic gain**. Novelty creates opportunities; gaps identify missing pieces; learnability says whether the opportunity is tractable; learning progress measures improvement; compression progress asks whether improvement creates a more efficient model; epistemic value asks how much uncertainty will be removed; future-usefulness models ask whether any of this improves subsequent decisions. The theories are better understood as different objective functions over the same learning loop than as mutually exclusive definitions of curiosity. citeturn8search0turn17search0turn9search0

**EbE-specific hypothesis worth retaining:** among epistemic actions, curiosity may approximate expected future **slack gain attributable to model improvement**, net of the cost of exploration and maintenance. This supplies a reason—not contained in compression theory alone—why a persistent system should care about learning efficiency.

**Claim that should be dropped unless new evidence appears:** “curiosity is thermodynamics felt from inside.” It currently compresses several different levels of explanation into one sentence.

A formulation that survives the literature much better is:

> **Curiosity may be the learning loop valued from the inside: an anticipatory signal that some attainable information is expected to improve the learner's model enough to repay the cost of acquiring and retaining it. Compression progress is one particularly strong candidate for that gain, but not the only one. In biological learners the loop is necessarily physical and metabolically constrained; whether its subjective feeling is itself a thermodynamic phenomenon remains open.**

That version is close enough to the original intuition to be interesting, but different enough to be falsifiable. It predicts not a hunger for maximum novelty, and not merely a desire to close every information gap, but a shifting attraction toward **what the learner expects it can profitably come to understand**.