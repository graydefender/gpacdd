*=$1000
l1                  lda                 $d012
l2                  cmp                 $d012
                    beq                 l2                  
                    bmi                 l1                  
                    cmp                 #$20                
                    bcc                 ntsc
                    lda #$30
                    sta                 $400                
                    rts
ntsc                lda                 #$31                
                    sta                 $400                
                    rts
