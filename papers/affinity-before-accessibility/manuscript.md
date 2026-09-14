# Affinity Before Accessibility

## Association strength, turnover, and the formation of productive couplings

### Abstract

The organizational-accessibility stack begins from a production matrix \(B\): once processes are coupled, it asks whether they collectively replace themselves, preserve declared function, retain an accessible repertoire, and make later organization reachable. But \(B\) itself is treated as given. It does not explain why components encounter one another, remain associated, or interact long enough for productive conversion.

This note isolates the missing association layer. In a simple kinetic decomposition, effective coupling depends on encounter, association persistence, and conversion. We use **affinity** or **association stability** for the middle term. Two mathematically distinct mechanisms produce an intermediate optimal association strength.

First, in a **cost channel**, affinity scales productive coupling, \(B(a)=aB_0\), while maintained association overhead grows linearly, \(\kappa(a)=ca\). Because uniform scaling preserves the Perron vector, the declared margin reduces to

\[
M_c(a)+1
=
K\,
\frac{2-\frac{1}{a\lambda_0}}
{1+ca},
\]

where \(\lambda_0=\rho(B_0)\) and \(K\) is the binding declared capability scale. For \(c>0\), the unique global optimum is

\[
\boxed{
a^\star
=
\frac{1+\sqrt{1+2\lambda_0/c}}
{2\lambda_0}
}
\]

and the peak margin is

\[
\boxed{
M_c(a^\star)+1
=
2K\,\frac{s-1}{s+1},
\qquad
s=\sqrt{1+\frac{2\lambda_0}{c}}.
}
\]

If \(K>1/2\), positive peak margin exists exactly when

\[
\boxed{
c\le
c_{\rm crit}
=
\frac{\lambda_0(2K-1)^2}{4K}.
}
\]

This volcano is **not universal**. It depends on an overhead that keeps growing with affinity; a bounded saturating overhead can remove the high-affinity downturn.

Second, in a **turnover channel**, maintained-association overhead is set to zero. Instead, effective productive coupling itself is Sabatier-shaped,

\[
\lambda(a)
=
\lambda_0
\frac{4a}{(1+a)^2}.
\]

The factor satisfies

\[
0<
\frac{4a}{(1+a)^2}
\le1
\]

for \(a>0\), with equality only at \(a=1\). Hence productive mass and declared margin are maximized uniquely at intermediate affinity \(a=1\), even with \(\kappa\equiv0\). Too-weak association fails to hold; too-strong association fails to turn over or release. This second mechanism is directly analogous to the Sabatier principle of catalysis.

The cost-channel optimum, the closed-form optimizer, and the turnover-channel peak are machine checked in Lean at the reduced-model level. A standard-library verifier reproduces the numerical example and demonstrates that saturating association overhead can remove the cost volcano. The result does not identify a new fundamental attractive force. It identifies association stability as a missing determinant of which couplings become candidates for later accessibility and retention.

---

## 1. The missing layer before the production matrix

The current framework starts from a nonnegative production matrix

\[
B=(B_{ij}),
\]

where \(B_{ij}\) records how activity of process \(j\) contributes to production of process \(i\).

That object is already downstream of several physical events.

For one component to contribute to another, at least three logically distinct things may matter:

\[
\boxed{
\text{encounter}
\rightarrow
\text{association persistence}
\rightarrow
\text{conversion}.
}
\]

In simple kinetic settings one may schematically write an effective coupling as

\[
B^{\rm eff}_{ij}
\sim
e_{ij}\,q_{ij}\,y_{ij},
\]

where

- \(e_{ij}\) summarizes encounter frequency or contact opportunity;
- \(q_{ij}\) summarizes the probability or residence time of productive association;
- \(y_{ij}\) summarizes productive conversion conditional on association.

This factorization is not asserted as a universal microscopic law. It is a bookkeeping decomposition showing what the existing production coefficient leaves implicit.

The parent Organizational Accessibility framework models productive consequences once \(B\) is specified. The present note isolates the middle term: **what determines whether an encounter persists long enough to become an effective coupling?**

We call that variable **affinity** or **association stability**.

This is where association enters the candidate-generating layer. Ordinary dynamics can supply encounters; affinity filters which encounters persist; conversion determines what those persistent encounters do.

---

## 2. Baseline production network

