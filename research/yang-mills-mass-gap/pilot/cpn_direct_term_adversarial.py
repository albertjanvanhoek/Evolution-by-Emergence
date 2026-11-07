import sys; sys.path.insert(0,".")
exec(open("cpn_direct_term.py").read().split('graphs={')[0])
# leaves: I = {0,1}, O = {2,3}; hubs u=4, v=5. Leaf edges a1-u, c1-u, a2-v, c2-v (and crossed variant); test adding units on u-v.
for name,leaf in [("parallel", [(0,4),(2,4),(1,5),(3,5)]), ("crossed", [(0,4),(3,4),(1,5),(2,5)]), ("one-sided", [(0,4),(1,4),(2,5),(3,5)])]:
    marked={0:'I',1:'I',2:'O',3:'O'}
    cnt=bad=0; worst=None
    for ks in product((0,1),repeat=4):
        le=[e for e,k in zip(leaf,ks) for _ in range(k)]
        prev=None
        for m in range(0,4):
            p=PE(6, le+[(4,5)]*m, marked)
            if p is None: continue
            if prev is not None:
                cnt+=1; d=p-prev
                if d<0:
                    bad+=1
                    if worst is None or d<worst[0]: worst=(d,ks,m)
            prev=p
    print(f"q={q} {name}: {cnt} additions on the hub-hub edge, {bad} decreases"+(f"; worst {float(worst[0]):+.6f} at leaves {worst[1]}, m {worst[2]-1}->{worst[2]}" if worst else ""),flush=True)
