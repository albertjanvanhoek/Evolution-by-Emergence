# Preregistration draft: a two-load test of the retained-load composition law

## Status

This is a prospective experimental protocol. No double-load outcome data have been examined or generated for this test.

The experiment is designed to test the uniform-dilution specialization of the Organizational Accessibility framework in a synthetic-biology system where single-load burden has already been characterized.

## Primary theoretical prediction

Let \(g_0\) be the matched empty-vector host growth rate and define fractional burden

\[
b_i=1-\frac{g_i}{g_0}.
\]

The uniform-dilution model maps burden to load by

\[
\kappa_i=\frac{b_i}{1-b_i}.
\]

For two separable one-way loads, retained productive capacity composes multiplicatively:

\[
\boxed{
\frac{g_{12}}{g_0}
=
\frac{g_1}{g_0}\frac{g_2}{g_0}
}
\]

or equivalently

\[
\boxed{
1-b_{12}
=
(1-b_1)(1-b_2)
}
\]

and

\[
\boxed{
b_{12}
=
b_1+b_2-b_1b_2.
}
\]

The simple additive alternative is

\[
b_{12}=b_1+b_2.
\]

For two 25% single loads, the models predict 43.75% versus 50% combined burden.

## Experimental architecture

Use two compatible plasmid backbones so all conditions contain the same backbone pair and antibiotic-selection burden.

Four core conditions:

1. empty backbone A + empty backbone B;
2. construct 1 in A + empty B;
3. empty A + construct 2 in B;
4. construct 1 in A + construct 2 in B.

The single-load effects used for prediction must therefore be measured in the same two-backbone context as the double-load condition.

## Primary endpoint

Exponential growth rate during matched culture conditions. Normalize all growth rates to the matched double-empty control from the same experimental block.

The physiological test is intentionally short enough that escape-mutant takeover is negligible.

## Primary analysis

For each construct pair, estimate

\[
R_1=g_1/g_0,\qquad
R_2=g_2/g_0.
\]

The multiplicative prediction is generated without fitting to the double-load data:

\[
\widehat R_{12}^{\rm mult}=R_1R_2.
\]

The additive-burden alternative predicts

\[
\widehat R_{12}^{\rm add}
=
R_1+R_2-1.
\]

Compare observed \(R_{12}\) with both precomputed predictions.

The primary confirmatory contrast is

\[
\Delta E
=
|R_{12}-(R_1+R_2-1)|
-
|R_{12}-R_1R_2|.
\]

Positive \(\Delta E\) favors the multiplicative model.

For several construct pairs, use a hierarchical model with experimental block as a random effect and propagate uncertainty in the single-load estimates into the predicted double-load value.

## Construct-pair selection

The published 301-BioBrick cohort is screened only to nominate constructs; no double-load outcomes exist in that dataset.

Preferred single burdens are approximately 20–30%.

Candidate constructs must satisfy, before cloning:

- reproducible positive growth burden in the Radde et al. dataset;
- no GFP-interference flag;
- no significant evidence in the published capacity-monitor analysis that burden is dominated by a non-expression source;
- sequence verified where possible;
- compatibility with the two chosen backbones;
- no known direct interaction between the encoded products.

## Replication

At minimum use independent biological transformants, multiple experimental blocks, and technical wells nested within transformant/block.

Sample size should be determined from pilot variance in normalized log growth rate and the prespecified separation between the two model predictions, before examining double-load outcomes.

## Secondary evolutionary-retention experiment

This is separate from the physiological composition test.

After measuring short-term \(b_1,b_2,b_{12}\), culture the same constructs for a prespecified number \(T\) of generations and measure loss-of-function or escape-mutant takeover.

The retention boundary is protocol dependent:

\[
M_{\rm ret}(\mu,T,N,p_\star,\text{protocol}),
\]

not an intrinsic host constant.

Mutation supply must be measured or controlled. Recommended measurements include mutation or escape rate, plasmid copy number, sequence of evolved escape variants, functional readout of both constructs, and growth rate before and after escape.

## Disconfirmation criteria

The uniform-dilution specialization is disconfirmed for this experimental system if, after prespecified quality control:

1. the double-load growth rate systematically follows the additive or another interaction model better than the multiplicative prediction;
2. residuals depend strongly on construct identity, indicating nonseparable physiological interactions;
3. single-load effects change materially merely because the second empty backbone is present;
4. the same pair gives inconsistent composition across blocks beyond prespecified measurement error.

A failed test rejects the specialization in this system, not the abstract set-theoretic accessibility framework.

## Source dataset

Radde N, Mortensen GA, Bhat D, et al. *Measuring the burden of hundreds of BioBricks defines an evolutionary limit on constructability in synthetic biology.* Nature Communications 15, 6242 (2024). DOI: 10.1038/s41467-024-50639-9.

The exact 301-part cohort is reconstructed directly from Supplementary Data 3, not from internal strain-level IDs in the associated repository.
