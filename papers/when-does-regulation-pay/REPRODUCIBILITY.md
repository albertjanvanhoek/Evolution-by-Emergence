# Reproducibility

## Model

The regulated deviation variable \(z\ge0\) obeys

\[
\dot z=\eta-\gamma z-\beta u,
\qquad
u=kz.
\]

Parameters:

- \(\eta>0\): disturbance/damage input.
- \(\gamma>0\): passive recovery/removal.
- \(\beta>0\): efficacy of regulatory action.
- \(k\ge0\): controller gain.
- \(m>0\): maximum tolerated steady deviation; functional margin is \(M=m-z\).
- \(L>0\): growth/maintenance penalty per unit deviation.
- \(c_0>0\): constitutive cost per unit installed gain.
- \(c_1\ge0\): activity-dependent cost per unit control action.

The steady state is

\[
z^*(k)=\frac{\eta}{\gamma+\beta k}.
\]

Functional sufficiency is

\[
M^*(k)=m-z^*(k)\ge0.
\]

## Growth/maintenance objective

The selected scalar objective in the worked model is

\[
g(k)=g_0-Lz^*(k)-c_0k-c_1kz^*(k).
\]

The advantage over the unregulated state is

\[
\Delta g(k)
=
L[z^*(0)-z^*(k)]
-c_0k-c_1kz^*(k).
\]

Define

\[
A=\beta L-c_1\gamma.
\]

Then

\[
\Delta g(k)
=
\frac{
k[\eta A-c_0\gamma(\gamma+\beta k)]
}{
\gamma(\gamma+\beta k)
}.
\]

The derivative is

\[
\frac{d\Delta g}{dk}
=
\frac{\eta A}{(\gamma+\beta k)^2}-c_0.
\]

If \(A>0\), the second derivative is negative:

\[
\frac{d^2\Delta g}{dk^2}
=
-\frac{2\eta A\beta}{(\gamma+\beta k)^3}<0.
\]

Thus the positive optimum exists when

\[
\eta A>c_0\gamma^2
\]

and equals

\[
k_{\rm opt}
=
\frac{\sqrt{\eta A/c_0}-\gamma}{\beta}.
\]

At that optimum,

\[
z^*_{\rm opt}
=
\sqrt{\frac{\eta c_0}{A}},
\]

hence

\[
M^*_{\rm opt}
=
m-\sqrt{\frac{\eta c_0}{A}}.
\]

The growth-optimal regulator is functionally sufficient iff

\[
\eta\le\frac{A m^2}{c_0}.
\]

## Minimum function-preserving gain

Functional sufficiency requires

\[
\eta\le m(\gamma+\beta k).
\]

If \(\eta>m\gamma\),

\[
k_{\rm func}
=
\frac{\eta/m-\gamma}{\beta}.
\]

Otherwise \(k_{\rm func}=0\).

## Pooling

The pooling calculation assumes that the constitutive controller cost \(c_0k\) is shared equally across \(n\) beneficiaries, while each beneficiary retains the same local benefit and activity-dependent cost. Thus replace

\[
c_0\mapsto c_0/n.
\]

Then

\[
k_{{\rm opt},n}
=
\frac{\sqrt{n\eta A/c_0}-\gamma}{\beta},
\]

on the positive branch, and

\[
M^*_{{\rm opt},n}
=
m-\sqrt{\frac{\eta c_0}{nA}}.
\]

Functional sufficiency at the selected optimum requires

\[
n\ge\frac{\eta c_0}{A m^2}.
\]

This is a model assumption about which cost is shareable, not a universal pooling law.

## Worked parameters

Figures use:

    gamma = 1
    beta  = 1
    L     = 1
    c1    = 0.2
    c0    = 0.1
    m     = 0.5

Therefore

\[
A=0.8.
\]

Important thresholds:

    onset of positive selected gain: eta_sel = 0.125
    unregulated functional failure: eta_unreg = 0.5
    unpooled alignment boundary: eta_align = 2.0
    pooled alignment boundary for n=4: eta_align,4 = 8.0

At \(\eta=3\):

    k_func = 5.0000
    k_opt,n=1 = 3.8990     -> functionally insufficient
    k_opt,n=4 = 8.7980     -> functionally sufficient

## Rare-shock limiting model

Let shocks arrive as a Poisson process \(N_t\) of rate \(\nu\). Suppose an unregulated shock multiplies abundance by survival factor \(s_0\in(0,1)\), while regulation improves this to \(s_1\in(s_0,1]\), at continuous cost \(c\).

Then almost surely,

\[
\frac{1}{t}\log X_t
\to
g_0+\nu\log s_0
\]

without regulation and

\[
\frac{1}{t}\log X_t^{\rm reg}
\to
g_0-c+\nu\log s_1
\]

with regulation.

Therefore regulation is favored iff

\[
\nu\log(s_1/s_0)>c.
\]

If the continuous cost is pooled equally across \(n\) beneficiaries, replace \(c\) by \(c/n\).

## Figures

Run:

    python papers/when-does-regulation-pay/figures/make_figures.py

The generator uses only the Python standard library and writes the committed SVG and CSV files.

## Formalization

The first formalization lives at:

    formalization/persistence-drift/RegulatoryReturn.lean

The formalization is intentionally limited to algebraic implications. It does not formalize natural selection, empirical controller biology, or the stochastic Poisson limit unless explicitly stated in theorem assumptions.
