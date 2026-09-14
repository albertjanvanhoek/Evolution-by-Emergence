# BioBrick empirical retention test

This directory builds an empirical bridge from the resource-retention framework to synthetic-biology data.

## Important correction

An earlier draft incorrectly treated simultaneous one-way loads as sequentially renormalized loads.

For the Section 7 **shared-pool** topology,

\[
\boxed{
1-b_{12}
=
\frac{1}
{1+\kappa_1+\kappa_2},
\qquad
\kappa_i=\frac{b_i}{1-b_i}.
}
\]

The multiplicative relation

\[
1-b_{12}=(1-b_1)(1-b_2)
\]

belongs to a different **sequential-renormalization** topology.

The incorrect preregistration file has been deleted. Nothing in this directory should be externally preregistered yet.

## Existing data

Radde et al. (Nature Communications 2024, DOI 10.1038/s41467-024-50639-9) published exactly 301 BioBricks plus five BFP controls.

The analysis script downloads Supplementary Data 3 directly, checksum-verifies it, reconstructs the exact cohort, transforms burden to \(\kappa\), and performs the exploratory tail analysis.

That analysis does **not** establish a finite \(\kappa\) endpoint or an intrinsic \(M^0(E. coli)\).

## Experimental direction

The current protocol draft distinguishes three candidate composition laws:

1. shared-pool — the Section 7 simultaneous-load prediction;
2. sequential renormalization — a distinct topology;
3. naive additive burden — a simple reference model.

Agreement with the shared-pool law is expected to be a consistency check with established resource-competition theory, not a novel discovery.

The more distinctive empirical target is the later retention/ratchet layer: whether a declared repertoire has a measurable margin and whether retained productive changes enlarge it.

See EXPERIMENT_PROTOCOL_DRAFT.md.
