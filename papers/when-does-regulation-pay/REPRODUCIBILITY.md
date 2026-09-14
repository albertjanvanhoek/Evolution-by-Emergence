# Reproducibility

## Controlled deviation model

\[
\dot z=\eta-\gamma z-\beta u,
\qquad
u=kz,
\]

with \(\eta>0\), \(\gamma>0\), \(\beta>0\), and \(k\ge0\).

The steady state is

\[
z^*(k)=\frac{\eta}{\gamma+\beta k}.
\]

For declared tolerance \(m>0\),

\[
M^*(k)=m-z^*(k),
\]

and

\[
M^*(k)\ge0
\iff
\eta\le m(\gamma+\beta k).
\]

Thus

\[
k_{\rm func}
=
\max\left\{0,\frac{\eta/m-\gamma}{\beta}\right\}.
\]

## Linear selected objective

\[
g(k)=g_0-Lz^*(k)-c_0k-c_1kz^*(k),
\]

with \(L>0\), \(c_0>0\), and \(c_1\ge0\). Define

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

The derivatives are

\[
\frac{d\Delta g}{dk}
=
\frac{\eta A}{(\gamma+\beta k)^2}-c_0,
\]

\[
\frac{d^2\Delta g}{dk^2}
=
-\frac{2\eta A\beta}{(\gamma+\beta k)^3}.
\]

For \(A>0\), positive regulation is selected when

\[
\eta A>c_0\gamma^2,
\]

and then

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
\qquad
M^*_{\rm opt}
=
m-\sqrt{\frac{\eta c_0}{A}}.
\]

Hence

\[
M^*_{\rm opt}\ge0
\iff
\eta\le\frac{Am^2}{c_0}.
\]

### Algebraic global-optimum certificate

Let

\[
d=\gamma+\beta k
\]

and

\[
R(d)=c_0d+\frac{\eta A}{d}.
\]

Up to a \(k\)-independent constant and the positive factor \(1/\beta\), maximizing \(g\) is minimizing \(R\).

If \(d_0>0\) satisfies

\[
\eta A=c_0d_0^2,
\]

then

\[
R(d)-R(d_0)
=
\frac{c_0(d-d_0)^2}{d}
\ge0.
\]

This gives a global-optimum certificate for the linear model and is machine checked in Lean.

## General marginal-alignment theorem

Generalize to

\[
g(k)
=
g_0
-
\Phi(z^*(k))
-
C(k)
-
c_1kz^*(k).
\]

On the overloaded branch

\[
\eta>m\gamma,
\]

the functional boundary corresponds to

\[
k(m)=k_{\rm func}.
\]

Using

\[
k(z)=\frac{\eta/z-\gamma}{\beta}
\]

and

\[
k(z)z=\frac{\eta-\gamma z}{\beta},
\]

the objective becomes, up to constants,

\[
g(z)
=
-\Phi(z)
-C(k(z))
+\frac{c_1\gamma}{\beta}z.
\]

Therefore

\[
g'(z)
=
-\Phi'(z)
+
\frac{\eta}{\beta z^2}C'(k(z))
+
\frac{c_1\gamma}{\beta},
\]

and

\[
g''(z)
=
-\Phi''(z)
-
\frac{\eta^2}{\beta^2z^4}C''(k(z))
-
\frac{2\eta}{\beta z^3}C'(k(z)).
\]

Under

\[
\Phi''\ge0,
\qquad
C'>0,
\qquad
C''\ge0,
\]

we have \(g''<0\). Hence

\[
z_{\rm opt}\le m
\iff
g'(m)\le0.
\]

Substitution gives

\[
\boxed{
\beta m^2\Phi'(m)
\ge
\eta C'(k_{\rm func})
+
c_1\gamma m^2.
}
\]

Define

\[
\Psi'(m)
=
\Phi'(m)-\frac{c_1\gamma}{\beta}.
\]

Then equivalently

\[
\boxed{
\beta m^2\Psi'(m)
\ge
\eta C'(k_{\rm func}).
}
\]

This criterion is local at \(z=m\): it decides aligned versus non-aligned but does not determine \(M^*_{\rm opt}\) without solving for the optimum.

