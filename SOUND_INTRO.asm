*=$1000
SND = 54272
SOUND_INTRO
                   
@sound2             lda                 #9                 
                    sta                 SND+5               
                    lda                 #195                
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24
                                                      
                    lda                 #30                 
                    sta                 SND+1               
                    lda                 #17                  
                    sta                 SND+4               
                    ldx #140
                    jsr                 delay8              
                    jsr @gap
                    ldx #35                  
                    jsr delay8
                    lda                 #30                 
                    sta                 SND+1               
                    ldx #35
                    jsr                 delay8              
                    jsr @gap                    
                    lda                 #30                
                    sta                 SND+1               
                    ldx #32
                    jsr                 delay8              
                    jsr @gap                    
                    lda                 #40                 
                    sta                 SND+1               
                    ldx #150
                    jsr                 delay8              
                    ldx #100
                    jsr @gap+2
                    lda                 #45                 
                    sta                 SND+1               
                    ldx #0
                    jsr                 delay8              
                    ldx #0
                    jsr                 delay8              
                    lda                 #0                  
                    sta                 SND+1               
                    sta SND
                    rts
@gap                ldx #60 
                    lda                 #16                  
                    sta                 SND+4                                  
                    jsr delay8             
                    lda                 #17                  
                    sta                 SND+4               
                    rts                             
                            

delay8              
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts