*=$1000
SND = 54272


                    lda                 #1                  
                    sta                 SOUND_DOTS_TOGGLE          
                    
REDIR               SEI
                    LDA                 #<SOUND_DOTS
                    LDX                 #>SOUND_DOTS
                    STA                 $0314
                    STX                 $0315  
   
                 ;   JSR                 SOUND_CHALLENGE     
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    
                    lda #1
                    sta SOUND_DOTS_TOGGLE
                  LDX #255
                     JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              

                    LDA                 #255                
                    JSR                 DELAY8              
                    LDA                 #255                
                    JSR                 DELAY8              
                    
                    lda #1
                    sta SOUND_DOTS_TOGGLE
          
                   rts                    

SOUND_DOTS
                    lda                 SOUND_DOTS_TOGGLE          ; DEATH SOUND TRIGGERED?
                    beq                 @end2              ; No then end                  
                    inc                 SOUND_DTS           ; INC TONE
                    lda                 #15                 
                    sta                 SND+24                                  
                    lda                 #15                 
                    sta                 SND+5
                    lda                 #%11110000
                    sta                 SND+6               
                    lda                 #17                  
                    sta                 SND+4

                    
                    lda                 SOUND_DTS 
                    sta SND+1                               ; Produce the tone         
                    cmp SOUND_DTWV_MAX                                ; REACHED TOP OF TONE?
                    bne @end                              ; NO =end, yes=get next max,min tones                  
@end_program        lda #0                                  ; Turn off trigger
                    sta                 SOUND_DOTS_TOGGLE                       
                    lda                 #0                  ;                
                    sta                 SND+1               ; Turn off sound
@end2               lda                 SOUND_DTWV_MIN      
                    sta SOUND_DTS
@end                jmp $ea31

delay8
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne                 @lp2                
                    rts
SOUND_DOTS_TOGGLE  byte 00
SOUND_DTS          byte 10                            ; CURRENT TONE OF DEATH SOUND
SOUND_DTWV_MIN     byte 10
SOUND_DTWV_MAX     byte 13
                    
SOUND_CHALLENGE             lda                 #9                 
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
                                 

