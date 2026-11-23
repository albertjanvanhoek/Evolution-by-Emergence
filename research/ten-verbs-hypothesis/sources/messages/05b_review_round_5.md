# Review, round 5: of version 0.5

The reviewing assistant's reply to [05_v0_5_full_message.md](05_v0_5_full_message.md), 20 November 2026, written after the first simulation results. Verbatim. One of its points was later corrected: see the note at point 2. Index: [README.md](README.md).

---

# Adversarial review, round 5: version 0.5

**Bottom line:** v0.5 takes up most of round 4. Its two corrections to my review are fair. But it was written without the simulation results, and those results contradict it in three places. The most serious: §8, as written, could reject the ten-verb model even when that model is true.

## The two corrections: both fair

**Be honest, Share and Repair do have research literatures.** I meant that standard *learning models* have no parameter for them, but I wrote it as if no field studies them. The new framing is better: the same set of functions explaining correction both within one intelligence and between intelligences.

**Failed recovery in one design does not disprove the theory.** Agreed, and the write-up in PR #155 says the same.

## Where the simulation results contradict v0.5

### 1. §8 can reject a true model

§8 rejects the ten-verb model (M4) if simpler models "predict held-out responses as well as or better." In the simulation:
- with only choices recorded, BIC picked the true full model **0 times out of 40**;
- with rich belief reports, it picked it 22 times out of 40.

So under §8 as written, a design that records only choices would reject M4 even when M4 generated the data. "M4 is false" and "the design can't see M4" would look identical.

**Fix:** a rejection under §8 counts only in designs where model recovery has first shown that M4 is picked when it is true, at a rate fixed in advance. §5 already puts identifiability first; §8 needs to depend on it explicitly.

### 2. The illustrative matrix expects the wrong failure

v0.5 sketches confusion between Notice and Change (0.38 / 0.42) and between Share and Repair (0.35 / 0.31). The simulation found almost none: with rich reports, every off-diagonal value is between −0.06 and 0.09.

The real failures were of two other kinds:
- **Invisibility:** outside their own condition, the data hold *no* information about Take care or Repair.
- **Thin measurement:** Be honest and Find new ways come back weakly, and the belief verbs blur when only choices are recorded.

This depends on my model. Notice was written as a threshold on surprise and Change as an update size, and Share and Repair each have their own observable behaviour. A different model could produce exactly the confusion v0.5 expects. But the lesson for experiment design stands: the risk lies in what gets recorded, more than in verbs being mistaken for each other.

> **Later correction (not part of the original reply):** an outside review showed that the check behind "almost none" could not show the absence of trade-offs. Correlations between estimation errors do show one: Stay open and Change (−0.41 with rich reports). See [../REVIEW_OF_PR155.md](../REVIEW_OF_PR155.md) and RESULTS.md, E2.

### 3. The §3 matrix builds in what v0.5 itself warns against

v0.5 says rightly that a simulation "must not … build the correct answer into its experimental conditions." Yet several of its own contrasts amount to "the verb's situation present vs. absent":
- **Repair:** disrupted vs. continuously working channels.
- **Take care:** scarce vs. plentiful resources.
- **Find new ways:** existing methods unable vs. able.
- **Share:** private information vs. information everyone already has.
- **Change:** "detected but not yet incorporated." That is close to the definition of Change.

In the simulation these rows came out exactly as predicted, and that tells us nothing (−24.8 for Take care only when scarce, −8.5 for Repair only when disrupted, −25.6 for Find new ways only in the blind condition). The rows that carry real risk are the ones where the condition is a *cause* rather than the verb's own setting:
- Be honest under incentives to misrepresent;
- Notice under noisy perception;
- Stay open under a misleader.

### 4. Remember / let go needs a crossover, and v0.5 can't express one

The row predicts a "greater adverse effect" in stable vs. changing environments, but doesn't say which impairment. In the simulation the two impairments have **opposite signs**:
- remembering everything *helped* in stable conditions (+4.6, and +13.6 with the reality route only) and cost 33.3 points when the world changed;
- letting go too fast hurt in every condition.

A crossover (sign flips with the condition) is the strongest kind of prediction the matrix could contain. Write it as one. The escape clause "except where the order is explicitly reversed" should go.

## Problems not touched by the simulation

- **M1 isn't yet a model that generates behaviour.** "A single latent factor" is a description, not a learner. Make it concrete: every verb parameter is a fixed function of one ability *g*, so the model has one free parameter.
- **M2 is still unspecified** ("the exact structure must be fixed before comparison"). Until it is fixed, M4 has no real opponent.
- **M4's "context-dependent interactions" add freedom.** If interactions can be chosen after seeing the data, M4 can fit anything. Fix them in advance or leave them out.
- **The recursive-learning idea isn't new to the project.** D45 already records your position that the next step is to apply the same verbs recursively across levels rather than add more verbs. Keeping it out of v0.5 is right, but cite D45 so the lineage is visible.

## A process point

v0.5 has now taken up most of my round-4 suggestions, so further rounds between the two assistants are converging rather than testing. By the repo's own agreement 7, my reviews are no longer an independent check. What can still surprise anyone is data (the simulation, and a model of the verbs written by someone else) or a human modeller.

## Suggested next step

Extend the simulation in PR #155:
- fit M1 (one ability), M2 (a standard learner with a weight on social information) and M3 (three tiers) next to M4;
- rerun model recovery across all seven conditions and both recording regimes;
- add the Remember / let go crossover as a pre-stated test.

That would answer §4 and §8 directly. It's about 30–45 minutes of local computing at no cost. I can also add v0.5 verbatim to the PR as lineage. Shall I do both?
