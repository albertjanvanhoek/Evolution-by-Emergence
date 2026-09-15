# Sufficient Alignment

## A Viability Framework for Collective Intelligence

### Signal Fidelity, Redundant Correction, Repair, and Intergenerational Protocol Persistence

### Abstract

Alignment is often imagined as a property of individual agents: each agent should reliably produce approved actions, share a prescribed objective, or converge toward a common model. For collective intelligence this target is unnecessarily strong and can be counterproductive. A network of fallible learning agents can remain collectively capable even when individual agents err, disagree, withhold some information, or occasionally fail to cooperate, provided that the interaction architecture retains enough signal fidelity, correction, redundancy, repair, and intergenerational continuity to keep the collective learning process viable.

We formalize **alignment as a viability region rather than a point**. Let \(\Gamma_H(N,C;U)\) denote the maximal probability that a network \(N\), under collaboration architecture \(C\), can reach a declared target \(U\) within horizon \(H\). For a required performance level \(p_\star\), define
\[
\boxed{
\mathcal V_{\rm align}(U,p_\star)
=
\{C:\Gamma_H(N,C;U)\ge p_\star\}.
}
\]
Alignment is sufficient when \(C\in\mathcal V_{\rm align}\); perfect agreement or perfect behavior by every node is not part of the definition.

Four narrow results make this idea operational.

First, a **signal-fidelity result** formalizes the cooperative core of honesty. For any finite decision problem, every policy available after a deterministic garbling of a task-relevant signal can be implemented after observing the original signal with exactly the same value. Therefore optimizing over the ungarbled signal weakly dominates optimizing over the garbling. This is a finite deterministic specialization of Blackwell's comparison of experiments, not a new information theorem.

Second, a **redundant-correction result** considers three independent correction channels, each functioning with probability \(p\), where the collective process remains viable when at least two function. Its reliability is
\[
R_3(p)=3p^2-2p^3.
\]
On \(p\in[0,1]\), \(R_3\) is monotone,
\[
R_3(p)\ge\frac12\iff p\ge\frac12,
\]
and
\[
R_3(p)>p\qquad\text{for } \frac12<p<1.
\]
Thus improving the reliability of individual corrective behavior increases collective reliability without requiring \(p=1\), and redundancy can make the network more reliable than any single channel.

Third, a **protocol-inheritance result** defines
\[
R_{\rm protocol}=mp,
\]
where each protocol carrier has \(m\) transmission opportunities and each is successfully retained with probability or efficacy \(p\). The scalar threshold is
\[
R_{\rm protocol}>1\iff p>\frac1m.
\]
In the homogeneous expectation model, expected carrier counts grow above the threshold and decline below it. Under the standard nondegenerate Galton-Watson assumptions, the classical branching-process theorem strengthens this to almost-sure extinction at mean offspring \(\le1\) and positive survival probability above one.

Fourth, a **repair boundary** gives a minimal formalization of forgiveness. Let a damaged collaborative edge have restored value \(V\), outside-option value \(W\), repair success probability \(r\), and repair cost \(C_R\). Attempting repair weakly dominates termination exactly when
\[
\boxed{
C_R\le r(V-W).
}
\]
Forgiveness is therefore not universally optimal; its functional core is recoverability of valuable relations when expected recovered surplus exceeds repair cost and recurrence risk has been incorporated into the value terms.

Together these results reinterpret the Sustainable Collaborative Alignment Protocol (SCAP) as a proposed **heritable maintenance protocol for collective intelligence**. Honesty maps to signal fidelity, transparency to timely observability, corrigibility to model update capacity, reciprocity to closing return loops that maintain useful edges, forgiveness to repairability, and education to reproduction of the correction architecture itself. The framework does not derive moral obligations from mathematics. It identifies conditions under which networks of bounded learners can preserve and enlarge joint future accessibility.

The model-specific algebraic cores are machine checked in Lean 4. The general Blackwell theorem, general \(k\)-out-of-\(n\) reliability, Galton-Watson extinction theorem, and repeated-game results on forgiveness are treated as established external mathematics.

