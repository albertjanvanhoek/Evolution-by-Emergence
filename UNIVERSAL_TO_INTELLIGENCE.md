# Universal EbE → Intelligent-System Specialization

**Status:** explicit specialization map for v21.  
**Important:** this document maps interfaces; it does **not** prove that the intelligent-system theory is equivalent to, or required by, the universal Evolution by Emergence model.

## 1. Why keep the layers separate?

The universal EbE core is substrate-agnostic. Its primitive objects are organization, retention, transition machinery, accessibility, resources, emergence, production and loss.

The intelligent-system specialization needs additional semantic objects:

- candidate worlds;
- claims with meaning;
- evidence and liveness;
- challenge and answerability;
- content-sensitive tracking;
- communication and correction routes;
- temporal repair of those routes.

These additions are appropriate for systems that maintain and revise models. They are not assumed for every biochemical, ecological, technological or organizational system to which universal EbE may be applied.

## 2. Proposed mapping

| Universal EbE object | Intelligent-system specialization | Current formal source |
|---|---|---|
| retained organization | retained records, revision rules, learned distinctions, maintained correction structure | `Tracking.lean`, `Network.lean`, `Persistence.lean` |
| transition machinery | challenge/evidence/revision transitions | `Operational.lean`, `Realization.lean` |
| future accessibility | reachable model revisions, answer routes, correction routes | `Semantics.lean`, `UnifiedTracking.lean`, `Realization.lean` |
| maintenance burden | resources required to keep links/processes available | `NetworkEconomics.lean`, `SCAP.lean` |
| context/environment | candidate-world/evidence conditions and changing external state | `DynamicEvidence.lean`, `Persistence.lean` |
| retained causal effect | earlier model/correction structure changes which later revisions are reachable | distributed across tracking/network/realization results |
| structural loss | sealed or broken correction routes | `Composition.lean`, `Persistence.lean` |
| restoration | repair of correction links / bounded temporal return | `Persistence.lean` |
| recursive grouping | individuals, groups, groups of groups governed by the same model law | `Network.lean`, `UnifiedTracking.lean` |
| resource-feasible persistence | SCAP affordability plus connectivity/faithfulness/openness/repair | `SCAP.lean` |

This is a modeling correspondence. Some rows are theorem-backed within the specialization; the table itself is not a theorem of equivalence.

## 3. Inside and outside descriptions

The specialization deliberately keeps two descriptions compatible.

### Inside

An agent holds a claim with a meaning over candidate worlds. Challenges may expose a live alternative. Evidence can remove possibilities. Answerability and tracking are defined in terms of what the system comes to admit and whether the change remains tied to the content supplied.

### Outside

A process has states, transitions, costs, runs and communication structure. Links can fail or be repaired. Resource ledgers constrain which correction structures can be maintained.

`Realization.lean` is the bridge: an abstract network edge can be implemented by an executable challenge/revision episode with bounded time and cost.

## 4. The anchor is not the universal EbE law

The Room anchor is a semantic fact about mutually incompatible represented claims: they cannot all be true together.

The intelligent-system theory then adds explicit premises/aims such as liveness and correctability.

Universal EbE does not require this anchor because many universal applications do not contain semantic claims at all. The anchor supplies the epistemic starting point for the intelligent-system specialization, not the generic law of cumulative evolution.

## 5. The common structural motif

What the two tracks share is a higher-order pattern:

```text
retained organization
      ↓
changes later transition machinery
      ↓
changes later accessibility
      ↓
new organization can be generated / retained
      ↓
maintenance and loss determine what persists
```

For intelligent systems, one important retained organization is the structure that makes future correction possible:

```text
records + revision rules + correction links
      ↓
which challenges/evidence can produce which revisions
      ↓
future epistemic accessibility
      ↓
updated records/rules/network structure
```

This is why the intelligent-system theory is a plausible specialization of EbE. It is not yet a complete formal instantiation theorem.

## 6. SCAP in this map

The specialization packages five explicit persistence conditions:

```text
Connected ∧ Faithful ∧ Evidence-open ∧ Repairable ∧ Affordable.
```

These correspond to different failure modes of maintained correction structure:

- **Connected:** correction routes structurally exist;
- **Faithful:** interfaces preserve another view's meaning exactly where exact transmission is claimed;
- **Evidence-open:** model state can change with supplied evidence;
- **Repairable:** broken baseline routes return within bounded temporal delay;
- **Affordable:** maintaining the declared correction structure fits the resource ledger.

SCAP is therefore a specialization-level persistence object, not a new universal axiom.

## 7. Alignment specialization

`Alignment.lean` adds a further intelligent-system specialization. It distinguishes:

- corrigibility from obedience;
- exact relay from mirroring;
- content tracking from last-speaker control;
- behavioural compliance from verification.

These results are relevant only after the semantic/agent assumptions are introduced.

## 8. What would count as a stronger formal bridge?

A future theorem-level bridge would need an explicit embedding from the Anchored Correctability state/process objects into the universal EbE state and transition/accessibility interfaces, followed by proofs that:

1. retained model/correction structure maps to retained organization;
2. challenge/evidence/revision dynamics induce the relevant universal transition machinery;
3. semantic correction reachability induces a declared universal accessibility measure;
4. the specialization's maintenance ledger is compatible with universal resource accounting;
5. the recursive update preserves the mapping over time.

Until that exists, this document is a transparent specialization map rather than an equivalence proof.

## 9. Review questions

A reviewer should ask:

- Is the proposed mapping non-arbitrary in concrete intelligent systems?
- Does the semantic notion of accessibility correspond to a useful universal accessibility object?
- Are correction routes genuinely retained organization, or merely transient state?
- Are resource costs measured consistently across the two models?
- Does the specialization add assumptions that carry the conclusion independently of universal EbE?
- Can an intelligent learning system satisfy universal EbE while violating the proposed semantic specialization?

Any negative answer can narrow the specialization without invalidating the universal model.

---

**Rule:** use this file to connect the two tracks, not to collapse them.