Use the normalized open production model already developed in the parent paper. Let

\[
\lambda_0=\rho(B_0)>0
\]

be the spectral radius of a baseline productive architecture and \(p\) its normalized Perron vector.

If all productive couplings are uniformly scaled by affinity \(a>0\),

\[
B(a)=aB_0,
\]

then

\[
\lambda(a)=a\lambda_0,
\]

while the Perron vector \(p\) is unchanged.

Under the normalized resource parameters used in the worked model, maintained productive mass is

\[
\boxed{
X(a)
=
2-\frac{1}{a\lambda_0}.
}
\]

A positive active organization requires

\[
a\lambda_0>\frac12.
\]

For declared capacity thresholds \(\theta_k\), define

\[
K
=
\min_k \frac{p_k}{\theta_k}.
\]

Because uniform scaling does not change \(p\), \(K\) is constant along this affinity axis.

Without any additional association overhead, the declared margin would be

\[
M(a)+1
=
K X(a).
\]

This is increasing in \(a\). Therefore **affinity by itself does not create an interior optimum in this linear-scaling model**. Some second effect is required.

There are at least two distinct ways to obtain one.

---

## 3. Mechanism I — costly maintained association

Some associations require maintained machinery or continuing organizational investment: adhesion molecules must be produced, localization machinery maintained, enforcement supplied, or coordinating infrastructure kept active.

This is not true of all attraction or binding. Passive chemical bonds can form exergonically and do not generally require continuous energetic payment merely to remain bonded. The present mechanism is therefore explicitly a model of **costly maintained association**, not a universal law of attraction.

Assume the maintained overhead is a one-way load

\[
\boxed{
\kappa(a)=ca,
\qquad c>0.
}
\]

The productive host is diluted by

\[
1+ca.
\]

Hence the binding declared margin becomes

\[
\boxed{
M_c(a)+1
=
K\,
\frac{
2-\frac{1}{a\lambda_0}
}{
1+ca
}.
}
\]

Define the unscaled score

\[
F_c(a)
=
\frac{
2-\frac{1}{a\lambda_0}
}{
1+ca
}.
\]

Its derivative is

\[
F_c'(a)
=
\frac{
1+2ca-2c\lambda_0a^2
}{
a^2\lambda_0(1+ca)^2}.
\]

Therefore the stationary condition is

\[
\boxed{
2c\lambda_0a^2
=
1+2ca.
}
\]

### Proposition 1 — unique global cost optimum

For

\[
a>0,\qquad
\lambda_0>0,\qquad
c>0,
\]

the positive stationary point is

\[
\boxed{
a^\star
=
\frac{
1+\sqrt{1+2\lambda_0/c}
}{
2\lambda_0
}.
}
\]

It is the unique global maximizer over positive affinity.

A useful exact certificate avoids relying on derivative sign alone. If \(a^\star\) satisfies the stationary equation, then for every \(a>0\),

\[
\boxed{
F_c(a^\star)-F_c(a)
=
\frac{
(a-a^\star)^2
}{
a(a^\star)^2\lambda_0(1+ca)
}
\ge0.
}
\]

Equality holds only at \(a=a^\star\).

The square certificate, the explicit optimizer, and global maximality are machine checked.

---

## 4. Peak height and the cost ceiling

Let

\[
s
=
\sqrt{1+\frac{2\lambda_0}{c}}.
\]

At the optimum,

\[
\boxed{
F_c(a^\star)
=
2\,\frac{s-1}{s+1}.
}
\]

Therefore

\[
\boxed{
M_c(a^\star)+1
=
2K\,\frac{s-1}{s+1}.
}
\]

If

\[
K>\frac12,
\]

positive peak margin is possible only when the association-overhead coefficient is not too large.

Solving

\[
M_c(a^\star)\ge0
\]

gives

\[
\boxed{
c
\le
c_{\rm crit}
=
\frac{
\lambda_0(2K-1)^2
}{
4K
}.
}
\]

Above this threshold, no affinity strength in this linear-overhead family leaves a nonnegative declared margin.

For the parameters used in the original numerical affinity experiment,

\[
\lambda_0\approx1.1861408,
\qquad
K\approx1.8085752,
\]

so

\[
\boxed{
c_{\rm crit}\approx1.1230447.
}
\]

