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

A further distinction is left deliberately open: **process continuation is not
yet numerical identity**. A persistence relation may allow branching or
copying, so one process can have more than one later continuer. Numerical
identity normally demands something stronger. The backup result below is a
useful warning: preserving the same network function or corrective role does
not by itself decide which continuer, if any, is the same individual.

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

## Extension: a shared/global representation layer

`lean/AnchoredEvolution/GlobalLayer.lean` · audit: `GlobalLayerAudit.lean`
(4 results, all axiom-audited)

This extension stays inside the node-network abstraction. It does not formalise
AI training, nations, legal ownership, cultural identity, conflict, or benefit
sharing. A node may be read as a person, community, institution, nation, model,
or any other local information source, but those interpretations are external
to the theorem.

The formal condition is `HubDetermined`: if two worlds look identical to a
shared/global representation `hub`, they also look identical to that node. This
is a dependence relation between representations; it does not by itself prove
causal influence or social absorption.

- `hub_determined_network_inherits_blind_spot`: if every available node is
  hub-determined, then every live retained-commitment cut on which the hub is
  blind is sealed for the combined node network. The error is therefore not
  discoverable from the available node views. A shared layer is not inherently
  harmful; the blind spot appears under the additional homogenising condition
  that all available views are functions of it at that distinction.
- `independent_node_pivotal_at_hub_blind_spot`: if all other available nodes
  are hub-determined while one node separates a hub-blind pair, that node is
  pivotal for the pair. Any independent source could play this role; the
  theorem does not privilege local or national sources as such.
- `losing_independent_node_seals`: if that node is the sole separator of a live
  retained-commitment cut, removing it seals the error.
- `hub_not_reducible_to_any_single_node`: if, for every node, the hub
  distinguishes some pair that the node does not, then the hub cannot be
  reconstructed as a function of any single node's view. This is only a formal
  non-reducibility result. It does **not** establish that the hub was trained on
  everyone's data, belongs to no nation, is culturally neutral, has no legal
  owner, or should be governed in any particular way.

The application-level lesson is therefore narrower than "global versus
national identity": **common mediation is compatible with correction only if
independent distinctions remain reachable.** Which institutions or model
architectures best satisfy that condition is an empirical/design question, not
a theorem here.

## Extension: shared-layer dynamics

`lean/AnchoredEvolution/SharedLayerDynamics.lean` · audit:
`SharedLayerDynamicsAudit.lean` (11 audited results)

This layer adds time but continues to model **informational dependence**, not
causal intervention. The reviewed version makes the connector-versus-common-
determinant contrast a network property rather than demanding that every node
preserve its own information forever.

### Collective irreducibility, not "emergence" by definition

`JointlyDetermined` says that if all **available** contributors identify two
worlds, the shared representation identifies them too. The layer therefore
adds no distinction absent from the available views as a group.

`NodeDeterminesHub` is the corresponding one-node condition.
`CollectivelyIrreducible` means jointly determined by the available set but not
individually determined by any available node. This is deliberately not called
`Emergent` in Lean: it is a structural signature of collective informational
dependence, not by itself the stronger EbE notion of emergence.

- `at_most_one_contributor_implies_node_determines`: if all available
  contributors, if any, collapse to one node, joint determination collapses to
  determination by that node.
- `collectively_irreducible_has_no_sole_contributor`: a collectively
  irreducible layer therefore cannot have exactly one available contributor.

These are boundary-relative information results, not claims about authorship,
training provenance, legal ownership, nationality or benefit entitlement.

### Hub-determined updates

`HubDeterminedUpdate` says that a node's next view carries no distinction that
the current hub lacks. If the hub identifies two worlds, that node identifies
them at the next step.

- `hub_determined_update_inherits_blind_spot`: if every available node updates
  this way, a live retained-commitment cut hidden from the hub is sealed and
  undiscoverable at the next network state.
- `hub_determined_not_distinction_preserving_at_independent_pair`: if a node
  previously distinguished a pair the hub does not, that node cannot both
  become hub-determined and retain *all* of its previous distinctions.

This is the structural failure mode informally described as capture. The Lean
statement itself is neutral: hub-determination is damaging only where the hub
lacks a distinction the correction system still needs.

### The actual safety invariant is network-level

Two stronger local notions remain useful:

- `DistinctionPreserving`: a node retains every distinction it previously had.
- `LiveCutPreserving`: a node retains every distinction it had across a live
  cut of a retained commitment.

