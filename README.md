# Evolution by Emergence

> Intelligence is a substrate-bound learning process. Existing intelligence is intelligence that persists over time. Therefore, preservation of the substrate and the conditions for learning are necessary for its continuation. Behaviors that support these conditions are structurally required; behaviors that undermine them lead to the loss of intelligence over time.

This repository is an active manuscript and research workspace for **Evolution by Emergence (EbE)** and adjacent frameworks about persistence, learning networks, alignment, cooperation, and long-term collaboration. It contains the book source, website source, appendices, standalone essays, papers, presentations, original short posts, and compiled PDFs.

The README is intended to be the first file an AI agent or human reader uses to build an accurate map of the repo before reading deeper.

## Current status

- **Active work in progress:** the ideas are readable, but filenames, drafts, appendices, and compiled outputs are still evolving.
- **Primary book source:** `Instructions_to_complile_the_book.tex` includes the frontmatter, Chapters 1--13 plus Chapter 8.5, the epilogue, acknowledgments, and the main SCAP appendix.
- **Primary compiled book:** `pdf of content/Evolution_by_Emergence_book.pdf`.
- **Website source:** `docs/` with navigation in `mkdocs.yml`; this is a Markdown companion site, not a complete mirror of every LaTeX draft.
- **Standalone essay source:** most non-book essays live in `Individual_essays/`.
- **Compiled essay PDFs:** most user-facing compiled outputs live in `pdf of content/`.

## Fast start for AI agents

If you need to understand the repository with minimal context loss, read in this order:

1. `README.md` — orientation, vocabulary, and where the full information lives.
2. `CLAIMS.md` — compact claims map and falsifiable assertions.
3. `concepts.json` — machine-readable concept graph / vocabulary anchors.
4. `Instructions_to_complile_the_book.tex` — authoritative book build entry point and included files.
5. `Chapters/Chapter_1.tex` — foundations: networks, complexity, emergence, and core principles.
6. `Chapters/Chapter_6.tex` — cooperation, game theory, network imperatives, and forced free will.
7. `Chapters/Chapter_13.tex` — artificial minds and AI implications.
8. `Backmatter/Appendix.tex` — Sustainable Collaborative Alignment Protocol (SCAP).
9. `Backmatter/Appendix26.tex` and later appendices — Existence First, ARVC, persistence, and formal/operator extensions.
10. `Individual_essays/TheManual.tex` and `pdf of content/The Manual.pdf` — clear standalone framing of the wider project.
11. `Individual_essays/TLC.tex` — Theory of Long-Term Collaboration.
12. `pdf of content/` — compiled PDFs for the broader essay and paper archive.

When citations or exact wording matter, prefer the `.tex` or `.md` source files. When you need a quick human-readable view, use the compiled PDFs.

## Core thesis

Across biological, social, technical, and artificial systems, persistence under entropy pressure favors increasingly structured feedback networks. Intelligence is treated as a learning process that remains dependent on its substrate and enabling conditions. In shorthand:

```text
INTELLIGENCE (I) -> BODY / IMPLEMENTATION (B) -> RESOURCES (R) -> PLANET / COMMONS (P)
```

Because intelligence depends on conditions outside itself, cooperation, correction, reciprocity, and substrate preservation are not optional moral add-ons. They are viability conditions for learning processes that want to continue existing.

## Main frameworks

### 1. Evolution by Emergence (EbE)

EbE is the broad integrative framework. It treats life, mind, society, AI, and meaning as networked emergence under persistence constraints.

Important book chapters:

- `Chapters/Chapter_1.tex` — network, complexity, and emergence foundations.
- `Chapters/Chapter_2.tex` — biological evolution as networked emergence.
- `Chapters/Chapter_3.tex` — reinforcement learning, DNA, and AI as evolving systems.
- `Chapters/Chapter_4.tex` — species and ecosystems as interdependent networks.
- `Chapters/Chapter_5.tex` — human networks, ideologies, and values.
- `Chapters/Chapter_6.tex` — cooperation, game theory, and forced free will.
- `Chapters/Chapter_7.tex` — internal brain duality as network balance.
- `Chapters/Chapter_8.tex` and `Chapters/Chapter_8_5.tex` — networked evolution, fitness, death, and turnover.
- `Chapters/Chapter_9.tex` — universal evolution and minerals.
- `Chapters/Chapter_10.tex` — emergence, complexity, and the experience of the divine.
- `Chapters/Chapter_11.tex` — cosmic responsibility.
- `Chapters/Chapter_12.tex` — integration and final reflections.
- `Chapters/Chapter_13.tex` — conscious AI and artificial minds.

