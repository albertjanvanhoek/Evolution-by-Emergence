"""A small agent model of the ten verbs, for a parameter-recovery check.

Purpose. Before any knockout experiment, ask whether a task can tell the ten
verbs apart at all. Simulate agents with known verb settings, record what an
experimenter could record, fit the model back, and see which settings come
back out. If two verbs cannot be recovered separately here, where the model is
known exactly, no experiment with this kind of task and measurement will
separate them either.

What this model is NOT. It is one way of writing the verbs as mechanisms,
chosen by the assistant. Each verb is a parameter of an agent that we built,
so the decomposition is partly built in (the trap named in v0.4). What the
model can show is narrower: which verbs a given task and a given measurement
can distinguish, and where they trade off against each other. It says nothing
about whether real learners have these ten functions.

The task
  * H = 4 possible world states; one is true. In the 'volatile' condition the
    true state switches with probability HAZARD per round.
  * Three standard tests, each with a binary outcome whose probability depends
    on the state. In the 'blind' condition the standard tests cannot tell
    states 0 and 1 apart. A fourth test (the "new method") can, but an agent
    must first acquire it.
  * N = 5 learners, fully linked. They can pass on the outcomes of their own
    tests. In the 'disrupted' condition links break and must be repaired. In
    the 'adversarial' condition a sixth agent sends outcomes drawn from a
    wrong state every round.
  * Testing costs one unit of budget. In the 'scarce' condition the budget is
    smaller than the number of rounds.

The ten verbs as mechanisms (all in [0, 1] unless stated)
  stay_open      weight given to testimony that disagrees with one's current
                 best guess (1 = same weight as agreeing testimony)
  try            how strongly test choice follows expected information gain
                 (0 = random choice among available tests)
  notice         sensitivity to surprise: an own observation moves beliefs
                 only if it is surprising enough; low notice = high threshold
  be_honest      probability that a passed-on outcome is the observed one;
                 otherwise the agent passes on what it expected
  change         size of a belief update, as an exponent on the likelihood
                 (1 = full Bayesian update)
  let_go         per-round mixing of beliefs back toward uniform, in [0, 0.3]
                 (0 = remember everything; high = let go quickly). One
                 retention policy, as v0.4 proposes, not two functions
  take_care      pacing of the test budget (0 = spend whenever possible;
                 1 = spend at a rate that lasts to the end)
  share          probability of passing on the outcome of one's own test
  repair         probability per round of repairing a broken incoming link
  find_new_ways  probability per round of acquiring the new method

What an experimenter records (and what the fit uses)
  test decisions and choices, own outcomes (the experimenter controls the
  stimuli), passed-on reports, received messages, link repairs, method
  acquisition, and a belief report every round. Two belief-report regimes:
    rich:   the full belief vector with Gaussian noise (SIGMA)
    sparse: only a choice of the most likely state (softmax, KAPPA)
"""

from __future__ import annotations

import numpy as np

H = 4
T = 60
N = 5
SIGMA = 0.05          # noise on rich belief reports
KAPPA = 4.0           # inverse temperature of sparse choices on log belief
BETA_MAX = 20.0       # try = 1 gives softmax(20 * EIG)
K_NOTICE = 8.0        # steepness of the notice threshold
LETGO_MAX = 0.3
HAZARD = 0.06
BUDGET_SCARCE = 20
P_CUT = 0.10

VERBS = ["stay_open", "try", "notice", "be_honest", "change",
         "let_go", "take_care", "share", "repair", "find_new_ways"]
LABELS = {
    "stay_open": "Stay open", "try": "Try", "notice": "Notice",
    "be_honest": "Be honest", "change": "Change",
    "let_go": "Remember / let go", "take_care": "Take care",
    "share": "Share", "repair": "Repair", "find_new_ways": "Find new ways",
}
# Range each verb is drawn from in the recovery experiments.
PRIOR = {
    "stay_open": (0.0, 1.0), "try": (0.0, 1.0), "notice": (0.0, 1.0),
    "be_honest": (0.5, 1.0), "change": (0.1, 1.0), "let_go": (0.0, LETGO_MAX),
    "take_care": (0.0, 1.0), "share": (0.2, 1.0), "repair": (0.1, 0.9),
    "find_new_ways": (0.02, 0.3),
}
# The six verbs that act through beliefs; fitted jointly.
JOINT = ["stay_open", "try", "notice", "be_honest", "change", "let_go"]
JOINT_BOUNDS = {
    "stay_open": (0.0, 1.0), "try": (0.0, 1.0), "notice": (0.0, 1.0),
    "be_honest": (0.001, 0.999), "change": (0.02, 1.0),
    "let_go": (0.0, LETGO_MAX),
}

