; G^Ray Defender
; 11/11/2015
;
;============================================================
;  Quick code to create auto execute program from basic
;============================================================

*=$0801
          byte           $0c, $08, $0a, $00, $9e, $20
          byte           $34, $30, $39, $36, $00, $00
          byte           $00
;============================================================
;=                       MAP
;============================================================
gx             byte               16
gy             byte                10
pq$            byte                $00,$00,$00,$00
pq$len         byte                00
g$             byte                $00,$00,$00,$00
g$len          byte                00
sldk           byte $31,$31,$31
gxminus1       byte                00           
gxplus1        byte                00
gyminus1       byte                00           
gyplus1        byte                00
sldkd          byte $32,$32,$32
xg             byte                19
yg             byte                12
px             byte                20
py             byte                23
;wall           byte                160
wall1          byte                46  ; period '.'
wall2          byte                32  ; space ' '
wall3          byte                42  ; asterisk '*'
wall4          byte                45
yy             byte                0
pd$            byte                21
cd$            byte                4
temp           byte                00
gd             byte                00
map_off_l      byte                $00,$28,$50,$78,$A0,$C8,$F0,$18,$40,$68,$90,$b8,$E0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0
map_off_h      byte                $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07

warp           byte 0

defm           pokeaxy
               pha
               ldx                 /2
               ldy                 /1             
               lda                 map_off_l,x
               sta                 $fd                 
               lda                 map_off_h,x
               sta                 $fe                 
               pla
               sta                 ($fd),y             
               endm


defm           check_wall
               
               ldx                 /2
               ldy                 /1             
               lda                 map_off_l,x
               sta                 $fd                 
               lda                 map_off_h,x
               sta                 $fe                 
               lda                 ($fd),y             
               ;sta                 $405
               cmp                 wall1                
               beq                 @notwall
               cmp                 wall2
               beq                 @notwall
               cmp                 wall3   
               beq                 @notwall
               cmp                 wall4             
               bne                 @bottom
               
@notwall       lda                 pd$ 
               cmp                 #/3
               beq                 @bottom             
               lda                 #/4
               ldx                 g$len
               sta                 g$,x                  
               inc                 g$len
               lda                 /5                  
               cmp                 #0                  
               beq                 @zero 
               lda                 /5                   
               cmp                 #1                  
               beq                 @one                
               lda                 /5    
               cmp                 #2                  
               beq                 @two                
               lda                 /5    
               cmp                 #3                  
               beq                 @three  
               jmp                 @bottom             

@zero         
               lda                 gy                  
               cmp                 yg                  
               bcs                 @bottom             
               jmp                 @cont
@one           lda                 gy                  
               cmp                 yg                  
               bcc                 @bottom  
               jmp                 @cont               
@two           lda                 gx 
               cmp                 xg                  
               bcc                 @bottom 
               jmp                 @cont               
@three         lda                 gx                  
               cmp                 xg                  
               bcs                 @bottom               
               jmp                 @cont             
 
@cont          
               lda                 #/4                 
               ldx                 pq$len
               sta                 pq$,x        
               inc                 pq$len   

               
@bottom        
              nop
               endm

check_end 
               lda                 gy                  
               cmp                 #12                  
               bne                 @bottom
               lda                 gx                  
               cmp                 #18                  
               beq                 @sk1
               cmp                 #21                 
               beq                 @check2
               rts
@sk1               lda #21              
               sta                 pd$                  
               lda                 #18                 
               sta cd$
               rts

@check2        
               lda                 #21                 
               sta                 pd$                  
               lda                 #12
               sta                 cd$                 
@bottom        rts               
;1230 rem if gx=xg and gy=yg then end


;check_wall       gxplus1,gy,#12,#18,3
;1530 temp=peek(1024+((gy-1)*40)+gx)
;1540 if temp<>wall and pd$<>"d" then g$="u":if gy>yg then pq$="u"
;1550 temp=peek(1024+((gy+1)*40)+gx)
;1560 if temp<>wall and pd$<>"u" then g$=g$+"d":if gy<yg then pq$=pq$+"d"
;1570 temp=peek(1024+(gy*40)+gx+1)
;1580 if temp<>wall and pd$<>"l" then g$=g$+"r":if gx<xg then pq$=pq$+"r"
;1590 temp=peek(1024+(gy*40)+gx-1)
;1600 if temp<>wall and pd$<>"r" then g$=g$+"l":if gx>xg then pq$=pq$+"l"
;============================================================
;             Main Program Variables
;============================================================
fastmode      byte 0

scn_width$     byte  40                              ;text width of screen (c64)
scn_offset     word                $0004          ;c64 screen offset

*=$1000        
               lda                 #4                  
               sta                 53280               
               lda                 #$93           ; shift clear dec 147
               jsr                 $FFD2               ; clear screen
               jsr                 Init_Random
               jsr                 drawmap             

;poke 1024+(yg*40)+xg,67
               lda                  #46
               pokeaxy              xg,yg
               ;lda                 #65                 
               ;sta $608
main_prg_lp
               
                      
               lda                  #65
               pokeaxy             gx,gy 
                             
               jsr                 move_ghosts 
               lda                 pq$                 
               sta                 $405                
               lda                 pq$+1
               sta                 $406
               lda                 g$
               sta                 $400
               lda g$+1
               sta                 $401            


               lda fastmode
               ;sta $41f
               cmp #0
               beq getch
               lda $607
               cmp #32
               beq blah
               lda #0
               sta fastmode

