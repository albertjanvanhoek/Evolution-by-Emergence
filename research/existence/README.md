# An existence conjecture

The question here is whether the proven pieces of Evolution by Emergence can be stated together as one existence conjecture: what any finite configuration needs in order to keep existing, with the proved results as special cases.

| File | What it is |
|---|---|
| [ASSISTANT_DRAFT.md](ASSISTANT_DRAFT.md) | The assistant's own draft answer to the brief, written at the author's request. Not independent; the literature is unchecked |
| [sources/REPORT_1_EXISTENCE.md](sources/REPORT_1_EXISTENCE.md) | Report 1, by a separate research agent, kept as received. It refers to a companion Lean file that was not supplied with it |
| [BRIEF_EXISTENCE_CONJECTURE.md](BRIEF_EXISTENCE_CONJECTURE.md) | The research brief for agents. It asks them to write the conjecture, map it to the proofs, make it refutable, separate it from what it must not claim, place it in the literature, and sketch it in Lean |

**Status:** one draft by the assistant (not independent) and one report, reviewed below. Further reports will be added under `sources/`.

**The assistant's view on readiness:** the theory is ready to *draft* a conjecture, not to claim one. Drafting it now will show which links between the proved pieces are still missing (the "Not yet formal" list in [CORE.md](../../CORE.md)). The main risk is a conjecture that nothing could refute, or one that restates the ledger's definitions as a finding. The brief asks for a narrower conjecture that can fail.

## Review of report 1, and how it changes the assistant's draft

### Its conjecture: maintenance and response
In plain words: a finite organization that has to be maintained can keep a specified function going through a declared range of disturbances only if responses it can actually deploy, in time, keep every indispensable resource above its failure floor throughout the horizon. Learning, reciprocity, growth and exit are possible ways to meet this; they are not requirements of all existence.

Precisely, for experiments registered in advance, the report proposes:
- a vector ledger, with one coordinate per indispensable resource and no common currency;
- a causal policy that sees only what it can observe;
- physical limits on actions;
- an operational test of functioning that is defined **independently** of the ledger.

The conjecture: if a policy keeps the organization functioning on every admissible course of the world, then the *same* policy keeps the ledger safe on every course. The order of the quantifiers matters: one policy for all courses, not a lucky response for each world.

### Where it is better than the assistant's draft, which the assistant accepts
1. **It does not make mechanisms necessary.**
   - The draft's E1 required faithful feedback, retention and an independent correction route whenever a configuration outlasts its reserve after the world leaves its fit.
   - The report counts an inherited fixed repertoire, a pre-existing regulator, buffering, a change of supplier, repair, care and exit as responses too. Learning is needed only where the existing responses cannot meet the constraints.
   - A fixed controller with enough variety for its disturbance class (Ashby) is a counterexample to any reading of E1 that requires learning or an independent route.

   So E1's four features are mechanisms that sometimes help, not conditions of existence. At most, E1 survives as a separate, conditional claim: *when* the available repertoire cannot meet the constraints, persistence needs a way to change it.
2. **It separates accounting from observation.** Functioning is tested by an operational criterion fixed before the test, never by the ledger itself. Without that separation the conjecture is a tautology: viability is *defined* as nonnegative slack (`internallyViableAt_iff_internalSlack_nonneg`). The draft's trigger `T·μ > R` points the same way, but the report makes the bridge explicit, and says that no current theorem supplies it.
3. **It adds the information structure.** The draft lacked this. If two courses of the world look the same to the system until a deadline, and need different actions, no single causal policy can handle both. That is a precise, provable obstruction.
4. **The draft's E2 was muddled.** It required detection and sanction for any commons that lasts while takers take above their interest. But the repository itself proves that capture does not pay a taker who discounts mildly (`not_cheating_wins_under_mild_discount`), and a large stock can outlast a short horizon. The report treats the commons as one more stock coordinate with its own floor, which is cleaner. Sanctions are a mechanism, not a condition.
5. **It classifies every proved result.** Each one is a *ledger instance*, a *conditional mechanism*, or a *boundary result*, so "all results are special cases of one existence law" is not true. `EbECore.lean` checks results; it does not compose them into one system.

