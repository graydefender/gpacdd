processor           6502
*=$1000
SND2                = 54279
                    
INIT
REDIR               SEI
                    LDA                 #<INTERRUPT
                    LDX                 #>INTERRUPT
                    STA                 $0314
                    STX                 $0315
                    lda                 #195
                    sta                 SND2+5
                    lda                 #155
                    sta                 SND2+6
                    lda                 #15
                    sta                 SND2+17             
                    
                    lda                 #19
                    sta                 SND2+4
                    lda                 WAVE_MIN
                    sta                 WAVE                
                    lda                 #Const_WV_EYES       
                    sta                 WV_EYES  
                    lda #Const_WV_GHOST           
                    sta                 WV_GHOST            
                    
                    CLI
                    RTS
INTERRUPT           jsr                 WAVE_SOUND
                    ;lda                 SND+1               
                    ;sta $400
                    jmp                 $EA31               
WAVE_CTR            byte                00

                    
WAVE_SOUND

                    lda                 WAVE_SOUND_TOGGLE
                    bne                @cont
                    jmp @sound_off 
@cont               lda                 WAVE_SOUND_EYES     
                    cmp                 #0                    
                    beq                 @BK_SIREN           
                    cmp                 #1                  
                    beq                 @EYES               
@GHOST     
                    inc                 WV_GH_DELAY         ; Slow down the siren
                    lda                 WV_GH_DELAY         
                    cmp                 #1                 
                    beq                 @BUS_USUAL1         
                    JMP @END

@BUS_USUAL1         lda                 #0
                    sta                 WV_GH_DELAY                  
 
                    inc                 WV_GHOST
                    lda                 WV_GHOST
                    cmp                 WV_GHOST_MIN                             
                    beq                 @CHG_WV_GHOST                            
                    sta                 SND2+1              
                    jmp                 @end                
@CHG_WV_GHOST       
                    lda                 #Const_WV_GHOST
                    sta                 WV_GHOST             
                    jmp                 @end                                    
                    
@EYES               dec                 WV_EYES          
                    lda                 WV_EYES                    
                    cmp                 WV_EYES_MIN                             
                    beq                 @CHG_WV_EYES                            
                    sta                 SND2+1              
                    jmp                 @end                
@CHG_WV_EYES        lda                 #Const_WV_EYES
                    sta                 WV_EYES             
                    jmp                 @end                                    
                 
@BK_SIREN           lda                 WAVE_UP_OR_DOWN
                    cmp                 #1                  ; WAVE UP
                    bne                 @WAVE_DOWN
@WAVE_UP            inc                 WAVE
                    lda                 WAVE
                    cmp                 WAVE_MAX
                    beq                 @CHG_WAVE_DOWN
                    jmp                 @_STORE_WAVE
@WAVE_DOWN          dec                 WAVE
                    lda                 WAVE
                    cmp                 WAVE_MIN
                    beq                 @CHG_WAVE_UP
@_STORE_WAVE                
                    sta                 SND2+1
                    JMP                 @end
@CHG_WAVE_UP        lda #1                                ; WAVE UP
                    jmp                 @CHG_WAVE_DOWN+2
@CHG_WAVE_DOWN      lda #0                                ; WAVE DOWN
                    STA                 WAVE_UP_OR_DOWN
                    jmp                 @end
@end                rts
@sound_off          lda                 #0                  
                    sta                 snd2+1              
                    rts
WAVE_SOUND_TOGGLE   byte                01
WAVE                byte                00
WAVE_UP_OR_DOWN     byte                01
WAVE_MIN            byte                25
WAVE_MAX            byte                30
WV_GH_DELAY         byte                00
                    
Const_WV_EYES       = 45
WAVE_SOUND_EYES      byte 02
WV_EYES             byte 0
WV_EYES_MIN         byte 35 

Const_WV_GHOST       = 0
WV_GHOST             byte 0
WV_GHOST_MIN         byte 15  

  