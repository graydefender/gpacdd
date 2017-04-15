MOVING_SPRITES      = $00                                   ; Comment this line out to disable ghosts from moving
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
; * 5/09/16 Implement Speed boost and super speed boost
; * 5/11/16 Implement Random opposite move for ghosts
; * 5/12/16 Fix bug g$len was being stomped on
; turns out g$ variables needs to be 5 bytes
; or a check to be sure the len is not >3 |so just made 5 bytes
; rather than adding an extra check, thats the trade off made
; 06/23/16 - Worked on ch levels
; 06/24/16 - added fruit to the mix but no score indictors just yet
; 07/16/16 - Change code to support user defined character sets
; 09/03/16 - Fix bug where fruit counts same as dots
; 09/10/16 - Implement Bonus rewards for completing challenge screens
; 09/11/16 - Quash some bugs including wait for input before start game
; 10/01/16 - Add joystick input on port 2
; 12/17/16 - REMOVE COLOR DATA FROM GAME MAPS
; 12/20/16 - Recovered back to Pac31? and added title screen information/color
; 12/20/16 - Remove Zero Page references - I hate them...
;            Update all self modifying labels to start with SM...
; 12/21/16 - More Optimization - Rename stuff and rearrange variables
;            Use @ for labels when possible
; 12/23/16 - Implementation of Attract mode off of title screen
; 12/24/16 - Implement Pre-Intro to title screen - Fixed Randomization issue
;            Corrected High Score functionality
; 12/25/16 - Correct dot counts on all challenge screen
;            Fix scoring bug score was zero after challange map
; 12/25/16  - Fix a few bugs including Superbonus reset
;           - Fix game over to return to title screen
;           - Fix NumPacs to display correct number of pacs on screen
; 1/7/17    - Add Title Screen Unlock fast map
; 1/14/17   - Add scrolling message on pre-intro screen
; 1/15/17   - This version has music on pre-intro screen ONLY
; 1/27/17   - Added in some various sound effects
; 1/29/18   - Added Background Siren
; 1/30/17   - Added in Death Sound Effect
; 2/1/17    - Reveal Dragons Wrath screen for a few seconds before blanking it out
;           - Implement Siren Ramp up as you progress through levels
;           - Turn off all sound during attract screen
;           - Bug fixes related to sound and Free Man variable not resetting
; 2/2/17    - Made eyes go a little faster to the cage
; 2/3/17    - Made ghosts exit cage a little quicker
;           - Adjusted ghost eat scoring to match arcade pac-man
; 2/4/17    - Fixed program crash and some bugs related to my code optimization
; 2/10/17   - Add in Intro and challenge screen tunes
;           - Fix siren starting late sometimes on certain maps
;           - Changed power pill and first fruit character shapes
;           - Move start position (down 2)of white ghost on 2nd challenge screen
;           - Fix bug starting game using keyboard (was not starting correct map)
; 2/11/17   - Implement Run/Stop to exit game to title screen
;           - Implment Hi Score taint indicator
; 2/12/17   - Further reduce dots on 3 of first 4 maps
;           - Fix issue where after all dots eaten pac moves one time too many
; 2/13/17   - Change they way fruits are used (bottom right)
;           - This made me have to change the way the easter egg worked
;           - Since your choices now put you further into the game
;           - Restricted how far into the game you can start with out EGG.
;           - Added Text to display championship rounds but only once per game
#region Charset & Sprites & Maps
*=$f82
incbin              "graydefender.sid"
*=$2000
charset
incbin              "charset.bin"               ; Created with CBM Char editor
*=$3000

; Pac_facing_up_mouth_open
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Pac_Facing_up_mouth_closing
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$66
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Pac_mouth_closed
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Pac_Facing_down_-_mouth_open
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$00
                    BYTE                $00

; Pac_Facing_down_-_mouth_closing
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$66
                    BYTE                $00,$00,$00
                    BYTE                $00


; Pac_Facing_left_-_mouth_open
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$7C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$1F
                    BYTE                $00,$00,$07
                    BYTE                $00,$00,$07
                    BYTE                $00,$00,$1F
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$7C
                    BYTE                $00

; Pac_Facing_left_-_mouth_closing
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$7F
                    BYTE                $00,$00,$07
                    BYTE                $00,$00,$07
                    BYTE                $00,$00,$7F
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00


; Pac_Facing_right_-_mouth_open
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3E
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$F8
                    BYTE                $00,$00,$E0
                    BYTE                $00,$00,$E0
                    BYTE                $00,$00,$F8
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3E
                    BYTE                $00

; Pac_Facing_right_-_mouth_closing
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$FE
                    BYTE                $00,$00,$E0
                    BYTE                $00,$00,$E0
                    BYTE                $00,$00,$FE
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Ghost_looking_up
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$5A
                    BYTE                $00,$00,$DB
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$A5
                    BYTE                $00

; Ghost_looking_down
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$DB
                    BYTE                $00,$00,$DB
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$A5
                    BYTE                $00

; Ghost_moving_left
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$5A
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$AB
                    BYTE                $00,$00,$55
                    BYTE                $00

; Ghost_Moving_Right
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$5A
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$D5
                    BYTE                $00,$00,$AA
                    BYTE                $00

; Eyes_looking_left
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$62
                    BYTE                $00,$00,$B5
                    BYTE                $00,$00,$F5
                    BYTE                $00,$00,$62
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$42
                    BYTE                $00

; Eyes_looking_right
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$46
                    BYTE                $00,$00,$AD
                    BYTE                $00,$00,$AF
                    BYTE                $00,$00,$46
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$42
                    BYTE                $00

; Eyes_Looking_up
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$A5
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$42
                    BYTE                $00

; Eyes_Looking_Down
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$A5
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$42
                    BYTE                $00

; Dying_Pac_Facing_Up_-_mouth_open_
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_2
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$81
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$E7
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_3
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$81
                    BYTE                $00,$00,$C3
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_4
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$FF
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_5
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$7E
                    BYTE                $00,$00,$3C
                    BYTE                $00,$00,$18
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_6
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$18
                    BYTE                $00,$00,$18
                    BYTE                $00,$00,$18
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_7
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$08
                    BYTE                $00,$00,$08
                    BYTE                $00,$00,$08
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_8
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$08
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_9
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$14
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$14
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_10
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$08
                    BYTE                $00,$00,$22
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$22
                    BYTE                $00,$00,$08
                    BYTE                $00,$00,$00
                    BYTE                $00

; Dying_Pac_Facing_Up_-_Dying_11
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$14
                    BYTE                $00,$00,$42
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$81
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$81
                    BYTE                $00,$00,$42
                    BYTE                $00,$00,$14
                    BYTE                $00

; 100_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$02,$77
                    BYTE                $00,$06,$55
                    BYTE                $00,$02,$55
                    BYTE                $00,$02,$55
                    BYTE                $00,$02,$55
                    BYTE                $00,$02,$55
                    BYTE                $00,$07,$77
                    BYTE                $00

; 200_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$07,$77
                    BYTE                $00,$01,$55
                    BYTE                $00,$01,$55
                    BYTE                $00,$07,$55
                    BYTE                $00,$04,$55
                    BYTE                $00,$04,$55
                    BYTE                $00,$07,$77
                    BYTE                $00

; 400_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$05,$77
                    BYTE                $00,$05,$55
                    BYTE                $00,$05,$55
                    BYTE                $00,$07,$55
                    BYTE                $00,$01,$55
                    BYTE                $00,$01,$55
                    BYTE                $00,$01,$77
                    BYTE                $00

; 800_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$07,$77
                    BYTE                $00,$05,$55
                    BYTE                $00,$05,$55
                    BYTE                $00,$07,$55
                    BYTE                $00,$05,$55
                    BYTE                $00,$05,$55
                    BYTE                $00,$07,$77
                    BYTE                $00

; 1600_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$26,$77
                    BYTE                $00,$64,$55
                    BYTE                $00,$24,$55
                    BYTE                $00,$27,$55
                    BYTE                $00,$25,$55
                    BYTE                $00,$25,$55
                    BYTE                $00,$77,$77
                    BYTE                $00

; 3200_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$77,$77
                    BYTE                $00,$11,$55
                    BYTE                $00,$11,$55
                    BYTE                $00,$77,$55
                    BYTE                $00,$14,$55
                    BYTE                $00,$14,$55
                    BYTE                $00,$77,$77
                    BYTE                $00

; 4000_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$57,$77
                    BYTE                $00,$55,$55
                    BYTE                $00,$55,$55
                    BYTE                $00,$75,$55
                    BYTE                $00,$15,$55
                    BYTE                $00,$15,$55
                    BYTE                $00,$17,$77
                    BYTE                $00

; 5000_point_sprite
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$77,$77
                    BYTE                $00,$45,$55
                    BYTE                $00,$45,$55
                    BYTE                $00,$75,$55
                    BYTE                $00,$15,$55
                    BYTE                $00,$15,$55
                    BYTE                $00,$77,$77
                    BYTE                $00

; Double_sized_box_for_Draagns_Wrath
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $FF,$FF,$F0
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00,$00,$00
                    BYTE                $00

*=$4000

Map1_Data

;Map_1_screen_data
                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
                    BYTE                $E3,$2A,$20,$20,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E3,$E3,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E3,$E3,$E3,$2E,$2E,$2E,$2E,$2A,$E3
                    BYTE                $E3,$2E,$E3,$20,$E3,$2E,$E3,$E3,$E3,$E3,$2E,$E3,$2E,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$20,$E3,$2E,$E3,$2E,$2E,$2E,$2E,$E3,$2E,$2E,$2E,$2E,$2E,$E3,$E3,$20,$2E,$2E,$2E,$2E,$2E,$20,$20,$E3,$20,$20,$2E,$2E,$2E,$2E,$2E,$20,$20,$E3,$2E,$E3
                    BYTE                $E3,$2E,$2E,$2E,$2E,$2E,$E3,$2E,$E3,$E3,$20,$20,$20,$E3,$20,$E3,$2E,$20,$20,$20,$E3,$E3,$20,$E3,$20,$E3,$20,$20,$20,$E3,$20,$E3,$20,$E3,$E3,$E3,$20,$E3,$2E,$E3
                    BYTE                $E3,$20,$E3,$E3,$E3,$20,$20,$2E,$E3,$E3,$E3,$E3,$20,$E3,$20,$E3,$2E,$E3,$E3,$20,$E3,$20,$20,$E3,$20,$E3,$E3,$E3,$20,$E3,$20,$E3,$20,$E3,$E3,$E3,$20,$E3,$2E,$E3
                    BYTE                $E3,$2E,$2E,$2E,$E3,$20,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$2A,$20,$20,$E3,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$E3,$20,$20,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$20,$20,$E3,$E3,$20,$E3,$E3,$E3,$20,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$E3,$20,$20,$2E,$2E,$E3,$20,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$20,$E3,$E3,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$E3,$20,$E3,$E3,$20,$E3,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$E3,$E3,$E3,$E3,$20,$E3,$2E,$E3,$E3,$20,$E3,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$20,$20,$20,$20,$20,$20,$E3,$2E,$E3,$E3,$E3,$E3,$20,$20,$20,$20,$20,$20,$20,$2E,$E3,$20,$20,$E3,$20,$E3,$E3,$E3,$E3,$E3,$E3,$20,$E3,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$E3,$20,$E3,$E3,$E3,$20,$20,$2E,$E3,$20,$20,$20,$20,$E3,$E3,$2D,$E3,$E3,$E3,$2E,$E3,$20,$E3,$E3,$20,$E3,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E3
                    BYTE                $20,$2E,$20,$2E,$E3,$20,$E3,$20,$20,$20,$E3,$2E,$E3,$20,$E3,$E3,$20,$E3,$20,$20,$20,$20,$E3,$2E,$20,$20,$20,$20,$20,$20,$2E,$E3,$20,$E3,$20,$E3,$2E,$E3,$2E,$20
                    BYTE                $E3,$2E,$E3,$2E,$E3,$20,$20,$20,$E3,$E3,$E3,$2E,$20,$20,$E3,$E3,$20,$E3,$E3,$E3,$E3,$E3,$E3,$2E,$E3,$20,$E3,$E3,$E3,$E3,$2E,$E3,$20,$20,$20,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$20,$20,$E3,$20,$20,$20,$20,$2E,$E3,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2E,$E3,$20,$E3,$E3,$E3,$E3,$2E,$E3,$E3,$E3,$E3,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$E3,$E3,$E3,$20,$E3,$20,$E3,$2E,$E3,$E3,$E3,$20,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$2E,$E3,$20,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$20,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$2E,$2E,$2E,$2E,$2E,$E3,$20,$E3,$2E,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E3,$E3,$2E,$E3,$E3,$E3,$E3,$20,$E3,$E3,$E3,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$E3,$20,$E3,$E3,$2E,$20,$20,$E3,$2E,$E3,$2E,$E3,$20,$E3,$E3,$E3,$20,$E3,$E3,$20,$E3,$E3,$E3,$2E,$E3,$2E,$2E,$2E,$2E,$2E,$E3,$2E,$2E,$2E,$20,$2E,$E3
                    BYTE                $E3,$2E,$20,$20,$20,$20,$E3,$2E,$E3,$E3,$E3,$2E,$E3,$2E,$E3,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E3,$2E,$E3,$2E,$E3,$20,$E3,$2E,$E3,$2E,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$20,$E3,$20,$20,$2E,$20,$20,$20,$2E,$20,$2E,$E3,$20,$E3,$E3,$E3,$E3,$E3,$E3,$20,$E3,$20,$20,$2E,$E3,$2E,$E3,$20,$E3,$2E,$E3,$2E,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$20,$20,$20,$E3,$2E,$E3,$E3,$E3,$2E,$E3,$2E,$E3,$20,$20,$20,$20,$20,$20,$20,$20,$E3,$20,$E3,$2E,$E3,$2E,$E3,$2E,$2E,$2E,$E3,$2E,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2E,$E3,$E3,$E3,$20,$E3,$2E,$E3,$E3,$E3,$2E,$E3,$2E,$E3,$20,$E3,$E3,$E3,$E3,$E3,$E3,$20,$E3,$20,$20,$2E,$E3,$2E,$E3,$2E,$E3,$E3,$E3,$2E,$E3,$2E,$E3,$2E,$E3
                    BYTE                $E3,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E3,$2E,$2E,$2E,$20,$2E,$2E,$2E,$2E,$2E,$E3,$2E,$2E,$2A,$E3
                    BYTE                $E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20

; Screen 2 - Map 2 Screen data
                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$6C,$67,$20,$20,$20,$6E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$6C,$2E,$2E,$2E,$2E,$2E,$2A,$A0
                    BYTE                $A0,$2E,$68,$6D,$69,$20,$6F,$2E,$70,$6D,$6D,$71,$20,$70,$71,$20,$6B,$6A,$20,$66,$20,$20,$2E,$6F,$20,$6F,$2E,$70,$6D,$6D,$71,$2E,$6C,$2E,$61,$6D,$6D,$71,$2E,$A0
                    BYTE                $A0,$2E,$6B,$64,$78,$20,$6C,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$20,$20,$6F,$2E,$6C,$20,$6E,$2E,$20,$20,$20,$2E,$2E,$6C,$2E,$6C,$2E,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$20,$20,$6C,$20,$6C,$2E,$6F,$20,$68,$6D,$6D,$69,$20,$68,$6D,$69,$2E,$6F,$20,$6E,$2E,$6C,$20,$20,$2E,$6F,$20,$6F,$2E,$68,$79,$2E,$6C,$2E,$6F,$20,$68,$A0
                    BYTE                $A0,$2E,$6F,$20,$6E,$20,$6E,$2E,$6E,$20,$6B,$64,$7E,$6A,$20,$6B,$5D,$67,$2E,$6C,$20,$20,$2E,$6C,$20,$6F,$2E,$6C,$20,$6E,$2E,$6B,$6A,$2E,$6C,$2E,$6C,$20,$65,$A0
                    BYTE                $A0,$2E,$6C,$20,$20,$20,$20,$2E,$20,$20,$20,$20,$6C,$2E,$2E,$2E,$6B,$6A,$2E,$6C,$20,$6F,$2E,$6E,$20,$6E,$2E,$6C,$20,$20,$2E,$2E,$2E,$2E,$6C,$2E,$6C,$20,$65,$A0
                    BYTE                $A0,$2E,$5E,$62,$20,$68,$69,$2E,$70,$6D,$62,$20,$6E,$2E,$6F,$2E,$2E,$2E,$2E,$6C,$20,$6C,$2E,$2E,$2E,$2E,$2E,$5E,$71,$20,$70,$6D,$62,$20,$6C,$2E,$6C,$20,$65,$A0
                    BYTE                $A0,$2E,$2E,$6C,$20,$6C,$67,$2E,$20,$20,$6C,$20,$20,$2E,$5E,$71,$20,$70,$6D,$5F,$20,$5E,$71,$20,$68,$69,$2E,$2E,$2E,$2E,$2E,$2E,$6C,$20,$6E,$2E,$6E,$20,$65,$A0
                    BYTE                $A0,$A0,$2E,$6E,$20,$6C,$67,$2E,$6F,$20,$6C,$20,$6F,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$7B,$77,$71,$20,$61,$6D,$71,$2E,$6C,$20,$20,$2E,$2E,$2E,$6B,$A0
                    BYTE                $A0,$A0,$2E,$20,$20,$6B,$78,$2E,$6C,$20,$6E,$20,$6C,$2E,$70,$62,$20,$61,$71,$2D,$70,$6D,$62,$20,$6C,$2E,$2E,$2E,$6C,$2E,$2E,$2E,$74,$71,$20,$70,$62,$2E,$2E,$A0
                    BYTE                $20,$20,$2E,$6F,$20,$20,$6E,$2E,$6C,$20,$20,$20,$6C,$2E,$2A,$6C,$20,$6C,$20,$20,$20,$20,$6C,$20,$6E,$2E,$6F,$2E,$6E,$2E,$6F,$20,$6E,$2E,$2E,$2E,$5E,$71,$2E,$20
                    BYTE                $A0,$A0,$2E,$5E,$71,$20,$20,$2E,$7A,$63,$69,$20,$6E,$2E,$70,$5F,$20,$5E,$6D,$6D,$6D,$6D,$5F,$2E,$2E,$2E,$6C,$2E,$2E,$2E,$6C,$2E,$2E,$2E,$6F,$2E,$2E,$2E,$2E,$A0
                    BYTE                $A0,$20,$2E,$2E,$20,$20,$6F,$2E,$6C,$20,$6C,$20,$20,$2E,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$2E,$6F,$20,$6E,$20,$70,$6D,$5F,$2E,$68,$7C,$73,$6D,$6D,$71,$20,$A0
                    BYTE                $A0,$20,$6F,$2E,$66,$20,$6C,$2E,$6B,$64,$6A,$20,$68,$69,$2E,$70,$6D,$6D,$62,$20,$61,$6D,$71,$2E,$6C,$20,$20,$20,$20,$20,$20,$2E,$6C,$67,$2E,$2E,$2E,$2E,$2E,$A0
                    BYTE                $A0,$20,$6C,$2E,$2E,$2E,$6C,$2E,$20,$20,$20,$20,$65,$6C,$2E,$20,$20,$20,$6C,$20,$6C,$2E,$2E,$2E,$74,$71,$20,$70,$6D,$6D,$62,$2E,$6B,$6A,$2E,$68,$63,$69,$2E,$A0
                    BYTE                $A0,$20,$6E,$20,$66,$2E,$6E,$2E,$68,$69,$20,$70,$76,$6A,$2E,$70,$71,$20,$6C,$20,$6C,$2E,$66,$20,$6E,$2E,$2E,$2E,$2E,$2E,$6C,$2E,$20,$20,$2E,$6C,$20,$6C,$2E,$A0
                    BYTE                $A0,$20,$20,$20,$20,$2E,$2E,$2E,$6C,$67,$20,$20,$20,$20,$2E,$2E,$2E,$20,$6C,$20,$6C,$2E,$20,$20,$20,$2E,$70,$6D,$62,$2E,$6E,$2E,$68,$69,$2E,$6C,$20,$6C,$2E,$A0
                    BYTE                $A0,$6D,$6D,$6D,$71,$20,$70,$6D,$76,$6A,$20,$70,$6D,$6D,$6D,$71,$2E,$68,$79,$20,$6C,$2E,$68,$7C,$71,$2E,$20,$20,$6C,$2E,$20,$2E,$6C,$67,$2E,$6C,$20,$6C,$2E,$A0
                    BYTE                $A0,$2E,$2E,$2E,$2E,$2E,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$6B,$6A,$20,$6E,$2E,$6B,$78,$2E,$2E,$6F,$20,$6C,$2E,$6F,$2E,$6C,$67,$2E,$6C,$20,$6C,$2E,$A0
                    BYTE                $A0,$2E,$70,$6D,$71,$2E,$6F,$2E,$70,$6D,$6D,$6D,$6D,$6D,$6D,$71,$2E,$20,$20,$20,$20,$2E,$2E,$6E,$2E,$70,$5F,$20,$6E,$2E,$6E,$2E,$6B,$6A,$2E,$6B,$64,$6A,$2E,$A0
                    BYTE                $A0,$2A,$2E,$2E,$2E,$2E,$6C,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$68,$63,$63,$63,$69,$2E,$2E,$2E,$20,$20,$20,$20,$2E,$2E,$2E,$20,$20,$2E,$2E,$2E,$2E,$2A,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20

;Map_3_screen_data
                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2A,$A0
                    BYTE                $A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$DE,$20,$EA,$A0,$A0,$A0,$20,$A0,$2E,$E4,$2E,$20,$2E,$EA,$A0,$EB,$20,$E4,$20,$EA,$A0,$A0,$A0,$A0,$A0,$A0,$EB,$20,$E4,$2E,$A0
                    BYTE                $A0,$2E,$A0,$20,$20,$20,$20,$DE,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$DE,$2E,$A0,$2E,$A0,$2E,$20,$20,$20,$20,$A0,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E4,$2E,$A0
                    BYTE                $A0,$2E,$A0,$20,$A0,$EB,$20,$DE,$20,$A0,$20,$EA,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$EA,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$EB,$20,$20,$2E,$A0
                    BYTE                $A0,$2E,$A0,$20,$A0,$2A,$2E,$2E,$2E,$20,$20,$20,$A0,$2E,$DE,$2E,$EA,$A0,$A0,$2E,$DE,$2E,$2E,$2E,$2E,$A0,$A0,$20,$A0,$2E,$A0,$20,$20,$20,$20,$20,$20,$A0,$2E,$A0
                    BYTE                $A0,$2E,$DE,$20,$A0,$EB,$2E,$E4,$2E,$EA,$A0,$20,$A0,$2E,$20,$2E,$20,$20,$20,$2E,$20,$20,$A0,$A0,$2E,$A0,$A0,$20,$A0,$2E,$DE,$20,$A0,$A0,$A0,$A0,$20,$A0,$2E,$A0
                    BYTE                $A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$20,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$20,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$DE,$20,$A0,$A0,$2E,$20,$20,$20,$A0,$A0,$20,$EA,$A0,$A0,$A0,$A0,$A0,$EB,$20,$A0
                    BYTE                $A0,$2E,$A0,$20,$20,$20,$20,$20,$A0,$2E,$A0,$A0,$EB,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E4,$20,$EA,$A0,$A0,$20,$DE,$2E,$2E,$2E,$A0,$20,$20,$20,$A0
                    BYTE                $A0,$2E,$DE,$20,$A0,$A0,$A0,$20,$DE,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$20,$A0,$A0,$2D,$A0,$A0,$A0,$20,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E4,$2E,$DE,$20,$EA,$A0,$A0
                    BYTE                $20,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$EA,$A0,$A0,$20,$A0,$A0,$20,$A0,$20,$20,$20,$20,$A0,$20,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$20,$A0,$2E,$2E,$2E,$2E,$2E,$20
                    BYTE                $A0,$2E,$A0,$A0,$A0,$A0,$A0,$20,$E4,$20,$20,$20,$A0,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$DE,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$CC,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2E,$A0,$A0,$2E,$E4,$2E,$A0,$20,$A0,$A0,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$DE,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$20,$E4,$20,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$20,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$EB,$20,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$20,$20,$20,$20,$20,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$20,$2E,$A0,$20,$A0,$2E,$20,$20,$A0,$A0,$EB,$20,$A0,$20,$D0,$A0,$20,$A0,$20,$20,$20,$DE,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$E4,$2E,$A0,$A0,$A0,$2E,$E4,$20,$DE,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$EB,$EB,$20,$20,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$A0,$A0,$A0,$A0,$20,$E4,$20,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$A0,$A0,$A0,$EB,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$EA,$A0,$EB,$20,$DE,$20,$EA,$A0,$A0,$A0,$A0,$A0,$EB,$20,$EA,$A0,$EB,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2A,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2A,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20

