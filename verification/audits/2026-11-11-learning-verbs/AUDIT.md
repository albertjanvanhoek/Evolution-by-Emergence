# Independent literature audit: learning verbs

**Reviewer:** an assistant from a model family other than the one that wrote the work.  
**Date:** 11 November 2026.  
**Status:** a dated judgment, not a proof of priority. This is a literature and scope audit, not a review of the Lean proofs or their compilation.

## Headline

This body of work is mainly a small formal reconstruction of candidate elimination, observational indistinguishability, learning about methods, and elementary resource accounting, with ethical and legal interpretations attached. Most substantive ideas have clear antecedents; the exact resource ledger was not found in the sources examined, but its conclusions largely follow from its stipulated prices and transitions. Several claims exceed their formal support, including general necessity of the seven verbs, the mapping from unsuccessful learning to sins, and an unqualified claim that false correction blocks later learning. The legal quotations are substantially sound, while the contrast with existing private-law thinking and the historical explanation of paternalism are overstated or insufficiently sourced.

## Scope and evidence

The audited repository is `albertjanvanhoek/Evolution-by-Emergence`, at commit [`342d7c98c7f76bfec50b529089094dde265126af`](https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/342d7c98c7f76bfec50b529089094dde265126af), the inspected head of PR 149. The findings concern that snapshot, including the corrections recorded in D43–D46, rather than earlier wording or subsequent revisions.

The requested reading order was followed: the fifteen-section learning note; the three modules' headers, definitions and theorem statements; the creed; the legal note; D39–D46; then the core and earlier-audit overview for context. Proof bodies were not independently checked. The two counterexamples below are direct evaluations of definitions, not claims that a proved theorem is false.

Repository references used throughout:

- **S1:** Repository contributors (2026), [*Learning decomposition*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/research/discovarianism/LEARNING_DECOMPOSITION.md), research note.
- **S2:** Repository contributors (2026), [*LearningVerbs.lean*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/formalization/cumulative-accessibility/CumulativeAccessibility/LearningVerbs.lean), formalization module.
- **S3:** Repository contributors (2026), [*LearningRatchet.lean*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/formalization/cumulative-accessibility/CumulativeAccessibility/LearningRatchet.lean), formalization module.
- **S4:** Repository contributors (2026), [*LongCollaboration.lean*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/formalization/cumulative-accessibility/CumulativeAccessibility/LongCollaboration.lean), formalization module.
- **S5:** Repository contributors (2026), [*The Discovarian creed*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/research/discovarianism/CREED.md), especially “The verbs of learning” and “Sins.”
- **S6:** Repository contributors (2026), [*Fallible is not incompetent: a person as the holder of a correctable model*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/research/relational-duties/FALLIBLE_NOT_INCOMPETENT.md), legal concept note.
- **S7:** Repository contributors (2026), [*DIALOGUE.md*, D39–D46](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/DIALOGUE.md), development record. Context: [*CORE.md*](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/CORE.md) and [September audit overview](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/342d7c98c7f76bfec50b529089094dde265126af/verification/audits/2026-09-15-literature/README.md).

The search used approximately forty targeted queries and source follow-ups, stopping within the brief's order-of-magnitude budget. This was not a systematic review. Original texts, official instruments and author/publisher records support the references below; publisher abstracts are explicitly identified where the full work was unavailable. A reproduction of an original text can be primary evidence of that text: a publisher's domain is not what makes Mill's own words a primary source.

## Verdict table

Verdicts apply to the numbered claims as worded in the brief. **Defective** can mean that the interpretation is defective while the named conditional theorem remains intact. **Not found** means no close antecedent was located within this search, not that priority has been established. A thematic resemblance is not treated as an exact antecedent.

| Claim | Verdict | Closest verified prior work | What differs |
|---|---|---|---|
| 1 | **defective** | Mitchell 1977 [R1] | Candidate elimination is familiar; joint sufficiency holds as stated, but general individual necessity does not follow and has a counterexample. |
| 2 | **special case** | Halpern and Moses 1990 [R2]; Rothenberg 1971 [R3] | Restricted identical information cannot certify a difference in actuality; this is not a general ban on checking instruments. |
| 3 | **special case** | Rothenberg 1971 [R3]; Halpern and Moses 1990 [R2] | Fixed observational equivalence persists under repeated filtering; an additional separating observation breaks it. |
| 4 | **special case** | Mitchell 1977 [R1]; Halpern and Moses 1990 [R2] | False hard evidence can exclude the target; identical receiver inputs imply identical verdicts, not universal distrust of testimony. |
| 5 | **special case** | Halpern and Moses 1990 [R2]; Csibra and Gergely 2009 [R17] as a looser teaching antecedent | Adding an operation refines distinguishability; the formal result does not model pedagogy or eliminate the value of repeated execution. |
| 6 | **special case** | Knight and Leveson 1986 [R6]; National Academies 2019 [R7] | Deterministic execution agreement is much narrower than empirical replication; independence is not formalized. |
| 7 | **special case** | Mitchell 1977 [R1]; Quine 1951 [R8]; Schmidhuber 1987 [R9] | Apply elimination to candidate functions; ambiguity between world and instrument follows when both explanations fit. |
| 8 | **restatement** | Katsuno and Mendelzon 1992 [R5] | The distinction between correcting beliefs about a fixed world and updating for world change is already explicit. |
| 9 | **not found** | Kelly 1956 [R20], Sims 2003 [R18] and Ashby 1960 [R10] are related, not exact antecedents | No exact unit-cost ledger found; its result is a finite cost sum, not a new general law that learning finances itself. |
| 10 | **defective** | Alchourrón, Gärdenfors and Makinson 1985 [R4] | Retraction is familiar; the ledger conflates truth exclusion with a penalty that may be zero. |
| 11 | **restatement** | Elementary disjoint counting; distributed knowledge in Halpern and Moses 1990 [R2] | Two counters are decremented separately by definition; this is not a general additive information or learning-speed theorem. |
| 12 | **special case** | Elementary budget recurrence; Trivers 1971 [R19] is a broader thematic antecedent | Fixed conduct, correction as the only income, and the stipulated conjunction determine persistence. |
| 13 | **restatement** | Ashby 1960 [R10]; Schmidhuber 1987 [R9]; comparison with Legg and Hutter 2007 [R11] | Adaptive and meta-learning capacities are familiar; the proposed definitions do not supply an operational intelligence measure. |
| 14 | **defective** | Cassam 2019 [R14] | Epistemic vice and responsibility already distinguish obstruction from blame; the claimed theorem coverage of every sin is false. |
| 15 | **restatement** | Nedelsky 1989 [R15]; Fricker 2007 [R16]; MCA and CRPD [L5–L7] | Relations enabling autonomous judgment and epistemic participation are established concerns; the proposed legal terminology is not an enacted right. |
| 16 | **defective** | Primary instruments and historical texts [L1–L11] | Most specified textual claims check out; broad claims about private relations, universal appeals and a common historical rationale do not. |

