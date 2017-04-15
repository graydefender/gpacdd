*=$1000
SND = 54272
SOUND_SUPERBONUS
 
@sound2       
                    lda                 #28                 
                    sta                 SND+5               
                    lda                 #%11110000          
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24                                                      
                    lda                 #33                  
                    sta                 SND+4               

                    ldx                 #0                  
@loopy              jsr                 @Create_Waves       
                    inx
                    cpx                 #3                 
                    bne                 @loopy                       
                    
                    lda                 #0                  
                    sta                 SND+1               
                    rts
@Create_Waves                    
                    txa
                    pha
                    ldy                 #35                 
                    ldx                 #40                 
                    jsr                 @WAVE_UP            
                    ldy                 #40                 
                    ldx                 #45                 
                    jsr                 @WAVE_UP            
                    ldy                 #45                 
                    ldx                 #50                 
                    jsr                 @WAVE_UP            
                    ldy                 #50                 
                    ldx                 #55                 
                    jsr                 @WAVE_UP            
                    ldy                 #55                 
                    ldx                 #60                 
                    jsr                 @WAVE_UP            
                    pla
                    tax
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

@delay              ldx #6
@lp2                ldy #00
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts