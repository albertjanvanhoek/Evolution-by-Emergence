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

## 4. Prospective prediction remains strong

The existing cohort cannot test the central composition law because it contains single BioBricks, not controlled pairs of independently characterized one-way loads.

The prospective prediction is

\[
\boxed{
1-b_{12}=(1-b_1)(1-b_2)
}
\]

or

\[
\boxed{
b_{12}=b_1+b_2-b_1b_2.
}
\]

This differs from the naive additive model

\[
b_{12}=b_1+b_2.
\]

The published data contain moderate-burden constructs that can nominate experimental candidates.

Using a conservative screen:

- burden 18–32%;
- statistically significant burden;
- no GFP-interference flag;
- no significant evidence of non-expression burden in the published capacity-monitor test;

six candidates remain.

Two pairs create particularly clear separation between additive and multiplicative predictions:

### Pair A

\[
K733013:\ b_1=0.1955,
\]

\[
J36335:\ b_2=0.3024.
\]

Predictions:

\[
b_{12}^{\rm additive}=0.4979,
\]

\[
\boxed{
b_{12}^{\rm multiplicative}=0.4388.
}
\]

### Pair B

\[
K733013:\ b_1=0.1955,
\]

\[
K346000:\ b_2=0.2914.
\]

Predictions:

\[
b_{12}^{\rm additive}=0.4869,
\]

\[
\boxed{
b_{12}^{\rm multiplicative}=0.4299.
}
\]

These are **candidate-nomination calculations only**. Construct sequence, mechanism, backbone compatibility, copy number, and absence of direct product interactions must be checked before preregistering a particular pair.

## 5. Interpretation

The retrospective tail analysis is weaker than initially reported.

The prospective test is stronger than the retrospective tail analysis.

The empirical claim should therefore be:

> The published BioBrick system provides measured single-load effects and an externally grounded evolutionary-retention problem. The framework predicts how two separable loads should compose, and that prediction is not contained in the existing data.

If a controlled double-load experiment rejects

\[
1-b_{12}=(1-b_1)(1-b_2),
\]

then the uniform-dilution specialization fails in that system.

If it succeeds prospectively across several independent load pairs, the framework gains a substantially stronger empirical result than any retrospective endpoint fit can provide.
