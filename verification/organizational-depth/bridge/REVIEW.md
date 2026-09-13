# Review of the operational-distance bridge

## Verdict

The core result is sound and materially strengthens the paper:

\[
d_{\rm op}(p,q)\le d_{\rm TV}(p,q)
\]

by data processing, while the Shiraishi--Funo--Saito Markov-jump speed limit is already written in the same total-variation metric. For finite-state Markov jump dynamics this removes the manuscript's abstract metric-comparison assumption.

The model-specific bound is

\[
2d_{\rm op,n}^2\le \Sigma_n\mathcal N_n,
\]

where \(\Sigma_n\) is dimensionless entropy production and \(\mathcal N_n=\int_{I_n}A(t)\,dt\) is expected jump count. Therefore

\[
\sum_n d_{\rm op,n}\le \sqrt{\Sigma_*\mathcal N_*/2}
\]

and fixed-resolution transitions obey the corresponding counting bound.

## Corrections before manuscript integration

1. **Flux indexing in the report.**  With the SFS convention \(W_{ij}\) for the transition \(j\to i\), the directed probability flux is
   \[
   F_{ij}=W_{ij}p_j,
   \]
   not \(p_iW_{ij}\).  Define \(J_{ij}=F_{ij}-F_{ji}\).  The final speed-limit inequality and constants are unchanged; this is a notation/indexing error in the prose derivation.

2. **Do not identify expected jump count with transition duration.**  The report maps \(\tau_n=\mathcal N_n\) when invoking the abstract Cauchy--Schwarz theorem.  Algebraically the same lemma is being reused, but physically \(\mathcal N_n\) is an activity budget, not a duration.  Present
   \[
   2d_{\rm op,n}^2\le\Sigma_n\mathcal N_n
   \]
   as a separate activity--entropy action inequality.  It is structurally analogous to the finite-action theorem but should not rename activity as time.

3. **The transport route is not absolutely 'unbridgeable'.**  There is no universal constant \(\alpha>0\) with
   \[
   W_2\ge\alpha d_{\rm TV}
   \]
   over unrestricted probability measures; the translated-point-mass counterexample proves that.  However, the manuscript already has a valid conditional bridge for a restricted readout class:
   \[
   d_{\rm op}\le L_{\rm readout}W_1\le L_{\rm readout}W_2.
   \]
   The correct statement is therefore: *there is no unconditional global comparison from \(W_2\) to raw TV; transport-based operational control requires additional regularity/readout assumptions.*

4. **Work/entropy wording.**  Keep the primary theorem in \(\Sigma\), where it is clean.  Only write \(W_{\rm diss}=k_BT\Sigma\) when dissipated work is defined in the appropriate isothermal nonequilibrium-free-energy sense and the thermodynamic assumptions are explicit.

5. **Sharpness of \(\alpha=1\).**  Data processing gives the universal constant 1 for every admissible measurement class. Equality is witnessed by the identity channel only when that channel belongs to the allowed class (or when discussing sharpness over unrestricted channels).

## Stronger interpretation for the paper

For an interval with duration \(\tau_n\) and average activity
\[
\bar A_n=\mathcal N_n/\tau_n,
\]
the SFS bound can also be written
\[
\Sigma_n\tau_n\ge \frac{2}{\bar A_n}d_{\rm TV,n}^2.
\]
Isothermally, with \(\varepsilon_n=k_BT\Sigma_n\),
\[
\varepsilon_n\tau_n\ge
\frac{2k_BT}{\bar A_n}d_{\rm op,n}^2.
\]
Thus in this model class the abstract coefficient has a concrete meaning:
\[
c_n=\frac{2k_BT}{\bar A_n}.
\]
Coefficient collapse is therefore explicitly tied to diverging average dynamical activity. This is the cleanest connection between the general theorem and the Markov-jump example.

An even stronger model-specific formulation avoids a per-transition activity ceiling:
\[
2d_{\rm op,n}^2\le \Sigma_n\mathcal N_n,
\qquad
\sum_n d_{\rm op,n}\le\sqrt{\Sigma_*\mathcal N_*/2}.
\]
The remaining question in this class is whether total activity \(\mathcal N_*\) can remain finite as retained organizational depth grows.

## Lean status

The supplied `OperationalBridge.lean` machine-checks the data-processing inequality, sharpness for the identity channel, transfer of a TV speed limit to operational distance, and the fixed-resolution counting bound. The stochastic-thermodynamic speed limit itself remains an explicit hypothesis, which is the correct formalization boundary.
