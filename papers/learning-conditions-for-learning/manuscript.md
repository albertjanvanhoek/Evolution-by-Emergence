# Learning the Conditions for Learning

## Intelligent networks as an inside specialization of functional ratchet velocity

**Status:** working theory paper, draft 0.1  
**Framework:** Evolution by Emergence

### Abstract

**Companion-paper relation.** The universal outside theory is developed
separately in *Functional Organization and the Velocity of the Ratchet*. There,
an organizational state and a functional target are different types of object,
and the primitive quantity is the target-indexed cost of reliably realizing
functions. Ratchet velocity is retained reduction of that functional cost
profile. The present paper asks what this means from inside an intelligent
network.

Learning changes what a system knows or can do. But learning can also change how
easily the system can learn again. A person can learn how to search, test,
revise, repair collaboration, or retain correction; a neural system can alter
its future plasticity; an evolving lineage can change the distribution of
variation available to selection; and a social network can alter the pathways
through which information, correction, and collaboration occur. These processes
differ in substrate but share a second-order structure: present organization
changes the accessibility of future organization.

We develop this idea in two linked descriptions. The **outside description** is
substrate-independent and belongs to Evolution by Emergence proper. It assigns a
directed cost geometry to organizational change. For state x at time t,
C_t(x,y | R_t) is the declared cost of reaching future state y while preserving
a retained repertoire R_t. This cost geometry induces a plasticity profile: the
fraction of relevant future states reachable under a given budget. A retained
change is quantitatively second-order when it changes this future cost geometry,
including cases in which a previously possible transition simply becomes
cheaper. The existing binary second-order accessibility result is recovered as
a thresholded special case.

The **inside description** applies to intelligent learning networks. Such a
network contains processes that regulate how it encounters information,
transmits signals, exposes uncertainty, detects error, revises, preserves
informative edges, repairs, re-engages, retains, and recombines. We represent
these processes by an internal process state P_t and an application-specific map
Γ from P_t to the outside accessibility geometry. The internal verbs and the
external plasticity/viscosity description are therefore two descriptions of the
same learning dynamics at different levels.

This distinction yields operational definitions of learning-to-learn,
self-improvement, and recursive self-improvement. Self-improvement occurs when a
system endogenously modifies its own learning-maintenance process and thereby
improves future accessibility on held-out targets while preserving required
prior function. Recursive self-improvement additionally improves the rate at which the system
can acquire further held-out functional capability under matched time/resource
conditions. The earlier abstract productivity functional remains a permissive
interface, but the companion outside theory supplies a preferred operational
grounding: improvement of future functional ratchet velocity.

The framework connects metaplasticity, evolvability, adaptive networks,
collective learning, and artificial learning while keeping their
substrate-specific mechanisms distinct. It generates falsifiable predictions
about path dependence, retention–plasticity trade-offs, diversity, information
fidelity, repair, and the rate of accessibility change. Artificial neural and
language-model systems provide a controlled workbench in which the outside
geometry and inside process interventions can be measured together.

---

## 1. Introduction

Most theories of learning evaluate a system by what it can presently do. An
organism knows a route, a neural network solves a task, a scientist holds a
model, or a group reaches a solution. Yet two systems with identical current
performance can differ substantially in what they can learn next. One may be
located in an organizational state from which many useful changes are cheap;
another may require extensive reorganization to reach the same future
capabilities.

This distinction is familiar in several mature literatures. Metaplasticity
describes prior activity changing the future capacity for synaptic plasticity.
Evolvability describes the capacity of biological organization to generate
adaptive future variation. Adaptive-network theory studies systems in which
node states and network topology coevolve. Work on collective learning shows
that network structure, diversity, information flow, and individual learning
strategies jointly shape problem solving. Meta-learning demonstrates in
artificial systems that parameters can be optimized specifically for future
learnability.

These literatures make related second-order observations, but they typically use
substrate-specific state variables. Evolution by Emergence suggests a higher
abstraction. Existing organization affects not only present function but the
space, cost, and distribution of future organization. The current formal EbE
stack captures this through binary second-order accessibility: a retained
organizational transition can change which future candidates are generated. The
present paper lifts that idea from binary possibility to a quantitative
accessibility geometry.

The central move is to distinguish two levels.

