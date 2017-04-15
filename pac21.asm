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
; * 3/9 Add flashing energizers
; * 3/15 Animate Ghost death and fix related problems
; * 3/19 Change dot color after certain number of ghost moves
; * 4/1/16 Implement Map transition effect
; * 4/2/16 Fix bug where ghosts refuse to enter cage (if wall
; * char is not directly above ghost cage)
; *4/22/16 Fix boost values after level 14
; * add one digit to the score
; * Fix bug if energizer is eaten last
;============================================================
;  Quick code to create auto execute program from basic
;============================================================
*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $32, $34, $35, $37, $36, $00
                    byte                $00,$00
#region Program Variables

junklskdfj          byte                $31,$31,$31
gh2_eyesmode        byte                00
gh2_bluetime        byte                00
gh2_cage_cntr       byte                00
gh2_exit_cage_flg   byte                00
gh2_xg              byte                0;39
gh2_yg              byte                0;12
gh2_gx              byte                0;18
gh2_gy              byte                0;12
gh2_pq$             byte                $00,$00
gh2_g$              byte                $00,$00,$00
gh2_pd$             byte                0;21
gh2_cdir            byte                0;21
gh2_pq$len          byte                00
gh2_g$len           byte                00
gh2_spctr           byte                00
gh2_sp_pos          byte                00

Cage_Xpos           byte                19
Cage_Ypos           byte                12


gh1_gy              byte                0;10
gh1_gx              byte                0;39
gh1_pq$             byte                $00,$00
gh1_pq$len          byte                00
gh1_g$              byte                $00,$00,$00
gh1_g$len           byte                00
gh1_xg              byte                0; 39
gh1_yg              byte                0; 12
gh1_pr              byte                00
gh1_pr_cntr         byte                0
gh1_spctr           byte                00
gh1_pd$             byte                0
gh1_cdir            byte                0;4
gh1_bluetime        byte                00
gh1_eyesmode        byte                00
gh1_cage_cntr       byte                00
gh1_exit_cage_flg   byte                00
gh1_sp_pos          byte                00

gxminus1            byte                00
gxplus1             byte                00
gyminus1            byte                00
gyplus1             byte                00
gx                  byte                0
gy                  byte                00
pq$                 byte                $00,$00
pq$len              byte                00
g$                  byte                $00,$00,$00
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

map_off_l           byte                $00,$28,$50,$78,$A0,$C8,$F0,$18,$40,$68,$90,$b8,$E0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0
map_off_h           byte                $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07

wall_dot            byte                46  ; period '.'
wall_spc            byte                32  ; space ' '
wall3__nrgzr        byte                42  ; asterisk '*'
pac_char            byte                48  ; Pac-Clone char
wall_cge            byte                45  ; '-' this is the cage minus char

;*****************************************************
gh3_gx              byte                0;32
gh3_gy              byte                0;4
gh3_pq$             byte                $00,$00
gh3_g$              byte                $00,$00,$00
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

gh4_gx              byte                0;32
gh4_gy              byte                0;14
gh4_pq$             byte                $00,$00
gh4_g$              byte                $00,$00,$00
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

gh5_gx              byte                32
gh5_gy              byte                14
gh5_pq$             byte                $00,$00
gh5_g$              byte                $00,$00,$00
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

ispacman            byte                00
userdirection       byte                00

SCORE_PARAM1        byte                00
SCORE_PARAM2        byte                00
SCORE_POS           = $410                                  ; Position of First 0 in score from left

SCORE_COLOR         = $d810
SAVED_SCORE         byte                0,0,0,0,0,0,0

GHOSTS_EATEN        byte                00                  ; Count Number of ghosts eaten per blue time
COLOR_CNTR          byte                15                  ; Number of screen flashes between levels
PACS_AVAIL          byte                5
DEATH_FLAG          byte                00                   ; 1 if pac be dead
DOTS_EATEN          byte                00
TOTAL_DOTS_FLAG     byte                0                    ; Needed since more than 255 dots on map
TOTAL_GH_FLAG       byte                0                                   ; Count how many moves 1 ghost has made
TOTAL_GH_MOVES      byte                0
DOT_POINTS          byte                01
DOT_DEC             byte                05

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



curr_sprite         byte                00

sprxmap             byte                $00,$02,$04,$06,$08
sprmap2             byte                %00000001,%00000010,%00000100,%00001000,%00010000

sp_gh_dir           byte                $8c,$8d,$8e,$8f  ; ghosts up down left right
sp_eye_dir          byte                $92,$93,$90,$91  ; ghost eyes up down left right
sprcolor            byte                $1, $0a, $3, $2
sprite_counter      byte                00
close_mouth         byte                00                   ; Need mouth closed after level completion and right before play begins
spreyecolor         byte                $1,$1,$1,$1,14
Const_UP            byte                $57                  ;Currently matching
Const_DOWN          byte                $5a                  ;Getch return values
Const_LEFT          byte                $41                  ;for up down left right
Const_RIGHT         byte                $53
;*****************************************************
; Level Defaults
; First byte is level 1, second level 2, etc.
;*****************************************************

Const_TOTAL_DOTS    byte                83,48,53,49,89                     ; Total number of dots on each map
Map_ColorL          byte                <Map1color,<Map2color,<Map3color,<Map4color
Map_ColorH          byte                >Map1color,>Map2color,>Map3color,>Map4color

;** defautl ghosts bluetime duration **
Const_gh2_bt_DEF    byte                160,80,60,60,60,50,40,35,30,25,20,15,10,05         ; Blue time Reset counter 1
Const_gh3_bt_DEF    byte                160,80,60,60,60,50,40,35,30,25,20,15,10,05         ; Blue time Reset counter 2
Const_gh4_bt_DEF    byte                160,80,60,60,60,50,40,35,30,25,20,15,10,05         ; Blue time Reset counter 3
Const_gh5_bt_DEF    byte                160,80,60,60,60,50,40,35,30,25,20,15,10,05         ; Blue time Reset counter 4
;** FLash ghosts length of time **
Const_gh2_bt_DEF2   byte                30,30,15,15,15,10,10,10,10,10,09,08,04,01         ; Blue time counter 1
Const_gh3_bt_DEF2   byte                60,60,15,15,15,12,12,12,12,12,10,08,05,01         ; Blue time counter 2
Const_gh4_bt_DEF2   byte                60,60,15,15,15,12,12,12,12,12,10,08,05,01         ; Blue time counter 3
Const_gh5_bt_DEF2   byte                60,60,15,15,15,12,12,12,12,12,10,08,05,01         ; Blue time counter
                    
Const_gh2_DEF_PR    byte                40,30,30,28,10,09,02,07,06,05,04,01,02,05         ; Priorities, give a break at high level
Const_gh3_DEF_PR    byte                40,10,30,25,10,09,08,07,06,05,40,01,05,05         ;
Const_gh4_DEF_PR    byte                10,30,20,10,03,09,08,02,06,12,04,01,04,05         ;
Const_gh5_DEF_PR    byte                40,30,12,26,10,02,08,07,02,05,04,01,03,05

gh1_sp_boost_goal   byte                09,07,06,06,06,05,05,05,04,04,04,03,02,01
gh2_sp_boost_goal   byte                08,08,07,07,07,06,06,06,05,05,05,04,03,01
gh3_sp_boost_goal   byte                07,10,05,09,09,07,04,07,05,06,06,04,03,02
gh4_sp_boost_goal   byte                06,06,09,09,05,07,07,04,03,03,06,04,03,01
gh5_sp_boost_goal   byte                09,10,09,09,09,04,07,07,06,06,03,04,03,02
MAP_INDEX           byte                00                                  ; Game Level defaults to 0, after calling RESET_LEVEL
SCREENS_CLEARED     byte                00
MAX_MAP_LEVELS      =14                                                     ; Maximum number of maps available
EnergizerColor      byte                01,01,02,02,02,01,01,01,07,07,07,01,01,01 ; Energizer color for each game map
MAP_BG_COLOR        byte                12,12,12,12,12,06,06,06,12,12,12,00,00,04 ; Middle BG color
MAP_BD_COLOR        byte                11,11,02,02,02,03,03,03,00,00,00,11,11,11 ; Border color
GAME_SPEED          byte                44,43,42,41,40,39,38,36,34,32,30,28,25,25                    
SCORE_COLOR_MAP     byte                00,00,00,00,00,01,01,01,00,00,00,01,01,01
ACTUAL_MAP_LEVELS   byte                00,00,01,01,01,02,02,02,03,03,03,00,01,02 ; Play map 0 two times, map 1 three times, etc
;Positions of all energizers on all maps
                                                            ; byte                $39,$39,$39,$39
ENG1=               $d851  ; These four energizers 
ENG2=               $db71  ; are in the same positions
ENG3=               $d876  ; on all maps
ENG4=               $db96  ;
MAP1ENG5 =          $d92b  ; The fifth energizer moves
MAP2ENG5 =          $d9EE  ; around on the different 
MAP3ENG5 =          $d8f5  ; maps
MAP4ENG5 =          $d8c0  ;

Energizer1Hi        byte                >ENG1,>ENG1,>ENG1,>ENG1,>ENG1,>ENG1,>ENG1,>ENG1
Energizer1Lo        byte                <ENG1,<ENG1,<ENG1,<ENG1,<ENG1,<ENG1,<ENG1,<ENG1
Energizer2Hi        byte                >ENG2,>ENG2,>ENG2,>ENG2,>ENG2,>ENG2,>ENG2,>ENG2
Energizer2Lo        byte                <ENG2,<ENG2,<ENG2,<ENG2,<ENG2,<ENG2,<ENG2,<ENG2
Energizer3Hi        byte                >ENG3,>ENG3,>ENG3,>ENG3,>ENG3,>ENG3,>ENG3,>ENG3
Energizer3Lo        byte                <ENG3,<ENG3,<ENG3,<ENG3,<ENG3,<ENG3,<ENG3,<ENG3
Energizer4Hi        byte                >ENG4,>ENG4,>ENG4,>ENG4,>ENG4,>ENG4,>ENG4,>ENG4
Energizer4Lo        byte                <ENG4,<ENG4,<ENG4,<ENG4,<ENG4,<ENG4,<ENG4,<ENG4
Energizer5Hi        byte                >MAP1ENG5,>MAP2ENG5,>MAP3ENG5,>MAP4ENG5,$d9,$d9,$d9,$d9
Energizer5Lo        byte                <MAP1ENG5,<MAP2ENG5,<MAP3ENG5,<MAP4ENG5,$2b,$2b,$2b,$2b

PACMAPL             byte                <MAP1_DATA,<MAP2_DATA ,<MAP3_DATA ,<MAP4_DATA
PACMAPH             byte                >MAP1_DATA,>MAP2_DATA ,>MAP3_DATA ,>MAP4_DATA

;MAP1Part2           = MAP1_DATA+256     ; strickly used     - Second Part of map1 screen memory
;Map1Part3           = MAP1_DATA+512     ; for drawmap       - Third Part of map1 screen memory
;Map1Part4           = MAP1_DATA+768     ; routine           - Forth Part of map1 screen memory
;Map1ColPart2        = MAP1color+256     ;                   - Second part of map1 color memory
;Map1ColPart3        = MAP1color+512     ;                   - Third part of map1 color memory
;Map1ColPart4        = MAP1color+768     ;                   - Forth part of map1 color memory


MAP2_DATA           = MAP1_DATA+1000                        ; Address of second game map
MAP3_DATA           = MAP1_DATA+2000                        ; Address of third game map
MAP4_DATA           = MAP1_DATA+3000                        ; Address of forth game map
Map2color           = map1color+1000                        ; Address of second map color data
Map3color           = map1color+2000                        ; Address of third map color data
Map4color           = map1color+3000                        ; Address of forth map color data
#endregion
#Region Macro Subs Located here
;*****************************************************
; Grab value of screen position located at x,y
; Store result in accumulator
;*****************************************************
defm                peekaxy
                    ldx                 /2                  ; X value
                    ldy                 /1                  ; Y Value
                    lda                 map_off_l,x         ; Load map low byte into $fb
                    sta                 $fb                 
                    lda                 map_off_h,x         ; Load map hig byte into $fc
                    sta                 $fc                 
                    lda                 ($fb),y             ; Load result into acc
                    endm
;*****************************************************
; Store value of accumulator in screen memory at position
; x, y
;*****************************************************
defm                pokeaxy
                    pha
                    ldx                 /2                  ; X value
                    ldy                 /1                  ; Y value
                    lda                 map_off_l,x         ; Load map low byte into $fb
                    sta                 $fb                 
                    lda                 map_off_h,x         ; Load map high byte into $fc
                    sta                 $fc                 
                    pla
                    sta                 ($fb),y             ; Store result in screen memory
                    endm                                    ; at pos x,y
;*****************************************************
; This macro checks the character at position x,y
; to see if it matches a wall or not.
;wall_chk            gx,gyminus1,Const_DOWN,Const_UP,#1
;*****************************************************
defm                wall_chk
                    ldx                 /2                  ; I realize these next 7 lines
                    ldy                 /1                  ; are my peekaxy macro
                                                            ;sty                 $41a
                    cpx                 Cage_Ypos           
                    bne                 @skip1              
                    cpy                 #0                  
                    beq                 @notwall            
                    cpy                 #40                 
                    beq                 @notwall            
