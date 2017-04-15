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
; * 1/19/16 Add Comments, formatting & change variable names
; * 1/22/16 Fix program crash in RAND sub
; * Change ghosts to turn back to 1,2,3,4 after blue time
; * reformat code 20,20,20 - spacing wise
; * Add scoring routine for dots and power pills
; * 1/23/16 Add score for eating ghosts
; * 1/25/16 Add level logic
; * 1/26/16 Add Ready text
; * 1/27/16 add pac-death noooo
; * Bug Fixes
; * 2/3/16 Fix Warp Tunnel Logic and Keyboard press logic
; * Previously had separate warp code for ghosts vs pac-clone
; * 2/27/16 Add Ghost sprites
; *         add eye sprites
;============================================================
;  Quick code to create auto execute program from basic
;============================================================
*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $32, $34, $35, $37, $36, $00
                    byte                $00,$00
#region Program Variables

junklskdfj          byte $31,$31,$31
gh2_eyesmode        byte                00
gh2_bluetime        byte                00
gh2_cage_cntr       byte                00
gh2_exit_cage_flg   byte                00
gh2_xg              byte                0;39
gh2_yg              byte                0;12
gh2_gx              byte                0;18
gh2_gy              byte                0;12
gh2_pq$             byte                $00,$00
gh2_g$              byte                $00,$00,$00,$00
gh2_pd$             byte                0;21
gh2_cdir            byte                0;21
gh2_pq$len          byte                00
gh2_g$len           byte                00
gh2_spctr           byte                00
gh2_sp_pos          byte                00
;gh2_flashctr        byte                00

Cage_Xpos           byte                19
Cage_Ypos           byte                12


gh1_gy              byte                0;10
gh1_gx              byte                0;39
gh1_pq$             byte                $00,$00
gh1_pq$len          byte                00
gh1_g$              byte                $00,$00,$00,$00
gh1_g$len           byte                00
gh1_xg              byte               0; 39
gh1_yg              byte               0; 12
gh1_pr              byte                00
gh1_pr_cntr         byte                0
gh1_spctr           byte                00

gh1_pd$             byte                0

gh1_cdir            byte                0;4

gh1_bluetime        byte                00
gh1_eyesmode        byte                00
gh1_cage_cntr       byte                00
gh1_exit_cage_flg   byte                00
;gh1_Const_sp_Max    byte                24
gh1_sp_pos          byte                00



gxminus1            byte                00
gxplus1             byte                00
gyminus1            byte                00
gyplus1             byte                00
gx                  byte                0
gy                  byte                00
pq$                 byte                $00,$00
pq$len              byte                00
g$                  byte                $00,$00,$00,$00
g$len               byte                00
g$eyesmode          byte                00
g$cage_cntr         byte                00
g$bluetime          byte                00
g$exit_cage_flg     byte                00
xg                  byte                0
yg                  byte                0
pr_cntr             byte                0
ghost_pr            byte                3
pd$                 byte                0
cdir                byte                0
px                  byte                20
py                  byte                23
map_off_l           byte                $00,$28,$50,$78,$A0,$C8,$F0,$18,$40,$68,$90,$b8,$E0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0
map_off_h           byte                $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07
wall_dot            byte                46  ; period '.'
wall_spc            byte                32  ; space ' '
wall3__nrgzr        byte                42  ; asterisk '*'
pac_char            byte                48  ; Pac-Clone char
gh2_char            byte                49  ; variable ghost char 1
gh3_char            byte                50  ; variable ghost char 2
gh4_char            byte                51  ; variable ghost char 3
gh5_char            byte                52  ; variable ghost char 4
Const_gh2_char      byte                49  ; Constant ghost char 1
Const_gh3_char      byte                50  ; Constant ghost char 2
Const_gh4_char      byte                51  ; Constant ghost char 3
Const_gh5_char      byte                52  ; Constant ghost char 4
wall_cge            byte                45  ; '-' this is the cage minus char
blue_ghost          byte                53  ;Change ghost to this during blue time
Flashing_gh         byte                54
;Const_Eyemode       byte                55  ;Change ghost to this during eyemode
;*****************************************************
gh3_gx              byte                0;32
gh3_gy              byte                0;4
gh3_pq$             byte                $00,$00
gh3_g$              byte                $00,$00,$00,$00
gh3_xg              byte                0;39
gh3_yg              byte                0;12
gh3_pd$             byte                0;21
gh3_cdir            byte                0;4
gh3_pq$len          byte                00
gh3_g$len           byte                00
gh3_bluetime        byte                00
gh3_eyesmode        byte                00
gh3_cage_cntr       byte                00
gh3_exit_cage_flg   byte                00
gh3_spctr           byte                00
gh3_sp_pos          byte                00
;gh3_flashctr        byte                00

gh4_gx              byte                0;32
gh4_gy              byte                0;14
gh4_pq$             byte                $00,$00
gh4_g$              byte                $00,$00,$00,$00
gh4_xg              byte                0;39
gh4_yg              byte                0;12
gh4_pd$             byte                0;21
gh4_cdir            byte                0;4
gh4_pq$len          byte                00
gh4_g$len           byte                00
gh4_bluetime        byte                00
gh4_eyesmode        byte                00
gh4_cage_cntr       byte                00
gh4_exit_cage_flg   byte                00
gh4_spctr           byte                00
gh4_sp_pos          byte                00
;gh4_flashctr        byte                00

gh5_gx              byte                32
gh5_gy              byte                14
gh5_pq$             byte                $00,$00
gh5_g$              byte                $00,$00,$00,$00
gh5_xg              byte                11
gh5_yg              byte                12
gh5_pd$             byte                21
gh5_cdir            byte                4
gh5_pq$len          byte                00
gh5_g$len           byte                00
gh5_bluetime        byte                00
gh5_eyesmode        byte                00
gh5_cage_cntr       byte                00
gh5_exit_cage_flg   byte                00
gh5_spctr           byte                00
gh5_sp_pos          byte                00
;gh5_flashctr        byte                00

ispacman            byte                00
userdirection       byte                00
pac_pd$             byte                00   ; used to keep pac-man moving in same general direction of travel
HIGH_PR             byte                1    ; High priority for eyes returning to cage
PARAM1              byte                00
PARAM2              byte                00
SCORE_POS           = $411                                  ; Position of First 0 in score from left
SAVED_SCORE         byte                0,0,0,0,0,0
GHOSTS_EATEN        byte                00                  ; Count Number of ghosts eaten per blue time
DOTS_EATEN          byte                00
COLOR_CNTR          byte                15                  ; Number of screen flashes between levels
PACS_AVAIL          byte                5
DEATH_FLAG          byte                00                   ; 1 if pac be dead
Const_TOTAL_DOTS    byte                206                  ; Total number of dots on the map
TOTAL_DOTS_FLAG     byte                0                    ; Needed since more than 255 dots on map
gh2_pr_cntr         byte                0                    ; Current GH priority counters
gh3_pr_cntr         byte                0                    ; These counters count up
gh4_pr_cntr         byte                0                    ; until they match the default priority
gh5_pr_cntr         byte                0                    ; then they get reset
gh2_pr              byte                00                   ; Current GH2 Priority
gh3_pr              byte                00                   ; Current GH3 Priority
gh4_pr              byte                00                   ; Current GH4 Priority
gh5_pr              byte                00                   ; Current GH5 Priority
gh2_bt_count        byte                255
gh3_bt_count        byte                50
gh4_bt_count        byte                50
gh5_bt_count        byte                50

gh2_flashon         byte                00
gh3_flashon         byte                00
gh4_flashon         byte                00
gh5_flashon         byte                00

tempsprite          byte                00

sprxmap             byte                $00,$02,$04,$06,$08
sprmap2             byte                %00000001,%00000010,%00000100,%00001000,%00010000

sprite_addr2       byte                $f8,$f9,$fa,$fb,$fc  ; Ghost addresses for sprites

sprite_color_adr2   byte                $28,$29,$2a,$2b
sprite_dir          byte                $8c,$8d,$8e,$8f  ; ghosts up down left right
sprite_dir2         byte                $92,$93,$90,$91  ; ghost eyes up down left right
sprcolor            byte                $1, $0a, $3, $2
close_mouth         byte                00
spreyecolor         byte                $1,$1,$1,$1
Const_UP            byte                $57                  ;Currently matching
Const_DOWN          byte                $5a                  ;Getch return values
Const_LEFT          byte                $41                  ;for up down left right
Const_RIGHT         byte                $53
;*****************************************************
; Level Defaults
; First byte is level 1, second level 2, etc.
;*****************************************************
GAME_LEVEL          byte                $00                                 ; Game Level defaults to 0, after calling RESET_LEVEL
;** defautl ghosts bluetime duration **
Const_gh2_bt_DEF    byte                080,060,020,020,015,005,001         ; Blue time Reset counter 1
Const_gh3_bt_DEF    byte                080,060,020,020,015,005,001         ; Blue time Reset counter 2
Const_gh4_bt_DEF    byte                080,060,020,020,015,005,001         ; Blue time Reset counter 3
Const_gh5_bt_DEF    byte                080,060,020,020,015,005,001         ; Blue time Reset counter 4
;** FLash ghosts length of time **
Const_gh2_bt_DEF2   byte                030,015,010,009,008,004,001         ; Blue time counter 1
Const_gh3_bt_DEF2   byte                060,015,012,010,008,005,001         ; Blue time counter 2
Const_gh4_bt_DEF2   byte                060,015,012,010,008,005,001         ; Blue time counter 3
Const_gh5_bt_DEF2   byte                060,015,012,010,008,005,001         ; Blue time counter
Const_gh2_DEF_PR    byte                002,040,006,013,010,008,007         ;
Const_gh3_DEF_PR    byte                001,030,005,010,008,007,006         ;
Const_gh4_DEF_PR    byte                020,020,004,010,008,006,004         ;
Const_gh5_DEF_PR    byte                040,026,003,$36,$35,$34,$33         ; Default values to reset back to
gh1_sp_boost_goal   byte                01,007,006,005,004,003,001
gh2_sp_boost_goal   byte                008,007,006,005,004,003,002
gh3_sp_boost_goal   byte                010,009,007,006,005,004,003
gh4_sp_boost_goal   byte                010,009,007,006,005,004,003
gh5_sp_boost_goal   byte                010,009,007,006,005,004,003

#endregion
#Region Macro Subs Located here
;*****************************************************
; Grab value of screen position located at x,y
; Store result in accumulator
;*****************************************************
defm                peekaxy
                    ldx                 /2                  ; X value
                    ldy                 /1                  ; Y Value
                    lda                 map_off_l,x         ; Load map low byte into $fd
                    sta                 $fd
                    lda                 map_off_h,x         ; Load map hig byte into $fe
                    sta                 $fe
                    lda                 ($fd),y             ; Load result into acc
                    endm