1. **Outside:** an observer describes the cost geometry of possible
   organizational transitions. Plasticity means low-cost adaptive
   reconfiguration; viscosity means resistance to such reconfiguration.

2. **Inside:** an intelligent learning network acts through substrate-specific
   processes that can alter that geometry. For a human or artificial learning
   network these processes may include seeking information, signalling
   faithfully, exposing uncertainty, testing, revising, maintaining an
   informative relationship through disagreement, repairing, re-engaging,
   retaining, and recombining.

The outside description is intended to be substrate-independent. The inside
description is a translation available to intelligent networks that can
represent and alter aspects of their own learning process.

The paper develops this duality, states the corresponding formal definitions,
positions them against neighboring literatures, and derives an experimental
programme in which neural and language-model systems serve as controlled
workbenches.

---

## 2. Outside: the accessibility geometry of organization

### 2.1 Directed transition cost

Let X be a state space of organizations. At time t the system occupies x_t.

Let R_t denote a declared retained repertoire: organization or function that
must remain viable while a future change occurs.

Define

\[
C_t(x,y \mid R_t,E_t) \in [0,\infty]
\]

as the declared minimum cost of reaching y from x under environment E_t while
preserving R_t.

The word *cost* is intentionally abstract. Depending on the substrate it can
represent energy, time, information, training updates, coordination burden,
relationship risk, material resources, or another operationally defined
quantity.

No metric structure is assumed. In particular,

\[
C_t(x,y) \neq C_t(y,x)
\]

in general, and the triangle inequality need not hold.

The directed character is essential. Correcting an entrenched belief may cost
more than acquiring it. Building an institution may cost more than dismantling
it. A neural network may learn task B cheaply after task A while the reverse
ordering is expensive.

### 2.2 Accessibility under budget

For budget B define

\[
\mathcal A_t(x;B)
=
\{y : C_t(x,y\mid R_t,E_t) \le B\}.
\]

This recovers the binary accessibility language already used in Evolution by
Emergence. A state is accessible under the declared budget or it is not.

But the cost representation preserves more information. Two systems may expose
the same binary candidate set at a large budget while differing dramatically in
the costs of reaching those candidates.

### 2.3 Plasticity profile

Let μ be a declared distribution over future states that matter for the
question under study. Define

\[
\Pi_t(B)
=
\Pr_{y\sim\mu}
\left[
C_t(x_t,y\mid R_t,E_t)\le B
\right].
\]

Π_t(B) is a **plasticity profile** rather than a single plasticity scalar.

It answers:

> Under budget B, what fraction of the relevant future state distribution is
> reachable while preserving the required retained organization?

Correspondingly define a viscosity quantile

\[
V_t(q)
=
\inf\{B : \Pi_t(B)\ge q\}.
\]

Low V_t(q) means that a large fraction of relevant future organization is
reachable cheaply. High V_t(q) means that the same adaptive reconfiguration is
more viscous.

This formulation forces three questions that a generic statement such as "the
system is plastic" hides:

1. plastic toward what target distribution?
2. under what resource budget?
3. while preserving what inherited organization?

### 2.4 Edge-level geometry

The cost geometry may itself be generated by lower-level interactions.

For a network, let η_{ij,t} represent the resistance associated with a possible
interaction between components i and j. A corresponding conductance can be
written

\[
g_{ij,t}=\frac{1}{1+\eta_{ij,t}}.
\]

For additive path costs, one may write

\[
C_t(\gamma)=\sum_{e\in\gamma}\eta_{e,t}
\]

and

\[
C_t(x,y)=\inf_{\gamma:x\leadsto y} C_t(\gamma).
\]

This is only one possible specialization. The general theory requires neither
additivity nor graph shortest paths. The purpose is to make clear that future
organizational cost can change because new edges appear, old edges disappear,
or existing edges become easier or harder to use.

The internet illustrates the distinction. It expanded the set of possible
human contacts and sharply reduced the geographic cost of many existing
potential contacts. Yet discovering the right collaborator, establishing
credibility, translating disciplinary language, maintaining attention, and
repairing failed coordination remain nontrivial. Latent connectivity and
realized productive accessibility are different quantities.

---

## 3. Quantitative second-order accessibility

### 3.1 From binary expansion to lower cost

The current EbE formalism defines a second-order click when a viable
organizational transition strictly expands a state-dependent future search
operator.

The quantitative extension is:

\[
C_{t+1}(x_{t+1},y)
\le
C_t(x_t,y)
\]

for all y in a declared target set Y, with strict inequality for at least one

\[
y^\star\in Y.
\]

We call this **strict quantitative accessibility improvement** or,
equivalently, a transition to a less viscous future geometry on Y.

This captures changes that binary accessibility misses. A future state may be
possible both before and after a transition, but its cost can fall from 100 to
5. Nothing new has become logically possible, yet the system's practical
future has changed dramatically.

### 3.2 Binary accessibility as a thresholded special case

Suppose

\[
C_{t+1}(y^\star)<C_t(y^\star).
\]

Choose budget

\[
B=C_{t+1}(y^\star).
\]

Then

\[
C_{t+1}(y^\star)\le B
\]

while

\[
C_t(y^\star)>B.
\]

Thus a strict quantitative improvement necessarily creates at least one budget
threshold at which the new state exposes a candidate that the old state does
not.

This result is machine checked in
formalization/cumulative-accessibility/CumulativeAccessibility/QuantitativeAccessibility.lean.

The theorem is important because it shows that the new cost geometry is not a
competing theory. It strictly generalizes the existing v16 binary
SecondOrderClick formalism.

### 3.3 Weak and strict viscosity order

For two geometries C and C' define C' to be no more viscous than C on target set
Y when

\[
C'(y)\le C(y)
\qquad
\forall y\in Y.
\]

The relation is reflexive and transitive. Lean checks both properties. It also
checks the retained-ratchet consequence: a strict improvement followed by any
declared non-worsening change remains strict relative to the ancestor, and
strict improvements compose.

A strict improvement adds

\[
\exists y^\star\in Y:
C'(y^\star)<C(y^\star).
\]

The order should not be interpreted as a universal value ranking. A lower cost
toward a harmful or erroneous state is not necessarily desirable. Target set Y
and the criterion by which it is selected remain external to the mathematics.

---

## 4. Learning velocity

Quantitative accessibility permits a distinction between present capability and
the rate at which future capability becomes accessible.

Suppose potentially informative opportunities arrive at rate λ_t. Let p_t be
the conditional probability that an opportunity produces a successful retained
change. If a successful event produces expected accessibility improvement

\[
E[\Delta A_t\mid\text{success}],
\]

then a generic modelling scaffold is

\[
v_t
=
\lambda_t p_t
E[\Delta A_t\mid\text{success}].
\]

We call v_t **learning velocity** when the relevant accessibility measure is
learnability.

This expression is not proposed as a universal dynamical law. Its role is to
separate three causes of slow collective change:

1. potentially useful events are rarely sampled;
2. sampled events rarely survive the learning process;
3. successful events have little effect on future accessibility.

For an intelligent network p_t itself can be decomposed into conditional
processes. A typical path might require:

\[
\begin{aligned}
p_t={}&p(\text{usable edge}\mid\text{encounter})\\
&\times p(\text{informative signal}\mid\text{edge})\\
&\times p(\text{error detected}\mid\text{signal})\\
&\times p(\text{revision}\mid\text{detection})\\
&\times p(\text{edge survives}\mid\text{revision})\\
&\times p(\text{retention}\mid\text{successful correction}).
\end{aligned}
\]

As a chain of conditional probabilities this factorization does not require
independence.

---

## 5. Inside: intelligent networks acting on their own geometry

### 5.1 Process state

The outside theory knows nothing about intelligence. It contains only
organizational state, transition cost, retained function, and environment.

For an intelligent learning network introduce a separate internal
learning-maintenance process state

\[
P_t.
\]

Let

\[
\Gamma
\]

map internal process state to the externally observed accessibility geometry:

\[
\boxed{
C_t=\Gamma(P_t,X_t,E_t).
}
\]

This is the central inside/outside bridge.

The intelligent system need not represent C_t explicitly. It acts through
substrate-specific processes whose combined effect changes the observed
geometry.

### 5.2 Learning verbs

For human and artificial learning networks, candidate internal operations
include:

| Inside process | Outside role |
|---|---|
| seek / encounter | sample non-redundant information or collaborators |
| listen | increase permeability of an informative edge |
| signal faithfully | preserve information fidelity |
| expose uncertainty | make potential model error observable |
| test | generate discriminating evidence |
| revise | allow justified discrepancy to change internal state |
| maintain disagreement | prevent premature loss of informative alternatives |
| repair | restore a damaged but potentially valuable edge/process |
| re-engage / forgive | make relational penalties reversible after demonstrated repair |
| retain | preserve successful correction |
| recombine | make retained organization available as substrate for novelty |