@skip1              lda                 map_off_l,x         ; but CBM Prg Studio cannot
                    sta                 $fb                 ; nest the macro calls
                    lda                 map_off_h,x         
                    sta                 $fc                 
                    lda                 ($fb),y             
                    cmp                 wall_dot            ; Is it a dot?
                    beq                 @notwall            
                    cmp                 wall_spc            ; Is it a space?
                    beq                 @notwall            
                    cmp                 wall3__nrgzr        ; Is it an engerizer pill?
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
; move_ghosts_part1    gh1_pr_cntr, gh1_pq$, gh1_pd$, gh1_g$, gh1_gx, gh1_gy, gh1_xg, gh1_yg, gh1_pr,gh1_cdir, gh1_pq$len, gh1_g$len, gh1_eyesmode, gh1_cage_cntr, gh1_exit_cage_flg,SpriteIndex
; move_ghosts_part1    gh2_pr_cntr, gh2_pq$, gh2_pd$, gh2_g$, gh2_gx, gh2_gy, gh2_xg, gh2_yg, gh2_pr,gh2_cdir, gh2_pq$len, gh2_g$len, gh2_eyesmode, gh2_cage_cntr, gh2_exit_cage_flg,#01
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
                    lda                 /10                 
                    sta                 cdir                
                    lda                 /11                 
                    sta                 pq$len              
                    lda                 /12                 
                    sta                 g$len               
                    lda                 /13                 
                    sta                 g$eyesmode          
                    lda                 /14                 
                    sta                 g$cage_cntr         
                    lda                 /15                 
                    sta                 g$exit_cage_flg     
                    lda                 /16                 
                    sta                 curr_sprite         

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
                    lda                 gx                  
                    sta                 /5                  
                    lda                 gy                  
                    sta                 /6                  
                    lda                 ghost_pr            
                    sta                 /9                  

                    lda                 cdir                
                    sta                 /10                 
                    lda                 pq$len              
                    sta                 /11                 
                    lda                 g$len               
                    sta                 /12                 
                    endm
;*****************************************************
; Turn on Bluetime in event energizer or power pill
; is eaten.  That is determined prior to this macro call
; Usage:
; turn_on_btime       gh2_bluetime, gh2_eyesmode, Const_gh2_bt_DEF, gh2_bt_count, SpriteIndex,gh2_flashon
;*****************************************************
defm                turn_on_btime
                    lda                 /2                  ; Is eyesmode on?
                    cmp                 #1                  ; if so skip to bottom
                    beq                 @bottom             
                    lda                 #1                  ; Turn on
                    sta                 /1                  ; blue time
                                                            ;                                                            ;
                    ldx                 MAP_INDEX     ;
                    lda                 /3,x                ; Set Default Blue time
                    sta                 /4                  ; For current game level

                    lda                 #0                  
                    sta                 /6                  
                    sta                 flash_on            
                    sta                 flash_counter       
                    sta                 flash_counter2      
                    sta                 flash_white_blue    
                    ldy                 /5                  
                    ldx                 #4                  
                    jsr                 set_eye_color       
@bottom
                    endm
;*****************************************************
; Check if blue time is on
; and count how long it is on
;Usage:
;check_btime         gh2_bluetime, gh2_bt_count, Const_gh2_bt_DEF, Const_gh2_bt_DEF2, SpriteIndex,gh2_flashon
;*****************************************************
defm                check_btime
                    lda                 /1                  
                    cmp                 #1                  ; Is blue time on ?
                    bne                 @quit               ; No
                    ldx                MAP_INDEX          
                    dec                 /2                  ; Decrease blue time Counter
                    lda                 /2                  
                    cmp                 /4,x                ; Fewer moves of blue time left
                    bne                 @ck_zero            ; if so then change ghost
                    lda                 #1                  ; Turn on Flash
                    sta                 /6                  

                    jmp                 @quit               
@ck_zero            cmp                 #0                  ; no more blue time left?
                    bne                 @quit               ; None left then quit
                    ldx                 MAP_INDEX          
                    lda                 /3,x                ; reset the blue time
                    sta                 /2                  ; counter,
                    lda                 #0                  
                    sta                 /1                  ; turn off blue time
                                                            ;lda                 #0                  ; Turn off flash
                    sta                 /6                  
                                                            ; jsr                 Spr_ghostcolor
                    ldy                 /5                  
                    jsr                 set_gh_color2       
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
;Collision          spritex, spritey, gh2_bluetime, gh2_eyesmode, gh2_xg, gh2_yg, gh2_pr, gh2_pr_cntr, spriteindex,SpriteBitpos
;*************************************************************
temp_val            byte                00
defm                Collision

                    lda                 /1                  ;
                    cmp                 $d000               ; Does Ghost X = Pac X  ?
                    bne                 @botabc             ; NO
                    lda                 /2                  
                    cmp                 $d001               ; Does Ghost Y = Pac Y ?
                    bne                 @botabc             ; No

                                                            ; Check if pac is on same side of map as ghost
                    lda                 $d010               ; test bit 1 against spritebitpos should be the same
                    and                 #%00000001          ; Test first bit - Pac on right side?
                    sta                 temp_val            ;
                    sta                 $408                
                    lda                 $d010               ;
                    and                 /10                 ; Check ghost bit - ghost on right side?
                    sta                 $409                
                    cmp                 #0                  ;
                    beq                 @_ha                ;
                    lda                 #1                  ;
@_ha                cmp                 temp_val        ;
                    bne                 @botabc             ;
                                                            ;lda                 #$39
                                                            ;sta $407

                    lda                 /3                  ; Blue time on?
                    cmp                 #1                  ;
                    beq                 @eat_ghost          ; Yes
                    lda                 /4                  ; Eyes should not kill pac-clone
                    cmp                 #1                  
                    beq                 @botabc             
                    lda                 #1                  ; Pac-Clone dead now
                    sta                 DEATH_FLAG          
@botabc             jmp                 @bottom

@eat_ghost
                    ;lda                 /9                  
                    ldx                 #4                  ;
                    LDA                 /10          ; Turn off pac during ready text printing
                    eor                 $d010               
                    sta                 $d010               

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
                    jsr                 IncreaseScore       
                    ldx #$9f                                ; Display 100 point sprite                
                    jsr                 display_bonus

                    jmp                 @Score              
@BONUS2             lda                 #2                  ; 200 points
                    jsr                 IncreaseScore  
                    ldx #$a0                                ; Display 200 point sprite                
                    jsr                 display_bonus

                    jmp                 @Score              
@BONUS3             lda                 #4                  ; 400 points
                    jsr                 IncreaseScore       
                    ldx #$a1                                ; Display 400 point sprite                
                    jsr                 display_bonus

                    jmp                 @Score              
@BONUS4             lda                 #8                  ; 800 points
                    jsr                 IncreaseScore       
                    ldx #$a2                                ; Display 800 point sprite                
                    jsr                 display_bonus

                    ;jmp                 @Score              
@Score              
                    LDA                 /10          ; Turn off pac during ready text printing
                    eor                 $d010               
                    sta                 $d010               

                    lda                 #0                  ; Turn off bluetime
                    sta                 /3                  
                    lda                 #1                  ; Toggle Eyesmode
                    sta                 /4                  ;
                    sta                 g$eyesmode          

                    ldy                 /9                  
                    ldx                 /9                  
                    jsr                 Pick_Ghost_spr      


                    ldy                 /9                  
                    ldx                 /9                  
                    lda                 #0                  
                    sta                 gh2_flashon,y       

                    jsr                 set_eye_color       
                    lda                 Cage_Xpos           ; Load New Dest X and
                    sta                 /5                  
                    lda                 Cage_Ypos           ; Dest Y values for ghost cage
                    sta                 /6                  
                    lda                 #1                  ;HIGH_PR             ;Change priority of eyes to always move towards priority
                   ; LDX                 MAP_INDEX          
                    sta                 /7                  
                    sta                 ghost_pr            
                    lda                 #0                  
                    sta                 /8                  ;Reset the Priority Counter to zero


@bottom             nop
                    endm

display_bonus
                    lda                 #1                                      
                    sta                 gobble_on           
                    sei
                    
                                     
                    stx                 $7f8                                    
                    jsr new_delay
                    lda                 #0
                    sta                 gobble_on                               
                    cli
                    rts


new_delay
                    ldx #$80
                    jsr dly7
                    rts
set_Nrgize_color
                    Energizer           Energizer1Lo,Energizer1Hi
                    Energizer           Energizer2Lo,Energizer2Hi
                    Energizer           Energizer3Lo,Energizer3Hi
                    Energizer           Energizer4Lo,Energizer4Hi
                    Energizer           Energizer5Lo,Energizer5Hi
                    rts

defm                Energizer
                    
                    ;ACTUAL_MAP_LEVELS
                    ldy                 MAP_INDEX           
                    ;tay
                    lda ACTUAL_MAP_LEVELS,y
                    tay                                    ;sty $400
                    lda                 /1,y                
                    sta                 $fd                 
                    lda                 /2,y                
                    sta                 $fe                 

                    ldy                 #0                  
                    txa
                    sta                 ($fd),y             
@end
                    endm

set_eye_color
                    lda                 #$28                ; Ghost
                    sta                 $fb                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fc                 ;
                    lda                 spreyecolor,x       
                    sta                 ($fb),y             
                    rts

set_gh_color2
                    lda                 #$d0                ;
                    sta                 $fc                 
                    lda                 #$28                
                    sta                 $fb                 
                    lda                 sprcolor,y          
                    sta                 ($fb),y             
                    rts

Spr_ghostcolor
                    lda                 #$28                ; Ghost
                    sta                 $fb                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fc                 ;

                    ldy                 #4                  
color_lp            dey
                    lda                 sprcolor,y          
                    sta                 ($fb),y             ;
                    cpy                 #0                  
                    bne                 color_lp            
                    rts

set_flash_color
                    lda                 #$28                ; Ghost
                    sta                 $fb                 ; Sprite
                    lda                 #$d0                ; color
                    sta                 $fc                 ;


                    lda                 flash_white_blue    

                    cmp                 #1                  
                    beq                 _blue               
                    lda                 #0                  
                    sta                 flash_white_blue    
                    lda                 #1                  
                    jmp                 _white              
_blue               lda                 #14
_white              sta                 ($fb),y
                    rts
flash_white_blue    byte                00

;*****************************************************
;* Check to see if ghost is entering /exiting cage
;* If exiting then turn off eyes mode and change ghost char
;* And reset ghost priority
; usage:
;check_cage         gh2_eyesmode, gh2_exit_cage_flg, Const_gh2_DEF_PR, gh2_pr,gh2_bluetime,SpriteIndex
;*****************************************************
defm                check_cage
                    lda                 /1                  ; Eyes mode enabled?
                    cmp                 #0                  
                    beq                 @exit               ; If not exit
                    lda                 /5                  ; Bluetime enabled?
                    cmp                 #1                  ; If so exit
                    beq                 @exit               
                    lda                 gy                  
                    cmp                 Cage_Ypos           ; Is ghost in right vert position with cage
                    bne                 @exit               ; No? then exit
                    lda                 gx                  
                    cmp                 Cage_Xpos           ; Is ghost in right Horiz position with cage
                    bne                 @exit               ; No? then exit
                    lda                 #$0                 ; entering or exiting cage then reset flag
                    sta                 /2                  ; Reset the cage exit flag to 0
                    lda                 #0                  ; Ghost back in cage turn off eyes mode
                    sta                 /1                  
                    ldy                 /6                  
                    ldx                 /6                  
                    lda                 #0                  
                    sta                 g$eyesmode          
                    jsr                 Pick_Ghost_spr      
                    ldy                 /6                  
                    jsr                 set_gh_color2       
                                                            ;****fix - ghosts leaving cage had bad priority
                                                            ; Reset ghost priority when entering cage
                    ldx                 MAP_INDEX          
                    lda                 /3,x                
                    sta                 /4                  
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
                    ldx                 MAP_INDEX          
                    lda                 /8,x                
                    sta                 /2                  
                    lda                 #0                  ; Turn off Eyes mode
                    sta                 /4                  
                    lda                 #1                  
                    sta                 /6                  ; change the yg value so caged ghost will escape upwards
                    sta                 yg                  
                    ldx                 MAP_INDEX          
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

;gh1_sp_boost_goal 09,07,06,06,06,05,05,05,04,04,04,03,02,01
                    lda                 #4                  
                    sta                 gh1_sp_boost_goal+8 ; Reset these values because they are changed after level 14
                    sta                 gh1_sp_boost_goal+9
                    sta                 gh1_sp_boost_goal+10 
                    lda                 #3                  
                    sta                 gh1_sp_boost_goal+11
                    lda                 #2                  
                    sta                 gh1_sp_boost_goal+12
                    lda                 #1                  
                    sta                 gh1_sp_boost_goal+13


                    lda                 #4                  
                    sta                 53280               
                    lda                 #$93                ; shift clear dec 147
                    jsr                 $FFD2               ; clear screen
                    jsr                 Init_Random         
                    ;drawmap MAP1_DATA,MAP1_DATA+256,MAP1_DATA+512,MAP1_DATA+768,MAP1_DATA+1024
                   jsr Pick_Map_to_Draw
                        lda #0
                    sta $405
                    sta $406

                    jsr                 Set_Interrupt       
                    jsr                 Prep_Level_One      ; Reset the Game Level and set score to zero
                    ;sei 
                   ; lda                 #$8a                
                   ; sta                 $7f8                
                    
                  ;  rts
main_prg_lp
                    lda                 DEATH_FLAG          
                                                            ;cmp #0
                    beq                 _alive              ; Yes Pacs alive
                    jsr                 HE_DEAD             ; Nooo say it aint so...
_alive

sk_385

;**** MOVE GHOSTS *****

                    Jsr                 Move_ALL_Sprites    
                    jmp                 main_prg_lp         
get_key
getch

                    jsr                 $ffe4               ; Input a key from the keyboard

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
                                                            ; jsr                Energize            ; Turn on blue time - cheat!
                    jsr                 _levelup            
                    rts
;                    sei                                     ; disable interrupts
;                    lda                 #<done_with_int           ; get low byte of target routine
;                    sta                 788                 ; put into interrupt vector
;                    lda                 #>done_with_int          ; do the same with the high byte
;                    sta                 789
;                    cli                                     ; re-enable interrupts
;                    rts
NO_Key_Pressed
Move_that_Dir       cmp                 #0
                    beq                 _rts                
                    sta                 userdirection     
;                    cmp                 Const_Left
;                    beq _skpleft
;                    ldx spr_right_low
;                    jmp _skpright
;_skpleft            ldx                 spr_left_low          ; Start out pac sprite facing up 
;_skpright           stx                 int_spr_low         
;                    stx                 int_sprite          
;                    inx
;                    inx
;                    inx
;                    stx                 int_spr_high        
;                    stx                 $7f8                

;  

_rts                rts
                    
