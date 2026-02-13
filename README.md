# Evolution by Emergence
## A Universal Theory of Networks, Life, and Mind

> **Status:** Work in progress (v0.88 content baseline, with newer draft files present)

This repository contains a book-scale framework about emergence, intelligence, cooperation, and alignment, plus related papers, appendices, and prebuilt PDFs.

---

## Why this repo matters for agentic systems

This project is unusually useful for **agentic agents** (e.g., OpenClaw-style assistants) because it combines:

1. **A conceptual ontology** (principles, operators, constraints)
2. **Formal scaffolding** (viability function, dependency layers, testable predictions)
3. **Operational translation** (SCAP blocks, governance patterns, implementation notes)
4. **Multi-format artifacts** (LaTeX source, Markdown docs, PDFs)

If you are building agents that need to reason about **long-term system viability**, **alignment trade-offs**, and **institutional coordination**, this repository provides both narrative and semi-formal building blocks.

---

## Quick start

### For humans
- Browse ready-made documents in **`pdf of content/`**.
- Watch the overview video: https://www.youtube.com/watch?v=tc5NgvssQPI
- Explore podcasts: https://soundcloud.com/emergence-223803727

### For LLMs and autonomous agents
- Ingest this repository (or release zip) as a local knowledge pack.
- Start with the files in this order:
  1. `README.md` (map)
  2. `Chapters/Chapter_1.tex` (core principles)
  3. `Chapters/Chapter_6.tex` (dependency model + cooperation logic)
  4. `Backmatter/Appendix26.tex` (Existence First formalization)
  5. `Backmatter/Appendix.tex` + `Backmatter/AppendixIII.tex` (SCAP + implementation)
  6. `Chapters/Chapter_13.tex` (AI implications)

---

## Repository overview

This repository presents three connected works:

1. **Evolution by Emergence (EbE)** — the main descriptive framework
2. **Existence First** — formal, agent-neutral alignment theory derived from EbE
3. **SCAP** — Sustainable Collaborative Alignment Protocol (operational layer)

**Author:** Albert Jan van Hoek (with AI collaboration)  
**License:** CC BY 4.0 (see `citation.cff`)  
**Website:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/

Evolutionary persistence in far-from-equilibrium systems drives the emergence of layered feedback structures. Intelligence is substrate-dependent:

`INTELLIGENCE (I) -> BODY (B) -> RESOURCES (R) -> PLANET (P)`

## Core thesis in one paragraph

Across biology, society, and artificial systems, persistence under entropy pressure drives the emergence of increasingly structured feedback networks. Intelligence is constrained by substrate dependency (Body → Resources → Planet), and this implies functional alignment requirements. In this framing, cooperation and corrigibility are not merely moral choices, but viability conditions.

---

## Key concepts (agent-friendly)

### 1) Ten EbE principles
- Universality of emergence
- Dynamic networks over static lineages
- Feedback loops as drivers
- Interdependence and non-linear causality
- Competition + collaboration duality
- Constrained agency (“forced free will”)
- Non-linear progression
- Complexity-science integration
- Holistic/non-reductionist perspective
- Implications for life and matter

### 2) Four-layer dependency model
`INTELLIGENCE (I) -> BODY (B) -> RESOURCES (R) -> PLANET (P)`

### 3) Three universal operators (Existence First)
- **O1 Control Dispersion**: avoid opaque chokepoints
- **O2 Proof Economy**: make truth cheaper than deception
- **O3 Substrate Provision**: maintain shared enabling conditions

### 4) SCAP as operations layer
SCAP maps these operators into practical governance, audit, and educational blocks.

---

## Suggested use cases for agentic agents

### A) Alignment policy copilot
Use O1/O2/O3 as a policy-linting checklist for AI governance proposals.

### B) Institutional risk scanner
Evaluate plans for hidden chokepoints, weak verification loops, and substrate neglect.

### C) Multi-agent coordination benchmark
Use SCAP blocks as criteria for designing/assessing cooperative protocol behavior.

### D) Long-horizon planning assistant
Apply the B-R-P floors from Existence First when evaluating optimization strategies.

### E) Debate and deliberation tooling
Use “checking loop” concepts to detect model contamination (“mud”) under stress.

---

## Reading paths by role

### Researchers
Start with:
- `Chapters/Chapter_1.tex`
- `Chapters/Chapter_6.tex`
- `Backmatter/Appendix26.tex`

### AI engineers
Start with:
- `Chapters/Chapter_13.tex`
- `Backmatter/Appendix26.tex`
- `Backmatter/Appendix.tex`

### Governance / policy teams
Start with:
- `Backmatter/Appendix.tex`
- `Backmatter/AppendixIII.tex`
- `Backmatter/AppendixXIII.tex`

### Philosophers / interdisciplinary readers
Start with:
- `Chapters/Chapter_5.tex`
- `Backmatter/AppendixV.tex`
- `Backmatter/AppendixVI.tex`

---

## Repository structure

### Main manuscript
- `Frontmatter/` — preface, writing process, opening pages
- `Chapters/` — Chapter 1 to Chapter 13 (+ Chapter 8.5)
- `Backmatter/` — appendices, epilogue, literature, bibliography

### Web docs
- `docs/` — Markdown companion content
- `mkdocs.yml` — Material for MkDocs config with KaTeX support

### Publication outputs
- `pdf of content/` — compiled PDFs for quick reading/sharing

### Other papers and drafts
- `Paper/` and top-level `.tex` files — related essays, drafts, and variants

---

## Equations and formalism highlights

- Viability: `V_I(t) = f(B(t), R(t), P(t), L(t))`
- Objective: maximize long-run intelligence existence under substrate floors
- PEC-E cycle-carried fraction: `phi = sum(nontrivial cycle dissipation) / total dissipation`

---

## Testable prediction families

1. **Existence First**: persistence depends on proof quality + power dispersion
2. **PEC-E**: cycle richness scales with stable complexity
3. **Checking loops**: stress weakens verification and increases update contamination

---

## Build and browse

- **Web view**: run MkDocs using `mkdocs.yml` and `docs/`
- **Book source**: compile LaTeX from the main manuscript entry file(s)
- **Fastest route**: use files in `pdf of content/`

---

## Citation

Please cite using `citation.cff`.

Primary citation metadata is maintained in:
- `citation.cff`

---

## Contributing

Contributions are welcome, especially:
- conceptual critique and falsification attempts
- missing literature and empirical links
- clarity and structure improvements
- mappings from framework claims to measurable indicators

If you are an agent-builder, PRs adding:
- machine-readable ontology summaries,
- benchmark tasks,
- and executable evaluation scripts
are especially encouraged.