;map_4_screen_data
                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $A0,$2A,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$20,$20,$20,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2A,$A0
                    BYTE                $A0,$20,$E2,$E2,$E2,$E2,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$20,$2E,$A0,$2E,$E2,$E2,$E2,$E2,$E2,$E2,$E2,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$20,$20,$20,$E2,$E2,$E2,$20,$A0,$A0,$20,$A0,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$E2,$20,$E2,$2E,$A0,$2A,$A0,$A0,$A0,$20,$A0,$2E,$A0
                    BYTE                $A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E2,$20,$A0,$2E,$2E,$E2,$E2,$E2,$2E,$E2,$E2,$E2,$E2,$E2,$2E,$E2,$E2,$E2,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$2E,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$2E,$E2,$20,$A0,$A0,$2E,$20,$20,$20,$2E,$2E,$A0,$20,$20,$20,$2E,$20,$20,$E2,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$20,$20,$20,$20,$E2,$20,$E2,$E2,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$20,$20,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$E2,$E2,$E2,$E2,$E2,$E2,$20,$E2,$20,$20,$E2,$E2,$2E,$A0,$2E,$E2,$20,$20,$E2,$2E,$20,$20,$20,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$E2,$E2,$2E,$2E,$A0,$2E,$A0
                    BYTE                $A0,$2E,$20,$20,$E2,$20,$E2,$E2,$E2,$E2,$20,$E2,$E2,$E2,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$E2,$E2,$2E,$A0
                    BYTE                $A0,$2E,$A0,$20,$E2,$E2,$E2,$20,$20,$20,$20,$E2,$20,$E2,$2E,$A0,$20,$20,$20,$20,$20,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$20,$A0,$20,$A0,$2E,$A0,$A0,$A0,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$2E,$2E,$A0,$20,$D0,$E2,$E2,$E2,$E2,$E2,$2E,$A0,$20,$A0,$A0,$2D,$A0,$A0,$A0,$20,$E2,$E2,$2E,$2E,$2E,$A0,$20,$A0,$20,$20,$2E,$20,$20,$20,$2E,$A0
                    BYTE                $20,$2E,$E2,$2E,$E2,$2E,$A0,$20,$CF,$A0,$20,$20,$20,$2E,$2E,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$E2,$E2,$E2,$E2,$2E,$A0,$20,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$20
                    BYTE                $A0,$2E,$A0,$2E,$E2,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$E2,$E2,$20,$E2,$2E,$A0,$20,$20,$20,$20,$2E,$A0,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$20,$2E,$E2,$E2,$E2,$E2,$20,$A0,$2E,$E2,$E2,$2E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E2,$20,$E2,$2E,$A0,$20,$A0,$A0,$A0,$2E,$20,$2E,$A0,$A0,$A0
                    BYTE                $A0,$2E,$A0,$2E,$E2,$E2,$E2,$E2,$20,$E2,$2E,$2E,$E2,$2E,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$20,$E2,$20,$E2,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$E2,$2E,$20,$20,$A0
                    BYTE                $A0,$2E,$A0,$2E,$20,$20,$20,$20,$20,$E2,$E2,$2E,$E2,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$E2,$20,$E2,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$E2,$2E,$A0,$20,$A0
                    BYTE                $A0,$2E,$E2,$2E,$E2,$20,$A0,$A0,$20,$20,$E2,$2E,$2E,$2E,$20,$2E,$A0,$20,$A0,$A0,$20,$A0,$A0,$A0,$2E,$E2,$E2,$E2,$2E,$20,$20,$A0,$2E,$A0,$2E,$E2,$2E,$2E,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$E2,$20,$E2,$E2,$E2,$20,$E2,$E2,$E2,$E2,$E2,$2E,$A0,$20,$20,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$2E,$E2,$E2,$E2,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$E2,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$20,$2E,$20,$2E,$2E,$E2,$E2,$2E,$A0
                    BYTE                $A0,$2E,$20,$2E,$E2,$E2,$E2,$E2,$E2,$20,$A0,$A0,$A0,$20,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$A0,$2E,$A0,$A0,$2E,$E2,$E2,$2E,$A0
                    BYTE                $A0,$2E,$A0,$2E,$E2,$E2,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$2E,$E2,$E2,$2E,$A0
                    BYTE                $A0,$2A,$20,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20,$20,$2E,$2E,$2E,$2E,$20,$20,$2A,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20


; Screen 5 - Chaos Fruit Grab Screen data

                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9
                    BYTE                $E9,$20,$20,$20,$20,$E8,$E8,$E8,$E8,$E8,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E6,$20,$20,$20,$20,$20,$20,$20,$E6,$20,$20,$20,$20,$E6,$53,$53,$E9
                    BYTE                $E9,$20,$E8,$E8,$20,$20,$20,$20,$20,$20,$20,$E8,$E8,$E8,$E8,$E8,$E8,$20,$E8,$E8,$E6,$E6,$20,$20,$20,$E6,$E6,$E6,$20,$E6,$20,$20,$20,$E6,$E6,$20,$20,$E6,$53,$E9
                    BYTE                $E9,$20,$52,$E8,$E8,$E8,$E8,$20,$E8,$E8,$20,$E8,$E8,$E8,$20,$20,$20,$20,$51,$E8,$51,$20,$20,$E6,$20,$20,$20,$20,$20,$E6,$E6,$E6,$E6,$51,$E6,$E6,$20,$20,$20,$E9
                    BYTE                $E9,$20,$E8,$E8,$51,$E8,$E8,$20,$E8,$E8,$20,$E8,$E8,$E8,$20,$E8,$E8,$E8,$E8,$E8,$E6,$20,$E6,$E6,$20,$E6,$52,$E6,$20,$20,$20,$20,$20,$20,$20,$E6,$E6,$E6,$20,$E9
                    BYTE                $E9,$20,$E8,$20,$20,$20,$20,$20,$E8,$E8,$20,$52,$E8,$20,$20,$E8,$51,$E8,$53,$E8,$E6,$20,$E6,$E6,$20,$E6,$E6,$E6,$20,$E6,$E6,$E6,$20,$E6,$20,$20,$20,$E6,$20,$E9
                    BYTE                $E9,$20,$E8,$20,$E8,$E8,$E8,$E8,$53,$E8,$20,$E8,$E8,$20,$E8,$E8,$51,$E8,$20,$20,$20,$20,$20,$E6,$20,$E6,$E6,$20,$20,$52,$52,$E6,$20,$E6,$E6,$E6,$20,$20,$20,$E9
                    BYTE                $E9,$20,$E8,$20,$52,$52,$E8,$E8,$53,$E8,$20,$E8,$52,$20,$E8,$53,$53,$20,$20,$E8,$E6,$E6,$20,$20,$20,$20,$20,$20,$E6,$52,$E6,$E6,$20,$E6,$E6,$E6,$E6,$20,$E6,$E9
                    BYTE                $E9,$20,$E8,$20,$E8,$E8,$E8,$2E,$2E,$E8,$20,$E8,$E8,$20,$E8,$E8,$E8,$20,$E8,$20,$20,$20,$20,$E6,$E6,$20,$E6,$20,$E6,$E6,$E6,$20,$20,$52,$E6,$E6,$20,$20,$E6,$E9
                    BYTE                $E9,$20,$20,$20,$20,$20,$2E,$2E,$2E,$E8,$20,$E8,$E8,$20,$52,$E8,$E8,$20,$20,$20,$E6,$E6,$E6,$E6,$E6,$20,$E6,$20,$20,$20,$20,$20,$E6,$52,$51,$E6,$20,$E6,$E6,$E9
                    BYTE                $E9,$20,$E8,$20,$E8,$E8,$2E,$2E,$2E,$E8,$20,$20,$20,$20,$E8,$E8,$51,$20,$E8,$20,$2E,$2E,$2E,$2E,$E6,$20,$20,$20,$E6,$E6,$E6,$20,$E6,$E6,$E6,$E6,$20,$E6,$53,$E9
                    BYTE                $E9,$20,$20,$20,$E8,$E8,$E8,$E8,$E8,$E8,$20,$E8,$E8,$20,$E8,$E8,$E8,$20,$E8,$20,$E6,$53,$E6,$2E,$E6,$20,$E6,$E6,$E6,$52,$52,$20,$20,$20,$20,$20,$20,$20,$20,$E9
                    BYTE                $E9,$20,$E8,$20,$20,$20,$20,$20,$E8,$2E,$2E,$2E,$E8,$20,$E8,$2E,$2E,$20,$20,$20,$E6,$E6,$E6,$2E,$E6,$20,$E6,$E6,$E6,$E6,$E6,$E6,$52,$E6,$E6,$E6,$E6,$20,$E6,$E9
                    BYTE                $E9,$20,$E8,$E8,$E8,$E8,$E8,$20,$20,$2E,$E8,$2E,$E8,$20,$E8,$E8,$2E,$E8,$20,$E8,$E6,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E6,$E6,$E6,$E6,$2E,$2E,$E6,$20,$20,$E9
                    BYTE                $E9,$20,$E8,$51,$51,$20,$20,$20,$E8,$2E,$2E,$2E,$E8,$20,$E8,$2E,$2E,$E8,$20,$E8,$20,$20,$E6,$E6,$E6,$E6,$20,$E6,$E6,$20,$51,$51,$51,$51,$2E,$2E,$2E,$E6,$20,$E9
                    BYTE                $E9,$20,$E8,$E8,$E8,$20,$E8,$E8,$E8,$E8,$E8,$E8,$20,$20,$E8,$2E,$2E,$E8,$20,$20,$20,$E6,$E6,$2E,$2E,$E6,$20,$E6,$E6,$E6,$2E,$E6,$2E,$2E,$2E,$2E,$55,$E6,$20,$E9
                    BYTE                $E9,$20,$E8,$E8,$20,$20,$20,$20,$20,$E8,$E8,$20,$20,$E8,$E8,$53,$2E,$53,$E8,$20,$E6,$E6,$2E,$54,$2E,$E6,$20,$20,$20,$E6,$E6,$E6,$E6,$E6,$2E,$2E,$2E,$E6,$20,$E9
                    BYTE                $E9,$20,$20,$20,$20,$E8,$E8,$E8,$E8,$20,$20,$20,$E8,$E8,$51,$E8,$E8,$E8,$20,$20,$E6,$2E,$2E,$2E,$2E,$E6,$52,$E6,$20,$20,$20,$20,$20,$20,$E6,$E6,$E6,$20,$20,$E9
                    BYTE                $E9,$20,$E8,$E8,$E8,$E8,$E8,$20,$20,$20,$E8,$E8,$52,$E8,$51,$E8,$52,$E8,$20,$E8,$E6,$E6,$E6,$E6,$2E,$E6,$E6,$E6,$54,$E6,$E6,$E6,$E6,$20,$20,$20,$20,$20,$E6,$E9
                    BYTE                $E9,$20,$20,$20,$20,$20,$20,$20,$E8,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$E6,$E6,$E6,$52,$E6,$E6,$E6,$E6,$E6,$E6,$20,$20,$E9
                    BYTE                $E9,$20,$E8,$E8,$E8,$20,$E8,$E8,$E8,$E8,$51,$E8,$E8,$E8,$E8,$20,$E8,$E8,$E8,$E8,$E6,$51,$E6,$E6,$20,$E6,$20,$20,$20,$20,$20,$20,$20,$E6,$E6,$E6,$E6,$E6,$20,$E9
                    BYTE                $E9,$20,$20,$20,$20,$20,$20,$20,$E8,$E8,$51,$E8,$E8,$E8,$51,$51,$51,$E8,$E8,$51,$51,$51,$E6,$E6,$51,$E6,$51,$E6,$E6,$E6,$E6,$E6,$20,$20,$20,$20,$20,$20,$20,$E9
                    BYTE                $E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9,$E9
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20


; Dragons Wrath Screen data

                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $A0,$20,$A0,$52,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$53,$20,$20,$53,$A0
                    BYTE                $A0,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$51,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$A0,$A0,$A0,$A0,$A0,$51,$A0,$20,$20,$20,$20,$20,$20,$20,$A0,$51,$A0,$20,$A0,$52,$A0,$20,$20,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$20,$20,$20,$20,$53,$A0
                    BYTE                $A0,$20,$A0,$A0,$A0,$A0,$A0,$51,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$51,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$A0,$51,$20,$20,$20,$53,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$A0,$52,$A0,$20,$20,$20,$A0,$51,$20,$20,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$A0,$A0,$A0,$20,$A0,$53,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$20,$20,$20,$20,$A0,$20,$A0,$52,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$A0
                    BYTE                $A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$20,$20,$A0,$20,$A0,$3A,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$20,$A0,$A0,$53,$A0,$20,$20,$20,$A0,$51,$A0,$52,$A0,$3A,$A0,$20,$A0,$53,$A0,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$52,$A0,$20,$A0,$A0
                    BYTE                $A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$3A,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$51,$A0,$20,$52,$A0
                    BYTE                $A0,$A0,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$53,$53,$51,$51,$A0,$20,$20,$20,$A0,$53,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$FB,$FB,$FB,$20,$FB,$FB,$FB,$20,$FB,$FB,$FB,$20,$FB,$FB,$FB,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$53,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$A0,$A0,$20,$20,$20,$20,$A0,$20,$FB,$53,$53,$20,$FB,$3A,$FB,$20,$FB,$3A,$FB,$20,$FB,$3A,$3A,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$53,$A0,$20,$20,$A0
                    BYTE                $A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$FB,$51,$FB,$20,$FB,$FB,$FB,$20,$FB,$FB,$FB,$20,$FB,$3A,$53,$20,$20,$20,$3A,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0
                    BYTE                $A0,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$FB,$51,$FB,$20,$FB,$3A,$3A,$20,$FB,$52,$FB,$20,$FB,$3A,$3A,$20,$A0,$20,$20,$20,$A0,$58,$51,$51,$A0,$20,$20,$20,$20,$A0
                    BYTE                $A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$FB,$FB,$FB,$20,$FB,$3A,$53,$20,$FB,$51,$FB,$20,$FB,$FB,$FB,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$20,$20,$A0,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$51,$53,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0,$A0,$20,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$20,$20,$A0,$20,$A0,$20,$20,$20,$A0,$52,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$20,$20,$51,$A0,$51,$53,$20,$A0,$20,$A0,$52,$51,$20,$A0,$20,$51,$A0
                    BYTE                $A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0
                    BYTE                $A0,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$20,$20,$A0,$20,$20,$20,$20,$20,$20,$20,$53,$A0,$51,$51,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$53,$A0,$A0,$A0,$51,$A0,$A0,$20,$A0,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$57,$A0,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0

;Screen_7_Carpals_Tunnel_Screen_data
                    BYTE                $20,$20,$20,$20,$20,$13,$03,$0F,$12,$05,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$08,$09,$3A,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20
                    BYTE                $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                    BYTE                $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$FF,$FF
                    BYTE                $FF,$20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$FF,$FF
                    BYTE                $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$2E,$FF,$FF
                    BYTE                $FF,$FF,$FF,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$FF,$FF
                    BYTE                $FF,$2E,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$FF,$FF
                    BYTE                $FF,$2E,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                    BYTE                $FF,$2E,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$FF,$FF
                    BYTE                $FF,$2E,$FF,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$2E,$FF,$2E,$2E,$FF,$FF
                    BYTE                $FF,$2E,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$2E,$FF,$FF
                    BYTE                $A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0
                    BYTE                $20,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$20
                    BYTE                $A0,$2E,$FC,$9C,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$FD,$9D,$2E,$A0,$2E,$EA,$A0,$A0,$2E,$FE,$9E,$2E,$A0,$2E,$EA,$A0,$A0,$2E,$FF,$9F,$2E,$A0,$2E,$EA,$A0,$A0,$2E,$A0,$20
                    BYTE                $A0,$2E,$FC,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$FD,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$FE,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$FF,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$20,$20
                    BYTE                $A0,$2E,$FC,$2E,$EA,$A0,$EB,$2E,$A0,$A0,$2E,$FD,$2E,$EA,$A0,$EB,$2E,$A0,$A0,$2E,$FE,$2E,$EA,$A0,$EB,$2E,$A0,$A0,$2E,$FF,$2E,$EA,$A0,$EB,$2E,$A0,$A0,$2E,$A0,$A0
                    BYTE                $A0,$2E,$FC,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$FD,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$FE,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$FF,$2E,$2E,$A0,$2E,$2E,$A0,$A0,$2E,$A0,$A0
                    BYTE                $A0,$2E,$FC,$9C,$2E,$54,$2E,$EA,$A0,$A0,$2E,$FD,$9D,$2E,$55,$2E,$EA,$A0,$A0,$2E,$FE,$9E,$2E,$56,$2E,$EA,$A0,$A0,$2E,$FF,$9F,$2E,$57,$2E,$EA,$A0,$A0,$2E,$2E,$A0
                    BYTE                $A0,$2E,$FC,$2E,$2E,$FC,$2E,$2E,$A0,$A0,$2E,$FD,$2E,$2E,$FD,$2E,$2E,$A0,$A0,$2E,$FE,$2E,$2E,$FE,$2E,$2E,$A0,$A0,$2E,$FF,$2E,$2E,$FF,$2E,$2E,$A0,$A0,$EB,$2E,$A0
                    BYTE                $A0,$2E,$FC,$2E,$C2,$FC,$9C,$2E,$A0,$A0,$2E,$FD,$2E,$C3,$FD,$9D,$2E,$A0,$A0,$2E,$FE,$2E,$C4,$FE,$9E,$2E,$A0,$A0,$2E,$FF,$2E,$C5,$FF,$9F,$2E,$A0,$A0,$2E,$2E,$A0
                    BYTE                $A0,$2E,$FC,$2E,$2E,$FC,$2E,$2E,$A0,$A0,$2E,$FD,$2E,$2E,$FD,$2E,$2E,$A0,$A0,$2E,$FE,$2E,$2E,$FE,$2E,$2E,$A0,$A0,$2E,$FF,$2E,$2E,$FF,$2E,$2E,$A0,$A0,$2E,$A0,$A0
                    BYTE                $A0,$2E,$FC,$9C,$2E,$FC,$2E,$A0,$A0,$A0,$2E,$FD,$9D,$2E,$FD,$2E,$EA,$A0,$A0,$2E,$FE,$9E,$2E,$FE,$2E,$EA,$A0,$A0,$2E,$FF,$9F,$2E,$FF,$2E,$EA,$A0,$A0,$2E,$A0,$A0
                    BYTE                $A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0
                    BYTE                $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20

; Screen 9 - Title Screen Screen data
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$30,$30,$30,$30,$30,$30,$30,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$20,$20,$A0,$A0,$A0,$A0,$A0,$20,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$A0,$A0,$20,$20,$A0,$20,$A0,$A0,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$20,$A0,$A0,$20,$A0,$A0,$20,$A0,$20,$20,$20,$A0,$20,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$20,$20,$A0,$A0,$A0,$A0,$A0,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$A0,$A0,$20,$20,$A0,$A0,$A0,$20,$A0,$A0,$20,$20,$20,$20,$A0,$20,$20,$20,$A0,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$20,$20,$A0,$A0,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$20,$A0,$A0,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$04,$05,$0D,$05,$0E,$14,$09,$01,$20,$04,$05,$06,$05,$0E,$04,$05,$12,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$10,$0F,$09,$0E,$14,$13,$20,$01,$17,$01,$12,$04,$05,$04,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$51,$64,$64,$64,$64,$64,$64,$64,$31,$30,$30,$20,$20,$20,$20,$20,$20,$20,$BA,$64,$64,$64,$64,$32,$30,$30,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$52,$64,$64,$64,$64,$64,$64,$64,$32,$30,$30,$20,$20,$20,$20,$20,$20,$BA,$BA,$64,$64,$64,$64,$34,$30,$30,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$53,$64,$64,$64,$64,$64,$64,$64,$34,$30,$30,$20,$20,$20,$20,$20,$BA,$BA,$BA,$64,$64,$64,$64,$38,$30,$30,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$54,$64,$64,$64,$64,$64,$64,$64,$38,$30,$30,$20,$20,$20,$20,$BA,$BA,$BA,$BA,$64,$64,$64,$64,$31,$36,$30,$30,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$55,$64,$64,$64,$64,$64,$64,$64,$31,$36,$30,$30,$20,$20,$20,$20,$2E,$2E,$2E,$64,$64,$64,$64,$31,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$56,$64,$64,$64,$64,$64,$64,$64,$33,$32,$30,$30,$20,$20,$20,$20,$2E,$2E,$2E,$64,$64,$64,$64,$35,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$57,$64,$64,$64,$64,$64,$64,$64,$34,$30,$30,$30,$20,$20,$20,$20,$2E,$2E,$2E,$64,$64,$64,$64,$31,$30,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$58,$64,$64,$64,$64,$64,$64,$64,$35,$30,$30,$30,$20,$20,$20,$20,$20,$2A,$20,$64,$64,$64,$64,$31,$30,$30,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$51,$20,$06,$31,$2D,$0F,$10,$14,$09,$0F,$0E,$13,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$13,$10,$01,$03,$05,$20,$14,$0F,$20,$10,$0C,$01,$19,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20

Preintro
                    BYTE                $20,$20,$0B,$05,$19,$02,$0F,$01,$12,$04,$3A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$0A,$0F,$19,$13,$14,$09,$03,$0B,$3A,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$17,$20,$2D,$20,$15,$10,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$10,$0F,$12,$14,$20,$32,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$1A,$20,$2D,$20,$04,$0F,$17,$0E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$01,$20,$2D,$20,$0C,$05,$06,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$13,$20,$2D,$20,$12,$09,$07,$08,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
                    BYTE                $20,$20,$20

Pre_presskey
                    BYTE                $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$10,$12,$05,$13,$13,$20,$01,$0E,$19,$14,$08,$09,$0E,$07,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20


backst_color        byte                00,13,7,3   ; Text color of each page of backstory
backstory           text                "you play as, g-pac,  a former m>d> who&over the years has seen many, many,&cases of dementia through his practice>&you have spent the majority of your&"
                    text                "life eating poorly, but now are on a  &health crusade>  fed up, you break&into the worlds largest nutritional&center, the de beers of vitamin&"
                    text                "factories, with the intent of&collecting as many nutritional &supplements and vitamin dots, as&possible>  this is no simple task!+standing in your way, are four of &"
                    text                "your internal demons, materialized as&gmos (genetically modified organisms),&hfcs (high fructose corn syrup),&msgs (mono sodium glutamate),&"
                    text                "bpa(bisphenol)>  make your way through&the many floors of this warehouse,     &collecting as many vita dots and &nutritional supplements as possible&"
                    text                "without succumbing to your 'demons'>&you start with three lives>&you must act quickly because once>>>+the seal to the room is broken, the&vita dots "
                    text                "start to lose their&nutritional value over time, costing&you valuable points> each room is&stocked with five super antioxidant&super pills which "
                    text                "will temporarily&repel your 'demons', sending them back&to where they came from> being a&super hero is no easy job>  be smart,&be brave, be swift, "
                    text                "because that's what&it will take to save the world from&dementia>"
                    byte                00
str_spbar           byte                $A8,$93,$90,$81,$83,$85,$a0,$82,$81,$92,$a9 ;text reversed "(space bar)"
                    byte                00

#endregion
;============================================================
;  Quick code to create auto execute program from basic
;============================================================

*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $32, $36, $31, $31, $32, $00
                    byte                $00,$00