Pick_Map_to_Draw
                    
                    
                    ldy                 MAP_INDEX 
                    lda ACTUAL_MAP_LEVELS,y
                    cmp                 #0                  
                    beq                 _draw_map1
                    cmp                 #1                  
                    beq                 _draw_mapaa         
                    
                    cmp                 #2                  
                    beq                 _draw_mapab
                    drawmap_prep        MAP4_DATA,Map4color          
                    jmp                 _done1              
_draw_mapaa         jmp _draw_map2
_draw_mapab         jmp _draw_map3                    
_draw_map1          drawmap_prep        MAP1_DATA,Map1color           
                    jmp                 _done1                       
_draw_map2          drawmap_prep        MAP2_DATA,Map2color
                    jmp                 _done1                                           
_draw_map3          drawmap_prep        MAP3_DATA,Map3color 
_done1              jsr                 drawmap             
                    rts
;*****************************************************
; Check Left side for non pac ghosts only
;*****************************************************
ck_leftside
                    check_sides         Const_Left,#$FF,#39,#11*8
;*****************************************************
; Check right side for non pac ghosts only
;*****************************************************
ck_rightside
                    check_sides         Const_Right,#40,#00,#08*2

defm                check_sides
                    lda                 cdir                
                    cmp                 /1                  ; Checking Left or right side?
                    bne                 @the_end            
                    lda                 gy                  
                    cmp                 Cage_Ypos           
                    bne                 @the_end            
                    lda                 gx                  
                    cmp                 /2                  ; Check for edge
                    beq                 @wp                 
                    jmp                 @the_end            
@wp                 lda                 /3                 ; Set gx to Opposite side of map
                    sta                 gx                  

                    ldy                 curr_sprite         ;
                    lda                 #$d0                ; Warp Sprite
                    sta                 $fc                 ;
                    lda                 sprxmap,y           ;
                    sta                 $fb                 ;
                    lda                 $d010               
                    eor                 sprmap2,y           ; Toggle sprite past 255 flag
                    sta                 $d010               
                    lda                 /4                  ; Set Sprite X to opposite side of map
                    ldy                 #0                  
                    sta                 ($fb),y             ;
@the_end            rts
endm

scan_dots
pacs_alive          peekaxy             gh1_gx,gh1_gy       ; Did Pac-Clone just eat
                    cmp                 wall3__nrgzr        ; the energizer?
                    beq                 Energize            ; NO, then skip
                    cmp                 wall_dot            
                    bne                 _done_scan          

                    lda                 DOT_POINTS          ; 10 points
                    ldx                 DOT_DEC             ; 4th decimal pos
                    jsr                 IncreaseScore       ; Give me points


                    jsr                 EAT_DOTS            ; Eat dots

                    LDA                 #10                 
                    STA                 SB                  
                    jsr                 dly4                
                    LDA                 #0                  
                    STA                 SB                  

                    rts
Energize            lda                 #1                  ; 100 points
                    ldx                 #4                  ; 4th decimal pos
                    jsr                 IncreaseScore       ; Increase score
                    jsr                 EAT_DOTS            ; Eat dots

                    lda                 DOTS_EATEN          ; These three lines fix bug where     
                    cmp                 #0                  ; energizer carries over to
                    beq                 _done_scan          ; next level when eaten last
                    
                    lda                 #0                  ; Reset the ghosts Eaten Counter
                    sta                 GHOSTS_EATEN        ; Used for score purposes
                    jsr                 BLUE_TIME           
_done_scan          rts

#region MAIN PROGRAM SUBS



Move_ALL_Sprites
_top                inc                 sprite_counter      ; Keep track of each sprite moving 8 pixels at a time

                    jsr                 Boost_Algorithm     
_Normal_Flow

                    jsr                 Move_Sprite1        
                    jsr                 delay_5                
                    jsr                 Move_Sprite2        
                    jsr                 delay_5
                    jsr                 Move_Sprite3        
                    jsr                 delay_5              
                    jsr                 Move_Sprite4        
                    jsr                 delay_5                
                    jsr                 Move_Sprite5        
                    jsr                 delay_5                
                    lda                 DEATH_FLAG          ;If dead, dont continue moving sprites
                    cmp                 #1                  
                    bne                 _cont1              
                    rts
_cont1              jsr                 get_key
                    lda                 sprite_counter      
                    cmp                 #8                  
                    bne                 _back_to_top        
                    lda                 #0                  
                    sta                 sprite_counter      
                    rts
_back_to_top        jmp                 _top
Move_Sprite1
                    

                                                            ;jsr                 Collisions
                    Move_Sprite         gh1_cdir,gh1_pd$,gh1_spctr,$d000,$d001,#%00000001,gh1_sp_pos
                                                            ;jsr                 Collisions
                    rts
Move_Sprite2
                                                            ;jsr                 Collisions
                    Move_Sprite         gh2_cdir,gh2_pd$,gh2_spctr,$d002,$d003,#%00000010,gh2_sp_pos
                                                            ;jsr                 Collisions
                    rts
Move_Sprite3
                                                            ;jsr                 Collisions
                    Move_Sprite         gh3_cdir,gh3_pd$,gh3_spctr,$d004,$d005,#%00000100,gh3_sp_pos
                                                            ;jsr                 Collisions
                    rts
Move_Sprite4
                                                            ;jsr                 Collisions
                    Move_Sprite         gh4_cdir,gh4_pd$,gh4_spctr,$d006,$d007,#%00001000,gh4_sp_pos
                                                            ;jsr                 Collisions
                    rts
Move_Sprite5
                                                            ;jsr                 Collisions
                    Move_Sprite         gh5_cdir,gh5_pd$,gh5_spctr,$d008,$d009,#%00010000,gh5_sp_pos
                                                            ;jsr                 Collisions
                    rts

;*************************************************************
; Each sprite has a counter, once a certain number is reached
; give the ghost a boost in speed, this value is determined
; by the current level played.
;*************************************************************
Boost_Algorithm
                    lda                 gh1_sp_pos          
                    LDY                 MAP_INDEX          
                    cmp                 gh1_sp_boost_goal,y 
                    bne                 _check2             
                   ; jsr                 Move_Sprite1        
                    jsr                 Move_Sprite1        
                    lda                 #0                  
                    sta                 gh1_sp_pos          

_check2
                    lda                 gh2_eyesmode        
                    cmp                 #1                  
                    beq                 _fasteyes1          
                    lda                 gh2_sp_pos          
                    LDY                 MAP_INDEX          
                    cmp                 gh2_sp_boost_goal,y 
                    bcc                 _check3             

                    jsr                 Move_Sprite2        
                                                            ;jsr                 Move_Sprite2
                                                            ;jsr                 Move_Sprite2
                    jmp                 _reset1             

_fasteyes1                                                  ;jsr                 Move_Sprite2
                    jsr                 Move_Sprite2        

_reset1             lda                 #0
                    sta                 gh2_sp_pos          

_check3             lda                 gh3_eyesmode
                    cmp                 #1                  
                    beq                 _fasteyes2          

                    lda                 gh3_sp_pos          
                    LDY                 MAP_INDEX          
                    cmp                 gh3_sp_boost_goal,y 
                    bcc                 _check4             
                    jsr                 Move_Sprite3        
                    jmp                 _reset2             
_fasteyes2          jsr                 Move_Sprite3
                    jsr                 Move_Sprite3        

_reset2             lda                 #0
                    sta                 gh3_sp_pos          

_check4             lda                 gh4_eyesmode
                    cmp                 #1                  
                    beq                 _fasteyes3          

                    lda                 gh4_sp_pos          
                    LDY                 MAP_INDEX          
                    cmp                 gh4_sp_boost_goal,y 
                    bcc                 _check5             
                    jsr                 Move_Sprite4        
                    jmp                 _reset3             
_fasteyes3          jsr                 Move_Sprite4
                    jsr                 Move_Sprite4        

_reset3             lda                 #0
                    sta                 gh4_sp_pos          
_check5             lda                 gh5_eyesmode
                    cmp                 #1                  
                    beq                 _fasteyes4          

                    lda                 gh5_sp_pos          
                    cmp                 gh5_sp_boost_goal   
                    bcc                 _done               

                    jsr                 Move_Sprite5        
                    jmp                 _reset4             
_fasteyes4          jsr                 Move_Sprite5
                    jsr                 Move_Sprite5        
_reset4             lda                 #0
                    sta                 gh5_sp_pos          
_done               rts
;*************************************************************

;*************************************************************
; Turn on blue time for all 4 ghosts
; Unless eyes mode is activated
;*************************************************************
BLUE_TIME
                    turn_on_btime       gh2_bluetime,gh2_eyesmode,Const_gh2_bt_DEF,gh2_bt_count,#0,gh2_flashon; Turn on blue time
                    turn_on_btime       gh3_bluetime,gh3_eyesmode,Const_gh3_bt_DEF,gh3_bt_count,#1,gh3_flashon; want to turn it on
                    turn_on_btime       gh4_bluetime,gh4_eyesmode,Const_gh4_bt_DEF,gh4_bt_count,#2,gh4_flashon; unless eyemode
                    turn_on_btime       gh5_bluetime,gh5_eyesmode,Const_gh5_bt_DEF,gh5_bt_count,#3,gh5_flashon; is activated
                    rts
;*************************************************************
; A collision occurs when a ghost runs into pac-clone
; One of two things should happen
;
; 1) Bluetime is enabled
; 2) Pac-Clone dies
;*************************************************************

Collisions
                    Collision           $d002,$d003,gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg,gh2_pr,gh2_pr_cntr,#0,#%0000010
                    Collision           $d004,$d005,gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg,gh3_pr,gh3_pr_cntr,#1,#%0000100
                    Collision           $d006,$d007,gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg,gh4_pr,gh4_pr_cntr,#2,#%0001000
                    Collision           $d008,$d009,gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg,gh5_pr,gh5_pr_cntr,#3,#%0010000
                    rts
;*************************************************************
; Move_Sprite
;Usage:
;                   Move_Sprite         gh1_cdir, gh1_pd$, gh1_spctr, $d000, $d001, #%0000001, gh1_sp_pos
;*************************************************************
defm                Move_Sprite
                    lda                 /6                  
                    cmp                 #1                  
                    bne                 @_skipfew           

                    lda                 /1                  
                    cmp                 /2                  
                    bne                 @_gh1               
                    jmp                 @_skipfew           

@_gh1
@glennx
                    lda                 #1                  
                    sta                 gobble_on 
                    lda                 #0              ; Open mouth when moving, fixes                   
                    sta                 close_mouth     ; issues where pac starts out pointing up
          
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
                    cmp                 #%0000001           ;Pac-Clone
                    beq                 @Gh1                
                    cmp                 #%0000010           ;Ghost 1
                    beq                 @Gh2                
                    cmp                 #%0000100           ;Ghost 2
                    beq                 @Gh3                
                    cmp                 #%0001000           ;Ghost 3
                    beq                 @Gh4                
                    cmp                 #%0010000           ;Ghost 4
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
                    jsr                 scan_dots           
                    jsr                 space               
                    lda                 #0                  
                    sta                 gh1_pd$             
                    move_ghosts_part1   gh1_pr_cntr,gh1_pq$,gh1_pd$,gh1_g$,gh1_gx,gh1_gy,gh1_xg,gh1_yg,gh1_pr,gh1_cdir,gh1_pq$len,gh1_g$len,gh1_eyesmode,gh1_cage_cntr,gh1_exit_cage_flg,#00
                                                            ;***********************************************
                                                            ;** Make ghosts follow Pac-CLone
                    updatexy            gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg
                    updatexy            gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg
                    updatexy            gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg
                    updatexy            gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg

                    lda                 #0                  
                    sta                 ispacman            
                    rts
mv_Ghost2
                    move_ghosts_part1   gh2_pr_cntr,gh2_pq$,gh2_pd$,gh2_g$,gh2_gx,gh2_gy,gh2_xg,gh2_yg,gh2_pr,gh2_cdir,gh2_pq$len,gh2_g$len,gh2_eyesmode,gh2_cage_cntr,gh2_exit_cage_flg,#01
                    check_cage          gh2_eyesmode,gh2_exit_cage_flg,Const_gh2_DEF_PR,gh2_pr,gh2_bluetime,#0
                    check_btime         gh2_bluetime,gh2_bt_count,Const_gh2_bt_DEF,Const_gh2_bt_DEF2,#0,gh2_flashon
                    CageDrama           gh2_exit_cage_flg,gh2_bt_count,gh2_cage_cntr,gh2_eyesmode,gh2_pr,gh2_yg,Const_gh2_DEF_PR,Const_gh3_bt_DEF
                    jsr                 Count_GH_Moves      
                    rts
mv_Ghost3
                    move_ghosts_part1   gh3_pr_cntr,gh3_pq$,gh3_pd$,gh3_g$,gh3_gx,gh3_gy,gh3_xg,gh3_yg,gh3_pr,gh3_cdir,gh3_pq$len,gh3_g$len,gh3_eyesmode,gh3_cage_cntr,gh3_exit_cage_flg,#02
                    check_cage          gh3_eyesmode,gh3_exit_cage_flg,Const_gh3_DEF_PR,gh3_pr,gh3_bluetime,#1
                    check_btime         gh3_bluetime,gh3_bt_count,Const_gh3_bt_DEF,Const_gh3_bt_DEF2,#1,gh3_flashon
                    CageDrama           gh3_exit_cage_flg,gh3_bt_count,gh3_cage_cntr,gh3_eyesmode,gh3_pr,gh3_yg,Const_gh3_DEF_PR,Const_gh3_bt_DEF

                    rts
mv_Ghost4
                    move_ghosts_part1   gh4_pr_cntr,gh4_pq$,gh4_pd$,gh4_g$,gh4_gx,gh4_gy,gh4_xg,gh4_yg,gh4_pr,gh4_cdir,gh4_pq$len,gh4_g$len,gh4_eyesmode,gh4_cage_cntr,gh4_exit_cage_flg,#03
                    check_cage          gh4_eyesmode,gh4_exit_cage_flg,Const_gh4_DEF_PR,gh4_pr,gh4_bluetime,#2
                    check_btime         gh4_bluetime,gh4_bt_count,Const_gh4_bt_DEF,Const_gh4_bt_DEF2,#2,gh4_flashon
                    CageDrama           gh4_exit_cage_flg,gh4_bt_count,gh4_cage_cntr,gh4_eyesmode,gh4_pr,gh4_yg,Const_gh4_DEF_PR,Const_gh4_bt_DEF

                    rts
