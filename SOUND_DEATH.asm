*=$1000
SND = 54272
SOUND_DEATH                  
                    jsr                 @sound               

                    rts
@sound               ldy                 #0                  
@loop               lda                 #0                  
                    sta                 SND,y                
                    iny
                    cpy                 #28                 
                    bne @loop
@sound2             lda                 #28                 
                    sta                 SND+5               
                    lda                 #195                
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24                                  
                    lda                 #19                  
                    sta                 SND+4               
                    jsr                 @delay              
                    jsr @delay
                    jsr @delay
                    ldy #70
                    ldx #90
                    jsr @WAVE_UP
                    ldy #60
                    ldx #80
                    jsr @WAVE_UP
                    ldy #50
                    ldx #60
                    jsr @WAVE_UP
                    ldy #40
                    ldx #50
                    jsr @WAVE_UP
                    ldy #30
                    ldx #40
                    jsr @WAVE_UP
                    ldy #20
                    ldx #30
                    jsr @WAVE_UP
                    ldy #10
                    ldx #20
                    jsr @WAVE_UP
                    ldy #10
                    ldx #20
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

@delay              ldx #7
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts