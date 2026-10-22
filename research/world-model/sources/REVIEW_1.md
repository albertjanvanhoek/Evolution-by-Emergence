> **Review 1, 22 October 2026.** An independent review of the first version of [WORLD_MODEL.md](../WORLD_MODEL.md) and `WorldModel.lean`, by a reader from another model family, given the [review brief](../briefs/REVIEW_BRIEF.md). Kept verbatim as received, as the record. The response is in [RESPONSE_1.md](RESPONSE_1.md). Its sources [S1]–[S16] were checked by the reviewer, not by the assistant, except where RESPONSE_1.md says otherwise.

# Part 0. My starting definition

**0.1 What is a world model?**

A world model is a representation of aspects of an environment, including how they relate and change, that supports inference about unobserved, future, or hypothetical situations. It can be explicit or implicit, probabilistic or deterministic, accurate or mistaken. Being corrigible makes it a better world model; it is not what makes it a world model in the first place.

**0.2 What does a model need in order to be a good one?**

A good model needs appropriate scope, useful representations, empirical fit, calibrated uncertainty, sound updating, checks for misspecification, and adequate predictive or decision performance at an affordable cost.

**0.3 Is there a collective world model, and what makes a good contribution?**

A collective world model can be distributed across people and records; contributing well requires communicating evidence, uncertainty, provenance, and dependencies, while allowing disagreements and errors to be examined.

**NOT READY.**

## Part 2. The definition itself

### Review scope and independence

Prepared for Albert Jan van Hoek, 22 October 2026.

I reviewed WORLD_MODEL.md and WorldModel.lean on the world-model-definition branch, pinned to commit **1d74c36ca1598fa19a20bda7ee4795d320092617**. PR #141 was open when retrieved. Both files match the attachment after normalizing line endings and surrounding whitespace. I also consulted CORE.md, especially steps 4 and 8 and its limitations, and the world-model-integrity README as context. I did not open experiments/. I did not audit the other Lean modules cited by the note.

The Part 0 answers above reproduce my initial answers verbatim. They are **not a blind baseline**: reading the combined attachment exposed its summary and portions of the material before I recorded them. My context also includes prior information about EbE. I did not participate in drafting these two files in this review, but I cannot represent myself as a reader with no prior exposure to the framework. The counterexamples and source checks below, rather than a claim of perfect independence, are the basis of this assessment.

The verdict concerns readiness to serve as the opening definition of a major release. It is not a verdict that the Lean implications are false, or that the practical concern with evidence, revision and shared information should be abandoned.

### 2.1 What the definition includes and excludes

The prose defines an **epistemically disciplined way of maintaining a world model**, not the general class of world models. The formal layer defines something narrower still: exact agreement between two sets of possibilities.

These are three different objects:

1. A representation of an environment.
2. A practice of testing and revising that representation.
3. A set equal to the possibilities compatible with specified background assumptions and evidence.

They should not share one definition without an explicit bridge.

**Wrong exclusions.** An inaccurate model remains a world model. So does a temporarily frozen simulator, a child's implicit model that lacks reflective awareness, and an approximate model that deliberately omits irrelevant distinctions. A world model trained offline does not cease to be one whenever it is deployed without online updating. Ha and Schmidhuber's technical use of the term supplies a concrete comparator: a learned generative model supports policy learning in a simulated environment, without making the note's ethical or metacognitive requirements part of the definition [S1].

**Wrong inclusions or missing discrimination.** A catalogue of observations or an evidence-compatible set is not automatically a model capable of predicting transitions or evaluating actions. A truth-directed temperature record can satisfy the prose's evidential discipline while lacking that structure. Formally, arbitrary predicates qualify when they equal L, whether or not a holder represents them, can compute with them, or has any updating mechanism. Most seriously, K = L = the empty set satisfies IsWorldModel, although it entails every proposition.

There are also failures inside the vague/world-model/sealed table:

- A partially vague model need not be useless. Let W = {a,b,c,d}, L = {a}, and K = {a,b}. K retains too much, but correctly rules out c and d.
- An over-sharp model need not be wrong about actuality. Let L = {a,b}, K = {a}, and let a be actual. It has unjustifiably excluded b, but retained actuality.
- The categories are not exhaustive. With L = {a,b} and K = {b,c}, K both wrongly excludes a live possibility and retains an excluded one. Neither set contains the other.

The vague-model theorems concern the extreme K = W, not all K strictly larger than L. The actual-world exclusion theorems concern models that exclude actuality, not all over-sharp models.

**Smallest conceptual repair:** retain “world model” for the representational object; use “evidence-responsive world modelling” for the practice and “exact evidence-compatible possibility set” for the formal ideal. If the author deliberately wants a narrower stipulative definition, name it as such and do not present it as substrate-neutral ordinary usage.

The literal requirement that **every claim** can be shown wrong also needs narrowing. Mathematical consequences and definitions are not empirically falsifiable in that sense; a stochastic forecast can assign positive probability to every finite outcome without being untestable. Require discriminating empirical evaluation of relevant predictions and revisability of empirical assumptions, rather than a decisive falsifier for every component.

### 2.2 Answerability: useful, but not yet operational

Answerability is a useful virtue because it distinguishes a currently mistaken but responsive model from a belief protected against criticism. It is not intrinsically circular. It becomes circular if evidence counts as adequate only when the model accepts it, or if “change when evidence requires it” has no independent criteria.