mv_Ghost5
                    move_ghosts_part1   gh5_pr_cntr,gh5_pq$,gh5_pd$,gh5_g$,gh5_gx,gh5_gy,gh5_xg,gh5_yg,gh5_pr,gh5_cdir,gh5_pq$len,gh5_g$len,gh5_eyesmode,gh5_cage_cntr,gh5_exit_cage_flg,#04
                    check_cage          gh5_eyesmode,gh5_exit_cage_flg,Const_gh5_DEF_PR,gh5_pr,gh5_bluetime,#3
                    check_btime         gh5_bluetime,gh5_bt_count,Const_gh5_bt_DEF,Const_gh5_bt_DEF2,#3,gh5_flashon
                    CageDrama           gh5_exit_cage_flg,gh5_bt_count,gh5_cage_cntr,gh5_eyesmode,gh5_pr,gh5_yg,Const_gh5_DEF_PR,Const_gh5_bt_DEF

                    rts

Count_GH_Moves
                    inc                 TOTAL_GH_MOVES      
                    lda                 TOTAL_GH_MOVES      
                    cmp                 #0                  
                    bne                 _check_moves        
                    inc                 TOTAL_GH_FLAG       
_check_moves        lda                 TOTAL_GH_FLAG
                    cmp                 #1                  
                    bne                 __check2            
                    lda                 TOTAL_GH_MOVES      
                    cmp                 #200                
                    beq                 _First_col_chg      
                    rts
__check2            cmp                 #2
                    bne                 _end_count          
                    lda                 TOTAL_GH_MOVES      
                    cmp                 #100                
                    beq                 _sec_col_chg        

_end_count          rts
_First_col_chg
                    lda                 #4                  
                    sta                 SEARCH_COLOR        
                    lda                 wall_dot            
                    sta                 SEARCH_CHAR         
                    jsr                 Change_Map_Color    
                    lda                 #5                  ; 5 points
                    sta                 DOT_POINTS          
                    lda                 #6                  ; 6th decimal pos
                    sta                 DOT_DEC             
                    rts
_sec_col_chg
                    lda                 #5                  
                    sta                 SEARCH_COLOR        
                    lda                 wall_dot            
                    sta                 SEARCH_CHAR         
                    jsr                 Change_Map_Color    
                    lda                 #1                  ; 1 point
                    sta                 DOT_POINTS          
                    lda                 #6                  ; 6th decimal pos
                    sta                 DOT_DEC             

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
                    lda                 ispacman            
                    cmp                 #1                  ; Have to check if this is Pac-clone
                    bne                 notpacman           ; if so then do not pick a dir of travel
                    lda                 userdirection       ; Check can pclone move in user direction

                    jsr                 Can_Move_This_Dir?  ; Can the we travel in the selected dir?
                    beq                 match2              ;
                    lda                 cdir                ;
                    jsr                 Can_Move_This_Dir?  ;Check can pclone move in current dir of travel
                    beq                 match2              ; Match means 'yes'
                                                            ; No match mean return
                    rts
match2
                    sta                 g$                  ; Store the requested
                    sta                 cdir                ;
                    ldy                 #0                  ;
                    sty                 g$len               ;
                    tax
                    tya
                    pha
                    txa                                     ; push direction
                    jmp                 ck_1                ;
notpacman
                    lda                 g$eyesmode          ; the entrance to ghost cage
                    cmp                 #1                  ;
                    bne                 not_cage            ; make sure eyes mode is on
                    peekaxy             gx,gyplus1          ; This code here will force
                    cmp                 wall_cge            ; ghost eyes to move down
                    bne                 not_cage            ; if directly over

                    lda                 #0                  
                    pha
                    lda                 Const_DOWN          ; Load Down Value
                    sta                 cdir                ;fixes bug where sprite ghost does not move into cage
                    sta                 g$                  ;This sta fixes 2nd bug where ghost does not move into cage when no wall directly above cage entrance

                    jmp                 ck_2a               ;
;***
; Pick a direction of travel either a priority dir
; Or a random dir based on possible choices of dir
;*****************************************************
not_cage            inc                 pr_cntr             ; Increment priority counter
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
                    pha                                     ; directions of travel
                    tax                                     ; push direction
                    lda                 g$,x                ;
                    sta                 cdir                ;
;*****************************************************
ck_1
                    cmp                 Const_UP            ; UP
                    bne                 ck_2                
                    dec                 gy                  ; Decrease Y value
                    Setup_Pacdir        #0,spr_up_low,spr_down_low
                    jmp                 skip                
ck_2                cmp                 Const_DOWN          ; DOWN
                    bne                 ck_3                
ck_2a
                    inc                 gy                  ; Increase Y value
                    Setup_Pacdir        #1,spr_down_low,spr_left_low
                    jmp                 skip                

ck_3                cmp                 Const_LEFT          ; LEFT
                    bne                 ck_4                
                    dec                 gx                  ; Decrease X value
                    Setup_Pacdir        #2,spr_left_low,spr_right_low
                    jsr                 ck_leftside         
                    jmp                 skip                
ck_4                cmp                 Const_RIGHT         ; RIGHT
                    bne                 skip                
                    inc                 gx                  ; Increase X value
                    Setup_Pacdir        #3,spr_right_low,#$8c
                    jsr                 ck_rightside        
skip
                    lda                 ispacman            
                    cmp                 #0                  
                    beq                 _ntpac              
                    lda                 #0                  
                    sta                 gobble_on           
                    jsr                 Set_Sprite_Int      

                    jmp                 _duh                

_ntpac              LDX                 temp_Gh_Dir
                    jsr                 Pick_Ghost_Spr      
_duh                pla                                     ; Pull Direction down
                    tax
                    lda                 g$,x                ;
                    sta                 pd$                 
                                                            ;  jsr                 Check_Walls         ; get new g$len, g$
done                rts
temp_low            byte                00
temp_high           byte                00
temp_Gh_Dir         byte                00

; Created this macro to make program code above more readable
defm                Setup_Pacdir
                    lda                 /1                  
                    sta                 temp_Gh_Dir         
                    lda                 /2                  
                    sta                 temp_low            
                    lda                 /3                  
                    sta                 temp_high           
                    endm
Set_Sprite_Int

                    lda                 temp_low            
                    sta                 int_spr_low         
                    sta                 int_sprite          
                    lda                 temp_high           
                    sta                 int_spr_high        
                    rts
Pick_Ghost_spr
                    ldy                 curr_sprite         
                    lda                 #$07                
                    sta                 $fc                 
                    lda                 #$f8                
                    sta                 $fb                 
                    lda                 g$eyesmode          
                    cmp                 #1                  
                    beq                 _over               
                    lda                 sp_gh_dir,x         
                    jmp                 _over2              
_over               lda                 sp_eye_dir,x
_over2              sta                 ($fb),y
done_2a             rts

;MAP1Part2           = MAP1_DATA+256     ; strickly used     - Second Part of map1 screen memory
;Map1Part3           = MAP1_DATA+512     ; for drawmap       - Third Part of map1 screen memory
;Map1Part4           = MAP1_DATA+768     ; routine           - Forth Part of map1 screen memeory
;Map1ColPart2        = MAP1color+256     ;                   - Second part of map1 color memory
;Map1ColPart3        = MAP1color+512     ;                   - Third part of map1 color memory
;Map1ColPart4        = MAP1color+768     ;                   - Forth part of map1 color memory

mpart1              byte                00,00
                    
;mpart2
;mpart3
;mpart4
;cpart1
;cpart2
;cpart3
;cpart4

defm drawmap_prep   ; Pass down which map to load
                    ldy                #>/1
                    sty                 _mpart1+2           
                    iny
                    sty                 _mpart2+2
                    iny
                    sty                 _mpart3+2           
                    iny
                    sty                 _mpart4+2           
                    lda                #</1
                    sta                 _mpart1+1           
                    sta                 _mpart2+1            
                    sta                 _mpart3+1            
                    sta                 _mpart4+1                               


                    ldy                #>/2
                    sty                 _mcpart1+2           
                    iny
                    sty                 _mcpart2+2
                    iny
                    sty                 _mcpart3+2           
                    iny
                    sty                 _mcpart4+2           
                    lda                #</2
                    sta                 _mcpart1+1           
                    sta                 _mcpart2+1            
                    sta                 _mcpart3+1            
                    sta                 _mcpart4+1                               

endm
                    
drawmap
                    ldx                 MAP_INDEX           
                   ; LDA                 ACTUAL_MAP_LEVELS,x 
                   ; tax
                    lda                 MAP_BG_COLOR,x      
                    sta                 53281               
                    lda                 MAP_BD_COLOR,x      
                    sta                 53280               
                    jsr                 SAVE_SCORE          

                    ldy                 #0                  
_mpart1             lda                 $0000,y           ;Self modifying code part1
                    sta                 $400,y              
_mcpart1            lda                 $dc00,y         
                    sta                 $d800,y             
                    iny
                    bne                 _mpart1           
                                                            
_mpart2             lda                 $0000,y
                    sta                 $500,y              
_mcpart2            lda                 $dc00,y      
                    sta                 $d900,y             
                    iny
                    bne                 _mpart2           
                                                            
_mpart3             lda                 $0002,y
                    sta                 $600,y              
_mcpart3            lda                 $dc00,y      
                    sta                 $da00,y             
                    iny
                    bne                 _mpart3
;                                                            
_mpart4             lda                 $0003,y
                    sta                 $700,y              
_mcpart4            lda                 $dc00,y      
                    sta                 $db00,y             
                    iny
                    cpy                 #$e7                
                    bne                 _mpart4
                    jsr                 RESTORE_SCORE       
                    rts
SAVE_SCORE
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
                    lda                 SCORE_POS+6         
                    sta                 SAVED_SCORE+6       
                    rts

RESTORE_SCORE       lda                 SAVED_SCORE         ; Display saved score
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
                    lda                 SAVED_SCORE+6       
                    sta                 SCORE_POS+6
                    ldx                 MAP_INDEX           

                    ;ldx                 ACTUAL_MAP_LEVELS,y                     
                    lda SCORE_COLOR_MAP,x
                    sta SCORE_COLOR
                    sta SCORE_COLOR+1
                    sta SCORE_COLOR+2                  
                    sta SCORE_COLOR+3
                    sta SCORE_COLOR+4
                    sta SCORE_COLOR+5
                    sta SCORE_COLOR+6
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
; Example score: 6543210
; Loading X as 0 gives us the first digit '6'
; Loading X as 1 give us the second digit '5' and so on
; To add 500 to the score load X with #4 and load Acc with #5, call sub
; To add 3000 to score load X with #3 and load Acc with #3, call sub
; To add 10 load X with #5 and load Acc with #1
;*************************************************************
IncreaseScore
                    sta                 SCORE_PARAM1        
                    stx                 SCORE_PARAM2        
.IncreaseBy1
                    ldx                 SCORE_PARAM2        
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
                    ldx                 SCORE_PARAM2        
                    rts
.IncreaseBy1Done
                    dec                 SCORE_PARAM1        
                    bne                 .IncreaseBy1        
                    ldx                 SCORE_PARAM2        
                    rts
;*************************************************************
; Ensure ghosts inside the cage bounce back and forth
; If they hit the left side increment the cage counter
; and set the course to go right
; If they hit the right side set the course to go back left
;*************************************************************
cage_sides
                    lda                 gy                  ;
                    cmp                 Cage_Ypos           ;
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
MAP_VAR1            byte                0
MAP_VAR2            byte                0

Change_Map_Color
                    Ldx                 MAP_INDEX 
                    lda                 ACTUAL_MAP_LEVELS,x
                    tax         
                    lda                 PACMAPH,x           
                    sta                 $fc                 
                    sta                 MAP_VAR1            
                    lda                 #$d8                
                    sta                 MAP_VAR2            
                    ldx                 #4                  
main_lp1            ldy                 #$00
loop2               lda                 MAP_VAR1
                    sta                 $fc                 
                    txa
                    pha
                    ldx                 MAP_INDEX          
                    lda                 ACTUAL_MAP_LEVELS,x
                    tax         
 
                   lda                 PACMAPL,x           

                    sta                 $fb                 
                    pla
                    tax

                    lda                 ($fb),y             
                    cmp                 SEARCH_CHAR         
                    bne                 skip_aa             

                    lda                 #$00                ;Low byte of screen memory
                    sta                 $fb                 
                    lda                 MAP_VAR2            
                    sta                 $fc                 ; pla
                    lda                 SEARCH_COLOR        
                    sta                 ($fb),y             

skip_aa             dey
                    bne                 loop2               
                    inc                 MAP_VAR1            
                    inc                 MAP_VAR2            
                    dex
                    bne                 main_lp1            
                    rts

;*************************************************************
dly
                    ldx                 #8                  
def_2               ldy                 #0
loop_xx             jsr                 delay
                    dey
                    bne                 loop_xx             
                    dex
                    bne                 def_2               
                    rts

;***DELAY ***
dly4
                    nop
                    nop
def_2ab             ldx                 #50
loop_xxab           jsr                 delay
                    dex
                    cpx                 #0                  
                    bne                 loop_xxab           
                    rts
;***DELAY ***
delay_5
                    nop
                    nop
_delay_5            ldx                 #25
loop_xxabc          jsr                 delay
                    dex
                    cpx                 #0                  
                    bne                 loop_xxabc           
                    rts

;***DELAY ***
dly5
loop_xxab1          jsr                 delay
                    dex
                    cpx                 #0                  
                    bne                 loop_xxab1          
                    rts

dly7
loop_xxab12          jsr                 delay_longer
                    dex
                    cpx                 #0                  
                    bne                 loop_xxab12
                    rts

;*************************************************************
; Make the screen flash different colors after completing
; a level
;*************************************************************
SEARCH_COLOR        byte                00
SEARCH_CHAR         byte                00

