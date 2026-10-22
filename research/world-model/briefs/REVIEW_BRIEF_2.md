> **Review brief 2, October 2026.** For a second independent review of the revised note (D34), by a fresh reader: preferably from a model family other than that of review 1, or a human reader. It comes in two messages, so that the reader's own definition is written before it sees any of the material; review 1 could not give a blind baseline because it saw a summary first. The first brief is kept as it was, in [REVIEW_BRIEF.md](REVIEW_BRIEF.md). Kept verbatim as the record of what was asked.

## Message 1. Send this alone, and wait for the answer

```text
INDEPENDENT REVIEW, PART 0

You will be asked to review a definition note. Before you see it, answer three
questions in your own words. Do not search for the material, and do not look up
the repository named later; it will be given to you in the next message.

  0.1 What is a world model? Give a definition in at most five sentences.
  0.2 What does it take to keep a world model good over time? List what is needed.
  0.3 Is there such a thing as a collective world model? If so, what does it take
      to contribute to it well, and to combine contributions well?

Answer only these questions in this message.
```

## Message 2. Send after the answer to message 1

```text
INDEPENDENT REVIEW: WORLD MODELS, AND WHAT MAKES ONE FUNCTIONAL
Prepared for Albert Jan van Hoek, October 2026

Keep your answers to Part 0 exactly as you gave them; you will compare them at the
end. You are asked to be an independent, adversarial reader. Agreement is not the
goal. A review that finds nothing wrong is useful only if you show where you looked.
Do not flatter, and do not soften a criticism to be polite.

1. WHAT YOU ARE REVIEWING

Evolution by Emergence (EbE) is a theory of persistence by Albert Jan van Hoek,
with machine-checked results in Lean 4:
https://github.com/albertjanvanhoek/Evolution-by-Emergence

The object of review is the second version of a definition note and its formal layer:
  - research/world-model/WORLD_MODEL.md
  - formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean
on the branch "world-model-definition" (pull request 141) until merged, then on
"main". If you cannot open the repository, the two files are pasted below this
brief; review them as given and say so.

A first independent review found the first version NOT READY to open the theory's
core. Its five main problems are listed in section 3. Do not read the repository's
response to that review (research/world-model/sources/RESPONSE_1.md) until you have
written your verdict; afterwards you may say whether the response is fair. Do not
open the folder experiments/ : it holds test material for future readers.

The author intends to make this definition the opening of the theory's core in a
major release (v23.0). Your review decides whether it is ready for that.

2. INDEPENDENT REVIEW

  2.1 Definition. The note distinguishes "world model" (descriptive) from
      "functional world model" (the concept it is about), "world modelling" (the
      practice) and "evidential fit" (a formal ideal). Is the distinction sound, and
      is it kept throughout the note, not only where it is introduced? Give cases the
      definition of a functional world model wrongly includes or excludes.
  2.2 Sharpness subject to calibration. Is the note's use of this rule, and of the
      support-level special case, correct? Is anything still overclaimed?
  2.3 Correctability. Are monotone update, revision and expansion distinguished
      correctly? Does the claim that provenance is what makes re-derivation possible
      hold, or is it overstated?
  2.4 The collective world model. Is the table of pooling rules correct? Is the
      lesson, that a collective depends on both contributors and the aggregation rule,
      the right one? Is anything about hard pooling still presented as general?
  2.5 Formal layer. For each result in WorldModel.lean, does the Lean statement say
      what the prose says it says? Is any conclusion hidden in a definition beyond
      what the note admits? If you can run Lean 4.33, build the file and report the
      result; if you cannot, say so and do not claim it.
  2.6 Labels. Each constituent in section 10 is labelled Follows, If or Proposed.
      Name any label that is still wrong.
  2.7 Prior art. Is the related-work section accurate and sufficient? Quote only
      what you have checked in the source.

3. CHECKLIST: THE FIVE PROBLEMS OF THE FIRST REVIEW

For each, answer FIXED, PARTLY FIXED or NOT FIXED, with the reason and, if not
fixed, the smallest change that would fix it.

  P1. One definition was used for a representation, a practice and an ideal set
      equality; static openness was not correctability; empty sets qualified.
  P2. Non-recovery was built into the update rule; retraction can restore an
      excluded possibility; over-sharpness need not exclude the actual world.
  P3. "One over-sharp contributor corrupts the collective" depended on pooling by
      intersection; other rules tolerate a wrong input.
  P4. Set-level sharpness was confused with calibration, with probabilistic
      learning and with compression.
  P5. Claims about simulation replacing real mistakes, about scaling to cells and
      societies, about disagreement leaving only force, and about which constituents
      follow, went beyond the argument.

4. NEW PROBLEMS

Name any problem the revision introduced, or that the first review missed.

5. VERDICT

  5.1 Compare your answers to Part 0 with the note. What did the note add that you
      did not have? What did you have that the note lacks?
  5.2 Is the definition ready to open the core of a major release?
      Answer one of: READY / READY WITH CHANGES / NOT READY.
  5.3 The most important remaining problems, ranked, at most five. For each: where
      it is, what is claimed, why it fails or overreaches, and the smallest change
      that fixes it.
  5.4 After your verdict: is the repository's response to the first review
      (RESPONSE_1.md) fair to that review?

FORMAT

Start with your Part 0 answers as given, then the verdict (5.2) in one line, then
sections 2 to 5. Keep claims about the repository to what you actually read. Write
plainly.
```