To make it operational, specify observable procedures: predictions recorded before outcomes, independently checkable measurements, tests of measurement error, revision triggers, out-of-sample evaluation, and ways to reconsider background assumptions. None alone guarantees truth.

**Yes, a fully answerable model can be systematically wrong**, in the procedural sense. For example, a model may faithfully learn from measurements carrying an undetected offset, or use a misspecified family while responding correctly to every available diagnostic. More exposure helps only if it can reveal the particular failure.

The formal soundness results are stronger because their premises are stronger. They require actuality to survive both the background and the evidence. Conditional on those premises and actual-world inclusion, deductive consequences are true. They do not establish that answerability itself secures those premises.

“Outside” also needs a boundary. An experiment designed by the holder produces evidence through interaction with the world; a copied rumour may arrive from outside without providing independent evidence. A hardware check may be internal to an organization but external to the model component under test. Replace “evidence it did not produce itself” with evidence whose outcomes are not fixed merely by the claims being tested.

Finally, the opening philosophical assertions exceed the argument. Conflicting certainties cannot both be correct, but this does not establish that every intelligence experiences a model as reality, that every holder literally is a model, or that nothing signals drift. Restrict the claim to fallible representations. No phenomenology needs to be attributed to cells or AI systems.

### 2.3 The sharpness rule hides substantive choices

The formal rule is exact once L is given. But L is not given by uninterpreted reality:

L at time n = B intersected with all E_i for i < n.

The choice of W determines what can be represented; B determines what is admitted before evidence; E determines how observations become constraints. Reliability, measurement error, causal interpretation and granularity all enter here. An incorrect B can exclude actuality before the first observation.

Consequently, identical raw observations do not entail identical live sets. The theorem about shared evidence actually assumes the same L. It says nothing about disagreement over background assumptions, likelihoods or interpretation.

**Support is not strength of evidence.** Consider two hypotheses that a coin has head probability 0.2 or 0.8. After eight heads and two tails, both hypotheses remain possible. Their likelihood ratio is 4096 in favour of 0.8. With equal prior odds, its posterior probability is 4096/4097, approximately 0.999756. There has been substantial learning with no elimination of either hypothesis. This is my illustrative calculation, not a repository result.

A model that assigns 0.999 to an event and one that assigns 0.5 can have identical support. Requiring nonzero probabilities does not calibrate either model. In continuous distributions, every singleton may have probability zero while lying inside the support. Uniform probability on [0,1] is the elementary example. The note's pointwise no-zero rule therefore cannot be its general probabilistic extension.

Ordinary Bayesian conditioning preserves prior zero-probability events when the conditioning event has positive probability; dominated likelihood updating has an analogous restriction. That is a result about an update operation, not a prohibition on revising a prior, changing a model family, or retaining a continuous support. Lindley's discussion states the positive-denominator condition explicitly [S2].

**Sharpness is not compression.** Set inclusion measures neither description length nor computational cost. A singleton containing an incompressible string is maximally specific but expensive to describe. The set of all strings is broad and easy to describe. Predictive compression may be valuable, but requires a coding scheme, a distribution and a complexity measure absent here.

### 2.4 Adding possibilities and recovering discarded ones

The limitation is acknowledged in §11. That is appropriate for a narrow elimination model, but insufficient for a general definition of correctable modelling.

Two separate operations are missing:

- **Belief revision:** restore a possibility already in W but previously excluded by K, B or an accepted observation.
- **Representational expansion:** extend W or the modelling language to express a possibility never represented.

The first does not require the second. With W = {a,b}, an agent may initially hold K = {b}, then retract its mistaken premise and adopt {a}. This is correction within the same W.

The function follow cannot do that because it is defined to intersect new constraints with the original K. The inability to recover is built into that operator. It is not a theorem that following evidence, in the ordinary sense, can never recover an excluded possibility.

There is a deeper mismatch: the prose's openness means correction remains possible; Open K L only means L is contained in K **now**. A completely frozen holder can satisfy it today. A revisable but mistaken holder can fail it today. Neither implication between the two meanings is established.

AGM belief revision directly addresses changing accepted beliefs, including contraction [S3]. The minimum repair is to distinguish monotone evidence accumulation from revision, and to define correctability separately in terms of observations, available update operations and reachable corrected states.

A changing environment adds another issue. If w is a complete world history, learning can narrow hypotheses about a changing trajectory. If w is a current state, accumulating old state observations as timeless constraints can create contradictions. The file does not specify which interpretation supports its claims about keeping up with a moving world.

### 2.5 Values, identity and direction of fit

The distinction between reporting what is and seeking what ought to be is coherent. A preference is not, by itself, evidence that its desired outcome has occurred.

The proposed separation is too architectural. Values legitimately determine which questions to ask, which errors matter, which variables to measure, what resolution to use, and how much to spend. A flood model serving evacuation decisions needs different detail from one serving ecological monitoring. This is selection of purpose and scope, not corruption.

Self-models contain factual claims about abilities, bodies and likely behaviour; these can be part of the world model. Desires and identities are also facts to be modelled where relevant. The descriptive claim “this person wants X” must be distinguished from endorsing X.

