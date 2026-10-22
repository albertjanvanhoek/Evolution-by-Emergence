> **Addendum to the [review brief](REVIEW_BRIEF.md), October 2026,** for conjecture 5, acting under time ([ACTING_UNDER_TIME.md](../ACTING_UNDER_TIME.md)). The brief itself is kept verbatim as the record of what review A was asked. For the next reader, add the block below to each message: block A at the end of message 1 (before "Answer only these questions"), block B at the end of message 2 (before "FORMAT"), and add to the file list in message 2 the files named in block B.

## Block A. Add to message 1

```text
  0.5 An intelligence cannot defer acting until its model of the world is certain,
      and not acting is also an action. Does that end the regress of checking the
      checks (the evidence, the procedure that checks it, and so on)? If so, how,
      and what does it leave open?
```

## Block B. Add to message 2

```text
7. CONJECTURE 5: ACTING UNDER TIME

Added after the first two reviews, at the author's request, as part of the same
problem. Files:
  - research/cooperative-correction/ACTING_UNDER_TIME.md
  - formalization/cumulative-accessibility/CumulativeAccessibility/ActingUnderTime.lean
  - research/cooperative-correction/simulation/sim_time.py and results/RESULTS_TIME.md

  C5 Acting under time: an intelligence cannot defer acting until its world model
     is certain; not acting is also an action; so the regress of checking ends
     locally when the next decision has to be made.

  7.1 The note labels the parts of C5 as following, conditional, or separate
      (values). Is any label wrong? Is a normative conclusion smuggled into what
      is presented as a result about time?
  7.2 The Lean model has two states, two actions, a delay cost and a reversal
      cost. Do the statements say what the prose says? Does
      regress_has_finite_depth answer the regress, or only restate its
      assumptions?
  7.3 E8 and E9. Is the comparison fair: are thresholds tuned and evaluated on
      separate runs, and are the reversible and irreversible cases matched in
      cost? Does "pooled evidence makes waiting worth it" follow from the runs,
      or from the parameters chosen?
  7.4 Is "prevention hides the evidence" handled honestly, including the finding
      that a sentinel channel made decisions checkable afterwards but did not
      lower the loss?
  7.5 Conclusion for C5: SUPPORTED, PARTLY SUPPORTED or NOT SUPPORTED by the
      note's own evidence? The strongest objection, and the failure condition the
      note misses. Prior-art leads to check, not established sources: Howard on
      the value of information; Russell and Wefald on rational metareasoning;
      Arrow and Fisher, and Henry, on irreversibility and option value; POMDPs;
      Pearl on intervention and counterfactuals.
  7.6 Should the definition of a world model in the core say that a functional
      one supports acting under time? Answer yes, no, or not yet, with a reason.
```
