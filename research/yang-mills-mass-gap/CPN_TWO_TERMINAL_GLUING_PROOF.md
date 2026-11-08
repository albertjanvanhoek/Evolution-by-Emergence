# A proof of the event-resolved gluing identity (B3) without deletion or reinsertion (8 November 2026)

**Status:** a proof answering the question in [`CPN_TWO_TERMINAL_INDEPENDENT_AUDIT.md`](CPN_TWO_TERMINAL_INDEPENDENT_AUDIT.md). Written by one model family. **Checked step by step by the other** (PR #144, comment of 8 November 2026, 11:14 UTC): it agrees with steps 1–5, including several paths meeting at the outer vertex. A human check is still needed before citation. Nothing here goes beyond the two-terminal setting of [`CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md`](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md). **It is not an annulus theorem and says nothing about Yang–Mills.**

## The claim

Setting of §1 of the two-terminal note: u and v are pinned at overlap p and joined only to the free gateway x, with strengths b_u, b_v. H is any finite network with terminals x and a, with nonnegative strengths and any cycles. a is the only outer marked site, free. E is the event that some index loop visits both {u, v} and a. Then, for every integer q ≥ 2,

  (B3)  Z(p) = G(p) Σ_n c_n n!/(q)_n,  Z_NC(p) = Σ_{d,n} w_d(p) c_n n!/(q+d)_n,

with K_H(z) = Σ c_n zⁿ the two-pinned kernel (B1), and w_d, G as in (A2) of that note. The equality holds coefficient by coefficient in every coupling and in p, so it also holds at fixed edge multiplicities.

The audit accepts (B1) and flags the step from (B1) to (B3). The original proof deletes same-terminal return arcs and must show that the deletion preserves the crossing event. **The proof below does not delete anything.** It uses (B1) only as a statement about a partition function with two pinned terminals.

## Proof

**Step 1. Z_NC is a partition function with a pinned (q ≥ 3).** Let e₃ be a unit vector orthogonal to span(z_u, z_v), and P_⊥ = e₃e₃†. Claim: Z_NC = Z(P_a = P_⊥).

Fix all edge multiplicities and the permutations at every free vertex except a. Call this the *data*. The index lines then form closed loops that avoid u, v and a (each with weight q) and *arcs*, maximal segments whose ends are slots at u, v or a. Call the data *crossing* if some arc has one end at a and the other at u or v.

- *E is decided by the data.* If the data are crossing, the loop that contains that arc visits a and u or v, whatever the permutation π_a at a. If not, the arcs from a all return to a. π_a then joins them only to each other, and the loops through u or v consist of arcs between u and v alone. So E fails for every π_a.
- *a free, data not crossing.* The vertex factor at a is 1/(q)_{d_a}, and π_a closes the a-arcs, in their fixed pairing ρ, into cycles of π_a∘ρ, each a loop of weight q. Since Σ_{π ∈ S_d} q^{cyc(π∘ρ)} = (q)_d, the sum over π_a cancels the vertex factor. What remains is the data weight times the weight W_uv of the loops through u and v.
- *a pinned to P_⊥.* There is no sum at a. A loop through pinned sites has weight equal to the product of the overlaps between consecutive pinned visits. If the data are crossing, some loop has a visit to a next to a visit to u or v, so it carries ⟨e₃|z_u⟩ or ⟨e₃|z_v⟩ (or the conjugate), which is 0. If not, loops through a visit only a, with weight ⟨e₃|e₃⟩ = 1 per arc, and the rest gives W_uv.

So both sides are the sum, over non-crossing data, of the data weight times W_uv. ∎ The argument is local to a. It does not use how many strands or networks meet at a, which settles the doubt raised in [`CPN_MULTI_GATEWAY.md`](CPN_MULTI_GATEWAY.md).

**Step 2. Integrate the interior of H.** With a pinned to P_⊥ and x fixed, the interior of H integrates to K_H(tr(P_x P_⊥)) = Σ c_n |⟨x, e₃⟩|²ⁿ. This is (B1), which needs only positivity of a two-pinned partition function, not any event. So

  Z_NC = Σ_n c_n ∫ dω(x) e^{⟨x|B|x⟩} |⟨x, e₃⟩|²ⁿ,  B = b_u P_u + b_v P_v.

**Step 3. Integrate x.** Write x = (x_∥, x₃, x_rest), with x_∥ in span(z_u, z_v). For x uniform on the unit sphere of Cᵠ, (|x_∥|², |x₃|², |x_rest|²) is Dirichlet(2, 1, q−3), independent of the direction x̂_∥, which is uniform on the unit sphere of C². Since ⟨x|B|x⟩ = |x_∥|² ⟨x̂_∥|B|x̂_∥⟩,

  E[⟨x|B|x⟩ᵈ |x₃|²ⁿ] = E[|x_∥|^{2d} |x₃|²ⁿ] · E[⟨x̂_∥|B|x̂_∥⟩ᵈ]
   = [(q−1)! (d+1)! n! / (q+d+n−1)!] · [d! H_d(λ₊, λ₋) / (2)_d].

The second factor is the CP¹ moment, the q = 2 case of the formula behind (A2). Since (2)_d = (d+1)!, this is d! H_d n!/(q)_{d+n}. Summing over d with 1/d!:

  Z_NC = Σ_{d,n} H_d c_n n!/(q)_{d+n} = Σ_{d,n} w_d(p) c_n n!/(q+d)_n,

because (q)_{d+n} = (q)_d (q+d)_n. That is (B3). ∎

**Step 4. Z(p).** Average over P_a instead: ∫ dω(a) K_H(|⟨x, a⟩|²) = Σ c_n n!/(q)_n does not depend on x, so Z = G(p) C_H. This part was never in doubt.

**At p = 1** span(z_u, z_v) is a line. Take any 2-plane containing it and e₃ orthogonal to that plane; steps 1–3 are unchanged.

**Step 5. q = 2.** Steps 1–3 need e₃, so q ≥ 3. At q = 2 there is no physical orthogonal direction in C², so what is continued is not that construction. It is the identity between two combinatorial expressions in the positive loop representation, at fixed edge multiplicities. Both sides of (B3) are power series in the couplings, convergent for all values. Their coefficients are rational functions of q: on the left, finite sums over permutations of powers of q divided by rising factorials; on the right, the same for c_n, times H_d and n!/(q+d)_n. Equality for all nonnegative couplings gives equality of every coefficient, for every integer q ≥ 3. Rational functions that agree at infinitely many points are equal, and none has a pole at q = 2. So (B3) holds at q = 2 as well. ∎

## The audit's question, answered

> Can the cyclic-word-preserving trace deletion be turned into a bijection …, or is there a wiring type not captured by n in K_H(z)?

There is no such wiring type. By steps 1–3, Z_NC depends on H only through K_H. **Two tangles with the same coefficients c_n give the same no-crossing weights**, so the falsification route proposed in the audit cannot succeed. The deletion bijection may well exist, but the theorem no longer needs it.

## Checks (`pilot/cpn_gluing_spin_check.py`, about two seconds)

1. **Step 3, exact.** In rational arithmetic, E[⟨x|B|x⟩ᵈ|x₃|²ⁿ]/d! = H_d n!/(q)_{d+n} at p = 0 and p = 1, for q = 3, 4, 5, 6, d ≤ 5, n ≤ 4, two sets of strengths.
2. **Serial network** u, v – x – y – a, all strengths 1, q = 3. The spin integral (y in closed form, x by quadrature, a pinned to e₃) reproduces the table in §4 of the two-terminal note to all 12 digits printed there, at p = 0, 0.25, 0.5, 0.75 and 1.
3. **Network with a cycle,** triangle x – y – a plus an edge x – a, full exponential model, q = 3, three sets of strengths, p = 0, 0.3, 0.7, 1. Spin integral and (B3) agree to a relative error of at most 1.1·10⁻¹⁵, for both Z and Z_NC.

The audit's 18 exact enumerations at fixed multiplicity (q = 2, 3, 5) are consistent with this proof. They test the same identity, coefficient by coefficient.

## What this changes

- [`CPN_UNIFORM_RELATIVE_SLOPE.md`](CPN_UNIFORM_RELATIVE_SLOPE.md) and [`CPN_MULTI_GATEWAY_STABILITY.md`](CPN_MULTI_GATEWAY_STABILITY.md) rely on (B3). With this proof they are no longer conditional on the deletion lemma, but they are now conditional on this proof being checked.
- The separate-routes theorem in [`CPN_MULTI_GATEWAY.md`](CPN_MULTI_GATEWAY.md) never used (B3). It uses (B1) and the identity of step 1.
- The scope is unchanged: one gateway and one outer site for (B3) itself. Gateways joined to u, v and a, outer layers with many sites, and uniformity over the annulus remain open.

## Where I'm unsure

- Step 1 is the identity of my own earlier note, now written out in full. The other model family has checked it; a human has not.
- Step 3 uses the standard Dirichlet law of |x_i|² for a uniform vector, grouped into blocks, and the independence of the direction within a block. I checked the result exactly but did not cite a source for the grouping property.
- Step 5 assumes that the loop representation's coefficients are the same rational expression of q for every integer q. That is how the representation is built, but I have not seen it stated in Wolff (2010).
