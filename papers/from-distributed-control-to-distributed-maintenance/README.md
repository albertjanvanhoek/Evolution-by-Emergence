# From Distributed Control to Distributed Maintenance

**Boundary Conditions for Viability in Decentralized Systems**

This directory contains the repo-ready LaTeX package for the synthesis paper developed from the `Distributed-Commons-Control` programme.

## Files

- `main.tex` — manuscript.
- `references.bib` — bibliography.
- `CLAIMS.md` — claim-status ledger separating prior art, previous papers, exact toy-model results, synthesis, and hypotheses.
- `figures/distributed_maintenance_architecture.tex` — TikZ source for the conceptual figure.

## Central claim

The paper does **not** claim a new universal law of maintenance. It proposes a diagnostic synthesis:

> distributed maintenance concerns the preservation of viability-relevant relations and capacities, not merely the persistence of present state.

The paper separates six unsafe implications:

1. local selection does not imply sufficient control;
2. persistence does not imply present self-maintenance;
3. participant presence does not imply positive contribution;
4. present state does not imply corrective capacity;
5. a reinforcement signal does not necessarily equal viability-relevant function;
6. positive contribution to one viability loop does not imply global benefit.

## New synthesis term

The manuscript introduces the **function–renewal proxy gap**: the mismatch between the function that matters for a declared viability condition and the signal that actually attracts renewal or reinforcement.

The term is new; the underlying class of proxy/alignment problems is not claimed as novel.

## Relationship to other papers

This paper is explicitly downstream of:

- `papers/persistence-does-not-measure-function/`
- `papers/when-does-regulation-pay/`
- the “Present Persistence Does Not Prove Present Self-Maintenance” test programme
- the `Distributed-Commons-Control` experiments

Protocol-specific JAM/ELVES correlated-failure results belong in the companion technical paper and are used here only as an illustration of architecture-dependent contribution.

## Build

From this directory:

```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

The figure is pure TikZ; no external image assets are required.

## Scope

This is a conceptual/theoretical synthesis with explicit falsifiers. Lean proofs in the source repositories validate consequences of declared assumptions, not empirical interpretations or the cross-substrate synthesis.