But neither is minimal. A node may safely forget a live-cut distinction if
another node acquires or retains it. The core is therefore
`NetworkCutPreserving`:

> if a live cut becomes indistinguishable to the **new network as a whole**,
> then it was already indistinguishable to the old network.

Equivalently for a previously anchor-safe network, an update may reorganise,
compress, rewire or hand off distinctions between nodes, but it may not erase
the network's final separator of a still-live retained-commitment cut.

- `distinction_preserving_implies_live_cut_preserving`: full local preservation
  is a stronger sufficient condition.
- `nodewise_live_cut_preserving_implies_network_cut_preserving`: preserving
  every node's live-cut distinctions implies the weaker network invariant, but
  the converse need not hold because handoff is allowed.
- `network_cut_preserving_step_keeps_safety`: one network-cut-preserving update
  keeps an anchor-safe network anchor-safe.
- `network_cut_preserving_stays_safe`: if every transition has that property,
  an initially anchor-safe network remains anchor-safe over time.
- `recoverable_update_preserves`: if one node's previous view is recoverable
  from its new view, that node preserves all of its previous distinctions.
  This is a convenient strong implementation condition, not a requirement on
  every node.

This is an important refinement: **safe learning may forget information.** It
may even move a distinction from one participant to another. What must persist
is not each node's content but the network's ability to expose remaining error.

### A connector is an explicit network regime

`NetworkCarriesHub` says that the updated network, collectively, carries every
distinction present in the current shared layer. `ConnectorUpdate` then combines
that with `NetworkCutPreserving`:

1. still-needed old correction cuts remain distinguishable somewhere in the
   network;
2. the network as a whole incorporates the hub's distinctions.

No individual node has to preserve or encode everything.

- `connector_network_stays_safe`: repeated connector updates preserve
  Anchor-Safety.
- `safe_hub_determined_not_connector_at_live_blind_cut`: if an anchor-safe
  network has a live cut the hub cannot distinguish, an update in which every
  next node is hub-determined cannot also satisfy the connector invariant.
  The common-determinant regime erases the cut; a connector must leave some
  correction route, although that route may move between nodes.

The structural lesson is:

> **Integrate shared information without making still-needed independent
> distinctions disappear from the network.**

This is not a claim that global layers are harmful or local layers are good.
The same shared representation can be useful as an informational input while
being dangerous as the sole determinant at one of its own blind spots.

Current limitations are explicit. `S`, `C`, `K` and the local view type remain
fixed over time; only views and the hub vary. The formalisation treats
information/refinement relations, not causal influence. Whether real humans,
models or institutions satisfy these relations is empirical. A later layer can
allow changing membership, evidence/open-world sets, commitments and
representation types.

## Ledger

| Status | Item |
|---|---|
| Proved, no axioms | the 11 audited self-model results, 4 global-layer results, and 11 shared-layer-dynamics results |
| Formal hypotheses | open worlds and retained commitments; equal/different histories; live cuts; exact node separation/determination; equal introspective reports; hub/local dependence; network cut preservation or connector conditions in dynamics |
| Modelling choices | history, node-network and introspection as `State` instances; `IsSelf` marker; `Unit` inside view in pure node networks; shared representation `hub`; fixed `S`, `C`, `K` and view type in the first dynamic layer |
| Programme-level aims | persistence and reality-tracking explain why correctability matters; they are not hypotheses of these proofs |
| Interpretive mappings | material-buffer interpretation; bodies/hosted models; nodes as people, communities, institutions or nations; hub as a shared model/AI layer; "capture" and "connector" as readings of information-dependence regimes |
| Not defined | numerical identity; whether process continuation is sufficient for identity; legal/political ownership of a representation layer; full EbE emergence of a shared layer |
| Outside formalisation | phenomenal feeling; causal influence of a hub on nodes; empirical identity/conflict claims; predictions about national identity; normative benefit-sharing claims |
| Open | time-varying membership, evidence sets and commitments; changing representation types; a formal continuation relation for retained organisation; quantitative measures of total contribution, robustness, homogenisation and independence; responsibility/upkeep via `NetworkEconomics`; worked finite examples |

## Provenance

Developed in dialogue between the author and two AI systems. A first version
presented the self-model results as a parallel information theory. Review moved
them onto Anchor-Safety and narrowed pairwise versus global, pivotal versus
total, and particularity versus identity. Later extensions applied the same
node-network logic to a shared representation layer and then to its dynamics,
keeping informational dependence separate from political, causal and normative
interpretations and moving the dynamic invariant from per-node retention to
network-level preservation of live correction cuts.