These verbs are not universal primitive laws. They are an internal vocabulary
for intelligent networks. An application must supply the mapping from process
change to Γ.

The corresponding Lean interface is
formalization/cumulative-accessibility/CumulativeAccessibility/IntelligentLearningMaintenance.lean.

### 5.3 Honesty as an example

For an intelligent information network, truthful or faithful signalling can be
interpreted as increasing the correspondence between transmitted signal and
source state.

This can reduce the expected cost of justified correction because fewer
observations or less verification may be needed before the receiver can safely
update.

But the theory does not assert

\[
\text{honesty}\Rightarrow\text{lower viscosity}
\]

without an application model. For example, truthful information can still fail
to cross an edge, be misunderstood, or concern an irrelevant target.

The universal statement is only that a change in process state that lowers the
measured target-transition costs is an accessibility improvement.

### 5.4 Corrigibility

Corrigibility concerns how readily sufficiently informative discrepancy causes
a justified update.

Importantly, desirable corrigibility is not absence of resistance to all
influence. A system that accepts arbitrary unsupported perturbation is not
necessarily a better learner.

The relevant target is **selective plasticity**:

\[
\text{low viscosity toward evidence-supported correction}
\]

while retaining sufficient resistance against unsupported change.

### 5.5 Repair and forgiveness

Let an informative edge suffer a failure. Repair concerns restoring the edge's
productive function. Forgiveness or re-engagement concerns whether the
relational penalty can subsequently be reversed when evidence supports repair.

In outside language, a failure may raise edge viscosity

\[
\eta_{ij}\uparrow.
\]

Permanent exclusion corresponds, in the limit, to

\[
\eta_{ij}\rightarrow\infty.
\]

Successful repair followed by evidence-sensitive re-engagement permits

\[
\eta_{ij}\downarrow.
\]

Thus forgiveness is not forgetting evidence. It is the **reversibility of edge
viscosity after demonstrated repair**.

This hypothesis is especially relevant in repeated learning networks: if every
detected error permanently destroys the channel through which correction
occurred, error correction itself can progressively remove future correction
capacity.

---

## 6. Learning, learning-to-learn, and self-improvement

The two-level framework separates four phenomena.

### 6.1 Ordinary learning

Ordinary learning changes current organization:

\[
X_t\rightarrow X_{t+1}.
\]

The system may become better at a task without becoming more learnable.

### 6.2 Learning-to-learn

Learning-to-learn changes P_t in a way that improves the induced future
geometry:

\[
P_t\rightarrow P_{t+1},
\]

with

\[
\Gamma(P_{t+1})\prec\Gamma(P_t)
\]

on a declared held-out target distribution.

For a person, learning how to search literature, formulate tests, identify
uncertainty, or invite criticism may lower the cost of many later learning
transitions.

### 6.3 Self-improvement

Self-improvement requires endogenous causation. The old process state generates
an intervention a_t, the intervention changes P_t, and the resulting geometry
strictly improves on held-out future targets while required existing function
remains viable.

Schematically:

\[
a_t\sim Q(P_t),
\]

\[
P_t\xrightarrow{a_t}P_{t+1},
\]

\[
\Gamma(P_{t+1})\prec\Gamma(P_t).
\]

The Lean specialization formalizes this distinction through a generated
intervention, an application relation, and the outside strict-viscosity
criterion.

### 6.4 Recursive self-improvement

The generic formal interface permits a declared productivity functional
`ρ(P)`. The companion functional-ratchet theory now supplies a preferred
operational grounding.

Clone or otherwise match the same starting organization. Run a held-out learning
episode under the old process and a matched episode under the self-modified
process. Normalize functional gains by each positive time/resource interval.

Recursive self-improvement requires:

1. the old process generated and applied the intervention that produced the new
   process;
2. declared retained functions are not made more costly at the matched starting
   organization;
3. the new process is not slower on any declared held-out learning target; and
4. it is strictly faster on at least one.

Schematically,

```math
v_{P_{t+1}}(f)\ge v_{P_t}(f)
\quad\forall f\in\Phi_L,
```

