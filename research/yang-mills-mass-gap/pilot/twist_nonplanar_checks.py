"""Deterministic checks for TWIST_NONPLANAR.md; no spin simulation.

Run from pilot/: OPENBLAS_NUM_THREADS=1 python twist_nonplanar_checks.py
Requires NumPy. Outputs go to twist_nonplanar_out/ beside this script.
The finite numerical checks do not certify the asymptotic theorem.
"""

import json
import math
from pathlib import Path
import time

import numpy as np


OUT = Path(__file__).resolve().parent / "twist_nonplanar_out"


def step(t):
    """C-infinity increasing step, together with its derivative."""
    t = np.asarray(t, dtype=float)
    value = np.zeros_like(t)
    deriv = np.zeros_like(t)
    value[t >= 1] = 1
    mask = (t > 0) & (t < 1)
    z = t[mask]
    left, right = np.exp(-1 / z), np.exp(-1 / (1 - z))
    s = left / (left + right)
    value[mask] = s
    deriv[mask] = s * (1 - s) * (z**-2 + (1 - z)**-2)
    return value, deriv


def square_cutoff(z, start, stop):
    value, deriv = step((np.abs(z) - start) / (stop - start))
    return 1 - value, -deriv * np.sign(z) / (stop - start)


def profiles(z):
    q, dq = square_cutoff(z, 1.2, 1.8)
    theta = q[:, 0] * q[:, 1]
    g = np.column_stack((dq[:, 0] * q[:, 1], q[:, 0] * dq[:, 1]))
    outer, _ = square_cutoff(z, 1.85, 1.95)
    inner, _ = square_cutoff(z, 1.05, 1.15)
    chi = outer.prod(axis=1) * (1 - inner.prod(axis=1))
    phi = np.stack(((chi[:, None] + g) / 2,
                    (chi[:, None] - g) / 2), axis=2)
    assert np.max(np.abs(phi[:, :, 0]**2 - phi[:, :, 1]**2 - g)) < 1e-12
    return theta, phi


def positive_modes(K, m):
    a, b = np.meshgrid(np.arange(-K, K + 1), np.arange(-K, K + 1), indexing="ij")
    p = np.column_stack((a.ravel(), b.ravel()))
    p = p[p[:, m] > 0]
    r = np.max(np.abs(p), axis=1)
    return p, r


def harmonic(K):
    return float(np.sum(1 / np.arange(1, K + 1, dtype=float)))


def frequency_coefficients(N, K, vectors):
    """Direct sine sums; verify (B4) and the explicit cubic upper bound."""
    a = math.pi / (8 * N)
    lam = 3 * math.pi / 8 * harmonic(K)
    result = np.zeros((len(vectors), 2))
    max_remainder_ratio = 0.0
    for m in range(2):
        p, r = positive_modes(K, m)
        for shell in range(1, K + 1):
            ps = p[r == shell]
            assert len(ps) == 4 * shell - 1
            assert int(ps[:, m].sum()) == 3 * shell**2
            assert int(ps[:, 1 - m].sum()) == 0
        weights = r.astype(float)**-3
        moment = float(weights @ p[:, m])
        assert math.isclose(N * a * moment, lam, rel_tol=2e-14)
        for j, v in enumerate(vectors):
            phase = a * (p @ v)
            result[j, m] = weights @ np.sin(phase)
            discrepancy = abs(result[j, m] - lam * v[m] / N)
            # |sin u-u| <= |u|^3/6, summed before any shell bound.
            bound = float(weights @ (np.abs(phase)**3 / 6))
            assert discrepancy <= bound + 2e-14
            if bound:
                max_remainder_ratio = max(max_remainder_ratio, discrepancy / bound)
    return lam, result, max_remainder_ratio


def graph(N, vectors, deleted=False):
    axis = np.arange(-2 * N, 2 * N + 1)
    a, b = np.meshgrid(axis, axis, indexing="ij")
    points = np.column_stack((a.ravel(), b.ravel()))
    keep = np.max(np.abs(points), axis=1) >= N
    if deleted:
        keep &= (points[:, 0] + 2 * points[:, 1]) % 7 != 0
    points = points[keep]
    lookup = np.full((4 * N + 1, 4 * N + 1), -1, dtype=int)
    lookup[points[:, 0] + 2 * N, points[:, 1] + 2 * N] = np.arange(len(points))
    blocks = []
    for v in vectors:
        target = points + v
        good = np.max(np.abs(target), axis=1) <= 2 * N
        if deleted:
            good &= (3 * points[:, 0] + points[:, 1]) % 5 != 0
        origin = np.flatnonzero(good)
        dest = lookup[target[good, 0] + 2 * N, target[good, 1] + 2 * N]
        present = dest >= 0
        blocks.append((origin[present], dest[present]))
    return points, blocks


def transfer_check(N, vectors, deleted):
    points, blocks = graph(N, vectors, deleted)
    theta, phi = profiles(points / N)
    rows = []
    for label, K in (("sqrt", math.isqrt(N)), ("full", N)):
        lam, coeff, remainder_ratio = frequency_coefficients(N, K, vectors)
        l1 = maxerr = h2 = maxsum = 0.0
        edges = 0
        for j, (x, y) in enumerate(blocks):
            h = theta[y] - theta[x]
            B = phi[x, :, 0] * phi[y, :, 0] - phi[x, :, 1] * phi[y, :, 1]
            ht = B @ coeff[j] / lam
            err = np.abs(h - ht)
            l1 += float(err.sum())
            maxerr = max(maxerr, float(err.max(initial=0)))
            maxsum = max(maxsum, float(np.max(np.abs(h + ht), initial=0)))
            h2 += float(h @ h)
            edges += len(x)
        rows.append(dict(N=N, cutoff=label, K=K, deleted=deleted,
                         vertices=len(points), edges=edges, lambda_value=lam,
                         h_l2=math.sqrt(h2), error_l1=l1,
                         logN_times_error_l1=math.log(N) * l1,
                         N2_logN_times_max_error=N**2 * math.log(N) * maxerr,
                         N_times_max_h_plus_ht=N * maxsum,
                         sine_remainder_ratio=remainder_ratio))
    return rows


