
*=$1000                   
Scroll_Message      ldx                 #00                 ; shift characters to the left
@loop               lda                 $0401,x
                    sta                 $0400,x
                    lda                 $d801,x
                    sta                 $d800,x
                    inx
                    cpx                 #39
                    bne                 @loop
                    ldx                 charoffset            ; insert next character
                    lda                 message,x
                    sta                 $0427               
                    lda                 txtcolors,x         
                    sta $d827
                    inx
                    lda                 message,x
                    bne                 @sk
                    ldx #0 
@sk                 stx charoffset  
                    jsr                 delay               
                    rts
delay               ldy #$a0
@loop2              ldx                 #0                  
@loop               dex
                    bne                 @loop               
                    dey
                    bne                 @loop2              
                    rts
                    
                    
charoffset          byte                00
message             TEXT                '     '
                    text                'brought to you by gray defender '
                    text                'february 2017. press space or use joystick '
                    TEXT                'in port 2 to play.  '
                    TEXT                '                                      '
                    TEXT                'wow! are you still reading this? '
                    text                'really? why???  enjoy!!                                        '
                    byte                00
txtcolors           byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1
                    byte                1,1,1,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
                    byte                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1