# Response to review 3

**22 October 2026.** The assistant's response to [REVIEW_3.md](REVIEW_3.md), point by point. "Note" means [WORLD_MODEL.md](../WORLD_MODEL.md); "Lean" means [`WorldModel.lean`](../../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean).

**Overall.** A careful review, and its specific claims about the text were checked and hold. Its verdict is READY WITH CHANGES, with five changes it calls publication-relevant. All five are made, and most of its smaller points too. Its Part 0 answers were recorded before it saw the material and are unchanged in the review ([REVIEW_3_PART0.md](REVIEW_3_PART0.md)). The review did not compile the Lean; the assistant did, locally, and CI builds it.

## The five ranked problems

| Rank | Problem | Response | Where |
|---|---|---|---|
| 1 | Evidential fit is called a support-level special case of sharpness subject to calibration | **Adopted.** Now "a set-theoretic analogue of evidence-relative sharpness", explicitly not a case of calibration; the reason (no distribution, no frequencies, and fit is compatible with biased evidence) is stated. Calibration is now judged over a relevant population, period and use. | Note §§3, 4; Lean docstring |
| 2 | Re-derivation, revision and provenance not cleanly separated; evidence retraction not formalized | **Adopted.** Two new results: `rederiving_with_false_evidence_does_not_recover` (re-derivation is not revision) and `retracting_false_evidence_recovers`, with a new `LiveExcept`. The witness shows a retraction. Constituent 6 now says that keeping the grounds is what correction needs, and that provenance makes it targeted, accountable and cheaper; the inconsistency with section 5 is gone. | Note §§5, 10, 11; Lean |
| 3 | Scope and evaluability underdefined | **Adopted.** The definition is now relative to a stated scope and use; calibration is required where it can meaningfully be assessed, with one-off questions as the case where it cannot; correctability can reside in the maintaining system. The circular wording in §1 is replaced by a reference to the requirements of §3. | Note §§1, 3 |
| 4 | "Expansion" collides with AGM | **Adopted.** Renamed **representational extension**, with an explicit contrast to AGM expansion and the correspondence between the note's operations and AGM's. | Note §5; Lean docstring |
| 5 | Constituent labels inconsistent | **Adopted.** Every row now has one principal label and its other claims labelled separately. A fourth label, *Stipulated*, marks parts of the definition, since the three labels of the creed had no place for them. Practices are now *Proposed*. | Note §10 |

## Other points

| Review section | Point | Response |
|---|---|---|
| 2.1 | The thermostat example is weak: it may not be a world model at all | **Adopted.** The example is now a hard-coded planning script that represents its environment but cannot be revised; the thermostat is mentioned as the weaker case. |
| 2.2 | Calibration has several forms; subgroups matter | **Adopted** (note §3). |
| 2.4 | Product pooling can leave no distribution | **Adopted** (note §9 table; Lean docstring). |
| 2.4 | Condorcet assumptions are not typical | **Adopted** (note §9 table). |
| 2.4 | A provenance record is not a pooling rule | **Adopted** (note §9 table). |
| 2.4 | Record, consensus belief and decision are three products | **Adopted.** New paragraph in note §9. |
| 2.4 | "A robust rule cannot recover what nobody passed on" too absolute | **Adopted.** Now: what is absent from every accessible input and cannot be inferred from them; aggregators can bring background knowledge, derive consequences or look. |
| 2.4 | Hard constraints must be reliable and jointly satisfiable | **Adopted** (note §9 table). |
| 2.5 | Evidence premises cover the whole stream | **Adopted.** All five theorems now assume only `∀ i, i < n → E i a`. |
| 2.5 | `rederive` does not represent provenance | **Adopted.** Stated in note §§5, 11 and the Lean docstring: the recovery results assume that the grounds were kept. |
| 2.5 | Scores, not credences | **Adopted.** `linearPool` and `productPool` are described as acting on nonnegative unnormalized scores that do not enforce the probability axioms. |
| 2.5 | Witness documentation describes three sources | **Adopted.** Corrected to two. |
| 2.7 | Neyman and Roughgarden's full title; position among belief revision, forecast aggregation and social epistemology; collective epistemic infrastructure | **Adopted.** Full title given; a paragraph "Where this sits" added to note §12. |
| 4.6 | Version naming | **Adopted.** The note now calls itself the third version. |
| 5.1 | Underdeveloped: semantic interoperability, integration versus aggregation, versioning, blind spots, systematic suppression, causal adequacy | **Adopted as limits.** A paragraph "Aggregating is not integrating" in note §9, crediting the reader's blind answer, and a list of what is underdeveloped in note §14. They are not developed further here. |
| 5.4 | RESPONSE_1 overstates "Adopted" in places | **Agreed.** An addendum to [RESPONSE_1.md](RESPONSE_1.md) records which of its "Adopted" were only adopted in part at the time. |

## What remains

- The note is now, by review 3's standard, ready to open the core once these changes are made; whether to do so is the author's call (D34).
- Representational extension, causal structure, and the integration side of collective world models remain outside the formal layer.
- No human reader has seen it yet.
