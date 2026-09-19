# Literature positioning

## Status

Targeted positioning note for a new universal paper. **Closest-prior-art audit updated 19 September 2026.** This remains a targeted rather than exhaustive systematic review.

The candidate contribution is **not** the discovery of function,
multifunctionality, evolvability, neural repertoire, causal organization, or
innovation rate.

The candidate contribution under review is the conjunction:

```math
\boxed{
\text{organization/function type separation}
+
\text{functional cost geometry}
+
\text{retained target-wise ratchet velocity}
+
\text{matched-step ratchet acceleration}
}
```

inside the broader Evolution by Emergence retention/resource architecture.

## 1. Ecosystem multifunctionality

Ecology already studies the capacity of ecosystems to provide multiple
functions simultaneously. A major literature also debates how those functions
should be selected and whether aggregation into one multifunctionality index is
scientifically justified.

Closest relevance:

- the object of interest is explicitly a multi-function repertoire;
- different functions can respond differently to the same biodiversity or
  network change;
- scalar aggregation can hide trade-offs and target-selection assumptions.

Relationship to the present framework:

The present proposal keeps the primitive quantity vector-valued: a cost profile
over declared functional targets. Ecosystem multifunctionality can therefore
be treated as one possible ecological scalarization or projection of a richer
functional geometry.

Key references to retain in the manuscript:

- Byrnes et al. (2014), *Methods in Ecology and Evolution*.
- Manning et al. (2018), *Nature Ecology & Evolution*.
- Garland et al. (2021), *Journal of Ecology*.

## 2. Functional diversity and niche differentiation

Functional-diversity research distinguishes species identity/count from the
traits and ecological roles through which organisms contribute to ecosystem
processes.

Relationship:

This is close to the proposed intuition that a commons can become more
functionally differentiated without a simple increase in component count.

The paper should not equate functional diversity with ratchet velocity.
Functional diversity describes a state/property; ratchet velocity describes a
retained change in the cost profile of functional realization.

## 3. Functional information and increasing functional information

Hazen, Griffin, Carothers and Szostak (2007) define functional information for
a specified function and degree of function as

```math
I(E_x)=-\log_2 F(E_x),
```

where `F(E_x)` is the fraction of possible system configurations achieving
function at least at level `E_x`. Functional information therefore measures
the rarity/information content of function-achieving configurations in a
declared ensemble.

Wong et al. (2023) broaden this direction and propose a "law of increasing
functional information": systems containing many possible configurations can
increase functional information when configurations undergo selection for one
or more functions.

These are major antecedents and should be central to the positioning of the
present paper.

**Relationship to the present framework**

The objects are related but not identical.

Functional information asks, for a function and performance threshold, how
rare qualifying configurations are in an ensemble:

```math
\text{ensemble rarity of function-achieving configurations}.
```

The present functional performance-cost geometry asks, for the actual current
organization `s` and a family of declared functional targets, the resource
cost of reliably performing each target:

```math
f\mapsto C^{\mathrm{perf}}(s,f).
```

Its velocity is the time/resource-normalized change of that current-system
profile.

Thus:

```math
I(E_f)
\neq
C^{\mathrm{perf}}(s,f)
\neq
\frac{\Delta C^{\mathrm{perf}}(s,f)}{\Delta t}.
```

Functional information may nevertheless become an important complementary
coordinate. For example, it can characterize target difficulty or the rarity
of organizations attaining a declared performance threshold, while the present
cost profile characterizes the realized organization's current capability.

The paper should therefore not claim to introduce function as a universal
coordinate of evolution, nor that function tends to increase in evolving
systems. Its candidate contribution is the state-conditioned,
multi-target, resource-sensitive **rate geometry** and its bridge to retained
organization and intelligent learning.

Key references:

- Hazen, Griffin, Carothers & Szostak (2007), *PNAS*, "Functional information
  and the emergence of biocomplexity", doi:10.1073/pnas.0701744104.
- Wong et al. (2023), *PNAS*, "On the roles of function and selection in
  evolving systems", doi:10.1073/pnas.2310223120.

## 4. Neural functional repertoire and expertise

Neuroscience already documents structural and functional reorganization during
skill acquisition and expertise. Network models of the connectome explicitly
use the term *functional repertoire* for the set/diversity of functional
configurations supported by structural organization.

A particularly close antecedent is Senden et al. (2014), who model how rich-club
network architecture supports a larger and more diverse functional repertoire.

Relationship:

This strongly supports separating physical structure from the repertoire of
functions it supports. The present proposal differs by making the cost of
realizing declared functional targets, and the retained change of that cost,
the primitive object.

Relevant references:

- Chang (2014), *Frontiers in Human Neuroscience*.
- Senden et al. (2014), *NeuroImage*.
- Yin et al. (2009), *Nature Neuroscience*.


## 5. Cybernetics and requisite variety

