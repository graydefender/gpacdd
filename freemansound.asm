*=$1000

SB                  = 54272
                    jsr                 sound               
                    jsr                 delay_2             
                    jsr                 sound2               
                    jsr                 delay_2             
                    jsr                 sound2              
                    jsr                 delay_2             
                    rts
sound               ldy                 #0                  
@loop               lda                 #0                  
                    sta                 SB,y                
                    iny
                    cpy                 #28                 
                    bne @loop
sound2              lda                 #15                 
                    sta                 SB+24               
                   ; jsr delay_2
                    lda                 #45                 
                    sta                 SB+1                
                   ; jsr delay_2
                    lda                 #0                  
                    sta                 SB+5                
                   ; jsr delay_2
                    lda                 #103                
                    sta                 SB+6                
                   ; jsr delay_2
                    lda                 #17                 
                    sta                 SB+4 
                    jsr delay_2
                    lda                 #16                 
                    sta                 SB+4                
                    rts
                    
delay               ldx #20 
@lp2                   ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
delay_2
                    jsr                 delay               
                    jsr                 delay               
                    jsr                 delay               
                    jsr                 delay                                   
                    jsr                 delay               
                    jsr                 delay               
                    jsr                 delay               
                    jsr                 delay                                   
                     rts