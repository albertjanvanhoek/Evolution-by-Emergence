# A probabilistic ledger for learning

**Status:** a working note with a small numerical model, 17 November 2026 (D50 in [DIALOGUE.md](../../DIALOGUE.md)). Outside the core. Revised the same day after an independent review ([REVIEW.md](../../verification/audits/2026-11-17-probabilistic-ledger/REVIEW.md); the repository's answer is [RESPONSE.md](../../verification/audits/2026-11-17-probabilistic-ledger/RESPONSE.md)). What was held before the review, and what changed it, is in section 8.

**What this note is, after the review.** A numerically checked comparison of two ways to charge for misfit: counting wrong worlds, as in [`LearningRatchet.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningRatchet.lean), and the log-loss of the actual world. Every identity used is standard and has a named antecedent (section 7). No new mathematical result is claimed. The log-loss version is not a validated resource ledger: it does not derive what misfit costs. What the comparison does is show assumptions the count ledger leaves implicit.

## 1. Why

The literature audit of 11 November (D47) said of the ledger in `LearningRatchet`: the count sets the bill. Each wrong world kept costs one unit per turn, so splitting one wrong possibility into several raises the cost, and nothing invariant stands behind the count.

The question here: if misfit is measured by the log-loss of the actual world, −ln q(w\*), instead of by the number of wrong worlds kept, what holds, what fails, and what has to be chosen?

It came up while discussing the book by Welling, Lu and Holdijk, *Generative AI and Stochastic Thermodynamics* (Cambridge University Press, 2026; seen only in the publisher's description), which relates machine learning to variational free energy. An outside note the author supplied asked to keep three things apart: what is logically compatible with the observations, what the information is worth, and what it costs physically. This note is about the second only.

## 2. The model

A learner holds a probability distribution q over a finite set of worlds. One world is actual. An operation gives an outcome with probability p(x | w). The learner updates by Bayes' rule. Misfit in a turn is −ln q(w\*), in nats, scored on a declared outcome space (case 1).

The count ledger is **not** a special case of this. Under hard elimination with a uniform belief over n worlds, log-loss is ln n, while `LearningRatchet` charges n − 1, plus a separate cost for a lost truth. No constant rate turns one into the other: (n − 1)/ln n runs from 1.44 at n = 2 to 3.37 at n = 8. The two are different cost rules that agree only in being monotone.

Every number below comes from [`ledger.py`](ledger.py) (standard library, deterministic; output in [`results.txt`](results.txt)). The finite models are enumerated in full, in floating-point arithmetic. The property check is a random sample with a fixed seed.

## 3. Five test cases

**Case 1. Splitting worlds.** With q = 1/2, 1/4, 1/4 on A (actual), B and C, splitting B into ten sub-worlds of the same total mass moves the count from 2 to 11 and leaves the log-loss at ln 2. Ruling out B gains ln 4/3 whether B is split or not. (In the split case the ten sub-worlds go in one turn, which `learnOwn`, removing one error per turn, does not do; the example shows an arbitrariness in the count rule, not a run of `LearningRatchet`.)

The condition, stated by the review more cleanly than in the first version: fix the outcome space that is scored, and score the probability pushed onto it. Any refinement of the worlds that keeps that pushed-forward distribution keeps the score. Two consequences: a prior that is "uniform over the listed worlds" does not do this (q(A) falls from 1/3 to 1/12 when B is split), and splitting the actual world raises the log-loss by ln 4 if the fine state is scored, and not at all if the coarse world is.

**Case 2. A false record, and a misleading observation.**
- *Hard elimination.* A false record gives the truth probability zero. Its log-loss is infinite, and under ordinary Bayes updating the truth cannot come back. That does not block all learning: an operation that told the remaining wrong worlds apart could still update among them. In the example none does, by the choice of case. So the strong block in `LearningRatchet` (no learning at all while `lost > 0`) is imposed by `learnOwn`, not derived here. Cromwell's rule is the warning against giving a contingent possibility probability zero; case (a) shows what happens when it is ignored.
- *With noise* (accuracy 0.8, prior 1/2). An honest observation can mislead: world A gives the outcome 1 with probability 0.2, and after it q(A) is 0.2. Compared with a learner that did not make that turn, the extra expected log-loss is 0.92, then 0.05 after ten further honest turns and 0.004 after twenty; 3.36 nats in all over 21 turns. In log-odds the misleading outcome is an offset of ln 4, which one observation the other way cancels.

This is conditional on an unfavourable outcome. It measures what one misleading datum costs. It is not a comparison of two policies: a learner that drops such data would need to know which data mislead, and keeping honest data is what Bayes prescribes under a right model. A real recording error that turned 0 into 1 leaves the learner in exactly the same state; from inside the two cannot be told apart, which is `tested_and_untested_look_alike` again. That the cost shrinks is shown only for this stationary, identifiable two-hypothesis model with a right instrument; in general it needs useful later evidence, positive support and a right model.

**Case 3. Information from another learner.** The chain rule I(T;X,Y) = I(T;X) + I(T;Y|X), with T a declared question, X my observation and Y the other's, is a possible alternative to the two counters of `LearningRatchet`, given a target and a joint distribution. It is not derived from them. With two fair bits:
- redundant views (Y = X): the other adds nothing;
- complementary views: the other adds a full bit;
- synergy (T = a xor b, X = a, Y = b): each alone tells nothing about T, together they settle it;
- the same noisy instrument run twice with independent noise (accuracy 0.8): the second run adds 0.18 bits to the first's 0.28.

Two corrections from the review. First, the count ledger scores the full world, and in the synergy case observing a rightly removes two of four worlds; the first version called that a gain booked "where nothing was learned", which switched the scored question. The fair point is narrower: the count cannot score progress on a declared question narrower than the world. Second, I(T;Y|X) = 0 means a *redundant* view. A second honest run of the same method with independent noise is not redundant (last row). So "same view" in `same_view_is_solo` has to mean redundant information, not the same method; this agrees with section 13 of [LEARNING_DECOMPOSITION.md](../discovarianism/LEARNING_DECOMPOSITION.md) (two laboratories with the same method still catch each other's errors).

**Case 4. A world that moves.**
- *Splitting a change.* When both the world p and the model q change, the change in KL(p‖q) can be split exactly into a model part and a world part, in two orders. In the example the orders give opposite signs: model first gives model −0.061 and world +0.060; world first gives world −0.062 and model +0.061. Averaging the two orders (a two-factor Shapley-style rule) gives model +0.000 and world −0.001. That average is a convention, not a theorem; a temporal or causal question can justify one order instead. Any line between "update" and "goes stale" needs one declared. The expected log-loss H(p) + KL(p‖q) also moves through H(p), by +0.062 here.
- *Assumed change.* Two worlds, accuracy 0.75, sixteen turns. Assuming a world that stands still (hazard 0) gives cumulative log-loss 3.86 in a static world and 28.1 when the world switches at the midpoint; assuming change (hazard 0.1) gives 6.61 and 9.10. This holds for these settings only; no general ranking is shown. The hazard captures one aspect of "retain, and let go": how fast old evidence loses weight. Neither learner drops, retracts or dates a record, so the verb as an action is not modelled.

**Case 5. A wrong instrument.** The learner's account says A gives 0 with probability 0.8 and B gives 1 with probability 0.8. If A really gives 0 with probability r:
- r = 0.8 (right): one turn's expected change in ln q(A) is +0.19;
- r = 0.6: the one-turn expectation is −0.08, yet the log-odds drift toward A (+0.28 per turn), so the learner still settles on A;
- r = 0.3: the drift is −0.55 and the learner settles on B (expected log-loss of A is 11.2 after twenty turns), because B's model is closer in KL to how A actually behaves than A's own model is.

So a right instrument is a sufficient premise for the per-turn guarantee; a wrong one can cost the guarantee without costing convergence, or cost both. With independent observations a misspecified Bayesian learner settles on the represented model closest in KL to the data, which need not carry the true label.

## 4. The general result

**If q(w\*) > 0 and the learner's p(x | w) is the true one, the expected change in ln q(w\*) after one honest observation is KL(p(x | w\*) ‖ q(x)), which is never negative.** It is zero exactly when the outcome distribution in the actual world equals the learner's predictive distribution. Checked on 20,000 random instances (largest gap 7.8 × 10⁻¹⁶); the identity is standard.

**Its relation to the creed is a reading, not an exact correspondence.** The first version said three creed items had "an exact role" here. The review gave a counterexample for one of them, and there is no formal map from the creed or `LearningVerbs.lean` to these assumptions.
- *Try.* Zero expected gain in the actual world is not the same as an operation that tells no worlds apart. Counterexample (checked in the script): prior 0.2, 0.4, 0.4 on A, B, C, actual A, and an operation giving 1 with probability 0.5, 0.2, 0.8. It tells B from C, yet the predictive probability of 1 is 0.5, as in A, so the expected gain for A is zero. The two notions match for I(W;X), averaged over a prior of full support, not for the gain in the actual world.
- *Look* and *record honestly* are things a learner does. The mathematics needs something else: that the record is distributed as the true likelihood says. An honest record through a wrong instrument does not meet that.
- *My instrument is right* is a sufficient premise for the guarantee (case 5), not a creed result.

What the identity does not give: that each turn improves the model, or that the reserve grows. `learning_turn_raises_slack` holds turn by turn under hard elimination without noise. With noise, what holds is a positive expected change in log-score, under a right instrument. Turning that into expected reserve needs the coupling of section 5, and the cost of trying.

## 5. What a log-loss ledger would still have to choose

- **What is scored.** The latent world, the next observation, the outcome of an action, or a declared question T; and whose loss is charged (case 1, case 3).
- **How loss becomes a drain.** Charging realized log-loss every turn is a choice of functional form, not a result.
- **A rate** between nats and units of reserve. A fixed rate cannot reproduce the count's bill (section 2). A rate that may vary freely by state can fit any bill, which moves the arbitrariness rather than removing it.

Task-specific ways to fix the last two exist: a decision problem with explicit losses (value of information), or a growth problem where log-loss maps to capital growth (Kelly). None gives one rate for all learners. These are leads from the review, not checked here.

D12 left open that a better model saves upkeep at all ("That a better model saves upkeep at all stays a premise"). These choices are where that premise would have to be made concrete. The first version said D12 left open "the exchange rate λ" itself; that said more than the record.

## 6. What is left out

- **The physical layer.** Nothing here is in joules. Logically ruling out a hypothesis is not the same as physically erasing a bit, and Landauer's bound concerns logically irreversible steps on a physical memory (D21). Of the physical leads (Landauer 1961; Bennett 1982; Still, Sivak, Bell and Crooks 2012; Shiraishi, Funo and Saito 2018), the review found none that yields a general rate from log-loss to resource depletion; Still and colleagues are the most pertinent as a mechanism. D12 already dropped an unsupported thermodynamic claim, so nothing physical is added.
- **Lean.** The note is numerical. A Lean version would need real numbers and logarithms, so Mathlib.
- **Choosing what to try,** a link that can lie, several learners, and any real learning system or calibrated cost.

## 7. Antecedents

From the review, which read these in primary sources or publisher records ([REVIEW.md](../../verification/audits/2026-11-17-probabilistic-ledger/REVIEW.md), Part 2, with full references):
- expected information and the local log score: Bernardo (1979); proper scoring rules: Gneiting and Raftery (2007);
- value of information: Howard (1966); information and growth: Kelly (1956);
- conditional information: Shannon (1948); redundancy and synergy: Williams and Beer (2010, preprint);
- online change-point detection with a hazard: Adams and MacKay (2007); stability and plasticity: Carpenter and Grossberg (1987);
- Bayesian misspecification and the KL-closest model: Kleijn and van der Vaart (2006);
- Cromwell's rule: Lindley (2006), section 6.8.

The review's verdict on novelty: nothing mathematical is added. The juxtaposition with this ledger is specific to the repository, not a new theorem.

## 8. Revision record

**What was held in the first version, and what changed it.** The review ([REVIEW.md](../../verification/audits/2026-11-17-probabilistic-ledger/REVIEW.md)) reproduced every number independently and found no numerical error. It found the prose stronger than the code in twelve places. The main ones, each now corrected above:
1. the count ledger was called a special case of uniform hard elimination; it is not (section 2);
2. an honest but misleading observation was called a "false record", and compared with a learner that dropped it after the fact; now relabelled and scoped as conditional on an unfavourable outcome (case 2);
3. "hard elimination blocks later learning" was too broad; it blocks the truth's return, not learning among wrong worlds (case 2);
4. "Cromwell's rule" was cited as if it produced the zero; it warns against it (case 2);
5. the synergy example switched the scored question when criticising the count (case 3);
6. "same view" was equated with zero conditional information; that holds for a redundant view only (case 3);
7. "retain, and let go" was called one parameter; the hazard is one aspect of it, and no action of letting go is modelled (case 4);
8. the symmetric split was presented as a default; it is a convention (case 4);
9. convergence under a wrong instrument was not separated from convergence to the true label (case 5);
10. three creed items were said to have "an exact role"; it is a reading, with a counterexample for "Try" (section 4);
11. the rate λ was presented as the one remaining choice and as what D12 left open; there are at least two choices, and D12 left open something broader (section 5);
12. "exact enumeration" and "robust signs" said more than shown (sections 2 and 4).

## 9. Where I'm unsure or disagree

- **I accept every point of the review.** I found no point where I think it is wrong. On the synergy case I would still keep the narrower point it leaves standing: a count of worlds cannot score progress on a declared question.
- **This is the fifth outside correction of the same pattern** in this repository: a summary stronger than the result (D40 to D47, and now here). The first version of this note named working agreement 7 and still made the same kind of error twelve times.
- **The idea and both versions of the note are by the same assistant** (working agreement 7). The review is by another assistant, whose model family is not recorded here.

## 10. Reproduce

`python3 ledger.py` (Python 3, standard library). Runs in about two seconds. The findings of cases 1 to 5, the property check and its counterexample, and the claim that no constant rate turns ln n into n − 1 are guarded by assertions; the run ends with "All assertions passed". [`results.txt`](results.txt) is the output behind this note.
