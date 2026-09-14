# Literature positioning

This note records which ingredients of the paper are established and where the proposed contribution begins.

## Established ingredients

### Regulation as control from within

Bich et al. (2016) distinguish regulation from mere constitutive dynamics and describe it as second-order control over the processes that produce and maintain an organism. This is close to the conceptual move made here from a fixed production matrix to state-dependent control.

DOI: 10.1007/s10539-015-9497-8

### Economy versus effectiveness

Szekely et al. (2013) explicitly analyze biological regulatory systems as a tradeoff between effectiveness and economy, using integral feedback and Pareto optimality. The present paper must not claim that regulatory cost–benefit optimization is new.

DOI: 10.1371/journal.pcbi.1003163

### Energetic cost of adaptation

Lan et al. (2012) show that accurate sensory adaptation is dissipative and establish an energy–speed–accuracy tradeoff. This supports charging the controller explicitly rather than treating regulation as free.

DOI: 10.1038/nphys2276

### Evolutionary tuning of expression and regulation

Dekel & Alon (2005) directly measured protein-expression cost and benefit and observed evolutionary tuning toward predicted optima.

DOI: 10.1038/nature03842

Poelwijk et al. (2011) studied optimality and evolution of transcriptionally regulated expression using experimentally measurable cost–benefit relationships.

DOI: 10.1186/1752-0509-5-128

### Fluctuating environments

Kussell & Leibler (2005) show that stochastic phenotype switching can be favored over sensing when environmental changes are infrequent.

DOI: 10.1126/science.1114383

Geisel (2011) compares constitutive and responsive expression and shows that demand frequency, response rate, and noise affect which strategy is favored.

DOI: 10.1371/journal.pone.0027033

### Loss of regulation

Moran et al. (2005) show that the highly reduced Buchnera genome lacks most regulatory genes for pathways examined and has correspondingly limited transcriptional responsiveness.

DOI: 10.1128/JB.187.12.4229-4237.2005

Chong et al. (2019) show repeated loss of stress-response and transcriptional-regulation genes across Buchnera lineages during continued genome reduction.

DOI: 10.1093/molbev/msz082

## Proposed contribution of this paper

The paper does not introduce the general idea that regulation trades effectiveness against cost.

It adds a separate object inherited from the companion paper:

\[
M=m-z,
\]

an independently declared functional margin.

This permits two different controller questions:

1. Which controller gain maximizes the declared selected growth/maintenance objective?
2. Which controller gain is sufficient to keep the functional margin nonnegative?

In the minimal model these are

\[
k_{\rm opt}
=
\frac{\sqrt{\eta A/c_0}-\gamma}{\beta}
\]

and

\[
k_{\rm func}
=
\max\left\{0,\frac{\eta/m-\gamma}{\beta}\right\}.
\]

The proposed methodological contribution is the explicit demonstration that these need not coincide.

At the selected optimum,

\[
M_{\rm opt}
=
m-\sqrt{\frac{\eta c_0}{A}},
\]

giving the exact alignment boundary

\[
\eta_{\rm align}
=
\frac{Am^2}{c_0}.
\]

The pooling corollary shifts that boundary to

\[
\eta_{\rm align,n}
=
\frac{nAm^2}{c_0}
\]

under the explicit assumption that the constitutive controller cost is shared across \(n\) beneficiaries.

## Novelty caution

A dedicated literature search should still be performed before submission for exact prior instances of the same selected-optimum-versus-functional-threshold equation. The current evidence supports treating the result as a compact synthesis/extension of established control and evolutionary cost–benefit ideas rather than claiming a new general law of biological regulation.
