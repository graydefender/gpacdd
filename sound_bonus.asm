*=$1000
SND                 = 54272
SB = 54296                    
SOUND_BONUS   
;@sound              ldy                 #0                  
;@loop               lda                 #0                  
;                    sta                 SND,y                
;                    iny
;                    cpy                 #28                 
;                    bne                 @loop               
                   LDA                 #03                 
                    STA                 SB    
                     ldx #10             
                    jsr                 @delay
                    LDA                 #0                  
                    STA                 SB  
                    ldx                 #200                 
                    jsr @delay

@sound2         
                    lda                 #28                 
                    sta                 SND+5                                  
                    lda                 #195                 
                    sta                 SND+6               
                    lda                 #15                 
                    sta                 SND+24
                    lda                 #19                  
                    sta                 SND+4               
                    lda #39
                    sta SND+1
                    jsr                 @delay                                  
                    lda #62
                    sta SND+1
                    jsr                 @delay              
                    lda                 #0                  
                    sta snd+1
                    rts
@delay              ldx #150
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