;*****************************************************
; Store value of accumulator in screen memory at position
; x, y
;*****************************************************
defm                pokeaxy
                    pha
                    ldx                 /2                  ; X value
                    ldy                 /1                  ; Y value
                    lda                 map_off_l,x         ; Load map low byte into $fd
                    sta                 $fd
                    lda                 map_off_h,x         ; Load map high byte into $fd
                    sta                 $fe
                    pla
                    sta                 ($fd),y             ; Store result in screen memory
                    endm                                    ; at pos x,y
;*****************************************************
; This macro checks the character at position x,y
; to see if it matches a wall or not.
;wall_chk            gx,gyminus1,Const_DOWN,Const_UP,#1
;*****************************************************
defm                wall_chk
                    ldx                 /2                  ; I realize these next 7 lines
                    ldy                 /1                  ; are my peekaxy macro
                    sty                 $41a
                    cpx                 #12
                    bne                 @skip1
                    cpy                 #0
                    beq                 @notwall
                    cpy                 #40
                    beq                 @notwall
@skip1              lda                 map_off_l,x         ; but CBM Prg Studio cannot
                    sta                 $fd                 ; nest the macro calls
                    lda                 map_off_h,x
                    sta                 $fe
                    lda                 ($fd),y
                    cmp                 wall_dot            ; Is it a dot?
                    beq                 @notwall
                    cmp                 wall_spc            ; Is it a space?
                    beq                 @notwall
                    cmp                 wall3__nrgzr        ; Is it an engerizer pill?
                    beq                 @notwall
                    cmp                 pac_char            ; Or any of the ghosts chars
                    beq                 @notwall
                    cmp                 gh2_char            ; including Pac-clone
                    beq                 @notwall
                    cmp                 gh3_char            ;
                    beq                 @notwall
                    cmp                 gh4_char            ;
                    beq                 @notwall
                    cmp                 gh5_char            ;
                    beq                 @notwall
                    cmp                 wall_cge            ; Is it cage character '-'?
                    bne                 @bot                ; No charcters match then exit
                    lda                 ispacman            ; Don't let pac-clone
                    cmp                 #1                  ; into the ghost cage
                    beq                 @bot                ; quit if pac-clone hitting cage char
                    lda                 g$eyesmode          ;is eyemode activated?
                    cmp                 #1                  ;Yes then allow ghost into
                    beq                 @notwall            ;the ghost cage
                                                            ; So to get to this point we are
                    lda                 /5                  ; looking at cage char, not pac-man, eyesmode off
                    cmp                 #0                  ; This is saying if I am looking at the south wall
                    beq                 @bot                ; =ghost trying to enter cage, then do not allow entry into cage
                    lda                 g$exit_cage_flg     ;These lines prevent non eyes
                    cmp                 #1                  ;from entering ghost cage
                    bne                 @bot
@notwall            lda                 pd$                 ;Load the previous direction
                    cmp                 /3                  ;make sure ghost does not move in
                    beq                 @bottom             ;previous direction so no quick back and forth movement
                    lda                 /4                  ;Load opposite direction
                    ldx                 g$len               ;
                    sta                 g$,x                ;Store as new possible direction of travel
                    inc                 g$len
                    lda                 /5                  ;Load Last Param either 0,1,2,3,4
                    cmp                 #0                  ;0=check Up for wall
                    beq                 @zero
                    lda                 /5
                    cmp                 #1                  ;1=check Down for wall
                    beq                 @one
                    lda                 /5
                    cmp                 #2                  ;2=check Left for wall
                    beq                 @two
                    lda                 /5
                    cmp                 #3                  ;3=check right for wall
                    beq                 @three
@bot                jmp @bottom
@zero               lda                 gy                  ; The next 16 lines
                    cmp                 yg                  ; Determine if the new direction
                    bcs                 @bottom             ; of travel is a priority direction
                    jmp                 @cont               ; meaning a direction which will
@one                lda                 gy                  ; more quickly move the ghost
                    cmp                 yg                  ; toward the pac-clone
                    bcc                 @bottom             ;
                    jmp                 @cont               ;
@two                lda                 gx                  ;
                    cmp                 xg                  ;
                    bcc                 @bottom             ;
                    jmp                 @cont               ;
@three              lda                 gx                  ;
                    cmp                 xg                  ;
                    bcs                 @bottom             ;
                    jmp                 @cont               ;
@cont               lda                 /4                  ; Load new direction
                    ldx                 pq$len              ; Store as new priority direction
                    sta                 pq$,x               ; of travel
                    inc                 pq$len              ;
@bottom
                    nop
                    endm
;*****************************************************
; Variable Initilization Part 1
; Usage:
; move_ghosts_part1    gh1_pr_cntr, gh1_pq$, gh1_pd$, gh1_g$, gh1_gx, gh1_gy, gh1_xg, gh1_yg, gh1_pr;
;*****************************************************
defm                move_ghosts_part1
                    lda                 /1
                    sta                 pr_cntr
                    lda                 /2
                    sta                 pq$
                    lda                 /2+1
                    sta                 pq$+1
                    lda                 /3
                    sta                 pd$
                    lda                 /4
                    sta                 g$
                    lda                 /4+1
                    sta                 g$+1
                    lda                 /4+2
                    sta                 g$+2
                    lda                 /4+3
                    sta                 g$+3
                    lda                 /5
                    sta                 gx
                    lda                 /6
                    sta                 gy
                    lda                 /7
                    sta                 xg
                    lda                 /8
                    sta                 yg
                    lda                 /9
                    sta                 ghost_pr
endm
;*****************************************************
; Variable Initilization Part 2
; Usage:
; move_ghosts_part2   gh1_cdir, gh1_pq$len, gh1_g$len, gh1_eyesmode, gh1_cage_cntr, gh1_exit_cage_flg;
;*****************************************************
defm                move_ghosts_part2
                    lda                 /1
                    sta                 cdir
                    lda                 /2
                    sta                 pq$len
                    lda                 /3
                    sta                 g$len
                    lda                 /4
                    sta                 g$eyesmode
                    lda                 /5
                    sta                 g$cage_cntr
                    lda                 /6
                    sta                 g$exit_cage_flg
                    endm
;*****************************************************
; Variable Initilization Part 3
; Usage:
; move_ghosts_part3   gh1_pr_cntr, gh1_pq$, gh1_pd$, gh1_g$, gh1_gx, gh1_gy, gh1_pr,SpriteIndex
;*****************************************************
defm                move_ghosts_part3
                    lda                 /8
                    sta                 tempsprite
                    jsr                 Check_Walls
                    jsr                 MV_GHOST
                    lda                 pr_cntr
                    sta                 /1
                    lda                 pq$
                    sta                 /2
                    lda                 pq$+1
                    sta                 /2+1
                    lda                 pd$
                    sta                 /3
                    lda                 g$
                    sta                 /4
                    lda                 g$+1
                    sta                 /4+1
                    lda                 g$+2
                    sta                 /4+2
                    lda                 g$+3
                    sta                 /4+3
                    lda                 gx
                    sta                 /5
                    lda                 gy
                    sta                 /6
                    lda                 ghost_pr
                    sta                 /7
                    endm
;*****************************************************
; Variable Initilization Part 4
;*****************************************************
defm                move_ghosts_part4
                    lda                 cdir
                    sta                 /1
                    lda                 pq$len
                    sta                 /2
                    lda                 g$len
                    sta                 /3
                    endm
;*****************************************************
; Turn on Bluetime in event energizer or power pill
; is eaten.  That is determined prior to this macro call
; Usage:
; turn_on_btime       gh2_bluetime, gh2_char, gh2_eyesmode, Const_gh2_bt_DEF, gh2_bt_count, SpriteIndex,gh2_flashon
;*****************************************************
defm                turn_on_btime
                    lda                 /3                  ; Is eyesmode on?
                    cmp                 #1                  ; if so skip to bottom
                    beq                 @bottom
                    lda                 #1                  ; Turn on
                    sta                 /1                  ; blue time
                                                            ;
                                                            ;
                    lda                 blue_ghost          ; Change ghost char to
                    sta                 /2                  ; this character
                    ldx                 GAME_LEVEL          ;
                    lda                 /4,x                ; Set Default Blue time
                    sta                 /5                  ; For current game level
                   ; ldy                 #14                 ;blue
                                                            ; jsr                 Ghosts_ALL_Color
                    lda #0
                    sta                 /7                  
                    sta                 flash_on            
                    sta                 flash_counter       
                    sta                 flash_counter2       
                    sta                 flash_counter3              
                    ldy                 /6                 
                jsr                 set_blue_color       
@bottom
                    endm
;*****************************************************
; Check if blue time is on
; and count how long it is on
;Usage:
;check_btime         gh2_bluetime, gh2_bt_count, gh2_char, Const_gh2_char, Const_gh2_bt_DEF, Const_gh2_bt_DEF2, SpriteIndex,gh2_flashon
;*****************************************************
defm                check_btime
                    lda                 /1
                    cmp                 #1                  ; Is blue time on ?
                    bne                 @quit               ; No
                    ldx                 GAME_LEVEL
                    dec                 /2                  ; Decrease blue time Counter
                    lda                 /2
                    cmp                 /6,x                ; Fewer moves of blue time left
                    bne                 @ck_zero            ; if so then change ghost
                    lda                 Flashing_gh         ; character to mimic flashing ghost
                    sta                 /3                  
                    lda                 #1                  ; Turn on Flash
                    sta                 /8           

                    jmp                 @quit
@ck_zero            cmp                 #0                  ; no more blue time left?
                    bne                 @quit               ; None left then quit
                    ldx                 GAME_LEVEL
                    lda                 /5,x                ; reset the blue time
                    sta                 /2                  ; counter,
                    lda                 #0
                    sta                 /1                  ; turn off blue time
                    lda                 /4                  ; and change ghost character
                    sta                 /3                  ; back to normal
                    lda                 #0                  ; Turn off flash
                    sta                 /8            
                                                            ; jsr                 Spr_ghostcolor
                    ;lda #0
                    ;sta                 flash_counter       
                    ;sta                 FLASH_ON            

                    ldy /7
                    jsr set_gh_color2     
@quit               nop
                    endm
