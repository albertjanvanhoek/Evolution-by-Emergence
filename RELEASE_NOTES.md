# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.1**

v22.1 makes the core of Evolution by Emergence findable, checkable and reusable from one place. It adds no new universal axiom and removes nothing: the v22.0 universal core, the Cumulative Reproduction Model and the intelligent-system specialization are retained unchanged. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core on one page: `CORE.md`

The repository holds many formal layers built over successive releases. v22.1 states the dynamic they share on one page:

> Organization that pays for itself can spend its surplus trying new combinations of what it already keeps. The combinations that pass the filters are kept, and keeping them changes what can be tried next. When a kept change also makes the organization cheaper to run or better at capturing resources, the surplus grows. That loop is the vortex.

`CORE.md` gives this loop as five laws, each tied to the Lean theorems that prove it:

1. **Ledger** — slack = capture − upkeep; viability, budget ceilings, forced forgetting.
2. **Ratchet** — kept organization changes which routes exist; a kept item counts as cumulative only if it opens more than it costs; kept products become parents for the next round.
3. **Vortex** — a kept change that both raises slack and widens search; recurring turns give open-ended accumulation.
4. **Speed** — opportunity × generate × affordable × validated × retained × gain; rate floors; the search–validation balance; competition among equivalent implementations lowering cost and raising slack.
5. **Network** — transfer versus creation inside the vortex; correctability of networks of models.

It also lists the boundaries shown necessary by countermodels: seed, successors, retention, a widening range of distinctions, and auxiliary support for emergent wholes.

## 2. The formal backbone in one file: `formalization/ebe-core`

`EbECore.lean` adds no mathematics. It imports the 37 results that carry the core from three packages (`cumulative-accessibility`, `anchored-correctability`, `persistence-drift`), prints every statement and audits every axiom set. The new **EbE Core Check** workflow rejects `sorryAx` and pins the count.

The package is usable as a Lean dependency:

```toml
[[require]]
name = "ebe_core"
git = "https://github.com/albertjanvanhoek/Evolution-by-Emergence.git"
rev = "v22.1"
subDir = "formalization/ebe-core"
```

Dependency resolution from a fresh outside project was tested before release: Lake resolves the in-repository path packages and the pinned Mathlib. See [`formalization/ebe-core/README.md`](formalization/ebe-core/README.md).

## 3. Network vortex ledger

`formalization/cumulative-accessibility/CumulativeAccessibility/NetworkVortexLedger.lean` splits the dynamic-vortex slack ledger over the parts of a network and separates **creation** (more uptake from the gradient, less maintenance) from **transfer** (internal flows that sum to zero), using only the existing vortex quantities:

- transfers cancel: the whole's slack and response budget are the sum of part slacks for any pure transfer;
- a transfer moves slack between parts but never changes the size of the vortex;
- transfers decide survival, not size: the whole is viable exactly when some redistribution lets every part cover its own maintenance, and a witness shows a transfer breaking a part while the whole's slack is unchanged;
- creation in any part raises the whole's response budget; a non-viable vortex cannot afford any positive-cost response and has zero ratchet velocity under the velocity-ledger seam.

It is wired into `AuditAll`, the `VerificationSurface` axiom audit and the cumulative-accessibility CI build.

## 4. Front door and metadata

- `README.md`, `FORMAL_THEORY_MAP.md` and `formalization/README.md` point to `CORE.md` and `EbECore.lean` first.
- `persistence-drift/lakefile.toml` exposes `PersistenceDrift` as a library so it can be imported; its default build targets are unchanged.
- `RELEASE_VERSION`, `CITATION.cff` and `.zenodo.json` are synchronized to v22.1; the public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`; Zenodo assigns the exact v22.1 version DOI when this GitHub release is archived.

## 5. Status of the claims

- **Proved:** each result in `EbECore.lean` is a machine-checked implication under the premises stated in its theorem.
- **Packaged, not derived:** the vortex composition theorem joins proved parts; it does not derive that real systems keep producing turns. Application mappings (what counts as capture, upkeep, a filter or a transfer in a domain) are assumptions to be tested.
- **Not claimed:** empirical universality, that any particular system satisfies the premises, or normative conclusions.

## 6. Open work remains open

The visible open problems of v22.0 remain: the reachability–independence trade-off, decoding and trust, total rather than pivotal contribution, the full upkeep/responsibility argument, empirical tests of whether real updates are correction-preserving, numerical identity and continuation, and cross-world-space transition semantics. v22.1 adds one practical test: whether a new reader can reconstruct the theory from `CORE.md` and `EbECore.lean` alone.

The v22.0 release notes remain available at the `v22.0` tag.
