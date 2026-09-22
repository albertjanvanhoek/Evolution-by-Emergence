# Handoff: EbE Centre — Paid Retained Organization and Future Change

This is the continuation guide for a researcher or LLM.

## Core invariant

> **Retained organization becomes causal structure for future change.**

Equivalent:

> **The system's history becomes part of its transition machinery.**

But do not stop at

\[
\mathcal K_{t+1}\neq\mathcal K_t.
\]

That is only weak history dependence.

The current stronger EbE criterion is **paid transfer to later novelty**.

Let \(R^-\) be the baseline retained repertoire, \(R^+=R^-\cup\{X\}\), and

\[
\mu_R(X)=M(R^+)-M(R^-).
\]

Let

\[
s^+=\operatorname{Retain}(s,X),
\qquad
s^-=\operatorname{Lose}(s,X),
\]

and compare both arms at the same gross budget:

\[
B^\pm=B^{\mathrm{gross}}-M(R^\pm).
\]

Then the strong transfer question is:

\[
\boxed{
\exists Y\notin\mathcal H_t:
\mathcal A_T(Y\mid s^+,B^+)
>
\mathcal A_T(Y\mid s^-,B^-).
}
\]

Equivalently, after cancelling upkeep common to both arms, \(B^+=B^- - \mu_R(X)\).

The test can fail.

That failure is useful.

## State-dependence firewall

Do not call ordinary state dependence "retention."

The current working criteria are:

1. **Endogenous** — produced by the system's own dynamics.
2. **Slow** — persists/reconstructs beyond the event that created it.
3. **Paid** — upkeep/storage/reconstruction/capacity burden is counted.
4. **Reused** — later dynamics causally depend on it.
5. **Transferable** — it changes graded accessibility in a later context, episode, descendant, task, or unvisited organization.

A valid application should operationalize all five or explain why a replacement criterion is stronger.

## Minimal paid spine

A useful scalar specialization is:

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

Keep the meanings separate:

- \(M(R)\): burden of **keeping** retained organization;
- \(K_R(Y)\): burden of **using/reaching** later organization;
- \(\mathcal A_T\): more general graded accessibility;
- \(\mathcal K\): transition machinery.

Do not reuse \(J\) or \(\mathcal R\) for multiple roles.

## Relational organization

Network/hypergraph language is a mathematical compression of organization:

\[
G=(V,E,\theta).
\]

It is not the deepest metaphysical claim.

Network representability alone does not establish an EbE mapping.

## Emergence decision

The current explicit decision is:

> **The centre is retention-driven change of transition machinery; emergence is an important source of candidate organization, not a mandatory property of every update.**

Strict compositional emergence remains:

\[
E(G,\phi,c)
\iff
G\models_c\phi
\land
\forall K\prec G,\;K\not\models_c\phi.
\]

### Law D candidate

Keep the emergence-feedback question explicit.

Two candidate routes are:

1. **Self-support:** emergent function increases usable slack enough to pay its own retention burden.
2. **Essential transfer:** retained emergent organization is causally reused and raises graded accessibility of an unvisited later target.

These are bridges to test, not universal laws.

## Accessibility

Use graded accessibility before cost:

\[
\mathcal A_T(S\mid G,R,\Gamma,q,B).
\]

Binary full closure is too coarse for the cumulative question: retained shortcuts can matter without adding anything to unlimited closure.

Cost specialization:

\[
K_G(H;c)
=
\inf_{\pi:G\leadsto H}
\mathbb E[\ell_c(\pi)].
\]

Positive net transfer in cost form requires:

\[
\boxed{
\mu_R(X)+K^{\mathrm{run}}_{s^+}(Y)
<
K_{s^-}(Y)
}
\]

where \(K^{\mathrm{run}}\) excludes the retention/upkeep amount already represented by \(\mu_R(X)\); never charge the same upkeep twice.

for at least one unvisited \(Y\).

## Repetition hierarchy corrections

For a module occurring \(n\) times:

\[
K_{\mathrm{inline}}=nc,
\]

\[
K_{\mathrm{retain}}=c+h+nr.
\]

Retention helps iff:

\[
\boxed{
(n-1)c>nr+h.
}
\]

Thus \(n=1\) cannot produce a pure additive representational scaffold when \(r,h\ge0\).

Minimum repetitions:

\[
n^\star
=
\left\lfloor\frac{c+h}{c-r}\right\rfloor+1.
\]

### Chain dichotomy

- single-use chain: no pure hidden scaffold from additive representation alone;
- repeated/shared chain: hierarchy can be favored if every level clears the threshold.

### Repetition-depth theorem

Under additive laminar nesting, if every level satisfies

\[
(n_i-1)c_i^{\min}>n_ir_i+h_i,
\]

then every optimum retains the full declared chain.

The detailed assumptions and proof sketch are in theorem-notes/README.md.

## Upkeep bound

If every active retained module costs at least

\[
\mu_{\min}>0
\]

and gross budget is finite, then

\[
|R_t|
\le
\left\lfloor
\frac{B_t^{\mathrm{gross}}}{\mu_{\min}}
\right\rfloor.
\]

Therefore open-ended historical accumulation does not imply unbounded simultaneously active retained organization.

## Dynamic Vortex prediction

With

\[
L_t=I_t-C_t
\]

and exploration budget

\[
B_t^{\mathrm{explore}}=\beta_tL_t,
\]

if candidate-generation rate is nondecreasing in exploration budget, then holding external opportunity and allocation fixed:

\[
\boxed{
\frac{\partial\lambda}{\partial L}\ge0.
}
\]

Test:

> greater post-maintenance slack should predict no lower exploratory/reorganizational trial rate until a declared saturation/bottleneck.

## Four grounding examples

### Neural learning

Strong test: does retained learned organization, after maintenance cost, improve a later untrained task/representation versus ablation?

### Autocatalytic chemistry

Strong test: does a self-maintained catalyst/organization change finite-time probability or net kinetic/energetic access to a later chemical organization not already present?

### Biological inheritance

Strong test: does retained regulatory/developmental architecture bias access to a later phenotype not already realized, after its maintenance/development burden is included?

### Technology

Strong test: does maintaining a component/standard/design capability lower net cost or raise probability of constructing a previously unrealized technology?

## Closest scientific neighbours

Do not omit:

- Kauffman — adjacent possible;
- Longo, Montévil & Kauffman — enablement;
- Montévil & Mossio — closure of constraints;
- Busseniers & Bergerot — Autonomous Change;
- evolvability / facilitated variation;
- adaptive networks;
- niche construction;
- open-ended/state-dependent dynamics.

Working differentiation, not a priority claim:

\[
\boxed{
\text{graded accessibility}
+
\text{paid retention}
+
\text{counterfactual transfer to unvisited organization}.
}
\]

That is where burden, upkeep bounds, repetition-driven hierarchy, saturation, gain/loss and lock-in enter.

## Verification files

Finite checks:

- ../scripts/check_repetition_depth.py
- ../scripts/check_chain_dichotomy.py
- ../scripts/check_transfer_criterion.py

They are sanity checks, not formal proofs.

## Current theorem target

Do **not** use the trivial target "when does retention change \(\mathcal K\)?"

Use:

> **Under graded accessibility, paid retention, and counterfactual ablation, derive conditions under which an endogenously retained organization improves access to at least one organization not previously visited.**

Then connect that result back to emergence through Law D.