FLASH_SCREEN
                    lda                 #160                
                    sta                 SEARCH_CHAR         
                    lda                 #3                  ; Number of flashes
                    sta                 COLOR_CNTR          
loop3               dec                 COLOR_CNTR
                    lda                 #3                  
                    sta                 SEARCH_COLOR        
                    jsr                 Change_Map_Color    
                    jsr                 dly                 
                    lda                 #0                  
                    sta                 SEARCH_COLOR        
                    jsr                 Change_Map_Color    
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
del_lp1
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

delay_longer         txa
                    pha
                    tya
                    pha
                    ldy                 #3                  
del_lp2a             ldx                 #$ff
del_lp1a
                    dex
                    cpx                 #0                  
                    bne                 del_lp1a             
                    dey
                    cpy                 #0                  
                    bne                 del_lp2a             
                    pla
                    tay
                    pla
                    tax
                    rts


;*************************************************************
; Reset the Game Level and set score to zero
;*************************************************************
Prep_Level_One
                    jsr                 RESET_LEVEL         
                    lda                 #$30                ; Initilize the score
                    sta                 SCORE_POS           ;
                    sta                 SCORE_POS+1         ;
                    sta                 SCORE_POS+2         ;
                    sta                 SCORE_POS+3         ;
                    sta                 SCORE_POS+4         ;
                    sta                 SCORE_POS+5         ;
                    sta                 SCORE_POS+6         ;                    
                    rts
;*************************************************************
; Upgrade to the next level
; Set the Ghost Priority &
; defaults to the new prioriy
; Dont need to reset btime counter here
; instead it is done when btime is enabled
;*************************************************************

RESET_LEVEL
                    lda                 #1                  ; Close Mouth
                    sta                 close_mouth         
                    lda                 #0                  
                    sta                 FLASH_ONLY          

                    sta                 gxminus1            
                    sta                 gxplus1             
                    sta                 gyminus1            
                    sta                 gyplus1             
                    sta                 gx                  
                    sta                 gy                  
                    sta                 pq$                 
                    sta                 pq$len              
                    sta                 g$                  
                    sta                 g$len               
                    sta                 g$eyesmode          
                    sta                 g$cage_cntr         
                    sta                 g$bluetime          
                    sta                 g$exit_cage_flg     
                    sta                 xg                  
                    sta                 yg                  
                    sta                 pr_cntr             
                    sta                 ghost_pr            
                    sta                 pd$                 
                    sta                 cdir                


                    ldx                 MAP_INDEX          
                    lda                 Const_gh2_DEF_PR,x  ;Grabbing the next
                    sta                 gh2_pr              ; et of priorities
                    lda                 Const_gh3_DEF_PR,x  ;Slightly more difficult
                    sta                 gh3_pr              ;For the next level
                    lda                 Const_gh4_DEF_PR,x  
                    sta                 gh4_pr              
                    lda                 Const_gh5_DEF_PR,x  
                    sta                 gh5_pr              
                    ;lda                 GAME_SPEED,x          
                    ;sta $403
                    ;clc             
                    lda                 SCREENS_CLEARED     
                    sta $401
                    cmp                 #13
                    bcc                 _here  ; Stay fast speed
                   ; sta                 $402                
                    lda                 #1                  
                    sta                 gh1_sp_boost_goal,x
                    ldx                 #13                 
                    
_here
                    lda                 GAME_SPEED,x        
                    sta                 _delay_5+1          

                    lda                 #0                  ;Reset Dots Eaten
                                                            ;sta                 DOTS_EATEN          ;
                                                            ;lda                 #0
                                                            ;sta                 TOTAL_DOTS_FLAG     ;
                    sta                 gh1_pr_cntr         
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
                    lda                 Cage_Ypos           
                    sta                 gh2_gy              
                    sta                 gh3_gy              
                    sta                 gh4_gy              
                    sta                 gh5_gy              

                    sta                 gh2_yg              
                    sta                 gh3_yg              
                    sta                 gh4_yg              
                    sta                 gh5_yg              
                    sta                 gh2_xg              
                    sta                 gh3_xg              
                    sta                 gh4_xg              
                    sta                 gh5_xg              
;
                    lda                 #0                  
;                    sta                 gh2_bluetime
;                    sta                 gh2_eyesmode
;                    sta                 gh3_bluetime
;                    sta                 gh3_eyesmode
;                    sta                 gh4_bluetime
;                    sta                 gh4_eyesmode
;                    sta                 gh5_bluetime
;                    sta                 gh5_eyesmode
                    jsr                 dsp_pacs            
                    LDA                 #%11111110          ; Turn off pac during ready text printing
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
                    sta                 gh2_g$              
                    sta                 gh3_g$              
                    sta                 gh4_g$              
                    sta                 gh5_g$              
                    sta                 gh1_pq$             
                    sta                 gh2_pq$             
                    sta                 gh3_pq$             
                    sta                 gh4_pq$             
                    sta                 gh5_pq$             
                    sta                 gh2_flashon         
                    sta                 gh3_flashon         
                    sta                 gh4_flashon         
                    sta                 gh5_flashon         
                    sta                 gh2_bt_count        
                    sta                 gh3_bt_count        
                    sta                 gh4_bt_count        
                    sta                 gh5_bt_count        

                    sta                 gh2_g$len           
                    sta                 gh3_g$len           
                    sta                 gh4_g$len           
                    sta                 gh5_g$len           
                    sta                 gh2_pq$len          
                    sta                 gh3_pq$len          
                    sta                 gh4_pq$len          
                    sta                 gh5_pq$len          
                    sta                 gh1_pd$             
                    sta                 gh2_pd$             
                                                            ; sta                 gh3_pd$
                    sta                 gh5_pd$             
 
                    lda                 #0                  
                    ;sta gobble_on
                   ; sta                 cdir                
                   ; sta                 g$                  
                    
                    sta                 userdirection       
                    sta gh1_cdir
                    lda                 Const_left          
                    sta                 gh5_cdir            
                    sta                 gh3_cdir            
                    sta                 gh3_g$              
                    sta                 gh3_pq$             
                    sta                 gh3_pd$             
                    lda                 Const_RIGHT         
                   ; sta                 cdir                
                   ; sta                 g$                  
                    ;sta                 gh1_cdir            
                    sta                 gh2_cdir            
                    sta                 gh4_cdir            
                    

                    sta                 gh4_g$              
                    sta                 gh4_pd$             
                    lda                 #0                  
                    sta                 gh2_bluetime        
                    sta                 gh3_bluetime        
                    sta                 gh4_bluetime        
                    sta                 gh5_bluetime        
                    sta                 gh2_eyesmode        
                    sta                 gh3_eyesmode        
                    sta                 gh4_eyesmode        
                    sta                 gh5_eyesmode        


                    STA                 gh2_pr_cntr         
                    STA                 gh3_pr_cntr         
                    STA                 gh4_pr_cntr         
                    STA                 gh5_pr_cntr         

                    sta                 gh2_cage_cntr       
                    sta                 gh3_cage_cntr       
                    sta                 gh4_cage_cntr       
                    sta                 gh5_cage_cntr       
                    lda                 #0                  
                    sta                 gh2_exit_cage_flg   
                    sta                 gh3_exit_cage_flg   
                    sta                 gh4_exit_cage_flg   
                    sta                 gh5_exit_cage_flg   
                    jsr                 mv_Ghost2           
                    jsr                 mv_Ghost3           
                    jsr                 mv_Ghost4           
                    jsr                 mv_Ghost5           
                    lda                 #$b0                
                    sta                 $d000               

                    lda                 #1                  
                    sta                 Gobble_on           

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
                    bne                 clear_buffer        

#endregion
                  ;  lda                 #0                  
                  ;  sta                 close_mouth         
                    lda                 #19                 
                    sta                 gh1_gx              
                    lda                 #14                 
                    sta                 gh1_gy              
                    lda                 #1                  ; Close Mouth
                    sta                 close_mouth         

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
                    lda #7
                    sta $da41,x

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
                    pha
                    ldy MAP_INDEX
                    lda SCORE_COLOR_MAP,y
                    sta                 $dbc0,x
                    pla
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
                    beq                 _Game_Over          ; Right now program freezes after last man...
                    jsr                 DEATH_ANIMATION     ; Animate Pac on death
                    jsr                 RESET_LEVEL         ; Reset the level
                    rts
_Game_Over          lda                 #$31
                    sta                 $400                
                    lda                 #$32                
                    sta                 $400                
                    lda                 #$33                
                    sta                 $400                
_junk               jmp                 _junk
;*************************************************************
; Simulate death of pac-clone by changing out characters
; with small delay between
;*************************************************************
DEATH_ANIMATION
                    lda                 #1                  
                    sta                 FLASH_ONLY          
                    lda                 #1                  ; Turn off all GHOSTS
                    sta                 $d015               
                    ldx                 #$ff                
                    jsr                 dly5                
                    jsr                 dly5                

                    jsr                 dly5                


                    ldy                 #148                ; Pac-Mouth-Open facing up
_death_lp           sty                 $07f8
                                                            ;sty                 $401
                    ldx                 #$50                
                    jsr                 dly6                
                    iny
                    cpy                 #158                
                    bne                 _death_lp           
                    rts
dly6
                    jsr                 dly5                
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
;                    jsr dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr                 dly5
;                    jsr dly5
                    jsr                 dly5                
                    jsr                 dly5                
                    jsr                 dly5                
                    jsr                 dly5                
                    jsr                 dly5                
                    jsr                 dly5                
                    rts

;                    lda                 #1
;                    pokeaxy             gh1_gx,gh1_gy
;                    jsr                 dly
;                    jsr                 dly
;                    jsr                 dly
;                    lda                 #2
;                    pokeaxy             gh1_gx,gh1_gy
;                    jsr                 dly
;                    jsr                 dly
;                    jsr                 dly
;                    lda                 #3
;                    pokeaxy             gh1_gx,gh1_gy
;                    jsr                 dly
;                    jsr                 dly
;                    jsr                 dly
;                    lda                 #$20
;                    pokeaxy             gh1_gx,gh1_gy
                    rts
;*************************************************************
; Eat Dots
;*************************************************************
SB                  = 54296

EAT_DOTS
                    inc                 DOTS_EATEN          ; Eat a dot
                    lda                 TOTAL_DOTS_FLAG     
                    cmp                 #1                  
                    bne                 _eat_first_255      

                    ldx                 MAP_INDEX           
                    lda                 ACTUAL_MAP_LEVELS,x 
                    tax
                    lda                 DOTS_EATEN        
                    cmp                 Const_TOTAL_DOTS,x    
                    beq                 _levelup            
                    rts
                    
_eat_first_255      lda                 DOTS_EATEN          ;
                    cmp                 #255                ; Are all dots eaten?
                    bne                 lbl_rtn             ; No
                    inc                 TOTAL_DOTS_FLAG     
                    inc $406
                    rts
_levelup
                    lda                 #1                  
                    sta                 Gobble_on           
                    sta                 close_mouth         

                    lda                 #0                  
                    sta                 gh2_flashon         
                    sta                 gh3_flashon         
                    sta                 gh4_flashon         
                    sta                 gh5_flashon         
                    sta                 flash_on            
                    sta                 TOTAL_GH_FLAG       
                    sta                 TOTAL_GH_MOVES      
                    sta                 TOTAL_DOTS_FLAG     
                    sta                 DOTS_EATEN          
                    lda                 #5                 
                    sta                 DOT_DEC             
                    lda                 #1                  
                    sta                 DOT_POINTS          
                    sta                 $d015               ;Only Pac-Clone at map end
                                                            ;LDA                 #1

                    jsr                 FLASH_SCREEN        ; Yes, do the screen flash
                   ; inc                 MAP_INDEX           ; Advance to the next level
                    inc SCREENS_CLEARED
                    inc                 MAP_INDEX
                    lda                 MAP_INDEX         
                    cmp                 #MAX_MAP_LEVELS     
                    bne                 _DONT_RESET_MAPX
                    
                    lda #8                   ; Reset back to first map
                    sta MAP_INDEX            ;

_DONT_RESET_MAPX
                    lda                 #0                  
                    sta                 $d015               
                    jsr                 DRAW_NEXT_MAP       
                    lda                 #254                
                    sta                 SEARCH_COLOR        
                                                            ;lda                 wall_dot
                                                            ;sta                 SEARCH_CHAR
                                                            ;jsr                 Change_Map_Color

                    jsr                 RESET_LEVEL         
lbl_rtn             rts
#endregion
space
                    lda                 wall_spc            
@ext                pokeaxy             gh1_gx,gh1_gy
                    rts

Reset_Sprite
                    lda                 #0                  
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

;                    ldx                 spr_up_low          ; Start out pac sprite facing up 
;                    stx                 int_spr_low         
;                    stx                 int_sprite          
;                    inx
;                    inx
;                    inx
;                    stx                 int_spr_high        
;                    stx                 $7f8                

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
                    sta                 flash_counter4      
                    sta                 flash_white_blue    
                    rts

Set_Interrupt
                    sei                                     ; disable interrupts
                    lda                 #<intcode           ; get low byte of target routine
                    sta                 788                 ; put into interrupt vector
                    lda                 #>intcode           ; do the same with the high byte
                    sta                 789                 
                    cli                                     ; re-enable interrupts
                                                            ; return to caller
_no_int             ldx                 spr_right_low       ; $84=$2000=sprite 1| $85 = sprite 2 etc.
                    stx                 $07f8               ; Sprite 1
                    stx                 int_spr_low         ; First sprite has three separate sprites
                    stx                 int_sprite          ; to emulate open-close of mouth
                    inx
                    inx
                    inx
                    stx                 int_spr_high        ;
                    jsr                 Reset_Sprite        
                    rts
;*************************************************************
intcode             = *

                    pha

                    inc                 flash_counter4      
                    lda                 flash_counter4      
                    cmp                 #12                 
                    bne                 _cont               
                    lda                 #0                  
                    sta                 flash_counter4      

                    inc                 int_nrgize          
                    lda                 int_nrgize          
                    cmp                 #2                  
                    beq                 _rst_nrgy           
                    ldx MAP_INDEX
                    ;LDX                 MAP_INDEX           
                    ;lda                 ACTUAL_MAP_LEVELS,x 
                    ;tax
                    lda EnergizerColor,x
                    tax
                    ;ldx                 #6                  
                    jsr                 Set_Nrgize_color    

                    jmp                 _cont               
