# Literature positioning

This note separates established antecedents from the paper's narrower contribution.

## Environmental-feedback evolutionary games are established

Weitz et al. (2016) introduced a replicator-environment framework capable of producing an oscillating tragedy of the commons.

DOI: 10.1073/pnas.1604096113

Tilman, Plotkin & Akçay (2020) generalized evolutionary games with environmental feedback and characterized multiple dynamical regimes.

DOI: 10.1038/s41467-020-14531-6

Ito & Yamamichi (2024) provided a broader classification of feedback-evolving games and showed bistability and persistent oscillation across several game structures.

DOI: 10.1093/pnasnexus/pgae455

**Novelty consequence:** the manuscript must not claim that strategy-environment feedback, oscillatory commons dynamics, bistability, or persistent oscillation are new.

## Regulation as internal control is established

Bich et al. (2016) describe biological regulation as control exerted from within an organized system over processes that maintain it.

DOI: 10.1007/s10539-015-9497-8

The present paper uses a much narrower dynamical model.

## Prevention paradox is an analogy

Rose (1981, 1985) motivates the intuition that successful prevention can make the prevented burden less visible and that individual observation can fail to reveal population-level causes.

DOIs:
- 10.1136/bmj.282.6279.1847
- 10.1093/ije/14.1.32

The manuscript uses this only as an analogy for successful maintenance hiding its own necessity. It does not identify Rose's prevention paradox with the maintenance ODE.

## Narrow contribution

The specific conjunction proposed here is:

1. distinguish retained stock \(K\) from lagged visible state \(h\);
2. define replacement imbalance \(D=\delta K-ax=-\dot K\);
3. let behavior respond directly to \(D\) with gain \(\gamma\);
4. derive the exact characteristic polynomial and stability threshold;
5. derive exact periodic-average balance and zero mean debt in the base system;
6. machine-check the model-specific chain from nonlinear flow through Jacobian and characteristic roots.

The exact threshold is
\[
\gamma_{\rm crit}
=
\frac{
\frac12(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon)-\delta
}{ab}.
\]

A conservative novelty sentence is:

> The paper introduces a minimal internal-stock distinction between visible condition and current replacement balance, derives an exact debt-response threshold for the Hurwitz stability of the resulting three-state maintenance model, and machine-checks the model-specific derivation from nonlinear flow to characteristic-root location and periodic-average accounting.

## Formal verification

Lean 4 is described by de Moura & Ullrich (2021), DOI 10.1007/978-3-030-79876-5_37.

Mathlib is described by The mathlib Community (2020), DOI 10.1145/3372885.3373824.

The formalization contribution is not a new theorem prover or verification method. Its value is to remove algebraic and transcription seams in the model-specific argument.
