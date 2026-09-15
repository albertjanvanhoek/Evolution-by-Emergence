# Tightness and retained packing depth

This directory reproduces the post-publication/internal stress test of the fixed-resolution activity--entropy bound and the correction from consecutive transition count to retained packing depth.

Run:

```bash
python analytic.py
python simulate.py
python packing.py
```

The corrected report is in [TIGHTNESS_REPORT.md](TIGHTNESS_REPORT.md).

Key result:

[
D_delta(T)le
minleft{
1+delta^{-1}sqrt{Sigma_*mathcal N_*/2},
mathcal P_delta(mathcal X_T)
ight}.
]

The first term is a dynamical path-length/resource bound. The second is a geometric packing-capacity bound. A two-state shuttle and an interior finite-state ring can both asymptotically saturate the SFS transition bound, so saturation itself does not diagnose retained depth.