_rst_nrgy           lda                 #0
                    sta                 int_nrgize          
                    ldx MAP_INDEX
                    ;LDX                 MAP_INDEX           
                    ;lda                 ACTUAL_MAP_LEVELS,x 
                    ;tax
                    lda MAP_BG_COLOR,x
                    tax

                    jsr                 Set_Nrgize_color    


_cont               lda                 FLASH_ONLY
                    cmp                 #1                  
                    bne                 _is_int             
                    jmp                 end                 

_is_int             lda                 Gobble_on
                    cmp                 #0                  
                    beq                 skip2               
                    lda                 close_mouth         
                    cmp                 #0                  
                    beq                 _normal             
                    ldx                 int_spr_low         
                    inx
                    inx
                    stx                 $7f8                

                    jmp                 flash_check         
end_jmp             jmp                 end
_normal             lda                 int_spr_low
                    sta                 $7f8                

                    jmp                 flash_check         
skip2               inc                 int_counter
                    lda                 int_counter         
                    cmp                 #03                 
                    bne                 flash_check         

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
                    inc                 flash_white_blue    

                    lda                 #0                  
                    sta                 flash_counter2      

                    Int_Flash           gh2_flashon,#0      ; Make Ghost 1 flash
test_2              Int_Flash           gh3_flashon,#1      ; Make Ghost 2 flash
test_3              Int_Flash           gh4_flashon,#2      ; Make Ghost 3 flash
test_4              Int_Flash           gh5_flashon,#3      ; Make Ghost 4 flash

_end_flash          lda                 flash_counter
                    cmp                 #2                  
                    bcc                 _inc                
                    lda                 #0                  
                    sta                 FLASH_ON            
                    lda                 #0                  
                    sta                 flash_counter       
_inc                inc                 flash_counter
@_end_here          nop


end                 pla
done_with_int       jmp                 $ea31

;Created this marco to make Interrupt flashing code more readable
defm                Int_Flash
                    lda                 /1                  
                    cmp                 #1                  
                    bne                 @end                
                    inc                 FLASH_ON            
                    ldy                 /2                  
                    jsr                 set_flash_color     
@end
endm

int_nrgize          byte                00
int_param           byte                00
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
flash_counter4      byte                00
FLASH_ONLY          byte                00

MAP2L               byte                00  ; New Mapl being switched to
MAP2H               byte                00  ;
map2cl              byte                00
map2ch              byte                00

DRAW_MAP4


                    ldy                 #0                  
_inner1a            lda                 $428,y
                    sta                 $400,y              
                    lda                 $d828,y             
                    sta                 $d800,y             
                    iny
                    bne                 _inner1a            
                                                            ;ldy #0
_inner1b            lda                 $528,y
                    sta                 $500,y              
                    lda                 $d928,y             
                    sta                 $d900,y             
                    iny
                    bne                 _inner1b            
                                                            ;ldy #0
_inner1c            lda                 $628,y
                    sta                 $600,y              
                    lda                 $da28,y             
                    sta                 $da00,y             
                    iny
                    bne                 _inner1c            
                                                            ;ldy #0
_inner1d            lda                 $728,y
                    sta                 $700,y              
                    lda                 $db28,y             
                    sta                 $db00,y             
                    iny
                    cpy                 #$e7                
                    bne                 _inner1d            
                    ldy                 #0                  
_inner2a            lda                 MAP2L               ; Load map low byte into $fb
                    sta                 $fb                 
                    lda                 MAP2H               ; Load map hig byte into $fc
                    sta                 $fc                 
                    lda                 ($fb),y             ; Load result into acc
                    sta                 $7c0,y              

                    lda                 map2cl              
                    sta                 $fb                 
                    lda                 map2ch              
                    sta                 $fc                 
                    lda                 ($fb),y             ; Load result into acc
                    sta                 $dbc0,y             

                    iny
                    cpy                 #40                 
                    bne                 _inner2a            

                    clc
                    lda                 map2l               
                    adc                 #40                 
                    sta                 map2l               
                    bcc                 _skip_carrya        
                    inc                 map2h               

_skip_carrya
                    clc
                    lda                 map2cl              
                    adc                 #40                 
                    sta                 map2cl              
                    bcc                 _skip_carryb        
                    inc                 map2ch              

_skip_carryb        rts

PrepMap_nLevel                                              ; Sets up temp pointers MAP2L,MAP2H,Map2CH,map2cl
                                                            ; to draw bottom line of new map during drawing map transition
                    ldx                 MAP_INDEX          
                    ;ldx                 ACTUAL_MAP_LEVELS,y
                    
                    lda                 MAP_BG_COLOR,x      
                    sta                 53281               
                    lda                 MAP_BD_COLOR,x      
                    sta                 53280               

                    ldx                 MAP_INDEX
                    lda                 ACTUAL_MAP_LEVELS,x
                    tax
                    
                    lda                 PACMAPH,x           
                    sta                 MAP2H               
                    lda                 PACMAPL,x           
                    sta                 MAP2L               
                    lda                 Map_ColorH,x        
                    sta                 map2ch              
                    lda                 MAP_ColorL,x        
                    sta                 map2cl              
                    rts

DRAW_NEXT_MAP
                    jsr                 PrepMap_nLevel      ; Prep Map for Next level
                    jsr                 SAVE_SCORE          
                    sei
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 draw_map4           
                    jsr                 RESTORE_SCORE       
                    cli
                    rts

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
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $C3,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $C3,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $18,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $18,$00,$00
 BYTE $18,$00,$00
 BYTE $18,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $08,$00,$00
 BYTE $08,$00,$00
 BYTE $08,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $08,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $14,$00,$00
 BYTE $00,$00,$00
 BYTE $14,$00,$00
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
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $08,$00,$00
 BYTE $22,$00,$00
 BYTE $00,$00,$00
 BYTE $22,$00,$00
 BYTE $08,$00,$00
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
 BYTE $14,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $42,$00,$00
 BYTE $14,$00,$00
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
 BYTE $4E,$E0,$00
 BYTE $CA,$A0,$00
 BYTE $4A,$A0,$00
 BYTE $4A,$A0,$00
 BYTE $4A,$A0,$00
 BYTE $4A,$A0,$00
 BYTE $EE,$E0,$00
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
 BYTE $EE,$E0,$00
 BYTE $2A,$A0,$00
 BYTE $2A,$A0,$00
 BYTE $EA,$A0,$00
 BYTE $8A,$A0,$00
 BYTE $8A,$A0,$00
 BYTE $EE,$E0,$00
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
 BYTE $AE,$E0,$00
 BYTE $AA,$A0,$00
 BYTE $AA,$A0,$00
 BYTE $EA,$A0,$00
 BYTE $2A,$A0,$00
 BYTE $2A,$A0,$00
 BYTE $2E,$E0,$00
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
 BYTE $EE,$E0,$00
 BYTE $AA,$A0,$00
 BYTE $AA,$A0,$00
 BYTE $EA,$A0,$00
 BYTE $AA,$A0,$00
 BYTE $AA,$A0,$00
 BYTE $EE,$E0,$00
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



