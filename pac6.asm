; G^Ray Defender
; 11/11/2015
;
; 12/19/15
; Adding logic to make ghosts smarter,
; make them follow pac-man
; 
; Logic to eat the ghosts Part 1
;  * blue time mode added
; 12/22/15
; Logic to eat the ghosts Part 2
;  * blue time duration
;  * make ghosts move away from pac-clone
; 01/11/16
; Add eyes logic to make ghost move back to ghost cage
; once it has been 'eaten'
;01/16/16 Make pac-clone move in last direction of travel
; even if input is not given
;if wall is hit in attempted direction make pac-clone
;continue along previous path until end of path
; * Bug fixes
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

Cage_Xpos      byte                19
Cage_Ypos      byte                12

junk5              byte                $31,$31,$31
gh2_eyesmode       byte                00
junk6              byte                 $32,$32,$32
gh2_bluetime       byte                00
junk7              byte                $33,$33,$33
gh2_btime_count    byte                255
junk8              byte                $34,$34,$34
gh2_cage_cntr      byte                00
junk9              byte                $35,$35,$35
gh2_exit_cage_flg  byte                00
junka              byte                $36,$36,$36
gh2_xg             byte                0 ;39
junk1              byte                $37,$37,$37
gh2_yg             byte                12
junk2              byte                $38,$38,$38
gh1_gy             byte                10
gh1_gx             byte                16
gh1_pq$            byte                $00,$00

gh1_pq$len         byte                00

gh1_g$             byte                $00,$00,$00,$00

gh1_g$len          byte                00

gh1_xg             byte                39

gh1_yg             byte                12

gh1_pr_cntr             byte                0
junkb              byte                $39,$39,$39
gh1_pr             byte                100
junk3              byte                $30,$30,$30
gh1_pd$            byte                21
junkc              byte                $31,$31,$31
gh1_cdir           byte                4
junk4              byte                $32,$32,$32
gh1_bluetime       byte                00
gh1_btime_count    byte                50
gh1_eyesmode       byte                01
gh1_cage_cntr      byte                00
gh1_exit_cage_flg  byte                00

gh2_gx             byte                1
gh2_gy             byte                6
gh2_pq$            byte                $00,$00
gh2_g$             byte                $00,$00,$00,$00
xjunk5             byte                $31,$31,$31
zjunk5             byte                $31,$31,$31
gh2_pr_cntr             byte                0
gh2_pd$            byte                21
gh2_cdir           byte                4
ejunk5             byte                $31,$31,$31

gh2_pq$len         byte                00
gh2_g$len          byte                00

junkxx             byte                $30,$30,$30
gxminus1           byte                00           
gxplus1            byte                00
gyminus1           byte                00           
gyplus1            byte                00


gx             byte                0
gy             byte                00
pq$            byte                $00,$00
pq$len         byte                00
g$             byte                $00,$00,$00,$00
g$len          byte                00
g$eyesmode     byte                00
g$cage_cntr    byte                00
g$bluetime     byte                00
g$exit_cage_flg byte               00
xg             byte                0
yg             byte                0
pr_cntr             byte                0
ghost_pr       byte                3
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
wall5          byte                57  ; ghost char 1
wall6          byte                49  ; ghost char 2
wall7          byte                49  ; ghost char 3    
wall8          byte                49  ; ghost char 4
wall9          byte                45  ; '-' this is the cage minus char
blue_ghost     byte                52  ;Change ghost to this during blue time
eyemode        byte                55  ;Change ghost to this during eyemode
;*****************************************************

gh3_gx             byte                32
gh3_gy             byte                4
gh3_pq$            byte                $00,$00
gh3_g$             byte                $00,$00,$00,$00
gh3_xg             byte                39
gh3_yg             byte                12
gh3_pr_cntr             byte                0
gh3_pd$            byte                21
gh3_cdir           byte                4
gh3_pq$len         byte                00
gh3_g$len          byte                00
gh3_bluetime       byte                00
gh3_btime_count    byte                50
gh3_eyesmode       byte                00
gh3_cage_cntr      byte                00
gh3_exit_cage_flg  byte                00

