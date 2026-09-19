# Maintaining the Edges of Learning

## Inside verbs, outside geometry, and the velocity of corrigible intelligent networks

**Status:** working theory paper, draft 0.1  
**Framework:** Evolution by Emergence

### Abstract

Intelligent beings rarely learn alone. They learn through relationships: by seeking others, listening, signalling what they know, exposing uncertainty, testing claims, revising models, preserving disagreement, repairing damaged relationships, retaining corrections, and recombining partial knowledge. These activities are ordinarily described from inside the learning process, using psychological or social language. From outside, however, the same system can be described as a dynamic network whose edges determine which information, criticism, evidence, and alternative models remain accessible.

This paper develops an inside–outside theory of learning in networks of intelligent agents. The level of analysis is deliberately fixed. Nodes are learning agents; edges are interaction channels through which information and correction can occur. The paper focuses not on the content being learned, but on the processes that form, maintain, use, and restore those edges. We call these **learning-maintenance processes**.

From outside the network, we represent learning by a directed accessibility-cost geometry. For organizational state \(X_t\), \(C_t(X_t,y\mid R_t)\) denotes the cost of reaching a future state \(y\) while preserving a declared retained repertoire \(R_t\). This induces plasticity and viscosity profiles rather than a single scalar measure of openness. A relationship can exist yet be highly viscous to correction; conversely, an extremely permeable edge may transmit noise or misinformation rather than useful evidence. The relevant property is therefore selective corrigibility rather than maximal plasticity.

The framework gives distinct meanings to the **loop**, **ratchet**, and **velocity** of collective learning. The loop is recurrent interaction. The ratchet occurs when validated corrections are retained without destroying the network required for later correction. Learning velocity is the rate at which retained functional improvements accumulate. Under explicit bounded-opportunity, bounded-response, and minimum-gain assumptions, shorter opportunity and response delays increase a guaranteed lower bound on this rate. A reduced search–validation model further demonstrates why simply increasing contact or search need not accelerate retained learning.

The theory generates testable predictions about disagreement, uncertainty disclosure, validation, relationship repair, re-engagement, network fragmentation, diversity, and future learning capacity. Multi-agent language models provide a controlled experimental workbench because both the inside interaction protocol and the outside network geometry can be manipulated and measured.

The central proposition is simple:

> **An informative relationship has value not only because of what travels across it now, but because preserving it can retain a route through which either participant may be corrected later.**

Under uncertainty about who is wrong and what information will matter next, maintainable and repairable edges can therefore constitute part of the learning infrastructure of an intelligent network.

---

# 1. Introduction

An individual can be wrong.

This fact has an immediate network consequence.

If an intelligent agent cannot fully determine from within its own model where that model is mistaken, correction may depend on information available elsewhere. Another person may have observed something different, know something the first does not, possess a competing model, detect an inconsistency, or simply ask a question that exposes an unnoticed assumption.

The relationship between them can therefore have a function beyond social affiliation. It can be a channel of future correction.

Yet most discussions of learning separate two descriptions that belong together. From the inside, we speak of activities such as listening, questioning, honesty, disagreement, criticism, revision, trust, forgiveness, and repair. From outside, research on collective learning describes network topology, connectivity, information diffusion, exploration, convergence, diversity, and group performance.

These are not competing accounts. They operate at different descriptive levels.

Consider two scientists who disagree. From inside their interaction, one may attempt to understand the other's argument, expose her own uncertainty, test a claim, revise part of her model, or repair the relationship after an acrimonious exchange. From outside, an observer may see an information channel whose availability, fidelity, responsiveness, persistence, and probability of future use have changed.

The same event can therefore be written schematically as

\[
\boxed{
\text{inside process}
\;\xrightarrow{\Gamma}\;
\text{outside network dynamics}.
}
\]

The purpose of this paper is to make that translation explicit.

The object of study is a **network of intelligent agents**. Nodes possess internal models and can change them. Edges are channels through which agents can exchange information capable of affecting those models. The central question is not what any particular agent should believe. It is:

\[
\boxed{
\textbf{How does an intelligent network maintain the edges through which it can continue to learn?}
}
\]

This question sits one meta-level above ordinary learning.

At level \(L_0\), agents learn content: facts, skills, predictions, explanations, solutions.

At level \(L_1\), processes determine whether the channels required for that learning remain usable: agents seek, listen, communicate faithfully, expose uncertainty, test, revise, preserve informative disagreement, repair, re-engage, retain, and recombine.

At level \(L_2\), the network can improve those learning-maintenance processes themselves: it can learn how to listen, test, repair, or organize disagreement more effectively.

The present paper focuses on \(L_1\).

This restriction matters. Similar mathematical patterns may arise within a single brain, during neural-network training, between cells in an organism, among organisms in an ecosystem, or across institutions in an economy. Evolution by Emergence treats such recurrence at a more abstract level. But moving casually among these scales creates apparent insights that are often merely rediscoveries of the same structure under different terminology.

Here the scale is fixed:

\[
\boxed{
\text{agent}
\longleftrightarrow
\text{agent}.
}
\]

The paper describes this network from inside and outside, introduces measurable quantities for its plasticity and learning velocity, and asks when maintenance and repair of informative edges increase future correction capacity.

---

# 2. Relation to Evolution by Emergence

Evolution by Emergence begins from persistence rather than from static objects.

Organized systems consist of processes that recreate enough of the organization required for further activity despite turnover of their material components. Environmental resources support maintenance; remaining capacity can support response or exploration; some generated changes are validated and retained; and retained organization can alter what changes become possible later.

