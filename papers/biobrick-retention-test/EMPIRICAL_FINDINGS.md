# Exact-cohort empirical findings

## Source

Radde N, Mortensen GA, Bhat D, et al. *Measuring the burden of hundreds of BioBricks defines an evolutionary limit on constructability in synthetic biology.* Nature Communications 15, 6242 (2024). DOI: 10.1038/s41467-024-50639-9.

The analysis downloads **Supplementary Data 3** from the publisher and verifies the workbook by SHA-256:

    e50996a272f275006ce7961bc3ffc14e2b60ff5d991bd78f553d99da063e221a

The workbook contains exactly:

- 301 published BioBricks;
- 5 BFP burden controls.

This resolves the earlier mismatch from analyzing 330 internal strain IDs in the Barrick repository rather than the final published BioBrick-level cohort.

## 1. Important correction: the published cohort does not support the earlier \(M\approx1\) tail claim

Using the exact 301-part cohort:

- maximum point-estimate burden:
  \[
  b_{\max}=0.516882;
  \]
- maximum transformed load:
  \[
  \kappa_{\max}=1.069887.
  \]
- two BioBricks have point-estimate burden \(>45\%\);
- three have point-estimate burden \(>40\%\).

However, **zero** BioBricks are significantly above either 45% or 50% burden in one-tailed tests at \(p<0.05\), using the published means, SEMs, and replicate counts.

The two point estimates above 45% are:

\[
K523022:\quad b=0.516882,
\]

\[
K733010:\quad b=0.459952.
\]

Their uncertainty is large enough that neither is significantly above 45%.

This reconciles the Supplementary Data 3 point estimates with the article's statement that no BioBrick had burden \(>45\%\) at the stated statistical criterion.

## 2. Reanalysis on the theory's load variable

The uniform-dilution specialization maps burden to

\[
\boxed{
\kappa=\frac{b}{1-b}.
}
\]

Extreme-value fits were therefore repeated on \(\kappa\), not directly on the bounded burden variable \(b\).

Generalized Pareto fits above thresholds corresponding to burden \(0.12\)–\(0.26\) give mostly negative point estimates for the shape parameter at the lower thresholds, but the result is **not statistically secure**.

Representative fits:

| burden threshold | exceedances | \(\hat\xi\) | implied endpoint \(M\) | implied burden endpoint |
|---:|---:|---:|---:|---:|
| 0.12 | 36 | -0.139 | 2.084 | 0.676 |
| 0.15 | 29 | -0.204 | 1.635 | 0.620 |
| 0.18 | 24 | -0.244 | 1.492 | 0.599 |
| 0.20 | 22 | -0.230 | 1.535 | 0.606 |
| 0.22 | 21 | -0.155 | 1.921 | 0.658 |
| 0.25 | 18 | -0.084 | 2.928 | 0.745 |
| 0.26 | 18 | +0.056 | unbounded | unbounded |

For every tested threshold, the nonparametric-bootstrap 95% interval for \(\xi\) includes zero.

Therefore:

\[
\boxed{
\text{the exact published cohort does not establish a finite }\kappa
\text{ endpoint by EVT alone.}
}
\]

The earlier statement that the data measured \(M^0(E.\ coli)\approx1\) should be withdrawn.

## 3. What the existing data do establish

The Barrick study itself supplies a population-genetic constructability boundary whose location depends on mutation rate, culture scale, duration, and failure criterion.

That boundary is naturally interpreted in the present framework as a **protocol-specific retention margin**,

\[
\boxed{
M_{\rm ret}
(\mu,T,N,p_\star,\text{protocol}),
}
\]

not an intrinsic host constant.

A burden range around 45–50% corresponds algebraically to

\[
\kappa
=
\frac{b}{1-b}
\approx
0.82\text{--}1.00.
\]

This is a mapping of the Barrick population-genetic boundary into the framework's load coordinate. It is not an estimate obtained from the empirical tail.

## 4. Correct prospective topology

The earlier draft incorrectly treated two simultaneous one-way loads as sequentially renormalized loads.

For simultaneous shared-pool loads,

\[
R_i=H\kappa_i,
\]

so

\[
X^\star
=
H\left(1+\kappa_1+\kappa_2\right)
\]

and therefore

\[
\boxed{
b_{12}^{\rm shared}
=
\frac{\kappa_1+\kappa_2}
{1+\kappa_1+\kappa_2}.
}
\]

The multiplicative burden relation

\[
1-b_{12}=(1-b_1)(1-b_2)
\]

belongs to a different sequential-renormalization topology.

For the current nominee pair K733013 + J36335,

\[
b_1=0.1955,
\qquad
b_2=0.3024,
\]

the predictions are approximately

\[
\boxed{
b_{12}^{\rm shared}=0.4035,
}
\]

\[
b_{12}^{\rm sequential}=0.4388,
\]

\[
b_{12}^{\rm additive}=0.4979.
\]

For K733013 + K346000,

\[
b_{12}^{\rm shared}=0.3955,
\qquad
b_{12}^{\rm sequential}=0.4299,
\qquad
b_{12}^{\rm additive}=0.4869.
\]

Thus the scientifically interesting experiment is not merely multiplicative versus naive additive burden. It is the harder mechanistic comparison between **shared-pool** and **sequential-renormalization** topologies.

The shared-pool law is already structurally aligned with established synthetic-biology resource-competition theory. Agreement would therefore be a consistency check of the framework's resource layer rather than a new resource-competition discovery.

## 5. Interpretation

The retrospective tail analysis is weaker than initially reported.

The prospective route remains useful, but its purpose is now narrower.

The empirical claim should be:

> The published BioBrick system provides measured single-load effects and an externally grounded evolutionary-retention problem. The framework's simultaneous-load specialization predicts shared-pool composition, while sequential renormalization is a different topology.

A double-load experiment can test whether the chosen implementation behaves as the shared-pool topology assumes. Agreement is a consistency check of the resource layer. The more distinctive empirical target lies downstream: whether a declared repertoire has a measurable retention margin and whether a retained productive change can enlarge that margin and future accessibility.
