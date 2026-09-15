# Independent two-factor re-audit — 15 September 2026

This directory preserves the second-agent re-audit of the Organizational Depth correction as supplied.

The package independently reproduced the finite-rate interior-ring construction, closed the Zhang tightness caveat, showed that the thermodynamic packing-depth factor is itself asymptotically attainable, derived a tighter simplex packing-number upper bound, and supplied an independent Lean formalization.

## Provenance rule

The files in this directory are preserved as the independent audit package, including two small issues found during integration:

1. the supplied `verify.py` described exact snapshot-subinterval testing but used the full-run budget for that particular check and only evaluated the geometric bound exactly for `|S|=2`;
2. the supplied `two_factor_section.tex` says the “second requirement” is impossible for finite `S`, where the geometric packing-capacity condition is the first requirement.

The canonical versions outside this archive correct both issues. The audit originals remain unchanged as provenance.

## Canonical adoption

- `../../PackingDepth.lean` — adopted independent Lean module;
- `../../tightness/` — corrected and expanded analytic/numerical reproducibility package;
- `../../../../Individual_essays/Organizational Depth at Finite Time.tex` — integrated two-factor theorem, improved lattice packing bound, Zhang sharpness result, and figure.

The older stress-test history is also retained under `../../tightness/archive/`.