Thus the earlier observation that the optimum was negative by \(c=2\) was qualitatively correct but not sharp.

---

## 5. The cost volcano depends on its overhead hypothesis

The high-affinity downturn in Proposition 1 is caused by the unbounded factor

\[
1+ca.
\]

It should not be interpreted as a universal consequence of stronger binding.

For example, replace linear overhead by a bounded saturating load

\[
\kappa_{\rm sat}(a)
=
\frac{ca}{1+a}.
\]

Then

\[
F_{\rm sat}(a)
=
\frac{
2-\frac{1}{a\lambda_0}
}{
1+\frac{ca}{1+a}
}.
\]

Differentiation gives

\[
F_{\rm sat}'(a)
=
\frac{
1+2(c+1)a+
\left(c+1-2c\lambda_0\right)a^2
}{
a^2\lambda_0\left(1+(1+c)a\right)^2}.
\]

Consequently, if

\[
\boxed{
c(2\lambda_0-1)\le1,
}
\]

the numerator is strictly positive for every \(a>0\), and the score is strictly increasing rather than volcano-shaped.

For the worked values

\[
c=0.2,
\qquad
\lambda_0\approx1.18614,
\]

this condition holds. The margin rises monotonically toward a finite plateau.

So the first volcano is a theorem about a **specific unbounded association-overhead law**. It is not the generic affinity result.

That motivates a second mechanism.

---

## 6. Mechanism II — turnover-limited association

The Sabatier principle supplies a physically different route to an intermediate optimum.

Productive association can fail at either extreme:

- if binding is too weak, the partners do not remain associated long enough to react;
- if binding is too strong, product release or turnover becomes limiting.

No continuous maintenance cost is required for this mechanism.

Represent the effective productive spectral scale by the minimal symmetric form

\[
\boxed{
\lambda(a)
=
\lambda_0
\frac{4a}{(1+a)^2},
\qquad
a>0.
}
\]

Set

\[
\kappa(a)\equiv0.
\]

Define

\[
h(a)
=
\frac{4a}{(1+a)^2}.
\]

Then

\[
\boxed{
0<h(a)\le1
}
\]

for \(a>0\), because

\[
(1+a)^2-4a
=
(a-1)^2
\ge0.
\]

Equality holds if and only if

\[
a=1.
\]

### Proposition 2 — no-upkeep turnover optimum

For positive \(\lambda_0\),

\[
\lambda(a)
\le
\lambda_0
\]

for every \(a>0\), with equality only at \(a=1\).

Since

\[
X(a)
=
2-\frac{1}{\lambda(a)}
\]

is strictly increasing in positive \(\lambda(a)\), productive mass and any margin of the form

\[
M_{\rm turn}(a)+1=KX(a)
\]

are maximized at

\[
\boxed{
a^\star_{\rm turn}=1.
}
\]

This optimum exists with **zero maintained-association overhead**.

The inequalities

\[
h(a)\le1,
\]

the equality condition, and global maximality of productive mass are machine checked.

---

## 7. Exact turnover witness

The turnover result can be exhibited without floating-point arithmetic.

Take

\[
\lambda_0=\frac65,
\qquad
K=\frac{56}{33}.
\]

At intermediate affinity

\[
a=1,
\]

the margin is

\[
\boxed{
M_{\rm turn}(1)=\frac{97}{99}.
}
\]

At the symmetric weaker and stronger affinities

\[
a=\frac12
\qquad\text{and}\qquad
a=2,
\]

the margin is lower:

\[
\boxed{
M_{\rm turn}\!\left(\frac12\right)
=
M_{\rm turn}(2)
=
\frac{53}{66}.
}
\]

More strongly, at

\[
a=\frac1{10}
\qquad\text{and}\qquad
a=10,
\]

the effective productive spectral scale is

\[
\boxed{
\lambda(a)=\frac{48}{121}<\frac12.
}
\]

The positive equilibrium therefore fails the normalized maintenance threshold at both extremes.

All of these rational statements are machine checked.

For the original numerical parameters from the affinity experiment,

\[
\lambda_0\approx1.18614,
\qquad
K\approx1.80858,
\]

the no-upkeep turnover model peaks at

\[
a=1,
\qquad
M_{\rm turn}\approx1.09239,
\]

matching the previously observed optimum margin scale.