---

## 1. From individual alignment to collective intelligence

A single finite agent acts through an internal state, model, policy, representation, or other retained organization. A network of such agents distributes observations, memory, hypotheses, actions, and error across multiple loci.

This changes the alignment problem.

If alignment is defined as

\[
\text{every agent always acts correctly},
\]

then collective intelligence requires something close to perfection.

But networks are useful precisely because they can do something different. They can tolerate local error through redundancy, compare non-identical models, route around failed components, repair damaged relations, and preserve information across the turnover of individual members.

The relevant question is therefore not

> Are all agents perfectly aligned?

but

> Does the interaction architecture remain good enough for the collective learning process to stay viable?

This paper calls that **sufficient alignment**.

The phrase is deliberately analogous to sufficient regulation. A controller need not be maximal; it must be strong enough to keep the controlled process within its declared functional region. Likewise, an alignment architecture need not make every node identical or error-free. It must preserve the functions on which collective learning depends.

Those functions include at least:

- transmission of task-relevant information;
- detection of error;
- ability to update because of error;
- redundancy against local failure;
- repair of valuable damaged relations;
- return loops that keep useful relations maintained;
- transmission of the correction architecture to successor agents.

The last item matters because collective intelligence can persist longer than any participant.

---

## 2. Collective intelligence as joint accessibility

Let \(N\) be a network of bounded learning agents and let \(C\) denote its interaction architecture: communication channels, permissions, update protocols, repair rules, review mechanisms, incentive couplings, and other relations that affect joint action.

Let \(U\) be a declared target set and \(H\) a finite horizon. Define

\[
\Gamma_H(N,C;U)
=
\sup_{\pi\in\Pi(N,C)}
P^\pi(\text{reach }U\text{ within }H).
\]

This is a controlled-accessibility quantity. It asks what the network can achieve under the best admissible joint policy permitted by \(C\).

Let \(N^\perp\) denote an explicitly chosen comparison in which the focal collaborative edges are removed or disabled. Define collective surplus

\[
\boxed{
S_H(N,C;U)
=
\Gamma_H(N,C;U)
-
\Gamma_H(N^\perp;U).
}
\]

When \(S_H>0\), the collaborative architecture makes a positive causal contribution to the declared future target.

This motivates a functional definition:

\[
\boxed{
\begin{minipage}{0.86\linewidth}
\textbf{Collective intelligence} is the capacity of a network of bounded learning agents to use distributed information, correction, memory, and action to maintain or enlarge joint future accessibility beyond what the declared comparison system can reliably achieve without the relevant collaborative architecture.
\end{minipage}
}
\]

The definition does not require consciousness, identical objectives, or permanent membership. It does require an operational target and a comparison.

---

## 3. Alignment as a viability region

Fix a target \(U\), horizon \(H\), and required success level \(p_\star\). Define

\[
\boxed{
\mathcal V_{\rm align}(U,p_\star)
=
\{C:\Gamma_H(N,C;U)\ge p_\star\}.
}
\]

The architecture \(C\) may itself be multidimensional. For example,

\[
C=(f,o,k,r,\rho,d,\ldots),
\]

where, depending on the application:

- \(f\) measures signal fidelity;
- \(o\) measures observability or feedback latency;
- \(k\) measures corrigibility/update capacity;
- \(r\) measures repairability;
- \(\rho\) measures reciprocal return to edge maintenance;
- \(d\) measures useful model or sensor diversity.

Alignment is therefore not a scalar in general.

A network is **sufficiently aligned for the declared task** when

\[
C\in\mathcal V_{\rm align}.
\]

This definition has three immediate consequences.

First, perfect alignment is neither required nor privileged:

\[
C\in\mathcal V_{\rm align}
\not\Rightarrow
C=C_{\rm perfect}.
\]

Second, alignment is task- and horizon-dependent. The same network may be viable for one class of tasks and not another.

Third, the viability region can contain disagreement. Agents need not share identical world models if the protocol by which disagreement is tested remains operational.

