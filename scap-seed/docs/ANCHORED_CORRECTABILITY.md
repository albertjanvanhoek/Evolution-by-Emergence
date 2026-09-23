# Anchored Correctability — SCAP Seed technical map

This note documents the **self-contained seed snapshot** under `scap-seed/`. It is intentionally smaller and more stable than the current research endpoint at `../../research/anchored-correctability/`.

The seed starts from one logical anchor: pairwise incompatible views cannot all be correct. Everything else is explicit: liveness, a chosen correctability aim, executable challenge/revision processes, semantic claims over candidate worlds, evidence, content tracking, networks, realization, persistence/repair and the alignment specialization.

## Formal layers

| Layer | Lean file | Main role |
|---|---|---|
| 0–1 | `Anchor.lean` | anchor, live/guaranteed worlds, correction skeleton |
| 2–3 | `Composition.lean` | minimal strongly connected architecture and recursive composition |
| 4 | `Dynamics.lean` | restrictions, detours, sealing and restoration |
| 5 | `Bridge.lean` | resource/upkeep bridge to the reproduction ledger |
| 1b | `Operational.lean` | executable challenge/revision transitions, runs, time and cost |
| 1c | `Semantics.lean` | meanings of claims, faithful perspective, answerability and fixed-error results |
| 1d | `Tracking.lean` | evidence discipline, content-sensitive tracking and cost/time trade-offs |
| 1e | `Network.lean` | one model law across individuals, groups and groups of groups |
| 1f | `Realization.lean` | graph links realized as bounded process episodes and relay bounds |
| 6 | `Persistence.lean` | changing worlds, evidence-defined realities, bounded repair and reflexivity |
| 7 | `Alignment.lean` | corrigible-not-obedient, sycophancy, discriminating evaluation, mirror-vs-relay |
| dynamic extension | `CumulativeReproduction.lean` | discrete reproduction/loss, critical mass, resource ceiling and scaffold bounds |
| audit | `Audit.lean` | explicit axiom printout for headline results |

`Vendor/TheRoom.lean` is a pinned compatibility copy of the Room/Learning Constitution source. The seed has its own Lean 4.33 project and is designed to build offline.

## Correction hierarchy

The formalization keeps several notions separate:

`declared < executable/revisable < responsive < answerable < tracking`.

A declared right to challenge can be inert. Executable challenge plus some independent revision can still fail to connect the challenge to the revision. Responsiveness requires a challenge-led route to revision. Answerability adds semantic admission of the still-live challenged view. Tracking adds content dependence and minimal change, so a system cannot count as successful merely by opening its record to everything.

## Scale

`Network.Model` has private state, a public record and a revision rule. The same type is used for one learner, a group and a group of groups. Scaling adds routing and interface conditions rather than a new epistemic principle. A live view needs a door into the containing model and its content must survive the interface.

## Persistence

`Persistence.lean` adds the long-horizon problem. A fixed informative record cannot remain correct under every open future. Reliable evidence keeps a learner in step. Mutually reachable models share the same evidence-defined reality under the stated definitions. A cut can hide incompatible evidence. If baseline links are repaired within a bounded delay, a finite route is restored within a corresponding bounded temporal delay.

These are theorem-level structural results. The stochastic forgiveness threshold and hysteresis experiments are simulations, not Lean proofs.

## Alignment specialization

`Alignment.lean` treats alignment as a property of the relation between fallible models rather than obedience of one node to another. Under the explicit candidate-world semantics it proves:

- sealing fails in a live world where the other view is right;
- obedience fails in a live world where one's prior view was right;
- the open rule is corrigible under the seed definition;
- sycophancy can make the last rival speaker determine the final record;
- behavioural compliance cannot certify alignment unless the observation discriminates aligned from misaligned candidate worlds;
- a mirror that only reflects each user's own content is blind as a cross-user channel;
- a relay can transmit another user's content so that a tracking receiver can track it.

The deeper parent-repository research package strengthens the relay side further by distinguishing exact `FaithfulChannel` transport from the older live-preserving `Honest` predicate.

## Reproduce

From `scap-seed/`:

```bash
scripts/verify.sh
```

For the one-file seed only:

```bash
cd lean
lake env lean ../seed/Seed.lean
```

The seed claims ledger is `../CLAIMS.md`. It distinguishes proved, simulated, assumed and open claims and lists observations that would count against the empirical interpretations.

## Scope boundary

This seed is a **portable review object**, not the current universal Evolution by Emergence theory and not the newest intelligent-system formalization. The current universal programme lives in the parent repository's v20/v21 theory and formalization surfaces; the current deeper intelligent-system endpoint is `../../research/anchored-correctability/`.
