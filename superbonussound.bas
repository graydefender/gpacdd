10 s=54272:for l=s to s+24:poke l,0:next 
20 aa=33:gosub 50
30 poke s+1,0:poke s,0
35 end
50 poke s+5,28
55 poke s+6,195
60 poke s+24,15
70 rem poke s+1,aa
80 rem poke s,135
90 poke s+4,aa
99 ba=35
100 ll=ba+5:h=ba:gosub 1000
110 ll=ba+10:h=ba+5:gosub 1000
120 ll=ba+15:h=ba+10:gosub 1000
130 ll=ba+20:h=ba+15:gosub 1000
140 ll=ba+25:h=ba+20:gosub 1000
150 ll=ba+5:h=ba:gosub 1000
160 ll=ba+10:h=ba+5:gosub 1000
170 ll=ba+15:h=ba+10:gosub 1000
180 ll=ba+20:h=ba+15:gosub 1000
190 ll=ba+25:h=ba+20:gosub 1000
200 ll=ba+5:h=ba:gosub 1000
210 ll=ba+10:h=ba+5:gosub 1000
220 ll=ba+15:h=ba+10:gosub 1000
230 ll=ba+20:h=ba+15:gosub 1000
240 ll=ba+25:h=ba+20:gosub 1000

299 return
300 end 
1000 for i=h to ll : poke s+1,i:nexti:return
1010 for i=ll to h step -1 : poke s+1,i:nexti:return