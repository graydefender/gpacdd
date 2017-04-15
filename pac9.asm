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
; * reformat code 20,20,20
; * Add scoring routine for dots and power pills
; * 1/23/16 Add score for eating ghosts
; * 1/25/16 Add some level logic 
;============================================================
;  Quick code to create auto execute program from basic
;============================================================
*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $34, $30, $39, $36, $00, $00
                    byte                $00
;============================================================
;=                       MAP
;============================================================
Cage_Xpos           byte                19
Cage_Ypos           byte                12
junk5               byte                $31,$31,$31
gh2_eyesmode        byte                00
junk6               byte                $32,$32,$32
gh2_bluetime        byte                00
junk7               byte                $33,$33,$33
gh2_btime_count     byte                255
junk8               byte                $34,$34,$34
gh2_cage_cntr       byte                00
junk9               byte                $35,$35,$35
gh2_exit_cage_flg   byte                00
junka               byte                $36,$36,$36
gh2_xg              byte                0 ;39
junk1               byte                $37,$37,$37
gh2_yg              byte                12
junk2               byte                $38,$38,$38
gh1_gy              byte                10
gh1_gx              byte                16
gh1_pq$             byte                $00,$00
gh1_pq$len          byte                00
gh1_g$              byte                $00,$00,$00,$00
gh1_g$len           byte                00
gh1_xg              byte                39
gh1_yg              byte                12
gh1_pr_cntr         byte                0
junkb               byte                $39,$39,$39
gh1_pr              byte                100
junk3               byte                $30,$30,$30
gh1_pd$             byte                21
junkc               byte                $31,$31,$31
gh1_cdir            byte                4
junk4               byte                $32,$32,$32
gh1_bluetime        byte                00
gh1_btime_count     byte                50
gh1_eyesmode        byte                01
gh1_cage_cntr       byte                00
gh1_exit_cage_flg   byte                00
gh2_gx              byte                1
gh2_gy              byte                3
gh2_pq$             byte                $00,$00
gh2_g$              byte                $00,$00,$00,$00
xjunk5              byte                $31,$31,$31
zjunk5              byte                $31,$31,$31
gh2_pr_cntr         byte                0
gh2_pd$             byte                21
gh2_cdir            byte                21
ejunk5              byte                $31,$31,$31
gh2_pq$len          byte                00
gh2_g$len           byte                00
junkxx              byte                $30,$30,$30
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
gd                  byte                00
px                  byte                20
py                  byte                23
map_off_l           byte                $00,$28,$50,$78,$A0,$C8,$F0,$18,$40,$68,$90,$b8,$E0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0
map_off_h           byte                $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07
wall_dot            byte                46  ; period '.'
wall_spc            byte                32  ; space ' '
wall3__nrgzr        byte                42  ; asterisk '*'
gh4_char            byte                48  ; Pac-Clone char
gh5_char            byte                49  ; variable ghost char 1
gh6_char            byte                50  ; variable ghost char 2
gh7_char            byte                51  ; variable ghost char 3
gh8_char            byte                52  ; variable ghost char 4
Const_gh5_char      byte                49  ; Constant ghost char 1
Const_gh6_char      byte                50  ; Constant ghost char 2
Const_gh7_char      byte                51  ; Constant ghost char 3
Const_gh8_char      byte                52  ; Constant ghost char 4
wall_cge            byte                45  ; '-' this is the cage minus char
blue_ghost          byte                53  ;Change ghost to this during blue time
Flashing_gh         byte                54
eyemode             byte                55  ;Change ghost to this during eyemode
;*****************************************************
gh3_gx              byte                32
gh3_gy              byte                4
gh3_pq$             byte                $00,$00
gh3_g$              byte                $00,$00,$00,$00
gh3_xg              byte                39
gh3_yg              byte                12
gh3_pr_cntr         byte                0
gh3_pd$             byte                21
gh3_cdir            byte                4
gh3_pq$len          byte                00
gh3_g$len           byte                00
gh3_bluetime        byte                00
gh3_btime_count     byte                50
gh3_eyesmode        byte                00
gh3_cage_cntr       byte                00
gh3_exit_cage_flg   byte                00
gh4_gx              byte                32
gh4_gy              byte                14
gh4_pq$             byte                $00,$00
gh4_g$              byte                $00,$00,$00,$00
gh4_xg              byte                39
gh4_yg              byte                12
gh4_pr_cntr         byte                0
gh4_pd$             byte                21
gh4_cdir            byte                4
gh4_pq$len          byte                00
gh4_g$len           byte                00
gh4_bluetime        byte                00
gh4_btime_count     byte                50
gh4_eyesmode        byte                00
gh4_cage_cntr       byte                00
gh4_exit_cage_flg   byte                00
gh5_gx              byte                32
gh5_gy              byte                14
gh5_pq$             byte                $00,$00
gh5_g$              byte                $00,$00,$00,$00
gh5_xg              byte                11
gh5_yg              byte                12
gh5_pr_cntr         byte                0
gh5_pd$             byte                21
gh5_cdir            byte                4
gh5_pq$len          byte                00
gh5_g$len           byte                00
gh5_bluetime        byte                00
gh5_btime_count     byte                50
gh5_eyesmode        byte                00
gh5_cage_cntr       byte                00
gh5_exit_cage_flg   byte                00
warp                byte                00
ispacman            byte                00
userdirection       byte                00
pac_pd$             byte                00   ; used to keep pac-man moving in same general direction of travel
HIGH_PR             byte                100  ; High priority for eyes returning to cage
gh2_pr              byte                05
gh3_pr              byte                04
gh4_pr              byte                03
gh5_pr              byte                02
gh2_DEF_PR          byte                05   ; Default values to reset back to
gh3_DEF_PR          byte                04
gh4_DEF_PR          byte                03
gh5_DEF_PR          byte                02
PARAM1              byte                00
PARAM2              byte                00
SCORE_POS           = $411                                  ; Position of First 0 in score from left
GHOSTS_EATEN        byte                00                  ; Count Number of ghosts eaten per blue time
DOTS_EATEN          byte                00
COLOR_CNTR          byte                15                  ; Number of screen flashes between levels
Const_TOTAL_DOTS    byte                200                 ; Total number of dots on the map
;*****************************************************
; Level Defaults
; First byte is level 1, second level 2, etc.
;*****************************************************
GAME_LEVEL         byte 00                                  ; Game Level defaults to 0
Const_BT1_Ctr      byte 255,200,150,100,050,025,005         ; Blue time counter 1
Const_BT2_Ctr      byte 020,020,020,020,015,005,001         ; Blue time counter 2
Const_Pr_gh1       byte 015,015,015,015,015,015,015         ; Ghost Priorities
Const_Pr_gh2       byte 010,010,010,010,010,010,010         ;
Const_Pr_gh3       byte 009,009,009,009,009,009,009         ;
Const_Pr_gh4       byte 008,008,008,008,008,008,008         ;
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
;*****************************************************
defm                wall_chk
                    ldx                 /2                  ; I realize these next 7 lines
                    ldy                 /1                  ; are my peekaxy macro
                    lda                 map_off_l,x         ; but CBM Prg Studio cannot
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
                    cmp                 gh4_char            ; Or any of the ghosts chars
                    beq                 @notwall
                    cmp                 gh5_char            ; including Pac-clone
                    beq                 @notwall
                    cmp                 gh6_char            ;
                    beq                 @notwall
                    cmp                 gh7_char            ;
                    beq                 @notwall
                    cmp                 gh8_char            ;
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
                    cmp                 #/3                 ;make sure ghost does not move in
                    beq                 @bottom             ;previous direction so no quick back and forth movement
                    lda                 #/4                 ;Load opposite direction
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
@cont               lda                 #/4                 ; Load new direction
                    ldx                 pq$len              ; Store as new priority direction
                    sta                 pq$,x               ; of travel
                    inc                 pq$len              ;