gh4_gx             byte                32
gh4_gy             byte                14
gh4_pq$            byte                $00,$00
gh4_g$             byte                $00,$00,$00,$00
gh4_xg             byte                39
gh4_yg             byte                12
gh4_pr_cntr             byte                0
gh4_pd$            byte                21
gh4_cdir           byte                4
gh4_pq$len         byte                00
gh4_g$len          byte                00
gh4_bluetime       byte                00
gh4_btime_count    byte                50
gh4_eyesmode       byte                00
gh4_cage_cntr      byte                00
gh4_exit_cage_flg  byte                00

gh5_gx             byte                32
gh5_gy             byte                14
gh5_pq$            byte                $00,$00
gh5_g$             byte                $00,$00,$00,$00
gh5_xg             byte                11
gh5_yg             byte                12
gh5_pr_cntr             byte                0
gh5_pd$            byte                21
gh5_cdir           byte                4
gh5_pq$len         byte                00
gh5_g$len          byte                00
gh5_bluetime       byte                00
gh5_btime_count    byte                50
gh5_eyesmode       byte                00
gh5_cage_cntr      byte                00
gh5_exit_cage_flg  byte                00

warp               byte 00
ispacman           byte 00
userdirection      byte 00
pac_pd$            byte 00 ; used to keep pac-man moving in same general direction of travel 
HIGH_PR            byte 100  ; High priority for eyes returning to cage
gh2_pr             byte                05
gh3_pr             byte                04
gh4_pr             byte                03
gh5_pr             byte                02

gh2_DEF_PR         byte                05             ; Default values to reset back to
gh3_DEF_PR         byte                04
gh4_DEF_PR         byte                03
gh5_DEF_PR         byte                02

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
               beq                 @notwall
               cmp                 wall8
               beq                 @notwall

              
               cmp                 wall9
               bne                 @bottom

               lda                 ispacman   ; Don't let pac-man
               cmp #1                         ; into the ghost cage
               beq @bottom                    ;  

               lda                 g$eyesmode ;is eyemode activated?
               cmp                 #1
               beq                 @notwall
               lda                 g$exit_cage_flg 
               cmp                 #1
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

@zero          lda                 gy                  
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
               sta pr_cntr
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
               lda /4 
               sta g$eyesmode
               lda /5
               sta g$cage_cntr
               lda /6
               sta g$exit_cage_flg 
               endm

defm turn_on_btime  
               lda /3                   ;Is eyesmode on?
               cmp #1                   ; if so skip to bottom
               beq @bottom              
               lda #1                   ; Yes, then Turn on 
               sta /1                   ; blue time
                                        ;
                                        ;

               lda blue_ghost           ;Change ghost char to
               sta /2                   ; this character
                                        ; during bluetime
                                                       
@bottom               
               endm 

defm move_ghosts_part3
               jsr check_end 
               jsr Check_Walls 
               lda ispacman 
               cmp #1
               beq @skip

               jsr ck_leftside
               jsr ck_rightside                                
               
@skip           nop  
              jsr space


               jsr mv_gh 

@baa           nop        
               lda pr_cntr
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
@skipa         lda ghost_pr 
               sta /7
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
               lda #255                         ; If so then reset the blue time
               sta /2                          ; counter, turn off blue time
               lda #0                          ; and change ghost character
               sta /1                          ; back to normal
               lda #49
               sta /3

@quit          nop
               endm
