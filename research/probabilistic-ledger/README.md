# A probabilistic ledger for learning

**Status:** a working note with a small numerical model, 17 November 2026 (D50 in [DIALOGUE.md](../../DIALOGUE.md)). Outside the core. Nothing here is new: every identity used is standard information theory or filtering. What the note does is apply those identities to the ledger of [`LearningRatchet.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningRatchet.lean) and report what changes. No outside reader has checked it yet; the brief for one is in [verification/audits/2026-11-17-probabilistic-ledger/](../../verification/audits/2026-11-17-probabilistic-ledger/BRIEF.md).

## 1. Why

The literature audit of 11 November (D47) said of the ledger in `LearningRatchet`: the count sets the bill. Each wrong world kept costs one unit per turn, so splitting one wrong possibility into several raises the cost, and nothing invariant stands behind the count. Its conclusions follow largely from stipulated prices.

The question here is narrow. If misfit is measured by the log-loss of the actual world, −ln q(w\*), instead of by the number of wrong worlds kept, what holds, what fails and what is new?

The question came up while discussing the book by Welling, Lu and Holdijk, *Generative AI and Stochastic Thermodynamics* (Cambridge University Press, 2026; seen only in the publisher's description, not read), which relates machine learning to variational free energy. An outside note the author supplied asked to keep three things apart: what is logically compatible with the observations, what the information is worth, and what it costs physically. This note is about the second only. The physical layer stays out (section 6).

## 2. The model

A learner holds a probability distribution q over a finite set of worlds. One world is actual. An operation gives an outcome with probability p(x | w). The learner updates by Bayes' rule. Misfit in a turn is −ln q(w\*), in nats, scored at a declared level (section 3, case 1). The count ledger is the special case of hard elimination with a uniform belief over the worlds kept.

Every number below comes from [`ledger.py`](ledger.py) (standard library, deterministic; output in [`results.txt`](results.txt)). The checks are exact enumerations, except the property check, which is a random sample with a fixed seed.

## 3. Five test cases

**Case 1. Splitting worlds.** With q = 1/2, 1/4, 1/4 on A (actual), B and C, splitting B into ten sub-worlds of the same total mass moves the count from 2 to 11 and leaves the log-loss at ln 2. A turn that rules out B gains ln 4/3 either way; the count books 1 or 10. This answers the audit's point, under two conditions. The split must keep the mass: a prior that is "uniform over the listed worlds" is not split-invariant (q(A) falls from 1/3 to 1/12). And the level of scoring must be declared: splitting the actual world into four fine states raises the log-loss by ln 4 if it is scored on the fine state, and leaves it unchanged if scored on the coarse world.

**Case 2. A retained false record.** Two different pictures.
- *Hard elimination.* A false record gives the truth probability zero. Log-loss is then infinite, and no later observation can bring the truth back: the outcome world A goes on giving has probability zero under the learner's own model. So `LearningRatchet`'s "a false record blocks later learning until revised" is forced here, not stipulated. But the cost is infinite rather than `lostCost + 1`, and both facts come from assigning probability zero.
- *With noise* (accuracy 0.8, prior 1/2), a false record lowers q(A) to 0.2. That is a debt, not a block. In log-odds it is an offset of ln 4, which one honest observation the other way cancels exactly. The extra expected log-loss shrinks from 0.92 to 0.05 after ten honest turns and to 0.004 after twenty; over 21 turns it adds 3.36 nats in total. So "blocks until revised" is a property of hard elimination, as the audit suspected.

Also in case 2: one honest turn with a right instrument can make things worse (outcome 1 in world A raises the log-loss by ln 3), while the expected change is positive. This is the general result below.

**Case 3. Information from another learner.** The two terms of `LearningRatchet` are two counters, decremented separately. The chain rule I(T;X,Y) = I(T;X) + I(T;Y|X) replaces them, where T is the question that is scored, X my observation and Y the other's. With two fair bits:
- same view: I(T;Y|X) = 0, which is `same_view_is_solo`;
- complementary views: the other adds a full bit;
- synergy (T = a xor b, X = a, Y = b): each view alone tells nothing about T, together they settle it. Adding the separate terms gives 0 against a true 1; in the redundant case it gives 2 against 1. In the synergy case X rules out two of four worlds, so the count ledger books a gain where nothing about T was learned.

This is a textbook identity. What it adds to the repository is that "difference is a condition" becomes a quantity, I(T;Y|X), which can exceed what the other's view is worth alone.

**Case 4. A world that moves.**
- *Splitting a change.* When both the world p and the model q change, the change in KL(p‖q) can be split exactly into a part due to the model and a part due to the world. But the split depends on the order. In the example, model first gives model −0.061 and world +0.060; world first gives world −0.062 and model +0.061. The two orders give opposite signs. Averaging both orders gives model +0.000 and world −0.001. So any split between "update" and "goes stale" needs a declared order or a symmetric rule. The expected log-loss H(p) + KL(p‖q) also moves through H(p) (+0.062 here), which no change in the model can touch.
- *Retain, and let go.* Two worlds, accuracy 0.75, sixteen turns, exact expectation. A learner that assumes a world standing still (hazard 0) has cumulative log-loss 3.86 in a static world and 28.1 when the world switches halfway. A learner that assumes switching (hazard 0.1) has 6.61 and 9.10. So retaining wins when the world stands still and letting go wins when it moves. The creed's verb "retain, and let go" becomes a quantity: the hazard rate the learner assumes. This is standard filtering.

**Case 5. A wrong instrument.** The learner's account says A gives 0 with probability 0.8. If that is right, one turn's expected change in ln q(A) is +0.19. If A really gives 0 with probability 0.6, the one-turn expectation is −0.08, yet the log-odds still drift toward A (+0.28 per turn) and the learner converges on the truth. If A gives 0 with probability 0.3, the drift is −0.55 and honest records drive q(A) toward zero (expected log-loss 11.2 after twenty turns). So a wrong instrument can cost the guarantee per turn without costing convergence, or cost both. That Bayesian learning under a wrong model converges to the model closest in KL is a known result.

## 4. The general result, and where it sits in the creed

**With a right instrument, the expected change in ln q(w\*) after one honest observation is KL(p(x|w\*) ‖ q(x)), which is never negative.** It is zero exactly when the outcome distribution in the actual world equals the learner's predictive distribution, as for an operation that behaves the same in every world. Checked on 20,000 random instances (largest gap 8 × 10⁻¹⁶); the identity itself is standard.

Three of the creed's items appear in it with an exact role:
- **Try**: the gain is zero when the operation does not discriminate;
- **Look** and **record honestly**: the observation must come from the actual world;
- **My instrument is right** (a condition, not a verb): the learner's p(x | w) must be the true one. Case 5 shows what is lost without it.

What this does *not* give: that each turn improves the model. `learning_turn_raises_slack` holds turn by turn only under hard elimination with no noise. With noise it holds in expectation, and only under a right instrument.

## 5. What changes for the ledger

- **The split problem goes, under conditions.** Log-loss does not move when a wrong world is split with its mass kept, if the scoring level is declared (case 1).
- **A free parameter comes in.** Reserve is counted in units; log-loss in nats. A ledger needs an exchange rate λ between them, and nothing here derives it. So the stipulation is moved, not removed. This is the same premise that D12 left open for curiosity: "That a better model saves upkeep at all stays a premise." It is still a premise.
- **The shape of the bill changes.** With a uniform belief over n kept worlds the count books each removal at 1. Log-loss books the first of eight at 0.13 nats and the last at ln 2 ≈ 0.69. Which shape fits a real learner depends on how prediction error turns into lost resources. Neither ledger derives that.
- **A false record becomes a debt instead of a block** once there is noise and no zero probability (case 2).
- **The two terms become the chain rule,** with redundancy and synergy (case 3).
- **Retain and let go become one parameter,** the assumed hazard (case 4).

## 6. What is left out

- **The physical layer.** Nothing here is in joules. Logically ruling out a hypothesis is not the same as physically erasing a bit, and Landauer's bound applies only to logically irreversible steps on a physical memory (D21). Whether any of the quantities above has a physical floor (Landauer and Bennett; Still, Sivak, Bell and Crooks 2012 on the cost of keeping non-predictive information; speed limits of Shiraishi, Funo and Saito 2018) needs an explicit physical model. These works are named as leads; their statements were not read in full for this note. D12 already dropped an unsupported thermodynamic claim, so nothing physical should be added until the brief's second part is done.
- **The operational coupling** from prediction error to resources (λ, and its shape).
- **Lean.** The note is numerical. If the outside reader finds it worth having, the general result and the chain-rule step could be stated in Lean; that needs real numbers and logarithms, so Mathlib, which the repository avoids where it can.
- **Choosing what to try,** a link that can lie (only case 2 touches false records), and several learners.

## 7. Where I'm unsure or disagree

- **Every result here is known.** The note is useful only if putting these identities on the repository's ledger changes what the ledger can claim. I think it does in three places: a false record as debt, the chain rule for the two terms, and the exchange rate as the remaining premise. An outside reader should judge that.
- **Case choices carry the numbers.** Accuracy 0.8 and 0.75, hazard 0.1, sixteen and twenty turns. The signs in cases 4 and 5 are robust in my judgement; the sizes are illustrative.
- **The scored level is a choice.** Case 1 shows the answer depends on it. I think that fits the repository (fixed resolution in the depth paper; declared function in `CLAIMS.md`), but it means log-loss is invariant only relative to a declared question.
- **The idea came from me in conversation,** and the probabilistic framing was sharpened by the outside note the author supplied. Its model family is not recorded. The script and this note were written by the same assistant that proposed the idea, so working agreement 7 applies in full.

## 8. Reproduce

`python3 ledger.py` (Python 3, standard library). Runs in about two seconds. The findings of cases 1 to 5 and the property check are guarded by assertions; the run ends with "All assertions passed". [`results.txt`](results.txt) is the output behind this note.