Schematically,

\[
\text{maintenance}
\rightarrow
\text{response}
\rightarrow
\text{generation}
\rightarrow
\text{validation}
\rightarrow
\text{retention}
\rightarrow
\text{changed future accessibility}.
\]

This paper specializes that architecture to intelligent networks.

The universal framework is not itself the claim of this manuscript. We use only its central second-order observation:

\[
\boxed{
\text{present organization can change the cost distribution of future organization.}
}
\]

In an intelligent network, the organization includes its relationships.

Consequently,

\[
\text{current edge structure}
\rightarrow
\text{future correction opportunities}.
\]

The network does not merely transmit current information. Its present interactions can alter whether future information will still be able to travel.

This is the sense in which relationship maintenance becomes a second-order learning process.

---

# 3. Fixing the descriptive levels

A central source of conceptual confusion is failure to distinguish **scale** from **meta-level**.

## 3.1 Scale

In this paper the nodes are intelligent agents.

An agent may internally be an enormous network of neurons, parameters, processes, or tools. That internal structure is bracketed.

Likewise, the collection of agents may form a laboratory, firm, scientific community, institution, or society. Those larger descriptions are applications of the same agent-network level rather than licenses to mix organizational scales inside a single derivation.

The state of agent \(i\) at time \(t\) is denoted

\[
m_{i,t},
\]

and the interaction network

\[
G_t=(N,E_t).
\]

A collective state can therefore be represented schematically as

\[
X_t=(m_{1,t},\ldots,m_{n,t},G_t,R_t),
\]

where \(R_t\) denotes whatever previously acquired functions or knowledge the analysis requires the network to preserve.

## 3.2 Meta-level

Three processes must then be separated.

### \(L_0\): ordinary learning

\[
m_{i,t}\rightarrow m_{i,t+1}.
\]

An agent changes its model or capability.

### \(L_1\): maintenance of learning conditions

\[
G_t\rightarrow G_{t+1}
\]

and changes in the properties of its edges determine how later correction can occur.

This is the central level of the present paper.

### \(L_2\): learning how to maintain learning

Processes at \(L_1\) themselves change:

\[
P_t\rightarrow P_{t+1}.
\]

A network might learn better protocols for criticism, verification, disagreement, repair, or knowledge retention.

This is learning-to-learn and is important, but it is treated here as a downstream extension.

Keeping these distinctions explicit prevents three different propositions from being confused:

\[
\text{I learned something;}
\]

\[
\text{I preserved or improved the conditions under which I can learn again;}
\]

and

\[
\text{I learned how to improve those conditions more effectively.}
\]

---

# 4. The inside description: learning-maintenance verbs

An intelligent agent does not experience an edge as a graph-theoretical object. It acts.

We therefore introduce a vocabulary of **learning-maintenance verbs**. They are not axioms and they are not assumed to be universally beneficial. They identify processes whose effects on the outside network can be tested.

| Inside process | Candidate functional role |
| --- | --- |
| **seek / encounter** | create opportunities for potentially informative interaction |
| **listen** | permit information from another model to enter one's own evaluation process |
| **signal faithfully** | reduce distortion between what an agent knows or observes and what it communicates |
| **expose uncertainty** | make possible model error easier for others to locate |
| **test** | discriminate between candidate claims or models |
| **revise** | permit evidence-supported change rather than merely receiving information |
| **maintain disagreement** | preserve alternative models long enough for them to remain testable |
| **maintain the edge** | prevent disagreement over content from automatically terminating the information channel |
| **repair** | restore productive interaction after failure or violation |
| **re-engage** | permit a repaired edge to become usable again when evidence supports doing so |
| **retain** | prevent validated correction from being immediately lost |
| **recombine** | construct new candidates from partial organization distributed across agents |

These terms require care.

**Listening is not agreement.**

An agent can accurately represent another's claim and reject it after testing.

**Openness is not gullibility.**

Lower resistance to evidence-supported correction need not imply lower resistance to unsupported assertion.

**Maintaining disagreement is not maximizing conflict.**

Conflict can impair performance, particularly when task disagreement becomes relational conflict. The relevant hypothesis is that potentially informative alternatives sometimes need to survive long enough to be tested.

**Repair is not restoration of the previous state.**

A repaired relationship may appropriately have changed boundaries, safeguards, or confidence.

**Re-engagement is not unconditional trust.**

It is the restoration of some future interaction probability conditional on evidence of repair.

These distinctions allow the inside vocabulary to become mechanistic rather than moralistic.

---

# 5. The outside description: edges as an accessibility geometry

From outside the network, an edge is useful only insofar as it enables some interaction that matters for learning.

The mere existence of contact is insufficient.

Two people may know one another yet be unable to exchange criticism. A team may meet daily while information is routinely distorted. A communication platform may connect millions of people while producing rapid convergence on poor information.

We therefore require a quantitative description.

## 5.1 Edge cost

Let

\[
c_{ij,t}
\]

denote the operational cost of obtaining a specified kind of informative interaction from agent \(j\) to agent \(i\) at time \(t\).

Depending on the application, this cost could include time, attention, communication effort, reputational risk, expected interaction attempts, coordination burden, or another declared resource.

A high value means that the edge is difficult to use productively.

We can loosely call this **edge viscosity**:

\[
\eta_{ij,t}\equiv c_{ij,t}.
\]

A corresponding mobility or conductance can be written for convenience as

\[
\mu_{ij,t}
=
\frac{1}{1+\eta_{ij,t}}.
\]

