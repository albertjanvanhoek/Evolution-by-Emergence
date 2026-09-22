# Retained Organization and the Dynamic Vortex — working EbE architecture

> **Status: working compression of the recurring EbE pattern — not yet the final formal theory.**
>
> This directory preserves the current centre so later formalization cannot silently replace it with a narrower cost, validation, closure, or generic state-dependence model.

## Centre

> **Retained organization becomes causal structure for future change.**

Equivalent formulation:

> **The system's history becomes part of its transition machinery.**

A schematic paid-retention spine is

\[
B_t^{\mathrm{free}}
=
B_t^{\mathrm{gross}}-M(R_t),
\]

\[
\mathcal K_t
=
\mathcal K[G_t,R_t,\Gamma_t;B_t^{\mathrm{free}}],
\]

\[
G'_t\sim\mathcal K_t,
\]

\[
(G_{t+1},R_{t+1})
=
\operatorname{Ret}(G_t,R_t,G'_t,\mathcal V,\Gamma_t).
\]

A mere change

\[
\mathcal K_{t+1}\neq\mathcal K_t
\]

is only weak historical dependence. Ordinary state-dependent systems can satisfy it.

The stronger current EbE criterion is **paid transfer** to later novelty. With \(R^+=R^-\cup\{X\}\),

\[
B^\pm=B^{\mathrm{gross}}-M(R^\pm),
\]

and the criterion is

\[
\boxed{
\exists Y\notin\mathcal H_t:
\mathcal A_T(Y\mid s^+,B^+)
>
\mathcal A_T(Y\mid s^-,B^-).
}
\]

Equivalently, after cancelling upkeep common to both arms, \(B^+=B^- - \mu_R(X)\) with \(\mu_R(X)=M(R^+)-M(R^-)\).

Retention should therefore be:

1. **endogenous**;
2. **slow** relative to the event that created it;
3. **paid** for;
4. **reused** causally later;
5. **transferable** to a later context/task/descendant or unvisited organization.

That is the current firewall against reducing EbE to ordinary state dependence.

## Why a network still matters

A network or hypergraph is the mathematical compression used for **relational organization**:

\[
G=(V,E,\theta).
\]

This does **not** assert that reality is literally a graph.

Representability as a network is not enough for EbE. A real application must identify relational organization, reorganization, differential continuation, paid retention, causal reuse, and transfer to future accessibility.

## Emergence

The explicit decision is:

> **The centre is retention-driven change of transition machinery; emergence is one important source of candidate organization and can feed back into retention and later accessibility.**

Strict compositional emergence remains:

\[
E(G,\phi,c)
\iff
G\models_c\phi
\land
\forall K\prec G,\;K\not\models_c\phi.
\]

Law D in the working theory keeps the feedback question explicit: an emergent capability may help pay its own upkeep or become an essential retained parent for later unvisited organization.

## Accessibility and cost

Accessibility is more general than cost:

\[
\mathcal A_T(S\mid G,R,\Gamma,q,B).
\]

Costed reachability is one specialization:

\[
K_G(H;c)
=
\inf_{\pi:G\leadsto H}\mathbb E[\ell_c(\pi)].
\]

Keeping and using are separated:

- \(M(R)\): upkeep/storage/reconstruction burden;
- \(K_R(Y)\): later construction/use burden.

This distinction is necessary for burden, lock-in, upkeep bounds, transfer thresholds, and hierarchy.

## Repetition-driven hierarchy

A reusable scaffold appearing \(n\) times, with inline cost \(c\), reference cost \(r\), and retention burden \(h\), pays for itself iff

\[
\boxed{
(n-1)c>nr+h.
}
\]

For nonnegative \(r,h\), \(n=1\) can never justify a purely representational scaffold.

So in the additive model:

> **single-use nesting does not generate hidden hierarchy; repeated/shared nesting can.**

The detailed repetition-depth theorem and check scripts are in theorem-notes and scripts.

## Dynamic Vortex

A minimal self-maintaining loop is

\[
X\rightarrow\phi\rightarrow r\rightarrow\operatorname{maintenance}(X).
\]

A resource specialization gives post-maintenance slack

\[
L_t=I_t-C_t.
\]

If exploration budget is nondecreasing in \(L_t\), the vortex gives a measurable prediction:

> **holding external opportunity and allocation fixed, greater post-maintenance slack should predict no lower exploratory/reorganizational trial rate until saturation or another declared bottleneck is reached.**

## Cross-domain grounding

| Role | Neural learning | Chemistry | Biological inheritance | Technology |
|---|---|---|---|---|
| relational organization | neural connectivity/dynamics | reaction-catalysis network | regulatory/developmental/module network | component/interface/production network |
| reorganization | plasticity/learning | reaction-network change | mutation/recombination/development | invention/recombination |
| differential continuation | reward/error/viability | kinetic/resource persistence | reproduction/viability | performance/adoption/cost |
| retention | learned organization | self-regeneration | heredity/reconstruction | design/standard/manufacture |
| transfer test | later untrained learning | later chemical accessibility | later phenotypic accessibility | later constructibility |

The mechanisms differ. The proposed unity is structural and conditional.

## Closest neighbours

The working theory explicitly overlaps with:

- Kauffman's **adjacent possible**;
- Longo, Montévil & Kauffman's **enablement**;
- Montévil & Mossio's **closure of constraints**;
- Busseniers & Bergerot's **Autonomous Change**;
- evolvability/facilitated variation;
- adaptive networks;
- open-ended/state-dependent dynamics;
- niche construction;
- modularity and cumulative technological evolution.

EbE should not claim to have discovered the idea that what exists changes what can exist next.

The current differentiating research programme is narrower:

\[
\boxed{
\text{graded accessibility}
+
\text{paid retention}
+
\text{counterfactual transfer to unvisited organization}.
}
\]

That is where burden, upkeep bounds, repetition-driven hierarchy, saturation, gain/loss, and lock-in become testable.

## Files

- [WORKING_THEORY.md](WORKING_THEORY.md) — canonical current compression and definitions.
- [HANDOFF.md](HANDOFF.md) — continuation guide.
- [theorem-notes/README.md](theorem-notes/README.md) — paid transfer, repetition threshold, chain dichotomy, repetition-depth theorem, Law D, upkeep bound.
- [simulations/README.md](simulations/README.md) — exploratory results and reproduction plan.
- [scripts/](scripts/) — finite algebra/adversarial checks.

## Guardrail

A future formalization has drifted away from the current centre if it cannot distinguish:

\[
\boxed{
\text{ordinary state dependence}
\neq
\text{paid retained causal structure}
\neq
\text{positive transfer to later novelty}.
}
\]
