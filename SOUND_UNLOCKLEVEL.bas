10 s=54272:for l=s to s+24:poke l,0:next
20 ff=25:ba=15
30 aa=33
40 gosub 90
60 for ff=1 to 45 step 2:gosub 160:next ff
62 rem for ff=1 to 75 step 3:gosub 160:next ff
65 rem for ff=15 to 25 step 2:gosub 160:next ff
70 poke s+1,0:poke s,0
80 end
90 poke s+5,28
100 poke s+6,195
110 poke s+24,15
120 poke s+4,aa
130 return
160 ll=ba+ff:h=ba:gosub 190
170 return
190 for i=ll to ba step -1 : poke s+1,i:nexti:return