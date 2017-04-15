*=$1000
Display_Back_Story
                    lda                 #0                   ; Reset page color
                    sta                 backst_color
                    lda                 #11                  ; Change background and border colors
                    sta                 53281
                    sta                 53280
                    jsr                 @set_tex_color
                    jsr                 $e544               ; Clear screen
                    lda                 #<backstory
                    sta                 @SM_backstory+1
                    lda                 #>backstory
                    sta                 @SM_backstory+2
@SM_backstory       lda backstory
                    cmp                 #$26                ; End of line separator
                    beq                 @print_eol
                    cmp                 #0
                    beq                 @end_of_story
                    cmp                 #$2b                ; Read the '+' = end of page
                    beq                 @end_of_page
                    jsr                 $ffd2
@into_loop          inc                 @SM_backstory+1
                    lda                 @SM_backstory+1
                    cmp                 #$00
                    bne                 @SM_backstory
                    inc                 @SM_backstory+2
                    jmp                 @SM_Backstory
@print_eol          lda #13
                    jsr                 $ffd2
                    jsr                 $ffd2
                    jmp                 @into_loop
@end_of_story       jsr @Display_sb
                    rts
@end_of_page        jsr                 @Display_sb
                    jsr                 @set_tex_color
                    jmp                 @into_loop
@Display_sb         ldy                 #0                  ; Print space bar text
@lp                 lda str_spbar,y
                    cmp                 #00
                    beq                 @sub
                    sta                 $7ce,y
                    lda                 #0
                    sta                 $dbce,y
                    iny
                    jmp                 @lp
@sub                lda                 $dc01               ; Wait for space bar or run/stop
                    cmp                 #255
                    beq                 @sub
                    JSR                 $E544               ; Clear the screen
                    rts
@set_tex_color      inc                 backst_color        ; Change the page text color
                    ldx                 backst_color
                    lda                 backst_color,x
                    sta                 646
                    rts
backst_color        byte                00,13,7,3   ; Text color of each page of backstory
backstory           text                "you play as, g-pac,  a former m.d. who&over the years has seen many, many,&cases of dementia through his practice.&you have spent the majority of your&"
                    text                "life eating poorly, but now are on a  &health crusade.  fed up, you break&into the worlds largest nutritional&center, the de beers of vitamin&"
                    text                "factories, with the intent of&collecting as many nutritional &supplements and vitamin dots, as&possible.  this is no simple task!+standing in your way, are four of &"
                    text                "your internal demons, materialized as&gmos (genetically modified organisms),&hfcs (high fructose corn syrup),&msgs (mono sodium glutamate),&"
                    text                "bpa(bisphenol).  make your way through&the many floors of this warehouse,     &collecting as many vita dots and &nutritional supplements as possible&"
                    text                "without succumbing to your 'demons'.&you start with three lives.&you must act quickly because once...+the seal to the room is broken, the&vita dots "
                    text                "start to lose their&nutritional value over time, costing&you valuable points. each room is&stocked with five super antioxidant&super pills which "
                    text                "will temporarily&repel your 'demons', sending them back&to where they came from. being a&super hero is no easy job.  be smart,&be brave, be swift, "
                    text                "because that's what&it will take to save the world from&dementia."
                    byte                00
str_spbar           byte                $A8,$93,$90,$81,$83,$85,$a0,$82,$81,$92,$a9 ;text reversed "(space bar)"
                    byte                00
