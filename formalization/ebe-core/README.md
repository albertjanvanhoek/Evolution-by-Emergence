# EbE Core — the formal backbone in one file

[`EbECore.lean`](EbECore.lean) collects the machine-checked results that carry the core of Evolution by Emergence, in the order of the eight steps of [`CORE.md`](../../CORE.md):

1. **Existence is paid for from a gradient** — the ledger: viability, ceilings, unaffordable critical mass, forced forgetting.
2. **Existence through connections** — a maintenance cycle keeps its members going; delete the return edge and the node declines; a defector that cannot live alone falls after its partner.
3. **Selection comes free** — under selection on cost, mean cost falls and slack rises.
4. **A changing world requires reconfiguration** — a sealed configuration runs out of reserve; one that follows reliable feedback persists.
5. **The learning loop becomes the vortex** — feedback plus retention, paid opening, second-order clicks, the vortex turn, and its speed.
6. **The commons is the vortex of the whole** — transfer versus creation, the window in which a node and the commons grow together, saturation, living off the interest, the horizon past which not cheating gains more, specialists and collapse, sanctions, a self-regenerating commons and its collapse under capture, the extraction threshold, selection overwhelmed by a bad return path, selected versus sufficient effort, the assembly barrier.
7. **Boundaries** — countermodels showing the vortex can stop.
8. **One domain worked out: intelligence** — the anchor (across people and across one person's lifetime), the learning law for records and evidence, shared reality, correctable networks.

The file adds **no mathematics**. It imports 71 results from four packages in this repository, prints each statement with `#check`, and prints its axioms with `#print axioms`. CI ([`ebe-core-check.yml`](../../.github/workflows/ebe-core-check.yml)) fails if any result stops compiling or depends on `sorry`.

| Source package | Path | Results used |
|---|---|---|
| `cumulative_accessibility_check` | [`formalization/cumulative-accessibility`](../cumulative-accessibility) | ledger, adaptive persistence, paid opening, second-order clicks, the vortex, its speed, the network ledger, the assembly barrier, boundaries |
| `collective_alignment` | [`formalization/collective-alignment`](../collective-alignment) (through cumulative accessibility) | the maintenance cycle and its return edge, selected versus sufficient effort |
| `functional_competition_check` | [`formalization/persistence-drift`](../persistence-drift) | selection on cost, competition raising slack, the extraction threshold, return-path feedback |
| `anchored_evolution` | [`research/anchored-correctability/lean`](../../research/anchored-correctability/lean) | budget ledger and critical mass, the scaffold, and the intelligence domain: anchor, learning law, shared reality, correctable networks |

## Verify locally

Requires [elan](https://github.com/leanprover/elan). The toolchain is pinned to `leanprover/lean4:v4.33.0` and Mathlib to the same revision as the source packages.

```bash
cd formalization/ebe-core
lake update
lake exe cache get        # prebuilt Mathlib; otherwise Mathlib builds from source
lake build EbECore
lake env lean EbECore.lean   # prints the 70 statements and their axioms
```

A correct run prints 70 axiom reports and no `sorryAx`.

## Use it as a dependency

Add this to your project's `lakefile.toml`, pinning `rev` to a release tag or commit:

```toml
[[require]]
name = "ebe_core"
git = "https://github.com/albertjanvanhoek/Evolution-by-Emergence.git"
rev = "v22.2"
subDir = "formalization/ebe-core"
```

Then `import EbECore` gives you every core result, or import a single source module such as `CumulativeAccessibility.DynamicVortex` or `AnchoredEvolution.Composition`. Lake resolves the in-repository path dependencies (cumulative accessibility, anchored correctability, persistence drift, collective alignment, the learning constitution) and Mathlib automatically. Use the same Lean toolchain (`v4.33.0`).

## What the results do and do not establish

Every result is a conditional implication under the premises stated in its theorem. Machine checking does not show that any real system satisfies those premises, that the architecture is empirically universal, or any normative conclusion. The vortex composition theorem joins proved parts; it does not derive that real systems keep producing turns. See the status section of [`CORE.md`](../../CORE.md).

## License

As for the rest of the repository: CC BY 4.0 OR Apache-2.0. See [DUAL-LICENSING.md](../../DUAL-LICENSING.md).