@bottom
                    nop
                    endm
;*****************************************************
; Variable Initilization Part 1
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
;*****************************************************
defm                move_ghosts_part3
                    jsr                 check_end           ;
                    jsr                 Check_Walls         ;
                    lda                 ispacman
                    cmp                 #1
                    beq                 @skip
                    jsr                 ck_leftside
                    jsr                 ck_rightside
@skip
                    jsr                 space
                    jsr                 mv_gh
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
@skipa              lda ghost_pr
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
                                                            ; during bluetime
@bottom
                    endm

;*****************************************************
; Check if blue time is on
; and count how long it is on
;*****************************************************
defm                check_btime
                    lda                 /1
                    cmp                 #1                  ; Is blue time on ?
                    bne                 @quit               ; No
                    dec                 /2                  ; Decrease blue time Counter
                    lda                 /2
                    cmp                 #20                 ; only 20 moves of blue time left
                    bne                 @ck_zero            ; if so then change ghost
                    lda                 Flashing_gh         ; character to mimic flashing ghost
                    sta                 /3
                    jmp                 @quit
@ck_zero            cmp #0                                  ; no more blue time left?
                    bne                 @quit               ; None left then quit
                    lda                 #255                ; reset the blue time
                    sta                 /2                  ; counter,
                    lda                 #0
                    sta                 /1                  ; turn off blue time
                    lda                 /4                  ; and change ghost character
                    sta                 /3                  ; back to normal
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
;*************************************************************

