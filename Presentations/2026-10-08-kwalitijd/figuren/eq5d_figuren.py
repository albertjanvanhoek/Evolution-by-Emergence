"""Presentatiefiguren op basis van de aangeleverde Nederlandse EQ-5D-5L-code.
Run: python eq5d_figuren.py (vereist matplotlib en numpy).
"""
from pathlib import Path
from io import BytesIO
from itertools import product
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.patches import FancyBboxPatch

OUT = Path(__file__).resolve().parent
D = np.array([[0,.035,.057,.166,.203], [0,.038,.061,.168,.168],
              [0,.039,.087,.192,.192], [0,.066,.092,.360,.415],
              [0,.070,.145,.356,.421]])
COLORS = ['#277F9A','#427BA8','#558662','#BE7230','#956198']
INK, MUTED, BG = '#173146', '#556675', '#FBFCFE'
DOMAINS = ['Mobiliteit','Zelfzorg','Dagelijkse\nactiviteiten','Pijn /\nongemak','Angst /\nsomberheid']
def fmt(x): return f'{x:.3f}'.replace('.',',')
def score(profile):
    if len(profile)!=5 or any(x not in range(1,6) for x in profile):
        raise ValueError('Een profiel heeft vijf gehele niveaus van 1 tot en met 5.')
    return round(1. if all(x==1 for x in profile) else 1-.047-sum(D[i,x-1] for i,x in enumerate(profile)),3)

plt.rcParams.update({'font.family':'DejaVu Sans','font.size':13,'text.color':INK,
                     'axes.labelcolor':MUTED,'xtick.color':MUTED,'ytick.color':INK,
                     'pdf.fonttype':42,'svg.fonttype':'none'})

def base(kicker, title, subtitle):
    fig=plt.figure(figsize=(16,9),facecolor=BG)
    fig.text(.055,.942,kicker,fontsize=12,weight='bold',color='#277F9A')
    fig.text(.055,.881,title,fontsize=29,weight='bold')
    fig.text(.055,.829,subtitle,fontsize=15,color=MUTED)
    return fig

def footer(fig,extra):
    fig.text(.055,.075,extra,fontsize=11,color=MUTED)
    fig.text(.055,.039,'Bron: aangeleverde Stata-code; Nederlands tarief — Versteegh et al. (2016), doi:10.1016/j.jval.2016.01.003.',fontsize=10,color=MUTED)

fig1=base('EQ-5D-5L  •  NEDERLANDSE WAARDERING',
          'Vijf domeinen. Vijf niveaus. Eén gezondheidsscore.',
          'Hoe langer de balk, hoe groter de aftrek van de score. Kies per domein één niveau.')
left,right,gap=.19,.962,.029
width=(right-left-4*gap)/5
levels=['1  Geen problemen','2  Lichte problemen','3  Matige problemen','4  Ernstige problemen','5  Extreem / niet in staat*']
for i in range(5):
    ax=fig1.add_axes([left+i*(width+gap),.325,width,.405],facecolor=BG)
    ax.set_xlim(0,.52); ax.set_ylim(4.55,-.6)
    for y in range(5):
        ax.barh(y,.45,height=.48,color='#EAF0F5',zorder=0)
    ax.barh(np.arange(5),D[i],height=.48,color=COLORS[i],zorder=2)
    for y,v in enumerate(D[i]):
        ax.text(v+.012,y,fmt(v),va='center',fontsize=12,weight='bold',color=INK)
    ax.set_yticks(range(5),levels if i==0 else ['']*5)
    ax.tick_params(axis='y',length=0,pad=15,labelsize=12)
    ax.set_xticks([0,.2,.4],['0','0,2','0,4'])
    ax.tick_params(axis='x',length=0,labelsize=11)
    for s in ax.spines.values(): s.set_visible(False)
    ax.set_title(DOMAINS[i],fontsize=15,weight='bold',color=COLORS[i],pad=16)
fig1.text(.575,.266,'Aftrek van de gezondheidsscore  →',ha='center',fontsize=12,color=MUTED)
box=FancyBboxPatch((.055,.128),.905,.094,boxstyle='round,pad=0.012',transform=fig1.transFigure,
                   facecolor='#EAF0F5',edgecolor='none')