#region Program Variables
;*****************************************************
ghost_1_VARS
gh1_xg              byte                0
gh1_yg              byte                0
gh1_gx              byte                0
gh1_gy              byte                0
gh1_pr              byte                00
gh1_pr_cntr         byte                0
gh1_pq$             byte                $00,$00
gh1_pq$len          byte                00
gh1_g$              byte                $00,$00,$00,$00,$00
gh1_g$len           byte                00
gh1_pd$             byte                0
gh1_cdir            byte                0
gh1_eyesmode        byte                00
gh1_sp_pos          byte                00
gh1_bt_count        byte                50
gh1_flashon         byte                00
gh1_bluetime        byte                00
gh1_spctr           byte                00
gh1_Start_X         byte                19,19,07,19,19,19,01,19,19,19, 01,19,19,19,19,19,19
gh1_Start_Y         byte                14,14,22,14,14,14,03,14,14,14, 02,14,14,14,14,14,14
gh1_SP_X            byte                20*08,20*08,08*08,20*08,20*08,20*08,02*08,20*08,20*08,20*08, 02*08,20*08,20*08,20*08,20*08,20*08,20*08
gh1_SP_Y            byte                149,149,213,149,149,149,061,149,149,149, 53,149,149,149,149,149,149
gh1_sp_boost_goal   byte                05,07,06,06,06,06,05,05,05,05, 04,04,04,04,03,02,01
;*****************************************************
ghost_2_VARS
gh2_xg              byte                0
gh2_yg              byte                0
gh2_gx              byte                0
gh2_gy              byte                0
gh2_pr              byte                00
gh2_pr_cntr         byte                0
gh2_pq$             byte                $00,$00
gh2_pq$len          byte                00
gh2_g$              byte                $00,$00,$00,$00,$00
gh2_g$len           byte                00
gh2_pd$             byte                0
gh2_cdir            byte                0
gh2_eyesmode        byte                00
gh2_sp_pos          byte                00
gh2_bt_count        byte                50
gh2_flashon         byte                00
gh2_bluetime        byte                00
gh2_spctr           byte                00
gh2_Start_X         byte                18,18,05,18,18,18,19,18,18,18, 17,18,18,18,18,18,18 ; GHOST X, Y starting positions on each map
gh2_Start_Y         byte                12,12,03,12,12,12,08,12,12,12, 18,12,12,12,12,12,12
gh2_SP_X            byte                19*08,19*08,06*08,19*08,19*08,19*08,20*08,19*08,19*08,19*08, 18*08,19*08,19*08,19*08,19*08,19*08,19*08
gh2_SP_Y            byte                133,133,061,133,133,133,101,133,133,133, 181,133,133,133,133,133,133
Const_gh2_bt_DEF    byte                115,105, 000, 120,090,075, 000,120,090,075, 000,125,065,050,045,030,025       ; Blue time Reset counter
Const_gh2_bt_DEF2   byte                050,030, 000, 025,020,015, 000,030,020,015, 000,025,010,009,008,005,005         ; Blue time counter
Const_gh2_DEF_PR    byte                003,012, 12,11,11,10,10,09,02,07, 22,06,05,04,01,01,01        ; Priorities, give a break at high level
gh2_sp_boost_goal   byte                020,08,08,07,07,07,07,06,06,06, 18,05,05,05,04,03,01
;*****************************************************
ghost_3_VARS
gh3_xg              byte                0
gh3_yg              byte                0
gh3_gx              byte                0
gh3_gy              byte                0
gh3_pr              byte                00
gh3_pr_cntr         byte                0
gh3_pq$             byte                $00,$00
gh3_pq$len          byte                00
gh3_g$              byte                $00,$00,$00,$00,$00
gh3_g$len           byte                00
gh3_pd$             byte                0
gh3_cdir            byte                0
gh3_eyesmode        byte                00
gh3_sp_pos          byte                00
gh3_bt_count        byte                50
gh3_flashon         byte                00
gh3_bluetime        byte                00
gh3_spctr           byte                00
gh3_Start_X         byte                19,19,12,19,19,19,04,19,19,19, 22,19,19,19,19,19,19
gh3_Start_Y         byte                12,12,11,12,12,12,22,12,12,12, 06,12,12,12,12,12,12
gh3_SP_X            byte                20*08,20*08,13*08,20*08,20*08,20*08,05*08,20*08,20*08,20*08, 23*08,20*08,20*08,20*08,20*08,20*08,20*08
gh3_SP_Y            byte                133,133,125,133,133,133,213,133,133,133, 085,133,133,133,133,133,133
Const_gh3_bt_DEF    byte                120,100, 000,120,090,075, 000,120,090,075, 000,125,065,050,045,030,025       ; Blue time Reset counter
Const_gh3_bt_DEF2   byte                050,030, 000,025,020,015, 000,030,020,015, 000,020,012,010,008,005,005         ; Blue time counter
Const_gh3_DEF_PR    byte                11,10,10,10,09,10,10,09,08,07, 20,06,05,10,08,01,05        ;
gh3_sp_boost_goal   byte                020,08,08,07,07,07,07,06,06,06, 18,05,05,05,04,03,01
;*****************************************************
ghost_4_VARS
gh4_xg              byte                0
gh4_yg              byte                0
gh4_gx              byte                0
gh4_gy              byte                0
gh4_pr              byte                00
gh4_pr_cntr         byte                0
gh4_pq$             byte                $00,$00
gh4_pq$len          byte                00
gh4_g$              byte                $00,$00,$00,$00,$00
gh4_g$len           byte                00
gh4_pd$             byte                0
gh4_cdir            byte                0
gh4_eyesmode        byte                00
gh4_sp_pos          byte                00
gh4_bt_count        byte                50
gh4_flashon         byte                00
gh4_bluetime        byte                00
gh4_spctr           byte                00
gh4_Start_X         byte                20,20, 27,20,20,20,30,20,20,20, 28,20,20,20,20,20,20
gh4_Start_Y         byte                12,12, 17,12,12,12,22,12,12,12, 14,12,12,12,12,12,12
gh4_SP_X            byte                21*08,21*08, 28*08,21*08,21*08,21*08,31*08,21*08,21*08,21*08, 29*08,21*08,21*08,21*08,21*08,21*08,21*08
gh4_SP_Y            byte                133,133,173, 133,133,133,213,133,133,133, 149,133,133,133,133,133,133
Const_gh4_bt_DEF    byte                120,100, 000,120,090,075, 000,120,085,075,000,120,065,050,045,030,025       ; Blue time Reset counter
Const_gh4_bt_DEF2   byte                050,030, 000,035,020,015, 000,025,016,016,000,020,102,010,008,005,005         ; Blue time counter
Const_gh4_DEF_PR    byte                11,10,10,10,10,03,03,09,08,02, 20,06,09,04,01,02,02        ;
gh4_sp_boost_goal   byte                20,08,09,09,09,05,07,07,07,04, 19,03,03,06,04,03,01
;*****************************************************
ghost_5_VARS
gh5_xg              byte                0
gh5_yg              byte                0
gh5_gx              byte                0
gh5_gy              byte                0
gh5_pr              byte                00
gh5_pr_cntr         byte                0
gh5_pq$             byte                $00,$00
gh5_pq$len          byte                00
gh5_g$              byte                $00,$00,$00,$00,$00
gh5_g$len           byte                00
gh5_pd$             byte                0
gh5_cdir            byte                0
gh5_eyesmode        byte                00
gh5_sp_pos          byte                00
gh5_bt_count        byte                00
gh5_flashon         byte                00
gh5_bluetime        byte                00
gh5_spctr           byte                00
gh5_Start_X         byte                21,21, 29,21,21,21,19,21,21,21, 05,21,21,21,21,21,21
gh5_Start_Y         byte                12,12, 02,12,12,12,12,12,12,12, 22,12,12,12,12,12,12
gh5_SP_X            byte                22*08,22*08, 30*08,22*08,22*08,22*08,20*08,22*08,22*08,22*08, 06*08,22*08,22*08,22*08,22*08,22*08,22*08
gh5_SP_Y            byte                133,133,053, 133,133,133,133,133,133,133, 213,133,133,133,133,133,133,133
Const_gh5_bt_DEF    byte                120,110, 000,120,090,075, 000,115,090,075,000,120,065,050,045,030,025       ; Blue time Reset counter
Const_gh5_bt_DEF2   byte                050,030, 000,030,020,015 ,000,020,025,016,000,015,012,010,010,010,010         ; Blue time counter
Const_gh5_DEF_PR    byte                10,10,09,09,10,10,10,02,08,07, 29,02,05,04,01,02,02
gh5_sp_boost_goal   byte                20,10,10,09,09,09,09,04,07,07, 20,06,06,03,04,03,02
;*****************************************************
Common_Vars
xg                  byte                0
yg                  byte                0
gx                  byte                0
gy                  byte                0
ghost_pr            byte                00
pr_cntr             byte                0
pq$                 byte                $00,$00
pq$len              byte                00
g$                  byte                $00,$00,$00,$00,$00
g$len               byte                00
pd$                 byte                0
cdir                byte                0
g$eyesmode          byte                00
;*****************************************************
Const_oGh1_Boost    byte                05,07,06,06,06,06,05,05,05,05, 04,04,04,04,03,02,01 ; Used for reseting back gh1_sp_boost_goal to orig values
Const_oGh2_Boost    byte                20,08,08,07,07,07,07,06,06,06, 18,05,05,05,04,03,01
Const_oGh3_Boost    byte                20,08,08,07,07,07,07,06,06,06, 18,05,05,05,04,03,01
Const_oGh4_Boost    byte                11,10,10,10,10,03,03,09,08,02, 20,06,09,04,01,02,02
Const_oGh5_Boost    byte                20,10,10,09,09,09,09,04,07,07, 20,06,06,03,04,03,02

SND                 = 54272                                 ; Voice 1 Mem loc
SND2                = 54279                                 ; Voice 2 Mem loc
Const_UP            = $57                                   ;
Const_DOWN          = $5a                                   ;values
Const_LEFT          = $41                                   ;for up down left right
Const_RIGHT         = $53                                   ;
Const_Music         = $1000
Const_DOT_SND       = 02                                    ; DOT EAT SOUND
Const_SIREN_SND     = 17                                    ; SIREN TONE
Const_OTHER_SND     = 17                                    ; ALL OTHER SOUND EFFECTs TONE (besides dot eat snd)
Const_SIREN_VOL     = %00100000
Const_Voice1_sus    = %11110000                             ; VOice 1 Sustain volume and release value SND+6
SND_OTHER_VOL       byte                00                  ; Works with / set by Const_OTHER_SND
Const_WV_GHOST      = 15                                    ; Sound Tone for Ghost
Const_WV_EYES       = 45                                    ; Sond Tone for EYES returning to cage
Const_SPR_ROOT      = ($3000/64)                            ; Sprite data starts at $3000
Const_SC_POS        = $40c                                  ; Position of First 0 in score from left
Const_HSC_PS        = $41c
Const_CageX         = 19
Const_CageY         = 12
Const_WallDT        = 46                                    ; period '.'
Const_WallSP        = 32                                    ; space ' '
Const_WallNRG       = 42                                    ; asterisk '*'
Const_PC_CH         = 60                                    ; Pac-Clone char
Const_WLCGE         = 45                                    ; '-' this is the cage minus char
Const_MAX_MAPS      = 17                                    ; Maximum number of maps available
Const_UNLOCKED_MAP  = 16                                    ; Map unlocked with secret code max is 16 -- 17 is title screen
Const_COLORFLSH     = 3                                     ; Number of screen flashes between levels
Const_PACS          = 3                                     ; Number of Pacs you start the game with
Const_GHOST_COL     = 14                                    ; Light Blue, Dark blue is way too dark
Const_fruit1        = 81                                    ; fruit char 1
Const_fruit2        = 82                                    ; fruit 2
Const_fruit3        = 83                                    ; fruit 3
Const_fruit4        = 84                                    ; fruit 4
Const_fruit5        = 85                                    ; fruit 5
Const_fruit6        = 86                                    ; fruit 6
Const_fruit7        = 87                                    ; fruit 7
Const_fruit8        = 88                                    ; fruit 8
Const_FR_ON_SC      = $643                                  ; Physical location of fruit in center of map
Const_FR_CLR_SCR    = $da43                                 ; Color pos of fruit in center of map
Const_ENG1          = $d851                                 ; These four energizers
Const_ENG2          = $db71                                 ; are in the same positions
Const_ENG3          = $d876                                 ; on all maps
Const_ENG4          = $db96                                 ;
Const_MAP1ENG5      = $d92b                                 ; The fifth energizer moves
Const_MAP2ENG5      = $d9EE                                 ; around on the different
Const_MAP3ENG5      = $d8f5                                 ; maps
Const_MAP4ENG5      = $d8c0                                 ;
Const_Start_Backat  = 11                                    ; After all maps are completed start back at mapindex 11
                    
gxminus1            byte                00
gxplus1             byte                00
gyminus1            byte                00
gyplus1             byte                00

map_off_l           byte                $00,$28,$50,$78,$A0,$C8,$F0,$18,$40,$68,$90,$b8,$E0,$08,$30,$58,$80,$a8,$d0,$f8,$20,$48,$70,$98,$c0
map_off_h           byte                $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07
TOP_ROW_SAVE        bytes               40  ; 40 bytes reserved to save off top row

superbonus          byte                00                 ; If this value changes then no super bonus is awarded after completing all three challenges successfully.
ATTRACT_MODE        byte                00
lbl_boost           Null                'super speed!'
lbl_bonus           Null                'bonus award!'
lbl_superbonus      Null                'super bonus!'
lbl_ready           Null                'ready!'
lbl_challenge1      Null                'chaos fruit grab!'
lbl_championship    Null                'championship rounds'                    
lbl_challenge2      Null                'carpels tunnel'
lbl_challenge3      Null                'dragons wrath'
lbl_failed          Null                'failed!'
lbl_backstory       Null                ' back story  '
lbl_unlock          Null                ' more maps!! '
lbl_options         Null                ' f1-options'
lbl_gameover        Null                'finis!'

SCORE_PARAM1        byte                00
SCORE_PARAM2        byte                00

DEATH_FLAG          byte                00                  ; 1 if pac be dead
DOTS_EATEN          byte                00
TOTAL_GH_MOVES      byte                00
curr_sprite         byte                00
sprxmap             byte                $00,$02,$04,$06,$08
sprmap2             byte                %00000001,%00000010,%00000100,%00001000,%00010000
sp_gh_dir           byte                Const_SPR_ROOT+9,Const_SPR_ROOT+10,Const_SPR_ROOT+11,Const_SPR_ROOT+12   ; ghosts up down left right
sp_eye_dir          byte                Const_SPR_ROOT+15,Const_SPR_ROOT+16,Const_SPR_ROOT+13,Const_SPR_ROOT+14  ; ghost eyes up down left right
sprcolor            byte                $1, $0a, $3, $2
spreyecolor         byte                $1,$1,$1,$1,Const_GHOST_COL    ; First four are eye color, 5th digit is ghost color

;*****************************************************
; Level Defaults
; First byte is level 1, second level 2, etc.
;*****************************************************

Const_TOTAL_DOTS    byte                23,12,10,33,113,56,138                                 ; Total number of dots on each map
ACTUAL_MAP_LEVELS   byte                00,00,04,01,01,01, 06,02,02,02, 05,03,02,01,00,01,02,7 ;   Play map 0 two times, map 1 three times, etc - One extra 7 = title screen
MAP_INDEX           byte                18                                                     ; 0-16 are valid game maps, 17 is title screen, 18 is pre into screen
EnergizerColor      byte                01,01,00,02,01,02,00,01,01,01, 00,07,07,07,01,01,01    ; Energizer color for each game map
MAP_BG_COLOR        byte                12,12,00,12,08,12,06,12,12,11, 15,12,00,08,00,00,04,0  ; Middle BG color - One xtra for title screen BG color
MAP_BD_COLOR        byte                11,12,11,14,09,11,06,14,12,00, 11,00,12,00,11,12,11,0  ; Border color - one extra for title screen bd color
GAME_SPEED          byte                44,43,43,42,41,40,40,39,38,36, 42,34,32,30,28,25,20
SCORE_COLOR_MAP     byte                00,00,01,01,00,00,01,01,01,01, 01,00,01,00,01,01,01    ; Score Color used on each map
SIREN_MIN           byte                25,25,30,30,30,35,35,35,40,40, 40,45,45,45,60,70,80    ; Siren MIN, MAX, DELAY are all used
SIREN_MAX           byte                40,40,45,45,45,50,50,50,55,55, 55,60,60,60,75,85,95    ; for the sound ramp up
SIREN_DELAY         byte                05,05,04,04,04,03,03,03,03,03, 02,02,02,02,01,01,01    ; as the game progresses to higher levels
DF_Wall_Colors      byte                3,3,5,6,6,6,2,0,0,0,11,11,11,11,03,11,0,2 ;  ADDED AFTER COLOR DATA REMOVED - One extra is RED for title screen
ttl_start_level     byte                00,03,07,11,12,13,14,15             ; Level table to start game on from title screen
; ** These are used to display the fruit bottom right
fruit_posns         byte                $e7,$e6,$e5,$e4,$e3,$e2,$e1,$e0
fruit_on_levels     byte                00,01,00,02,03,04,00,05,06,07,00,08,09,10,11,12,13,14,15,16,17,18,19 ; records the order of fruits,00-indicates challenge map
Fruit_Levels_orig   byte                Const_fruit1,Const_fruit2,Const_fruit3,Const_fruit4,Const_fruit5,Const_fruit6,Const_fruit7,Const_fruit8
Fruit_Levels        byte                Const_fruit1,Const_fruit1,Const_fruit2,Const_fruit2,Const_fruit2,Const_fruit3,Const_fruit3
                    byte                Const_fruit3,Const_fruit4,Const_fruit5,Const_fruit6,Const_fruit7,Const_fruit8,Const_fruit8,Const_fruit8,Const_fruit8
                    byte                Const_fruit8,Const_fruit8,Const_fruit8

;Positions of all energizers on all maps
Energizer1Hi        byte                >Const_ENG1,>Const_ENG1,>Const_ENG1,>Const_ENG1,>Const_ENG1,>Const_ENG1,>Const_ENG1,>Const_ENG1
Energizer1Lo        byte                <Const_ENG1,<Const_ENG1,<Const_ENG1,<Const_ENG1,<Const_ENG1,<Const_ENG1,<Const_ENG1,<Const_ENG1
Energizer2Hi        byte                >Const_ENG2,>Const_ENG2,>Const_ENG2,>Const_ENG2,>Const_ENG2,>Const_ENG2,>Const_ENG2,>Const_ENG2
Energizer2Lo        byte                <Const_ENG2,<Const_ENG2,<Const_ENG2,<Const_ENG2,<Const_ENG2,<Const_ENG2,<Const_ENG2,<Const_ENG2
Energizer3Hi        byte                >Const_ENG3,>Const_ENG3,>Const_ENG3,>Const_ENG3,>Const_ENG3,>Const_ENG3,>Const_ENG3,>Const_ENG3
Energizer3Lo        byte                <Const_ENG3,<Const_ENG3,<Const_ENG3,<Const_ENG3,<Const_ENG3,Const_<ENG3,<Const_ENG3,<Const_ENG3
Energizer4Hi        byte                >Const_ENG4,>Const_ENG4,>Const_ENG4,>Const_ENG4,>Const_ENG4,>Const_ENG4,>Const_ENG4,>Const_ENG4
Energizer4Lo        byte                <Const_ENG4,<Const_ENG4,<Const_ENG4,<Const_ENG4,<Const_ENG4,<Const_ENG4,<Const_ENG4,<Const_ENG4
Energizer5Hi        byte                >Const_MAP1ENG5,>Const_MAP2ENG5,>Const_MAP3ENG5,>Const_MAP4ENG5,$d9,$d9,$d9,$d9
Energizer5Lo        byte                <Const_MAP1ENG5,<Const_MAP2ENG5,<Const_MAP3ENG5,<Const_MAP4ENG5,$2b,$2b,$2b,$2b
CHALLENGE_SCREEN    byte                00 ; If 1 then we are on a challenge map
PACMAPL             byte                <MAP1_DATA,<MAP2_DATA ,<MAP3_DATA ,<MAP4_DATA,<MAP5_DATA,<MAP6_DATA,<MAP7_DATA,<MAP8_DATA
PACMAPH             byte                >MAP1_DATA,>MAP2_DATA ,>MAP3_DATA ,>MAP4_DATA,>MAP5_DATA,>MAP6_DATA,>MAP7_DATA,>MAP8_DATA

MAP2_DATA           = MAP1_DATA+1000                        ; Address of second game map
MAP3_DATA           = MAP1_DATA+2000                        ; Address of third game map
MAP4_DATA           = MAP1_DATA+3000                        ; Address of forth game map
MAP5_DATA           = MAP1_DATA+4000
MAP6_DATA           = MAP1_DATA+5000
MAP7_DATA           = MAP1_DATA+6000
MAP8_DATA           = MAP1_DATA+7000
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
                    sta                 @SM.screen+1        
                    lda                 map_off_h,x         ; Load map hig byte into $fc
                    sta                 @SM.screen+2        
@SM.screen          lda                 $0400,y             ; Load result into acc
                    endm
;*****************************************************
; This macro checks the character at position x,y
; to see if it matches a wall or not.
;wall_chk            gx,gyminus1,Const_DOWN,Const_UP,#1
;wall_chk            gxminus1,gy,Const_RIGHT,Const_LEFT,#2;
;*****************************************************
defm                wall_chk
                    ldx                 /2                  
                    ldy                 /1                  
                    cpx                 #Const_CageY        
                    bne                 @skip1              
                    cpy                 #40                 
                    beq                 @notwall            ; I realize these next 7 lines few lines are peekaxy macro
@skip1              lda                 map_off_l,x           ; but CBM Prg Studio cannot
                    sta                 @SM.SCREEN+1        ; nest the macro calls
                    lda                 map_off_h,x         
                    sta                 @SM.SCREEN+2        
@SM.SCREEN          lda                 $0400,y

                    cmp                 #Const_WallDT       ; Is it a dot?
                    beq                 @notwall            
                    cmp                 #Const_WallSP       ; Is it a space?
                    beq                 @notwall            
                    cmp                 #Const_fruit1       ; Is it a fruit 1
                    beq                 @notwall            
                    cmp                 #Const_fruit2       ; Is it a fruit 2
                    beq                 @notwall            
                    cmp                 #Const_fruit3       ; Is it a fruit 3
                    beq                 @notwall            
                    cmp                 #Const_fruit4       ; Is it a fruit 4
                    beq                 @notwall            
                    cmp                 #Const_fruit5       ; Is it a fruit 5
                    beq                 @notwall            
                    cmp                 #Const_fruit6       ; Is it a fruit 6
                    beq                 @notwall            
                    cmp                 #Const_fruit7       ; Is it a fruit 7
                    beq                 @notwall            
                    cmp                 #Const_fruit8       ; Is it a fruit 8
                    beq                 @notwall            
                    cmp                 #Const_WallNRG      ; Is it an engerizer pill?
                    beq                 @notwall            
                    cmp                 #Const_WLCGE        ; Is it cage character '-'?
                    bne                 @bot                ; No charcters match then exit
                    lda                 g$eyesmode          ;is eyemode activated?
                    cmp                 #1                  ;Yes then allow ghost into
                    beq                 @notwall            ;the ghost cage
                                                            ; So to get to this point we are
                    lda                 /5                  ; looking at cage char, not pac-man, eyesmode off
                    beq                 @bot                ; This is saying if I am looking at the south wall
                                                            ; =ghost trying to enter cage, then do not allow entry into cage
@notwall
                    lda                 pd$                 ;Load the previous direction
                    cmp                 /3                  ;make sure ghost does not move in
                    beq                 @bottom             ;previous direction so no quick back and forth movement

                    lda                 /4                  ;Load opposite direction
                    ldx                 g$len               ;
                    sta                 g$,x                ;Store as new possible direction of travel
                    inc                 g$len               
                    lda                 /5                  ;Load Last Param either 0,1,2,3,4
                    beq                 @zero               ;0=check Up for wall
                    lda                 /5                  
                    cmp                 #1                  ;1=check Down for wall
                    beq                 @one                
                    lda                 /5                  
                    cmp                 #2                  ;2=check Left for wall
                    beq                 @two                
                    lda                 /5                  
                    cmp                 #3                  ;3=check right for wall
                    beq                 @three              
@bot                jmp                 @bottom
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
                    endm
;*****************************************************
; Move all sprites/ghosts
; Variable Initilization Part 1
;*****************************************************
defm                MACRO_Move_All
                    ldy                 #0                  
@ltlloop            lda /1,y
                    sta                 Common_Vars,y       
                    iny
                    cpy                 #18                 
                    bne                 @ltlloop            
                    jsr                 Check_Walls         
                    jsr                 MV_GHOST            
                    ldy                 #0                  
@ltlloopa           lda                 Common_Vars,y
                    sta                 /1,y                
                    iny
                    cpy                 #18                 
                    bne                 @ltlloopa           
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
                    ldx                 MAP_INDEX           ;
                    lda                 /3,x                ; Set Default Blue time
                    sta                 /4                  ; For current game level

                    lda                 #0                  
                    sta                 /6                  
                    sta                 flash_on            
                    sta                 flash_counter       
                    sta                 flash_counter2      
                    sta                 SM_flash_white_bl+1 
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
                    ldx                 MAP_INDEX           
                    dec                 /2                  ; Decrease blue time Counter
                    lda                 /2                  
                    cmp                 /4,x                ; Fewer moves of blue time left
                    bne                 @ck_zero            ; if so then change ghost
                    lda                 #1                  ; Turn on Flash
                    sta                 /6                  
                    jmp                 @quit               
@ck_zero            cmp                 #$00                ; no more blue time left?
                    bne                 @quit               ; None left then quit
                    ldx                 MAP_INDEX           
                    lda                 /3,x                ; reset the blue time
                    sta                 /2                  ; counter,
                    lda                 #0                  
                    sta                 /1                  ; turn off blue time

                    sta                 /6                  
                    jsr                 CHECK_BG_SOUND      
                    ldy                 /5                  
                    jsr                 set_gh_color2       
@quit              
                    endm
;*****************************************************
;  Compare Ghost X and Y to Pac X and Y
;  If they are equal then check blue time
;  If blue time is on then Pac-Clone eats the ghost
;  (eating ghost turns them into eyes returning to cage
;  with high priority)
;  otherwise pac-clone should die.
;
; Usage
; MACRO_Collide    spritex, spritey, gh2_bluetime, gh2_eyesmode, gh2_xg, gh2_yg, gh2_pr, gh2_pr_cntr, spriteindex,SpriteBitpos,flashon,gh2_sp_boost_goal
;*************************************************************
defm                MACRO_Collide

                    lda                 /1                  ;
                    cmp                 $d000               ; Does Ghost X = Pac X  ?
                    bne                 @botabc             ; NO
                    lda                 /2                  
                    cmp                 $d001               ; Does Ghost Y = Pac Y ?
                    bne                 @botabc             ; No

                                                            ; Check if pac is on same side of map as ghost
                    lda                 $d010               ; test bit 1 against spritebitpos should be the same
                    and                 #%00000001          ; Test first bit - Pac on right side?
                    sta                 @SM_ha+1            ;
                    lda                 $d010               ;
                    and                 /10                 ; Check ghost bit - ghost on right side?
                    beq                 @SM_ha              ;
                    lda                 #1                  ;
@SM_ha              cmp                 #$00
                    bne                 @botabc             ;

                    lda                 /3                  ; Blue time on?
                    cmp                 #1                  ;
                    beq                 @eat_ghost          ; Yes
                    lda                 /4                  ; Eyes should not kill pac-clone
                    cmp                 #1                  
                    beq                 @botabc             
                                                            ; jmp @bottom             ; Uncomment to be invincible, but also during attract mode
                    lda                 #1                  ; Pac-Clone dead now
                    sta                 DEATH_FLAG          
@botabc             jmp                 @bottom

@eat_ghost

                    ldx                 #4                  ; Decimal position for the score
                    LDA                 /10                 ; Turn off pac during ready text printing
                    eor                 $d015               
                    sta                 $d015               
                    jsr                 Ghost_Score         ; Give points for eating each ghsot
                    LDA                 /10                 ; Turn off pac during ready text printing
                    eor                 $d015               
                    sta                 $d015               

                    lda                 #0                  ; Turn off bluetime
                    sta                 /3                  
                    lda                 #1                  ; Toggle Eyesmode
                    sta                 /4                  
                    sta                 g$eyesmode          
                    ldy                 /9                  
                    ldx                 /9                  
                    lda                 #0                  
                    sta                 /11                 ; Turn flashing ghost off
                    jsr                 set_eye_color       
                    lda                 #Const_CageX        ; Tell eyes to move back
                    sta                 /5                  ; the ghost cage
                    lda                 #Const_CageY        ;
                    sta                 /6                  ; at a high priority
                    lda                 #1                  ;HIGH_PR
                    sta                 /7                  ;Change priority of eyes to always move towards priority
                    sta                 ghost_pr            
                    lda                 #0                  
                    sta                 /8                  ;Reset the Priority Counter to zero
                    lda                 #1                  
                    sta                 /12                 ;Set the boost goal to fast - move eyes a little faster
@bottom
                    endm
Ghost_Score
                    inc                 SM_GHOSTS_EATEN+1   ; GHOST GOBBLED UP
SM_GHOSTS_EATEN     lda                 #$00                ; Count Number of ghosts eaten per blue time
                    cmp                 #1                  
                    beq                 @BONUS1             
                    cmp                 #2                  
                    beq                 @BONUS2             
                    cmp                 #3                  
                    beq                 @BONUS3             
                    cmp                 #4                  ; 4 too difficult? maybe three is fun er
                    beq                 @BONUS4             
                    rts

@BONUS1             lda                 #2                        ; 200 points
                    jsr                 IncreaseScore       
                    ldx                 #Const_SPR_ROOT+$1d ; Display 200 point sprite
                    jsr                 display_bonus       
                    jsr                 display_bonus2      
                    rts
@BONUS2             lda                 #4                       ; 400 points
                    jsr                 IncreaseScore       
                    ldx                 #Const_SPR_ROOT+$1e ; Display 400 point sprite
                    jsr                 display_bonus       
                    jsr                 display_bonus2      
                    rts
@BONUS3             lda                 #8                       ; 800 points
                    jsr                 IncreaseScore       
                    ldx                 #Const_SPR_ROOT+$1f ; Display 800 point sprite
                    jsr                 display_bonus       
                    jsr                 display_bonus2      
                    jmp                 @Score              
@BONUS4             lda                 #16                      ; 1600 points
                    jsr                 IncreaseScore       
                    ldx                 #Const_SPR_ROOT+$20 ; Display 1600 point sprite
                    jsr                 display_bonus       
                    jsr                 display_bonus2      
                    jsr                 AWARD_SPEED_BONUS   ; Speed bonus after eating all 4
@Score              rts