This transformation has no universal physical significance. It simply makes the direction intuitive:

\[
\eta\uparrow
\quad\Longleftrightarrow\quad
\mu\downarrow.
\]

An edge can therefore remain formally present while approaching functional closure:

\[
E_{ij}=1,
\qquad
\eta_{ij}\gg 1.
\]

This captures an important fact:

\[
\boxed{
\text{connectivity}
\neq
\text{corrigibility}.
}
\]

## 5.2 Network-level acquisition cost

The more general object is not an edge cost but the cost of a future collective transition.

Let \(y\) be a target future state of the intelligent network and let \(R_t\) denote a declared repertoire that must be preserved.

Define

\[
C_t(X_t,y\mid R_t)
\]

as the minimum declared cost of reaching \(y\) from current state \(X_t\) while preserving \(R_t\).

No metric axioms are assumed.

In general,

\[
C_t(X,y)\neq C_t(y,X).
\]

Nor must the triangle inequality hold.

This asymmetry is essential. Learning an error may be cheap while correcting an entrenched error is expensive. Losing a relationship can be easy while rebuilding sufficient confidence for productive criticism may take years.

For a simple path-additive model,

\[
C_t(\gamma)
=
\sum_{e\in\gamma}\eta_{e,t},
\]

and

\[
C_t(X,y)
=
\inf_{\gamma:X\leadsto y} C_t(\gamma).
\]

The general theory does not depend on this additive specialization.

---

# 6. Plasticity and viscosity

A statement such as “this network is open to change” hides too much.

Open toward what?

At what cost?

While preserving what?

Let \(\mathcal Y\) denote a declared family of potentially useful future states and let \(\mu\) be a distribution over them.

Define the **plasticity profile**

\[
\Pi_t(B)
=
\Pr_{y\sim\mu}
\left[
C_t(X_t,y\mid R_t)\leq B
\right].
\]

This answers:

> What fraction of the relevant future transitions can this network accomplish under budget \(B\) while preserving the required inherited function?

Correspondingly define a viscosity quantile

\[
V_t(q)
=
\inf
\left\{
B:
\Pi_t(B)\geq q
\right\}.
\]

The network is less viscous toward the specified target distribution when the same fraction of future transitions can be achieved at lower cost.

This is a **profile**, not a personality trait.

The same network may be highly plastic toward one class of corrections and extremely viscous toward another.

That is desirable in principle.

The target is not maximal plasticity but **selective corrigibility**:

\[
\boxed{
\text{low viscosity toward justified correction}
+
\text{sufficient resistance to unsupported perturbation}.
}
\]

---

# 7. Differential speeds

Nothing in this framework needs to be permanently fixed.

A central premise is that every component of the network may change, but at different characteristic rates.

Let

\[
\tau_k
\]

denote a characteristic timescale of organizational variable \(k\).

Schematically,

\[
\frac{dx_k}{dt}
=
\frac{1}{\tau_k}F_k(X,E).
\]

Fast variables can respond rapidly to new information. Slower variables preserve accumulated organization against every transient perturbation.

This provides a useful interpretation of relationship stability.

The content of a disagreement may change quickly:

\[
\tau_{\text{content}}
\text{ small},
\]

while the relationship carrying the disagreement can remain comparatively persistent:

\[
\tau_{\text{edge}}
>
\tau_{\text{content}}.
\]

If every local disagreement immediately destroys the corresponding edge, then \(L_0\) perturbations continuously destroy \(L_1\) learning infrastructure.

Conversely, an edge that can never change may preserve a harmful or corrupted channel indefinitely.

The relevant property is therefore not permanence but **reversible persistence**.

A learning network may benefit when:

\[
\boxed{
\text{ordinary disagreement changes faster than the relationships required to investigate it.}
}
\]

When a serious violation occurs, the edge can change. When evidence of repair accumulates, it may change again.

Thus

\[
\tau<\infty
\]

for every component.

Stability emerges from relative rates, not immutability.

---

# 8. The learning loop, the ratchet, and the vortex

Several terms that are often used metaphorically can now be separated.

## 8.1 The loop

The **learning loop** is recurrence:

\[
\text{encounter}
\rightarrow
\text{information}
\rightarrow
\text{candidate}
\rightarrow
\text{test}
\rightarrow
\text{revision}
\rightarrow
\text{later encounter}.
\]

A loop need not improve anything. It may repeatedly reproduce error.

## 8.2 The ratchet

The **learning ratchet** introduces historical asymmetry.

A candidate change is not enough.

It must pass through at least three conceptually distinct stages:

\[
\text{variation}
\rightarrow
\text{validated improvement}
\rightarrow
\text{retained improvement}.
\]

Retention makes the result available as starting organization for subsequent rounds.

For an intelligent network, however, retaining the corrected belief while destroying all relationships capable of providing the next correction is an incomplete ratchet.

The stronger form is:

\[
\boxed{
\text{validated correction}
\rightarrow
\text{retained function}
+
\text{preserved future correction capacity}.
}
\]

The ratchet therefore has two potential failure modes.

One is **forgetting**:

\[
\text{past validated function is lost}.
\]

The other is **loss of learnability**:

\[
\text{past function remains, but future correction becomes increasingly inaccessible}.
\]

## 8.3 The vortex

The **vortex** describes the wider circulation.

Current organization shapes whom agents encounter, what they can understand, what they can test, what resources they can mobilize, and which relationships remain available.

Learning then modifies that organization.

Thus:

