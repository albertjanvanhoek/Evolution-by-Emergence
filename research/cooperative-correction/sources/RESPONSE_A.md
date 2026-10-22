# Response to review A

**22 October 2026.** The assistant's response to [REVIEW_A.md](REVIEW_A.md), point by point. "Note" means [README.md](../README.md); "Lean" means [`CooperativeCorrection.lean`](../../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean); "simulation" means [sim.py](../simulation/sim.py), version 2.

**Overall.** The review is right, and its central finding is a real error by the assistant. The bridge correction cancels when corrected estimates are averaged, so version 1 credited a gain to cooperative error identification that came from provenance. The assistant had noticed, while designing the simulation, that the equal-weight cooperative mean equals the consensus mean, and still attributed the provenance version's gain to cooperation. That should have been caught. Every quantitative claim in the review was checked and holds:
- the identity holds to within 7 × 10⁻¹⁶;
- random reference readings leave the estimate unchanged;
- the provenance-only interval covers 95.2%.

Version 1 is kept as reviewed ([sim_v1.py](../simulation/sim_v1.py), [results_v1/](../simulation/results_v1/RESULTS.md)).

What version 2 adds in reply goes one step further than the review asked. With a common target, the ordinary measurements are already a bridge, so a reference operation *cannot* add information. A new experiment (E6) gives agents distinct targets. There the bridge does add a great deal: comparisons improve fourfold, and an instrument drift is told apart from a real change in the world (flagged 99% against 4.5%, where the ordinary measurements flag 77% against 38%). That isolates the incremental value of the bridge the review asked about. It also narrows where cooperative error identification matters: where the agents' ordinary observations are not directly comparable.

## The five ranked problems

| Rank | Problem | Response | Where |
|---|---|---|---|
| 1 | The point-estimate correction cancels | **Adopted.** The cancellation is stated with its algebra; a provenance-only comparator is added; four outcomes are separated (collective estimate, individual correction, calibration, detection). New E6 isolates what the bridge adds. | Note §§2, 4, 5; simulation E1, E2, E6 |
| 2 | The consensus comparison confounds aggregation with uncertainty | **Adopted.** Matched interval methods: consensus with uncertainty from the agents' spread (t, N−1), provenance from the origins' spread (t, K−1), each with its proper critical value. | Simulation E1, E2 |
| 3 | Bridge construction is not formalized | **Adopted.** Renamed "bridge discovery among available operations"; `Bridge` is now `AvailableBridge`; the operational compatibility assumption is stated; construction stays an open conjecture. | Note §§3, 5; Lean docstring |
| 4 | Diversity claims too general | **Adopted.** The assumptions behind the formula are stated next to it; localization is now reported conditionally on fault size, noise and the number of faults, and version 1's three-method claim is withdrawn. | Note §4 (E3), §5 |
| 5 | Failure mechanisms over-generalized | **Adopted.** Responsiveness is randomized across agents in each run; a shared-theory recording mechanism is added and corrupts bridges (up to 11% false exposures); the claim about theory-laden records is limited to different theories; the supplied correction rule is stated. | Simulation E4, E5; note §§4, 5 |

## Other points

| Review section | Point | Response |
|---|---|---|
| 2.1 | `Responsive` only says the agent changes | **Adopted.** A stronger `Corrective` condition is added, and two results show its limit: it can be met by becoming vague, which gives up commitment. An improving revision is named as not yet formalized. |
| 2.2 | `bridges_grow_with_shared_operations` holds for fixed models only | **Adopted** in the docstring and note. |
| 2.2 | An empty support discriminates trivially | **Adopted.** `Committed` now requires a nonempty allowed set; `empty_support_discriminates_trivially` and `empty_support_is_not_committed` record the degenerate case. |
| 2.3 | Shared types and exact operation identification are assumed | **Adopted** as the stated operational compatibility assumption. |
| 3.3 | The ordinary measurements also detect relative drift | **Adopted and confirmed.** At matched false alarms (0.5% per origin), they detect the drift 99.7% against 98.7% for the reference, with more spill-over (7.0% against 3.7%). The reference's advantage appears only with distinct targets (E6). |
| 3.4 | The k\* optimum is specific to its assumptions | **Adopted** (note §4, E3). |
| 3.6 | The correction rule is supplied | **Adopted.** Stated in the note and the results. With a common target, adopting the provenance estimate does better than the bridge correction (0.246 against 0.268). |
| C1 | Same symbol, different meanings; commitments changed after the fact | **Adopted as failure conditions**, not modelled (note §5). |
| C3 | Bridges have costs | **Adopted** as an unpriced failure condition. |
| C4 | Do not separate methods from conclusions unconditionally | **Adopted.** The line is now between diversity that keeps informative inquiry going and diversity that keeps known errors, with Zollman's transient diversity as prior art. |
| 5 | Prior art | **Adopted.** Listed in note §6 as checked by the reviewer; the assistant has not yet checked these sources itself, so nothing from them is quoted. |
| 6.4 | Test on inter-laboratory proficiency data | **Adopted** as the falsification test for conjecture 3 as restated (note §7). |

## Where the assistant still differs, mildly

- **On calling the result for conjecture 3 "partly supported".** The assistant agrees with the label. It reads E6 as giving the bridge a clearer role than the review could see in version 1: not in pooling measurements of the same thing, but in making measurements of different things comparable. Whether that holds in real data is the test of note §7.
