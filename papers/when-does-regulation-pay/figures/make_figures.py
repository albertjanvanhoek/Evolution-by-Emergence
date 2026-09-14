#!/usr/bin/env python3
"""Regenerate regulation-retention paper figures and worked-example data.

Standard library only.
"""
from pathlib import Path
import csv
import math

OUT = Path(__file__).resolve().parent

GAMMA=1.0
BETA=1.0
L=1.0
C1=0.2
C0=0.1
M=0.5
A=BETA*L-C1*GAMMA

ETA_SEL=C0*GAMMA**2/A
ETA_UNREG=M*GAMMA
ETA_ALIGN=A*M**2/C0

def linspace(a,b,n):
    h=(b-a)/(n-1)
    return [a+i*h for i in range(n)]

def k_opt(eta,n=1.0):
    if eta*A <= (C0/n)*GAMMA**2:
        return 0.0
    return (math.sqrt(n*eta*A/C0)-GAMMA)/BETA

def k_func(eta):
    return max(0.0,(eta/M-GAMMA)/BETA)

def selected_margin(eta,n=1.0):
    k=k_opt(eta,n)
    return M-eta/(GAMMA+BETA*k)

def escape(s):
    return str(s).replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")

def points(data,xmap,ymap):
    return " ".join(f"{xmap(x):.2f},{ymap(y):.2f}" for x,y in data)

def plot_svg(path,title,xlabel,ylabel,xlim,ylim,curves,vlines=(),shade_from=None,shade_label=""):
    W,H=900,540
    LFT,RGT,TOP,BOT=88,38,56,78
    x0,x1=LFT,W-RGT
    y0,y1=TOP,H-BOT
    def xm(x): return x0+(x-xlim[0])/(xlim[1]-xlim[0])*(x1-x0)
    def ym(y): return y1-(y-ylim[0])/(ylim[1]-ylim[0])*(y1-y0)
    p=[
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">',
        '<rect width="100%" height="100%" fill="white"/>'
    ]
    if shade_from is not None:
        sx=xm(shade_from)
        p.append(f'<rect x="{sx:.2f}" y="{y0}" width="{x1-sx:.2f}" height="{y1-y0}" fill="#999" opacity="0.16"/>')
        p.append(f'<text x="{(sx+x1)/2:.2f}" y="{y0+46}" text-anchor="middle" font-size="13">{escape(shade_label)}</text>')
    p += [
        f'<line x1="{x0}" y1="{y1}" x2="{x1}" y2="{y1}" stroke="black"/>',
        f'<line x1="{x0}" y1="{y0}" x2="{x0}" y2="{y1}" stroke="black"/>',
        f'<text x="{W//2}" y="28" text-anchor="middle" font-size="18" font-weight="bold">{escape(title)}</text>',
        f'<text x="{W//2}" y="{H-20}" text-anchor="middle" font-size="15">{escape(xlabel)}</text>',
        f'<text x="20" y="{H//2}" text-anchor="middle" font-size="15" transform="rotate(-90 20 {H//2})">{escape(ylabel)}</text>'
    ]
    if ylim[0] <= 0 <= ylim[1]:
        p.append(f'<line x1="{x0}" y1="{ym(0):.2f}" x2="{x1}" y2="{ym(0):.2f}" stroke="#555"/>')
    dashes=["","8,5","2,4","10,4,2,4"]
    for i,(label,data) in enumerate(curves):
        dash=dashes[i%len(dashes)]
        dd=f' stroke-dasharray="{dash}"' if dash else ""
        p.append(f'<polyline fill="none" stroke="black" stroke-width="2"{dd} points="{points(data,xm,ym)}"/>')
        p.append(f'<text x="{x0+12}" y="{y0+22+18*i}" font-size="13">{escape(label)}</text>')
    for xv,label in vlines:
        p.append(f'<line x1="{xm(xv):.2f}" y1="{y0}" x2="{xm(xv):.2f}" y2="{y1}" stroke="black" stroke-dasharray="5,5"/>')
        p.append(f'<text x="{xm(xv)+4:.2f}" y="{y1-8}" font-size="11">{escape(label)}</text>')
    for i in range(6):
        xv=xlim[0]+i*(xlim[1]-xlim[0])/5
        yv=ylim[0]+i*(ylim[1]-ylim[0])/5
        p.append(f'<line x1="{xm(xv):.2f}" y1="{y1}" x2="{xm(xv):.2f}" y2="{y1+6}" stroke="black"/>')
        p.append(f'<text x="{xm(xv):.2f}" y="{y1+22}" text-anchor="middle" font-size="11">{xv:.2f}</text>')
        p.append(f'<line x1="{x0-6}" y1="{ym(yv):.2f}" x2="{x0}" y2="{ym(yv):.2f}" stroke="black"/>')
        p.append(f'<text x="{x0-10}" y="{ym(yv)+4:.2f}" text-anchor="end" font-size="11">{yv:.2f}</text>')
    p.append("</svg>")
    path.write_text("\n".join(p),encoding="utf-8")

def main():
    etas=linspace(0.0,3.5,500)
    plot_svg(
        OUT/"regulatory_gain_alignment.svg",
        "Selected regulation can become functionally insufficient",
        "Disturbance load eta",
        "Controller gain",
        (0,3.5),(0,6.5),
        [
            ("selected gain k_opt",[(e,k_opt(e)) for e in etas]),
            ("function-preserving gain k_func",[(e,k_func(e)) for e in etas]),
        ],
        vlines=[
            (ETA_SEL,"selection onset"),
            (ETA_UNREG,"unregulated failure"),
            (ETA_ALIGN,"alignment boundary"),
        ],
        shade_from=ETA_ALIGN,
        shade_label="selected controller below functional requirement"
    )

    etas2=linspace(0.0,8.5,600)
    plot_svg(
        OUT/"functional_margin_pooling.svg",
        "Pooling constitutive cost expands the region of sufficient selected control",
        "Disturbance load eta",
        "Functional margin at selected optimum",
        (0,8.5),(-0.65,0.55),
        [
            ("unpooled n=1",[(e,selected_margin(e,1)) for e in etas2]),
            ("pooled n=4",[(e,selected_margin(e,4)) for e in etas2]),
        ],
        vlines=[
            (ETA_ALIGN,"n=1 boundary"),
            (4*ETA_ALIGN,"n=4 boundary"),
        ]
    )

    rows=[0,ETA_SEL,0.25,ETA_UNREG,1,ETA_ALIGN,3,8]
    with (OUT/"worked_example.csv").open("w",newline="",encoding="utf-8") as fh:
        w=csv.writer(fh,lineterminator="\n")
        w.writerow(["eta","k_opt_n1","k_func","margin_n1","k_opt_n4","margin_n4"])
        for e in rows:
            w.writerow([
                f"{e:.6f}",
                f"{k_opt(e,1):.9f}",
                f"{k_func(e):.9f}",
                f"{selected_margin(e,1):.9f}",
                f"{k_opt(e,4):.9f}",
                f"{selected_margin(e,4):.9f}",
            ])

if __name__=="__main__":
    main()
