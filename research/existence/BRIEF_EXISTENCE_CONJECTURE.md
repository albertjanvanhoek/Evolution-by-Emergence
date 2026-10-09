> **Research brief, October 2026.** Written to be given to separate agents, at the author's request: "prompt an agent to write an existence conjecture". Kept verbatim as the record of what was asked.

```text
RESEARCH BRIEF: AN EXISTENCE CONJECTURE FOR EVOLUTION BY EMERGENCE
State, as one precise and refutable conjecture, what the proven pieces of the theory are instances of

Prepared for Albert Jan van Hoek, October 2026

1. Background

Evolution by Emergence (EbE) is a theory of persistence in networks:
https://github.com/albertjanvanhoek/Evolution-by-Emergence
Read, in this order:
- CORE.md: the eight steps, the table of proved results, what each result says,
  which premises are assumed, what is not yet formal, and the related work;
- formalization/ebe-core/EbECore.lean: the core results, machine-checked in Lean 4;
- the modules outside the core in formalization/cumulative-accessibility/
  CumulativeAccessibility/: CareTransfer, PowerDistribution, CuriosityValue,
  ExitOption, HealthProfile;
- PREDICTIONS.md;
- DIALOGUE.md, especially D7 (values are stated separately), D11 (self-model
  transmission), D12 (curiosity), D14 and D15 (agency that works through its
  possibility);
- the lineage in Backmatter/Appendix26.tex, Appendix30.tex and Appendix31.tex
  ("Existence First"), which states earlier theorems and conjectures in another form.
Treat all of it as the object under assessment, not as evidence. Do not open the
folder experiments/ : it holds test material for future readers.

Each proved result is a conditional implication about a simple model: a ledger in
which a configuration pays upkeep from a gradient; reciprocal dependence; selection;
reconfiguration in a changing world; feedback and retention (the "vortex"); the
commons as the vortex of the whole; care, power and distribution; the value of
exploring; the unused exit. None of them says that anything real persists for these
reasons. The author asks whether the pieces can now be stated together as one
existence conjecture: a general claim about what any finite configuration needs in
order to keep existing, of which the proved results are special cases.

2. The task

C1. Write the conjecture. Give:
    - a short version in plain words, in at most three sentences;
    - a precise version, with every term defined, and each term tied to the
      definition it generalizes in CORE.md or the Lean files;
    - its scope: which systems it is about (physical, living, social, artificial),
      over which horizon, in which kind of environment;
    - its form: necessary conditions, sufficient conditions, or both. Be explicit
      about which, and why. A conjecture that claims necessity across all substrates
      is much stronger than one that claims sufficiency in a model.
C2. Map it to the proofs. For each part of the conjecture, list the proved results
    that are special cases of it, and the assumptions under which they hold. Name
    the parts that no current result covers. Use the "Not yet formal" list in
    CORE.md.
C3. Make it refutable. State, concretely, what observation or counterexample would
    refute it: a system that persists while violating a necessary condition, or one
    that meets the sufficient conditions and fails. If you cannot state a refuting
    case, say so: the conjecture is then not yet scientific, and should be narrowed.
C4. Separate it from what it must not claim:
    - persistence is not goodness: the conjecture says what lasts, not what ought to;
    - it does not supply aims or values (D7, D11);
    - it does not explain why a commitment is felt as one's own (D15);
    - it should not restate a definition as if it were a finding (for example,
      "what persists is what pays its upkeep" is true by definition in the ledger).
C5. Place it in the literature. Compare it with its nearest neighbours, and say what
    it adds, if anything, and where it is only a restatement:
    - viability theory (Aubin);
    - autopoiesis (Maturana and Varela);
    - dissipative structures (Prigogine);
    - requisite variety and the good-regulator theorem (Ashby; Conant and Ashby);
    - the free-energy principle (Friston);
    - the adjacent possible (Kauffman);
    - Ostrom's design principles;
    - the "Existence First" appendices in the repository.
    These are leads from the repository's own related-work list; check them against
    primary sources, with citations and short located quotations.
C6. Sketch a formal statement. Write the conjecture as a Lean 4 statement (core Lean,
    no Mathlib if possible) that uses or generalizes the existing definitions, marked
    clearly as a conjecture: a `def` of the proposition, not a `theorem`, and no
    `sorry`. Say which existing theorems would be its special cases, and what the
    first provable step towards it would be.

3. Deliverable

A report with:
- Part 1: the conjecture (C1), short and precise.
- Part 2: the map to the proofs, and the gaps (C2).
- Part 3: what would refute it (C3), and what it does not claim (C4).
- Part 4: the literature, with what is new and what is restatement (C5).
- Part 5: the Lean sketch and the first provable step (C6).
- Part 6: your assessment. Is the theory ready for such a conjecture, or should it
  first close particular gaps? Which narrower conjecture would you defend?
- Part 7: what you could not verify.

Rules:
- Cite primary sources. Search summaries are leads, not sources.
- Do not treat the repository as evidence; assess it.
- Prefer a narrower conjecture that can fail to a grand one that cannot.
- Disagree where the evidence says so. Do not flatter the theory or the author.
- Write plainly.
```