;*****************************************************
;  Compare Ghost X and Y to Pac X and Y
;  If they are equal then check blue time
;  If blue time is on then Pac-Clone eats the ghost
;  otherwise pac-clone should die.
;*****************************************************
defm Collision
              lda /1              
              cmp gh1_gx        ; Does Ghost X = Pac X  ?
              bne @bottom       ; NO
              lda /2            
              cmp gh1_gy        ; Does Ghost Y = Pac Y ? 
              bne @bottom       ; No

              lda /3            ; Blue time on?
              cmp #1
              bne @bottom       ; NO

              lda #0            ; Turn off bluetime
              sta /3   

              lda #1            ; Toggle Eyesmode
              sta /4            ; 
              lda eyemode       ; Change to eyemode character
              sta /5
              lda Cage_Xpos     ; Load New Dest X and 
              sta /6 
              lda Cage_Ypos     ; Dest Y values for ghost cage 
              sta /7
              lda HIGH_PR       ;Change priority of eyes to always move towards priority
              sta /8
              sta ghost_pr
              lda #0
              sta /9
@bottom       nop
              endm

;*****************************************************
;* Check to see if ghost is entering /exiting cage
;* If exiting then turn off eyes mode and change ghost char
;* And reset ghost priority 
;*****************************************************
defm check_cage             
               lda /2             ; Eyes mode enabled?
               cmp #0
               beq @exit          ; If not exit 
               lda /6             ; Bluetime enabled?
               cmp #1             ; If so exit
               beq @exit

               lda gy             
               cmp Cage_Ypos            
               bne @exit
                                    
               lda gx                  
               cmp Cage_Xpos
               bne @exit

               lda #$0           ; entering or exiting cage then reset flag
               sta /3            ; Reset the cage exit flag to 0
      
               lda #0            ; Ghost back in cage turn off eyes mode
               sta /2      
               lda #57           ; Reset ghost character to non ghost char
               sta /1
                                 ;****fix - ghosts leaving cage had bad priority
               lda /4            ; Reset ghost priority when entering cage
               sta /5            ;               
@exit          nop
               endm

;*****************************************************
;* Once ghost is in cage, ensure it bounces back
;* and forth at least two times before exiting
;* thats what the g$cage_cntr var is for
;*****************************************************

defm CageDrama
              lda g$cage_cntr               
              cmp #2             ;has ghost hit left side of cage 2 times?
              bne @skp_bot
                                 ;Allow ghost to exit the cage
              lda #1             ; set the exit cage flag
              sta /1             ; allow ghost to exit the cage
              lda #255           ;hard coded blue time count reset
              sta /2
              lda #0             ;Turn off Eyes mode
              sta /4
             
              lda #1
              sta /6             ;change the yg value so caged ghost will escape upwards
              sta yg

              lda /7             ;reset to default priority ghost exiting cage
              sta /5   
              sta ghost_pr
              lda #0
              sta g$cage_cntr    
            
@skp_bot      sta /3
              nop
              endm

;*************************************************************
; Set the end goal location of the ghosts to be
; where ever pac-clone is on the map
; unless Eyesmode is on then leave it alone...
;*************************************************************
;defm    SetGH_XY 
;              lda /1            ; Eyesmoode On?
;              cmp #1            
;              beq @bot          ; If yes exit 
;              lda xg            ; Otherwise
;              sta /2            ; Set new ghost priority
;              lda yg            ; to match the location 
;              sta /3            ; of pac-clone on the map
              
;@bot          nop
;              endm

;*****************************************************
; This code tells the ghosts where
; Pac-clone is on the map but we dont want them
; To know where he is if bluetime is on, in fact
; this code tells the ghosts to run to the opposite
; side of the map relative to pac-clone
;*****************************************************
defm updatexy 
               lda /1            ; Is bluetime on? 
               cmp #1            ;
               beq @thwart_gh    ; Yes then continue
               lda /2            ; Check if eyes mode is on
               cmp #1            ; if Yes then dont change xy destination points
               beq @bot

               lda /5           ; Check exit cage flag is set to 1
               cmp #1           ; This should prevent ghost bouncing back
                                ; and forth endlessly in cage
               beq @bot 

               lda gh1_gx       
               sta /3               
               lda gh1_gy       
               sta /4
               jmp @bot

