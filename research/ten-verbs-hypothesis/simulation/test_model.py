"""Checks that the fitting code replays exactly what the simulation did.

Run: python -m pytest test_model.py   (or: python test_model.py)
"""

import numpy as np

from model import (CONDITIONS, JOINT, N, T, agent_record, closed_form_fits,
                   draw_params, joint_loglik, simulate, test_table)


def test_replay_reproduces_beliefs():
    """At the true settings, the replay's belief in the true state equals the
    simulation's, round by round, in every condition."""
    rng = np.random.default_rng(0)
    for name, cond in CONDITIONS.items():
        pr = draw_params(rng, (3, N))
        rec = simulate(pr, cond, rng)
        P = test_table(cond["blind"])
        for r in range(3):
            for n in range(N):
                a = agent_record(rec, r, n)
                th = np.array([[pr[v][r, n] for v in JOINT]])
                tr = []
                ll = joint_loglik(th, a, P, "rich", trace=tr)
                assert np.isfinite(ll).all(), name
                b = np.array([x[0] for x in tr])
                got = b[np.arange(T), a["true"]]
                assert np.allclose(got, a["acc"], atol=1e-12), name


def test_closed_forms():
    rng = np.random.default_rng(1)
    pr = draw_params(rng, (2, N))
    rec = simulate(pr, CONDITIONS["base"], rng)
    a = agent_record(rec, 0, 0)
    f = closed_form_fits(a)
    assert np.isclose(f["share"], a["shared"].sum() / a["tested"].sum())
    assert np.isnan(f["take_care"])      # abundant budget: never constrained
    assert np.isnan(f["repair"])         # no breaks: no repair data
    rec = simulate(pr, CONDITIONS["all_hard"], rng)
    f = closed_form_fits(agent_record(rec, 0, 0))
    assert not np.isnan(f["take_care"])
    assert not np.isnan(f["repair"])


if __name__ == "__main__":
    test_replay_reproduces_beliefs()
    test_closed_forms()
    print("all checks passed")