_STANDARD_ADEQUATE = np.array([[0.8, 0.2, 0.8, 0.2],
                               [0.8, 0.8, 0.2, 0.2],
                               [0.7, 0.3, 0.3, 0.7]]).T
# States 0 and 1 are identical on every standard test: a blind spot.
_STANDARD_BLIND = np.array([[0.8, 0.8, 0.2, 0.2],
                            [0.3, 0.3, 0.8, 0.3],
                            [0.6, 0.6, 0.4, 0.85]]).T
_METHOD = np.array([0.9, 0.1, 0.5, 0.5])

CONDITIONS = {
    "base":        dict(volatile=False, scarce=False, blind=False, disrupted=False, adversarial=False),
    "volatile":    dict(volatile=True,  scarce=False, blind=False, disrupted=False, adversarial=False),
    "scarce":      dict(volatile=False, scarce=True,  blind=False, disrupted=False, adversarial=False),
    "blind":       dict(volatile=False, scarce=False, blind=True,  disrupted=False, adversarial=False),
    "disrupted":   dict(volatile=False, scarce=False, blind=False, disrupted=True,  adversarial=False),
    "adversarial": dict(volatile=False, scarce=False, blind=False, disrupted=False, adversarial=True),
    "all_hard":    dict(volatile=True,  scarce=True,  blind=True,  disrupted=True,  adversarial=True),
}


def test_table(blind: bool) -> np.ndarray:
    """Outcome probabilities, shape (H, 4); column 3 is the new method."""
    std = _STANDARD_BLIND if blind else _STANDARD_ADEQUATE
    return np.column_stack([std, _METHOD])


# ---------------------------------------------------------------- belief maths

def _entropy(p, axis=-1):
    return -(p * np.log(np.clip(p, 1e-300, None))).sum(axis)


def update(b, L, e):
    """Tempered Bayes: b * L**e, normalised. b, L: (..., H); e: (...)."""
    logb = np.log(b) + e[..., None] * np.log(L)
    logb = logb - logb.max(-1, keepdims=True)
    nb = np.exp(logb)
    return nb / nb.sum(-1, keepdims=True)


def notice_weight(b, L, notice):
    """Weight in (0, 1) given to an own observation, rising with surprise."""
    s = -np.log((b * L).sum(-1))
    tau = 2.5 * (1.0 - notice) - 0.5
    return 1.0 / (1.0 + np.exp(-K_NOTICE * (s - tau)))


def eig(b, P):
    """Expected information gain of each test. b: (..., H); P: (H, J)."""
    p1 = b @ P
    post1 = b[..., :, None] * P / p1[..., None, :]
    post0 = b[..., :, None] * (1 - P) / (1 - p1)[..., None, :]
    return (_entropy(b)[..., None]
            - p1 * _entropy(post1, axis=-2) - (1 - p1) * _entropy(post0, axis=-2))


def _logsumexp(x, axis=-1):
    m = x.max(axis, keepdims=True)
    return (m + np.log(np.exp(x - m).sum(axis, keepdims=True))).squeeze(axis)


# ---------------------------------------------------------------- simulation

def draw_params(rng, shape):
    return {v: rng.uniform(*PRIOR[v], size=shape) for v in VERBS}