This motivates a distinction between:

\[
\boxed{
\text{object-level diversity}
\quad\text{and}\quad
\text{protocol-level alignment}.
}
\]

Collective intelligence may benefit from the first while requiring enough of the second.

---

## 4. Signal fidelity: the cooperative core of honesty

### 4.1 Finite deterministic theorem

Let \(\Omega\) be a finite set of relevant world states. An agent observes signal

\[
S=s(\omega)
\]

and chooses an action according to policy

\[
\pi_S:S\to A.
\]

Let the weighted value of a policy be

\[
V(\pi_S)
=
\sum_{\omega\in\Omega}
w_\omega
u(\omega,\pi_S(s(\omega))).
\]

Now let

\[
Y=g(S)
\]

be a deterministic garbling of the signal, and let

\[
\pi_Y:Y\to A
\]

be any policy using only \(Y\).

Define the lifted policy

\[
\widetilde\pi_S(s)=\pi_Y(g(s)).
\]

Then identically,

\[
\boxed{
V(\widetilde\pi_S)=V(\pi_Y).
}
\]

Therefore every action rule available after the garbling is also available to a decision-maker that sees the original signal: the latter can simply perform the garbling internally.

Taking optima gives

\[
\boxed{
\sup_{\pi_S}V(\pi_S)
\ge
\sup_{\pi_Y}V(\pi_Y).
}
\]

This is the simple direction of Blackwell's comparison of experiments. Blackwell's theorem is stronger: under the standard statistical decision-theory formulation, one experiment weakly dominates another for all decision problems exactly when the latter can be obtained as a stochastic garbling of the former.

The present framework does not claim this as new mathematics.

### 4.2 Interpretation as an honesty result

For a cooperative corrective edge with a declared common decision objective, define honesty operationally as preservation of task-relevant signal fidelity.

Then:

\[
\boxed{
\text{unnecessary garbling of task-relevant corrective information
cannot increase maximal attainable decision value.}
}
\]

This is the precise content of the proposed **Honesty Theorem**.

It does not say:

- disclose every fact to every agent;
- privacy is harmful;
- strategic opponents should receive unfiltered information;
- information hazards do not exist;
- processing more information is costless;
- agents cannot disagree about what the signal means.

Those are different questions.

The theorem says something narrower: once a cooperative edge has been designated to carry task-relevant corrective information for a shared objective, destroying distinctions in that signal cannot expand the receiver's optimal decision set.

### 4.3 Alignment implication

Honesty is therefore not treated as a binary moral essence. It is a parameter controlling an information channel.

Teaching an agent why signal fidelity matters need not produce

\[
P(\text{truthful transmission})=1.
\]

It can instead change

\[
p\longrightarrow p+\Delta p.
\]

The collective consequences of that probabilistic shift depend on network architecture.

That leads to redundancy.

---

## 5. Sufficient alignment under redundant correction

Suppose three independent corrective channels each function in a round with probability \(p\). The collective correction process remains viable if at least two function.

Then

\[
\boxed{
R_3(p)
=
3p^2(1-p)+p^3
=
3p^2-2p^3.
}
\]

This is the standard \(2\)-out-of-\(3\) reliability model.

### Proposition 1: Monotonicity

For

\[
0\le p\le q\le1,
\]

\[
\boxed{
R_3(p)\le R_3(q).
}
\]

Improving the reliability of individual corrective behavior cannot lower collective reliability in this model.

### Proposition 2: Exact viability threshold

\[
\boxed{
R_3(p)\ge\frac12
\iff
p\ge\frac12.
}
\]

If the declared network-level viability target is \(1/2\), individual channels need only cross the corresponding sufficient threshold. They need not be perfect.

### Proposition 3: Redundancy gain

For

\[
\frac12<p<1,
\]

\[
\boxed{
R_3(p)>p.
}
\]

Indeed,

\[
R_3(p)-p
=
p(1-p)(2p-1)>0.
\]

Once individual channels are better than chance, majority redundancy makes the collective correction channel more reliable than a single component.

