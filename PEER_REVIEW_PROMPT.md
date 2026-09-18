# Formal-core peer-review prompt

Use this prompt with an LLM that can inspect GitHub. For the current post-v15 revision, first resolve `main` (or the pull request under review) to an exact commit SHA and review that immutable commit. The tagged **v15** release remains the historical verification-closure baseline.

```text
Act as an adversarial scientific peer reviewer of an exact commit of:

https://github.com/albertjanvanhoek/Evolution-by-Emergence

Resolve the target branch or pull request to an exact commit SHA before analysis and report it.

Your task is to test the formal-core claims, not to defend or attack the broader philosophy of Evolution by Emergence.

ACCESS GATE — DO THIS FIRST

Before reviewing, report:

REPOSITORY ACCESS: yes / no
TARGET VERSION: <exact commit SHA> / v15 / unknown
SOURCE-FILE ACCESS: yes / no
LEAN EXECUTION: yes / no
LITERATURE SEARCH: yes / no

SOURCE-FILE ACCESS may be reported as "yes" only after you have successfully
opened RELEASE_NOTES.md at the target commit and at least one exact Lean source from the
core-file list below. Access in principle is not the same as successful source
resolution.

If you cannot access the repository or supplied source files, STOP.
Do not substitute a generic review of evolutionary theory, emergence,
open-ended evolution, cybernetics, artificial life, or cooperation.
Do not invent likely source files, theorem names, assumptions, weaknesses,
prior literature, or severity ratings.

If you review v15 rather than the current post-v15 revision, say so explicitly.
Never mix theorem statements or verification evidence from different commits.

CORE FILES — USE THESE EXACT PATHS AT THE TARGET COMMIT

THEORY.md
DYNAMIC_OVERVIEW.md
FORMAL_THEORY_MAP.md
CLAIMS.md
RELEASE_NOTES.md
RESEARCH_GUIDE.md
formalization/README.md
formalization/affinity-layer/AffinityLayer.lean
formalization/collective-alignment/CollectiveAlignment.lean
formalization/collective-alignment/MaintenanceReproduction.lean
formalization/collective-alignment/MaintenanceDynamics.lean
formalization/persistence-drift/PersistenceDrift.lean
formalization/persistence-drift/FunctionalCompetition.lean
formalization/persistence-drift/ReturnPathPrice.lean
formalization/cumulative-accessibility/README.md
formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortex.lean
formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortexWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/FormalCoreWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceGatedWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceOpportunityBridge.lean
formalization/cumulative-accessibility/CumulativeAccessibility/ResponseDynamics.lean
formalization/cumulative-accessibility/CumulativeAccessibility/BoundedResponseWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousBudgetBridge.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousBudgetWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/ValidatedUptake.lean
formalization/cumulative-accessibility/CumulativeAccessibility/OpenEndedCapacity.lean
formalization/cumulative-accessibility/CumulativeAccessibility/FiniteGenerativeSaturation.lean
formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeClosure.lean
formalization/cumulative-accessibility/CumulativeAccessibility/GeneratorRuleEvolution.lean
formalization/cumulative-accessibility/CumulativeAccessibility/CapacitySlack.lean
formalization/cumulative-accessibility/CumulativeAccessibility/AuditAll.lean
formalization/cumulative-accessibility/CumulativeAccessibility/VerificationSurface.lean
verification/organizational-depth/OrganizationalDepth.lean
verification/organizational-depth/OperationalBridge.lean
verification/organizational-depth/PackingDepth.lean
verification/organizational-depth/MaintenanceDynamicsEndToEnd.lean
verification/audits/2026-09-15-literature/P1_LITERATURE_AUDIT.md
verification/audits/2026-09-15-literature/FROM_SYNTHESIS_TO_PARADIGM.md

FILE-RESOLUTION RULE

Do not infer that a file is absent because it is not in the first directory you
inspect. The core Lean files are nested under:

formalization/cumulative-accessibility/CumulativeAccessibility/

Before reporting a named source as missing:

1. try the exact target-commit path supplied above;
2. if that fails, search the target commit recursively by filename and a
   distinctive theorem/definition name;
3. inspect imports and the package README;
4. distinguish "I could not resolve this file with my available tools" from
   "this file does not exist".

Never ask the human for a path already supplied in this prompt.

Before beginning scientific analysis, report:

THEORY.md: FOUND / NOT RESOLVED — <exact path or limitation>
FORMAL_THEORY_MAP.md: FOUND / NOT RESOLVED — <exact path or limitation>
formalization/README.md: FOUND / NOT RESOLVED — <exact path or limitation>
DYNAMIC_OVERVIEW.md: FOUND / NOT RESOLVED — <exact path or limitation>
DynamicVortex.lean: FOUND / NOT RESOLVED — <exact path or limitation>
DynamicVortexWitness.lean: FOUND / NOT RESOLVED — <exact path or limitation>
FormalCoreWitness.lean: FOUND / NOT RESOLVED — <exact path or limitation>
MaintenanceGatedWitness.lean: FOUND / NOT RESOLVED — <exact path or limitation>
MaintenanceOpportunityBridge.lean: FOUND / NOT RESOLVED — <exact path or limitation>

EVIDENCE RULE

Do not populate SOURCE / THEOREM unless you have located the exact repository
path and, where applicable, the exact Lean declaration.

If not accessed, write:

SOURCE / THEOREM: UNVERIFIED — SOURCE NOT ACCESSED

Do not assign a severity until you have confirmed that the repository actually
makes the criticized claim. Before proposing a conceptual criticism, check
whether the supposed confusion is already an explicit non-claim, converse
failure, counterexample, or acknowledged scope limitation.

LOGICAL-DIRECTION RULE

For every theorem, rewrite its logical direction explicitly before evaluating
necessity, converse status, or failure cases.

If the theorem is:

A -> B

then it establishes that A is sufficient for B. It does not establish that A is
necessary for B. Failure of A does not imply failure of B. The exact converse is
B -> A.

If the theorem is:

(A and C) -> B

then showing that A alone does not imply B is a premise-ablation or independence
result, not a counterexample to the theorem and not the theorem's converse.

Label negative results precisely as one of:

- counterexample to the stated theorem;
- counterexample to the exact converse;
- premise ablation / one premise alone is insufficient;
- independence result;
- scope limitation;
- empirical applicability concern.

Do not call a sufficient condition "required" unless necessity is separately
proved.

WITNESS RULE

There are two different formal-core witnesses and they serve different roles.

1. FormalCoreWitness.lean

This is a logical non-vacuity witness. Its progressive architecture realizes
new retained novelty at every time step, so the opportunity premise is stronger
than necessary for that particular construction. This does not invalidate the
bridge theorem. It means the witness does not demonstrate causal dependence or
minimality.

2. MaintenanceGatedWitness.lean

This is a within-model dependency/ablation witness. The same architecture
family is parameterized by an opportunity stream. At a time step:

- opportunity present -> generator enabled and repertoire can expand;
- opportunity absent -> generator disabled and repertoire unchanged.

The concrete recurrent maintenance stream yields open-ended cumulative novelty.
Replacing the opportunity stream by False leaves the architecture static and
not open-ended.

Treat this as a constructive dependency result inside the formal model. Do not
upgrade it to empirical causality.

Likewise, acceptAllCriterion is explicitly a permissive non-vacuity witness,
not a scientifically realistic validator.

VERIFICATION-STATUS RULE

Distinguish three levels:

- SOURCE INSPECTED: you read the Lean declaration/proof text;
- REPOSITORY-REPORTED MACHINE CHECK: CI/release material reports a successful
  Lean build;
- INDEPENDENTLY EXECUTED: you actually ran the relevant Lean build yourself.

If LEAN EXECUTION is "no", do not claim independent execution.

The current verification contract explicitly builds:

CumulativeAccessibility.AuditAll
CumulativeAccessibility.VerificationSurface
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
CumulativeAccessibility.BoundedResponseWitness
CumulativeAccessibility.EndogenousBudgetWitness

AuditAll must import every module advertised by the package README.
VerificationSurface explicitly prints the axiom dependencies of the declarations
selected for the advertised verification surface. CI rejects sorryAx in that
output and retains the two end-to-end witness audits. If you can execute Lean,
reproduce this rather than relying only on the badge.

SCIENTIFIC TASK 1 — RECONSTRUCT THE FORMAL CHAIN

Reconstruct the exact implication architecture:

positive canonical support + nonnegative dynamics + non-strict product threshold
        -> persistent quantitative support

persistent support
        + explicit SupportImpliesOpportunity connection
        -> recurring opportunity Q

same-time route:
Q + success at every opportunity V
        -> recurrent successful coincidence W

bounded-delay route:
external gradient G_t
        + organization-dependent uptake U(s_t,G_t)
        - maintenance demand M(s_t)
        -> internal slack L_t
        -> endogenous response budget B_t^resp

Q + per-opportunity internally financed validated response within lag Δ (B_Δ)
        -> recurrent validated response within lag Δ (D_Δ)
D_Δ -> validated generative uptake G

W <-> D_0

retention R + G
        -> open-ended cumulative retained novelty N

representation P + retention R + N
        -> unbounded effective distinguishability capacity C

Also verify the separation results:
Q and not N
W and not V
Q and G and not W
D_1 and not W
validated success and not resource-feasible validated success
resource feasibility and not validated success

For every arrow:

1. locate the exact definitions and theorem(s);
2. list assumptions explicitly;
3. state the logical direction;
4. determine whether the proof establishes the stated implication;
5. identify any strengthening introduced only in prose;
6. inspect included counterexamples and converse failures.

SCIENTIFIC TASK 2 — ATTACK THE BOUNDARIES

Try to break the following distinctions:

maintenance != learning
persistence != fitness
novelty != improvement
external validation predicate != objective truth
unbounded capacity != realized novelty
joint satisfiability != empirical realism
within-model dependency != empirical causality

If the repository itself already contains a counterexample protecting one of
these distinctions, report that before proposing the criticism.

SCIENTIFIC TASK 3 — TEST FINITE SATURATION

Inspect FiniteGenerativeSaturation.lean and OpenEndedCapacity.lean.

Check the claims that:

1. strict retained expansion inside a fixed finite distinguishability set is
   bounded by remaining finite capacity;
2. idle periods do not evade that count bound;
3. changing the generator alone does not evade a fixed finite capacity bound;
4. open-ended cumulative retained novelty, with representation in a moving
   envelope, implies unbounded envelope capacity;
5. the converse is false.

Try to find a counterexample to the exact theorem statements, not to a stronger
interpretation the files do not claim.

SCIENTIFIC TASK 4 — TEST RETAINED GENERATIVE CLOSURE

Inspect GenerativeClosure.lean and related arity/evolvability modules.

Check whether the formalization really distinguishes:

- retained stepping-stone depth;
- expansion of the search/generative operator;
- multi-parent recombination;
- changes in retained parent material;
- changes in the generative rule;
- actual realized novelty.

SCIENTIFIC TASK 5 — TEST QUANTITATIVE SUPPORT AND THE MAINTENANCE BRIDGE

Inspect MaintenanceOpportunityBridge.lean and MaintenanceDynamics.lean.

Check that:

1. cycle3SupportedBy requires the lower-bound vector itself to be strictly
   positive and the trajectory state to remain componentwise above it;
2. the canonical support theorem uses the non-strict product threshold;
3. the scalar epsilon floor is derived from, rather than substituted for, the
   retained vector bound;
4. persistent support implies recurring opportunity only through an explicit
   SupportImpliesOpportunity connection;
5. no theorem claims recurrence of an arbitrary opportunity predicate from
   support alone;
6. the repository does not call the mathematical canonical vector an empirically
   calibrated operational threshold without an additional modelling argument.

Then inspect Q, V, W, and G. Verify exactly:

Q and V -> W
W -> Q
W -> G

and verify that retention remains an explicit premise in R and G -> N, while
representation and retention remain explicit in P and R and N -> C.

Confirm that W is a weaker sufficient coupling assumption than V, not a
derivation of successful innovation from maintenance.

Then inspect ResponseDynamics.lean and BoundedResponseWitness.lean. Check that:

1. ResourceFeasibleAt is exactly a declared cost <= budget inequality at a
   specific time and candidate;
2. ResourceValidatedSuccessAt retains all ordinary validated-success premises
   and adds, rather than replaces them with, resource feasibility;
3. RecurringValidatedResponseWithin Δ keeps opportunity time q and success time
   r distinct and enforces q <= r <= q + Δ;
4. W is literally equivalent to the Δ=0 case;
5. Q plus the local bounded resource-response premise B_Δ implies D_Δ and then G;
6. the lag-1 even/odd witness really has D_1 while W is false;
7. neither ordinary validated success nor resource feasibility implies the
   other in the supplied separation witnesses;
8. inspect EndogenousBudgetBridge.lean and confirm that the external gradient
   remains an input while usable response budget is generated as a function of
   organizational uptake minus maintenance;
9. verify that fixed-gradient higher uptake and/or lower maintenance only imply
   nondecreasing slack/budget under the stated nonnegative reinvestment
   assumptions;
10. verify the fixed-gradient witness: gradient 10, maintenance 6, uptake
    10 -> 11, internal budget 4 -> 5, and response cost 9/2;
11. inspect the cumulative-margin specialization and confirm it does not identify
    dimensionless Margin with physical free energy;
12. verify that the exact 2/3 -> 97/99 margin winding makes response/load cost
    9/10 infeasible before and feasible after;
13. confirm that the organizational state trajectory is still supplied rather
    than derived from the retained novelty event, so the final feedback
    novelty -> organization -> future uptake/maintenance remains open.

SCIENTIFIC TASK 6 — TEST BOTH WITNESSES

For FormalCoreWitness.lean:

- confirm joint satisfiability;
- identify the deliberately unused opportunity premise in the progressive
  witness;
- classify this correctly as a witness limitation, not a theorem failure.

For MaintenanceGatedWitness.lean:

- verify that the opportunity hypothesis is actually used in the generator and
  repertoire update;
- verify the recurrent-maintenance positive construction;
- verify the no-opportunity ablation;
- verify the W and not V witness;
- verify the Q and G and not W even/odd witness;
- determine exactly what dependency/coupling statements follow and what causal
  claims do not follow.

SCIENTIFIC TASK 7 — AXIOM AUDIT

If you can execute Lean, run:

cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface CumulativeAccessibility.FormalCoreWitness CumulativeAccessibility.MaintenanceGatedWitness CumulativeAccessibility.BoundedResponseWitness CumulativeAccessibility.EndogenousBudgetWitness
lake env lean CumulativeAccessibility/VerificationSurface.lean
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
lake env lean CumulativeAccessibility/BoundedResponseWitness.lean
lake env lean CumulativeAccessibility/EndogenousBudgetWitness.lean

Report whether any central printed theorem depends on sorryAx.

Standard Lean/Mathlib axioms such as propext, Classical.choice, and Quot.sound
are not the same as sorryAx; report them accurately rather than calling them
unproved placeholders.

LITERATURE AND NOVELTY RULE

Do not call a result or mechanism "novel" without performing an actual
literature search and citing the sources that support that assessment.

If you have not completed that search, write:

RELATION TO PRIOR LITERATURE: NOT ASSESSED

The repository itself positions much of the stack conservatively as synthesis
and research architecture with exact model-specific results. Treat novelty as a
question to investigate, not a default label.

SCOPE AND SEVERITY RULE

Do not assign High/Fatal severity merely because a theorem is narrow, abstract,
or not yet generalized when that limitation is explicit.

Reserve High/Fatal severity for a demonstrated false theorem, inconsistent
assumptions, invalid proof dependency, hidden sorry/unproved dependency, or
prose claim that materially exceeds the formal result.

SELF-CONSISTENCY CHECK — BEFORE FINALIZING

Check that:

1. every claimed converse is the literal reverse implication;
2. you never infer not-B merely from failure of a sufficient A;
3. every theorem criticism names an exact theorem and source;
4. every novelty claim has literature evidence;
5. every severity refers to an actual defect rather than an acknowledged scope
   limitation;
6. statements about machine verification match your declared execution level;
7. you distinguish the original non-vacuity witness from the gated dependency
   witness and the bounded-delay response witness;
8. you distinguish compilation coverage (AuditAll) from declaration-level axiom
   auditing (VerificationSurface);
9. you do not infer W from separate recurrence of Q and G;
10. you do not treat resource feasibility as sufficient for generation,
    validation, or retention;
11. you distinguish the external gradient from the internally generated
    response budget;
12. you distinguish physical slack from the dimensionless cumulative-accessibility
    margin;
13. you do not claim that retained novelty already causes the next organizational
    state transition.

OUTPUT FORMAT

Begin with the access report and resolved file paths.

Then give:

A. FORMAL CHAIN RECONSTRUCTION
B. VERIFIED STRENGTHS
C. POSSIBLE DEFECTS
D. SCOPE LIMITATIONS / FUTURE WORK
E. PRIOR-LITERATURE POSITIONING
F. VERIFICATION STATUS
G. BOTTOM LINE

For every possible defect use:

CLAIM:
SOURCE / THEOREM:
ASSUMPTIONS:
LOGICAL FORM:
PROBLEM:
COUNTEREXAMPLE OR FAILURE MODE:
CLASSIFICATION:
SEVERITY: low / moderate / high / fatal
SUGGESTED TEST OR FIX:

A successful falsification is a contribution. Prior art is a result. Review the
smallest thing you can break.
```
