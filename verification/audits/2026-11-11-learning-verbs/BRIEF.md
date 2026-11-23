# Brief for an independent literature audit of the learning-verbs work

11 November 2026. This file is a prompt. Give it, whole, to a reviewer who did not write the work: an assistant from another model family, or a human reader. The assistant that wrote the work should not carry out this audit (working agreement 7 in [CLAUDE.md](../../../CLAUDE.md)).

---

## Your task

You are asked to audit a body of recent work in the repository *Evolution by Emergence* against the existing literature. Your job is adversarial: find prior art, rediscoveries, stronger antecedents and precision defects. Do not look for reasons the work is new. An earlier audit of this repository ([../2026-09-15-literature/](../2026-09-15-literature/README.md)) found that most of its formal results were rediscoveries with a few sharpenings, and the repository accepted that. Expect the same here, and say so plainly where it is the case.

You are not asked to check the Lean proofs. They compile and CI passes. You are asked what the results amount to once they are set beside what was already known.

## What to read

Repository: `albertjanvanhoek/Evolution-by-Emergence`. Read these, in this order:

1. `research/discovarianism/LEARNING_DECOMPOSITION.md`: the note. Fifteen sections; section 11 and section 15 already list overlaps and weaknesses found from inside.
2. `formalization/cumulative-accessibility/CumulativeAccessibility/LearningVerbs.lean`, `LongCollaboration.lean` and `LearningRatchet.lean`: the statements. Read the module headers and the theorem statements; you do not need the proofs.
3. `research/discovarianism/CREED.md`, sections "The verbs of learning" and "Sins".
4. `research/relational-duties/FALLIBLE_NOT_INCOMPETENT.md`: a concept note on law.
5. `DIALOGUE.md`, entries D39 to D46: how the work came about and what was already corrected.
6. For context only: `CORE.md`, and `verification/audits/2026-09-15-literature/` for the form of an earlier audit.

## The claims to audit

For each numbered claim, find the closest prior statement in the literature.

**Part A. Learning as a loop of verbs**

1. **Learning as ruling out possible worlds**, with one turn made of try, test, record, update, retain, under the conditions leave open and afford; the seven are jointly sufficient and each is necessary in the model (`seven_verbs_learn`, `sealed_blocks` to `unpaid_blocks`).
2. **Actions and conditions.** "Test" and "leave open" cannot be checked from inside: two situations identical in everything the learner has can differ in which world is actual (`tested_and_untested_look_alike`, `open_and_sealed_look_alike`).
3. **The blind spot.** An error that no operation of the learner tells from the truth survives any number of its own honest turns (`blind_spot_survives`), and another learner with a different operation can remove it (`seven_verbs_correct`, `same_view_cannot_correct`).
4. **A correction can be false and cannot be checked.** Accepting a false signal rules out the truth (`accepting_false_signal_loses_truth`); for a blind spot the receiver's own observations give the same verdict on a true and a false correction (`own_evidence_cannot_evaluate_blind_correction`).
5. **Being told and being taught.** Receiving a result against acquiring an operation; honest own testing with a correctly understood operation never rules out the truth (`own_test_keeps_truth`); acquiring removes a difference in methods (`after_acquiring_other_adds_nothing`).
6. **Replication.** The same method run twice honestly gives the same record; disagreement reveals a failure; agreement proves nothing if both failed alike (`same_method_honest_records_agree`, `same_method_disagreement_reveals_failure`, `agreement_is_not_proof`).
7. **Methods can be wrong; checking a method is the same loop one level up**, with its own blind spot (`wrong_account_of_method_loses_truth`, `method_validation_is_a_learning_turn`, `validated_method_can_still_be_wrong`); and on the joint space of world and method a surprise does not say which is wrong (`surprise_does_not_say_which`).
8. **A retained result can go stale** when the world moves (`retained_record_goes_stale`).

**Part B. Learning on a resource ledger**

9. **Learning pays for its own next turn.** Each wrong possibility kept costs per turn; a learning turn raises slack for good; a learner whose reserve covers the transition lasts and a sealed one does not (`learning_turn_raises_slack`, `loop_closes`, `efficiency_buys_duration`).
10. **A retained false record** changes slack by what it happened to remove minus what the lost truth costs, and blocks later learning until revised (`false_turn_slack`, `after_false_turn_no_learning`, `revision_restores_learning`).
11. **Two terms.** Progress from one's own operations and progress that arrives only through a link to a different view (`errors_removed_two_terms`, `link_decides`).
12. **A lasting exchange of correction** between two learners who depend only on each other lasts exactly when both do all the exchange verbs, at the knife-edge where a correction pays one turn's cost (`lasts_iff_all_verbs`, `gain_below_cost_ends`, `gain_at_least_cost_lasts`). The repository already says this is largely its own earlier `Reciprocity` result.

**Part C. Definitions and the creed**

