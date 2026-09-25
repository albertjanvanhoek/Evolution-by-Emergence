# Organization-driven emergence — synthesis target

**Status:** research branch; candidate successor to the v17/v18 causal core.

## Why this branch exists

The repository accumulated several formally correct but semantically different
routes to the same intended idea:

- recursive accessibility and SecondOrderClick;
- retained promotion and generative closure;
- compositional emergence;
- Dynamic Vortex maintenance/resource support;
- repertoire-dependent generator change.

Adversarial review exposed an important drift: later attempts began treating
capacity labels as objects that had to be promoted, certified, or endowed with
operators before they could affect the future.

That is not the intended ontology of Evolution by Emergence.

The present synthesis therefore returns to organization itself.

## Core statement

A configuration has whatever functions its organization realizes.

Nothing authorizes those functions.

Persistence determines only whether that organization remains available to
become material for what comes next.

The intended causal chain is:

    retained organization
      -> parts assemble a new whole
      -> the whole realizes a function
      -> proper parts do not realize that function
      -> the organization may persist or disappear
      -> if it persists, the whole remains reusable material
      -> every function it realizes remains available through that whole
      -> later organization/accessibility may change.

In compact form:

    organization -> function
    organization + persistence -> reusable organization
    reusable organization -> material for later organization.

## Emergence

For organization x, context c, and function phi:

    Emergent(x,c,phi)
      iff
    Realizes(x,c,phi)
      and
    no declared proper part of x realizes phi in c.

Emergence therefore answers an attribution question:

> Which organization realizes the function?

It does not mean:

- the function was unpredictable;
- the function is historically novel;
- the function is beneficial;
- the function is persistent;
- the function is externally approved;
- the underlying physical or computational laws changed.

Those remain separate propositions.

## Persistence is downstream

The formalization now separates:

    EmergentOrganizationAt

from:

    EmergentOrganizationPersistenceAt.

The first contains construction and emergence only.

The second adds a resource/selection persistence gate and a retention law.

Therefore the theory can state explicitly:

    function exists
      AND
    persistence fails.

That organization may disappear, but its function was still real while the
organization existed.

This is the intended role of selection/resource constraints.

## Functional vocabulary

Persistence can have a stronger consequence when the retained whole realizes a
function that no previously retained organization realizes.

Define:

    FunctionallyNovelToRetainedSystem(phi)

when no currently retained organization realizes phi.

Then a retained emergent whole with such a function strictly expands the
system's currently available functional vocabulary.

No certification variable is required:

    whole persists
      + whole realizes phi
      -> phi is functionally available.

This is the strong vocabulary-emergence case.

## Accessibility

Three notions remain distinct.

1. **Immediate/one-step access.**
   Retaining organization can make a fixed construction relation usable in new
   ways simply because new material is present.

2. **Bounded-depth/resource access.**
   Retained intermediates may shorten or cheapen later construction.

3. **Full multi-step reach.**
   A retained organization can enlarge full reach when the functions realized
   by that retained organization participate in the fixed Use law and thereby
   enable an organization outside the previous reach.

The fixed-rule P9 boundary is retained:

    if organization x was already reachable under a fixed construction
    relation, merely promoting x to primitive material cannot enlarge the full
    transitive closure of that same fixed relation.

This is not a contradiction.  The full organization-driven model contains
fixed laws Base, Realizes, and Use.  Retaining a new organization changes the
state to which those fixed laws apply.  Its intrinsic functions can therefore
change the **effective** construction relation without any mutation of the
underlying law.

## Context and expressed function

Context remains explicit in:

    Realizes organization context function.

This permits the same retained organization to express different effective
function in different contexts while the organization and underlying laws
remain fixed.

The research probe
`same_retained_organization_context_changes_expressed_function`
exists specifically to prevent the formal theory from identifying every change
in expressed capability with generator mutation.

This distinction is consistent with the conceptual lesson drawn from:

Chen, Q., Qin, L., Liu, J., et al. (2025).
*Electronic Circuit Principles of Large Language Models*.
arXiv:2502.03325v2.

The paper is not treated as evidence for EbE's evolutionary claims.  Its
relevance here is narrower: effective capability can depend on current
organization/context without parameter or fundamental-rule change.

## Recursive reuse

The temporal layer distinguishes:

1. `OrganizationEmergenceChain`:
   one explicit lineage in which a retained emergent organization becomes a
   causal parent of the next organization;

2. `RecurringEmergentOrganizationPersistence`:
   emergent organizations persist arbitrarily late, without asserting one
   lineage;

3. `RecurringRetainedVocabularyEmergence`:
   arbitrarily late retained emergent organizations add functions absent from
   the previously retained system.

The ladder witness instantiates both linked reuse and arbitrary-late recurrence.

## Positive ladder

At time t the system contains reusable organizations:

    0, 1, ..., t+1.

The fixed assembly law combines:

    {t, t+1} -> t+2.

The whole t+2 realizes function t+2.

Its declared proper parts t and t+1 do not.

After persistence, organization t+2 remains available and its function is
automatically available.  A fixed Use law can then use that function to produce
a downstream product that was outside the old full reach.

The retained organization t+2 is also a parent in the next assembly event.

Thus the witness has the intended form:

    organization
      -> emergent function
      -> persistence
      -> reuse
      -> later organization.

## Non-emergent twin

The negative control is intentionally different from the rejected certification
model.

In the non-emergent twin:

- the whole **still realizes the function**;
- a retained proper part already realizes that same function;
- therefore the function is already available before the whole persists;
- the whole adds no new functional vocabulary.

So non-emergence does not turn function off.

It changes attribution and novelty.

That is the required regression test.

## Dynamic Vortex/resource layer

The endogenous uptake-minus-maintenance budget is attached only to persistence.

It does not appear in Realizes or EmergentUnder.

Therefore:

    insufficient resources
      -> organization may fail to persist

does **not** imply:

    insufficient resources
      -> the organization never had the function.

Recurring opportunity plus successful persistence of emergent vocabulary events
can still feed the existing open-ended retained-organization results.

## Abandoned route

The experimental certification/operator files were removed from the branch.

The reason is conceptual, not merely terminological.

That route made effective function depend on a separate provenance/permission
state.  It therefore risked replacing:

    organization -> function

with:

    capacity label -> certification -> allowed operator.

The latter may be a useful model for some institutional or software systems,
but it is not the intended universal EbE core.

## Current formal milestones

The candidate must machine-check all of the following.

1. Function follows from emergent organization before persistence.
2. A failed persistence gate can remove the organization without denying its
   function.
3. Persistence automatically makes every realized function of the whole
   available.
4. If that function was absent from all previous retained organization,
   functional vocabulary strictly expands.
5. If a use of the retained function reaches something outside old full reach,
   organizational accessibility strictly expands.
6. Fixed-rule promotion of an already-reachable organization does not enlarge
   full closure.
7. Linked recursive reuse is distinct from arbitrary-late recurrence.
8. The infinite ladder witnesses recurrence and open-ended retained
   organization.
9. The non-emergent twin still functions but is not functionally novel.
10. Context can change expressed function without changing retained
    organization or fundamental laws.
11. The endogenous resource budget affects persistence only.

## Remaining scientific seams

Lean cannot determine whether an empirical mapping has chosen the correct:

- organization/configuration;
- proper-part relation;
- context;
- realization relation;
- functional-use law;
- persistence criterion;
- observational granularity.

Those are scientific modelling claims.

The formalization is useful precisely because it makes them visible rather than
hiding them inside a generic success predicate.
