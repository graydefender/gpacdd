
*=$C000               ; memory location for our code

CR = $0d
clear = $e544                   ; clear screen
screenbeg = $0400               ; beginning of screen memory
screenend = $07e7               ; end of screen memory
screenpos = $8000               ; current position in screen
screenwidth = $20

main
        jsr initscreen
        jsr loop
        rts

loop
        jsr clear
        jsr drawmsg

        inc screenpos           ; increment current screen position
        jmp loop                ; loop
        rts

initscreen
        lda #$00
        sta $d020               ; border
        sta $d021               ; background
        sta screenpos           ; screen position
        rts

return
        rts

msg
        null   'HELLO WORLD!'

        rts

drawmsg
        ldx #$00                  ; regX keeps msg index
        ldy screenpos             ; regY keeps screen position

        cpy #$20
        bcs screenposgreatherthan

        jmp drawmsghelper

drawmsghelper
        jsr drawmsgloop
        rts

drawmsgloop
        lda msg,x               ; char at msg index
        beq return              ; exit when zero byte

        and #$3f                ; ascii to petscii
        sta screenbeg,y         ; modify screen memory
        inx
        iny

        cpy #$20
        bcs ycountergreatherthan

        jmp drawmsgloop

screenposgreatherthan
        ldy #$00
        sty screenpos

        jmp drawmsghelper

ycountergreatherthan
        tya
        sbc #$20
        tay

        jmp drawmsgloop