AWARD_SPEED_BONUS
                    ldx                 MAP_INDEX           
                    cpx                 #9                  ; Was only going to enable it in early levels prior to dragons wrath
                    bcs                 @end                

                    lda                 gh1_sp_boost_goal,x 
                    cmp                 #1                  
                    beq                 @end                
                    lda                 #1                  
                    sta                 gh1_sp_boost_goal,x 
                    lda                 #0                  
                    sta                 gh1_sp_pos          
                    jsr                 print_boost         
@end                rts

display_bonus       lda                 #1
                    sta                 gobble_on           
                    sta                 SM_close_mouth+1    
                    stx                 SM_SHW_PT_VAL+1     ; Save value of point value sprite for int. to use
                    rts
display_bonus2      jsr                 SOUND_EATGHOST
                    lda                 #1                  
                    sta                 SOUND_SIREN_EYES    ; Enable EYE BALLS  BG SIREN SOUND
display_bonus2a     lda                 #0                  ; Reset back to 0 for close mouth
                    sta                 SM_SHW_PT_VAL+1     
                    lda                 #0                  
                    sta                 gobble_on           
                    rts
display_bonus3
                    jsr                 SOUND_EAT_FRUIT     
                    jmp                 display_bonus2a     


set_Nrgize_color
                    Energizer           Energizer1Lo,Energizer1Hi
                    Energizer           Energizer2Lo,Energizer2Hi
                    Energizer           Energizer3Lo,Energizer3Hi
                    Energizer           Energizer4Lo,Energizer4Hi
                    Energizer           Energizer5Lo,Energizer5Hi
                    rts

defm                Energizer
                    ldy                 MAP_INDEX           
                    lda                 ACTUAL_MAP_LEVELS,y 
                    tay
                    lda                 /1,y                
                    sta                 @nrgize+1           
                    lda                 /2,y                
                    sta                 @nrgize+2           
                    ldy                 #0                  
                    txa
@nrgize             sta                 $db00,y

@end
                    endm

set_eye_color
                    lda                 #$28                ; Ghost
                    sta                 @SM.eyec+1          ; Sprite
                    lda                 #$d0                ; color
                    sta                 @SM.eyec+2          ;

                    lda                 spreyecolor,x       
@SM.eyec            sta                 $d000,y
                    rts

set_gh_color2
                    lda                 #$28                
                    sta                 @SM.eyec2+1         
                    lda                 #$d0                
                    sta                 @SM.eyec2+2         
                    lda                 sprcolor,y          
@SM.eyec2           sta                 $d000,y
                    rts

Spr_ghostcolor
                    lda                 #$28                ; Ghost
                    sta                 @SM.eyec3+1         ; Sprite
                    lda                 #$d0                ; color
                    sta                 @SM.eyec3+2         ;

                    ldy                 #4                  
@color_lp           dey
                    lda                 sprcolor,y          
@SM.eyec3           sta                 $d000,y             
                    cpy                 #0                  
                    bne                 @color_lp           
                    rts

set_flash_color
                    lda                 #$28                ; Ghost
                    sta                 SM.eyec4+1          ; Sprite
                    lda                 #$d0                ; color
                    sta                 SM.eyec4+2          ;
SM_Flash_White_bl   lda                 #$00
                    cmp                 #1                  
                    beq                 @_blue              
                    lda                 #0                  
                    sta                 SM_Flash_White_bl+1 
                    lda                 #1                  
                    jmp                 SM.eyec4            
@_blue              lda                 #Const_GHOST_COL
SM.eyec4            sta                 $d000,y
                    rts

;*****************************************************
;* Check to see if ghost is entering /exiting cage
;* If exiting then turn off eyes mode and change ghost char
;* And reset ghost priority
; usage:
; check_cage                     gh2_eyesmode, Const_gh2_DEF_PR, gh2_pr, gh2_bluetime ,#0, Const_oGh2_Boost, gh2_sp_boost_goal, gh2_bt_count, Const_gh2_bt_DEF
;*****************************************************
defm                check_cage
                    lda                 /1                  ; Eyes mode enabled?
                    beq                 @exit               ; If not exit
                    lda                 /4                  ; Bluetime enabled?
                    cmp                 #1                  ; If so exit
                    beq                 @exit               
                    lda                 gy                  
                    cmp                 #Const_CageY        ; Is ghost in right vert position with cage
                    bne                 @exit               ; No? then exit
                    lda                 gx                  
                    cmp                 #Const_CageX        ; Is ghost in right Horiz position with cage
                    bne                 @exit               ; No? then exit

@Entering_Cage

                    lda                 /6                  ; Load in Original ghost boost speed
                    sta                 /7                  ; Save it back to boost goal variable
                    lda                 #0                  ; Ghost back in cage turn off eyes mode
                    sta                 /1                  
                    ldx                 /5                  
                    lda                 #0                  
                    sta                 g$eyesmode          
                    jsr                 Pick_Ghost_spr      
                    ldy                 /5                  
                    jsr                 set_gh_color2       
                                                            ;****fix - ghosts leaving cage had bad priority
                                                            ; Reset ghost priority when entering cage
                    jsr                 CHECK_BG_SOUND      
                    ldx                 MAP_INDEX           
                    lda                 /2,x                
                    sta                 /3                  
                    lda                 /9,x                ; Reset Blue time counter
                    sta                 /8                  
@exit              
                    endm

;*****************************************************
; This code tells the ghosts where
; Pac-clone is on the map but we dont want them
; To know where he is if bluetime is on, in fact
; this code tells the ghosts to run to the opposite
; side of the map relative to pac-clone if blue time is on
; updatexy            gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg
;*****************************************************
defm                updatexy
                    lda                 /2                  ; Check if eyes mode is on
                    cmp                 #1                  ; if Yes then dont change xy destination points
                    beq                 @bot                
                    lda                 /1                  ; Is bluetime on?
                    cmp                 #1                  ;
                    beq                 @thwart_gh          ; Yes then continue
                    lda                 gh1_gx              ; Change Dest X and
                    sta                 /3                  
                    lda                 gh1_gy              ; Dest Y values of ghost
                    sta                 /4                  ; to follow Pac-clone
                    jmp                 @bot                
@thwart_gh          lda                 gh1_gx              ; Blue time is on, so ghosts should be afraid
                    cmp                 #Const_CageX        ; of Pac-Clone. Set the Dest X and Dest Y
                    bcs                 @skip               ; values of ghost to opposite side of map
                    lda                 #39                 ; relative to Pac-Clones current position
                    sta                 /3                  
                    jmp                 @ck_y               
@skip               lda                 #1                  ; For example pac-clone is somewhere on right side of map
                    sta                 /3                  ; make ghosts move to left side setting Dest X
@ck_y               lda                 gh1_gy
                    cmp                 #Const_CageY        ;Check if pac-clone is on top side of map
                    bcs                 @skip2              
                    lda                 #24                 ;if so set Dest Y to bottom part of map
                    sta                 /4                  
                    jmp                 @bot                
@skip2              lda                 #1                  ;if not set Dest Y to top part of map
                    sta                 /4                  
@bot

                    endm
#endRegion

;============================================================
;                     Main Program
;============================================================

*=$6600
                    lda                 #0                  
                    jsr                 Const_Music         

                    lda                 #$18                ; Tell CPU
                    sta                 $d018               ; character set is $2000
                    jsr                 Init_Random         
                    lda                 #$30                
                    sta                 TOP_ROW_SAVE+34     
                    sta                 TOP_ROW_SAVE+33     
                    sta                 TOP_ROW_SAVE+32     
                    sta                 TOP_ROW_SAVE+31     
                    sta                 TOP_ROW_SAVE+30     
                    sta                 TOP_ROW_SAVE+29     
                    sta                 TOP_ROW_SAVE+28     
                    lda                 #$20                ; Space no sc taint
                    sta                 TOP_ROW_SAVE+27     

Back_to_Title
                    jsr                 TITLE_SCREEN        
                    jsr                 RESET_LEVEL         ; Reset the Game Level and set score to zero
main_prg_lp
@normal             lda                 DEATH_FLAG
                    beq                 alive               ; Yes Pacs alive
                    lda                 CHALLENGE_SCREEN    ; No Death if on Challenge Screen
                    beq                 heded               
                    jsr                 DEATH_ANIMATION     ; Animate Pac on death
                                                            ; Turn back on interrupts after challenge screen complete
                    jsr                 RESET_LEVEL         ; Reset the level
                    lda                 ATTRACT_MODE        ; Did Pac die
                    beq                 donew_level         ; during attract mode
                    lda                 #17                 ; while on a challenge screen?
                    sta                 MAP_INDEX           ; If so start back at the title
                    jmp                 Back_to_Title       

donew_level

SM_RUNSTOP          lda                 #$00
                    bne                 heded               
                    jsr                 LEVEL_UP  
                    LDA                 #0
                    STA                 DEATH_FLAG
                    jmp                 main_prg_lp         
heded
                    lda                 SM_PACS_AVAIL+1     ; This code here handles
                    bne                 @skip               ;  what happens when
                    lda                 SM_LEVEL_DONE+1     ;  run/stop is
                    beq                 @skip               ;  pressed
                    jsr                 Save_Clr_TopRow     ;
                    jsr                 RESTORE_TOP_ROW     ;
                    jmp                 @back_to_title      

@skip               jsr                 HE_DEAD            ; Nooo say it aint so...
                    jsr                 Save_Clr_TopRow     ; Save high score
                    jsr                 RESTORE_TOP_ROW     
                    lda                 SM_PACS_AVAIL+1     ; Is game over?
                    beq                 @back_to_title      
                    lda                 ATTRACT_MODE        
                    beq                 main_prg_lp         
@back_to_title      lda                 #17
                    sta                 MAP_INDEX           
                    jmp                 Back_to_Title       
alive
                                                            ;**** MOVE GHOSTS *****
                    jsr                 Move_ALL_Sprites    
SM_LEVEL_DONE       lda                 #$00
                    beq                 main_prg_lp         
                    jmp                 donew_level         

get_key             jsr                 $ffe4               ; Input a key from the keyboard
_ck_pressed         cmp                 #Const_DOWN         ; down - z pressed
                    beq                 _Move_that_Dir      
                    cmp                 #Const_Right        ; up - w pressed
                    beq                 _Move_that_Dir      
                    cmp                 #Const_LEFT         ; left - a pressed
                    beq                 _Move_that_Dir      
                    cmp                 #Const_Up           ; right - s pressed
                    beq                 _Move_that_Dir      
                    cmp                 #$54                ; T - Pressed - advance a level - cheat
                    beq                 @levelup            
                    cmp                 #$03                ; Run/Stop Pressed
                    bne                 _Chk_joystick       ;
                    LDA                 #1                  
                    STA                 DEATH_FLAG          
                    STA                 SM_RUNSTOP+1        
                    lda                 #0                  
                    sta                 SM_PACS_AVAIL+1     
                    JMP                 @nocheat            
@levelup            lda                 #1
                    sta                 SM_WAS_CHT_USED+1   
                    jsr                 CHECK_FOR_CHEAT     
@nocheat            lda                 #1
                    sta                 SM_LEVEL_DONE+1     
                    rts
_Move_that_Dir      sta                 SM_userdir+1
                    rts

.FirstInput         lda                 ATTRACT_MODE
                    bne                 RAND_DIR            
                    jsr                 $ffe4               ; These next 6 lines
                    beq                 @was_jy_pressed     ; test the keyboard
                    jmp                 _ck_pressed         ; and joystick for input
@was_jy_pressed     lda                 $dc00               ; between levels to start game
                    cmp                 #$7f                ; Nothing pressed on joystick
                    beq                 .FirstInput         ;

_Chk_joystick       lda                 $dc00               ; Input from Joystick Port 2
                    cmp                 #$7d                ; Down
                    bne                 _ck_jy_up           
_first_down         lda                 #Const_Down
                    jmp                 _Move_that_Dir      
_ck_jy_up           cmp                 #$7e                ; Up
                    bne                 _ck_jy_left         
_first_up           lda                 #Const_Up
                    jmp                 _Move_that_Dir      
_ck_jy_left         cmp                 #$7b                ; Left
                    bne                 _ck_jy_right        
_first_left         lda                 #Const_Left
                    jmp                 _Move_that_Dir      
_ck_jy_right        cmp                 #$77                ; Right
                    bne                 _no_jy_pressed      
_first_right        lda                 #Const_Right
                    jmp                 _Move_that_Dir      
_no_jy_pressed      rts

RAND_DIR            LDA                 $D41B               ; First time
                    CMP                 #5                  
                    BCC                 _got_one            
                    jmp                 RAND_DIR            
_got_one            cmp                 #1
                    beq                 _first_left         
                    cmp                 #2                  
                    beq                 _first_right        
                    cmp                 #3                  
                    beq                 _first_up           
                    jmp                 _first_right        

Pick_Map_to_Draw    sei                                     ; Fixed random char appearing on title screen

                    jsr                 PrepMap_nLevel      ; Prep Map for Next level
                    ldy                 MAP_INDEX           
                    lda                 ACTUAL_MAP_LEVELS,y 
                    beq                 @draw_map1          
                    cmp                 #1                  
                    beq                 @draw_mapaa         
                    cmp                 #2                  
                    beq                 @draw_mapab         
                    cmp                 #3                  
                    beq                 @draw_mapac         
                    cmp                 #4                  
                    beq                 @draw_5             
                    cmp                 #5                  
                    beq                 @draw_mapae         
                    cmp                 #6                  
                    beq                 @draw_mapaf         
                    jmp                 @draw_title         
@draw_mapaa         jmp                 @dm_2
@draw_mapab         jmp                 @dm_3
@draw_mapac         jmp                 @dm_4
@draw_5             jmp                 @dm_5
@draw_mapae         jmp                 @dm_6
@draw_mapaf         jmp                 @dm_7
@draw_title         jmp                 @dm_8
@draw_map1          dm_prep        MAP1_DATA           ;,Map1color
                    jmp                 @done1              
@dm_2               dm_prep        MAP2_DATA           ;,Map2color
                    jmp                 @done1              
@dm_3               dm_prep        MAP3_DATA           ;,Map3color
                    jmp                 @done1              
@done1              jsr            drawmap
                    rts
@dm_4               dm_prep        MAP4_DATA           ;,Map4color
                    jmp                 @done1              
@dm_5               dm_prep        MAP5_DATA           ;,Map5color
                    jmp                 @done1              
@dm_6               dm_prep        MAP6_DATA
                    jmp                 @done1              
@dm_7               dm_prep        MAP7_DATA
                    jmp                 @done1              
@dm_8               dm_prep        MAP8_DATA
                    jmp                 @done1              

ck_leftside
                    check_sides         #Const_Left,#$ff,#39,#9*8

ck_rightside
                    check_sides         #Const_Right,#40,#00,#00

defm                check_sides
                    lda                 cdir                
                    cmp                 /1                  ; Checking Left or right side?
                    bne                 @the_end            
                    lda                 gy                  

                    cmp                 #Const_CageY        
                    bne                 @the_end            
                    lda                 gx                  

                    cmp                 /2                  ; Check for edge
                    beq                 @wp                 
                    jmp                 @the_end            
@wp                 lda                 /3                 ; Set gx to Opposite side of map
                    sta                 gx                  

                    ldy                 curr_sprite         ;
                    lda                 #$d0                ; Warp Sprite
                    sta                 @SM.SPR+2           ;
                    lda                 sprxmap,y           ;
                    sta                 @SM.SPR+1           ;
                    lda                 $d010               
                    eor                 sprmap2,y           ; Toggle sprite past 255 flag
                    sta                 $d010               
                    lda                 /4                  ; Set Sprite X to opposite side of map
                    ldy                 #0                  
@SM.SPR             sta                 $d000,y             ;
@the_end            rts
endm


scan_dots           peekaxy             gh1_gx,gh1_gy       ; Did Pac-Clone just eat
                    cmp                 #Const_WallNRG      ; the energizer?
                    beq                 Energize            ; NO, then skip
                    cmp                 #Const_WallDT       
                    beq                 @dots               
                    jmp                 check_all_fruit     

@dots
SM_DOT_POINTS       lda                 #$01                ; 10 points
SM_DOT_DEC          ldx                 #$05                ; 4th decimal pos
                    jsr                 IncreaseScore       ; Give me points
SM_DOT_SND          LDA                 #02                 ; Product eat dot sound
                    STA                 SB                  
                    jsr                 dly4                
                    LDA                 #0                  
                    STA                 SB                  
                    jsr                 EAT_DOTS            ; Eat dots
                    jmp                 done_scan           
Energize            lda                 #2
                    sta                 SOUND_SIREN_EYES    ; Enable ENERGIZER BG SIREN SOUND
                    lda                 #1                  ; 100 points
                    ldx                 #4                  ; 4th decimal pos
                    jsr                 IncreaseScore       ; Increase score
                    jsr                 EAT_DOTS            ; Eat dots
@nolevelup          lda                 #0                  ; Reset the ghosts Eaten Counter
                    sta                 SM_GHOSTS_EATEN+1   ; Used for score purposes

                    lda                 gh2_bluetime        
                    ora                 gh3_bluetime        
                    ora                 gh4_bluetime        
                    ora                 gh5_bluetime        
                    cmp                 #1                  
                    beq                 @skip_rev           
                    jsr                 reverse_gh_dirs     
@skip_rev           jsr                 BLUE_TIME

done_scan           jsr                 space               ; Replace dots,fruit,or energizer with a space
                    rts
check_all_fruit     cmp                 #Const_Fruit1
                    beq                 @eat_fruit1         
                    cmp                 #Const_Fruit2       
                    bne                 @checkfr3           
                    jmp                 @eat_fruit2         
@checkfr3           cmp                 #Const_Fruit3
                    bne                 @checkfr4           
                    jmp                 @eat_fruit3         
@checkfr4           cmp                 #Const_Fruit4
                    bne                 @checkfr5           
                    jmp                 @eat_fruit4         
@checkfr5           cmp                 #Const_Fruit5
                    bne                 @checkfr6           
                    jmp                 @eat_fruit5         
@checkfr6           cmp                 #Const_Fruit6
                    bne                 @checkfr7           
                    jmp                 @eat_fruit6         
@checkfr7           cmp                 #Const_Fruit7
                    bne                 @checkfr8           
                    jmp                 @eat_fruit7         
@checkfr8           cmp                 #Const_Fruit8
                    bne                 done_scan           
                    jmp                 @eat_fruit8         
@eat_fruit1         lda                 #1
                    sta                 @SM_fr1+1           
                    ldy                 #4                  
                    lda                 #Const_SPR_ROOT+$1c 
                    jmp                 @finish_fruit       
@eat_fruit2         lda                 #2
                    sta                 @SM_fr1+1           
                    ldy                 #4                  
                    lda                 #Const_SPR_ROOT+$1d 
                    jmp                 @finish_fruit       
@eat_fruit3         lda                 #4
                    sta                 @SM_fr1+1           
                    ldy                 #4                  
                    lda                 #Const_SPR_ROOT+$1e 
                    jmp                 @finish_fruit       
@eat_fruit4         lda                 #8
                    sta                 @SM_fr1+1           
                    ldy                 #4                  
                    lda                 #Const_SPR_ROOT+$1f 
                    jmp                 @finish_fruit       
@eat_fruit5         lda                 #16
                    sta                 @SM_fr1+1           
                    ldy                 #4                  
                    lda                 #Const_SPR_ROOT+$20 
                    jmp                 @finish_fruit       
@eat_fruit6         lda                 #32
                    sta                 @SM_fr1+1           
                    ldy                 #4                  
                    lda                 #Const_SPR_ROOT+$21 
                    jmp                 @finish_fruit       
@eat_fruit7         lda                 #4
                    sta                 @SM_fr1+1           
                    ldy                 #3                  
                    lda                 #Const_SPR_ROOT+$22 
                    jmp                 @finish_fruit       
@eat_fruit8         lda                 #5
                    sta                 @SM_fr1+1           
                    ldy                 #3                  
                    lda                 #Const_SPR_ROOT+$23 
@finish_fruit       sta                 @SM_fr2+1
                    jsr                 space               ; Blank out the fruit on map
                    tya
                    tax
@SM_fr1             lda                 #00                 ; Point Value
                    jsr                 IncreaseScore       ; Increase score
@SM_fr2             ldx                 #00                 ; Display point sprite
                    jsr                 display_bonus       
                    jsr                 display_bonus3      
                    lda                 CHALLENGE_SCREEN    
                    beq                 @dontdisplay        ; On non challenge screen, fruit it not counted toward total dots eaten
                    jsr                 EAT_DOTS            ; Eat dots
@dontdisplay        rts

#region MAIN PROGRAM SUBS
UNLOCKED            byte 00
F1_WAS_PRESSED
                    lda                 #0                  
                    sta                 TURN_ON_ATTRACT     ; Reset the attract counter
                    jsr                 TITLE_CLR_EFFECT    ; Flash the text as F1 is pressed
SM_F1_INDEX         ldy                 #$00
                    iny
                    
                    lda                 UNLOCKED
                    beq @notunlocked
                     
                    cpy                 #8                  
                    beq                 @dsp_backstory      
                    cpy                 #$Fe                
                    bne @more_ck
                    ldy #7
                    
@more_ck            cpy                 #9                  
                    bne                 @chg_fruit          
                    jmp                 @dsp_backstory
 
@notunlocked        cpy                 #4                  
                    beq                 @dsp_backstory      
                    cpy                 #5                  
                    bne                 @chg_fruit          
                    
@dsp_backstory      jsr                 TITLE_SEL_BK_ST
                    ldy                 #$FF                
                    jmp                 @skip               
@chg_fruit          lda                 Fruit_Levels_orig,y
                    sta                 $7a6                                    
                    jsr                 char_color                        
                    sta                 $dba6               
                    jsr                 TITLE_Options       
@skip               sty                 SM_F1_INDEX+1                
                    rts
                    
TITLE_SCREEN
                    ldx                 MAP_INDEX           
                    cpx                 #18                 ; Title Screen
                    bcc                 @title_screen       
                    jsr                 DRAW_INTRO          

@title_screen       jsr                 Pick_Map_to_Draw
                    jsr                 Set_Interrupt       
                    jsr                 RESET_TITLE_VARS    
                    ldx                 MAP_INDEX           
                    cpx                 #17                 
                    bcc                 BEGIN_GAME         ; Begin Game on map index chosen
                    lda                 #1                  
                    sta                 INT_TTLSCN_ACTIVE   ; TITLE SCREEN IS ACTIVE
                    jsr                 FIX_TITLE_COLORS    
                    lda                 #0                  
                    sta                 SM_F1_INDEX+1       
@loop
                    jsr                 $ffe4               
                    cmp                 #$20                ; Space pressed?
                    beq                 @Start_Game         
                    cmp                 #$85                ; F1 Pressed?
                    beq                 @F1_PRESSED         
                    lda                 $dc00               ; Check joystick
                    cmp                 #$7e                
                    beq                 @s_code             
                    cmp                 #$7d                
                    beq                 @s_code             
                    cmp                 #$7b                ; Left (for unlock)
                    beq                 @s_code             
                    cmp                 #$77                ; Right (for unlock)
                    beq                 @s_code             
                    cmp                 #$6f                
                    beq                 @Start_Game         
                    lda                 TURN_ON_ATTRACT 
                    cmp                 #60                 
                    bne                 @loop               
                    jmp                 ENABLE_ATTRACT      
@s_code
                    ldy                 UNLOCKED            
                    cpy                 #$01 
                    beq                 @F1_PRESSED        
                    jsr                 SAVE_CODE           ; Save key sequence pressed
                    jsr                 CHK_SECRET          ; check if secret sequence been exectued?
                    cpx                 #6                  ; 6 = YES, ALL 6 sequences executed in order
                    bne                 @F1_PRESSED         
                    jsr                 TITLE_UNLOCK        ; Display text on screen to indicated unlock
                    jsr                 TURN_ON_ALL_SOUNDS 
                    jsr                 SOUND_LVL_UNLOCK    ; Secret Code Unlock Sound
                    lda                 #1 
                    sta                 UNLOCKED
                    lda                 #$FD               ; $FE indicates fast map was unlocked
                    sta                 SM_F1_INDEX+1       
                    jmp @loop
@F1_PRESSED         jsr                 F1_WAS_PRESSED
                    jmp                 @loop               

@Start_Game         ldy                 SM_F1_INDEX+1       ; Which selection is F1 on
                    cpy                 #$ff                ; Back story?
                    beq                 Print_Backstory     
                    cpy                 #$fd                ; WAS FAST MAP UNLOCKED?
                    bne                 @not_unlocked       
                    lda                 #Const_UNLOCKED_MAP 
                    sta                 MAP_INDEX           
                    jmp                 BEGIN_GAME  

@not_unlocked       lda                 ttl_start_level,y
                    sta                 MAP_INDEX           

BEGIN_GAME
                    LDX                 MAP_INDEX           
                    beq                 @lvl1               
                    lda                 #1                  
                    jmp                 @NOTlvl1            
@lvl1               lda                 #0
@NOTlvl1            sta                 SM_WAS_CHT_USED+1   ; Indicate hi score was not from game started from first map
                    lda                 #$EA                ; For normal gameplay
                    sta                 SM_ATT_INT          ; We dont need to check
                    sta                 SM_ATT_INT+1        ; For run/stop to exit attract mode
                    sta                 SM_ATT_INT+2        ;
                    lda                 #0                  
                    sta                 INT_TTLSCN_ACTIVE   ; TITLE SCREEN IS ACTIVE
                    jsr                 Pick_Map_to_Draw    
                    jsr                 REST_TTL_HI2        
                    jsr                 Set_Interrupt       
                    lda                 #0                  ; Turn off Attract Mode
                    sta                 ATTRACT_MODE        
                    sta                 SM_frtpl_ctr+1      
                    sta                 SM_TTL_GH+1         
                    sta                 TOTAL_GH_MOVES      
                    sta                 DOTS_EATEN          
                    jsr                 TURN_ON_ALL_SOUNDS  
                    rts

Print_Backstory     jsr                 Display_Back_Story
                    jmp                 TITLE_SCREEN        

ENABLE_ATTRACT      lda                 #0                 ; Enable Attract mode          
                    sta                 TURN_ON_ATTRACT     
                    lda                 #1                  
                    sta                 ATTRACT_MODE        
                    sta                 SM_WAS_CHT_USED+1   ; Indicate hi score is non human
                    jsr                 TURN_OFF_ALL_SOUNDS 
                    jsr                 sound_off           
                    lda                 #$20                ; During Attract mode
                    sta                 SM_ATT_INT          ; Enable JSR ATTRACT_INTERRUPT
                    lda                 #<ATTRACT_INTERRUPT ; to check for run/stop
                    sta                 SM_ATT_INT+1        ; to quit attract_mode
                    lda                 #>ATTRACT_INTERRUPT 
                    sta                 SM_ATT_INT+2        