## Part A — Learning as a loop of verbs

### 1. Elimination learning and seven supposedly necessary verbs

**Closest antecedent.** Mitchell's candidate-elimination construction [R1] retains hypotheses consistent with observations. In S2, if the initial possibilities are \(K\), the operation is \(o\), and the record is \(r\), the successful paid turn carries

\[
K'=K\cap\{w:o(w)=r\}.
\]

Truth remains when it starts in \(K\) and the observation and record are correct. A discriminating operation ensures that something is removed. Separating this into observed, recorded, updated and carried states is a bookkeeping decomposition of that familiar argument. `Affords` matters because `Retains` explicitly makes an unpaid turn preserve the old state; payment is not independently derived as necessary to set intersection.

**Defect.** `UpdatesNothing` is one failure mode, not the negation of `Updates`. Likewise, `RetainsNothing` is not the negation of `Retains`. The named blocking results therefore do not establish the unrestricted claim that each verb is individually necessary even when the other six hold.

Here is a counterexample to that stronger claim. Let \(K=\{a,b,c\}\), actual world \(a\), and \(o(a)=o(b)=0\), \(o(c)=1\). Set observed and recorded to 0, paid to true, and both updated and carried to \(\{a\}\). `LeavesOpen`, `Tries`, `Tests`, `Records`, `Retains` and `Affords` hold, and `Learns` holds. `Updates` fails because it also requires retaining \(b\). The turn still learns according to the repository's own definition.

S1 and S2 acknowledge selected failure patterns. That qualification is narrower than the claim in the brief and the module's remaining “each shown to be needed” wording. There is no defect here in `seven_verbs_learn`; there is a defect in turning sufficiency plus selected blocking examples into general necessity.

### 2. What cannot be certified from identical internal information

**Closest antecedent.** Halpern and Moses [R2] model knowledge through alternatives consistent with an agent's local history. Rothenberg [R3] defines observational equivalence through equality of observable distributions. An observation cannot identify which member of an indistinguishable pair is actual.

S2 gives concrete pairs of turns with the same learner-accessible fields but different actual worlds. That is a small deterministic instance of this established structure, not a new impossibility principle.

**Scope.** `Tests` means that an observed value equals the operation's actual value; it does not mean that the learner performed a specified experimental action. `LeavesOpen` means that the actual world is in the candidate set. Neither has an infallible certificate from the restricted fields in the examples. This does not prove that instrument calibration, cross-checking, probabilistic confidence or expanded evidence is impossible. Nor does the model distinguish an inaccessible truth from an alternative that was culpably ignored. Those are further epistemic and ethical questions.

### 3. Blind spots and a different operation

**Closest antecedent.** Statistical identification [R3] asks whether distinct parameter states can be distinguished by observables. The same issue appears as indistinguishable alternatives in epistemic models [R2].

`blind_spot_survives` iterates the elementary fact that intersecting with sets containing both indistinguishable worlds cannot separate them. The premise already quantifies over all the learner's available operations. Another operation can remove the false candidate precisely when the premise of indistinguishability ceases to apply. Repetition does not create missing discriminatory information.

**Difference.** The repository adds the verb vocabulary and an explicit communication path. It does not prove that every learner has a blind spot, that every different learner supplies a useful operation, or that organizational or demographic difference guarantees informational complementarity. The signature's blind candidate is not itself required to differ from actuality; interpreting it as an error adds that condition.

Aumann's agreement theorem [R21] is not this theorem: it concerns common priors and common knowledge of posterior probabilities. Zollman [R22] and Kleinberg–Raghavan [R23] concern specific network and correlation effects, not the proposition that any extra connection necessarily improves inquiry.

### 4. False corrections and the limits of checking them

**Closest antecedent.** If elimination treats a false datum as a hard constraint, the true candidate need not survive [R1]. If a receiver's observation vector and the submitted signal are identical in two scenarios, a verdict computed from those inputs is identical too [R2]. These are the two ingredients of S2's results.

**Difference.** The theorem fixes what evidence the evaluator may use. It does not show that true and false corrections are indistinguishable given every possible investigation. Teaching a new operation, checking the source's track record, or obtaining an independent observation changes the information available.

The module header still says that information about the source “has to” resolve the problem. That conclusion is not established: source information may help, but an additional direct test may also help, and neither guarantees success. Conversely, the creed's broader resistance to source-based weighting is not licensed by this result. Where content cannot be checked directly, source reliability may be evidentially relevant. The source-free and source-only readings both overreach the theorem.

### 5. Receiving an answer and acquiring an operation

**Closest antecedent.** The formal core is refinement of observational distinguishability [R2]. Csibra and Gergely [R17] discuss communication that enables acquisition of generalizable knowledge rather than only learning an episode; this is a relevant teaching antecedent, not an exact mathematical match.

In S2, acquiring an operation extends the operation index type. `after_acquiring_other_adds_nothing` then says that worlds indistinguishable under every operation in the enlarged family cannot be separated by the newly included operation. This follows directly from its inclusion. `own_test_keeps_truth` is the truth-preservation part of candidate elimination under a correct account of the operation.

**Limits.** Neither theorem models teaching effort, skill acquisition, comprehension or successful transfer between differently embodied learners. In S3, a single `differs` flag allows `acquire` to transfer all blind errors into the own-error counter. That is a strong assumption about what one acquired operation can do, not something derived from S2. Developing a new method is not implemented.

The current distinction between losing a difference in methods and retaining the value of another execution is correct. It should not be reported as a proof that a teacher becomes informationally redundant in every respect.