@thwart_gh     lda gh1_gx
               cmp #20
               bcs @skip
               lda #39
               sta /3
               jmp @ck_y
@skip          lda #1
               sta /3               
                  
@ck_y          lda gh1_gy
               cmp #12
               bcs @skip2
               lda #24
               sta /4
               jmp @bot
@skip2         lda #1      
               sta /4                               
@bot        
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
              ; lda                  #46
              ; pokeaxy              xg,yg
main_prg_lp
               
                
               peekaxy             gh1_gx,gh1_gy                ; Did Pac-Clone eat
               cmp                 wall3__nrgzr         ; the energizer?
               bne                 sk_385               ; NO, then skip 

              
               turn_on_btime  gh2_bluetime,wall5,gh2_eyesmode ; Turn on blue time
               turn_on_btime  gh3_bluetime,wall6,gh3_eyesmode ; want to turn it on
               turn_on_btime  gh4_bluetime,wall7,gh4_eyesmode ; unless eyemode
               turn_on_btime  gh5_bluetime,wall8,gh5_eyesmode ; is activated

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
               cmp                 #$5a ; z down pressed
               beq                 udir
               cmp                 #$57   ; up w pressed
               beq                 udir               
               cmp                 #$41  ; left a pressed
               beq                 udir
               cmp                 #$53  ; right s pressed 
               beq                 udir
              
               lda gh1_cdir             ;This makes pac-clone move in the last current dir when no input given
             ;  jmp continue 

leftright      cmp #12
               beq ggg
               cmp #18
               beq nextck4

udir           cmp #$5a
               bne nextck1
               lda gh1_gy
               cmp #12
               bne ff
               lda gh1_gx
               cmp #0
               bne f1               
               lda gh1_cdir
               jmp leftright             
f1             cmp #39
               bne ff
               lda gh1_cdir
               jmp leftright


ff             lda #4               
               jmp continue
nextck1        cmp #$57
               bne nextck2 
               
               lda gh1_gy
               cmp #12
               bne sk_down
               lda gh1_gx
               sta $401
               cmp #0           
               bne z1
               lda gh1_cdir             ;This makes pac-clone move in the last current dir when no input given
               jmp leftright
z1             cmp #39
               bne sk_down 
               lda gh1_cdir
               jmp leftright
               

sk_down        lda #21               
               jmp continue 
nextck2        cmp #$41
               bne nextck3

ggg             
               jsr ck_leftside3

               jmp notthis
notthis        lda #12
             
               jmp continue 
nextck3        cmp #$53
               beq nextck4               
              

nextck4        
               jsr ck_rightside3
               jmp notthis2

notthis2       lda #18
                 
continue       sta userdirection


             
    
               lda #1
               sta ispacman
               lda #0               
               sta gh1_pd$
;**** MOVE GHOSTS *****
               jsr mv_Ghost1


skip_gh        lda #0
               sta ispacman

               jsr mv_Ghost2
               jsr mv_Ghost3

 
;***DEBUG
               jsr mv_Ghost4
               jsr mv_Ghost5
 
               lda gh2_pr
               sta $410
               lda gh2_xg
               sta $411
               lda gh2_yg
               sta $412

               lda gh3_pr
               sta $413
               lda gh3_xg
               sta $414
               lda gh3_yg
               sta $415

               lda gh4_pr
               sta $416
               lda gh4_xg
               sta $417
               lda gh4_yg
               sta $418

               lda gh5_pr
               sta $419
               lda gh5_xg
               sta $41a
               lda gh5_yg
               sta $41b
               jmp                 main_prg_lp   
               rts


ck_leftside3   lda gh1_gx
               sta $410

               cmp #0
               bne exit_ck3

               lda gh1_gy 

               cmp #12
               bne exit_ck3

               lda                 #32
               pokeaxy             gh1_gx,gh1_gy               
               lda                 #39                 
               sta                 gx 
               sta                 gh1_gx

               lda                 wall4
               pokeaxy             gh1_gx,gh1_gy 

               lda #1
               sta warp