### What it adds
- **A proof map** of every core result and the modules outside the core, with the premises that carry each one.
- **Refutation tests set in advance:** buffer against response delay; a resource that cannot be substituted; an information deadline; dependence on a commons. Each states which observation rejects the registered prediction.
- **Grander readings it rejects at once.** "Everything persistent must improve", "must finance itself", "every part must survive", "a positive final payoff suffices", and "feedback requires agency or a self-model" each have an immediate countermodel.
- **Two first provable steps:**
  - a deficit-window lemma for a vector ledger with a cap, which generalizes the draft's scalar `reserve_only_bound`;
  - an indistinguishability lemma: two courses that look the same until a deadline, and need different actions, cannot both be handled by one causal policy.

### Errata to the lineage: the "Existence First" appendices
The report gives concrete counterexamples to several claims in `Backmatter/Appendix30.tex` and `Appendix31.tex`:
- **the `k`-cover bound** (one monitor can be sensitive to two substrates);
- **the barrier-monitor inequality** (a state-space Lipschitz constant does not bound the variation along an unobserved direction);
- **forward invariance** (approving the current state does not certify the executed action);
- **constructive feasibility** (a Lipschitz bound limits an effect; it does not guarantee a helpful one);
- **the kernel ratchet** (a smaller, nonempty kernel need not contain the present state);
- **the capture bound** (only the monitors covering the violated constraint need to be bribed).

The assistant checked the kernel-ratchet case against the text of Appendix 31. The theorem allows a new kernel inside the old one, but does not require the present state to lie in it. With `x' = x`, an old kernel `[0,2]`, a new kernel `[1,2]` and the state at `0`, no safe controller exists after the floor rises. The other cases are plausible on their face and still need checking.

These appendices are lineage and are kept as written (working agreement 6). They are not part of the checked core. The errata belong next to them, so that no reader takes them as proved.

### Where the assistant is unsure
- **Can calibration be truly independent?** The report's conjecture has content only if the ledger's upkeep, floors and response costs are calibrated independently of the outcome. The report says itself that, without a stated calibration method, the formula is "a template for a conjecture". Whether such calibration is possible outside engineered systems is the open question.
- **Its Lean file.** It mentions a companion `ExistenceConjecture.lean` that it could not compile. That file was not supplied, so it is not reviewed here.
- **Its literature.** The literature checks give located quotations for Aubin, Varela, Maturana and Uribe, Prigogine, Ashby, Conant and Ashby, Friston, Kauffman and Ostrom. The assistant could not open them. The Friston quotation matches the one in the second curiosity report.

## The conjecture after report 1
- **Main statement:** the report's maintenance–response conjecture, as necessary conditions on registered, independently calibrated experiments. Its first test should be an engineered system with storage that can be instrumented, controlled disturbances and an adjustable response delay.
- **A separate, conditional claim (the draft's E1, narrowed):** when the inherited repertoire cannot meet the constraints, persistence needs a way to change that repertoire in time. This is the place for learning and the vortex.
- **Not a law of existence.** The theory's contribution is a particular decomposition: maintenance finances responses; retained construction changes what can be generated next; relations and the commons finance or destroy that process; distribution and the value of options complicate totals. That is a modelling vocabulary to be tested against simpler viability models, not yet a new law.

## Next steps
1. **Errata for Appendix 30 and 31,** next to the appendices, listing the counterexamples above.
2. **Two lemmas in core Lean:** the vector deficit-window lemma, and the indistinguishability lemma.
3. **The author's view on the reformulation** (D16).
4. **A prospective test on an engineered system,** with the boundary, floors and functioning criterion fixed in advance, against a simpler resource model as a baseline.