### 6. Replication, disagreement and correlated failure

**Closest antecedent.** Knight and Leveson [R6] directly investigated independently developed implementations and found dependent failures. The National Academies [R7] distinguish computational reproduction using the same materials from replication using new data, whose consistency must allow for uncertainty.

**What S2 proves.** Two deterministic executions represented by the same operation in the same actual world, with correct observations and faithful records, have equal records. Unequal records therefore contradict at least one of those conditions. Equal records do not logically entail correct execution, because both may share an error.

**Limits.** This does not establish that empirical replications should produce identical observations or estimates. Sampling variation is absent. “Honest” is used for equalities, not a modeled intention; a failure can be technical rather than deceptive. Agreement failing to prove truth is different from agreement providing no evidence.

Independence is not a premise or a probabilistic variable in these theorems. Separate execution or separate authorship does not ensure independent errors [R6]. The statement that a second execution *has to be independent* is therefore stronger than the formal result: disagreement exposes a problem without that assumption, and evaluating the evidential value of agreement requires an explicit error model.

### 7. Method error, validation and joint explanations

**Closest antecedents.** Candidate elimination can range over functions as readily as over ordinary hypotheses [R1]. Quine [R8, §6] describes experience confronting a connected body of commitments, with adjustment possible in different parts. Schmidhuber's thesis [R9, abstract and opening discussion] explicitly proposes learning strategies that modify learning strategies, including feedback onto themselves.

S2 instantiates `Turn` with candidate method accounts \(W\to O\). Testing a known case eliminates accounts that mispredict it. In the joint space of world and method, `surprise_does_not_say_which` retains two alternatives when its premises supply one fitting world change and one fitting method change. This is a finite logical illustration of underdetermination, not a new resolution of it.

**Precision defects.** `method_validation_is_a_learning_turn` assumes no `Tries` premise and does not conclude `Learns`. It guarantees preservation of the true account and rejection of inconsistent accounts; all candidate accounts may agree on the tested case, producing no strict reduction. The name is therefore stronger than a claim of positive learning on every validation turn.

`validated_method_can_still_be_wrong` preserves an account that agrees on the known case; its signature does not require that account to differ elsewhere from the true account. An actual counterexample requires that additional difference. A surviving wrong account is possible, but not inevitable: a candidate class may be fully separated by the cases tested. The claim that validation at every level necessarily leaves a blind spot is unsupported.

Finally, changing the type of hypotheses is not itself an algorithm for recursive self-improvement. S2 does not select experiments, construct better methods, or establish reliable infinite ascent through validation levels.

### 8. Retention in a changing world

**Closest antecedent.** Katsuno and Mendelzon [R5] expressly distinguish changing a knowledge base because the world changed from revising beliefs about a world that stayed fixed. S2's stale-record theorem is a particularly small instance: a state once correctly excluded can become actual later.

**Difference and defect.** The theorem changes the designated actual world; it does not model temporal dynamics or a learning policy for detecting change. An old observation indexed to its original time can remain true. What becomes invalid is treating it as an unchanged constraint on the present.

Thus the module's sentence that retention is good only while the world stands still is too broad. Keeping historical data can be useful in a changing world. Neither mandatory forgetting nor a solution to the stability–plasticity problem follows from the theorem.

## Part B — Learning on a resource ledger

### 9. Learning and future resource slack

**Closest verified literature.** Kelly [R20, p. 917] relates information to achievable capital growth in a specified betting setting. Sims [R18, author-record abstract] models an information-processing constraint. Ashby [R10] studies adaptation and viability. None of these is an exact antecedent for S3's equal-cost count of retained wrong worlds, and the search did not locate that precise ledger. The verdict is **not found**, not **sharpening**: a different stipulated toy economy is not automatically a strengthening of those theories.

In S3, misfit is `own + blind + lost`, and idle slack is uptake minus misfit. Decrementing `own` by one therefore raises subsequent slack by exactly one. With no blind errors or lost truth, the conservative reserve requirement is

\[
\operatorname{need}(e)=\sum_{i=1}^{e}(i+t)
=\frac{e(e+1)}2+te.
\]

That sum covers clearing a finite stock of errors, even without crediting uptake. After clearance, learning stops and the model has nonnegative uptake without an additional baseline maintenance cost.

**Limits.** Raising future slack is not the same as paying for the current experiment or making the next turn affordable. Initial reserves are essential. A sealed learner fails only when continuing misfit exceeds uptake; `efficiency_buys_duration` explicitly includes that inequality. A comfortably financed wrong learner need not fail.

The representation also sets the bill: splitting one economically equivalent false possibility into several separately counted possibilities raises costs. There is no invariant probability, decision loss or expected value of information behind that count. No general claim about the economic return to real learning follows without defending this mapping.

### 10. False records, penalties and revision

**Closest antecedent.** AGM theory [R4] supplies explicit operations and constraints for contraction and revision. S3 does not implement those operations: `revise` resets a cost field. It contains no evidence store or mechanism that identifies and retracts the offending record.

The equality in `false_turn_slack` is valid accounting: provided \(r\leq\text{own}\), the change is \(r-\text{lostCost}\). It need not be negative. The note has already corrected an earlier stronger suggestion about its sign.

**Concrete semantic defect.** `Terms.lostCost` is a natural number, so zero is permitted. `falseTurn` marks purported truth exclusion only by adding `lostCost` to `State.lost`; `learnOwn` blocks learning only when `lost` is nonzero.

Take `own = 2`, `blind = 0`, `lost = 0`, `reserve = 10`, and `u = t = lostCost = 0`. Apply `falseTurn` with `r = 0`. The resulting state still has `own = 2` and `lost = 0`, with reserve 8. A subsequent `learnOwn` reduces `own` to 1, with reserve 6, without revision. This contradicts the unqualified interpretation that this false turn has excluded truth and therefore blocks later learning.

The named theorem `after_false_turn_no_learning` remains untouched: it assumes `0 < s.lost`, rather than proving that every `falseTurn` establishes it. Truth exclusion and its price are not equivalent under the permitted parameters. Even with positive penalties, blocking is imposed by the transition rule; there is no formal abstraction theorem connecting the ledger to S2. In real misspecified models, improvement on some predictive tasks need not require recovering the whole truth first.

### 11. The two contributions to progress

