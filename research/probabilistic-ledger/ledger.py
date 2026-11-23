"""A probabilistic version of the learning ledger, beside LearningRatchet.lean.

The ledger in LearningRatchet counts wrong worlds kept possible: each costs
one unit per turn. An independent audit (D47) found that the count sets the
bill and that nothing invariant stands behind it. This script asks what
changes if misfit is measured by the log-loss of the actual world,
-ln q(w*), instead of by the count.

Five test cases, each comparing the count ledger with the log-loss ledger:
  1. splitting worlds;
  2. a false record, and one misleading honest observation;
  3. information from another learner (redundant, complementary, synergistic);
  4. a world that moves (retain, and let go);
  5. a wrong instrument.
Plus a property check: with a right instrument, the expected change in
ln q(w*) after one honest observation equals KL(p(x|w*) || q(x)) >= 0;
and a counterexample to reading zero expected gain as "the try tells no
worlds apart".

Standard library only. Deterministic: full enumeration of the finite models,
in floating-point arithmetic, and a fixed seed for the random property check. Run: python3 ledger.py
"""

from fractions import Fraction as F
from itertools import product
from math import log, comb, isclose, inf
import random

LINE = "-" * 72


# ---------------------------------------------------------------- helpers

def normalize(d):
    s = sum(d.values())
    return {k: v / s for k, v in d.items()}


def logloss(q, w):
    """-ln q(w); infinite if q(w) = 0."""
    return inf if q[w] == 0 else -log(q[w])


def kl(p, q):
    """KL(p || q) for dicts over the same keys; infinite if p > 0 where q = 0."""
    total = 0.0
    for k, pk in p.items():
        if pk == 0:
            continue
        if q[k] == 0:
            return inf
        total += float(pk) * log(float(pk) / float(q[k]))
    return total


def entropy(p):
    return -sum(float(v) * log(float(v)) for v in p.values() if v > 0)


def bayes(q, lik, x):
    """Posterior over worlds after outcome x; lik[w][x] = p(x | w)."""
    return normalize({w: q[w] * lik[w][x] for w in q})


def predictive(q, lik, outcomes):
    return {x: sum(q[w] * lik[w][x] for w in q) for x in outcomes}


def mutual_info(joint, a_idx, b_idx, cond_idx=()):
    """I(A;B | C) from a joint distribution given as {tuple: prob}.
    a_idx, b_idx, cond_idx are tuples of positions in the key tuple."""
    def marg(idx):
        m = {}
        for k, v in joint.items():
            kk = tuple(k[i] for i in idx)
            m[kk] = m.get(kk, 0) + v
        return m
    abc = marg(a_idx + b_idx + cond_idx)
    ac = marg(a_idx + cond_idx)
    bc = marg(b_idx + cond_idx)
    c = marg(cond_idx)
    na, nb = len(a_idx), len(b_idx)
    total = 0.0
    for k, v in abc.items():
        if v == 0:
            continue
        ka, kb, kc = k[:na], k[na:na + nb], k[na + nb:]
        total += float(v) * log(float(v) * float(c[kc]) /
                                (float(ac[ka + kc]) * float(bc[kb + kc])))
    return total


def nats_to_bits(x):
    return x / log(2)


# ---------------------------------------------------------------- case 1

