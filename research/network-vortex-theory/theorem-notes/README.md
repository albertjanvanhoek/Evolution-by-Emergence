# Theorem Notes

> **Status:** paper mathematics / candidate theorem program.  
> These results should be independently checked before being promoted into the formal EbE core.

## 1. General retention identity

Let \(R\) be the current retained repertoire, \(D_R(Y)\) minimum future construction/description cost of target \(Y\), \(M(R)\) maintenance/storage cost, and future targets follow \(P\).

Define

\[
J(R)=\mathbb E_{Y\sim P}[D_R(Y)]+M(R).
\]

For candidate module \(X\), define

\[
S_R(X)=\mathbb E[D_R(Y)-D_{R\cup\{X\}}(Y)]
\]

and

\[
C_R(X)=M(R\cup\{X\})-M(R).
\]

Then exactly:

\[
\boxed{
J(R\cup\{X\})-J(R)=C_R(X)-S_R(X).
}
\]

Hence:

\[
\boxed{
J(R\cup\{X\})<J(R)
\iff
S_R(X)>C_R(X).
}
\]

This result is mathematically elementary and is not claimed as novel. Its role is to prevent the theory from assuming that persistence/retention is automatically advantageous.

## 2. Two-level hierarchy model

Let \(A\prec B\).

Parameters:

- \(a\): scratch construction cost of \(A\);
- \(b\): additional scratch cost of \(B\) once \(A\) exists;
- \(r_A,r_B\): reuse/reference costs;
- \(u\): future direct uses of \(A\);
- \(v\): future uses of \(B\);
- \(m_A\): retention cost of \(A\);
- \(m_B\): independent retention cost of \(B\);
- \(m_{B|A}\): retention cost of \(B\) when \(A\) is retained.

Candidate objectives:

\[
J_\varnothing=ua+v(a+b),
\]

\[
J_A=m_A+ur_A+v(r_A+b),
\]

\[
J_B=m_B+ua+vr_B,
\]

\[
J_{AB}=m_A+m_{B|A}+ur_A+vr_B.
\]

The nested dictionary \(\{A,B\}\) is uniquely optimal iff:

\[
m_{B|A}<v(r_A+b-r_B),
\tag{H1}
\]

\[
m_A<u(a-r_A)+(m_B-m_{B|A}),
\tag{H2}
\]

and

\[
m_A+m_{B|A}
<
u(a-r_A)+v(a+b-r_B).
\tag{H3}
\]

H2 has the interpretation

\[
\boxed{
m_A
<
\underbrace{u(a-r_A)}_{\text{direct reuse}}
+
\underbrace{(m_B-m_{B|A})}_{\text{hierarchical compression}}.
}
\]

## 3. Pure scaffold corollary

Set \(u=0\).

Then retaining \(A\) can still be optimal if

\[
\boxed{
m_A<m_B-m_{B|A}.
}
\]

A lower-level module can therefore have zero direct task utility and still be worth retaining because it compresses higher-level organization.

If there is no representation sharing,

\[
m_{B|A}=m_B,
\]

and \(m_A>0\), then such a pure scaffold cannot be optimal.

## 4. Arbitrary-depth chain

Let

\[
A_1\prec A_2\prec\cdots\prec A_k.
\]

For each \(A_i\):

- \(m_i>0\): maintenance/retention cost;
- \(W_i\ge0\): direct expected reuse saving.

For each adjacent pair define \(H_i\ge0\) as representation/maintenance saving for \(A_{i+1}\) when \(A_i\) is retained.

For dictionary \(R\subseteq\{1,\dots,k\}\), define

\[
J(R)
=
J_0+
\sum_{i\in R}(m_i-W_i)
-
\sum_{i=1}^{k-1}
H_i\mathbf1_{\{i,i+1\}\subseteq R}.
\tag{1}
\]

Let \(K=\{1,\dots,k\}\). For omitted set \(Q=K\setminus R\),

\[
J(R)-J(K)
=
\sum_{i\in Q}(W_i-m_i)
+
\sum_{\{i,i+1\}\cap Q\neq\varnothing}H_i.
\tag{2}
\]

For an omitted contiguous interval \([p,q]\),

\[
\Delta_{p,q}
=
\sum_{i=p}^{q}(W_i-m_i)
+
\sum_{i=\max(1,p-1)}^{\min(k-1,q)}H_i.
\tag{3}
\]

Because omitted sets decompose into contiguous intervals on a chain:

\[
\boxed{
K\text{ is uniquely optimal}
\iff
\Delta_{p,q}>0
\quad
\forall 1\le p\le q\le k.
}
\tag{4}
\]

## 5. Simple sufficient condition

A sufficient condition for the full hierarchy to be uniquely optimal is

\[
\boxed{
W_i+H_i>m_i
\quad i=1,\dots,k-1
}
\]

and

\[
\boxed{
W_k>m_k.
}
\]

## 6. Recursive scaffold corollary

If lower levels have zero direct use,

\[
W_1=\cdots=W_{k-1}=0,
\]

then sufficient conditions become

\[
\boxed{
H_i>m_i
\quad i<k
}
\]

and

\[
\boxed{
W_k>m_k.
}
\]

Thus, for arbitrary prescribed depth \(k\), a full hierarchy can be uniquely optimal even when every lower-level organization has zero direct task utility.

## 7. Network interpretation

The hierarchy theorem is **not the ontology of EbE**.

It is a subresult about retained network modules.

\(A_i\) should be interpreted as a stable/reproducible subnetwork that can act as a higher-scale component in \(A_{i+1}\).

The term \(H_i\) represents a reduction in future construction/maintenance burden caused by treating that subnetwork as a reusable module.

## 8. Next theorem

The current hierarchy is pre-specified.

The next target is stronger:

> Given a recurrent distribution of network constructions, derive sufficient conditions under which an optimal retained repertoire discovers recurrent subgraphs and necessarily contains nested reusable modules.

That theorem should start from network structure, not from a pre-given chain.
