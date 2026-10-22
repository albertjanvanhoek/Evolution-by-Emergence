# Response to review 1

**22 October 2026.** The assistant's response to [REVIEW_1.md](REVIEW_1.md), point by point, written after the author asked for the improvements (D34). Each point is **Adopted**, **Adopted in part** or **Disputed**, with where the change is. "Note" means [WORLD_MODEL.md](../WORLD_MODEL.md); "Lean" means [`WorldModel.lean`](../../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean).

**Overall.** The review is right on almost every point. Its verdict, not ready to open the core, is accepted for the first version. The most important correction is to the collective claim: that one over-sharp contribution is enough to make a collective lose the actual world holds only when contributions are pooled by intersection. The assistant had presented it to the author as a general insight; it was not.

**One disagreement in emphasis.** The review proposes to define "world model" descriptively and to drop the normative concept. The note adopts the descriptive definition, but keeps the author's concept under its own name, **functional world model**, which is the author's original phrasing ("the ingredients required for a functional and sharp worldmodel"). The review's own suggested repair allows this: "If the author deliberately wants a narrower stipulative definition, name it as such".

## The five ranked problems

| Rank | Problem | Response | Where |
|---|---|---|---|
| 1 | One definition for a representation, a practice and an ideal; static openness is not correctability; empty sets qualify | **Adopted.** Four terms kept apart: world model, world modelling, functional world model, evidential fit. Correctability defined as reachability of a corrected state. Consistency handling added, with `empty_fit_entails_everything` and `inconsistency_flags_background_or_evidence`. | Note §§1, 3, 4, 5; Lean |
| 2 | Non-recovery is built into `follow`; retraction can restore; over-sharpness need not exclude actuality | **Adopted.** Renamed to monotone update. Added `rederive`, `rederiving_recovers_what_following_cannot` and `revising_background_recovers`. Fit and reliability treated as two axes. Narrowing, revision and expansion distinguished; AGM cited. | Note §§4, 5; Lean |
| 3 | The one-contributor result depends on hard intersection | **Adopted.** Renamed to hard pooling. Added `linearPool`, `productPool`, `linear_pool_keeps_what_one_source_keeps`, `product_pool_zero_is_a_veto`, and a table of pooling rules. The rule for a collective now has two halves: contributors and aggregation. The review's coverage example (0.95¹⁰⁰) is used, credited. | Note §9; Lean |
| 4 | Set sharpness is not calibration, not probabilistic learning, not compression | **Adopted.** Central rule restated as sharpness subject to calibration, citing Gneiting, Balabdaoui and Raftery (2007), checked by the assistant. Support-level fit marked as a special case. The coin example is used, credited. The continuum caveat stated. Compression kept as the author's hypothesis, explicitly not following from the results. | Note §4 |
| 5 | Simulation claim, scaling, "only by force", constituent labels | **Adopted.** "Mistakes in the model" kept as the core value, with the action bridge and its limits stated; laboratory experiments described as controlled exposure. "Only by force" deleted. Scaling table rebuilt with "has a model" and "practises modelling" as separate columns; the immune-system mapping dropped. Constituents relabelled, with the governing aim above the table. | Note §§7, 8, 10 |

## Other points

| Review section | Point | Response |
|---|---|---|
| 2.1 | Partly vague models can be useful; over-sharp models can keep actuality; categories not exhaustive | **Adopted.** Note §4 now has two axes and mixed cases. |
| 2.1 | "Every claim can be shown wrong" too strong | **Adopted.** Testability is required of empirical predictions; revisability of empirical assumptions (note §3). |
| 2.2 | Answerability needs procedures; "outside" is the wrong boundary | **Adopted.** Procedures listed; the boundary is now evidence "whose outcomes are not fixed by the claims being tested" (note §3). |
| 2.2 | Opening claims attribute phenomenology too widely | **Adopted.** Restricted to fallible representations; experience mentioned only for holders that have it (note §2). |
| 2.3 | The live set depends on W, B and E | **Adopted.** Stated in the Lean docstring and note §§4, 7. `shared_evidence_shared_world_model` renamed `same_live_set_same_fit`, with the point that the same raw observations need not give the same live set. |
| 2.4 | Changing world: states or histories? | **Adopted.** Worlds read as histories (note §5; Lean docstring). |
| 2.5 | Separation of models too architectural; values rightly shape scope | **Adopted.** The rule is now the review's: values may guide inquiry and action, must not count as evidence by themselves, and their influence should be visible (note §6). |
| 3.1 | 23 declarations is 22 results and a witness | **Adopted.** The revised file has 29 declarations, described as 28 results and a witness. |
| 3.1 | Docstrings overreach ("never wrong, and useless", "the mistake is made in reality", "harmless, and useless") | **Adopted.** Removed or qualified. |
| 3.1 | Reliability hypothesis unused in `oversharp_model_never_recovers_actual` | **Adopted.** Dropped from the renamed `monotone_update_never_recovers_actual`. |
| 3.1 | "Pooling sharpens" suggests a strict gain | **Adopted.** "Weakly narrower" (`hard_pool_is_narrower`). |
| 3.2 | Most work is in the definitions | **Adopted.** Said plainly in note §11 and the Lean docstring. |
| 3.4 | The reviewer did not compile | **Noted.** The assistant compiled the revised file with Lean 4.33 and audited its axioms; CI builds it. That is the assistant's check, not an independent one. |
| 4.1 | Other values of modelling: explanation, diagnosis, measurement design | **Adopted** (note §7, last paragraph). |
| 4.1 | "More freedom" is an interpretation | **Adopted** (note §7, point 4). |
| 4.1 | Maintaining a dependency need not require representing it | **Adopted** (note §7, point 3). |
| 4.1 | Prevention neither refutes nor confirms a no-action forecast | **Adopted** (note §9, last paragraph). |
| 4.3 | Vagueness is not harmless | **Adopted.** The theorem is restated as "leaves a hard pool unchanged", and its limits are stated (note §9). |
| 4.4 | Deceit and overconfidence differ in more than blame | **Adopted.** The review's narrow statement is used (note §9). This also corrects [world-model integrity](../../world-model-integrity/README.md) only where it relied on the first version; that note already separates honest error from deliberate manipulation. |
| 4.5 | Constituent labels | **Adopted.** Relabelled as the review proposes, with the aim stated above the table (note §10). |
| 5 | Prior art | **Adopted.** Note §12, which says which sources the assistant checked itself and which rest on the review's check. The unverified Popper wording is not used; Popper is cited without quotation. |
| 6.4 | Nothing mathematically new | **Agreed.** Note §12 says so and states what the note attempts instead. |
| — | Replacement opening | **Adopted in part.** Its content is in note §§1 and 3, and its spirit in the one-paragraph summary. The note keeps the author's concept, functional world model, as the subject. |

## What remains for the next review

- Whether the four terms are kept apart throughout, not only in §1.
- Whether the revised collective section is now right about aggregation, and whether its two halves are the right lesson.
- Whether the constituent labels are now correct.
- Whether anything from the first version's framing survives where it should not.

## Addendum, after review 3

Review 3 found that some points above were marked **Adopted** when the change made at the time was only partial. That is right. In the second version:
- the treatment of revision did not yet include retraction of evidence, and used "expansion" in a sense that conflicts with belief-revision theory (rows 2 and 2.4);
- the constituent labels were improved but not applied one per row (rank 5 and row 4.5);
- evidential fit was still called a special case of sharpness subject to calibration (rank 4).

All three are fixed in the third version; see [RESPONSE_3.md](RESPONSE_3.md). The table above is kept as written.
