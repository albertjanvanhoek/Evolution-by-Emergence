# Formal-core peer-review prompt

Use this prompt with an LLM that can inspect GitHub. The default review object is the immutable **v15** release.

```text
Act as an adversarial scientific peer reviewer of the tagged v15 release of:

https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/v15

Your task is to test the formal-core claims, not to defend or attack the broader philosophy of Evolution by Emergence.

ACCESS GATE — DO THIS FIRST

Before reviewing, report:

REPOSITORY ACCESS: yes / no
TARGET VERSION: v15 / other / unknown
SOURCE-FILE ACCESS: yes / no
LEAN EXECUTION: yes / no
LITERATURE SEARCH: yes / no

SOURCE-FILE ACCESS may be reported as "yes" only after you have successfully
opened RELEASE_NOTES.md at v15 and at least one exact Lean source from the
core-file list below. Access in principle is not the same as successful source
resolution.

If you cannot access the repository or supplied source files, STOP.
Do not substitute a generic review of evolutionary theory, emergence,
open-ended evolution, cybernetics, artificial life, or cooperation.
Do not invent likely source files, theorem names, assumptions, weaknesses,
prior literature, or severity ratings.

If you review a version other than v15, report the exact commit SHA and say
explicitly that you are reviewing a different repository state.

CORE FILES — USE THESE EXACT v15 PATHS

RELEASE_NOTES.md
RESEARCH_GUIDE.md
formalization/cumulative-accessibility/README.md
formalization/cumulative-accessibility/CumulativeAccessibility/FormalCoreWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceGatedWitness.lean
formalization/cumulative-accessibility/CumulativeAccessibility/MaintenanceOpportunityBridge.lean
formalization/cumulative-accessibility/CumulativeAccessibility/ValidatedUptake.lean
formalization/cumulative-accessibility/CumulativeAccessibility/OpenEndedCapacity.lean
formalization/cumulative-accessibility/CumulativeAccessibility/FiniteGenerativeSaturation.lean
formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeClosure.lean

FILE-RESOLUTION RULE

Do not infer that a file is absent because it is not in the first directory you
inspect. The core Lean files are nested under:

formalization/cumulative-accessibility/CumulativeAccessibility/

Before reporting a named source as missing:

1. try the exact v15 path supplied above;
2. if that fails, search the v15 repository recursively by filename and a
   distinctive theorem/definition name;
3. inspect imports and the package README;
4. distinguish "I could not resolve this file with my available tools" from
   "this file does not exist".

Never ask the human for a path already supplied in this prompt.

Before beginning scientific analysis, report:

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

The v15 verification contract explicitly builds:

CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness

and checks the printed theorem axioms for sorryAx. If you can execute Lean,
reproduce this rather than relying only on the badge.

SCIENTIFIC TASK 1 — RECONSTRUCT THE FORMAL CHAIN

Reconstruct the exact implication chain:

strict recurrent maintenance conditions
        -> recurring maintenance opportunity
        + opportunity-conditioned validated realization
        + retention
        -> validated generative uptake
        -> open-ended cumulative retained novelty
        + representation inside a moving envelope
        -> unbounded effective distinguishability capacity

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

SCIENTIFIC TASK 5 — TEST THE MAINTENANCE BRIDGE

Inspect MaintenanceOpportunityBridge.lean and the maintenance dynamics it
imports.

Check whether the concrete strict three-cycle result really supplies recurring
opportunity under the stated assumptions, and whether novelty still requires a
separate response premise.

Confirm that recurring opportunity alone is not asserted to imply novelty.

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
- determine exactly what dependency statement follows and what causal claims do
  not follow.

SCIENTIFIC TASK 7 — AXIOM AUDIT

If you can execute Lean, run:

cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build CumulativeAccessibility.FormalCoreWitness CumulativeAccessibility.MaintenanceGatedWitness
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean

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
7. you distinguish the original non-vacuity witness from the newer gated
   dependency witness.

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