\[
\boxed{
\begin{array}{c}
\text{current network}\\
\downarrow\\
\text{opportunities for interaction}\\
\downarrow\\
\text{generation and testing}\\
\downarrow\\
\text{retained correction}\\
\downarrow\\
\text{changed agents and edges}\\
\downarrow\\
\text{changed future opportunities}\\
\circlearrowleft
\end{array}}
\]

The vortex is circulation.

The ratchet is the historical asymmetry within that circulation.

---

# 9. Learning velocity

A system can be capable of learning while learning extremely slowly.

A theory of intelligent networks therefore requires rates.

Let

\[
C_t^{\mathrm{perf}}(X_t,f)
\]

denote the declared cost with which the current network performs functional target \(f\).

A retained functional gain over one transition is

\[
g_t(f)
=
C_t^{\mathrm{perf}}(X_t,f)
-
C_{t+1}^{\mathrm{perf}}(X_{t+1},f).
\]

For a positive interval \(\Delta t\),

\[
\boxed{
v_t(f)
=
\frac{g_t(f)}{\Delta t}.
}
\]

This is **functional learning velocity**.

It should not be confused with activity, communication volume, or rate of belief change.

A rapidly changing network can have

\[
v_t(f)\leq0
\]

if it changes noisily, forgets validated results, or converges on worse solutions.

## 9.1 A mechanism ledger

One useful reduced decomposition is

\[
\boxed{
v
=
\lambda
p_G
p_R
p_V
p_T
\bar g ,
}
\]

where:

- \(\lambda\) is an opportunity rate;
- \(p_G\) is the probability that an opportunity produces a useful candidate;
- \(p_R\) is resource feasibility;
- \(p_V\) is probability of successful validation;
- \(p_T\) is probability of retention;
- \(\bar g\) is mean retained functional gain.

This product is not proposed as a universal law.

Its role is diagnostic.

It makes explicit that increasing one mechanism does not necessarily improve system-level velocity when mechanisms compete for common resources or affect one another.

The inside verbs can be mapped onto candidate coordinates.

Seeking may increase \(\lambda\).

Faithful signalling and listening may affect whether useful information enters candidate generation.

Testing may increase \(p_V\) while also adding delay.

Revision can shorten the delay between evidence and justified update.

Repair and re-engagement can restore future opportunities and therefore affect later \(\lambda\).

Retention alters \(p_T\).

Recombination can change both candidate-generation probability and the distribution of possible gains.

These are hypotheses to test, not semantic definitions.

---

# 10. Opportunity and delay

Rate requires something stronger than eventual recurrence.

Suppose useful learning opportunities occur arbitrarily late but the waiting time between them grows without bound. The system may remain theoretically capable of learning while its long-run rate approaches zero.

Introduce:

\[
K=\text{maximum opportunity gap}
\]

and

\[
\Delta=\text{maximum validated-response delay}.
\]

If, from any time point, a relevant opportunity occurs within \(K\) steps and every such opportunity receives a resource-feasible validated response within a further \(\Delta\) steps, then every window of width

\[
K+\Delta+1
\]

contains at least one validated update.

If each such update contributes at least

\[
g_{\min}>0
\]

to a declared functional target and intervening changes do not erase that gain, then the corresponding guaranteed local average rate is bounded below by

\[
\boxed{
v_{\min}
\geq
\frac{g_{\min}}{K+\Delta+1}.
}
\]

This simple relation gives several inside processes an outside interpretation.

Maintaining useful edges can reduce opportunity gaps.

Listening and revision can reduce response delays.

Better testing can increase validated gain, although more testing may also increase delay.

The quantities therefore interact.

---

# 11. Why more contact is not necessarily faster learning

It would be tempting to conclude that learning networks should simply maximize connectivity.

Existing collective-learning research strongly cautions against this.

Rapid information diffusion can produce premature convergence. Sparse or inefficient networks can preserve independent exploration. The effect of diversity depends on task complexity and network structure. Social influence can reduce independence even when it increases apparent consensus. Conflict itself is not reliably beneficial.

Our theory should therefore predict no universal monotonic relationship between connectivity and retained learning velocity.

A minimal example illustrates why.

Suppose a unit resource budget is divided between search and validation. Let \(x\) be allocated to search and \(1-x\) to validation.

Then the reduced velocity

\[
v(x)=x(1-x)
\]

has

\[
v(0)=v(1)=0
\]

and

\[
v_{\max}
=
v\left(\frac12\right)
=
\frac14.
\]

More search accelerates learning when search is the bottleneck, but decreases retained learning once validation becomes the bottleneck.

This reduced model is intentionally elementary. Its importance is conceptual:

\[
\boxed{
\text{more interaction}
\not\Rightarrow
\text{more learning}.
}
\]

The scientific target is therefore not the number of edges.

It is the organization of edges into a network capable of generating, preserving, testing, correcting, and retaining useful differences.

---

# 12. Maintaining disagreement

A learning network faces a recurring tension.

Information must diffuse.

But if every agent rapidly adopts the currently dominant model, the network can lose the independent variation required to discover that the dominant model is wrong.

A dissenting edge or minority model can therefore have value even when it is not presently correct.

Its value may lie in preserving an alternative trajectory.

This does not imply that disagreement is intrinsically good. Persistent disagreement can arise from misinformation, incompatible goals, strategic manipulation, or simple noise.

The claim is narrower:

\[
\boxed{
\text{premature elimination of independent models can remove future search directions.}
}
\]

Hence a network can be too viscous because nobody revises, but it can also be too fluid because every node rapidly copies everyone else.

Effective collective learning requires an interaction between local exploration and network-level retention of diversity.

---

