# Experimental protocol draft — NOT preregistered

## Status

**Do not preregister this document yet.**

The previous preregistration file was deleted because it encoded the wrong topology. The Section 7 simultaneous-load model does **not** predict multiplicative composition of retained host fraction.

This document is a corrected design draft for review before any external registration.

## 1. Re-derived topology

For simultaneous one-way loads \(R_i\) produced from the same host pool,

\[
R_i = H\kappa_i,
\]

and total maintained mass satisfies

\[
X^\star
=
H+\sum_i R_i
=
H\left(1+\sum_i\kappa_i\right).
\]

Therefore

\[
\boxed{
H
=
\frac{X^\star}{1+\sum_i\kappa_i}.
}
\]

For a single load with fractional burden \(b_i\),

\[
\kappa_i
=
\frac{b_i}{1-b_i}.
\]

For two **simultaneous shared-pool loads**, the model therefore predicts

\[
\boxed{
1-b_{12}^{\rm shared}
=
\frac{1}{1+\kappa_1+\kappa_2}
}
\]

or

\[
\boxed{
b_{12}^{\rm shared}
=
\frac{\kappa_1+\kappa_2}
{1+\kappa_1+\kappa_2}.
}
\]

In terms of the two single-load burdens,

\[
\boxed{
1-b_{12}^{\rm shared}
=
\frac{(1-b_1)(1-b_2)}
{1-b_1b_2}.
}
\]

## 2. Three hypotheses must be registered

### H1 — shared-pool topology

\[
\boxed{
b_{12}^{\rm shared}
=
\frac{\kappa_1+\kappa_2}
{1+\kappa_1+\kappa_2}.
}
\]

This is the prediction of the Section 7 simultaneous-load topology.

It is structurally consistent with established synthetic-biology resource-competition models in which independent demands add against a shared free-resource pool. Agreement would validate the framework's resource specialization in this system, but would **not** establish a novel resource-competition law.

### H2 — sequential-renormalization topology

If load 2 is defined relative to the already-diluted host after load 1,

\[
\boxed{
1-b_{12}^{\rm seq}
=
(1-b_1)(1-b_2).
}
\]

### H3 — naive additive burden

\[
\boxed{
b_{12}^{\rm add}
=
b_1+b_2.
}
\]

## 3. Example discriminating pairs

For K733013 + J36335:

\[
b_1=0.1955,\qquad b_2=0.3024,
\]

\[
\boxed{b_{12}^{\rm shared}=0.4035},
\qquad
b_{12}^{\rm seq}=0.4388,
\qquad
b_{12}^{\rm add}=0.4979.
\]

For K733013 + K346000:

\[
b_1=0.1955,\qquad b_2=0.2914,
\]

\[
b_{12}^{\rm shared}=0.3955,
\qquad
b_{12}^{\rm seq}=0.4299,
\qquad
b_{12}^{\rm add}=0.4869.
\]

The primary scientific contrast should be shared-pool versus sequential topology.

## 4. Experimental architecture

Use two compatible plasmid backbones so every condition contains the same backbone pair and antibiotic-selection burden.

Core conditions:

1. empty backbone A + empty backbone B;
2. construct 1 in A + empty B;
3. empty A + construct 2 in B;
4. construct 1 in A + construct 2 in B.

Single-load effects used to generate the prediction must be measured in this same two-backbone context.

## 5. Primary endpoint

Measure exponential growth rate under matched culture conditions and normalize to the matched double-empty control:

\[
R_i=\frac{g_i}{g_0}.
\]

The short-term physiological assay should be completed before escape-mutant takeover can materially change the population.

## 6. Primary model comparison

From the two single-load measurements calculate

\[
b_i=1-R_i,
\qquad
\kappa_i=\frac{b_i}{1-b_i}.
\]

Before inspecting the double-load outcome compute all three predictions.

The primary mechanistic contrast is

\[
\boxed{H_{\rm shared}\text{ versus }H_{\rm seq}.}
\]

The additive comparison is secondary.

## 7. Precision requirement

For the nominee pairs above, shared-pool and sequential predictions differ by only about 0.034–0.035.

The development simulation, assuming independent Gaussian burden estimates, suggests approximately:

- SD 0.033: n=24 gives about 94–95% power;
- SD 0.015: n=6 gives about 97–98% power.

These are planning calculations only. Final sample size must be recalculated from pilot variance under the actual protocol and distinguish biological from technical replication.

## 8. Secondary evolutionary-retention experiment

The physiological composition test is separate from evolutionary retention.

The later retention quantity should remain protocol specific:

\[
M_{\rm ret}(\mu,T,N,p_\star,\text{protocol}).
\]

## 9. Interpretation

Agreement with the shared-pool prediction is a **consistency check of the resource layer**, not a novel discovery of shared-resource competition.

The more distinctive empirical questions remain whether a declared repertoire has a measurable retention margin and whether a productive retained step can increase that margin and thereby enlarge future retainable accessibility.
