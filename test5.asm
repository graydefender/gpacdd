*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $34, $30, $39, $36, $00, $00
                    byte                $00

SCORE_POS           = $411
PARAM1              byte                00
PARAM2              byte                00

*=$1000
                    lda                 #$30                ; Initilize the score
                    sta                 SCORE_POS
                    sta                 SCORE_POS+1
                    sta                 SCORE_POS+2
                    sta                 SCORE_POS+3
                    sta                 SCORE_POS+4
                    sta                 SCORE_POS+5         

                    lda                 #5
                    ldx                 #3                
                    jsr                 IncreaseScore       
                    rts

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