This is the simplest mathematical demonstration of the principle:

\[
\boxed{
\text{collective alignment need not mean individual perfection.}
}
\]

It requires sufficient component reliability plus an architecture that converts independent or weakly correlated competence into network-level robustness.

The independence assumption matters. Perfectly correlated errors remove much of the benefit. More generally, communication can improve individual estimates while simultaneously increasing correlation among errors; networked collective-intelligence research shows that whether social influence helps or harms depends on topology and task. The alignment target is therefore not maximum communication but an architecture that preserves enough information exchange without destroying useful diversity.

---

## 6. Selected alignment need not equal sufficient alignment

The regulation work in this repository already established

\[
\text{selected control}\neq\text{sufficient control}.
\]

The same distinction applies here.

Maintaining signal fidelity, listening, audit, redundancy, repair, and accountability has costs. An individual agent or subsystem can therefore optimize its own objective at a level of alignment investment below what keeps the collective network inside

\[
\mathcal V_{\rm align}.
\]

A minimal exact specialization makes the point.

Let \(e\) denote individual investment in a reliable corrective protocol and suppose the private objective is

\[
\boxed{
g(e)=ve-\frac{c}{2}e^2,
}
\]

with \(c>0\).

The unconstrained selected optimum is

\[
\boxed{
e_{\rm opt}=\frac{v}{c}.
}
\]

Indeed,

\[
\boxed{
g(e_{\rm opt})-g(e)
=
\frac{c}{2}(e-e_{\rm opt})^2\ge0.
}
\]

Now identify \(e\) with the component reliability \(p\) in the 2-out-of-3 correction model and retain the declared network viability target

\[
R_3(p)\ge\frac12.
\]

Section 5 showed that this requires

\[
p\ge\frac12.
\]

Therefore the privately selected effort is functionally sufficient exactly when

\[
\frac{v}{c}\ge\frac12,
\]

or

\[
\boxed{
2v\ge c.
}
\]

When

\[
2v<c,
\]

we have

\[
\boxed{
e_{\rm opt}<\frac12=e_{\rm func},
}
\]

so the privately selected amount of alignment is below the network's declared functional threshold.

This gives an explicit toy result:

\[
\boxed{
\text{selected alignment need not equal sufficient alignment}.
}
\]

The result should not be universalized beyond its assumptions. The private benefit and cost functions are deliberately simple, and real networks distribute both costs and collective returns across heterogeneous agents.

Its role is diagnostic: positive collective surplus does not imply that lower-level incentives maintain the interaction architecture that creates it.

This is the collective-intelligence form of the public-good problem already encountered in the regulation and integration models.

---

## 7. Intergenerational persistence of the alignment protocol

Collective intelligence can outlive its current members only if some of its learning architecture is reproduced.

Suppose each carrier of a collaboration/correction protocol has \(m\) effective transmission opportunities to successor agents. Let \(p\) denote the probability or efficacy with which the protocol is successfully retained in each opportunity.

Define

\[
\boxed{
R_{\rm protocol}=mp.
}
\]

Then

\[
\boxed{
R_{\rm protocol}>1
\iff
p>\frac1m.
}
\]

In the homogeneous expectation model, if \(N_n\) is expected protocol-carrier count,

\[
\boxed{
E[N_n]=N_0R_{\rm protocol}^n.
}
\]

Thus expected carrier count grows when

\[
R_{\rm protocol}>1
\]

and declines when

\[
0<R_{\rm protocol}<1.
\]

For a genuine nondegenerate Galton-Watson branching process, the standard extinction theorem is stronger: mean offspring \(\le1\) implies extinction almost surely, while mean offspring \(>1\) gives a positive probability of indefinite survival.

The threshold belongs to classical branching-process theory. The proposed application is to transmission of **meta-learning architecture**.

### 7.1 What should be inherited?

The target is not perfect copying of a doctrine.

Let

\[
M_n
\]

denote domain knowledge,

\[
Q_n
\]

the process generating candidate revisions, and

\[
C_n
\]

