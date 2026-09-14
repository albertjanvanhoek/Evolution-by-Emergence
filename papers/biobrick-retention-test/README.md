# BioBrick empirical retention test

This directory builds the empirical bridge from the resource-retention theorem to a prospective synthetic-biology experiment.

## Core prediction

The theory maps fractional growth burden \(b\) to the one-way load variable

\[
\kappa=\frac{b}{1-b}.
\]

For two separable one-way loads,

\[
\boxed{
1-b_{12}=(1-b_1)(1-b_2).
}
\]

This is experimentally distinguishable from additive burden.

## Existing data

Radde et al. (Nature Communications 2024, DOI 10.1038/s41467-024-50639-9) published burden measurements for exactly 301 BioBricks plus five BFP controls.

The analysis script downloads Supplementary Data 3 directly, asserts the exact 301+5 cohort, transforms burden to \(\kappa\), performs an exploratory threshold analysis on the \(\kappa\) tail, and nominates moderate-load constructs for a prospective test.

## Interpretive firewall

The exploratory upper endpoint is **not** called an intrinsic \(M^0(E. coli)\).

The observed constructability boundary depends on mutation supply, scale, duration, and protocol. Any inferred retention margin is therefore protocol specific:

\[
M_{\rm ret}(\mu,T,N,p_\star,\text{protocol}).
\]

The existing dataset is used to generate hypotheses and choose constructs. The decisive test is prospective: predict the double-load growth rate from the two single-load measurements before observing the double-load outcome.

See PREREGISTRATION.md.