def case1():
    print(LINE)
    print("CASE 1. Splitting worlds")
    print(LINE)
    q = {"A": F(1, 2), "B": F(1, 4), "C": F(1, 4)}  # A is the actual world
    count = sum(1 for w in q if w != "A" and q[w] > 0)
    print(f"Coarse worlds A (actual), B, C with q = 1/2, 1/4, 1/4.")
    print(f"  count misfit = {count}, log-loss = {logloss(q, 'A'):.4f} nats")

    k = 10
    q_split = {"A": F(1, 2), "C": F(1, 4)}
    for i in range(k):
        q_split[f"B{i}"] = F(1, 4) / k
    count_s = sum(1 for w in q_split if w != "A" and q_split[w] > 0)
    print(f"Split B into {k} sub-worlds, total mass kept at 1/4:")
    print(f"  count misfit = {count_s}, log-loss = {logloss(q_split, 'A'):.4f} nats"
          "  (count changes, log-loss does not)")

    # a learning turn that rules out B (all of it)
    q_after = normalize({w: v for w, v in q.items() if w != "B"})
    q_split_after = normalize({w: v for w, v in q_split.items() if not w.startswith("B")})
    gain = logloss(q, "A") - logloss(q_after, "A")
    gain_s = logloss(q_split, "A") - logloss(q_split_after, "A")
    print("A turn that rules out B:")
    print(f"  count gain: 1 unsplit, {k} split")
    print(f"  log-loss gain: {gain:.4f} unsplit, {gain_s:.4f} split  (= ln 4/3 = {log(4/3):.4f})")
    assert isclose(gain, gain_s) and isclose(gain, log(4 / 3))

    # splitting the actual world
    m = 4
    q_fine = {"C": F(1, 4), "B": F(1, 4)}
    for i in range(m):
        q_fine[f"A{i}"] = F(1, 2) / m
    fine = logloss(q_fine, "A0")
    coarse = -log(sum(v for w, v in q_fine.items() if w.startswith("A")))
    print(f"Split the actual world A into {m} fine states of equal mass:")
    print(f"  log-loss scored on the fine state  = {fine:.4f} nats (= ln 2 + ln {m})")
    print(f"  log-loss scored on the coarse world = {coarse:.4f} nats (unchanged)")
    assert isclose(fine, log(2) + log(m)) and isclose(coarse, log(2))

    # the uniform-prior trap
    worlds = ["A", "C"] + [f"B{i}" for i in range(k)]
    q_unif = {w: F(1, len(worlds)) for w in worlds}
    print("If the prior is 'uniform over the listed worlds', splitting B changes q(A):")
    print(f"  3 listed worlds: q(A) = 1/3, log-loss = {log(3):.4f}")
    print(f"  {len(worlds)} listed worlds: q(A) = 1/{len(worlds)}, log-loss = "
          f"{logloss(q_unif, 'A'):.4f}")
    print("Finding: log-loss is invariant to splitting wrong worlds only if the split")
    print("keeps their mass and the score is taken at a declared level. A uniform prior")
    print("over a list of worlds is not split-invariant.")


# ---------------------------------------------------------------- case 2

def posterior_A_after(counts0, n, a, prior_A):
    """Two hypotheses: A (x=0 with prob a) and not-A (x=1 with prob a).
    Returns q(A) after n observations of which counts0 are x=0."""
    la = a ** counts0 * (1 - a) ** (n - counts0)
    lb = (1 - a) ** counts0 * a ** (n - counts0)
    return prior_A * la / (prior_A * la + (1 - prior_A) * lb)


def expected_logloss_after(n, a, prior_A):
    """E[-ln q_n(A)] when the world is A and n honest observations are made."""
    total = 0.0
    for c0 in range(n + 1):
        pr = comb(n, c0) * a ** c0 * (1 - a) ** (n - c0)
        total += pr * -log(posterior_A_after(c0, n, a, prior_A))
    return total