Ashby's law of requisite variety is a major antecedent for any claim linking
adaptive capacity to the repertoire of possible responses. A regulator must
possess sufficient variety relative to the disturbances it must control.

Relationship:

The present paper should not claim that adaptive systems require a repertoire
of responses. The proposed distinction is that raw response variety is not yet
functional ratchet velocity. The latter is target-conditioned, resource-
sensitive, retention-sensitive, and explicitly dynamic: it asks how the cost
profile of reliable functions changes through time.

Ashby's variety is therefore a conceptual ancestor for the repertoire side of
the theory, while the cost geometry and retained velocity are the candidate
extensions.

Key reference:

- W. Ross Ashby (1956), *An Introduction to Cybernetics*.

## 6. Form/function degeneracy in regulatory networks

Payne and Wagner (2015) exhaustively studied small gene-regulatory circuits and
showed that circuit form does not uniquely determine function, and that the
same function can be realized by multiple circuit structures. They explicitly
describe the set of functions a circuit can realize as its functional
repertoire.

Relationship:

This is particularly close to the present structure/function separation. It
argues strongly against treating topology alone as the moving quantity.

The proposed framework adds an operational cost to realizing functions and then
asks how retained organizational change alters that cost profile and its rate
of change.

Key reference:

- Payne & Wagner (2015), *Scientific Reports*, "Function does not follow form
  in gene regulatory circuits".

## 7. Causal emergence and effective information

Effective-information approaches quantify causal organization by perturbing
system states and asking how selectively and deterministically states constrain
future states. Work on causal emergence shows that a macro description can
sometimes carry more effective information than a micro description.

Relationship:

This is an important neighboring formalism because it treats organization as
causal structure rather than raw component count.

It is not identical to the present proposal. Effective information measures
properties of the system's transition structure; functional ratchet velocity
is target-conditioned and resource-sensitive. A system could have high
effective information yet be poor at a declared function, or acquire a new
functional capability without a simple monotonic change in effective
information.

Relevant references:

- Hoel et al. (2013), *PNAS*.
- Klein & Hoel (2020), *Complexity*.

## 8. Evolvability

Evolvability research studies the capacity of biological systems to generate
heritable, evolutionarily relevant variation and has long emphasized the role
of genotype-phenotype organization, modularity, integration, and mechanisms
that alter future variation.

Relationship:

Evolvability is a close biological antecedent for a present organization
changing future adaptive possibilities. The present framework should not claim
that the rate or capacity of future evolution is new.

The narrower proposed bridge is to express future functional possibilities as a
directed cost profile, preserve trade-offs instead of collapsing them
immediately, and define ratchet velocity as the retained change of that profile.

Key references:

- Wagner & Altenberg (1996), *Evolution*.
- Earl & Deem (2004), *PNAS*.
- Draghi & Ogbunugafor (2022), *Journal of Experimental Zoology B*.
- Barnett, Meister & Rainey (2025), *Science*.

## 9. Stability-plasticity and exploration-exploitation trade-offs

The stability-plasticity dilemma is established in both biological and
artificial learning systems. Learning requires enough plasticity to incorporate
new information while sufficient stability is needed to preserve prior
function. Excess plasticity can produce forgetting; excess stability can block
new learning. Related exploration-exploitation literatures likewise study the
allocation of effort between generating alternatives and exploiting or
evaluating what has already been found.

Relevant antecedents include:

- Mermillod et al. (2013), *Frontiers in Psychology*, "The
  stability-plasticity dilemma: investigating the continuum from catastrophic
  forgetting to age-limited learning effects".
- Ajemian et al. (2013), *PNAS*, "A theory for how sensorimotor skills are
  learned and retained in noisy and nonstationary neural circuits".
- the broader continual-learning literature on catastrophic forgetting and
  stability-plasticity control.

**Relationship to the present framework**

The present work does not claim the stability-plasticity trade-off as new.

Its reduced search-validation model instead serves as an exact bridge into the
ratchet-velocity ledger. Ceteris-paribus, increasing generation or validation
raises ledger velocity. Under a shared unit constraint, however,

```math
p_G=x,
\qquad
p_V=1-x,
```

so

```math
v(x)=x(1-x).
```

This creates an interior optimum and proves that monotonicity of individual
ledger coordinates does not survive arbitrary coupling among those
coordinates.

The scientific question for real systems is therefore not whether
plasticity/stability trade-offs exist, but how substrate-specific mechanisms
map onto the rate coordinates and where their joint optimum lies.

## 10. Capability-development rate, adaptation speed, and cumulative cultural acquisition cost

Capability-development research already treats organizational capability as a trajectory with an explicit **rate of improvement**. Rockart and Dutt (2015) formalize capability-development trajectories in which firms differ both in the rate at which they close the gap between current and potential capability and in the potential capability level itself. This is a close antecedent to any claim that retained organization has a measurable development velocity.

