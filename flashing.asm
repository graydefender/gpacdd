*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $34, $30, $39, $36, $00, $00
                    byte                $00
PARAM               byte                $00
COLOR_CNTR          byte 15
*=$1000
;============================================================
;                          Draw Map
;============================================================
                    jsr                 drawmap 
                    lda #7
                    sta COLOR_CNTR            

loop3               dec                 COLOR_CNTR          

                    lda                 #3
                    jsr                 color               
                    jsr dly
                    lda                 #0                
                    jsr                 color               
                    jsr dly
       

                    lda                 COLOR_CNTR          
                    bne                 loop3

                    rts
drawmap
                    lda                 #$00                ;Low byte of screen memory
                    sta                 $fb
                    lda                 #04                 ;High byte of screen memory
                    sta                 $fc
                    lda                 MAPL                ;Map low
                    sta                 $fd
                    lda                 MAPH                ;Map High byte
                    sta                 $fe
                    ldx                 #4
main_lp             ldy                 #$00
loop1               lda                 ($fd),y
                    sta                 ($fb),y
                    dey
                    bne                 loop1
                    inc                 $fc
                    inc                 $fe
                    dex
                    bne                 main_lp
                    rts

color                                                       ;sta                 PARAM
                    pha
                    lda                 #$00                ;Low byte of screen memory
                    sta                 $fb
                    lda                 #$d8                ;High byte of screen memory
                    sta                 $fc
                    lda                 MAPL                ;Map low
                    sta                 $fd
                    lda                 MAPH                ;Map High byte 
                    sta                 $fe
                    ldx                 #4
main_lp1            ldy                 #$00
loop2               lda                 ($fd),y
                    cmp                 #160
                    bne                 skip
                                                            ;lda                 PARAM
                    pla
                    sta                 ($fb),y             
                    pha

skip                dey
                    bne                 loop2
                    inc                 $fc
                    inc                 $fe
                    dex
                    bne                 main_lp1            
                    pla
                    rts

dly
                    ldx #8
def                 ldy                 #0
                    
abc                 jsr                 delay               
                    dey
                    bne                 abc                 
                    dex
                    bne def
                    rts
;----------------------------------------------------------
; From http://codebase64.org/doku.php?id=base:delay
; Delay to smooth out raster interrupts
;                                        
delay             ;// delay 84-accu cycles, 0<=accu<=65
  lsr             ;// 2 cycles akku=akku/2 carry=1 if accu was odd, 0 otherwise
  bcc waste1cycle ;// 2/3 cycles, depending on lowest bit, same operation for both
waste1cycle
  sta smod+1      ;// 4 cycles selfmodifies the argument of branch
  clc             ;// 2 cycles 
;// now we have burned 10/11 cycles.. and jumping into a nopfield 
smod
  bcc *+10        ;// 3 cycles
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  rts            ; // 6 cycles


MAPL                BYTE                <MAP_DATA
MAPH                BYTE                >MAP_DATA
MAP_DATA
incbin              pacmap3.bin