def case2():
    print(LINE)
    print("CASE 2. A false record, and a misleading observation")
    print(LINE)
    # (a) noiseless elimination
    q = {"A": F(1, 3), "B": F(1, 3), "C": F(1, 3)}
    op = {"A": 0, "B": 1, "C": 1}
    lik = {w: {x: F(int(op[w] == x)) for x in (0, 1)} for w in q}
    honest = bayes(q, lik, 0)
    false = bayes(q, lik, 1)
    print("(a) Noiseless operation: A -> 0, B and C -> 1. Actual world A.")
    print(f"  honest record 0: q(A) = {honest['A']}, log-loss {logloss(q,'A'):.4f} -> "
          f"{abs(logloss(honest,'A')):.4f}")
    print(f"  false record 1:  q(A) = {false['A']}, log-loss -> {logloss(false,'A')}")
    p0 = sum(false[w] * lik[w][0] for w in false)
    print("  After the false record no later observation can raise q(A) above 0. The")
    print("  honest outcome 0 that world A goes on giving has probability"
          f" {p0} under the learner's")
    print("  own model, so Bayes' rule cannot even be applied to it.")
    print("  The count ledger stipulates lostCost + 1 per turn. Under log-loss the cost")
    print("  is infinite, and the truth cannot come back under ordinary Bayes updating.")
    print("  That does not block all learning: an operation that told B from C could")
    print("  still update among the wrong worlds. Here none does, by the choice of case.")
    print("  Cromwell's rule is the warning against giving a contingent possibility")
    print("  probability zero; this is what happens when the warning is ignored.")

    # (b) noisy operation: an honest observation can mislead
    a = 0.8
    print(f"\n(b) Noisy operation, accuracy a = {a}: A gives 0 with prob {a}; B, C give 1 with prob {a}.")
    qf = {w: 1 / 3 for w in "ABC"}
    likn = {"A": {0: a, 1: 1 - a}, "B": {0: 1 - a, 1: a}, "C": {0: 1 - a, 1: a}}
    for x in (0, 1):
        post = bayes(qf, likn, x)
        print(f"  honest outcome {x} (prob {likn['A'][x]:.1f} in A): "
              f"q(A) {qf['A']:.4f} -> {post['A']:.4f}, "
              f"change in log-loss {logloss(post,'A') - logloss(qf,'A'):+.4f}")
    pred = predictive(qf, likn, (0, 1))
    exp_change = sum(likn["A"][x] * (log(bayes(qf, likn, x)["A"]) - log(qf["A"])) for x in (0, 1))
    klv = kl(likn["A"], pred)
    print(f"  expected change in ln q(A) = {exp_change:.4f} = KL(p(x|A) || q(x)) = {klv:.4f}")
    assert isclose(exp_change, klv)
    print("  So an honest turn with a right instrument improves ln q(A) in expectation,")
    print("  but one honest turn can make it worse (outcome 1 above).")

    # (c) one misleading observation in the noisy model: a cost that shrinks
    print(f"\n(c) Noisy model, A versus not-A, a = {a}, prior q(A) = 1/2.")
    print("  Learner M made one observation and got the misleading outcome 1, which")
    print(f"  world A gives with probability {1 - a:.1f}. Learner N did not make that turn.")
    print("  This is conditional on an unfavourable outcome. It measures what one")
    print("  misleading datum costs; it is not a comparison of two policies, because a")
    print("  rule that drops such data would need to know which data mislead. A real")
    print("  recording error that turned 0 into 1 leaves M in exactly the same state:")
    print("  from inside the two cannot be told apart (tested_and_untested_look_alike).")
    print("  Expected log-loss of A after n further honest observations:")
    priorA = 0.5
    # after one false record x=1: q(A) = (1-a)/( (1-a) + a ) with prior 1/2
    q_after_false = posterior_A_after(0, 1, a, priorA)
    print(f"  q(A) right after the misleading outcome: {q_after_false:.4f}")
    cum_R = cum_D = 0.0
    rows = []
    for n in range(0, 21):
        eR = expected_logloss_after(n, a, q_after_false)
        eD = expected_logloss_after(n, a, priorA)
        cum_R += eR
        cum_D += eD
        rows.append((n, eR, eD))
    for n, eR, eD in rows:
        if n in (0, 1, 2, 3, 5, 10, 20):
            print(f"    n = {n:2d}: M {eR:.4f}   N {eD:.4f}   difference {eR - eD:.4f}")
    diffs = [eR - eD for _, eR, eD in rows]
    assert all(d > 0 for d in diffs) and all(d1 > d2 for d1, d2 in zip(diffs, diffs[1:]))
    # cancellation: one false 1 and one honest 0 leave q(A) at the prior
    assert isclose(posterior_A_after(1, 2, a, priorA), priorA)
    print(f"  cumulative over n = 0..20: M {cum_R:.4f}, N {cum_D:.4f}, extra {cum_R - cum_D:.4f}")
    # the log-odds offset of one misleading outcome equals one observation the other way
    lr = log(a / (1 - a))
    print(f"  In log-odds the misleading outcome is an offset of -ln(a/(1-a)) = {-lr:.4f}:")
    print("  one observation the other way cancels it exactly.")
    print("Finding: in this stationary, identifiable two-hypothesis model with a right")
    print("instrument and a nonzero prior, the cost of one misleading datum shrinks in")
    print("expectation as honest observations come in. That is not shown in general:")
    print("it needs useful later evidence, positive support and a right model.")
    print("The permanent exclusion of case (a) comes from zero support (hard elimination).")