Anscombe's shopping-list example supports a difference in the role of a representation, not a proof that cognition requires separate containers [S4]. Predictive-processing proposals explicitly couple perception, action, attention and bodily regulation [S5–S7]. They are relevant alternatives, not established proof of one universal architecture.

Replace “none may overwrite it” with: **preferences may guide inquiry and action, but must not by themselves count as evidence for factual conclusions; their influence on assumptions and decisions should be visible.**

## Part 3. The formal layer

### 3.1 Audit of every result

The file contains **23 theorem declarations in total: 22 general results and one witness**. The note's “23 results and a witness” is an off-by-one description if read as 24.

By inspection, the proofs implement elementary predicate/set reasoning. I found no counterexample to a theorem's actual statement. The principal problems are interpretation, omitted assumptions, and the distance between the defined objects and the prose. Compilation was not independently performed.

Here K and L denote sets of worlds; a denotes the actual world; entailment means truth at every world in K.

| # | Result | What it establishes; match or mismatch |
|---|---|---|
| 1 | world_model_iff_matches_evidence | Open and Sharp are equivalent to pointwise K = L. Exact, but this is mutual inclusion unpacked. It does not establish answerability or predictive function. |
| 2 | reliable_evidence_keeps_actual | If B contains a and every E_i is true at a, Live contains a at any finite n. Exact. Both reliability and adequate background are premises; assuming all future E_i is stronger than needed for a particular n. |
| 3 | open_model_keeps_actual | Adds L ⊆ K to result 2 and obtains a ∈ K. Exact conditional inclusion; not a procedural guarantee that an empirically “open” agent retains actuality. |
| 4 | open_entailment_is_sound | If L ⊆ K, a ∈ L and K entails P, then P(a). Exact. No simulation, action, costs or mistakes are represented. |
| 5 | sharper_entails_more | K' ⊆ K implies every consequence of K is a consequence of K'. Exact, with “more” meaning at least as much. K' may be empty or exclude a; safety and usefulness do not follow. |
| 6 | vague_model_is_open | The universal set contains L. Exact for the maximally uninformative support. No practical harmlessness claim follows. |
| 7 | vague_model_sharp_iff_nothing_ruled_out | The universal set is contained in L iff L is universal. Exact. It is not about every partially vague model. |
| 8 | vague_entails_only_the_universal | K = W entails P iff P is true at every w. Exact by unfolding. Universal truths can be useful; the theorem has no utility measure. |
| 9 | ruled_out_stays_ruled_out | follow K E n is a subset of the original K, so excluded worlds remain excluded. Exact for follow; false as a claim about all evidence-responsive revision. |
| 10 | oversharp_model_never_recovers_actual | If K excludes a, follow excludes a forever. Exact. The reliability hypothesis is unused. Over-sharpness alone is not the premise: exclusion of actuality is. |
| 11 | following_evidence_keeps_world_model | Starting with K equal to Live at zero, intersecting both with the same evidence preserves equality. Exact invariant. Reliability is not required, so equality can be preserved while both sets lose actuality or become empty. |
| 12 | fixed_model_is_world_model_only_if_nothing_learned | If K equals both L1 and L2, then L1 = L2. Exact. There is no variable for wishes or cause of fixation, no temporal ordering, and no probabilistic notion of learning. |
| 13 | shared_evidence_shared_world_model | If K1 and K2 equal the same L, they equal each other. Exact. Same raw evidence does not establish same L, background or interpretation. |
| 14 | pooled_is_sharper | L1 ∩ L2 is contained in each input. Exact weak inclusion. The prose's “fewer” and “sharper than any” incorrectly suggest a strict gain. Identical or nested inputs can yield equality with an input. |
| 15 | pooling_entails_more | A consequence of either input is a consequence of their intersection. Exact. An empty intersection entails everything, so this alone is not a gain in usable knowledge. |
| 16 | pooled_keeps_actual | If both inputs contain a, their intersection contains a. Exact. The formal premises concern actuality, not an empirically established source-reliability process. |
| 17 | one_false_source_excludes_actual | If the second input excludes a, the intersection excludes a. Exact under mandatory conjunction of contributions. It does not cover all collective aggregation. |
| 18 | many_pooled_keeps_actual_iff_each_does | The finite intersection contains a iff every included input does. Literally Iff.rfl: the definition of poolMany restated. |
| 19 | open_contribution_keeps_actual | Result 3 applied to a contribution C. Exact with reliable evidence and B(a); not an independent new mechanism. |
| 20 | hygienic_pool_entailment_is_sound | If every input contains a, every consequence of their intersection holds at a. Exact by applying the entailment premise. It does not model testing plans or replacing real-world trials. |
| 21 | one_oversharp_contribution_makes_pool_deny_actual | If an included C_j excludes a, the pool entails w ≠ a. Exact. The excluded a need not be identifiable by the agent. The pool may be empty. No real-world action or harm follows without additional structure. |
| 22 | vague_contribution_adds_nothing | Appending the universal contribution leaves the intersection unchanged. Exact identity law. Not a claim about partially vague reports, communication costs or diluted attention. |
| 23 | world_model_witness | A concrete example realizes the intended contrast and non-recovery under follow. Useful as a satisfiability example. Technically W is Nat with B(w) meaning w ≤ 2, so there are three background-admissible worlds, not a three-element world type; the universal vague model includes all naturals. |

