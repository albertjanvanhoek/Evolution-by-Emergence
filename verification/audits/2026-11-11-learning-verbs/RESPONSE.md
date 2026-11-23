# Response to the literature audit of 11 November 2026

This file says what the repository accepts, corrects, keeps or leaves open after [AUDIT.md](AUDIT.md), which was written on the brief in [BRIEF.md](BRIEF.md) by an assistant from a model family other than the one that wrote the work. The response was drafted by the assistant that wrote the work (D47 in [DIALOGUE.md](../../../DIALOGUE.md)); the author has not yet read it.

The audit judged the commit `342d7c9`. Line references in it are to that commit. Two things changed afterwards that a reader of the audit should know: the theorem `method_validation_is_a_learning_turn` is now `method_check_filters_accounts`, and the false turn in `LearningRatchet.lean` now always marks the truth as ruled out.

## Headline

The audit's headline is accepted without reservation:

> mainly a small formal reconstruction of candidate elimination, observational indistinguishability, learning about methods, and elementary resource accounting, with ethical and legal interpretations attached.

No claim received the verdict "sharpening". The work should not be presented as new theory. What it may be is an arrangement: known ideas set side by side in one vocabulary and one small family of models. Whether that arrangement earns its place is open, and is for readers outside the repository to judge. This matches the conclusion of the audit of 15 September about the earlier stack.

## The two counterexamples

Both were re-derived in Lean before anything was changed, and both hold.

- **Claim 1, general necessity of the seven verbs.** With three worlds kept possible, an operation that tells the third from the other two, a right record, and an update that also drops the second world, six verbs hold, `Updates` fails, and the turn learns. *Accepted.* The counterexample is now a theorem, `update_not_necessary_in_general`, with its twin for retain. The wording "each is needed" is removed from the module header, the note, the package README and the release notes. What stands: joint sufficiency; necessity of leave open, try, test, record and afford in the sense of exact negation; and, for update and retain, that one named way of failing blocks.
- **Claim 10, a false turn with zero cost.** With `lostCost = 0` a false turn left `lost = 0`, and a later honest turn learned. *Accepted.* The model conflated having ruled out the truth with what that costs. Ruling out the actual world now costs at least one unit per turn, so every false turn leaves its mark (`false_turn_excludes_truth`, `false_turn_blocks_later_learning`). The audit's further point is also accepted and stated in the module: the blocking holds by the transition rule and is not derived from `LearningVerbs`.

## Claim by claim

| Claim | Verdict | Response |
|---|---|---|
| 1 | defective | **Corrected,** as above. |
| 2 | special case | **Accepted.** The note's "cannot be checked from inside" is now read as: cannot be certified from the restricted information in the examples. It is not a ban on calibration or cross-checking. The audit's remark that the model does not tell an inaccessible truth from one that was culpably ignored is taken up under claim 14. |
| 3 | special case | **Accepted.** The docstring now says that `blind_spot_survives` does not require the blind world to differ from the actual one. The repository does not claim that every learner has a blind spot or that any difference between learners is useful. |
| 4 | special case | **Corrected.** The module header said information about the source "has to" settle a blind-spot correction. It now says that further evidence can, about the source or by an additional direct test, and that neither is guaranteed to. |
| 5 | special case | **Accepted.** That one acquired operation turns all blind errors into findable ones is a strong assumption of the ledger model, and is stated as such. |
| 6 | special case | **Corrected.** The note said the second execution "has to be" independent. Independence is not in the model. The wording now says that the worth of agreement depends on how far the two can fail differently, that "honest" names equalities and not intentions, and that deterministic agreement is much narrower than empirical replication. |
| 7 | special case | **Corrected.** `method_validation_is_a_learning_turn` did not conclude that anything was learned; it is renamed `method_check_filters_accounts`, and `method_check_learns_when_accounts_differ` gives the full statement. `validated_method_can_still_be_wrong` now requires the surviving account to be wrong. "Each level leaves a blind spot" is now "can leave". The repository does not claim a procedure for recursive self-improvement. |
| 8 | restatement | **Accepted,** with the antecedent (Katsuno and Mendelzon 1992). "Retaining is good only while the world stands still" was too broad and is replaced: what fails is treating an old result as an unchanged constraint on the present. |
| 9 | not found | **Accepted as "not found", which is not "new".** The heading "the loop pays for its own next turn" claimed more than raising later slack and is changed. The audit's point that the count sets the bill, so that splitting one possibility raises the cost, is added to the module's limits. |
| 10 | defective | **Corrected,** as above. `revise` is still a reset and not an account of retraction; the note said so and still does. |
| 11 | restatement | **Accepted.** "Two terms" is two counters decremented separately by definition. The module now says this is counting and not a result about how information from two sources combines. |
| 12 | special case | **Accepted.** The module already named `Reciprocity` as the richer model and stated the knife-edge. Added: a cost of zero is allowed in the extension, and then both last without correction. |
| 13 | restatement | **Accepted.** The two definitions name a scope and give no measure. They stay in D45 as proposals and are not in the core. |
| 14 | defective | **Corrected in the creed.** It no longer says that every sin blocks learning in the model, and it no longer says that a failed condition is nobody's fault. It says which rows have a blocking result and that the others are proposed; and that a failed condition is not in itself a fault, while a fault can still lie with someone. The audit's wider point stands and is not answered: an equality in a model carries no information about intention or care, so the step from a failed verb to a vice needs premises the models do not have. |
| 15 | restatement | **Accepted,** with the antecedents (Nedelsky 1989; Fricker 2007). The legal note now says that it is a way of putting an existing concern, and that supported decision-making is not only about correction. |
| 16 | defective | **Corrected in the legal note.** Its Sources section now follows the audit's table. The statement that fallibility is not a working assumption between persons in private relations was wrong and is replaced. The three historical cases are stated with what their sources support, and the shared diagnosis is marked as the note's own. The illustrations about parents and debts are marked as unchecked. |

## Kept

- **The Lean results as conditional statements.** The audit did not check proofs and found no theorem false; its counterexamples are to interpretations.
- **The verb vocabulary.** The audit treats it as a redescription of known structure, which is what it is.
- **The legal note as a proposal,** now more plainly marked as one.

## Left open

- **The literature the audit could not reach.** Its own list of unverified leads stands as the repository's list: Hintikka, Popper, Gold, formal learning theory, Bateson, Argyris and Schön, Friston, Blackwell, the testimony literature, Collins, concept drift, Zagzebski, Mackenzie and Stoljar, Stark, and the Dutch statutes on representation and compulsory care. None of these names should be cited from this repository as an antecedent until someone has read the source.
- **From failed verb to vice.** See claim 14.
- **Whether the arrangement is worth having.** Not a question an audit of antecedents can settle.
- **A human reader.** The work, two reviews and this audit were all done by assistants, from two model families. No lawyer, philosopher or clinician has read any of it.
