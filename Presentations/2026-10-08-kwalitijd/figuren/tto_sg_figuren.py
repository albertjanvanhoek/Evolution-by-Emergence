"""Maak vier Nederlandstalige uitlegslides over TTO en SG; vereist matplotlib."""
from pathlib import Path
from io import BytesIO
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Rectangle, FancyArrowPatch
from matplotlib.backends.backend_pdf import PdfPages

OUT=Path(__file__).resolve().parent
BG,INK,MUTED='#FBFCFE','#173146','#556675'
BLUE,GREEN,RED,GRAY='#277F9A','#247C6D','#B45A60','#E4E9EE'
plt.rcParams.update({'font.family':'DejaVu Sans','font.size':13,'text.color':INK,'pdf.fonttype':42})

def text(fig,x,y,s,size=14,color=INK,weight='normal',**kw):
    return fig.text(x,y,s,fontsize=size,color=color,weight=weight,**kw)

def box(fig,x,y,w,h,color):
    p=FancyBboxPatch((x,y),w,h,boxstyle='round,pad=0.012',transform=fig.transFigure,facecolor=color,edgecolor='none',zorder=0)
    fig.add_artist(p)

def base(method,title,subtitle):
    f=plt.figure(figsize=(16,9),facecolor=BG)
    text(f,.055,.942,method,12,BLUE,'bold')
    text(f,.055,.882,title,29,weight='bold')
    text(f,.055,.832,subtitle,15,MUTED)
    box(f,.055,.724,.89,.055,'#EAF0F5')
    text(f,.073,.746,'Stel je voor: elke dag matige pijn die je dagelijkse activiteiten belemmert.',15,weight='bold',va='center')
    return f

def footer(f,line,source):
    text(f,.055,.074,line,10.5,MUTED)
    text(f,.055,.038,source,9.5,MUTED)

def tto(answer):
    f=base('TIME TRADE-OFF  •  TIJD AFWEGEN',
           'Hoeveel gezonde jaren wegen op tegen tien jaar met klachten?',
           'Twee zekere levenslopen. Alleen het aantal jaren in volledige gezondheid verandert.')
    ax=f.add_axes([.25,.335,.69,.32],facecolor=BG)
    ax.set_xlim(0,10.8);ax.set_ylim(-.65,1.7)
    ax.barh(1,10,height=.40,color=BLUE)
    ax.barh(1,.8,left=10,height=.40,color=GRAY)
    ax.barh(0,7,height=.40,color=GREEN)
    ax.barh(0,3.8,left=7,height=.40,color=GRAY)
    ax.text(5,1,'10 jaar met deze klachten',ha='center',va='center',color='white',fontsize=17,weight='bold')
    ax.text(3.5,0,'7 jaar in volledige gezondheid',ha='center',va='center',color='white',fontsize=16,weight='bold')
    ax.text(8.9,0,'Daarna overleden',ha='center',va='center',color=MUTED,fontsize=12)
    ax.annotate('Daarna overleden',xy=(10.4,1.02),xytext=(9.7,1.47),ha='right',color=MUTED,fontsize=12,
                arrowprops={'arrowstyle':'-','color':MUTED})
    ax.annotate('',xy=(10,-.38),xytext=(7,-.38),arrowprops={'arrowstyle':'<->','color':MUTED,'lw':1.3})
    ax.text(8.5,-.57,'3 jaar korter',ha='center',color=MUTED,fontsize=12)
    ax.set_yticks([1,0],['A  Met klachten','B  Volledig gezond'])
    ax.tick_params(axis='y',length=0,pad=19,labelsize=14)
    ax.set_xticks([0,2,4,6,7,8,10],['Nu','2','4','6','7','8','10 jaar'])
    ax.tick_params(axis='x',length=0,labelsize=11,pad=11,colors=MUTED)
    for sp in ax.spines.values():sp.set_visible(False)
    if answer:
        box(f,.055,.143,.89,.112,'#E5F0ED')
        text(f,.073,.214,'Stel: bij 7 jaar vind je A en B precies even aantrekkelijk.',18,weight='bold')
        text(f,.073,.166,'Dan is het TTO-gewicht van deze toestand: 7 / 10 = 0,70',22,GREEN,'bold')
    else:
        box(f,.055,.143,.89,.112,'#EAF0F5')
        text(f,.073,.214,'Wat kies je: A, B, of vind je ze even aantrekkelijk?',22,weight='bold')
        text(f,.073,.170,'Kies je A? Maak B langer. Kies je B? Maak B korter. Zoek het punt waarop je geen voorkeur hebt.',13.5,MUTED)
    footer(f,'Fictief voorbeeld. Basisvorm voor toestanden beter dan dood; berekening met lineaire waardering van tijd, zonder tijdsdiscontering.',
           'Bron: EuroQol, uitleg TTO; Oppe et al. (2016), EuroQol Protocols for Time Trade-Off Valuation of Health Outcomes.')
    return f