# 13. Edge failure and repair

Relationships fail.

Signals are misunderstood.

Agents make errors.

Trust can be violated.

Coordination can collapse.

A theory in which productive learning requires perfect persistent edges would therefore describe almost no real intelligent network.

Repair must be part of the dynamics.

Suppose a failure raises edge viscosity:

\[
\eta_{ij,t}
\rightarrow
\eta_{ij,t+1}.
\]

In the extreme,

\[
\eta_{ij}\rightarrow\infty,
\]

and the channel becomes functionally inaccessible.

Repair is a process that can lower this cost again when sufficient evidence supports restored interaction:

\[
\eta_{ij,t+k}
<
\eta_{ij,t+1}.
\]

This need not return the edge to its original state.

Indeed, successful repair may involve new constraints, monitoring, boundaries, or reduced trust.

The relevant property is **reversibility**.

An edge whose penalty can never decrease after any failure behaves differently from one whose future state remains evidence-sensitive.

This gives a precise interpretation to re-engagement or forgiveness in the present framework:

\[
\boxed{
\text{forgiveness is not deletion of evidence;
it is the possibility that edge viscosity can fall after demonstrated repair.}
}
\]

Whether it should fall in a particular case is an empirical and contextual question.

---

# 14. The informational option value of an edge

The option-value interpretation of learning relationships is not new. Katsamakas (2007) explicitly argued that network relationships can carry **strategic learning option value** because they preserve rights to potential future learning benefits, and that loss of trust can destroy that value. The present framework adopts that antecedent and makes a narrower move: it represents the option in terms of future validated functional gain enabled by a directed, repairable correction channel.

A useful consequence of the framework therefore concerns uncertainty.

Suppose agent \(i\) believes \(A\) and agent \(j\) believes \(B\).

Neither possesses direct access to a perfect external representation of the world.

Maintaining the edge does not require assuming that \(j\) is correct.

Its potential value follows precisely from not knowing in advance which model will later prove useful.

For horizon \(H\), define schematically the future informational option value of edge \(ij\) as

\[
\mathcal O_{ij,t}(H)
=
\mathbb E
\left[
\sum_{h=1}^{H}
\delta^h
G_{ij,t+h}
\right],
\]

where \(G_{ij,t+h}\) is the future validated functional gain causally enabled by access to that edge and \(\delta\) determines how later gains are weighted.

This quantity need not always be positive.

Maintaining an edge has costs.

Some edges systematically transmit false or adversarial information.

Some interactions impose unacceptable risk.

Some redundancy makes an edge unnecessary.

The claim is therefore conditional:

\[
\boxed{
\text{an informative, corrigible edge can possess positive future option value even when it supplies no immediate gain.}
}
\]

This is why the value of a relationship can exceed the value of the information currently passing through it.

The edge preserves a possibility.

---

# 15. Two trajectories

The framework makes contrasting network trajectories easy to express.

## 15.1 Fragile learning network

\[
\text{error}
\rightarrow
\text{disagreement}
\rightarrow
\text{relationship conflict}
\rightarrow
\text{edge destruction}
\rightarrow
\text{fewer independent correction channels}
\rightarrow
\text{greater future correction cost}.
\]

Repeated often enough, the network can become fragmented or epistemically segregated.

## 15.2 Repairable learning network

\[
\text{error}
\rightarrow
\text{disagreement}
\rightarrow
\text{testing}
\rightarrow
\text{revision where warranted}
\rightarrow
\text{repair}
\rightarrow
\text{retained correction}
\rightarrow
\text{continued future accessibility}.
\]

The second trajectory does not require harmony.

In fact, productive disagreement can remain visible.

Its defining feature is that disagreement about \(L_0\) content does not automatically destroy the \(L_1\) infrastructure required to investigate later disagreements.

---

# 16. Falsifiable hypotheses

The framework becomes scientifically useful only when the verbs can fail.

## H1 — Edge-maintenance hypothesis

For repeated learning problems in which an edge has non-zero probability of carrying unique useful information, preserving that edge through ordinary disagreement will reduce expected future correction cost relative to permanent severance.

**Counter-result:** edge preservation does not improve future correction accessibility or performs worse after accounting for maintenance costs.

## H2 — Repairability hypothesis

Following a recoverable edge failure, evidence-sensitive repair and re-engagement will produce higher long-run retained learning velocity than either unconditional continuation or irreversible severance.

**Counter-result:** repair provides no advantage over one of the two simpler policies.

## H3 — Selective-corrigibility hypothesis

Networks that are highly responsive to evidence-supported correction while remaining resistant to unsupported perturbation will outperform networks characterized by either generalized rigidity or generalized suggestibility.

**Counter-result:** indiscriminate openness or indiscriminate stability performs equally well or better.

## H4 — Opportunity-gap hypothesis

Processes that preserve informative interaction channels will increase learning velocity partly by reducing the waiting time \(K\) between useful correction opportunities.

**Counter-result:** changes in edge availability do not mediate learning rate through opportunity frequency.

## H5 — Revision-delay hypothesis

When evidence quality is held constant, processes that permit justified revision will improve learning velocity partly by reducing response delay \(\Delta\).

**Counter-result:** revision latency does not predict retained learning rate.

## H6 — Uncertainty-exposure hypothesis

Accurate communication of uncertainty will improve network correction efficiency when it helps other agents allocate testing effort to locations where model error is plausible.

**Counter-result:** uncertainty exposure produces no improvement in correction cost or systematically degrades it.

## H7 — Diversity-retention hypothesis