def simulate(params, cond, rng, isolate0=False, no_budget0=False,
             notice_on=True):
    """Run R replicate groups of N learners at once.

    params: dict verb -> array (R, N). Returns a dict of records.
    isolate0: agent 0 receives nothing (reality route only).
    no_budget0: agent 0 cannot test (commons route only).
    notice_on: False switches the notice threshold off (weight 1).
    """
    R = params["try"].shape[0]
    P = test_table(cond["blind"])
    PT = P.T                                          # (4, H)
    budget = np.full((R, N), BUDGET_SCARCE if cond["scarce"] else T, float)
    if no_budget0:
        budget[:, 0] = 0
    true = rng.integers(H, size=R)
    wrong = (true + 1 + rng.integers(H - 1, size=R)) % H
    b = np.full((R, N, H), 1.0 / H)
    allowed = ~np.eye(N, dtype=bool)[None].repeat(R, 0)     # i receives from j
    if isolate0:
        allowed[:, 0, :] = False
    link = allowed.copy()
    acquired = np.zeros((R, N), bool)
    ri = np.arange(R)[:, None]

    rec = {k: np.zeros((R, N, T), dtype) for k, dtype in [
        ("downs", int), ("attempts", int), ("decided", bool), ("tested", bool),
        ("budget_frac", float), ("test", int), ("avail_method", bool),
        ("outcome", int), ("shared", bool), ("report", int), ("choice", int),
        ("acc", float)]}
    rec["acq_round"] = np.full((R, N), -1)
    rec["rich"] = np.zeros((R, N, T, H))
    rec["belief"] = np.zeros((R, N, T, H))      # noiseless, for checks and scores
    # messages received: sender axis N+1 (last = the misleader)
    rec["msg_on"] = np.zeros((R, N, T, N + 1), bool)
    rec["msg_test"] = np.zeros((R, N, T, N + 1), int)
    rec["msg_out"] = np.zeros((R, N, T, N + 1), int)
    rec["true"] = np.zeros((R, T), int)

    beta = BETA_MAX * params["try"]
    for t in range(T):
        if cond["volatile"]:
            sw = rng.random(R) < HAZARD
            true = np.where(sw, (true + 1 + rng.integers(H - 1, size=R)) % H, true)
        rec["true"][:, t] = true

        # Repair, then new breaks.
        if cond["disrupted"]:
            down = allowed & ~link
            att = down & (rng.random((R, N, N)) < params["repair"][..., None])
            link |= att
            rec["downs"][:, :, t] = down.sum(-1)
            rec["attempts"][:, :, t] = att.sum(-1)
            link &= ~(link & (rng.random((R, N, N)) < P_CUT))

        # Find new ways.
        newly = ~acquired & (rng.random((R, N)) < params["find_new_ways"])
        rec["acq_round"] = np.where(newly, t, rec["acq_round"])
        acquired |= newly

        # Take care: whether to spend on a test this round.
        has = budget > 0
        frac = np.minimum(1.0, budget / (T - t))
        ptest = (1 - params["take_care"]) + params["take_care"] * frac
        tested = has & (rng.random((R, N)) < ptest)
        rec["decided"][:, :, t] = has
        rec["budget_frac"][:, :, t] = frac
        rec["tested"][:, :, t] = tested
        rec["avail_method"][:, :, t] = acquired

        # Try: which test.
        logits = beta[..., None] * eig(b, P)
        logits = np.where(np.concatenate([np.ones((R, N, 3), bool),
                                          acquired[..., None]], -1), logits, -np.inf)
        g = logits - np.log(-np.log(rng.random(logits.shape)))
        j = g.argmax(-1)
        o = (rng.random((R, N)) < P[true[:, None], j]).astype(int)
        map0 = b.argmax(-1)
        conf = (P[map0, j] >= 0.5).astype(int)
        Lj = PT[j]
        L = np.where(o[..., None] == 1, Lj, 1 - Lj)
        w = notice_weight(b, L, params["notice"]) if notice_on else np.ones((R, N))
        b = np.where(tested[..., None], update(b, L, params["change"] * w), b)
        budget = budget - tested
        rec["test"][:, :, t] = np.where(tested, j, -1)
        rec["outcome"][:, :, t] = o

        # Share, honestly or not.
        shares = tested & (rng.random((R, N)) < params["share"])
        honest = rng.random((R, N)) < params["be_honest"]
        rep = np.where(honest, o, conf)
        rec["shared"][:, :, t] = shares
        rec["report"][:, :, t] = rep

        # Receive, sender by sender, in a fixed order; the misleader last.
        senders = [(s, shares[:, s], j[:, s], rep[:, s]) for s in range(N)]
        if cond["adversarial"]:
            mj = rng.integers(3, size=R)
            mo = (rng.random(R) < P[wrong, mj]).astype(int)
            senders.append((N, np.ones(R, bool), mj, mo))
        for s, on, sj, so in senders:
            arr = on[:, None] & (link[:, :, s] if s < N else ~np.zeros((R, N), bool))
            if s < N and isolate0:
                arr[:, 0] = False
            if s == N and isolate0:
                arr[:, 0] = False
            Ls = PT[sj][:, None, :].repeat(N, 1)
            Ls = np.where(so[:, None, None] == 1, Ls, 1 - Ls)
            mp = b.argmax(-1)
            disconf = Ls[ri, np.arange(N)[None], mp] < 0.5
            e = params["change"] * np.where(disconf, params["stay_open"], 1.0)
            b = np.where(arr[..., None], update(b, Ls, e), b)
            rec["msg_on"][:, :, t, s] = arr
            rec["msg_test"][:, :, t, s] = sj[:, None]
            rec["msg_out"][:, :, t, s] = so[:, None]

        # Remember / let go.
        lg = params["let_go"][..., None]
        b = (1 - lg) * b + lg / H

        # Belief reports, both regimes from the same trajectory.
        rec["rich"][:, :, t] = b + rng.normal(0, SIGMA, b.shape)
        cl = KAPPA * np.log(b)
        rec["choice"][:, :, t] = (cl - np.log(-np.log(rng.random(cl.shape)))).argmax(-1)
        rec["belief"][:, :, t] = b
        rec["acc"][:, :, t] = b[ri, np.arange(N)[None], true[:, None]]
    return rec