with strict inequality for at least one held-out target.

This is stronger than simply becoming better at a task. It says that the system
has changed the process responsible for acquiring further capability, and that
the rate improvement survives a matched counterfactual test.

It still does not imply runaway acceleration. Resource limits, interference,
rigidity, loss of diversity, increasing target difficulty, or exhaustion of
useful search directions can make later velocity plateau or fall.

---

## 7. The individual/network recursion

The same architecture can be applied recursively across organizational scales.

An individual is a learning network of neural and cognitive processes. The same
individual is also a node in larger networks of people, tools, institutions,
and information systems. An organization is a network of people and a node in a
network of organizations.

The theory therefore does not identify "individual" with "atom". The relevant
question at each scale is:

> What organization is being retained, what transitions are available, and what
> processes determine their costs?

A person's investment in learning skills can change future personal
accessibility. An institution's investment in transparent error reporting can
change future organizational accessibility. A scientific community's
replication practices can change the cost of moving from false consensus to
better-supported models.

The implementations differ. The outside geometry supplies the common language.

---

## 8. Relationship to existing theory

### 8.1 Metaplasticity

Metaplasticity describes neural changes caused by prior activity that persist
and alter subsequently induced plasticity. Abraham (2008) explicitly frames
metaplasticity as regulation of plasticity required to keep learning within a
useful dynamic range.

This is a substrate-specific instance of earlier state changing later
transition propensity.

The present framework generalizes the object from synaptic plasticity to an
arbitrary directed accessibility-cost geometry.

### 8.2 Evolvability

Wagner and Altenberg (1996) distinguish realized variation from the
organization that determines what kinds of variation can be generated. They
argue that evolvability depends critically on the genotype–phenotype map and
that this map can itself evolve.

Barnett, Meister and Rainey (2025) provide experimental evidence that
evolvability itself can evolve: bacterial lineages evolved localized
hypermutation under selection for the capacity to transition between
environmentally favored states.

These results closely parallel the EbE distinction between present organization
and the distribution of future accessible organization.

### 8.3 Adaptive networks

Gross and Blasius (2008) review adaptive networks in which network topology and
node states coevolve. This establishes that mutual feedback between organization
and interaction structure is already a mature cross-domain concept.

The present framework differs by making **transition cost and future
accessibility** the central state-dependent object rather than topology alone.

### 8.4 Collective learning and cultural evolvability

Lazer and Friedman (2007) show that rapid information dissemination can improve
short-term performance while harming long-term exploration on complex problems,
because slower networks preserve diversity.

Barkoczi and Galesic (2016) show that the effect of network structure on group
performance depends on the social-learning strategy used by agents.

Schimmelpfennig et al. (2022) identify sociality, transmission fidelity, and
cultural diversity as interacting levers of innovation, and introduce
*cultural evolvability* as a framework for balancing exploration and
coordination.

Baumann, Czaplicka and Rahwan (2024) similarly show that the effect of diversity
on collective learning depends on task complexity and network density.

These literatures directly support the paper's refusal to interpret encounter,
connectivity, trust, diversity, or plasticity as monotonically beneficial.

### 8.5 Meta-learning and artificial systems

Meta-learning supplies an engineered example of optimizing a system for future
learnability rather than present task performance alone. Finn, Abbeel and Levine
(2017), for example, explicitly optimize parameters so that new tasks can be
learned with few gradient steps and little data. The paper does not depend on a
specific meta-learning algorithm. Its relevance is conceptual: two systems with
similar current capability can differ in the cost of acquiring future
capability.

### 8.6 Plasticity loss

Dohare et al. (2024) show that standard deep-learning systems can progressively
lose their ability to learn in continual-learning settings. This provides the
important reverse direction: accumulated learning can make the future
accessibility geometry worse rather than better.

This supports a central distinction:

\[
\text{current competence}
\neq
\text{future learnability}.
\]

Together, meta-learning and plasticity-loss results make artificial neural
systems an unusually useful experimental workbench: the outside geometry can
both improve and degrade, and the direction can be measured under controlled
conditions.

---

## 9. Artificial learning systems as a workbench

Artificial systems are useful not because their mechanisms are identical to
human social learning, but because both outside and inside variables can be
controlled.

At training checkpoint θ_t, branch identical copies. Present each branch with a
standardized held-out set of target functions f_1,...,f_n.

For each target estimate

