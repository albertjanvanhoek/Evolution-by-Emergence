"""Models for acting: simulations M0-M3 for research/world-model
(MODELS_FOR_ACTING.md, D36), testing what ModelsForActing.lean leaves open.

Setting, as in the Lean module: worlds, actions, outcomes. An environment says
what each action yields in each world. An objective scores outcomes (integers
0-9). A representation is a partition of the worlds: the holder knows which
class the actual world is in, not which world. Worlds are generated from a
smaller set of outcome profiles (what each action yields), so several worlds
differ in ways no action's outcome reflects.

M0  Check. Brute force over small random cases: an optimal policy over a
    partition exists exactly when every class shares an action within the
    tolerance of the best (near_suffices_iff). Also checks the code used below.
M1  Purposes change. A holder scoped to its current purpose keeps only the
    distinctions that purpose needs; an aimless world model keeps every
    distinction that some action's outcome reflects. Each period the world is
    drawn anew; with probability p the purpose changes. Distinctions cost upkeep
    k per class per period; learning the distinctions a new purpose needs takes
    L periods, during which the scoped holder acts on its old classes. Also: a
    holder that accumulates distinctions across purposes, and one with none.
    Cost per period = regret (best payoff minus payoff obtained) + upkeep.
M2  How many distinctions. The number of classes needed (first-fit grouping,
    an upper bound on the minimum) for K purposes at once, at tolerance eps.
M3  Outside checks. A holder assesses whether its state is safe from its
    internal state, which conflates safe and unsafe states in some of its
    states (blind spots). Added channels: none; an instrument (independent
    error); a peer with its own, independent blind spots; one peer, or five,
    sharing the holder's blind spots. The best rule is learned from a training
    sample and evaluated on a separate one.

Expectations, written before the first run:
  M1  At p = 0 the scoped holder costs no more than the aimless one (same zero
      regret, fewer classes). As p rises its regret rises; there is a crossover
      above which the aimless world model is cheaper, at lower p when upkeep is
      cheaper. The accumulating holder ends between the two.
  M2  Classes needed fall with eps and rise with K, towards the number of
      outcome profiles and never above it.
  M3  Peers that share the blind spots add nothing on blind states, however
      many; an instrument and an independent peer both help, by their
      independence and error, not by what kind of source they are.

Run: python3 sim_models.py   (writes results/RESULTS_MODELS.md and results/results_models.json)
Seeded; numpy only.
"""

from __future__ import annotations

import itertools
import json
import os

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, "results")
os.makedirs(RES, exist_ok=True)

W, PROFILES, A, O = 12, 6, 4, 6


def make_env(rng):
    """Worlds generated from PROFILES distinct outcome profiles."""
    while True:
        prof = rng.integers(0, O, size=(PROFILES, A))
        if len({tuple(r) for r in prof}) == PROFILES:
            break
    assign = np.concatenate([np.arange(PROFILES), rng.integers(0, PROFILES, W - PROFILES)])
    rng.shuffle(assign)
    return prof[assign], assign


def payoff(res, u):
    return u[res]  # W x A


def class_ok(V, members, eps):
    """Some action is within eps of the best in every member world."""
    best = V[members].max(axis=1)
    return bool(np.any(np.all(V[members] >= best[:, None] - eps, axis=0)))


def sufficient(V, labels, eps):
    return all(class_ok(V, np.where(labels == c)[0], eps) for c in np.unique(labels))


def first_fit(Vs, assign, eps, rng, tries=8):
    """Group outcome profiles into as few classes as found, each valid for every
    payoff matrix in Vs. Worlds with the same profile are never split. Returns
    world labels. An upper bound on the minimum number of classes."""
    reps = np.array([np.where(assign == p)[0][0] for p in range(PROFILES)])
    best = None
    for _ in range(tries):
        order = rng.permutation(PROFILES)
        groups: list[list[int]] = []
        for p in order:
            for g in groups:
                cand = g + [p]
                if all(class_ok(V, reps[cand], eps) for V in Vs):
                    g.append(p)
                    break
            else:
                groups.append([p])
        if best is None or len(groups) < len(best):
            best = groups
    plab = np.empty(PROFILES, dtype=int)
    for i, g in enumerate(best):
        plab[g] = i
    return plab[assign]


def policy(V, labels):
    """Per class, the action with the highest mean payoff over its worlds
    (uniform prior). Returns the action for each world."""
    act = np.empty(W, dtype=int)
    for c in np.unique(labels):
        m = labels == c
        act[m] = int(np.argmax(V[m].mean(axis=0)))
    return act


def regret_vec(V, labels):
    act = policy(V, labels)
    return V.max(axis=1) - V[np.arange(W), act]


def refine(a, b):
    _, lab = np.unique(a * 1000 + b, return_inverse=True)
    return lab


# ---------------------------------------------------------------- M0

