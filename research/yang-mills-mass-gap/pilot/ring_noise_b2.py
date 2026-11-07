"""Ring test with noisy retained spins: does Delta_R survive near the two conditionings?

Same set-up as ring_b2.py (b = 2, periodic planar pattern, free centre spin sigma_0,
annulus R < d <= 2R tilted by +/- eps toward e_z), but every fixed retained spin is
perturbed: eta_x -> normalise(eta_x + delta * g_x), with g_x i.i.d. standard Gaussian
3-vectors. For each noise sample the SAME g is used for the + ring and the - ring,
so Delta_R(g) = <sigma_0^z>_{+,g} - <sigma_0^z>_{-,g} compares two conditionings that
differ only in the annulus. Each (ring, noise sample) is run from starts near +z and -z.

This is a proxy for conditioning on small neighbourhoods (sets of positive measure)
of the two configurations. It is stricter than needed: in the definition of an
essential discontinuity the tolerance may shrink as R grows, while here delta is fixed.

Usage: python ring_noise_b2.py BETA R DELTA [NSAMP]   (L = 4R; writes ring_noise_b2_beta{BETA}_R{R}_d{DELTA}.json)
"""

import json
import math
import sys
import time

import numpy as np

sys.path.insert(0, ".")
from pilot import seed  # noqa: E402
from ring_b2 import run_chain, setup  # noqa: E402


def main():
    beta = float(sys.argv[1])
    R = int(sys.argv[2])
    delta = float(sys.argv[3])
    nsamp = int(sys.argv[4]) if len(sys.argv) > 4 else 4
    L = 4 * R
    ntherm, nmeas = 4000, 6000
    out = {"beta": beta, "R": R, "L": L, "delta": delta, "eps": 0.3, "ntherm": ntherm,
           "nmeas": nmeas, "samples": []}
    t0 = time.time()
    for k in range(nsamp):
        g = np.random.default_rng(10_000 + 100 * R + k + int(1000 * delta)).normal(size=(L, L, 3))
        res = {"sample": k, "runs": []}
        for ring in (+1, -1):
            for start in ("up", "down"):
                seedv = 7_000_000 + int(1000 * beta) * 1000 + 37 * R + 11 * k \
                    + (0 if start == "up" else 5) + (0 if ring > 0 else 2) + int(1000 * delta)
                rng = np.random.default_rng(seedv)
                seed(seedv)
                s, frozen, inner, c = setup(L, R, ring, start, rng)
                v = s[frozen] + delta * g[frozen]
                s[frozen] = v / np.linalg.norm(v, axis=1)[:, None]
                s0, mi, en, acc = run_chain(s, beta, frozen, inner, c, ntherm, nmeas)
                h = nmeas // 2
                res["runs"].append({"ring": ring, "start": start, "seed": seedv,
                                    "mean_s0z": float(s0.mean()),
                                    "halves": [float(s0[:h].mean()), float(s0[h:].mean())],
                                    "mean_m_inner": float(mi.mean())})
        sp = np.mean([r["mean_s0z"] for r in res["runs"] if r["ring"] > 0])
        sm = np.mean([r["mean_s0z"] for r in res["runs"] if r["ring"] < 0])
        res["Delta"] = float(sp - sm)
        res["start_spread"] = float(max(
            abs(res["runs"][0]["mean_s0z"] - res["runs"][1]["mean_s0z"]),
            abs(res["runs"][2]["mean_s0z"] - res["runs"][3]["mean_s0z"])))
        out["samples"].append(res)
        print(f"beta={beta} R={R} delta={delta} sample {k}: Delta={res['Delta']:+.3f} "
              f"start spread={res['start_spread']:.3f} m_in: "
              f"{' '.join(f'{r['mean_m_inner']:+.2f}' for r in res['runs'])} ({time.time() - t0:.0f}s)",
              flush=True)
    d = [x["Delta"] for x in out["samples"]]
    out["Delta_mean"] = float(np.mean(d))
    out["Delta_se_over_samples"] = float(np.std(d, ddof=1) / math.sqrt(len(d)))
    print(f"beta={beta} R={R} delta={delta}: Delta = {out['Delta_mean']:+.3f} +- "
          f"{out['Delta_se_over_samples']:.3f} over {len(d)} noise samples", flush=True)
    with open(f"ring_noise_b2_beta{beta}_R{R}_d{delta}.json", "w") as f:
        json.dump(out, f, indent=1)


if __name__ == "__main__":
    main()
