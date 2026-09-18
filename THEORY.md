# Evolution by Emergence

## The current theory

**Evolution by Emergence (EbE)** is a theory architecture about how organized
processes can arise, persist, accumulate history, and change the space of what
can happen next.

Its central question is:

> **How does organization that exists now change the distribution of
> organization that can exist next?**

The theory is broader than biological evolution but does not claim that every
domain uses the same mechanism. Biological selection, learning, technological
change, institutional adaptation, and chemical self-organization can be very
different processes. The proposed unity is **structural**, not mechanical.

The current scientific position of the repository is deliberately conservative:

> **EbE is primarily a synthesis and formal architecture, with several exact
> model-specific results.**

The literature audits in this repository found strong antecedents for most
individual ingredients. The contribution under review is therefore the way
maintenance, resources, retention, accessibility, generation, selection, and
physical limits are put into one explicit recursive architecture.

For theorem-level traceability, see **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)**.
For the central recursive dynamics alone, see
**[DYNAMIC_OVERVIEW.md](DYNAMIC_OVERVIEW.md)**.

---

# 1. The idea in one page

Everything realized has a finite material history.

Molecules turn over. Cells replace cells. Organisms replace components.
Institutions replace members. Machines replace parts. Yet organized processes
can continue.

Persistence therefore cannot generally mean that the same material remains.
It means that a process keeps recreating enough of the organization required
for further activity.

That continued organization requires throughput from an environment. It must
pay maintenance. If captured throughput exceeds maintenance demand, some
resource margin or **slack** remains. Slack can be routed into response,
exploration, repair, construction, or search.

If a new configuration is generated, validated by a declared criterion, and
retained, it becomes part of later history. Retained organization can then do
more than survive: it can become reusable parent material, alter a generative
rule, change resource efficiency, or change the effective search operator.
That means the organization changes which successor organizations are
reachable.

The central loop is therefore:

