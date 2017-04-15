*=$1000
SND                 = 54272
                    
SOUND_LVL_UNLOCK   jsr                 @sound

                    rts
@sound              ldy                 #0                  
@loop               lda                 #0                  
                    sta                 SND,y                
                    iny
                    cpy                 #28                 
                    bne                 @loop               
                    lda                 #25                 
                    sta @main_loop+1
@sound2         
                    lda                 #28                 
                    sta                 SND+5                                  
                    lda                 #195                 
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24
                    lda                 #33                  
                    sta                 SND+4               
                    
                    ldx #0  
@mini               inc                 @main_loop+1        
                    txa
                    pha     
                    jsr                 @main_loop          
                    pla
                    tax
                    inx
                    cpx                 #15                                     
                    bne                 @mini
                    
                    ldx #0
@mini2              inc                 @main_loop+1             
                    inc                 @main_loop+1        
                    txa
                    pha
                    jsr                 @main_loop          
                    pla
                    tax
                    inx
                    inx
                    cpx                 #10                                     
                    bne                 @mini2
@done               lda                 #0                  
                    sta                 SND+1               
                    rts
@main_loop          ldy #25
@loopx              ldx #25
                    jsr                 @WAVE_DOWN
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

@delay              ldx #7
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
