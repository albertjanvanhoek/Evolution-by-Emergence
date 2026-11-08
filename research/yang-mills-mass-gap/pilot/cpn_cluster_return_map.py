# Two layer vertices 0,1 joined by k units (t-edge), each with ONE external unit to an outside vertex X.
# External return map rho on the 2 external strands: 'id' (strand from X re-exits at the same vertex) or 'swap'.
# Weight W(rho) = sum over pi_0, pi_1 inducing rho of q^{internal closed loops}/((q)_{k+1})^2. Fused vertex: ratio 1.
from itertools import permutations
from fractions import Fraction as F
q=3
def poch(d):
    r=1
    for i in range(d): r*=q+i
    return r
for k in range(0,6):
    # slots at vertex v: z-slots/zbar-slots indexed 0..k ; index 0 = external unit, 1..k = internal units
    # internal unit j: zbar at 0 -> z at 1 (j), zbar at 1 -> z at 0 (j); external: zbar at v -> X
    W={'id':F(0),'swap':F(0)}
    P=list(permutations(range(k+1)))
    for p0 in P:
        for p1 in P:
            pair={(0,a):(0,p0[a]) for a in range(k+1)}; pair.update({(1,a):(1,p1[a]) for a in range(k+1)})
            def go(zb):  # zbar slot (v,j) -> z slot at other vertex, or 'X'
                v,j=zb
                if j==0: return 'X'
                return (1-v,j)
            # external strand entering vertex v at z-slot (v,0): follow until exit
            ends={}
            used=set()
            for v in (0,1):
                cur=(v,0)
                while True:
                    used.add(cur); nxt=go(pair[cur])
                    if nxt=='X': ends[v]=pair[cur][0]; break
                    cur=nxt
            rho='id' if ends[0]==0 else 'swap'
            # internal closed loops: z-slots not used
            seen=set(used); loops=0
            for s in pair:
                if s in seen: continue
                loops+=1; cur=s
                while cur not in seen:
                    seen.add(cur); cur=go(pair[cur])
            W[rho]+=F(q**loops, poch(k+1)**2)
    print(f"k={k}: W(id)={float(W['id']):.6g} W(swap)={float(W['swap']):.6g} ratio swap/id={float(W['swap']/W['id']):.6f}")