Evolutionary theory likewise has mature rate concepts. Population-genetic and quantitative-genetic models study rates of fitness or trait change; traveling-wave models derive speeds of adaptation under mutation and selection; related work derives rate limits for evolutionary change.

Cumulative-cultural-evolution models also study the cost of acquiring inherited knowledge. Mesoudi (2011), for example, models cultural acquisition costs that increase with accumulated cultural complexity and can eventually constrain further cumulative innovation. Such models also consider innovations that reduce acquisition or innovation costs.

**Relationship to the present framework**

These literatures mean the present paper must not claim that capability development has a rate, that evolution has a speed, or that acquisition cost constrains cumulative evolution as new.

The current EbE split is instead:

```text
7A: acquisition/transition cost of reaching future organization
7B: current performance cost of realized functions
7B-rate: retained change of the multi-target performance-cost profile
```

Population-genetic adaptation speed commonly tracks fitness or trait change.
The proposed ratchet velocity is target-conditioned and can remain vector-
valued across multiple functional targets rather than collapsing immediately to
fitness.

Cultural acquisition-cost models are especially relevant to Layer 7A and may
provide strong application models for how inherited complexity raises or lowers
future acquisition cost. They should be used as antecedents when the EbE
framework is applied to science, technology, or cumulative culture.

Relevant references:

- Rockart & Dutt (2015), *Strategic Management Journal*, "The rate and potential of capability development trajectories", doi:10.1002/smj.2202.
- Queller (2017), *The American Naturalist*, on fundamental evolutionary
  theorems and rates of selection response.
- traveling-wave / clonal-interference work on the speed of adaptation in
  asexual populations.
- García-Pintos (2024), *Scientific Reports*, on evolutionary rate limits for
  quantitative traits.
- Mesoudi (2011), *PLOS ONE*, "Variable cultural acquisition costs constrain
  cumulative cultural evolution."

## 11. Bottleneck allocation, water-filling, and path dependence

Resource allocation to bottlenecks is a classical problem in operations
research, production, communications, and network throughput. Water-filling and
max-min/bottleneck-aware allocation methods explicitly redirect limited
resources toward constrained stages. Production-function optimization likewise
studies optimal input allocation under fixed budgets.

Organization and innovation research separately contains mature literatures on
path dependence, dynamic capabilities, absorptive capacity, and the idea that
accumulated capabilities shape subsequent investment and innovation.

Relevant antecedents include:

- classical water-filling and constrained resource-allocation results;
- bottleneck-aware service-process allocation that seeks to equalize or
  approximately equalize stage service rates;
- Cobb--Douglas and related production-function allocation results;
- Schreyögg & Sydow (2011) on organizational path dependence;
- Vergne & Durand (2011) on path dependence and dynamic capabilities;
- Nerkar & Paruchuri (2005) on path-dependent evolution of R&D capabilities;
- Redding (2002) on path-dependent endogenous innovation and the pace of
  future technological change.

**Relationship to the present framework**

The present paper does not claim bottleneck equalization, water-filling, or
path-dependent capability accumulation as new.

Its narrower use of these results is to connect them to the functional-ratchet
state:

```math
\text{retained organization}
\to
\text{rate-producing response functions}
\to
\text{optimal next allocation}
\to
\text{new retained organization}.
```

The Lean two-baseline witness makes this dependence explicit. In the interior
regime the next unit of resource equalizes final search and validation
capacities; sufficiently large inherited imbalance moves the optimum to a
boundary where the whole new unit is allocated to the bottleneck.

The candidate contribution is therefore not the optimizer. It is the
cross-domain architecture in which **organization is simultaneously retained
functional capacity and a state variable that reshapes the velocity landscape
of subsequent adaptation**.

## 12. Relation to the intelligent-network paper

The companion paper on learning-maintenance processes should now be read as an
inside specialization.

For intelligent systems, functional targets may be tasks, discriminations,
predictions, explanations, skills, or other operational capabilities.

Knowledge and understanding are not assumed to be directly visible in static
structure. They are inferred through reliable counterfactual performance under
appropriate probes and environments.

The central experimental quantity is then learning velocity on held-out
functional targets under matched resource/time windows.

Recursive self-improvement becomes the stronger claim that an endogenous change
to the learning-maintenance process raises that future learning velocity.

## Working novelty boundary

The paper may currently claim:

1. a formal separation between organization-state type and functional-target
   type;
2. a target-indexed, directed cost geometry for functional realization;
3. a vector-valued definition of retained ratchet velocity;
4. a matched-step definition of ratchet acceleration;
5. a threshold theorem connecting positive velocity to strict functional
   repertoire expansion;
6. a cross-domain programme in which scalar "organization" measures are treated
   as declared projections rather than primitives.

The targeted closest-prior-art audit did not identify a source containing this exact conjunction. That is a provisional search result, not proof of absence; the paper should claim the conjunction as its proposed synthesis/formalization rather than claim exhaustive priority.