;*****************************************************
;  Compare Ghost X and Y to Pac X and Y
;  If they are equal then check blue time
;  If blue time is on then Pac-Clone eats the ghost
;  (eating ghost turns them into eyes returning to cage
;  with high priority)
;  otherwise pac-clone should die.
;*****************************************************
;*************************************************************
;* Check of Pac-Clone is on top of a particular ghost
;* If this happens with blue time on the the ghost
;* should turn into eyesmode and return to the cage with high
;* priority
; Usage
;Collision          spritex, spritey, gh2_bluetime, gh2_eyesmode, gh2_xg, gh2_yg, gh2_pr, gh2_pr_cntr, spriteindex
;*************************************************************
defm                Collision
                    lda                 /1
                    cmp                 $d000              ; Does Ghost X = Pac X  ?
                    bne                 @botabc            ; NO
                    lda                 /2
                    cmp                 $d001              ; Does Ghost Y = Pac Y ?
                    bne                 @botabc            ; No
                    lda                 /3                  ; Blue time on?
                    cmp                 #1
                    beq                 @eat_ghost          ; Yes
                    lda                 /4                  ; Eyes should not kill pac-clone
@botabc             jmp                 @bottom

@eat_ghost
                    lda                 /9                  
                    inc                 GHOSTS_EATEN        ; GHOST GOBBLED UP
                    lda                 GHOSTS_EATEN
                    cmp                 #1
                    beq                 @BONUS1
                    cmp                 #2
                    beq                 @BONUS2
                    cmp                 #3
                    beq                 @BONUS3
                    cmp                 #4
                    beq                 @BONUS4
                    jmp                 @bottom
@BONUS1             lda                 #1                  ; 100 points
                    jmp                 @Score
@BONUS2             lda                 #2                  ; 200 points
                    jmp                 @Score
@BONUS3             lda                 #4                  ; 400 points
                    jmp                 @Score
@BONUS4             lda                 #8                  ; 800 points
                    jmp                 @Score
@Score              ldx                 #3                  ;
                    jsr                 IncreaseScore
                    lda                 #0                  ; Turn off bluetime
                    sta                 /3
                    lda                 #1                  ; Toggle Eyesmode
                    sta                 /4                  ;
                    sta                 g$eyesmode          
                   
                    ldy                 /9
                    ldx /9
                    jsr                 set_ghost_col      


                    ldy                 /9 
                    lda                 #0                  
                    sta                 gh2_flashon,y       

                    jsr                 set_eye_color       
                    lda                 Cage_Xpos           ; Load New Dest X and
                    sta                 /5
                    lda                 Cage_Ypos           ; Dest Y values for ghost cage
                    sta                 /6
                    lda                 HIGH_PR             ;Change priority of eyes to always move towards priority
                    LDX                 GAME_LEVEL
                    sta                 /7
                    sta                 ghost_pr
                    lda                 #0
                    sta                 /8                  ;Reset the Priority Counter to zero
                    

@bottom             nop
                    endm


Ghosts_All_Color    
                    sty                 $d028               
                    sty                 $d029               
                    sty                 $d02a               
                    sty                 $d02b               
                    rts
set_eye_color       
                    lda                 #$28                ; Ghost
                    sta                 $fa                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fb                 ;
                    lda                 spreyecolor,y      
                    sta                 ($fa),y             
                    rts

set_blue_color      lda                 #$28                ; Ghost
                    sta                 $fa                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fb                 ;
                    lda                 #14
                    sta                 ($fa),y             

                    rts

set_flash_color     
                    lda                 #$28                ; Ghost
                    sta                 $fa                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fb                 ;
                    
                   
                    lda                 flash_counter3  
                   
                    cmp                 #1                   
                    beq                 _color1             
                    lda                 #0
                    sta                 flash_counter3      
                    lda                 #1                
                    jmp                 _skipfh
_color1             
                    lda                 #14                 
 
_skipfh             sta                 ($fa),y             

                    rts
flash_counter3      byte                00
set_gh_color2
                    lda                 #$d0                ;
                    sta                 $fb                                  
                    lda                 sprite_color_adr2,y            
                    sta                 $fa                 

                    lda                 sprcolor,y         
                    ldy #0
                    sta                 ($fa),y             
                    rts
Spr_ghostcolor      
                    lda                 #$28                ; Ghost
                    sta                 $fa                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fb                 ;

                    ldy                 #4
color_lp            dey
                    lda                 sprcolor,y                  
                    sta                 ($fa),y             ;
                    cpy #0
                    bne                 color_lp
                    rts
;*****************************************************
;* Check to see if ghost is entering /exiting cage
;* If exiting then turn off eyes mode and change ghost char
;* And reset ghost priority
; usage:
;check_cage          gh2_char, gh2_eyesmode, gh2_exit_cage_flg, Const_gh2_DEF_PR, gh2_pr,gh2_bluetime, Const_gh2_char,SpriteIndex
;*****************************************************
defm                check_cage
                    lda                 /2                  ; Eyes mode enabled?
                    cmp                 #0
                    beq                 @exit               ; If not exit
                    lda                 /6                  ; Bluetime enabled?
                    cmp                 #1                  ; If so exit
                    beq                 @exit
                    lda                 gy
                    cmp                 Cage_Ypos           ; Is ghost in right vert position with cage
                    bne                 @exit               ; No? then exit
                    lda                 gx
                    cmp                 Cage_Xpos           ; Is ghost in right Horiz position with cage
                    bne                 @exit               ; No? then exit
                    lda                 #$0                 ; entering or exiting cage then reset flag
                    sta                 /3                  ; Reset the cage exit flag to 0
                    lda                 #0                  ; Ghost back in cage turn off eyes mode
                    sta                 /2
                    lda                 /7                  ; Reset ghost character to non ghost char
                    sta                 /1                  

                    ldy                 /8
                  
                    ldx                 /8                  
                    lda                 #0                  
                    sta                 g$eyesmode                              
                    jsr                 set_ghost_col      
;@abcde          jmp @abcde
                    ldy                 /8
                    jsr set_gh_color2
                                                            ;****fix - ghosts leaving cage had bad priority
                                                            ; Reset ghost priority when entering cage
                    ldx                 GAME_LEVEL
                    lda                 /4,x
                    sta                 /5
@exit               nop
                    endm
;*****************************************************
; Once ghost is in cage, ensure it bounces back
; and forth at least two times before exiting
; thats what the g$cage_cntr var is for
; Usage:
; CageDrama           gh2_exit_cage_flg, gh2_bt_count, gh2_cage_cntr ,gh2_eyesmode, gh2_pr, gh2_yg, Const_gh2_DEF_PR, gh2_bt_DEF
;*****************************************************
defm                CageDrama
                    jsr                 cage_sides          ; Make sure ghosts move left and right within cage
                    lda                 g$cage_cntr
                    cmp                 #3                  ; has ghost hit left side of cage 2 times?
                    bne                 @skp_bot
                                                            ; Allow ghost to exit the cage
                    lda                 #1                  ; set the exit cage flag
                    sta                 /1                  ; allow ghost to exit the cage
                    ldx                 GAME_LEVEL
                    lda                 /8,x
                    sta                 /2
                    lda                 #0                  ; Turn off Eyes mode
                    sta                 /4
                    lda                 #1
                    sta                 /6                  ; change the yg value so caged ghost will escape upwards
                    sta                 yg
                    ldx                 GAME_LEVEL
                    lda                 /7,x                ; reset to default priority ghost exiting cage
                    sta                 /5
                    sta                 ghost_pr
                  
                    lda                 #0
                    sta                 g$cage_cntr         ; reset cage counter to zero
@skp_bot            sta                 /3                  ; save acc back to cage counter
                    nop
                    endm
;*****************************************************
; This code tells the ghosts where
; Pac-clone is on the map but we dont want them
; To know where he is if bluetime is on, in fact
; this code tells the ghosts to run to the opposite
; side of the map relative to pac-clone if blue time is on
;*****************************************************
defm                updatexy
                ;jmp @bot
                    lda                 /1                  ; Is bluetime on?
                    cmp                 #1                  ;
                    beq                 @thwart_gh          ; Yes then continue
                    lda                 /2                  ; Check if eyes mode is on
                    cmp                 #1                  ; if Yes then dont change xy destination points
                    beq                 @bot
                    lda                 gh1_gx              ; Change Dest X and
                    sta                 /3
                    lda                 gh1_gy              ; Dest Y values of ghost
                    sta                 /4                  ; to follow Pac-clone
                    jmp                 @bot
@thwart_gh          lda gh1_gx                              ; Blue time is on, so ghosts should be afraid
                    cmp                 Cage_Xpos           ; of Pac-Clone. Set the Dest X and Dest Y
                    bcs                 @skip               ; values of ghost to opposite side of map
                    lda                 #39                 ; relative to Pac-Clones current position
                    sta                 /3
                    jmp                 @ck_y
@skip               lda #1                                  ; For example pac-clone is somewhere on right side of map
                    sta                 /3                  ; make ghosts move to left side setting Dest X
@ck_y               lda gh1_gy
                    cmp                 Cage_Ypos           ;Check if pac-clone is on top side of map
                    bcs                 @skip2
                    lda                 #24                 ;if so set Dest Y to bottom part of map
                    sta                 /4
                    jmp                 @bot
@skip2              lda #1                                  ;if not set Dest Y to top part of map
                    sta                 /4
@bot
 
                    endm
#endRegion
;============================================================
;                     Main Program
;============================================================
*=$6000
                    lda                 #4
                    sta                 53280
                    lda                 #$93                ; shift clear dec 147
                    jsr                 $FFD2               ; clear screen
                    jsr                 Init_Random
                    jsr                 drawmap
                    jsr                 Set_Interrupt
                    jsr                 Prep_Level_One      ; Reset the Game Level and set score to zero
                         
;                    lda                 #0                  
;                     sta $d028
;xxx                     jmp xxx

  
main_prg_lp
                    lda                 DEATH_FLAG
                                                            ;cmp #0
                    beq                 _alive               ; Yes Pacs alive
                    jsr                 HE_DEAD             ; Nooo say it aint so...
_alive             

sk_385              ;  lda                 pac_char            ; These lines store the
                    ;pokeaxy             gh1_gx,gh1_gy       ; pac-ghost and ghosts text
;                    lda                 gh2_char            ; characters in their correct
;                    pokeaxy             gh2_gx,gh2_gy       ; x,y positions on the screen
;                    lda                 gh3_char            ;
;                    pokeaxy             gh3_gx,gh3_gy       ;
;                    lda                 gh4_char            ;
;                    pokeaxy             gh4_gx,gh4_gy       ;
;                    lda                 gh5_char            ;
;                    pokeaxy             gh5_gx,gh5_gy       ;


