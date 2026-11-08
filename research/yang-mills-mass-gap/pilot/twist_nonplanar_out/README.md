# Checks for the bounded-range twist note

These outputs accompany [TWIST_NONPLANAR.md](../../TWIST_NONPLANAR.md).
They are finite checks of a written proof, not a numerical proof.

## Deterministic checks

From `research/yang-mills-mass-gap/pilot/`, with NumPy installed:

```sh
OPENBLAS_NUM_THREADS=1 python twist_nonplanar_checks.py
```

The script writes `deterministic_checks.json` here. The saved run used
NumPy 2.3.5 and took 1.13 seconds.

- At N = 16, 64, 256, it checks every displacement up to sup-length 4,
  with one orientation per undirected displacement. It checks the exact
  shell moments and the cubic sine-remainder bound.
- At N = 16, 32, 64, 128, it compares the square-root and full cutoffs on
  the stencil {(1,0), (0,1), (1,1), (2,1), (0,2)} and its negatives.
  Each graph is tested both whole and with deterministic vertex and edge
  deletions. Both cutoffs use the note's linear-moment normalization.
  The full-cutoff comparison is therefore not the paper's exactly
  normalized nearest-neighbour construction.
- At N = 8, 16, it uses all displacements up to sup-length 2, with
  deletions. Directly formed mode currents agree with (B3) within
  3e-15. Direct differences agree with (B11) within 7e-16.
  The family costs are also computed from finite Gram matrices.

The finite samples cannot verify uniform bounds in N. The proof supplies
those bounds. The assertions target sign, normalization and factorization
errors.

## Existing Monte Carlo sampler: execution check only

With NumPy and Numba installed, run from `pilot/`:

```sh
python twist_graph.py short 2.0 4 0.1 4 5 100 200 271828
mv twist_graph_short_b2.0_N4_r0.1_l4_s271828.json twist_nonplanar_out/
```

The saved run took about one second after compilation. It had 14 extra
edges and returned f(pi/2) = 20.730, with stored f_err = 0.318.
Only 100 thermalization and 200 measurement sweeps were used per angle,
with five angles. This is an execution check, not a convergence study.

The sampler was left unchanged. Its stored f_err recurrence omits the
shared-angle covariance between adjacent trapezoids; see the note.
Its Python-level seed also does not explicitly seed the random generator
inside the compiled sweep. Do not expect bitwise reproducibility of this
Monte Carlo output from the command alone. The graph construction is
seeded separately. The deterministic companion does not use randomness.
The separate random states are documented in the primary
[Numba reference](https://numba.readthedocs.io/en/stable/reference/numpysupported.html#randomstate-and-legacy-random-number-generation),
checked on 7 November 2026.
