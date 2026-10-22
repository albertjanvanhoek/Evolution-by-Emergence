"""Models for acting: learning from noisy evidence, simulations M4 and M5 for
research/world-model (MODELS_FOR_ACTING.md, D36). The next step after M0-M3.

Setting as in sim_models.py: 12 worlds from 6 outcome profiles, 4 actions,
objectives scoring outcomes 0-9. The holder's representation is coarse: the 6
profiles are grouped into 2 classes, so it knows the class of the actual world,
not the world. Within its class it holds a belief (uniform prior, which is
correct here) and acts by expected payoff. The actual world is fixed during an
episode.

Evidence. A channel gives one of 4 symbols per reading. Each world has a home
symbol; a reading shows it with probability 1 - eta and each other symbol with
eta/3 (eta = 0.5, so a reading is weak evidence). Home symbols are drawn at
random, so some worlds in a class share one and cannot be told apart by it.
The holder knows these likelihoods.

Holders:
  own lens        a channel whose readings depend only on the class: no update
  one origin      one independent reading per period, counted once
  copies counted  the same reading relayed by 4 copies, counted as 5 readings
  two origins     two independent readings per period
  (and, as a bound, a holder that knows the world)

M4  Acting every period while learning (repeated, reversible choice): regret
    per period over 30 periods; the probability given to the actual world;
    calibration: how often the holder is confidently wrong (gives the most
    probable world at least 0.9 while it is not the actual one) against how
    often it is confident at all.
M5  When to stop learning and act once (irreversible): each period of waiting
    costs c and brings one reading. Policies: act at once; read a fixed number
    n of times; myopic value of information (read again while one more reading
    is expected to be worth more than c); good enough (read again while the
    expected regret of acting now exceeds c); and the myopic rule run by a
    holder that counts copies. Loss = regret of the final choice + c x periods
    waited. At most 30 readings.

Expectations, written before the first run:
  M4  Own lens: regret stays at its starting level. One origin: regret falls
      over time. Two origins: falls faster. Copies counted: the belief moves
      faster and is more often confidently wrong; regret no better than one
      origin.
  M5  The myopic and good-enough rules come close to the best fixed n at every
      cost without being tuned; each fixed n does well only near the cost it
      suits; the holder that counts copies stops too early and loses more when
      waiting is cheap.

Added after the first run, and labelled as such in the results: standard errors
for M4, and in M5 a rule that looks ahead up to 8 readings (read again while some
batch of k readings is expected to be worth more than c x k). Nothing else changed.

Run: python3 sim_learning.py   (writes results/RESULTS_LEARNING.md and results/results_learning.json)
Seeded; numpy only.
"""

from __future__ import annotations

import json
import os

import numpy as np

from sim_models import A, O, PROFILES, W, make_env, payoff

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, "results")
S = 4          # symbols per reading
ETA = 0.5      # noise of a reading
COPIES = 4     # copies relaying the same reading
T4 = 30
MAXWAIT = 30


def make_case(rng):
    res, assign = make_env(rng)
    u = rng.integers(0, 10, size=O)
    V = payoff(res, u).astype(float)
    group = rng.permutation(PROFILES) % 2      # profile -> class
    cls = group[assign]                        # world -> class
    home = rng.integers(0, S, size=W)
    lik = np.full((W, S), ETA / (S - 1))
    lik[np.arange(W), home] = 1 - ETA
    return V, cls, lik


def act(V, members, b):
    return int(np.argmax(b @ V[members]))


def read(rng, lik, w):
    return int(rng.choice(S, p=lik[w]))


# ---------------------------------------------------------------- M4

