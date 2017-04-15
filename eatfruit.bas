10 sid=54272
20 rem for i = 0 to 28 : poke sid + i, 0 : next
21 REM gosub 30
22 gosub 200
25 POKE SID+1,0
28 end
200 poke sid + 24, 15
210 poke sid + 1,  8
220 poke sid + 5,25
230 poke sid + 6, 122
250 poke sid + 4, 17
260 for i=20 to 1 step -1:poke sid+1,i: next i
263 for i=10  to 35       :poke sid+1,i: next i
270 return