defm                Collision
                    lda                 /1
                    cmp                 gh1_gx              ; Does Ghost X = Pac X  ?
                    bne                 @bottom             ; NO
                    lda                 /2
                    cmp                 gh1_gy              ; Does Ghost Y = Pac Y ?
                    bne                 @bottom             ; No
                    lda                 /3                  ; Blue time on?
                    cmp                 #1
                    bne                 @bottom             ; NO
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
                    lda                 eyemode             ; Change to eyemode character
                    sta                 /5
                    lda                 Cage_Xpos           ; Load New Dest X and
                    sta                 /6
                    lda                 Cage_Ypos           ; Dest Y values for ghost cage
                    sta                 /7
                    lda                 HIGH_PR             ;Change priority of eyes to always move towards priority
                    sta                 /8
                    sta                 ghost_pr
                    lda                 #0
                    sta                 /9                  ;Reset the Priority Counter to zero
@bottom             nop
                    endm
;*****************************************************
;* Check to see if ghost is entering /exiting cage
;* If exiting then turn off eyes mode and change ghost char
;* And reset ghost priority
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
                                                            ;****fix - ghosts leaving cage had bad priority
                    lda                 /4                  ; Reset ghost priority when entering cage
                    sta                 /5                  ;
@exit               nop
                    endm
;*****************************************************
;* Once ghost is in cage, ensure it bounces back
;* and forth at least two times before exiting
;* thats what the g$cage_cntr var is for
;*****************************************************
defm                CageDrama
                    lda                 g$cage_cntr
                    cmp                 #2                  ;has ghost hit left side of cage 2 times?
                    bne                 @skp_bot
                                                            ;Allow ghost to exit the cage
                    lda                 #1                  ; set the exit cage flag
                    sta                 /1                  ; allow ghost to exit the cage
                    lda                 #255                ;hard coded blue time count reset
                    sta                 /2
                    lda                 #0                  ;Turn off Eyes mode
                    sta                 /4
                    lda                 #1
                    sta                 /6                  ;change the yg value so caged ghost will escape upwards
                    sta                 yg
                    lda                 /7                  ;reset to default priority ghost exiting cage
                    sta                 /5
                    sta                 ghost_pr
                    lda                 #0
                    sta                 g$cage_cntr         ; reset cage counter to zero
@skp_bot            sta /3            ; save acc back to cage counter
                    nop
                    endm
;*************************************************************
; Set the end goal location of the ghosts to be
; where ever pac-clone is on the map
; unless Eyesmode is on then leave it alone...
;*************************************************************
defm                SetGH_XY
                    lda                 /1                  ; Eyesmoode On?
                    cmp                 #1
                    beq                 @bot                ; If yes exit
                    lda                 xg                  ; Otherwise
                    sta                 /2                  ; Set new ghost priority
                    lda                 yg                  ; to match the location
                    sta                 /3                  ; of pac-clone on the map
@bot                nop
                    endm
;*****************************************************
; This code tells the ghosts where
; Pac-clone is on the map but we dont want them
; To know where he is if bluetime is on, in fact
; this code tells the ghosts to run to the opposite
; side of the map relative to pac-clone if blue time is on
;*****************************************************
defm                updatexy
                    lda                 /1                  ; Is bluetime on?
                    cmp                 #1                  ;
                    beq                 @thwart_gh          ; Yes then continue
                    lda                 /2                  ; Check if eyes mode is on
                    cmp                 #1                  ; if Yes then dont change xy destination points
                    beq                 @bot
;*** next three lines was causing ghosts not to follow pac-clone
                                                            ;lda /5           ; Check exit cage flag is set to 1
                                                            ;cmp #1           ; This should prevent ghost bouncing back
                                                            ; and forth endlessly in cage
                                                            ;beq @bot
                    lda                 gh1_gx              ; Change Dest X and
                    sta                 /3
                    lda                 gh1_gy              ; Dest Y values of ghost
                    sta                 /4                  ; to follow Pac-clone
                    jmp                 @bot