The source comments themselves sometimes overreach: “Never wrong, and useless” after result 8, “the mistake is made in reality” after result 21, and “harmless, and useless” after result 22 are not formal conclusions.

### 3.2 What is built into the definitions?

Most of the work is done before the proofs:

- Exact evidential fit is imposed by defining IsWorldModel as both inclusions.
- Non-recovery is imposed by defining follow as intersection with the initial model.
- Individual veto over collective possibility is imposed by defining pooling as conjunction.
- Soundness is obtained by requiring actuality to belong to the relevant possibility sets.

These are legitimate definitions for a small deductive model. They are not independent findings about cognition.

The maintenance invariant, witness and propagation lemmas do slightly more than unfold a single definition: they connect the definitions or exhibit an instance. None provides a substantive result about actual learning systems, forecast quality, institutional design or persistence. Simplicity is not a defect; advertising the consequences as broader than the premises is.

**A missing guard:** if L is empty, K = L qualifies as a world model and entails False. Requiring a live actual world prevents this in the soundness results, so this is not a refutation of those results. It is a defect in using IsWorldModel alone as a definition of a good model. Add a consistency/nonemptiness condition or an explicit inconsistent-evidence state that suspends ordinary endorsement and triggers revision.

### 3.3 Intersection versus other collective models

Intersection is appropriate when combining compatible hard constraints in a shared language and treating every accepted constraint as binding. It is not a neutral account of combining fallible testimony, forecasts or institutions.

The following contrasts are elementary consequences of the stated pooling rules; they are not new empirical claims. Linear and logarithmic pooling are established alternatives [S8].

| Aggregation | Treatment of one source that excludes actuality |
|---|---|
| Hard intersection | A single accepted exclusion necessarily excludes actuality. |
| Linear probability pool, q = Σ α_i p_i, nonnegative weights summing to one | A positive-weight source assigning actuality positive mass keeps positive pooled mass even if another assigns zero. This statement concerns discrete hypotheses/events, not singleton masses in continuous distributions. |
| Logarithmic pool, q proportional to ∏ p_i raised to α_i | A positive-weight zero is a veto when the normalization exists. The note's fragility survives this rule. Conflicting supports can prevent normalization. |
| Majority vote on one binary claim | One erroneous vote need not defeat a correct majority; it can be decisive near a tie. Correlation and competence matter. |
| Robust aggregation with rejection or bounded influence | A bad report may be discounted or have limited influence. Protection depends on assumptions about contamination and how weights or exclusions are chosen. |
| A pluralistic record with provenance | Contradictory reports can coexist as attributed reports without both being endorsed as facts. |

For a numerical example, probabilities 0.9, 0.9 and 0 for a particular hypothesis average to 0.6. The third contributor reduces confidence but does not eliminate the hypothesis. This directly refutes the universal claim about one contributor.

There is no universally best replacement. Arithmetic pooling can dilute strong evidence; voting can bury a correct minority; rejecting outliers can suppress discoveries; multiplying likelihoods can double-count shared evidence. The right design depends on source errors, dependencies and the decision problem.

There is also a statistical aggregation problem even without dishonesty. Suppose 100 independent confidence sets each cover a fixed true parameter with probability 0.95, and a collective treats their intersection as its admissible set. Its coverage is 0.95^100, approximately 0.00592. Honest individual 95% coverage is not jointly reliable hard evidence. Confidence sets are not literal impossibility sets; treating them as such is the error.

Nor is actual-world exclusion equivalent to over-sharpness. A contribution may equal its own misleading live set and exclude actuality; another may be over-sharp but accidentally retain actuality. Reliability and sharpness are distinct axes.

**What survives:** if every contribution retains actuality, intersection retains it; if a contribution is accepted as an irrevocable hard constraint and excludes actuality, the intersection loses it. More generally, unsupported certainty can cause costly collective errors. The broader design lesson is to make aggregation tolerant of fallible contributors, not merely to require perfect contributor hygiene.

CORE.md already discusses a mixture that preserves possibilities supported by either participant. This note should distinguish that operation from conjunction and explain when each is appropriate.

### 3.4 Lean build status

The pinned lean-toolchain specifies **leanprover/lean4:v4.33.0**. Neither lean nor elan was available on PATH, and no Lean executable was present at the checked standard locations. **I did not compile the file and do not independently certify a Lean build or an axiom audit.**

The PR reports a local build, but that is the author's report, not this review's verification. I inspected all 23 theorem declarations and their proofs; no sorry or axiom declaration appears in this file. That inspection is not a substitute for a kernel check.

## Part 4. The claims around it

### 4.1 Making mistakes in a model rather than reality

This is a good motivation for simulation and planning, not a complete definition or a consequence of the present formalization.

The soundness theorem has no proposed action, state transition, intervention, imagined failure, resource expenditure or deployment outcome. To establish the claimed substitution, the model needs a bridge between simulated and actual action consequences, plus the cost of modelling and validation.

A predictive association is not enough: forecasting outcomes under the existing policy need not identify what would happen if the policy changed. Likewise, a simulation only exposes failures represented by its assumptions. It can make an incorrect action look safe.

The note also omits explanation, diagnosis, reconstructing past events, designing measurements and discovering missing variables as values of modelling. “Mistakes in a model” captures only part of their value.

