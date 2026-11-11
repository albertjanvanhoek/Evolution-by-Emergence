"""A decomposition of learning, checked with Z3.

One turn of a learning loop is modelled over possible worlds. Each verb is a
condition on that turn. Z3 checks:

  Part A (the loop, alone)
    A1  the seven verbs together guarantee learning in that turn;
    A2  the seven verbs can hold together (a witness);
    A3  for each verb: with the other six in place, its failure blocks
        learning in every case, and that failure is possible;
    A4  in a fixed finite space the loop saturates: with N worlds the verbs
        can hold for N-1 turns in a row and never for N.

  Part B (the blind spot, and the verbs between learners)
    B1  an error that none of the learner's own operations can tell apart
        from the truth survives any number of its own honest turns;
    B2  seven verbs between two learners together remove that error;
    B3  each of the seven is needed, in the same sense as A3;
    B4  over several turns the error is removed exactly when the link is
        intact in at least one turn: a break is a delay if it is repaired
        and permanent if it is not.

Every "holds" below is an UNSAT answer to the negation of the claim, for
worlds and outcomes of any number (uninterpreted sorts), except A4 and B4,
which are checked for the sizes printed. Run:  python3 decomposition.py
"""
from z3 import (And, Bool, BoolSort, Const, Consts, DeclareSort, EnumSort,
                Exists, ForAll, Function, If, Implies, Not, Or, Solver, sat, unsat)

FAILED = []


def check(name, constraints, expect):
    s = Solver()
    s.set("timeout", 60000)
    s.add(*constraints)
    r = s.check()
    ok = r == expect
    if not ok:
        FAILED.append(name)
    print(f"  [{'ok' if ok else 'FAIL'}] {name}: {r} (expected {expect})")
    return r


World = DeclareSort("World")
Outcome = DeclareSort("Outcome")
w, u = Consts("w u", World)
wstar = Const("wstar", World)          # the actual world


def subset_fn(name):
    return Function(name, World, BoolSort())


# --------------------------------------------------------------------------
# Part A. One turn of the loop, alone.
# --------------------------------------------------------------------------
print("Part A. The loop, alone")

S, S1, S2 = subset_fn("S"), subset_fn("S1"), subset_fn("S2")
# S  : the worlds kept possible before the turn
# S1 : after the update
# S2 : what is carried into the next turn
out = Function("out", World, Outcome)   # what the chosen operation yields in each world
observed = Const("observed", Outcome)   # what the learner observes
rec = Const("rec", Outcome)             # what the learner records
paid = Bool("paid")                     # the turn's cost is covered

mechanics_A = []
# Keeping costs. What is carried forward is the update if the turn is paid
# for, and the old state if it is not. (A first version made an unpaid turn
# change nothing as a separate rule. The check "the case is possible" then
# failed for 'afford': the other six verbs could not hold in an unpaid turn
# at all, so 'afford' was a precondition of the others and not a verb beside
# them. Tying the cost to retention removes that.)

verbs_A = {
    "leave open": S(wstar),
    "try":        Exists([w, u], And(S(w), S(u), out(w) != out(u))),
    "test":       observed == out(wstar),
    "record":     rec == observed,
    "update":     ForAll(w, S1(w) == And(S(w), out(w) == rec)),
    "retain":     ForAll(w, S2(w) == If(paid, S1(w), S(w))),
    "afford":     paid,
}
# How each verb fails. For the first three, the fifth-from-last and the last
# this is the exact negation; "update" and "retain" fail in the plain way
# (nothing is changed; what was gained is dropped).
fails_A = {
    "leave open": Not(S(wstar)),
    "try":        ForAll([w, u], Implies(And(S(w), S(u)), out(w) == out(u))),
    "test":       observed != out(wstar),
    "record":     rec != observed,
    "update":     ForAll(w, S1(w) == S(w)),
    "retain":     ForAll(w, S2(w) == S(w)),
    "afford":     Not(paid),
}
# Learning in one turn: nothing new is assumed, the actual world is still
# kept possible, and at least one world that was kept possible is ruled out.
learn = And(ForAll(w, Implies(S2(w), S(w))),
            S2(wstar),
            Exists(w, And(S(w), Not(S2(w)))))

allA = list(verbs_A.values())
check("A1 the seven verbs together guarantee learning",
      mechanics_A + allA + [Not(learn)], unsat)
check("A2 the seven verbs can hold together", mechanics_A + allA, sat)
for v in verbs_A:
    others = [c for k, c in verbs_A.items() if k != v]
    check(f"A3 without '{v}': learning is blocked in every case",
          mechanics_A + others + [fails_A[v], learn], unsat)
    check(f"A3 without '{v}': the case is possible",
          mechanics_A + others + [fails_A[v]], sat)

