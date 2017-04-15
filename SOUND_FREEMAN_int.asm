*=$1000
SND=54272
SOUND_FREE_MAN    
                    
                    lda                 #15                 
                    sta                 SND+24                                  

                   ; lda                 #8                 
                   ; sta                 SND+1               

                    lda                 #15                 
                    sta                 SND+5
                    lda                 #%11110000                
                    sta                 SND+6               
                    lda                 #17                  
                    sta                 SND+4               
                    jsr INIT
make_sound          lda                 #1                  
                    sta                 SOUND_FREEMN_TRIGGER
                    rts
                    
INIT
REDIR               SEI
                    LDA                 #<INTERRUPT
                    LDX                 #>INTERRUPT
                    STA                 $0314
                    STX                 $0315                    
                    rts
INTERRUPT
@sound2             lda SOUND_FREEMN_TRIGGER
                    beq @end
                    inc CLOCK_TICKS
                    lda                 CLOCK_TICKS         
                    cmp                 #10                 
                    bne @end
                    lda                 #0                  
                    sta CLOCK_TICKS

                    inc BEEP_COUNTER
                    lda                 BEEP_COUNTER        
                    cmp                 #1                  
                    beq                 @MAKE_BEEP                              
                    cmp                 #2                  
                    beq                 @MAKE_QUIET         
                    cmp                 #3                  
                    beq                 @MAKE_BEEP                            
                    cmp                 #4
                    beq                 @MAKE_QUIET                             
                    cmp                 #5
                    beq                 @MAKE_BEEP                              
                    cmp                 #6                  
                    beq                 @MAKE_QUIET         
                    lda                 #0                  
                    sta BEEP_COUNTER
                    sta SOUND_FREEMN_TRIGGER
                    jmp @end

@MAKE_BEEP 
                    lda                 #45                 
                    sta                 SND+1                
                    lda                 #17                 
                    sta                 SND+4 
                    ;jsr @delay_2
                    ;lda                 #16                 
                    ;sta                 SND+4                
                    jmp $ea31
@MAKE_QUIET
                    lda                 #0                  
                    sta                 SND+1                 
@end                    jmp                 $ea31               
                    

SOUND_FREEMN_TRIGGER  byte                00                    
CLOCK_TICKS         byte                00
BEEP_COUNTER        byte                00
delay8              
@lp3                ldy #0
@lp4                 dey
                    bne                 @lp4
                    dex
                    bne @lp3
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