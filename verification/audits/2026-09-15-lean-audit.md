# Independent Lean audit — 15 September 2026

> Preserved audit record. This report was produced independently against repository commit `f06f77e`. It is retained verbatim in substance as part of the repository's verification history.

## Audit — the four Lean formalization projects

`formalization/{affinity-layer, collective-alignment, cumulative-accessibility, persistence-drift}`  
Evolution-by-Emergence, cloned at `f06f77e`.

**Headline: no defects found.** All nine files build, every declaration is axiom-clean, every
exact witness is genuine and independently reproduces, and no theorem is vacuous. The items
below are three hypotheses that make theorems weaker than they need to be, and four
consistency recommendations.

---

## 1. Build and axiom audit

I could not use the files as written — all nine `import Mathlib` wholesale, and my local
Mathlib is a 1,979-module subset with no root. I built a synthetic root over the subset,
added the two modules the files needed (`Algebra.BigOperators.Field`,
`Analysis.SpecialFunctions.Exp`, 140 s), and compiled each file with that root substituted
for `import Mathlib`. Nothing else was changed.

| File | Result | Declarations audited |
|---|---|---|
| `AffinityLayer.lean` | PASS | 14 |
| `CollectiveAlignment.lean` | PASS | 16 |
| `CumulativeAccessibility.lean` | PASS | 32 |
| `EquilibriumExposure.lean` | PASS | 9 |
| `FunctionalCompetition.lean` | PASS | 29 |
| `FunctionalThresholds.lean` | PASS | 8 |
| `PersistenceDrift.lean` | PASS | 13 |
| `RegulatoryReturn.lean` | PASS | 15 |
| `ReturnPathPrice.lean` | PASS | 10 |

**146 declarations, zero errors, zero `sorry`.** Every one reports
`[propext, Classical.choice, Quot.sound]` — Lean's three standard axioms, nothing else.
A `sorry` sweep over all 14 Lean files in the repository (including
`verification/organizational-depth/`) returns zero.

I also built `MaintenanceDynamics.lean` (10 declarations, clean).
`MaintenanceDynamicsEndToEnd.lean` audited 14 declarations before hitting `MeasureTheory`
and `Real.log`, which are absent from my subset — **that is my limitation, not a defect in
the file.**

---

## 2. Three hypotheses that are not needed

Only three unused hypotheses across 146 declarations. Each means the theorem proved is
slightly *stronger* than the one stated.

**2.1 `FunctionalThresholds.lean:123` — `hphys : lambda2^2 < 2`.**
In `hollowB_strictly_decreases_on_physical_branch`. The docstring says the hypothesis
"keeps the statement inside the region corresponding to `0 ≤ f < 1`" — true as
interpretation, but the proof is a polynomial identity that never uses it. **The
monotonicity holds on all of `λ ≥ 1`, not only the physical branch.** Worth saying so: it is
a stronger result than the paper claims, and a reader who assumes the bound is load-bearing
will underestimate it.

**2.2 `FunctionalCompetition.lean:247` — `hpnn : ∀ i, 0 ≤ p i`.**
In `mean_fitness_strictly_increases`. Subsumed, because the strict version assumes
`0 < variance p r` outright, whereas the non-strict `mean_fitness_nondecreasing` above it
genuinely needs `hpnn` to derive `variance_nonneg`. Keeping it makes the pair read in
parallel; that is a defensible reason to retain it.

**2.3 `RegulatoryReturn.lean:158` — `hd0 : d0 ≠ 0`.**
In `reducedRegulatoryCost_sub_at_stationary`. The identity survives `d0 = 0`: stationarity
then forces `eta * A = 0`, and with Lean's `x / 0 = 0` convention both sides reduce to
`c0 * d`. So the theorem is true without the hypothesis.

**Recommendation.** `verification/organizational-depth` already established the right
convention for exactly this situation — retain the hypothesis for faithfulness to the
paper, add a one-line comment saying why, and suppress the linter:

```lean
-- retained for faithfulness to the paper; the proof does not need it
set_option linter.unusedVariables false in
```

`formalization/` does not use it, so these three emit warnings on every build. Adopting the
convention silences them without weakening any statement.

---

## 3. Witnesses: all genuine, all independently reproduced

The counterexample theorems are the load-bearing content, and they are the part most at risk
of being vacuous. They are not. Every one is closed rational arithmetic discharged by
`norm_num`, so there is no satisfiability question at all. I recomputed each in exact
rational arithmetic:

| Theorem | Claim | Recomputed |
|---|---|---|
| `costCritical_exact_witness` | `costCritical(56/33, 6/5) = 6241/6160` | ✓ |
| `turnover_exact_witness` | margins `97/99` at `a=1`; `53/66` at `a=1/2` and `a=2` | ✓ |
| `turnover_exact_two_sided_failure` | `turnoverLambda(6/5, 1/10) = turnoverLambda(6/5, 10) = 48/121 < 1/2` | ✓ |
| `exact_two_click_witness` | `{A,B} ⊊ {A,B,C} ⊊ {A,B,C,D}` at budget 1 | ✓ |
| `exact_second_click_unavailable_at_baseline` | direct second click yields only `{B}` | ✓ |

