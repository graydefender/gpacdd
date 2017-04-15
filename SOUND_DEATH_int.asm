*=$1000
SND = 54272
SOUND_DEATH  

                    lda #$ff                                ; Init to 255 so it will inc to 0 on first run
                    sta                 DEATH_WAVE_CTR      
                    jsr                 DW_GET_NX_WAVE      ; Initialize first wave
                    lda                 #1                  
                    sta                 DW_TRIGGER          
                    
REDIR               SEI
                    LDA                 #<INTERRUPT
                    LDX                 #>INTERRUPT
                    STA                 $0314
                    STX                 $0315  
                    lda                 #15                 
                    sta                 SND+24                                  
                    lda                 #15                 
                    sta                 SND+5
                    lda                 #%11110000                
                    sta                 SND+6               
                    lda                 #17                  
                    sta                 SND+4                
                    rts                    

INTERRUPT           lda                 DW_TRIGGER          ; DEATH SOUND TRIGGERED?
                    beq                 DW_end              ; No then end                  
                    inc                 DEATH_WAVE          ; INC TONE
                    lda                 DEATH_WAVE 
                    sta SND+1                               ; Produce the tone         
SM_DW_MAX           cmp #$90                                ; REACHED TOP OF TONE?
                    bne DW_end                              ; NO =end, yes=get next max,min tones
                    jsr                 DW_GET_NX_WAVE      ; Grab next set of min,max    
                    bne                 DW_end              ; Was top of tone reached?,no=return from int, yes=quit                           
@end_program        lda #0                                  ; Turn off trigger
                    sta DW_TRIGGER
                    lda                 #0                  ;                
                    sta                 SND+1               ; Turn off sound
DW_end              jmp $ea31                               ; Return from interrupt

DW_GET_NX_WAVE      inc                 DEATH_WAVE_CTR      ; INC Wave counter index
                    ldx                 DEATH_WAVE_CTR      
                    lda                 DEATH_WAVES_MIN,x   ; SET MIN OF TONE                    
                    sta                 DEATH_WAVE
                    lda                 DEATH_WAVES_MAX,x   ; SET MAX OF TONE
                    sta                 SM_DW_MAX+1           
                    rts           

DW_TRIGGER          byte 00
DEATH_WAVE          byte 00                            ; CURRENT TONE OF DEATH SOUND
DEATH_WAVE_CTR      byte $ff                    
DEATH_WAVES_MIN     byte 70,60,50,40,30,20,10,10,0
DEATH_WAVES_MAX     byte 90,80,60,50,40,30,20,20,0
                    

