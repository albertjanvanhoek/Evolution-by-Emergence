# EbE Core — the formal backbone in one file

[`EbECore.lean`](EbECore.lean) collects the machine-checked results that carry the core dynamic of Evolution by Emergence, in the order of [`CORE.md`](../../CORE.md):

0. **Persistence first** — the premise and its two consequences: given substrate dependence and reciprocity, persistence requires correctability; in an open-ended world, persistence requires the vortex to keep turning.
1. **Ledger** — staying alive: slack = capture − upkeep; viability, ceilings, forced forgetting.
2. **Ratchet** — accumulation: kept organization changes which routes exist; paid opening; second-order clicks.
3. **Vortex** — feedback: a kept change that both raises slack and widens search.
4. **Speed** — the ratchet-velocity ledger, rate floors, the search–validation balance, competition lowering cost.
5. **Network** — transfer versus creation inside the vortex; correctability of networks of models.

plus the **boundaries** (countermodels) showing which premises cannot be dropped.

The file adds **no mathematics**. It imports 44 results from three packages in this repository, prints each statement with `#check`, and prints its axioms with `#print axioms`. CI ([`ebe-core-check.yml`](../../.github/workflows/ebe-core-check.yml)) fails if any result stops compiling or depends on `sorry`.

| Source package | Path | Results used |
|---|---|---|
| `cumulative_accessibility_check` | [`formalization/cumulative-accessibility`](../cumulative-accessibility) | persistence requires the vortex, ledger, ratchet, vortex, speed, network ledger, boundaries |
| `anchored_evolution` | [`research/anchored-correctability/lean`](../../research/anchored-correctability/lean) | persistence requires correctability, budget ledger, critical mass, anchor, correctable composition, sealing, shared layers |
| `functional_competition_check` | [`formalization/persistence-drift`](../persistence-drift) | competition among equivalent implementations raises slack |

## Verify locally

Requires [elan](https://github.com/leanprover/elan). The toolchain is pinned to `leanprover/lean4:v4.33.0` and Mathlib to the same revision as the source packages.

```bash
cd formalization/ebe-core
lake update
lake exe cache get        # prebuilt Mathlib; otherwise Mathlib builds from source
lake build EbECore
lake env lean EbECore.lean   # prints the 44 statements and their axioms
```

A correct run prints 44 axiom reports and no `sorryAx`.

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