13. **Two proposed definitions** (D45): intelligence as the capacity of a network-organized process to use information from interactions with reality to adapt its organization and behaviour; recursive intelligence as the capacity to also modify the operations through which it learns.
14. **Sins as failures of what a learner does**, kept apart from conditions that fail without fault (the creed's "What is not a sin").

**Part D. The legal concept note**

15. **A person as the holder of a correctable model**, and a proposed protected interest in one's routes of correction, with the safeguard "fallible is not incompetent".
16. **The note's legal and historical statements.** Check each against its source: the Universal Declaration (articles 1 and 29), Mill's *On Liberty* chapter 2, Burgerlijk Wetboek 7:448 and 7:450, the Mental Capacity Act 2005 section 1, article 12 of the disability convention, General Comment No. 1 (2014), the declaration of the Netherlands on article 12, and the unreferenced historical claims in its section 4. The note lists which of these were checked in a primary source and which were not.

## Leads, all unverified

The assistant that wrote the work named the following from memory and checked none of them. Treat them as places to start, confirm or reject each, and add what is missing.

- Claim 1: version spaces and candidate elimination (Mitchell); possible-worlds accounts of knowledge and information (Hintikka; Aumann); Popper on falsification; belief revision (Alchourrón, Gärdenfors and Makinson); formal learning theory (Gold; Kelly); optimal experiment design and active learning.
- Claim 2: epistemic externalism and the internalism debate; unconceived alternatives (Stanford).
- Claims 3 and 4: identifiability and observational equivalence in statistics and econometrics; the epistemology of testimony; common knowledge and agreement results (Aumann); Zollman on networks; Kleinberg and Raghavan on algorithmic monoculture.
- Claim 5: testimony against demonstration; teaching in cultural evolution (Tomasello; Csibra and Gergely on natural pedagogy); learning to learn (Bateson's levels of learning; Argyris and Schön on double-loop learning; Schmidhuber; Chollet's skill-acquisition efficiency).
- Claim 6: replication and reproducibility; Condorcet-style results and their dependence on independence.
- Claim 7: the Duhem–Quine problem; calibration of instruments (the experimenter's regress, Collins); the problem of induction.
- Claim 8: the stability–plasticity dilemma; concept drift; forgetting in continual learning.
- Claims 9 to 11: the value of information; rational inattention (Sims); the free-energy principle (Friston); bounded rationality; requisite variety (Ashby).
- Claim 12: reciprocal altruism (Trivers); repeated games; partner choice.
- Claim 13: Legg and Hutter; Hernández-Orallo; Chollet; autopoiesis and enactive accounts; Hofstadter's strange loop; Metzinger's self-model.
- Claim 14: virtue epistemology and epistemic vices (Zagzebski; Cassam); moral luck.
- Claim 15: relational autonomy (Nedelsky; Mackenzie and Stoljar); epistemic injustice (Fricker); coercive control (Stark); supported decision-making and its critics; Dutch law on curatele, bewind and mentorschap, and the Wvggz and the Wzd.

## Rules

1. **Primary sources.** Do not attribute a result, a quotation or a date to anyone unless you have seen it in the work itself or in the publisher's or author's own record of it. A search-engine summary is a lead, not a source. If you cannot reach a source, say so and mark the item "unverified".
2. **Give the reference in full** for every source you rely on: authors, year, title, venue, and a link or DOI where one exists.
3. **Quote sparingly.** At most one short quotation per source, and only where the wording matters.
4. **Say what differs.** For each claim give the closest prior statement, then what the repository's version adds, changes or gets wrong. "Nothing" is an acceptable answer to "what does it add".
5. **Precision defects count.** Where a Lean statement or the note's prose claims more than the closest result in the literature would license, say so.
6. **No flattery and no rescue.** If a claim is a restatement, call it one. Do not suggest a reframing that would make it look newer.
7. **Stay within the brief.** Do not edit any other file in the repository, and do not open or merge pull requests. Do not put the name of any AI model in the files you write.
8. **Cost.** The author is cost-conscious. This audit should need on the order of a few dozen searches and source readings. If you find it needs many more, stop and report what you have.

## What to deliver

One file, `verification/audits/2026-11-11-learning-verbs/AUDIT.md`, with:

1. **A table**, one row per claim (1 to 16): the verdict, the closest prior work, and one line on what differs. Use these verdicts:
   - *restatement*: already in the literature in essentially this form;
   - *special case*: a narrower instance of a known result;
   - *sharpening*: a known idea made more exact or joined to another in a way you did not find elsewhere;
   - *not found*: you found no close antecedent, which is not the same as new;
   - *defective*: the claim is wrong or misleading as stated.
2. **A section per claim** with the references and your reasoning.
3. **For Part D, a list** of each legal or historical statement with "confirmed in the primary source", "confirmed only in a secondary source", "not confirmed" or "wrong", and the source.
4. **A list of what you could not check** and why.
5. **A headline**, three or four sentences: what this body of work is, once set beside the literature.

State at the top who or what carried out the audit (a human reader; or "an assistant from a model family other than the one that wrote the work"), the date, and that it is a dated judgment and not a proof of priority.
