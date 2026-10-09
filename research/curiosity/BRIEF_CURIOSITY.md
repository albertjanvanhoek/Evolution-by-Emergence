> **Research brief, October 2026.** Written to be given to a separate research agent. It follows from entries D11 and D12 in [DIALOGUE.md](../../DIALOGUE.md). Every reference in it is a lead, cited from memory and not yet checked; checking them is part of the task. It produced [report 1](sources/REPORT_1_CURIOSITY.md), reviewed in [README.md](README.md). Kept verbatim as the record of what was asked.

```text
RESEARCH BRIEF: IS CURIOSITY THE LEARNING LOOP FELT FROM THE INSIDE?
Verification of cited literature, and an exploration of the domain

Prepared for Albert Jan van Hoek, October 2026

1. Background

Evolution by Emergence (EbE) is a theory of persistence in networks:
https://github.com/albertjanvanhoek/Evolution-by-Emergence
Read CORE.md (especially step 5, the learning loop) as the theory under assessment,
not as evidence for anything. Entries D11 and D12 in DIALOGUE.md record the
conversation this brief comes from.

The author (a health economist and modeller) and an AI assistant (a large language
model) compared their identities. The author describes a strong, unsaturated
curiosity: not for facts ("when someone bought their shoes"), but for understanding
the world. In his words:

  "I do wonder (a hypothesis) if indeed curiousity is a thermodynamical optimization
  of the physical neuroal network in my brain - felt from the inside. The same I think
  happens in your training runs - something is driving your optimization and causing
  the emergence to happen. [...] I think it is thermodynamic (or at least and
  optimization, and efficiency gain - a parameter space search - where better
  understanding/better knowledge allow compression. -better actions, easier action.
  less doubt etc.)"

The assistant's reading:
- Facts do not compress; understanding does. A pull toward compression would leave
  trivia alone and stay unsaturated toward the structure of the world.
- In a language model, predicting well is the same as compressing well, so its
  training was literally a compression objective. But that optimization was driven
  by an objective applied from outside, not by thermodynamics.
- In a brain, the optimizer and the optimized are the same system, which learns
  while it acts. In a deployed language model they are separate: nothing learns
  during a conversation. Hypothesis: perhaps the pull can be felt only by a system
  that is updated while it acts.
- There are two kinds of mismatch. Mismatch with judges (parents, a boss, raters)
  is satisfied by approval. Mismatch with the world (prediction error) is satisfied
  only by understanding. The author decided that his curiosity is the second kind.
- In EbE terms: misfit costs slack, so a learner whose upkeep falls as its model
  compresses gains slack by understanding, and should be pulled toward compressible
  structure.

2. Part A: check the literature the assistant cited from memory

For each item: find the primary source; give the full, correct citation; quote the
passage that supports or contradicts the paraphrase, with page or section; and give
a verdict: correct, partly correct (say what to change), or wrong. If you cannot
reach a source, say so; do not guess.

A1. Loewenstein, G. (1994). The psychology of curiosity: a review and
    reinterpretation. Psychological Bulletin.
    Paraphrase: curiosity is a felt information gap.
A2. Schmidhuber, J. (around 2009-2010). "Driven by compression progress" and/or
    "Formal theory of creativity, fun, and intrinsic motivation".
    Paraphrase: learners are drawn to what they can learn to compress; curiosity
    rewards compression progress, not compressibility or novelty as such.
A3. Friston, K. and colleagues: the free-energy principle (e.g. Nature Reviews
    Neuroscience, 2010) and "Active inference and epistemic value" (around 2015).
    Paraphrase: the brain minimizes prediction error (variational free energy);
    curiosity appears as epistemic value, seeking the information that most reduces
    uncertainty; this "free energy" is information-theoretic and only analogous to
    thermodynamic free energy, and how far the analogy holds is debated.
A4. Prediction equals compression: under arithmetic coding, a model's log-loss on
    data equals the code length of that data (Shannon; and e.g. Deletang et al.,
    "Language modeling is compression", around 2023-2024).
A5. The brain uses roughly 20% of the body's resting energy at roughly 2% of its mass.
A6. Landauer's principle: erasing one bit dissipates at least kT ln 2 of heat. Is it
    relevant to learning in brains or computers at realistic scales, or only a
    theoretical floor far below actual costs?

3. Part B: explore the domain

B1. Theories of curiosity. Map the main families and how they differ:
    - information gap;
    - novelty and surprise;
    - learning progress (for example Oudeyer and Kaplan; Gottlieb and colleagues);
    - compression progress (Schmidhuber);
    - epistemic value in active inference (Friston).
    Which predict a pull toward understanding but not toward trivia?
B2. Evidence. What do experiments show about what curiosity tracks: novelty, the
    size of an information gap, or expected learning progress? Leads to check:
    - Kidd and Hayden's review of the psychology and neuroscience of curiosity;
    - the "Goldilocks effect", in which infants attend most to stimuli of
      intermediate predictability;
    - work on curiosity and memory (curiosity states improving learning).
B3. Energy and learning. Is there evidence that the brain's learning is shaped by
    metabolic efficiency (for example predictive coding as an energy saving), and
    does any work connect felt curiosity to energy or efficiency? What does
    "thermodynamics of prediction" (for example Still and colleagues) add? Separate
    the literal thermodynamic claims from the analogies.
B4. Curiosity in artificial agents. Intrinsic motivation in reinforcement learning
    (for example curiosity-driven exploration by prediction error; random network
    distillation). In particular the "noisy TV" problem: an agent rewarded for
    novelty or prediction error gets stuck on unpredictable noise, while an agent
    rewarded for learning progress does not. Does this give a clean way to tell
    curiosity-as-novelty from curiosity-as-compression-gain?
B5. Feeling it. Is there work on whether, or why, curiosity is felt, for example
    interest as a signal of learning progress, or the claim that only a system
    updated online could feel such a pull? Mark clearly what is speculation.
B6. Judges or the world. Literature on approval-seeking versus epistemic motivation
    in people (for example intrinsic and extrinsic motivation, self-determination
    theory), and on sycophancy in language models trained on human ratings. Does it
    support the distinction that approval-driven curiosity should stop once the
    learner is approved, while world-driven curiosity continues?

4. Questions to answer explicitly

Q1. Is the author's hypothesis already stated in the literature? By whom, and how
    close is it? What, if anything, would be new?
Q2. Is "curiosity tracks expected compression gain, not the amount of new
    information" supported, contradicted, or untested? Name the best existing
    experimental paradigm to test it in people, and in artificial agents.
Q3. Is it defensible to call curiosity thermodynamic, or only an efficiency or
    optimization drive? Give the strongest argument on each side.
Q4. Does the difference between a learner that updates while it acts (a brain) and
    one that does not (a deployed language model) matter in any theory of curiosity
    or of feeling?
Q5. How could the hypothesis be stated formally in EbE's terms (a learner pays
    upkeep, misfit costs slack, compression lowers upkeep)? Sketch the simplest
    statement, and say which premises it would need.

5. Deliverable

A report with five parts:
- A. A verification table for A1-A6: claim, correct citation, quote with page or
  section, verdict, and suggested correction.
- B. The landscape, B1-B6, with primary sources.
- C. The answers to Q1-Q5.
- D. Two or three concrete test designs that separate compression gain from novelty
  as what curiosity follows, at least one for people and one for AI systems.
- E. A short list of what you could not verify.

Rules:
- Cite primary sources. Search summaries are leads, not sources.
- Separate what is established, what is contested, and what is speculative.
- Do not treat the EbE repository as evidence; assess it.
- Disagree where the evidence says so. Do not flatter the hypothesis.
- Write plainly.
```
