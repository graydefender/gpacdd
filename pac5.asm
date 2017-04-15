; G^Ray Defender
; 11/11/2015
;
; 12/19
; Adding logic to make ghosts smarter,
; make them follow pac-man
; 
; Logic to eat the ghosts Part 1
;  * blue time mode added
; 12/22
; Logic to eat the ghosts Part 2
;  * blue time duration
;  * make ghosts move away from pac-clone
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
gh2_gx             byte                1
gh2_gy             byte                6
gh2_pq$            byte                $00,$00
gh2_g$             byte                $00,$00,$00,$00
xjunk5             byte                $31,$31,$31
gh2_xg             byte                0;19
gh2_yg             byte                12
zjunk5             byte                $31,$31,$31
gh2_yy             byte                0
gh2_pd$            byte                21
gh2_cdir           byte                4
ejunk5             byte                $31,$31,$31
gh2_pr             byte                2
gh2_pq$len         byte                00
gh2_g$len          byte                00
gh2_bluetime       byte                00
gh2_btime_count    byte                50


junkxx             byte                $30,$30,$30
gxminus1           byte                00           
gxplus1            byte                00
gyminus1           byte                00           
gyplus1            byte                00

gh1_gx             byte                16
junk5              byte                $31,$31,$31
gh1_gy             byte                10
junk6              byte                 $32,$32,$32
gh1_pq$            byte                $00,$00
junk7              byte                $33,$33,$33
gh1_pq$len         byte                00
junk8              byte                $34,$34,$34
gh1_g$             byte                $00,$00,$00,$00
junk9              byte                $35,$35,$35
gh1_g$len          byte                00
junka              byte                $36,$36,$36
gh1_xg             byte                39
junk1              byte                $37,$37,$37
gh1_yg             byte                12
junk2              byte                $38,$38,$38
gh1_yy             byte                0
junkb              byte                $39,$39,$39
gh1_pr             byte                10
junk3              byte                $30,$30,$30
gh1_pd$            byte                21
junkc              byte                $31,$31,$31
gh1_cdir           byte                4
junk4              byte                $32,$32,$32
gh1_bluetime       byte                00
gh1_btime_count    byte                50

gx             byte                0
gy             byte                00
pq$            byte                $00,$00
pq$len         byte                00
g$             byte                $00,$00,$00,$00
g$len          byte                00
xg             byte                0
yg             byte                0
yy             byte                0
ghost_pr       byte                1
pd$            byte                0
cdir           byte                0

gd             byte                00
px             byte                20
py             byte                23
map_off_l      byte                $00,$28,$50,$78,$A0,$C8,$F0,$18,$40,$68,$90,$b8,$E0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0
map_off_h      byte                $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07
wall1          byte                46  ; period '.'
wall2          byte                32  ; space ' '
wall3__nrgzr   byte                42  ; asterisk '*'
wall4          byte                48  ; Pac-Clone char
wall5          byte                49  ; ghost char 1
wall6          byte                49  ; ghost char 2
wall7          byte                49  ; ghost char 3    
wall8          byte                49  ; ghost char 4
blue_ghost     byte                52  ;Change ghost to this during blue time

;*****************************************************

gh3_gx             byte                32
gh3_gy             byte                4
gh3_pq$            byte                $00,$00
gh3_g$             byte                $00,$00,$00,$00
gh3_xg             byte                39
gh3_yg             byte                12
gh3_yy             byte                0
gh3_pd$            byte                21
gh3_cdir           byte                4
gh3_pr             byte                3
gh3_pq$len         byte                00
gh3_g$len          byte                00
gh3_bluetime       byte                00
gh3_btime_count    byte                50

gh4_gx             byte                32
gh4_gy             byte                14
gh4_pq$            byte                $00,$00
gh4_g$             byte                $00,$00,$00,$00
gh4_xg             byte                39
gh4_yg             byte                12
gh4_yy             byte                0
gh4_pd$            byte                21
gh4_cdir           byte                4
gh4_pr             byte               3
gh4_pq$len         byte                00
gh4_g$len          byte                00
gh4_bluetime       byte                00
gh4_btime_count    byte                50

