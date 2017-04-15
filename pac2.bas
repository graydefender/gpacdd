1000 X = RND(-TI)
1010 px=20:py=23
1020 wall=160
1030 yy=0:pq$=""
1040 pd$="":g$=""
1050 gx=3:gy=5
1060 xg=19:yg=12          :rem x,y goal for ghost
1070 rem ************
1080 g1yy=0:g2pq$=""
1090 g3pd$="" :g4g$=""
1100 g5gx=3:g6gy=5
1110 g7xg=19:g8yg=12          :rem x,y goal for ghost
1120 rem ************
1130 h1yy=0:h2pq$=""
1140 h3pd$="" :h4g$=""
1150 h5gx=30:h6gy=17
1160 h7xg=19:h8yg=12          :rem x,y goal for ghost
1170 rem ************
1180 print chr$(147)
1190 gosub 1800           :rem draw the map
1200 poke 1024+(yg*40)+xg,67
1210 for i=1 to 550
1220 rem
1230 rem if gx=xg and gy=yg then end
1240  rem
1250 gosub 1290
1260 next i
1270 end
1280 rem ************** Move Ghost 1 **************
1290 yy=g1yy:pq$=g2pq$
1300 pd$=g3pd$:g$=g4g$
1310 gx=g5gx:gy=g6gy
1320 xg=g7xg:yg=g8yg
1330 gosub 1500
1340 g1yy=yy:g2pq$=pq$
1350 g3pd$=pd$:g4g$=g$
1360 g5gx=gx:g6gy=gy
1370 g7xg=xg:g8yg=yg
1380 rem ************** Move Ghost 2 **************
1390 yy=h1yy:pq$=h2pq$
1400 pd$=h3pd$:g$=h4g$
1410 gx=h5gx:gy=h6gy
1420 xg=h7xg:yg=h8yg
1430 gosub 1500
1440 h1yy=yy:h2pq$=pq$
1450 h3pd$=pd$:h4g$=g$
1460 h5gx=gx:h6gy=gy
1470 h7xg=xg:h8yg=yg
1480 return
1490 rem ******************************************
1500 g$=""
1510 pq$=""
1520 poke 1024+(gy*40)+gx,32
1530 temp=peek(1024+((gy-1)*40)+gx)
1540 if temp<>wall and pd$<>"d" then g$="u":if gy>yg then pq$="u"
1550 temp=peek(1024+((gy+1)*40)+gx)
1560 if temp<>wall and pd$<>"u" then g$=g$+"d":if gy<yg then pq$=pq$+"d"
1570 temp=peek(1024+(gy*40)+gx+1)
1580 if temp<>wall and pd$<>"l" then g$=g$+"r":if gx<xg then pq$=pq$+"r"
1590 temp=peek(1024+(gy*40)+gx-1)
1600 if temp<>wall and pd$<>"r" then g$=g$+"l":if gx>xg then pq$=pq$+"l"
1610 rem ** Now we know what directions the ghost can move in
1620 rem ** g$="DL" means it can move down or left for example
1630 rem poke 1024,asc(mid$(g$,1,1))-64:poke 1025,32:poke 1026,32:if len(g$)=2 then poke 1025,asc(mid$(g$,2,1))-64:if len(g$)=3 then poke 1026,asc(mid$(g$,3,1))-64
1640 rem poke 1030,32:if len(pq$)=1 or len(pq$)=2 then poke 1030,asc(mid$(pq$,1,1))-64:poke 1031,32:if len(pq$)=2 then poke 1031,asc(mid$(pq$,2,1))-64
1650 rem GET aa$: IF aa$="" THEN 1650
1660 rem *** yy=5 means five times toward priority for every one time toward random direction
1670 yy=yy+1:if yy=80 then yy=0:goto 1710
1680 if pq$<>"" then g$=pq$:goto 1710
1690   rem if len(g$)=1 then goto 1710 :rem w/o these two lines ghost goes in circles
1700 rem  g$=cd$                      :rem near the ghost cage:actuall this line makes ghost go through wall
1710 gd=INT(RND(1)*len(g$))+1
1720 cd$=mid$(g$,gd,1)
1730 if cd$="u" then gy=gy-1
1740 if cd$="d" then gy=gy+1
1750 if cd$="l" then gx=gx-1
1760 if cd$="r" then gx=gx+1
1770 poke 1024+(gy*40)+gx,65
1780 pd$=mid$(g$,gd,1)
1790 return
1800 PRINT "{reverse on}{cyan}                                        ";
1810 PRINT "{reverse off}{reverse on} {reverse off}*..{reverse on} {reverse off}......{reverse on} {reverse off}.........{reverse on}   {reverse off}.......{reverse on}   {reverse off}....*{reverse on} ";
1820 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off} {reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}.{reverse on}       {reverse off}.{reverse on}   {reverse off}.{reverse on}     {reverse off}.{reverse on}   {reverse off}.{reverse on}   {reverse off}.{reverse on} ";
1830 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}....{reverse on} {reverse off}.....{reverse on}  {reverse off}.... ...{reverse on} {reverse off}.........{reverse on} {reverse off}.{reverse on} ";
1840 PRINT "{reverse off}{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on}  {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}....{reverse on}  {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1850 PRINT "{reverse off}{reverse on}     {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1860 PRINT "{reverse off}{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}...........{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}...........{reverse on} {reverse off}...{reverse on} ";
1870 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}......{reverse on}   {reverse off}.{reverse on}    {reverse off}..*{reverse on} {reverse off}.{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}       {reverse off}.{reverse on}   {reverse off}.{reverse on} ";
1880 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on}  {reverse off}.......{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on} {reverse off}...........{reverse on} ";
1890 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.........{reverse on}    {reverse off}........{reverse on} {reverse off}..{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on}  {reverse off} {reverse on} ";
1900 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}...{reverse on} {reverse off}....{reverse on}  {reverse off}--{reverse on}  {reverse off}.{reverse on} {reverse off} {reverse on}  {reverse off}.{reverse on} {reverse off}.........{reverse on} ";
1910 PRINT "{reverse off} ...{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on} {reverse off}    {reverse on} {reverse off}......{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}."
1920 PRINT "{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off} {reverse on}    {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1930 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}...........{reverse on} {reverse off}.{reverse on}    {reverse off}.{reverse on}     {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1940 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on}       {reverse off}.{reverse on} {reverse off}............{reverse on} {reverse off}.{reverse on} ";
1950 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on} {reverse off}.............{reverse on}  {reverse off}.{reverse on}         {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1960 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}  {reverse off}.{reverse on}  {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.....{reverse on} {reverse off}.....{reverse on} {reverse off}.....{reverse on} ";
1970 PRINT "{reverse off}{reverse on} {reverse off}.....{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}........{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1980 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
1990 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}........{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
2000 PRINT "{reverse off}{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}      {reverse off}.{reverse on} {reverse off}...{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on}   {reverse off}.{reverse on} {reverse off}.{reverse on} {reverse off}.{reverse on} ";
2010 PRINT "{reverse off}{reverse on} {reverse off}*....{reverse on} {reverse off}..................{reverse on} {reverse off}...{reverse on} {reverse off}.....{reverse on} {reverse off}..*{reverse on} ";
2020 PRINT "{reverse off}{reverse on}                                        ";
2030 return