@thwart_gh          lda gh1_gx       ; Blue time is on, so ghosts should be afraid
                    cmp                 Cage_Xpos           ; of Pac-Clone. Set the Dest X and Dest Y
                    bcs                 @skip               ; values of ghost to opposite side of map
                    lda                 #39                 ; relative to Pac-Clones current position
                    sta                 /3
                    jmp                 @ck_y
@skip               lda #1           ; For example pac-clone is somewhere on right side of map
                    sta                 /3                  ; make ghosts move to left side setting Dest X
@ck_y               lda gh1_gy
                    cmp                 Cage_Ypos           ;Check if pac-clone is on top side of map
                    bcs                 @skip2
                    lda                 #24                 ;if so set Dest Y to bottom part of map
                    sta                 /4
                    jmp                 @bot
@skip2              lda #1           ;if not set Dest Y to top part of map
                    sta                 /4
@bot
                    endm
;============================================================
;             Main Program Variables
;============================================================
*=$1000
                    lda                 #4
                    sta                 53280
                    lda                 #$93                ; shift clear dec 147
                    jsr                 $FFD2               ; clear screen
                    jsr                 Init_Random         
                    lda #3
                    jsr                 drawmap
                    lda                 #$30                ; Initilize the score
                    sta                 SCORE_POS
                    sta                 SCORE_POS+1
                    sta                 SCORE_POS+2
                    sta                 SCORE_POS+3
                    sta                 SCORE_POS+4
                    sta                 SCORE_POS+5
main_prg_lp
                    peekaxy             gh1_gx,gh1_gy       ; Did Pac-Clone eat
                    cmp                 wall3__nrgzr        ; the energizer?
                    beq                 Energize            ; NO, then skip
                                                            ;lda                 ispacman            ; If this is pac-clone
                                                            ;cmp                 #1                  ; then add score for
                                                            ; bne                 spc           ; eating dots
                    cmp                 wall_dot
                    bne                 sk_385
                    lda                 #1                  ; 10 points
                    ldx                 #4                  ;
                    jsr                 IncreaseScore       
                    inc                 DOTS_EATEN          
                    lda                 DOTS_EATEN          
                    cmp                 Const_TOTAL_DOTS                
                    bne                 sk_385              
                    jsr FLASH_SCREEN
aaaa                    jmp                 aaaa
Energize
                    lda                 #1                  ; 100 points
                    ldx                 #3                  ;
                    jsr                 IncreaseScore
                    lda                 #0                  ; Reset the ghosts Eaten Counter
                    sta                 GHOSTS_EATEN        ; USed for score purposes
                    turn_on_btime       gh2_bluetime,gh5_char,gh2_eyesmode; Turn on blue time
                    turn_on_btime       gh3_bluetime,gh6_char,gh3_eyesmode; want to turn it on
                    turn_on_btime       gh4_bluetime,gh7_char,gh4_eyesmode; unless eyemode
                    turn_on_btime       gh5_bluetime,gh8_char,gh5_eyesmode; is activated
sk_385              lda                 gh4_char
                    pokeaxy             gh1_gx,gh1_gy
                    lda                 gh5_char
                    pokeaxy             gh2_gx,gh2_gy
                    lda                 gh6_char
                    pokeaxy             gh3_gx,gh3_gy
                    lda                 gh7_char
                    pokeaxy             gh4_gx,gh4_gy
                    lda                 gh8_char
                    pokeaxy             gh5_gx,gh5_gy
getch
                    jsr                 $ffe4               ; Input a key from the keyboard
                    beq                 getch
                    cmp                 #$5a                ; z down pressed
                    beq                 udir
                    cmp                 #$57                ; up w pressed
                    beq                 udir
                    cmp                 #$41                ; left a pressed
                    beq                 udir
                    cmp                 #$53                ; right s pressed
                    beq                 udir
                    cmp                 #$54
                    bne                 ska
                    turn_on_btime       gh2_bluetime,gh5_char,gh2_eyesmode; Turn on blue time
                    turn_on_btime       gh3_bluetime,gh6_char,gh3_eyesmode; want to turn it on
                    turn_on_btime       gh4_bluetime,gh7_char,gh4_eyesmode; unless eyemode
                    turn_on_btime       gh5_bluetime,gh8_char,gh5_eyesmode; is activated
                    jmp                 getch
ska
                    lda                 gh1_cdir            ;This makes pac-clone move in the last current dir when no input given
leftright           cmp                 #12
                    beq                 lft_ck
                    cmp                 #18
                    beq                 rt_ck
udir                cmp                 #$5a
                    beq                 warpL