gh5_gx             byte                32
gh5_gy             byte                14
gh5_pq$            byte                $00,$00
gh5_g$             byte                $00,$00,$00,$00
gh5_xg             byte                11
gh5_yg             byte                12
gh5_yy             byte                0
gh5_pd$            byte                21
gh5_cdir           byte                4
gh5_pr             byte                3
gh5_pq$len         byte                00
gh5_g$len          byte                00
gh5_bluetime       byte                00
gh5_btime_count    byte                50

warp              byte 00
ispacman          byte 00
userdirection     byte 00
pac_pd$           byte 00 ; used to keep pac-man moving in same general direction of travel 


defm           peekaxy
               pha
               ldx                 /2
               ldy                 /1             
               lda                 map_off_l,x
               sta                 $fd                 
               lda                 map_off_h,x
               sta                 $fe                 
               pla
               lda                 ($fd),y             
               endm


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
               cmp                 wall1                
               beq                 @notwall
               cmp                 wall2
               beq                 @notwall
               cmp                 wall3__nrgzr                
               beq                 @notwall
               cmp                 wall4
               beq                 @notwall
               cmp                 wall5
               beq                 @notwall
               cmp                 wall6
               beq                 @notwall
               cmp                 wall7
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


;*****************************************************
defm           move_ghosts_part1
               lda /1
               sta yy
               lda /2
               sta pq$
               lda /2+1
               sta pq$+1
               
               lda /3
               sta pd$
               lda /4
               sta g$
               lda /4+1
               sta g$+1
               lda /4+2
               sta g$+2
               lda /4+3
               sta g$+3
               lda /5
               sta gx
               lda /6
               sta gy

               lda /7
               sta xg
               lda /8
               sta yg
               lda /9 
               sta ghost_pr
endm 
 

defm move_ghosts_part2
               lda /1
               sta cdir
               lda /2
               sta pq$len
               lda /3
               sta g$len
               endm


defm move_ghosts_part3
               jsr Check_Walls 
               jsr ck_leftside
               jsr ck_rightside                                

               lda                 pq$                 
               sta                 $405                
               lda                 pq$+1
               sta                 $406
               lda                 g$
               sta                 $400
               lda g$+1
               sta                 $401            
               lda g$+2
               sta                 $402
               lda g$len
               sta $403
               lda gh1_g$len
               sta $404

               jsr mv_gh 
             
               lda yy
               sta /1
               lda pq$
               sta /2
               lda pq$+1
               sta /2+1
              
               lda pd$
               sta /3
               lda g$
               sta /4
               lda g$+1
               sta /4+1
               lda g$+2
               sta /4+2
               lda g$+3
               sta /4+3
               lda gx
               sta /5
               lda gy
               sta /6

               lda xg
               sta /7
               lda yg
               sta /8
               lda ghost_pr 
               sta /9
               endm

defm move_ghosts_part4
               lda cdir
               sta /1 
               lda pq$len
               sta /2
               lda g$len
               sta /3
               endm

defm check_btime                                ;Check if blue time is on
                                                ; and count how long it is on
               lda /1
               cmp #1
               bne @quit
               dec /2
               lda /2
               cmp #20                         ; only 20 moves of blue time left
               bne @ck_zero                    ; if so then change ghost 
               lda #50                         ; character to mimic flashing ghost      
               sta /3
               jmp @quit                   

@ck_zero       cmp #0                          ; no more blue time left?
               bne @quit                
               lda #50                         ; If so then reset the blue time
               sta /2                          ; counter, turn off blue time
               lda #0                          ; and change ghost character
               sta /1                          ; back to normal
               lda #49
               sta /3

@quit          nop
               endm
;============================================================
;             Main Program Variables
;============================================================
;fastmode        byte 0  

scn_width$     = #40                              ;text width of screen (c64)
scn_offset     word                $0004          ;c64 screen offset

*=$1000        
               lda                 #4                  
               sta                 53280               
               lda                 #$93                ; shift clear dec 147
               jsr                 $FFD2               ; clear screen
               jsr                 Init_Random
               jsr                 drawmap             


;poke 1024+(yg*40)+xg,67
               lda                  #46
               pokeaxy              xg,yg
main_prg_lp
               
                
               peekaxy             gh1_gx,gh1_gy                ; Did Pac-Clone eat
               sta                 $41f
               cmp                 wall3__nrgzr         ; the energizer?
               bne                 sk_385               ; NO, then skip 

               jsr                 turn_on_btime        ; Turn on blue time