def m0(seed=7, cases=3000):
    rng = np.random.default_rng(seed)
    agree = 0
    n_suff = 0
    for _ in range(cases):
        w, a, m = 5, 3, 3
        res = rng.integers(0, 4, size=(w, a))
        u = rng.integers(0, 10, size=4)
        V = u[res]
        labels = rng.integers(0, m, size=w)
        eps = int(rng.integers(0, 3))
        # brute force: does some policy M -> A work in every world?
        exists = any(
            all(V[x, pi[labels[x]]] >= V[x].max() - eps for x in range(w))
            for pi in itertools.product(range(a), repeat=m)
        )
        cond = all(class_ok(V, np.where(labels == c)[0], eps) for c in np.unique(labels))
        agree += exists == cond
        n_suff += exists
    return {"cases": cases, "agree": agree, "sufficient_cases": n_suff}


# ---------------------------------------------------------------- M1

def m1_run(seed, p, k, L, envs, T):
    rng = np.random.default_rng(seed)
    tot = {h: 0.0 for h in ("none", "aimless", "scoped", "accumulating")}
    reg = {h: 0.0 for h in tot}
    cls = {h: 0.0 for h in tot}
    for _ in range(envs):
        res, assign = make_env(rng)
        u = rng.integers(0, 10, size=O)
        V = payoff(res, u)
        lab_none = np.zeros(W, dtype=int)
        lab_aim = assign.copy()
        lab_sc = first_fit([V], assign, 0, rng)
        lab_acc = lab_sc.copy()
        pending = -1  # periods until the scoped holders' new distinctions are learned
        target = None
        regs = {"none": regret_vec(V, lab_none), "aimless": regret_vec(V, lab_aim),
                "scoped": regret_vec(V, lab_sc), "accumulating": regret_vec(V, lab_acc)}
        for t in range(T):
            if p > 0 and rng.random() < p:
                u = rng.integers(0, 10, size=O)
                V = payoff(res, u)
                target = first_fit([V], assign, 0, rng)
                pending = L
                regs = {"none": regret_vec(V, lab_none), "aimless": regret_vec(V, lab_aim),
                        "scoped": regret_vec(V, lab_sc), "accumulating": regret_vec(V, lab_acc)}
            if pending == 0:
                lab_sc = target
                lab_acc = refine(lab_acc, target)
                regs["scoped"] = regret_vec(V, lab_sc)
                regs["accumulating"] = regret_vec(V, lab_acc)
                pending = -1
            elif pending > 0:
                pending -= 1
            w = rng.integers(0, W)
            for h, lab in (("none", lab_none), ("aimless", lab_aim),
                           ("scoped", lab_sc), ("accumulating", lab_acc)):
                n = len(np.unique(lab))
                r = regs[h][w]
                reg[h] += r
                cls[h] += n
                tot[h] += r + k * n
    n = envs * T
    return {h: {"cost": tot[h] / n, "regret": reg[h] / n, "classes": cls[h] / n} for h in tot}


def m1(seed_tune=11, envs=300, T=400, L=20):
    out = []
    for p in (0.0, 0.005, 0.02, 0.05, 0.1, 0.2):
        for k in (0.0, 0.1, 0.3, 1.0):
            r = m1_run(seed_tune, p, k, L, envs, T)
            out.append({"p": p, "k": k, "L": L, **{h: r[h] for h in r}})
    return out


# ---------------------------------------------------------------- M2

def m2(seed=13, envs=300):
    rng = np.random.default_rng(seed)
    rows = []
    for K in (1, 2, 4, 8, 16, 64):
        for eps in (0, 1, 2, 3, 5):
            counts = []
            for _ in range(envs):
                res, assign = make_env(rng)
                Vs = [payoff(res, rng.integers(0, 10, size=O)) for _ in range(K)]
                lab = first_fit(Vs, assign, eps, rng)
                assert all(sufficient(V, lab, eps) for V in Vs)
                counts.append(len(np.unique(lab)))
            rows.append({"K": K, "eps": eps, "classes_mean": float(np.mean(counts)),
                         "classes_max": int(np.max(counts))})
    return rows


# ---------------------------------------------------------------- M3