exit_ck3       rts

ck_rightside3  lda gh1_gx
               cmp #39
               bne exit_ck4
               lda gh1_gy 
               cmp #12
               bne exit_ck4
               
               lda                 #32
               pokeaxy             gh1_gx,gh1_gy               
               lda                 #0                 
               sta                 gx 
               sta                 gh1_gx

               lda                 wall4
               pokeaxy             gh1_gx,gh1_gy 
               lda #1
               sta warp
exit_ck4       rts


ck_leftside    lda                 cdir                 
               cmp                 #18                 
               beq                 @end                

               lda                 #32
               pokeaxy             gx,gy               
               jsr                 Check_Walls         
               lda                 gx
               cmp                 #0                  
               bne                 @end
               lda                 #39                 
               sta                 gx 
               lda                 #1
               sta                 warp                 
@end           rts               

ck_rightside
               lda                 cdir                
               cmp                 #12
               beq                 @end                

               lda                 #32
               pokeaxy             gx,gy 
               lda                 gx
            ;   sta                 $409                
               
               cmp                 #39                 
               bne                 @end

@skip                       
               lda                 #$00                 
               sta                 gx
           
               lda #1
               sta warp
@skip2        
               jsr Check_Walls

@end           rts

;*************************************************************
;* Check of Pac-Clone is on top of a particular ghost
;* If this happens with blue time on the the ghost
;* should turn into eyeballs and return to the cage with high
;* priority
;*************************************************************
Collision
              lda /1            ;  Compare Ghost X and Y to Pac X and Y
              cmp gh1_gx        ;  If they are equal then check blue time
              bne @bottom       ;  If blue time is on then Pac-Clone eats the ghost
              lda /2            ;  otherwise pac-clone should die.
              cmp gh1_gy
              bne @bottom

              lda /3            ; Blue time on?
              cmp #1
              bne @bottom

              lda #0            ; Turn off bluetime
              sta /3   

              lda #1            ; Toggle Eyesmode
              sta /4            ; 
              lda eyemode       ; Change to eyemode character
              sta /5
              lda Cage_Xpos  
              sta /6
              lda Cage_Ypos  
              sta /7
              lda HIGH_PR       ;Change priority of eyes to always move towards priority
              sta /8
              sta ghost_pr
              lda #0                
              sta /9
@bottom       nop
              rts


;*************************************************************
; Collisions must be checked before and after moving pac-clone
; A collision occurs when a ghost runs into pac-clone
; One of two things should happen
;
; 1) Bluetime is enabled
; 2) Pac-Clone dies
;*************************************************************
Collisions

              Collision gh2_gx,gh2_gy,gh2_bluetime,gh2_eyesmode,wall5,gh2_xg,gh2_yg,gh2_pr,gh2_pr_cntr 
              Collision gh3_gx,gh3_gy,gh3_bluetime,gh3_eyesmode,wall6,gh3_xg,gh3_yg,gh3_pr,gh3_pr_cntr  
              Collision gh4_gx,gh4_gy,gh4_bluetime,gh4_eyesmode,wall7,gh4_xg,gh4_yg,gh4_pr,gh4_pr_cntr
              Collision gh5_gx,gh5_gy,gh5_bluetime,gh5_eyesmode,wall8,gh5_xg,gh5_yg,gh5_pr,gh5_pr_cntr 
              rts
mv_Ghost1    
             
              jsr Collisions
              move_ghosts_part1 gh1_pr_cntr,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_xg,gh1_yg,gh1_pr
              move_ghosts_part2 gh1_cdir,gh1_pq$len,gh1_g$len,gh1_eyesmode,gh1_cage_cntr,gh1_exit_cage_flg
              move_ghosts_part3 gh1_pr_cntr,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_pr                           
              move_ghosts_part4 gh1_cdir,gh1_pq$len,gh1_g$len                           
              jsr Collisions
              ;***********************************************
              ;** Make ghosts follow Pac-CLone
              updatexy gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg,gh2_exit_cage_flg 
              updatexy gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg,gh3_exit_cage_flg
              updatexy gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg,gh4_exit_cage_flg
              updatexy gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg,gh5_exit_cage_flg    
               ;***********************************************

              lda #45
              sta 1523-40
              lda #160
              sta 1524-40
              rts


