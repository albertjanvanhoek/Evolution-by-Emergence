# Reproducibility

## Declared accessible set

Fix a target family \(\mathscr U\), common evaluation protocol \(\mathcal P\), horizon \(\tau\), establishment criterion, and threshold \(p_\star\).

For target hitting score

\[
h_t(U)=\mathcal H_\tau(U\mid s_t,\mathcal P),
\]

define

\[
\mathcal R_t
=
\{U\in\mathscr U:h_t(U)\ge p_\star\}.
\]

A preserving step satisfies

\[
\mathcal R_t\subseteq\mathcal R_{t+1}.
\]

A strict click satisfies

\[
\mathcal R_t\subsetneq\mathcal R_{t+1}.
\]

## Score sufficient condition

If

\[
h_{t+1}(U)\ge h_t(U)
\quad\forall U\in\mathscr U,
\]

then every thresholded accessible target remains accessible.

If additionally some target crosses the threshold,

\[
h_t(U^\star)<p_\star\le h_{t+1}(U^\star),
\]

the step is strict.

## Cost sufficient condition

For a mechanism-level effective cost \(c_t(U)\) and budget \(B\),

\[
\mathcal F_t(B)
=
\{U\in\mathscr U:c_t(U)\le B\}.
\]

If

\[
c_{t+1}(U)\le c_t(U)
\quad\forall U\in\mathscr U,
\]

then

\[
\mathcal F_t(B)\subseteq\mathcal F_{t+1}(B).
\]

If

\[
c_{t+1}(U^\star)\le B<c_t(U^\star),
\]

then the inclusion is strict.

This cost construction is a mechanism-level specialization. It does not redefine the probabilistic organizational-accessibility kernel.

## Machine verification

Project:

    formalization/cumulative-accessibility/

Build locally with:

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build

The Lean source checks preservation, strict expansion, composition, score dominance, threshold crossing, cost dominance, budget crossing, and the failure of preservation after target loss.

The formalization proves the abstract implications. It does not validate an empirical choice of target family, protocol, score, cost, or threshold.