;**** MOVE GHOSTS *****
              ;      jsr get_key    
                    Jsr                 Move_ALL_Sprites    
;_loop               lda                 56320              
                    
;                    cmp #$7E
;                    bne  _loop
              ;  jsr get_key
                    ;jsr                 scan_spot           
                    jmp                 main_prg_lp
get_key
getch
                                        ;DC00 is joystick port 2
                    jsr                 $ffe4               ; Input a key from the keyboard
                   
                                                            ; beq                 getch
ck_pressed          cmp                 Const_DOWN          ; down - z pressed
                    beq                 Move_that_dir
                    cmp                 Const_UP            ; up - w pressed
                    beq                 Move_that_dir
                    cmp                 Const_LEFT          ; left - a pressed
                    beq                 Move_that_dir
                    cmp                 Const_RIGHT         ; right - s pressed
                    beq                 Move_that_dir
                    cmp                 #$54                ; T - Pressed
                    bne                 NO_Key_Pressed      ;
                                                            ;  jsr                Energize            ; Turn on blue time - cheat!
                        jsr _levelup
                   rts
NO_Key_Pressed
                   ; lda                 gh1_cdir            ; Makes pac-clone move in the last current dir when no input given
                   ; pla                                        ;jmp ck_pressed                          ;
Move_that_Dir       cmp #0
                    beq _rts 
                    sta                 userdirection       

_rts                rts
;*****************************************************
; Check Left side for non pac ghosts only
;*****************************************************
ck_leftside         lda                 cdir
                    cmp                 Const_LEFT
                    bne                 the_end
                    lda                 gy
                    cmp                 #12
                    bne                 the_end
                    lda                 gx
                    cmp                 #$FF                ; Check for (-1)
                    beq                 wp
                    rts
wp                  lda                 #39
                    sta                 gx
                    
                    ldy                 tempsprite          ;
                    lda                 #$d0                  ; Warp Sprite
                    sta                 $fb                 ;
                    lda                 sprxmap,y           ;
                    sta                 $fa                 ;
                    

                    lda                 $d010
                    eor                 sprmap2,y
                    sta                 $d010

                    lda                 #88 ;#11*8  
                    ldy #0    
                
                    sta                 ($fa),y             ;

;abcdefg             jmp abcdefg
the_end             rts
;*****************************************************
; Check right side for non pac ghosts only
;*****************************************************
ck_rightside
                    lda                 cdir
                    cmp                 Const_RIGHT
                    bne                 @end2
                    lda                 gy
                    cmp                 #12
                    bne                 @end2
                    lda                 gx
                    cmp                 #40
                    beq                 @wp3
                    rts
@wp3                lda                 #$00
                    sta                 gx                  
                    lda #$d0
                    sta                 $fb                 ; Warp Sprite
                    ldy                 tempsprite          ;
                    lda                 sprxmap,y           ;
                    sta                 $fa                 ;
                    
                                                          
                    lda                 $d010
                    eor                 sprmap2,y
                    sta                 $d010

                    lda                 #08*2               ;
                    ldy #0
                    sta                 ($fa),y             ;
@end2               rts

scan_spot
pacs_alive
                    lda                 gh1_gx              
                    sta                 $402                
                    lda                 gh1_gy              
                    sta $403

                    peekaxy             gh1_gx,gh1_gy       ; Did Pac-Clone just eat
                    sta                 $401                
                    cmp                 wall3__nrgzr        ; the energizer?
                    beq                 Energize            ; NO, then skip
                    cmp                 wall_dot
                    bne                 _done_scan
                    jsr                 EAT_DOTS            ; Eat dots
                    jmp                 _done_scan
Energize
                
                    lda                 #1                  ; 100 points
                    ldx                 #3                  ; 3rd decimal pos
                    jsr                 IncreaseScore       ; Increase score
                    lda                 #0                  ; Reset the ghosts Eaten Counter
                    sta                 GHOSTS_EATEN        ; Used for score purposes
                    jsr                 BLUE_TIME
_done_scan          rts

#region MAIN PROGRAM SUBS

sprite_counter      byte 00

Move_ALL_Sprites
                    
_top                inc                 sprite_counter

                    lda                 gh1_sp_pos         
                    LDY GAME_LEVEL  
                    cmp                 gh1_sp_boost_goal,y 
                    bne                 _check2
                    jsr                 Move_Sprite1        

                    lda                 #0                  
                    sta                 gh1_sp_pos                    

_check2       
                    lda                 gh2_eyesmode
                    cmp #1
                    beq                 _isgh              
                    lda                 gh2_sp_pos
                    LDY GAME_LEVEL  
                    cmp                 gh2_sp_boost_goal,y
                    bcc                 _check3 
                         
                    jsr                 Move_Sprite2        
                    jmp                 _reset1
            
_isgh               jsr                 Move_Sprite2        
                    jsr                 Move_Sprite2        

_reset1             lda                 #0                  
                    sta                 gh2_sp_pos
_check3             lda                 gh3_eyesmode          
                    cmp #1
                    beq                 _isgh2

                    lda                 gh3_sp_pos         
                    LDY GAME_LEVEL    
                    cmp                 gh3_sp_boost_goal,y
                    bcc                 _check4
                    jsr                 Move_Sprite3
                    jmp _reset2
_isgh2              jsr                 Move_Sprite3        
                    jsr                 Move_Sprite3

_reset2             lda                 #0                  
                    sta                 gh3_sp_pos
_check4             lda                 gh4_eyesmode          
                    cmp #1
                    beq                 _isgh3


                    lda                 gh4_sp_pos 
                    LDY GAME_LEVEL    
                    cmp                 gh4_sp_boost_goal,y
                    bcc                 _check5
                    jsr                 Move_Sprite4        
                    jmp _reset3
_isgh3              jsr                 Move_Sprite4        
                    jsr                 Move_Sprite4

_reset3              lda                 #0                  
                    sta                 gh4_sp_pos
_check5             lda                 gh5_eyesmode
                    cmp #1
                    beq                 _isgh4

                    lda                 gh5_sp_pos           
                    cmp                 gh5_sp_boost_goal   
                    bcc                 _Normal_Flow
                    
                    jsr                 Move_Sprite5        
                    jmp _reset4
_isgh4              jsr                 Move_Sprite5        
                    jsr                 Move_Sprite5        
_reset4             lda                 #0                  
                    sta                 gh5_sp_pos

_Normal_Flow                 
                    
                    jsr                 Move_Sprite1        
                    jsr                 dly4                
                    jsr                 Move_Sprite2        
                    jsr                 dly4                
                    jsr                 Move_Sprite3        
                    jsr                 dly4                
                    jsr                 Move_Sprite4        
                    jsr                 dly4                
                    jsr                 Move_Sprite5        
                    jsr                 dly4                

                    jsr get_key
                    lda                 sprite_counter      
                    cmp                 #8                  
                    bne                 _back_to_top         
                    lda                 #0                  
                    sta                 sprite_counter      
                    rts
_back_to_top        jmp _top
Move_Sprite1
                    Move_Sprite         gh1_cdir,gh1_pd$,gh1_spctr,$d000,$d001,#%00000001,gh1_sp_pos                    
                    rts
Move_Sprite2
                    Move_Sprite         gh2_cdir,gh2_pd$,gh2_spctr,$d002,$d003,#%00000010,gh2_sp_pos
                    rts
Move_Sprite3
                    Move_Sprite         gh3_cdir,gh3_pd$,gh3_spctr,$d004,$d005,#%00000100,gh3_sp_pos
                    rts
Move_Sprite4
                    Move_Sprite         gh4_cdir,gh4_pd$,gh4_spctr,$d006,$d007,#%00001000,gh4_sp_pos
                    rts
Move_Sprite5
                    Move_Sprite         gh5_cdir,gh5_pd$,gh5_spctr,$d008,$d009,#%00010000,gh5_sp_pos
                    rts

;*************************************************************
; Turn on blue time for all 4 ghosts
; Unless eyes mode is activated
;*************************************************************
BLUE_TIME
                    turn_on_btime       gh2_bluetime,gh2_char,gh2_eyesmode,Const_gh2_bt_DEF,gh2_bt_count,#0,gh2_flashon; Turn on blue time
                    turn_on_btime       gh3_bluetime,gh3_char,gh3_eyesmode,Const_gh3_bt_DEF,gh3_bt_count,#1,gh3_flashon; want to turn it on
                    turn_on_btime       gh4_bluetime,gh4_char,gh4_eyesmode,Const_gh4_bt_DEF,gh4_bt_count,#2,gh4_flashon; unless eyemode
                    turn_on_btime       gh5_bluetime,gh5_char,gh5_eyesmode,Const_gh5_bt_DEF,gh5_bt_count,#3,gh5_flashon; is activated
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
                   Collision           $d002,$d003,gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg,gh2_pr,gh2_pr_cntr,#0
                   Collision           $d004,$d005,gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg,gh3_pr,gh3_pr_cntr,#1
                   Collision           $d006,$d007,gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg,gh4_pr,gh4_pr_cntr,#2
                   Collision           $d008,$d009,gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg,gh5_pr,gh5_pr_cntr,#3
                    rts
;gh1_Const_sp_Max    byte                24
;gh1_sp_pos          byte                00
;gh1_sp_boost_goal   byte                10
;gh1_fast_slow       byte                00; 1=move faster - 0=move slower

;Usage:
;                   Move_Sprite         gh1_cdir, gh1_pd$, gh1_spctr, $d000, $d001, #%0000001, gh1_sp_pos 
defm                Move_Sprite
                    lda                 /6                  
                    cmp                 #1                  
                    bne                 @_skipfew

                    lda                 /1
                    cmp                 /2
                    bne                 @_gh1

                    jmp @_skipfew
                    
@_gh1               
@glennx
                    lda                 #1
                    sta gobble_on
@_gh2               jmp @Gh1

@_exit              jmp                 @exit_sprite 
@_skipfew           inc                 /3                  
                    inc                 /7                  
                    
@mv_Spritesub       lda                 /1
                    cmp                 Const_LEFT
                    beq                 @sp_left
                    cmp                 Const_Right
                    beq                 @sp_right
                    cmp                 Const_UP
                    beq                 @sp_up
                    cmp                 Const_DOWN
                    beq                 @sp_down
                    jmp                 @_lt                
@exit               jmp @exit_sprite
@sp_up
                    dec                 /5                  
                    jmp                 @_lt
@sp_down
                    inc                 /5                  
                    jmp                 @_lt
@sp_right
                    inc                 /4                  
                    lda                 /4
                    cmp                 #00
                    bne                 @_rt
                    lda                 $d010
                    eor                 /6
                    sta                 $d010