Two features worth noting, because they show the constructions are not toys:

- The turnover witness is genuinely two-sided and reciprocal-symmetric: `shape(1/10) = shape(10)`
  exactly, so weak and strong association fail identically. That is `A13`'s falsifiable null
  prediction, and it holds by construction rather than by fitting.
- In the two-click witness, **stage-2 costs rise for A, B and C** (0.471 → 0.896 for A) and D
  still crosses the budget. So it is not the trivial "everything gets cheaper" construction —
  it exhibits a productive step that dilutes the inherited repertoire and expands
  accessibility anyway, which is the interesting case.

**No vacuity anywhere.** No theorem has contradictory hypotheses, and there are no
defined-but-unused witnesses — `directSecondClickCost` looked like one until I found it used
at `CumulativeAccessibility.lean:538`.

**Design strength worth preserving.** `exists_strictCostDominatingStep` exists solely so that
`not_costDominates_scaled` cannot be read as a general impossibility theorem, and its
docstring says so. That is the kind of guard most formalizations omit.

I also checked the models themselves, not just the algebra: `majority3Reliability p = 3p² − 2p³`
is the correct 2-of-3 voting reliability (`3p²(1−p) + p³`), and `majority3_half_threshold` is
exact — the factorization `3p² − 2p³ − ½ = (p − ½)(−2p² + 2p + 1)` with the quadratic strictly
positive on `[0,1]`.

---

## 4. Four consistency recommendations

**4.1 No paper-to-declaration mapping.** Of 283 declarations across the repository, the six
papers reference exactly **one** by name. A reader cannot tell which Lean theorem backs which
claim. The `organizational-depth` appendix already solves this with an explicit A.1–A.7 →
declaration table; the same table per paper would make the "machine checked" status column
checkable rather than assertable.

**4.2 Ledger terminology is inconsistent.** Five ledgers say "machine checked";
`sufficient-alignment` says "Lean checked" (6 claims). Since the status column is the corpus's
epistemic apparatus — and it is used well, distinguishing "Exact theorem; machine checked"
from "Framework observation" and "Interpretation; conditional" — it should use one phrase.
Across the six ledgers: 125 claims, 52 marked machine- or Lean-checked.

**4.3 `import Mathlib` makes independent verification expensive.** Every file in
`formalization/` imports the whole library, so checking any one of them requires a complete
Mathlib build. By contrast `OrganizationalDepth.lean` and `OperationalBridge.lean` use four
and three targeted imports and compiled here in 44 s and 3 s. Narrowing the imports would cut
CI time and let a sceptical reader check a single claim without building all of Mathlib.

**4.4 The four projects are separate Lake packages** with four identical `lean-toolchain` and
`lakefile.toml` files, each pinning Mathlib at `db584cd`. That is fine, but it means four
independent Mathlib checkouts for a reader who wants to verify everything. A single workspace
with four `lean_lib` targets — which `verification/organizational-depth` already does — would
be cheaper.

---

## 5. Correction to my own proofread

In the proofread of *Organizational Depth at Finite Time* I flagged that
`finite_action_of_kinetic_floor` did not exist and that the appendix's description of it was
inverted. **I was wrong on both counts.** I was reading against the file I had delivered, not
against the committed version. The repository's `OrganizationalDepth.lean` has 13 declarations
rather than the 9 I wrote, including `finite_action_of_kinetic_floor`,
`fixed_resolution_count_of_kinetic_floor` and `fixed_resolution_finite_of_kinetic_floor`. The
first takes a variable coefficient `c n` with a floor `cstar ≤ c n`, derives
`cstar * d n ^ 2 ≤ eps n * tau n`, and invokes `finite_action` — exactly as the appendix
describes. Appendix A.5 is accurate; strike item 2.1 of that proofread.

I verified this by compiling the committed version here: 12 declarations, exit 0, standard
axioms only. The other items in that proofread stand, in particular the four dead
cross-references (`Theorem 3.1`, `Theorem 5.1`, `Corollary 6.1`, `Corollary 7.1`), which are
still present in `verification/organizational-depth/appendix/appendix_lean.tex` at lines 50,
60, 69 and 83.

---

## 6. Reproduction

```
lean 4.33.0 ; mathlib db584cd6d46c92f209a44c0f1c829460d327499d   (matches every lakefile pin)
# synthetic root over the locally built subset, then per file:
lake env lean <file>.lean      # with `import Mathlib` -> `import MathlibSubset`
```

`ReturnPathPrice.lean` additionally needs `FunctionalCompetition.olean` on `LEAN_PATH`.
