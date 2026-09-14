#!/usr/bin/env python3
"""Regenerate paper figures and sensitivity data.

Uses only the Python standard library.
"""
from pathlib import Path
import csv
import math

OUT = Path(__file__).resolve().parent

J = 2.0
D = 1.0
ELL = 1.0
THETA_B = 0.15
F_STAR = 0.719820577300739
M0 = 0.773242158072694
KAPPA_WORKED = 0.360

def linspace(a, b, n):
    if n == 1:
        return [a]
    step = (b-a)/(n-1)
    return [a+i*step for i in range(n)]

def escape(s):
    return str(s).replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")

def polyline(points, xmap, ymap):
    return " ".join(f"{xmap(x):.2f},{ymap(y):.2f}" for x,y in points)

def svg_plot(path, *, title, xlabel, ylabel, xlim, ylim, curves,
             vlines=(), shade_from=None, shade_label="",
             right_curves=(), right_ylim=None, right_ylabel=""):
    W,H=900,540
    L,R,T,B=92,88,56,78
    x0,x1=L,W-R
    y0,y1=T,H-B
    def xm(x):
        return x0+(x-xlim[0])/(xlim[1]-xlim[0])*(x1-x0)
    def ym(y):
        return y1-(y-ylim[0])/(ylim[1]-ylim[0])*(y1-y0)

    p=[
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">',
        '<rect width="100%" height="100%" fill="white"/>'
    ]

    if shade_from is not None:
        sx=xm(shade_from)
        p.append(f'<rect x="{sx:.2f}" y="{y0}" width="{x1-sx:.2f}" height="{y1-y0}" fill="#999" opacity="0.16"/>')
        p.append(f'<text x="{(sx+x1)/2:.2f}" y="{ym(ylim[0]+0.18*(ylim[1]-ylim[0])):.2f}" text-anchor="middle" font-size="14">{escape(shade_label)}</text>')

    p += [
        f'<line x1="{x0}" y1="{y1}" x2="{x1}" y2="{y1}" stroke="black"/>',
        f'<line x1="{x0}" y1="{y0}" x2="{x0}" y2="{y1}" stroke="black"/>',
        f'<text x="{W//2}" y="28" text-anchor="middle" font-size="18" font-weight="bold">{escape(title)}</text>',
        f'<text x="{W//2}" y="{H-20}" text-anchor="middle" font-size="15">{escape(xlabel)}</text>',
        f'<text x="22" y="{H//2}" text-anchor="middle" font-size="15" transform="rotate(-90 22 {H//2})">{escape(ylabel)}</text>'
    ]

    if ylim[0] <= 0 <= ylim[1]:
        p.append(f'<line x1="{x0}" y1="{ym(0):.2f}" x2="{x1}" y2="{ym(0):.2f}" stroke="#555"/>')

    dashes=["","7,5","2,4"]
    for i,(label,data) in enumerate(curves):
        dash=dashes[i%len(dashes)]
        dd=f' stroke-dasharray="{dash}"' if dash else ""
        p.append(f'<polyline fill="none" stroke="black" stroke-width="2"{dd} points="{polyline(data,xm,ym)}"/>')
        p.append(f'<text x="{x0+12}" y="{y0+22+18*i}" font-size="13">{escape(label)}</text>')

    for xv,label in vlines:
        p.append(f'<line x1="{xm(xv):.2f}" y1="{y0}" x2="{xm(xv):.2f}" y2="{y1}" stroke="black" stroke-dasharray="6,5"/>')
        p.append(f'<text x="{xm(xv)+5:.2f}" y="{y0+18}" font-size="12">{escape(label)}</text>')

    for i in range(6):
        xv=xlim[0]+i*(xlim[1]-xlim[0])/5
        yv=ylim[0]+i*(ylim[1]-ylim[0])/5
        p.append(f'<line x1="{xm(xv):.2f}" y1="{y1}" x2="{xm(xv):.2f}" y2="{y1+6}" stroke="black"/>')
        p.append(f'<text x="{xm(xv):.2f}" y="{y1+23}" text-anchor="middle" font-size="11">{xv:.2f}</text>')
        p.append(f'<line x1="{x0-6}" y1="{ym(yv):.2f}" x2="{x0}" y2="{ym(yv):.2f}" stroke="black"/>')
        p.append(f'<text x="{x0-10}" y="{ym(yv)+4:.2f}" text-anchor="end" font-size="11">{yv:.2f}</text>')

    if right_curves and right_ylim is not None:
        def yr(y):
            return y1-(y-right_ylim[0])/(right_ylim[1]-right_ylim[0])*(y1-y0)
        p.append(f'<line x1="{x1}" y1="{y0}" x2="{x1}" y2="{y1}" stroke="black"/>')
        p.append(f'<text x="{W-18}" y="{H//2}" text-anchor="middle" font-size="15" transform="rotate(90 {W-18} {H//2})">{escape(right_ylabel)}</text>')
        for i,(label,data) in enumerate(right_curves):
            dash=dashes[(i+1)%len(dashes)]
            p.append(f'<polyline fill="none" stroke="#444" stroke-width="2" stroke-dasharray="{dash}" points="{polyline(data,xm,yr)}"/>')
            p.append(f'<text x="{x1-310}" y="{y0+22+18*(i+len(curves))}" font-size="13">{escape(label)}</text>')
        for i in range(6):
            yv=right_ylim[0]+i*(right_ylim[1]-right_ylim[0])/5
            p.append(f'<line x1="{x1}" y1="{yr(yv):.2f}" x2="{x1+6}" y2="{yr(yv):.2f}" stroke="black"/>')
            p.append(f'<text x="{x1+10}" y="{yr(yv)+4:.2f}" font-size="11">{yv:.2f}</text>')

    p.append("</svg>")
    path.write_text("\n".join(p), encoding="utf-8")