def m3(seed=17, n_internal=40, blind_frac=0.3, err=0.15, n_train=20000, n_test=20000, reps=20):
    """States: (internal state, safe). In blind internal states half are safe,
    half unsafe; elsewhere the internal state fixes safety."""
    results = {k: [] for k in ("none", "instrument", "independent peer",
                               "one peer sharing the blind spots",
                               "five peers sharing the blind spots")}
    blind_acc = {k: [] for k in results}
    rng = np.random.default_rng(seed)
    for _ in range(reps):
        blind = rng.random(n_internal) < blind_frac
        base_safe = rng.random(n_internal) < 0.5
        # the independent peer's own internal partition: blind spots drawn independently
        peer_blind_state = rng.random(n_internal * 4) < blind_frac

        def sample(n):
            c = rng.integers(0, n_internal, size=n)
            safe = np.where(blind[c], rng.random(n) < 0.5, base_safe[c])
            # the peer's internal state: a different partition of the same states
            pc = rng.integers(0, n_internal * 4, size=n)
            return c, safe, pc

        def readings(c, safe, pc):
            n = len(c)
            flip = lambda x: np.where(rng.random(n) < err, ~x, x)
            instr = flip(safe)
            # independent peer: correct (up to err) unless its own state is blind, then a coin
            peer = np.where(peer_blind_state[pc], rng.random(n) < 0.5, flip(safe))
            # peers sharing the holder's representation: see only c, report their best guess
            guess = np.where(blind[c], rng.random(n) < 0.5, base_safe[c])
            one = np.where(blind[c], rng.random(n) < 0.5, flip(base_safe[c]))
            five = [np.where(blind[c], rng.random(n) < 0.5, flip(base_safe[c])) for _ in range(5)]
            fivemaj = np.sum(five, axis=0) >= 3
            return {"none": np.zeros(n, dtype=int), "instrument": instr.astype(int),
                    "independent peer": peer.astype(int),
                    "one peer sharing the blind spots": one.astype(int),
                    "five peers sharing the blind spots": fivemaj.astype(int)}

        ctr, str_, ptr = sample(n_train)
        cte, ste, pte = sample(n_test)
        rtr, rte = readings(ctr, str_, ptr), readings(cte, ste, pte)
        for key in results:
            # learn: majority safety per (internal state, reading)
            keytr = ctr * 2 + rtr[key]
            keyte = cte * 2 + rte[key]
            tab = np.zeros((n_internal * 2, 2))
            np.add.at(tab, (keytr, str_.astype(int)), 1)
            rule = tab[:, 1] > tab[:, 0]
            pred = rule[keyte]
            results[key].append(float(np.mean(pred == ste)))
            mb = blind[cte]
            blind_acc[key].append(float(np.mean(pred[mb] == ste[mb])))
    return {k: {"accuracy": float(np.mean(results[k])), "accuracy_on_blind_states": float(np.mean(blind_acc[k]))}
            for k in results}


def main():
    out = {"M0": m0(), "M1": m1(), "M2": m2(), "M3": m3()}
    with open(os.path.join(RES, "results_models.json"), "w") as f:
        json.dump(out, f, indent=1)
    lines = ["# Models for acting: simulation results (M0-M3)", "",
             "Generated by `sim_models.py` (seeded). Worlds: %d, from %d outcome profiles; actions: %d; outcomes: %d; objectives score outcomes 0-9." % (W, PROFILES, A, O), ""]
    m = out["M0"]
    lines += ["## M0. Check of near_suffices_iff", "",
              "%d random cases (5 worlds, 3 actions, 3 classes, tolerance 0-2): brute force and the class condition agree in %d; %d cases were sufficient." % (m["cases"], m["agree"], m["sufficient_cases"]), ""]
    lines += ["## M1. Purposes change", "",
              "Cost per period = regret + upkeep × classes. Learning a new purpose's distinctions takes %d periods." % out["M1"][0]["L"], "",
              "| p (purpose change per period) | upkeep k | none | aimless | scoped | accumulating | classes: aimless / scoped / accumulating | regret: scoped / accumulating |",
              "|---|---|---|---|---|---|---|---|"]
    for r in out["M1"]:
        lines.append("| %.3f | %.1f | %.3f | %.3f | %.3f | %.3f | %.2f / %.2f / %.2f | %.3f / %.3f |" % (
            r["p"], r["k"], r["none"]["cost"], r["aimless"]["cost"], r["scoped"]["cost"], r["accumulating"]["cost"],
            r["aimless"]["classes"], r["scoped"]["classes"], r["accumulating"]["classes"],
            r["scoped"]["regret"], r["accumulating"]["regret"]))
    lines += ["", "## M2. Classes needed (first fit, an upper bound on the minimum)", "",
              "| purposes K | " + " | ".join("eps=%d" % e for e in (0, 1, 2, 3, 5)) + " |", "|---|---|---|---|---|---|"]
    for K in (1, 2, 4, 8, 16, 64):
        row = [r for r in out["M2"] if r["K"] == K]
        lines.append("| %d | " % K + " | ".join("%.2f" % r["classes_mean"] for r in row) + " |")
    lines += ["", "Outcome profiles (the aimless world model): %d. Worlds: %d." % (PROFILES, W), ""]
    lines += ["## M3. Outside checks", "", "| channel | accuracy | accuracy on the holder's blind states |", "|---|---|---|"]
    for k, v in out["M3"].items():
        lines.append("| %s | %.3f | %.3f |" % (k, v["accuracy"], v["accuracy_on_blind_states"]))
    with open(os.path.join(RES, "RESULTS_MODELS.md"), "w") as f:
        f.write("\n".join(lines) + "\n")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