; Screen 1 - Map 1 Colour data
MAP1Color
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        BYTE    $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
        BYTE    $03,$01,$07,$07,$03,$07,$07,$07,$07,$07,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$03,$03,$07,$07,$07,$07,$07,$07,$07,$03,$03,$03,$07,$07,$07,$07,$01,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$03,$03,$03,$07,$03,$07,$03,$03,$03,$03,$03,$03,$03,$07,$03,$03,$03,$07,$03,$03,$03,$03,$03,$07,$03,$03,$03,$07,$03,$03,$03,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$07,$07,$07,$07,$03,$07,$07,$07,$07,$07,$03,$03,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03
        BYTE    $03,$07,$07,$07,$07,$07,$03,$07,$03,$03,$07,$07,$07,$03,$07,$03,$07,$07,$07,$07,$03,$03,$07,$03,$07,$03,$07,$07,$07,$03,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$03,$03,$07,$03,$07,$03,$03,$03,$03,$07,$03,$07,$03,$07,$03,$03,$07,$03,$07,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03
        BYTE    $03,$07,$07,$07,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$01,$07,$07,$03,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$07,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$07,$07,$07,$07,$03,$07,$03,$03,$03,$07,$03,$03,$03,$07,$03,$03,$03,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$03,$03,$03,$03,$07,$07,$07,$07,$07,$07,$03,$03,$03,$03,$07,$03,$07,$03,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03
        BYTE    $03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03,$03,$03,$03,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$07,$03,$07,$03,$03,$03,$03,$03,$03,$07,$03,$03,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$03,$03,$07,$07,$07,$03,$07,$07,$07,$07,$03,$03,$01,$03,$03,$03,$07,$03,$07,$03,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$07,$07,$07,$03,$07,$03,$07,$03,$03,$07,$03,$00,$00,$00,$00,$03,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$03,$07,$03,$03,$03,$07,$07,$07,$03,$03,$07,$03,$03,$03,$03,$03,$03,$07,$03,$07,$03,$03,$03,$03,$07,$03,$07,$07,$07,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$07,$07,$07,$03,$07,$07,$07,$03,$07,$03,$07,$07,$07,$07,$03,$03,$03,$03,$03,$03,$07,$03,$07,$03,$03,$03,$03,$07,$03,$03,$03,$03,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03,$07,$03,$03,$03,$07,$03,$03,$03,$03,$03,$03,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03
        BYTE    $03,$07,$03,$07,$07,$07,$07,$07,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$03,$07,$03,$03,$03,$03,$07,$03,$03,$03,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$03,$07,$03,$03,$07,$07,$07,$03,$07,$03,$07,$03,$07,$03,$03,$03,$03,$03,$03,$07,$03,$03,$03,$07,$03,$07,$07,$07,$07,$07,$03,$07,$07,$07,$03,$07,$03
        BYTE    $03,$07,$07,$07,$07,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03,$07,$03,$03,$03,$03,$03,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$07,$07,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$03,$07,$03,$07,$03,$07,$07,$07,$03,$07,$03,$07,$03,$07,$03
        BYTE    $03,$07,$03,$03,$03,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03,$07,$03,$03,$03,$03,$03,$03,$07,$03,$07,$03,$07,$03,$07,$03,$07,$03,$03,$03,$07,$03,$07,$03,$07,$03
        BYTE    $03,$01,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$03,$07,$07,$01,$03
        BYTE    $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; Screen 2 - Map 2 Colour data

        BYTE    $00,$00,$00,$00,$00,$05,$05,$05,$05,$05,$05,$05,$05,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        BYTE    $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
        BYTE    $06,$02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$06,$07,$07,$07,$06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$01,$01,$01,$01,$01,$02,$06
        BYTE    $06,$01,$06,$06,$06,$07,$06,$01,$06,$06,$06,$06,$01,$06,$06,$01,$06,$06,$07,$06,$01,$01,$01,$06,$07,$06,$01,$06,$06,$06,$06,$01,$06,$01,$06,$06,$06,$06,$01,$06
        BYTE    $06,$01,$06,$06,$06,$07,$06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$01,$06,$07,$06,$01,$07,$07,$06,$01,$01,$06,$01,$06,$01,$01,$01,$01,$06
        BYTE    $06,$01,$01,$01,$06,$07,$06,$07,$06,$07,$06,$06,$06,$06,$07,$06,$06,$06,$01,$06,$01,$06,$01,$06,$07,$07,$01,$06,$07,$06,$01,$06,$06,$01,$06,$01,$06,$07,$06,$06
        BYTE    $06,$01,$06,$01,$06,$07,$06,$07,$06,$07,$06,$06,$06,$06,$07,$06,$06,$06,$01,$06,$01,$01,$01,$06,$07,$06,$01,$06,$07,$06,$01,$06,$06,$01,$06,$01,$06,$07,$06,$06
        BYTE    $06,$01,$06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$01,$01,$01,$06,$06,$01,$06,$01,$06,$01,$06,$07,$06,$01,$06,$07,$07,$01,$01,$01,$01,$06,$01,$06,$07,$06,$06
        BYTE    $06,$01,$06,$06,$01,$06,$06,$01,$06,$06,$06,$01,$06,$01,$06,$01,$01,$01,$01,$06,$01,$06,$01,$01,$01,$01,$01,$06,$06,$07,$06,$06,$06,$07,$06,$01,$06,$07,$06,$06
        BYTE    $06,$01,$01,$06,$01,$06,$06,$01,$07,$07,$06,$01,$07,$01,$06,$06,$01,$06,$06,$06,$01,$06,$06,$01,$06,$06,$01,$01,$01,$01,$01,$01,$06,$07,$06,$01,$06,$07,$06,$06
        BYTE    $06,$06,$01,$06,$01,$06,$06,$01,$06,$07,$06,$01,$06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$06,$06,$01,$06,$06,$06,$01,$06,$07,$07,$01,$01,$01,$06,$06
        BYTE    $06,$06,$01,$01,$01,$06,$06,$01,$06,$07,$06,$01,$06,$01,$06,$06,$01,$06,$06,$02,$06,$06,$06,$01,$06,$01,$01,$01,$06,$01,$01,$01,$06,$06,$07,$06,$06,$01,$01,$06
        BYTE    $03,$07,$01,$06,$01,$01,$06,$01,$06,$07,$07,$01,$06,$01,$02,$06,$01,$06,$00,$00,$00,$00,$06,$01,$06,$01,$06,$01,$06,$01,$06,$01,$06,$01,$01,$01,$06,$06,$01,$03
        BYTE    $06,$06,$01,$06,$06,$01,$07,$01,$06,$06,$06,$01,$06,$01,$06,$06,$01,$06,$06,$06,$06,$06,$06,$01,$01,$01,$06,$01,$01,$01,$06,$01,$01,$01,$06,$01,$01,$01,$01,$06
        BYTE    $06,$01,$01,$01,$01,$01,$06,$01,$06,$06,$06,$01,$07,$01,$01,$01,$01,$07,$07,$07,$07,$07,$07,$01,$06,$01,$06,$01,$06,$06,$06,$01,$06,$06,$06,$06,$06,$06,$01,$06
        BYTE    $06,$01,$06,$01,$06,$01,$06,$01,$06,$06,$06,$01,$06,$06,$01,$06,$06,$06,$06,$07,$06,$06,$06,$01,$06,$01,$01,$01,$07,$07,$07,$01,$06,$06,$01,$01,$01,$01,$01,$06
        BYTE    $06,$01,$06,$01,$01,$01,$06,$01,$01,$01,$01,$01,$06,$06,$01,$07,$07,$07,$06,$07,$06,$01,$01,$01,$06,$06,$07,$06,$06,$06,$06,$01,$06,$06,$01,$06,$06,$06,$01,$06
        BYTE    $06,$01,$06,$07,$06,$01,$06,$01,$06,$06,$01,$06,$06,$06,$01,$06,$06,$07,$06,$07,$06,$01,$06,$07,$06,$01,$01,$01,$01,$01,$06,$01,$07,$07,$01,$06,$06,$06,$01,$06
        BYTE    $06,$01,$01,$01,$01,$01,$01,$01,$06,$06,$01,$07,$07,$07,$01,$01,$01,$07,$06,$07,$06,$01,$07,$07,$07,$01,$06,$06,$06,$01,$06,$01,$06,$06,$01,$06,$06,$06,$01,$06
        BYTE    $06,$06,$06,$06,$06,$01,$06,$06,$06,$06,$01,$06,$06,$06,$06,$06,$01,$06,$06,$07,$06,$01,$06,$06,$06,$01,$07,$07,$06,$01,$07,$01,$06,$06,$01,$06,$06,$06,$01,$06
        BYTE    $06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$06,$07,$06,$01,$06,$06,$01,$01,$06,$07,$06,$01,$06,$01,$06,$06,$01,$06,$06,$06,$01,$06
        BYTE    $06,$01,$06,$06,$06,$01,$06,$01,$06,$06,$06,$06,$06,$06,$06,$06,$01,$01,$01,$01,$01,$01,$01,$06,$01,$06,$06,$07,$06,$01,$06,$01,$06,$06,$01,$06,$06,$06,$01,$06
        BYTE    $06,$02,$01,$01,$01,$01,$06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$06,$06,$06,$06,$06,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$06
        BYTE    $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; Screen 3 - Map 3 Colour data

        BYTE    $00,$00,$00,$00,$00,$05,$05,$05,$05,$05,$05,$05,$05,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        BYTE    $00,$01,$07,$07,$07,$07,$07,$07,$07,$00,$07,$07,$07,$07,$07,$07,$00,$07,$07,$07,$00,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$01,$00
        BYTE    $00,$07,$00,$00,$00,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$07,$00,$07,$00,$07,$07,$07,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00,$07,$00,$07,$00
        BYTE    $00,$07,$00,$07,$07,$07,$07,$00,$07,$07,$07,$07,$07,$07,$00,$07,$00,$07,$00,$07,$00,$07,$07,$07,$07,$07,$00,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$07,$00
        BYTE    $00,$07,$00,$07,$00,$00,$07,$00,$07,$00,$01,$00,$00,$07,$00,$07,$07,$07,$00,$07,$00,$07,$00,$00,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$07,$03,$07,$00
        BYTE    $00,$07,$00,$07,$00,$01,$07,$07,$07,$07,$07,$07,$00,$07,$00,$07,$00,$00,$00,$07,$00,$07,$07,$07,$07,$00,$00,$07,$00,$07,$00,$07,$07,$00,$07,$07,$07,$00,$07,$00
        BYTE    $00,$07,$00,$07,$00,$00,$07,$00,$07,$00,$00,$07,$00,$07,$00,$07,$07,$07,$07,$07,$07,$07,$00,$00,$07,$00,$00,$07,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$07,$00
        BYTE    $00,$07,$07,$07,$07,$07,$07,$00,$07,$07,$00,$07,$00,$07,$00,$07,$00,$00,$00,$07,$00,$07,$00,$00,$07,$00,$00,$07,$00,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00
        BYTE    $00,$07,$00,$00,$00,$00,$00,$00,$00,$07,$00,$07,$07,$07,$00,$07,$00,$00,$00,$07,$00,$07,$00,$00,$07,$07,$07,$07,$00,$00,$07,$00,$00,$00,$00,$00,$00,$00,$07,$00
        BYTE    $00,$07,$00,$01,$01,$01,$01,$01,$00,$07,$00,$00,$00,$07,$00,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$07,$00,$00,$00,$07,$00,$07,$07,$07,$00,$07,$07,$07,$00
        BYTE    $00,$07,$00,$01,$00,$00,$00,$01,$00,$07,$07,$07,$07,$07,$00,$00,$07,$00,$00,$03,$00,$00,$00,$07,$00,$00,$07,$07,$07,$07,$07,$07,$07,$00,$07,$00,$07,$00,$00,$00
        BYTE    $03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$00,$00,$07,$00,$00,$07,$00,$00,$00,$00,$00,$00,$07,$00,$00,$07,$00,$00,$00,$00,$00,$07,$00,$07,$07,$07,$07,$07,$03
        BYTE    $00,$07,$00,$00,$00,$00,$00,$07,$00,$07,$07,$07,$00,$07,$07,$07,$07,$00,$00,$00,$00,$00,$00,$07,$00,$07,$07,$00,$07,$07,$07,$00,$07,$00,$00,$00,$00,$00,$07,$00
        BYTE    $00,$07,$00,$00,$00,$00,$00,$07,$00,$07,$00,$07,$00,$00,$00,$00,$01,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$00,$07,$00,$07,$00,$07,$00,$00,$00,$00,$00,$07,$00
        BYTE    $00,$07,$00,$07,$07,$07,$07,$07,$00,$07,$07,$07,$07,$07,$00,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$07,$00,$00,$07,$00,$07,$00,$07,$07,$07,$07,$00,$00,$07,$00
        BYTE    $00,$07,$07,$07,$00,$00,$00,$07,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$07,$00,$00,$07,$00,$07,$00,$00,$00,$00,$07,$00,$00,$07,$00
        BYTE    $00,$07,$00,$07,$00,$03,$00,$07,$00,$00,$00,$07,$07,$07,$07,$07,$00,$00,$07,$00,$07,$00,$00,$00,$07,$07,$07,$07,$07,$00,$07,$07,$07,$07,$07,$07,$00,$00,$07,$00
        BYTE    $00,$07,$01,$07,$00,$06,$00,$07,$07,$07,$00,$00,$00,$07,$00,$07,$00,$00,$07,$00,$07,$07,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$07,$00,$07,$00
        BYTE    $00,$07,$00,$07,$00,$00,$00,$07,$00,$07,$00,$07,$07,$07,$07,$07,$07,$07,$07,$00,$00,$00,$01,$01,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$00,$07,$00
        BYTE    $00,$07,$00,$07,$07,$07,$07,$07,$00,$07,$07,$07,$00,$00,$00,$00,$07,$00,$07,$07,$07,$07,$07,$00,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$07,$00
        BYTE    $00,$06,$00,$00,$00,$00,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00,$07,$00,$07,$00,$00,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$07,$00,$00,$00,$07,$00,$07,$00
        BYTE    $00,$01,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$01,$00
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; Screen 4 - map 4 Colour data

        BYTE    $00,$00,$00,$00,$00,$0B,$0B,$0B,$04,$04,$05,$05,$05,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        BYTE    $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
        BYTE    $0B,$07,$00,$00,$00,$00,$00,$0B,$00,$00,$00,$0B,$0B,$0B,$0B,$01,$07,$0B,$0B,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$0B
        BYTE    $0B,$00,$0B,$0B,$0B,$0B,$00,$00,$00,$0B,$00,$00,$00,$00,$00,$00,$0B,$07,$07,$07,$00,$0B,$00,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$00,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$00,$00,$0B,$0B,$0B,$00,$0B,$0B,$00,$0B,$0B,$00,$0B,$00,$0B,$0B,$0B,$0B,$00,$0B,$00,$00,$00,$00,$00,$0B,$0B,$0B,$00,$0B,$07,$0B,$0B,$0B,$0B,$0B,$00,$0B
        BYTE    $0B,$0B,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$00,$0B,$00,$00,$0B,$0B,$0B,$00,$0B,$0B,$0B,$0B,$0B,$00,$0B,$0B,$0B,$00,$0B,$00,$00,$00,$0B,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$00,$00,$0B,$0B,$01,$0B,$0B,$0B,$0B,$00,$0B,$00,$0B,$0B,$00,$07,$0B,$0B,$00,$00,$0B,$07,$07,$0B,$00,$0B,$01,$0B,$00,$0B,$0B,$0B,$00,$00,$00,$0B,$00,$0B
        BYTE    $0B,$00,$0B,$01,$01,$01,$01,$0B,$0B,$0B,$0B,$00,$00,$00,$00,$0B,$00,$0B,$0B,$0B,$0B,$00,$0B,$07,$0B,$0B,$00,$0B,$01,$01,$00,$00,$00,$0B,$0B,$0B,$00,$0B,$00,$0B
        BYTE    $0B,$00,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$00,$00,$0B,$0B,$00,$0B,$00,$0B,$0B,$0B,$0B,$00,$00,$00,$00,$0B,$00,$0B,$0B,$0B,$0B,$0B,$00,$0B,$0B,$00,$00,$0B,$00,$0B
        BYTE    $0B,$00,$00,$00,$0B,$0B,$0B,$0B,$0B,$0B,$00,$0B,$0B,$0B,$00,$00,$00,$0B,$0B,$0B,$0B,$00,$0B,$0B,$00,$0B,$00,$00,$00,$00,$00,$00,$00,$0B,$00,$00,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$0B,$00,$0B,$0B,$0B,$00,$00,$00,$00,$0B,$0B,$0B,$00,$0B,$00,$07,$07,$07,$07,$00,$00,$00,$00,$0B,$00,$0B,$0B,$0B,$00,$0B,$07,$0B,$00,$0B,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$0B,$00,$00,$00,$0B,$00,$0B,$0B,$0B,$0B,$0B,$0B,$00,$0B,$00,$0B,$0B,$07,$0B,$0B,$0B,$00,$0B,$0B,$00,$00,$00,$0B,$00,$0B,$07,$07,$00,$07,$07,$0B,$00,$0B
        BYTE    $07,$00,$0B,$00,$0B,$00,$0B,$00,$0B,$0B,$01,$01,$01,$00,$00,$01,$00,$0B,$0B,$00,$00,$00,$0B,$00,$0B,$0B,$0B,$0B,$00,$0B,$00,$0B,$0B,$0B,$00,$0B,$0B,$0B,$00,$04
        BYTE    $0B,$00,$0B,$00,$0B,$00,$00,$00,$00,$00,$00,$0B,$0B,$00,$0B,$0B,$00,$0B,$0B,$0B,$0B,$0B,$0B,$00,$0B,$0B,$0B,$0B,$00,$0B,$00,$00,$00,$00,$00,$0B,$00,$00,$00,$0B
        BYTE    $0B,$00,$01,$00,$0B,$0B,$0B,$0B,$00,$0B,$00,$0B,$0B,$00,$01,$01,$00,$07,$07,$07,$07,$07,$07,$00,$00,$0B,$0B,$0B,$00,$0B,$00,$0B,$0B,$0B,$00,$07,$00,$0B,$0B,$0B
        BYTE    $0B,$00,$0B,$00,$0B,$0B,$0B,$0B,$00,$0B,$00,$00,$0B,$00,$0B,$0B,$00,$0B,$0B,$0B,$0B,$07,$0B,$0B,$00,$0B,$0B,$0B,$00,$00,$00,$00,$00,$0B,$00,$0B,$00,$07,$07,$0B
        BYTE    $0B,$00,$0B,$00,$00,$00,$00,$00,$00,$0B,$0B,$00,$0B,$00,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$0B,$0B,$00,$0B,$0B,$0B,$00,$0B,$00,$0B,$00,$0B,$07,$0B
        BYTE    $0B,$00,$0B,$00,$0B,$00,$0B,$0B,$00,$00,$0B,$00,$00,$00,$00,$00,$0B,$01,$0B,$0B,$01,$0B,$0B,$0B,$00,$0B,$0B,$0B,$00,$07,$07,$0B,$00,$0B,$00,$0B,$00,$00,$00,$0B
        BYTE    $0B,$00,$0B,$00,$0B,$00,$0B,$0B,$0B,$00,$0B,$0B,$0B,$0B,$0B,$00,$0B,$01,$01,$01,$01,$01,$01,$0B,$00,$00,$00,$00,$00,$0B,$07,$0B,$00,$0B,$00,$0B,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$0B,$00,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$00,$0B,$01,$0B,$0B,$0B,$0B,$01,$0B,$00,$0B,$0B,$0B,$00,$0B,$01,$07,$00,$07,$00,$00,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$01,$00,$0B,$0B,$0B,$0B,$0B,$00,$0B,$0B,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$01,$0B,$00,$0B,$0B,$00,$0B,$0B,$00,$0B
        BYTE    $0B,$00,$0B,$00,$0B,$0B,$00,$00,$00,$00,$00,$00,$0B,$0B,$0B,$01,$0B,$0B,$0B,$0B,$0B,$01,$0B,$0B,$0B,$0B,$0B,$0B,$00,$0B,$01,$0B,$00,$0B,$0B,$00,$0B,$0B,$00,$0B
        BYTE    $0B,$07,$00,$00,$00,$00,$00,$0B,$0B,$0B,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$01,$01,$00,$00,$00,$00,$07,$07,$07,$0B
        BYTE    $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
        BYTE    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$0B,$0B,$0B,$0B,$0B,$0B,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; Screen 5 - Challenge Screen Colour data

        BYTE    $07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07
        BYTE    $07,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$03,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$06,$06,$06,$03,$03,$03,$03,$03,$03,$06,$06,$03,$03,$03,$06,$06,$06,$06,$06,$03,$03,$06,$06,$03,$03,$06,$06,$06,$06,$03,$03,$03,$03,$06,$06,$06,$06,$06,$07
        BYTE    $07,$06,$06,$03,$03,$06,$06,$06,$06,$06,$06,$06,$03,$06,$06,$03,$06,$06,$06,$03,$03,$03,$03,$06,$06,$03,$03,$06,$06,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$06,$06,$03,$06,$06,$06,$06,$06,$06,$06,$06,$03,$06,$06,$03,$06,$06,$06,$03,$03,$03,$03,$06,$06,$06,$03,$03,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$06,$06,$03,$06,$06,$06,$06,$06,$06,$06,$06,$03,$06,$03,$03,$06,$06,$06,$03,$03,$06,$03,$03,$06,$06,$06,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$06,$06,$03,$06,$03,$03,$03,$03,$03,$03,$06,$03,$03,$03,$06,$06,$06,$06,$03,$03,$03,$03,$03,$06,$06,$06,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$06,$06,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$06,$03,$03,$03,$03,$03,$03,$03,$06,$06,$06,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$07,$06,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$03,$06,$06,$03,$03,$06,$06,$06,$03,$03,$06,$06,$06,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$07,$06,$06,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$03,$03,$06,$03,$06,$06,$06,$06,$06,$03,$06,$06,$06,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$07,$06,$06,$06,$03,$03,$03,$03,$03,$03,$03,$03,$06,$06,$03,$03,$06,$03,$06,$06,$06,$06,$06,$03,$06,$06,$06,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$07,$06,$06,$06,$06,$06,$06,$06,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$07
        BYTE    $07,$07,$03,$03,$03,$03,$03,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$03,$03,$06,$06,$06,$06,$06,$07
        BYTE    $07,$03,$03,$03,$06,$06,$03,$03,$03,$06,$03,$03,$03,$03,$06,$03,$03,$03,$03,$03,$06,$06,$03,$06,$03,$03,$06,$06,$03,$03,$03,$06,$03,$06,$03,$06,$06,$06,$03,$07
        BYTE    $07,$03,$03,$03,$03,$06,$03,$06,$06,$06,$03,$06,$06,$06,$06,$03,$06,$06,$06,$03,$03,$06,$03,$06,$03,$03,$03,$06,$03,$06,$06,$06,$03,$06,$03,$03,$06,$06,$03,$07
        BYTE    $07,$03,$06,$06,$03,$06,$03,$03,$06,$06,$03,$06,$03,$03,$06,$03,$03,$06,$06,$03,$03,$03,$03,$06,$03,$06,$03,$06,$03,$06,$06,$06,$03,$06,$06,$03,$06,$06,$03,$07
        BYTE    $07,$03,$06,$06,$03,$06,$03,$03,$03,$06,$03,$03,$03,$03,$06,$03,$03,$03,$06,$03,$03,$03,$03,$06,$03,$06,$03,$06,$03,$03,$03,$06,$03,$03,$03,$03,$06,$06,$03,$07
        BYTE    $07,$03,$06,$06,$03,$06,$03,$03,$03,$06,$03,$06,$06,$06,$06,$03,$03,$03,$06,$03,$03,$03,$03,$06,$03,$06,$03,$06,$03,$03,$03,$06,$03,$03,$03,$06,$06,$06,$03,$07
        BYTE    $07,$03,$06,$03,$03,$06,$03,$06,$06,$06,$03,$06,$06,$06,$06,$03,$03,$06,$06,$03,$03,$03,$03,$06,$03,$06,$03,$06,$03,$06,$06,$06,$03,$03,$03,$03,$06,$06,$03,$07
        BYTE    $07,$03,$03,$03,$03,$03,$03,$06,$06,$06,$03,$06,$06,$06,$06,$03,$03,$06,$06,$03,$03,$06,$03,$06,$03,$03,$03,$06,$03,$06,$06,$06,$03,$03,$06,$03,$03,$06,$03,$07
        BYTE    $07,$03,$03,$03,$03,$03,$03,$03,$03,$06,$03,$06,$06,$06,$06,$03,$03,$03,$06,$03,$06,$06,$03,$06,$03,$03,$06,$06,$03,$03,$03,$06,$03,$03,$06,$06,$03,$06,$03,$07
        BYTE    $07,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$03,$07
        BYTE    $07,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$03,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$03,$03,$03,$03,$03,$06,$06,$03,$07
        BYTE    $07,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$06,$06,$03,$03,$06,$06,$07,$07
        BYTE    $07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07

