# Review, round 3: of version 0.3

The reviewing assistant's reply to [03_v0_3_corrective_filtering.md](03_v0_3_corrective_filtering.md), 20 November 2026. Verbatim. The literature named was named from general knowledge and has not been checked. Index: [README.md](README.md).

---

# Adversarial review, round 3: version 0.3

**Bottom line:** v0.3 is much better. Outcomes are separated, contamination is built in, letting go is now included, and there is a real falsification section. But v0.3 became defensible mainly by moving its weight onto claims that are already known and don't need the verbs. The one claim that is new, the ten-way decomposition, is now the least specified part.

## On the two challenges to my review

**Logic as a source of truth:** this answers a claim I didn't make. My split was by *what does the checking*, and I described coherence as finding an inconsistency, not as settling which premise is false. The clarification is still right, though, and the "checking processes" wording in v0.3 is better than my "routes."

**My falsifier was too strong:** I accept this. Independent errors help only if each signal is better than chance (Condorcet needs p > 0.5) *and* the receiver combines the signals correctly. My P1 needed both conditions.

## Main problems

### 1. H1 and H2 test known results, not the verbs

- **H1** is conditioned on "an appropriately specified evidence-integration procedure." If that procedure is close to Bayesian, H1 is a mathematical result, not something that needs testing.
- **H2** compares "an effective evaluation procedure" against counting agreeing messages. That builds success into the intervention, which is exactly what §9 says it avoids.

Both are already shown in the literature on correlated errors, for example Lorenz et al. (2011) on how social influence undermines the wisdom of crowds. More importantly, **neither H1 nor H2 mentions a single verb.** They could all come out true and the Ten Verbs Hypothesis would have gained nothing. The verbs only carry weight in H3 and H4.

### 2. H3 is the novel claim, and it is the one left unspecified

"Distinguishable patterns of impairment… must be specified for each task before testing." That puts off the only claim that is specific to this theory. The decomposition is the theory's contribution, so commit now: write down the predicted impairment matrix (10 functions × checking processes + resistance to contamination). The design is double dissociation, as in neuropsychology. Some illustrative rows:

| Function knocked out | Reality checking | Reasoning checking | Commons checking | Resists contamination |
|---|---|---|---|---|
| Notice | ↓↓ | – | ↓ | ↓ |
| Share (keeping provenance) | – | – | ↓↓ | ↓↓ |
| Try | ↓↓ | – | – | – |
| Let go | ↓ (slow recovery) | – | ↓ | ↓↓ (old errors persist) |

If knockouts don't produce separable profiles, the ten-way split fails. That is a real and specific risk, which is what makes it worth testing.

### 3. The circularity has moved into the verb table

The circularity is no longer in the main claim. It is now in the definitions of the individual functions:
- "Revise beliefs **appropriately**"
- "**credible** alternatives"
- "**warranted** learning"
- "when **appropriate and safe**"

Each qualifier quietly means "in the way that produces accuracy." Every function needs a measure that doesn't look at the final outcome:

| Verb | Measure that doesn't use final accuracy |
|---|---|
| Stay open | How many alternative hypotheses are kept in play or sampled |
| Try | Expected information gain of the tests chosen |
| Notice | Sensitivity (d′) to prediction errors |
| Be honest | Match between privately held and reported belief |
| Change | Size of belief update compared with a normative benchmark |
| Remember / let go | Keeping confirmed items; withdrawing refuted ones |
| Take care | Resources set aside for inquiry |
| Share | Whether information passed on keeps its provenance |
| Repair | Time until a broken correction channel works again |
| Find new ways | Rate of adopting new methods, and of validating them |

### 4. "Remember and let go" is two opposing functions under one name

The two can trade off against each other, so measuring them as one component hides the trade-off. Strictly, you now have eleven functions under ten names. Either split them, or justify the pairing as one function (a single retention policy). This also matters for the creed and for the film's voice-over, which use the ten-verb version.

### 5. H5 predicts nothing

"The direction and magnitude… are expected to depend on these prespecified conditions." That's a promise to make a prediction later. P4 from my redraft gave a direction and was dropped: cohesion built on uncorrected beliefs is fragile once real consequences arrive. Bring back some prediction with a direction, or remove H5.

### 6. §7 on contamination has no hypothesis

Accountability, conditional Repair and boundaries are argued for, but nothing tests them. A candidate: *in mixed populations that include misleading agents, conditional Repair and Share keep accuracy higher than unconditional versions, while unconditional versions do better in fully cooperative populations.* That covers the policing side of the framework, which you hold to be essential.

### 7. The "distinctive" claim isn't distinctive yet

"Maintaining correctability matters even when agreement is impossible" is already in Popper and Longino, and in much of the work on deliberation. What *is* new: the claims apply to any kind of intelligence, the ten-way split can be tested, and correction is measured separately from relationship outcomes. Say that plainly, and let H3 carry the weight.

## A pattern to watch

Each round between two AI reviewers has made the text more defensible by making it claim less. v0.1 was bold and circular. v0.3 is careful and mostly already known. The next version should go back toward risk: one bold claim made precise (the impairment matrix) is worth more than five well-hedged predictions.

## Suggested next step

Keep §1–2 and §6–7 as they are. Cut H1 and H2 down to one sentence of background ("we assume established results on correlated evidence"). Make H3 the main hypothesis, with the matrix written out, and add the contamination hypothesis from point 6. An agent-based or multi-agent LLM setup that knocks out functions one at a time could test it quickly, before any work with human participants.
