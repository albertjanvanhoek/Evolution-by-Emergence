# Tightness and retained packing depth

This directory reproduces the stress test of the fixed-resolution activity--entropy bound and the correction from consecutive transition count to retained packing depth.

Run:

\`\`\`bash
python analytic.py
python simulate.py
python packing.py
\`\`\`

The corrected report is in [TIGHTNESS_REPORT.md](TIGHTNESS_REPORT.md). The original exploratory report is preserved under [archive/](archive/) for provenance.

Key result:

\[
D_\delta(T)\le
\min\left\{
1+\delta^{-1}\sqrt{\Sigma_*\mathcal N_*/2},
\mathcal P_\delta(\mathcal X_T)
\right\}.
\]

The first term is a dynamical path-length/resource bound. The second is a geometric packing-capacity bound. A two-state shuttle and an interior finite-state ring can both asymptotically saturate the SFS transition bound, so saturation itself does not diagnose retained depth.

The finite-prefix resource implication is machine-checked in \`OperationalBridge.lean\` as \`pairwise_depth_resource_bound\`. The finite-dimensional packing-number estimate is standard geometry and is not formalized in Lean here.
