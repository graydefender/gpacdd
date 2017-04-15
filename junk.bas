9 PRINT CHR$(147)CHR$(14): POKE 53280,PEEK(53281)
10 LF$="                                     "
11 LF$=LF$+"    * * * DAS C64-Wiki ist super ! * * *      Created by Jodigi    "
12 LF$=LF$+"    Copyright 2016        Abbruch mit RUN/STOP !!!             "
13 FOR X=1 TO LEN(LF$)
14 POKE 781,11:POKE 782,5:POKE 783,0:SYS 65520:PRINT MID$(LF$,X,30)
15 FOR Y=55741 TO 55771:POKE Y,X: NEXT Y,X
16 GOTO 13