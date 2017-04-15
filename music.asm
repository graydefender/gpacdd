*=$810        

music               = $1000

                    lda #0
                    jsr                 music               
                    
loop2               jsr                 music+3
                    jsr                 delay               
                    jmp loop2
  
delay               ldx #5 
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts                    
*=$f82 
incbin              "graydefender.sid"
                    