# ---------------------------------------------------------------- case 3

def case3():
    print(LINE)
    print("CASE 3. Information from another learner: I(T;X,Y) = I(T;X) + I(T;Y|X)")
    print(LINE)
    print("Worlds W = (a, b), two fair bits. X = my observation, Y = the other's.")
    print("T = the question that is scored. Values in bits.")
    rows = []
    setups = [
        ("T = W,       X = a, Y = a      (same view)", lambda a, b: (a, b), lambda a, b: a, lambda a, b: a),
        ("T = W,       X = a, Y = b      (complementary)", lambda a, b: (a, b), lambda a, b: a, lambda a, b: b),
        ("T = a,       X = a, Y = a      (redundant)", lambda a, b: a, lambda a, b: a, lambda a, b: a),
        ("T = a xor b, X = a, Y = b      (synergy)", lambda a, b: a ^ b, lambda a, b: a, lambda a, b: b),
    ]
    print(f"  {'setup':48s} I(T;X) I(T;Y) I(T;Y|X) I(T;X,Y)")
    for name, T, X, Y in setups:
        joint = {}
        for a, b in product((0, 1), repeat=2):
            key = (T(a, b), X(a, b), Y(a, b))
            joint[key] = joint.get(key, 0) + F(1, 4)
        ix = nats_to_bits(mutual_info(joint, (0,), (1,)))
        iy = nats_to_bits(mutual_info(joint, (0,), (2,)))
        iyx = nats_to_bits(mutual_info(joint, (0,), (2,), (1,)))
        ixy = nats_to_bits(mutual_info(joint, (0,), (1, 2)))
        assert isclose(ixy, ix + iyx, abs_tol=1e-12)
        rows.append((name, ix, iy, iyx, ixy))
        print(f"  {name:48s} {ix:6.3f} {iy:6.3f} {iyx:8.3f} {ixy:8.3f}")
    # the same noisy instrument, run twice with independent noise
    acc = F(4, 5)
    joint = {}
    for a, ex, ey in product((0, 1), repeat=3):
        pr = F(1, 2) * (acc if ex == 0 else 1 - acc) * (acc if ey == 0 else 1 - acc)
        key = (a, a ^ ex, a ^ ey)
        joint[key] = joint.get(key, 0) + pr
    ix = nats_to_bits(mutual_info(joint, (0,), (1,)))
    iy = nats_to_bits(mutual_info(joint, (0,), (2,)))
    iyx = nats_to_bits(mutual_info(joint, (0,), (2,), (1,)))
    ixy = nats_to_bits(mutual_info(joint, (0,), (1, 2)))
    assert isclose(ixy, ix + iyx, abs_tol=1e-12) and iyx > 0
    print(f"  {'T = a, X and Y = a seen through the same':48s} {ix:6.3f} {iy:6.3f} {iyx:8.3f} {ixy:8.3f}")
    print(f"  {'  instrument (accuracy 0.8), independent noise':48s}")
    print("  The chain rule holds exactly in every row (checked).")
    print("  The sum of separate terms I(T;X) + I(T;Y) overstates in the redundant row")
    print("  (2 against 1) and understates in the synergy row (0 against 1).")
    print("  The count ledger scores the full world W. In the synergy row X rightly")
    print("  rules out 2 of the 4 worlds; what the count cannot do is score progress")
    print("  on a narrower declared question T, where world counts and progress on T")
    print("  can come apart.")
    print("Finding: the chain rule is a possible alternative to LearningRatchet's two")
    print("counters, given a declared target and a joint distribution. It is not derived")
    print("from them. I(T;Y|X) = 0 holds for a redundant view; a second run of the same")
    print("noisy instrument with independent noise adds information (last row), so")
    print("'same view' in same_view_is_solo means a redundant view, not the same method.")
    print("This is a standard identity, not a new result.")


