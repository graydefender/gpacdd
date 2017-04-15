*=$1000
SND = 54272
SOUND_Challenge                  
                   
;                    ldy                 #0                  
;@loop               lda                 #0                  
;                    sta                 SND,y                
;                    iny
;                    cpy                 #24                 
;                    bne @loop
@sound2             lda                 #9                 
                    sta                 SND+5               
                    lda                 #155                
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24                                                      
                    lda                 #33                 
                    sta                 SND+1               
                    lda                 #17                  
                    sta                 SND+4               
                    ldx #0
                    jsr                 delay8              
                    ldx                 #70                  
                    jsr delay8
                    lda                 #43                 
                    sta                 SND+1               
                    ldx #100
                    jsr                 delay8
                    lda                 #53                 
                    sta                 SND+1               
                    ldx #100
                    jsr                 delay8
                    lda                 #63                 
                    sta                 SND+1               
                    ldx #100
                    jsr                 delay8             
                    lda                 #85                 
                    sta                 SND+1 
                    lda                 #16                
                    sta SND+4
                    rts
                                 

delay8              
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts