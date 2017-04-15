*=$0801
                    byte                $0c, $08, $0a, $00, $9e, $20
                    byte                $34, $30, $39, $36, $00, $00
                    byte                $00

;INDEX               byte                2 <constant>


LIST                byte                $31,$32,$33
var = 50
abc                 byte                $30,$31,$32
ready               Null                'ready!'


*=$1000

                    ldx                 #0                  
loop                lda                 ready,x              

                    cmp #0            
                    beq quit
                    sta                 $400,x  

                    inx
                    txa
                    pha
                    jsr                 dly               
                    pla
                    tax
                    jmp loop
quit                rts


dly
                    ldx #8
def_2               ldy                 #0
                    
loop_xx             jsr                 delay               
                    dey
                    bne                 loop_xx
                    dex
                  
                    bne def_2
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