nextck1             cmp                 #$57
                    beq                 warpR
                    jmp                 nextck2
warpL               ldx                 #4                  ;Temp store 'D' down value
                    jmp                 warp_tnnl
warpR               ldx                 #21                 ;Temp store 'U' up value
warp_tnnl           lda                 gh1_gy
                    cmp                 #12                 ;Check if on line 12 = warp line
                    bne                 not_warpln          ;
                    lda                 gh1_gx
                    cmp                 #0                  ;Warp Tunnel Handling
                    bne                 Chk_rtsd            ;If warped through set the
                    lda                 gh1_cdir            ;current direction variable
                    jmp                 leftright           ;Makes pac-clone move in the last current dir when no input given
Chk_rtsd            cmp                 #39                 ;
                    bne                 not_warpln          ;
                    lda                 gh1_cdir            ;
                    jmp                 leftright           ;
not_warpln          txa                                     ; Restore X to 'U' or 'D' value
                    jmp                 continue
nextck2             cmp                 #$41                ; A pressed
                    bne                 nextck3
lft_ck              jsr                 ck_leftside3
                                                            ;jmp notthis
                    lda                 #12
                    jmp                 continue
nextck3             nop
                                                            ;cmp #$53               ; S pressed
                                                            ;beq rt_ck
rt_ck               jsr                 ck_rightside3
                                                            ;         jmp notthis2
aaa                 lda                 #18
continue            sta                 userdirection
                    lda                 #1
                    sta                 ispacman
                    lda                 #0
                    sta                 gh1_pd$
;**** MOVE GHOSTS *****
                    jsr                 mv_Ghost1
skip_gh             lda                 #0
                    sta                 ispacman
                    jsr                 mv_Ghost2
                    jsr                 mv_Ghost3
;***DEBUG
                     jsr                 mv_Ghost4
                     jsr                 mv_Ghost5
;                    lda                 gh2_bluetime
;                    sta                 $410
;                    lda                 gh2_xg
;                    sta                 $411
;                    lda                 gh2_yg
;                    sta                 $412
;                    lda                 gh3_bluetime
;                    sta                 $413
;                    lda                 gh3_xg
;                    sta                 $414
;                    lda                 gh3_yg
;                    sta                 $415
;                    lda                 gh4_bluetime
;                    sta                 $416
;                    lda                 gh4_xg
;                    sta                 $417
;                    lda                 gh4_yg
;                    sta                 $418
;                    lda                 gh5_bluetime
;                    sta                 $419
;                    lda                 gh5_xg
;                    sta                 $41a
;                    lda                 gh5_yg
;                    sta                 $41b
                    jmp                 main_prg_lp
                                                            ;rts
ck_leftside3        lda                 gh1_gx
                                                            ;sta $410
                    cmp                 #0
                    bne                 exit_ck3
                    lda                 gh1_gy
                    cmp                 #12
                    bne                 exit_ck3
                    lda                 wall_spc
                    pokeaxy             gh1_gx,gh1_gy
                    lda                 #39
                    sta                 gx
                    sta                 gh1_gx
                    lda                 gh4_char
                    pokeaxy             gh1_gx,gh1_gy
                    lda                 #1
                    sta                 warp
exit_ck3            rts
ck_rightside3       lda                 gh1_gx
                    cmp                 #39
                    bne                 exit_ck4
                    lda                 gh1_gy
                    cmp                 #12
                    bne                 exit_ck4
                    lda                 wall_spc
                    pokeaxy             gh1_gx,gh1_gy
                    lda                 #0
                    sta                 gx
                    sta                 gh1_gx
                    lda                 gh4_char
                    pokeaxy             gh1_gx,gh1_gy
                    lda                 #1
                    sta                 warp
exit_ck4            rts
ck_leftside         lda                 cdir
                    cmp                 #18
                    beq                 @end
                    lda                 wall_spc
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
                    lda                 wall_spc
                    pokeaxy             gx,gy
                    lda                 gx
;   sta                 $409
                    cmp                 #39
                    bne                 @end
@skip
                    lda                 #$00
                    sta                 gx
                    lda                 #1
                    sta                 warp
@skip2
                    jsr                 Check_Walls
@end           rts

