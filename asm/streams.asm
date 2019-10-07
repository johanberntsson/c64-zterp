; Routines to handle output streams and input streams

!zone streams {
streams_current_entry		!byte 0,0,0,0
streams_stack				!fill 60, 0
streams_stack_items			!byte 0
streams_buffering			!byte 1,1
streams_output_selected		!byte 0, 0, 0, 0

.streams_tmp	!byte 0,0,0
.current_character !byte 0

!ifdef SWEDISH_CHARS {

; SWEDISH

character_translation_table_in
; (zscii code, petscii code).
; NOTE: Must be sorted on PETSCII value, descending!
	; Map uppercase letters to lowercase, or they won't be recognized in player input
	!byte $c9, $dd ; Å = ]
	!byte $9c, $dc ; Ö = £
	!byte $9b, $db ; Ä = [
	!byte $aa, $b1 ; é = CBM-e
	!byte $20, $a0 ; Convert shift-space to regular space
	!byte $83, $9d ; Cursor left
	!byte $81, $91 ; Cursor up
	!byte $c9, $5d ; å = ]
	!byte $9c, $5c ; ö = £
	!byte $9b, $5b ; ä = [
	!byte $84, $1d ; Cursor right
	!byte $08, $14 ; Backspace
	!byte $82, $11 ; Cursor down
character_translation_table_in_end

character_translation_table_out
; (zscii code, petscii code).
; NOTE: Must be sorted on ZSCII value, descending!
	!byte $ca, $dd ; Å = Shift-]
	!byte $c9, $5d ; å = ]
	!byte $aa, $b1 ; é = CBM-e
	!byte $9f, $dc ; Ö = Shift-£
	!byte $9e, $db ; Ä = Shift-[
	!byte $9c, $5c ; ö = £
	!byte $9b, $5b ; ä = [
	!byte $7e, $2d ; ~ => -
	!byte $7d, $29 ; } => )
	!byte $7c, $dd ; Pipe = pipe-like graphic character
	!byte $7b, $28 ; { => (
	!byte $60, $27 ; Grave accent => quote
	!byte $5f, $af ; Underscore = underscore-like graphic character
	!byte $5d, $29 ; ] = )
	!byte $5c, $bf ; Backslash => (somewhat) backslash-like graphic character
	!byte $5b, $28 ; [ = (
character_translation_table_out_end
} else { ; End of Swedish section
!ifdef DANISH_CHARS {

; DANISH

character_translation_table_in
; (zscii code, petscii code).
; NOTE: Must be sorted on PETSCII value, descending!
	; Map uppercase letters to lowercase, or they won't be recognized in player input
	!byte $c9, $dd ; Å = ]
	!byte $cb, $dc ; Ø = £
	!byte $d3, $db ; Æ = [
	!byte $aa, $b1 ; é = CBM-e
	!byte $20, $a0 ; Convert shift-space to regular space
	!byte $83, $9d ; Cursor left
	!byte $81, $91 ; Cursor up
	!byte $c9, $5d ; å = ]
	!byte $cb, $5c ; ø = £
	!byte $d3, $5b ; æ = [
	!byte $84, $1d ; Cursor right
	!byte $08, $14 ; Backspace
	!byte $82, $11 ; Cursor down
character_translation_table_in_end

character_translation_table_out
; (zscii code, petscii code).
; NOTE: Must be sorted on ZSCII value, descending!
	!byte $d4, $db ; Æ = Shift-[
	!byte $d3, $5b ; æ = [
	!byte $cc, $dc ; Ø = Shift-£
	!byte $cb, $5c ; ø = £
	!byte $ca, $dd ; Å = Shift-]
	!byte $c9, $5d ; å = ]
	!byte $aa, $b1 ; é = CBM-e
	!byte $7e, $2d ; ~ => -
	!byte $7d, $29 ; } => )
	!byte $7c, $dd ; Pipe = pipe-like graphic character
	!byte $7b, $28 ; { => (
	!byte $60, $27 ; Grave accent => quote
	!byte $5f, $af ; Underscore = underscore-like graphic character
	!byte $5d, $29 ; ] = )
	!byte $5c, $bf ; Backslash => (somewhat) backslash-like graphic character
	!byte $5b, $28 ; [ = (
character_translation_table_out_end
} else { ; End of Danish section
!ifdef GERMAN_CHARS {

; GERMAN

character_translation_table_in
; (zscii code, petscii code).
; NOTE: Must be sorted on PETSCII value, descending!
	; Map uppercase letters to lowercase, or they won't be recognized in player input
	!byte $9b, $dd ; Ä => ]
	!byte $9c, $db ; Ö => [
	!byte $9d, $c0 ; Ü => @
	!byte $20, $a0 ; Convert shift-space to regular space
	!byte $83, $9d ; Cursor left
	!byte $81, $91 ; Cursor up
	!byte $a1, $5f ; ß = left-arrow
	!byte $9b, $5d ; ä = ]
	!byte $9c, $5b ; ö = [
	!byte $9d, $40 ; ü = @
	!byte $84, $1d ; Cursor right
	!byte $08, $14 ; Backspace
	!byte $82, $11 ; Cursor down
character_translation_table_in_end

character_translation_table_out
; (zscii code, petscii code).
; NOTE: Must be sorted on ZSCII value, descending!
	!byte $a1, $5f ; ß = left-arrow
	!byte $a0, $c0 ; Ü = Shift-@
	!byte $9f, $db ; Ö = Shift-[
	!byte $9e, $dd ; Ä = Shift-]
	!byte $9d, $40 ; ü = @
	!byte $9c, $5b ; ö = [
	!byte $9b, $5d ; ä = ]
	!byte $7e, $2d ; ~ => -
	!byte $7d, $29 ; } => )
	!byte $7c, $dd ; Pipe = pipe-like graphic character
	!byte $7b, $28 ; { => (
	!byte $60, $27 ; Grave accent => quote
	!byte $5f, $af ; Underscore = underscore-like graphic character
	!byte $5d, $29 ; ] = )
	!byte $5c, $bf ; Backslash => (somewhat) backslash-like graphic character
	!byte $5b, $28 ; [ = (
character_translation_table_out_end
} else { ; End of German section
!ifdef ITALIAN_CHARS {

; ITALIAN

character_translation_table_in
; (zscii code, petscii code).
; NOTE: Must be sorted on PETSCII value, descending!
	; Map uppercase letters to lowercase, or they won't be recognized in player input
	!byte $aa, $bb ; é <= É (CBM-f)
	!byte $b8, $b9 ;      ò (CBM-o)
	!byte $b9, $b8 ;      ù (CBM-u)
	!byte $b8, $b6 ; ò <= Ò (CBM-l)
	!byte $b9, $b5 ; ù <= Ù (CBM-j)
	!byte $aa, $b2 ;      é (CBM-r)
	!byte $b6, $b1 ;      è (CBM-e)
	!byte $b5, $b0 ;      à (CBM-a)
	!byte $b5, $ad ; à <= À (CBM-z)
	!byte $b6, $ac ; è <= È (CBM-d)
	!byte $b7, $a2 ;      ì (CBM-i)
	!byte $b7, $a1 ; ì <= Ì (CBM-k)
	!byte $20, $a0 ; Convert shift-space to regular space
	!byte $83, $9d ; Cursor left
	!byte $81, $91 ; Cursor up
	!byte $84, $1d ; Cursor right
	!byte $08, $14 ; Backspace
	!byte $82, $11 ; Cursor down
character_translation_table_in_end

character_translation_table_out
; (zscii code, petscii code).
; NOTE: Must be sorted on ZSCII value, descending!
	!byte $be, $b5 ; Ù
	!byte $bd, $b6 ; Ò
	!byte $bc, $a1 ; Ì
	!byte $bb, $ac ; È
	!byte $ba, $ad ; À
	!byte $b9, $b8 ; ù
	!byte $b8, $b9 ; ò
	!byte $b7, $a2 ; ì
	!byte $b6, $b1 ; è
	!byte $b5, $b0 ; à
	!byte $b0, $bb ; É
	!byte $aa, $b2 ; é
	!byte $7e, $2d ; ~ => -
	!byte $7d, $29 ; } => )
	!byte $7c, $dd ; Pipe = pipe-like graphic character
	!byte $7b, $28 ; { => (
	!byte $60, $27 ; Grave accent => quote
	!byte $5f, $af ; Underscore = underscore-like graphic character
	!byte $5c, $bf ; Backslash => (somewhat) backslash-like graphic character
character_translation_table_out_end

} else { ; End of Italian section


!ifdef SPANISH_CHARS {

; SPANISH

character_translation_table_in
; (zscii code, petscii code).
; NOTE: Must be sorted on PETSCII value, descending!
	; Map uppercase letters to lowercase, or they won't be recognized in player input
	!byte $ac, $b9 ; á          (CBM-o)
	!byte $ad, $b8 ; á          (CBM-u)
	!byte $9d, $b7 ; ü          (CBM-y)
	!byte $ac, $b6 ; Ó => ó     (CBM-l)
	!byte $ad, $b5 ; Ú => ú     (CBM-j)
	!byte $9d, $b4 ; Ü => ü     (CBM-h)
	!byte $df, $b3 ; inverted ? (CBM-w)
	!byte $aa, $b1 ; é          (CBM-e)
	!byte $a9, $b0 ; á          (CBM-a)
	!byte $a9, $ad ; Á => á     (CBM-z)
	!byte $aa, $ac ; É => é     (CBM-d)
	!byte $de, $ab ; inverted ! (CBM-q)
	!byte $ce, $aa ; ñ          (CBM-n)
	!byte $ce, $a7 ; Ñ => ñ     (CBM-m)
	!byte $ab, $a2 ; í          (CBM-i)
	!byte $ab, $a1 ; Í => í     (CBM-k)
	!byte $20, $a0 ; Convert shift-space to regular space
	!byte $83, $9d ; Cursor left
	!byte $81, $91 ; Cursor up
	!byte $84, $1d ; Cursor right
	!byte $08, $14 ; Backspace
	!byte $82, $11 ; Cursor down
character_translation_table_in_end

character_translation_table_out
; (zscii code, petscii code).
; NOTE: Must be sorted on ZSCII value, descending!
	!byte $df, $b3 ; inverted ?
	!byte $de, $ab ; inverted !
	!byte $d1, $a7 ; Ñ
	!byte $ce, $aa ; ñ
	!byte $b3, $b5 ; Ú
	!byte $b2, $b6 ; Ó
	!byte $b1, $a1 ; Í
	!byte $b0, $ac ; É
	!byte $af, $ad ; Á
	!byte $ad, $b8 ; á
	!byte $ac, $b9 ; á
	!byte $ab, $a2 ; í
	!byte $aa, $b1 ; é
	!byte $a9, $b0 ; á
	!byte $a0, $b4 ; Ü
	!byte $9d, $b7 ; ü
	!byte $7e, $2d ; ~ => -
	!byte $7d, $29 ; } => )
	!byte $7c, $dd ; Pipe = pipe-like graphic character
	!byte $7b, $28 ; { => (
	!byte $60, $27 ; Grave accent => quote
	!byte $5f, $af ; Underscore = underscore-like graphic character
	!byte $5c, $bf ; Backslash => (somewhat) backslash-like graphic character
character_translation_table_out_end

} else { ; End of Italian section

; ENGLISH

character_translation_table_in
; (zscii code, petscii code).
; NOTE: Must be sorted on PETSCII value, descending!
	!byte $20, $a0 ; Convert shift-space to regular space
	!byte $83, $9d ; Cursor left
	!byte $81, $91 ; Cursor up
	!byte $84, $1d ; Cursor right
	!byte $08, $14 ; Backspace
	!byte $82, $11 ; Cursor down
character_translation_table_in_end

character_translation_table_out
; (zscii code, petscii code).
; NOTE: Must be sorted on ZSCII value, descending!
	!byte $7e, $2d ; ~ => -
	!byte $7d, $29 ; } => )
	!byte $7c, $dd ; Pipe = pipe-like graphic character
	!byte $7b, $28 ; { => (
	!byte $60, $27 ; Grave accent => quote
	!byte $5f, $af ; Underscore = underscore-like graphic character
	!byte $5c, $bf ; Backslash => (somewhat) backslash-like graphic character
character_translation_table_out_end

} ; End of English section
} ; End of non-Italian section
} ; End of non-German section
} ; End of non-Danish section
} ; End of non-Swedish section
	
streams_init
	; Setup/Reset streams handling
	; input: 
	; output:
	; side effects: Sets all variables/tables to their starting values
	; used registers: a
	lda #0
	sta streams_stack_items
	sta streams_output_selected + 1
	sta streams_output_selected + 2
	sta streams_output_selected + 3
	lda #1
	sta streams_buffering
	sta streams_buffering + 1
	sta streams_output_selected
	rts
	
streams_print_output
	; Print a character
	; input:  character in a
	; output:
	; side effects: -
	; affected registers: p
	cmp #0
	beq .return
	pha
	lda streams_output_selected + 2
	bne .mem_write
	lda streams_output_selected
	beq .pla_and_return
	pla
	jsr translate_zscii_to_petscii
	bcs .could_not_convert
	jmp printchar_buffered
.could_not_convert
!ifdef DEBUG {
	jmp print_bad_zscii_code_buffered
} else {
	rts
}
.mem_write
	lda streams_current_entry + 2
	sta .print_byte_to_mem + 1
	lda streams_current_entry + 3
	sta .print_byte_to_mem + 2
	pla
.print_byte_to_mem
	sta $8000 ; Will be modified!
	inc streams_current_entry + 2
	bne .return
	inc streams_current_entry + 3
.return
	rts
.pla_and_return
	pla
	rts
	
z_ins_output_stream
	; Set output stream held in z_operand 0
	; input:  z_operand 0: 1..4 to enable, -1..-4 to disable. If enabling stream 3, also provide z_operand 1: z_address of table
	; output:
	; side effects: Uses zp_temp (2 bytes)
	; used registers: a,x,y
	bit z_operand_value_low_arr
	bmi .negative
	lda z_operand_value_low_arr
!ifndef SMALL_CODE {
	beq .unsupported_stream
	cmp #5
	bcs .unsupported_stream
}
	tax
	lda #1
	sta streams_output_selected - 1,x
	cpx #3
	beq .turn_on_mem_stream
	rts
!ifndef SMALL_CODE {
.unsupported_stream
    lda #ERROR_UNSUPPORTED_STREAM
	jsr fatalerror
}
.negative
	lda z_operand_value_low_arr
!ifndef SMALL_CODE {
	cmp #-4
	bmi .unsupported_stream
}
	eor #$ff
	clc
	adc #1
	cmp #3
	beq .turn_off_mem_stream
	tax
	lda #0
	sta streams_output_selected - 1,x
	rts
.turn_on_mem_stream
	lda streams_stack_items
	beq .add_first_level
!ifndef SMALL_CODE {
	cmp #16
	bcs .stream_nesting_error
}
	asl
	asl
	tay
	; Move current level to stack
	ldx #3
-	lda streams_current_entry,x
	sta streams_stack - 4 + 3,y
	dey
	dex
	bpl -
.add_first_level
	; Setup pointer to start of table
	lda z_operand_value_low_arr + 1
	sta streams_current_entry
	lda z_operand_value_high_arr + 1
	clc
	adc #>story_start
	sta streams_current_entry + 1
	; Setup pointer to current storage location
	lda streams_current_entry
	adc #2
	sta streams_current_entry + 2
	lda streams_current_entry + 1
	adc #0
	sta streams_current_entry + 3
	inc streams_stack_items
	rts
!ifndef SMALL_CODE {
.stream_nesting_error
    lda #ERROR_STREAM_NESTING_ERROR
	jsr fatalerror
}
.turn_off_mem_stream
	lda streams_stack_items
!ifndef SMALL_CODE {
	beq .stream_nesting_error
}
	; Copy length to first word in table
	lda streams_current_entry
	sta zp_temp
	lda streams_current_entry + 1
	sta zp_temp + 1
	lda streams_current_entry + 2
	sec
	sbc #2
	tay
	lda streams_current_entry + 3
	sbc #0
	tax
	tya
	sec
	sbc zp_temp
	ldy #1
	sta (zp_temp),y
	txa
	sbc zp_temp + 1
	dey
	sta (zp_temp),y
	; Pop item off stack
	dec streams_stack_items
	lda streams_stack_items
	beq .remove_first_level
	asl
	asl
	tay
	; Move top stack entry to current level
	ldx #3
-	lda streams_stack - 4 + 3,y
	sta streams_current_entry,x
	dey
	dex
	bpl -
	rts
.remove_first_level
	; Turn off stream 3 output (A is always 0 here)
	sta streams_output_selected + 2
	rts

translate_zscii_to_petscii
	; Return PETSCII code *OR* set carry if this ZSCII character is unsupported
	sty .streams_tmp + 1
	ldy #character_translation_table_out_end - character_translation_table_out - 2
-	cmp character_translation_table_out,y
	beq .match
	bcc .no_match
	dey
	dey
	bpl -
.no_match
	; Check if legal
	cmp #13
	beq .case_conversion_done
	cmp #$20
	bcc .not_legal
	cmp #$7f
	bcc .is_legal
.not_legal
	sec
	rts
.is_legal
; .case_conversion
	ldy .streams_tmp + 1
	cmp #$41
	bcc .case_conversion_done
	cmp #$5b
	bcs .not_upper_case
	; Upper case. $41 -> $c1
	ora #$80
	bcc .case_conversion_done
.not_upper_case
	cmp #$61
	bcc .case_conversion_done
	cmp #$7b
	bcs .case_conversion_done
	; Lower case. $61 -> $41
	and #$df
.case_conversion_done
	clc
	rts
.match
	iny
	lda character_translation_table_out,y
	ldy .streams_tmp + 1
	clc
	rts

}
