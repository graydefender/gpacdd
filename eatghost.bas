10 sid=54272
20 for i = 0 to 28 : poke sid + i, 0 : next
30 gosub 70
40 gosub 140
50 poke sid+1,0
55 FOR I=1 TO 100:NEXT
60 goto 30
70 poke sid + 24, 15
80 REM poke sid + 1, 75
90 poke sid + 5, 43
100  poke sid + 6, 120
110  poke sid + 4, 37
120 rem poke sid + 4, 137
130 return
140 for i=16  to 18:poke sid+1,i:next i
150 REM for i=10  to 5 step -1:poke sid+1,i:next i
160 poke sid+1,15
170 rem for i=1 to150:next i
180 return