For sufficiently complex search problems, maintaining independently generated candidate models will improve discovery relative to immediate convergence, but the effect will depend on network structure and validation capacity.

**Counter-result:** independent alternatives never improve retained outcomes after communication and validation are controlled.

## H8 — Edge-timescale hypothesis

In repeated learning environments, networks in which ordinary content disagreement occurs faster than irreversible edge loss will preserve greater future correction capacity than networks in which each disagreement strongly and permanently updates relationship availability.

**Counter-result:** coupling edge survival tightly to each local disagreement does not impair later learning.

## H9 — Learning-maintenance hypothesis

Two networks with matched initial capability but different learning-maintenance processes will diverge in future capability trajectories because their acquisition-cost geometries change differently.

**Counter-result:** after initial performance is matched, manipulating the declared learning-maintenance processes produces no persistent difference in future learning cost.

---

# 17. Multi-agent language models as an experimental workbench

Multi-agent language models offer a particularly clean test because the relevant level of analysis can be reproduced directly.

Each model instance is a node.

Messages form edges.

The interaction protocol implements learning-maintenance processes.

The experiment therefore does not require claiming that an LLM is neurologically equivalent to a human being.

It tests the network logic.

## 17.1 Basic design

Initialize multiple groups from identical model instances.

Give all groups the same sequence of complex tasks containing distributed or partially hidden information.

No single agent initially receives all information required for optimal performance.

Assign agents different observations, candidate explanations, or partial solutions.

Construct matched network conditions that differ only in their interaction protocol.

Candidate interventions include:

- whether agents actively seek input from other nodes;
- whether a receiving agent must accurately restate another agent's claim before evaluating it;
- whether agents report calibrated uncertainty;
- whether independent criticism is explicitly requested;
- whether dissenting candidate models are preserved for later testing;
- whether conclusions require an independent validation step;
- whether agents may revise after validation;
- whether an edge remains available after disagreement;
- whether failed interactions receive a structured repair exchange;
- whether successfully repaired edges can be re-engaged;
- whether validated conclusions enter shared retained memory;
- whether agents can recombine partial solutions discovered on different branches.

## 17.2 Primary outcomes

Do not use final benchmark accuracy alone.

Measure:

\[
K
=
\text{waiting time to useful information},
\]

\[
\Delta
=
\text{delay from useful evidence to validated revision},
\]

\[
p_T
=
\text{retention probability},
\]

\[
F_t
=
\text{retained functional repertoire},
\]

\[
C_t^{\mathrm{acq}}
=
\text{cost of subsequent correction},
\]

and

\[
v_t
=
\text{retained functional gain per unit resource}.
\]

Also measure network properties directly:

- edge survival after disagreement;
- edge repair time;
- fragmentation;
- message redundancy;
- diversity of candidate solutions;
- premature convergence;
- frequency with which unique information remains stranded;
- frequency with which false information propagates.

## 17.3 The critical longitudinal test

The strongest experiment is sequential.

After each task, preserve the modified interaction history or process state and present a new held-out problem.

Then ask not merely:

> Did the network solve the previous problem?

but:

> Did the way it solved the previous problem make the next correction cheaper or more expensive?

This estimates

\[
C_0^{\mathrm{acq}}
\rightarrow
C_1^{\mathrm{acq}}
\rightarrow
\cdots
\rightarrow
C_T^{\mathrm{acq}}.
\]

Two initially equivalent networks may then diverge:

\[
F_t^A-F_t^B
\]

because their learning-maintenance processes generate different future accessibility geometries.

That is the experimentally relevant ratchet.

---

# 18. Human experiments

The same predictions can be tested with human groups without requiring the full theory to be inferred from observational social networks.

A laboratory design could distribute unique information among participants solving repeated complex problems.

Conditions could manipulate:

1. whether disagreement threatens future interaction;
2. whether participants can repair a failed interaction;
3. whether uncertainty is communicated;
4. whether minority hypotheses remain available for later testing;
5. whether previous validated corrections remain visible;
6. whether participants are rewarded only for individual correctness or also for preserving future group performance.

The primary endpoint should again be longitudinal.

A group that solves round one fastest may not be the group that retains the highest learning velocity after twenty rounds.

Relevant outcomes include correction latency, network fragmentation, distribution of participation, retention of minority information, re-use of previously productive edges, and acquisition cost on new problems.

This separates immediate performance from the maintenance of future learnability.

---

# 19. Relationship to existing literatures

The framework is intentionally positioned as a synthesis and formal interface rather than a claim that its component mechanisms are individually new.

## 19.1 Exploration and exploitation

Organizational-learning research has long recognized the tension between exploration and exploitation. Network models and experiments further show that rapid diffusion can promote short-term convergence while reducing independent search. Lazer and Friedman demonstrated theoretically that network structure changes this trade-off; Brackbill and Centola later showed experimentally that less efficient communication networks could discover better solutions in complex data-science problems.

The present framework adds a distinction between **communication topology** and **maintenance of the channels themselves**.

## 19.2 Collective learning and diversity

The collective-brain literature emphasizes that human knowledge exceeds individual cognitive capacity because information is accumulated and transmitted socially. Work by Muthukrishna and Henrich, Schimmelpfennig and colleagues, Barkoczi and Galesic, and Baumann and colleagues shows that diversity, social-learning strategy, network density, and task complexity interact.

This supports our refusal to treat more diversity or more connectivity as uniformly beneficial.

## 19.3 Psychological safety and speaking up

Edmondson's work on psychological safety demonstrated that interpersonal conditions affect whether team members engage in learning behavior, including asking for help, discussing errors, experimenting, and speaking up.