\[
C_t(f_i\mid R_t),
\]

the resource required to reach the target while preserving declared retained
capabilities.

Repeating this across checkpoints estimates the changing accessibility
geometry:

\[
C_0
\rightarrow
C_1
\rightarrow
\cdots
\rightarrow
C_T.
\]

The experiment can then manipulate candidate learning-maintenance processes:
diversity of independent evidence, fidelity of feedback, availability of
critique, persistence of dissenting alternatives, repair of failed
collaborations, retention, and recombination.

The primary outcome is not benchmark score. It is the change in held-out future
transition cost.

### 9.1 Self-improvement experiment

Allow the system to inspect failures in its own learning process and propose
changes to that process.

An intervention counts as self-improvement only if:

1. it is generated endogenously;
2. it changes the process state P;
3. required old capabilities remain viable;
4. held-out future accessibility improves.

A second round then tests whether the new process state produces successful
process improvements at a higher rate.

This directly tests recursive self-improvement.

---

## 10. Falsifiable hypotheses

### H1 — Historical accessibility

Prior learning changes the cost distribution of later learning even when
current task performance is controlled.

**Counter-result:** matched systems with different histories have identical
future transition-cost distributions.

### H2 — Quantitative second order

Some retained changes lower the cost of other future changes even when those
future states were already accessible.

**Counter-result:** learning affects only current capability and never the
future transition geometry.

### H3 — Retention–plasticity trade-off

Both insufficient retention and insufficient plasticity reduce cumulative
adaptive learning.

**Counter-result:** either can be maximized without compromising long-run
retained accessibility in the declared regime.

### H4 — Repair

In repeated informative interaction, repair and evidence-sensitive re-engagement
can preserve future correction capacity that would be lost under permanent
edge deletion.

**Counter-result:** permanent edge severance performs equally or better across
the stated repeated-learning regime.

### H5 — Context-dependent connectivity and diversity

The effects of encounter rate, connectivity, and diversity depend on task and
network state rather than being universally monotonic.

**Counter-result:** one of these variables has a stable monotonic effect across
the declared regimes.

### H6 — Endogenous self-improvement

Systems able to generate and retain modifications to their learning-maintenance
process can discover changes that improve held-out accessibility geometry.

**Counter-result:** self-generated process modifications do not outperform
matched no-change or externally randomized controls.

### H7 — Recursive improvement

Some self-improvements increase a declared measure of the rate or efficiency
with which further self-improvements are produced.

**Counter-result:** improvements to current process state never affect future
self-improvement productivity.

---

## 11. Scope and non-claims

The framework does not establish that:

- every reduction in transition cost is beneficial;
- more connectivity is always better;
- more trust is always better;
- diversity is always beneficial;
- maximal plasticity is optimal;
- honesty, forgiveness, or repair have universal monotonic effects without an
  application-specific model;
- all intelligent networks share identical mechanisms;
- self-improvement must become recursively accelerating;
- recursive self-improvement implies an intelligence explosion;
- the present conjunction is novel merely because its components are expressed
  in EbE notation.

The universal object is the accessibility-cost geometry and its change.

The intelligent-network verbs are a substrate-specific interpretation of
processes that may alter that geometry.

---

## 12. Formal status

The first outside theorem layer is implemented in:

formalization/cumulative-accessibility/CumulativeAccessibility/QuantitativeAccessibility.lean

Lean currently checks:

1. no-more-viscous comparison is reflexive;
2. no-more-viscous comparison composes transitively;
3. lower future costs preserve candidates already accessible at any fixed
   budget;
4. any strict cost improvement opens a budget interval in which a target is
   newly affordable;
5. strict quantitative improvement induces strict binary candidate expansion at
   some threshold;
6. a state-dependent quantitative second-order click therefore implies an
   ordinary v16 SecondOrderClick at some budget;
7. a concrete two-state witness inhabits both the quantitative and thresholded
   binary forms.

The inside interface is implemented in:

formalization/cumulative-accessibility/CumulativeAccessibility/IntelligentLearningMaintenance.lean

It machine-checks the bridge from an internal process improvement to the
external cheaper-future and budget-window consequences, and separates ordinary
process change, endogenous self-improvement, and recursive self-improvement.

No theorem asserts that a named intelligent-network verb necessarily improves
the geometry. Those links remain empirical/mechanistic hypotheses.