def dense_check(N, ell):
    """Check the raw current and factorization on all bounded displacements."""
    vectors = np.array([(i, j) for i in range(-ell, ell + 1)
                        for j in range(-ell, ell + 1)
                        if i > 0 or (i == 0 and j > 0)], dtype=int)
    points, blocks = graph(N, vectors, deleted=True)
    theta, phi = profiles(points / N)
    K, a = math.isqrt(N), math.pi / (8 * N)
    lam, coeff, _ = frequency_coefficients(N, K, vectors)
    x = np.concatenate([block[0] for block in blocks])
    y = np.concatenate([block[1] for block in blocks])
    displacement = points[y] - points[x]
    assert np.max(np.abs(displacement)) == ell
    pins = (np.max(np.abs(points), axis=1) == N) | (np.max(np.abs(points), axis=1) == 2 * N)
    differences, sup2, current = [], [], np.zeros(len(x), dtype=complex)
    group_op_norms = []
    factor_error = 0.0
    for m in range(2):
        p, r = positive_modes(K, m)
        for sign_idx, sign in enumerate((1, -1)):
            wave = np.exp(1j * a * (points @ (sign * p).T))
            ph = phi[:, m, sign_idx]
            f = ph[:, None] * wave * r[None, :]**-1.5
            assert np.max(np.abs(f[pins]), initial=0) == 0
            df = f[y] - f[x]
            current += .5 * (f[x] * f[y].conj() - f[x].conj() * f[y]).sum(axis=1)
            U = df * np.sqrt(r)[None, :]
            # Independently evaluate the two summands of (B11).
            factored = ((ph[y] - ph[x])[:, None] * wave[x] / r[None, :]
                        + ph[y, None] * wave[x]
                        * np.expm1(1j * a * (displacement @ (sign * p).T)) / r[None, :])
            factor_error = max(factor_error, float(np.max(np.abs(U - factored))))
            group_op_norms.append(float(np.sqrt(np.linalg.eigvalsh(U.conj().T @ U)[-1])))
            differences.append(df)
            sup2.append(np.max(np.abs(f), axis=0)**2)
    expected = []
    for j, (bx, by) in enumerate(blocks):
        B = phi[bx, :, 0] * phi[by, :, 0] - phi[bx, :, 1] * phi[by, :, 1]
        expected.append(-1j * (B @ coeff[j]))
    current_error = float(np.max(np.abs(current - np.concatenate(expected))))
    assert current_error < 2e-12
    assert factor_error < 2e-12
    df = np.concatenate(differences, axis=1)
    supremum2 = np.concatenate(sup2)
    energy2 = np.sum(np.abs(df)**2, axis=0)
    gram = df.conj().T @ df
    hs2 = float(np.sum(np.abs(gram)**2))  # ||dF dF*||_HS^2 = ||dF* dF||_HS^2
    paircost = float(np.minimum(supremum2[:, None] * energy2[None, :],
                                energy2[:, None] * supremum2[None, :]).sum())
    return dict(N=N, ell=ell, K=K, vertices=len(points), edges=len(x),
                modes=df.shape[1], exact_current_max_error=current_error,
                operator_factorization_max_error=factor_error,
                group_operator_norms=group_op_norms, T_HS_squared=hs2,
                pair_cost=paircost, family_cost_over_HK=(hs2 + paircost) / harmonic(K),
                lambda_value=lam)


def main():
    started = time.monotonic()
    # Check every direction at range four, including axial length > 1.
    vectors = np.array([(i, j) for i in range(-4, 5) for j in range(-4, 5)
                        if i > 0 or (i == 0 and j > 0)], dtype=int)
    moments = []
    for N in (16, 64, 256):
        lam, _, ratio = frequency_coefficients(N, math.isqrt(N), vectors)
        moments.append(dict(N=N, K=math.isqrt(N), directions=len(vectors),
                            lambda_value=lam, max_sine_remainder_ratio=ratio))
    stencil = np.array([(1, 0), (0, 1), (1, 1), (2, 1), (0, 2)])
    transfers = []
    for N in (16, 32, 64, 128):
        for deleted in (False, True):
            transfers.extend(transfer_check(N, stencil, deleted))
    dense = [dense_check(N, 2) for N in (8, 16)]
    out = dict(description="Finite numerical checks only; the proof is in TWIST_NONPLANAR.md.",
               numpy_version=np.__version__, frequency_checks=moments,
               transfer_checks=transfers, dense_checks=dense,
               seconds=time.monotonic() - started)
    OUT.mkdir(exist_ok=True)
    path = OUT / "deterministic_checks.json"
    path.write_text(json.dumps(out, indent=2) + "\n")
    print(f"All assertions passed in {out['seconds']:.2f}s; output: {path.name}")
    for row in transfers:
        if not row["deleted"]:
            print(f"N={row['N']:3d} {row['cutoff']:4s}: "
                  f"L1={row['error_l1']:.6g}; log(N)*L1={row['logN_times_error_l1']:.6g}")
    for row in dense:
        print(f"Dense N={row['N']}: current error={row['exact_current_max_error']:.3g}; "
              f"factorization error={row['operator_factorization_max_error']:.3g}")


if __name__ == "__main__":
    main()