@_rt                jmp @_lt
@sp_left            dec                 /4
                    lda                 /4
                    cmp                 #$FF
                    bne                 @_lt
                    lda                 $d010
                    eor                 /6
                    sta                 $d010
@_lt
                    lda                 /3
                    cmp                 #8
                    bne                 @exit_sprite        
                   
                    lda                 #0
                    sta                 /3                  
                    lda                 /6                  
                    cmp                 #%0000001             ;Pac-Clone
                    beq                 @Gh1
                    cmp                 #%0000010             ;Ghost 1
                    beq                 @Gh2
                    cmp                 #%0000100             ;Ghost 2
                    beq                 @Gh3
                    cmp                 #%0001000             ;Ghost 3
                    beq                 @Gh4
                    cmp                 #%0010000             ;Ghost 4
                    beq                 @Gh5
 
@Gh1
                    jsr                 Collisions
                    jsr                 mv_Ghost1           
                    jmp                 @exit_sprite        
@Gh2                jsr                 Collisions
                    jsr                 mv_Ghost2 
                    jmp                 @exit_sprite        
@Gh3                jsr                 Collisions
                    jsr                 mv_Ghost3   
                    jmp                 @exit_sprite        
@Gh4                jsr                 Collisions
                    jsr                 mv_Ghost4           
                    jmp                 @exit_sprite        
@Gh5                
                    jsr                 Collisions
                    jsr                 mv_Ghost5           
@exit_sprite        jsr                 Collisions
                    endm

mv_Ghost1
                    lda                 #1
                    sta                 ispacman 
                    jsr                 scan_spot           
                    jsr                 space

                    move_ghosts_part1   gh1_pr_cntr, gh1_pq$, #0, gh1_g$, gh1_gx, gh1_gy, gh1_xg, gh1_yg, gh1_pr;
                    move_ghosts_part2   gh1_cdir, gh1_pq$len, gh1_g$len, gh1_eyesmode, gh1_cage_cntr, gh1_exit_cage_flg;
                    move_ghosts_part3   gh1_pr_cntr, gh1_pq$, gh1_pd$, gh1_g$, gh1_gx, gh1_gy, gh1_pr,#00
                    move_ghosts_part4   gh1_cdir,gh1_pq$len,gh1_g$len;
                  
                                                            ;***********************************************
                                                            ;** Make ghosts follow Pac-CLone
                    updatexy            gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg
                    updatexy            gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg
                    updatexy            gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg
                    updatexy            gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg
                   
                    lda                 #0
                    sta                 ispacman
                    lda                 wall_cge
                    sta                 1523-40
                    lda                 #160
                    sta                 1524-40
                    rts
mv_Ghost2
                    move_ghosts_part1   gh2_pr_cntr, gh2_pq$, gh2_pd$, gh2_g$, gh2_gx, gh2_gy, gh2_xg, gh2_yg, gh2_pr
                    move_ghosts_part2   gh2_cdir,gh2_pq$len,gh2_g$len,gh2_eyesmode,gh2_cage_cntr,gh2_exit_cage_flg
                    move_ghosts_part3   gh2_pr_cntr, gh2_pq$, gh2_pd$, gh2_g$, gh2_gx, gh2_gy, gh2_pr,#01
                    check_cage          gh2_char,gh2_eyesmode,gh2_exit_cage_flg,Const_gh2_DEF_PR,gh2_pr,gh2_bluetime,Const_gh2_char,#0
                    check_btime         gh2_bluetime,gh2_bt_count,gh2_char,Const_gh2_char,Const_gh2_bt_DEF,Const_gh2_bt_DEF2,#0,gh2_flashon
                    lda                 gh2_bluetime        
                   sta $400
                    move_ghosts_part4   gh2_cdir,gh2_pq$len,gh2_g$len
                    CageDrama           gh2_exit_cage_flg, gh2_bt_count, gh2_cage_cntr ,gh2_eyesmode, gh2_pr, gh2_yg, Const_gh2_DEF_PR, Const_gh3_bt_DEF
                   
                    rts
mv_Ghost3
                    move_ghosts_part1   gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_xg,gh3_yg,gh3_pr
                    move_ghosts_part2   gh3_cdir,gh3_pq$len,gh3_g$len,gh3_eyesmode,gh3_cage_cntr,gh3_exit_cage_flg
                    move_ghosts_part3   gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_pr,#02
                    check_cage          gh3_char,gh3_eyesmode,gh3_exit_cage_flg,Const_gh3_DEF_PR,gh3_pr,gh3_bluetime,Const_gh3_char,#1
                    check_btime         gh3_bluetime,gh3_bt_count,gh3_char,Const_gh3_char,Const_gh3_bt_DEF,Const_gh3_bt_DEF2,#1,gh3_flashon
                    move_ghosts_part4   gh3_cdir,gh3_pq$len,gh3_g$len
                    CageDrama           gh3_exit_cage_flg,gh3_bt_count,gh3_cage_cntr,gh3_eyesmode,gh3_pr,gh3_yg,Const_gh3_DEF_PR,Const_gh3_bt_DEF
                  
                    rts
mv_Ghost4
                    move_ghosts_part1   gh4_pr_cntr, gh4_pq$, gh4_pd$, gh4_g$, gh4_gx, gh4_gy, gh4_xg, gh4_yg,gh4_pr
                    move_ghosts_part2   gh4_cdir,gh4_pq$len,gh4_g$len,gh4_eyesmode,gh4_cage_cntr,gh4_exit_cage_flg
                    move_ghosts_part3   gh4_pr_cntr, gh4_pq$, gh4_pd$, gh4_g$, gh4_gx, gh4_gy, gh4_pr,#03
                    check_cage          gh4_char,gh4_eyesmode,gh4_exit_cage_flg,Const_gh4_DEF_PR,gh4_pr,gh4_bluetime,Const_gh4_char,#2
                    check_btime         gh4_bluetime,gh4_bt_count,gh4_char,Const_gh4_char,Const_gh4_bt_DEF,Const_gh4_bt_DEF2,#2,gh4_flashon
                    move_ghosts_part4   gh4_cdir,gh4_pq$len,gh4_g$len
                    CageDrama           gh4_exit_cage_flg,gh4_bt_count,gh4_cage_cntr,gh4_eyesmode,gh4_pr,gh4_yg,Const_gh4_DEF_PR,Const_gh4_bt_DEF
                  
                    rts
mv_Ghost5
                    move_ghosts_part1   gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_xg,gh5_yg,gh5_pr
                    move_ghosts_part2   gh5_cdir,gh5_pq$len,gh5_g$len,gh5_eyesmode,gh5_cage_cntr,gh5_exit_cage_flg
                    move_ghosts_part3   gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_pr,#04
                    check_cage          gh5_char,gh5_eyesmode,gh5_exit_cage_flg,Const_gh5_DEF_PR,gh5_pr,gh5_bluetime,Const_gh5_char,#3
                    check_btime         gh5_bluetime,gh5_bt_count,gh5_char,Const_gh5_char,Const_gh5_bt_DEF,Const_gh5_bt_DEF2,#3,gh5_flashon
                    move_ghosts_part4   gh5_cdir,gh5_pq$len,gh5_g$len
                    CageDrama           gh5_exit_cage_flg,gh5_bt_count,gh5_cage_cntr,gh5_eyesmode,gh5_pr,gh5_yg,Const_gh5_DEF_PR,Const_gh5_bt_DEF
                    
                    rts
;============================================================
;                          Check for Walls
; This section of code checks up/down/left/right for walls
; in order to determine the direction that can be travelled in.
; it sets up a string g$ that looks something like this:
; g$="udl" - Means ghost can move up/down/left
; it aslo sets up priority direction that ghost can move in.
; that string looks something like this:
; pq$="dl" (subset of g$) - means down/left are pr directions which
; will move the ghost closer to the target
;============================================================
Check_Walls
                    lda                 #0                  ; Reset
                    sta                 g$                  ; all
                    sta                 g$+1                ; g$ values
                    sta                 g$+2
                    sta                 g$+3
                    sta                 pq$                 ; Reset all
                    sta                 pq$+1               ; pq$ values
                    sta                 g$len
                    sta                 pq$len
                    ldy                 gy                  ; Set up
                    dey
                    sty                 gyminus1            ; gy - 1
                    ldy                 gy
                    iny
                    sty                 gyplus1             ; gy + 1
                    wall_chk            gx,gyminus1,Const_DOWN,Const_UP,#1; Check wall directly above ghost
                    wall_chk            gx,gyplus1,Const_UP,Const_DOWN,#0; Check wall directly below ghost
                    ldy                 gx                  ; Set up
                    dey
                    sty                 gxminus1            ; gx - 1
                    ldy                 gx
                    iny
                    sty                 gxplus1             ; gx + 1
                    wall_chk            gxminus1,gy,Const_RIGHT,Const_LEFT,#2; Check wall to left of ghost
                    wall_chk            gxplus1,gy,Const_LEFT,Const_RIGHT,#3; Check wall to riht of ghost
                    rts
;*****************************************************
; scan the possible directions pac-clone can move
; if there is a match with the accumulater than
; return 'beq' otherwise return 'bne'
;*****************************************************
Can_Move_This_Dir?  ldx                 #0                  ; Check if pac-clone hits a wall_dot
loop                cmp                 g$,x                ; needed for sprite mouth to stay open on hit
                    beq                 ext_sub
                    inx
                    cpx                 g$len
                    bne                 loop
                    ldx                 #1                  ;These two lines are here because
                    cpx                 #2                  ;need to set the BNE flag to return 'bne'
ext_sub             rts
;*****************************************************
;This sub is heart of the entire program
;It is responsible for actually moving all objects
;on the map
;*****************************************************
MV_GHOST
                       ;lda                 userdirection
                       ;sta $403
                    lda                 ispacman
                    cmp                 #1                  ; Have to check if this is Pac-clone
                    bne                 notpacman           ; if so then do not pick a dir of travel
;                    jsr                 scan_spot           
;                    jsr                 space
                    lda                 userdirection       ; Check can pclone move in user direction
                    ;jmp match2
                    jsr                 Can_Move_This_Dir?  ; Can the we travel in the selected dir?
                    beq                 match2              ; Match means 'yes'
                    sta                 $429                ; store direction in which wall was hit
                                                            ; Need this information for furture when
                                                            ; sprites are enabled you want pclone mouth
                                                            ; to stay open when wall hit
                    lda                 cdir                ; Check can pclone move in current dir of travel
                    sta                 $42a
                    jsr                 Can_Move_This_Dir?  ;

                    beq                 match2              ; Match means 'yes'
                                                            ; No match mean return
                    rts
