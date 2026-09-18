# The Dynamic Core of Evolution by Emergence

## A resource-fed recursive accessibility vortex

This document is the canonical overview of the **dynamic core** of Evolution by
Emergence. For the full theory—including affinity, selection/persistence drift,
collective alignment, interpretive extensions, novelty status, and the research
agenda—start with **[THEORY.md](THEORY.md)**. Exact theorem traceability is in
**[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)**.

The central object is not a static organization. It is a maintained process
whose present organization changes the conditions of its own continuation.

The shortest statement is:

> **Organized processes persist by using environmental gradients to recreate the
> organization required for further activity. When retained changes alter
> resource efficiency, reusable structure, generative rules, or effective
> search, the organization changes the possibilities available to its
> successors. Repetition of this state-dependent reconstruction creates
> cumulative historical accessibility.**

The physical qualification is equally important:

> **Recursive accessibility does not remove resource, time, maintenance, or
> distinguishability bounds.**

---

## 1. State of the dynamic system

Write the evolving state schematically as

\[
\Omega_t=(s_t,M_t,H_t,U_t),
\]

where

- \(s_t\) is the current physical or organizational implementation;
- \(M_t\) is retained organization, modules, or repertoire;
- \(H_t\) is the current generative rule;
- \(U_t\) is the currently distinguishable possibility envelope.

Two additional inputs are kept explicitly outside the organization:

- \(G_t\): environmental gradient or resource opportunity;
- \(E_t\): declared external evaluation or acceptance process.

This separation is intentional. The organization does not create the external
gradient in the present model, and external validation is not defined to mean
objective truth.

---

## 2. The full loop

