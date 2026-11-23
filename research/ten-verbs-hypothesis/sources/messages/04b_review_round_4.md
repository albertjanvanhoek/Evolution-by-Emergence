# Review, round 4: of version 0.4

The reviewing assistant's reply to [04_v0_4_full_message.md](04_v0_4_full_message.md), 20 November 2026. Verbatim. It led to the author's request "Please build the simulation in the EbE repo." The literature named was named from general knowledge and has not been checked. Index: [README.md](README.md).

---

# Adversarial review, round 4: version 0.4

**Bottom line:** v0.4 finally takes a real risk. The other model's worry at the end (that the verbs may be stages of one process rather than separate components) is the right one, and it can be settled. But there are three problems that a demanding reviewer would raise first:
- the matrix discriminates less than it seems to
- most of P1–P5 are true by how the experiments are built
- the "simpler alternatives" are never named, and the obvious ones already exist

## 1. Half the matrix rows can't be told apart

Look at the rows across R/L/C/F:
- **Uniform rows:** Change (↓↓ ↓↓ ↓↓ ↓), Remember/let go (↓\* ×4), Take care (↓\* ×4) and Find new ways (↓↓\* ↓\* ↓\* ↓\*) predict "impairs everything." That pattern looks the same as a general learning-capacity factor.
- **Near-identical pairs:** Stay open (↓ ↓ ↓↓ ±) and Be honest (↓ ↓ ↓↓ ↓) almost match. Share and Repair are identical apart from the asterisk.
- **Escape hatches:** every **±** is consistent with any result, and every **\*** postpones the prediction to some condition.

The conditions in §3 point to the real structure. Some verbs separate by **route** (Try, Share, Notice). Others separate by **environment**:

| Verb | Condition that should expose it |
|---|---|
| Remember / let go | Stable vs. changing environment |
| Take care | Plentiful vs. scarce resources |
| Find new ways | Adequate vs. blind methods |
| Repair | Intact vs. disrupted channels |

So the prediction needs two axes: verb × route *and* verb × condition. Say outright that there are two kinds of component, and replace each ± with a direction tied to a stated condition. P6 already gives one: positive in adversarial networks, negative in cooperative ones.

## 2. P1–P5 are mostly guaranteed by the setup

- **P1:** reducing testing hurts test-based correction more than testimony-based correction. The manipulation *is* the route, so this will pass.
- **P3:** Repair is defined as recovery after disruption, so it can only matter after disruption.
- **P4:** new methods help more when existing methods are blind. Also true by definition.

These are good manipulation checks, but not risky predictions. Only one line in v0.4 can actually fail: *"outperforms specified simpler alternatives on held-out tasks."* Yet the alternatives are never specified.

## 3. The competing models already exist

A reviewer will map most of the verbs onto parameters in standard computational models of learning, from reinforcement learning and Bayesian or hierarchical-Gaussian-filter models of the kind used in computational psychiatry:

| Verb | Existing parameter |
|---|---|
| Try | Exploration / directed information-seeking |
| Notice | Sensory or likelihood precision |
| Change | Learning rate |
| Remember / let go | Volatility estimate, forgetting rate |
| Stay open | Prior precision; weight given to social information |
| Take care | Sampling or effort cost |
| Find new ways | Structure learning / expanding the model |
| **Be honest** | *nothing standard* |
| **Share (with provenance)** | *nothing standard* |
| **Repair** | *nothing standard* |

This changes the story. The verbs for individual learning probably add little to models that already exist, and the new content sits in **Be honest, Share and Repair**, which are the relational verbs. So the relational hypothesis isn't an extra to protect. It is where the theory is new. I'd reorganize around that.

Name at least three competing models and register them in advance:
- **M1:** one general learning factor.
- **M2:** a Bayesian or RL agent with a social-weight parameter, roughly 5–6 parameters.
- **M3:** a three-tier model: a core loop (Try, Notice, Change, Remember/let go); a social layer (Stay open, Be honest, Share, Repair); and maintenance and method (Take care, Find new ways). This is roughly the stages-vs-components alternative from the paste.

Then the ten-verb model has to beat M2 and M3 on held-out data.

## 4. Check identifiability before running any experiment

With ten parameters, several will trade off against each other. A slow learning rate and low noticing sensitivity can produce the same behaviour. Before any knockout study, run a **parameter recovery** test:
1. Simulate agents with known verb settings.
2. Fit the model to their behaviour.
3. Check whether the ten values come back out separately.

If they don't, no experiment can separate them, and the ten-way claim fails in silico at almost no cost. This is also the answer to the trap the paste correctly names (agents built around the ten verbs will trivially show them). Recovery tests whether the *task* can tell the verbs apart, not whether the software can.

## 5. Smaller points

- **"Substrate-independent" needs measurement invariance:** you have to show that the same measure captures the same function in LLMs, humans and algorithms. Otherwise comparisons across substrates are like comparing apples and oranges.
- **Measuring "Be honest" in humans:** you can't selectively impair it, so for people it may be only observable, not manipulable. That's fine, but say so.
- **The three-agent relational experiment is the best design here.** Measuring "can each represent the other's position" separately from agreement is a strong outcome measure. Watch the statistical power: four information conditions × three outcomes needs a lot of agent pairs.

## Recommended v0.5

1. Make the matrix two-dimensional: route and condition. Replace each ± with a stated direction.
2. Name M1–M3 and treat beating them as the main test.
3. Make the relational verbs (Be honest, Share, Repair) the stated new contribution.
4. Run the parameter-recovery simulation before anything else.

Step 4 is cheap, quick, and could kill the claim. That's the right first experiment. If you want, I can build that simulation in the EbE repo.