**Closest antecedent.** Distributed knowledge can distinguish what an agent's information leaves unresolved [R2]. The numerical identity in S3, however, is elementary counting: decrease an own counter by at most one and a disjoint blind counter by at most one, then add the decreases.

The division into two classes, the external source's ability to remove blind errors, and the absence of overlap are supplied by the model. They are not consequences of a general information decomposition. There is no mutual information, redundancy measure, synergistic observation or uncertainty-dependent gain here.

`link_decides` further requires blind-error cost to exceed uptake, sufficient starting reserve, a useful different view, and a link with no upkeep or false messages. Under those premises the link changes survival. This is not a general theorem that connection increases learning speed or viability. Zollman's model [R22] is a relevant warning against that extrapolation: a communication arrangement can change reliability adversely even while accelerating communication. It is not a counterexample to S3's much narrower arithmetic.

### 12. Lasting mutual correction

**Closest antecedent.** Trivers [R19] analyzes reciprocal altruism and the conditions under which costly acts can be sustained by later benefits. That is a thematic predecessor; S4 does not reproduce its evolutionary or strategic analysis. The immediate mathematical antecedent is the elementary budget recurrence, and S4 itself identifies the repository's earlier `Reciprocity` model as richer in one respect.

In S4, correction is *defined* as a conjunction of the exchange booleans. Successful correction exactly offsets a unit cost; otherwise reserves fall. Conduct is fixed over time in the main equivalence. Consequently, `lasts_iff_all_verbs` is a special case of that resource rule, not an independently derived list of requirements for relationships generally.

**Limits.** Giving is free, so withholding has no modeled strategic reward. There are no alternative partners, other income, endogenous incentives, or proof that fresh correctable errors remain available forever. The connection to S2 is interpretive, not an imported derivation. The finite-error and perpetual-error models are not a single composed system.

The gain/cost extension correctly states separate sufficient and failure conditions. It does not prove a new unrestricted necessity theorem when gain exceeds cost. Zero cost is allowed in that extension, so survival can then occur without corrections. Nor does the fixed-conduct equivalence forbid temporary lapses: `one_lapse_survivable` explicitly permits one. Those scope qualifications are already substantially present in S4.

## Part C — Definitions and the creed

### 13. Intelligence and recursive intelligence

**Closest antecedents.** Ashby's adaptive systems [R10] already connect organization, environmental interaction and regulation. Legg and Hutter [R11] define a different, more operational target through goal achievement across environments. Hernández-Orallo and Dowe [R13] develop an intelligence-testing framework, while Chollet [R12] stresses skill-acquisition efficiency in relation to priors and experience. Schmidhuber [R9] directly anticipates modifying the strategies by which learning occurs.

The proposed intelligence definition is a broad adaptation-based characterization, not a new equivalent of those quantitative proposals. It does not specify goals, performance, generalization, learning efficiency, or a threshold separating intelligent adaptation from simpler adaptive processes. “Network-organized” supplies no operational discriminator unless the relevant organization and comparison class are defined.

The recursive definition restates a familiar meta-learning capacity. S2 demonstrates that method accounts can be objects of inference; that is weaker than demonstrating a process that improves its actual learning operations. The proposed terms may name the author's intended scope, but definitions alone establish neither a new empirical boundary nor a formal intelligence measure. Autopoiesis, enactivism, strange loops and self-model theory were not independently verified in this bounded audit.

### 14. Sins, unsuccessful action and responsibility

**Closest antecedent.** Cassam's publisher description [R14] explicitly characterizes epistemic vices through obstruction of acquiring, retaining and sharing knowledge, and distinguishes epistemic criticism from blame when control is limited. That record establishes a close conceptual predecessor; the full monograph was not examined.

**Defect in the formal attribution.** The creed says that each listed sin blocks learning in the model. Several rows have no corresponding blocking theorem: method development, weighing testimony, beneficial forgetting and the long-term maintenance of means are not all operations in S2. Receiving an answer can remove an error without acquiring the method. An unchecked method can happen to be correct. A personally safe question can still separate two possible worlds. Screening a demonstrably unreliable source can protect inquiry. These are counterexamples to the broad verbal mapping, not rebuttals of the selected formal failure predicates.

**Defect in the moral inference.** An equality such as observed = actual output contains no information about intention, care, knowledge of risk or avoidability. It cannot establish culpability. Conversely, a failed condition does not establish that nobody did anything wrong: another party may have deliberately corrupted the instrument or withheld resources, and an agent may have ignored a known calibration requirement.

The revised distinction between actions and conditions removes one earlier conflation but does not prove faultlessness. The ethical judgment needs premises absent from these models. The creed is entitled to propose norms; its claim that the whole table follows from the blocking results is defective.

## Part D — The legal concept note

### 15. Correctable models, relational autonomy and protected interests

**Closest antecedents.** Nedelsky [R15] expressly asks which relationships and institutions develop and sustain autonomy, challenging a picture of rights as boundaries around an isolated self. Fricker [R16, publisher abstract] identifies wrongs to people in their capacities as knowers. The Mental Capacity Act and CRPD material [L5–L7] address support for decision-making while protecting agency.

The claim that relationships can either enable or undermine independent judgment therefore has close antecedents. So does the separation of a person's rights from whether a decision is wise. The specific expression “holder of a correctable model” and the proposed general protected interest were not found verbatim; that absence does not establish a new substantive doctrine.

**Legal distinction.** Correctability is not the sole purpose of supported decision-making. Respect for will and preferences can protect a choice that an expert believes mistaken. Recasting support entirely as correction risks losing that distinction. A duty to provide support, a duty not to isolate or deceive, and a power to override a decision are different legal relations.

S6 properly labels the extension as proposed, retains rights when a person is wrong, and acknowledges unresolved capacity cases. Its categorical statement that private relationships lack procedural fallibilism nevertheless conflicts with its own informed-consent and supported-decision examples. The claim that the proposal supplies something the earlier picture cannot see is too strong given those examples and relational-autonomy literature.

The purported extension to relations involving artificial systems is also a proposal. None of the inspected human-rights instruments establishes equal legal personhood or identical duties across all those substrates. The survival and blind-spot results do not themselves establish a legal entitlement or an enforceable standard of reasonable effort.

### 16. Legal and historical source checks