# ---------------------------------------------------------------- case 4

def forward_filter(obs, a, h, prior=0.5):
    """Two worlds A, B; observation = world label with prob a; the learner
    assumes the world switches with hazard h per turn. Returns the list of
    beliefs q_t(A) held at the start of each turn, before observing."""
    qA = prior
    beliefs = []
    for x in obs:
        # predict step (the world may have switched)
        qA = qA * (1 - h) + (1 - qA) * h
        beliefs.append(qA)
        # update on x (x = 0 means 'looks like A')
        la = a if x == 0 else 1 - a
        lb = 1 - a if x == 0 else a
        qA = qA * la / (qA * la + (1 - qA) * lb)
    return beliefs


def expected_cum_logloss(path, a, h):
    """Exact expectation over all observation sequences of sum_t -ln q_t(w_t)."""
    n = len(path)
    total = 0.0
    for obs in product((0, 1), repeat=n):
        pr = 1.0
        for w, x in zip(path, obs):
            pr *= a if (x == 0) == (w == "A") else 1 - a
        beliefs = forward_filter(obs, a, h)
        ll = sum(-log(qA if w == "A" else 1 - qA) for w, qA in zip(path, beliefs))
        total += pr * ll
    return total


def case4():
    print(LINE)
    print("CASE 4. A world that moves: retain, and let go")
    print(LINE)
    # (a) non-uniqueness of the KL split
    p, p2 = {0: 0.7, 1: 0.3}, {0: 0.4, 1: 0.6}
    q, q2 = {0: 0.5, 1: 0.5}, {0: 0.6, 1: 0.4}
    total = kl(p2, q2) - kl(p, q)
    m1 = kl(p, q2) - kl(p, q)
    w1 = kl(p2, q2) - kl(p, q2)
    w2 = kl(p2, q) - kl(p, q)
    m2 = kl(p2, q2) - kl(p2, q)
    print("(a) World p: (0.7, 0.3) -> (0.4, 0.6). Model q: (0.5, 0.5) -> (0.6, 0.4).")
    print(f"  total change in KL(p||q) = {total:+.4f}")
    print(f"  model first, then world: model {m1:+.4f}, world {w1:+.4f}")
    print(f"  world first, then model: world {w2:+.4f}, model {m2:+.4f}")
    print(f"  symmetric (average of both orders): model {(m1+m2)/2:+.4f}, world {(w1+w2)/2:+.4f}")
    assert isclose(m1 + w1, total) and isclose(w2 + m2, total)
    dH = entropy(p2) - entropy(p)
    print(f"  the expected log-loss H(p) + KL(p||q) also changes through H: dH = {dH:+.4f}")
    print("  Both splits are exact; they disagree. A split needs a declared order or a")
    print("  symmetric rule, or the line between 'update' and 'goes stale' is arbitrary.")

    # (b) retaining versus letting go
    a, n = 0.75, 16
    static = ["A"] * n
    switch = ["A"] * (n // 2) + ["B"] * (n // 2)
    print(f"\n(b) Two worlds, observation accuracy a = {a}, {n} turns, exact expectation.")
    print("  Learner 'retain' assumes a world that stands still (hazard 0).")
    print("  Learner 'let go' assumes the world may switch (hazard 0.1).")
    print("  Expected cumulative log-loss of the current world:")
    res = {}
    for pname, path in (("static world", static), ("switch at turn 8", switch)):
        for lname, h in (("retain", 0.0), ("let go", 0.1)):
            res[(pname, lname)] = expected_cum_logloss(path, a, h)
        print(f"    {pname:17s}: retain {res[(pname,'retain')]:7.3f}   "
              f"let go {res[(pname,'let go')]:7.3f}")
    assert res[("static world", "retain")] < res[("static world", "let go")]
    assert res[("switch at turn 8", "let go")] < res[("switch at turn 8", "retain")]
    print("Finding: for these settings (accuracy, horizon, one switch at the midpoint,")
    print("hazards 0 and 0.1), assuming a still world does better when the world stands")
    print("still and assuming change does better when it moves. No general ranking is")
    print("shown. The hazard captures one aspect of 'retain, and let go': how fast old")
    print("evidence loses weight. Both learners keep their evidence in a posterior;")
    print("neither drops, retracts or dates a record, so the verb as an action is not")
    print("modelled. This is standard filtering, not a new result.")


# ---------------------------------------------------------------- case 5

def case5():
    print(LINE)
    print("CASE 5. A wrong instrument")
    print(LINE)
    m = 0.8  # the learner's account: A gives 0 with prob 0.8, B gives 1 with prob 0.8
    print(f"Learner's account of the operation: A -> 0 and B -> 1, each with prob {m}.")
    print("Actual world A. Prior q(A) = 1/2.")
    print(f"  {'true P(x=0 | A)':16s} {'E[d ln q(A)], 1 turn':>21s} {'drift per turn':>15s}"
          f" {'E[-ln q(A)] n=20':>17s}")
    for true0 in (0.8, 0.6, 0.3):
        # one-step expected change from the uniform prior
        pred = {0: 0.5 * m + 0.5 * (1 - m), 1: 0.5 * (1 - m) + 0.5 * m}
        model_lik = {0: m, 1: 1 - m}
        true_lik = {0: true0, 1: 1 - true0}
        one = sum(true_lik[x] * log(model_lik[x] / pred[x]) for x in (0, 1))
        # drift of the log-odds A:B per turn under the true channel
        drift = true0 * log(m / (1 - m)) + (1 - true0) * log((1 - m) / m)
        n = 20
        e = 0.0
        for c0 in range(n + 1):
            pr = comb(n, c0) * true0 ** c0 * (1 - true0) ** (n - c0)
            e += pr * -log(posterior_A_after(c0, n, m, 0.5))
        print(f"  {true0:16.1f} {one:21.4f} {drift:15.4f} {e:17.4f}")
        if true0 == 0.8:
            assert one > 0 and isclose(one, kl(true_lik, pred))
        if true0 == 0.6:
            assert one < 0 < drift
        if true0 == 0.3:
            assert one < 0 and drift < 0
    print("  At 0.8 (right instrument) the one-turn expectation is KL >= 0.")
    print("  At 0.6 the one-turn expectation is negative, yet the drift is positive:")
    print("  the guarantee per turn is lost while the learner still converges on A.")
    print("  At 0.3 the drift is negative: honest records drive q(A) toward 0, and the")
    print("  learner settles on B, whose model (0 with prob 0.2) is closer in KL to how")
    print("  A actually behaves than A's own model is.")
    print("Finding: the expected-improvement guarantee uses a right instrument as a")
    print("sufficient premise. A wrong instrument can cost the guarantee per turn")
    print("without costing convergence (0.6), or cost both (0.3). With independent")
    print("observations a misspecified Bayesian learner settles on the represented")
    print("model closest in KL to the data, which need not carry the true label")
    print("(known result).")


# ---------------------------------------------------------------- property check

def property_check(trials=20000, seed=17):
    print(LINE)
    print("PROPERTY CHECK. Right instrument: E[d ln q(w*)] = KL(p(x|w*) || q(x)) >= 0")
    print(LINE)
    rng = random.Random(seed)
    worst = 0.0
    zero_cases = 0
    for _ in range(trials):
        nw, nx = rng.randint(2, 5), rng.randint(2, 4)
        q = normalize({w: rng.random() + 1e-3 for w in range(nw)})
        lik = {w: normalize({x: rng.random() + 1e-3 for x in range(nx)}) for w in range(nw)}
        ws = rng.randrange(nw)
        pred = predictive(q, lik, range(nx))
        exp_change = sum(lik[ws][x] * (log(bayes(q, lik, x)[ws]) - log(q[ws])) for x in range(nx))
        k = kl(lik[ws], pred)
        assert isclose(exp_change, k, rel_tol=1e-9, abs_tol=1e-12)
        assert k >= -1e-12
        worst = max(worst, abs(exp_change - k))
    # equality case: an operation that does not discriminate
    q = {0: 0.3, 1: 0.7}
    lik = {0: {0: 0.4, 1: 0.6}, 1: {0: 0.4, 1: 0.6}}
    pred = predictive(q, lik, (0, 1))
    if isclose(kl(lik[0], pred), 0.0, abs_tol=1e-15):
        zero_cases += 1
    print(f"  {trials} random instances (seed {seed}): identity holds, largest gap {worst:.2e},")
    print("  and the expectation is never negative.")
    print("  Equality (no expected gain) exactly when the outcome distribution in w*")
    print("  equals the learner's predictive distribution, as for an operation that")
    print(f"  gives the same distribution in every world (checked: {zero_cases == 1}).")
    # the converse fails: a discriminating operation with zero expected gain in w*
    q = {"A": 0.2, "B": 0.4, "C": 0.4}
    lik = {"A": {1: 0.5, 0: 0.5}, "B": {1: 0.2, 0: 0.8}, "C": {1: 0.8, 0: 0.2}}
    pred = predictive(q, lik, (0, 1))
    gainA = kl(lik["A"], pred)
    joint = {(w, x): q[w] * lik[w][x] for w in q for x in (0, 1)}
    iwx = mutual_info(joint, (0,), (1,))
    assert isclose(gainA, 0.0, abs_tol=1e-15) and iwx > 0
    print("  The converse fails. Prior (0.2, 0.4, 0.4) on A, B, C, actual A, and an")
    print("  operation giving 1 with probability 0.5, 0.2, 0.8. It tells B from C, yet")
    print(f"  the predictive probability of 1 is {pred[1]:.2f}, as in A, so the expected")
    print(f"  gain for A is {abs(gainA):.1f}. Averaged over the prior, I(W;X) = {iwx:.4f} nats > 0.")
    print("  So zero expected gain in the actual world is not the same as an operation")
    print("  that tells no worlds apart (the creed's 'Try'). The two match only for")
    print("  I(W;X), averaged over worlds, with a prior of full support.")
    print("  The identity is standard (expected log-score gain of a Bayesian update).")


# ---------------------------------------------------------------- shape of the bill

def shape():
    print(LINE)
    print("SHAPE OF THE BILL. Count against log-loss, noiseless elimination")
    print(LINE)
    print("Uniform belief over n kept worlds, one actual. Each turn rules out one wrong world.")
    print(f"  {'kept n':>6s} {'count misfit':>13s} {'log-loss ln n':>14s} {'gain of next turn: count / log':>32s}")
    for n in range(8, 0, -1):
        gain_log = log(n / (n - 1)) if n > 1 else 0.0
        print(f"  {n:6d} {n-1:13d} {log(n):14.4f} {('1' if n>1 else '0'):>18s} / {gain_log:.4f}")
    # no constant exchange rate turns ln n into n - 1
    ratios = [(n - 1) / log(n) for n in range(2, 9)]
    assert max(ratios) - min(ratios) > 0.5
    print("Finding: the count books every removed world at 1; log-loss books the first")
    print("removal low and the last at ln 2. No constant rate turns ln n into n - 1")
    print(f"((n-1)/ln n runs from {ratios[0]:.2f} at n = 2 to {ratios[-1]:.2f} at n = 8), so the")
    print("count ledger is not log-loss of uniform elimination in other units.")
    print("Which shape fits depends on how prediction error turns into lost resources,")
    print("which neither ledger derives. A log-loss ledger needs two further choices:")
    print("a rate between nats and reserve, and a reason to charge realized log-loss")
    print("as a drain every turn.")


if __name__ == "__main__":
    case1()
    case2()
    case3()
    case4()
    case5()
    property_check()
    shape()
    print(LINE)
    print("Done. All assertions passed.")
