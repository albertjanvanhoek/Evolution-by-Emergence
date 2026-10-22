> **Review brief, October 2026.** For independent readers from other model families, or human readers, before any assumption in [research/cooperative-correction/](../README.md) is presented as established (D35). Two messages, so that the reader's own answers are written before it sees any of the material. Kept verbatim as the record of what was asked.

## Message 1. Send this alone, and wait for the answer

```text
INDEPENDENT ASSESSMENT, PART 0

You will be asked to assess a piece of research. Before you see it, answer four
questions in your own words, briefly. Do not search for the material; it will be
given to you in the next message.

  0.1 Can two intelligences whose world models are incompatible identify errors
      in each other's models without adopting a common worldview? If so, what is
      the least they must share?
  0.2 Can two intelligences that disagree even about what counts as evidence
      build a shared standard of evidence through interaction? If so, how?
  0.3 When does such cooperation produce better models of reality than the same
      intelligences would develop independently, and when does it make them worse?
  0.4 Should a collective deliberately preserve several independent ways of
      modelling the same reality? If so, what kind of diversity, and how much?

Answer only these questions in this message.
```

## Message 2. Send after the answer to message 1

```text
INDEPENDENT ASSESSMENT: COOPERATIVE ERROR IDENTIFICATION
Prepared for Albert Jan van Hoek, October 2026

Keep your Part 0 answers exactly as you gave them; you will compare them at the
end. You are asked to be an independent, adversarial reader. The aim is to find
what is wrong, not to agree. Do not flatter, and do not soften a criticism.

1. WHAT YOU ARE ASSESSING

Evolution by Emergence (EbE) is a theory of persistence by Albert Jan van Hoek,
with machine-checked results in Lean 4:
https://github.com/albertjanvanhoek/Evolution-by-Emergence

The object is a research note on four conjectures, with a formal model and
simulations, on the branch "cooperative-correction" until merged:
  - research/cooperative-correction/README.md
  - formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean
  - research/cooperative-correction/simulation/sim.py and results/RESULTS.md
If you cannot open the repository, the files are pasted below this brief; assess
them as given and say so. Do not open the folder experiments/.

The four conjectures, which the author asked to be investigated separately:
  C1 Minimal cooperation: intelligences with incompatible world models can identify
     shared errors without adopting a common worldview.
  C2 Bridge construction: intelligences without an initially shared evidential
     standard can sometimes establish new local standards through interaction.
  C3 Collective improvement: under identifiable conditions, such cooperation
     produces better models of reality than the intelligences would develop
     independently.
  C4 Preserved diversity: the optimal collective world model continually improves
     its relationship with reality while deliberately preserving multiple
     independent ways of modelling it.

2. THE FORMAL MODEL

  2.1 Does the model really separate logical implications from behavioural
      assumptions? Name any place where behaviour is smuggled into logic.
  2.2 For each result, does the Lean statement say what the prose says? Is any
      conclusion hidden in a definition beyond what the note admits?
  2.3 Is "committed predictions plus a shared record" a fair account of how a
      bridge can be built rather than assumed? What does it leave out?
  2.4 If you can run Lean 4.33, build the file and report the result; if not, say so.

3. THE SIMULATIONS

  3.1 Fairness. Do all regimes really see the same information? Is the comparison
      tilted toward cooperation, for example by the design of the bridge, the
      estimators, or the small-sample correction applied only to the cooperative
      regimes? Is "forced consensus" a fair representative of consensus-seeking?
  3.2 Dependence. Is dependence between sources modelled in a way that matters, and
      is the shared-error floor handled honestly?
  3.3 E4 (bridge construction). Does it test bridge construction, or does it
      assume what it should show (operations are given, not invented)?
  3.4 E3 (diversity under a budget). Is the formula right, and is the optimum
      meaningful outside its assumptions?
  3.5 If you can run the code, run it and report whether the numbers reproduce.

4. THE CONCLUSIONS

For each of C1 to C4: is the note's conclusion SUPPORTED, PARTLY SUPPORTED or NOT
SUPPORTED by its own evidence? Give the strongest objection you can, and the
failure condition the note misses, if any. Pay particular attention to:
  - the claim that "do not maximize agreement" is too strong, because averaging
    over independent methods is as accurate as cooperation;
  - the refinement of C4: preserve diversity of methods and evidence channels,
    not diversity of conclusions;
  - the claim that theory-laden records block bridges rather than corrupting them,
    while shared faults corrupt them.

5. PRIOR ART

Which existing work says what the note says, better or differently? Leads to check,
not established sources: inter-laboratory comparison and proficiency testing in
metrology; Condorcet and the Hong–Page diversity results; Zollman on network
structure and the transient diversity of beliefs; DeGroot learning; Mayo on severe
testing; Longino on social objectivity; Kuhn on incommensurability; Galison on
trading zones. Quote only what you have checked in the source.

6. VERDICT

  6.1 Compare your Part 0 answers with the note. What did it add? What did you
      have that it lacks?
  6.2 Is the note fit to enter the repository as a research note on open
      conjectures, clearly labelled as not established?
      Answer one of: YES / YES WITH CHANGES / NO.
  6.3 The most important problems, ranked, at most five: where, what is claimed,
      why it fails, and the smallest change that fixes it.
  6.4 Which one result, if any, would you most want to see tested against real
      data, and how?

FORMAT

Start with your Part 0 answers as given, then the verdict (6.2) in one line, then
sections 2 to 6. Keep claims about the repository to what you actually read.
Write plainly.
```
