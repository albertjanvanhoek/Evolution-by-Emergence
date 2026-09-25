# Anchor-Safety: policy constraints for a fallible intelligence

**Status:** post-v21.1 research extension inside `research/anchored-correctability/`.

This layer starts *after* the anchor and the common-ground result. It does not
claim that the anchor supplies an aim. The extra aim remains explicit: an
intelligence wants its retained commitments to track reality well enough for
successful action. Anchor-Safety formalizes a constraint on pursuing that aim:

> **Act on the best model available, but do not make a still-live error in a
> retained commitment informationally undiscoverable.**

Equivalently: evidence may remove live worlds; decisions may drop commitments;
routes may be compressed, removed, added or rewired. What is forbidden is a
change that destroys the final effective distinction across a still-live cut
of a commitment the system continues to rely on.

## Why this is not a duplicate of the existing theory

The existing layers already contain two nearby results:

- `Dynamics.lean` is **content-blind structural safety**. Given a currently
  strongly connected correction graph, a change preserves structural
  correctability exactly when every old edge remains realizable directly or by
  a detour.
- `Alignment.lean` plus the Step-6 common-ground results establish why the
  maintained correction link, rather than informative shared content, is the
  pre-agreement common ground.

`AnchorSafety.lean` adds a different question: **which distinctions are still
obligatory after evidence and commitment change?** Obligations attach only to
retained commitments and still-open worlds. This makes the policy layer less
conservative than preserving every old route while remaining stricter than
mere connectivity.

The relationship is:

```text
anchor
  -> live rivals / no guarantee
  -> tracking and faithful correction
  -> persistence / SCAP
  -> common ground is the maintained correction link
  -> Anchor-Safety: change the system without sealing a live retained error
```

## Formal objects

For one state:

- `C w` — worlds still open under evidence;
- `obs w` — information available inside the model;
- `msg r w` — the message available through route `r`;
- `eff r` — routes assumed effective: they reach the agent and can participate
  in revision;
- `K a` — retained commitments, i.e. claims the agent currently relies on.

`Indist s v w` means the inside view and all effective route messages are the
same in `v` and `w`.

A live error of commitment `a` is **sealed** when some open world where `a` is
true is indistinguishable from the open world where `a` is false. It is
**information-level discoverable** when some judgement constant on those
indistinguishability classes soundly detects the error.

The qualifier matters. `Discoverable` here is extensional/information-theoretic;
it does **not** yet prove that an executable decoder, challenge or revision
procedure computes the judgement. Operational realization remains the job of
`Operational.lean`, `ModelProcess.lean`, `RelayProcess.lean` and
`Realization.lean`.

## Main checked claims

1. `discoverable_iff_not_sealed` — information-level discoverability is exactly
   absence of a seal.
2. `anchorSafe_iff_cuts_separated` — anchor-safety is equivalent to every
   still-live cut of every retained commitment being separated by the inside
   view or an effective route. The route type is abstract here; this is not yet
   literally a graph-cut theorem.
3. `sealed_error_invisible` — sealing does not make a claim truer; it removes
   the information needed to decide it correctly over the open worlds.
4. `evidence_preserves_safety` — evidence may close worlds without violating
   anchor-safety. `dropping_commitments_preserves_safety` gives the analogous
   result for commitments no longer relied upon.
5. `reconfiguration_preserves_safety` — genuine route replacement/rewiring is
   allowed whenever no live commitment cut that was distinguishable becomes
   indistinguishable. `prune_safe` is a stronger route-wise sufficient rule.
6. `last_route_removal_seals` — if an effective route is the only separator of
   a live commitment cut, that pair is distinguishable before its removal and
   sealed after it, so the resulting state is unsafe (effectiveness and
   separation are used in the proof, not merely assumed).
   `last_route_removal_breaks_safety` states the safe-to-unsafe transition.
7. Over time, an irreversible seal on a real error (actual world always open,
   commitment false there; both used in the conclusion) yields an error that is
   live, false and undiscoverable at every later time, while bounded unsealing turns the same information-level
   failure into bounded delay.

## Corrections made during integration

The supplied standalone draft was not merged verbatim.

- Its `Discoverable` definition is logically sound but information-level, not
  yet “a judgement the agent can actually execute”. The integrated wording now
  states that limitation explicitly.
- The original `prune_safe` allowed additions but did not permit replacing an
  old informative route by a different informative route. The new
  `reconfiguration_preserves_safety` supplies the genuine rewiring theorem;
  `prune_safe` is retained as a useful sufficient corollary.
- The original last-route theorem did not require the removed route actually to
  be effective, distinguishing, or removed from an initially safe state. Those
  hypotheses are now explicit, so the theorem supports the causal wording.
- The temporal “permanent error” results now explicitly assume `RealError`.

## Boundary to the existing SCAP layer

Anchor-Safety does not replace SCAP. SCAP says a persistent correction commons
must be connected, faithful, evidence-open, repairable and affordable.
Anchor-Safety says which **epistemically relevant distinctions** may not be lost
while that commons is changed.

Two bridges remain research targets:

1. connect information-level `Discoverable` to an executable decoder/process;
2. instantiate abstract effective routes with the repository's graph paths,
   exact faithful channels, temporal repair and resource constraints.

Those bridges would turn the current policy theorem into a fully operational
SCAP policy theorem rather than merely an information-level one.