match2              ldx                 #0
                    stx                 $429
                    sta                 g$                  ; Store the requested
                                                            ;sta                 gh1_g$              ; direction of travel
                                                            ;sta                 gh1_cdir            ;
                    sta                 cdir                ;
                    ldy                 #0                  ;
                    sty                 g$len               ;
                    tax
                    tya
                    pha
                    txa                                     ; push direction
                    jmp                 ck_1                ;
notpacman
                    peekaxy             gx,gyplus1          ; This code here will force
                    cmp                 wall_cge            ; ghost eyes to move down
                    bne                 not_cage            ; if directly over
                    lda                 g$eyesmode          ; the entrance to ghost cage
                    cmp                 #1                  ;
                    bne                 not_cage            ; make sure eyes mode is on
                    lda                 #0
                    pha
                    lda                 Const_DOWN          ; Load Down Value
                    sta                 cdir                ;fixes bug where sprite ghost does not move into cage


                                                            ;jsr eyes_toggle

                    jmp                 ck_2a               ;
;***
; Pick a direction of travel either a priority dir
; Or a random dir based on possible choices of dir
;*****************************************************
not_cage            inc                 pr_cntr             ; Increment prioriyt counter
                    lda                 pr_cntr             ; Do we have a match with the
                    cmp                 ghost_pr            ; Current Priority?
                    bne                 random              ; No? then move randomly
                                                            ; Yes? Then move in priority dir
                    lda                 #0                  ; Reset the Priority counter
                    sta                 pr_cntr
                    lda                 pq$                 ; Load priority direction
                    cmp                 #0                  ; Make sure there is one
                    beq                 random
                    lda                 pq$                 ; Make the ghost
                    sta                 g$                  ; Move randomly in the direction
                    lda                 pq$+1               ; of priority
                    sta                 g$+1
                    lda                 pq$len
                    sta                 g$len
random                                                      ; Randomly move ghost
                    jsr                 RAND                ; in one of the possible
                                                            ; directions of travel
                    pha
                    tax                                     ; Push Direction
                    lda                 g$,x                ;
                    sta                 cdir                ;
;*****************************************************
ck_1                cmp                 Const_UP            ; UP
                    bne                 ck_2                
                    dec                 gy                  ; Decrease Y value
                    ldx #$00
                    jsr Pick_Ghost_Spr
                   
                    lda                 ispacman
                    cmp                 #0
                    beq                 sk_ck               
                    lda                 #0                  
                    sta                 gobble_on

sdfdflkj

                    ldx                 spr_up_low
                    stx                 int_spr_low
                    stx                 int_sprite
                    inx
                    inx
                    inx
                    stx                 int_spr_high
                    jmp                 skip
ck_2                cmp                 Const_DOWN          ; DOWN
                    bne                 ck_3
ck_2a              
                    inc                 gy                  ; Increase Y value
                    ldx #$1
                    jsr Pick_Ghost_Spr

                    lda                 ispacman
                    cmp                 #0
                    beq                 sk_ck               
                    lda                 #0                  
                    sta                 gobble_on

                    ldx                 spr_down_low
                    stx                 int_spr_low
                    stx                 int_sprite
                    inx
                    inx
                    inx
                    stx                 int_spr_high
                    jmp                 skip
ck_3                cmp                 Const_LEFT          ; LEFT
                    bne                 ck_4                
                
                    dec                 gx                  ; LEFT, Decrease X
                    ldx #$2
                    jsr Pick_Ghost_Spr

                    lda                 ispacman
                    cmp                 #0
                    beq                 sk_ck               
                    lda                 #0                  
                    sta                 gobble_on


                    ldx                 spr_left_low
                    stx                 int_spr_low
                    stx                 int_sprite
                    inx
                    inx
                    inx
                    stx                 int_spr_high
sk_ck               jsr                 ck_leftside
                    jmp                 skip
ck_4                cmp                 Const_RIGHT         ;
                    bne                 skip                

                    inc                 gx                  ; RIGHT, Increase X
                    ldx #$3
                    jsr Pick_Ghost_Spr

                    lda                 ispacman
                    cmp                 #0
                    beq                 sk_ck2              
                    lda                 #0                  
                    sta                 gobble_on


                    ldx                 spr_right_low
                    stx                 int_spr_low
                    stx                 int_sprite
                    inx
                    inx
                    inx
                    stx                 int_spr_high
sk_ck2        
                    jsr                 ck_rightside
skip

                    pla                                     ; Pull Direction down
                    tax
                    lda                 g$,x                ;
                    sta                 pd$
                    lda                 ispacman
                    cmp                 #0
                    beq                 done
                                                            ; lda #0
                                                            ; sta gh1_pd$
                    jsr                 Check_Walls         ; get new g$len, g$
                    lda                 g$len
                    sta                 $440
                    lda                 g$
                    sta                 $441
                    lda                 g$+1
                    sta                 $442
                    lda                 g$+2
                    sta                 $443
                    lda                 userdirection
                    sta                 $42a
                    jsr                 Can_Move_This_Dir?  ;
                    beq                 okay                ; Match means 'yes'
                    sta                 $43a
                    rts
okay            
done                rts

Pick_Ghost_spr      
                    ldy                 tempsprite          ; Sprite for pacclone
                    cpy #0
                    beq                done_2a
                    lda                 #$07                ;
                    sta                 $fb                                  
                    lda                 sprite_addr2,y
                    sta                 $fa                 

                    lda                 g$eyesmode          
                    cmp #1
                    bne                 _over               
                    
                    ;sty $400
;abcdefg             jmp abcdefg

                                
                    lda                  sprite_dir2,x        
                    jmp _over2
_over               lda                 sprite_dir,x
                    
_over2              ldy                 #0                  
                    sta                 ($fa),y             
done_2a             rts


set_ghost_col      
                    lda                 #$07                ;
                    sta                 $fb                                  
                    lda                 sprite_addr2+1,y
                    sta                 $fa                 

                    lda                 g$eyesmode          
                    cmp #1
                    bne                 _over1
                    
                    lda                  sprite_dir2,x        
                    jmp _over3
_over1               lda                 sprite_dir,x
                    
_over3              ldy                 #0                  
                    sta                 ($fa),y             
done_2b             rts

;============================================================
;                          Draw Map
;============================================================
drawmap
                    lda                 SCORE_POS           ;Save score before
                    sta                 SAVED_SCORE         ;drawing map
                    lda                 SCORE_POS+1         ;
                    sta                 SAVED_SCORE+1       ;Score needs to be saved
                    lda                 SCORE_POS+2         ;because when you redraw
                    sta                 SAVED_SCORE+2       ;the map between levels
                    lda                 SCORE_POS+3         ;the score needs to be
                    sta                 SAVED_SCORE+3       ;preserved
                    lda                 SCORE_POS+4
                    sta                 SAVED_SCORE+4
                    lda                 SCORE_POS+5
                    sta                 SAVED_SCORE+5
                    lda                 #$00                ;Low byte of screen memory
                    sta                 $fb
                    lda                 #04                 ;High byte of screen memory
                    sta                 $fc
                    lda                 MAPL                ;Map low
                    sta                 $fd
                    lda                 MAPH                ;Map High byte
                    sta                 $fe
                    ldx                 #4
main_lp             ldy                 #$00
loop1               lda                 ($fd),y
                    sta                 ($fb),y
                    dey
                    bne                 loop1
                    inc                 $fc
                    inc                 $fe
                    dex
                    bne                 main_lp
                    lda                 SAVED_SCORE         ; Display saved score
                    sta                 SCORE_POS           ;
                    lda                 SAVED_SCORE+1
                    sta                 SCORE_POS+1
                    lda                 SAVED_SCORE+2
                    sta                 SCORE_POS+2
                    lda                 SAVED_SCORE+3
                    sta                 SCORE_POS+3
                    lda                 SAVED_SCORE+4
                    sta                 SCORE_POS+4
                    lda                 SAVED_SCORE+5
                    sta                 SCORE_POS+5
                    rts
;============================================================
Init_Random
                    LDA                 #$FF                ; maximum frequency value
                    STA                 $D40E               ; voice 3 frequency low byte
                    STA                 $D40F               ; voice 3 frequency high byte
                    LDA                 #$80                ; noise waveform, gate bit off
                    STA                 $D412               ; voice 3 control register
                    rts
RAND                lda                 g$len               ; These two lines
                    beq                 dont_crash          ; prevent program crash
                    LDA                 $D41B               ; get random value from 0-255
                    CMP                 g$len               ; narrow random result down
                                                            ; to between zero - g$len
                    BCS                 RAND                ; ~ to 0-3
dont_crash          rts
;============================================================
;*************************************************************
; This sub adapted from
; http://www.retroremakes.com/remaketalk/index.php?p=/discussion/2391/how-to-write-a-c64-game-in-several-steps/p1
; Thank you!!
;
;increases score by A
;note that the score is only shown; not held in a variable
;
; Example score: 654321
; Loading X as 0 gives us the first digit '6'
; Loading X as 1 give us the second digit '5' and so on
; To add 500 to the score load X with #3 and load Acc with #5, call sub
; To add 3000 to score load X with #2 and load Acc with #3, call sub
; To add 10 load X with #4 and load Acc with #1
;*************************************************************
IncreaseScore
                    sta                 PARAM1
                    stx                 PARAM2
.IncreaseBy1
                    ldx                 PARAM2
.IncreaseDigit
                    inc                 SCORE_POS,x
                    lda                 SCORE_POS,x
                    cmp                 #58                 ; The number past 9 in C64 ascii
                    bne                 .IncreaseBy1Done
                                                            ;looped digit, increase next
                    lda                 #48                 ; '0' character
                    sta                 SCORE_POS,x
                    dex
                    bne                 .IncreaseDigit
                    ldx                 PARAM2
                    rts
.IncreaseBy1Done
                    dec                 PARAM1
                    bne                 .IncreaseBy1
                    ldx                 PARAM2
                    rts
;*************************************************************
; Ensure ghosts inside the cage bounce back and forth
; If they hit the left side increment the cage counter
; and set the course to go right
; If they hit the right side set the course to go back left
;*************************************************************
cage_sides
                    lda                 gy                  ;
                    cmp                 #12                 ;
                    bne                 exit_sub            ;
                    lda                 gx                  ;
                    cmp                 #18                 ; Left side of cage
                    beq                 set_right           ;
                    cmp                 #21                 ; Right Side of cage
                    beq                 set_left            ;
