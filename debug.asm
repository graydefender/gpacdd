

*=$c000

          lda #15
          sta 53248
          
          lda #0
                    jsr                 music               
                    rts

@loop               jsr                 music+3
                    jsr                 delay               
                    jmp @loop
                    
                    rts
delay              ldx #15 
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
*=$1000
music
incbin "glenn1.sid"