Several subsidiary claims should change:

- Sharpening a sound possibility set can weakly expand actions certified safe under a fixed safety predicate. It need not add any action, and the file contains no action space. Call this an interpretation requiring a bridge, not literally more freedom.
- People choose under risk; they need not see an option as safe before choosing it.
- Maintaining a dependency does not always require representing it. A fixed automatic process can maintain a resource in suitable conditions. The universal “cannot be carried out without a world model” is unsupported unless “model” is broadened until ordinary regulation counts.
- CORE.md acknowledges that listening can cost more than it gains. The note's upkeep instructions should preserve that qualification.
- Disagreement does not imply separate realities or leave force as the only settlement. People can negotiate, arbitrate, experiment, coordinate around shared predictions, or tolerate unresolved disagreement. Delete the “only by force” sentence.
- A laboratory experiment still happens in reality. The distinction is often controlled, smaller-scale exposure versus uncontrolled deployment, not model versus reality.
- A prediction under no intervention is not refuted merely because intervention prevents its outcome. But prevention also does not verify that counterfactual forecast. The note should preserve both directions of that distinction.

### 4.2 Does the definition scale?

| Holder | Assessment |
|---|---|
| A cell or simple organism | Possible as a carefully specified operational analogy. Responsiveness alone does not demonstrate representation, counterfactual modelling, or the ability to reconsider claims. Reflective awareness and an explicit truth-directed aim do not map without further argument. |
| An immune system | The proposed failure mapping fails as stated. Autoimmunity is not shown to be irreversible exclusion of a possible world, and harmful tolerance is not the universal set of possibilities. The note confuses response policies with epistemic content. Self/non-self is also not a complete account of immune regulation; Matzinger's work is a relevant challenge, not a replacement theory proved here [S9]. |
| An animal or person | Plausible for predictive representations. Much modelling is implicit and does not meet the requirement of knowing it is a model. Distinguish having a model from practising reflective inquiry. |
| A team | Plausible with specified records, communication and revision procedures. Distributed complementary knowledge need not be what everyone holds in common. |
| An institution or society | Plausible as an ecosystem of models and evidence practices; stretched as one coherent belief set. Preserve disagreement, provenance, division of expertise and fallible gatekeeping. |
| An AI system | Concrete learned world models exist [S1]. Weights, context and tools do not automatically amount to one consistent model. Specify whether correction occurs in context, memory, tools, retraining, or the maintaining organization. |
| A collective of humans and AI | Plausible as an organized modelling process. Requires translation, source tracking, error-aware aggregation and correction rights. The intersection theorem does not establish this mapping. |

The §11 caveat that mappings must be shown is correct. It should govern the claims where they first appear. The opening assertion that the same account holds for a cell and a society is stronger than the demonstration.

### 4.3 Vagueness is not harmless

The theorem proves only that adding the universal constraint changes no intersection.

A vague report can consume limited attention, conceal a relevant observation, prevent timely decisions, obscure accountability or dilute a signal under a different aggregation rule. Conversely, cautious uncertainty can be useful: it may honestly communicate measurement limitations or warn that the available model is inadequate.

Even within the formalism, universal entailments can matter. If the represented worlds all satisfy a physical constraint, an action may be safe in every world. What counts as universal depends on W, which was already chosen.

Replace the claim with: **a contribution imposing no constraint does not change a hard intersection; its practical effects and information value require a richer model.**

### 4.4 Deceit and honest overconfidence

I agree only with a narrow statement: **the same accepted content, passed through the same aggregation operation in the same state, has the same immediate formal output regardless of motive.**

I disagree with “differ in blame, not in effect” as a general claim. Deception can involve selecting claims to exploit a target, fabricating provenance, coordinating false reports and blocking correction. Honest overconfidence may be discovered and repaired differently. Either can be persistent or damaging; intention alone does not rank the eventual harm.

The absence of a motive variable does not show that motive has no causal consequences. It shows that those consequences have been omitted.

### 4.5 Audit of all eleven constituent labels

The table actually has ten Follows labels and one If label; none is Proposed. Its introductory “each follows from the definition” is inconsistent even with its own provenance row.

The closing disclaimer that one must first adopt the aim helps, but is insufficient. Many rows require extra conditions beyond wanting a world model. If every recommendation is intended to be conditional on maintaining an empirically useful model within a budget, put that condition above the table and distinguish logical necessities from proposed means.