def main():
    fs=linspace(0.0,0.95,500)
    margin=[]
    lamcurve=[]
    xcurve=[]
    for f in fs:
        lam=math.sqrt(1+f)
        X=J/D-ELL/lam
        pB=(1-f)/(1+lam)
        margin.append((f,X*pB/THETA_B-1))
        lamcurve.append((f,lam))
        xcurve.append((f,X))

    svg_plot(
        OUT/"integrated_hollowing_margin.svg",
        title="Integrated innovation: efficiency rises while functional margin crosses zero",
        xlabel="Reallocation fraction f",
        ylabel="Functional margin M",
        xlim=(0,0.95), ylim=(-1,2.4),
        curves=[("Functional margin M",margin)],
        vlines=[(F_STAR,f"f* = {F_STAR:.3f}")],
        shade_from=F_STAR,
        shade_label="functional failure region (M < 0)",
        right_curves=[("lambda",lamcurve),("X*",xcurve)],
        right_ylim=(0.95,1.45),
        right_ylabel="Endogenous measures",
    )

    ks=linspace(0.0,1.15,500)
    mk=[(k,(M0-k)/(1+k)) for k in ks]
    ones=[(k,1.0) for k in ks]

    svg_plot(
        OUT/"downstream_extraction_margin.svg",
        title="One-way extraction: equilibrium metrics stay fixed while capacity margin is consumed",
        xlabel="One-way extraction kappa",
        ylabel="Functional margin M",
        xlim=(0,1.15), ylim=(-0.25,0.85),
        curves=[("Functional margin M",mk)],
        vlines=[
            (M0,f"kappa_crit = M0 = {M0:.3f}"),
            (KAPPA_WORKED,f"worked kappa = {KAPPA_WORKED:.3f}")
        ],
        shade_from=M0,
        shade_label="functional failure region (M < 0)",
        right_curves=[("lambda/lambda0 = X*/X*0 = 1 (coincident)",ones)],
        right_ylim=(0.85,1.15),
        right_ylabel="Normalized endogenous measures",
    )

    rows=[
        (0.05,0.9066925087774351),
        (0.10,0.8133752112353652),
        (0.15,0.7198205773007390),
        (0.20,0.6257267990162195),
        (0.25,0.5306799345904577),
        (0.30,0.43408743072445183),
    ]
    with (OUT/"threshold_sensitivity.csv").open("w",newline="",encoding="utf-8") as fh:
        w=csv.writer(fh)
        w.writerow(["theta_B","f_star"])
        root_text = {
            0.05: "0.9066925087774351",
            0.10: "0.8133752112353652",
            0.15: "0.7198205773007390",
            0.20: "0.6257267990162195",
            0.25: "0.5306799345904577",
            0.30: "0.43408743072445183",
        }
        for theta, _root in rows:
            w.writerow([f"{theta:.2f}", root_text[theta]])

if __name__=="__main__":
    main()
