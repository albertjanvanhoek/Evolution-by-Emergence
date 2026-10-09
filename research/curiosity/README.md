# Is curiosity the learning loop felt from the inside?

This folder follows up entry D12 in [DIALOGUE.md](../../DIALOGUE.md): the author's hypothesis that curiosity is an efficiency drive of the learning network, felt from the inside.

| File | What it is |
|---|---|
| [BRIEF_CURIOSITY.md](BRIEF_CURIOSITY.md) | The research brief: check the literature the assistant cited from memory, and explore the domain |
| [sources/REPORT_1_CURIOSITY.md](sources/REPORT_1_CURIOSITY.md) | Report 1, by a separate research agent, kept as received. Its `cite…` markers are the research tool's own citation placeholders and do not resolve outside it. The author confirmed it came from a model family other than the assistant's |
| [sources/REPORT_2_CURIOSITY.md](sources/REPORT_2_CURIOSITY.md) | Report 2, by a second research agent from the same other model family, kept as received. It has full references with DOIs and links, and states where each quotation is located |

**Status:** a hypothesis under review. Nothing here is a result of the theory. Neither report could read D11 and D12, because the pull request that added them was not yet merged when they ran. Both worked from the brief.

## Where the two reports agree

They were written independently, so these points are the most robust.

1. **The core of the hypothesis is not new.**
   - Schmidhuber (2009, 2010) proposed that curiosity rewards *progress* in compression, not compressibility or novelty as such.
   - Oudeyer and Kaplan (2007) proposed learning progress.
   - Both predict a pull toward what is neither mastered nor pure noise.
2. **The thermodynamic step is not supported.**
   - No experiment found links felt curiosity to energy saving.
   - Landauer's bound is a floor far below real neural costs.
   - The one literal bridge is Still and colleagues' "thermodynamics of prediction", and it is narrow: in their class of physical systems, keeping information that does not predict costs dissipation.
   - Both reports advise stating the hypothesis as an efficiency- or resource-constrained learning drive, and reserving "thermodynamic" for a specified physical model.
3. **"Facts do not compress; understanding does" is false as a general claim.**
   - People are reliably curious about trivia (Kang et al. 2009).
   - A better statement: understanding often means learning relations that organize many facts and support new predictions.
   - The author's own curiosity fits that kind, but it describes him, not curiosity in general.
4. **"Nothing in it learns during a conversation" is too broad.** Language models adapt within a conversation without changing their weights (Brown et al. 2020; Garg et al. 2022). The useful question is what state changes, and for how long it is kept.
5. **Curiosity comes before the answer.** So the feeling is at most a forecast of improvement, not a readout of an update that has happened. A forecast can also be wrong: the expected insight can turn out to be illusory.
6. **The stopping rule for "judges against the world" was too strong.**
   - Approval can need continual upkeep.
   - A question about the world can be settled.
   - What separates the two is which outcome the learning signal rewards, not whether the feedback comes from people or from the physical world: teachers can correct toward the world, and a non-social environment can mislead.
7. **A formal statement is possible in the theory's own terms,** with the cost of exploring and a counterfactual or baseline. The crucial premise is a causal link between better compression and lower upkeep. That link cannot be read off from the units "bits" and "joules".

## Where they disagree: Friston and thermodynamics

- **Report 1:** Friston "explicitly describes variational free energy as a generalization of thermodynamic free energy". It called my phrase "only analogous" too strong.
- **Report 2:** quotes Friston (2010), author PDF p. 2: free energy is "an information theoretic quantity (like surprise), as opposed to a thermodynamic quantity". It adds that literal connections can be derived only in specified physical models.

Report 2 gives a located quotation; report 1 does not. Both may hold across Friston's writings. The safe statement, which I now adopt: **variational free energy is an information-theoretic quantity; formal links to thermodynamic free energy exist only under specified physical models, and how much the principle explains about brains is contested.** I accepted report 1's correction too readily: my original wording was closer to Friston (2010) than report 1 allowed. This is the kind of disagreement that a second, independent view is for.

## Review of report 1

Report 1 checked the six claims, mapped the field, and proposed a formal statement and three experiments.

**What it added that report 2 does not:**
- a counterfactual definition of epistemic gain: the gain in future slack *caused by improving the model*, compared with the same observation without learning. Without the counterfactual, food, money or praise would count as curiosity;
- a "moving Goldilocks zone" experiment, in which curiosity should follow the slope of learning, not the size of the error;
- the substrate-neutral question "does information taken in now change the state that controls the next action?";
- Dubey and Griffiths' rational account: curiosity seeks what most increases the expected usefulness of knowledge.