;*************************************************************
; Collisions must be checked before and after moving pac-clone
; A collision occurs when a ghost runs into pac-clone
; One of two things should happen
;
; 1) Bluetime is enabled
; 2) Pac-Clone dies
;*************************************************************
Collisions
                    Collision           gh2_gx,gh2_gy,gh2_bluetime,gh2_eyesmode,gh5_char,gh2_xg,gh2_yg,gh2_pr,gh2_pr_cntr
                    Collision           gh3_gx,gh3_gy,gh3_bluetime,gh3_eyesmode,gh6_char,gh3_xg,gh3_yg,gh3_pr,gh3_pr_cntr
                    Collision           gh4_gx,gh4_gy,gh4_bluetime,gh4_eyesmode,gh7_char,gh4_xg,gh4_yg,gh4_pr,gh4_pr_cntr
                    Collision           gh5_gx,gh5_gy,gh5_bluetime,gh5_eyesmode,gh8_char,gh5_xg,gh5_yg,gh5_pr,gh5_pr_cntr
                    rts
mv_Ghost1
                    jsr                 Collisions
                    move_ghosts_part1   gh1_pr_cntr,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_xg,gh1_yg,gh1_pr
                    move_ghosts_part2   gh1_cdir,gh1_pq$len,gh1_g$len,gh1_eyesmode,gh1_cage_cntr,gh1_exit_cage_flg
                    move_ghosts_part3   gh1_pr_cntr,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_pr
                    move_ghosts_part4   gh1_cdir,gh1_pq$len,gh1_g$len
                    jsr                 Collisions
                                                            ;***********************************************
                                                            ;** Make ghosts follow Pac-CLone
                    updatexy            gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg,gh2_exit_cage_flg
                    updatexy            gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg,gh3_exit_cage_flg
                    updatexy            gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg,gh4_exit_cage_flg
                    updatexy            gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg,gh5_exit_cage_flg
                                                            ;***********************************************
                    lda                 wall_cge
                    sta                 1523-40
                    lda                 #160
                    sta                 1524-40
                    rts
mv_Ghost2
                    move_ghosts_part1   gh2_pr_cntr,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_xg,gh2_yg,gh2_pr
                    move_ghosts_part2   gh2_cdir,gh2_pq$len,gh2_g$len,gh2_eyesmode,gh2_cage_cntr,gh2_exit_cage_flg
                                                            ;lda #$56
                                                            ;sta $400
                    move_ghosts_part3   gh2_pr_cntr,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_pr
                                                            ;  lda                 #$56
                                                            ;  sta                 $409
                                                            ;SetGH_XY gh2_eyesmode,gh2_xg,gh2_yg
                    check_cage          gh5_char,gh2_eyesmode,gh2_exit_cage_flg,gh2_DEF_PR,gh2_pr,gh2_bluetime,Const_gh5_char
                                                            ; lda                 #$56
                                                            ; sta                 $40a
                    check_btime         gh2_bluetime,gh2_btime_count,gh5_char,Const_gh5_char
                                                            ; lda                 #$56
                                                            ; sta                 $40b
                    move_ghosts_part4   gh2_cdir,gh2_pq$len,gh2_g$len
                                                            ;lda                 #$56
                                                            ;sta                 $40c
                    CageDrama           gh2_exit_cage_flg,gh2_btime_count,gh2_cage_cntr,gh2_eyesmode,gh2_pr,gh2_yg,gh2_DEF_PR
                                                            ;lda                 #$56
                                                            ;sta                 $40d
                                                            ;lda                 gh2_eyesmode
                                                            ;sta                 $405
                                                            ;lda                 gh2_bluetime
                                                            ;sta                 $409
                    rts
mv_Ghost3
                    move_ghosts_part1   gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_xg,gh3_yg,gh3_pr
                    move_ghosts_part2   gh3_cdir,gh3_pq$len,gh3_g$len,gh3_eyesmode,gh3_cage_cntr,gh3_exit_cage_flg
                    move_ghosts_part3   gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_pr
                                                            ;SetGH_XY gh3_eyesmode,gh3_xg,gh3_yg
                    check_cage          gh6_char,gh3_eyesmode,gh3_exit_cage_flg,gh3_DEF_PR,gh3_pr,gh3_bluetime,Const_gh6_char
                    check_btime         gh3_bluetime,gh3_btime_count,gh6_char,Const_gh6_char
                    move_ghosts_part4   gh3_cdir,gh3_pq$len,gh3_g$len
                    CageDrama           gh3_exit_cage_flg,gh3_btime_count,gh3_cage_cntr,gh3_eyesmode,gh3_pr,gh3_yg,gh3_DEF_PR
                    lda                 gh3_eyesmode
                    sta                 $406
                    lda                 gh3_bluetime
                    sta                 $40a
                    rts
