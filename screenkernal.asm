; replacement for these C64 kernal routines and their variables:
; setcursor $e50c
; printchar $ffd2
; plot      $fff0
; zp_cursorswitch $cc
; zp_screenline $d1
; zp_screencolumn $d3
; zp_screenrow $d6
;
; needed to be able to customize the text scrolling to
; not include status lines, especially big ones used in
; Border Zone, and Nord and Bert.
;
; usage: first call s_init, then replace
; $ffd2 with s_printchar and so on.
; Uncomment TESTSCREEN and call testscreen for a demo.

s_screenpos = $c9 ; c9/ca = pointer to screen
s_screentmp = $a7 ; a7/a8 = temp buffer during scroll

;TESTSCREEN = 1

!zone screenkernal {
s_init
    ; init cursor
    lda #0
    sta .col
    sta .row
    sta .reverse
    lda #$ff
    sta .current_screenpos_row ; force recalculation first time
    rts

s_printchar
    ; replacement for CHROUT ($ffd2)
    ; input: A = byte to write (PETASCII)
    ; output: -
    ; used registers: -
    stx .stored_x
    sty .stored_y
    cmp #$0d
    bne +
    ; newline/enter/return
    lda #0
    sta .col
    inc .row
    jsr .s_scroll
    jmp .printchar_end
+   cmp #$93 
    bne +
    ; clr (clear screen)
    lda #0
    sta .col
    sta .row
    jsr .erase_window
    jmp .printchar_end
+   cmp #146
    bne +
    ; reverse on
    lda #128
    sta .reverse
    jmp .printchar_end
+   cmp #18
    bne +
    ; reverse off
    lda #0
    sta .reverse
    jmp .printchar_end
+   ; covert from pet ascii to screen code
    cmp #$40
    bcc ++    ; no change if numbers or special chars
    cmp #$60
    bcc +
    ; upper case letters (A - Z)
    sec
    sbc #128
    bne ++
+   ; lower case letters (a - z)
    sec
    sbc #64
++  ; print the char
    clc
    adc .reverse
    pha
    jsr .update_screenpos
    ldy .col
    pla
    sta (s_screenpos),y
    iny
    sty .col
    cpy #40
    bcc .printchar_end
    lda #0
    sta .col
    inc .row
    jsr .s_scroll
.printchar_end
    ldx .stored_x
    ldy .stored_y
    rts

.update_screenpos
    ; set screenpos (current line) using row
    ldx .row
    cpx .current_screenpos_row
    beq +
    ; need to recalculate s_screenpos
    stx .current_screenpos_row
    stx s_screenpos
    ; use the fact that .row * 40 = .row * (32+8)
    lda #0
    sta s_screenpos + 1
    asl s_screenpos ; *2 no need to rol s_screenpos + 1 since 0 < .row < 24
    asl s_screenpos ; *4
    asl s_screenpos ; *8
    ldx s_screenpos ; store *8 for later
    asl s_screenpos ; *16
    rol s_screenpos + 1
    asl s_screenpos ; *32
    rol s_screenpos + 1  ; *32
    txa
    clc
    adc s_screenpos ; add *8
    sta s_screenpos
    lda s_screenpos + 1
    adc #$04        ; add screen start ($0400)
    sta s_screenpos +1
+   rts

.erase_line
    lda #0
    sta .col
    jsr .update_screenpos
    ldy #0
    lda #$20
-   sta (s_screenpos),y
    iny
    cpy #40
    bne -
    rts
    
.erase_window
    lda #0
    sta .row
-   jsr .erase_line
    inc .row
    lda .row
    cmp #25
    bne -
    lda #0
    sta .row
    sta .col
    rts

.s_scroll
    lda .row
    cmp #25
    bpl +
    rts
+   ldx #1 ; how many top lines to protect
    stx .row
-   jsr .update_screenpos
    lda s_screenpos
    sta s_screentmp
    lda s_screenpos + 1
    sta s_screentmp + 1
    inc .row
    jsr .update_screenpos
    ldy #0
--  lda (s_screenpos),y ; .row
    sta (s_screentmp),y ; .row - 1
    iny
    cpy #40
    bne --
    lda .row
    cmp #24
    bne -
    jmp .erase_line

.row !byte 0
.col !byte 0
.reverse !byte 0
.stored_x !byte 0
.stored_y !byte 0
.current_screenpos_row !byte 0

!ifdef TESTSCREEN {

.testtext !pet 147,146,"Status Line 123         ",18,13
          !pet "test aA@! ",146,"Test aA@!",18,13
          !pet "third line",13
          !pet "fourth line",13
          !pet 13,13,13,13,13,13
          !pet 13,13,13,13,13,13,13
          !pet 13,13,13,13,13,13,13
          !pet "last line",1
          !pet "aaaaaaaaabbbbbbbbbbbcccccccccc",1
          !pet "d",1 ; last char on screen
          !pet "efg",1 ; should scroll here and put efg on new line
          !pet 13,"h",1; should scroll again and f is on new line
          !pet 0

testscreen
    lda #23 ; 23 upper/lower, 21 = upper/special (22/20 also ok)
    sta $d018 ; reg_screen_char_mode
    jsr s_init
    ldx #0
-   lda .testtext,x
    bne +
    rts
+   cmp #1
    bne +
    txa
    pha
--  jsr kernel_getchar
    beq --
    pla
    tax
    bne ++
+   jsr s_printchar
++  inx
    bne -
}
}