mv_Ghost2    
             
              move_ghosts_part1 gh2_pr_cntr,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_xg,gh2_yg,gh2_pr
              move_ghosts_part2 gh2_cdir,gh2_pq$len,gh2_g$len,gh2_eyesmode,gh2_cage_cntr,gh2_exit_cage_flg
              move_ghosts_part3 gh2_pr_cntr,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_pr
             ; SetGH_XY gh2_eyesmode,gh2_xg,gh2_yg
              check_cage wall5,gh2_eyesmode,gh2_exit_cage_flg,gh2_DEF_PR,gh2_pr,gh2_bluetime          
              check_btime gh2_bluetime,gh2_btime_count,wall5              
              move_ghosts_part4 gh2_cdir,gh2_pq$len,gh2_g$len
              CageDrama gh2_exit_cage_flg,gh2_btime_count,gh2_cage_cntr,gh2_eyesmode,gh2_pr,gh2_yg,gh2_DEF_PR
              

             

              lda gh2_eyesmode
              sta $405
              lda gh2_bluetime
              sta $409
              
              rts

mv_Ghost3   
              move_ghosts_part1 gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_xg,gh3_yg,gh3_pr
              move_ghosts_part2 gh3_cdir,gh3_pq$len,gh3_g$len,gh3_eyesmode,gh3_cage_cntr,gh3_exit_cage_flg
              move_ghosts_part3 gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_pr
             ; SetGH_XY gh3_eyesmode,gh3_xg,gh3_yg
              check_cage wall6,gh3_eyesmode,gh3_exit_cage_flg,gh3_DEF_PR,gh3_pr,gh3_bluetime            
              check_btime gh3_bluetime,gh3_btime_count,wall6
              move_ghosts_part4 gh3_cdir,gh3_pq$len,gh3_g$len
              CageDrama gh3_exit_cage_flg,gh3_btime_count,gh3_cage_cntr,gh3_eyesmode,gh3_pr,gh3_yg,gh3_DEF_PR
            
              lda gh3_eyesmode
              sta $406
              lda gh3_bluetime
              sta $40a
              rts

mv_Ghost4    
              move_ghosts_part1 gh4_pr_cntr,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_xg,gh4_yg,gh4_pr
              move_ghosts_part2 gh4_cdir,gh4_pq$len,gh4_g$len,gh4_eyesmode,gh4_cage_cntr,gh4_exit_cage_flg
              move_ghosts_part3 gh4_pr_cntr,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_pr
              ;SetGH_XY gh4_eyesmode,gh4_xg,gh4_yg
              check_cage wall7,gh4_eyesmode,gh4_exit_cage_flg,gh4_DEF_PR,gh4_pr,gh4_bluetime           
              check_btime gh4_bluetime,gh4_btime_count,wall7
              move_ghosts_part4 gh4_cdir,gh4_pq$len,gh4_g$len
              CageDrama gh4_exit_cage_flg,gh4_btime_count,gh4_cage_cntr,gh4_eyesmode,gh4_pr,gh4_yg,gh4_DEF_PR
              
              lda gh4_eyesmode
              sta $407
              lda gh4_bluetime
              sta $40b
              rts

