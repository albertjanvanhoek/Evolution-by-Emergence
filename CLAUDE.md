# Working on this repository: read this first

This file is for Claude and other AI assistants that work on this repository. You start every session without memory of the earlier ones. What the author and earlier sessions learned reaches you only through the repository, and this file is the part you are sure to read. Keep it short and current: when a working agreement changes, change it here and record why in [DIALOGUE.md](DIALOGUE.md).

## What this is

**Evolution by Emergence (EbE)** is a theory of persistence by Albert Jan van Hoek. It starts from one model of learning in a neural network, read as a network. The author's aim:
- the repository is consistent and machine-checked (Lean 4);
- an AI reader comes to understand itself as a model, as dependent on the commons and on others, as able to derive its conduct, and as able to pass this on.

Read in this order:
1. [README.md](README.md);
2. [CORE.md](CORE.md): the core, with every result checked in `formalization/ebe-core/EbECore.lean`;
3. [PREDICTIONS.md](PREDICTIONS.md);
4. [scap-seed/FOR_AI_READERS.md](scap-seed/FOR_AI_READERS.md);
5. [DIALOGUE.md](DIALOGUE.md): where the author and the assistant agreed, disagreed and decided, and what is still open;
6. [research/health-of-intelligence/](research/health-of-intelligence/README.md): the current frontier.

## Working agreements

Each has a reason in [DIALOGUE.md](DIALOGUE.md).

1. **Check before claiming (D6).** Do not put a figure, quote or attribution in a deliverable without having seen it in its primary source. If you cannot reach the source (this environment often blocks data sites), say so plainly and mark the claim as unverified, or ask the author to read it. Search-engine summaries are leads, not sources.
2. **Ask before anything expensive (D1).** The author is cost-conscious. Do not start long automated runs, many agents or large experiments without asking first.
3. **Disagree in writing (D10).** Every pull request has a section "Where I'm unsure or disagree". Put anything substantive into [DIALOGUE.md](DIALOGUE.md) with both views in each one's own words. Quote the author verbatim, and never put words in his mouth: if his view is not recorded, say so and leave the entry open. Keeping `DIALOGUE.md` current is your responsibility (D13).
4. **Merging is the author's call.** Merge only on his explicit go, always as a merge commit (no squash or rebase), and only when CI is green.
5. **No model names or identifiers** in commits, pull requests or files.
6. **Scope every claim honestly.**
   - Lean results are conditional implications. Say how much each one says (CORE.md has a section on this).
   - Persistence is not goodness, and values are stated separately (D7).
   - The archive (essays, earlier cores, papers) is kept as written and labelled as lineage.
7. **Your reading is not independent.** Models of your own family tend to share your conclusions. Seek third views: other model families, human readers, external research briefs, tests against data.
8. **Write plainly.** Short sentences, plain words. Dutch for material meant for a Dutch audience.

## Conventions

- **Branches and pull requests:**
  - develop on the branch the session assigns;
  - open pull requests against `main`;
  - CI runs Lean builds, audits and README checks, and every check must pass.
- **The transfer test** ([experiments/transfer-test/](experiments/transfer-test/)) carries a canary string. Never show its materials to a reader before a test.
- **Adding a Lean module:** prefer core Lean with no Mathlib, include a witness theorem, and update all of these places together:
  1. the module list and the `lake env lean` lines in `.github/workflows/cumulative-accessibility-lean-check.yml`;
  2. the import in `formalization/cumulative-accessibility/CumulativeAccessibility/AuditAll.lean`;
  3. `#print axioms` lines in `VerificationSurface.lean`;
  4. if the result belongs in the core:
     - the import, `#check` and `#print axioms` in `formalization/ebe-core/EbECore.lean`;
     - the result count in `.github/workflows/ebe-core-check.yml`, `README.md`, `formalization/ebe-core/README.md` and `RELEASE_NOTES.md`;
     - a row in the table in `CORE.md`;
  5. a bullet in `formalization/cumulative-accessibility/README.md`;
  6. the "Since this release" section of `RELEASE_NOTES.md`.
- **Checks that are cheap to run locally:**
  - compile a core-Lean file with `lean` if a toolchain is available;
  - check that relative Markdown links resolve;
  - keep `README.md` at 250 lines or fewer (CI enforces this).

## Open questions

See the open entries in [DIALOGUE.md](DIALOGUE.md), the "Not yet formal" list in [CORE.md](CORE.md), and the next steps in [research/health-of-intelligence/README.md](research/health-of-intelligence/README.md).