@RANDs              LDA                 $D41B               ; Select a random MAP to start on
                    CMP                 #Const_MAX_MAPS     
                    BCC                 @got_one            ;
                    jmp                 @RANDs              

@got_one            sta                 MAP_INDEX
                    lda                 #0                  
                    sta                 INT_TTLSCN_ACTIVE   ; TITLE SCREEN IS ACTIVE
                    jsr                 Pick_Map_to_Draw    
                    jsr                 REST_TTL_HI2        
                    jsr                 Set_Interrupt       
                    rts

SAVE_CODE           pha
                    lda                 SECRET_CODE+1       
                    sta                 SECRET_CODE         
                    lda                 SECRET_CODE+2       
                    sta                 SECRET_CODE+1       
                    lda                 SECRET_CODE+3       
                    sta                 SECRET_CODE+2       
                    lda                 SECRET_CODE+4       
                    sta                 SECRET_CODE+3       
                    lda                 SECRET_CODE+5       
                    sta                 SECRET_CODE+4       
                    pla
                    sta                 SECRET_CODE+5       
                    rts
CHK_SECRET          ldx                 #0
@loop               lda                 SECRET_CODE,x
                    cmp                 UNLOCK,x            
                    bne                 @rtn                
                    inx
                    cpx                 #6                  
                    bne                 @loop               
@rtn                rts


Display_Back_Story
                    lda                 #0                  ; Turn off interrupt
                    sta                 INT_TTLSCN_ACTIVE   
                    sta                 ENG_FLASH_ON        
                    lda                 #0                  ; Reset page color
                    sta                 backst_color        
                    lda                 #11                 ; Change background and border colors
                    sta                 53281               
                    sta                 53280               
                    jsr                 @set_tex_color      
                    jsr                 $e544               ; Clear screen
                    lda                 #<backstory         
                    sta                 @SM_backstory+1     
                    lda                 #>backstory         
                    sta                 @SM_backstory+2     
@SM_backstory       lda                 backstory
                    cmp                 #$26                ; End of line separator
                    beq                 @print_eol          
                    cmp                 #$00
                    beq                 @end_of_story       
                    cmp                 #$2b                ; Read the '+' = end of page
                    beq                 @end_of_page        
                    jsr                 $ffd2               
@into_loop          inc                 @SM_backstory+1
                    lda                 @SM_backstory+1 
                    bne                 @SM_backstory       
                    inc                 @SM_backstory+2     
                    jmp                 @SM_Backstory       
@print_eol          lda                 #13
                    jsr                 $ffd2               
                    jsr                 $ffd2               
                    jmp                 @into_loop          
@end_of_story       jsr                 @Display_sb
                    lda                 #1                  ; Turn on chomp
                    sta                 INT_TTLSCN_ACTIVE   
                    jsr                 $ffe4               ; Clear kbd buffer otherwise
                    jsr                 $ffe4               ; Pressing space will start game
                    jsr                 $ffe4               
                    rts

@end_of_page        jsr                 @Display_sb
                    jsr                 @set_tex_color      
                    jmp                 @into_loop          
@Display_sb         ldy                 #0                  ; Print space bar text
@lp                 lda                 str_spbar,y
                    beq                 @sub                
                    sta                 $7ce,y              
                    lda                 #0                  
                    sta                 $dbce,y             
                    iny
                    jmp                 @lp                 
@sub                lda                 $dc01               ; Wait for space bar or run/stop
                    cmp                 #255                
                    bne                 @pressed            
                    lda                 $dc00               ; Wait for any joystick press
                    cmp                 #$7f                
                    beq                 @sub                

@pressed            JSR                 $E544               ; Clear the screen
                    rts
@set_tex_color      inc                 backst_color        ; Change the page text color
                    ldx                 backst_color        
                    lda                 backst_color,x      
                    sta                 646                 
                    rts
TITLE_Options
                    ldx                 #0                  
@loop               lda                 lbl_options,x
                    sta                 $7a7,x              
                    inx
                    cpx                 #11                 
                    bne                 @loop               
                    rts

TITLE_SEL_BK_ST
                    ldx                 #0                  
@loop               lda                 lbl_backstory,x
                    sta                 $7a6,x              
                    inx
                    cpx                 #13                 
                    bne                 @loop               
                    rts
TITLE_UNLOCK
                    ldx                 #0                  
@loop               lda                 lbl_unlock,x
                    sta                 $7a6,x              
                    inx
                    cpx                 #13                 
                    bne                 @loop               
                    rts
TITLE_CLR_EFFECT
                    jsr                 TITLE_CLR_SUB       
                    ldy                 #30                 
@loop               jsr                 dly4
                    dey
                    bne                 @loop               
                    rts

TITLE_CLR_SUB
                    ldx                 #0                  
@loop               lda                 lbl_options+1,x
                    ora                 #128                
                    sta                 $7a8,x              
                    inx
                    cpx                 #10                 
                    bne                 @loop               
                    rts
FIX_TITLE_COLORS
                    ldy                 #18                 
@newcolors          lda                 #7                  ; Yellow
                    sta                 $d99a,y             ; Dementia defender text
                    sta                 $dbcd,y             ; Space to play chars
                    lda                 #3                  ; Cyan
                    sta                 $dba6,y             ; f1 options text
                    lda                 #1                  
                    sta                 $d9ec,y             ; White points awarded text
                    dey
                    bne                 @newcolors          
                    sta                 $db5f               ; Make Power Pill white
                    lda                 #7                  
                    sta                 $d8e8               ; Make power
                    sta                 $d8e9               ; pill dot
                    sta                 $d910               ; yellow
                    sta                 $d911               ;
                    lda                 #3                  ; 1 pt. CYAN Fix Dot Colors TTL Scn
                    sta                 $dae6               
                    sta                 $dae7               
                    sta                 $dae8               
                    lda                 #4                  ; 5 pts. Fix Dot Colors TTL scn
                    sta                 $db0e               
                    sta                 $db0f               
                    sta                 $db10               
                    rts
DRAW_INTRO

                    ldy                 #$00                
@map_loop           lda                 MAP8_DATA,y
                    sta                 $400,y              
                    jsr                 char_color          
                    sta                 $d800,y             
                    cpy                 #200                
                    bcs                 @skip               
                    lda                 MAP8_DATA+256,y     
                    sta                 $0500,y             
                    jsr                 char_color          
                    sta                 $d900,y             
@skip               iny

                    bne                 @map_loop           
                    lda                 #$20                
                    sta                 $410                
                    sta                 $411                
                    sta                 $412                
                    sta                 $413                
                    sta                 $414                
                    sta                 $415                
                    sta                 $416                
                    jsr                 FIX_TITLE_COLORS    
                    ldy                 #0                  
@loop2              lda                 Preintro,y
                    sta                 $630,y              
                    lda                 #1                  
                    sta                 $da30,y             
                    iny
                    bne                 @loop2              
                    ldy                 #39                 
@loop3              lda                 Pre_presskey,y
                    sta                 $798,y              
                    lda                 #10                 
                    sta                 $da30,y             
                    lda                 #13                 
                    sta                 $db98,y             

                    dey
                    bne                 @loop3              
                    lda                 #17                 
                    sta                 MAP_INDEX           

@loop
                    jsr                 Const_Music+3       
                    jsr                 Scroll_Message      
                    jsr                 ATTRACT_INTERRUPT   
                    lda                 DEATH_FLAG          
                    beq                 @loop               

 ;                   inc                 CNTR                                    
 ;                   lda                 CNTR                
 ;                   cmp                 #200                
 ;                   bne @loop
                    
                    jsr                 SOUND_OFF           
                    jsr                 Init_Random         
                    jsr                 $ffe4               
                    jsr                 $ffe4               
                    jsr                 $ffe4               
                    rts
;CNTR    byte 00                    
RESET_TITLE_VARS
                    lda                 #$60                ; Do not Execute the shadow sprite code for chlnge screen EA is NOP instruction
                    sta                 SM_Challenge        
                    lda                 #Const_PACS         
                    sta                 SM_PACS_AVAIL+1     
                    lda                 #0  
                    sta                 print_champ+1       ; Reset championship text to print on a new game
                    sta                 SM_RUNSTOP+1        
                    sta                 SM_ST_OF_GAME+1     ; Turn on INTRO SONG for start of game
                    sta                 DOTS_EATEN          
                    sta                 SM_TTL_DOTS+1       
                    sta                 SM_FREE_MAN+1       
                    sta                 flash_counter4      
                    sta                 $d015               ; Turn off all sprites
                    sta                 DEATH_FLAG          
                    sta                 SM_frtpl_ctr+1      
                    sta                 superbonus          
                    sta                 gh2_flashon         
                    sta                 gh3_flashon         
                    sta                 gh4_flashon         
                    sta                 gh5_flashon         
                    sta                 flash_on            
                    sta                 SM_TTL_GH+1         
                    sta                 TOTAL_GH_MOVES      
                    sta                 DOTS_EATEN          
                    sta                 SM_FRT_CNTR+1       
                    sta                 SM_frtpl_ctr+1      
                    jsr                 Reset_HIGH_SMs      
                    jsr                 REST_TTL_HI         
                    rts

Move_ALL_Sprites
                    inc                 SM_spr_cntr+1       ; Keep track of each sprite moving 8 pixels at a time
                    jsr                 Boost_Algorithm     
;_Normal_Flow
                    jsr                 Move_Sprite1        
                    lda                 SM_LEVEL_DONE+1     ; Need to pop out of this back up a level in the case
                    beq                 SM_ATT_INT          ; ALL DOTS ARE consumed on a map and level is complete
                    rts

SM_ATT_INT          jsr                 ATTRACT_INTERRUPT   ; Check if interruption during attract mode

                    jsr                 delay_5             
ifdef               MOVING_SPRITES

                    jsr                 Move_Sprite2        
                    jsr                 delay_5             
                    jsr                 Move_Sprite3        
                    jsr                 delay_5             
                    jsr                 Move_Sprite4        
                    jsr                 delay_5             
                    jsr                 Move_Sprite5        
                    jsr                 delay_5             
else
                    jsr                 delay_5             
                    jsr                 delay_5             
                    jsr                 delay_5             
                    jsr                 delay_5             
endif

                    lda                 DEATH_FLAG          ;If dead, dont continue moving sprites
                    cmp                 #1                  
                    bne                 @cont1              
                    rts
@cont1              jsr                 get_key

SM_spr_cntr         lda                 #$00
                    cmp                 #8                  
                    bne                 @back_to_top        
                    lda                 #0                  
                    sta                 SM_spr_cntr+1       
                    rts
@back_to_top        jmp                 Move_ALL_Sprites

Move_Sprite1

                    Move_Sprite         gh1_cdir,gh1_pd$,gh1_spctr,$d000,$d001,#%00000001,gh1_sp_pos
SM_Challenge        rts
;****************** CODE BELOW only EXECUTES DURING CHALLENGE 'Dragons wrath' SCREEN ***********
;                   This code sort of emulates Atari 2600 Adventure catacombs
                    lda                 $d010               ; Move challenge sprite
                    and                 #%00000001          ; copying position of gpac
                    beq                 @notpast255         ;including code for past
                    lda                 $d010               ; the 255 position toggle
                    ora                 #%00100000          ; set bit to past 255
                    jmp                 @sk_sv              ;
@notpast255         lda                 $d010               ;
                    and                 #%11011111          ; clear the 255 bit for
@sk_sv              sta                 $d010               ; sprite 6
                    lda                 $d000               ;
                    sta                 $d00a               ;
                    lda                 $d001               ;
                    sta                 $d00b               ;
                    rts
;*******************************************************************************
Move_Sprite2
                    Move_Sprite         gh2_cdir,gh2_pd$,gh2_spctr,$d002,$d003,#%00000010
                    rts
Move_Sprite3
                    Move_Sprite         gh3_cdir,gh3_pd$,gh3_spctr,$d004,$d005,#%00000100
                    rts
Move_Sprite4
                    Move_Sprite         gh4_cdir,gh4_pd$,gh4_spctr,$d006,$d007,#%00001000
                    rts
Move_Sprite5
                    Move_Sprite         gh5_cdir,gh5_pd$,gh5_spctr,$d008,$d009,#%00010000
                    rts

;*************************************************************
; Each sprite has a counter, once a certain number is reached
; give the ghost a boost in speed, this value is determined
; by the current level played.
;*************************************************************
Boost_Algorithm
                    inc                 gh1_sp_pos          
                    lda                 gh1_sp_pos          
                    ldy                 MAP_INDEX           
                    cmp                 gh1_sp_boost_goal,y 
                    bne                 @check2             
                    lda                 #0                  
                    sta                 gh1_sp_pos          
                    jsr                 Move_Sprite1        
@check2
                    lda                 gh2_eyesmode        
                    cmp                 #1                  
                    beq                 @fasteyes1          
                    inc                 gh2_sp_pos          
                    inc                 gh2_sp_pos          

                    lda                 gh2_sp_pos          
                    LDY                 MAP_INDEX           
                    cmp                 gh2_sp_boost_goal,y 
                    bne                 @check3             

                    jsr                 Move_Sprite2        
                    jmp                 @reset1             

@fasteyes1
                    jsr                 Move_Sprite2        
                    jsr                 Move_Sprite2        

@reset1             lda                 #0
                    sta                 gh2_sp_pos          

@check3             lda                 gh3_eyesmode
                    cmp                 #1                  
                    beq                 @fasteyes2          
                    inc                 gh3_sp_pos          
                    inc                 gh3_sp_pos          
                    lda                 gh3_sp_pos          
                    LDY                 MAP_INDEX           
                    cmp                 gh3_sp_boost_goal,y 
                    bne                 @check4             
                    jsr                 Move_Sprite3        
                    jmp                 @reset2             
@fasteyes2          jsr                 Move_Sprite3
                    jsr                 Move_Sprite3        

@reset2             lda                 #0
                    sta                 gh3_sp_pos          

@check4             lda                 gh4_eyesmode
                    cmp                 #1                  
                    beq                 @fasteyes3          
                    inc                 gh4_sp_pos          
                    inc                 gh4_sp_pos          
                    lda                 gh4_sp_pos          
                    LDY                 MAP_INDEX           
                    cmp                 gh4_sp_boost_goal,y 
                    bne                 @check5             
                    jsr                 Move_Sprite4        
                    jmp                 @reset3             
@fasteyes3          jsr                 Move_Sprite4
                    jsr                 Move_Sprite4        

@reset3             lda                 #0
                    sta                 gh4_sp_pos          
@check5             lda                 gh5_eyesmode
                    cmp                 #1                  
                    beq                 @fasteyes4          
                    inc                 gh5_sp_pos          
                    lda                 gh5_sp_pos          
                    cmp                 gh5_sp_boost_goal   
                    bne                 @done               

                    jsr                 Move_Sprite5        
                    jmp                 @reset4             
@fasteyes4          jsr                 Move_Sprite5
                    jsr                 Move_Sprite5        
@reset4             lda                 #0
                    sta                 gh5_sp_pos          
@done               rts
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
                    MACRO_Collide       $d002,$d003,gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg,gh2_pr,gh2_pr_cntr,#0,#%0000010,gh2_flashon,gh2_sp_boost_goal
                    MACRO_Collide       $d004,$d005,gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg,gh3_pr,gh3_pr_cntr,#1,#%0000100,gh3_flashon,gh3_sp_boost_goal
                    MACRO_Collide       $d006,$d007,gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg,gh4_pr,gh4_pr_cntr,#2,#%0001000,gh4_flashon,gh4_sp_boost_goal
                    MACRO_Collide       $d008,$d009,gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg,gh5_pr,gh5_pr_cntr,#3,#%0010000,gh5_flashon,gh5_sp_boost_goal
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
                    lda                 #0                  ; Open mouth when moving, fixes
                    sta                 SM_close_mouth+1    ; issues where pac starts out pointing up

@_gh2               jmp                 @gh1

@_skipfew           inc                 /3
@mv_Spritesub       lda                 /1
                    cmp                 #Const_LEFT         
                    beq                 @sp_left            
                    cmp                 #Const_Right        
                    beq                 @sp_right           
                    cmp                 #Const_UP           
                    beq                 @sp_up              
                    cmp                 #Const_DOWN         
                    beq                 @sp_down            
                    jmp                 @_lt                
@sp_up
                    dec                 /5                  
                    jmp                 @_lt                
@sp_down
                    inc                 /5                  
                    jmp                 @_lt                
@sp_right
                    inc                 /4                  
                    lda                 /4                  
                    bne                 @_rt                
                    lda                 $d010               
                    eor                 /6                  
                    sta                 $d010               
@_rt                jmp                 @_lt
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
                    beq                 @gh1                
                    cmp                 #%0000010           ;Ghost 1
                    beq                 @gh2                
                    cmp                 #%0000100           ;Ghost 2
                    beq                 @gh3                
                    cmp                 #%0001000           ;Ghost 3
                    beq                 @gh4                
                    cmp                 #%0010000           ;Ghost 4
                    beq                 @gh5                

@gh1                jsr                 Collisions          
                    jsr                 mov_ghost1          
                    jmp                 @exit_sprite        
@gh2                jsr                 Collisions
                    jsr                 mov_ghost2          
                    jmp                 @exit_sprite        
@gh3                jsr                 Collisions
                    jsr                 mov_ghost3          
                    jmp                 @exit_sprite        
@gh4                jsr                 Collisions
                    jsr                 mov_ghost4          
                    jmp                 @exit_sprite        
@gh5
                    jsr                 Collisions          
                    jsr                 mov_ghost5          
@exit_sprite        jsr                 Collisions
                    endm

mov_ghost1
@normal             jsr                 scan_dots
@cont               lda                 ATTRACT_MODE        ; These two lines control if Attract_mode is 1 then
                    bne                 @attracton          ; Move pac-clone around randomly
                    lda                 #1                  
                    sta                 SM_ispacman+1       
                    lda                 #0                  
                    sta                 gh1_pd$             
                    jmp                 @skipatt            
@attracton          lda                 #0
                    sta                 gobble_on           


@skipatt            lda #0
                    sta                 curr_sprite         
                    MACRO_Move_All      ghost_1_vars        
                                                            ;***********************************************
                                                            ;** Make ghosts follow Pac-CLone
                    updatexy            gh2_bluetime,gh2_eyesmode,gh2_xg,gh2_yg
                    updatexy            gh3_bluetime,gh3_eyesmode,gh3_xg,gh3_yg
                    updatexy            gh4_bluetime,gh4_eyesmode,gh4_xg,gh4_yg
                    updatexy            gh5_bluetime,gh5_eyesmode,gh5_xg,gh5_yg

                    lda                 #0                  
                    sta                 SM_ispacman+1       
                    rts

ATTRACT_INTERRUPT   lda                 $dc01               ; Check Run/stop or SPACE BAR
                    cmp                 #$ff                
                    beq                 @chk_joystick       
@set_death          lda                 #1
                    sta                 DEATH_FLAG                      
                    rts
@chk_joystick       lda                 $dc00              ; Check if anything input from joystick
                    cmp                 #$7f                
                    bne                 @set_death          
                    rts
mov_ghost2
                    lda                 #1                  
                    sta                 curr_sprite         
                    MACRO_Move_All      ghost_2_vars        
                    check_cage          gh2_eyesmode,Const_gh2_DEF_PR,gh2_pr,gh2_bluetime,#0,Const_oGh2_Boost,gh2_sp_boost_goal,gh2_bt_count,Const_gh2_bt_DEF
                    check_btime         gh2_bluetime,gh2_bt_count,Const_gh2_bt_DEF,Const_gh2_bt_DEF2,#0,gh2_flashon
                    jsr                 Count_GH_Moves      
                    rts
mov_ghost3                                  
                    lda                 #2                  
                    sta                 curr_sprite         
                    MACRO_Move_All      ghost_3_vars        
                    check_cage          gh3_eyesmode,Const_gh3_DEF_PR,gh3_pr,gh3_bluetime,#1,Const_oGh3_Boost,gh3_sp_boost_goal,gh3_bt_count,Const_gh3_bt_DEF
                    check_btime         gh3_bluetime,gh3_bt_count,Const_gh3_bt_DEF,Const_gh3_bt_DEF2,#1,gh3_flashon
                    rts
mov_ghost4             
                    lda                 #3                  
                    sta                 curr_sprite         
                    MACRO_Move_All      ghost_4_vars        
                    check_cage          gh4_eyesmode,Const_gh4_DEF_PR,gh4_pr,gh4_bluetime,#2,Const_oGh4_Boost,gh4_sp_boost_goal,gh4_bt_count,Const_gh4_bt_DEF
                    check_btime         gh4_bluetime,gh4_bt_count,Const_gh4_bt_DEF,Const_gh4_bt_DEF2,#2,gh4_flashon
                    rts
mov_ghost5
                    lda                 #4                  
                    sta                 curr_sprite         
                    MACRO_Move_All      ghost_5_vars        
                    check_cage          gh5_eyesmode,Const_gh5_DEF_PR,gh5_pr,gh5_bluetime,#3,Const_oGh5_Boost,gh5_sp_boost_goal,gh5_bt_count,Const_gh5_bt_DEF
                    check_btime         gh5_bluetime,gh5_bt_count,Const_gh5_bt_DEF,Const_gh5_bt_DEF2,#3,gh5_flashon
                    rts

swap_direction
                    cmp                 #Const_Up           
                    beq                 @ck_up              
                    cmp                 #Const_Down         
                    beq                 @ck_down            
                    cmp                 #Const_Left         
                    beq                 @ck_left            
                    lda                 #Const_Left         ; Default right so swap to left
                    rts
@ck_up              lda                 #Const_Down
                    rts
@ck_down            lda                 #Const_Up
                    rts
@ck_left            lda                 #Const_Right
                    rts

reverse_gh_dirs                                             ; Reverse all ghosts EXCEPT when Eyes mode is activated!
                    lda                 gh2_eyesmode        
                    bne                 @check_gh3          
                    lda                 gh2_pd$             
                    jsr                 swap_direction      
                    sta                 gh2_pd$             

@check_gh3          lda                 gh3_eyesmode
                    bne                 @check_gh4          

                    lda                 gh3_pd$             
                    jsr                 swap_direction      
                    sta                 gh3_pd$             

@check_gh4          lda                 gh4_eyesmode
                    bne                 @check_gh5          

                    lda                 gh4_pd$             
                    jsr                 swap_direction      
                    sta                 gh4_pd$             

@check_gh5          lda                 gh5_eyesmode
                    bne                 @done_exit          

                    lda                 gh5_pd$             
                    jsr                 swap_direction      
                    sta                 gh5_pd$             
@done_exit          rts


; Change dot colors based on a certain number of moves
; Dots will change to red then to green
;
Count_GH_Moves      inc                 SM_frtpl_ctr+1
SM_frtpl_ctr        lda                 #$00
                    cmp                 #50                 
                    bne                 cont_gh_move        
                    lda                 #0                  
                    sta                 SM_frtpl_ctr+1      
                    lda                 CHALLENGE_SCREEN    ; No fruit on challenge screens
                    bne                 skip_placing_fr     
                    inc                 SM_FRT_CNTR+1       
SM_FRT_CNTR         lda                 #$00
                    cmp                 #2                  ; Place first Fruit
                    beq                 @place_fruit        
                    cmp                 #4                  ; Remove first Fruit
                    beq                 @erase_fruit        
                    cmp                 #6                  ; Place 2nd Fruit
                    beq                 @place_fruit        
                    cmp                 #8                  ; Remove 2nd Fruit
                    beq                 @erase_fruit        
                    jmp                 skip_placing_fr     
@erase_fruit        lda                 #$20                ; Space
                    sta                 Const_FR_ON_SC      
                    jmp                 skip_placing_fr     

@place_fruit
SM_CURRENT_FRUIT    lda                 #$00
                    sta                 Const_FR_ON_SC      
                    jsr                 char_color
                    sta                 Const_FR_CLR_SCR    
skip_placing_fr
                    jsr                 reverse_gh_dirs     

cont_gh_move        inc                 TOTAL_GH_MOVES
                    lda                 TOTAL_GH_MOVES      
                    bne                 @check_moves        
                    inc                 SM_TTL_GH+1         
@check_moves
SM_TTL_GH           lda                 #$00                ; Count how many moves ghost 1 has made
                    cmp                 #1                  
                    bne                 @__check2           
                    lda                 TOTAL_GH_MOVES      
                    cmp                 #200                
                    beq                 @First_col_chg      ; Change all dots colors first time
                    rts
@__check2           cmp                 #2
                    bne                 @end_count          
                    lda                 TOTAL_GH_MOVES      ; Change all dots colors second time
                    cmp                 #100                
                    beq                 @sec_col_chg        

@end_count          rts
@First_col_chg
                    lda                 #4                  ; Purple Dots
                    sta                 SM_Search_Color+1   
                    lda                 #5                  ;Make just wall dots change color
                    sta                 _SM_1+1             ;

                    jsr                 Change_Map_Color    
                    lda                 #5                  ; Dots worth 5 points now
                    sta                 SM_DOT_POINTS+1     
                    lda                 #6                  ; 6th decimal pos
                    sta                 SM_DOT_DEC+1        
                    rts
@sec_col_chg
                    lda                 #3                  ; Cyan Dots
                    sta                 SM_Search_Color+1   
                    jsr                 Change_Map_Color    
                    lda                 #1                  ; Dots worth 1 point now
                    sta                 SM_DOT_POINTS+1     
                    lda                 #6                  ; 6th decimal pos
                    sta                 SM_DOT_DEC+1        

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
                    wall_chk            gx,gyminus1,#Const_DOWN,#Const_UP,#1; Check wall directly above ghost
                    wall_chk            gx,gyplus1,#Const_UP,#Const_DOWN,#0; Check wall directly below ghost

                    ldy                 gx                  ; Set up
                    dey

@skp                sty                 gxminus1            ; gx - 1
                    ldy                 gx                  
                    iny
                    sty                 gxplus1             ; gx + 1
                    wall_chk            gxminus1,gy,#Const_RIGHT,#Const_LEFT,#2; Check wall to left of ghost
                    wall_chk            gxplus1,gy,#Const_LEFT,#Const_RIGHT,#3; Check wall to right of ghost

                    rts
;*****************************************************
; scan the possible directions pac-clone can move
; if there is a match with the accumulater than
; return 'beq' otherwise return 'bne'
;*****************************************************
Can_Move_This_Dir?
                    ldx                 #0                  ; Check if pac-clone hits a Const_WallDT
