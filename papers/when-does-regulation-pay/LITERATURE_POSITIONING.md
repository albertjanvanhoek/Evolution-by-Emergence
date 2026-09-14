# Literature positioning

This note separates established ingredients from the proposed contribution.

## Established ingredients

### Regulation as control from within

Bich et al. (2016) distinguish regulation from constitutive dynamics and describe it as second-order control over the processes that produce and maintain an organism.

DOI: 10.1007/s10539-015-9497-8

### Economy versus effectiveness

Szekely et al. (2013) explicitly analyze biological regulatory systems as a tradeoff between effectiveness and economy, using integral feedback and Pareto optimality. The present paper does not claim that regulatory cost-effectiveness optimization is new.

DOI: 10.1371/journal.pcbi.1003163

### Energetic cost of adaptation

Lan et al. (2012) show that accurate sensory adaptation is dissipative and establish an energy-speed-accuracy tradeoff.

DOI: 10.1038/nphys2276

### Evolutionary tuning of expression and regulation

Dekel & Alon (2005) directly measured protein-expression cost and benefit and observed evolutionary tuning toward predicted optima.

DOI: 10.1038/nature03842

Poelwijk et al. (2011) studied optimality and evolution of transcriptionally regulated expression using experimentally measurable cost-benefit relationships.

DOI: 10.1186/1752-0509-5-128

### Fluctuating environments

Kussell & Leibler (2005) show that stochastic phenotype switching can be favored over sensing when environmental changes are infrequent.

DOI: 10.1126/science.1114383

Geisel (2011) compares constitutive and responsive expression and shows that demand frequency, response rate, and noise affect which strategy is favored.

DOI: 10.1371/journal.pone.0027033

### Loss of regulation

Moran et al. (2005) and Chong et al. (2019) document extensive regulatory-gene loss during *Buchnera* genome reduction.

DOIs: 10.1128/JB.187.12.4229-4237.2005; 10.1093/molbev/msz082

## Proposed contribution

The paper imports a separate object from the companion paper:

\[
M=m-z,
\]

an independently declared functional margin.

This creates two distinct questions:

1. which controller maximizes the declared endogenous objective?
2. which controller is sufficient to keep the declared function inside its boundary?

The linear model gives

\[
k_{\rm opt}
=
\frac{\sqrt{\eta A/c_0}-\gamma}{\beta},
\qquad
k_{\rm func}
=
\max\left\{0,\frac{\eta/m-\gamma}{\beta}\right\},
\]

with

\[
A=\beta L-c_1\gamma.
\]

These need not coincide.

The paper then generalizes the result. For

\[
g(k)=g_0-\Phi(z^*)-C(k)-c_1kz^*,
\]

with the stated convexity and monotonicity assumptions, alignment at the independently declared functional boundary is equivalent to

\[
\boxed{
\beta m^2\Phi'(m)
\ge
\eta C'(k_{\rm func})
+
c_1\gamma m^2.
}
\]

Equivalently, with

\[
\Psi'(m)
=
\Phi'(m)-\frac{c_1\gamma}{\beta},
\]

\[
\boxed{
\beta m^2\Psi'(m)
\ge
\eta C'(k_{\rm func}).
}
\]

The proposed methodological contribution is therefore not a new theory of biological control, nor the discovery that regulation trades cost against effectiveness. It is the explicit separation between:

- a selected controller optimum;
- an independently declared functional boundary;
- and the exact marginal condition under which the former respects the latter.

The linear boundary

\[
\eta\le\frac{Am^2}{c_0}
\]

is an exact corollary.

The same theorem yields:

- the scaled-power steepness threshold
  \[
  p_{\min}
  =
  \frac{c_1\gamma+\eta c_0/m^2}{\beta L};
  \]
- the asymptotic cost classification through \(kC'(k)\);
- the critical nature of logarithmic constitutive-cost growth;
- a precise condition under which fixed finite boundary valuation is eventually outrun by unbounded disturbance.

## Pooling scope

The pooling corollary assumes shared, sufficiently non-rival constitutive infrastructure. It does not require perfectly common-mode disturbance, but it also does not apply when each beneficiary requires proportional duplication of controller capacity.

## Novelty caution

A dedicated pre-submission literature search should still check for exact prior formulations of the selected-optimum-versus-functional-boundary inequality and its marginal form.

The safest novelty framing is:

> established regulatory cost-effectiveness theory plus an independently specified functional boundary yields a distinct alignment problem, together with an exact local criterion for when the selected controller respects that boundary.

The paper does not claim a universal forward direction of evolution or organization.
