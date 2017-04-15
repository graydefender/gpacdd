10 s=54272:for l=s to s+24:poke l,0:next
20 aa=19:gosub 50
30 poke s+1,0:poke s,0
40 end
50 poke s+5,28
60 poke s+6,195
70 poke s+24,15
80 rem poke s+1,aa
90 rem poke s,135
100 poke s+4,aa
110 ba=80
120 gosub 150
130 gosub 150
140 gosub 150
150 ll=ba-40:h=ba:gosub 210
160 rem ll=ba-60:h=ba-30:gosub 200
170 return
180 return
190 end
200 for i=ll to h : poke s+1,i:nexti:return
210 for i=h to ll step -1 : poke s+1,i:nexti:return