---

## 8. Relation to the Sabatier principle

The second mechanism is deliberately Sabatier-shaped.

The classical Sabatier principle states that catalytic interactions should be neither too weak nor too strong for maximal turnover. Modern catalytic work represents this through volcano relations between activity and an interaction or adsorption descriptor.

The analogy should be stated at the level actually modeled:

\[
\boxed{
\text{weak association}
\rightarrow
\text{insufficient residence}
}
\]

while

\[
\boxed{
\text{strong association}
\rightarrow
\text{insufficient release/turnover}.
}
\]

That is much closer to the catalytic mechanism than the linear-upkeep volcano of Sections 3--4.

The comparison is still not a universality claim. Volcano relations depend on the reaction mechanism and chosen descriptor; the catalysis literature contains both strong empirical support and critical discussions of where the Sabatier picture succeeds or fails.

A directly relevant biochemical example is Kari et al. (2018), who reported an intermediate-binding optimum for interfacial cellulase catalysis and interpreted the volcano through the Sabatier principle (ACS Catalysis, DOI 10.1021/acscatal.8b03547).

The cost channel and turnover channel should therefore remain separate propositions:

\[
\boxed{
\begin{aligned}
\text{cost volcano}
&:\quad
\text{increasing productive coupling}
+
\text{unbounded maintained overhead},
\\[0.4em]
\text{turnover volcano}
&:\quad
\text{weak-binding loss}
+
\text{strong-binding release limitation}.
\end{aligned}
}
\]

Either can create an intermediate persistence optimum, but for different reasons.

---

## 9. Where this layer enters the larger framework

The organizational-accessibility stack can now be decomposed one step earlier:

\[
\boxed{
\begin{aligned}
\text{ordinary motion}
&\rightarrow
\text{encounter}
\\
&\rightarrow
\text{association persistence}
\\
&\rightarrow
\text{productive conversion}
\\
&\rightarrow
\text{realized production network}
\\
&\rightarrow
\text{retention/accessibility ratchet}.
\end{aligned}
}
\]

The matrix \(B\) belongs after the first three arrows.

The candidate distribution \(Q_s\) therefore need not be treated as an unexplained abstract search process. At least part of it can be generated by ordinary dynamics plus encounter geometry and affinity.

This does not mean affinity is the only determinant of candidate generation. Spatial mixing, concentration, transport, compatibility, timing, modularity, recombination, transfer, and many other mechanisms can matter. The point is narrower:

> **which couplings are proposed to the retention layer depends partly on which encounters persist long enough to become productive interactions.**

That supplies a concrete physical interpretation for one part of \(Q_s\).

---

## 10. What is not claimed

This note does not claim that:

- there is a new fundamental attractive force toward organization;
- every association requires continuous energetic upkeep;
- stronger affinity always costs more;
- all binding systems have a volcano relation;
- the linear overhead \(\kappa(a)=ca\) is universal;
- the turnover law \(4a/(1+a)^2\) is a universal microscopic binding law;
- the Sabatier principle applies unchanged across chemistry, biology, institutions, and social relationships;
- an intermediate persistence optimum is ethically or normatively optimal;
- affinity alone determines the full candidate distribution \(Q_s\).

The paper proves conditional results for two explicitly stated reduced mechanisms.

---

## 11. Conclusion

The existing framework asked what follows once productive couplings exist.

This note asks one step earlier:

> **What makes an encounter persist long enough to become a productive coupling at all?**

Affinity is one answer, but affinity has consequences in both directions.

In one mechanism, stronger maintained association increases productive coupling but consumes an ever-growing shared budget. The resulting cost volcano has a closed-form optimum and a closed-form viability ceiling.

In the second mechanism, no ongoing association cost is required. Productive turnover itself is maximal at intermediate binding: too weak and partners do not remain associated; too strong and release becomes limiting.

Thus the scientifically defensible statement is not that organization is pulled together by a new force.

It is:

\[
\boxed{
\text{persistent productive coupling can require an intermediate association regime.}
}
\]

This adds a layer before organizational accessibility. Ordinary dynamics supplies encounters; affinity determines which encounters persist; productive interaction determines which associations alter the organization; and the retention ratchet determines which resulting organizations can remain.

The candidate-generating process is therefore at least partly physical before it is evolutionary.
