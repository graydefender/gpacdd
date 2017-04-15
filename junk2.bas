10 sid=54272
20 for i = 0 to 28 : poke sid + i, 0 : next
21 gosub 30
22 gosub 30
28 end
30 poke sid + 24, 15
40 poke sid + 1, 175
50 poke sid + 5,222
60 poke sid + 6, 120
70 poke sid + 4, 17
80 poke sid + 4, 16
85 for i=15  to 50:poke sid+1,i:next i
90 for i=1 to 200:next i
100 return