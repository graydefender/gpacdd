; G^Ray Defender
; 11/11/2015
;
;============================================================
;  Quick code to create auto execute program from basic
;============================================================

*=$0801
          byte           $0c, $08, $0a, $00, $9e, $20
          byte           $34, $30, $39, $36, $00, $00
          byte           $00

Test                word                $d851

;============================================================
;             Main Program Variables
;============================================================

*=$1000        
               lda      #4
               sta      53280 
                    jsr                 drawmap             

                    lda                 #3                  
                sta Test
               rts

drawmap
               lda                 #$00                
               sta                 $fb                 
               lda                 #04                 
               sta                 $fc                 
               ldx                 #00                  
               lda                 MAPL,x      
               sta                 $fd                 
               lda                 MAPH,x      
               sta                 $fe                

               ldx                 #4                 
main_lp        ldy                 #$00
loop1          lda                 ($fd),y             
               sta                 ($fb),y             
               dey
               bne                 loop1               
               inc                 $fc                 
               inc                 $fe
               dex
                    bne                 main_lp             
               rts
             
MAPL           BYTE                <MAP_DATA
MAPH           BYTE                >MAP_DATA

MAP_DATA
incbin         pacmap2.bin


SCREEN_MAP     BYTE           $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
               BYTE           $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
               BYTE           $A0,$2A,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2A,$A0
               BYTE           $A0,$2E,$A0,$20,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$20,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2A,$A0,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$20,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$A0,$A0,$2D,$2D,$A0,$A0,$2E,$A0,$20,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0
               BYTE           $20,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$20,$20,$20,$20,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$20
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$20,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$A0,$2E,$A0,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0
               BYTE           $A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$2E,$A0,$2E,$A0,$2E,$A0
               BYTE           $A0,$2A,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$A0,$2E,$2E,$2E,$2E,$2E,$A0,$2E,$2E,$2A,$A0
               BYTE           $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
               BYTE           $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20