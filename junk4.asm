*=$1000
SB = 54295

                    jsr                 sound               
                    jsr                 sound               
                    jsr                 sound               
                    jsr                 sound               
                    jsr                 sound               
                    
                     rts
SOUND
                    lda                 #%00011111                
                    sta                 SB               
                    jsr                 dly4ab
                
                    lda #0
                    sta                 SB   
                    jsr new_delay            
                    rts
                    
dly4a               
DLY4AB              ldx                 #23
@loop_xxab          jsr                 delay
                    dex
                    bne                 @loop_xxab          
                    rts
                    
delay               txa
                    pha
                    tya
                    pha
                    ldy                 #3                  
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
                    
dly7
@loop_xxab12        jsr                 delay_longer
                    dex
                    bne                 @loop_xxab12        
                    rts
delay8
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne                 @lp2                
                    rts

new_delay           ldx                 #$80
                    jsr                 dly7                
                    rts
                    
delay_longer        txa
                    pha
                    tya
                    pha
                    ldy                 #1                 
@del_lp2a           ldx                 #$80
@del_lp1a           dex
                    cpx                 #0                  
                    bne                 @del_lp1a           
                    dey
                    cpy                 #0                  
                    bne                 @del_lp2a           
                    pla
                    tay
                    pla
                    tax
                    rts