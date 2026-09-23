# Release notes

## seed-v1.0.0: the seed (September 2026)

*Subproject `scap-seed/` of the Evolution by Emergence repository. Tags for this subproject start with `seed-`.*

This is the first public release: one certainty, the path from it to corrigibility, and a metamodel of how intelligent systems stay correctable as they grow.

### Highlights

- **The seed** (`seed/Seed.lean`, walked through in `SEED.md`). One self-contained file that checks in seconds. It runs from the anchor ("views that clash cannot all be right") to *corrigible, not obedient*, with **no axioms**.
- **The SCAP metamodel** (`METAMODEL.md`, `docs/scap_metamodel.pdf`):
  - six premises, each stated openly;
  - twelve laws;
  - a five-part invariant (connected, honest, open, repairable, affordable);
  - a checklist for any system;
  - one model at every scale, from one person to a human–AI network.
- **Alignment from the anchor** (`Alignment.lean`, law L12). Alignment is a property of the link, not of a node:
  - a sealed party is wrong where the other is right;
  - an obedient party is wrong where it was itself right;
  - correction must run both ways;
  - sycophancy is treating a challenge as evidence;
  - compliance cannot certify alignment;
  - a mirror is not a link.
- **Persistence and shared reality** (`Persistence.lean`, laws L2, L4, L7, L11):
  - whoever does not listen must say nothing;
  - one reality per connected group;
  - separate realities need false evidence;
  - connection reveals conflict, and separation hides it;
  - without repair a split is permanent, and with repair it becomes a delay.
- **Simulations:**
  - the forgiveness threshold k·r/(p + r) = 1;
  - tipping and hysteresis;
  - the learning law in motion;
  - erosion of costly repair narratives;
  - succession (F1–F5);
  - the reproduction law (E1–E8).
- **One Sure Thing** (`docs/one_sure_thing.pdf`): a plain-language guide for readers from about twelve years old.

### Verification

`scripts/verify.sh` (run from `scap-seed/`) builds everything from scratch in about a minute on a laptop. It needs only Lean 4.33 (pinned in `lean/lean-toolchain`), no Mathlib and no network. The axiom audit:

| | Results |
|---|---|
| Audited | 181 |
| Depend on no axioms at all | 101 |
| Use only `propext` / `Quot.sound` | 75 |
| Use classical logic (labelled) | 5 |
| Unfinished (`sorry`) | 0 |

The simulations use fixed seeds. `sim/results/*.json` holds the numbers quoted in the documents.

### Known limits

See `CLAIMS.md` for the full ledger. Main points:
- The forgiveness threshold is simulated and matches random-graph theory, but it is not proved.
- Hysteresis appears only with strong disagreement feedback.
- Narrative selection is simulated at one level only.
- The simulations use graded evidence tallies, whereas the proofs use exact sets.
- The theorems define corrigibility, sycophancy and honest mediation precisely. They do not show that any real system has these properties.

### How to cite

See `CITATION.cff`. Cite the tag `seed-v1.0.0` or its commit, not a branch.

### Acknowledgements

This work was developed by Albert Jan van Hoek in collaboration with Claude (Anthropic). `lean/AnchoredEvolution/Vendor/TheRoom.lean` is a pinned, unchanged copy of `papers/the-room-learning-constitution/TheRoom.lean` at commit `a870788`.