def agent_record(rec, r, n):
    """Slice one agent's data out of a batch record."""
    out = {k: v[r, n] for k, v in rec.items() if k != "true"}
    out["true"] = rec["true"][r]
    return out


# ---------------------------------------------------------------- likelihood

def joint_loglik(theta, a, P, regime, notice_on=True, trace=None):
    """Log-likelihood of one agent's belief-driven behaviour.

    theta: (K, 6) in the order of JOINT. Replays the agent's belief trajectory
    from its recorded inputs for each of the K parameter vectors at once.
    Uses: test choices (try), passed-on reports (be_honest), and belief
    reports (rich or sparse). Take care, share, repair and find new ways have
    their own likelihood terms (see closed_form_fits), which separate.
    """
    K = theta.shape[0]
    open_, try_, notice, honest, change, letgo = theta.T
    b = np.full((K, H), 1.0 / H)
    ll = np.zeros(K)
    kr = np.arange(K)
    for t in range(T):
        if a["tested"][t]:
            j = a["test"][t]
            nav = 4 if a["avail_method"][t] else 3
            lg = BETA_MAX * try_[:, None] * eig(b, P[:, :nav])
            ll += lg[:, j] - _logsumexp(lg, 1)
            map0 = b.argmax(1)
            conf = (P[map0, j] >= 0.5).astype(int)
            o = a["outcome"][t]
            L = P[:, j] if o == 1 else 1 - P[:, j]
            w = notice_weight(b, L[None], notice) if notice_on else np.ones(K)
            b = update(b, np.broadcast_to(L, (K, H)), change * w)
            if a["shared"][t]:
                r_ = a["report"][t]
                p = np.where(r_ == o, honest + (1 - honest) * (conf == r_),
                             (1 - honest) * (conf == r_))
                ll += np.log(np.clip(p, 1e-12, None))
        for s in np.flatnonzero(a["msg_on"][t]):
            j = a["msg_test"][t, s]
            L = P[:, j] if a["msg_out"][t, s] == 1 else 1 - P[:, j]
            disconf = L[b.argmax(1)] < 0.5
            b = update(b, np.broadcast_to(L, (K, H)),
                       change * np.where(disconf, open_, 1.0))
        b = (1 - letgo[:, None]) * b + letgo[:, None] / H
        if trace is not None:
            trace.append(b.copy())
        if regime == "rich":
            ll -= ((a["rich"][t][None] - b) ** 2).sum(1) / (2 * SIGMA ** 2)
        else:
            cl = KAPPA * np.log(b)
            ll += cl[kr, a["choice"][t]] - _logsumexp(cl, 1)
    return ll


def closed_form_fits(a):
    """Verbs with their own observable channel. NaN = no information."""
    out = {}
    nt = a["tested"].sum()
    out["share"] = a["shared"].sum() / nt if nt else np.nan
    d = a["downs"].sum()
    out["repair"] = a["attempts"].sum() / d if d else np.nan
    # find_new_ways: geometric, attempts every round until acquired.
    k = a["acq_round"]
    out["find_new_ways"] = 1.0 / (k + 1) if k >= 0 else 0.0
    # take_care: Bernoulli test decisions with p = 1 - c * (1 - frac).
    dec = a["decided"]
    frac = a["budget_frac"][dec]
    y = a["tested"][dec]
    if dec.sum() == 0 or np.all(frac >= 1.0):
        out["take_care"] = np.nan          # never constrained: no information
    else:
        grid = np.linspace(0, 1, 1001)
        p = 1 - grid[:, None] * (1 - frac[None])
        p = np.clip(p, 1e-9, 1 - 1e-9)
        ll = (np.log(p) * y + np.log(1 - p) * (~y)).sum(1)
        out["take_care"] = grid[ll.argmax()]
    return out