def sg(answer):
    f=base('STANDARD GAMBLE  •  RISICO AFWEGEN',
           'Hoeveel risico neem je voor volledige gezondheid?',
           'Een zekere levensloop tegenover een kans. Alleen de kans op een goede afloop verandert.')
    box(f,.055,.315,.33,.34,'#EAF0F5')
    text(f,.078,.610,'A  Zekerheid',20,BLUE,'bold')
    text(f,.078,.531,'10 jaar',33,BLUE,'bold')
    text(f,.078,.480,'met deze klachten',19,weight='bold')
    text(f,.078,.402,'Daarna overleden',13,MUTED)
    text(f,.434,.470,'of',18,MUTED,ha='center')
    box(f,.490,.315,.455,.34,'#F0F3F6')
    text(f,.511,.610,'B  Een denkbeeldige behandeling',19,weight='bold')
    text(f,.564,.522,'80%',30,GREEN,'bold',ha='center')
    text(f,.650,.535,'10 jaar volledig gezond',19,GREEN,'bold')
    text(f,.650,.498,'Daarna overleden',12,MUTED)
    text(f,.564,.380,'20%',30,RED,'bold',ha='center')
    text(f,.650,.394,'Direct overlijden',19,RED,'bold')
    text(f,.650,.356,'Geen resterende levensjaren',12,MUTED)
    # De beide uitkomsten zijn alternatieven, geen opeenvolgende gebeurtenissen.
    for x,y in [(.633,.538),(.633,.397)]:
        f.add_artist(FancyArrowPatch((.609,y),(x,y),transform=f.transFigure,arrowstyle='-|>',mutation_scale=12,color=MUTED,lw=1.3))
    if answer:
        box(f,.055,.143,.89,.112,'#E5F0ED')
        text(f,.073,.214,'Stel: bij 80% kans op succes vind je A en B precies even aantrekkelijk.',17.5,weight='bold')
        text(f,.073,.166,'Dan is het SG-gewicht: 0,80 × 1 + 0,20 × 0 = 0,80',22,GREEN,'bold')
    else:
        box(f,.055,.143,.89,.112,'#EAF0F5')
        text(f,.073,.214,'Wat kies je: A, B, of vind je ze even aantrekkelijk?',22,weight='bold')
        text(f,.073,.170,'Kies je A? Verhoog de succeskans. Kies je B? Verlaag die. Zoek het punt waarop je geen voorkeur hebt.',13.2,MUTED)
    footer(f,'Fictief voorbeeld. Basisvorm voor toestanden beter dan dood; berekening volgens verwachte-nutstheorie, met volledige gezondheid = 1 en dood = 0.',
           'Bron: York Health Economics Consortium, Standard Gamble; Matza et al. (2016), doi:10.1007/s10198-015-0740-7.')
    return f

figs=[tto(False),tto(True),sg(False),sg(True)]
for fig,name in [(figs[1],'time-trade-off-uitleg.png'),(figs[3],'standard-gamble-uitleg.png')]:
    buf=BytesIO();fig.savefig(buf,format='png',dpi=220,facecolor=BG)
    (OUT/name).write_bytes(buf.getvalue())
buf=BytesIO()
with PdfPages(buf) as pdf:
    for fig in figs:pdf.savefig(fig,facecolor=BG)
(OUT/'tto-en-standard-gamble.pdf').write_bytes(buf.getvalue())
print('Vier dia’s gemaakt: per methode eerst de vraag, daarna het voorbeeldantwoord.')
