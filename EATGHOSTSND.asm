*=$1000
SND = 54272
SOUND_EATGHOST                  
                    jsr                 @sound               

                    rts
@sound              ldy                 #0                  
@loop               lda                 #0                  
                    sta                 SND,y                
                    iny
                    cpy                 #28                 
                    bne @loop
@sound2       
                    lda                 #15                 
                    sta                 SND+24                                  
                    lda                 #75                 
                    sta                 SND+1                                  

                    lda                 #43                 
                    sta                 SND+5               
                    lda                 #17                  
                    sta                 SND+4               
                    jsr                 @delay              
                    jsr @delay
                    jsr @delay
                    ldy #5
                    ldx #105
                    jsr                 @WAVE_UP            
                    ldy                 #15                 
                    ldx                 #17                 
                    jsr @WAVE_UP
;                    lda                 #15                  
;                    sta                 SND+1               
;                    jsr                 @delay              
;                    jsr @delay
;                    jsr                 @delay              
;                    jsr @delay

                    lda                 #0                  
                    sta                 SND+1               
                    rts
                                 
@WAVE_UP     
                    stx @SM_1+1
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

@delay              ldx #4
@lp2                ldy #00
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts