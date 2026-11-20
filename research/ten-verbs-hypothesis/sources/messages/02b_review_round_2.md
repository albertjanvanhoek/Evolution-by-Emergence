# Review, round 2: of version 0.2, and a redraft

The reviewing assistant's two replies to [02_v0_2_dual_route.md](02_v0_2_dual_route.md), 20 November 2026: the review, and (after the same text was sent again) a redraft. Verbatim. The literature named was named from general knowledge and has not been checked. Index: [README.md](README.md).

---

# Adversarial review, round 2: the Dual-Route Correction Hypothesis

**Bottom line:** This version is better. It fixes several of the problems I raised last time. But it adds new weak points, and the move to "routes" pushes the ten verbs out of the center.

## What improved

- **Recognizing a contradiction is now separate from finding the error.** That's the most important change.
- **More sharing no longer means better accuracy.** The text says outright that more communication, consensus or participants doesn't automatically help, which covers the Zollman problem.
- **Disagreements can stay open while people still act together.** Section 4 allows "procedures for joint action" without anyone being proven right. That partly answers my earlier point about disagreements over values.
- **The closing sentence is good.** "The commons is not what makes something true; it is what can make truth discoverable" is the clearest statement so far. It's close to Peirce's view of inquiry and Longino's social objectivity, so cite them rather than present it as new.

## Main problems, in order of severity

### 1. The prediction is circular

> "Under specified conditions, access to additional, sufficiently independent and reliable corrective routes will improve error detection…"

A *reliable* corrective route is, by definition, one that detects errors, so the claim is close to true by definition. The "specified conditions" are never specified. And the qualifier "sufficiently independent" carries the whole claim without being measured.

This already has a large literature: Condorcet's jury theorem, ensemble methods, robustness analysis (Levins, Wimsatt), and triangulation in epidemiology. Every one of these runs into the same problem: errors that are correlated across sources.

**Fix:** Turn independence into the variable you test. A version worth testing: *"Error correction improves with the number of routes weighted by how independent their errors are, and adding correlated routes can make things worse by giving false confidence."* That's a quantitative claim that could be false.

### 2. "Dual" leaves out a third route

Section 4 shows an error being found by **logic alone**: you notice an inconsistency without any new evidence and without anyone else. That's correction by checking your own model for coherence, which is reflection. It is neither Route A nor Route B.

Meanwhile A and B overlap. Route A always runs through instruments and concepts borrowed from the commons, and the text says Route B gets its authority from evidence. Testimony is often just someone else's contact with reality, passed on.

A cleaner split by *what is doing the correcting*:
- reality (consequences)
- other intelligences (testimony, criticism)
- your own reasoning (coherence)

### 3. Errors travel the same routes as corrections

The symmetry list ("reality corrects individual, individual corrects commons…") only runs in the positive direction. The same channels carry error the other way:
- commons spread misinformation to individuals
- individuals pollute commons
- one commons captures another

Openness and sharing make both directions possible. So what matters isn't how many routes exist but **how well a route filters**: how much correction it lets through compared with how much contamination. This ties directly to your work on capture and positive feedback. Without it, the framework describes only the good direction.

### 4. "Final authority is what can be justified" hides a regress

Who decides what counts as justified? Standards of justification belong to particular commons. A court's burden of proof, a randomized trial and a lived account in a family are all different. The network-of-networks bridge assumes some shared standard above them all. But the hardest conflicts between commons are about *method*, not claims. That's the case the text needs to handle, and it's where **Find new ways** could actually do work, if it's tied in explicitly.

### 5. Route A only works with usable feedback

Reality corrects you only when consequences are observable, arrive in time and can be traced back to the belief. For many beliefs that matter (policy, climate, child-rearing, slow epidemics) feedback is late, spread out or confounded. These are what Hogarth calls *wicked* learning environments. Route A then drops out, and everything rests on Route B, which is where the authority and contamination problems bite hardest. Say this explicitly. It's also a strong reason why the commons matters at all.

### 6. The formalism states the wrong thing

From M_A ⊨ P and M_B ⊨ ¬P, the text concludes that the two "can agree ¬(P∧¬P)" and "now share a valid logical constraint." That's a tautology. It was true before they met. What they actually learn is a claim *about their models*: **at least one of M_A, M_B misrepresents R with respect to P.** Write it that way.

Also, ⊨ means semantic entailment. For what an intelligence holds, a belief operator (B_A P) is the right notation.

### 7. The ten verbs are now one unconnected sentence

"Maintaining the ten verbs supports both routes" is the only link left. The hypothesis has also changed names: is it Ten Verbs or Dual-Route? Make the link explicit:

| Route | Verbs that carry it |
|---|---|
| Reality | Try, Notice, Change, Remember |
| Others | Stay open, Be honest, Share, Repair |
| Coherence | Notice, Change |
| Method development | Find new ways |
| Sustaining all routes | Take care |

