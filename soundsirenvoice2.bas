10 s=54279:for l=s to s+18:poke l,0:next
20 ff=25:ba=15
30 aa=19
40 gosub 90
50 ff=20:gosub 160
62 for ff=20 to 50 step 3:gosub 160:next ff
70 poke s+1,0:poke s,0
80 end
90 rem
100 poke s+5,195
105 poke s+6,240
110 poke s+17,15
120 poke s+4,aa
130 return
160 ll=ba+ff:h=ba:gosub 190
170 return
190 for i=ll to ba step -1 : poke s+1,i:nexti
200 for i=ba to ll : poke s+1,i:nexti:return