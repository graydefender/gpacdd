*=$810
                    ;//                  clear all sid registers to 0
                    ldx                 #$00
                    lda                 #$00
clearsidloop
                    ;//                  SID registers start at $d400
                    sta                 $d400
                    inc                 clearsidloop+1
                    inx
                    cpx                 #$29 ;// and there are 29 of them
                    bne                 clearsidloop
                    ;//                  set master volume and turn filter off
                    lda                 #%00001111
                    sta                 filtermode_volume
;;// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mainloop
                    ;//                  check if rasterline is #$ff
                    ;//                  which happens every 20ms
                    ;//                  do nothing and jump back to mainloop if not
                    lda                 $d012
                    cmp                 #$ff
                    bne                 mainloop
                    ;//                  play a single frame of music (if there are any notes to play this frame)
                    jsr                 music
                    ;//                  loop
                    jmp                 mainloop
;;// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
music
                    ;//                  tickcounter counts the number of 20ms frames
                    inc                 tickcounter
                    ;//                  speed is the number of 20ms frames that will happen before the slowtable advances one position
                    lda                 tickcounter
                    cmp                 speed
                    beq                 playnote
                    jmp                 endmusic
playnote
                    ;//                  flash border and background
                    inc                 $d020
                    dec                 $d021
                    ;//                  reset
                    lda                 #%00000000
                    sta                 $d404
                    ;//                  reset tickcounter as we have got to the next row of the slowtable and we want to start counting towards the next note
                    lda                 #$00
                    sta                 tickcounter
                    ;//                  add slowtablepos to slowtable to get the current position in the slowtable
                    ldx                 slowtablepos
                    lda                 slowtable,
                    ;//                  get low byte of frequency from slowtable
                    sta                 frequency
                    ;//                  get high byte of frequency from slowtable
                    inx
                    lda                 slowtable,
                    sta                 frequency+1
freqcheck1
                    ;//                  check if low byte of frequency is #$00, if not, continue to play note
                    lda                 frequency
                    cmp                 #$00
                    bne                 playnote2
                    ;//                  check if high byte of frequency is #$00 (frequency is #$0000), if not, continue to next check
                    lda                 frequency+1
                    cmp                 #$00
                    bne                 freqcheck2
                    ;//                  if it is, reset slowtablepos and start again
                    lda                 #$00
                    sta                 slowtablepos
                    jmp                 playnote
freqcheck2
                    ;//                  check if high byte of frequency is #$01 (frequency is #$0001), if not continue to play note
                    lda                 frequency+1
                    cmp                 #$01
                    bne                 playnote2
                    ;//                  if it is, increment slowtablepos to continue moving through the table, but jump back to the start without playing a note
                    inc                 slowtablepos
                    inc                 slowtablepos
                    jmp                 music
playnote2
                    ;//                  set attack to 0, decay to 6
                    lda                 #$06
                    sta                 attack_decay
                    ;//                  set sustain and release to 0
                    lda                 #$00
                    sta                 sustain_release
                    ;//                  move frequency from frequency variable to sid buffer
                    lda                 frequency
                    sta                 freq_lowbyte
                    lda                 frequency+1
                    sta                 freq_highbyte
                    ;//                  set waveform to saw and turn gatebit on
                    lda                 #%00100001
                    sta                 control
                    ;//                  increment the slowtablepos twice (twice because there are two bytes for each note in the table)
                    inc                 slowtablepos
                    inc                 slowtablepos
                    ;//                  write data from the sid buffer to the sid chip
                    lda                 freq_lowbyte
                    sta                 $d400
                    lda                 freq_highbyte
                    sta                 $d401
                    lda                 control
                    sta                 $d404
                    lda                 attack_decay
                    sta                 $d405
                    lda                 sustain_release
                    sta                 $d406
                    lda                 filtermode_volume
                    sta                 $d418
endmusic
                    rts

;// variables ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;// the number of frames to wait before advancing the slowtable, you can set this to anything
speed
                    byte               $1f
;// stores the tick (frame) counter
tickcounter
                    byte               $00
;// stores the position in the slowtable
slowtablepos
                    byte               $00
;// temporarily stores the frequency of the next note
frequency
                    byte               $00
                    byte               $00
;// music data ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;// the slowtable is where the note data is stored
slowtable
                    ;//                  frequency is a sixteen bit number, a higher number is a higher pitch
                    byte               $b1
                    byte               $30
                    byte               $b1
                    ;//                  a frequency of #$0001 tells the player to play no note on this row
                    byte               $00
                    byte               $b1
                    byte               $30
                    byte               $b1
                    byte               $00
                    byte               $b1
                    byte               $30
                    byte               $b1
                    byte               $00
                    byte               $b1
                    byte               $30
                    byte               $b1
                    byte               $00
                    ;//                  a frequency of #$0000 tells the player to loop back to the start of the slowtable
                    byte               $00
;// sid buffer ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;// values that are going to be written to the sid are stored here and then written in one go
;// freq_lowbyte is the low byte of the frequency
;// on the SID this is $d400
freq_lowbyte
                    byte               $00
;// freq_highbyte is the high byte of the frequency
;// on the SID this is $d401
freq_highbyte
                    byte               $00
;// control sets the waveform and gatebit
;// on the SID this is $d404
control
                    byte               $00
;// the first nybble of attack_decay is attack, the second nybble is decay
;// on the SID this is $d405
attack_decay
                    byte               $00
;// the first nybble of sustain_release is sustain, the second nybble is release
;// on the SID this is $d406
sustain_release
                    byte               $00
;// bits 7-4 of filtermode_volume control the filter, bits 3-1 control the master volume
;// on the SID this is $d418
filtermode_volume
                    byte               $00