The table separates a statement's source status from approval of the proposal. **Not confirmed** for a proposed rule means that it is not established law by the sources examined; it does not mean that a normative proposal is false. A treaty committee's interpretation and a state's contrary declaration are both primary evidence of their respective positions, not interchangeable statements of settled domestic law.

| Statement in S6 | Status | Source and assessment |
|---|---|---|
| §2: UDHR article 1 describes human beings as endowed with reason and conscience. | **confirmed in the primary source** | [L1], article 1. The quoted wording is accurate. |
| §§1–2: much rights law presupposes that people know their own minds, with rights largely fencing off consensual private relations. | **not confirmed** | An interpretive generalization without jurisdiction, period or supporting authority. Article 1 alone does not establish this legal anthropology. |
| §2: the UDHR recognizes duties to the community. | **confirmed in the primary source** | [L1], article 29(1). |
| §2: protecting access to correction is something the sovereign-will picture cannot see. | **not confirmed** | A conceptual claim, not an implication of the cited instrument. UDHR information and education rights already complicate this opposition [L1, articles 19 and 26]. |
| §3: a court must hear both sides. | **not confirmed** | Fair-hearing protection is documented [L1, article 10], but no source was supplied for this unrestricted formulation across proceedings and jurisdictions. |
| §3: a court's judgment can be appealed. | **not confirmed** | The blanket claim is unqualified; an appeal right for every judgment was not established by any cited source. |
| §3: powers are separated so each can be checked by another. | **not confirmed** | Familiar constitutional rationale, but no specified constitutional text or historical source was checked for this general statement. |
| §3: Mill's quoted sentence occurs in *On Liberty*, chapter II. | **confirmed in the primary source** | [L2]. “All silencing of discussion is an assumption of infallibility.” |
| §3: fallibility is not a working assumption for persons in private relations. | **wrong** | As an exclusionary claim, contradicted by the note's own examples [L3–L7]. Mill's argument also reaches social discussion, not only state institutions. |
| §4: women's legal subordination historically existed. | **confirmed in the primary source** | Mill's contemporary account [L11] supplies evidence for the narrower historical proposition, not a universal statutory history of guardianship. |
| §4: guardianship over women was justified specifically by the proposition that they could not certify their own views. | **not confirmed** | No historical statute, judgment or advocate's text establishing this precise rationale was located within the budget. [L11] does not establish that genealogy. |
| §4: colonial tutelage was justified by an asserted inability of subjected peoples to govern independently. | **confirmed in the primary source** | League Covenant article 22 [L10] explicitly uses such a paternalist rationale. |
| §4: colonial tutelage specifically followed from general epistemic fallibilism applied asymmetrically. | **not confirmed** | [L10] supports tutelage and a hierarchy of capacity, not this precise philosophical derivation. |
| §4: persons with psychosocial disabilities have historically been subjected to denial of capacity and substitute decisions. | **confirmed only in a secondary source** | The Committee's historical account in [L7, paragraphs 7–8] reports this history. It is primary for the Committee's position, secondary for the historical events. |
| §4: psychiatric coercion historically rested on the quoted self-certification premise. | **not confirmed** | No contemporaneous psychiatric statute, case or policy text was examined to establish the claimed rationale. |
| §4: these three histories share one error, the asymmetric application of that premise. | **not confirmed** | An author's diagnosis, not a demonstrated historical finding. The specific institutions and rationales must not be collapsed into one genealogy. |
| §5: fallibility alone should create no power to override; correction should remain available. | **not confirmed** | Expressly a proposal. [L5–L8] support parts of the distinction but do not jointly enact this universal rule. |
| §5: an effort duty to keep correction routes open exists across relationships. | **not confirmed** | Proposed terminology, with no general statutory duty established in the inspected sources. |
| §5: care professionals have specific duties towards patients. | **confirmed in the primary source** | [L3–L4] establish patient-directed duties. The broader claim that one side owes “more” is not a quantified legal conclusion. |
| §5: a parent owes a child more than the child owes back. | **not confirmed** | An ethical comparison rather than a specified legal rule. [L3, article 447] recognizes parental support obligations, but no general comparative legal standard was established. |
| §5: exit is always available and cannot be limited by the proposed duty. | **not confirmed** | A proposed safeguard, not a verified description of every existing legal relationship. Its scope and exceptions are unspecified. |
| §5: a departing parent continues to owe care and maintenance. | **not confirmed** | No applicable family-law provision was inspected; the precise duties depend on legal status and orders. This audit does not label the broad proposition false. |
| §5: leaving a relationship does not extinguish a debt. | **not confirmed** | No specified debt, discharge rule or jurisdictional authority was examined. A plausible generalization is not a source check. |
| §6: BW 7:448 addresses the care provider's duty to inform. | **confirmed in the primary source** | Official 1994 enactment and 2019 amendment [L3–L4]; the latter also specifies consultation responsive to the patient's situation. |
| §6: BW 7:450 requires patient consent for treatment. | **confirmed in the primary source** | [L3], article 450, establishes the basic rule and qualifications. This should not be read as eliminating exceptions elsewhere in the statutory scheme. |
| Source note: the version of BW 7:448 previously consulted may predate its amendment. | **confirmed in the primary source** | [L4] establishes the 2019 amendment. This audit checked enactments, not a successfully accessed current consolidated text as of the audit date. |
| §6: MCA 2005 section 1 presumes capacity unless lack of capacity is established. | **confirmed in the primary source** | [L5], section 1(2), official legislation XML. |
| §6: an unwise decision alone does not establish inability to decide. | **confirmed in the primary source** | [L5], section 1(4). |
| §6: all practicable steps to help decide must have failed before inability is inferred. | **confirmed in the primary source** | [L5], section 1(3). This does not abolish the Act's best-interests provisions. |
| §6: CRPD article 12 recognizes equal legal capacity and access to support. | **confirmed in the primary source** | [L6], paragraphs 2–3. |
| §6: article 12 safeguards must respect rights, will and preferences. | **confirmed in the primary source** | [L6], paragraph 4, also addresses conflicts of interest, undue influence and review. |
| §6: General Comment No. 1 calls for replacing substituted with supported decision-making. | **confirmed in the primary source** | [L7], especially paragraphs 26–29. The Committee's position is stronger than merely adding support alongside unreformed substitution. |
| §6: that interpretation is contested, specifically by the Netherlands' stated position. | **confirmed in the primary source** | Comparison of [L7] with [L8] directly establishes this disagreement. No broader survey of the controversy was performed. |
| §6: the Netherlands' ratification declaration allows supported and substitute arrangements, with substitution necessary, a last resort and safeguarded. | **confirmed in the primary source** | [L8], article 12 declaration, deposited on 14 June 2016. |
| §6: substitute decision-making consequently remains permitted in Dutch law. | **confirmed only in a secondary source** | Government legal explanation [L9] confirms representative arrangements. The declaration is not itself domestic statutory authorization; the current underlying statutes were not fully checked. |
| §7: every existing individual protection remains unchanged under the proposal. | **not confirmed** | A design commitment. Coexistence with existing capacity regimes and the no-override clause has not been legally worked out. Read as creating no *new* override power, the clause is less problematic. |
| §7: some isolation and manipulation are already recognized as coercive control or undue influence. | **not confirmed** | No jurisdiction-specific offence, civil doctrine or case was verified for this mapping. [R16] is philosophical literature, not an enactment of these legal categories. |
| §7: the proposed interest applies on the same terms across human and artificial systems. | **not confirmed** | A normative extension. No inspected instrument confers that cross-substrate legal status. |
| §8: existing capacity regimes address inability to decide. | **confirmed in the primary source** | [L5] establishes one such regime; [L9] describes Dutch arrangements. Whether those regimes answer the problem satisfactorily is a separate judgment. |