mv_Ghost5   
              move_ghosts_part1 gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_xg,gh5_yg,gh5_pr
              move_ghosts_part2 gh5_cdir,gh5_pq$len,gh5_g$len,gh5_eyesmode,gh5_cage_cntr,gh5_exit_cage_flg
              move_ghosts_part3 gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_pr
             ; SetGH_XY gh5_eyesmode,gh5_xg,gh5_yg
              check_cage wall8,gh5_eyesmode,gh5_exit_cage_flg,gh5_DEF_PR,gh5_pr,gh5_bluetime             
              check_btime gh5_bluetime,gh5_btime_count,wall8
              move_ghosts_part4 gh5_cdir,gh5_pq$len,gh5_g$len
              CageDrama gh5_exit_cage_flg,gh5_btime_count,gh5_cage_cntr,gh5_eyesmode,gh5_pr,gh5_yg,gh5_DEF_PR
            
              lda gh5_eyesmode
              sta $408
              lda gh5_bluetime
              sta $40c
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
;============================================================
; scan the possible direction pac-clone can move
; if there is a match with the accumulater than 
; return 'beq' otherwise return 'bne'
;
check_match                    ; Check if pac-clone hits a wall1
                               ; needed for sprite mouth to stay open on hit
               ldx #0
loop           cmp g$,x
               beq ext_sub
               inx
               cpx g$len
               bne loop
               ldx #1         ;These two lines are here because 
               cpx #2         ;need to set the BNE flag return 'bne'
ext_sub        rts



mv_gh    

               lda ispacman
               cmp #1
               bne  notpacman
               
               lda userdirection  ;Check can pclone move in user direction
               jsr check_match    ;
               beq match          ; Match means 'yes'
               
               sta $429           ; store direction in which wall was hit
                                  ; Need this information for furture when
                                  ; sprites are enabled you want pclone mouth
                                  ; to stay open when wall hit

               lda cdir           ;Check can pclone move in current dir of travel
               jsr check_match    ;
               beq match2         ;Match means 'yes'
               rts        

match          lda userdirection
match2         sta g$
               sta gh1_g$
               sta gh1_cdir
               sta cdir
              
               ldy #0
               sty g$len                             

               jmp ck_1

notpacman

               
               peekaxy         gx,gyplus1       ;This code here will force 
               cmp wall9                        ;ghost eyes to move down
               bne contb                        ;if directly over
               lda                 g$eyesmode   ;the entrance to ghost cage
               cmp                 #1           ;
               bne                 contb        ;
               lda #4                           ;
               jmp ck_2                         ;



contb          inc                 pr_cntr                  
               lda                 pr_cntr                  
               cmp                ghost_pr
               bne                cont5                 
               
               lda                 #0                  
               sta                 pr_cntr                  

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

ck_1           cmp                 #21     ; Up
               bne                 ck_2                
               dec                 gy                  
               ;jmp                 skip
               
ck_2           cmp                 #4      ; Down
               bne                 ck_3                
               inc                 gy                  
              ; jmp                 skip

ck_3           cmp                 #12     ; Left
               bne                 ck_4     

               lda warp
               cmp #1 
               bne subtox
;            jmp blah               
               lda #0
               sta warp
               lda g$,x
               jmp ck_4
           

subtox         dec                 gx 

ck_4           cmp                 #18     ; Right
               bne                 skip

;               jmp                 skip
               
;skip2          lda gh1_cdir
;               sta $40a
;blah           jmp blah
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
;============================================================

check_end     
               lda                 gy                  
               cmp                 #12                  
               bne                 exit_sub

               lda                 gx                  
               cmp                 #18                  
               beq                 sk1
               cmp                 #21                 
               beq                 check2

exit_sub       rts
sk1 
               inc g$cage_cntr    ;Increment this counter every time the ghost hits the left side of the cage
              ; lda #49
              ; sta $400
              ; sta $401

               lda #21              
               sta                 pd$
                 
               lda                 #18                 
               sta cdir       
               rts

check2        
              ; lda #55
              ; sta $400
              ; sta $401


               lda                 #21
               sta pd$
 
               sta cdir         
               sta g$
             

@bott          rts               



              
MAPL           BYTE                <MAP_DATA
MAPH           BYTE                >MAP_DATA

MAP_DATA
incbin         pacmap3.bin


space
               lda                 #32
               pokeaxy             gx,gy               
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
