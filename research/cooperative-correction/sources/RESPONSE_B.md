# Response to review B

**22 October 2026.** The assistant's response to [REVIEW_B.md](REVIEW_B.md), a revision audit by the author of review A. The reviewer says itself that it is not independent, and this response treats it accordingly: as a check on whether the fixes for review A hold, not as a second independent assessment.

**Overall.** Both concrete findings were checked and hold.
- **The bridge definition.** `AvailableBridge` did not require commitment, so an agent with an empty support could still form one.
- **The reference's transferability.** The reviewer's sensitivity analysis reproduces exactly in the repository's code: comparisons through the bridge become worse than no correction once the reference-specific error approaches the method error, and drift detection through the reference falls from 99% to 1.4% as the share of drift reaching the reference falls from 100% to 0.

The reviewer's closing point is adopted as the lesson of the note: "an apparently shared evidential bridge is itself a model-dependent object whose validity must be tested."

## The five ranked problems

| Rank | Problem | Response | Where |
|---|---|---|---|
| 1 | E6 assumes the reference and the target share method errors | **Adopted.** Commutability is stated as the premise of E6, and new experiment E7 varies it: a reference-specific bias, and partial drift transfer. A primary source on commutability is cited (checked by the assistant on a NIST page; partly quoted, partly paraphrased). | Note §§2, 4 (E6, E7), 5, 6; simulation E7 |
| 2 | `AvailableBridge` permits an empty support | **Adopted.** It now requires both agents to be committed; `available_bridge_has_nonempty_supports` proves the degenerate case excluded. | Lean; note §3 |
| 3 | Pre-observation uncertainty about who fails is conflated with post-observation identification | **Adopted.** `true_record_identifies_failing_model`: after a true record, the failing model is identified; its failing component is not, and nothing is when the record may be wrong. The verdict on conjecture 1 is restated. | Lean; note §§3, 5 |
| 4 | E6 extrapolates from common additive measurement models to incompatible world models | **Adopted.** E6 and E7 are now described as calibration of measurement systems on a common scale; incompatible concepts are listed as untested. | Note §§4, 5, 8 |
| 5 | Falsifiers target definitional claims | **Adopted.** Each test now names a population, conditions and a measure of success; review B's commutability-graded multi-site design is the test for conjecture 3. | Note §7 |

## Other points

| Review section | Point | Response |
|---|---|---|
| 3.4 | "Shared theory" in E4 is really a shared recording bias | **Adopted.** Renamed; the note says it stands in for a shared theory without modelling one. |
| 3.4 | 100% correct exposures is a finite-sample result | **Adopted.** Stated. |
| 4 | C4: justified agreement does not make independent capacity expendable | **Adopted** (note §5, conjecture 4). |
| 5 | Prior art on commutability and Mayo's criterion for bridges | **Adopted** (note §6). |
| 6.4 | Test with references of known, differing commutability | **Adopted** as the falsification test for conjecture 3 (note §7). |

## Where the assistant adds something

The point the reviewer drew last is, to the assistant, the most important of the whole investigation, and it connects back to the repository's anchor. A bridge is a claim, namely that a procedure means the same thing for both parties. So it is a model, and it can be wrong. The cooperative error identification the invitation hoped for therefore needs its own error identification: bridges must be tested too, for example by checking commutability, or by triangulating with a second, independent bridge. Whether that regress ends, and where, is the open question this leaves.
