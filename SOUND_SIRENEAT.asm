processor           6502
*=$1000
SND2                = 54279
SND                = 54272


                    
                   ;                     lda                 #15                 
                   ; sta                 SND+24                                  

                   ; lda                 #8                 
                   ; sta                 SND+1               

                  ; lda                 #15               
                   ;sta                 SND+5

                    ;lda                 #15
                    ;sta                 SND+6               
                   ; lda                 #17                  
                                                            ; sta                 SND+4               
                    ;jsr SOUND_EATGHOST
                    jsr                 INIT                
@loop                ;    jsr                 SOUND_EATGHOST
                    ldx                 #$ff                
                    jsr                 delay8              
                    jmp @loop
                    rts
SOUND_EAT_FRUIT     

@sound           
@sound2         
                    lda                 #%10011111
                    sta                 SND+6               
 
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
                    jsr delay8
                    rts                    
INIT
REDIR               SEI
                    LDA                 #<INTERRUPT
                    LDX                 #>INTERRUPT
                    STA                 $0314
                    STX                 $0315
                    ;lda                 #195
                    ;sta                 SND2+5
@label              lda                 #%00010000          
                    sta                 SND2+6
                    lda                 #15
                    sta                 SND2+17             
                    
                    lda                 #17
                    sta                 SND2+4
                    lda                 WAVE_MIN
                    sta                 WAVE                
                    lda                 #Const_WV_EYES       
                    sta                 WV_EYES             
                    lda                 #1                  
                    sta WAVE_SOUND_TOGGLE
                    CLI
                    RTS
INTERRUPT           jsr WAVE_SOUND
                    jmp $EA31                    
WAVE_SOUND         
                    lda                 WAVE_SOUND_TOGGLE
                    beq                 sound_off
                    lda                 WAVE_SOUND_EYES     
                    beq @BK_SIREN
                    dec                 WV_EYES          
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
sound_off          lda                 #0                  
                    sta                 snd2+1              
                    rts
delay8              
@lp2                ldy #0
@lp                 dey
                    bne                 @lp                 
                    dex
                    bne @lp2
                    rts
SOUND_EATGHOST                  
                    ;lda                 #15                 
                    ;sta                 SND+24                                  
                    lda                 #75                 
                    sta                 SND+1                                  

                    lda                 #43                 
                    sta                 SND+5
                    lda                 #%11110000          
                    sta                 SND+6                              
                    lda                 #17                  
                    sta                 SND+4               
                    ldy #5
                    ldx #105
                    jsr                 @WAVE_UP            
                    ldy                 #15                 
                    ldx                 #17                 
                    jsr @WAVE_UP

                    lda                 #0                  
                    sta                 SND+1               
                    rts
                                 
@WAVE_UP     
                    stx @SM_1+1
@loopab             tya
                    sta                 SND+1            
                    pha
                    ldx #4
                    jsr                 delay8              
                    pla
                    tay
                    iny
@SM_1               cpy                 #15
                    bne                 @loopab             
                    rts                    

WAVE_SOUND_TOGGLE   byte                00
WAVE                byte                00
WAVE_UP_OR_DOWN     byte                01
WAVE_MIN            byte                25
WAVE_MAX            byte                30

Const_WV_EYES       = 40
WAVE_SOUND_EYES     byte 00
WV_EYES             byte 00
WV_EYES_MIN         byte 20    