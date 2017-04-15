10 s=54272:x=16:yy=17:del=-40
20 forl=stos+24:pokel,0:next
30 pokes+5,9:pokes+6,175
40 pokes+24,15
50 readhf,lf,dr:hf=hf+5
80 ifhf<0 then POKES,0:POKES+1,0:end
90 pokes+1,hf+x:pokes,lf
100 pokes+4,yy
110 fort=1todr+del:next
120 pokes+4,16:fort=1to50:next
130 goto50
140 poke s+1,0:end
150 data20,155,200, 40,214,200
160 data20,155,200, 65,177,200,-10,-10,-10