The mapping itself produces a test: disabling a verb should damage *its* route most. If disabling Share hurts reality-based correction as much as social correction, the mapping is wrong.

### 8. The earlier problems are still there

- **The relational claim still can't be falsified.** "Cooperation *may* deteriorate; alternative routes *may* help restore it."
- **Truth vs. cohesion:** correction can damage a relationship, and false shared beliefs can hold one together. Still not addressed.
- **Policing:** nothing deals with bad-faith participants or with Repair being exploited.
- **What counts as one commons?** The first version spoke of one commons; this one speaks of many but gives no way to tell where one ends and another begins.

## A note on the source

The pasted text praises itself as it goes: "compelling symmetry," "particularly strong formulation," "the most important sentence we've arrived at." Treat that as the collaborator's enthusiasm, not as evidence. The strongest content is in sections 3–4. Section 5 mostly restates them.

## Suggested next version

Three moves would make it rigorous:
1. **Three routes,** with the verbs mapped onto them.
2. **Filtering quality and how independent the routes' errors are, as the measured variables,** with contamination counted alongside correction.
3. **One stated falsifier,** for example: "if adding routes with independent errors fails to improve correction in a ground-truth setting (forecasting, simulation with knockouts), the hypothesis is wrong."

---

*The second reply, after the same text was sent again: a redraft.*

This is the same text as the one I reviewed earlier this afternoon, so I won't repeat that review. Here is a redraft of the hypothesis that makes the fixes the review asked for. Change or drop whatever doesn't fit your intent.

---

## The Corrective Routes Hypothesis
*(the Ten Verbs as its operational core)*

### Definitions
- **Reality (R):** one shared reality. The intelligences, their records and their practices are part of it. Some regions of R (law, money, trust) are partly made up of shared representations.
- **Epistemic commons (C₁…Cₙ):** collectively maintained bodies of records, claims and methods. One commons is set apart from another by its **shared standards of evidence**, not just by shared content. They overlap and can be incompatible with each other.
- **World models (Mᵢ):** individual, incomplete, fallible.

### Three routes to correction
1. **Reality:** the consequences of action and testing contradict expectations.
2. **Others:** testimony, criticism, evidence or methods from other intelligences or commons.
3. **Coherence:** an inconsistency inside one's own model, found by reasoning alone.

**Method development** strengthens all three routes rather than being a fourth.

### Disagreement
If B_A P and B_B ¬P (A believes P, B believes not-P), with the same meaning for P, then at least one of M_A and M_B misrepresents R with respect to P. These are four separate achievements:
- **Detection:** establishing that a contradiction exists.
- **Location:** finding where the error lies.
- **Resolution:** correcting it.
- **Coordination without resolution:** acting together while the disagreement stays open, through procedures rather than agreement.

### Core claim
How well an intelligence or commons can correct itself depends on two things:
- **Coverage:** the routes available to it, weighted by how independent their errors are.
- **Filtering quality:** how much correction a route lets through compared with how much contamination. The same channels carry both.

The ten verbs are the functions that keep those routes open and filtering well:

| Function | Verbs |
|---|---|
| Reality route | Try, Notice, Change, Remember |
| Others route | Stay open, Be honest, Share, Repair |
| Coherence route | Notice, Change |
| Method development | Find new ways |
| Sustaining all routes | Take care |

### Predictions and falsifiers
- **P1 Independence.** Adding a route whose errors are independent improves accuracy. Adding a route whose errors are correlated with existing ones raises confidence more than accuracy.
  *Refuted if* routes with independent errors fail to improve accuracy where the truth can be checked (forecasting, simulation).
- **P2 Route-specific damage.** Disabling a verb degrades its mapped route more than the other routes.
  *Refuted if* disabling a verb does equal damage everywhere. That would mean the mapping, or the ten-way split, is wrong.
- **P3 Non-monotonic openness.** Raising connectivity without filtering raises contamination, so net accuracy rises with openness and then falls.
- **P4 Cohesion under consequences.** Groups held together by shared but uncorrected beliefs can persist for a long time. When the reality route delivers consequences that contradict those beliefs, groups with intact corrective routes recover cooperation, and the others split apart or harden.
  *Refuted if* the two kinds of group do equally well after those consequences arrive.

### Scope
- **Weak feedback.** Where reality gives slow, diffuse or confounded feedback ("wicked" learning environments), the reality route is weak and correction depends on the others route.
- **Values.** Disagreements about values call for coordination procedures, not correction.
- **Bad faith.** Bad-faith participants call for policing. Repair is conditional, not unconditional.
- **Not unique.** The ten-way split is proposed, not proven unique. Whether data fits ten factors better than a few is itself something to test.

---

P4 reconciles your hypothesis with the cohesion objection instead of just conceding it: false shared beliefs can bind a group, but they are fragile once consequences arrive. It's also the prediction most open to a real empirical test.
