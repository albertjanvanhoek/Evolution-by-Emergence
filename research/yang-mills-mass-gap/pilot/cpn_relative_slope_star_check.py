# (b) Relative slope h'(p) >= gamma h(p) on the one-sided star (H = leaf a), formulas (D3)-(D7)
import math
def check(q,bu,bv,ba):
    poch=lambda s,d: math.prod(s+i for i in range(d))
    f=lambda s,b: sum(b**m/poch(s,m) for m in range(120))
    s=bu+bv
    def h(p):
        D=bu*bv*(1-p); disc=math.sqrt(max(s*s-4*D,0)); lp,lm=(s+disc)/2,(s-disc)/2
        w=[sum(lp**j*lm**(d-j) for j in range(d+1))/poch(q,d) for d in range(120)]
        return 1-sum(wd*f(q+d,ba) for d,wd in enumerate(w))/(f(q,ba)*sum(w))
    g=2*bu*bv*math.exp(-2*s)/(q*(q+1)*(q+2))
    worst=min((h(min(p+1e-5,1))-h(max(p-1e-5,0)))/((min(p+1e-5,1)-max(p-1e-5,0))*h(p)) for p in [i/20 for i in range(21)])
    return worst,g
for q in (2,3,8):
    for bu,bv,ba in [(0.1,0.1,1),(1,1,1),(3,3,0.1),(1,0.2,10),(5,5,5)]:
        worst,g=check(q,bu,bv,ba)
        print(f"q={q} b=({bu},{bv},{ba}): min_p h'/h = {worst:.3e}  gamma = {g:.3e}  {'OK' if worst>=g else 'VIOLATED'}")