Map1_Data
; Screen 1 - Map 1 Screen data

        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $A0,$2A,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2A,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$20,$2E,$2E,$2E,$2E,$2E,$20,$20,$A0,$20,$20,$2E,$2E,$2E,$2E,$2E,$20,$20,$A0,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$20,$20,$20,$A0,$20,$A0,$2E,$20,$20,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$20,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$2E,$A0
        BYTE    $A0,$20,$A0,$A0,$A0,$20,$20,$2E,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$2E,$A0,$A0,$20,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$2A,$20,$20,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$A0,$20,$20,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$20,$20,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$20,$2E,$2E,$A0,$20,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$20,$A0,$A0,$20,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0,$A0,$20,$A0,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$20,$20,$20,$20,$20,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$20,$20,$20,$20,$20,$20,$2E,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$20,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2D,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$20,$A0,$2E,$2E,$2E,$20,$2E,$2E,$2E,$2E,$2E,$A0
        BYTE    $20,$2E,$20,$2E,$A0,$20,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$20,$A0,$20,$20,$20,$20,$A0,$2E,$20,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$20
        BYTE    $A0,$2E,$A0,$2E,$A0,$20,$20,$2E,$A0,$A0,$A0,$2E,$20,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$20,$20,$A0,$2E,$2E,$2E,$20,$2E,$A0,$2E,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$A0,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$20,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$20,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$2E,$20,$2E,$2E,$2E,$2E,$2E,$20,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$2E,$20,$2E,$A0,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$20,$2E,$A0,$2E,$A0,$A0,$A0,$20,$A0,$2E,$A0,$2E,$20,$20,$20,$20,$20,$20,$20,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$2E,$20,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$20,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2A,$A0
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
; Screen 2 - Map 2 Screen data

        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$A0,$A0,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2A,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$20,$A0,$A0,$20,$A0,$20,$20,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$A0,$2E,$A0,$20,$A0,$2E,$20,$20,$20,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0
        BYTE    $A0,$2E,$20,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$20,$A0,$2E,$A0,$20,$20,$2E,$A0,$20,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$20,$A0,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$20,$20,$2E,$A0,$20,$A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$20,$A0,$A0
        BYTE    $A0,$2E,$A0,$20,$20,$20,$20,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$20,$A0,$2E,$A0,$20,$A0,$2E,$A0,$20,$20,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$20,$A0,$A0
        BYTE    $A0,$2E,$A0,$A0,$20,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$2E,$20,$20,$2E,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$2E,$A0,$20,$A0,$A0
        BYTE    $A0,$2E,$2E,$A0,$20,$A0,$A0,$2E,$20,$20,$A0,$2E,$20,$2E,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$20,$A0,$A0
        BYTE    $A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$20,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$20,$20,$2E,$2E,$2E,$A0,$A0
        BYTE    $A0,$A0,$2E,$20,$20,$A0,$A0,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$2D,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$20,$A0,$A0,$2E,$2E,$A0
        BYTE    $20,$20,$2E,$A0,$20,$20,$A0,$2E,$A0,$20,$20,$2E,$A0,$2E,$2A,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$20,$A0,$2E,$2E,$2E,$A0,$A0,$2E,$20
        BYTE    $A0,$A0,$2E,$A0,$A0,$20,$20,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$A0
        BYTE    $A0,$20,$2E,$2E,$20,$20,$A0,$2E,$A0,$A0,$A0,$2E,$20,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$20,$20,$2E,$A0,$20,$A0,$20,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0
        BYTE    $A0,$20,$A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$20,$20,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0
        BYTE    $A0,$20,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$20,$20,$20,$A0,$20,$A0,$2E,$2E,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$20,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$A0,$20,$A0,$20,$A0,$2E,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$20,$20,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$20,$20,$20,$20,$2E,$2E,$2E,$A0,$A0,$20,$20,$20,$20,$2E,$2E,$2E,$20,$A0,$20,$A0,$2E,$20,$20,$20,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$20,$A0,$2E,$A0,$A0,$A0,$2E,$20,$20,$A0,$2E,$20,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$2E,$2E,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$20,$A0,$2E,$A0,$A0,$2E,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$20,$20,$20,$20,$2E,$2E,$A0,$2E,$A0,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2A,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$20,$20,$20,$20,$2E,$2E,$2E,$20,$20,$2E,$2E,$2E,$2E,$2A,$A0
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
; Screen 3 - Map 3 Screen data

        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2A,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0,$2E,$20,$2E,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$2E,$20,$20,$20,$20,$A0,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$20,$20,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$20,$A0,$2E,$A0,$20,$20,$20,$20,$20,$20,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$20,$2E,$20,$20,$20,$2E,$20,$2E,$A0,$A0,$2E,$A0,$A0,$20,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$20,$20,$20,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0
        BYTE    $A0,$2E,$A0,$20,$20,$20,$20,$20,$A0,$2E,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$A0,$20,$20,$20,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$2D,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$20,$A0,$A0,$A0
        BYTE    $20,$2E,$20,$20,$20,$20,$20,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$20
        BYTE    $A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$20,$20,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$20,$20,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$2E,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$20,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$20,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$20,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$20,$2E,$A0,$20,$A0,$2E,$20,$20,$A0,$A0,$A0,$20,$A0,$2E,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$20,$A0,$20,$20,$20,$20,$2E,$2E,$20,$20,$A0,$A0,$A0,$20,$20,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$A0,$A0,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
        BYTE    $A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$2E,$A0
        BYTE    $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2A,$A0
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
; Screen 4 - map 4 Screen data

        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $A0,$2A,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$20,$20,$20,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2A,$A0
        BYTE    $A0,$20,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$20,$20,$20,$A0,$A0,$A0,$20,$A0,$A0,$20,$A0,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$2A,$A0,$A0,$A0,$20,$A0,$2E,$A0
        BYTE    $A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$20,$20,$20,$2E,$2E,$A0,$20,$20,$20,$2E,$20,$20,$A0,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$20,$20,$20,$20,$A0,$20,$A0,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$20,$20,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$20,$A0,$A0,$2E,$A0,$2E,$A0,$20,$20,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$A0,$2E,$A0
        BYTE    $A0,$2E,$2E,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$A0,$A0,$20,$20,$20,$20,$A0,$20,$A0,$2E,$A0,$20,$20,$20,$20,$20,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$20,$A0,$20,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$2E,$2E,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2D,$A0,$A0,$A0,$20,$A0,$A0,$2E,$2E,$2E,$A0,$20,$A0,$20,$20,$2E,$20,$20,$20,$2E,$A0
        BYTE    $20,$2E,$A0,$20,$A0,$2E,$A0,$20,$A0,$A0,$20,$20,$20,$2E,$2E,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$20
        BYTE    $A0,$2E,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$20,$A0,$2E,$A0,$20,$20,$20,$20,$2E,$A0,$2E,$2E,$2E,$A0
        BYTE    $A0,$2E,$20,$20,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0,$A0,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$2E,$A0,$20,$A0,$A0,$A0,$2E,$20,$2E,$A0,$A0,$A0
        BYTE    $A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$20,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$20,$20,$A0
        BYTE    $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$20,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$A0,$2E,$2E,$2E,$20,$2E,$A0,$20,$A0,$A0,$20,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$20,$20,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$2E,$20,$2E,$2E,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$20,$2E,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$2E,$A0
        BYTE    $A0,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$2E,$A0
        BYTE    $A0,$2A,$20,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$2E,$2E,$2E,$2E,$20,$20,$2A,$A0
        BYTE    $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
        BYTE    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
; Screen 5 - Challenge Screen Screen data

        BYTE    $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0
        BYTE    $E0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$20,$A0,$A0,$A0,$E0,$E0,$20,$20,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$E0,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$E0,$E0,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$A0,$20,$20,$20,$20,$E0,$E0,$E0,$20,$20,$A0,$A0,$20,$20,$20,$E0,$E0,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$A0,$20,$20,$20,$20,$E0,$20,$E0,$20,$20,$20,$A0,$A0,$2E,$A0,$E0,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$A0,$20,$20,$20,$20,$E0,$20,$E0,$20,$20,$20,$20,$A0,$E0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$A0,$20,$2E,$2E,$2E,$2E,$2E,$2E,$20,$A0,$A0,$A0,$20,$20,$20,$20,$E0,$E0,$E0,$E0,$E0,$20,$20,$20,$E0,$E0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$A0,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$A0,$20,$A0,$A0,$20,$20,$E0,$E0,$20,$20,$20,$E0,$E0,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$A0,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$20,$20,$A0,$20,$20,$E0,$E0,$20,$20,$20,$E0,$E0,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$20,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$E0,$20,$20,$A0,$20,$20,$E0,$20,$20,$20,$20,$20,$E0,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$E0,$20,$20,$E0,$E0,$20,$E0,$20,$20,$20,$20,$20,$E0,$20,$20,$20,$E0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$20,$20,$20,$20,$20,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$E0,$A0,$A0,$20,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$A0,$20,$A0,$A0,$20,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$20,$20,$A0,$E0
        BYTE    $E0,$A0,$A0,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$20,$A0,$A0,$20,$20,$A0,$E0
        BYTE    $E0,$A0,$20,$20,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$A0,$20,$20,$A0,$E0
        BYTE    $E0,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$20,$A0,$E0
        BYTE    $E0,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$20,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$20,$20,$A0,$E0
        BYTE    $E0,$A0,$20,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$20,$20,$A0,$20,$A0,$A0,$20,$20,$A0,$E0
        BYTE    $E0,$A0,$A0,$A0,$2E,$2E,$A0,$20,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$A0,$A0,$20,$E0,$E0
        BYTE    $E0,$A0,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$20,$A0,$20,$20,$20,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$A0,$20,$A0,$A0,$20,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$20,$E0,$E0
        BYTE    $E0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E0
        BYTE    $E0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2E,$2E,$2E,$2E,$2E,$20,$20,$E0,$E0
        BYTE    $E0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$2E,$2E,$20,$20,$20,$E0
        BYTE    $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0