The present model offers an outside interpretation of this phenomenon: interpersonal conditions can alter the cost of transmitting potentially corrective information across an edge.

Psychological safety and edge viscosity are not the same construct. The former is a psychological and team-level construct; the latter is an abstract operational quantity. The proposed relation between them is empirical.

## 19.4 Conflict and disagreement

Research on task and relationship conflict cautions against treating disagreement itself as beneficial. Meta-analytic evidence has found negative average associations between both relationship conflict and task conflict and team performance, although context and the entanglement between task and relational conflict matter.

Our claim is therefore not “conflict improves learning.”

It is that eliminating potentially informative differences before they can be evaluated can reduce search, and that intelligent networks require processes capable of investigating disagreement without automatically destroying the relevant edges.

## 19.5 Trust and repair

Trust-repair research already studies how relationships can recover following violations through apology, explanation, compensation, structural safeguards, monitoring, forgiveness, and other mechanisms.

The present theory does not replace that work.

It asks a different functional question:

> What happens to future learning accessibility when a damaged information channel is permanently closed, imperfectly restored, or conditionally re-engaged?

Repair thereby enters a rate theory of collective learning.

## 19.6 Strategic learning options

Katsamakas (2007) is a close conceptual antecedent to the present option-value argument. In his organizational-network account, investment in relationships preserves future learning opportunities, trust expands those opportunities, and loss of trust can destroy learning option value.

The present paper therefore does not claim that relationships have future learning option value as a new idea. Its narrower contribution is to connect that option value to a target-dependent correction-cost geometry, explicit repair and re-engagement dynamics, and retained functional-learning velocity.

## 19.7 Plasticity and metaplasticity

Neural and machine-learning research distinguishes present performance from future plasticity. Learning can change the capacity for later learning, and continual-learning systems can retain current competence while progressively losing plasticity.

These systems operate at a different scale from the present paper.

Their relevance is structural:

\[
\boxed{
\text{current competence}
\neq
\text{future learnability}.
}
\]

The present paper applies the same logical distinction to the edges of an intelligent-agent network.

---

# 20. Formal status

Parts of the outside framework have already been machine-checked in Lean within the Evolution by Emergence formalization.

The relevant results include the following.

## 20.1 Quantitative accessibility

If a new condition makes every declared future target no more costly and at least one strictly cheaper, then there exists a budget threshold at which the accessible target set strictly expands.

Schematically,

\[
C_{t+1}(y)\leq C_t(y)
\quad
\forall y\in\mathcal Y,
\]

with strict inequality for some \(y^\ast\), implies the existence of \(B\) such that

\[
\mathcal A_t(B)
\subsetneq
\mathcal A_{t+1}(B).
\]

## 20.2 Bounded opportunity and response

A bounded opportunity gap \(K\) plus bounded validated-response delay \(\Delta\) implies at least one validated update in every window of width

\[
K+\Delta+1.
\]

With an additional minimum retained-gain assumption, this yields the corresponding positive local rate certificate.

## 20.3 Search–validation trade-off

For the reduced shared-budget model

\[
v(x)=x(1-x),
\]

Lean verifies the unique maximum at

\[
x=\frac12,
\]

and verifies that increasing search beyond this point decreases retained velocity.

These results validate implications under explicit assumptions.

They do **not** prove that listening, honesty, repair, disagreement, or re-engagement necessarily improve collective learning.

Those bridges remain empirical.

That distinction is central to the framework.

---

# 21. Scope and non-claims

The theory does not imply that:

- every relationship should be preserved;
- more communication is always beneficial;
- denser networks learn faster;
- trust should be unconditional;
- disagreement is intrinsically productive;
- forgiveness requires forgetting a violation;
- every damaged relationship can or should be repaired;
- exposure to false information is harmless;
- every participant has equally useful information;
- every edge has positive informational option value;
- all learning can be represented by pairwise edges;
- human social relationships are reducible to information channels;
- the same microscopic mechanism operates in brains, LLMs, organizations, and societies;
- increased learning velocity is equivalent to moral, social, or political improvement.

The target family, retained repertoire, success criterion, and cost function must always be declared.

This makes the theory conditional rather than normative.

An edge can be valuable for one learning problem and harmful for another.

---

# 22. Discussion

The framework begins from a mundane observation: intelligent agents are fallible.

But fallibility changes the functional interpretation of relationships.

If I already possessed a complete and error-free world model, another person's disagreement would have no epistemic necessity. I could evaluate it entirely from a privileged external position.

Real agents do not have that position.

My own certainty cannot, by itself, distinguish the world in which I am correct from a sufficiently convincing world in which I am mistaken.

I therefore sometimes depend on processes outside my present model.

An informative relationship is one such process.

This does not establish that the other person is right.

It establishes something weaker and more important:

\[
\boxed{
\text{I cannot know in advance every future correction for which another model may become useful.}
}
\]

The value of contact therefore need not lie in immediate agreement.

A maintained edge can preserve future optionality.

This gives familiar interpersonal activities a second description.

From inside:

> I listen.

From outside:

> Information from another model remains able to enter my evaluation process.

From inside:

> I admit uncertainty.

From outside:

> Potential error becomes easier for other nodes to target.

From inside:

> I disagree without ending the relationship.

From outside:

> Model diversity changes while the correction channel remains accessible.

From inside:

> We repair the relationship.

From outside:

> Edge viscosity falls after a failure.

From inside:

> I forgive and re-engage after demonstrated repair.

From outside:

