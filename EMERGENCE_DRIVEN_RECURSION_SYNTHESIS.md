# Emergence-driven recursion — synthesis target

**Status:** research branch; not part of the frozen v17/v18 canonical core.

## Why this branch exists

The 21 September adversarial review showed that the repository had accumulated
several correct but semantically different approaches to the same intended
idea.

- RecursiveAccessibility.lean, ModuleGeneratedEvolvability.lean, and
  GeneratorRuleEvolution.lean formalized second-order changes in future
  accessibility, but did not require compositional emergence.
- DynamicVortex.lean composed validated retained response with a
  SecondOrderClick, but kept their coupling as an explicit modelling premise
  and likewise did not require compositional emergence.
- RecursiveEmergence.lean and ConstructiveRecursiveEmergence.lean introduced
  compositional emergence, filtering, retention and explicit parent reuse, but
  the later promotion route established mainly one-step generated access rather
  than change in full transitive generative closure.

The synthesis target is therefore not another parallel model. It is one
reviewable causal chain in which emergence and future-access change are present
at the same time.

## Target statement

The intended architecture is:

    existing retained organization
      -> parent set constructs an organization
      -> that same parent organization realizes an emergent capacity
      -> resource / validation filters
      -> retained integration
      -> operational reuse
      -> changed generative accessibility
      -> later parent set constructs another emergent organization

The strong form additionally requires:

    retained emergent organization
      -> change in repertoire-dependent generative rule
      -> strict expansion of full multi-step generative closure.

## Three notions of accessibility

The review exposed a distinction that must remain explicit.

1. One-step access: what the present repertoire can generate in one application
   of a rule.
2. Bounded access / generative distance: what can be reached under a finite
   depth, time or resource budget.
3. Full closure: what can be reached after arbitrarily many applications of the
   same fixed rule.

Retaining a generated intermediate may improve (1) and (2) while leaving (3)
unchanged.

Therefore the synthesis treats two ratchets separately.

### Operational ratchet

A retained emergent product becomes a reusable primitive. Holding the next rule
fixed, this can strictly expand one-step access or reduce generative distance.

### Vocabulary ratchet

The retained organization changes the rule by which later organization is
constructed. The strong test is strict expansion of full generative closure.

## P9 as a design constraint

The reviewer proved:

    fixed generator
    + child already generated from current repertoire
    + promote child to primitive
      -> no expansion of full transitive closure.

The synthesis imports this result into the core semantics. Fixed-rule promotion
is not called vocabulary emergence merely because it changes one-step
generability.

## Parent-faithful emergence

The generic constructive interface remains useful, but it permits a build rule
that ignores the configuration argument. The synthesis therefore adds an
optional stronger specialization:

    configuration = finite causal parent set
    proper subconfiguration = proper parent subset.

Under this specialization, the object tested by EmergentUnder is literally the
same parent organization used by the generator.

This is intentionally strong and optional. Applications with richer
configuration semantics may later supply a more general faithful
parent-to-subconfiguration map.

## Repertoire-dependent generator

The strong vocabulary route introduces:

    RuleOf : retained repertoire -> HyperGenerator

so that the time-indexed rule is not an independent input:

    H_t = RuleOf(S_t).

For causal attribution, the first strong event additionally requires isolated
integration:

    S_(t+1) = S_t union {child}.

The toy witness can therefore ask whether that retained emergent product alone
changes the rule and full closure.

## First machine-check milestone

The first milestone is deliberately finite, not asymptotic.

Lean should check a concrete two-generation example in which:

1. existing parts a,b construct their own parent configuration;
2. the whole {a,b}, but no proper subset, realizes c;
3. c is feasible, validated and retained;
4. retaining only c changes the repertoire-dependent generator;
5. a capacity d outside the old full closure enters the new full closure;
6. retained c is explicitly used in {b,c};
7. {b,c}, but no proper subset, realizes emergent d.

Only after this finite causal chain is checked should the work be lifted back
into open-ended recurrence and Dynamic Vortex resource/maintenance results.

## Non-claims

The synthesis does not claim:

- every emergent capacity is retained;
- every retained capacity changes future accessibility;
- every retained capacity changes the generator;
- one-step access expansion is full vocabulary expansion;
- compositional emergence by itself implies progress or value;
- the toy witness is an empirical model;
- open-ended recurrence follows without an explicit continuation mechanism.

## Review gates

Before this branch can replace or supersede the v17 core, reviewers should try
to falsify at least the following.

1. Can a parent-faithful event still attach emergence to an unrelated
   configuration?
2. Can a constant generator satisfy the strong vocabulary-expansion event?
3. Can the two-generation witness produce the second emergent product without
   the first retained child?
4. Does the claimed old/new closure difference survive direct induction?
5. Is the rule change genuinely a function of retained repertoire, or merely
   correlated with it by time index?
6. Are emergence, retention, operational access and closure expansion still
   separable by counterexamples?

The branch should remain a research object until those gates and Lean CI are
green.
