5 X = RND(-TI)
8 pd$="l" 
10 gx=10
20 gy=10
30 rem px=2
40 rem py=11
45 wall=160
48 print chr$(147)
49 gosub 5000
50 rem move ghost 1
53 for i=1 to 550
55 gosub 1000
57 next i
60 end
1000 rem ** Move Ghost 1
1002 g$=""
1004 poke 1024+(gy*40)+gx,32
1005 temp=peek(1024+((gy-1)*40)+gx)
1010 if temp<>wall and pd$<>"d" then g$="u"
1020 temp=peek(1024+((gy+1)*40)+gx)
1030 if temp<>wall and pd$<>"u" then g$=g$+"d"
1050 temp=peek(1024+(gy*40)+gx+1)
1060 if temp<>wall and pd$<>"l" then g$=g$+"r"
1080 temp=peek(1024+(gy*40)+gx-1)
1090 if temp<>wall and pd$<>"r" then g$=g$+"l"
1100 rem ** Now we know what directions the ghost can move in
1110 rem ** g$="DL" means it can move down or left for example
1120 gd=INT(RND(1)*len(g$))+1
1130 if mid$(g$,gd,1)="u" then gy=gy-1
1140 if mid$(g$,gd,1)="d" then gy=gy+1
1150 if mid$(g$,gd,1)="l" then gx=gx-1
1160 if mid$(g$,gd,1)="r" then gx=gx+1
1161 rem if peek(1024+(gy*40)+gx)=wall then print g$;"+gd=";gd
1162 poke 1024+(gy*40)+gx,65
1165 pd$=mid$(g$,gd,1)
1168 rem print pd$
1170 rem print "x=";gx;" y=";gy
1180 return
2000 rem
3000 rem
4000 rem
5000 REM SCREEN 1 - 
5010 PRINT "                                        ";
5020 PRINT "{reverse on}{cyan}                                        ";
5030 PRINT "{reverse off}{reverse on} {reverse off}...{reverse on} {reverse off}......{reverse on} {reverse off}.........{reverse on}   {reverse off}.......{reverse on}   {reverse off}....*{reverse on} ";
5040 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}.{reverse on}       {reverse off}.{reverse on}   {reverse off}.{reverse on}     {reverse off}.{reverse on}   {reverse off}.{reverse on}   {reverse off}.{reverse on} ";
5050 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}....{reverse on} {reverse off}.....{reverse on}  {reverse off}.... ...{reverse on} {reverse off}.........{reverse on} {reverse off}.{reverse on} ";
5060 PRINT "{reverse off}{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on}  {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}....{reverse on}  {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5070 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5080 PRINT "{reverse off}{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}...........{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}...........{reverse on} {reverse off}...{reverse on} ";
5090 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}......{reverse on}   {reverse off}.{reverse on}    {reverse off}..*{reverse on} {reverse off}.{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}       {reverse off}.{reverse on}   {reverse off}.{reverse on} ";
5100 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on}  {reverse off}.......{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on} {reverse off}...........{reverse on} ";
5110 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.........{reverse on}    {reverse off}........{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on}  {reverse off} {reverse on} ";
5120 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}...{reverse on} {reverse off}....{reverse on}  {reverse off}--{reverse on}  {reverse off}.{reverse on} {reverse off} {reverse on}  {reverse off}.{reverse on} {reverse off}.........{reverse on} ";
5130 PRINT "{reverse off} ...{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on} {reverse off}    {reverse on} {reverse off}......{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}. ";
5140 PRINT "{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off} {reverse on}    {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5150 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}...........{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on}     {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5160 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on}       {reverse off}.{reverse on} {reverse off}............{reverse on} {reverse off}.{reverse on} ";
5170 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on} {reverse off}.............{reverse on}  {reverse off}.{reverse on}         {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5180 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on}  {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.....{reverse on} {reverse off}.....{reverse on} {reverse off}.....{reverse on} ";
5190 PRINT "{reverse off}{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}........{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5200 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5210 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}........{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5220 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
5230 PRINT "{reverse off}{reverse on} {reverse off}..... ..................{reverse on} {reverse off}...{reverse on} {reverse off}.....{reverse on} {reverse off}..*{reverse on} ";
5240 PRINT "{reverse off}{reverse on}                                        ";
5260 return
