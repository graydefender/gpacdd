1000 X = RND(-TI)
1010 px=20:py=23
1020 wall=160
1030 yy=0:pq$=""
1040 pd$="":g$=""
1050 gx=3:gy=5
1060 xg=19:yg=12          :rem x,y goal for ghost
1180 print chr$(147)
1190 gosub 1720           :rem draw the map
1200 poke 1024+(yg*40)+xg,67
1210 for i=1 to 550
1220 rem
1230 rem if gx=xg and gy=yg then end
1240  rem
1250 gosub 1420
1260 next i
1270 end
1410 rem ******************************************
1420 g$=""
1430 pq$=""
1440 poke 1024+(gy*40)+gx,32
1450 temp=peek(1024+((gy-1)*40)+gx)
1460 if temp<>wall and pd$<>"d" then g$="u":if gy>yg then pq$="u"
1470 temp=peek(1024+((gy+1)*40)+gx)
1480 if temp<>wall and pd$<>"u" then g$=g$+"d":if gy<=yg then pq$=pq$+"d"
1490 temp=peek(1024+(gy*40)+gx+1)
1500 if temp<>wall and pd$<>"l" then g$=g$+"r":if gx<xg then pq$=pq$+"r"
1510 temp=peek(1024+(gy*40)+gx-1)
1520 if temp<>wall and pd$<>"r" then g$=g$+"l":if gx>=xg then pq$=pq$+"l"
1530 rem ** Now we know what directions the ghost can move in
1540 rem ** g$="DL" means it can move down or left for example
1550 rem poke 1024,asc(mid$(g$,1,1))-64:poke 1025,32:poke 1026,32:if len(g$)=2 then poke 1025,asc(mid$(g$,2,1))-64:if len(g$)=3 then poke 1026,asc(mid$(g$,3,1))-64
1560 rem  poke 1030,32:if len(pq$)=1 or len(pq$)=2 then poke 1030,asc(mid$(pq$,1,1))-64:poke 1031,32:if len(pq$)=2 then poke 1031,asc(mid$(pq$,2,1))-64
1570  GET aa$: IF aa$="" THEN 1570
1580 rem *** yy=5 means five times toward priority for every one time toward random direction
1590 yy=yy+1:if yy=3 then yy=0:goto 1630
1600 if pq$<>"" then g$=pq$:goto 1630
1610 rem  if len(g$)=1 then goto 1630 :rem w/o these two lines ghost goes in circles
1620 rem  g$=cd$                      :rem near the ghost cage:actuall this line makes ghost go through wall
1630 gd=INT(RND(1)*len(g$))+1
1640 cd$=mid$(g$,gd,1)
1650 if cd$="u" then gy=gy-1
1660 if cd$="d" then gy=gy+1
1670 if cd$="l" then gx=gx-1
1680 if cd$="r" then gx=gx+1
1690 poke 1024+(gy*40)+gx,65
1700 pd$=mid$(g$,gd,1)
1710 return
1720 PRINT "{reverse on}{cyan}                                        ";
1730 PRINT "{reverse off}{reverse on} {reverse off}*..{reverse on} {reverse off}......{reverse on} {reverse off}.........{reverse on}   {reverse off}.......{reverse on}   {reverse off}....*{reverse on} ";
1740 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off} {reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}.{reverse on}       {reverse off}.{reverse on}   {reverse off}.{reverse on}     {reverse off}.{reverse on}   {reverse off}.{reverse on}   {reverse off}.{reverse on} ";
1750 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}....{reverse on} {reverse off}.....{reverse on}  {reverse off}.... ...{reverse on} {reverse off}.........{reverse on} {reverse off}.{reverse on} ";
1760 PRINT "{reverse off}{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on}  {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}....{reverse on}  {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1770 PRINT "{reverse off}{reverse on}     {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1780 PRINT "{reverse off}{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}...........{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}...........{reverse on} {reverse off}...{reverse on} ";
1790 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}......{reverse on}   {reverse off}.{reverse on}    {reverse off}..*{reverse on} {reverse off}.{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}       {reverse off}.{reverse on}   {reverse off}.{reverse on} ";
1800 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on}  {reverse off}.......{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on} {reverse off}...........{reverse on} ";
1810 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.........{reverse on}    {reverse off}........{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on}  {reverse off} {reverse on} ";
1820 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}...{reverse on} {reverse off}....{reverse on}  {reverse off}--{reverse on}  {reverse off}.{reverse on} {reverse off} {reverse on}  {reverse off}.{reverse on} {reverse off}.........{reverse on} ";
1830 PRINT "{reverse off} ...{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on} {reverse off}    {reverse on} {reverse off}......{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}."
1840 PRINT "{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off} {reverse on}    {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1850 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}...........{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on}     {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1860 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on}       {reverse off}.{reverse on} {reverse off}............{reverse on} {reverse off}.{reverse on} ";
1870 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on} {reverse off}.............{reverse on}  {reverse off}.{reverse on}         {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1880 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on}  {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.....{reverse on} {reverse off}.....{reverse on} {reverse off}.....{reverse on} ";
1890 PRINT "{reverse off}{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}........{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1900 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1910 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}........{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1920 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1930 PRINT "{reverse off}{reverse on} {reverse off}*....{reverse on} {reverse off}..................{reverse on} {reverse off}...{reverse on} {reverse off}.....{reverse on} {reverse off}..*{reverse on} ";
1940 PRINT "{reverse off}{reverse on}                                        ";
1950 return