The legal defects are therefore concentrated in the framing and inference, not in a wholesale failure of the cited provisions. The explicit source uncertainty in S6 should be updated from this table; it must not be replaced by a claim that every legal assertion is now verified.

## Unverified leads, reading limits and negative findings

This table accounts for the brief's suggested leads. “Unverified” means no sufficiently inspected primary source supports reliance on that lead here. It does not mean the proposed connection is false.

| Lead or family of leads | Disposition in this audit |
|---|---|
| Mitchell; candidate elimination | **Confirmed:** original 1977 paper [R1]. Later editions and thesis versions were not needed or independently audited. |
| Hintikka; possible-worlds epistemology | **Hintikka unverified.** A primary formal antecedent was established through Halpern–Moses [R2]. |
| Aumann | **Confirmed but not an exact match:** [R21]; assumptions concern common priors and common-knowledge posteriors. |
| Popper; Gold; Kevin Kelly's formal learning theory | **Unverified:** not examined directly before the budget stop. J. L. Kelly's information-and-growth paper [R20] is a different author and topic. |
| AGM belief revision | **Confirmed:** [R4]. Pure candidate filtering should not be equated with the full revision theory. |
| Optimal experimental design; active learning | **Unverified as specific antecedents:** the repository does not optimize the choice of an experiment. |
| Epistemic externalism/internalism; Stanford's unconceived alternatives | **Unverified:** no original work read sufficiently to attribute a precise result. |
| Identification and observational equivalence | **Confirmed:** Rothenberg [R3]. |
| Epistemology of testimony | **Partially covered:** Fricker's publisher abstract [R16]; no comprehensive testimony theory reviewed. |
| Zollman; Kleinberg and Raghavan | **Confirmed, limited relevance:** [R22–R23]. Their network and correlation results are not the repository's blind-spot theorem. |
| Tomasello | **Unverified:** no original source examined sufficiently. |
| Csibra and Gergely | **Confirmed, thematic:** [R17]; natural pedagogy is not the operation-extension theorem. |
| Bateson; Argyris and Schön | **Unverified:** no primary text inspected sufficiently. |
| Schmidhuber; Chollet | **Confirmed:** [R9, R12]; meta-learning and intelligence measurement, respectively. |
| Replication and reproducibility | **Confirmed:** [R6–R7]. |
| Condorcet and dependence extensions | **Unverified:** no original theorem or extension used. No majority-vote theorem is attributed here. |
| Duhem–Quine | **Quine confirmed:** [R8]. **Duhem independently unverified:** no inference from the compound label to having read both authors. |
| Collins's experimenter's regress; problem of induction | **Unverified:** no original source examined sufficiently. |
| Concept drift; stability–plasticity; continual-learning forgetting | **Unverified as specific technical literatures:** [R5] establishes the narrower world-change distinction. |
| Value of information; Blackwell | **Partial:** Kelly [R20] establishes a different information-to-payoff connection. The attempted Blackwell source was inaccessible; no Blackwell theorem is attributed. |
| Sims | **Confirmed at author-record abstract level only:** [R18], not the derivations in the full article. |
| Friston | **Unverified:** the attempted primary article was inaccessible. Search snippets were not used as evidence. |
| Bounded rationality | **Unverified as a specific original citation:** no claim of an exact antecedent based on that label. |
| Ashby and requisite variety | **Partial:** *Design for a Brain* [R10] was inspected for adaptation and reorganization. A separate requisite-variety theorem was not checked or attributed. |
| Trivers | **Confirmed, thematic:** [R19]. |
| Repeated games; partner choice | **Unverified as specific external antecedents:** no equilibrium or partner-choice result used. |
| Legg and Hutter; Hernández-Orallo and Dowe | **Confirmed:** [R11, R13]. |
| Autopoiesis; enactivism; Hofstadter; Metzinger | **Unverified:** no original source examined sufficiently. |
| Zagzebski; moral luck | **Unverified:** no original source used. |
| Cassam | **Confirmed at publisher-abstract level only:** [R14]. The book's full argument was not audited. |
| Nedelsky | **Confirmed:** original 1989 article [R15]. |
| Mackenzie and Stoljar | **Unverified:** no original source examined sufficiently. |
| Fricker | **Confirmed at publisher-abstract level only:** [R16]. |
| Stark; coercive control; undue influence | **Unverified:** neither a full original theoretical work nor jurisdiction-specific legal authorities checked. |
| Supported decision-making and criticism | **Partly confirmed:** treaty, Committee text and Dutch declaration [L6–L8]. Not a comprehensive literature review of critics. |
| Curatele, bewind, mentorschap | **Official explanation inspected:** [L9]. Current statutory provisions and case law not fully verified. These arrangements have different scopes and must not be treated as identical. |
| Wvggz; Wzd | **Unverified:** no current statute or authoritative case analysis inspected. |

