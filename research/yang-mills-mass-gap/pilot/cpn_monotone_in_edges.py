import sys; sys.path.insert(0,".")
exec(open("cpn_direct_term.py").read().split('graphs={')[0])
graphs={
 "two-hub chain + I-edge": (5,[(0,3),(1,3),(3,4),(4,2),(0,1)],{0:'I',1:'I',2:'O'}),
 "two hubs both to I1,I2,O": (5,[(0,3),(1,3),(2,3),(0,4),(1,4),(2,4)],{0:'I',1:'I',2:'O'}),
 "hub+hub2 to O, O2 layer": (6,[(0,3),(1,3),(3,2),(1,4),(4,5),(3,5)],{0:'I',1:'I',2:'O',5:'O'}),
}
for name,(nv,base,marked) in graphs.items():
    cnt=bad=0; worst=None
    for ks in product((0,1),repeat=len(base)):
        e0=[e for e,k in zip(base,ks) for _ in range(k)]
        p0=PE(nv,e0,marked)
        if p0 is None: continue
        for j,e in enumerate(base):
            p1=PE(nv,e0+[e],marked)
            d=p1-p0; cnt+=1
            if d<0:
                bad+=1
                if worst is None or d<worst[0]: worst=(d,ks,e)
    print(f"q={q} {name}: {cnt} single-strand additions, {bad} decreases" + (f"; worst {float(worst[0]):+.5f} adding {worst[2]} at base {worst[1]}" if worst else ""),flush=True)