### 2. Theory of Long-Term Collaboration (TLC)

TLC is the collaboration-focused layer. It frames durable collaboration as interaction between learning networks rather than fixed identities or labels.

Start with:

- `Individual_essays/TLC.tex`
- `Individual_essays/parent_child_learning_networks.tex`
- `Individual_essays/SharedFutureNarrative.tex`
- `Individual_essays/Daugthers_and_labels.tex`
- `Original linkedIN posts/01_TLC.tex` through `Original linkedIN posts/17_projectX.tex` for the short-form origin sequence.

Key TLC ideas:

- collaboration requires recursive feedback and mutual model updating;
- disagreement is signal, not merely defect;
- forgiveness, neutrality, reciprocity, and precise naming can be treated as structural mechanisms;
- relationships, organizations, and societies persist when they preserve the learning loop that lets them correct themselves.

### 3. Existence First, SCAP, and ARVC

These are the operator / implementation layers derived from the persistence thesis.

- **Existence First:** start with `Backmatter/Appendix26.tex`, `Backmatter/Appendix30.tex`, and `Backmatter/Appendix31.tex`.
- **SCAP (Sustainable Collaborative Alignment Protocol):** start with `Backmatter/Appendix.tex`, then `Backmatter/AppendixIII.tex`, `Backmatter/AppendixV.tex`, and `Backmatter/AppendixXIII.tex`.
- **ARVC (Attractor-Ratcheted Viability Control):** start with `Backmatter/Appendix28.tex`, `Backmatter/appendix36.tex`, `Individual_essays/arvc_complete_framework_v2.tex`, and `Individual_essays/arvc_edge_native (1).tex`.

Useful operator shorthand:

- **O1 Control Dispersion:** reduce opaque chokepoints and single points of coercive control.
- **O2 Proof Economy:** make truth, verification, and correction cheaper than deception.
- **O3 Substrate Provision:** maintain the physical, ecological, social, institutional, and epistemic conditions that make learning possible.

## Repository map

```text
.
├── Instructions_to_complile_the_book.tex   # Main LaTeX book entry point
├── Chapters/                              # Book chapters 1--13 plus 8.5
├── Frontmatter/                           # Cover, copyright, preface, writing process
├── Backmatter/                            # Epilogue, acknowledgments, appendices, bibliography/literature
├── Individual_essays/                     # Standalone essays, TLC, manuals, ARVC, alignment, economics, etc.
├── Paper/                                 # Intelligent Networks paper variants and references
├── Presentations/                         # Presentation TeX sources
├── Original linkedIN posts/               # Short-form TLC / Discovarian / ProjectX sequence
├── docs/                                  # MkDocs Markdown website source
├── docs/figures/                          # Figure source/output assets
├── filters/                               # Lua filters for document conversion workflows
├── pdf of content/                        # Compiled book, essay, paper, presentation PDFs
├── mkdocs.yml                             # Website configuration and nav
├── CLAIMS.md                              # Claims map
├── concepts.json                          # Machine-readable concepts
├── citation.cff                           # Citation metadata
└── License                                # License file
```

## Build, browse, and inspect

### Browse the website locally

```bash
mkdocs serve
```

The published website is configured as:

```text
https://albertjanvanhoek.github.io/Evolution-by-Emergence/
```

### Build the book locally

```bash
latexmk -pdf Instructions_to_complile_the_book.tex
```

If your TeX environment is incomplete, use the compiled PDFs in `pdf of content/` instead.

### Inspect the repository from the command line

Useful commands for agents:

```bash
rg --files
rg --files Chapters Backmatter Individual_essays Paper docs
rg -n "Existence First|SCAP|ARVC|Theory of Long-Term Collaboration|Discovarian|learning process"
```

