10 s=54272:for l=s to s+24:poke l,0:next 
20 aa=19:gosub 50
30 poke s+1,0:poke s,0
35 end
50 poke s+5,28
55 poke s+6,195
60 poke s+24,15
70 rem poke s+1,aa
80 rem poke s,135
90 poke s+4,aa
99 ba=80
100 ll=ba-10:h=ba:gosub 1000
110 ll=ba-20:h=ba-10:gosub 1010
120 ll=ba-30:h=ba-20:gosub 1000
130 ll=ba-40:h=ba-30:gosub 1010
140 ll=ba-50:h=ba-40:gosub 1000
150 ll=ba-60:h=ba-50:gosub 1010
160 ll=ba-70:h=ba-60:gosub 1000
170 ll=ba-60:h=ba-30:gosub 1010
180 return
520 end 
1000 for i=ll to h : poke s+1,i:nexti:return
1010 for i=h to ll step -1 : poke s+1,i:nexti:return