mv_Ghost4
                    move_ghosts_part1   gh4_pr_cntr,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_xg,gh4_yg,gh4_pr
                    move_ghosts_part2   gh4_cdir,gh4_pq$len,gh4_g$len,gh4_eyesmode,gh4_cage_cntr,gh4_exit_cage_flg
                    move_ghosts_part3   gh4_pr_cntr,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_pr
                                                            ; SetGH_XY gh4_eyesmode,gh4_xg,gh4_yg
                    check_cage          gh7_char,gh4_eyesmode,gh4_exit_cage_flg,gh4_DEF_PR,gh4_pr,gh4_bluetime,Const_gh7_char
                    check_btime         gh4_bluetime,gh4_btime_count,gh7_char,Const_gh7_char
                    move_ghosts_part4   gh4_cdir,gh4_pq$len,gh4_g$len
                    CageDrama           gh4_exit_cage_flg,gh4_btime_count,gh4_cage_cntr,gh4_eyesmode,gh4_pr,gh4_yg,gh4_DEF_PR
                    lda                 gh4_eyesmode
                    sta                 $407
                    lda                 gh4_bluetime
                    sta                 $40b
                    rts
mv_Ghost5
                    move_ghosts_part1   gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_xg,gh5_yg,gh5_pr
                    move_ghosts_part2   gh5_cdir,gh5_pq$len,gh5_g$len,gh5_eyesmode,gh5_cage_cntr,gh5_exit_cage_flg
                    move_ghosts_part3   gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_pr
                                                            ;SetGH_XY gh5_eyesmode,gh5_xg,gh5_yg
                    check_cage          gh8_char,gh5_eyesmode,gh5_exit_cage_flg,gh5_DEF_PR,gh5_pr,gh5_bluetime,Const_gh8_char
                    check_btime         gh5_bluetime,gh5_btime_count,gh8_char,Const_gh8_char
                    move_ghosts_part4   gh5_cdir,gh5_pq$len,gh5_g$len
                    CageDrama           gh5_exit_cage_flg,gh5_btime_count,gh5_cage_cntr,gh5_eyesmode,gh5_pr,gh5_yg,gh5_DEF_PR
                    lda                 gh5_eyesmode
                    sta                 $408
                    lda                 gh5_bluetime
                    sta                 $40c
                    rts
;============================================================
;                          Check for Walls
; This section of code checks up/down/left/right for walls
; in order to determine the direction that can be travelled in.
; it sets up a string g$ that looks something like this:
; g$="udl" - Means ghost can move up/down/left
; it aslo sets up pr direction that ghost can move in.
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
                    wall_chk            gx,gyminus1,#4,#21,#1; Check wall directly above ghost
                    wall_chk            gx,gyplus1,#21,#4,#0; Check wall directly below ghost
                    ldy                 gx                  ; Set up
                    dey
                    sty                 gxminus1            ; gx - 1
                    ldy                 gx
                    iny
                    sty                 gxplus1             ; gx + 1
                    wall_chk            gxminus1,gy,#18,#12,#2; Check wall to left of ghost
                    wall_chk            gxplus1,gy,#12,#18,#3; Check wall to riht of ghost
                    rts
;============================================================
; scan the possible direction pac-clone can move
; if there is a match with the accumulater than
; return 'beq' otherwise return 'bne'
;
matching_dir                                                ; Check if pac-clone hits a wall_dot
                                                            ; needed for sprite mouth to stay open on hit
                    ldx                 #0
loop                cmp                 g$,x
                    beq                 ext_sub
                    inx
                    cpx                 g$len
                    bne                 loop
                    ldx                 #1                  ;These two lines are here because
                    cpx                 #2                  ;need to set the BNE flag return 'bne'
ext_sub             rts
mv_gh
                    lda                 ispacman
                    cmp                 #1
                    bne                 notpacman
                    lda                 userdirection       ;Check can pclone move in user direction
                    jsr                 matching_dir        ;
                    beq                 match               ; Match means 'yes'
                    sta                 $429                ; store direction in which wall was hit
                                                            ; Need this information for furture when
                                                            ; sprites are enabled you want pclone mouth
                                                            ; to stay open when wall hit
                    lda                 cdir                ;Check can pclone move in current dir of travel
                    jsr                 matching_dir        ;
                    beq                 match2              ;Match means 'yes'
                    rts
match               lda                 userdirection
match2              sta                 g$
                    sta                 gh1_g$
                    sta                 gh1_cdir
                    sta                 cdir
                    ldy                 #0
                    sty                 g$len
                    jmp                 ck_1
