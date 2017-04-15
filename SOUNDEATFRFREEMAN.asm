*=$1000
SND                 = 54272
SND2= 54279
INIT
REDIR               SEI
                    LDA                 #<INTERRUPT
                    LDX                 #>INTERRUPT
                    STA                 $0314
                    STX                 $0315               
                    jsr SOUND_EAT_FRUIT 
                    lda                 #1                  
                    sta                 SOUND_FREEMN_TRIGGER
                    lda                 #195
                    sta                 SND2+5
                    lda                 #240
                    sta                 SND2+6
                    lda                 #15
                    sta                 SND2+17             
                    
                    lda                 #19
                    sta                 SND2+4
                    lda                 WAVE_MIN
                    sta                 WAVE                
                    lda                 #Const_WV_EYES       
                    sta                 WV_EYES  
                    lda Const_WV_GHOST           
                    sta                 WV_GHOST                             
                    rts


SOUND_FREEMN_TRIGGER  byte                00                    
CLOCK_TICKS           byte                00
BEEP_COUNTER          byte                00                   

                    
INTERRUPT           jsr                 WAVE_SOUND
                    jsr SOUND_FREE_MAN
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
                    lda                 #16                 
                    sta                 SND+4                
                    jmp $ea31
@MAKE_QUIET
                    lda                 #0                  
                    sta                 SND+1                 
@end                    jmp                 $ea31               
                             

delay8              
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
SOUND_FREE_MAN
                    ;jsr SOUND_OFF
                    lda                 SOUND_FREEMN_TRIGGER
                   ; sta $400
                    beq                 @end                
                    lda                 SND+1               ; DONT INTERRUPT this sound if voice 1 in use already             
                   ; sta $401
                  ;  bne @end
                    inc CLOCK_TICKS
                    lda                 CLOCK_TICKS         
                    cmp                 #10                 
                    bne                 @end                
                    inc $402
                    lda                 #0                  
                    sta                 CLOCK_TICKS         
                    lda                 #15                 
                    sta                 SND+24   
                    lda                 #15                 
                    sta                 SND+5
                    lda                 #%11110000                
                    sta                 SND+6               
                    lda                 #17                  
                    sta                 SND+4 
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
                    sta                 BEEP_COUNTER        
                    sta CLOCK_TICKS
                    sta SOUND_FREEMN_TRIGGER
                    jmp @end

@MAKE_BEEP          lda                 #45                 
                    sta                 SND+1                
                    lda                 #17                 
                    sta                 SND+4               
                    jmp @end
@MAKE_QUIET
                    lda                 #0                  
                    sta                 SND+1                 
@end                rts

SOUND_EAT_FRUIT     
@sound           
    ;ldy                 #0                  
;@loop               lda                 #0                  
;                    sta                 SND,y                
;                    iny
;                    cpy                 #28                 
;                    bne @loop
@sound2         
                    lda                 #15                 
                    sta                 SND+24                                  

                    lda                 #8                 
                    sta                 SND+1               

                    lda                 #15                 
                    sta                 SND+5
                    lda                 #%11110000                
                    sta                 SND+6               
                    lda                 #17                  
                    sta                 SND+4  
                    ;jsr @delay
                    ;lda                 #16                 
                    ;sta                 SND+4                
             
                    ;jsr                 @delay              
                    ;jsr @delay
                    ;jsr @delay
                    ldy #22
                    ldx #01
                    jsr @WAVE_DOWN
                    ldy #10
                    ldx #35
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
 
WAVE_SOUND


                   ; lda                 WAVE_SOUND_TOGGLE
                   ; beq                 @sound_off
                    lda                 WAVE_SOUND_EYES     
                    cmp                 #0                    
                    beq                 @BK_SIREN           
                    cmp                 #1                  
                    beq                 @EYES               
@GHOST              inc                 WV_GHOST
                    lda                 WV_GHOST
                    cmp                 WV_GHOST_MIN                             
                    beq                 @CHG_WV_GHOST                            
                    sta                 SND2+1              
                    jmp                 @end                
@CHG_WV_GHOST       lda                 #Const_WV_GHOST
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
WAVE_MAX            byte                40

Const_WV_EYES       = 45
WAVE_SOUND_EYES      byte 01
WV_EYES             byte 45
WV_EYES_MIN         byte 35 

Const_WV_GHOST       = 15
WV_GHOST             byte 25
WV_GHOST_MIN         byte 35  