getch          jsr                 $ffe4          ; Input a key from the keyboard
               cmp                 #$51                
               beq                 blah
               cmp                 #$46
               bne                 getch
               lda #1
               sta fastmode


               
blah           jsr ck_leftside
               jsr ck_rightside                                
               jsr                 mv_gh               
                          
               jsr                 check_end           

sss           ; jsr                 move_ghosts
               
               jmp                 main_prg_lp   
               rts

ck_leftside    lda                 cd$                 
               cmp                 #18                 
               beq                 @end                

               lda                 #32
               pokeaxy             gx,gy               
               jsr                 move_ghosts         
               lda                 gx
               cmp                 #0                  
               bne                 @end
               lda                 #40                 
               sta                 gx                  
              ; lda                 #18                 
              ; sta                 pd$
             ;  lda                 #12
             ;  sta                 cd$
               
             ;  sta                 g$               
@end           rts               

ck_rightside
               lda                 cd$                 
               cmp                 #12
               beq                 @end                

               lda                 #32
               pokeaxy             gx,gy 
               lda                 gxplus1
               sta                 $409                
               
               cmp                 #40                 
               bne                 @end

               
 ;lda                 #65                 
@skip          inc $408               
               lda                 #$00                 
               sta                 gx
               lda #1
               sta warp
               ;sta                 gxminus1

@skip2         ;lda                 #12                
               ;sta                 gy                  
               jsr move_ghosts
              ; lda                 #12                 
              ; sta                 pd$    
            ;lda                 #18                 
              ; sta                 cd$ 
              ; sta g$ 
          ; sta                 pq$                 
           ; sta                 $40f                

@end           rts
;============================================================
;                          Move Ghosts
;============================================================

move_ghosts
               
               lda                 #0                  
               sta                 g$                  
               sta                 g$+1
               sta                 g$+2
               sta                 g$+3                
               sta                 pq$                 
               sta                 pq$+1               
              

               lda                 #0                  
               sta                 g$len               
               sta                 pq$len 
               
               ldy                 gy                  
               dey
               sty                 gyminus1            
               ldy                 gy                  
               iny
               sty                 gyplus1             
               
               check_wall       gx,gyminus1,#4,#21,#1          
               check_wall       gx,gyplus1,#21,#4,#0              

               ldy                 gx  
ssss           dey
               cpy #$ff
               bne xxxy
               ldy #0
xxxy           sty                 gxminus1            
yyyy           ldy                 gx                  
               iny
               sty                 gxplus1             
               
               check_wall          gxminus1,gy,#18,#12,#2               
               check_wall          gxplus1,gy,#12,#18,#3
               
               rts
mv_gh          
               
               inc                 yy                  
               lda                 yy                  
               cmp                 #10
               bne                 cont5                 
               
               lda                 #0                  
               sta                 yy                  

               jmp  random
cont5          lda                 pq$
               cmp                 #0                  
               bne                 cont6               
               jmp                 cont7
cont6          lda                 pq$
               sta                 g$                  
               lda                 pq$+1               
               sta                 g$+1                
               lda                 pq$len              
               sta                 g$len               
               jmp                 random              
cont7          nop
random
               jsr                 RAND                
               sta                 gd 
               tax
               lda                 g$,x                
               sta                 cd$                 
ck_1           cmp                 #21
               bne                 ck_2                
               dec                 gy                  
               
               
ck_2           cmp                 #4
               bne                 ck_3                
               inc                 gy                  
               

ck_3           cmp                 #12
               bne                 ck_4                
               dec                 gx                  
               

ck_4           cmp                 #18
               bne                 skip 
               lda warp
               cmp #1 
               bne ggg
               lda #0
               sta warp
               jmp skip               
ggg            inc                 gx
                           
skip           
               ldx                 gd
               lda                 g$,x
               sta                 pd$                 
            ;   lda                 #65                 
            ;   pokeaxy             gx,gy


               rts

;============================================================
;                          Draw Map
;============================================================
drawmap
               lda                 #$00                
               sta                 $fb                 
               lda                 #4                 
               sta                 $fc                 
               lda                 MAPL
               sta                 $fd                 
               lda                 MAPH
               sta                 $fe                

               ldx                 #4                 
main_lp        ldy                 #$00
loop1          lda                 ($fd),y             
               sta                 ($fb),y             
               dey
               bne                 loop1               
               inc                 $fc                 
               inc                 $fe
               dex
               bne                 main_lp
               rts
;============================================================

Init_Random
               LDA                 #$FF                ; maximum frequency value
               STA                 $D40E               ; voice 3 frequency low byte
               STA                 $D40F               ; voice 3 frequency high byte
               LDA                 #$80                ; noise waveform, gate bit off
               STA                 $D412               ; voice 3 control register
               rts

RAND           LDA $D41B  ; get random value from 0-255
               CMP g$len
                          ; U-L+1 = $31 = $40-$10+$01
               BCS RAND   ; branch if value > U-L+1
               ;ADC                 #$10                ; add L
               rts

MAPL           BYTE                <MAP_DATA
MAPH           BYTE                >MAP_DATA

MAP_DATA
incbin         pacmap.bin


SCREEN_MAP     BYTE           $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
               BYTE           $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
               BYTE           $A0,$2A,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2A,$A0
               BYTE           $A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$20,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2A,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$20,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2D,$2D,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
               BYTE           $20,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$20
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0
               BYTE           $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2A,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2A,$A0
               BYTE           $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
               BYTE           $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