@loop               cmp                 g$,x                ; needed for sprite mouth to stay open on hit
                    beq                 @ext_sub            
                    inx
                    cpx                 g$len               
                    bne                 @loop               
                    ldx                 #1                  ;These two lines are here because
                    cpx                 #2                  ;need to set the BNE flag to return 'bne'
@ext_sub            rts
;*****************************************************
;This sub is heart of the entire program
;It is responsible for actually moving all objects
;on the map
;*****************************************************
MV_GHOST
SM_ispacman         lda                 #$00
                    cmp                 #1                  ; Have to check if this is Pac-clone
                    bne                 notpacman           ; if so then do not pick a dir of travel

SM_userdir          lda                 #$00                ; Check can pclone move in user direction
                    jsr                 Can_Move_This_Dir?  ; Can the we travel in the selected dir?
                    beq                 match2              ;
                    lda                 cdir                ; This keeps pacclone moving in current dir of travel
                    jsr                 Can_Move_This_Dir?  ;Check can pclone move in current dir of travel
                    beq                 match2              ; Match means 'yes'                                                            ; No match mean return
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
                    cmp                 #Const_WLCGE        ; ghost eyes to move down
                    bne                 not_cage            ; if directly over

                    lda                 #0                  
                    pha
                    lda                 #Const_DOWN         ; Load Down Value
                    sta                 cdir                ;fixes bug where sprite ghost does not move into cage
                    sta                 g$                  ;This sta fixes 2nd bug where ghost does not move into cage when no wall directly above cage entrance

                    inc                 gy                  ; force ghost into ghost cage
                    ldx                 #1                  
                    jmp                 .gskip              

;***
; Pick a direction of travel either a priority dir
; Or a random dir based on possible choices of dir
;*****************************************************
not_cage
                    inc                 pr_cntr             ; Increment priority counter
                    lda                 pr_cntr             ; Do we have a match with the
                    cmp                 ghost_pr            ; Current Priority?
                    bne                 @random_dirs        ; No? then move randomly
                                                            ; Yes? Then move in priority dir
                    lda                 #0                  ; Reset the Priority counter
                    sta                 pr_cntr             
                    lda                 pq$                 ; Load priority direction
                    beq                 @random_dirs        ; Make sure there is one
                    lda                 pq$                 ; Make the ghost
                    sta                 g$                  ; Move randomly in the direction

                    lda                 pq$+1               ; of priority
                    sta                 g$+1                

                    lda                 pq$len              
                    sta                 g$len               

@random_dirs                                                 ; Randomly move ghost
                    jsr                 RAND                ; in one of the possible
                    pha                                     ; directions of travel
                    tax                                     ; push direction
                    lda                 g$,x                ;
                    sta                 cdir                ;
                    lda                 g$+1                
                    lda                 g$+2                
                    lda                 g$len               
                    lda                 g$                  
                    lda                 cdir                

;*****************************************************

                    jsr                 change_gx_gy        ; Change gx, gy based on current direction of travel
;These lines are executed by ghosts (and pac-clone when in attract mode)
.gskip              lda                 ATTRACT_MODE        ; (these 4 lines set/fix direction sprite of pac-clone sprite during attract_mode)
                    beq                 @xkip1              ; skip if attract mode is off
                    lda                 curr_sprite         ; 0 = Pac-clone
                    beq                 ck_1                ; SO if attract_mode=1 and curr_sprite is pac_clone then fix direction of sprite to be correct random direction
@xkip1              jsr                 Pick_Ghost_Spr      ; skip the pick_ghost_spr
                    jmp                 .tobot              

;**************************************************
;These lines are executed by Pac-Clone
ck_1                jsr                 change_gx_gy        ; Change gx, gy based on current direction of travel
                    txa                                     ; X should be 0-3 for up,down,left,right
                    jsr                 Setup_Pacdir        ; Orient Pac-Clone sprite to proper direction
                    jsr                 ck_rightside        
                    lda                 #0                  ; Turn gobble on
                    sta                 gobble_on           
.tobot              pla                                     ; Pull Direction down
                    tax
                    lda                 g$,x                ;
                    sta                 pd$                 
                    rts

change_gx_gy
                    cmp                 #Const_UP           ; UP
                    bne                 @xck_2              
                    dec                 gy                  ; Decrease Y value
                    ldx                 #0                  
                    rts
@xck_2              cmp                 #Const_DOWN          ; DOWN
                    bne                 @xck_3              
                    inc                 gy                  ; Increase Y value
                    ldx                 #1                  
                    rts
@xck_3              cmp                 #Const_LEFT          ; LEFT
                    bne                 @xck_4              
                    dec                 gx                  ; Decrease X value
                    ldx                 #2                  
                    jsr                 ck_leftside         
                    rts
@xck_4              cmp                 #Const_RIGHT         ; RIGHT
                    bne                 @done               
                    inc                 gx                  ; Increase X value
                    ldx                 #3                  
                    jsr                 ck_rightside        
@done               rts

; Created this macro to make program code above more readable
Setup_Pacdir
                    beq                 @xup                
                    cmp                 #1                  
                    beq                 @xdown              
                    cmp                 #2                  
                    beq                 @xleft              
                    cmp                 #3                  
                    beq                 @xright             
                    rts
@xup
                    lda                 spr_up              
                    sta                 int_sprite_byte     
                    lda                 spr_up+1            
                    sta                 int_sprite_byte+1   
                    lda                 spr_up+2            
                    sta                 int_sprite_byte+2   
                    rts
@xdown
                    lda                 spr_down            
                    sta                 int_sprite_byte     
                    lda                 spr_down+1          
                    sta                 int_sprite_byte+1   
                    lda                 spr_down+2          
                    sta                 int_sprite_byte+2   
                    rts
@xleft
                    lda                 spr_left            
                    sta                 int_sprite_byte     
                    lda                 spr_left+1          
                    sta                 int_sprite_byte+1   
                    lda                 spr_left+2          
                    sta                 int_sprite_byte+2   
                    rts
@xright
                    lda                 spr_right           
                    sta                 int_sprite_byte     
                    lda                 spr_right+1         
                    sta                 int_sprite_byte+1   
                    lda                 spr_right+2         
                    sta                 int_sprite_byte+2   
                    rts
Pick_Ghost_spr                                              ;eyeball ghost direction
                    ldy                 curr_sprite         
                    lda                 #$07                
                    sta                 @SM.xover+2         
                    lda                 #$f8                
                    sta                 @SM.xover+1         
                    lda                 g$eyesmode          
                    cmp                 #1                  
                    beq                 @xover              
                    lda                 sp_gh_dir,x         
                    jmp                 @SM.xover           
@xover              lda                 sp_eye_dir,x
@SM.xover           sta                 $d000,y
done_2a             rts

defm                dm_prep                                 ; Pass down which map to load
                    ldy                 #>/1                
                    sty                 _SM_mpart1+2        
                    iny
                    sty                 _SM_mpart2+2        
                    iny
                    sty                 _SM_mpart3+2        
                    iny
                    sty                 _SM_mpart4+2        
                    lda                 #</1                
                    sta                 _SM_mpart1+1        
                    sta                 _SM_mpart2+1        
                    sta                 _SM_mpart3+1        
                    sta                 _SM_mpart4+1        
endm

drawmap             ldx                 MAP_INDEX
                    jsr                 SET_BG_FG_COLORS    
                    ldy                 #0                  
_SM_mpart1          lda                 $0000,y             ;Self modifying code part1
                    sta                 $400,y              
                    jsr                 char_color          
                    sta                 $d800,y             
                    iny
                    bne                 _SM_mpart1          
_SM_mpart2          lda                 $0000,y
                    sta                 $500,y              
                    jsr                 char_color          
                    sta                 $d900,y             
                    iny
                    bne                 _SM_mpart2          
_SM_mpart3          lda                 $0002,y
                    sta                 $600,y              
                    jsr                 char_color          
                    sta                 $da00,y             
                    iny
                    bne                 _SM_mpart3          
_SM_mpart4          lda                 $0003,y
                    sta                 $700,y              
                    jsr                 char_color          
                    sta                 $db00,y             
                    iny
                    cpy                 #$e8                
                    bne                 _SM_mpart4          
                    lda                 MAP_INDEX           
                    cmp                 #17                 
                    beq                 @rts                
                    lda                 ATTRACT_MODE        ; So If attract mode is on then reset score to zero and return to title screen
                    bne                 @SK2                
                    lda                 CHALLENGE_SCREEN    ; If coming off chlng screen skip the save_clr - fixes score being zeroed out
                    bne                 @skip_clr           
@SK2                ldx                 MAP_INDEX
                    lda                 TOP_ROW_SAVE+27     
                    cpx                 #17                 ; Place cheat indicator
                    beq                 @ttl                ; in proper location
                    sta                 $41B                ; location changes on ttl screen
                    jmp                 @reset_score        
@ttl                sta                 $40f                ; sc taint pos
                    lda                 #1                  
                    sta                 $d80f               ; color pos


@reset_score        jsr                 Save_Clr_TopRow     ; Change score color
@skip_clr           jsr                 RESTORE_TOP_ROW     ; top line
@rts                rts

char_color          cmp                 #Const_WallDT
                    beq                 @color_yel          
                    cmp                 #Const_WLCGE        ; All Non chlnge screen maps
                    beq                 @color_lgr          
                    cmp                 #Const_fruit1       
                    beq                 @color_wht          
                    cmp                 #Const_fruit2       
                    beq                 @color_pnk          
                    cmp                 #Const_fruit3       
                    beq                 @color_red          
                    cmp                 #Const_fruit4       
                    beq                 @color_wht          
                    cmp                 #Const_fruit5       
                    beq                 @color_dgreen        
                    cmp                 #Const_fruit6       
                    beq                 @color_pnk          
                    cmp                 #Const_fruit7       
                    beq                 @color_lbl          
                    cmp                 #Const_fruit8       
                    beq                 @color_cya          
                    cmp                 #233                ; Maze Craze border color dark blue
                    beq                 @color_dbl          
                    cmp                 #230                ; Maze craze white walls
                    beq                 @color_wht          
                    cmp                 #252                ; Carpels Tunnel
                    beq                 @color_pnk          
                    cmp                 #253                ; Carpels Tunnel
                    beq                 @color_yel          
                    cmp                 #254                ; Carpels Tunnel
                    beq                 @color_wht          
                    cmp                 #255                ; Carpels Tunnel
                    beq                 @color_lgray        
                    cmp                 #156                ; Carpels Tunnel
                    beq                 @color_pnk          
                    cmp                 #157                ; Carpels Tunnel
                    beq                 @color_yel          
                    cmp                 #158                ; Carpels Tunnel
                    beq                 @color_wht          
                    cmp                 #159                ; Carpels Tunnel
                    beq                 @color_lgray        
                    jmp                 @check_more         
@color_yel          lda                 #7 ; Yellow - dot color
                    rts
@color_blk          lda                 #0 ; Black - used on map 3
                    rts
@color_red          lda                 #2 ; RED - Fruit 3 color
                    rts
@color_pnk          lda                 #10 ; Pink
                    rts
@color_dgreen       lda                 #5 ; Dark green used on map 4
                    rts
@color_lgr          lda                 #13 ; Light Green - Cage wall color
                    rts
@color_lbl          lda                 #14 ; Light Blue - Fruit 7 color
                    rts
@color_lgray        lda                 #15 ; Light Grey - Carpels Tunnel
                    rts
@color_wht          lda                 #1 ; White - Cage exit color
                    rts
@color_cya          lda                 #3 ; CYAN - Wall color map 1
                    rts
@color_dgr          lda                 #5 ; Dark Green - Maze Craze green walls
                    rts
@color_dbl          lda                 #6 ; Dark Blue - Maze Craze border color
                    rts
@check_more
                    cmp                 #194                ; Carpels Tunnel
                    beq                 @color_pnk          
                    cmp                 #195                ; Carpels Tunnel
                    beq                 @color_yel          
                    cmp                 #196                ; Carpels Tunnel
                    beq                 @color_wht          
                    cmp                 #197                ; Carpels Tunnel
                    beq                 @color_lgray        
                    cmp                 #251                ; Dragons Wrath GPAC color
                    beq                 @color_blk          
                    cmp                 #58                 ; Dragons Wrath colon
                    beq                 @color_yel          
                    cmp                 #186                ; Ghost Blue Color
                    beq                 @color_dbl          
                    cmp                 #$30                
                    beq                 @color_wht          
                    cmp                 #$31                
                    beq                 @color_wht          
                    cmp                 #$32                
                    beq                 @color_wht          
                    cmp                 #$33                
                    beq                 @color_wht          
                    cmp                 #$34                
                    beq                 @color_wht          
                    cmp                 #$35                
                    beq                 @color_wht          
                    cmp                 #$36                
                    beq                 @color_wht          
                    cmp                 #$37                
                    beq                 @color_wht          
                    cmp                 #$38                
                    beq                 @color_wht          
                    cmp                 #$39                
                    beq                 @color_wht          
.SM_CH_Dflt         lda                 #2                  ; A few maps change the default color
                    rts

;============================================================
Init_Random
                    LDA                 #$FF                ; maximum frequency value
                    STA                 $D40E               ; voice 3 frequency low byte
                    STA                 $D40F               ; voice 3 frequency high byte
                    LDA                 #$80                ; noise SIRENform, gate bit off
                    STA                 $D412               ; voice 3 control register
                    rts

RAND                lda                 g$len               ; These two lines
                    beq                 @dont_crash         ; prevent program crash
                    LDA                 $D41B               ; get random value from 0-255
                    CMP                 g$len               ; narrow random result down
                                                            ; to between zero - g$len
                    BCC                 @dont_crash         ; ~ to 0-3
                    jmp                 RAND                
@dont_crash         rts
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
.IncreaseDigit      inc                 Const_SC_POS,x

.SM_HIGHSC1         ;inc                 Const_HSC_PS,x   - SELF MODIFIED
                    nop
                    nop
                    nop
                    lda                 Const_SC_POS,x      
                    cmp                 #58                 ; The number past 9 in C64 ascii
                    bne                 .IncreaseBy1Done    
                    lda                 #48                 ; '0' character
                    sta                 Const_SC_POS,x      
.SM_HIGHSC2         ;sta                 Const_HSC_PS,x   - SELF MODIFIED
                    nop
                    nop
                    nop
                    dex
                    bne                 .IncreaseDigit      
                    ldx                 SCORE_PARAM2        
                    jmp                 SM_CHKHISCORE       

.IncreaseBy1Done
SM_FREE_MAN         lda                 #0                  ; Was Free man flag triggered?
                    cmp                 #1                  
                    beq                 @cont               
                    lda                 Const_SC_POS+2      ; 10,000 digit position
                    cmp                 #$31                
                    bne                 @cont               
                    INC                 SM_FREE_MAN+1       
                    inc                 SM_PACS_AVAIL+1     
                    txa
                    pha
                    jsr                 dsp_pacs            
                    lda                 #1                  
                    sta                 gobble_on           
                    lda                 #0                  
                    sta                 SM_close_mouth+1    
                    lda                 #1                  
                    sta                 SM_SND_FREEMN_TGR+1 

                    lda                 #0                  
                    sta                 gobble_on           

                    pla
                    tax

@cont               dec                 SCORE_PARAM1
                    bne                 .IncreaseBy1        
SM_CHKHISCORE       jsr                 CheckForHighscore   ; THis is Self modded out once high score is set and in place during gameplay
                    ldx                 SCORE_PARAM2        ; Restore X register
                    rts
;------------------------------------------------------------
;check if the player got a new highscore entry
;------------------------------------------------------------

CheckForHighscore   ldy                 #0
                    ldx                 #0                  
@CheckNextDigit     lda                 Const_SC_POS,x
                    cmp                 Const_HSC_PS,y      
                    bcc                 @NotHigher          
                    bne                 @IsHigher           
                    iny                                     ;need to check next digit
                    inx
                    cpx                 #7                  
                    beq                 @IsHigher           
                    jmp                 @CheckNextDigit     
@NotHigher          rts

@IsHigher
                    lda                 #$FE                ; SELF MODIFYING TO INC HIGHSCORE,x
                    sta                 .SM_HIGHSC1         
                    lda                 #<Const_HSC_PS      
                    sta                 .SM_HIGHSC1+1       
                    lda                 #>Const_HSC_PS      
                    sta                 .SM_HIGHSC1+2       
                    LDA                 #$9D                ; SELF MODIFYING TO STA HIGHSCORE,x
                    sta                 .SM_HIGHSC2         
                    lda                 #<Const_HSC_PS      
                    sta                 .SM_HIGHSC2+1       
                    lda                 #>Const_HSC_PS      
                    sta                 .SM_HIGHSC2+2       

                    lda                 #$EA                
                    sta                 SM_CHKHISCORE       
                    sta                 SM_CHKHISCORE+1     
                    sta                 SM_CHKHISCORE+2     

                    ldx                 #7                  ; First time high score is set
@loop               lda                 Const_SC_POS-1,x     ; Need to copy current score
                    sta                 Const_HSC_PS-1,x    ; to the high score.
                    dex
                    bne                 @loop               
                    JSR                 CHECK_FOR_CHEAT     
                    rts

Reset_HIGH_SMs
                    lda                 #$EA                ; SELF MODIFYING TO INC HIGHSCORE,x
                    sta                 .SM_HIGHSC1         
                    sta                 .SM_HIGHSC1+1       
                    sta                 .SM_HIGHSC1+2       
                    sta                 .SM_HIGHSC2         
                    sta                 .SM_HIGHSC2+1       
                    sta                 .SM_HIGHSC2+2       
                    lda                 #$20                
                    sta                 SM_CHKHISCORE       
                    lda                 #<CheckForHighscore 
                    sta                 SM_CHKHISCORE+1     
                    lda                 #>CheckForHighscore 
                    sta                 SM_CHKHISCORE+2     
                    rts

;*************************************************************
; Redraw color just the border of the map with the value
; stored in SM_Search_Color+1
; SEARCH_CHAR
;*************************************************************

Change_Map_Color    lda                 #$04
                    sta                 _SM_scnptr2+2       
                    lda                 #$d8                
                    sta                 _SM_scnptr+2        

                    ldx                 #$00                
main_lp1            ldy                 #$00
loop2
_SM_scnptr2         lda                 $0400,y
                    cmp                 #Const_WallDT       
_SM_1               bne                 skip_aa

SM_Search_Color     lda                 #00                 ;SM_Search_Color+1
_SM_scnptr          sta                 $d800,y
skip_aa             dey
                    bne                 loop2               
                    inc                 _SM_scnptr2+2       ; Inc High byte
                    inc                 _SM_scnptr+2        
                    inx
                    cpx                 #4                  
                    bne                 main_lp1            
                    rts

;*************************************************************
delay               txa
                    pha
                    tya
                    pha
                    ldy                 #3                  
@del_lp2            ldx                 #1
@del_lp1            dex
                    cpx                 #0                  
                    bne                 @del_lp1            
                    dey
                    cpy                 #0                  
                    bne                 @del_lp2            
                    pla
                    tay
                    pla
                    tax
                    rts

delay_longer        txa
                    pha
                    tya
                    pha
                    ldy                 #3                  
@del_lp2a           ldx                 #$ff
@del_lp1a           dex
                    cpx                 #0                  
                    bne                 @del_lp1a           
                    dey
                    cpy                 #0                  
                    bne                 @del_lp2a           
                    pla
                    tay
                    pla
                    tax
                    rts

dly
                    ldx                 #8                  
@def_2              ldy                 #0
@loop_xx            jsr                 delay
                    dey
                    bne                 @loop_xx            
                    dex
                    bne                 @def_2              
                    rts

;***DELAY ***
dly4
                    ldx                 #50                 
@loop_xxab          jsr                 delay
                    dex
                    bne                 @loop_xxab          
                    rts
;***DELAY ***
delay_5
_delay_5            ldx                 #25
@loop_xxabc         jsr                 delay
                    dex
                    bne                 @loop_xxabc         
                    rts

;***DELAY ***
dly5
@loop_xxab1         jsr                 delay
                    dex
                    bne                 @loop_xxab1         
                    rts

dly7
@loop_xxab12        jsr                 delay_longer
                    dex
                    bne                 @loop_xxab12        
                    rts
delay8
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne                 @lp2                
                    rts

new_delay           ldx                 #$80
                    jsr                 dly7                
                    rts

;*************************************************************
; Make the screen flash different colors after completing
; a level
;*************************************************************

FLASH_SCREEN
                    lda                 #0                  
                    sta                 _SM_1+1             ;Make all characters change colors

                    lda                 #Const_COLORFLSH    ; Number of flashes between levels
                    sta                 SM_COLOR_CNTR+1     
FL_loop             dec                 SM_COLOR_CNTR+1
                    lda                 #3                  
                    sta                 SM_Search_Color+1   
                    jsr                 Change_Map_Color    
                    jsr                 dly                 
                    lda                 #0                  
                    sta                 SM_Search_Color+1   
                    jsr                 Change_Map_Color    
                    jsr                 dly                 
SM_COLOR_CNTR       lda                 #$00
                    bne                 FL_loop             
                    rts


;*************************************************************
; Upgrade to the next level
; Set the Ghost Priority &
; defaults to the new prioriy
; Dont need to reset btime counter here
; instead it is done when btime is enabled
;*************************************************************

RESET_LEVEL
                    jsr                 SIREN_INIT          

                    ldx                 MAP_INDEX           
                    cpx                 #2                  ; Map 2 is chaos challenge screen
                    beq                 @is_ch_scr          
                    cpx                 #6                  ; Map 6 is Carpals Tunnel ch screen
                    beq                 @is_ch_scr          
                    cpx                 #10                 ; Map 10 is Dragons Wrath ch screen
                    beq                 @is_ch_scr          
                    cpx                 #11                 ; Ma
                    beq                 @print_champ          

@cont               lda                 #0                  
                    sta                 CHALLENGE_SCREEN    ; reset challenge screen
                    jmp                 @notchlng           
@print_champ        jsr print_champ

                    jmp @cont
@is_ch_scr
                    lda                 #1                  
                    sta                 CHALLENGE_SCREEN    
@notchlng
                    jsr                 RESET_VARS          
                    lda                 #1                  ; Close Mouth
                    sta                 SM_close_mouth+1    
                    lda                 #0                  
                    sta                 SM_LEVEL_DONE+1     
                    jsr                 Dsp_Fruit_Level     
                    jsr                 Reset_Sprite        
                    lda                 CHALLENGE_SCREEN    
                    cmp                 #1                  
                    bne                 prt_ready           ; Not a challenge screen then print ready!
                    lda                 #0                  
                    sta                 ENG_FLASH_ON        ; Turn off flashing energizers
                    lda                 MAP_INDEX           
                    cmp                 #6                  ; Map 6 has more than 255 dots
                    beq                 @dontdothat         
                    lda                 #1                  ; Emulate more that 255 dots eaten
                    sta                 SM_TTL_DOTS+1       ;
@dontdothat         lda                 DEATH_FLAG          ; Are you dead?
                    cmp                 #1                  
                    bne                 @chlng              ; No..
                    jsr                 Save_Clr_TopRow     
                    jsr                 print_failed        ; So if you die on challenge screen then print 'failed'
                    jsr                 RESTORE_TOP_ROW     ;
                    rts
@chlng              jsr                 print_challenge     
                    LDA                 #223                ; Turn on all sprites except big box
                    sta                 $d015               
                    lda                 MAP_INDEX           ; Challenge Map 10 is the one we want to enable extra sprite
                    cmp                 #$0a                
                    bne                 skp_cont            
                    lda                 #$ea                ; Execute the shadow sprite code for chlnge screen EA is NOP instruction
                    sta                 SM_Challenge        
                    lda                 #Const_SPR_ROOT+36  
                    sta                 $7fd                
                    lda                 $d000               
                    sta                 $d00a               
                    lda                 $d001               
                    sta                 $d00b               
                    lda                 #%00100000          ; Sprite 6
                    sta                 $d01b               ; Make sprite 6 transparent
                    sta                 $d017               ; Double Height
                    sta                 $d01d               ; Double Width
                    LDA                 #$ff                ; Turn on all sprites
                    sta                 $d015               
                    lda                 #15                 ; Set Box color
                    sta                 $d02c               
                    jmp                 skp_cont            

prt_ready           lda                 #$60                ; RTS - do not execute some code if not challenge screen
                    sta                 SM_Challenge        
                    lda                 #1                  
                    sta                 ENG_FLASH_ON        
                    jsr                 print_ready         
                    LDA                 #$df                ; All sprites on but sprite 6 the shadow sprite for challenge screen
                    sta                 $d015               
skp_cont
                    jsr                 mov_ghost2          
                    jsr                 mov_ghost3          
                    jsr                 mov_ghost4          
                    jsr                 mov_ghost5          
                    lda                 #1                  
                    sta                 Gobble_on           
                    lda                 ATTRACT_MODE        
                    beq                 @okdelay            
                    jmp                 @skipdelay          
@okdelay

@skipdelay

clear_buffer        jsr                 $ffe4
                    jsr                 $ffe4               
                    jsr                 $ffe4               

                    lda                 #1                  ; Close Mouth
                    sta                 SM_close_mouth+1    
SM_ST_OF_GAME       lda                 #00
                    bne                 @frstinput          
                    jsr                 SOUND_INTRO         
                    lda                 #1                  
                    sta                 SM_ST_OF_GAME+1     

@frstinput          jsr                 .FirstInput         ; Waits for first input before game starts
                    jsr                 RESET_SIREN         
                    lda                 CHALLENGE_SCREEN    ; No BG SIREN on challenge screen
                    bne                 @exit               
                    lda                 #1                  ; Turn on Siren
                    sta                 SM_SIREN_TOGGLE+1   
@exit               rts

