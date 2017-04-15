*=$1000
SND                 = 54272
SB = 54296
SOUND_EAT_FRUIT     
@sound           
    ;ldy                 #0                  
;@loop               lda                 #0                  
;                    sta                 SND,y                
;                    iny
;                    cpy                 #28                 
;                    bne @loop
@sound2         
                    lda                 #15                 
                    sta                 SND+24                                  

                    lda                 #8                 
                    sta                 SND+1               

                    lda                 #15                 
                    sta                 SND+5
                    lda                 #%11110000                
                    sta                 SND+6               
                    lda                 #17                  
                    sta                 SND+4  
                    ;jsr @delay
                    ;lda                 #16                 
                    ;sta                 SND+4                
             
                    ;jsr                 @delay              
                    ;jsr @delay
                    ;jsr @delay
                    ldy #22
                    ldx #01
                    jsr @WAVE_DOWN
                    ldy #10
                    ldx #35
                    jsr @WAVE_UP
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
@WAVE_DOWN     
                    stx @SM_2+1
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

@delay              ldx #4
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
                    
@delay_more              ldx #100
@lp2a                ldy #0
@lpa                 dey
                    bne                 @lpa                 
                    dex
                    bne @lp2a
                    rts