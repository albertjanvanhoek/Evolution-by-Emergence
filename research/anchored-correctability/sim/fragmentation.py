"""Agent-based model of shared reality, fragmentation and repair (Layer 6).

This is the smallest dynamic version of the SCAP metamodel.  It is a graded
(soft) counterpart of the set-based Lean file `Persistence.lean`.

World
    The true state moves on a ring of W worlds, a random walk with rate `lam`.
    This is the persistence premise: the world changes.

Agents
    Each agent keeps a tally of evidence weight over the W worlds.  Its
    **reality** is the set of worlds whose tally is at least `theta` times its
    maximum.  Agents belong to G groups.
    * learner: forgets (rate `decay`) and spreads its tally to neighbouring
      worlds (rate `diffuse`), because the world may have moved.  It adds new
      evidence.  This is openness plus evidence: learning.
    * rigid: stops all updating after a burn-in;
    * drifter: after the burn-in, shifts its tally at random, whatever happens;
    * sealed: keeps learning, but its tally is zero outside a fixed constraint
      (its burn-in reality, widened by 2): a sealed tradition;
    * vacuous: after the burn-in, leaves every world open (says nothing).

Evidence
    With probability q per step an agent sees an interval of radius rho.  It is
    centred on the true world, except in two cases:
    * with probability `bias_rate` it is shifted by the agent's group lens
      (systematic false evidence, invisible from inside the group);
    * with probability eps it is centred at random.

Links
    Links form a potential-link graph: dense inside groups (mean degree
    `k_in`), sparse across groups (`k_out`).  Along active links, agents mix
    their tallies (DeGroot averaging with weight `mix`).  Relayed voices are
    added, never deleted: keep every voice.

Second-order rules (the narrative)
    An active link breaks with probability p * (1 + beta * D).  A broken link
    is repaired with probability r * exp(-gamma * D).  D is the disagreement
    between the two agents: the total-variation distance between their evidence
    tallies, from 0 (same picture) to 1 (nothing in common).  r is the mean of
    the two groups' narratives.

Succession (links through time)
    Each agent is replaced with probability `death`.  The newcomer inherits a
    random group member's tally with probability `fidelity`; otherwise it starts
    blank (a uniform tally: it knows nothing).

Measured
    S          size of the largest cluster of active links (the collaboration)
    instep     fraction of agents whose reality contains the true world
    know       mean over agents of (1 - |reality|/W) if in step, else 0
    cross_dis  fraction of cross-group pairs with disjoint realities: two
               realities, at most one of them right
    hidden     cross-group pairs that are disjoint AND in different clusters:
               conflict that nobody can see
"""
from __future__ import annotations

import math
from dataclasses import dataclass

import numpy as np


@dataclass
class Params:
    N: int = 300
    G: int = 1
    W: int = 24
    k_in: float = 6.0
    k_out: float = 0.0
    lam: float = 0.05
    decay: float = 0.03
    diffuse: float = 0.05
    theta: float = 0.6
    q: float = 0.05
    rho: int = 2
    eps: float = 0.05
    bias_rate: float = 0.0
    bias_size: int = 12        # lens offsets spread symmetrically, +-bias_size/2 for G=2
    mix: float = 0.3
    gossip: float = 0.3
    p: float = 0.05
    r: float = 0.20
    beta: float = 0.0
    gamma: float = 0.0
    fb_cross_only: bool = False  # disagreement feedback acts only on links between groups
    death: float = 0.0
    fidelity: float = 1.0
    kind: str = "learner"
    burn: int = 50
    T: int = 600
    seed: int = 1


def er_giant(c: float) -> float:
    """Giant component fraction of an Erdos-Renyi graph with mean degree c."""
    if c <= 1.0:
        return 0.0
    s = 0.5
    for _ in range(500):
        s = 1.0 - math.exp(-c * s)
    return s