RESET_VARS


                    ldx                 MAP_INDEX           
                    lda                 gh2_Start_X,x       
                    sta                 gh2_gx              
                    lda                 gh2_Start_Y,x       
                    sta                 gh2_gy              
                    lda                 gh3_Start_X,x       
                    sta                 gh3_gx              
                    lda                 gh3_Start_Y,x       
                    sta                 gh3_gy              
                    lda                 gh4_Start_X,x       
                    sta                 gh4_gx              
                    lda                 gh4_Start_Y,x       
                    sta                 gh4_gy              
                    lda                 gh5_Start_X,x       
                    sta                 gh5_gx              
                    lda                 gh5_Start_Y,x       
                    sta                 gh5_gy              
                    lda                 #$33                
                    lda                 gh1_Start_X,x       
                    sta                 gh1_gx              
                    lda                 gh1_Start_Y,x       
                    sta                 gh1_gy              
                    lda                 gh1_SP_X,x          
                    sta                 $d000               
                    lda                 gh1_SP_Y,x          
                    sta                 $d001               
                    lda                 Const_gh2_DEF_PR,x  ;Grabbing the next
                    sta                 gh2_pr              ; et of priorities
                    lda                 Const_gh3_DEF_PR,x  ;Slightly more difficult
                    sta                 gh3_pr              ;For the next level
                    lda                 Const_gh4_DEF_PR,x  
                    sta                 gh4_pr              
                    lda                 Const_gh5_DEF_PR,x  
                    sta                 gh5_pr              
                    lda                 Const_oGh1_Boost,x  
                    sta                 gh1_sp_boost_goal   
                    lda                 Const_oGh2_Boost,x  
                    sta                 gh2_sp_boost_goal   
                    lda                 Const_oGh3_Boost,x  
                    sta                 gh3_sp_boost_goal   
                    lda                 Const_oGh4_Boost,x  
                    sta                 gh4_sp_boost_goal   
                    lda                 Const_oGh5_Boost,x  
                    sta                 gh5_sp_boost_goal   
                    lda                 GAME_SPEED,x        
                    sta                 _delay_5+1          

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
                    sta                 xg                  
                    sta                 yg                  
                    sta                 pr_cntr             
                    sta                 ghost_pr            
                    sta                 pd$                 
                    sta                 cdir                
                    sta                 gh1_pr_cntr         
                    sta                 gh2_pr_cntr         
                    sta                 gh3_pr_cntr         
                    sta                 gh4_pr_cntr         
                    sta                 gh5_pr_cntr         
                    sta                 $d010               
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
                    sta                 gh5_pd$                                                                        
                    sta                 gh1_cdir            
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

                    jsr                 dsp_pacs            
                    LDA                 #%11011110          ; Turn off pac during ready text printing
                    sta                 $d015               
                    lda                 #Const_left         ; Set starting direction of movement
                    sta                 gh5_cdir            
                    sta                 gh3_cdir            
                    sta                 gh3_g$              
                    sta                 gh3_pq$             
                    sta                 gh3_pd$             
                    lda                 #Const_RIGHT        
                    sta                 gh2_cdir            
                    sta                 gh4_cdir            
                    sta                 gh4_g$              
                    sta                 gh4_pd$             

                    rts

RESET_SIREN                                                 ; RESETS SIREN SOUND VARS
                    lda                 #1                  ; Start out siren from top of wave going down
                    sta                 SM_SIREN_U_D+1      
                    ldx                 MAP_INDEX           
                    lda                 SIREN_MIN,x         
                    sta                 SIREN               
                    rts

print_boost         lda                 #1
                    sta                 gobble_on           
                    lda                 #0                  
                    sta                 SM_close_mouth+1    

                    lda                 #<lbl_boost         
                    sta                 _SM_Loop+1          
                    lda                 #>lbl_boost         
                    sta                 _SM_Loop+2          
                    jsr                 _print_loop         
boost_fini
                    jsr                 SOUND_BOOST         
                    jsr                 RESTORE_TOP_ROW     
                    lda                 #0                  
                    sta                 gobble_on           
                    rts
print_bonus
                    lda                 #1                  ; Stop Chomping
                    sta                 gobble_on           
                    sta                 SM_close_mouth+1    ; Close Mouth


                    lda                 #<lbl_bonus         
                    sta                 _SM_Loop+1          
                    lda                 #>lbl_bonus         
                    sta                 _SM_Loop+2          
                    jsr                 _print_loop         
                    jsr                 SOUND_SUPERBONUS    
                    jsr                 new_delay           

                    jsr                 new_delay           

                    lda                 #0                  ; Turn off all sprites
                    sta                 $d015               
                    jsr                 RESTORE_TOP_ROW     
                    rts

print_superbonus    lda                 #<lbl_superbonus
                    sta                 _SM_Loop+1          
                    lda                 #>lbl_superbonus    
                    sta                 _SM_Loop+2          
                    jsr                 _print_loop         
                    jsr                 SOUND_LVL_UNLOCK    

                    jsr                 RESTORE_TOP_ROW     
                    rts

_print_loop         jsr                 Save_Clr_TopRow
                    ldx                 #0                  
_SM_Loop            lda                 lbl_boost,x
                    beq                 @quit               
                    sta                 $40e,x              ; Hard coded start position
                    lda                 #7                  
                    sta                 $d80e,x             
                    inx
                    jmp                 _SM_Loop            
@quit               rts

defm                RESTORE_ROW                             ; Made quick macro to use for top and bottom rows
                    ldx                 MAP_INDEX           
                    lda                 SCORE_COLOR_MAP,x   
                    tay
                    ldx                 #40                 
@smloopb            lda                 TOP_ROW_SAVE-1,x
                    sta                 /1,x                
                    tya
                    sta                 /2,x                
                    dex
                    bne                 @smloopb            
endm

CHECK_FOR_CHEAT
                    lda                 .SM_HIGHSC1+1       
                    cmp                 #$ea                ; if EA or NOP means high score not set
                    beq                 CHEAT_END           ; no high score = no matter

SM_WAS_CHT_USED     lda                 #0                  ; if 1 means cheat was used
                    beq                 @not_cheat          
                    lda                 #170                
                    jmp                 @not_cheat+2        
@not_cheat          lda                 #$20
                    sta                 TOP_ROW_SAVE+27     
                    sta                 $400+27             
CHEAT_END           rts

RESTORE_TOP_ROW                                             ; To make room for text printed across top
                    RESTORE_ROW         $3ff,$d7ff          
                    rts
RESTORE_BOT_ROW
                    RESTORE_ROW         $7bf,$dbbf          
                    rts

REST_TTL_HI

                    ldx                 #7                  
@loop               lda                 TOP_ROW_SAVE+27,x       ; Hi score position on screen
                    sta                 $40f,x              
                    sta                 TTLHIGH-1,x         
                    dex
                    bne                 @loop               
                    lda                 TOP_ROW_SAVE+27     
                    sta                 $40f                
                    lda                 #1                  
                    sta                 $d80f               
@exit               rts
REST_TTL_HI2
                    ldx                 #7                  
@loop               lda                 TTLHIGH-1,x       ; Hi score position on screen
                    sta                 $41b,x              
                    dex
                    bne                 @loop               
                    lda                 TOP_ROW_SAVE+27     
                    sta                 $41b                
                    rts
;*************************************************************y
; Print ready in the center of the map right before
; play begins
;*************************************************************

print_failed                                                ; Set up pointers to print ready text at specific location
                    lda                 ATTRACT_MODE          
                    cmp                 #1                  
                    bne                 @continue           
                    rts
@continue           lda MAP_INDEX
                    cmp                 #$0a                ; If you fail on map 10 reveal the map while text is printed
                    bne                 @cont2              
                    lda                 #15                 ; Change border/bg color to light gray
                    sta                 53280               
                    sta                 53281               

@cont2              lda                 #<lbl_failed
                    sta                 SM_Get_Char+1       
                    lda                 #>lbl_failed        
                    sta                 SM_Get_Char+2       
                    lda                 #$10                
                    jmp                 .into_it2           

print_ready
                    lda                 ATTRACT_MODE        
                    bne                 @dont_print         
                    lda                 #<lbl_ready         ; Set up pointers to print ready text at specific location
                    sta                 SM_Get_Char+1       
                    lda                 #>lbl_ready         
                    sta                 SM_Get_Char+2       
                    lda                 #$41                
                    sta                 SM_Put_Char+1       
                    sta                 SM_prt_color+1      
                    lda                 #$06                
                    sta                 SM_Put_Char+2       
                    lda                 #$da                
                    sta                 SM_prt_color+2      
                    jsr                 print_text          ; Skip the first sub
@dont_print         rts

print_gameover      ldx                 #0
@loop               lda                 lbl_gameover,x
                    sta                 $641,x              
                    lda                 #7                  
                    sta                 $da41,x             
                    txa
                    pha
                    jsr                 dly                 
                    pla
                    tax
                    inx
                    cpx                 #6                  
                    bne                 @loop               
                    sei
                    jsr                 dly                 
                    jsr                 dly                 
                    jsr                 dly                 
                    jsr                 dly                 
                    rts

print_champ         lda                 #$00                   ; Only print this message once
                    beq                 @cont               
                    rts 

@cont               lda                 #1                  
                    sta                 print_champ+1       
                    lda #$0a                                    ; Attempt to center this text
                    sta txt_pos+1                               ; by moving it back 2 chars
                    jsr                 SOUND_Challenge                        
                    jsr                 Save_Clr_TopRow
                    lda                 #<lbl_championship
                    sta                 SM_Get_Char+1       
                    lda                 #>lbl_championship                     
                    jsr                 into_it             
                    jsr                 RESTORE_TOP_ROW     
                    lda #$0c                                    ; Reset back to normal
                    sta txt_pos+1

                    rts

print_challenge     jsr                 Save_Clr_TopRow     ; Set up pointers to print challenge text at specific location on screen
                    lda                 Map_Index           
                    cmp                 #2                  
                    beq                 @print_ch1          
                    cmp                 #6                  
                    beq                 @print_ch2          
                    lda                 #<lbl_challenge3    
                    sta                 SM_Get_Char+1       
                    jsr                 SOUND_Challenge     
                    lda                 #>lbl_challenge3    
                    jsr                 into_it            
                    jsr                 RESTORE_TOP_ROW     
@Dragonswrath       lda                 #11                 ; Hide the background in Dragons Wrath
                    sta                 53281               ; After revealing it for a few seconds
                    rts
@print_ch1          lda                 #<lbl_challenge1
                    sta                 SM_Get_Char+1       
                    jsr                 SOUND_Challenge     
                    lda                 #>lbl_challenge1    
                    jmp                 into_it            
@print_ch2          lda                 #<lbl_challenge2
                    sta                 SM_Get_Char+1       
                    jsr                 SOUND_Challenge     
                    lda                 #>lbl_challenge2    

into_it             sta                 SM_Get_Char+2
txt_pos             lda                 #$0c                
.into_it2           sta                 SM_Put_Char+1
                    sta                 SM_prt_color+1      
                    lda                 #$04                
                    sta                 SM_Put_Char+2       
                    lda                 #$10                
                    lda                 #$d8                
                    sta                 SM_prt_color+2      
                    jsr                 print_text          
                    jsr                 RESTORE_TOP_ROW     
                    rts

print_text          ldx                 #0
lbl_loop            jsr                 SM_Get_Char
                    beq                 .xnext_loop         
print_dest          jsr                 SM_Put_Char
                    lda                 #7                  
SM_prt_color        sta                 $da41,x
                    inx
                    txa
                    pha
                    ldx                 #60                 
                    jsr                 delay8              
                    pla
                    tax
                    jmp                 lbl_loop            
.xnext_loop
                    jsr                 dly                 
                    jsr                 dly                 
                    jsr                 dly                 
                    jsr                 dly                 
                    ldx                 #0                  
lbl_loop2           jsr                 SM_Get_Char
                    beq                 .xret               
                    lda                 #$20                
Erase_dest          jsr                 SM_Put_Char
                    inx
                    jmp                 lbl_loop2           

SM_Get_Char         lda                 lbl_ready,x
                    rts
SM_Put_Char         sta                 $641,x              
.xret               rts

Save_Clr_TopRow
                    ldx                 #40                 ; To make room for text printed across top
@smloopa            lda                 $3ff,x
                    sta                 TOP_ROW_SAVE-1,x    
                    lda                 #$20                ; Space character
                    sta                 $3ff,x              
                    dex
                    bne                 @smloopa            
@rtn                rts

dsp_pacs
SM_PACS_AVAIL       lda                 #$00                ; Self modified loaded with number of pacs in game
                    cmp                 #2                  
                    bcs                 @some_avail         
                    lda                 #$20                ; Down to last PAC
                    sta                 $7c0                ; Blank it out on bottom
                    rts
@some_avail
                    ldx                 #1                  
                    lda                 #Const_PC_CH        
@lbl_pacs           sta                 $7bf,x
                    pha
                    ldy                 MAP_INDEX           
                    lda                 #7                  
                    sta                 $dbbf,x             
                    pla
                    inx
                    cpx                 SM_PACS_AVAIL+1     
                    bcc                 @lbl_pacs           
                    lda                 #$20                
                    cpx                 #8                  
                    bne                 @lbl_pacs           
                    rts
;*************************************************************
; Display the fruit on bottom right corner
; play begins
;*************************************************************

Dsp_Fruit_Level     
                    ldx                 MAP_INDEX
                    cpx                 #17                 ; No Fruit on Title Screen
                    beq                 _exit1
                    lda                 CHALLENGE_SCREEN    ; No fruit on challenge screens
                    bne                 _exit1                    

                    cpx                 #10                  
                    bcs                FR_algorithm2         
                    ldy                 #0                  
_loop               lda                 fruit_on_levels,y
                    tax
                    lda                 fruit_posns,x       
                    sta                 SM_Fr_Bot_RT+1      
                    sta                 SM_Fr_Col_Bot+1     
                    lda                 Fruit_Levels,x                          
SM_Fr_Bot_RT        sta                 $07e7
                    sta                 SM_CURRENT_FRUIT+1  
                    jsr char_color
SM_Fr_Col_Bot       sta                 $dbe7
                    cpy                 MAP_INDEX           ; Display fruits based on how many screens cleared
                    beq                 _exit1              
                    iny
                    cpy                 #12                 
                    bne                 _loop               
                    rts
                    
FR_algorithm2      
                    ldy                 #0                  
                    clc
                    txa
                    sbc                 #8                  ; Subtract 7
                    tax
LP_alg2             
                    lda                 fruit_posns,y       
                    sta                 SM_Fr_Bot_RT2+1     
                    sta                 SM_Fr_Col_Bot2+1      
                    lda                 fruit_levels,x                              
SM_Fr_Bot_RT2       sta                 $07e7
                    sta                 SM_CURRENT_FRUIT+1  
                    jsr char_color
SM_Fr_Col_Bot2      sta                 $dbe7                    
                    inx
                    iny
                    cpy                 #7                  
                    bne LP_alg2                   
_exit1              rts

;*************************************************************
; Actions taken when pac-clone is dead:
; Clear dath flag, decrease available free men
; Do the death animation and do a level reset
;*************************************************************
HE_DEAD             lda                 #0                  ; No Pacs dead
                    sta                 DEATH_FLAG          ; Reset flag
                    dec                 SM_PACS_AVAIL+1     ; Decrease avail lives
                    lda                 SM_PACS_AVAIL+1     
                    beq                 @Game_Over          ; Is Game over?
                    jsr                 DEATH_ANIMATION     ; Animate Pac on death

                    jsr                 RESET_LEVEL         ; Reset the level

                    ldx                 MAP_INDEX           ;
                    lda                 Const_oGh1_Boost,x  ; Reset boost speed to normal after death
                                                            ;
                    sta                 gh1_sp_boost_goal,x ;
                    lda                 GAME_SPEED,x        ;
                    sta                 _delay_5+1          ;
                    rts
@Game_Over
                    jsr                 DEATH_ANIMATION     ; Animate Pac on death
                    jsr                 dsp_pacs            
                    jsr                 print_gameover      
                    rts
;*************************************************************
; Simulate death of pac-clone by changing out characters
; with small delay between
; I tried to align the animation with the sound
; to the best of my abilties
;*************************************************************
DEATH_ANIMATION     lda                 ATTRACT_MODE        ; DEATH DURING ATTRACT MODE?
                    cmp                 #1                  ; If this is removed animation will play
                    bne                 @continue           ; during if death in attract mode but not if run/stop is pressed
                    rts
@continue           jsr                 DW_INIT
                    lda                 #0                  ; Turn off SIREN
                    sta                 SM_SIREN_TOGGLE+1   
                    lda                 #1                  
                    sta                 FLASH_ONLY          
                    sta                 SM_DW_TRIGGER+1     
                    sta                 $d015               ; Turn off all GHOSTS
                    ldy                 #Const_SPR_ROOT+17  ; Pac-Mouth-Open facing up
@death_lp           sty                 $07f8
                    tya
                    pha
                    ldx                 #110                
                    jsr                 delay8              
                    pla
                    tay
                    iny
                    cpy                 #Const_SPR_ROOT+28  
                    bne                 @death_lp           
                    lda                 #$01                
                    eor                 $d015               
                    sta                 $d015               
                    rts

;*************************************************************
; Eat Dots
;*************************************************************
SB                  = 54295

EAT_DOTS
                    inc                 DOTS_EATEN          ; Eat a dot
SM_TTL_DOTS         lda                 #$00
                    beq                 @eat_first_255      
                    ldx                 MAP_INDEX           
                    lda                 ACTUAL_MAP_LEVELS,x 
                    tax
                    lda                 DOTS_EATEN          
                    cmp                 Const_TOTAL_DOTS,x  
                    beq                 @rtn                ; level up
                    rts
@eat_first_255      lda                 DOTS_EATEN          ;
                    cmp                 #255                ; Are all dots eaten?
                    bne                 @exitsub            ; No
                    inc                 SM_TTL_DOTS+1       
@exitsub            rts

@rtn                lda #1
                    sta                 SM_LEVEL_DONE+1     ; ALL DOTS EATEN LEVEL IS DONE
                    rts

LEVEL_UP            lda                 #0                  ; Turn off Siren
                    sta                 SM_SIREN_TOGGLE+1   
                    lda                 #1                  
                    sta                 SM_close_mouth+1    
                    sta                 Gobble_on           
                    lda                 #Const_SPR_ROOT+2   ; Force mouth closed
                    sta                 $7f8                

                    lda                 #0                  
                    sta                 gh2_flashon         
                    sta                 gh3_flashon         
                    sta                 gh4_flashon         
                    sta                 gh5_flashon         
                    sta                 flash_on            
                    sta                 SM_TTL_GH+1         
                    sta                 TOTAL_GH_MOVES      
                    sta                 SM_TTL_DOTS+1       
                    sta                 DOTS_EATEN          
                    sta                 SM_FRT_CNTR+1       
                    sta                 SM_frtpl_ctr+1      

                    lda                 #5                  ;Reset Dots to be worth 10 points
                    sta                 SM_DOT_DEC+1        
                    lda                 #1                  
                    sta                 SM_DOT_POINTS+1     
                    sta                 $d015               ;Only Pac-Clone at map end

                    lda                 DEATH_FLAG          
                    bne                 @dead               

                    lda                 CHALLENGE_SCREEN    
                    beq                 @cont5              

                    lda                 #Const_SPR_ROOT+2   ; Force PAC mouth closed
                    sta                 $7f8                

                    lda                 MAP_INDEX           
                    cmp                 #$0a                
                    bne                 @regularbonus       
                    lda                 superbonus          
                    cmp                 #2                  
                    bne                 @regularbonus       

                    jsr                 print_superbonus    
                    lda                 #50                 ; 50=50,000
                    ldx                 #3                  ; 1000 decimal pos
                    jsr                 IncreaseScore       ; Increase score
                    inc                 SM_PACS_AVAIL+1     ; Award FREE MAN
                    jsr                 dsp_pacs            
                    lda                 #1                  
                    sta                 SM_SND_FREEMN_TGR+1 
                    jsr                 new_delay           
                    jsr                 new_delay           
                    jmp                 @cont5              ; One bonus is enough

@regularbonus       jsr                 print_bonus         

                    lda                 #10                 ; 10=10,000
                    ldx                 #3                  ; 1000 decimal pos
                    jsr                 IncreaseScore       ; Increase score
                    inc                 SM_PACS_AVAIL+1     ; Award FREE MAN
                    jsr                 dsp_pacs            
                    lda                 #1                  
                    sta                 SM_SND_FREEMN_TGR+1 
                    inc                 superbonus          ; INC if success on chlnge scn. If Super Bonus>=2 Then you get super bonus
                    jsr                 new_delay           ; Gives free man sound time to play
                    jsr                 new_delay           
@cont5              jsr                 new_delay
                    sei
                    jsr                 FLASH_SCREEN        ; Yes, do the screen flash

@dead               inc                 MAP_INDEX
                    lda                 MAP_INDEX           
                    cmp                 #Const_MAX_MAPS     
                    bne                 @DONT_RESET_MAPX    
                    lda                 #Const_Start_Backat   ; Reset back a few maps
                    sta                 MAP_INDEX             ;
@DONT_RESET_MAPX

                    lda                 #0                  
                    sta                 $d015               
                    lda                 DEATH_FLAG          
                    cmp                 #1                  
                    bne                 @skipthis           
                    jsr                 Pick_Map_to_Draw    
                    jsr                 set_interrupt       
                    jmp                 @around             
@skipthis           jsr                 DRAW_NEXT_MAP
@around             lda                 #254
                    sta                 SM_Search_Color+1   
                    jsr                 RESET_LEVEL         
                    rts
#endregion
space
                    lda                 #Const_WallSP       
                    sta                 @saveacc+1          
                    ldx                 gh1_gy              ; X value
                    lda                 map_off_l,x         ; Load map low byte into $fb
                    sta                 .SM_newvalue+1      
                    lda                 map_off_h,x         ; Load map high byte into $fc
                    sta                 .SM_newvalue+2      
@saveacc            lda                 #00
                    ldx                 gh1_gx              
.SM_newvalue        sta                 $0400,x             ; Store result in screen memory
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

                    lda                 #Const_SPR_ROOT+12  
                    sta                 $07f9               ; sprite 2
                    jsr                 Spr_ghostcolor      

                    lda                 #Const_SPR_ROOT+11  
                    sta                 $07fA               ; sprite 3
                    lda                 #Const_SPR_ROOT+12  
                    sta                 $07fb               ; sprite 4
                    lda                 #Const_SPR_ROOT+11  
                    sta                 $07fc               ; sprite 5
                    ldx                 MAP_INDEX           
                    lda                 gh1_SP_X,x          
                    sta                 $d000               
                    lda                 gh1_SP_Y,x          
                    sta                 $d001               
                    lda                 gh2_SP_X,x          
                    sta                 $d002               ; Ghost 1 X Position
                    lda                 gh2_SP_Y,x          
                    sta                 $d003               ; Ghost 1 Y Position
                    lda                 gh3_SP_X,x          
                    sta                 $d004               ; Ghost 2 X Position
                    lda                 gh3_SP_Y,x          
                    sta                 $d005               ; Ghost 2 Y Position
                    lda                 gh4_SP_X,x          
                    sta                 $d006               ; Ghost 3 X Position
                    lda                 gh4_SP_Y,x          
                    sta                 $d007               ; Ghost 3 Y Position
                    lda                 gh5_SP_X,x          
                    sta                 $d008               ; Ghost 4 X Position
                    lda                 gh5_SP_Y,x          
                    sta                 $d009               ; Ghost 4 Y Position
                    lda                 #7                  ;make the int_sprite yellow
                    sta                 $d027               
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
                    sta                 SM_Flash_White_bl+1 
                    rts

Set_Interrupt
                    sei                                     ; disable interrupts
                    lda                 #<intcode           ; get low byte of target routine
                    sta                 788                 ; put into interrupt vector
                    lda                 #>intcode           ; do the same with the high byte
                    sta                 789                 
                    jsr                 Reset_Sprite        
                    ldx                 #2                  
                    lda                 int_sprite_byte,x   
                    sta                 $7f8                
                    jsr                 SIREN_INIT          
                    cli                                     ; re-enable interrupts
                    rts

;*************************************************************
intcode             = *

                    jsr                 SOUND_FREE_MAN2     ; Was Free Man sound triggered?
                    jsr                 SOUND_DEATH         ; Was Pac Death sound triggered?
                    jsr                 SOUND_SIREN         
                    lda                 INT_TTLSCN_ACTIVE   ; These next 25 lines of code
                    cmp                 #1                  ; Animate the title screen PAC
                    bne                 @chk_flash          ;
                    inc                 flash_counter4      ; Delay counter
                    lda                 flash_counter4      ;
                    cmp                 #18                 ; Controls chomp speed on title screen
                    bne                 @cont               ; It is also tied to TURN_ON_ATTRACT
                    lda                 #0                  
                    sta                 flash_counter4      
                    inc                 INT_PAC_TXT         
                    lda                 INT_PAC_TXT         
                    cmp                 #1                  
                    beq                 @INT_PAC_TXT1       
                    cmp                 #2                  
                    beq                 @INT_PAC_TXT2       
                    cmp                 #3                  
                    beq                 @INT_PAC_TXT3       
                    cmp                 #4                  
                    beq                 @INT_PAC_TXT2       
                    lda                 #1                  
                    sta                 INT_PAC_TXT         
@INT_PAC_TXT1       jsr INT_PAC_TXT1
                    jmp                 end_int             
@INT_PAC_TXT2       jsr INT_PAC_TXT2
                    jmp                 end_int             
@INT_PAC_TXT3       jsr INT_PAC_TXT3
                    jmp                 end_int             
@chk_flash
@sk12               lda                 ENG_FLASH_ON
                    cmp                 #1                  
                    bne                 @cont               
                    inc                 flash_counter4      
                    lda                 flash_counter4      
                    cmp                 #22                 ; Controls Energizer Flash frequency
                    bne                 @cont               
                    lda                 #0                  
                    sta                 flash_counter4      
                    inc                 int_nrgize          
                    lda                 int_nrgize          
                    cmp                 #2                  
                    beq                 @rst_nrgy           
                    ldx                 MAP_INDEX           
                    lda                 EnergizerColor,x    
                    tax
                    jsr                 Set_Nrgize_color    
                    jmp                 @cont               
@rst_nrgy           lda                 #0
                    sta                 int_nrgize          
                    ldx                 MAP_INDEX           
                    lda                 MAP_BG_COLOR,x      
                    tax
                    jsr                 Set_Nrgize_color    
@cont               lda                 FLASH_ONLY
                    cmp                 #1                  
                    bne                 @is_int             
                    jmp                 end_int             
@is_int             lda                 Gobble_on
                    beq                 int_skip2           
SM_close_mouth      lda                 #$00
                    beq                 int_normal          
SM_SHW_PT_VAL       lda                 #$00
                    bne                 INT_Sprite1         
                    ldx                 #2                  ; mouth closed
                    lda                 int_sprite_byte,x   
INT_sprite1         sta                 $7f8
                    jmp                 flash_check         
