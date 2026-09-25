# Self-model layer

`lean/AnchoredEvolution/SelfModel.lean` · audit: `lean/AnchoredEvolution/SelfModelAudit.lean` (11 results, all axiom-free)

## Principle

**Self-claims inherit the same correctability law as world-claims.**

The Anchor-Safety layer is claim-generic. Nothing in `State`, `Sealed`,
`Discoverable` or `Unsealed` separates a claim about the world from a claim
an agent makes about itself. So this layer adds no parallel information theory.
It builds three kinds of `State`; the headline safety/discoverability results
instantiate existing Anchor-Safety theorems, while small adapter lemmas unfold
those state constructions directly.

## Three concepts, kept apart

| Concept | Meaning | What constrains it here |
|---|---|---|
| **Identity** | programme-level candidate: continuity of a persisting organised process | not defined or proved in this layer |
| **Self-model** | the process's representation of itself, i.e. its retained self-claims | the anchor, via Anchor-Safety (parts 0, 1, 3) |
| **Relational particularity** | the distinctions and capacities the process makes available to the larger network | partly described by the network theorems (part 2) |

The anchor constrains the self-model. The network theorems describe part of
relational particularity. Neither defines identity, and this layer does not
claim that the programme-level identity candidate is the uniquely correct
metaphysical criterion.

## Results

**0. No self-exemption.** `selfPart` restricts retained commitments to
self-claims.
- `self_claims_inherit`: an anchor-safe agent is anchor-safe about its
  self-claims. This is an instance of `dropping_commitments_preserves_safety`.
- `sealed_self_claim_breaks_safety`: an explicit retained self-claim that is
  false in an open world and sealed there is enough to make the whole agent
  unsafe.

**1. Buffer dependence** (`historyState`: routes are past observation steps).
- `buffer_seals_dependence`: while inside histories agree, the error in the
  self-claim "I sustain myself" is sealed and undiscoverable, and the agent is
  not anchor-safe. Instance of `discoverable_iff_not_sealed`.
- `buffer_exhausted_pairwise`: once histories differ at step `B`, the pair
  is distinguishable. **Pairwise only.** This is not global recognition of
  dependence.

If a bodily or hosted system can be represented by histories with different
buffer horizons `B`, both are instances of the same theorem. That mapping is an
interpretive application, not something proved by the theorem.

**2. Pivotal contribution** (`nodeState`: routes are nodes).
- `pivotal_removal_seals`: removing the unique separator of a live cut seals
  a live error. Instance of `last_route_removal_seals`.
- `determined_removal_safe`: removing a node determined by the others is a
  cut-preserving reconfiguration. Instance of `reconfiguration_preserves_safety`.
- `determined_not_pivotal`: a determined node is never pivotal.
- `backup_becomes_pivotal`: two nodes that both separate a pair are each
  non-pivotal while both are present, and either becomes pivotal as soon as
  the other fails.

**Pivotal is not total.** Redundant nodes can carry robustness value, which
this layer demonstrates for a live pair but does not measure generally.
Pivotality is also relative to the chosen candidate worlds, commitments,
available nodes and observation boundary. "What the network would lose without
you, now" therefore describes one boundary-relative form of *pivotal relational
particularity*. It does not define identity.

**3. Introspection** (`introState`: reports are the inside view, with no
external routes).
- `introspection_seals_both`: if two open worlds give the same reports and
  differ on a self-property `F`, then the theorem explicitly records both
  errors: affirming `F` where it is false and denying `F` where it is true.
  Both are sealed and undiscoverable from reports. The layer shows why the
  question stays open under this indistinguishability condition. It does not
  answer the underlying self-property.

## Ledger

| Status | Item |
|---|---|
| Proved, no axioms | the 11 audited results above; headline claims are Anchor-Safety instantiations and adapter lemmas are direct consequences of the state definitions |
| Formal hypotheses | open worlds and retained commitments; equal/different histories; live cut pairs; exact node separation/determination; equal introspective reports |
| Modelling choices | the history state, node network and introspective state as `State` instances; `IsSelf` as a marker for self-claims; `Unit` inside view in the pure node-network construction |
| Programme-level aims | persistence and reality-tracking explain why correctability matters; they are not hypotheses of these 11 proofs |
| Interpretive mappings | treating a temporal indistinguishability horizon as a material buffer; mapping bodies or hosted models to such histories; applying the same abstraction across substrates |
| Not defined | identity as a persisting organised process |
| Outside formalisation | whether anything is felt; whether these definitions capture what they name |
| Open | a measure of total (not only pivotal) contribution, including robustness; responsibility as upkeep via `NetworkEconomics`; local views cannot certify network-level commitments; a worked finite example |

## Provenance

Developed in dialogue between the author and two AI systems. A first version
presented these results as a parallel information theory. Review moved them
onto Anchor-Safety and narrowed three claims: pairwise versus global,
pivotal versus total, and particularity versus identity.
