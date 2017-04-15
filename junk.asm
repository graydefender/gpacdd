*=$1000

SB                  = 54272
                    ;jsr                 sound               
                    ;jsr d
                    ldy                 #0                  
@loop               lda                 #0                  
                    sta                 SB,y                
                    iny
                    cpy                 #28                 
                    bne @loop
                    lda                 #15                 
                    sta                 SB+24               

                    lda                 #16                 
                    sta                 SB+1                

                    lda                 #0                  
                    sta                 SB+5                

                    lda                 #103                
                    sta                 SB+6                
                    jsr                 SOUND 
                        jsr dly4ab
                    jsr sound

                    jsr                 SOUND 
                        jsr dly4ab
                    jsr sound
                    jsr                 SOUND 
                        jsr dly4ab
                    jsr sound

SOUND
                    lda                 #%00010001                 
                    sta                 SB+4 
                    jsr dly4ab
                    lda                 #0                 
                    sta                 SB+4                
                    rts
                    

dly4a               
DLY4AB              ldx                 #240
@loop_xxab          jsr                 delay
                    dex
                    bne                 @loop_xxab          
                    rts
                    
delay               txa
                    pha
                    tya
                    pha
                    ldy                 #2                  
@del_lp2            ldx                 #1
@del_lp1            dex
                    cpx                 #0                  
                    bne                 @del_lp1            
                    dey
                    cpy                 #0                  
                    bne                 @del_lp2            
                    pla
                    tay
                    pla
                    tax
                    rts