def m4(seed=21, cases=600):
    rng = np.random.default_rng(seed)
    holders = ("own lens", "one origin", "copies counted", "two origins")
    reg = {h: np.zeros(T4) for h in holders}
    ptrue = {h: np.zeros(T4) for h in holders}
    conf = {h: 0 for h in holders}
    case10 = {h: [] for h in holders}
    case30 = {h: [] for h in holders}
    confwrong = {h: 0 for h in holders}
    n = 0
    for _ in range(cases):
        V, cls, lik = make_case(rng)
        w = int(rng.integers(0, W))
        members = np.where(cls == cls[w])[0]
        L = lik[members]                       # members x S
        idx = int(np.where(members == w)[0][0])
        b = {h: np.full(len(members), 1 / len(members)) for h in holders}
        best = V[w].max()
        for t in range(T4):
            s1 = read(rng, lik, w)
            s2 = read(rng, lik, w)
            b["one origin"] = b["one origin"] * L[:, s1]
            b["copies counted"] = b["copies counted"] * L[:, s1] ** (1 + COPIES)
            b["two origins"] = b["two origins"] * L[:, s1] * L[:, s2]
            for h in holders:
                b[h] = b[h] / b[h].sum()
                a = act(V, members, b[h])
                reg[h][t] += best - V[w, a]
                if t == 9:
                    case10[h].append(best - V[w, a])
                if t == T4 - 1:
                    case30[h].append(best - V[w, a])
                ptrue[h][t] += b[h][idx]
                if b[h].max() >= 0.9:
                    conf[h] += 1
                    if int(np.argmax(b[h])) != idx:
                        confwrong[h] += 1
        n += 1
    return {h: {"regret_by_period": (reg[h] / n).round(4).tolist(),
                "p_actual_by_period": (ptrue[h] / n).round(4).tolist(),
                "regret_se_period10": float(np.std(case10[h]) / np.sqrt(n)),
                "regret_se_period30": float(np.std(case30[h]) / np.sqrt(n)),
                "confident_share": conf[h] / (n * T4),
                "confidently_wrong_share": confwrong[h] / (n * T4),
                "wrong_when_confident": (confwrong[h] / conf[h]) if conf[h] else None}
            for h in holders}


# ---------------------------------------------------------------- M5

def exp_regret(Vm, b):
    a = int(np.argmax(b @ Vm))
    return float(b @ (Vm.max(axis=1) - Vm[:, a]))


def myopic_voi(Vm, L, b):
    now = float(np.max(b @ Vm))
    val = 0.0
    for s in range(S):
        ps = float(b @ L[:, s])
        if ps <= 0:
            continue
        bs = b * L[:, s] / ps
        val += ps * float(np.max(bs @ Vm))
    return val - now


import math
from itertools import combinations_with_replacement

LOOK = 8
COUNTS = {k: [np.bincount(c, minlength=S) for c in combinations_with_replacement(range(S), k)] for k in range(1, LOOK + 1)}
COEF = {k: [math.factorial(k) / np.prod([math.factorial(x) for x in n]) for n in COUNTS[k]] for k in COUNTS}


def batch_voi(Vm, L, b, k):
    now = float(np.max(b @ Vm))
    val = 0.0
    for n, co in zip(COUNTS[k], COEF[k]):
        like = co * np.prod(L ** n, axis=1)
        pn = float(b @ like)
        if pn <= 0:
            continue
        post = b * like / pn
        val += pn * float(np.max(post @ Vm))
    return val - now


def lookahead_wants_more(Vm, L, b, c):
    return any(batch_voi(Vm, L, b, k) > c * k for k in range(1, LOOK + 1))


def m5_episode(rng, V, cls, lik, w, policy, c, n_fixed=0, copies=False):
    members = np.where(cls == cls[w])[0]
    Vm, L = V[members], lik[members]
    b = np.full(len(members), 1 / len(members))
    waited = 0
    while waited < MAXWAIT:
        if policy == "now":
            break
        if policy == "fixed" and waited >= n_fixed:
            break
        if policy == "myopic" and myopic_voi(Vm, L, b) <= c:
            break
        if policy == "good enough" and exp_regret(Vm, b) <= c:
            break
        if policy == "lookahead" and not lookahead_wants_more(Vm, L, b, c):
            break
        s = read(rng, lik, w)
        b = b * L[:, s] ** (1 + COPIES if copies else 1)
        b = b / b.sum()
        waited += 1
    a = int(members.size and np.argmax(b @ Vm))
    return V[w].max() - V[w, a] + c * waited, waited


