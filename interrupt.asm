*=$810

                    jsr                 Set_Interrupt       
                    rts
Set_Interrupt
                    sei                                     ; disable interrupts
                    lda                 #<intcode           ; get low byte of target routine
                    sta                 788                 ; put into interrupt vector
                    lda                 #>intcode           ; do the same with the high byte
                    sta                 789                 



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

                 ;   lda                 #<irq
                 ;   ldx                 #>irq
                    ldy                 #$7e
                 ;   sta                 $0314
                 ;   stx                 $0315
                    sty                 $d012
                    lda                 $dc0d
                    lda                 $dd0d
                    asl                 $d019


                    cli                                     ; re-enable interrupts
                                                            ; return to caller

                    lda                 #$00
                    tax
                    tay
                    jsr                 $1000
                    rts

intcode             = *
        
                    jsr                 $1003
                    asl                 $d019

end                 jmp                 $ea31


                    jmp                 $ea81
*=$f82
INCBIN              "alive.sid"
