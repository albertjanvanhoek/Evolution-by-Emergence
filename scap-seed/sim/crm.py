"""
Cumulative Reproduction Model (CRM): exact stochastic simulator and analytic companions.

State: N = size of the retained repertoire (retained organization).
Events (continuous-time Markov chain, simulated exactly with Gillespie's algorithm):
  * production of one new retained item at rate P(N), gated by the budget ledger
    (admission: the item is retained only if the repertoire N+1 is affordable);
  * loss of one retained item at rate delta * N (forgetting, decay, displacement).

Production laws:
  mass-action (free parallel search, e.g. chemistry, mass-action encounters):
      P(N) = rho * ( a0 + sum_k alpha_k * C(N, k) )
  effort-limited (search paid from the free budget, e.g. agents, R&D):
      P(N) = rho * phi * F(N) * (1 + beta*N)**gamma / c0 ,  F(N) = B0 + (eta - mu) * N
      (retained items raise yield per unit of free budget with leverage beta)

Ledger (one currency): gross budget B0 + eta*N, upkeep mu*N.  Affordable(N) iff mu*N <= B0 + eta*N.

Cumulative reproduction number:  R_c(N) = P(N) / (delta * N)
  = expected retained items produced per retained item over its expected lifetime 1/delta.
"""
from __future__ import annotations

import math
from dataclasses import dataclass, field
from typing import Callable, Optional

import numpy as np


# ----------------------------------------------------------------------------- model

@dataclass
class Ledger:
    B0: float = math.inf     # exogenous gross budget
    eta: float = 0.0         # resource capture per retained item
    mu: float = 0.0          # upkeep per retained item

    def affordable(self, n: float) -> bool:
        return self.mu * n <= self.B0 + self.eta * n + 1e-12

    @property
    def cap(self) -> float:
        """Largest affordable repertoire (inf if retention is self-financing)."""
        if self.eta >= self.mu or math.isinf(self.B0):
            return math.inf
        return self.B0 / (self.mu - self.eta)

    def free(self, n: float) -> float:
        return self.B0 + (self.eta - self.mu) * n


@dataclass
class CRM:
    delta: float = 1.0                 # per-item loss rate
    rho: float = 1.0                   # retention (validation/fidelity) probability
    mode: str = "mass"                 # "mass" or "effort"
    a0: float = 0.0                    # from-scratch innovation rate (mass-action)
    alpha: dict = field(default_factory=dict)   # {arity k: alpha_k}
    # effort-limited parameters
    phi: float = 1.0
    c0: float = 1.0
    beta: float = 0.0
    gamma: float = 1.0
    ledger: Ledger = field(default_factory=Ledger)

    # raw production (before admission gating)
    def P_raw(self, n: float) -> float:
        if self.mode == "mass":
            s = self.a0
            for k, a in self.alpha.items():
                s += a * math.comb(int(n), k) if float(n).is_integer() else a * _gcomb(n, k)
            return self.rho * s
        elif self.mode == "effort":
            F = self.ledger.free(n)
            if F <= 0:
                return 0.0
            return self.rho * self.phi * F * (1.0 + self.beta * n) ** self.gamma / self.c0
        raise ValueError(self.mode)

    def P(self, n: float) -> float:
        """Production actually admitted: zero when N+1 would be unaffordable."""
        if not self.ledger.affordable(n + 1):
            return 0.0
        return self.P_raw(n)

    def L(self, n: float) -> float:
        return self.delta * n

    def Rc(self, n: float) -> float:
        return self.P(n) / self.L(n) if n > 0 else math.inf


def _gcomb(x: float, k: int) -> float:
    """Generalized binomial coefficient for real x (used by the ODE)."""
    out = 1.0
    for i in range(k):
        out *= (x - i) / (i + 1)
    return max(out, 0.0)


# ----------------------------------------------------------------------------- Gillespie

@dataclass
class RunResult:
    t: np.ndarray
    n: np.ndarray
    outcome: str        # "extinct", "cap" (reached n_cap), "time" (t_max reached)
    t_end: float


def gillespie(model: CRM, n0: int, t_max: float, n_cap: int = 10**9,
              rng: Optional[np.random.Generator] = None, record: bool = True,
              ledger_schedule: Optional[Callable[[float], Ledger]] = None,
              max_events: int = 5_000_000) -> RunResult:
    """Exact simulation. If ledger_schedule is given, the ledger is time-varying
    (piecewise constant; re-evaluated at every event and at schedule breakpoints),
    and items above a newly lowered ceiling are shed immediately (forced forgetting)."""
    rng = rng or np.random.default_rng()
    t, n = 0.0, int(n0)
    ts, ns = [0.0], [n]
    events = 0
    while True:
        if ledger_schedule is not None:
            model.ledger = ledger_schedule(t)
            cap = model.ledger.cap
            if n > cap:
                n = int(math.floor(cap))
                if record:
                    ts.append(t); ns.append(n)
        if n == 0 and model.P(0) == 0:
            return RunResult(np.array(ts), np.array(ns), "extinct", t)
        if n >= n_cap:
            return RunResult(np.array(ts), np.array(ns), "cap", t)
        p = model.P(n)
        l = model.L(n)
        tot = p + l
        if tot <= 0:
            return RunResult(np.array(ts), np.array(ns), "time", t_max)
        dt = rng.exponential(1.0 / tot)
        if ledger_schedule is not None and hasattr(ledger_schedule, "breaks"):
            nxt = [b for b in ledger_schedule.breaks if b > t]
            if nxt and t + dt > nxt[0]:
                t = nxt[0]      # memoryless: re-draw after the breakpoint
                continue
        t += dt
        if t > t_max:
            return RunResult(np.array(ts), np.array(ns), "time", t_max)
        n += 1 if rng.random() * tot < p else -1
        events += 1
        if record:
            ts.append(t); ns.append(n)
        if events > max_events:
            return RunResult(np.array(ts), np.array(ns), "time", t)