def m5(seed=23, cases=1500):
    rows = []
    policies = [("act at once", "now", 0, False)] + \
        [("fixed n=%d" % n, "fixed", n, False) for n in (1, 2, 4, 8, 16)] + \
        [("myopic value of information", "myopic", 0, False),
         ("good enough", "good enough", 0, False),
         ("myopic, counting copies", "myopic", 0, True),
         ("lookahead up to 8 readings (added after the first run)", "lookahead", 0, False)]
    for c in (0.01, 0.05, 0.2, 0.5, 1.0):
        rng = np.random.default_rng(seed)
        cs = []
        for _ in range(cases):
            V, cls, lik = make_case(rng)
            cs.append((V, cls, lik, int(rng.integers(0, W)), int(rng.integers(0, 2**31))))
        for name, pol, nf, cp in policies:
            losses, waits = [], []
            for V, cls, lik, w, sd in cs:
                r = np.random.default_rng(sd)   # same readings for every policy
                loss, waited = m5_episode(r, V, cls, lik, w, pol, c, nf, cp)
                losses.append(loss)
                waits.append(waited)
            rows.append({"c": c, "policy": name, "loss": float(np.mean(losses)),
                         "loss_se": float(np.std(losses) / np.sqrt(len(losses))),
                         "readings": float(np.mean(waits))})
    return rows


def main():
    out = {"M4": m4(), "M5": m5()}
    with open(os.path.join(RES, "results_learning.json"), "w") as f:
        json.dump(out, f, indent=1)
    L = ["# Models for acting: learning from noisy evidence (M4, M5)", "",
         "Generated by `sim_learning.py` (seeded). 12 worlds from 6 profiles, 4 actions; the representation groups the profiles into 2 classes; readings have 4 symbols, noise %.2f; copies: %d." % (ETA, COPIES), "",
         "## M4. Acting every period while learning", "",
         "| holder | regret, period 1 | period 5 | period 10 (s.e.) | period 30 (s.e.) | P(actual world), period 10 | confident (>=0.9) | confidently wrong | wrong when confident |",
         "|---|---|---|---|---|---|---|---|---|"]
    for h, v in out["M4"].items():
        r = v["regret_by_period"]
        L.append("| %s | %.3f | %.3f | %.3f (%.3f) | %.3f (%.3f) | %.3f | %.3f | %.3f | %s |" % (
            h, r[0], r[4], r[9], v["regret_se_period10"], r[29], v["regret_se_period30"], v["p_actual_by_period"][9], v["confident_share"],
            v["confidently_wrong_share"], "%.3f" % v["wrong_when_confident"] if v["wrong_when_confident"] is not None else "-"))
    L += ["", "## M5. When to stop learning and act once", "",
          "Loss = regret of the final choice + c x readings (standard error in brackets); readings = mean number taken.", "",
          "| policy | " + " | ".join("c=%g" % c for c in (0.01, 0.05, 0.2, 0.5, 1.0)) + " |", "|---|---|---|---|---|---|"]
    names = []
    for r in out["M5"]:
        if r["policy"] not in names:
            names.append(r["policy"])
    for nm in names:
        cells = []
        for c in (0.01, 0.05, 0.2, 0.5, 1.0):
            r = [x for x in out["M5"] if x["policy"] == nm and x["c"] == c][0]
            cells.append("%.3f (%.3f); %.1f" % (r["loss"], r["loss_se"], r["readings"]))
        L.append("| %s | " % nm + " | ".join(cells) + " |")
    with open(os.path.join(RES, "RESULTS_LEARNING.md"), "w") as f:
        f.write("\n".join(L) + "\n")
    print("\n".join(L))


if __name__ == "__main__":
    main()
