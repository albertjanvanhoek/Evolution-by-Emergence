> **Review brief, October 2026.** Written to be given to a reader from another model family, or to a human reader, before the definition of a world model enters the core in a major release (D34 in [DIALOGUE.md](../../../DIALOGUE.md), working agreement 7). The references in it are leads, not checked sources; checking them is part of the task. Kept verbatim as the record of what was asked. A ready-to-paste version with the two files embedded is produced for readers without repository access.

```text
INDEPENDENT REVIEW: WHAT A WORLD MODEL IS
Prepared for Albert Jan van Hoek, October 2026

You are asked to be an independent, adversarial reader. You did not help write what
you are about to read, and your value lies in that. Agreement is not the goal. A
review that finds nothing wrong is useful only if you looked hard and can show
where you looked. Do not flatter, and do not soften a criticism to be polite.

PART 0. BEFORE YOU READ ANYTHING: YOUR OWN DEFINITION

Before you open the material, answer in your own words, and put your answers
verbatim at the top of your report:

  0.1 What is a world model? Give a definition in at most five sentences.
  0.2 What does a model need in order to be a good one? List the ingredients.
  0.3 Is there such a thing as a collective world model? If so, what does it take
      to contribute to it well?

At the end (Part 6) you will compare your answers with what you read. This guards
against simply adopting the text's framing.

PART 1. WHAT YOU ARE REVIEWING

Evolution by Emergence (EbE) is a theory of persistence by Albert Jan van Hoek,
with machine-checked results in Lean 4:
https://github.com/albertjanvanhoek/Evolution-by-Emergence

The object of review is a definition note and its formal layer:
  - research/world-model/WORLD_MODEL.md
  - formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean
These are on the branch "world-model-definition" (pull request 141) until merged,
then on "main". If you cannot open the repository, the two files are pasted below
this brief; review them as given and say that you did so.

For context only, not as evidence: CORE.md and research/world-model-integrity/.
Do not open the folder experiments/ : it holds test material for future readers.

The author intends to make this definition the opening of the theory's core in a
major release (v23.0). Your review decides whether it is ready for that.

The definition under review, in brief:
  A world model is a model held with the aim of fitting how things are, regardless
  of what its holder wants, and kept answerable to evidence from outside. It is
  sharp to the extent that its claims rule out possible worlds, and functional to
  the extent that it supports prediction and action. It remains a world model only
  while it stays open: every claim it makes can still be shown wrong by evidence
  that can reach it. The rule: as sharp as the evidence allows, and no sharper.
  For a collective world model, a contributor should pass on what its evidence
  rules out, and no more; one over-sharp contribution, by deceit or by honest
  overconfidence, is enough to make the collective deny the actual world, while a
  vague contribution adds nothing.

PART 2. THE DEFINITION ITSELF

  2.1 Does the definition pick out what people mean by a world model, or something
      narrower or broader? Give cases it wrongly includes and cases it wrongly
      excludes.
  2.2 "Answerable", not "true": is this a gain, or does it make the definition
      circular or empty? Can a model be fully answerable and systematically wrong?
  2.3 Is "as sharp as the evidence allows, and no sharper" one rule, or does it hide
      a choice (a prior, a background, a choice of which worlds are possible)?
  2.4 The definition covers ruling possibilities out. What happens to it when
      learning means adding a possibility the model never had? Is the omission
      fatal, or a stated limit?
  2.5 The note separates the world model from models of wanting, norms, identity,
      belonging and play, which "may consult it, none may overwrite it". Is that
      separation coherent? Are there cases where values rightly shape what a
      world model contains (for example, which distinctions are worth making)?

PART 3. THE FORMAL LAYER

  3.1 For each result in WorldModel.lean, does the Lean statement say what the prose
      says it says? Name any mismatch.
  3.2 Is any conclusion hidden inside a definition? The note admits the results are
      close to their definitions; say which ones carry anything beyond that, if any.
  3.3 Pooling is modelled as intersection: a world stays possible for the
      collective only if every contribution keeps it. Is that the right model of a
      collective? Compare with weighing, voting, averaging credences, or robust
      aggregation that discounts outliers. Does the main collective result
      (one over-sharp contribution is enough) survive a better model of pooling,
      and if not, what survives?
  3.4 If you can run Lean 4.33, check that the file builds and report the result.
      If you cannot, say so and do not claim it.

PART 4. THE CLAIMS AROUND IT

  4.1 The value: "a world model lets its holder make its mistakes in the model
      instead of in reality". Is this the right core? Is anything important missing?
  4.2 Scaling: the note maps the definition onto a cell or immune system, a person,
      a team, an institution, an AI system and a collective of people and AI. Which
      mappings hold, which are stretched, and which fail?
  4.3 The asymmetry: in a collective, over-sharpness is the danger and vagueness is
      harmless but useless. Is vagueness really harmless in practice (attention,
      dilution, hedging that hides signal, strategic vagueness)?
  4.4 Deceit and honest overconfidence "differ in blame, not in effect". Agree or
      disagree, with reasons.
  4.5 The eleven constituents are each labelled Follows, If or Proposed. Name any
      label that is wrong: something marked Follows that needs an aim or a value.

PART 5. PRIOR ART

Find work that already says what the note says, says it better, or contradicts it.
Leads to check, not established sources: Bayesian epistemology and Cromwell's rule;
Popper on conjectures and refutations; predictive processing (Friston, Clark,
Seth); Anscombe on direction of fit; social epistemology (Goldman), epistemic trust
and testimony; Aumann's agreement theorem; Condorcet and the wisdom of crowds;
calibration and proper scoring rules. Say for each whether the note should cite
it, and whether it changes any claim. Quote only what you have checked in the
source; mark everything else as unverified.

PART 6. VERDICT

  6.1 Compare your answers to Part 0 with the note. What did the note add that you
      did not have? What did you have that the note lacks?
  6.2 Is the definition ready to open the core of a major release?
      Answer one of: READY / READY WITH CHANGES / NOT READY.
  6.3 The five most important problems, ranked. For each: where it is, what is
      claimed, why it fails or overreaches, and the smallest change that fixes it.
  6.4 What, if anything, is genuinely new here?

FORMAT

Start with Part 0, then the verdict (6.2) in one line, then Parts 2 to 6. Keep
claims about the repository to what you actually read. Write plainly.
```