fig1.add_artist(box)
fig1.text(.074,.183,'Score = 1 − 0,047 − de vijf gekozen aftrekken',fontsize=19,weight='bold',va='center')
fig1.text(.074,.144,'Uitzondering: nergens problemen (11111)? Dan is de score precies 1,000; er is geen vaste aftrek.',fontsize=12)
footer(fig1,'* Vereenvoudigde labels; niveau 5 betekent niet in staat bij de eerste drie domeinen, extreem bij de laatste twee.')

profile=(2,1,2,3,2)
deductions=[.047]+[float(D[i,l-1]) for i,l in enumerate(profile)]
u=score(profile)
fig2=base('VAN ANTWOORDEN NAAR SCORE',
          'Zo wordt een gezondheidsprofiel een QALY-gewicht',
          'Voorbeeld 21232: lichte problemen met lopen en activiteiten, matige pijn, lichte angst / somberheid.')
ax=fig2.add_axes([.085,.307,.865,.445],facecolor=BG)
ax.set_ylim(0,1.13); ax.set_xlim(-.65,7.65)
ax.set_yticks([0,.25,.5,.75,1],['0','0,25','0,50','0,75','1,00'])
ax.set_ylabel('Gezondheidsscore',labelpad=12)
ax.grid(axis='y',color='#E2E8EF',lw=.8,zorder=0)
ax.bar(0,1,width=.65,color='#35566E',zorder=3)
ax.text(0,1.035,'1,000',ha='center',fontsize=17,weight='bold')
current=1.
for j,(v,c) in enumerate(zip(deductions,['#8D9CA7']+COLORS),1):
    following=current-v
    ax.plot([j-1+.325,j-.325],[current,current],color='#9CAAB5',lw=1.1,zorder=2)
    if v>0: ax.bar(j,v,bottom=following,width=.65,color=c,zorder=3)
    else: ax.plot([j-.325,j+.325],[current,current],color=c,lw=3,zorder=3)
    ax.text(j,current+.028,'−'+fmt(v) if v>0 else '0,000',ha='center',fontsize=14,weight='bold',color=c)
    current=following
ax.plot([6.325,6.675],[u,u],color='#9CAAB5',lw=1.1)
ax.bar(7,u,width=.65,color='#247C6D',zorder=3)
ax.text(7,u+.035,fmt(u),ha='center',fontsize=22,weight='bold',color='#247C6D')
ax.set_xticks(range(8),['Volledige\ngezondheid','Vaste\naftrek','Mobiliteit\nniveau 2','Zelfzorg\nniveau 1',
                     'Activiteiten\nniveau 2','Pijn\nniveau 3','Angst / somber\nniveau 2','Uiteindelijke\nscore'])
ax.tick_params(axis='both',length=0,labelsize=11,pad=12)
for s in ax.spines.values(): s.set_visible(False)
box=FancyBboxPatch((.055,.137),.905,.069,boxstyle='round,pad=0.012',transform=fig2.transFigure,
                  facecolor='#E5F0ED',edgecolor='none')
fig2.add_artist(box)
fig2.text(.075,.169,'Eén jaar in deze gezondheidstoestand = 0,717 QALY',fontsize=22,weight='bold',va='center',color='#246B5F')
footer(fig2,'1 = volledige gezondheid; 0 = de waardering van dood. Scores kunnen negatief zijn: het minimum in dit tarief is −0,446.')

# Rekencontroles: plafond, vaste aftrek, voorbeeld, ondergrens en monotonie.
assert score((1,1,1,1,1))==1
assert score((2,1,1,1,1))==.918
assert u==.717
scores=[score(p) for p in product(range(1,6),repeat=5)]
assert min(scores)==-.446 and max(scores)==1
assert np.all(np.diff(D,axis=1)>=0)

for figure, filename in [(fig1,'eq5d-5l-overzicht.png'),(fig2,'eq5d-5l-rekenvoorbeeld.png')]:
    buffer=BytesIO()
    figure.savefig(buffer,format='png',dpi=220,facecolor=BG)
    (OUT/filename).write_bytes(buffer.getvalue())
with PdfPages(OUT/'eq5d-5l-presentatie.pdf') as pdf:
    pdf.savefig(fig1,facecolor=BG)
    pdf.savefig(fig2,facecolor=BG)
print('Gemaakt: twee PNG-figuren en een PDF met twee pagina’s. Alle rekencontroles geslaagd.')