def build_edges(P: Params, group: np.ndarray, rng: np.random.Generator):
    N = P.N
    sizes = np.bincount(group, minlength=P.G)
    iu, ju = np.triu_indices(N, 1)
    same = group[iu] == group[ju]
    p_in = P.k_in / np.maximum(1, sizes[group[iu]] - 1)
    p_out = P.k_out / np.maximum(1, N - sizes[group[iu]])
    prob = np.where(same, p_in, p_out)
    keep = rng.random(len(iu)) < prob
    return iu[keep], ju[keep], ~same[keep]


def components(N: int, a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """Label connected components (union-find, vectorised enough for N ~ 1e3)."""
    parent = np.arange(N)

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    for i, j in zip(a.tolist(), b.tolist()):
        ri, rj = find(i), find(j)
        if ri != rj:
            parent[ri] = rj
    return np.array([find(i) for i in range(N)])


class World:
    def __init__(self, P: Params, narratives=None, kinds=None):
        self.P = P
        self.rng = rng = np.random.default_rng(P.seed)
        self.group = (np.arange(P.N) * P.G) // P.N
        self.ei, self.ej, self.cross = build_edges(P, self.group, rng)
        self.active = np.ones(len(self.ei), dtype=bool)
        self.truth = int(rng.integers(P.W))
        self.tally = np.full((P.N, P.W), 1.0 / P.W)
        self.kind = np.array(kinds if kinds is not None else [P.kind] * P.N)
        self.seal = np.ones((P.N, P.W), dtype=bool)
        self.offset = np.array([(g - (P.G - 1) / 2) * P.bias_size for g in range(P.G)])
        self.narr = np.array(narratives if narratives is not None else [P.r] * P.G, dtype=float)
        self.t = 0
        W = P.W
        self._iv = np.zeros((W, W))
        for c in range(W):
            for d in range(-P.rho, P.rho + 1):
                self._iv[c, (c + d) % W] = 1.0

    # realities
    def realities(self) -> np.ndarray:
        m = self.tally.max(axis=1, keepdims=True)
        return self.tally >= self.P.theta * m

    def step(self):
        P, rng, W = self.P, self.rng, self.P.W
        T = self.tally
        post = self.t >= P.burn
        if self.t == P.burn:
            R = self.realities()
            wide = R | np.roll(R, 1, 1) | np.roll(R, -1, 1)
            wide = wide | np.roll(wide, 1, 1) | np.roll(wide, -1, 1)
            sealed = self.kind == "sealed"
            self.seal[sealed] = wide[sealed]
        # the world changes
        if rng.random() < P.lam:
            self.truth = (self.truth + int(rng.choice((-1, 1)))) % W
        learns = (self.kind == "learner") | (self.kind == "sealed") | (not post)
        # openness: forget and spread (the world may have moved)
        spread = (1 - P.diffuse) * T + 0.5 * P.diffuse * (np.roll(T, 1, 1) + np.roll(T, -1, 1))
        spread = (1 - P.decay) * spread + P.decay / W
        T[learns] = spread[learns]
        # evidence
        draw = learns & (rng.random(P.N) < P.q)
        idx = np.nonzero(draw)[0]
        if len(idx):
            u = rng.random(len(idx))
            centre = np.full(len(idx), self.truth)
            noisy = u < P.eps
            biased = (~noisy) & (u < P.eps + P.bias_rate)
            centre[noisy] = rng.integers(0, W, noisy.sum())
            centre[biased] = np.round(self.truth + self.offset[self.group[idx[biased]]]).astype(int) % W
            T[idx] += self._iv[centre]
        # drifters: change regardless of anything
        drift = (self.kind == "drifter") & post & (rng.random(P.N) < P.lam)
        for i in np.nonzero(drift)[0]:
            T[i] = np.roll(T[i], int(rng.choice((-1, 1))))
        # relay: DeGroot mixing along a sample of active links
        act = np.nonzero(self.active)[0]
        if len(act):
            pick = act[rng.random(len(act)) < P.gossip]
            a, b = self.ei[pick], self.ej[pick]
            ok = learns[a] & learns[b]
            a, b = a[ok], b[ok]
            delta = np.zeros_like(T)
            diff = T[b] - T[a]
            np.add.at(delta, a, P.mix * diff)
            np.add.at(delta, b, -P.mix * diff)
            deg = np.bincount(np.concatenate([a, b]), minlength=P.N).astype(float)
            T += delta / np.maximum(1.0, deg)[:, None]
        # vacuous agents keep every world open, whatever happens
        vac = (self.kind == "vacuous") & post
        T[vac] = 1.0 / W
        # sealed agents cannot put weight outside their constraint
        sealed = (self.kind == "sealed") & post
        T[sealed] = np.where(self.seal[sealed], T[sealed], 0.0)
        empty = sealed & (T.sum(axis=1) <= 0)
        T[empty] = self.seal[empty] / np.maximum(1, self.seal[empty].sum(axis=1, keepdims=True))
        # normalise
        T /= T.sum(axis=1, keepdims=True)
        # link dynamics: the narrative
        # disagreement: total-variation distance between the two tallies
        D = 0.5 * np.abs(T[self.ei] - T[self.ej]).sum(axis=1)
        fb = self.cross if P.fb_cross_only else np.ones(len(D), dtype=bool)
        beta = np.where(fb, P.beta, 0.0)
        gamma = np.where(fb, P.gamma, 0.0)
        br = rng.random(len(D)) < P.p * (1.0 + beta * D)
        rr = 0.5 * (self.narr[self.group[self.ei]] + self.narr[self.group[self.ej]])
        rep = rng.random(len(D)) < np.minimum(1.0, rr * np.exp(-gamma * D))
        self.active = np.where(self.active, ~br, rep)
        # succession
        if P.death > 0:
            die = np.nonzero(rng.random(P.N) < P.death)[0]
            for i in die:
                g = self.group[i]
                if rng.random() < P.fidelity:
                    mates = np.nonzero(self.group == g)[0]
                    T[i] = T[rng.choice(mates)]
                else:
                    T[i] = 1.0 / W
        self.t += 1

    def measure(self, pairs: int = 400):
        P, rng = self.P, self.rng
        R = self.realities()
        lab = components(P.N, self.ei[self.active], self.ej[self.active])
        _, counts = np.unique(lab, return_counts=True)
        S = counts.max() / P.N
        n_real = int((counts >= max(2, 0.05 * P.N)).sum())
        ins = R[:, self.truth]
        width = R.sum(axis=1) / P.W
        know = np.where(ins, 1 - width, 0.0)
        out = dict(S=float(S), realities=n_real, instep=float(ins.mean()),
                   know=float(know.mean()), sharp=float(1 - width.mean()))
        if P.G > 1:
            a = rng.integers(0, P.N, pairs)
            b = rng.integers(0, P.N, pairs)
            cr = self.group[a] != self.group[b]
            a, b = a[cr], b[cr]
            dis = ~(R[a] & R[b]).any(axis=1)
            out["cross_dis"] = float(dis.mean()) if len(a) else 0.0
            out["hidden"] = float((dis & (lab[a] != lab[b])).mean()) if len(a) else 0.0
            out["cross_active"] = float(self.active[self.cross].mean()) if self.cross.any() else 0.0
        out["group_know"] = [float(know[self.group == g].mean()) for g in range(P.G)]
        out["kind_instep"] = {k: float(ins[self.kind == k].mean()) for k in np.unique(self.kind)}
        out["kind_know"] = {k: float(know[self.kind == k].mean()) for k in np.unique(self.kind)}
        return out


def run(P: Params, every: int = 10, world: World | None = None, T: int | None = None,
        narratives=None, kinds=None):
    w = world or World(P, narratives=narratives, kinds=kinds)
    series = []
    for _ in range(T if T is not None else P.T):
        w.step()
        if w.t % every == 0:
            m = w.measure()
            m["t"] = w.t
            series.append(m)
    return w, series