> A previously penalized channel becomes conditionally accessible again.

Neither description replaces the other.

The outside description does not capture what the relationship means to the participants.

The inside description alone does not tell us whether the process actually improves collective learning.

Together they create a testable theory.

This also suggests a different way of thinking about collective intelligence.

The intelligence of a network is not simply the sum of the intelligence of its nodes.

Nor is it simply their connectivity.

Part of collective intelligence lies in the processes that determine whether information can continue crossing differences between nodes after mistakes, uncertainty, and disagreement inevitably occur.

The network must not merely possess edges.

It must be able to **maintain, regulate, and where appropriate repair the edges through which it can be corrected**.

That is a dynamic property.

It has timescales.

It has bottlenecks.

It can accelerate.

It can decay.

And it can potentially be learned.

---

# 23. Conclusion

This paper develops an inside–outside theory of learning in networks of intelligent agents.

The inside description consists of learning-maintenance processes: seeking, listening, faithful signalling, uncertainty exposure, testing, revision, maintenance of informative disagreement, repair, re-engagement, retention, and recombination.

The outside description treats the same system as a dynamic accessibility geometry in which edges and collective transitions have costs.

Plasticity describes the distribution of affordable future change.

Viscosity describes resistance to such change.

Learning velocity describes the rate of retained functional improvement.

The ratchet occurs when validated correction becomes retained history without consuming the network's capacity for future correction.

The central object is therefore neither maximal stability nor maximal plasticity.

It is a network that remains **selectively corrigible**.

Such a network can preserve useful history while allowing evidence to change it. It can maintain differences without requiring permanent division. It can suffer failures without making every loss irreversible.

The practical implication follows from the mathematics rather than preceding it.

More contact is not always better.

More disagreement is not always better.

More trust is not always better.

But when an edge carries a genuine possibility of future correction, preserving its usability can preserve something the network may not be able to reconstruct cheaply later.

Thus a relationship between intelligent beings can be understood simultaneously in two ways:

\[
\boxed{
\begin{array}{c}
\textbf{Inside:}\\
\text{a continuing willingness to encounter, listen, test, revise, and repair}
\\[3mm]
\Updownarrow\\[3mm]
\textbf{Outside:}\\
\text{a maintained route through the network's future correction geometry.}
\end{array}
}
\]

The reason to preserve such a route is not certainty about what another agent knows.

It is precisely the absence of that certainty.

In a fallible network, the edge may be part of what makes future error correctable.

---

# References

Barkoczi, D., & Galesic, M. (2016). Social learning strategies modify the effect of network structure on group performance. *Nature Communications, 7*, 13109. https://doi.org/10.1038/ncomms13109

Baumann, F., Czaplicka, A., & Rahwan, I. (2024). Network structure shapes the impact of diversity in collective learning. *Scientific Reports, 14*, 2491. https://doi.org/10.1038/s41598-024-52837-3

Brackbill, D., & Centola, D. (2020). Impact of network structure on collective learning: An experimental study in a data science competition. *PLoS ONE, 15*(9), e0237978. https://doi.org/10.1371/journal.pone.0237978

De Dreu, C. K. W., & Weingart, L. R. (2003). Task versus relationship conflict, team performance, and team member satisfaction: A meta-analysis. *Journal of Applied Psychology, 88*(4), 741–749. https://doi.org/10.1037/0021-9010.88.4.741

Dohare, S., Hernandez-Garcia, J. F., Lan, Q., Rahman, P., Mahmood, A. R., & Sutton, R. S. (2024). Loss of plasticity in deep continual learning. *Nature, 632*, 768–774. https://doi.org/10.1038/s41586-024-07711-7

Edmondson, A. C. (1999). Psychological safety and learning behavior in work teams. *Administrative Science Quarterly, 44*(2), 350–383.

Edmondson, A. C., & Lei, Z. (2014). Psychological safety: The history, renaissance, and future of an interpersonal construct. *Annual Review of Organizational Psychology and Organizational Behavior, 1*, 23–43.

Kähkönen, T. (2021). Repairing trust within teams after organizational change. *Journal of Organizational Change Management*. https://doi.org/10.1108/JOCM-11-2020-0348

Lazer, D., & Friedman, A. (2007). The network structure of exploration and exploitation. *Administrative Science Quarterly, 52*(4), 667–694. https://doi.org/10.2189/asqu.52.4.667

Lewicki, R. J., & Brinsfield, C. (2017). Trust repair. *Annual Review of Organizational Psychology and Organizational Behavior, 4*, 287–313. https://doi.org/10.1146/annurev-orgpsych-032516-113147

March, J. G. (1991). Exploration and exploitation in organizational learning. *Organization Science, 2*(1), 71–87.

Muthukrishna, M., & Henrich, J. (2016). Innovation in the collective brain. *Philosophical Transactions of the Royal Society B, 371*, 20150192.

Sala, G. R., & Pratt, M. G. (2022). How organizations influence interpersonal trust repair: The case of a French antiterrorist unit. *Academy of Management Journal*. https://doi.org/10.5465/amj.2020.1093

Schimmelpfennig, R., Razek, L., Schnell, E., & Muthukrishna, M. (2022). Paradox of diversity in the collective brain. *Philosophical Transactions of the Royal Society B, 377*, 20200316. https://doi.org/10.1098/rstb.2020.0316

Woolley, A. W., Chabris, C. F., Pentland, A., Hashmi, N., & Malone, T. W. (2010). Evidence for a collective intelligence factor in the performance of human groups. *Science, 330*(6004), 686–688.