exit_sub            rts
set_right
                    inc                 g$cage_cntr         ; Increment this counter every time the ghost hits the left side of the cage
                    lda                 Const_LEFT          ; Set previous direction to LEFT
                    sta                 pd$
                    lda                 Const_RIGHT         ; Set new direction to move RIGHT
                    sta                 cdir                ;
                    rts
set_left
                    lda                 Const_RIGHT         ; Set previous direction to RIGHT
                    sta                 pd$
                    lda                 Const_Left          ; Set new direction to move LEFT
                    sta                 cdir                ;
@bott               rts
;*************************************************************
; Redraw color just the border of the map with the value
; passed down in the accumulator
;*************************************************************
color                                                       ;sta                 PARAM
                    pha
                    lda                 #$00                ;Low byte of screen memory
                    sta                 $fb
                    lda                 #$d8                ;High byte of screen memory
                    sta                 $fc
                    lda                 MAPL                ;Map low
                    sta                 $fd
                    lda                 MAPH                ;Map High byte
                    sta                 $fe
                    ldx                 #4
main_lp1            ldy                 #$00
loop2               lda                 ($fd),y
                    cmp                 #160
                    bne                 skip_aa
                                                            ;lda                 PARAM
                    pla
                    sta                 ($fb),y
                    pha
skip_aa             dey
                    bne                 loop2
                    inc                 $fc
                    inc                 $fe
                    dex
                    bne                 main_lp1
                    pla
                    rts
dly
                    ldx                 #8
def_2               ldy                 #0
loop_xx             jsr                 delay
                    dey
                    bne                 loop_xx
                    dex
                    bne                 def_2
                    rts
dly4
                   ; jsr                 dly                 
                   ; jsr                 dly
                    ;jsr                 dly                 
                    ;rts
                    ;jsr delay
                    ldy                 #1
                    nop
                    nop
def_2ab             ldx                 #50
loop_xxab           jsr                 delay
                    dex
                    cpx                 #0
                    bne                 loop_xxab
                                                            ;dey
                                                            ;cpy #0
                                                            ;bne                 def_2ab
                    rts
;*************************************************************
; Make the screen flash different colors after completing
; a level
;*************************************************************
FLASH_SCREEN
                    lda                 #3                  ; Number of flashes
                    sta                 COLOR_CNTR
loop3               dec                 COLOR_CNTR
                    lda                 #3
                    jsr                 color
                    jsr                 dly
                    lda                 #0
                    jsr                 color
                    jsr                 dly
                    lda                 COLOR_CNTR
                    bne                 loop3
                    rts
delay               txa
                    pha
                    tya
                    pha
                    ldy                 #3
del_lp2             ldx                 #1
del_lp1             stx                 smodabc
                    dex
                    cpx                 #0
                    bne                 del_lp1
                    dey
                    cpy                 #0
                    bne                 del_lp2
                    pla
                    tay
                    pla
                    tax
                    rts
smodabc             byte                0
;----------------------------------------------------------
; From http://codebase64.org/doku.php?id=base:delay
; Delay to smooth out raster interrupts
;
delayabc                                                    ;// delay 84-accu cycles, 0<=accu<=65
                    lsr                                     ;// 2 cycles akku=akku/2 carry=1 if accu was odd, 0 otherwise
                    bcc                 waste1cycle         ;// 2/3 cycles, depending on lowest bit, same operation for both
waste1cycle
                    sta                 smod+1              ;// 4 cycles selfmodifies the argument of branch
                    clc                                     ;// 2 cycles
;// now we have burned 10/11 cycles.. and jumping into a nopfield
smod
                    bcc                 *+10                ;// 3 cycles
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    rts                                     ; // 6 cycles
;*************************************************************
; Reset the Game Level and set score to zero
;*************************************************************
Prep_Level_One
                    jsr                 RESET_LEVEL         
        ;jsr                 RESET_LEVEL
                    lda                 #$30                ; Initilize the score
                    sta                 SCORE_POS           ;
                    sta                 SCORE_POS+1         ;
                    sta                 SCORE_POS+2         ;
                    sta                 SCORE_POS+3         ;
                    sta                 SCORE_POS+4         ;
                    sta                 SCORE_POS+5         ;
                    rts
;*************************************************************
; Upgrade to the next level
; Set the Ghost Priority &
; defaults to the new prioriy
; Dont need to reset btime counter here
; instead it is done when btime is enabled
;*************************************************************
RESET_LEVEL


                   
                    lda #1
                    sta close_mouth 
                    ;lda                 #0                  
                    ;sta                 flash_on            
                    ;sta                 flash_counter


                    ldx                 GAME_LEVEL
                    lda                 Const_gh2_DEF_PR,x  ;Grabbing the next
                    sta                 gh2_pr              ; et of priorities
                    lda                 Const_gh3_DEF_PR,x  ;Slightly more difficult
                    sta                 gh3_pr              ;For the next level
                    lda                 Const_gh4_DEF_PR,x
                    sta                 gh4_pr
                    lda                 Const_gh5_DEF_PR,x
                    sta                 gh5_pr
                    lda                 #0                  ;Reset Dots Eaten
                    sta                 DOTS_EATEN          ;
                    lda                 #0                  
                    sta                 TOTAL_DOTS_FLAG     ;
                    sta                 gh2_pr_cntr
                    sta                 gh3_pr_cntr
                    sta                 gh4_pr_cntr
                    sta                 gh5_pr_cntr

                    lda                 #18                 ;Move the ghosts
                    sta                 gh2_gx              ;Back into the
                    lda                 #19                 ;Ghost cage
                    sta                 gh3_gx
                    lda                 #20
                    sta                 gh4_gx
                    lda                 #21
                    sta                 gh5_gx
                    lda                 #12
                    sta                 gh2_gy
                    sta                 gh3_gy
                    sta                 gh4_gy
                    sta                 gh5_gy 
                    
                    lda                 #0
                    sta                 gh2_bluetime
                    sta                 gh2_eyesmode
                    sta                 gh3_bluetime
                    sta                 gh3_eyesmode
                    sta                 gh4_bluetime
                    sta                 gh4_eyesmode
                    sta                 gh5_bluetime
                    sta                 gh5_eyesmode
                    jsr                 dsp_pacs
                    LDA                 #%11111110
                    sta                 $d015               
                    lda                 #0                  
                    sta                 $d010 

                    Jsr                 Reset_Sprite        
                    jsr                 print_text     

                    LDA                 #$ff
                    sta                 $d015               

              
                    lda                 #0                  
                    sta                 gh1_pr              
                    sta                 gh1_g$   
                  
                    sta                 gh3_g$              
                    sta                 gh4_g$              
                    sta                 gh5_g$ 
                    sta                 gh1_pq$             
                    sta                 gh2_pq$
                    sta                 gh3_pq$
                    sta                 gh4_pq$
                    sta                 gh5_pq$
                    sta                 gh2_g$len               
                    sta                 gh3_g$len
                    sta                 gh4_g$len
                    sta                 gh5_g$len
                    sta                 gh2_pq$len               
                    sta                 gh3_pq$len
                    sta                 gh4_pq$len
                    sta                 gh5_pq$len          
                    sta                 gh2_pd$             
                    sta                 gh3_pd$             
                    sta                 gh5_pd$             


                    lda                 Const_left          
                    sta                 gh5_cdir            
                    sta                 gh3_cdir            
                    sta                 gh3_g$                    
                    sta                 gh3_pq$ 
                    sta                 gh3_pd$
                    lda                 Const_RIGHT         
                    sta                 cdir                
                    sta                 g$                  
                    sta                 gh1_cdir            
                    sta                 gh2_cdir            
                    sta                 gh4_cdir            
                    sta                 userdirection       
                    
                    sta                 gh4_g$              
                    sta                 gh4_pd$             
                  ;  sta                 gh4_pq$             
                   
                   

                    
                    lda #0
                    sta                 gh2_bluetime        
                    sta                 gh3_bluetime        
                    sta                 gh4_bluetime        
                    sta                 gh5_bluetime        
                    sta                 gh2_eyesmode        
                    sta                 gh3_eyesmode        
                    sta                 gh4_eyesmode        
                    sta                 gh5_eyesmode 

                    STA gh2_pr_cntr
                    STA                 gh3_pr_cntr
                    STA                 gh4_pr_cntr
                    STA                 gh5_pr_cntr


                   ; lda                 #2                  

                    sta                 gh2_cage_cntr       
                    sta                 gh3_cage_cntr       
                    sta                 gh4_cage_cntr       
                    sta                 gh5_cage_cntr  
                    lda #0
                    sta                 gh2_exit_cage_flg   
                    sta                 gh3_exit_cage_flg   
                    sta                 gh4_exit_cage_flg   
                    sta                 gh5_exit_cage_flg   
                                                            ;jsr                 mv_Ghost1  
            ;        lda                 #0                  
            ;    sta $d015
                    
                   ; jsr                 mv_Ghost1
                    jsr                 mv_Ghost2
                    jsr                 mv_Ghost3
                    jsr                 mv_Ghost4                      
                    jsr                 mv_Ghost5           
                    lda                 #$b0
                    sta $d000

                        lda                 #1
                        sta Gobble_on
                                  ; lda  #$8b
                    ;inx
                    ;inx
                   ; sta                 $7f8                
               ; sta $403
               ;                lda #$8b
               ;     sta                 $7f8                
                ;   sta $405
#region delay
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                            jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                            jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                            jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    jsr                 dly4                
                    ldy                 #0                  
clear_buffer        jsr                 $ffe4              
                    dey
                    bne clear_buffer
                  
#endregion
                   lda #0
                   sta close_mouth  
                    lda                 #19
                    sta                 gh1_gx
                    lda                 #14
                    sta                 gh1_gy

                    rts
;*************************************************************
; Print ready in the center of the map right before
; play begins
;*************************************************************
lbl_ready           Null                'ready!'
print_text          ldx                 #0
lbl_loop            lda                 lbl_ready,x
                    cmp                 #0
                    beq                 quit
                    sta                 $641,x              ; Hard coded start position
                    inx
                    txa
                    pha
                    jsr                 dly
                    pla
                    tax
                    jmp                 lbl_loop
quit                jsr                 dly
                    jsr                 dly
                    jsr                 dly
                    jsr                 dly
                    lda                 #$20
                    sta                 $641
                    sta                 $642
                    sta                 $643
                    sta                 $644
                    sta                 $645
                    sta                 $646
                    rts
dsp_pacs            ldx                 #0
                    lda                 pac_char
lbl_pacs            sta                 $7c0,x
                    inx
                    cpx                 PACS_AVAIL
                    bcc                 lbl_pacs
                    lda                 #$20
                    cpx                 #8
                    bne                 lbl_pacs
                    rts