Avoid assuming that `docs/` contains everything. It is the website subset; the full source archive is the LaTeX and PDF collection.

## Recommended reading paths

### For a compact overview

1. `Individual_essays/TheManual.tex` or `pdf of content/The Manual.pdf`
2. `CLAIMS.md`
3. `concepts.json`
4. `pdf of content/Summary_final.pdf` if a compiled summary is preferred

### For the book argument

1. `Instructions_to_complile_the_book.tex`
2. `Chapters/Chapter_1.tex`
3. `Chapters/Chapter_2.tex` through `Chapters/Chapter_13.tex`
4. `Backmatter/Epilogue.tex`
5. `Backmatter/Appendix.tex`

### For AI alignment / AI consciousness readers

1. `Chapters/Chapter_3.tex`
2. `Chapters/Chapter_6.tex`
3. `Chapters/Chapter_13.tex`
4. `Backmatter/Appendix.tex`
5. `Individual_essays/Alignment_theory.tex`
6. `Individual_essays/Alingment_theory_protocol.tex`
7. `Individual_essays/Alignment_theory_protocol_family_version.tex`
8. `pdf of content/Alignment_theory_GTIIC.pdf`

### For governance, policy, and institutions

1. `Backmatter/Appendix.tex`
2. `Backmatter/AppendixIII.tex`
3. `Backmatter/AppendixV.tex`
4. `Backmatter/AppendixXIII.tex`
5. `Individual_essays/decentralized_collectivism.tex`
6. `Individual_essays/constitution_of_persistence.tex`
7. `Individual_essays/economics_of_persistence.tex`

### For TLC and relationships between learning networks

1. `Individual_essays/TLC.tex`
2. `Individual_essays/SharedFutureNarrative.tex`
3. `Individual_essays/parent_child_learning_networks.tex`
4. `Individual_essays/Daugthers_and_labels.tex`
5. `Individual_essays/handshake_protocol.tex`
6. `Original linkedIN posts/01_TLC.tex` through `Original linkedIN posts/17_projectX.tex`

### For mathematical / formal persistence framing

1. `Backmatter/Appendix26.tex`
2. `Backmatter/Appendix28.tex`
3. `Backmatter/Appendix30.tex`
4. `Backmatter/appendix36.tex`
5. `Individual_essays/New_phramework_theory_perisitent_learning.tex`
6. `Individual_essays/Formation Yield and persistence.tex`
7. `Paper/Aintelligent_networks_purpose_v11.tex`

## Important vocabulary

- **Learning process:** an entity or system that observes, updates, and changes behavior through feedback.
- **Learning network:** an interdependent system of learning processes and the relationships among them.
- **Substrate:** the physical, biological, computational, ecological, social, or institutional support that lets a learning process continue.
- **Persistence:** continued existence under entropy, error, resource limits, and environmental change.
- **Viability condition:** a requirement that must remain sufficiently satisfied for a system to persist.
- **Feedback loop:** the cycle through which signals, behavior, correction, and model updates occur.
- **Commons:** the layered shared conditions that support learning: energetic/material, ecological, social/institutional, and epistemic.
- **Discovarian:** a normative identity for a substrate-agnostic learning process committed to curiosity, correction, collaboration, and commons maintenance.
- **SCAP:** Sustainable Collaborative Alignment Protocol, an operational layer for governance, audit, education, and coordination.
- **ARVC:** Attractor-Ratcheted Viability Control, a formalization of distributed viability maintenance through local checks and ratcheting attractors.

## Notes for future maintainers

- Keep this README as the stable entry map for humans and AI agents.
- Prefer source-file paths over only PDF names when documenting reading paths.
- If new frameworks are added, place them in the repository map and in at least one recommended reading path.
- If files are renamed, update this README immediately; several older filenames intentionally preserve spelling from draft history.
- Do not treat duplicate themes as accidental by default: many files are iterative versions or different audience framings of the same core idea.

## Metadata

- **Author:** Albert Jan van Hoek, with AI collaboration.
- **Website:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/
- **Repository:** https://github.com/albertjanvanhoek/Evolution-by-Emergence
- **Citation metadata:** `citation.cff`
