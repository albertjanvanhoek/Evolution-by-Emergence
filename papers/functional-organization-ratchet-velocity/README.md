# Functional Organization and Ratchet Velocity

Working universal theory paper in the Evolution by Emergence programme.

## Core question

What is the quantity that moves when a retained network becomes "more
organized", and what determines the rate at which that organization
accumulates?

The proposed answer deliberately does **not** identify organization with node
count, edge count, entropy, connectivity, or a universal scalar complexity
measure.

Instead it separates:

- the **organization state** of a network or commons;
- the **functional targets** that organization can reliably realize;
- the **cost profile** of realizing those targets;
- the retained change of that profile through time.

The fundamental object is therefore a functional accessibility geometry.

For organizational state `s` and functional target `f`:

```math
C_t(s,f)
```

is the declared cost of reliably realizing `f` from `s`.

The functional repertoire available within budget `B` is:

```math
\mathcal F_t(B)=\{f:C_t(s_t,f)\le B\}.
```

The vector-valued one-step ratchet velocity is:

```math
v_t(f)=C_t(s_t,f)-C_{t+1}(s_{t+1},f).
```

Positive values mean that the function became cheaper to realize.

A strong positive ratchet step requires:

```math
v_t(f)\ge 0
```

for every declared retained target and

```math
v_t(f^\star)>0
```

for at least one target.

Acceleration compares two matched intervals and asks whether the second
velocity profile dominates the first.

## Why the organization/function split matters

A neural configuration is not the same type of object as "understand this
French sentence". An ecosystem state is not the same type of object as
"perform nitrogen cycling". A scientific institution is not the same type of
object as "detect this class of error".

The formal layer therefore separates organizational states from functional
targets rather than forcing both into one state space.

## Outside and inside

**Outside:** a network is described by the reliable transformations its
organization makes possible and by their costs.

**Inside:** an intelligent network can represent some of those capacities as
knowledge, understanding, skills, and methods, and can alter the processes by
which further capacities are acquired.

The outside paper is universal. The intelligent-network paper
`../learning-conditions-for-learning/` is a specialization.

## Formal source

`formalization/cumulative-accessibility/CumulativeAccessibility/FunctionalRatchetVelocity.lean`

The formal core keeps velocity vector-valued. Scalar summaries are
application-specific and must declare a target family and aggregation rule.

## Main review questions

1. Is functional cost a useful common object across biological, neural,
   ecological, technological, and social networks?
2. Is a target-indexed cost profile preferable to a universal scalar
   "complexity" measure?
3. Does retained cost reduction capture the intended ratchet more faithfully
   than raw structural change?
4. When can functional targets be operationalized independently of observer
   preference?
5. Under what conditions can velocity and acceleration be compared across
   intervals without confounding time, resource budget, or target difficulty?
6. Which existing literatures already contain equivalent cost-geometric or
   rate-of-ratchet formulations?

A counterexample, stronger antecedent, or failed operationalization is a useful
result.
