processor    6502
*=$0810


INIT     LDA #$00
         JSR $1000
         
REDIR    SEI
         LDA #<VECTOR
         LDX #>VECTOR
         STA $0314
         STX $0315
         CLI
         RTS
VECTOR   
                    JSR                 $1003               
                    asl                 $d019
                    JMP                 $EA31               
STOP                    
        sei
           lda #$ea
           sta $0315
           lda #$31
           sta $0314
           lda #$81
           sta $dc0d
           lda #0
           sta $d01a
           inc $d019
           lda $dc0d
           jsr $1000
                    cli
                    rts
*=$f82
INCBIN "graydefender.sid"