int_normal
                    ldx                 #0                  ; mouth open
                    lda                 int_sprite_byte,x   
                    sta                 $7f8                
                    jmp                 flash_check         
int_skip2           inc                 int_counter
                    lda                 int_counter         
                    cmp                 #5                  ; Controls PAC Chomp Speed
                    bne                 flash_check         
                    lda                 #0                  
                    sta                 int_counter         
                    inc                 int_sprite          
                    ldx                 int_sprite          
                    cpx                 #3                  ; int_spr_high
                    bne                 @int_skip           
                    ldx                 #0                  
                    stx                 int_sprite          
@int_skip           lda                 int_sprite_byte,x
                    sta                 $07f8               

flash_check         inc                 flash_counter2
                    lda                 flash_counter2      
                    cmp                 #20                 
                    bne                 end_int             
                    inc                 SM_Flash_White_bl+1 
                    lda                 #0                  
                    sta                 flash_counter2      

                    Int_Flash           gh2_flashon,#0      ; Make Ghost 1 flash
                    Int_Flash           gh3_flashon,#1      ; Make Ghost 2 flash
                    Int_Flash           gh4_flashon,#2      ; Make Ghost 3 flash
                    Int_Flash           gh5_flashon,#3      ; Make Ghost 4 flash

                    lda                 flash_counter       
                    cmp                 #2                  
                    bcc                 @_inc               
                    lda                 #0                  
                    sta                 flash_on            
                    lda                 #0                  
                    sta                 flash_counter       
@_inc               inc                 flash_counter
end_int             jmp                 $ea31               ; Done with Interrupt

;Created this marco to make Interrupt flashing code more readable
defm                Int_Flash
                    lda                 /1                  
                    cmp                 #1                  
                    bne                 @end                
                    inc                 flash_on            
                    ldy                 /2                  
                    jsr                 set_flash_color     
@end
endm
INT_PAC_TXT1        lda                 #$20
                    jsr                 INT_PAC_TXT2+2      
                    jsr                 INT_PAC_TXT3+2      
                    rts
INT_PAC_TXT2        lda                 #160
                    sta                 $497                
                    sta                 $498                
                    sta                 $499                
                    sta                 $4be                
                    sta                 $4e5                
                    sta                 $50d                
                    sta                 $536                
                    sta                 $55f                
                    sta                 $560                
                    sta                 $561                
                    lda                 #$20                
                    jsr                 INT_PAC_TXT3+2      
                    rts
INT_PAC_TXT3        lda                 #160
                    sta                 $4BF                
                    sta                 $4c0                
                    sta                 $4c1                
                    sta                 $4e6                
                    sta                 $50e                
                    sta                 $537                
                    sta                 $538                
                    sta                 $539                
                    inc                 TURN_ON_ATTRACT     
                    rts
WV_sound_off
                    lda                 #1                  
                    sta                 SM_SIREN_U_D+1      

                    lda                 #0                  
                    sta                 snd2+1              
                    sta                 SND2                
                    sta                 WV_GH_DELAY         
                    sta                 WV_EY_DELAY         
                    sta                 WV_SIREN_DLY        
                    sta                 SIREN               
                    lda                 #Const_WV_EYES      
                    sta                 WV_EYES             
                    lda                 #Const_WV_GHOST     
                    sta                 WV_GHOST            
                    rts
SOUND_SIREN
SM_SIREN_TOGGLE     lda                 #$00
                    beq                 WV_sound_off        

                    lda                 SOUND_SIREN_EYES    
                    beq                 @BK_SIREN           
                    cmp                 #1                  
                    beq                 @EYES               
@GHOST
                    inc                 WV_GH_DELAY         ; Slow down the siren
                    lda                 WV_GH_DELAY         
                    cmp                 #4                  
                    beq                 @BUS_USUAL1         
                    jmp                 DW_end              
@BUS_USUAL1         lda                 #0
                    sta                 WV_GH_DELAY         
                    inc                 WV_GHOST            
                    lda                 WV_GHOST            
                    cmp                 WV_GHOST_MIN        
                    beq                 @CHG_WV_GHOST       
                    sta                 SND2+1              
                    jmp                 DW_end              
@CHG_WV_GHOST       lda                 #Const_WV_GHOST
                    sta                 WV_GHOST            
                    jmp                 DW_end              
@EYES
                    inc                 WV_EY_DELAY         ; Slow down the siren
                    lda                 WV_EY_DELAY         
                    cmp                 #3                  
                    beq                 @BUS_USUAL2         
                    jmp                 DW_end              
@BUS_USUAL2
                    lda                 #0                  
                    sta                 WV_EY_DELAY         
                    dec                 WV_EYES             
                    lda                 WV_EYES             
                    cmp                 WV_EYES_MIN         
                    beq                 @CHG_WV_EYES        
                    sta                 SND2+1              
                    jmp                 DW_end              
@CHG_WV_EYES        lda                 #Const_WV_EYES
                    sta                 WV_EYES             
                    jmp                 DW_end              
@BK_SIREN
                    inc                 WV_SIREN_DLY        ; Slow down the siren
                    lda                 WV_SIREN_DLY        
SM_SIREN_DELAY      cmp                 #5
                    beq                 @BUS_USUAL          
                    jmp                 DW_end              

@BUS_USUAL          lda                 #0
                    sta                 WV_SIREN_DLY        

SM_SIREN_U_D        lda                 #$00                ; SIREN UP OR DOWN
                    cmp                 #1                  ; SIREN UP
                    bne                 SIREN_DOWN          
                    inc                 SIREN               
                    lda                 SIREN               
SM_SIREN_MAX        cmp                 #100                ;SIREN_MAX
                    beq                 CHG_SIREN_DOWN      
                    jmp                 STORE_SIREN         
SIREN_DOWN          dec                 SIREN
                    lda                 SIREN               
SM_SIREN_MIN        cmp                 #50                 ;SIREN_MIN
                    beq                 CHG_SIREN_UP        
STORE_SIREN
                    sta                 SND2+1              
                    JMP                 DW_end              
CHG_SIREN_UP        lda                 #1                  ; SIREN UP
                    jmp                 CHG_SIREN_DOWN+2    
CHG_SIREN_DOWN      lda                 #0                  ; SIREN DOWN
                    STA                 SM_SIREN_U_D+1      
                    rts
SIREN_INIT

                    lda                 #0                  
                    sta                 SOUND_SIREN_EYES    
                    sta                 SND2+5              
                    lda                 #1                  
                    sta                 SM_SIREN_U_D+1      
                    lda                 #Const_SIREN_VOL    
                    sta                 SND2+6              
                    lda                 #15                 
                    sta                 SND2+17             
SM_SIREN_VOL        lda                 #17
                    sta                 SND2+4              
                    lda                 SIREN_MIN           
                    sta                 SIREN               
                    lda                 #Const_WV_EYES      
                    sta                 WV_EYES             
                    lda                 #Const_WV_GHOST     
                    sta                 WV_GHOST            
                    lda                 #0                  
                    sta                 SM_SIREN_TOGGLE+1   
                    rts

SOUND_DEATH
SM_DW_TRIGGER       lda                 #$00                ; DEATH SOUND TRIGGERED?
                    beq                 DW_end              ; No then end
                    inc                 WV_DTH_DLY          ; Slow down the siren
                    lda                 WV_DTH_DLY          
                    cmp                 #1                  
                    beq                 @BUS_USUAL          
                    jmp                 DW_end              
@BUS_USUAL          lda                 #0
                    sta                 WV_DTH_DLY          
                    inc                 DEATH_SIREN         ; INC TONE
                    lda                 DEATH_SIREN         
                    sta                 SND+1               ; Produce the tone
SM_DW_MAX           cmp                 #$90                ; REACHED TOP OF TONE?
                    bne                 DW_end              ; NO =end, yes=get next max,min tones
                    jsr                 DW_GET_NX_SIREN     ; Grab next set of min,max
                    bne                 DW_end              ; Was top of tone reached?,no=return from int, yes=quit
@end_program        lda                 #0                  ; Turn off trigger
                    sta                 SM_DW_TRIGGER+1     
                    lda                 #0                  ;
                    sta                 SND+1               ; Turn off sound
DW_end              rts                                     ; Return from interrupt

DW_GET_NX_SIREN     inc                 DEATH_WV_SIREN_DLY  ; INC SIREN counter index
                    ldx                 DEATH_WV_SIREN_DLY  
                    lda                 DEATH_SND_MIN,x     ; SET MIN OF TONE
                    sta                 DEATH_SIREN         
                    lda                 DEATH_SND_MAX,x     ; SET MAX OF TONE
                    sta                 SM_DW_MAX+1         
                    rts
DW_INIT             lda                 #15
                    sta                 SND+24              
                    lda                 #15                 
                    sta                 SND+5               
                    lda                 #Const_Voice1_sus         
                    sta                 SND+6               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    lda                 #$ff                ; Init to 255 so it will inc to 0 on first run
                    sta                 DEATH_WV_SIREN_DLY  
                    jsr                 DW_GET_NX_SIREN     ; Initialize first SIREN
                    rts

; Draw Game Map one line at a time
; This routine must be called 25 times to
; draw the entire screen
Shift_Draw_Map      ldy                 #0
@inner1a            lda                 $428,y
                    sta                 $400,y              
                    lda                 $d828,y             
                    sta                 $d800,y             
                    iny
                    bne                 @inner1a            
@inner1b            lda                 $528,y
                    sta                 $500,y              
                    lda                 $d928,y             
                    sta                 $d900,y             
                    iny
                    bne                 @inner1b            
@inner1c            lda                 $628,y
                    sta                 $600,y              
                    lda                 $da28,y             
                    sta                 $da00,y             
                    iny
                    bne                 @inner1c            
@inner1d            lda                 $728,y
                    sta                 $700,y              
                    lda                 $db28,y             
                    sta                 $db00,y             
                    iny
                    cpy                 #$c0                
                    bne                 @inner1d            
                    ldy                 #0                  
SM_mapxy            lda                 $0400,y             ; Value changed above
                    sta                 $7c0,y              
                    jsr                 char_color          
                    sta                 @SM_mapcxy+1        
@SM_mapcxy          lda                 #$00
                    sta                 $dbc0,y             
                    iny
                    cpy                 #40                 
                    bne                 SM_mapxy            
                    clc
                    lda                 SM_mapxy+1          
                    adc                 #40                 
                    sta                 SM_mapxy+1          
                    bcc                 @skip_carryb        
                    inc                 SM_mapxy+2          
@skip_carryb        rts

SET_BG_FG_COLORS
                    lda                 MAP_BG_COLOR,x      
                    sta                 53281               
                    lda                 MAP_BD_COLOR,x      
                    sta                 53280               
                    rts
PrepMap_nLevel                                              ; Sets up temp pointers
                                                            ; to draw bottom line of new map during drawing map transition
                    ldx                 MAP_INDEX           
                    lda                 DF_Wall_Colors,x    ; Change the default wall map color
                    sta                 .SM_CH_Dflt+1       
                    jsr                 SET_BG_FG_COLORS    

                    lda                 SIREN_MIN,x         
                    sta                 SM_SIREN_MIN+1      
                    lda                 SIREN_MAX,x         
                    sta                 SIREN               
                    sta                 SM_SIREN_MAX+1      
                    lda                 SIREN_DELAY,x       
                    sta                 SM_SIREN_DELAY+1    
                    lda                 #0                  
                    sta                 SM_SIREN_U_D+1      
                    lda                 ACTUAL_MAP_LEVELS,x 
                    tax
                    lda                 PACMAPH,x           
                    sta                 SM_mapxy+2          
                    lda                 PACMAPL,x           
                    sta                 SM_mapxy+1          
                    rts

; After level up pepare and draw the next MAP
; This function copies the score from the top
; Row to the bottom row so it will scroll up
; with the map as it is drawn/shifted up one line at a time.
DRAW_NEXT_MAP                                               
                    jsr                 PrepMap_nLevel      ; Prep Map for Next level
                    jsr                 Save_Clr_TopRow     ; COpy TOP ROW and blank it out
                    jsr                 Shift_Draw_Map      
                    jsr                 RESTORE_BOT_ROW     ; Restore from the TOP to the bottom row so score will scroll up
                    ldx                 #0                  
@loop_map
                    jsr                 Shift_Draw_Map      ; Shift the new map up one line at a time from the bottom up
                    inx
                    cpx                 #24                 
                    bne                 @loop_map           
                    cli
                    rts
Scroll_Message

@do_msg             tya
                    pha
                    txa
                    pha
                    inc                 @scroll_cntr+1      
@scroll_cntr        lda                 #$00
                    cmp                 #$15                
                    bne                 BOT_Message         
                    lda                 #0                  
                    sta                 @scroll_cntr+1      
                    ldx                 #00                 ; shift characters to the left
@loop               lda                 $0401,x
                    sta                 $0400,x             
                    lda                 $d801,x             
                    sta                 $d800,x             
                    inx
                    cpx                 #39                 
                    bne                 @loop               
SM_charoffset       ldx                 #$00                ; insert next character
                    lda                 message,x           
                    sta                 $0427               
                    lda                 txtcolors,x         
                    sta                 $d827               
                    inx
                    lda                 message,x           
                    bne                 @sk                 
                    ldx                 #0                  
@sk                 stx                 SM_charoffset+1
BOT_Message         ldx                 #$50
                    jsr                 dly5                
                    pla
                    tax
                    pla
                    tay
                    rts


SOUND_OFF           lda                 #0
                    sta                 SND                 
                    sta                 SND+1               
                    sta                 SND2                
                    sta                 SND2+1    
                    lda                 #0                  
                    sta                 SND+5               
                    sta                 SND+6                                   
                    rts
SOUND_FREE_MAN2
SM_SND_FREEMN_TGR   lda                 #$00
                    bne                 @cont               
@wend               jmp                 @end
@cont               lda                 MAP_INDEX
                    cmp                 #10                 
                    bcs                 @skip               ; Fixes bug on maps 11 and up where free man sound does not work right
                    lda                 SND+1               ; DONT INTERRUPT this sound if voice 1 in use already
                    bne                 @wend               
                    lda                 #10                 ; Doing this because gradually the free man sound beep gap decreases over time
                    jmp                 @skip+2             
@skip               lda                 #20
                    sta                 @SM_TICKS+1         
                    inc                 @SM_CLOCK_TICKS+1   
@SM_CLOCK_TICKS     lda                 #$00
@SM_TICKS           cmp                 #20
                    bne                 @end                
                    lda                 #0                  
                    sta                 @SM_CLOCK_TICKS+1   
                    lda                 #15                 
                    sta                 SND+24              
                    lda                 #15                 
                    sta                 SND+5               
                    lda                 #Const_Voice1_sus          
                    sta                 SND+6               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    inc                 @SM_BEEPS+1         
@SM_BEEPS           lda                 #$00
                    cmp                 #1                  
                    beq                 @MAKE_QUIET         
                    cmp                 #2                  
                    beq                 @MAKE_QUIET         
                    cmp                 #3                  
                    beq                 @MAKE_BEEP          
                    cmp                 #4                  
                    beq                 @MAKE_QUIET         
                    cmp                 #5                  
                    beq                 @MAKE_BEEP          
                    cmp                 #6                  
                    beq                 @MAKE_QUIET         
                    cmp                 #7                  
                    beq                 @MAKE_BEEP          
                    cmp                 #8                  
                    beq                 @MAKE_QUIET         
                    cmp                 #9                  
                    beq                 @MAKE_BEEP          
                    cmp                 #10                 
                    beq                 @MAKE_QUIET         
                    lda                 #0                  
                    sta                 @SM_BEEPS+1         
                    sta                 @SM_CLOCK_TICKS+1   
                    sta                 SM_SND_FREEMN_TGR+1 
                    jmp                 @end                

@MAKE_BEEP          lda                 #45
                    sta                 SND+1               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    jmp                 @end                
@MAKE_QUIET
                    lda                 #0                  
                    sta                 SND+1               
@end                rts

SOUND_LVL_UNLOCK
                    lda                 #25                 
                    sta                 @main_loop+1        
@sound2
                    lda                 #28                 
                    sta                 SND+5               
                    lda                 #Const_Voice1_sus         
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24              
                    lda                 #33                 
                    sta                 SND+4               

                    ldx                 #0                  
@mini               inc                 @main_loop+1
                    txa
                    pha
                    jsr                 @main_loop          
                    pla
                    tax
                    inx
                    cpx                 #15                 
                    bne                 @mini               

                    ldx                 #0                  
@mini2              inc                 @main_loop+1
                    inc                 @main_loop+1        
                    txa
                    pha
                    jsr                 @main_loop          
                    pla
                    tax
                    inx
                    inx
                    cpx                 #10                 
                    bne                 @mini2              
@done               lda                 #0
                    sta                 SND+1               
                    rts
@main_loop          ldy                 #25
@loopx              ldx                 #25
                    jsr                 DOWN_SIREN          
                    rts
DOWN_SIREN
                    stx                 @SM_2+1             
@loopabc            tya
                    sta                 SND+1               
                    pha
                    jsr                 @delay              
                    pla
                    tay
                    dey
@SM_2               cpy                 #15
                    bne                 @loopabc            
                    rts

@delay              ldx                 #5
                    jsr                 delay8              
                    rts

SOUND_EAT_FRUIT
                    lda                 #15                 
                    sta                 SND+24              
                    lda                 #Const_Voice1_sus          
                    sta                 SND+6               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    ldy                 #22                 
                    ldx                 #01                 
                    jsr                 DOWN_SIREN          
                    ldy                 #10                 
                    ldx                 #35                 
                    jsr                 UP_SIREN            
                    lda                 #0                  
                    sta                 SND+1               
                    rts
UP_SIREN
                    stx                 @SM_1+1             
@loopab             tya
                    sta                 SND+1               
                    pha
                    jsr                 @delay              
                    pla
                    tay
                    iny
@SM_1               cpy                 #15
                    bne                 @loopab             
                    rts

@delay              ldx                 #4
                    jsr                 delay8              
                    rts
SOUND_BOOST
                    lda                 #28                 
                    sta                 SND+5               
                    lda                 #Const_Voice1_sus          
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24              
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    lda                 #39                 
                    sta                 SND+1               
                    jsr                 @delay              
                    lda                 #62                 
                    sta                 SND+1               
                    jsr                 @delay              
                    lda                 #0                  
                    sta                 SND+1               
                    rts
@delay              ldx                 #150
                    jsr                 delay8              
                    rts
SOUND_SUPERBONUS
                    lda                 #Const_Voice1_sus          
                    sta                 SND+6               
                    lda                 #33                 
                    sta                 SND+4               

                    ldx                 #0                  
@loopy              jsr                 @Create_SIRENs
                    inx
                    cpx                 #3                  
                    bne                 @loopy              

                    lda                 #0                  
                    sta                 SND+1               
                    rts
@Create_SIRENs
                    txa
                    pha
                    ldy                 #35                 
                    ldx                 #40                 
                    jsr                 UP_SIREN            
                    ldy                 #40                 
                    ldx                 #45                 
                    jsr                 UP_SIREN            
                    ldy                 #45                 
                    ldx                 #50                 
                    jsr                 UP_SIREN            
                    ldy                 #50                 
                    ldx                 #55                 
                    jsr                 UP_SIREN            
                    ldy                 #55                 
                    ldx                 #60                 
                    jsr                 UP_SIREN            
                    pla
                    tax
                    rts
SOUND_EATGHOST
                    lda                 #75                 
                    sta                 SND+1               

                    lda                 #43                 
                    sta                 SND+5               
                    lda                 #Const_Voice1_sus         
                    sta                 SND+6               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    ldy                 #5                  
                    ldx                 #105                
                    jsr                 UP_SIREN            
                    ldy                 #15                 
                    ldx                 #17                 
                    jsr                 UP_SIREN            
                    lda                 #0                  
                    sta                 SND+1               
                    rts
CHECK_BG_SOUND
                    lda                 gh2_eyesmode        
                    ora                 gh3_eyesmode        
                    ora                 gh4_eyesmode        
                    ora                 gh5_eyesmode        
                    cmp                 #1                  
                    beq                 @EYES_BG_SOUND      
                    lda                 gh2_bluetime        
                    ora                 gh3_bluetime        
                    ora                 gh4_bluetime        
                    ora                 gh5_bluetime        
                    cmp                 #1                  
                    beq                 @GH_BG_SOUND        
                    lda                 #0                  ; 0 = Normal BG Siren
                    jmp                 @exit               
@EYES_BG_SOUND      lda                 #1                  ; 1= EYES BG SIREN
                    jmp                 @exit               
@GH_BG_SOUND
                    lda                 #2                  ; 2 = GHOST BG SIREN
@exit               sta                 SOUND_SIREN_EYES
                    rts
SOUND_INTRO
                    lda                 #9                  
                    sta                 SND+5               
                    lda                 #195                
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24              

                    lda                 #30                 
                    sta                 SND+1               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    ldx                 #140                
                    jsr                 delay8              
                    jsr                 @gap                
                    ldx                 #35                 
                    jsr                 delay8              
                    lda                 #30                 
                    sta                 SND+1               
                    ldx                 #35                 
                    jsr                 delay8              
                    jsr                 @gap                
                    lda                 #30                 
                    sta                 SND+1               
                    ldx                 #32                 
                    jsr                 delay8              
                    jsr                 @gap                
                    lda                 #40                 
                    sta                 SND+1               
                    ldx                 #150                
                    jsr                 delay8              
                    ldx                 #100                
                    jsr                 @gap+2              
                    lda                 #45                 
                    sta                 SND+1               
                    ldx                 #0                  
                    jsr                 delay8              
                    ldx                 #0                  
                    jsr                 delay8              
                    lda                 #0                  
                    STA                 SND+1               
                    sta                 SND+4               
                    sta                 SND+5               
                    sta                 SND+6               
                    rts
@gap                ldx                 #60
                    lda                 #16                 
                    sta                 SND+4               
                    jsr                 delay8              
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    rts
SOUND_Challenge
                    lda                 #9                  
                    sta                 SND+5               
                    lda                 #155                
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24              
                    lda                 #33                 
                    sta                 SND+1               
                    lda                 SND_OTHER_VOL       
                    sta                 SND+4               
                    ldx                 #0                  
                    jsr                 delay8              
                    ldx                 #70                 
                    jsr                 delay8              
                    lda                 #43                 
                    sta                 SND+1               
                    ldx                 #100                
                    jsr                 delay8              
                    lda                 #53                 
                    sta                 SND+1               
                    ldx                 #100                
                    jsr                 delay8              
                    lda                 #63                 
                    sta                 SND+1               
                    ldx                 #100                
                    jsr                 delay8              
                    lda                 #85                 
                    sta                 SND+1               
                    lda                 #16                 
                    sta                 SND+4               
                    rts
TURN_ON_ALL_SOUNDS
                    lda                 #0                  
                    sta                 SND+4                 
                    lda                 #Const_SIREN_SND    ; Turn on ALL SOUND
                    sta                 SM_SIREN_VOL+1      
                    lda                 #Const_OTHER_SND    
                    sta                 SND_OTHER_VOL       
                    lda                 #Const_DOT_SND      
                    sta                 SM_DOT_SND+1        
                    rts
TURN_OFF_ALL_SOUNDS
                    lda                 #0                  ; TURN OFF ALL GAME SOUND
                    sta                 SM_SIREN_VOL+1      ; HOPFULLY
                    sta                 SND_OTHER_VOL       
                    sta                 SM_DOT_SND+1        
                    rts
;***************************************
; *** These vars are down here to fix
; *** Memory overwrite at $f82
; *** I know, too many variables, ugh!!
;***************************************
UNLOCK              byte                $7E,$7D,$7B,$7B,$77,$77  ; LEFT, LEFT, RIGHT, RIGHT, UP, DOWN to UNLOCK
SECRET_CODE         byte                255,255,255,255,255,255

TTLHIGH             bytes               7                   ; Create space for High Score
;***************************************
; *** Sound Effect Variables         ***
;***************************************
WV_SIREN_DLY        byte                00
WV_DTH_DLY          byte                00
WV_GH_DELAY         byte                00
WV_EY_DELAY         byte                00

DEATH_SIREN         byte                00                            ; CURRENT TONE OF DEATH SOUND
DEATH_WV_SIREN_DLY  byte                $ff
DEATH_SND_MIN       byte                70,60,55,50,40,35,30,25,20,18,16,14,10,10,10,05,0
DEATH_SND_MAX       byte                90,80,70,60,50,45,40,35,30,24,22,21,20,20,20,15,0
SIREN               byte                00
SOUND_SIREN_EYES    byte                00
WV_EYES             byte                00
WV_EYES_MIN         byte                35
WV_GHOST            byte                00
WV_GHOST_MIN        byte                22
;***************************************
; *** Program Interrupt Variables    ***
;***************************************
int_nrgize          byte                00
int_param           byte                00
int_counter         byte                00
int_sprite          byte                00
Gobble_on           byte                00
INT_TTLSCN_ACTIVE   byte                00
TURN_ON_ATTRACT     byte                00 ; Counts how many chomps on title screen before enabling ATTRACT_MODE
INT_PAC_TXT         byte                00 ; Used to Keep track of ttl screen pac-open - close state
int_sprite_byte     byte                Const_SPR_ROOT,Const_SPR_ROOT+1,Const_SPR_ROOT+2
spr_up              byte                Const_SPR_ROOT,Const_SPR_ROOT+1,Const_SPR_ROOT+2
spr_down            byte                Const_SPR_ROOT+3,Const_SPR_ROOT+4,Const_SPR_ROOT+2
spr_left            byte                Const_SPR_ROOT+5,Const_SPR_ROOT+6,Const_SPR_ROOT+2
spr_right           byte                Const_SPR_ROOT+7,Const_SPR_ROOT+8,Const_SPR_ROOT+2

flash_counter       byte                00
flash_on            byte                00
flash_counter2      byte                00
flash_counter4      byte                00
FLASH_ONLY          byte                00
ENG_FLASH_ON        byte                00 ; energizer flash on toggle
;****************************************
message             text                'brought to you by gray defender '
                    text                'feb 2017> press space or use joystick '
                    TEXT                'in port 2> '
                    TEXT                'complete challenge maps for bonus points>'
                    TEXT                '                                       '
                    TEXT                'wow! are you still reading this? '
                    text                'really? why???  enjoy!!                                       '
                    byte                00
txtcolors           byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,1,1,7,7,7,7,7,1,1,1,1,1,1,1,1,7,7,7,7,7,7,7,7,1,1,1,1,1,1,1,1,1,4,1,1,1,1,1
                    byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
