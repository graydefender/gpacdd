*=$810

                    jsr                 Set_Interrupt       
                    rts
junkabc             byte                $31, $31,$31
Gobble_on           byte                00
flash_on            byte                00

Set_Interrupt
                    sei                                     ; disable interrupts
                    lda                 #<intcode           ; get low byte of target routine
                    sta                 788                 ; put into interrupt vector
                    lda                 #>intcode           ; do the same with the high byte
                    sta                 789
                    cli                                     ; re-enable interrupts
                                                            ; return to caller



                    lda                 #$7f
                    sta                 $dc0d
                    sta                 $dd0d
                    lda                 #$01
                    sta                 $d01a
                    lda                 #$1b
                    ldx                 #$08
                    ldy                 #$14
                    sta                 $d011
                    stx                 $d016
                    sty                 $d014               

                    ldx                 spr_left_low        ; $84=$2000=sprite 1| $85 = sprite 2 etc.
                    stx                 $07f8               ; Sprite 1
                    stx                 int_spr_low         ; First sprite has three separate sprites
                    stx                 int_sprite          ; to emulate open-close of mouth
                    inx
                    inx
                    inx
                    stx                 int_spr_high        ;
                    LDA                 #%11111111
                    sta                 $d015               ;
                    lda                 #$8c
                    sta                 $07f9               ; sprite 2
                    lda                 #255
                    sta                 $d002
                    lda                 #130
                    sta                 $d003
                    lda                 #$8d
                    sta                 $07fA               ; sprite 3
                    lda                 #100
                    sta                 $d004
                    lda                 #130
                    sta                 $d005

                    lda                 #$8e
                    sta                 $07fb               ; sprite 4
                    lda                 #140
                    sta                 $d006
                    lda                 #150
                    sta                 $d007
                    lda                 #$8f
                    sta                 $07fc               ; sprite 5
                    lda                 #200
                    sta                 $d008
                    lda                 #130
                    sta                 $d009

                    lda                 #$a0
                    sta                 $d000
                    lda                 #$40
                    sta                 $d001
                    lda                 #7                  ;make the int_sprite yellow
                    sta                 $d027
                    jsr                 default_color       


                    lda                 #0                  
                    sta                 Gobble_on           
                    sta flash_on
                    lda                 #$87                
                    sta                 $7f8                
                    
                    lda                 #$00
                    tax
                    tay
                    jsr                 $1000

                    rts
default_color
                    lda                 #2                  ;make the int_sprite yellow
                    sta                 $d028
                    lda                 #8                  ;make the int_sprite yellow
                    sta                 $d029

                    lda                 #9                  ;make the int_sprite yellow
                    sta                 $d02a

                    lda                 #8                  ;make the int_sprite yellow
                    sta                 $d02b
                    rts

intcode             = *
                    lda                 Gobble_on
                    cmp                 #0
                    beq                 _flash
skip2               inc                 int_counter
                    lda                 int_counter
                    cmp                 #04
                    bne                 _flash
                    lda                 #0
                    sta                 int_counter
                    inc                 int_sprite
                    lda                 int_sprite
                    cmp                 int_spr_high
                    bne                 skip
                    lda                 int_spr_low
                    sta                 int_sprite
skip                sta                 $7f8

_flash              lda                 flash_on            
                    cmp                 #0
                    beq                 end
                    inc                 flash_counter       
                    lda                 flash_counter       

                    cmp                 #1                  
                    beq                 sk_c
                    cmp                 #2                  
                    beq                 sk_b
                    cmp                 #3                  
                    bne                 end

                    lda #0
                    sta                 flash_counter       
                    jmp end
                
                    lda                 $d028               
                    cmp                 #2                  
                    beq                 sk_b
sk_c                lda                 #2                  
                    jmp sk_a
sk_b                lda                 #3
sk_a                sta                 $d028
                    sta                 $d029
                    sta                 $d02a
                    sta                 $d02b
   

end                 jsr                 $1003
                    asl                 $d019
                    jmp                 $ea31

*=$f82
INCBIN              "alive.sid"

int_counter         byte                00
flash_counter       byte                00


int_spr_low         byte                00
int_spr_high        byte                00
int_sprite          byte                00
junk                byte                $31,$31,$31

spr_up_low          byte                $80
spr_down_low        byte                $83
spr_left_low        byte                $86
spr_right_low       byte                $89
*                   = $2000
; 
 BYTE $00,$00,$00
 BYTE $C3,$00,$00
 BYTE $C3,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $66,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $C3,$00,$00
 BYTE $C3,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $66,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $7C,$00,$00
 BYTE $7E,$00,$00
 BYTE $1F,$00,$00
 BYTE $07,$00,$00
 BYTE $07,$00,$00
 BYTE $1F,$00,$00
 BYTE $7E,$00,$00
 BYTE $7C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $7F,$00,$00
 BYTE $07,$00,$00
 BYTE $07,$00,$00
 BYTE $7F,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3E,$00,$00
 BYTE $7E,$00,$00
 BYTE $F8,$00,$00
 BYTE $E0,$00,$00
 BYTE $E0,$00,$00
 BYTE $F8,$00,$00
 BYTE $7E,$00,$00
 BYTE $3E,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FE,$00,$00
 BYTE $E0,$00,$00
 BYTE $E0,$00,$00
 BYTE $FE,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $DB,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $A5,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $7E,$00,$00
 BYTE $DB,$00,$00
 BYTE $DB,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $A5,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $AB,$00,$00
 BYTE $55,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $FF,$00,$00
 BYTE $D5,$00,$00
 BYTE $AA,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $62,$00,$00
 BYTE $B5,$00,$00
 BYTE $F5,$00,$00
 BYTE $62,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $46,$00,$00
 BYTE $AD,$00,$00
 BYTE $AF,$00,$00
 BYTE $46,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $E7,$00,$00
 BYTE $A5,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $A5,$00,$00
 BYTE $E7,$00,$00
 BYTE $00,$00,$00
 BYTE $3C,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $C3,$00,$00
 BYTE $C3,$00,$00
 BYTE $E7,$00,$00
 BYTE $E7,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $C3,$00,$00
 BYTE $E7,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $C3,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $FF,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $7E,$00,$00
 BYTE $3C,$00,$00
 BYTE $18,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $18,$00,$00
 BYTE $18,$00,$00
 BYTE $18,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $08,$00,$00
 BYTE $08,$00,$00
 BYTE $08,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $08,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $14,$00,$00
 BYTE $00,$00,$00
 BYTE $14,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $08,$00,$00
 BYTE $22,$00,$00
 BYTE $00,$00,$00
 BYTE $22,$00,$00
 BYTE $08,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

; 
 BYTE $14,$00,$00
 BYTE $42,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $00,$00,$00
 BYTE $81,$00,$00
 BYTE $42,$00,$00
 BYTE $14,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00,$00,$00
 BYTE $00