| Constituent | Assessment and smallest correction |
|---|---|
| 1. Knowing it is a model | Does not follow. A system can update without metacognitive awareness. Change to Proposed for reflective holders, or If explicit self-assessment is part of the chosen practice. |
| 2. Direction of fit | Truth-directed use is part of the prose stipulation; a strict separation into different models does not follow. Keep the functional distinction, qualify the architecture. The fixed-set theorem supplies no proof about motivation. |
| 3. Exposure | Useful as a proposed testing practice for empirical claims. The theorem about universal entailments does not show that every useful claim is individually falsifiable or that the holder must verbalize a falsifier. Qualify the claim type and observability assumptions. |
| 4. Open routes | Conditional on correcting the relevant errors, feasible detection, and affordable access. Keeping a necessary route and actively searching every time are different requirements. Label If and state the cost condition. |
| 5. Independent sources | Valuable conditional protection against shared errors. Account for dependencies rather than demand absolute independence. A dependable copy can transmit evidence new to a recipient even when it is not a second independent observation. Label If. |
| 6. Provenance | The existing If is appropriate. Exhaustive provenance for every internal component is not always feasible; specify what is needed for consequential claims and revisions. |
| 7. Calibration | K = L follows from the stipulated definitions. Statistical calibration and the universal no-zero rule do not. Rename the formal property evidential fit; add calibration as a separate evaluable criterion. |
| 8. Coherence | Under classical semantics, P and not-P cannot both be true of the same world in the same respect. That logical part follows. Diagnosing and resolving contradictions is a practice; attributed disagreement is not itself inconsistent endorsement. |
| 9. Scope | Explicit scope is good practice, not implied by support equality. Extrapolation is not automatically over-sharp if justified by structural assumptions. Label If and require those assumptions and uncertainty to be stated. |
| 10. Including oneself and others | Does not follow for every model. Self, substrate and other agents matter when they affect the questions or interventions modelled. Label If those dependencies are decision-relevant. |
| 11. Upkeep | Conditional on environmental change, informative feedback, costs and time horizon. The fixed-model result concerns a changed live set, not change in the world as such. Label If maintaining the model has sufficient expected value. |

## Part 5. Prior art and source verification

The closest predecessors are not only Popper and predictive processing. Statistical sharpness/calibration, belief revision, and alternative pooling rules bear directly on the central claims.

The source descriptions below report what I checked, not a claim to have reviewed each literature exhaustively. Interpretations of their implications for this note are my assessment. I use no unchecked direct quotations.

| Work | What was checked | Should the note cite it, and does it change a claim? |
|---|---|---|
| Ha & Schmidhuber, World Models (2018) [S1] | Authors' interactive paper, abstract and model description. | **Yes.** Supplies established technical usage and an operational example of learning through simulation. It makes the note's narrow normative use of “world model” a choice needing disclosure. |
| Lindley, Understanding Uncertainty (2006), §6.8, pp. 90–92 [S2] | Primary book discussion of Bayes' rule and Cromwell's rule. | **Yes.** The zero-probability preservation result is established. Its update assumptions must remain visible; it does not validate treating every continuous point of probability zero as excluded. |
| Alchourrón, Gärdenfors & Makinson (1985) [S3] | Original publisher abstract and bibliographic details; full article proofs not checked. | **Essential.** Contraction and revision expose the limitation of monotone intersection. Changes the general non-recovery claim to an operator-specific one. No particular AGM representation theorem is independently audited here. |
| Anscombe, Intention (1957; second-edition scan), §32, p. 56 [S4] | The shopping-list/detective passage visually checked in the scan. | **Yes.** Supports the role-based distinction. Does not establish separate cognitive modules or exclusion of values from problem selection. The passage also allows that the shopping list itself may be mistaken. |
| Friston (2010) [S5] | Primary review's abstract, generative-model discussion and treatment of action/perception. | **Yes, as a neighbouring proposal.** Connects adaptive persistence and modelling, but couples action and inference rather than proving the note's separation. It is not empirical validation of all scale mappings. |
| Clark (2013) [S6] | Primary article, especially §§2.5, 3.3–3.4 on architecture, action and situated cognition. | **Yes.** Challenges the idea that action-oriented modelling is simply another kind to keep apart. It also explicitly leaves architectural and empirical questions open. |
| Seth (2013) [S7] | Author's abstract indexed in PubMed; full paper not checked. | **Yes if retaining the emotion/self-model discussion.** Interoceptive inference is a concrete alternative to sharp separation between feeling, self and predictive modelling. Broad framing verified; detailed mechanisms not independently assessed here. |
| Popper, Conjectures and Refutations (1963), chapter 1 [S10] | Primary-text excerpt covering risky predictions, empirical prohibition and falsifiability. | **Yes.** Much of the emphasis on exposure and ruling possibilities out is established. Popper's distinction between scientific status and truth supports distinguishing a testable but false model from no model at all. The specific “theories die in our place” attribution was not located in a primary passage during this review and remains **unverified here**. |
| Goldman, Experts: Which Ones Should You Trust? (2001), especially §4 [S11] | Primary article's discussion of consensus, copied opinion and conditional independence, pp. 97–102. | **Yes.** Directly anticipates counting origins instead of copies and assesses when agreement adds warrant. It supplies a more discriminating account than the number of connected sources alone. |
| Aumann, Agreeing to Disagree (1976) [S12] | Original paper's theorem and assumptions, p. 1236. | **Yes, as a contrast.** The theorem needs common priors and common knowledge of posteriors; private information can differ. The note's same-L identity is much weaker and must not be presented as general convergence from shared observations. |
| Condorcet tradition; Boland, Majority Systems and the Condorcet Jury Theorem (1989) [S13] | Boland's original research abstract, stating the classical assumptions and its generalizations. Condorcet's 1785 text not checked. | **Yes.** Under independence and equal competence above one-half, majority reliability improves with odd group size. Demonstrates why a collective can tolerate individual errors. These assumptions do not establish universal crowd wisdom. |
| Gneiting, Balabdaoui & Raftery, Probabilistic forecasts, calibration and sharpness (2007) [S14] | Primary paper, abstract and §2.4. | **Essential.** Its explicit formulation is “maximizing the sharpness of the predictive distributions subject to calibration.” This is a close predecessor to the central maxim, with operational diagnostics. The paper distinguishes calibration notions and states a broader equivalence as a conjecture; do not inflate that into a universal theorem either. |
| Gneiting & Raftery, Strictly Proper Scoring Rules, Prediction, and Estimation (2007) [S15] | Primary paper's definitions and introduction. | **Essential for the proposed checklist/test.** Strict propriety encourages honest reporting under expected-score maximization. It provides a route to measuring forecast performance, while not making a forecaster's beliefs true or making every real incentive system honest. |
| Neyman & Roughgarden, From Proper Scoring Rules to Max-Min Optimal Forecast Aggregation (2023 version) [S8] | Primary paper's §§1.1–1.2, linear/logarithmic formulas and abstract. | **Yes.** Demonstrates that aggregation is a substantive design choice. The note's one-source veto holds for some pooling rules and fails for others. |
| Genest & Zidek, Combining Probability Distributions (1986) [S16] | Bibliographic identity checked through institutional records and publisher search; full article not retrieved successfully. | **Recommended as historical pooling literature.** Detailed assertions about its theorems remain **unverified here**; the pooling comparison above relies on explicit algebra and [S8], not an unread paper. |