the correction/collaboration architecture.

A reproducing learning network ideally transmits some version of

\[
\boxed{
(M_n,Q_n,C_n)
\longrightarrow
(M_{n+1},Q_{n+1},C_{n+1}).
}
\]

If only \(M_n\) is copied, accurate inherited knowledge can eventually become dogma when the environment changes.

If \(C_n\) is copied perfectly and made immutable, the protocol itself becomes dogma.

The required invariant is therefore not textual identity of SCAP. It is preservation of enough capacity for future agents to test, repair, and revise the protocol itself.

That is inheritance of corrigibility.

---

## 8. Repairability: a minimal forgiveness boundary

Finite agents make errors. If every error irreversibly destroys a useful collaborative edge, long-horizon collaboration becomes brittle.

But unlimited forgiveness is equally indefensible when repair is expensive or exploitation is persistent.

A minimal decision model separates these cases.

Let:

- \(V\) = value if a damaged edge is successfully restored;
- \(W\) = value of terminating the edge and taking the outside option;
- \(r\) = probability that attempted repair succeeds;
- \(C_R\) = cost of repair.

Then

\[
V_{\rm repair}
=
rV+(1-r)W-C_R,
\]

whereas

\[
V_{\rm terminate}=W.
\]

Therefore

\[
V_{\rm repair}\ge V_{\rm terminate}
\]

exactly when

\[
\boxed{
C_R\le r(V-W).
}
\]

This is the proposed **repair boundary**.

It gives a technical core to forgiveness:

\[
\boxed{
\text{forgiveness}
\approx
\text{restoration of a damaged but still valuable and repairable edge}.
}
\]

The result explicitly allows non-forgiveness.

If

\[
C_R>r(V-W),
\]

termination is better in the stated model.

Recurring exploitation can be represented by reducing the effective restored value \(V\), reducing repair success \(r\), increasing repair cost, or explicitly extending the model with recurrence risk.

This aligns with experimental and evolutionary-game results showing that lenient and forgiving strategies can support cooperation under noise, while forgiveness remains conditional rather than unconditional.

---

## 9. SCAP as a maintenance protocol for collective intelligence

The Sustainable Collaborative Alignment Protocol originally expressed a set of normative-seeming principles: honesty, openness, reciprocity, forgiveness, transparency, accountability, care for enabling substrates, and transmission to subsequent generations.

The present stack supports a narrower reinterpretation.

| SCAP/TLC term | Network operation |
|---|---|
| Honesty | preserve task-relevant signal fidelity |
| Openness | maintain access to information not already fixed by the current model |
| Corrigibility | permit relevant error signals to alter model or policy |
| Transparency | make critical state/error signals observable with adequate latency |
| Reciprocity | return enough value to maintain productive edges |
| Accountability | couple local actions to downstream consequences and repair |
| Forgiveness | restore valuable relations after repairable failure |
| Patience | avoid terminating a still-correctable edge before repair can complete |
| Diversity / dissent | preserve nonredundant observations and reduce correlated blind spots |
| Peer review | distributed error detection |
| Education | reproduce correction architecture across agent turnover |
| Substrate stewardship | maintain the resources supporting the learning network |
| SCAP reflexivity | allow the protocol itself to be corrected |

These are **candidate functional mappings**, not universal mathematical equivalences.

The proposal is:

