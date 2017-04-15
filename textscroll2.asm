SINUS=  $CF00   ; Place for the sinus table
CHRSET= $3800   ; Here begins the character set memory
GFX=    $3C00   ; Here we plot the dycp data
X16=    $CE00   ; values multiplicated by 16 (0,16,32..)
D16=    $CE30   ; divided by 16  (16 x 0,16 x 1 ...)
START=  $033C   ; Pointer to the start of the sinus
COUNTER= $033D  ; Scroll counter (x-scroll register)
POINTER= $033E  ; Pointer to the text char
YPOS=   $0340   ; Lower 4 bits of the character y positions
YPOSH=  $0368   ; y positions divided by 16
CHAR=   $0390   ; Scroll text characters, multiplicated by eight
ZP=     $FB     ; Zeropage area for indirect addressing
ZP2=    $FD
AMOUNT= 38      ; Amount of chars to plot-1
PADCHAR= 33     ; Code used for clearing the screen

*= $C000

        SEI             ; Disable interrupts
        LDA #$32        ; Character generator ROM to address space
        STA $01
        LDX #0
LOOP0   LDA $D000,X     ; Copy the character set
        STA CHRSET,X
        LDA $D100,X
        STA CHRSET+256,X
        DEX
        BNE LOOP0
        LDA #$37        ; Normal memory configuration
        STA $01
        LDY #31
LOOP1   LDA #66         ; Compose a full sinus from a 1/4th of a
        CLC             ;   cycle
        ADC SIN,X
        STA SINUS,X
        STA SINUS+32,Y
        LDA #64
        SEC
        SBC SIN,X
        STA SINUS+64,X
        STA SINUS+96,Y
        INX
        DEY
        BPL LOOP1
        LDX #$7F
LOOP2   LDA SINUS,X
        LSR
        CLC
        ADC #32
        STA SINUS+128,X
        DEX
        BPL LOOP2

        LDX #39
LOOP3   TXA
        ASL
        ASL
        ASL
        ASL
        STA X16,X       ; Multiplication table (for speed)
        TXA
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #>GFX
        STA D16,X       ; Dividing table
        LDA #0
        STA CHAR,X      ; Clear the scroll
        DEX
        BPL LOOP3
        STA POINTER     ; Initialize the scroll pointer
        LDX #7
        STX COUNTER
LOOP10  STA CHRSET,X    ; Clear the @-sign..
        DEX
        BPL LOOP10

        LDA #>CHRSET    ; The right page for addressing
        STA ZP2+1
        LDA #<IRQ       ; Our interrupt handler address
        STA $0314
        LDA #>IRQ
        STA $0315
        LDA #$7F        ; Disable timer interrupts
        STA $DC0D
        LDA #$81        ; Enable raster interrupts
        STA $D01A
        LDA #$A8        ; Raster compare to scan line $A8
        STA $D012
        LDA #$1B        ; 9th bit
        STA $D011
        LDA #30
        STA $D018       ; Use the new charset
        CLI             ; Enable interrupts and return
        RTS

IRQ     INC START       ; Increase counter
        LDY #AMOUNT
        LDX START
LOOP4   LDA SINUS,X     ; Count a pointer for each text char and according
        AND #7          ;  to it fetch a y-position from the sinus table
        STA YPOS,Y      ;   Then divide it to two bytes
        LDA SINUS,X
        LSR
        LSR
        LSR
        STA YPOSH,Y
        INX             ; Chars are two positions apart
        INX
        DEY
        BPL LOOP4

        LDA #0
        LDX #79
LOOP11  STA GFX,X       ; Clear the dycp data
        STA GFX+80,X
        STA GFX+160,X
        STA GFX+240,X
        STA GFX+320,X
        STA GFX+400,X
        STA GFX+480,X
        STA GFX+560,X
        DEX
        BPL LOOP11

MAKE    LDA COUNTER     ; Set x-scroll register
        STA $D016
        LDX #AMOUNT
        CLC             ; Clear carry
LOOP5   LDY YPOSH,X     ; Determine the position in video matrix
        TXA
        ADC LINESL,Y    ; Carry won't be set here
        STA ZP          ; low byte
        LDA #4
        ADC LINESH,Y
        STA ZP+1        ; high byte
        LDA #PADCHAR    ; First clear above and below the char
        LDY #0          ; 0. row
        STA (ZP),Y
        LDY #120        ; 3. row
        STA (ZP),Y
        TXA             ; Then put consecuent character codes to the places
        ASL             ;  Carry will be cleared
        ORA #$80        ; Inverted chars
        LDY #40         ; 1. row
        STA (ZP),Y
        ADC #1          ; Increase the character code, Carry won't be set
        LDY #80         ; 2. row
        STA (ZP),Y

        LDA CHAR,X      ; What character to plot ? (source)
        STA ZP2         ;  (char is already multiplicated by eight)
        LDA X16,X       ; Destination low byte
        ADC YPOS,X      ;  (16*char code + y-position's 3 lowest bits)
        STA ZP
        LDA D16,X       ; Destination high byte
        STA ZP+1

        LDY #6          ; Transfer 7 bytes from source to destination
        LDA (ZP2),Y 
        STA (ZP),Y
        DEY             ; This is the fastest way I could think of.
        LDA (ZP2),Y 
      STA (ZP),Y
        DEY
        LDA (ZP2),Y 
        STA (ZP),Y
        DEY
        LDA (ZP2),Y 
        STA (ZP),Y
        DEY
        LDA (ZP2),Y 
        STA (ZP),Y
        DEY
        LDA (ZP2),Y 
        STA (ZP),Y
        DEY
        LDA (ZP2),Y 
        STA (ZP),Y
        DEX
        BPL LOOP5       ; Get next char in scroll

        LDA #1
        STA $D019       ; Acknowledge raster interrupt

        DEC COUNTER     ; Decrease the counter = move the scroll by 1 pixel
        BPL OUT
LOOP12  LDA CHAR+1,Y    ; Move the text one position to the left
        STA CHAR,Y      ;  (Y-register is initially zero)
        INY
        CPY #AMOUNT
        BNE LOOP12
        LDA POINTER
        AND #63         ; Text is 64 bytes long
        TAX
        LDA SCROLL,X    ; Load a new char and multiply it by eight
        ASL
        ASL
        ASL
        STA CHAR+AMOUNT ; Save it to the right side
        DEC START       ; Compensation for the text scrolling
        DEC START
        INC POINTER     ; Increase the text pointer
        LDA #7
        STA COUNTER     ; Initialize X-scroll

OUT     JMP $EA7E       ; Return from interrupt

SIN     BYTE 0,3,6,9,12,15,18,21,24,27,30,32,35,38,40,42,45

        BYTE 47,49,51,53,54,56,57,59,60,61,62,62,63,63,63
                        ; 1/4 of the sinus

LINESL  BYTE 0,40,80,120,160,200,240,24,64,104,144,184,224
        BYTE 8,48,88,128,168,208,248,32

LINESH  BYTE 0,0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,2,3

SCROLL  text "THIS@IS@AN@EXAMPLE@SCROLL@FOR@"
        text "COMMODORE@MAGAZINE@BY@PASI@OJALA@@"
                        ; SCR will convert text to screen codes