# A4. Saturation in a fixed finite space.
for N in (2, 3, 4, 5):
    FW, fws = EnumSort(f"FW{N}", [f"w{i}" for i in range(N)])
    fw, fu = Consts(f"fw{N} fu{N}", FW)
    fstar = Const(f"fstar{N}", FW)

    def turns(T):
        cs = []
        St = [Function(f"S{N}_{T}_{t}", FW, BoolSort()) for t in range(T + 1)]
        for t in range(T):
            o = Function(f"out{N}_{T}_{t}", FW, Outcome)
            cs += [St[t](fstar),                                                    # leave open
                   Exists([fw, fu], And(St[t](fw), St[t](fu), o(fw) != o(fu))),     # try
                   # test, record, update, retain and afford, folded into one line:
                   ForAll(fw, St[t + 1](fw) == And(St[t](fw), o(fw) == o(fstar)))]
        return cs

    check(f"A4 N={N}: the verbs can hold for {N-1} turns in a row", turns(N - 1), sat)
    check(f"A4 N={N}: they cannot hold for {N} turns", turns(N), unsat)

# --------------------------------------------------------------------------
# Part B. The blind spot, and the verbs between learners.
# --------------------------------------------------------------------------
print("Part B. The blind spot, and the verbs between learners")

Op = DeclareSort("Op")
o = Const("o", Op)
own = Function("own", Op, World, Outcome)   # the learner's own operations
used = Function("used", Op, BoolSort())     # the ones it runs, any number of them
b = Const("b", World)                       # a wrong world it keeps possible
P = subset_fn("P")                          # after all its own honest turns

blind = [S(wstar), S(b), b != wstar,
         ForAll(o, own(o, b) == own(o, wstar))]            # no own operation tells b from the truth
own_turns = [ForAll(w, P(w) == And(S(w), ForAll(o, Implies(used(o), own(o, w) == own(o, wstar)))))]

check("B1 the blind spot survives any number of own honest turns",
      blind + own_turns + [Not(And(P(b), P(wstar)))], unsat)

oth = Function("oth", World, Outcome)       # an operation only the other learner has
obs_o, sent, received, rec2 = Consts("obs_o sent received rec2", Outcome)
link = Bool("link")
T1, T2 = subset_fn("T1"), subset_fn("T2")

setting_B = blind + own_turns + [oth(b) != oth(wstar),            # the other's operation does tell them apart
                                 Implies(link, received == sent)]  # an intact link carries the signal

verbs_B = {
    "the other tests":           obs_o == oth(wstar),
    "the other passes on honestly": sent == obs_o,
    "keep the link":             link,
    "take in honestly":          rec2 == received,
    "accept the correction":     ForAll(w, T1(w) == And(P(w), Implies(link, oth(w) == rec2))),
    "leave open":                S(wstar),
    "retain":                    ForAll(w, T2(w) == T1(w)),
}
fails_B = {
    "the other tests":           obs_o != oth(wstar),
    "the other passes on honestly": sent != obs_o,
    "keep the link":             Not(link),
    "take in honestly":          rec2 != received,
    "accept the correction":     ForAll(w, T1(w) == P(w)),     # the signal is set aside
    "leave open":                Not(S(wstar)),
    "retain":                    ForAll(w, T2(w) == P(w)),
}
corrected = And(Not(T2(b)), T2(wstar))
# "leave open" is already part of the setting (S(wstar) in `blind`); for its
# own necessity check the setting is rebuilt without it.
setting_B_no_open = [c for c in setting_B if not c.eq(S(wstar))]

allB = list(verbs_B.values())
check("B2 the seven verbs between learners remove the blind spot",
      setting_B + allB + [Not(corrected)], unsat)
check("B2 they can hold together", setting_B + allB, sat)
for v in verbs_B:
    others = [c for k, c in verbs_B.items() if k != v]
    base = setting_B_no_open if v == "leave open" else setting_B
    check(f"B3 without '{v}': the blind spot is not corrected, in every case",
          base + others + [fails_B[v], corrected], unsat)
    check(f"B3 without '{v}': the case is possible",
          base + others + [fails_B[v]], sat)

# B4. A broken link is a delay if repaired, permanent if not.
for T in (2, 3, 4):
    Q = [subset_fn(f"Q{T}_{t}") for t in range(T + 1)]
    links = [Bool(f"link{T}_{t}") for t in range(T)]
    cs = [Q[0](wstar), Q[0](b), b != wstar, oth(b) != oth(wstar)]
    for t in range(T):
        # every verb of B2 except the link holds in every turn
        cs.append(ForAll(w, Q[t + 1](w) == And(Q[t](w), Implies(links[t], oth(w) == oth(wstar)))))
    check(f"B4 T={T}: the error is gone at the end exactly when the link held in some turn",
          cs + [Not(And(Q[T](wstar), Not(Q[T](b)) == Or(*links)))], unsat)

print()
print("ALL CHECKS AS EXPECTED" if not FAILED else f"UNEXPECTED: {FAILED}")
raise SystemExit(1 if FAILED else 0)