notpacman
                    peekaxy             gx,gyplus1          ;This code here will force
                    cmp                 wall_cge            ;ghost eyes to move down
                    bne                 contb               ;if directly over
                    lda                 g$eyesmode          ;the entrance to ghost cage
                    cmp                 #1                  ;
                    bne                 contb               ;make sure eyes mode is on
                    lda                 #4                  ;
                    jmp                 ck_2                ;
contb               inc                 pr_cntr
                    lda                 pr_cntr
                    cmp                 ghost_pr
                    bne                 cont5
                    lda                 #0
                    sta                 pr_cntr
                    jmp                 random
cont5
                    lda                 pq$
                    cmp                 #0
                    bne                 cont6
                    jmp                 cont7
cont6
                    lda                 pq$
                    sta                 g$
                    lda                 pq$+1
                    sta                 g$+1
                    lda                 pq$len
                    sta                 g$len
                    jmp                 random
cont7               nop
random
                    jsr                 RAND
                    sta                 gd
                    tax
                    lda                 g$,x
                    sta                 cdir
ck_1                cmp                 #21                 ; Up
                    bne                 ck_2
                    dec                 gy
                                                            ;jmp                 skip
ck_2                cmp                 #4                  ; Down
                    bne                 ck_3
                    inc                 gy
                                                            ; jmp                 skip
ck_3                cmp                 #12                 ; Left
                    bne                 ck_4
                    lda                 warp
                    cmp                 #1
                    bne                 subtox
;            jmp blah
                    lda                 #0
                    sta                 warp
                    lda                 g$,x
                    jmp                 ck_4
subtox              dec                 gx
ck_4                cmp                 #18                 ; Right
                    bne                 skip
;               jmp                 skip
;skip2          lda gh1_cdir
;               sta $40a
;blah           jmp blah
                    lda                 warp
                    cmp                 #1
                    bne                 addtogx
                    lda                 #0
                    sta                 warp
                    jmp                 skip
addtogx             inc                 gx
skip
                    ldx                 gd
                    lda                 g$,x
                    sta                 pd$
                    rts
;============================================================
;                          Draw Map
;============================================================
drawmap
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
; To add 3000 to score load X with 2 and load Acc with #3, call sub
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
check_end
                    lda                 gy
                    cmp                 #12
                    bne                 exit_sub
                    lda                 gx
                    cmp                 #18
                    beq                 sk1
                    cmp                 #21
                    beq                 check2
exit_sub            rts
sk1
                    inc                 g$cage_cntr         ;Increment this counter every time the ghost hits the left side of the cage
                    lda                 #21
                    sta                 pd$
                    lda                 #18
                    sta                 cdir
                    rts
check2
                    lda                 #21
                    sta                 pd$
                    sta                 cdir
                    sta                 g$
@bott               rts


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
                    ldx #8
def_2               ldy                 #0
                    
loop_xx             jsr                 delay               
                    dey
                    bne                 loop_xx
                    dex
                    bne def_2
                    rts

FLASH_SCREEN
                    lda #3             ; Number of flashes
                    sta COLOR_CNTR            

loop3               dec                 COLOR_CNTR          

                    lda                 #3
                    jsr                 color               
                    jsr dly
                    lda                 #0                
                    jsr                 color               
                    jsr dly
       

                    lda                 COLOR_CNTR          
                    bne                 loop3

                    rts
;----------------------------------------------------------
; From http://codebase64.org/doku.php?id=base:delay
; Delay to smooth out raster interrupts
;                                        
delay             ;// delay 84-accu cycles, 0<=accu<=65
  lsr             ;// 2 cycles akku=akku/2 carry=1 if accu was odd, 0 otherwise
  bcc waste1cycle ;// 2/3 cycles, depending on lowest bit, same operation for both
waste1cycle
  sta smod+1      ;// 4 cycles selfmodifies the argument of branch
  clc             ;// 2 cycles 
;// now we have burned 10/11 cycles.. and jumping into a nopfield 
smod
  bcc *+10        ;// 3 cycles
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
  rts            ; // 6 cycles


MAPL                BYTE                <MAP_DATA
MAPH                BYTE                >MAP_DATA
MAP_DATA
incbin              pacmap3.bin
space
                    lda                 wall_spc
                    pokeaxy             gx,gy
                    rts
SCREEN_MAP          BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $A0,$2A,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2A,$A0
                    BYTE                $A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$20,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2A,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$20,$A0
                    BYTE                $A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2D,$2D,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
                    BYTE                $20,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$20
                    BYTE                $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2A,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2A,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