### Sources

**[S1]** Ha, D., & Schmidhuber, J. (2018). World Models. [Authors' article](https://worldmodels.github.io/); [arXiv:1803.10122](https://arxiv.org/abs/1803.10122).

**[S2]** Lindley, D. V. (2006). Understanding Uncertainty. Wiley. §6.8. [Book text](https://www.al-edu.com/wp-content/uploads/2014/05/Lindley-D.V.-Understanding-uncertainty-2006.pdf); [publisher](https://doi.org/10.1002/0470055480).

**[S3]** Alchourrón, C. E., Gärdenfors, P., & Makinson, D. (1985). On the logic of theory change: Partial meet contraction and revision functions. Journal of Symbolic Logic, 50(2), 510–530. [Publisher abstract](https://doi.org/10.2307/2274239).

**[S4]** Anscombe, G. E. M. Intention, §32, p. 56. [Second-edition scan](https://makowski.wdfiles.com/local--files/wprowadzenie-do-analizy-metaetycznej/anscombe.pdf), PDF page index 24. Original publication 1957.

**[S5]** Friston, K. (2010). The free-energy principle: a unified brain theory? Nature Reviews Neuroscience, 11, 127–138. [DOI](https://doi.org/10.1038/nrn2787); [text checked](https://activeinference.github.io/papers/unified.pdf).

**[S6]** Clark, A. (2013). Whatever next? Predictive brains, situated agents, and the future of cognitive science. Behavioral and Brain Sciences, 36(3), 181–204. [Article](https://doi.org/10.1017/S0140525X12000477).

**[S7]** Seth, A. K. (2013). Interoceptive inference, emotion, and the embodied self. Trends in Cognitive Sciences, 17(11), 565–573. [Author abstract](https://pubmed.ncbi.nlm.nih.gov/24126130/); [DOI](https://doi.org/10.1016/j.tics.2013.09.007).

**[S8]** Neyman, E., & Roughgarden, T. From Proper Scoring Rules to Max-Min Optimal Forecast Aggregation. Version 2, August 2023. [Primary paper](https://arxiv.org/pdf/2102.07081).

**[S9]** Matzinger, P. (1994). Tolerance, danger, and the extended family. Annual Review of Immunology, 12, 991–1045. [Author abstract](https://pubmed.ncbi.nlm.nih.gov/8011301/); [DOI](https://doi.org/10.1146/annurev.iy.12.040194.005015). Used only for its stated challenge to a simple self/non-self account, not as a full review of immunology.

**[S10]** Popper, K. R. (1963). Conjectures and Refutations, chapter 1. [Primary-text excerpt checked](https://tildesites.bowdoin.edu/~j.knockel/falsification/).

**[S11]** Goldman, A. I. (2001). Experts: Which Ones Should You Trust? Philosophy and Phenomenological Research, 63(1), 85–110. [Primary article](https://kutrov.web.elte.hu/tudhat/11_goldman.pdf); [DOI](https://doi.org/10.1111/j.1933-1592.2001.tb00093.x).

**[S12]** Aumann, R. J. (1976). Agreeing to Disagree. Annals of Statistics, 4(6), 1236–1239. [Original paper](https://www.haverford.edu/sites/default/files/Aumann1976.pdf); [DOI](https://doi.org/10.1214/aos/1176343654).

**[S13]** Boland, P. J. (1989). Majority Systems and the Condorcet Jury Theorem. The Statistician, 38(3), 181–189. [Publisher abstract](https://academic.oup.com/jrsssd/article-abstract/38/3/181/7122472); [DOI](https://doi.org/10.2307/2348873).

**[S14]** Gneiting, T., Balabdaoui, F., & Raftery, A. E. (2007). Probabilistic forecasts, calibration and sharpness. JRSS B, 69(2), 243–268. [Primary paper](https://sites.stat.washington.edu/raftery/Research/PDF/Gneiting2007jrssb.pdf); [DOI](https://doi.org/10.1111/j.1467-9868.2007.00587.x).

**[S15]** Gneiting, T., & Raftery, A. E. (2007). Strictly Proper Scoring Rules, Prediction, and Estimation. JASA, 102(477), 359–378. [Primary paper](https://sites.stat.washington.edu/people/raftery/Research/PDF/Gneiting2007jasa.pdf); [DOI](https://doi.org/10.1198/016214506000001437).

**[S16]** Genest, C., & Zidek, J. V. (1986). Combining Probability Distributions: A Critique and an Annotated Bibliography. Statistical Science, 1(1), 114–135. [Publisher record](https://doi.org/10.1214/ss/1177013825). Full text unverified in this review.

## Part 6. Verdict

### 6.1 Comparison with Part 0

The note made two concerns more explicit than my starting answer: that contributors must maintain correction after passing information on, and that the resources and institutions sustaining shared evidence matter. My initial answer included provenance and error examination but did not articulate that maintenance burden.

My starting definition retained features the note loses: imperfect models remain models; inference can be probabilistic without ruling hypotheses out; useful abstraction depends on scope and purpose; and a model needs representational and predictive structure, not only a set of admissible worlds.

I would retain those features. The note has sharpened the social-maintenance emphasis, but has not justified replacing a descriptive definition with an ideal of evidential discipline. Because the baseline was not blind, this comparison is a transparent account of the recorded starting position, not evidence of an uncontaminated before/after effect.

### 6.2 Release verdict

**NOT READY** to open the core of v23.0.

It could remain a clearly scoped research note on evidence-compatible possibility sets and the risks of hard-conjunctive aggregation. Making it the general opening definition would transfer too much authority from elementary formal implications to unsupported claims about learning, agency, collective reasoning and cognition.

The note acknowledges limitations, but several headline statements contradict those limitations. A later disclaimer does not repair an earlier universal claim.

### 6.3 The five most important problems, ranked

| Rank | Where and claim | Why it fails or overreaches | Smallest adequate repair |
|---|---|---|---|
| **1** | §§2–3, 8; IsWorldModel: a world model exists only when open and exactly matched to live possibilities. | Conflates a representation, a maintenance practice and ideal set equality. Static Open does not express correctability. Empty evidence/model sets qualify. | Separate the three terms. Define world model descriptively; make evidential fit and correctability distinct properties. Add consistency handling. |
| **2** | §§2–3; ruled_out_stays_ruled_out and oversharp_model_never_recovers_actual: exclusion makes a belief uncorrectable. | Non-recovery is built into follow. Retraction can restore an existing possibility. Over-sharpness need not exclude actuality. | Say “cannot recover under this monotone update rule”; distinguish revision from representational expansion; restrict the actuality claim to its actual premise. |
| **3** | §§6–7: one over-sharp contributor corrupts the collective; contributor hygiene is therefore necessary. | Necessity depends on accepting every input as a hard veto. Other pools tolerate a wrong input; even calibrated fallible inputs can make hard intersection unreliable. | Rename the result as a hard-intersection fragility result, add an explicit alternative, and state that contributor quality and aggregation robustness jointly matter. |
| **4** | §3 and constituent 7: set sharpness supplies calibration, meaningful learning and compression. | Equal support permits radically different credences; continuous singleton zeros are not exclusions; set specificity is not code length. | Limit the theorem to support constraints. Add separate probabilistic evaluation, representation and complexity concepts; cite forecasting sharpness/calibration. |
| **5** | Opening, §§5–8: simulation replaces real mistakes, all scales fit, disagreement leaves force, and ten constituent duties follow. | No action/cost semantics supports the simulation claim; biological mappings are not established; the force claim is false; several duties require extra aims and resource assumptions. | Recast applications as conditional interpretations, delete the force claim, qualify biological examples, and relabel practices with their actual conditions. |

### 6.4 What is new?

I found **no demonstrated new mathematical result** in these 23 declarations, and no basis for claiming novelty for the central sharpness maxim, falsifiability, direction of fit, source-dependence warning or zero-prior phenomenon.

This is not a claim that an exhaustive literature search proves the absence of novelty. It is the narrower finding that the elementary results and checked predecessors do not support an originality claim.

The possible contribution is the synthesis: describing maintained, correctable modelling as a shared resource, linking contributor conduct to institutional maintenance and persistence, and making some assumptions machine-checkable. Its value would have to be demonstrated through clearer distinctions, useful operational measures, and applications that outperform existing accounts. Formalizing the chosen definitions supplies auditability, not that demonstration.

### A replacement opening that would avoid the main errors

> A world model is a representation of aspects of the world that supports inference about what is unobserved, what may happen, and what would happen under different actions. It may be incomplete or mistaken. Good world modelling makes assumptions and uncertainty explicit, tests relevant predictions against evidence, and permits both beliefs and the space of possibilities to be revised. Seek informative predictions without overstating what the evidence supports. In collective modelling, preserve provenance and uncertainty, account for dependence between sources, and use aggregation and correction procedures that can tolerate individual error. These practices improve the prospects of useful decisions; they do not guarantee truth or eliminate the need to learn in the world.

This replacement is a proposed formulation, not a theorem. The existing Lean file can accompany it as a deliberately narrow model of hard constraints, with the interpretation corrections above.