sk_385         lda                  wall4
               pokeaxy             gh1_gx,gh1_gy                

               lda                  wall5
               pokeaxy             gh2_gx,gh2_gy 
               lda                  wall6
               pokeaxy             gh3_gx,gh3_gy                              
               lda                  wall7
               pokeaxy             gh4_gx,gh4_gy 
               lda                  wall8
               pokeaxy             gh5_gx,gh5_gy 
              

getch       
               jsr                 $ffe4          ; Input a key from the keyboard
               beq getch
               cmp                 #$51                
               beq                 fm
               cmp                 #$46           ; f pressed
               beq                 fm
               cmp                 #$5a ; z down pressed
               beq                 udir
               cmp                 #$57   ; up w pressed
               beq                 udir               
               cmp                 #$41  ; left a pressed
               beq                 udir
               cmp                 #$53  ; right s pressed 
               beq                 udir
              
               lda userdirection
               jmp continue

udir           cmp #$5a
               bne nextck1
               lda #4               
               jmp continue
nextck1        cmp #$57
               bne nextck2
               lda #21               
               jmp continue 
nextck2        cmp #$41
               bne nextck3
               lda #12
             
               jmp continue 
nextck3        cmp #$53
               beq nextck4               
              

nextck4        lda #18
                 
continue       sta userdirection


fm             
    
               lda #1
               sta ispacman
               lda #0               
               sta gh1_pd$

               jsr mv_Ghost1

         
               lda gh2_bluetime ;**** This code tells the ghosts where
               cmp #1           ;* Pac-clone is but we dont want them
               beq ck_gh3       ;* To know where he is if bluetime is on
               lda gh1_gx       
               sta gh2_xg       
               sta $420
               
               lda gh1_gy       
               sta gh2_yg       
               sta $421
;sdlkf          jmp sdlkf
ck_gh3         lda gh3_bluetime
               cmp #1
               beq ck_gh4
               lda gh1_gx       
               sta gh3_xg       
               lda gh1_gy       
               sta gh3_yg       
ck_gh4         lda gh4_bluetime
               cmp #1
               beq ck_gh5
               lda gh1_gx       
               sta gh4_xg       
               lda gh1_gy       
               sta gh4_yg       
ck_gh5         lda gh5_bluetime
               cmp #1
               beq skip_gh
               lda gh1_gx       
               sta gh5_xg       
               lda gh1_gy       
               sta gh5_yg   

skip_gh        lda #0
               sta ispacman

               jsr mv_Ghost2
               jsr mv_Ghost3
               jsr mv_Ghost4
               jsr mv_Ghost5

               jmp                 main_prg_lp   
               rts

ck_leftside    lda                 cdir                 
               cmp                 #18                 
               beq                 @end                

               lda                 #32
               pokeaxy             gx,gy               
               jsr                 Check_Walls         
               lda                 gx
               cmp                 #0                  
               bne                 @end
               lda                 #40                 
               sta                 gx                  
@end           rts               

ck_rightside
               lda                 cdir                
               cmp                 #12
               beq                 @end                

               lda                 #32
               pokeaxy             gx,gy 
               lda                 gxplus1
               sta                 $409                
               
               cmp                 #40                 
               bne                 @end

               
               
@skip                       
               lda                 #$00                 
               sta                 gx
           
               lda #1
               sta warp
              

@skip2        
               jsr Check_Walls

@end           rts

mv_Ghost1    
              move_ghosts_part1 gh1_yy,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_xg,gh1_yg,gh1_pr
              move_ghosts_part2 gh1_cdir,gh1_pq$len,gh1_g$len
              move_ghosts_part3 gh1_yy,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_xg,gh1_yg,gh1_pr              
              move_ghosts_part4 gh1_cdir,gh1_pq$len,gh1_g$len
              rts
mv_Ghost2    
              move_ghosts_part1 gh2_yy,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_xg,gh2_yg,gh2_pr
              move_ghosts_part2 gh2_cdir,gh2_pq$len,gh2_g$len
              move_ghosts_part3 gh2_yy,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_xg,gh2_yg,gh2_pr
              check_btime gh2_bluetime,gh2_btime_count,wall5
              move_ghosts_part4 gh2_cdir,gh2_pq$len,gh2_g$len
              rts