---

## 13. Discussion

The outside/inside duality resolves a recurring ambiguity in discussions of
learning systems.

From outside, learning can be described without psychological vocabulary. An
organization occupies a state in a directed accessibility-cost geometry. A
retained change alters that geometry. Plasticity and viscosity describe the
cost distribution of possible future reconfiguration.

From inside, an intelligent network can act on processes that partially
determine that geometry. It can search for information, expose uncertainty,
test its own predictions, revise, preserve informative disagreement, repair
failed interactions, re-engage after successful repair, retain corrections, and
recombine prior organization. These are not additional universal laws; they are
the vocabulary through which some intelligent systems can modify the processes
that instantiate the outside dynamics.

The same event can therefore receive two valid descriptions.

A scientist learns to solicit criticism.

Inside:

\[
P_t\rightarrow P_{t+1}.
\]

Outside:

\[
C_{t+1}(y)<C_t(y)
\]

for some future corrective transitions.

An artificial agent learns to preserve independent verification rather than
converging immediately on one answer.

Inside, its learning protocol changes. Outside, the expected cost of escaping
certain error states may fall.

This is the proposed meaning of *learning the conditions for learning*.

---

## 14. Conclusion

Evolution by Emergence begins from the idea that retained organization changes
what organization can come next. Quantitative recursive accessibility extends
this claim from binary possibility to transition cost.

The extension yields a two-level theory.

**Outside:** organization induces a plasticity/viscosity geometry over future
organization.

**Inside:** intelligent networks can regulate processes that alter that
geometry.

Ordinary learning changes present state. Learning-to-learn changes future
transition costs. Self-improvement is endogenous change to the
learning-maintenance process that measurably improves held-out accessibility.
Recursive self-improvement occurs when such a change also improves the capacity
to generate further successful process improvements.

The theory therefore turns a broad intuition into a measurable question:

> Does retained organization make useful future correction and recombination
> cheaper, and can a learning system learn to improve the processes that make
> this happen?

Artificial learning systems provide a controlled workbench for answering that
question. Human and institutional networks provide the broader setting in which
the same outside geometry may be translated into different inside processes.

---

## References

Abraham, W. C. (2008). Metaplasticity: tuning synapses and networks for
plasticity. *Nature Reviews Neuroscience*, 9, 387.
doi:10.1038/nrn2356.

Barnett, M., Meister, L., & Rainey, P. B. (2025). Experimental evolution of
evolvability. *Science*, 387(6736), eadr2756.
doi:10.1126/science.adr2756.

Barkoczi, D., & Galesic, M. (2016). Social learning strategies modify the
effect of network structure on group performance. *Nature Communications*, 7,
13109. doi:10.1038/ncomms13109.

Baumann, F., Czaplicka, A., & Rahwan, I. (2024). Network structure shapes the
impact of diversity in collective learning. *Scientific Reports*, 14, 2491.
doi:10.1038/s41598-024-52837-3.

Dohare, S., Hernandez-Garcia, J. F., Lan, Q., Rahman, P., Mahmood, A. R., &
Sutton, R. S. (2024). Loss of plasticity in deep continual learning. *Nature*,
632, 768–774. doi:10.1038/s41586-024-07711-7.

Finn, C., Abbeel, P., & Levine, S. (2017). Model-Agnostic Meta-Learning for
Fast Adaptation of Deep Networks. *Proceedings of Machine Learning Research*,
70, 1126–1135.

Gross, T., & Blasius, B. (2008). Adaptive coevolutionary networks: a review.
*Journal of the Royal Society Interface*, 5(20), 259–271.
doi:10.1098/rsif.2007.1229.

Lazer, D., & Friedman, A. (2007). The network structure of exploration and
exploitation. *Administrative Science Quarterly*, 52(4), 667–694.
doi:10.2189/asqu.52.4.667.

Schimmelpfennig, R., Razek, L., Schnell, E., & Muthukrishna, M. (2022).
Paradox of diversity in the collective brain. *Philosophical Transactions of
the Royal Society B*, 377(1843), 20200316.
doi:10.1098/rstb.2020.0316.

Wagner, G. P., & Altenberg, L. (1996). Perspective: complex adaptations and
the evolution of evolvability. *Evolution*, 50(3), 967–976.
doi:10.1111/j.1558-5646.1996.tb02339.x.