;*************************************************************
; Actions taken when pac-clone is dead:
; Clear dath flag, decrease available free men
; Do the death animation and do a level reset
;*************************************************************
HE_DEAD
                    lda                 #0                  ; No Pacs dead
                    sta                 DEATH_FLAG          ; Reset flag
                    dec                 PACS_AVAIL          ; Decrease avail lives
                    lda                 PACS_AVAIL
                    cmp                 #0                  ; Is game over?
xx_self             beq                 xx_self             ; Right now program freezes after last man...
                    jsr                 DEATH_ANIMATION     ; Animate Pac on death
                    jsr                 RESET_LEVEL         ; Reset the level
                    rts
;*************************************************************
; Simulate death of pac-clone by changing out characters
; with small delay between
;*************************************************************
DEATH_ANIMATION
                    lda                 #1
                    pokeaxy             gh1_gx,gh1_gy
                    jsr                 dly
                    jsr                 dly
                    jsr                 dly
                    lda                 #2
                    pokeaxy             gh1_gx,gh1_gy
                    jsr                 dly
                    jsr                 dly
                    jsr                 dly
                    lda                 #3
                    pokeaxy             gh1_gx,gh1_gy
                    jsr                 dly
                    jsr                 dly
                    jsr                 dly
                    lda                 #$20
                    pokeaxy             gh1_gx,gh1_gy
                    rts
;*************************************************************
; Eat Dots
;*************************************************************
EAT_DOTS
                    lda                 #1                  ; 10 points
                    ldx                 #4                  ; 4th decimal pos
                    jsr                 IncreaseScore       ; Give me points

                    inc                 DOTS_EATEN          ; Eat a dot


                    lda                 TOTAL_DOTS_FLAG     
                    cmp                 #1                  
                    bne                 _eat_first_255                

                    lda                 DOTS_EATEN          
                    cmp                 Const_TOTAL_DOTS
                    beq                 _levelup            
                    rts
_eat_first_255      lda                 DOTS_EATEN          ;
                    cmp                 #255                ; Are all dots eaten?
                    bne                 lbl_rtn             ; No
                    inc                 TOTAL_DOTS_FLAG     
                    rts
_levelup                                                    
                    lda                 #1                  
                    sta                 Gobble_on           
                    sta close_mouth 
                        
                    lda                 #0                  
                    sta                 gh2_flashon         
                    sta                 gh3_flashon         
                    sta                 gh4_flashon         
                    sta                 gh5_flashon         
                    sta                 flash_on 
                    ;sta                 flash_counter       
                    ;sta                 flash_counter2       
                    ;sta                 flash_counter3      

                    LDA                 #1              ; Only Pac-Clone at map end
                    sta                 $d015               ;
                    jsr                 FLASH_SCREEN        ; Yes, do the screen flash
                    inc                 GAME_LEVEL          ; Advance to the next level
                    jsr                 drawmap             ; Redraw a fresh map
                    jsr                 RESET_LEVEL
lbl_rtn             rts
#endregion
space
                    lda                 wall_spc
@ext                pokeaxy             gh1_gx,gh1_gy
                    rts

Reset_Sprite
                    lda #0
                    sta                 gh1_sp_pos          
                    sta                 gh2_sp_pos          
                    sta                 gh3_sp_pos          
                    sta                 gh4_sp_pos          
                    sta                 gh5_sp_pos          
                    sta                 gh1_spctr           
                    sta                 gh2_spctr           
                    sta                 gh3_spctr           
                    sta                 gh4_spctr           
                    sta                 gh5_spctr           
        
                    lda                 #$8c
                    sta                 $07f9               ; sprite 2
                    jsr                 Spr_ghostcolor

                    lda                 #$8d
                    sta                 $07fA               ; sprite 3
                    lda                 #100
                    sta                 $d004
                    lda                 #130
                    sta                 $d005
                    lda                 #$8e
                    sta                 $07fb               ; sprite 4
                    lda                 #140
                    sta                 $d006
                    lda                 #150
                    sta                 $d007
                    lda                 #$8f
                    sta                 $07fc               ; sprite 5
                    lda                 #200
                    sta                 $d008
                    lda                 #130
                    sta                 $d009
                    lda                 #$b0
                    sta                 $d000
                    lda                 #162
                    sta                 $d001
                    lda                 #7                  ;make the int_sprite yellow
                    sta                 $d027               
                    lda                 #21*8               ; Ghost 1 Position
                    sta                 $d002               ;
                    lda                 #146                ;
                    sta                 $d003               ;
                    lda                 #22*8               ; Ghost 2 Position
                    sta                 $d004               ;
                    lda                 #146                ;
                    sta                 $d005               ;
                    lda                 #23*8               ; Ghost 3 Position
                    sta                 $d006               ;
                    lda                 #146                ;
                    sta                 $d007               ;
                    lda                 #24*8               ; Ghost 4 Position
                    sta                 $d008               ;
                    lda                 #146                ;
                    sta                 $d009               ;
                    
                    ldx                 spr_right_low       
                   ; stx                 int_sprite          
                   ; stx                 int_counter         

                    stx                 int_spr_low
                    stx                 int_sprite
                    inx
                    inx
                    inx
                    stx                 int_spr_high        
                    stx $7f8

                    lda                 #0                  
                    sta                 gh2_flashon
                    sta                 gh3_flashon
                    sta                 gh4_flashon
                    sta                 gh5_flashon

                    sta                 int_counter         
                   lda                 #0                  
                    sta                 flash_on 
                    sta                 flash_counter       
                    sta                 flash_counter2       
                    sta                 flash_counter3      
                    rts

Set_Interrupt       ;jmp _no_int
                    sei                                     ; disable interrupts
                    lda                 #<intcode           ; get low byte of target routine
                    sta                 788                 ; put into interrupt vector
                    lda                 #>intcode           ; do the same with the high byte
                    sta                 789
                    cli                                     ; re-enable interrupts
                                                            ; return to caller
_no_int              ldx                 spr_right_low       ; $84=$2000=sprite 1| $85 = sprite 2 etc.
                    stx                 $07f8               ; Sprite 1
                    stx                 int_spr_low         ; First sprite has three separate sprites
                    stx                 int_sprite          ; to emulate open-close of mouth
                    inx
                    inx
                    inx
                    stx                 int_spr_high        ;
                    jsr Reset_Sprite
                    rts
intcode             = *
                    pha
                    lda                 Gobble_on
                    cmp                 #0
                    beq                 skip2
                    lda                 close_mouth         
                    cmp #0
                    beq                 _normal             
                    ldx                 int_spr_low         
                    inx
                    inx
                    stx                 $7f8                

                    jmp                 flash_check         
end_jmp             jmp end
_normal             lda                 int_spr_low
                    sta                 $7f8

                    jmp                 flash_check
skip2               inc                 int_counter
                    lda                 int_counter
                    cmp                 #03
                    bne                 flash_check ;end_jmp
                    lda                 #0
                    sta                 int_counter
                    inc                 int_sprite
                    lda                 int_sprite
                    cmp                 int_spr_high
                    bne                 int_skip
                    lda                 int_spr_low
                    sta                 int_sprite
int_skip            sta                 $7f8



flash_check
                    inc                 flash_counter2
                    lda                 flash_counter2
                    cmp                 #20
                    bne                 end
                    inc                 flash_counter3      
                    ;lda                 flash_counter3      
                    
        

                    
                    lda                 #0                  
                    sta                 flash_counter2      

                    lda                 gh2_flashon
                    cmp                 #1
                    bne                 test_2              
                    inc FLASH_ON
                    ldy #0
                    jsr                 set_flash_color     

test_2              lda                 gh3_flashon 
                    cmp                 #1
                    bne                 test_3              
                    inc FLASH_ON
                    ldy #1                    
                    jsr                 set_flash_color     

test_3              lda                 gh4_flashon 
                    cmp                 #1
                    bne                 test_4              
                    inc FLASH_ON
                    ldy #2
                    jsr                 set_flash_color     

test_4              lda                 gh5_flashon
                    sta $40a
                    cmp                 #1
                    bne                 _end_flash                
                    inc FLASH_ON                    
                    ldy #3                    
                    jsr                 set_flash_color     

_end_flash          lda                 flash_counter       
                    cmp                 #2
                    bcc _inc
                    lda                 #0                  
                    sta                 FLASH_ON            
                    lda #0
                    sta flash_counter
_inc                inc                 flash_counter
@_end_here          nop
        
 
end                 pla
                    jmp                 $ea31    
           


int_param            byte                00
int_counter         byte                00
int_spr_low         byte                00
int_spr_high        byte                00
int_sprite          byte                00
junkaaaa            byte                $31,$31,$31
Gobble_on           byte                00
spr_up_low          byte                $80
spr_down_low        byte                $83
spr_left_low        byte                $86
spr_right_low       byte                $89
flash_counter       byte                00
flash_on            byte                00
flash_counter2      byte                00

*                   = $2000

; 
 BYTE $00,$00,$00
 BYTE $C3,$00,$00
 BYTE $C3,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $66,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $C3,$00,$00
 BYTE $C3,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $66,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $7C,$00,$00
 BYTE $7E,$00,$00
 BYTE $1F,$00,$00
 BYTE $07,$00,$00
 BYTE $07,$00,$00
 BYTE $1F,$00,$00
 BYTE $7E,$00,$00
 BYTE $7C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $7F,$00,$00
 BYTE $07,$00,$00
 BYTE $07,$00,$00
 BYTE $7F,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3E,$00,$00
 BYTE $7E,$00,$00
 BYTE $F8,$00,$00
 BYTE $E0,$00,$00
 BYTE $E0,$00,$00
 BYTE $F8,$00,$00
 BYTE $7E,$00,$00
 BYTE $3E,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FE,$00,$00
 BYTE $E0,$00,$00
 BYTE $E0,$00,$00
 BYTE $FE,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $DB,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $A5,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $7E,$00,$00
 BYTE $DB,$00,$00
 BYTE $DB,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $A5,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $AB,$00,$00
 BYTE $55,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $D5,$00,$00
 BYTE $AA,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $62,$00,$00
 BYTE $B5,$00,$00
 BYTE $F5,$00,$00
 BYTE $62,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $46,$00,$00
 BYTE $AD,$00,$00
 BYTE $AF,$00,$00
 BYTE $46,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $E7,$00,$00
 BYTE $A5,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $A5,$00,$00
 BYTE $E7,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

MAPL                BYTE                <MAP_DATA
MAPH                BYTE                >MAP_DATA
MAP_DATA
incbin              pacmap3.bin