**Limits.**
- Most of its landscape is cited through tool markers, not full references. Report 2 supplies full references for most of the same sources: Kidd, Piantadosi and Aslin 2012; Kang et al. 2009; Gruber et al. 2014; Patankar et al. 2023; Still et al. 2012; Pathak et al. 2017; Burda et al. 2018; Silvia 2005; Sharma et al. 2024; Oudeyer and Kaplan 2007.
- Its Friston correction is contradicted by report 2's located quotation (above).

## Review of report 2

**What it adds:**
- **Full, checkable references** (29), each saying what was inspected and what was not.
- **Explanation-seeking curiosity** (Liquin and Lombrozo 2020). It is a recognized kind of curiosity, distinguished from fact-seeking curiosity. Expectations of future learning and usefulness predict it beyond novelty, surprise and information gaps. This is the closest match in the literature to what the author describes: curiosity toward understanding, not toward trivia.
- **Humans track learning progress** (Ten, Kaushik, Oudeyer and Gottlieb 2021). In free choice among learning tasks, models that include learning progress explain exploration. This is the strongest human evidence for the progress part of the hypothesis, and its code is public.
- **Efficiency can produce prediction** (Ali et al. 2022). Recurrent networks trained only to be energy-efficient develop predictive-coding-like organization. This is an existence proof for part of the author's intuition: an efficiency pressure can yield a predictive model. It is a model with an activity cost, not measured human metabolism.
- **Two further hypotheses from the literature:**
  - curiosity may be metabolically cheap, because it uses activity that would happen anyway (Kondrakiewicz and Nawrocka 2025);
  - emotional valence may be the rate of change of free energy (Joffily and Coricelli 2013), which is close to "improvement is felt".
- **Four claims to keep apart:**
  1. a system improves;
  2. it detects the improvement;
  3. that detection guides exploration;
  4. the improvement is felt.

  Showing the first three does not establish the fourth.
- **A conditional proposition** that can be checked directly. With reserve `B(t+1) = B(t) + R − U − M − K`, the terms are:
  - uptake `R`;
  - upkeep `U`;
  - misfit losses `M`;
  - exploration cost `K`.

  Suppose an exploration yields a retained compression gain `g`, which lowers upkeep by `α·g` per period for `H` periods. Then it raises cumulative slack exactly when `α·g·Σδ^h > K`. The report names the weak premise itself: that compression lowers upkeep at all.
- **Three implications for `CORE.md` step 5.** I checked them against the text.
  1. The step from `q^k` to `k·q` trials needs feedback on each part separately, and interacting parts may not allow that.
  2. A turn of the vortex requires a change that both raises slack and widens search. A curiosity reward can be earned without doing either.
  3. Curiosity that lasts needs a continuing supply of learnable structure. Finite capacity and compression alone do not guarantee it.
- **Three experiments,** each stating what would count against the hypothesis:
  - in people, novelty without progress and progress without novelty, built on Ten et al.'s paradigm;
  - in AI, with honest accounting of compute and energy;
  - in people, approval and understanding varied independently.
- **A caution on the noisy-TV test.** Leaving the noise rules out one error-seeking algorithm. It is not unique evidence for compression progress, because Bayesian information gain and count-based bonuses also leave it.

**Limits.** It is a targeted search, not a systematic review, as it says itself. Several full texts were not inspected (Kang, the final Ali article, the final Kondrakiewicz and Nawrocka article), and the report marks this.

## The hypothesis after two reports

Both reports converge on nearly the same reformulation. Report 2's:

> Some epistemic curiosity may be a felt, fallible estimate of the value of improving one's model, given one's learning opportunities and costs. Whether compression supplies that estimate, and whether metabolic savings help explain it, remain separate empirical questions.

In the theory's terms: **curiosity as the learner's forecast of the slack gained by improving its model, net of the cost of searching.** Compression progress is one strong candidate for the measure of improvement, but not the only one. "Thermodynamic" stays a possible implementation, not the claim. What would be new is not a theory of curiosity, but placing existing theories in a resource ledger, with tests that discriminate between them.

**The author's decision (D12):** "the thermodynamic should go - as it is not supported - and it was just based on my fantasy." The reformulation stands, without the thermodynamic claim.

## Next steps

1. **Done:** [`CuriosityValue.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CuriosityValue.lean) states report 2's proposition with report 1's counterfactual. An exploration raises the reserve exactly when the retained saving over the horizon exceeds its cost; only the part caused by improving the model counts; without a saving it only costs; and it can pay yet be unaffordable now. The link from a better model to lower upkeep is a premise, not a result.
2. **Formal extensions:** discounting, uncertain or fading savings, and several explorations competing for one reserve.
3. **`CORE.md` step 5:** consider report 2's three implications, especially that `q^k → k·q` assumes separable feedback.
4. **An experiment:** the cheapest is the agent comparison (learnable rooms against a noise television), with several reward signals compared, not just two.
