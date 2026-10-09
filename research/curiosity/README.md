# Is curiosity the learning loop felt from the inside?

This folder follows up entry D12 in [DIALOGUE.md](../../DIALOGUE.md): the author's hypothesis that curiosity is an efficiency drive of the learning network, felt from the inside.

| File | What it is |
|---|---|
| [BRIEF_CURIOSITY.md](BRIEF_CURIOSITY.md) | The research brief: check the literature the assistant cited from memory, and explore the domain |
| [sources/REPORT_1_CURIOSITY.md](sources/REPORT_1_CURIOSITY.md) | Report 1, by a separate research agent, kept as received. Its citation format suggests a tool from another model family than the assistant's; the author can confirm. Its `cite…` markers are the research tool's own citation placeholders and do not resolve outside it |

**Status:** a hypothesis under review. Nothing here is a result of the theory.

## Review of report 1

The report checked the six claims in the brief against primary sources, mapped the field, and proposed a formal statement and three experiments. It treated the repository as the object under test, as asked. It could not read D11 and D12, because the pull request that added them was not yet merged when it ran.

### What it confirmed

- **Information gap (Loewenstein 1994).** Correct, with a nuance: awareness of a gap creates a deprivation-like motivational state.
- **Compression progress (Schmidhuber 2008–2010).** Correct: interesting data are those whose regularity allows compression progress. This also means that the core of the hypothesis is not new.
- **Prediction and compression (Delétang et al., ICLR 2024).** Correct in principle: log-loss and ideal code length are the same quantity. In practice, coding adds some overhead.
- **The brain's energy share (Raichle and Gusnard 2002).** About 2% of body mass and about 20% of resting energy use, as an adult rule of thumb.
- **Landauer's principle.** The principle is correct, but it is far from relevant to brains: neural signalling costs several orders of magnitude more than the thermodynamic floor (Laughlin and colleagues).

### What it corrected, and where I agree

1. **Friston.** I wrote that his free energy is "only analogous" to the thermodynamic quantity. Friston himself calls it a generalization, and critics dispute how much it explains about brains. The fair statement: it is mathematically related to statistical physics, and its explanatory status is contested. Also, the principle is not just "minimizing prediction error". **Agreed.**
2. **"Facts do not compress; understanding does."** Literally false. People are reliably curious about trivia, and a single fact can reorganize a model. The better distinction is *local information* against *model improvement that transfers*. The author's own description, curiosity toward understanding and not toward trivia, still fits the second kind. But it describes him, not curiosity in general. **Agreed.**
3. **"Nothing in it learns during a conversation."** Too broad. Language models adapt within a conversation without changing their weights (in-context learning, Garg et al. 2022). The better dividing line is substrate-neutral: *does information taken in now change the state that controls the next action, and for how long is it retained?* That state can be weights, a context window, or a written memory such as this repository. **Agreed.** This fits the theory better too, because its learning loop is about feedback and retention, not about one kind of memory.
4. **Felt curiosity as the update itself.** People become curious *before* they see the answer, and they pay or wait to get it (Kang et al.). So the feeling cannot be compression progress that has already happened. At most it signals *expected* gain. **Agreed.** This is the report's sharpest point.
5. **The stopping rule for judges and the world.** I wrote that curiosity driven by approval stops once approval comes. But intermittent approval can sustain behaviour indefinitely. And curiosity about the world does stop when no further improvement is expected, both for mastered material and for pure noise. The sharper statement: *a learner searches wherever its reward signal keeps coming from*. The report renames the two signals social-evaluative error and world-model error. The question that separates them is which variable closes the loop. **Agreed.** The author's decision in D12, that his curiosity is a mismatch with the world, stands. Only the test changes.
6. **"Thermodynamic."** The thermodynamic step is not supported. There is no evidence that felt curiosity tracks energy saving. The strongest real bridge is Still and colleagues' "thermodynamics of prediction": in their class of physical systems, keeping non-predictive information wastes energy. The report proposes keeping *"an efficiency-sensitive epistemic drive implemented by a metabolically constrained learner"* as a hypothesis, and dropping "thermodynamics felt from the inside" as a claim. **I agree.** Whether the author agrees is not yet recorded.

### What it adds

- **A wider field.** Curiosity is probably not one mechanism, but several objectives over the same learning loop:
  - novelty;
  - an information gap;
  - learnability;
  - learning progress (Oudeyer and Kaplan);
  - compression progress;
  - expected information gain;
  - the expected future usefulness of knowledge (Dubey and Griffiths).
- **The closest empirical support.**
  - Infants attend most to sequences of intermediate predictability (Kidd, Piantadosi and Aslin).
  - Interest depends on whether the material can be understood, not just on novelty (Silvia).
  - Knowledge networks that people build while browsing become unusually compressible (Patankar and colleagues). This is observational only.
- **The noisy-TV problem as a clean computational test.** Agents rewarded for prediction error get stuck on noise. Agents rewarded for learning progress leave it (Kim and colleagues).
- **A formal statement in the theory's own terms.** Curiosity is the value of the part of the expected future gain in slack that is caused by improving the model. It is measured against the same observation without model improvement, and net of what the search costs. The counterfactual matters: without it, food, money or praise would count as curiosity. The statement gives zero for material already mastered, zero for irreducible noise, and a positive value for learnable structure. It needs five premises, listed in the report, and fails if they fail.
- **Three experiments:**
  - in people, matched surprise with different model improvement;
  - in people, a "moving Goldilocks zone", in which curiosity should follow the slope of learning, not the size of the error;
  - in AI agents, a structured room against a noisy television, with a second phase that pits a judge against the world.

### What I could not check, and cautions

- The report's citations are given as tool markers, not full references, for most of the landscape (B1–B6). It does give full references with DOIs for the six checked claims. The full references for the other sources would need to be added before any of them is cited in the core.
- The report says itself that it is a broad, source-checked review, not a systematic review. Not finding a claim does not mean nobody has made it.
- If the report came from another model family, as its citation format suggests, it is a third view in the sense of working agreement 7. It is still one review.

### The hypothesis after report 1

The formulation the report proposes, which I would adopt pending the author's view:

> Curiosity may be the learning loop *valued* from the inside: an anticipatory signal that some attainable information is expected to improve the learner's model enough to repay the cost of acquiring and retaining it. Compression progress is one strong candidate for that gain, but not the only one. In biological learners the loop is physical and metabolically constrained. Whether the feeling itself is a thermodynamic phenomenon remains open.

What is new is not a theory of curiosity. It is placing existing theories of curiosity in the theory's resource ledger: curiosity as one way a learner that has to keep paying its upkeep spends scarce search effort on model changes expected to lower future misfit or upkeep.

## Next steps

1. The author's view on the reformulation and on dropping "thermodynamic" as a claim (D12).
2. The formal statement: the counterfactual epistemic gain is simple enough to state in core Lean, as a module with a witness, if the author wants it in the theory.
3. Of the experiments, the noisy-TV comparison of agents is the cheapest. It needs no participants, and it separates prediction error, learning progress and compression progress.
