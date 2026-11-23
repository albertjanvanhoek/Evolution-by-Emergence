# Response to the review of 17 November 2026

This file says what the repository accepts, corrects, keeps or leaves open after [REVIEW.md](REVIEW.md). The review was written on the brief in [BRIEF.md](BRIEF.md) by an assistant that did not write the work; its model family is not recorded. This response was drafted by the assistant that wrote the work (D50 in [DIALOGUE.md](../../../DIALOGUE.md)). The author has not yet read it.

The review judged commit `b1bd937` on the branch of pull request 154. [REVIEW.md](REVIEW.md) is kept as received, including the branch name in its links.

## Headline

The review's verdict is accepted without reservation: the numbers are right, the identities are standard, and the prose claimed more than the code in twelve places. No new mathematical result is claimed. The note is now a bounded comparison of two ways to charge for misfit, not a probabilistic resource ledger. In the review's words, what it offers is "an explicit display of the assumptions the earlier count ledger hid".

## Reproduction

The review could not run the original script. It wrote its own checker and reproduced every reported number, including the largest gap 7.77 × 10⁻¹⁶ in the 20,000-trial property check. The corrected script was run again here; all its assertions pass, and the numbers of the first version are unchanged.

## Part 1, item by item

| Item | Verdict | Response |
|---|---|---|
| 1. Splitting | correct, precision defect | **Corrected.** The condition is now the review's: fix the outcome space that is scored and score the pushed-forward probability. The claim that the count ledger is a special case of uniform hard elimination is **withdrawn**; a new check shows no constant rate turns ln n into n − 1. The note now says the one-turn removal of ten sub-worlds is not a run of `learnOwn`. |
| 2. False record | correct, significant precision defect | **Corrected.** The noisy outcome is now called what it is, an honest but misleading observation, and the comparison is scoped as conditional on an unfavourable outcome, not a comparison of policies. "Blocks later learning" is narrowed to "the truth cannot return"; learning among wrong worlds can go on. "Debt that later observations repay" is scoped to the stationary, identifiable two-hypothesis model. Cromwell's rule is now cited as the warning it is. Added: a real recording error leaves the learner in the same state as a misleading observation, which is `tested_and_untested_look_alike` again. |
| 3. Two learners | identity correct, mapping overstated | **Corrected.** The chain rule is now "a possible alternative, given a declared target", not a replacement derived from the counters. The synergy criticism is narrowed to what survives the review: a count of worlds cannot score progress on a declared question narrower than the world. A new row shows a second run of the same noisy instrument adds information (0.18 bits), so `same_view_is_solo` has to mean a redundant view, not the same method. |
| 4. Moving world | correct, precision defect | **Corrected.** The symmetric split is called a convention (two-factor Shapley-style), with a declared order as the alternative. The hazard comparison is scoped to its settings. "Retain, and let go become one parameter" is **withdrawn**: the hazard is one aspect, and no action of letting go is modelled. |
| 5. Wrong instrument | correct, precision defect | **Corrected.** At r = 0.3 the learner settles on B, whose model is closer in KL to the data; the note now separates the represented model from the true label. |
| 6. General result | identity correct; exact correspondence wrong | **Corrected.** "An exact role" for three creed items is **withdrawn**; it is a reading. The review's counterexample for "Try" is added to the script as a checked case: an operation that tells B from C with zero expected gain for the actual world A. The note now says the creed's "Try" matches I(W;X) averaged over a prior of full support, not the gain in the actual world. |
| 7. The rate λ | correct, precision defect | **Corrected.** The note now lists the choices separately: what is scored, how loss becomes a drain, and the rate. "D12 left open λ" is **withdrawn**; D12 left open the broader premise that a better model saves upkeep. |
| 8. Precision | multiple overstatements | **Corrected,** all twelve. Section 8 of the note lists them. |

## Part 2

All accepted. The antecedents the review read are now listed in section 7 of the note, with a pointer to the full references in REVIEW.md. None of them was read again for this response, so they are cited as the review's findings.

## The five questions from the brief

| Question | Review | Response |
|---|---|---|
| A finding is wrong or follows from the numbers | yes | Accepted. The hazard ranking is example-specific and now says so; the misleading observation and the target switch are corrected. |
| The count ledger already has the property | yes, in part | Accepted. `same_view_is_solo` already gives no gain for a redundant view; the count never claimed to measure information about an arbitrary target. |
| λ can reproduce every count bill | no for fixed λ; yes for free λ | Accepted, and now in section 5 of the note. |
| The creed mapping is decoration | yes, as an exact correspondence | Accepted. It is now presented as a reading. |
| Known work already did the mathematics | yes | Accepted. |

## Where I'm unsure or disagree

- **No disagreement with any verdict.**
- **One point is narrowed rather than dropped.** On synergy, the review shows the first version's criticism switched the scored question. What remains is that the count has no way to declare a question; whether that matters depends on whether the repository wants a ledger scored on the world or on what a learner needs to know for acting (compare `research/world-model/MODELS_FOR_ACTING.md`). That is for the author.
- **The pattern repeats.** This is the fifth time an outside reader has found an assistant's summary stronger than its result (D40 to D47, and here), and the first version of the note named working agreement 7 while doing it. The review's twelve points are mostly of one kind: a sentence that turns a standard identity into a claim about the repository's own terms. A check that might have caught them: for each sentence that links a formula to a repository term (a verb, a theorem name, a premise of D12), ask whether there is a formal map, and if not, write "a reading".

## Open

- Whether this note earns a place in the repository at all, now that it claims no result. Its use is to show which choices a non-count ledger would have to make (section 5 of the note).
- What is scored: the world or a declared question.
- The author's reading of the note and of this response.
