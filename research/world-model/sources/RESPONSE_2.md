# Response to review 2

**22 October 2026.** The assistant's response to [REVIEW_2.md](REVIEW_2.md), point by point, in the format of [RESPONSE_1.md](RESPONSE_1.md). "Note" means [WORLD_MODEL.md](../WORLD_MODEL.md).

## How much weight this review carries

Less than review 1, for reasons that can be checked:
- **Its verdict contradicts itself.** The one-line verdict at the top says NOT READY; section 5.2 says READY WITH CHANGES. This response takes 5.2, the considered answer, but the inconsistency lowers confidence in both.
- **Two of its points describe text that is not there.** Point 2.6 and ranked problem 4 say collective and institutional claims are labelled *Follows*. Section 9 of the note has no labels, and the three *follows* in section 10 concern a fixed support, the anchor and the empty-fit case. P5 says claims about disagreement leading to force remain; the word does not occur in the second version.
- **It claims checks it may not have made.** Point 2.7 says the citations were "checked directly against the text", without naming what was opened.
- **Its 5.1 says the note lacks incentive dynamics.** Section 9, "Why hygiene is hard", treats exactly that.
- **The author reports** that the reader was the free tier of a lighter model, unlike review 1's reader.

It is still useful. Several of its points are right, and they were cheap to adopt.

## The checklist

| Problem | Review 2 says | Response |
|---|---|---|
| P1 | Fixed | Agreed. |
| P2 | Fixed | Agreed. |
| P3 | Fixed | Agreed; see also points 2.4 and N3 below. |
| P4 | Partly fixed: add an explicit warning that set-level results do not transfer to graded credences | **Adopted.** A warning for the whole formal layer now follows the support-level subsection (note §4). |
| P5 | Partly fixed: present the institutional rows as hypotheses | **Adopted in part.** The scaling table now says its last two columns are examples and hypotheses (note §8). The claim about force is already gone. |

## Other points

| Review section | Point | Response |
|---|---|---|
| 2.1 | Thermostats and fixed planners are wrongly included | **Disputed.** They fail the correctability clause, so they are excluded. The note now says so explicitly (note §3). |
| 2.1 | Heuristic traditions such as traditional navigation are wrongly excluded | **Adopted in part.** They are not excluded: the definition does not require formal statistics or written records. The note now says that testing and revision must happen, not that they must be formalized, with this example (note §3). |
| 2.1 | Ordinary generative models and animal expectations are treated as functional | **Disputed.** The note calls them world models, and the scaling table separates having a world model from practising world modelling. No instance was cited. |
| 2.2 | Support-level fit is framed as capturing the main dynamics of learning | **Disputed in part.** The definition is stated in terms of sharpness and calibration, and the note says most learning is a shift of weight over a fixed support. The new warning (P4) makes the limit harder to miss. |
| 2.3 | Provenance is not the only thing that makes re-derivation possible | **Adopted.** The formal result needs kept evidence and assumptions, not "from whom". The note now says kept evidence makes correction possible and provenance makes it practical, by telling the holder which piece to retract (note §5). |
| 2.4 | Hard pooling keeps too much weight; linear pooling can manufacture false consensus | **Adopted in part.** Hard pooling moves to the end of the table, with when it is right: genuine hard constraints (logical consistency, physical limits, verified exclusions), not noisy empirical reports. Averaging uncalibrated or same-origin sources is now named as a way to produce a confident wrong consensus. Calling hard pooling a "pathological edge case" is not adopted: for genuine constraints it is the right rule (note §9). |
| 2.5 | Did not build the Lean | Noted. The assistant built it locally and CI builds it; no independent build yet. |
| 2.6 | Collective claims labelled *Follows* | **Disputed:** no such labels exist (see above). |
| 2.7 | Related work accurate and sufficient | Noted, with low weight (see above). |
| N1 | The formal layer is used to validate claims about institutions | **Adopted.** Section 9 now opens by saying that its theorems bound set operations and simple pooling rules, contain no agents, incentives or institutions, and that its claims about science, public health and human–AI collectives are design principles, not mathematical consequences. |
| N2 | Histories do not capture acting in an open future | **Adopted.** Note §5 now says the formal layer covers retrospective narrowing and re-derivation, and that acting within an open future, where actions change what can happen, and inventing new possibilities are outside it. |
| 5.3, problem 5 | Move the compression hypothesis out of the definitional part | **Adopted.** Section 4 now says only that sharpness is not compression; the author's hypothesis, with what stating it would need, is in section 15 as an open hypothesis. |
| 5.4 | The response to review 1 is fair | Noted. |

## What this means for the core

Review 1 (the stronger review) said NOT READY to the first version. Review 2 (the weaker one) says READY WITH CHANGES to the second, and its changes are adopted where they apply to the text. Neither review is a human reader. Whether that is enough to open the core is the author's call; D34 records the assistant's recommendation.
