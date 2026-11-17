# Brief for an independent review of the probabilistic ledger

17 November 2026. This file is a prompt. Give it, whole, to a reviewer who did not write the work: an assistant from another model family, or a human reader. The assistant that wrote the work should not carry out this review (working agreement 7 in [CLAUDE.md](../../../CLAUDE.md)).

---

## Your task

You are asked to review a short working note in the repository *Evolution by Emergence* and the script behind it. The note replaces the count of wrong worlds in a resource ledger by the log-loss of the actual world, and reports what changes in five test cases.

The review has two parts. Do Part 1 fully. Do Part 2 only as far as primary sources allow, and say where you stopped.

Your job is adversarial. The note already says that every identity it uses is standard. What it claims is narrower: that applying those identities to this ledger changes what the ledger can claim. Find where that is wrong, overstated or already done.

## What to read

Repository: `albertjanvanhoek/Evolution-by-Emergence`, branch `main`. In this order:

1. `research/probabilistic-ledger/README.md`: the note (eight short sections).
2. `research/probabilistic-ledger/ledger.py` and `results.txt`: the script and its output. Run it: `python3 ledger.py`, standard library only, about two seconds.
3. `formalization/cumulative-accessibility/CumulativeAccessibility/LearningRatchet.lean`: the ledger being replaced. The module header and the definitions `Terms`, `State`, `misfit`, `learnOwn`, `falseTurn`, `linked` are enough.
4. `research/discovarianism/LEARNING_DECOMPOSITION.md`, sections 3, 10 and 16, and `research/discovarianism/CREED.md`, section "The verbs of learning".
5. `verification/audits/2026-11-11-learning-verbs/AUDIT.md`: the earlier audit, whose remark on the ledger ("the count sets the bill") this note answers.
6. `DIALOGUE.md`, entries D12, D21, D47 and D50.

## Part 1. The mathematics and the mapping

For each item, say whether it is correct, whether it is stated with its limits, and whether the note's reading of it is fair.

1. **Case 1, splitting.** Log-loss of the actual world is invariant when a wrong world is split with its mass kept, and only relative to a declared level of scoring. Is "declared level of scoring" the right condition, or is there a cleaner one (a sufficient statistic, a partition fixed in advance, a proper scoring rule's locality)?
2. **Case 2, a false record.** Under hard elimination a false record gives infinite log-loss and blocks later learning; with noise it is a finite debt repaid by later honest observations. Is "blocks until revised" in `LearningRatchet` then fairly called an artefact of hard elimination? Is the comparison of the two learners (retained against discarded record) set up fairly?
3. **Case 3, two learners.** The chain rule I(T;X,Y) = I(T;X) + I(T;Y|X) replaces the two separately decremented counters. Is the mapping of `same_view_is_solo` to I(T;Y|X) = 0 right? Is the synergy example a fair criticism of the count ledger, or does the count ledger, read with T in mind, already avoid it?
4. **Case 4, a moving world.** (a) The split of a change in KL(p‖q) into a model part and a world part depends on the order, and the example gives opposite signs. Is the symmetric average the right default, or is there a standard decomposition the note should use? (b) The comparison of a learner with hazard 0 and one with hazard 0.1: is reading "retain, and let go" as the assumed hazard rate fair to the creed?
5. **Case 5, a wrong instrument.** A wrong account of the operation can cost the per-turn guarantee without costing convergence (true accuracy 0.6), or cost both (0.3). Check the numbers and the claim about convergence to the KL-closest model.
6. **The general result.** With a right instrument, the expected change in ln q(w\*) after one honest observation equals KL(p(x|w\*) ‖ q(x)) ≥ 0, with equality exactly when the outcome distribution in w\* equals the predictive distribution. Check the identity and the equality condition. Is the mapping of its three conditions to the creed (try; look and record honestly; my instrument is right) exact, or a reading?
7. **Section 5 of the note.** The note claims the stipulation is moved, not removed: a ledger now needs an exchange rate λ between nats and units of reserve, and this is the premise D12 left open. Is that the right description? Is there a principled way to fix λ (for example from a decision problem, a growth-rate argument as in Kelly betting, or a cost of misprediction) that the note misses?
8. **Precision.** Anywhere the note's prose says more than the script shows.

## Part 2. Literature

For each item give the closest prior statement, then what the note adds. "Nothing" is an acceptable answer.

- The expected log-score gain of a Bayesian update; information gain and expected value of sample information.
- The chain rule and partial information decomposition (redundancy, synergy, unique information).
- Bayesian filtering with a hazard rate; change-point detection; the stability–plasticity dilemma.
- Bayesian learning under misspecification (convergence to the KL-closest model).
- Cromwell's rule; zero-probability events and Bayesian updating.
- Proper scoring rules and their dependence on the partition scored.
- For the physical layer the note leaves out, check only whether these are fairly named as leads, and say whether any of them speaks to the exchange rate λ: Landauer (1961) and Bennett (1982); Still, Sivak, Bell and Crooks, "Thermodynamics of prediction" (PRL 2012); Shiraishi, Funo and Saito, "Speed limit for classical stochastic processes" (PRL 2018); Welling, Lu and Holdijk, *Generative AI and Stochastic Thermodynamics* (Cambridge University Press, 2026).

## What would count against the note

Say plainly if any of these holds:
- one of the five findings is wrong, or follows from a choice of numbers rather than from the structure;
- the count ledger, read correctly, already has the property the note says it lacks;
- the change from count to log-loss removes nothing, because the exchange rate λ can reproduce any bill the count gave;
- the mapping to the creed's verbs is decoration rather than an exact correspondence;
- the work is already done in a known source.

## Rules

1. **Primary sources.** Do not attribute a result, a quotation or a date to anyone unless you have seen it in the work itself or in the publisher's or author's own record of it. A search-engine summary is a lead, not a source. If you cannot reach a source, say so and mark the item "unverified".
2. **Give the reference in full** for every source you rely on: authors, year, title, venue, and a link or DOI where one exists.
3. **Quote sparingly.** At most one short quotation per source, and only where the wording matters.
4. **Say what differs.** For each item, the closest prior statement, then what the note adds, changes or gets wrong.
5. **No flattery and no rescue.** If something is a restatement, call it one. Do not suggest a reframing that would make it look newer.
6. **Run the script.** Report if any number in the note differs from what the script prints.

## What to hand back

A single Markdown file, `REVIEW.md`, with:
1. a verdict in three sentences;
2. Part 1, item by item: correct / correct with a precision defect / wrong, with your reason;
3. Part 2, item by item: closest prior statement, full reference, what the note adds;
4. the list from "What would count against the note", with yes, no or unclear for each;
5. what you could not check, and why.
