
*=   $1000

        lda #141
        sta $07f8

        lda #$03
        sta $d015
        lda #$a0
        sta $d000
        lda #$40
        sta $d001

        lda #145
        sta $07f9

        lda #$a0
        sta $d002
        lda #$40
        sta $d003

        lda #15     ;make the sprite yellow
        sta $d027  
        rts
        

* = $2000
; 
 BYTE $3C,$00,$00
 BYTE $7E,$00,$00
 BYTE $5A,$00,$00
 BYTE $FF,$00,$00
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
 BYTE $C3,$00,$00
 BYTE $C3,$00,$00
 BYTE $A7,$00,$00
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
 BYTE $A7,$00,$00
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
 BYTE $BF,$00,$00
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
 BYTE $E5,$00,$00
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
 BYTE $E5,$00,$00
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
 BYTE $FD,$00,$00
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
 BYTE $6E,$00,$00
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
 BYTE $6E,$00,$00
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
 BYTE $6E,$00,$00
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
 BYTE $76,$00,$00
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
 BYTE $76,$00,$00
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
 BYTE $76,$00,$00
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