\`\`\`text
                    EXTERNAL GRADIENT G_t
                            │
                            ▼
                 ┌─────────────────────┐
                 │ current organization│
                 │        s_t          │
                 └─────────────────────┘
                     │             │
                  uptake        maintenance
                     │             │
                     └──────┬──────┘
                            ▼
                    INTERNAL SLACK L_t
                            │
                       reinvestment β_t
                            │
                            ▼
                  RESPONSE / SEARCH BUDGET
                            │
                            │ + maintained opportunity
                            ▼
                 generation from M_t by H_t
                            │
                            ▼
                       candidate z
                            │
                       external E_t
                            │
                            ▼
                    validated retention
                            │
                            ▼
                         M_{t+1}
                            │
             ┌──────────────┴──────────────┐
             │                             │
             ▼                             ▼
   new reusable parent material      changed generative rule
             │                             │
             └──────────────┬──────────────┘
                            ▼
                 changed search operator
                            │
                            ▼
                 SECOND-ORDER CLICK
                            │
                            ▼
             possibilities inaccessible to s_t
             become accessible from s_{t+1}
                            │
                            ▼
                 changed organization s_{t+1}
                            │
              ┌─────────────┴─────────────┐
              ▼                           ▼
        changed uptake              changed maintenance
              │                           │
              └─────────────┬─────────────┘
                            ▼
                    NEW INTERNAL SLACK
                            │
                            └──────────────► repeat
\`\`\`

This is the **vortex**: flow sustains organization, while retained organization
changes the channel through which later flow, search, and construction occur.

---

## 3. Maintenance keeps the process instantiated

The cumulative-accessibility stack uses a discrete recurrent maintenance loop.
Under explicit sign and closed-loop replacement conditions, Lean proves
persistent positive quantitative support.

The important separation is:

\[
\text{maintenance support}\neq\text{innovation}.
\]

A declared support-to-opportunity interface is required before persistent
support can imply recurring opportunity.

Relevant files:

- \`formalization/collective-alignment/MaintenanceDynamics.lean\`
- \`formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceOpportunityBridge.lean\`

A separate continuous maintenance-debt programme has its own literal
end-to-end theorem in:

- \`verification/organizational-depth/MaintenanceDynamicsEndToEnd.lean\`

That theorem closes nonlinear flow -> equilibrium -> Jacobian -> characteristic
roots for that specific model. It is a different endpoint and should not be
silently identified with the cumulative-accessibility maintenance loop.

---

## 4. Gradient, uptake, maintenance, and internal slack

For organization \(s_t\) under external gradient \(G_t\), define captured
throughput

\[
J_t=\mathcal U(s_t,G_t)
\]

and maintenance demand

\[
C_t=\mathcal M(s_t).
\]

Internal slack is

\[
\boxed{L_t=J_t-C_t}.
\]

The external gradient remains a boundary condition. The **usable amount of that
gradient is organization-dependent**.

A declared reinvestment fraction gives

\[
\boxed{B_t^{\mathrm{resp}}=\beta_t L_t}.
\]

Lean checks that at a fixed external gradient, higher uptake and/or lower
maintenance cannot reduce slack, and with nonnegative reinvestment cannot reduce
the internally generated response budget.

Relevant file:

- \`CumulativeAccessibility/EndogenousBudgetBridge.lean\`

The persistence-drift package independently proves a related route:

\[
\text{cheaper functionally equivalent implementation}
\rightarrow
\text{more slack}
\rightarrow
\text{no less exploration},
\]

and in its two-type model:

\[
\text{implementation competition}
\rightarrow
\text{mean cost}\downarrow
\rightarrow
\text{slack}\uparrow
\rightarrow
\text{search rate}\uparrow.
\]

Relevant file:

- \`formalization/persistence-drift/PersistenceDrift.lean\`

---

## 5. Slack funds realizable response

A response candidate \(z\) is resource feasible at time \(t\) when

\[
C_{\mathrm{resp}}(t,z)\le B_t^{\mathrm{resp}}.
\]

A strict budget increase therefore opens a nonempty interval of response costs
that were previously infeasible and are now affordable.

The existing fixed-gradient witness holds the environmental gradient at 10,
maintenance at 6, and improves captured uptake from 10 to 11:

\[
L:4\rightarrow5.
\]

A response with cost \(9/2\) crosses from infeasible to feasible.

Relevant files:

- \`ResponseDynamics.lean\`
- \`EndogenousBudgetBridge.lean\`
- \`EndogenousBudgetWitness.lean\`

---

## 6. Opportunity, delay, validation, and retention

The formalization separates:

- recurring opportunity \(Q\);
- resource-feasible validated response;
- response delay \(\Delta\);
- recurrent validated uptake \(G\);
- retention \(R\).

An opportunity at time \(q\) may receive a response at time \(r\) with

\[
q\le r\le q+\Delta.
\]

The old same-time condition is exactly the \(\Delta=0\) special case.

The checked route is:

\[
Q+B_\Delta
\rightarrow
D_\Delta
\rightarrow
G,
\]

and then

\[
R+G
\rightarrow
\text{open-ended cumulative retained novelty}.
\]

Relevant files:

- \`ResponseDynamics.lean\`
- \`BoundedResponseWitness.lean\`
- \`ValidatedUptake.lean\`

---

## 7. Retention creates historical dependence

Retained products become future substrate.

\`GenerativeClosure.lean\` contains the minimal checked example

\[
a\rightarrow b,\qquad b\rightarrow c,
\]

with no direct \(a\rightarrow c\) route.

Candidate \(c\) is unavailable after one retained generative round but becomes
available after two because generated \(b\) has become reusable parent material.

Thus

\[
\boxed{\text{product of one round}\rightarrow\text{substrate for later rounds}.}
\]

This is cumulative history rather than mere succession.

---

## 8. Retained organization changes evolvability

The repository separates two mechanisms.

### Repertoire-driven expansion

Hold the generative rule fixed and change retained modules:

\[
M_t\rightarrow M_{t+1}.
\]

A newly realizable parent set can strictly expand the effective search operator.

Relevant file:

- \`ModuleGeneratedEvolvability.lean\`

### Rule-driven expansion

Hold the retained repertoire fixed and change the generative rule:

\[
H_t\rightarrow H_{t+1}.
\]

This can also strictly expand future search.

Relevant file:

- \`GeneratorRuleEvolution.lean\`

The distinction matters: evolution can change both the material available to
generation and the rule by which generation occurs.

---

## 9. Second-order accessibility

\`RecursiveAccessibility.lean\` defines a \`SecondOrderClick\` as a viable
organizational transition

\[
x\rightarrow y
\]

for which the declared future search operator strictly expands:

\[
\Sigma(x)\subsetneq\Sigma(y).
\]

So the transition changes both the state and the possibilities available from
that state.

Retained history composes this effect. Lean proves that a descendant can expose
a future candidate unavailable to its ancestor.

This is the formal core of the statement:

> **the process changes the conditions of its own future change.**

---

## 10. The new composition theorem

\`DynamicVortex.lean\` makes the previously distributed composition explicit.

A \`DynamicVortexTurn\` is one organizational transition that

1. strictly raises internal slack at the same external gradient; and
2. is a \`SecondOrderClick\`.

Lean then proves:

\[
\boxed{
\text{dynamic vortex turn}
\rightarrow
\begin{cases}
\text{a newly affordable response-cost interval},\\
\text{a newly accessible future-search candidate}.
\end{cases}}
\]

The recurrent interface
\`OpportunityConditionedEndogenousVortexResponseWithin\` additionally requires
that an internally funded validated response is accompanied by a second-order
organizational update.

From recurring opportunity, retention, and representation, Lean packages the
previously separate routes into one theorem:

\[
\boxed{
\text{integrated endogenous vortex response}
\rightarrow
\begin{cases}
\text{open-ended cumulative retained novelty},\\
\text{unbounded effective distinguishability capacity},\\
\text{arbitrarily late second-order organizational updates}.
\end{cases}}
\]

The coupling from a retained response to a particular physical organizational
update remains an explicit modelling assumption. The theorem does not claim
that every retained novelty is physically supportive.

---

## 11. Concrete full-dynamic witness

\`DynamicVortexWitness.lean\` inhabits the composition with one transparent toy
architecture.

- fixed gradient: 10;
- maintenance: 6;
- baseline uptake: 10;
- later uptake: 11;
- response budget: \(4\rightarrow5\);
- response cost: \(9/2\);
- retained repertoire: the progressive natural-number repertoire;
- state \(n\) exposes search candidates \(z\le n\);
- every \(n\rightarrow n+1\) transition is a second-order click.

The concrete theorem certifies simultaneously:

\[
\text{open-ended cumulative retained novelty},
\]

\[
\text{unbounded distinguishability capacity},
\]

and

\[
\text{recurring second-order organizational/search updates}.
\]

This is a non-vacuity/composition witness, not an empirical model.

---

## 12. The shared-budget ratchet is a complementary realization

The cumulative-accessibility paper gives another view of historical dependence.

With budget \(B\) and binding inherited cost \(c_t^\star\),

\[
M_t^{\mathrm{margin}}=\frac{B}{c_t^\star}-1.
\]

The exact first productive click winds margin from

\[
\frac23\rightarrow\frac{97}{99},
\]

making the later \(9/10\) load affordable although it was unaffordable from the
baseline.

So retained organization changes the resource state in a way that changes what
can be retained next.

This dimensionless margin is not identified with physical free-energy slack.
Both instantiate a future-response-budget interface in their own declared
units.

Relevant paper:

- \`papers/when-does-change-become-cumulative/\`

---

## 13. Why the vortex does not imply physical explosion

Recursive accessibility is constrained.

### Finite distinguishability

Inside a fixed finite distinguishable universe, monotone retained strict
expansion cannot continue forever.

\`FiniteGenerativeSaturation.lean\` proves the corresponding counting bound.

### Open-ended cumulative novelty

\`OpenEndedCapacity.lean\` proves

\[
\boxed{
\text{open-ended cumulative retained novelty}
\rightarrow
\text{unbounded effective distinguishability capacity}.
}
\]

The converse is false.

### Finite-time fixed-resolution depth

The organizational-depth programme separately proves conditional resource
bounds on fixed-resolution retained depth. Under its explicit physical
speed/action assumptions, bounded resource and time exclude arbitrarily many
fixed-resolution retained transitions.

Relevant files:

- \`verification/organizational-depth/OrganizationalDepth.lean\`
- \`verification/organizational-depth/PackingDepth.lean\`

Therefore

\[
\boxed{\text{recursive accessibility}\neq\text{finite-time physical explosion}.}
\]

Open-ended continuation must relax at least one relevant finite-capacity
condition: more time, more throughput, expanding operational state space,
changing representation/resolution, or vanishing distinguishable step size.

---

## 14. Compact recursive form

A schematic dynamic model is

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

The strongest conceptual point is that the effective transition structure can
itself change:

\[
(\Omega_t,F_t)\rightarrow(\Omega_{t+1},F_{t+1}).
\]

That is the sense in which the framework is **second-order evolutionary**.

---

## 15. Proof-status map

| Dynamic arrow | Current status |
|---|---|
| recurrent maintenance loop -> persistent quantitative support | Lean checked |
| support -> arbitrary opportunity | not automatic; explicit connection required |
| uptake - maintenance -> internal slack | defined and Lean checked |
| improved uptake/lower maintenance -> no less slack | Lean checked |
| slack x reinvestment -> endogenous response budget | Lean checked |
| larger budget -> newly feasible response interval | Lean checked |
| opportunity + bounded feasible validated response -> recurrent uptake | Lean checked |
| recurrent validated uptake + retention -> open-ended retained novelty | Lean checked |
| retained generated intermediate -> reusable future parent | Lean checked |
| retained module change -> expanded search | Lean checked |
| generator-rule change -> expanded search | Lean checked |
| viable transition + expanded search -> second-order click | Lean checked |
| retained history + second-order click -> ancestor-new future possibility | Lean checked |
| slack-improving second-order transition -> budget window + search expansion | Lean checked in \`DynamicVortex.lean\` |
| internally funded integrated response -> open-ended novelty + unbounded capacity + recurring second-order updates | Lean checked in \`DynamicVortex.lean\` |
| one concrete architecture jointly inhabits those consequences | Lean checked in \`DynamicVortexWitness.lean\` |
| productive first shared-budget click -> later click becomes feasible | Lean checked |
| lower-cost equivalent implementation -> more slack/search | Lean checked |
| open-ended novelty -> unbounded distinguishability envelope | Lean checked |
| fixed finite distinguishability -> finite cumulative retained expansion | Lean checked |
| bounded finite-time physical resources -> bounded fixed-resolution depth | Lean checked conditionally on stated physical assumptions |
| retained candidate -> specific real-world physical state update with measured uptake/maintenance effects | application-specific empirical/model mapping |

---

## 16. What should be peer reviewed

The primary scientific review target is no longer a single isolated theorem.
It is the **architecture and its interfaces**.

Reviewers should attack, in particular:

1. whether the state decomposition \((s_t,M_t,H_t,U_t)\) hides important
   dependencies;
2. whether the support -> opportunity interface is too weak or too strong;
3. whether the endogenous slack ledger is physically interpretable in proposed
   applications;
4. whether response cost and reinvestment are the right abstraction;
5. whether the integration premise from retained response to second-order
   organizational update can be mechanistically derived in useful model
   classes;
6. whether monotone retention should be replaced by turnover plus recoverable
   memory;
7. whether external validation \(E_t\) needs its own dynamics;
8. whether the distinguishability envelope \(U_t\) corresponds to operationally
   measurable distinctions;
9. whether the finite-resolution physical boundary is being mapped correctly to
   the abstract accessibility state space;
10. whether prior literature already contains the same integrated architecture
    or stronger results.

A successful counterexample, failed interface, or prior-art identification is a
useful result.

---

## 17. The core thesis

The current thesis can be stated compactly as:

> **Organized processes persist by using environmental gradients to continually
> recreate the organization required for their own continuation. Retained
> changes can alter resource efficiency, reusable structure, generative rules,
> and effective search. Those changes modify which successor organizations are
> reachable. Repeated state-dependent reconstruction therefore makes history
> causal: existing organization helps produce new organization that changes
> what can subsequently exist.**

Or, schematically:

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

That loop is the dynamic object this repository now aims to prove, delimit, and
peer review.