\`\`\`text
environmental gradient
        ↓
organization-dependent uptake
        ↓
maintenance
        ↓
internal slack
        ↓
response / search
        ↓
generated candidate
        ↓
validation + retention
        ↓
new reusable organization
        ↓
changed generation / changed future accessibility
        ↓
changed organization
        ↓
changed future uptake, maintenance, and search
        ↺
\`\`\`

This is the **resource-fed recursive accessibility vortex**.

The important feature is not merely that the state changes. The effective
transition structure can change too:

\[
\boxed{
(\Omega_t,F_t)\longrightarrow(\Omega_{t+1},F_{t+1})
}
\]

where \(\Omega_t\) is the current organizational state and \(F_t\) summarizes
the effective rules and opportunities governing possible next transitions.

This is the sense in which EbE is a **second-order evolutionary architecture**.

---

# 2. What "emergence" means here

"Emergence" is not used as a new force of nature.

It means a generative organizational event:

> **interactions produce organization whose existence changes what becomes
> possible afterward.**

In the minimal form,

\[
\boxed{
\text{interaction}
\rightarrow
\text{organization}
\rightarrow
\text{changed accessibility}
\rightarrow
\text{new interaction}.
}
\]

This distinguishes EbE from a picture in which a fixed set of entities simply
competes on a fixed landscape.

Competition remains real. Selection remains real. Scarcity, conflict, failure,
and exclusion remain real.

The extension is that **collaboration, maintenance, construction, inheritance,
and niche/state-space modification are causal too**.

---

# 3. The state of the theory

A useful schematic state is

\[
\boxed{
\Omega_t=(s_t,M_t,H_t,U_t)
}
\]

with:

- \(s_t\): current physical or organizational implementation;
- \(M_t\): retained modules, repertoire, or reusable organization;
- \(H_t\): current generative rule;
- \(U_t\): currently distinguishable possibility envelope.

Two inputs are kept explicit:

- \(G_t\): environmental gradient or resource opportunity;
- \(E_t\): declared external evaluation/acceptance process.

This separation prevents several easy overclaims.

The organization does not create the external gradient in the current model.
A validation predicate is not automatically truth, goodness, or fitness.
A distinguishability envelope is not the same as realized novelty.
A retained change is not automatically an improvement.

---

# 4. Layer 0 — encounters must become productive couplings

The later maintenance and accessibility models start from productive
interactions. But productive coupling itself has prerequisites.

The affinity layer separates:

\[
\boxed{
\text{encounter}
\rightarrow
\text{association persistence}
\rightarrow
\text{conversion}
\rightarrow
\text{productive coupling}.
}
\]

This is a pre-accessibility layer.

A component that never encounters another cannot couple to it. An encounter
that disappears too quickly may not become productive. Association that is too
strong may also inhibit turnover or release.

The repository studies two reduced mechanisms for an intermediate association
optimum:

1. a benefit-versus-maintained-cost channel;
2. a turnover/Sabatier channel.

These are conditional model results, not a universal law that all relationships
have an optimum at intermediate affinity.

**Role in EbE:** the candidate-generating distribution is partly shaped before
selection or retention begins. Search is not always an abstract lottery; it can
be physically filtered by encounter geometry, residence time, and conversion.

---

# 5. Layer 1 — organization persists by recurrent maintenance

An organization is not treated as a static object.

It is a set of processes whose activity can reproduce or support further
activity.

In the finite maintenance models, individually subcritical processes can jointly
support a recurrent loop. For a directed three-cycle,

\[
A\to B\to C\to A,
\]

the canonical witness threshold is

\[
\boxed{
k_{AB}k_{BC}k_{CA}
\ge
(1-r_A)(1-r_B)(1-r_C).
}
\]

The current Lean stack proves that, under the declared sign and threshold
conditions, a positive quantitative support vector can be maintained along the
trajectory.

This produces an important conceptual shift:

\[
\boxed{
\text{persistent entity}
\;\leadsto\;
\text{recurrently reproduced organization}.
}
\]

Material identity is no longer required.

It also establishes a first network lesson: a component can depend on return
paths through other components. Removing one edge can destroy a maintenance
cycle even when the remaining nodes still exist.

---

# 6. Layer 2 — persistence requires solvency

Maintenance needs resources.

For organizational state \(s_t\) under external gradient \(G_t\), write captured
throughput as

\[
J_t=\mathcal U(s_t,G_t)
\]

and maintenance demand as

\[
C_t=\mathcal M(s_t).
\]

Define internal slack

\[
\boxed{
L_t=J_t-C_t.
}
\]

Viability at that instant means

\[
L_t\ge0.
\]

The key distinction is:

\[
\boxed{
\text{external gradient is exogenous}
\quad\text{but}\quad
\text{usable slack is organization-dependent}.
}
\]

A better organization can capture more from the same gradient, require less
maintenance, or both.

If a fraction \(\beta_t\) of slack is routed to response/search,

\[
\boxed{
B_t^{\mathrm{resp}}=\beta_tL_t.
}
\]

That creates the resource bridge from present organization to future change.

---

# 7. Layer 3 — slack opens future response

A candidate response \(z\) at time \(t\) is resource-feasible when

\[
C_{\mathrm{resp}}(t,z)\le B_t^{\mathrm{resp}}.
\]

A strict increase in internally available budget opens a nonempty interval of
responses that were previously unaffordable.

The fixed-gradient Lean witness uses:

\[
G=10,\qquad C=6,
\]

with organizational uptake changing

\[
10\rightarrow11.
\]

Hence slack changes

\[
4\rightarrow5,
\]

and a response costing

\[
\frac92
\]

crosses from infeasible to feasible.

This gives a precise local statement:

\[
\boxed{
\text{organizational improvement}
\rightarrow
\text{more usable slack}
\rightarrow
\text{newly affordable action}.
}
\]

It does **not** say that every organizational change increases slack.

---

# 8. Layer 4 — opportunity is not success

A maintained system can keep opportunities available without realizing a
successful novelty.

The formalization therefore distinguishes:

- recurring opportunity;
- resource feasibility;
- generation;
- external validation;
- retention;
- response delay.

An opportunity at time \(q\) can receive a successful response later at \(r\),

\[
q\le r\le q+\Delta.
\]

This avoids the unrealistic requirement that opportunity and successful change
must always occur at exactly the same indexed instant.

The checked architecture is:

\[
\boxed{
\text{recurring opportunity}
+
\text{bounded resource-feasible validated response}
\rightarrow
\text{recurrent validated uptake}.
}
\]

With retention, recurrent uptake can become cumulative novelty.

---

# 9. Layer 5 — retention makes history causal

Change is not cumulative merely because different things happen over time.

It becomes cumulative when earlier organization remains usable in later
generation.

The minimal retained-generative example is

\[
a\rightarrow b,\qquad b\rightarrow c,
\]

with no direct \(a\rightarrow c\) route.

After one round, \(b\) exists and is retained. It can then act as parent
material for \(c\).

Thus:

\[
\boxed{
\text{product of one round}
\rightarrow
\text{substrate for a later round}.
}
\]

This is the first precise sense in which history changes future accessibility.

It also clarifies the relation to inheritance. Inheritance need not mean copying
an entire organism or document. It can mean preservation of enough reusable
organization that later construction starts from a different state.

---

# 10. Layer 6 — evolution can alter its own generator

Retained history can change future generation in at least two distinct ways.

## 10.1 Repertoire-driven change

Hold the generative rule \(H\) fixed, but change retained modules:

\[
M_t\rightarrow M_{t+1}.
\]

New parent material can make additional candidates generable.

## 10.2 Rule-driven change

Hold retained material fixed, but change the generative rule:

\[
H_t\rightarrow H_{t+1}.
\]

The same repertoire can now generate a different candidate set.

These mechanisms are formally distinct.

That matters because open-ended evolution is not only movement through a fixed
graph. The graph-generating process can change.

---

# 11. Layer 7 — second-order accessibility

The formal object that packages this idea is a **second-order click**.

A viable transition

\[
x\rightarrow y
\]

is second-order when

\[
\Sigma(x)\subsetneq\Sigma(y),
\]

where \(\Sigma(x)\) is the declared future search operator or candidate set at
state \(x\).

So the transition does two things:

1. it realizes a new organizational state;
2. it changes what can be generated from that state.

This is the core recursive proposition:

\[
\boxed{
\text{the process changes the conditions of its own future change}.
}
\]

Retained history allows those changes to compose across multiple steps.

---

# 11A. Layer 7A — quantitative accessibility geometry

Binary accessibility records whether a future state is exposed. But organization
can change the **cost** of future change even when the same future state was
already possible.

The quantitative extension assigns a directed transition cost

\[
C_t(x,y\mid R_t,E_t)
\]

to realizing future organization \(y\) from current organization \(x\), under
environment \(E_t\), while preserving a declared retained repertoire \(R_t\).

The cost is application-specific. It may represent time, energy, information,
training updates, coordination burden, relationship risk, or another operational
resource. It need not be symmetric and need not satisfy a triangle inequality.

For budget \(B\), define the thresholded accessible set

\[
\mathcal A_t(x;B)
=
\{y:C_t(x,y)\le B\}.
\]

A quantitative second-order improvement occurs when a retained organizational
change makes every declared target no more costly and at least one target
strictly cheaper:

\[
C_{t+1}(y)\le C_t(y)
\]

for all declared targets, with

\[
C_{t+1}(y^\star)<C_t(y^\star)
\]

for at least one \(y^\star\).

Lean proves that any such strict cost improvement creates a budget threshold at
which the cheaper target is inaccessible before and accessible afterward.
Therefore the existing binary SecondOrderClick is recovered as a thresholded
special case of the quantitative geometry.

This adds a distinction that is important throughout the theory:

\[
\boxed{
\text{same logical possibility}
\neq
\text{same practical accessibility}.
}
\]

It also gives a substrate-independent meaning to **plasticity** and
**viscosity**. Plasticity concerns low-cost adaptive reconfiguration; viscosity
concerns resistance or cost of reconfiguration. These are directional and
target-dependent properties, not necessarily single scalar properties of an
entire system.

Formal source:

formalization/cumulative-accessibility/CumulativeAccessibility/QuantitativeAccessibility.lean

---

# 11B. Layer 7B — functional organization and ratchet velocity

The quantitative geometry above treats future organizations as targets. For
many applications, however, the organization and what that organization can
**do** are different kinds of object.

Let

\[
s_t\in\Sigma
\]

denote organizational state and let

\[
f\in\Phi
\]

denote a declared functional target. Define

\[
C_t(s_t,f)
\]

as the performance/evaluation cost of reliably realizing function \(f\) with
the current organization \(s_t\), under declared environmental conditions.
By default this does **not** include the future training or reorganization cost
needed to acquire \(f\). That separate acquisition problem belongs to the
organizational accessibility geometry in Layer 7A.

This separation matters. A neural configuration is not the same object as
"understand this French sentence". An ecological community is not the same
object as "cycle nitrogen". A scientific institution is not the same object as
"detect this class of error".

A functional target should therefore be operationalized by a declared test:
an intervention/input family, an observable success criterion, an allowed error
level, and the context in which the test applies. Schematically,

\[
C_t(s,f)
=
\inf\left\{
r:
\Pr(S_f\mid do(I_f),s,r)\ge 1-\varepsilon_f
\right\}.
\]

For budget \(B\), the functional repertoire is

\[
\mathcal F_t(B)
=
\{f:C_t(s_t,f)\le B\}.
\]

The primitive moving object is not a universal scalar "amount of organization".
It is the target-indexed **functional cost profile**

\[
\mathbf C_t
=
\big(C_t(s_t,f)\big)_{f\in\Phi}.
\]

For one interval define functional gain

\[
g_t(f)
=
C_t(s_t,f)-C_{t+1}(s_{t+1},f).
\]

For a positive declared time or resource interval \(\Delta_t\), define
normalized ratchet velocity

\[
\boxed{
v_t(f)=\frac{g_t(f)}{\Delta_t}.
}
\]

A strong positive ratchet step is Pareto-like on a declared retained target
family: no target becomes more costly and at least one becomes strictly cheaper.
Lean proves that such a step necessarily creates a budget threshold at which
the declared functional repertoire strictly expands.

Ratchet acceleration is then a statement about **rates**, not merely about a
later state being better. Across matched or explicitly normalized episodes, the
later rate profile must weakly dominate the earlier one and strictly dominate it
for at least one declared target.

This formulation deliberately keeps the fundamental object vector-valued.
Scalar summaries are allowed, but only after an application declares its target
family, measure, weights, budget, and aggregation rule.

The outside research question is therefore:

\[
\boxed{
\text{What determines the velocity at which a commons acquires retained
functional organization?}
}
\]

Candidate control parameters include resource throughput, proposal/variation
rate, recombination, validation fidelity, retention, modularity, differentiation,
interaction topology, delay, repair, diversity, and coordination cost. Their
effects need not be monotone; the target is a regime-dependent theory of
ratchet velocity.

A first optional mechanism ledger separates one scalar projection of that
velocity into

\[
v_{\mathrm{ledger}}
=
\lambda\,p_G\,p_R\,p_V\,p_T\,\bar g,
\]

where the factors represent opportunity rate, conditional generation, resource
feasibility, validation, retention, and mean retained functional gain. If the
fractions are conditional probabilities, no independence assumption is needed.
The ledger has an explicit modelling seam: the universal theory does **not**
assert that every real system is represented by this product. Its purpose is to
expose candidate bottlenecks that domain models can derive or estimate.

A first part of that derivation is now explicit. Qualitative recurring
opportunity does not imply a positive speed floor because waiting times can grow
without bound. If instead opportunities have a maximum waiting time `K`, and
every opportunity receives a resource-feasible validated response within lag
`Δ`, then Lean proves that every window of width

\[
K+\Delta+1
\]

contains a validated retained update.

For the canonical maintained three-cycle, quantitative support holds at every
indexed time. Under an explicit support→opportunity connection this gives
`K=0`, hence one validated update in every `Δ+1` window. If an application
also proves at least `g_{\min}` functional gain per validated update, the same
window contains at least that gain.

If the chosen retained functional target is non-worsening between
certified successes, the window theorem sharpens to an actual block-average
rate bound:

\[
\boxed{
\bar v_k(f)
\ge
\frac{g_{\min}}{K+\Delta+1}.
}
\]

The strong per-step functional ratchet condition supplies this nonnegative
target-gain premise for any declared retained target.

The resulting guaranteed-rate floor has machine-checked comparative statics:
increasing `g_min`, decreasing the maximum opportunity wait `K`, or
decreasing validated-response lag `Δ` raises the floor; the corresponding
strict changes raise it strictly under positive gain.

This is the first formal notion of mechanism-level acceleration in the stack.
It is an acceleration of the **guaranteed lower bound**, not by itself proof
that the realized trajectory's observed velocity increased.

This produces a first genuine mechanism-to-speed bridge while preserving the
distinctions

\[
\boxed{
\text{open-endedness}
\neq
\text{positive rate floor}
\neq
\text{realized acceleration}.
}
\]

The ceteris-paribus monotonicity of individual ledger coordinates does not mean
that system velocity is monotone in every underlying control parameter.
Mechanisms can couple ledger coordinates through shared constraints.

A minimal exact specialization allocates a unit processing budget between
candidate generation/search and validation. Let \(x\in[0,1]\) be the search
share and \(1-x\) the validation share, with all other ledger factors fixed.
Then

\[
v(x)=x(1-x).
\]

Lean proves

\[
0\le v(x)\le\frac14
\]

on the feasible interval, with a unique maximum at

\[
x=\frac12.
\]

Velocity increases with search allocation below the midpoint and decreases
above it. At pure search \(x=1\), retained ledger velocity is zero because
nothing is allocated to validation.

This is not a universal law or a new statement of the established
stability--plasticity dilemma. It is an exact reduced-model witness inside the
EbE rate ledger showing:

\[
\boxed{
\text{more search/plasticity}
\not\Rightarrow
\text{faster retained functional change}
}
\]

when search competes with another necessary stage.

Formal sources:

- formalization/cumulative-accessibility/CumulativeAccessibility/FunctionalRatchetVelocity.lean
- formalization/cumulative-accessibility/CumulativeAccessibility/RatchetVelocityLedger.lean
- formalization/cumulative-accessibility/CumulativeAccessibility/BoundedUpdateRate.lean
- formalization/cumulative-accessibility/CumulativeAccessibility/SearchValidationTradeoff.lean

Working paper:

papers/functional-organization-ratchet-velocity/

---

# 12. Layer 8 — the full vortex

The current integrated formal core joins the resource route to the
second-order-accessibility route.

A **dynamic vortex turn** is an organizational transition that:

1. increases net internal slack at the same external gradient; and
2. is also a second-order accessibility click.

The Lean composition theorem proves that such a turn simultaneously produces:

- a newly affordable interval of response costs;
- a genuinely new future-search candidate.

The recurrent interface then adds one explicit modelling bridge: an internally
funded validated response is accompanied by a second-order organizational
update.

Under recurring opportunity, retention, and representation, the full
composition yields:

\[
\boxed{
\begin{aligned}
&\text{open-ended cumulative retained novelty},\\
&\text{unbounded effective distinguishability capacity},\\
&\text{arbitrarily late second-order organizational updates}.
\end{aligned}
}
\]

A concrete Lean witness jointly inhabits these assumptions.

This is the current formal centerpiece of Evolution by Emergence.

---

# 13. Layer 9 — selection can release slack, but selection is not progress

Selection remains part of the theory, but it is not treated as a universal
progress operator.

In one formal specialization, functionally equivalent implementations compete
while differing in implementation cost.

Under a declared linear cost penalty, competition drives mean implementation
cost non-increasingly. If functional return is fixed, released cost becomes
additional slack. If candidate-generation rate is monotone in slack, exploration
cannot decrease.

Thus, under those assumptions:

\[
\boxed{
\text{competition among equivalent implementations}
\rightarrow
\text{cost}\downarrow
\rightarrow
\text{slack}\uparrow
\rightarrow
\text{search}\uparrow.
}
\]

But if the environment or return map changes endogenously, the positive
selection component can be overwhelmed by a sufficiently negative return-path
effect.

So EbE explicitly rejects:

\[
\text{selection}\Rightarrow\text{global monotonic improvement}.
\]

Selection is one directional mechanism inside a larger state-dependent system.

---

# 14. Layer 10 — persistence is not the same as function

The repository repeatedly separates quantities that are often conflated:

- persistence;
- maintained mass;
- replacement rate;
- functional threshold;
- resource margin;
- search capacity;
- externally declared task success.

A system can persist while failing a declared function.
A selected control level can be below a sufficient functional level.
A large distinguishability envelope can exist without realized novelty.

These are not semantic niceties. They stop the theory from defining success by
whatever happened to persist.

The framework therefore requires the functional or evaluative criterion to be
declared separately when such a criterion is scientifically relevant.

---

# 15. Layer 11 — cumulative accessibility as a budgeted ratchet

The shared-budget specialization provides an exact finite example of historical
potentiation.

For declared budget \(B\) and binding inherited cost \(c_t^\star\), define

\[
M_t^{\mathrm{margin}}
=
\frac{B}{c_t^\star}-1.
\]

A productive first click can lower inherited cost and increase margin.

In the exact Lean witness,

\[
\frac23\rightarrow\frac{97}{99}.
\]

A later load

\[
\frac9{10}
\]

is therefore unavailable before the first click but affordable afterward.

Hence:

\[
\boxed{
\text{click 1 changes the resource state so click 2 becomes possible}.
}
\]

This is a minimal exact model of retained history changing later accessibility.

The dimensionless margin in this model is not identified with physical free
energy. It is one specialization of a more general future-response-budget idea.

---

# 16. Layer 12 — open-endedness has a capacity cost

A fixed finite distinguishable universe cannot support indefinitely many strict
retained expansions.

If retained novelty continues without bound, then the effective
distinguishability envelope must also become unbounded in the relevant model
sense.

The formal direction is:

\[
\boxed{
\text{open-ended cumulative retained novelty}
\rightarrow
\text{unbounded effective distinguishability capacity}.
}
\]

The converse is false.

Capacity does not generate novelty by itself.

This is an important anti-teleological boundary: empty possibility is not the
same as realized cumulative change.

---

# 17. Layer 13 — physical resources bound finite-time depth

Recursive accessibility does not imply physical explosion.

The organizational-depth formalization studies fixed operational resolution
under bounded activity, entropy production, resource, and time assumptions.

For one operational Markov-jump specialization, total-variation
data processing supplies a direct bridge from physical to operational
distinguishability.

The resulting bounds imply that bounded finite-time resources cannot support
arbitrarily many retained transitions that remain separated by a fixed positive
operational resolution.

Schematically,

\[
\boxed{
\text{bounded finite-time resources}
\Rightarrow
\text{bounded fixed-resolution depth}.
}
\]

Therefore an indefinitely continuing process must relax at least one relevant
finite-capacity condition, for example through:

- more time;
- more cumulative throughput;
- expansion of effective state space;
- changing representation;
- finer or vanishing operational distinctions.

So:

\[
\boxed{
\text{recursive accessibility}
\neq
\text{finite-time physical infinity}.
}
\]

---

# 18. Darwinian evolution inside EbE

EbE does not remove Darwinian evolution.

It places Darwinian selection inside a broader organizational architecture.

A conventional evolutionary description emphasizes:

\[
\text{variation}
\rightarrow
\text{differential persistence/reproduction}
\rightarrow
\text{inheritance}.
\]

EbE adds explicit questions around that loop:

- What organization keeps the replicating process viable?
- What resources fund variation and repair?
- Which earlier products become reusable infrastructure?
- How does retained organization change the candidate distribution?
- How can the generator itself evolve?
- How does the environment of later selection get partly constructed by earlier
  organization?
- What physical capacity limits cumulative change?

The resulting picture is more naturally a **web of causal construction and
selection** than a single branching tree.

That does not make phylogenetic trees wrong. Trees remain appropriate for many
ancestry questions. The point is that causal evolutionary history can also
contain recombination, horizontal transfer, symbiosis, ecological inheritance,
infrastructure, and cross-scale maintenance relations that are not represented
by ancestry alone.

---

# 19. The network is not merely the environment

A key conceptual shift is to treat shared organization as a causal object.

A network can do more than constrain its members. Its interactions can produce
capabilities no isolated member possesses.

This motivates the working definition:

> **A commons is a jointly produced or maintained organizational state whose
> condition changes the future capabilities or accessibility of multiple
> participants.**

Examples can include languages, scientific methods, standards, ecological
systems, public-health surveillance, open protocols, collective memory, and
institutional infrastructure.

This is an **interpretive extension**, not a universal Lean theorem.

Its scientific value is that it creates measurable questions:

- What shared structure changes which capabilities are reachable?
- What does it cost to reproduce it?
- Who contributes to its maintenance?
- Who can externalize its costs?
- Which local incentives underinvest in network-level function?
- What happens when repair capacity itself decays?

---

# 20. Capture as a failure mode

The broader conceptual work uses **capture** for a local/global mismatch in
which a part improves its local position while degrading the substrate or
organization on which the larger system depends.

The formal stack contains several narrower relatives:

- selected control can be below sufficient control;
- an added load can preserve or destroy inherited accessibility depending on
  margin;
- changing return paths can overwhelm a positive selection component;
- a cooperative protocol can fail to reproduce;
- removing a return edge can destroy maintenance support.

These results do not prove a universal theorem of "capture".

They provide model classes in which local and system-level criteria diverge.

Accordingly, capture should currently be treated as a research-program concept
to be operationalized separately in each application.

---

# 21. Intelligence, learning, and corrigibility

EbE can be applied to learning systems by treating:

- models, memories, tools, and institutions as retained organization;
- observation and communication as candidate-generating channels;
- error signals as external or relational validation;
- revision as organizational change;
- preserved correction channels as part of the maintained commons.

The structural claim is then:

\[
\boxed{
\text{a learning system must preserve or recreate enough capacity to be
corrected if it is to remain adaptive}.
}
\]

That interpretation motivates the project's work on corrigibility,
cooperation, and collective intelligence.

It is not a theorem that every persistent system is intelligent, or that
corrigibility is morally obligatory.

The descriptive and normative steps must remain separate.

## Inside translation: intelligent learning-maintenance processes

Quantitative accessibility supplies the **outside** description of learning:
the current organization induces a directed plasticity/viscosity geometry over
future organization.

Intelligent networks permit a complementary **inside** description. Let \(P_t\)
denote the state of processes through which a learning network encounters,
tests, corrects, repairs, retains, and recombines information. An
application-specific map

\[
\boxed{
C_t=\Gamma(P_t,X_t,E_t)
}
\]

connects those internal processes to the outside accessibility geometry.

For human or artificial learning networks, useful internal verbs can include:

- seek and encounter;
- listen;
- signal faithfully;
- expose uncertainty;
- test;
- revise;
- maintain informative disagreement;
- repair;
- re-engage after demonstrated repair;
- retain;
- recombine.

These verbs are **not** added to the universal EbE theorem as moral or causal
axioms. Their effects require substrate-specific models or empirical tests.

The two descriptions serve different roles:

\[
\boxed{
\text{OUTSIDE: functional accessibility geometry and ratchet velocity}
\quad\Longleftrightarrow\quad
\text{INSIDE: processes that alter that velocity}.
}
\]

Ordinary learning changes current capability. Learning-to-learn changes
\(P_t\) so that future functional acquisition becomes cheaper or faster.
Self-improvement requires the system itself to generate and apply the process
intervention that produces the improvement.

The preferred operational form of **recursive self-improvement** is stronger.
Start matched learning episodes from the same organization, hold the declared
held-out target family fixed, normalize by positive time/resource intervals,
and compare the old and self-modified learning processes. The new process must
preserve declared prior functions, be no slower on the declared held-out
targets, and be strictly faster on at least one:

\[
v_{P_{t+1}}(f)\ge v_{P_t}(f)
\quad\forall f\in\Phi_L,
\]

with strict inequality somewhere.

This does not imply runaway acceleration. Resource limits, interference,
increasing target difficulty, loss of diversity, or finite physical throughput
can make later velocity plateau or fall.

A complementary **mechanism-level** test is now formalized. An application can
associate each learning-maintenance process state with a certificate

\[
(K,\Delta,g_{\min}),
\]

where \(K\) bounds opportunity wait, \(\Delta\) bounds validated-response
lag, and \(g_{\min}\) lower-bounds retained functional gain per declared
success. Its conservative rate floor is

\[
v_{\min}
=
\frac{g_{\min}}{K+\Delta+1}.
\]

A self-generated process change is mechanism-grounded recursive
self-improvement when it preserves declared prior function and strictly raises
this justified floor. Lean checks three elementary sufficient routes when the
other coordinates are held fixed: shorter \(K\), shorter \(\Delta\), or
larger \(g_{\min}\).

This is not interchangeable with the matched held-out-rate test. The certificate
test concerns a guaranteed lower bound implied by a mechanism model; the
matched-episode test concerns realized learning performance. Their agreement is
an empirical question.

Formal specialization:

formalization/cumulative-accessibility/CumulativeAccessibility/IntelligentLearningMaintenance.lean

Working paper:

papers/learning-conditions-for-learning/

---

# 22. Collective intelligence and sufficient alignment

The collective-alignment work treats alignment as a viability region for a
declared task, not as perfect agreement.

It separates:

\[
\text{object-level diversity}
\quad\text{from}\quad
\text{protocol-level alignment}.
\]

The formal toy models support several narrower statements:

- deterministic garbling cannot improve the optimum of a cooperative decision
  problem under the declared assumptions;
- independent redundant correction can improve reliability above its threshold;
- individually selected alignment effort can fall below a declared sufficient
  level;
- a correction protocol must itself be transmitted and maintained;
- repair is worthwhile only inside an explicit value-of-repair region;
- recurrent return paths can maintain network-level support.

This extension connects the general EbE idea to learning networks:

> **not aligned minds, but interoperable learning processes.**

Again, this is conditional architecture, not a universal governance theorem.

---

# 23. What the theory does not claim

The current theory does **not** establish that:

- all evolution is governed by one microscopic mechanism;
- every network is adaptive;
- every persistent system is functional;
- every novelty is beneficial;
- every retained novelty increases slack;
- stronger association is always better or always worse;
- collaboration is intrinsically good;
- competition is intrinsically bad;
- external validation equals truth;
- unbounded capacity guarantees realized novelty;
- open-ended evolution can evade finite physical constraints;
- physical reality has a fixed finite state space;
- the framework has priority over the mature literatures whose mechanisms it
  uses;
- moral duties follow directly from persistence.

The literature audit found no high-confidence new general theorem among the
twelve initially audited claims. That finding is part of the theory's current
epistemic status, not something to hide.

---

# 24. What is actually new enough to review

The defensible review target is the **architecture/conjunction**.

The question is whether it is scientifically useful to place the following
objects into one common state-dependent account:

\[
\boxed{
\begin{aligned}
&\text{association and productive coupling}\\
&+\text{recurrent maintenance}\\
&+\text{resource solvency and slack}\\
&+\text{candidate generation}\\
&+\text{validation and retention}\\
&+\text{reusable historical organization}\\
&+\text{evolving generative rules}\\
&+\text{second-order accessibility}\\
&+\text{selection and efficiency drift}\\
&+\text{collective maintenance}\\
&+\text{physical depth bounds}.
\end{aligned}
}
\]

A useful synthesis must do more than rename prior science.

It should:

- expose missing interfaces;
- prevent category errors;
- make results from different fields comparable;
- generate counterexamples;
- make assumptions explicit;
- create measurable cross-domain questions;
- or reveal a reusable formal composition that was previously awkward to state.

That is the standard against which EbE should be judged.

---

# 25. The compact mathematical form

The current dynamic synthesis can be written:

\[
\begin{aligned}
J_t &= \mathcal U(s_t,G_t),\\
L_t &= J_t-\mathcal M(s_t),\\
B_t &= \beta_tL_t,\\
z_t &\sim \Sigma(M_t,H_t;B_t,U_t),\\
A_t &= E_t(z_t),\\
M_{t+1} &= \mathcal R(M_t,z_t,A_t),\\
H_{t+1} &= \Psi(H_t,M_{t+1},z_t),\\
s_{t+1} &= \Phi(s_t,M_{t+1},H_{t+1}),\\
\Sigma_{t+1} &= \Sigma(M_{t+1},H_{t+1}).
\end{aligned}
\]

The functions \(\mathcal R,\Psi,\Phi\) are interfaces, not universal laws.
Different substrates can instantiate them differently.

The core second-order condition is:

\[
\boxed{
\Sigma_t\neq\Sigma_{t+1}
}
\]

for at least some retained organizational transitions.

The full theory is therefore not a claim that all systems follow one equation.
It is a claim that these interfaces form a useful **causal grammar** for
studying prolonged, cumulative organization.

---

# 26. The thesis in one sentence

> **Existing organization uses environmental throughput to maintain and modify
> itself; retained modifications change resources, reusable structure, or
> generative possibilities, thereby changing which organizations can exist
> next.**

And in one loop:

\[
\boxed{
\text{gradient}
\rightarrow
\text{maintenance}
\rightarrow
\text{slack}
\rightarrow
\text{search}
\rightarrow
\text{retention}
\rightarrow
\text{changed search}
\rightarrow
\text{changed organization}
\rightarrow
\text{changed future uptake/maintenance}
\circlearrowleft
}
\]

---

# 27. What remains open

The current formalization intentionally leaves several research questions open.

1. **Physical state update.** In a real system, when does a retained candidate
   produce a specific organizational state change?
2. **Endogenous response costs.** How do response costs change with organization?
3. **Gradient dynamics.** How are external gradients depleted, replenished, or
   relocated?
4. **Turnover and memory.** How should monotone retained-set models be replaced
   by loss, recovery, redundancy, and memory?
5. **Stochastic generation and validation.** What distributions generate
   recurrent successful uptake?
6. **Generator evolution.** Under what mechanisms does selection act on
   candidate-generating rules themselves?
7. **Cross-scale composition.** When does organization at one scale become a
   component at another?
8. **Operational distinguishability.** Which state metrics correspond to
   empirically meaningful differences?
9. **Capture.** Which measurable local/global objective gaps predict substrate
   degradation?
10. **Architectural prior art.** Does an equivalent or stronger integrated
    architecture already exist in another literature?

These are not footnotes. They are the next tests of the theory.

---

# 28. How to read and review the repository

For an accessible path:

1. **This file** — the full theory.
2. **[DYNAMIC_OVERVIEW.md](DYNAMIC_OVERVIEW.md)** — the recursive vortex in
   detail.
3. **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)** — exact claims and Lean
   declarations.
4. **[formalization/README.md](formalization/README.md)** — proof packages and
   reproduction.
5. **[PEER_REVIEW_PROMPT.md](PEER_REVIEW_PROMPT.md)** — adversarial review
   protocol.
6. **[verification/audits/](verification/audits/)** — theorem and literature
   audits.

For historical context, the original book remains in the LaTeX chapter tree.
It should be read as the intellectual history of the project. The files above
are the current theory surface.

---

# 29. Review rule

The preferred form of contribution is not agreement.

Useful contributions include:

- a counterexample;
- an unstated assumption;
- a failed composition;
- a more general theorem;
- a simpler explanation;
- an empirical system that violates a predicted boundary;
- a stronger antecedent in the literature;
- or evidence that two layers should not be unified.

**Prior art is a result. A successful falsification is a contribution.**