mv_Ghost3    
              move_ghosts_part1 gh3_yy,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_xg,gh3_yg,gh3_pr
              move_ghosts_part2 gh3_cdir,gh3_pq$len,gh3_g$len
              move_ghosts_part3 gh3_yy,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_xg,gh3_yg,gh3_pr
              check_btime gh3_bluetime,gh3_btime_count,wall6
              move_ghosts_part4 gh3_cdir,gh3_pq$len,gh3_g$len
              rts

mv_Ghost4    
              move_ghosts_part1 gh4_yy,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_xg,gh4_yg,gh4_pr
              move_ghosts_part2 gh4_cdir,gh4_pq$len,gh4_g$len
              move_ghosts_part3 gh4_yy,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_xg,gh4_yg,gh4_pr
              check_btime gh4_bluetime,gh4_btime_count,wall7
              move_ghosts_part4 gh4_cdir,gh4_pq$len,gh4_g$len
              rts

mv_Ghost5    
              move_ghosts_part1 gh5_yy,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_xg,gh5_yg,gh5_pr
              move_ghosts_part2 gh5_cdir,gh5_pq$len,gh5_g$len
              move_ghosts_part3 gh5_yy,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_xg,gh5_yg,gh5_pr
              check_btime gh5_bluetime,gh5_btime_count,wall8
              move_ghosts_part4 gh5_cdir,gh5_pq$len,gh5_g$len
              rts

;============================================================
;                          Check for Walls
; This section of code checks up/down/left/right for walls
; in order to determine the direction that can  travelled in.
; it sets up a string G$ that looks something like this:
; g$="udl" - Means ghost can move up/down/left
; it aslo sets up pr direction that ghost can move in.
; that string looks something like this:
; pq$="dl" (subset of g$) - means down/left are pr directions which
; will move the ghost closer to the target
;============================================================

Check_Walls
               
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
               dey
               sty                 gxminus1            
               ldy                 gx                  
               iny
               sty                 gxplus1             
               
               check_wall          gxminus1,gy,#18,#12,#2               
               check_wall          gxplus1,gy,#12,#18,#3
               
               rts

mv_gh          
               lda ispacman
               cmp #1
               bne  notpacman
               
               ldx #0 
shortloop      lda userdirection
               cmp g$,x
               beq match 
               inx
               cpx g$len
               bne shortloop
               rts
; if there is a match, this means pac-clone can move in that direction
; so we want to hard code the direction
match          lda userdirection
               sta g$
               sta gh1_g$
               sta gh1_cdir
               sta cdir
              
               ldy #0
               sty g$len                             
               
               jmp ck_1

notpacman      inc                 yy                  
               lda                 yy                  
               cmp                 ghost_pr
               bne                cont5                 
               
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
               sta                 cdir                 

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
               bne addtogx
               lda #0
               sta warp
               jmp skip      

                
addtogx        inc                 gx                  
skip           
               ldx                 gd
               lda                 g$,x
               sta                 pd$                 

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

RAND           LDA $D41B                                ; get random value from 0-255
               CMP g$len
                          
               BCS RAND   
               rts
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
@sk1           lda #21              
               sta                 pd$                  
               lda                 #18                 
               sta cdir
               rts

@check2        
               lda                 #21                 
               sta                 pd$                  
               lda                 #12
               sta                 cdir                 
@bottom        rts               
MAPL           BYTE                <MAP_DATA
MAPH           BYTE                >MAP_DATA

MAP_DATA
incbin         pacmap.bin

turn_on_btime  

               lda #1                                   ; Yes, then Turn on 
               sta gh2_bluetime                         ; blue time
               sta gh3_bluetime                         ; for all ghosts
               sta gh4_bluetime                         ;
               sta gh5_bluetime                         ;

               lda blue_ghost                           ; Change ghost char to
               sta wall5                                ; this character
               sta wall6                                ; during bluetime
               sta wall7                                ;
               sta wall8                                ;
               lda #19
               sta gh2_xg
               sta gh3_xg
               sta gh4_xg
               sta gh5_xg
               lda #14
               sta gh2_yg
               sta gh3_yg
               sta gh4_yg
               sta gh5_yg
               rts         

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