## Exact specializations

For

\[
\Phi(z)=Lz,
\qquad
C(k)=c_0k,
\]

\[
\Psi'(m)=\frac{A}{\beta},
\]

and the theorem reduces to

\[
\eta c_0\le Am^2.
\]

For

\[
\Phi_p(z)
=
Lm\left(\frac zm\right)^p,
\qquad
p\ge1,
\]

with \(C(k)=c_0k\),

\[
\Phi_p'(m)=Lp,
\]

so

\[
\boxed{
p_{\min}
=
\frac{c_1\gamma+\eta c_0/m^2}{\beta L}.
}
\]

For the worked parameters,

\[
p_{\min}=0.2+0.4\eta.
\]

## Constitutive-cost asymptotics

On the overloaded branch,

\[
\eta=m(\gamma+\beta k_{\rm func}).
\]

Thus

\[
\eta C'(k_{\rm func})
=
m(\gamma+\beta k_{\rm func})C'(k_{\rm func}),
\]

so the relevant large-gain quantity is \(kC'(k)\).

If

\[
kC'(k)\to\infty,
\]

then any fixed finite \(\Psi'(m)\) is eventually insufficient under unbounded disturbance.

For \(C(k)=c_0k^a\), \(a>0\), this condition holds.

For \(C(k)\sim c_0\log k\),

\[
kC'(k)\to c_0,
\]

so the logarithmic case is critical.

For \(C(k)\sim c_0(\log k)^2\),

\[
kC'(k)\sim2c_0\log k\to\infty,
\]

so eventual separation still occurs, although slowly.

These are asymptotic statements only. The exact finite-system criterion is the boundary inequality above.

## Pooling

The pooling calculation assumes sufficiently shared, non-rival constitutive infrastructure, so

\[
c_0\mapsto c_0/n.
\]

Then

\[
M^*_{{\rm opt},n}
=
m-\sqrt{\frac{\eta c_0}{nA}},
\]

and alignment requires

\[
\eta\le\frac{nAm^2}{c_0}.
\]

For a discrete beneficiary count,

\[
n_{\min}
=
\left\lceil\frac{\eta c_0}{Am^2}\right\rceil.
\]

This \(1/n\) result does not apply when controller capacity must be duplicated proportionally for each additional beneficiary.

## Worked parameters

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

Thresholds:

    eta_sel   = 0.125
    eta_unreg = 0.5
    eta_align = 2.0
    eta_align,n=4 = 8.0

At \(\eta=3\):

    k_func = 5.0000
    k_opt,n=1 = 3.8990
    k_opt,n=4 = 8.7980

The three linear-model disturbance boundaries satisfy

\[
\eta_{\rm unreg}^2
=
\eta_{\rm sel}\eta_{\rm align}.
\]

## Rare-shock limiting model

With shocks arriving at rate \(\nu\), survival factors \(s_0<s_1\), and continuous preparedness cost \(c\),

\[
\Delta g_{\rm shock}
=
-c+
\nu\log\left(\frac{s_1}{s_0}\right).
\]

Preparedness pays iff

\[
\nu\log(s_1/s_0)>c.
\]

## Figures

Run:

    python papers/when-does-regulation-pay/figures/make_figures.py

The generator uses only the Python standard library and writes the committed SVG and CSV files.

## Formalization

The Lean source is:

    formalization/persistence-drift/RegulatoryReturn.lean

It machine-checks:

1. functional sufficiency versus the load-control inequality;
2. exact return factorization;
3. positive and nonpositive return implications;
4. the reduced-cost representation;
5. a global-optimum certificate for the linear stationary candidate;
6. the scaled boundary-derivative identity;
7. the exact marginal-alignment inequality;
8. the effective marginal-value reformulation;
9. the linear specialization;
10. the scaled-power boundary specialization;
11. the pooling numerator identity.

The Lean development checks algebraic implications under explicit assumptions. The manuscript's differentiability and convexity assumptions for the general \(\Phi,C\) theorem are analytic and stated separately. No empirical biological assumption is machine validated.
