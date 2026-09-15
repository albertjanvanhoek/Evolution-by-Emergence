# Reproducibility

## Lean

The machine-checked algebraic core is in:

    formalization/collective-alignment/CollectiveAlignment.lean

Run:

    cd formalization/collective-alignment
    lake update
    lake exe cache get
    lake build

The file checks:

- deterministic signal-garbling policy lifting;
- 2-out-of-3 reliability monotonicity;
- the exact half-threshold;
- redundancy gain above \(p=1/2\);
- the quadratic selected-alignment global optimum and exact (2v\ge c) sufficiency boundary;
- protocol reproduction monotonicity and exact scalar threshold;
- expected carrier growth/decline around \(R=1\);
- weak and strict repair boundaries.

The formalization deliberately does not re-prove the general stochastic Blackwell theorem, general \(k\)-out-of-\(n\) reliability theory, the Galton-Watson extinction theorem, or repeated-game forgiveness results.

## Numerical verification

Run:

    python papers/sufficient-alignment/verify_alignment.py

The script evaluates the 2-out-of-3 reliability curve, verifies the threshold numerically, checks protocol reproduction examples, and checks the repair boundary.

## Epistemic boundary

Lean verifies mathematical consequences of the stated toy-model assumptions. It does not establish that honesty, forgiveness, reciprocity, or SCAP are universal moral requirements, nor that a given real network is correctly represented by these models.


## Verified proof state

The complete theorem stack was verified at commit:

`7e8ff46ad629eee19e712365baa80c29ae8deea6`

GitHub Actions workflow run:

`34943940789`

Lean job:

`104298814659`

That run passed `lake build`. The `#print axioms` audit reported only the standard Lean/Mathlib dependencies

`propext`, `Classical.choice`, and `Quot.sound`

for the reported declarations, with no `sorryAx`.

Subsequent commits on the branch modify repository routing/workflow documentation only unless explicitly stated otherwise.