Other limits: the current consolidated BW endpoint could not be used successfully; official enactment and amendment texts were used instead. The audit did not check all historical jurisdictions, review every article of the disability convention, run the Lean build, assess empirical validity of the ledger, or prove that no earlier work uses the exact proposed terminology. Those omissions prevent a priority verdict. No claim receives **sharpening** on the evidence examined.

## Bibliography

Page or section locators above identify the portions relied on; inclusion below does not imply that every page of a book or long report was read. All online sources were inspected for this audit on 11 November 2026.

### Research literature

- **[R1]** Mitchell, Tom M. (1977). “Version Spaces: A Candidate Elimination Approach to Rule Learning.” *Proceedings of the Fifth International Joint Conference on Artificial Intelligence*, 305–309. [Original paper](https://ijcai.org/proceedings/1977/68).
- **[R2]** Halpern, Joseph Y., and Yoram Moses (1990). “Knowledge and Common Knowledge in a Distributed Environment.” *Journal of the ACM*, 37(3), 549–587. [Original article, hosted at MIT](https://groups.csail.mit.edu/tds/papers/Halpern/JACM90.pdf).
- **[R3]** Rothenberg, Thomas J. (1971). “Identification in Parametric Models.” *Econometrica*, 39(3), 577–591. [Original article](https://pages.stern.nyu.edu/~dbackus/Identification/id/Rothenberg_id_Econometrica_71.pdf).
- **[R4]** Alchourrón, Carlos E., Peter Gärdenfors, and David Makinson (1985). “On the Logic of Theory Change: Partial Meet Contraction and Revision Functions.” *The Journal of Symbolic Logic*, 50(2), 510–530. [DOI: 10.2307/2274239](https://doi.org/10.2307/2274239); [original article inspected](https://fitelson.org/piksi/piksi_22/agm.pdf).
- **[R5]** Katsuno, Hirofumi, and Alberto O. Mendelzon (1992). “On the Difference between Updating a Knowledge Base and Revising It.” In Peter Gärdenfors (ed.), *Belief Revision*, 183–203. Cambridge University Press. [Publisher chapter and introduction](https://www.cambridge.org/core/books/abs/belief-revision/on-the-difference-between-updating-a-knowledge-base-and-revising-it/8ADFFF65FA776C21E8646D6F4D2434AB). This is the edition inspected; an earlier conference version was not separately checked.
- **[R6]** Knight, John C., and Nancy G. Leveson (1986). “An Experimental Evaluation of the Assumption of Independence in Multiversion Programming.” *IEEE Transactions on Software Engineering*, SE-12(1), 96–109. [DOI: 10.1109/TSE.1986.6312924](https://doi.org/10.1109/TSE.1986.6312924); [original article inspected](https://people.cs.rutgers.edu/~uli/cs673/papers/EvaluationMultiVersionProgramming86.pdf).
- **[R7]** National Academies of Sciences, Engineering, and Medicine (2019). *Reproducibility and Replicability in Science*. Washington, DC: National Academies Press. [DOI: 10.17226/25303](https://doi.org/10.17226/25303); [publisher text, Summary](https://www.nationalacademies.org/read/25303/chapter/3).
- **[R8]** Quine, W. V. (1951). “Two Dogmas of Empiricism.” *The Philosophical Review*, 60(1), 20–43. [Original text reproduced](https://www.philosophie.hu-berlin.de/de/arbeitsbereiche/logik/lehre/quine-twodogmas.pdf), especially §6.
- **[R9]** Schmidhuber, Jürgen (1987). *Evolutionary Principles in Self-Referential Learning*. Diploma thesis, Technische Universität München, 14 May 1987. [Author-hosted original thesis](https://people.idsia.ch/~juergen/diploma1987ocr.pdf).
- **[R10]** Ashby, W. Ross (1960 [1952]). *Design for a Brain: The Origin of Adaptive Behaviour*. Second edition, revised. London: Chapman & Hall. [Book scan](https://www.ashby.info/Ashby%20-%20Design%20for%20a%20Brain%20-%20The%20Origin%20of%20Adaptive%20Behavior.pdf), particularly the treatment of parameters and ultrastability.
- **[R11]** Legg, Shane, and Marcus Hutter (2007). “Universal Intelligence: A Definition of Machine Intelligence.” *Minds and Machines*, 17, 391–444. [DOI: 10.1007/s11023-007-9079-x](https://doi.org/10.1007/s11023-007-9079-x); [author-hosted paper](https://www.hutter1.net/ai/iorx.pdf).
- **[R12]** Chollet, François (2019). “On the Measure of Intelligence.” *arXiv*, 1911.01547. [Original preprint and author abstract](https://arxiv.org/abs/1911.01547).
- **[R13]** Hernández-Orallo, José, and David L. Dowe (2010). “Measuring Universal Intelligence: Towards an Anytime Intelligence Test.” *Artificial Intelligence*, 174, 1508–1539. [DOI: 10.1016/j.artint.2010.09.006](https://doi.org/10.1016/j.artint.2010.09.006); [author-hosted paper](https://dmip.webs.upv.es/papers/measuring.pdf).
- **[R14]** Cassam, Quassim (2019). *Vices of the Mind: From the Intellectual to the Political*. Oxford University Press. [Publisher record and abstract inspected](https://academic.oup.com/book/10598), DOI: 10.1093/oso/9780198826903.001.0001. Full book not inspected.
- **[R15]** Nedelsky, Jennifer (1989). “Reconceiving Autonomy: Sources, Thoughts and Possibilities.” *Yale Journal of Law & Feminism*, 1(1), 7–36. [Original article in Yale repository](https://openyls.law.yale.edu/bitstreams/b6f87a9b-ef6e-426c-ace2-db9baf152a19/download).
- **[R16]** Fricker, Miranda (2007). *Epistemic Injustice: Power and the Ethics of Knowing*. Oxford University Press. [Publisher record and abstract inspected](https://academic.oup.com/book/32817), DOI: 10.1093/acprof:oso/9780198237907.001.0001. Full book not inspected.
- **[R17]** Csibra, Gergely, and György Gergely (2009). “Natural Pedagogy.” *Trends in Cognitive Sciences*, 13(4), 148–153. [DOI: 10.1016/j.tics.2009.01.005](https://doi.org/10.1016/j.tics.2009.01.005); [original article inspected](https://cognitionandculture.net/wp-content/uploads/csibra_gergely_2009.pdf).
- **[R18]** Sims, Christopher A. (2003). “Implications of Rational Inattention.” *Journal of Monetary Economics*, 50(3), 665–690. [Author institutional record and abstract inspected](https://collaborate.princeton.edu/en/publications/implications-of-rational-inattention/), DOI: 10.1016/S0304-3932(03)00029-1. Full article not inspected.
- **[R19]** Trivers, Robert L. (1971). “The Evolution of Reciprocal Altruism.” *The Quarterly Review of Biology*, 46(1), 35–57. [DOI: 10.1086/406755](https://doi.org/10.1086/406755); [original article inspected](https://science.umd.edu/faculty/wilkinson/BIOL608W/Trivers1971.pdf).
- **[R20]** Kelly, J. L., Jr. (1956). “A New Interpretation of Information Rate.” *Bell System Technical Journal*, 35(4), 917–926. [Original article scan](https://vtda.org/pubs/BSTJ/vol35-1956/articles/bstj35-4-917.pdf). Opening page inspected visually; the result is used only at the scope stated in its abstract.
- **[R21]** Aumann, Robert J. (1976). “Agreeing to Disagree.” *The Annals of Statistics*, 4(6), 1236–1239. [Original article](https://www.haverford.edu/sites/default/files/Aumann1976.pdf).
- **[R22]** Zollman, Kevin J. S. (2007). “The Communication Structure of Epistemic Communities.” *Philosophy of Science*, 74(5), 574–587. [DOI: 10.1086/525605](https://doi.org/10.1086/525605); [original article inspected](https://www.jingyiwu.org/uploads/1/3/8/0/138010336/zollman_2007.pdf).
- **[R23]** Kleinberg, Jon, and Manish Raghavan (2021). “Algorithmic Monoculture and Social Welfare.” *arXiv*, 2101.05853. [Original preprint record and abstract](https://arxiv.org/abs/2101.05853).

### Legal and historical primary texts, and one official legal explanation

- **[L1]** United Nations General Assembly (1948). *Universal Declaration of Human Rights*. Resolution 217 A (III), 10 December 1948, particularly articles 1, 10, 19, 26 and 29. [UN text](https://www.un.org/sites/un2.un.org/files/2021/03/udhr.pdf). The retrieved text also appeared through a public-authority reproduction; the wording is the instrument itself.
- **[L2]** Mill, John Stuart (1859). *On Liberty*, chapter II, “Of the Liberty of Thought and Discussion.” Book; [original text reproduced at Wikisource](https://en.wikisource.org/wiki/On_Liberty/Chapter_2).
- **[L3]** Netherlands (1994). *Besluit van 15 december 1994* publishing the text of the Act of 17 November 1994 amending the Civil Code concerning the medical treatment agreement. *Staatsblad*, 1994, 838; underlying Act: *Staatsblad*, 1994, 837. [Official publication](https://zoek.officielebekendmakingen.nl/stb-1994-838.pdf), inserted BW 7:448 and 7:450. Historical enactment, not a current consolidation.
- **[L4]** Netherlands (2019). *Wet van 5 juni 2019 tot wijziging van Boek 7 van het Burgerlijk Wetboek, de Jeugdwet en enkele andere wetten ter verbetering van patiëntgerichte zorg en het opnemen van een wettelijke regeling voor het inzagerecht in het medisch dossier van een overleden patiënt*. *Staatsblad*, 2019, 224, article I(A). [Official amendment of BW 7:448](https://zoek.officielebekendmakingen.nl/stb-2019-224.html).
- **[L5]** United Kingdom Parliament (2005). *Mental Capacity Act 2005*, c. 9, section 1, “The principles.” [Official legislation](https://www.legislation.gov.uk/ukpga/2005/9/section/1); [official XML inspected](https://www.legislation.gov.uk/ukpga/2005/9/section/1/data.xml).
- **[L6]** United Nations General Assembly (2006). *Convention on the Rights of Persons with Disabilities*. Resolution A/RES/61/106, annex I, article 12, adopted 13 December 2006. [Official resolution and convention text](https://mandates.un.org/mandate/A/RES/61/106).
- **[L7]** United Nations Committee on the Rights of Persons with Disabilities (2014). *General Comment No. 1: Article 12, Equal Recognition before the Law*. CRPD/C/GC/1, 19 May 2014, particularly paragraphs 7–8 and 24–29. [Official document](https://documents.un.org/doc/undoc/gen/g14/031/20/pdf/g1403120.pdf). The 2018 corrigendum, CRPD/C/GC/1/Corr.1, was also inspected; no conclusion here depends on the superseded conjunction in paragraph 27.
- **[L8]** Kingdom of the Netherlands / United Nations Secretary-General, depositary (2016). *Convention on the Rights of Persons with Disabilities: Netherlands, Ratification*. C.N.489.2016.TREATIES-IV.15, action effected 14 June 2016, declarations on articles 12 and 14. [Official depositary notification](https://treaties.un.org/doc/Publication/CN/2016/CN.489.2016-Eng.pdf).
- **[L9]** Rijksoverheid (undated; accessed 11 November 2026). *Wat zijn de verschillen tussen curatele, bewind en mentorschap?* Government public information service. [Official explanation](https://www.rijksoverheid.nl/themas/familie-zorg-en-gezondheid/curatele-bewind-en-mentorschap/vraag-en-antwoord/curatele-bewind-en-mentorschap/verschillen-curatele-beschermingsbewind-en-mentorschap). Secondary exposition of domestic law, not a substitute for its statutes.
- **[L10]** League of Nations (1919). *Covenant of the League of Nations*, article 22. Treaty text, in the version reproduced with amendments through 1924. [Primary text reproduced by Yale's Avalon Project](https://avalon.law.yale.edu/20th_century/leagcov.asp).
- **[L11]** Mill, John Stuart (1869). *The Subjection of Women*. Book, particularly chapter I. [Original text reproduced by Project Gutenberg](https://www.gutenberg.org/cache/epub/27083/pg27083-images.html). Used as contemporary evidence of legal subordination, not as a comprehensive legal history.
