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
99 ba=39:xx=62
100 POKE S+1,BA:FORX=1TO130:NEXTX
110 POKE S+1,XX:FORX=1TO130:NEXTX
299 return
300 end 