# ----------------------------------------------------------------------------- analytics

def ode_trajectory(model: CRM, n0: float, t_max: float, n_cap: float = 1e12, dt: float = 1e-3):
    """Mean-field ODE dN/dt = P(N) - delta*N with admission ceiling (RK4, clipped)."""
    from scipy.integrate import solve_ivp
    cap = model.ledger.cap

    def f(t, y):
        n = y[0]
        p = model.P_raw(n) if n + 1 <= cap or math.isinf(cap) else 0.0
        if not math.isinf(cap) and n >= cap:
            p = 0.0
        return [p - model.delta * n]

    def hit_cap(t, y):
        return y[0] - n_cap
    hit_cap.terminal = True
    sol = solve_ivp(f, (0, t_max), [n0], events=hit_cap, max_step=0.05, rtol=1e-8, atol=1e-10)
    return sol.t, np.minimum(sol.y[0], cap if not math.isinf(cap) else np.inf)


def arity2_critical_mass(model: CRM) -> float:
    """Mass-action, arity 2 only, a0 = 0:  P = rho*alpha2*N(N-1)/2 = a N^2 - a N,
    dN/dt = a N^2 - (a + delta) N  ->  N* = (a + delta)/a = 1 + 2 delta/(rho alpha2)."""
    a = model.rho * model.alpha[2] / 2
    return (a + model.delta) / a


def arity2_time_to(model: CRM, n0: float, n1: float) -> float:
    """Closed-form deterministic time from n0 to n1 (> n0 > N*) for dN/dt = aN^2 - gN.
    With u = 1/N: u(t) = 1/N* + (1/n0 - 1/N*) e^{g t}.  Blow-up time (n1 -> inf):
    t* = -(1/g) ln(1 - N*/n0)."""
    a = model.rho * model.alpha[2] / 2
    g = a + model.delta
    Ns = g / a
    if math.isinf(n1):
        return -math.log(1 - Ns / n0) / g
    return math.log((1 - Ns / n1) / (1 - Ns / n0)) / g


def birth_death_hit_prob(model: CRM, n0: int, n_cap: int) -> float:
    """Exact probability that the embedded birth-death chain reaches n_cap before 0."""
    # rates b_i = P(i), d_i = delta*i ; ruin formula h(n) = S(n)/S(n_cap), S(n)=sum_{j<n} prod_{i=1..j} d_i/b_i
    # States with zero production (e.g. N = 0, 1 under pure arity-2 composition)
    # can only decline, so reaching the highest such state `lo` is certain extinction.
    lo = 0
    for i in range(1, n_cap):
        if model.P(i) <= 0:
            lo = i
    if n0 <= lo:
        return 0.0
    if n0 >= n_cap:
        return 1.0
    # chain on {lo, ..., n_cap}: h(n) = sum_{j=lo}^{n-1} r_j / sum_{j=lo}^{n_cap-1} r_j,
    # r_lo = 1, r_j = prod_{i=lo+1..j} d_i / b_i
    logs = [0.0]
    acc = 0.0
    for i in range(lo + 1, n_cap):
        acc += math.log(model.L(i)) - math.log(model.P(i))
        logs.append(acc)
    logs = np.array(logs)
    w = np.exp(logs - logs.max())
    S = np.cumsum(w)
    return float(S[n0 - 1 - lo] / S[-1])


def linear_extinction_prob(Rc: float, n0: int) -> float:
    """Linear birth-death (arity 1): extinction probability = min(1, 1/R_c)^n0."""
    return min(1.0, 1.0 / Rc) ** n0


def spectral_radius(K: np.ndarray) -> float:
    return float(max(abs(np.linalg.eigvals(K))))


def two_layer_threshold(k11: float, k22: float) -> float:
    """Symmetric coupling c = k12 = k21 at which a 2-layer NGM with subcritical
    diagonals becomes critical:  (1-k11)(1-k22) = c^2."""
    return math.sqrt((1 - k11) * (1 - k22))


# ----------------------------------------------------------------------------- exact transient (finite state)

def generator(model: CRM, n_max: int) -> np.ndarray:
    """CTMC generator on states 0..n_max (births blocked at n_max and by the ledger)."""
    Q = np.zeros((n_max + 1, n_max + 1))
    for n in range(n_max + 1):
        b = model.P(n) if n < n_max else 0.0
        d = model.L(n)
        if n < n_max:
            Q[n, n + 1] = b
        if n > 0:
            Q[n, n - 1] = d
        Q[n, n] = -(b + d)
    return Q


def transient_distribution(model: CRM, p0: np.ndarray, t: float, n_max: int) -> np.ndarray:
    from scipy.linalg import expm
    return p0 @ expm(generator(model, n_max) * t)


def project_down(p: np.ndarray, cap: int) -> np.ndarray:
    """Forced forgetting when the ceiling drops: mass above cap moves to cap."""
    q = p.copy()
    q[cap] += q[cap + 1:].sum()
    q[cap + 1:] = 0.0
    return q