\[
\boxed{
\begin{minipage}{0.86\linewidth}
\textbf{SCAP is a proposed heritable maintenance protocol for collective intelligence: a set of interaction dispositions intended to keep the network's information, correction, repair, resource, and reproduction loops inside the viability region required for cumulative learning across changing agents and generations.}
\end{minipage}
}
\]

This is different from a command to make all agents behave identically.

---

## 10. Alignment should constrain process more strongly than conclusion

Suppose two agents hold different models:

\[
M_A\neq M_B.
\]

This need not be a defect. If their observations or inductive histories differ, model diversity may increase the chance that at least one detects a relevant distinction.

The more important shared structure may be the correction protocol:

\[
C_A\approx C_B.
\]

They may disagree about the world while remaining aligned on practices such as:

- report observations without strategic corruption on the cooperative edge;
- distinguish observation from inference;
- expose claims to counterevidence;
- allow valid correction to propagate;
- repair ordinary relational failure;
- maintain the resource base of the shared inquiry.

This motivates

\[
\boxed{
\text{alignment of learning protocol}
>
\text{uniformity of learned conclusions}.
}
\]

The inequality is conceptual, not a scalar theorem. Its point is that collective intelligence can require diversity at the object level while requiring sufficient interoperability at the meta level.

A concise target is:

\[
\boxed{
\textbf{not aligned minds, but interoperable learning processes.}
}
\]

---

## 11. Connection to Organizational Accessibility and the ratchet

A collaborative relation can itself be retained organization.

Let \(\Theta_t\) include not only domain knowledge but also the communication, review, repair, and training architecture that generated and preserved it.

If that architecture enlarges the operational repertoire,

\[
\mathcal R_t
\subsetneq
\mathcal R_{t+1},
\]

then collaboration has contributed to cumulative accessibility.

The ratchet requires retention. If every generation destroys the learning architecture and reconstructs it from scratch, earlier discoveries do not become infrastructure for later search.

The relevant inherited object is therefore not merely a proposition.

It is a capability:

\[
\boxed{
\text{ability to continue correcting together}.
}
\]

If SCAP or a successor protocol increases the probability that this capability is retained, it changes the variation-and-retention process governing future collective learning.

In OA language, the protocol can affect:

- current accessibility \(\mathcal A\);
- target-hitting probability \(\mathcal H\);
- candidate generation \(Q\);
- retention geometry;
- and, through intergenerational transmission, the starting architecture of future search.

This is why the alignment problem belongs naturally inside the cumulative-organization stack.

---

## 12. Alignment as second-order regulation

The analogy with physiological or organizational regulation can now be made precise enough to be useful.

First-order control acts on the world:

\[
\text{state}
\rightarrow
\text{action}.
\]

Second-order alignment acts on the architecture that determines how agents generate, exchange, test, and repair those actions:

\[
\boxed{
\text{interaction architecture}
\rightarrow
\text{quality of collective control}.
}
\]

The alignment variables are therefore meta-control parameters.

Like any controller, they can be:

- too weak;
- unnecessarily costly;
- delayed;
- captured;
- overcentralized;
- brittle;
- or misaligned with the declared function.

The correct target is not maximum control.

It is sufficient control:

\[
C\in\mathcal V_{\rm align}.
\]

This also makes alignment itself corrigible. A fixed alignment protocol may cease to fit a changed environment.

Therefore:

\[
\boxed{
C_t\rightarrow C_{t+1}
}
\]

must remain possible.

Alignment is not convergence to a final immutable rule set. It is maintenance of a correctable region of collective dynamics.

---

## 13. What the four results jointly establish

The results can be read as four necessary design questions.

### Information

Does the network preserve enough task-relevant information to permit correction?

Signal fidelity addresses this question.

### Fault tolerance

Can the network survive ordinary individual error?

Redundant correction addresses this question.

### Relational continuity

Can valuable edges recover after nonterminal failure?

The repair boundary addresses this question.

### Generational continuity

Can the correction architecture survive turnover of the agents carrying it?

The protocol reproduction threshold addresses this question.

Together:

\[
\boxed{
\text{collective intelligence}
=
\text{distributed capability}
+
\text{maintained corrective architecture}.
}
\]

This is a structural hypothesis, not a claim that the four toy models exhaust collective intelligence.

---

## 14. Testable implications

The framework generates several empirical predictions.

1. **Signal fidelity.** On genuinely cooperative tasks with common objectives, experimentally garbling task-relevant corrective signals should weakly reduce the best achievable performance when agents can otherwise use the information freely.

2. **Redundancy.** Independent or weakly correlated correction channels should create nonlinear reliability gains. Increasing individual reliability can have disproportionately large network effects near a viability boundary.

3. **Correlation penalty.** Redundancy gains should shrink as errors become more correlated.

4. **Repair region.** Repair of damaged collaboration should improve long-horizon performance when expected recovered edge surplus exceeds repair cost; outside that region, termination should outperform repair.

5. **Transmission threshold.** Meta-learning protocols should disappear when their effective reproduction process remains subcritical and persist with positive probability only after crossing the relevant reproduction boundary under branching-process assumptions.

6. **Selected versus sufficient alignment.** Individually optimized investment in honesty, verification, repair, or monitoring can remain below the network-level functional threshold when benefits are externalized.

7. **Object-level diversity.** Networks with protocol-level alignment but nonredundant models or sensors can outperform equally aligned but highly correlated networks, all else equal.

These are hypotheses to test, not consequences of a single universal equation.

---

## 15. Relation to existing literature

The broader problem of collective intelligence is also established. Human-group research has reported collective-performance factors that are not reducible to the best individual performer, while network-science work shows that communication topology can either improve collective problem solving or damage the informational diversity on which crowd accuracy depends. This is important for the present framework: alignment should not be identified with maximal connectivity or maximal consensus.

The mathematical ingredients used below are established.

Blackwell's comparison of experiments formalizes when one information structure is more informative than another for decision making. The signal-fidelity theorem proved here is only the deterministic finite lifting direction.

\(k\)-out-of-\(n\) reliability is classical reliability engineering. The 2-out-of-3 model is used here as the smallest transparent demonstration that network viability can increase without individual perfection.

The extinction threshold of Galton-Watson branching processes is classical. The present contribution is only to interpret protocol carriers as a reproducing organizational lineage.

Repeated-game research has long shown that noise changes the strategies supporting cooperation. Fudenberg, Rand and Dreber found that successful strategies under implementation noise could be lenient and forgiving. Lenaerts and colleagues derived conditions under which apology and forgiveness can preserve cooperative agreements after mistakes.

The proposed contribution is therefore not any of these theorems individually.

It is their placement inside a common Organizational Accessibility account of **collective intelligence as a maintained, heritable, corrigible network capability**.

---

## 16. Limits and non-claims

This paper does not prove that honesty, forgiveness, reciprocity, or transparency are unconditional moral duties.

It does not claim that:

- more disclosure is always better;
- all agents should share the same objective;
- all networks benefit from the same amount of alignment;
- independent-error assumptions hold in real social networks;
- majority rule is generally optimal;
- \(R_{\rm protocol}>1\) guarantees survival of every lineage;
- forgiveness is always superior to exit;
- collaboration should preserve every existing edge;
- diversity is always beneficial;
- SCAP is a final or uniquely correct alignment protocol;
- collective intelligence necessarily grows over time.

The framework is functional and conditional.

It asks what interaction architecture maintains a declared collective learning capability under explicit assumptions.

---

## 17. Conclusion

The core proposal is simple:

\[
\boxed{
\textbf{alignment is a viability region, not a point.}
}
\]

A collectively intelligent network does not require perfect agents. It requires enough reliable information, correction, redundancy, repair, reciprocal maintenance, and protocol inheritance for the joint learning process to remain operational.

Signal fidelity gives a technical core to honesty.

Redundancy explains why occasional individual failure need not destroy collective function.

The repair boundary gives a conditional rather than absolute role to forgiveness.

The protocol reproduction number explains why a culture of correction can disappear or persist across generations without perfect transmission.

This reframes the Sustainable Collaborative Alignment Protocol.

Its strongest defensible interpretation is no longer:

> these are the rules every intelligence must always obey.

It is:

> these are candidate maintenance operations for a network of finite learning agents that wants to preserve its capacity to learn together through error, disagreement, damage, and generational replacement.

The target is not aligned minds.

\[
\boxed{
\textbf{The target is a sufficiently aligned network of interoperable,
correctable learning processes.}
}
\]

If that architecture can itself be retained, revised, and passed onward, alignment becomes part of the cumulative-organizational ratchet rather than an external constraint imposed upon it.
