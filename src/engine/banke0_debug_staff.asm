; ROM bank $E0: debug: staff roll and debug screens
; The annotated listing of this bank is build/listing/banke0.asm.

SECTION "Bank E0", ROMX
    db $e0

; Runs the debug skill editor, state 12 of the debug battle viewer (called by
; RunDebugState_E0_SkillEditor). Jumps through a table of six by wDebugSubState: 0
; RunDebugSubState_E0_ShowHeading draws the screen, 1 RunDebugSubState_E0_SideField, 2
; RunDebugSubState_E0_SkillField, 3 RunDebugSubState_E0_CountField and 4
; RunDebugSubState_E0_BattleEndField each edit one field, 5 RunDebugSubState_E0_Exit goes back to
; state 3 of the viewer. (C1, E-0385)
; the editing sub-states of the bank-$E0 debug viewer: shows a string, then edits the debug cursor,
; two debug values and the battle-end flag (E-0354; was: runs the routine for wDebugSubState (jump
; table of six) (E-0122))
RunDebugSubState_E0:: ; configured code entry (E-0395 (RunDebugSubState_E0: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld a, [wDebugSubState]
    jumptable
    dw RunDebugSubState_E0_ShowHeading
    dw RunDebugSubState_E0_SideField
    dw RunDebugSubState_E0_SkillField
    dw RunDebugSubState_E0_CountField
    dw RunDebugSubState_E0_BattleEndField
    dw RunDebugSubState_E0_Exit

; Debug skill editor, sub-state 0: shows its heading strings, draws its 20 x 18 layout
; (RunDebugSubState_E0_ShowHeading_Data) and the four fields (the side, the skill number and name, a
; count, the battle-end flag) with the cursor on the first. (C1, E-0357)
RunDebugSubState_E0_ShowHeading::
    ld hl, vTiles1 + $6d0
    ld de, $2101
    ld a, $02
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    call ShowStringBank09AtHLSizeDEThenDefault
    ld hl, vTiles2 + $10
    ld de, $1001
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank08AtTilesHLThenDefault_BankE0
    call FillTilesFromRequest
    ld de, RunDebugSubState_E0_ShowHeading_Data
    ld bc, $1412
    ld hl, vBGMap0

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    call RunDebugSubState_E0_DrawSideMarks
    call ShowSkillNumberAndName_BankE0
    call RunDebugSubState_E0_DrawCount
    call RunDebugSubState_E0_DrawBattleEndMarks
    ld hl, wDebugSubState
    inc [hl]
    ld a, $bb
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_SideField", ROMX

; Debug skill editor, sub-state 1 (the side field): Select leaves (sub-state 5); Up/Down move to the
; last or next field; Left/Right toggle wDebugCursor bit 0 (which side). (C1, E-0357)
RunDebugSubState_E0_SideField::
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, .check_joypad_pressed_repeat
    ld a, $05
    ld [wDebugSubState], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, $04
    ld hl, vBGMap0 + $182
    jr .set_debug_sub_state

.check_bit7:
    bit 7, a
    jr z, .skip
    ld a, $02
    ld hl, vBGMap0 + $a2
    jr .set_debug_sub_state

.skip:
    and $30
    ret z
    ld a, [wDebugCursor]
    and $01
    xor $01
    ld [wDebugCursor], a
    call RunDebugSubState_E0_DrawSideMarks
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_SkillField", ROMX

; Debug skill editor, sub-state 2 (the skill field): Select leaves; A sets skill 0; Up/Down move
; between fields; Left/Right step the skill number through 0-$E3 with wrap, redrawing its name. (C1,
; E-0357)
RunDebugSubState_E0_SkillField::
    ld a, [wJoypadPressed]
    and $04
    jr z, .check_joypad_pressed
    ld a, $05
    ld [wDebugSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed_repeat
    xor a
    ld [wDebugValue0], a
    call ShowSkillNumberAndName_BankE0
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, $01
    ld hl, vBGMap0 + $42
    jr .set_debug_sub_state

.check_bit7:
    bit 7, a
    jr z, .check_bit5
    ld a, $03
    ld hl, vBGMap0 + $122
    jr .set_debug_sub_state

.check_bit5:
    bit 5, a
    jr z, .check_bit4
    ld a, [wDebugValue0]
    dec a
    cp $ff
    jr nz, .set_debug_value0
    ld a, $e3

.set_debug_value0:
    ld [wDebugValue0], a
    jr .call_show_skill_number_and_name_bank_e0

.check_bit4:
    bit 4, a
    ret z
    ld a, [wDebugValue0]
    inc a
    cp $e4
    jr nz, .set_debug_value02
    xor a

.set_debug_value02:
    ld [wDebugValue0], a

.call_show_skill_number_and_name_bank_e0:
    call ShowSkillNumberAndName_BankE0
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $a2
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_CountField", ROMX

; Debug skill editor, sub-state 3 (the count field): Select leaves; Up/Down move between fields;
; Left/Right change wDebugValue1 by one and redraw it. (C1, E-0357)
RunDebugSubState_E0_CountField::
    ld a, [wJoypadPressed]
    and $04
    jr z, .check_joypad_pressed_repeat
    ld a, $05
    ld [wDebugSubState], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, $02
    ld hl, vBGMap0 + $a2
    jr .set_debug_sub_state

.check_bit7:
    bit 7, a
    jr z, .check_bit5
    ld a, $04
    ld hl, vBGMap0 + $182
    jr .set_debug_sub_state

.check_bit5:
    bit 5, a
    jr z, .check_bit4
    ld a, [wDebugValue1]
    dec a
    ld [wDebugValue1], a
    jr .call_run_debug_sub_state_e0_draw_count

.check_bit4:
    bit 4, a
    ret z
    ld a, [wDebugValue1]
    inc a
    ld [wDebugValue1], a

.call_run_debug_sub_state_e0_draw_count:
    call RunDebugSubState_E0_DrawCount
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $122
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_BattleEndField", ROMX

; Debug skill editor, sub-state 4 (the battle-end flag field): Select leaves; Up/Down move between
; fields; Left/Right toggle wBattleEndFlag bit 0. (C1, E-0357)
RunDebugSubState_E0_BattleEndField::
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, .check_joypad_pressed_repeat
    ld a, $05
    ld [wDebugSubState], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, $03
    ld hl, vBGMap0 + $122
    jr .set_debug_sub_state

.check_bit7:
    bit 7, a
    jr z, .skip
    ld a, $01
    ld hl, vBGMap0 + $42
    jr .set_debug_sub_state

.skip:
    and $30
    ret z
    ld a, [wBattleEndFlag]
    and $01
    xor $01
    ld [wBattleEndFlag], a
    call RunDebugSubState_E0_DrawBattleEndMarks
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $182
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_Exit", ROMX

; Debug skill editor, sub-state 5: returns to the debug viewer's state 3. (C2, E-0357; probed
; E-0385)
RunDebugSubState_E0_Exit::
    xor a
    ld [wDebugSubState], a
    ld a, $03
    ld [wDebugState], a
    ret

SECTION "Bank E0 RunDebugSubState_E0_DrawSideMarks", ROMX

; Draws the side field's two marks from the 3-byte table RunDebugSubState_E0_DrawSideMarks_Data
; ($BB, $C3, $BB) indexed by (wDebugCursor bit 0) XOR 1: tiles at vBGMap0 + $69 and + $6D, so one of
; the two shows the $BB cursor mark and the other $C3 (blank). Called by
; RunDebugSubState_E0_ShowHeading and RunDebugSubState_E0_SideField after Left/Right toggles
; wDebugCursor bit 0. (C1, E-0371)
RunDebugSubState_E0_DrawSideMarks::
    ld a, [wDebugCursor]
    and $01
    xor $01
    ld de, RunDebugSubState_E0_DrawSideMarks_Data
    add e
    ld e, a
    jr nc, .call_write_vram_byte
    inc d

.call_write_vram_byte:
    ld a, [de]
    ld hl, vBGMap0 + $69
    call WriteVRAMByte
    inc de
    ld a, [de]
    ld hl, vBGMap0 + $6d
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_DrawSideMarks_Data", ROMX

; Three bytes: $BB, $C3, $BB, where $BB is the cursor tile and $C3 a blank. Two overlapping pairs
; are read: the pair at index 0 puts the cursor on the left place and a blank on the right, the pair
; at index 1 does the opposite. The index is (wDebugCursor & 1) xor 1 in
; RunDebugSubState_E0_DrawSideMarks, drawing at vBGMap0 + $69 and + $6D (row 3, columns 9 and 13),
; and (wBattleEndFlag & 1) xor 1 in RunDebugSubState_E0_DrawBattleEndMarks, drawing at vBGMap0 +
; $1A9 and + $1AD (row 13, columns 9 and 13). (C1, E-0381)
RunDebugSubState_E0_DrawSideMarks_Data::
    db $bb, $c3, $bb

; Redraws the skill field of the debug skill editor. Writes the two hex nibbles of wDebugValue0 (the
; skill number), each plus 1 as a tile number, at vBGMap0 + $CA and the next cell, copies string
; wDebugValue0 of category 4 (the skill names) into wTextBuf0 with CopyStringHLToDE, and shows
; string 5 of category 8 (ShowString_Bank08), which is just '<BUF0>', so the name appears. Called by
; RunDebugSubState_E0_ShowHeading and, after A or Left/Right, by RunDebugSubState_E0_SkillField.
; (C1, E-0385)
; writes the two nibbles of wDebugValue0, each plus 1, as tiles at vBGMap0 + $CA; copies string
; wDebugValue0 of category 4 (skill names) to wTextBuf0 (CopyStringHLToDE) and shows string 5 of
; category 8 (ShowString_Bank08) (E-0112)
ShowSkillNumberAndName_BankE0::
    ld a, [wDebugValue0]
    swap a
    and $0f
    add $01
    ld hl, vBGMap0 + $ca
    call WriteVRAMByteInc
    ld a, [wDebugValue0]
    and $0f
    add $01
    call WriteVRAMByte
    ld de, wTextBuf0
    ld a, [wDebugValue0]
    ld l, a
    ld h, $04
    call CopyStringHLToDE
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ret

SECTION "Bank E0 RunDebugSubState_E0_DrawCount", ROMX

; Draws wDebugValue1 as up to three digits (leading zeros blank) at the count field. (C1, E-0357)
RunDebugSubState_E0_DrawCount::
    ld a, [wDebugValue1]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld c, $00
    ld hl, vBGMap0 + $14a
    ld a, [wDigits]
    or a
    jr z, .call_write_vram_byte_inc
    ld c, $01
    add $e0
    jr .call_write_vram_byte_inc2

.call_write_vram_byte_inc:
    ld a, $c3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    or a
    jr nz, .skip
    bit 0, c
    jr z, .call_write_vram_byte_inc3

.skip:
    add $e0
    jr .call_write_vram_byte_inc4

.call_write_vram_byte_inc3:
    ld a, $c3

.call_write_vram_byte_inc4:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add $e0
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugSubState_E0_DrawBattleEndMarks", ROMX

; Draws the battle-end flag field's two marks from the same 3-byte table as
; RunDebugSubState_E0_DrawSideMarks, indexed by (wBattleEndFlag bit 0) XOR 1: tiles at vBGMap0 +
; $1A9 and + $1AD, one $BB mark and one $C3 blank. Called by RunDebugSubState_E0_ShowHeading and
; RunDebugSubState_E0_BattleEndField. (C1, E-0371)
RunDebugSubState_E0_DrawBattleEndMarks::
    ld a, [wBattleEndFlag]
    and $01
    xor $01
    ld de, RunDebugSubState_E0_DrawSideMarks_Data
    add e
    ld e, a
    jr nc, .call_write_vram_byte
    inc d

.call_write_vram_byte:
    ld a, [de]
    ld hl, vBGMap0 + $1a9
    call WriteVRAMByte
    inc de
    ld a, [de]
    ld hl, vBGMap0 + $1ad
    call WriteVRAMByte
    ret

SECTION "Bank E0 ShowStringBank08AtTilesHLThenDefault_BankE0", ROMX

; HL = tile destination, DE = window size (E = rows, D = width): stores them in
; wTextWindowTileLo/Hi, wTextWindowRows and wTextWindowWidth, far-calls ShowString_Bank08 to show
; string wStringIndex of category wStringCategory, then puts the window back to vTiles1 with the
; size word $1202. Called by RunDebugSubState_E0_ShowHeading and
; RunDebugState_E0_ChooseActionTargets_Start. (C1, E-0385)
; sets the string window to HL (tile destination) and DE (size), far-calls ShowString_Bank08, then
; sets the window to vTiles1 with size word $1202 (E-0067) (the same 45 bytes appear in 2 banks)
ShowStringBank08AtTilesHLThenDefault_BankE0::
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

SECTION "Bank E0 ShowStringBank09AtHLSizeDEThenDefault", ROMX

; The same as ShowStringBank08AtTilesHLThenDefault_BankE0 but it far-calls ShowString_Bank09: HL =
; tile destination, DE = window size (E = rows, D = width), then the window goes back to vTiles1
; with $1202. Called once, by RunDebugSubState_E0_ShowHeading. (C1, E-0385)
; shows the selected string (ShowString_Bank09) in a window at HL with size DE, then restores the
; default window (vTiles1, $1202) (E-0121)
ShowStringBank09AtHLSizeDEThenDefault::
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

SECTION "Bank E0 RunDebugSubState_E0_ShowHeading_Data", ROMX

; A 20 by 18 tile screen image, 360 bytes in row order, which RunDebugSubState_E0_ShowHeading writes
; to vBGMap0 starting at row 0 (b = 20 columns, c = 18 rows, 32 bytes between rows). It is a frame
; of tiles $B0-$B7 around a field of blank tile $C3, with label glyph tiles in a few rows (for
; example $ED-$F2, $F3-$F7, $80-$88, $FD-$FF and $00) that the reader does not interpret. (C1,
; E-0381)
RunDebugSubState_E0_ShowHeading_Data::
    db $b0
    ds $12, $b1
    db $b2, $b6
    ds $12, $c3
    db $b7, $b6, $c3, $c3, $ed, $ee, $ef, $f0, $f1, $f2, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $f3
    db $f4, $c3, $c3, $f5, $f6, $f7, $c3, $c3, $b7, $b6
    ds $12, $c3
    db $b7, $b6, $c3, $c3, $ed, $ee, $ef, $fb, $fc, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e0
    db $e0, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $80, $81, $82, $83, $84, $85, $86, $87, $88, $b7, $b6
    ds $12, $c3
    db $b7, $b6, $c3, $c3, $fd, $fe, $ff, $00, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $c3, $be, $e2, $e5, $e5, $c3, $c3, $b7, $b6
    ds $12, $c3
    db $b7, $b6, $c3, $c3, $f8, $f9, $fa, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $f3
    db $f4, $c3, $c3, $f5, $f6, $f7, $c3, $c3, $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b3
    ds $12, $b4
    db $b5

; The debug battle viewer of bank $E0. Jumps through a table of 14 by wDebugState: 0
; RunDebugState_E0_ShowHeading, 1 RunDebugState_E0_DrawSlotStats, 2 RunDebugState_E0_Input, 3
; RunDebugState_E0_MarkGains, 4 RunDebugState_E0_DrawResistanceFrame, 5
; RunDebugState_E0_DrawResistances, 6 RunDebugState_E0_ReturnOnA, 7 DrawTileMapAndStep, 8
; RunDebugState_E0_DrawSkillBytes, 9 RunDebugState_E0_ReturnOnB, 10 RunDebugState_E0_EffectViewer,
; 11 RunDebugState_E0_EditStatusBits, 12 RunDebugState_E0_SkillEditor, 13
; RunDebugState_E0_ChooseActionTargets. The only routines that far-call it are
; CallRunDebugStateInBankE0_BankA0 and UnreferencedDebugScreenCaller, and nothing in src/ calls
; either of them. (C1, E-0385)
; the bank-$E0 debug battle viewer: by wDebugState it draws strings, slot HP/MP stats, packed 2-bit
; fields and bytes in hex, waits for buttons, and picks action targets (RunDebugSubState_E0 for its
; editing sub-states) (E-0354; was: runs the routine for wDebugState (jump table of fourteen)
; (E-0122))
RunDebugState_E0::
    ld a, [wDebugState]
    jumptable
    dw RunDebugState_E0_ShowHeading
    dw RunDebugState_E0_DrawSlotStats
    dw RunDebugState_E0_Input
    dw RunDebugState_E0_MarkGains
    dw RunDebugState_E0_DrawResistanceFrame
    dw RunDebugState_E0_DrawResistances
    dw RunDebugState_E0_ReturnOnA
    dw DrawTileMapAndStep
    dw RunDebugState_E0_DrawSkillBytes
    dw RunDebugState_E0_ReturnOnB
    dw RunDebugState_E0_EffectViewer
    dw RunDebugState_E0_EditStatusBits
    dw RunDebugState_E0_SkillEditor
    dw RunDebugState_E0_ChooseActionTargets

; Debug battle viewer, state 0: shows its heading (string 4 of category 2), draws the screen and
; puts the cursor at the current page's mark. (C1, E-0357)
RunDebugState_E0_ShowHeading::
    ld hl, vTiles1 + $6d0
    ld de, $2301
    ld a, $02
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankE0
    call DrawFullScreenFromBankE0
    ld hl, RunDebugState_E0_ShowHeading_Data
    ld a, [wDebugSubState]
    add a
    add_a_to_hl
    deref_hl
    ld a, $bb
    call WriteVRAMByte
    ld hl, wDebugState
    inc [hl]
    ret

SECTION "Bank E0 RunDebugState_E0_ShowHeading_Data", ROMX

; Two BG map addresses, $9824 and $982A (vBGMap0 row 1, columns 4 and 10).
; RunDebugState_E0_ShowHeading indexes it with wDebugSubState and writes the cursor tile $BB at the
; chosen place. (C1, E-0381)
RunDebugState_E0_ShowHeading_Data::
    db $24, $98, $2a, $98

; Debug battle viewer, state 1: draws the HP, MP and stats of three battle slots (the party's 0-2,
; or the foes' 4-6 on page 1) and the battle meter. (C1, E-0357)
RunDebugState_E0_DrawSlotStats::
    ld a, [wDebugSubState]
    or a
    jr nz, .call_draw_slot_hpmp_stats_bank_e0
    ld c, $00
    jr .call_draw_slot_hpmp_stats_bank_e02

.call_draw_slot_hpmp_stats_bank_e0:
    ld c, $04

.call_draw_slot_hpmp_stats_bank_e02:
    call DrawSlotHPMPStats_BankE0
    inc c
    call DrawSlotHPMPStats_BankE0
    inc c
    call DrawSlotHPMPStats_BankE0
    ld hl, vBGMap0 + $20b
    ld de, wBattleMeter
    call DrawSlotHPMPStats_BankE0_DrawWordAtDE
    ld hl, wDebugState
    inc [hl]
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0", ROMX

; Debug stats display for slot C (unless out): HP, max HP, MP and max MP, then level, ATK, DEF, AGL,
; INT, the three personality bytes, the trait and the extra stat in decimal, then the AI mode glyph,
; at the slot's place from DrawSlotHPMPStats_BankE0_Data; an out slot is cleared instead. (C1,
; E-0357)
DrawSlotHPMPStats_BankE0::
    ld a, c
    and $03
    ld hl, DrawSlotHPMPStats_BankE0_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, c
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $ff
    jr z, .clear_temp0
    ld de, wBattleHP
    call DrawSlotHPMPStats_BankE0_IndexWordC
    ld de, wBattleMaxHP
    call DrawSlotHPMPStats_BankE0_IndexWordC
    ld de, wBattleMP
    call DrawSlotHPMPStats_BankE0_IndexWordC
    ld de, wBattleMaxMP
    call DrawSlotHPMPStats_BankE0_IndexWordC
    inc hl
    ld de, wBattleLevel
    call DrawSlotHPMPStats_BankE0_DrawByteStat
    ld de, wBattleATK
    call DrawSlotHPMPStats_BankE0_DrawWordStat
    ld de, wBattleDEF
    call DrawSlotHPMPStats_BankE0_DrawWordStat
    ld de, wBattleAGL
    call DrawSlotHPMPStats_BankE0_DrawWordStat
    ld de, wBattleINT
    call DrawSlotHPMPStats_BankE0_DrawWordStat
    ld de, wSlotPersonalityHi
    call DrawSlotHPMPStats_BankE0_DrawByteStat
    ld de, wSlotPersonalityMid
    call DrawSlotHPMPStats_BankE0_DrawByteStat
    ld de, wSlotPersonalityLo
    call DrawSlotHPMPStats_BankE0_DrawByteStat
    ld de, wSlotTrait
    call DrawSlotHPMPStats_BankE0_DrawByteStat
    dec hl
    ld de, wBattleExtraStat
    call DrawSlotHPMPStats_BankE0_IndexWordC
    call DrawSlotHPMPStats_BankE0_DrawAIModeGlyph
    call DrawSlotHPMPStats_BankE0_DrawSuffixMark
    ret

.clear_temp0:
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a
    call DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow
    inc hl
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    call DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow
    dec hl
    call DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_DrawWordStat", ROMX

; C = battle slot, DE = a word-per-slot battle array (wBattleATK and the like), HL = VRAM position:
; converts the word at DE + 2 * C (WordAtDEToPackedBCD) and draws its low three digits with leading
; zeros left unwritten, then moves HL down one BG map row (falls into
; DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow). (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawWordStat::
    ld a, c
    add a
    add e
    ld e, a
    jr nc, .call_word_at_de_to_packed_bcd
    inc d

.call_word_at_de_to_packed_bcd:
    call WordAtDEToPackedBCD
    jr DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_DrawByteStat", ROMX

; C = battle slot, DE = a byte-per-slot battle array (wBattleLevel, wSlotPersonalityHi and the
; like), HL = VRAM position: converts the byte at DE + C (Number24ToPackedBCD with wDigits + 1 and +
; 2 cleared) and falls into DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow, which draws three
; digits and moves HL down a row. BC and HL are kept across the conversion. (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawByteStat::
    ld a, c
    add e
    ld e, a
    jr nc, .set_digits
    inc d

.set_digits:
    push hl
    ld a, [de]
    ld [wDigits], a
    xor a
    ld [wDigits + $1], a
    ld [wDigits + $2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    pop hl

; Draws the packed number's three digits and moves HL down a row. (C1, E-0357)
DrawSlotHPMPStats_BankE0_DrawThreeDigitsNextRow::
    ld b, $00
    push hl
    call DrawSlotHPMPStats_BankE0_DrawThreeDigits
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_IndexWordC", ROMX

; C = battle slot, DE = the start of an array with one word per slot (wBattleHP, wBattleMaxHP,
; wBattleMP, wBattleMaxMP or wBattleExtraStat), HL = VRAM position: adds 2 * C to DE and falls into
; DrawSlotHPMPStats_BankE0_DrawWordAtDE, which draws that word as a number. Called five times by
; DrawSlotHPMPStats_BankE0. (C1, E-0385)
; DE += 2 * C, then falls into the BCD conversion of the word
DrawSlotHPMPStats_BankE0_IndexWordC::
    ld a, c
    add a
    add e
    ld e, a
    jr nc, DrawSlotHPMPStats_BankE0_DrawWordAtDE
    inc d

; DE = address of a 16-bit value, HL = VRAM position: converts the word (WordAtDEToPackedBCD) and
; falls into DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow, which draws its low four digits and
; moves HL down a row. Called by RunDebugState_E0_DrawSlotStats for wBattleMeter and reached from
; DrawSlotHPMPStats_BankE0_IndexWordC for the HP, MP and extra-stat words. (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawWordAtDE::
    call WordAtDEToPackedBCD

; HL = VRAM position: draws the low four digits of the packed number in hTemp1/hTemp0
; (DrawSlotHPMPStats_BankE0_DrawFourDigits), then moves HL down one BG map row ($20); HL's other
; bits are kept. (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawFourDigitsNextRow::
    push hl
    call DrawSlotHPMPStats_BankE0_DrawFourDigits
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_DrawFourDigits", ROMX

; HL = VRAM position: draws four decimal digits from the packed number (thousands from hTemp1's high
; nibble, then DrawSlotHPMPStats_BankE0_DrawThreeDigits for hundreds, tens and ones) as tiles $E0 +
; digit; leading zero digits are not written (their tiles are left as they were) and the ones digit
; is always drawn. B = 1 once a digit is drawn. (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawFourDigits::
    ld b, $00
    ldh a, [hTemp1]
    swap a
    and $0f
    or a
    jr z, .next
    add $e0
    call WriteVRAMByte
    ld b, $01

.next:
    inc hl

; HL = VRAM position, B bit 0 = a higher digit was already drawn: draws the hundreds (hTemp1 low
; nibble), tens and ones (hTemp0) of the packed number as tiles $E0 + digit at HL, HL + 1 and HL +
; 2; a zero is skipped (not written) until some digit has been drawn, and the ones digit is always
; drawn. (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawThreeDigits::
    ldh a, [hTemp1]
    and $0f
    or a
    jr nz, .call_write_vram_byte
    bit 0, b
    jr z, .read_temp0

.call_write_vram_byte:
    add $e0
    call WriteVRAMByte
    ld b, $01

.read_temp0:
    inc hl
    ldh a, [hTemp0]
    swap a
    and $0f
    or a
    jr nz, .call_write_vram_byte2
    bit 0, b
    jr z, .check_temp0

.call_write_vram_byte2:
    add $e0
    call WriteVRAMByte

.check_temp0:
    inc hl
    ldh a, [hTemp0]
    and $0f
    add $e0
    call WriteVRAMByte
    ret

SECTION "Bank E0 WordAtDEToPackedBCD", ROMX

; DE = address of a 16-bit word (low byte first): copies it to wDigits and wDigits + 1, clears
; wDigits + 2 and runs Number24ToPackedBCD, so hTemp0 = tens and ones, hTemp1 = thousands and
; hundreds, hTemp2 = hundred-thousands and ten-thousands (a word never has a hundred-thousands
; digit, so it is 0 to 6) and hTemp3 = 0, two decimal digits per byte with the higher digit in the
; upper nibble. BC and HL are kept; DE is not. Called by DrawSlotHPMPStats_BankE0_DrawWordStat and
; DrawSlotHPMPStats_BankE0_DrawWordAtDE. (C2, E-0385)
; wDigits/wDigits + $1 = the word at DE, wDigits + $2 = 0, then Number24ToPackedBCD; BC, HL kept
; (E-0118)
WordAtDEToPackedBCD::
    push hl
    ld a, [de]
    ld [wDigits], a
    inc de
    ld a, [de]
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    pop hl
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_DrawAIModeGlyph", ROMX

; C = battle slot: writes the glyph tile for the AI mode of that slot,
; DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data2[wSlotAIMode[C]] ($0B, $0A, $09, $08 or $EF for
; modes 0-4), at the BG map address of column C AND 3 from
; DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data1 ($9946, $994C, $9952). Called by
; DrawSlotHPMPStats_BankE0 just before the suffix mark. (C1, E-0385)
; writes the glyph for the slot's wSlotAIMode at the slot's BG address
DrawSlotHPMPStats_BankE0_DrawAIModeGlyph::
    ld a, c
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data2
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, c
    and $03
    ld hl, DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data1
    add a
    add_a_to_hl
    deref_hl
    pop af
    call WriteVRAMByte
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_DrawSuffixMark", ROMX

; C = battle slot: writes tile $CC + (wSlotNameSuffix[C] bit 0), so $CC or $CD, at the VRAM address
; for slot C & 3 in the 3-word table after it ($98C6, $98CC, $98D2). The last step of
; DrawSlotHPMPStats_BankE0. (C1, E-0371)
DrawSlotHPMPStats_BankE0_DrawSuffixMark::
    ld a, c
    ld de, wSlotNameSuffix
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, c
    and $03
    ld hl, DrawSlotHPMPStats_BankE0_DrawSuffixMark_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, [de]
    and $01
    add $cc
    call WriteVRAMByte
    ret

SECTION "Bank E0 DrawSlotHPMPStats_BankE0_DrawSuffixMark_Data", ROMX

; Three BG map addresses, $98C6, $98CC and $98D2 (vBGMap0 row 6, columns 6, 12 and 18), one per slot
; column. DrawSlotHPMPStats_BankE0_DrawSuffixMark indexes it with slot C & 3 and writes tile $CC
; plus bit 0 of wSlotNameSuffix[C] there. (C1, E-0381)
DrawSlotHPMPStats_BankE0_DrawSuffixMark_Data::
    db $c6, $98, $cc, $98, $d2, $98

; Three BG map addresses, $9842, $9848 and $984E (vBGMap0 row 2, columns 2, 8 and 14), the top of
; each slot column of numbers. DrawSlotHPMPStats_BankE0 indexes it with slot C & 3 and draws HP, max
; HP, MP and max MP as four-digit numbers going down one row each, then level, the stats and the
; extra stat below. (C1, E-0381)
DrawSlotHPMPStats_BankE0_Data::
    db $42, $98, $48, $98, $4e, $98

; Three BG map addresses, $9946, $994C and $9952 (vBGMap0 row 10, columns 6, 12 and 18), one per
; slot column. DrawSlotHPMPStats_BankE0_DrawAIModeGlyph indexes it with slot C & 3 and writes the AI
; mode tile from DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data2 there. (C1, E-0381)
DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data1::
    db $46, $99, $4c, $99, $52, $99

; Five tile numbers: $0B, $0A, $09, $08, $EF, indexed by wSlotAIMode[C], the AI mode of the slot
; (value 0 gives $0B, value 4 gives $EF). DrawSlotHPMPStats_BankE0_DrawAIModeGlyph writes the chosen
; tile at the address from DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data1. (C1, E-0381)
DrawSlotHPMPStats_BankE0_DrawAIModeGlyph_Data2::
    db $0b, $0a, $09, $08, $ef

; Debug battle viewer, state 2: Select saves the battle counts and actor and opens the effect viewer
; (state $0A); Start goes on to state 3; Left/Right turn the page; A opens the resistances (state
; 4); B the skills (state 7). (C1, E-0357)
RunDebugState_E0_Input::
    ld a, [wJoypadPressed]
    and $04
    jr z, .check_joypad_pressed
    ld hl, wWorkBuf
    ld a, [wBattlePartyCount]
    ld [hli], a
    ld a, [wBattleFoeCount]
    ld [hli], a
    ld a, [wBattleActor]
    ld [hli], a
    ld a, [wBattleTarget]
    ld [hli], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld a, $01
    ld [wBattlePartyCount], a
    ld a, $01
    ld [wBattleFoeCount], a
    ld a, $0a
    ld [wDebugState], a
    call RunDebugState_E0_Input_DrawEffectViewerScreen
    call DrawSkillDebugDigitsAndRecord
    xor a
    ld [wDebugSubState], a
    call DrawHexByteAtBGMap8A
    ld a, $ff
    ld [wEffectId], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $08
    jr z, .check_joypad_pressed2
    ld hl, wDebugState
    inc [hl]
    ret

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and $30
    jr z, .check_joypad_pressed3
    ld a, [wDebugSubState]
    inc a
    and $01
    ld [wDebugSubState], a
    xor a
    ld [wDebugState], a
    ret

.check_joypad_pressed3:
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed4
    ld a, $04
    ld [wDebugState], a
    ret

.check_joypad_pressed4:
    ld a, [wJoypadPressed]
    and $02
    ret z
    ld a, $07
    ld [wDebugState], a
    ret

SECTION "Bank E0 RunDebugState_E0_MarkGains", ROMX

; Debug battle viewer, state 3: draws the screen buffer and marks every active slot's level-up gains
; as 7, clearing wDebugValue3. (C1, E-0357)
RunDebugState_E0_MarkGains::
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub b
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, .loop
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, .loop3
    ld c, $04

.loop3:
    ld a, c
    ld hl, wLevelUpGains
    add_a_to_hl
    ld [hl], $07
    inc c
    dec b
    jr nz, .loop3
    xor a
    ld [wDebugValue3], a
    ret

SECTION "Bank E0 RunDebugState_E0_DrawResistanceFrame", ROMX

; Debug battle viewer, state 4: draws the 20 x 16 tile map of the resistance page at vBGMap0 + $20
; and advances wDebugState (DrawTileMapAndStep); state 5 (RunDebugState_E0_DrawResistances) then
; fills in the values. (C1, E-0371)
RunDebugState_E0_DrawResistanceFrame::
    call DrawTileMapAndStep
    ret

SECTION "Bank E0 RunDebugState_E0_DrawResistances", ROMX

; Debug battle viewer, state 5: draws the six slots' 27 resistance levels as 2-bit digits
; (wSlotResistances). (C1, E-0357)
RunDebugState_E0_DrawResistances::
    ld hl, vBGMap0 + $61
    ld de, wSlotResistances
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $67
    ld de, wSlotResistances + $7
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $6d
    ld de, wSlotResistances + $e
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $141
    ld de, wSlotResistances + $1c
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $147
    ld de, wSlotResistances + $23
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $14d
    ld de, wSlotResistances + $2a
    call DrawPacked2BitFieldsInRows
    ld hl, wDebugState
    inc [hl]
    ret

SECTION "Bank E0 DrawPacked2BitFieldsInRows", ROMX

; Draws the 2-bit fields of the bytes at DE (a resistance record) as digits, six rows of five with
; each row $1B tiles further on, the last digit through DrawLowTwoBitsAsDigit. (C1, E-0357)
DrawPacked2BitFieldsInRows::
    ld a, [de]
    ld c, a
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    ld a, l
    add $1b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    ld a, l
    add $1b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    ld a, l
    add $1b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    ld a, l
    add $1b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    ld a, l
    add $1b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    call DrawBits32OfDEAsDigit
    ld a, c
    rlca
    rlca
    jr DrawLowTwoBitsAsDigit

SECTION "Bank E0 DrawBits76OfNextDEAsDigit", ROMX

; DE += 1, then draws bits 7-6 of the byte at [DE] as the digit tile $E0 + (0-3) at HL and advances
; HL (through DrawLowTwoBitsAsDigit). Used by DrawPacked2BitFieldsInRows to cross from one
; resistance byte to the next. (C1, E-0385)
; DE += 1, then writes bits 7-6 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc)
; (E-0112)
DrawBits76OfNextDEAsDigit::
    inc de
    ld a, [de]
    rlca
    rlca
    jr DrawLowTwoBitsAsDigit

SECTION "Bank E0 DrawBits54OfDEAsDigit", ROMX

; Draws bits 5-4 of the byte at [DE] as the digit tile $E0 + (0-3) at HL and advances HL (swap, then
; DrawLowTwoBitsAsDigit). DE is not changed. (C1, E-0385)
; writes bits 5-4 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
DrawBits54OfDEAsDigit::
    ld a, [de]
    swap a
    jr DrawLowTwoBitsAsDigit

SECTION "Bank E0 DrawBits32OfDEAsDigit", ROMX

; Draws bits 3-2 of the byte at [DE] as the digit tile $E0 + (0-3) at HL and advances HL (two right
; rotations, then DrawLowTwoBitsAsDigit). DE is not changed. (C1, E-0385)
; writes bits 3-2 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
DrawBits32OfDEAsDigit::
    ld a, [de]
    rrca
    rrca
    jr DrawLowTwoBitsAsDigit

SECTION "Bank E0 DrawBits10OfDEAsDigit", ROMX

; Draws bits 1-0 of the byte at [DE] as the digit tile $E0 + (0-3) at HL and advances HL (falls into
; DrawLowTwoBitsAsDigit). DE is not changed. (C1, E-0385)
; writes bits 1-0 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
DrawBits10OfDEAsDigit::
    ld a, [de]

; A = value: writes tile $E0 + (A & 3), the digit 0-3, at VRAM address HL and advances HL
; (WriteVRAMByteInc). The shared tail of DrawBits10OfDEAsDigit, DrawBits32OfDEAsDigit,
; DrawBits54OfDEAsDigit, DrawBits76OfNextDEAsDigit and DrawPacked2BitFieldsInRows, which rotate the
; wanted 2-bit field into bits 1-0 first. (C1, E-0371)
DrawLowTwoBitsAsDigit::
    and $03
    add $e0
    call WriteVRAMByteInc
    ret

SECTION "Bank E0 RunDebugState_E0_ReturnOnA", ROMX

; Debug battle viewer, state 6: waits for A, then back to state 0. (C2, E-0357; probed E-0385)
RunDebugState_E0_ReturnOnA::
    ld a, [wJoypadPressed]
    and $01
    ret z
    xor a
    ld [wDebugState], a
    ret

SECTION "Bank E0 DrawTileMapAndStep", ROMX

; Writes the 20 x 16 tile map DrawTileMapAndStep_Data to vBGMap0 + $20 row by row (WriteVRAMByteInc,
; 32 bytes between rows), then adds 1 to wDebugState. It is state 7 of RunDebugState_E0 (reached
; from the viewer input with B) and is also called by RunDebugState_E0_DrawResistanceFrame. (C1,
; E-0385)
; writes the 20 x 16 tile map $4946 to vBGMap0 + $20, then wDebugState += 1 (E-0124) (E-0344: the
; address in its name dropped or read as the label there; was DrawTileMapAndStep)
DrawTileMapAndStep::
    ld de, DrawTileMapAndStep_Data
    ld hl, vBGMap0 + $20
    ld bc, $1410

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ld hl, wDebugState
    inc [hl]
    ret

SECTION "Bank E0 RunDebugState_E0_DrawSkillBytes", ROMX

; Debug battle viewer, state 8: draws the six slots' skill bytes (wBattleSkills) as hex columns and
; the three battler records' experience. (C1, E-0357)
RunDebugState_E0_DrawSkillBytes::
    ld de, wBattleSkills
    ld hl, vBGMap0 + $62
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $10
    ld hl, vBGMap0 + $68
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $20
    ld hl, vBGMap0 + $6e
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $40
    ld hl, vBGMap0 + $142
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $50
    ld hl, vBGMap0 + $148
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $60
    ld hl, vBGMap0 + $14e
    call DrawEightBytesAsHexColumns
    call RunForThreeBattlerRecords
    ld hl, wDebugState
    inc [hl]
    ret

SECTION "Bank E0 DrawEightBytesAsHexColumns", ROMX

; DE = bytes, HL = VRAM position: draws four entries with DrawFourBytesAsHexRows, then four more
; from where DE stopped in a second column 3 cells to the right. Each entry is the low byte of a
; 16-bit word (DrawFourBytesAsHexRows takes every second byte), so 16 bytes are covered. Called six
; times by RunDebugState_E0_DrawSkillBytes for wBattleSkills. (C1, E-0385)
; DrawFourBytesAsHexRows at HL, then the next four bytes in a second column three entries to the
; right (E-0112)
DrawEightBytesAsHexColumns::
    push hl
    call DrawFourBytesAsHexRows
    pop hl
    ld a, l
    add $03
    ld l, a
    ld a, h
    adc $00
    ld h, a

; DE = bytes, HL = VRAM position: for 4 entries draws the byte at DE as two hex digit tiles
; (WriteHexDigitTile, high nibble first), moves HL to the same column of the next BG map row, and
; advances DE by 2 (so every second byte is shown). Called by DrawEightBytesAsHexColumns. (C1,
; E-0385)
; writes four bytes from DE as two hex digits each (WriteHexDigitTile), one byte per BG map row (HL
; += $1E after each) (E-0112)
DrawFourBytesAsHexRows::
    ld b, $04

.loop:
    ld a, [de]
    swap a
    and $0f
    call WriteHexDigitTile
    ld a, [de]
    and $0f
    call WriteHexDigitTile
    ld a, l
    add $1e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc de
    inc de
    dec b
    jr nz, .loop
    ret

SECTION "Bank E0 WriteHexDigitTile", ROMX

; A = 0-15, HL = VRAM position: writes the tile $E0 + A for A below 10, or the tile A - 2 ($08-$0D)
; for 10-15, and advances HL (WriteVRAMByteInc). Called by DrawFourBytesAsHexRows. (C1, E-0385)
; A = 0-15: writes tile $E0 + A for 0-9, or A - 2 for 10-15, at HL (WriteVRAMByteInc) (E-0112)
WriteHexDigitTile::
    cp $0a
    jr nc, .call_write_vram_byte_inc
    add $e0
    jr .call_write_vram_byte_inc2

.call_write_vram_byte_inc:
    sub $02

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ret

SECTION "Bank E0 RunForThreeBattlerRecords", ROMX

; Starts at BATTLER_EXP of record 3 of wBattlerRecords (records are $4E bytes) and calls
; RunForThreeBattlerRecords_Number24ToPackedBCD for B = 0, 1, 2, moving HL on by $4E each time. Each
; call converts the 24-bit experience at HL (Number24ToPackedBCD) and draws its last five digits as
; digit tiles in row 15 of vBGMap0, columns 2, 8 and 14 for B = 0, 1, 2; zero digits are not written
; until a non-zero digit has been drawn. So it shows the experience of records 3, 4 and 5. Called by
; RunDebugState_E0_DrawSkillBytes. (C1, E-0385)
; runs RunForThreeBattlerRecords_Number24ToPackedBCD for B = 0, 1, 2 on the 78-byte records from
; wBattlerRecords + $18 + 3 * $4E (E-0122) (E-0344: the address in its name dropped or read as the
; label there; was RunForThreeBattlerRecords)
RunForThreeBattlerRecords::
    ld de, $004e
    ld hl, wBattlerRecords + BATTLER_EXP
    add hl, de
    add hl, de
    add hl, de
    ld b, $00
    call RunForThreeBattlerRecords_Number24ToPackedBCD
    add hl, de
    ld b, $01
    call RunForThreeBattlerRecords_Number24ToPackedBCD
    add hl, de
    ld b, $02
    call RunForThreeBattlerRecords_Number24ToPackedBCD
    ret

SECTION "Bank E0 RunForThreeBattlerRecords_Number24ToPackedBCD", ROMX

; Draws the 24-bit number at HL as up to six digits (leading zeros blank) at battler record B's
; place. (C1, E-0357)
RunForThreeBattlerRecords_Number24ToPackedBCD::
    push af
    push bc
    push de
    push hl
    ld a, [hli]
    ld [wDigits], a
    ld a, [hli]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop hl
    pop de
    pop bc
    pop af
    push hl
    ld a, b
    ld hl, RunForThreeBattlerRecords_Number24ToPackedBCD_Data
    add a
    add_a_to_hl
    deref_hl
    ld b, $00
    ldh a, [hTemp2]
    and $0f
    or a
    jr z, .read_temp1
    add $e0
    call WriteVRAMByte
    ld b, $01

.read_temp1:
    inc hl
    ldh a, [hTemp1]
    swap a
    and $0f
    or a
    jr nz, .call_write_vram_byte
    bit 0, b
    jr z, .check_temp1

.call_write_vram_byte:
    add $e0
    call WriteVRAMByte
    ld b, $01

.check_temp1:
    inc hl
    ldh a, [hTemp1]
    and $0f
    or a
    jr nz, .call_write_vram_byte2
    bit 0, b
    jr z, .read_temp0

.call_write_vram_byte2:
    add $e0
    call WriteVRAMByte
    ld b, $01

.read_temp0:
    inc hl
    ldh a, [hTemp0]
    swap a
    and $0f
    or a
    jr nz, .call_write_vram_byte3
    bit 0, b
    jr z, .check_temp0

.call_write_vram_byte3:
    add $e0
    call WriteVRAMByte
    ld b, $01

.check_temp0:
    inc hl
    ldh a, [hTemp0]
    and $0f
    add $e0
    call WriteVRAMByte
    pop hl
    ret

SECTION "Bank E0 RunForThreeBattlerRecords_Number24ToPackedBCD_Data", ROMX

; Three BG map addresses, $99E2, $99E8 and $99EE (vBGMap0 row 15, columns 2, 8 and 14).
; RunForThreeBattlerRecords_Number24ToPackedBCD indexes it with B = 0, 1, 2 (the three records
; RunForThreeBattlerRecords visits at BATTLER_EXP) and draws the 24-bit experience as digit tiles
; $E0 + digit there, leaving leading zeros blank. (C1, E-0381)
RunForThreeBattlerRecords_Number24ToPackedBCD_Data::
    db $e2, $99, $e8, $99, $ee, $99

; Debug battle viewer, state 9: waits for B, then back to state 0. (C2, E-0357; probed E-0385)
RunDebugState_E0_ReturnOnB::
    ld a, [wJoypadPressed]
    and $02
    ret z
    xor a
    ld [wDebugState], a
    ret

SECTION "Bank E0 DrawTileMapAndStep_Data", ROMX

; A 20 by 16 tile screen image, 320 bytes in row order, which DrawTileMapAndStep copies once to
; vBGMap0 starting at row 1 (vBGMap0 + $20, 32 bytes between rows) before it advances wDebugState.
; It is a frame of tiles $B0-$B7 around blank tile $C3, with glyph tiles $F5-$F7 in row 1 and $F8
; and $F9 in row 8. (C1, E-0381)
DrawTileMapAndStep_Data::
    db $b0
    ds $12, $b1
    db $b2, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $f5, $f6, $f7, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $f8, $c3, $f9, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b6
    ds $12, $c3
    db $b7, $b3
    ds $12, $b4
    db $b5

; The effect viewer, state 10: while an effect plays runs it; otherwise Right/Left step the effect
; number 0-$3B with wrap and draw it, then the buttons below. (C1, E-0357)
RunDebugState_E0_EffectViewer::
    ld a, [wEffectId]
    cp $ff
    jr z, .check_joypad_pressed
    farcall RunDebugState_E0_EffectViewer_PlayEffect
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $10
    jr z, .check_joypad_pressed2
    ld hl, wDebugSubState
    inc [hl]
    ld a, [hl]
    cp $3c
    jr nz, DrawHexByteAtBGMap8A
    xor a
    ld [hl], a
    jr DrawHexByteAtBGMap8A

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and $20
    jr z, RunDebugState_E0_EffectViewer_Buttons
    ld hl, wDebugSubState
    dec [hl]
    ld a, [hl]
    cp $ff
    jr nz, DrawHexByteAtBGMap8A
    ld a, $3b
    ld [hl], a

; Draws A as two hex digits at BG map 0 + $89/$8A (digit tiles from $E0, letters 2 below the letter
; tiles), then the skill debug digits (DrawSkillDebugDigitsAndRecord). (C1, E-0357)
DrawHexByteAtBGMap8A::
    push af
    and $0f
    cp $0a
    jr nc, .call_write_vram_byte
    add $e0
    jr .call_write_vram_byte2

.call_write_vram_byte:
    sub $02

.call_write_vram_byte2:
    ld hl, vBGMap0 + $8a
    call WriteVRAMByte
    pop af
    swap a
    and $0f
    cp $0a
    jr nc, .call_write_vram_byte3
    add $e0
    jr .call_write_vram_byte4

.call_write_vram_byte3:
    sub $02

.call_write_vram_byte4:
    ld hl, vBGMap0 + $89
    call WriteVRAMByte
    call DrawSkillDebugDigitsAndRecord
    ret

SECTION "Bank E0 RunDebugState_E0_EffectViewer_Buttons", ROMX

; The effect viewer's buttons (reached from RunDebugState_E0_EffectViewer when Right and Left are
; not pressed): A starts debug effect wDebugSubState (RunDebugState_E0_EffectViewer_StartEffect in
; bank $3A) and plays its sound (RunDebugState_E0_PlayEffectSound); Select restores
; wBattlePartyCount, wBattleFoeCount, wBattleActor, wBattleTarget and wBattleActionId from wWorkBuf,
; sets wDebugState to $0B (RunDebugState_E0_EditStatusBits) with wDebugSubState and wDebugCounter 0,
; draws that screen and its status bits and reads the cursor cell; otherwise it goes on to
; RunDebugState_E0_RestoreBattleOnB for B. (C1, E-0371)
RunDebugState_E0_EffectViewer_Buttons::
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    farcall RunDebugState_E0_EffectViewer_StartEffect
    call RunDebugState_E0_PlayEffectSound
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $04
    jr z, RunDebugState_E0_RestoreBattleOnB
    ld hl, wWorkBuf
    ld a, [hli]
    ld [wBattlePartyCount], a
    ld a, [hli]
    ld [wBattleFoeCount], a
    ld a, [hli]
    ld [wBattleActor], a
    ld a, [hli]
    ld [wBattleTarget], a
    ld a, [hl]
    ld [wBattleActionId], a
    ld a, $0b
    ld [wDebugState], a
    xor a
    ld [wDebugSubState], a
    call RunDebugState_E0_DrawStatusBitsScreen
    call DrawSlotStatusBitsDebug
    xor a
    ld [wDebugCounter], a
    call ReadBGTileAtDebugCounterCell
    ret

SECTION "Bank E0 RunDebugState_E0_RestoreBattleOnB", ROMX

; Returns unless B is pressed; then restores wBattlePartyCount, wBattleFoeCount, wBattleActor,
; wBattleTarget and wBattleActionId from the 5 bytes at wWorkBuf, sets wDebugState to 0 and
; wEffectId to $FF (no effect playing). Reached from the effect viewer's buttons and from
; RunDebugState_E0_EditStatusBits. (C2, E-0371; probed E-0385)
RunDebugState_E0_RestoreBattleOnB::
    ld a, [wJoypadPressed]
    and $02
    ret z
    ld hl, wWorkBuf
    ld a, [hli]
    ld [wBattlePartyCount], a
    ld a, [hli]
    ld [wBattleFoeCount], a
    ld a, [hli]
    ld [wBattleActor], a
    ld a, [hli]
    ld [wBattleTarget], a
    ld a, [hl]
    ld [wBattleActionId], a
    xor a
    ld [wDebugState], a
    ld a, $ff
    ld [wEffectId], a
    ret

SECTION "Bank E0 RunDebugState_E0_EditStatusBits", ROMX

; Debug battle viewer, state 11 (the status bits): blinks the cursor; Start changes slot (0-7); the
; D-pad moves over the bits (columns 0-7, rows of the slot's status bytes); the rest follow. (C1,
; E-0357)
RunDebugState_E0_EditStatusBits::
    call BlinkTemp0Tile
    ld a, [wJoypadPressed]
    and $08
    jr z, .check_joypad_pressed
    ld hl, wDebugSubState
    inc [hl]
    ld a, [hl]
    cp $08
    jr nz, .call_draw_slot_status_bits_debug
    xor a
    ld [hl], a

.call_draw_slot_status_bits_debug:
    call DrawSlotStatusBitsDebug
    xor a
    ld [wDebugCounter], a
    call ReadBGTileAtDebugCounterCell
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $20
    jr z, .check_joypad_pressed2
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and $0f
    dec a
    and $0f
    cp $0f
    jr nz, .skip
    ld a, [hl]
    and $f0
    or $07

.skip:
    push af
    ld a, [hl]
    and $f0
    pop bc
    or b
    ld [hl], a
    jr .call_read_bg_tile_at_debug_counter_cell

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and $10
    jr z, .check_joypad_pressed3
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and $0f
    inc a
    and $0f
    cp $08
    jr nz, .skip2
    ld a, [hl]
    and $f0

.skip2:
    push af
    ld a, [hl]
    and $f0
    pop bc
    or b
    ld [hl], a
    jr .call_read_bg_tile_at_debug_counter_cell

.check_joypad_pressed3:
    ld a, [wJoypadPressed]
    and $40
    jr z, .check_joypad_pressed4
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and $f0
    sub $10
    and $f0
    cp $f0
    jr nz, .skip3
    ld a, [hl]
    and $0f
    or $80

.skip3:
    push af
    ld a, [hl]
    and $0f
    pop bc
    or b
    ld [hl], a
    jr .call_read_bg_tile_at_debug_counter_cell

.check_joypad_pressed4:
    ld a, [wJoypadPressed]
    and $80
    jr z, .check_joypad_pressed5
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and $f0
    add $10
    and $f0
    cp $90
    jr nz, .skip4
    ld a, [hl]
    and $0f

.skip4:
    push af
    ld a, [hl]
    and $0f
    pop bc
    or b
    ld [hl], a

.call_read_bg_tile_at_debug_counter_cell:
    call ReadBGTileAtDebugCounterCell
    ret

.check_joypad_pressed5:
    ld a, [wJoypadPressed]
    and $01
    jr z, .to_run_debug_state_e0_restore_battle_on_b
    ld a, [wMenuRowCount]
    xor $01
    ld [wMenuRowCount], a
    ld a, [wTemp0]
    ld l, a
    ld a, [wTemp1]
    ld h, a
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld a, [wDebugSubState]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [wDebugCounter]
    ld e, a
    swap a
    and $0f
    ld c, a
    ld b, $00
    add hl, bc
    ld a, [wMenuRowCount]
    and $01
    jr z, .skip6
    ld a, e
    ld de, RunDebugState_E0_EditStatusBits_Data2
    and $0f
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    or [hl]
    ld [hl], a
    ret

.skip6:
    ld a, e
    ld de, RunDebugState_E0_EditStatusBits_Data1
    and $0f
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    and [hl]
    ld [hl], a
    ret

.to_run_debug_state_e0_restore_battle_on_b:
    jp RunDebugState_E0_RestoreBattleOnB

SECTION "Bank E0 RunDebugState_E0_EditStatusBits_Data1", ROMX

; Eight AND masks, $FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F: each clears one bit, bit 0 to bit 7.
; RunDebugState_E0_EditStatusBits indexes it with the low nibble of wDebugCounter (the bit cursor,
; 0-7) when the toggled mark is cleared, and ANDs it into the status byte at wBattleStatus + 9 *
; wDebugSubState plus the high nibble of wDebugCounter. (C1, E-0381)
RunDebugState_E0_EditStatusBits_Data1::
    db $fe, $fd, $fb, $f7, $ef, $df, $bf, $7f

; Eight OR masks, $01, $02, $04, $08, $10, $20, $40, $80: each sets one bit, bit 0 to bit 7.
; RunDebugState_E0_EditStatusBits indexes it with the low nibble of wDebugCounter (0-7) when the
; toggled mark is set, and ORs it into the status byte at wBattleStatus + 9 * wDebugSubState plus
; the high nibble of wDebugCounter. (C1, E-0381)
RunDebugState_E0_EditStatusBits_Data2::
    db $01, $02, $04, $08, $10, $20, $40, $80

; Writes the tile $C3 (blank) when bit 3 of wFrameCounterLo is clear, otherwise the tile saved in
; wMenuRowCount, at the VRAM address in wTemp0 (low) and wTemp1 (high): the status-bit cursor cell
; blinks every 8 frames. Called every frame by RunDebugState_E0_EditStatusBits. (C1, E-0385)
; writes either $C3 (bit 3 of wFrameCounterLo clear) or wMenuRowCount at the VRAM address in
; wTemp0/1 (E-0122) (E-0340: the address in its name read as its RAM name; was BlinkTemp0Tile)
BlinkTemp0Tile::
    ld a, [wTemp0]
    ld l, a
    ld a, [wTemp1]
    ld h, a
    ld a, [wFrameCounterLo]
    bit 3, a
    ld a, $c3
    jr z, .call_write_vram_byte
    ld a, [wMenuRowCount]

.call_write_vram_byte:
    call WriteVRAMByte
    ret

SECTION "Bank E0 RunDebugState_E0_SkillEditor", ROMX

; Debug battle viewer, state 12: runs the skill editor (RunDebugSubState_E0). (C1, E-0357)
RunDebugState_E0_SkillEditor::
    call RunDebugSubState_E0
    ret

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets", ROMX

; State 13 of the debug battle viewer (choosing actions). Jumps through a table of six by
; wDebugSubState: 0 RunDebugState_E0_ChooseActionTargets_Start, 1
; RunDebugState_E0_ChooseActionTargets_AIChoice, 2 RunDebugState_E0_ChooseActionTargets_ShowActor, 3
; RunDebugState_E0_ChooseActionTargets_Input, 4 RunDebugState_E0_ChooseActionTargets_End, 5
; RunDebugState_E0_ChooseActionTargets_RerunAI. (C1, E-0385)
; debug battle state $0D: shows a string, reads the slot's personality and, for an actor without a
; target, far-calls ChooseActionTarget
RunDebugState_E0_ChooseActionTargets::
    ld a, [wDebugSubState]
    jumptable
    dw RunDebugState_E0_ChooseActionTargets_Start
    dw RunDebugState_E0_ChooseActionTargets_AIChoice
    dw RunDebugState_E0_ChooseActionTargets_ShowActor
    dw RunDebugState_E0_ChooseActionTargets_Input
    dw RunDebugState_E0_ChooseActionTargets_End
    dw RunDebugState_E0_ChooseActionTargets_RerunAI

; Choosing actions, sub-state 0: shows the headings, draws the layout and starts with actor 0. (C1,
; E-0357)
RunDebugState_E0_ChooseActionTargets_Start::
    ld hl, vTiles2 + $10
    ld de, $1001
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank08AtTilesHLThenDefault_BankE0
    ld hl, vTiles1
    ld de, $1201
    ld a, $0e
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank08AtTilesHLThenDefault_BankE0
    ld de, DebugActionTargetsScreenLayout
    ld bc, $1412
    ld hl, vBGMap0

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    xor a
    ld [wBattleActor], a
    ld a, $01
    ld [wDebugSubState], a
    ret

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets_AIChoice", ROMX

; Choosing actions, sub-state 1: works out the actor's personality and its AI choice
; (RunDebugState_E0_RunAIChoice). (C1, E-0357)
RunDebugState_E0_ChooseActionTargets_AIChoice::
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_BankE0
    ld [wPersonalityIndex], a
    farcall RunDebugState_E0_RunAIChoice
    ld a, $02
    ld [wDebugSubState], a
    ret

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets_ShowActor", ROMX

; Choosing actions, sub-state 2: draws the actor's details (far-calls
; RunDebugState_E0_ChooseActionTargets_DrawDetails), then sets wDebugSubState to 3 (the input step).
; (C1, E-0371)
RunDebugState_E0_ChooseActionTargets_ShowActor::
    farcall RunDebugState_E0_ChooseActionTargets_DrawDetails
    ld a, $03
    ld [wDebugSubState], a
    ret

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets_Input", ROMX

; Choosing actions, sub-state 3. B (wJoypadPressed bit 1) goes to sub-state 4 and clears the two
; bytes of wBattleSubPhase. Otherwise on wJoypadPressedRepeat: A (bit 0) goes back to sub-state 1;
; Left (bit 5) or Right (bit 4) make wBattleActor the previous or next slot, wrapping within 0-7 and
; skipping slots whose wBattleSlotOut byte is $FF (a slot with 0 or 1 is not skipped), then go to
; sub-state 1; Select (bit 2) goes to sub-state 5. Any other button does nothing. (C2, E-0385)
RunDebugState_E0_ChooseActionTargets_Input::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_joypad_pressed_repeat
    ld a, $04
    ld [wDebugSubState], a
    xor a
    ld hl, wBattleSubPhase
    ld [hli], a
    ld [hl], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr z, .check_bit5
    ld a, $01
    ld [wDebugSubState], a
    ret

.check_bit5:
    bit 5, a
    jr z, .check_bit4

.loop:
    ld a, [wBattleActor]
    dec a
    and $07
    ld [wBattleActor], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .loop
    ld a, $01
    ld [wDebugSubState], a
    ret

.check_bit4:
    bit 4, a
    jr z, .check_bit2

.loop2:
    ld a, [wBattleActor]
    inc a
    and $07
    ld [wBattleActor], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .loop2
    ld a, $01
    ld [wDebugSubState], a
    ret

.check_bit2:
    bit 2, a
    jr z, .return
    ld a, $05
    ld [wDebugSubState], a
    ret

.return:
    ret

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets_End", ROMX

; Choosing actions, sub-state 4: clears the actor and the 16 action choices ($FF) and returns to the
; viewer's state 3. (C2, E-0357; probed E-0385)
RunDebugState_E0_ChooseActionTargets_End::
    xor a
    ld [wBattleActor], a
    ld [wDebugSubState], a
    ld a, $03
    ld [wDebugState], a
    ld a, $ff
    ld hl, wBattleActionChoice
    ld bc, $0010
    jp FillBytes

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets_RerunAI", ROMX

; Choosing actions, sub-state 5 (Select in the input step): runs the AI's full choice for the actor
; (RunDebugState_E0_ChooseActionTargets_RunFullAI), then sets wDebugSubState to 2 to redraw the
; details. (C1, E-0371)
RunDebugState_E0_ChooseActionTargets_RerunAI::
    farcall RunDebugState_E0_ChooseActionTargets_RunFullAI
    ld a, $02
    ld [wDebugSubState], a
    ret

SECTION "Bank E0 DebugActionTargetsScreenLayout", ROMX

; A 20 x 18 tile map (360 bytes, one screen row per line) for the debug battle viewer: a frame
; around the whole screen ($B0-$B7) with heading tiles ($80-$82 and $01, $9B-$A2, $8B $8C, $ED-$F3,
; $85-$87, $88-$8A), a column of $AF tiles in column 3, short labels ($02-$04 with $AF, $01 $01, $0B
; $0D) and tiles $92-$9A in row 16. RunDebugState_E0_ChooseActionTargets_Start copies it to vBGMap0
; row by row (BC = $1412, WriteVRAMByteInc) after drawing category 0 string 0 at vTiles2 + $10 and
; category $0E string 0 at vTiles1, then starts actor 0 at sub-state 1. (C1, E-0373); E-0213 (C1: a
; debug screen routine copies 20 x 18 bytes (BC = $1412) from $4D95 to vBGMap0 row by row with
; WriteVRAMByteInc). (named from its reading, E-0373; was
; RunDebugState_E0_ChooseActionTargets_ShowStringBank08AtTilesHLThenDefault_BankE0_DebugScreenLayout)
; record: 20 x 18 tiles, one row per line
DebugActionTargetsScreenLayout::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; entry 0: row 0
    db $b6, $c3, $c3, $80, $81, $82, $01, $c3, $c3, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $8b, $8c, $c3, $c3, $c3, $c3, $ed, $ee, $ef, $f0, $f1, $f2, $f3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $85, $86, $87, $c3, $c3, $88, $89, $8a, $89, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $02, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $03, $af, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $04, $af, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 9
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $b6, $c3, $c3, $af, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $02, $af, $01, $01, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 13
    db $b6, $c3, $04, $af, $0b, $0d, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 15
    db $b6, $c3, $c3, $c3, $c3, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $c3, $c3, $c3, $c3, $c3, $b7 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

; wDebugCounter holds the cursor row (high nibble) and column (low nibble) of the status-bit grid:
; stores vBGMap0 + $89 + 32 * row + column in wTemp0 (low) and wTemp1 (high), then waits for VRAM
; access and reads the tile there into wMenuRowCount. Called by
; RunDebugState_E0_EffectViewer_Buttons and RunDebugState_E0_EditStatusBits. (C1, E-0385)
; wDebugCounter = row (high nibble) and column (low nibble): stores vBGMap0 + $89 + 32 * row +
; column in wTemp0/1 and reads the tile there into wMenuRowCount (E-0121)
ReadBGTileAtDebugCounterCell::
    ld a, [wDebugCounter]
    ld b, a
    and $0f
    ld c, a
    ld a, b
    swap a
    and $0f
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld b, $00
    add hl, bc
    ld bc, vBGMap0 + $89
    add hl, bc
    ld a, l
    ld [wTemp0], a
    ld a, h
    ld [wTemp1], a
    call WaitForVRAMAccess
    ld a, [hl]
    ld [wMenuRowCount], a
    ret

SECTION "Bank E0 DrawSlotStatusBitsDebug", ROMX

; Draws the status page of slot wDebugSubState: the four-tile strip for that slot
; (DrawFourTileStripForA), then its nine status bytes (wBattleStatus + 9 * slot) as nine rows of
; eight tiles from vBGMap0 + $89, each bit as the tile $E0 + 0 or 1 with bit 0 leftmost. It keeps
; the running VRAM position in wBattleArg0 and wBattleArg1. Called by
; RunDebugState_E0_EffectViewer_Buttons (when Select opens the status bits state) and by
; RunDebugState_E0_EditStatusBits (when Start changes the slot). (C1, E-0385)
; debug: draws the four-tile strip for wDebugSubState, then the 9 status bytes of slot
; wDebugSubState as rows of 0/1 digit tiles from vBGMap0 + $89 (E-0127)
DrawSlotStatusBitsDebug::
    ld a, [wDebugSubState]
    call DrawFourTileStripForA
    ld hl, vBGMap0 + $89
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld c, $00
    ld a, [wDebugSubState]
    ld hl, wBattleStatus
    call AddAx9ToHL

.loop:
    ld d, [hl]
    ld b, $00

.loop2:
    push hl
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld a, l
    add b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, d
    and $01
    add $e0
    call WriteVRAMByte
    pop hl
    srl d
    inc b
    ld a, b
    cp $08
    jr nz, .loop2
    push hl
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld de, $0020
    add hl, de
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    pop hl
    inc hl
    inc c
    ld a, c
    cp $09
    jr nz, .loop
    ret

SECTION "Bank E0 DrawFourTileStripForA", ROMX

; A = 0-7: copies the four tiles at DrawFourTileStripForA_Data[A] (a pointer table of 8, bank $E0)
; to vBGMap0 + $27 with CopyRectFromBankToVRAM (4 wide, 1 row). Called by DrawSlotStatusBitsDebug
; with the slot number. (C1, E-0385)
; copies a 4 x 1 tile strip from bank $E0 (address from the word table at $4F9E + 2 * A) to vBGMap0
; + $27 (CopyRectFromBankToVRAM) (E-0118)
DrawFourTileStripForA::
    add a
    ld hl, DrawFourTileStripForA_Data
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0 + $27
    lb bc, $04, $01
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

SECTION "Bank E0 DrawFourTileStripForA_Data", ROMX

; Eight words, the pointers DrawFourTileStripForA_Data_Entry00 to
; DrawFourTileStripForA_Data_Entry07. DrawFourTileStripForA is called with A = wDebugSubState (0-7,
; which wraps at 8) and copies the four tiles at the chosen pointer from bank $E0 to vBGMap0 + $27
; (row 1, columns 7-10). (C1, E-0381)
DrawFourTileStripForA_Data::
    dw DrawFourTileStripForA_Data_Entry00
    dw DrawFourTileStripForA_Data_Entry01
    dw DrawFourTileStripForA_Data_Entry02
    dw DrawFourTileStripForA_Data_Entry03
    dw DrawFourTileStripForA_Data_Entry04
    dw DrawFourTileStripForA_Data_Entry05
    dw DrawFourTileStripForA_Data_Entry06
    dw DrawFourTileStripForA_Data_Entry07

; Four tile numbers, $F5, $F6, $F7, $E0: three glyph tiles and the digit tile for 0.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 0,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry00::
    db $f5, $f6, $f7, $e0

; Four tile numbers, $F5, $F6, $F7, $E1: three glyph tiles and the digit tile for 1.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 1,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry01::
    db $f5, $f6, $f7, $e1

; Four tile numbers, $F5, $F6, $F7, $E2: three glyph tiles and the digit tile for 2.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 2,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry02::
    db $f5, $f6, $f7, $e2

; Four tile numbers, $F5, $F6, $F7, $E3: three glyph tiles and the digit tile for 3.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 3,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry03::
    db $f5, $f6, $f7, $e3

; Four tile numbers, $F8, $F9, $E0, $C3: two glyph tiles, the digit tile for 0 and a blank.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 4,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry04::
    db $f8, $f9, $e0, $c3

; Four tile numbers, $F8, $F9, $E1, $C3: two glyph tiles, the digit tile for 1 and a blank.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 5,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry05::
    db $f8, $f9, $e1, $c3

; Four tile numbers, $F8, $F9, $E2, $C3: two glyph tiles, the digit tile for 2 and a blank.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 6,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry06::
    db $f8, $f9, $e2, $c3

; Four tile numbers, $F8, $F9, $E3, $C3: two glyph tiles, the digit tile for 3 and a blank.
; DrawFourTileStripForA copies them to vBGMap0 + $27 (row 1, columns 7-10) when wDebugSubState is 7,
; drawn by DrawSlotStatusBitsDebug above the nine status byte rows of that slot. (C1, E-0381)
DrawFourTileStripForA_Data_Entry07::
    db $f8, $f9, $e3, $c3

; Draws the skill data of the debug effect viewer for the skill number in wDebugValue0:
; DrawSkillRecordFirstByteDigits, DrawSkillDebugDigitsAndRecord_DrawRecordWords, then far-calls
; DrawSkillDebugPage. Called by RunDebugState_E0_Input (when Select opens the effect viewer) and by
; DrawHexByteAtBGMap8A. (C1, E-0385)
; DrawSkillRecordFirstByteDigits, DrawSkillDebugDigitsAndRecord_DrawRecordWords, then far-calls
; DrawSkillDebugPage (E-0122) (E-0345: draws the skill's debug digits, loads the skill record and
; far-calls the battle-argument writer; was DrawSkillDebugDigitsAndRecord)
DrawSkillDebugDigitsAndRecord::
    call DrawSkillRecordFirstByteDigits
    call DrawSkillDebugDigitsAndRecord_DrawRecordWords
    farcall DrawSkillDebugPage
    ret

SECTION "Bank E0 DrawSkillRecordFirstByteDigits", ROMX

; Loads the first byte of the record of skill wDebugValue0 into wRecordBufferData
; (LoadSkillRecordPart) and draws it as three decimal digit tiles ($E0 + digit, HLToDecimalDigits)
; at vBGMap0 + $204 to + $206. Called by DrawSkillDebugDigitsAndRecord. (C1, E-0385)
; loads skill wDebugValue0's first record byte (LoadSkillRecordPart) and writes it as three digit
; tiles at vBGMap0 + $204 (E-0121) (E-0345: was DrawSkillRecordFirstByteDigits)
DrawSkillRecordFirstByteDigits::
    ld a, $00
    ld [wBattleArg0], a
    ld a, [wDebugValue0]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits]
    add $e0
    ld hl, vBGMap0 + $204
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add $e0
    ld hl, vBGMap0 + $205
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add $e0
    ld hl, vBGMap0 + $206
    call WriteVRAMByte
    ret

SECTION "Bank E0 DrawSkillDebugDigitsAndRecord_DrawRecordWords", ROMX

; Loads the record of skill wDebugValue0 (LoadSkillRecord into wRecordBufferData) and draws four
; three-digit numbers (HLToDecimalDigits, tiles $E0 + digit): the word at record bytes 9-10 at
; vBGMap0 + $1C3, that word plus byte 11 at + $1E3, the word at bytes 13-14 at + $1C7, and that word
; plus byte 15 at + $1E7. What these record fields mean is not read here. (C1, E-0371)
DrawSkillDebugDigitsAndRecord_DrawRecordWords::
    ld a, [wDebugValue0]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    push hl
    call HLToDecimalDigits
    ld a, [wDigits]
    add $e0
    ld hl, vBGMap0 + $1c3
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add $e0
    ld hl, vBGMap0 + $1c4
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add $e0
    ld hl, vBGMap0 + $1c5
    call WriteVRAMByte
    pop hl
    ld a, [wRecordBufferData + $b]
    ld c, a
    ld b, $00
    add hl, bc
    call HLToDecimalDigits
    ld a, [wDigits]
    add $e0
    ld hl, vBGMap0 + $1e3
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add $e0
    ld hl, vBGMap0 + $1e4
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add $e0
    ld hl, vBGMap0 + $1e5
    call WriteVRAMByte
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    push hl
    call HLToDecimalDigits
    ld a, [wDigits]
    add $e0
    ld hl, vBGMap0 + $1c7
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add $e0
    ld hl, vBGMap0 + $1c8
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add $e0
    ld hl, vBGMap0 + $1c9
    call WriteVRAMByte
    pop hl
    ld a, [wRecordBufferData + $f]
    ld c, a
    ld b, $00
    add hl, bc
    call HLToDecimalDigits
    ld a, [wDigits]
    add $e0
    ld hl, vBGMap0 + $1e7
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add $e0
    ld hl, vBGMap0 + $1e8
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add $e0
    ld hl, vBGMap0 + $1e9
    call WriteVRAMByte
    ret

SECTION "Bank E0 DrawFullScreenFromBankE0", ROMX

; Copies the 20 x 18 tile map DrawFullScreenFromBankE0_TileRect from bank $E0 to vBGMap0
; (CopyRectFromBankToVRAM). Called once, by RunDebugState_E0_ShowHeading. (C1, E-0385)
; copies a 20 x 18 tile map from E0:$511B to vBGMap0 (CopyRectFromBankToVRAM) (E-0116) (E-0344: the
; address in its name dropped or read as the label there; was DrawFullScreenFromBankE0)
DrawFullScreenFromBankE0::
    ld hl, vBGMap0
    ld de, DrawFullScreenFromBankE0_TileRect
    lb bc, $14, $12
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

SECTION "Bank E0 RunDebugState_E0_Input_DrawEffectViewerScreen", ROMX

; Copies the 20 x 18 tile map EffectViewerScreenTileRect from bank $E0 to vBGMap0. Called once, by
; RunDebugState_E0_Input right after it sets wDebugState to $0A (the effect viewer), so this is the
; effect viewer screen. (C1, E-0385)
; copies a 20 x 18 tile map from E0:$5283 to vBGMap0 (E-0116) (E-0344: the address in its name
; dropped or read as the label there; was RunDebugState_E0_Input_DrawEffectViewerScreen)
RunDebugState_E0_Input_DrawEffectViewerScreen::
    ld hl, vBGMap0
    ld de, EffectViewerScreenTileRect
    lb bc, $14, $12
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

SECTION "Bank E0 RunDebugState_E0_DrawStatusBitsScreen", ROMX

; Copies the 20 x 18 tile map that follows it in bank $E0 to vBGMap0 (CopyRectFromBankToVRAM). Its
; only caller is the effect viewer's Select branch, which has just switched to state $0B
; (RunDebugState_E0_EditStatusBits) and draws the status bits next, so this is that screen's layout.
; (C1, E-0371)
RunDebugState_E0_DrawStatusBitsScreen::
    ld hl, vBGMap0
    ld de, RunDebugState_E0_DrawStatusBitsScreen_TileRect
    lb bc, $14, $12
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

SECTION "Bank E0 DrawFullScreenFromBankE0_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
DrawFullScreenFromBankE0_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $f5, $f6, $f7, $c3, $c3, $c3, $f8, $f9, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $ea, $c3, $c3, $c3, $c3, $c3, $ea, $c3, $c3, $c3, $c3, $c3, $ea, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $ed, $ff, $c3, $c3, $c3, $c3, $ed, $ff, $c3, $c3, $c3, $c3, $ed, $ff, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $ee, $00, $c3, $c3, $c3, $c3, $ee, $00, $c3, $c3, $c3, $c3, $ee, $00, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $ef, $01, $c3, $c3, $c3, $c3, $ef, $01, $c3, $c3, $c3, $c3, $ef, $01, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b6, $f0, $02, $c3, $c3, $c3, $c3, $f0, $02, $c3, $c3, $c3, $c3, $f0, $02, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $f2, $04, $c3, $c3, $c3, $c3, $f2, $04, $c3, $c3, $c3, $c3, $f2, $04, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $f4, $06, $c3, $c3, $c3, $c3, $f4, $06, $c3, $c3, $c3, $c3, $f4, $06, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $f3, $05, $c3, $c3, $c3, $c3, $f3, $05, $c3, $c3, $c3, $c3, $f3, $05, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $b6, $f1, $03, $c3, $c3, $c3, $c3, $f1, $03, $c3, $c3, $c3, $c3, $f1, $03, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $f1, $07, $c3, $c3, $c3, $c3, $f1, $07, $c3, $c3, $c3, $c3, $f1, $07, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $b6, $c3, $c3, $c3, $c3, $fa, $fb, $fc, $fd, $fe, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

EffectViewerScreenTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $0e, $09, $0f, $c3, $0c, $0d, $0d, $0c, $0a, $ff, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $14, $15, $16, $17, $18, $19, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $1a, $1b, $1c, $1d, $1e, $1f, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $20, $21, $22, $23, $24, $25, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $26, $27, $28, $29, $2a, $2b, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $2c, $2d, $2e, $2f, $30, $31, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $32, $33, $34, $35, $36, $37, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $0b, $c3, $f5, $f6, $f7, $c3, $f8, $f9, $c3, $c3, $ec, $c3, $f5, $f6, $f7, $c3, $f8, $f9, $b7 ; id 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e1, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e2, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $b6, $ec, $01, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

RunDebugState_E0_DrawStatusBitsScreen_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $09, $f0, $ff, $c3, $e0, $e1, $e2, $e3, $e4, $e5, $e6, $e7, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $09, $ff, $e0, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $09, $ff, $e1, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $09, $ff, $e2, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $09, $ff, $e3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $09, $ff, $e4, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $09, $ff, $e5, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b6, $c3, $09, $ff, $e6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $09, $ff, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 11
    db $b6, $c3, $09, $ff, $e8, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 15
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 17

; HL = tile destination, DE = window size: saves the four string window bytes (wTextWindowTileLo to
; wTextWindowWidth), sets the window to HL and DE, far-calls ShowString_Bank09, then restores the
; saved window. Called by RunDebugState_E0_ShowHeading. (C1, E-0385)
; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes
; appear in 3 banks)
ShowStringBank09AtTilesHL_BankE0::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

SECTION "Bank E0 RunDebugState_E0_PlayEffectSound", ROMX

; Plays the sound of effect wDebugSubState (DebugSoundEffectList). (C2, E-0357; probed E-0385)
RunDebugState_E0_PlayEffectSound::
    ld a, [wDebugSubState]
    ld hl, DebugSoundEffectList
    add_a_to_hl
    ld a, [hl]
    call QueueSoundEffect
    ret

SECTION "Bank E0 RunEffectTestEntryA", ROMX

; A = entry number: loads wBattleActor, wBattleTarget, wBattleActionId and wEffectFlags2 from the
; four bytes of EffectTestEntries + 4 * A, then far-calls SelectEffectByEffectFlags2Flags, which
; queues the sound of the action (50 of the 51 entries carry flags $40 and take the sound of
; ActionSoundTable_Flag6 for the action and the side of the actor; entry 44 carries $04, which makes
; the target the actor and uses ActionSoundTable_Flag2). Nothing in src/ calls it. (C2, E-0385)
; loads wBattleActor, wBattleTarget, wBattleActionId and wEffectFlags2 from the 4-byte entry A of
; the table at $55FB, then far-calls SelectEffectByEffectFlags2Flags (a test or debug entry list)
; (E-0118)
RunEffectTestEntryA:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    add a
    add a
    ld hl, EffectTestEntries
    add_a_to_hl
    ld a, [hli]
    ld [wBattleActor], a
    ld a, [hli]
    ld [wBattleTarget], a
    ld a, [hli]
    ld [wBattleActionId], a
    ld a, [hl]
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ret

SECTION "Bank E0 DebugSoundEffectList", ROMX

; RunDebugState_E0_PlayEffectSound (debug menu) plays QueueSoundEffect with the byte at $55BF +
; wDebugSubState; 60 bytes end at EffectTestEntries (E-0213, C1)
; record: sound effect number
DebugSoundEffectList::
    db $89 ; id 0
    db $8b ; id 1
    db $8b ; id 2
    db $8d ; id 3
    db $8d ; id 4
    db $8f ; id 5
    db $90 ; id 6
    db $d9 ; id 7
    db $91 ; id 8
    db $93 ; id 9
    db $93 ; id 10
    db $94 ; id 11
    db $95 ; id 12
    db $95 ; id 13
    db $96 ; id 14
    db $97 ; id 15
    db $97 ; id 16
    db $98 ; id 17
    db $87 ; id 18
    db $86 ; id 19
    db $85 ; id 20
    db $88 ; id 21
    db $88 ; id 22
    db $99 ; id 23
    db $9a ; id 24
    db $9b ; id 25
    db $9d ; id 26
    db $9e ; id 27
    db $9f ; id 28
    db $99 ; id 29
    db $a2 ; id 30
    db $a3 ; id 31
    db $a4 ; id 32
    db $a5 ; id 33
    db $a7 ; id 34
    db $a8 ; id 35
    db $da ; id 36
    db $99 ; id 37
    db $a9 ; id 38
    db $aa ; id 39
    db $ab ; id 40
    db $ac ; id 41
    db $ae ; id 42
    db $b0 ; id 43
    db $85 ; id 44
    db $b2 ; id 45
    db $b4 ; id 46
    db $b8 ; id 47
    db $b6 ; id 48
    db $dc ; id 49
    db $ba ; id 50
    db $bc ; id 51
    db $bd ; id 52
    db $bf ; id 53
    db $c1 ; id 54
    db $c3 ; id 55
    db $c5 ; id 56
    db $c7 ; id 57
    db $c9 ; id 58
    db $cb ; id 59

; RunEffectTestEntryA loads the 4-byte entry at $55FB + 4 * A into wBattleActor, wBattleTarget,
; wBattleActionId and wEffectFlags2, then far-calls SelectEffectByEffectFlags2Flags; 51 entries end
; at the code at $56C7 (E-0213, C1)
; record: wBattleActor, wBattleTarget, wBattleActionId, wEffectFlags2
EffectTestEntries::
    db $00, $04, $01, $40 ; id 0
    db $00, $04, $02, $40 ; id 1
    db $00, $04, $03, $40 ; id 2
    db $00, $04, $04, $40 ; id 3
    db $00, $04, $05, $40 ; id 4
    db $00, $04, $06, $40 ; id 5
    db $00, $04, $07, $40 ; id 6
    db $00, $04, $08, $40 ; id 7
    db $00, $04, $09, $40 ; id 8
    db $00, $04, $0a, $40 ; id 9
    db $00, $04, $0b, $40 ; id 10
    db $00, $04, $0c, $40 ; id 11
    db $00, $04, $10, $40 ; id 12
    db $00, $04, $11, $40 ; id 13
    db $00, $04, $12, $40 ; id 14
    db $00, $04, $0d, $40 ; id 15
    db $00, $04, $0e, $40 ; id 16
    db $00, $04, $0f, $40 ; id 17
    db $00, $04, $27, $40 ; id 18
    db $04, $04, $25, $40 ; id 19
    db $04, $04, $16, $40 ; id 20
    db $00, $04, $2f, $40 ; id 21
    db $00, $04, $34, $40 ; id 22
    db $00, $04, $2e, $40 ; id 23
    db $04, $04, $3b, $40 ; id 24
    db $04, $04, $39, $40 ; id 25
    db $00, $04, $47, $40 ; id 26
    db $00, $04, $4b, $40 ; id 27
    db $00, $04, $43, $40 ; id 28
    db $00, $04, $62, $40 ; id 29
    db $00, $04, $50, $40 ; id 30
    db $00, $04, $52, $40 ; id 31
    db $00, $04, $51, $40 ; id 32
    db $00, $04, $53, $40 ; id 33
    db $00, $04, $54, $40 ; id 34
    db $00, $04, $57, $40 ; id 35
    db $00, $04, $5a, $40 ; id 36
    db $00, $04, $5c, $40 ; id 37
    db $00, $04, $67, $40 ; id 38
    db $00, $04, $66, $40 ; id 39
    db $00, $04, $3f, $40 ; id 40
    db $00, $04, $3e, $40 ; id 41
    db $00, $04, $3d, $40 ; id 42
    db $00, $04, $83, $40 ; id 43
    db $10, $04, $ff, $04 ; id 44
    db $00, $04, $4c, $40 ; id 45
    db $00, $04, $4d, $40 ; id 46
    db $00, $04, $5d, $40 ; id 47
    db $00, $04, $91, $40 ; id 48
    db $04, $04, $9b, $40 ; id 49
    db $04, $04, $a1, $40 ; id 50

; Clears the actor's action choice and runs the AI's choice for it (AIChooseActionResolveStep,
; ChooseTargetIfUnset); in a link session the random seeds are saved and restored around it. (C1,
; E-0357)
RunDebugState_E0_RunAIChoice::
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hl], a
    ld a, [wLinkMode]
    or a
    jr z, .call_ai_choose_action_resolve_step
    ld a, [wRandomSeed2Lo]
    ld l, a
    ld a, [wRandomSeed2Hi]
    ld h, a
    push hl
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    push hl
    farcall AIChooseActionResolveStep
    call ChooseTargetIfUnset
    pop hl
    ld a, l
    ld [wRandomLo], a
    ld a, h
    ld [wRandomHi], a
    pop hl
    ld a, l
    ld [wRandomSeed2Lo], a
    ld a, h
    ld [wRandomSeed2Hi], a
    ret

.call_ai_choose_action_resolve_step:
    farcall AIChooseActionResolveStep
    call ChooseTargetIfUnset
    ret

SECTION "Bank E0 ChooseTargetIfUnset", ROMX

; If the target byte of the actor (wBattleTargetChoice + 2 * wBattleActor) is $FF, meaning no target
; yet, far-calls ChooseActionTarget; otherwise does nothing. Called twice by
; RunDebugState_E0_RunAIChoice. (C1, E-0385)
; when the actor's wBattleTargetChoice entry is $FF (no target yet), far-calls ChooseActionTarget
; (E-0112)
ChooseTargetIfUnset::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr nz, .return
    farcall ChooseActionTarget

.return:
    ret

SECTION "Bank E0 RunDebugState_E0_ChooseActionTargets_DrawDetails", ROMX

; Far-called by RunDebugState_E0_ChooseActionTargets_ShowActor: draws the actor's 4 name tiles at
; vBGMap0 + $23 (word table after it, indexed by DisplayedSlotOfActor); unless the actor is slot 3
; or 7, its tactic name (string wSlotTactic & 3 + 2 of category $0E); its wSlotAIMode as tile $8D +
; mode; its personality name (category 7, PersonalityIndexOfSlot_BankE0); for a foe outside link
; battles three digits from its wEncounterMonsters word, else three blanks; 8 rows of its skill
; bytes from wBattleSkillsPrefix + 16 * actor; the ten wAIWeights words in decimal (shown as 9999
; above that, or raw hex when both bytes are $FF); its chosen action's name (category 4, or string 1
; of category $0E for none) and number; the target's 4 name tiles (DisplayedTargetChoiceOfActor);
; and the three wAIChoiceOrder entries. (C1, E-0371)
RunDebugState_E0_ChooseActionTargets_DrawDetails::
    call DisplayedSlotOfActor
    ld hl, DebugSlotLabels
    call ReadWordTableEntry_Bank00
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $23
    ld b, $04

.loop:
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, .loop
    ld hl, vTiles1 + $1b0
    ld de, $0801
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wBattleActor]
    and $03
    cp $03
    jr z, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and $03
    add $02
    ld [wStringIndex], a
    ld a, $0e
    ld [wStringCategory], a
    ld hl, vTiles1 + $1b0
    ld de, $0801
    call ShowStringBank08AtTilesHLThenDefault_BankE0_2

.read_battle_actor:
    ld a, [wBattleActor]
    ld de, wSlotAIMode
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add $8d
    ld hl, vBGMap0 + $46
    di
    call WriteVRAMByte
    ei
    ld hl, vTiles1 + $6d0
    ld de, $0701
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_BankE0
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, vTiles1 + $6d0
    ld de, $0701
    call ShowStringBank08AtTilesHLThenDefault_BankE0_2
    ld a, [wLinkMode]
    cp $01
    ld a, [wBattleActor]
    jr z, .skip2
    sub $04
    jr nc, .skip3

.skip2:
    ld a, $c3
    ld hl, vBGMap0 + $1af
    di
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByte
    ei
    jr .read_battle_actor2

.skip3:
    ld de, wEncounterMonsters + $1
    add a
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld hl, vBGMap0 + $1af
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    dec de
    ld a, [de]
    and $f0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei

.read_battle_actor2:
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $a2
    ld b, $08

.loop2:
    push hl
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    inc hl
    inc de
    ld a, [de]
    and $f0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    pop hl
    push de
    ld de, $0020
    add hl, de
    pop de
    inc de
    dec b
    jr nz, .loop2
    ld de, wAIWeights
    ld hl, vBGMap0 + $a8
    ld b, $0a

.loop3:
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    and c
    cp $ff
    jr nz, .skip5
    ld a, [de]
    and $f0
    swap a
    push hl
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    dec de
    ld a, [de]
    and $f0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    pop hl
    inc de
    jr .next

.skip5:
    push hl
    push de
    push bc
    ld a, c
    ld [wDigits], a
    ld a, [de]
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop bc
    pop de
    pop hl
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp2]
    or c
    jr z, .skip6
    ld a, $99
    ldh [hTemp1], a
    ldh [hTemp0], a

.skip6:
    push bc
    push hl
    ld c, $00
    call WriteHexDigitTilesOfTemp1Temp0
    pop hl
    pop bc

.next:
    inc de
    push de
    ld de, $0020
    add hl, de
    pop de
    dec b
    jr nz, .loop3
    ld a, $04
    ld [wStringCategory], a
    ld a, [wBattleActor]
    add a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    or a
    jr nz, .call_show_string_bank08_at_tiles_hl_then
    ld a, $0e
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a

.call_show_string_bank08_at_tiles_hl_then:
    ld hl, vTiles1 + $120
    ld de, $0901
    call ShowStringBank08AtTilesHLThenDefault_BankE0_2
    ld a, [wBattleActor]
    add a
    ld de, wBattleActionChoice
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    ld hl, vBGMap0 + $202
    and $f0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    call DisplayedTargetChoiceOfActor
    ld hl, DebugSlotLabels
    call ReadWordTableEntry_Bank00
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $20f
    ld b, $04

.loop4:
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, .loop4
    ld b, $03
    ld c, $01
    ld hl, wAIChoiceOrder

.loop5:
    push bc
    push hl
    ld b, $03

.loop6:
    ld a, [hli]
    cp c
    jr nz, .next2
    ld de, -4
    add hl, de
    ld a, [hl]
    ld [wDigits], a
    xor a
    ld [wDigits + $1], a
    ld [wDigits + $2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    swap c
    ld b, $00
    ld hl, vBGMap0 + $8f
    add hl, bc
    add hl, bc
    push bc
    push hl
    ld c, $00
    call WriteLowHexDigitTilesOfTemp1Temp0
    pop hl
    pop bc
    jr .restore

.next2:
    dec b
    jr nz, .loop6

.restore:
    pop hl
    pop bc
    inc c
    dec b
    jr nz, .loop5
    ld hl, vBGMap0 + $131
    ld de, wAIChoiceOrder
    ld b, $03

.loop7:
    ld a, [de]
    and $0f
    inc a
    di
    call WriteVRAMByte
    ei
    push de
    ld de, $0020
    add hl, de
    pop de
    inc de
    dec b
    jr nz, .loop7
    ret

SECTION "Bank E0 DisplayedSlotOfActor", ROMX

; A = wBattleActor with bit 2 flipped when wLinkMode is 1 and bit 1 of wLinkRole is set (the two
; sides swap for that player); HL ends as wLinkRole. Called by
; RunDebugState_E0_ChooseActionTargets_DrawDetails to pick the label of the actor. (C2, E-0385)
; A = wBattleActor, with bit 2 flipped when wLinkMode = 1 and wLinkRole bit 1 is set (the side swap
; of the battle panels) (E-0118)
DisplayedSlotOfActor::
    ld a, [wLinkMode]
    ld hl, wLinkRole
    cp $01
    ld a, [wBattleActor]
    ret nz
    bit 1, [hl]
    ret z
    xor $04
    ret

SECTION "Bank E0 DisplayedTargetChoiceOfActor", ROMX

; A = the target choice byte wBattleTargetChoice[2 * wBattleActor], with bit 2 flipped under the
; same link condition as DisplayedSlotOfActor (wLinkMode 1 and wLinkRole bit 1), even when the byte
; is $FF; DE = its address, HL = wLinkRole. Called by
; RunDebugState_E0_ChooseActionTargets_DrawDetails to show the target of the actor. (C2, E-0385)
; A = wBattleTargetChoice[wBattleActor * 2]; in link mode 1 with wLinkRole bit 1 set, flips bit 2
; (the side) so the choice is shown from this player's side
DisplayedTargetChoiceOfActor::
    ld a, [wBattleActor]
    add a
    ld de, wBattleTargetChoice
    add e
    ld e, a
    jr nc, .read_link_mode
    inc d

.read_link_mode:
    ld a, [wLinkMode]
    ld hl, wLinkRole
    cp $01
    ld a, [de]
    ret nz
    bit 1, [hl]
    ret z
    xor $04
    ret

SECTION "Bank E0 WriteHexDigitTilesOfTemp1Temp0", ROMX

; HL = VRAM position, C = 0: draws the four hex digits of the 16-bit number hTemp1:hTemp0 as tiles
; (WriteVRAMByteInc), each nibble n as tile n + 1 (the tiles from the string '0123456789ABCDEF'),
; but a leading zero becomes the blank tile $C3 (C collects the nibbles so far); falls into
; WriteLowHexDigitTilesOfTemp1Temp0 after the first digit. The last digit is always drawn. Called by
; RunDebugState_E0_ChooseActionTargets_DrawDetails. (C1, E-0385)
; writes hTemp1's high nibble as a tile (nibble + 1, or $C3 while every digit so far is zero; C
; tracks that), then falls into WriteLowHexDigitTilesOfTemp1Temp0 for the remaining nibbles
WriteHexDigitTilesOfTemp1Temp0::
    ldh a, [hTemp1]
    and $f0
    swap a
    ld b, a
    or c
    ld c, a
    ld a, b
    jr nz, .call_write_vram_byte_inc
    ld a, $c2

.call_write_vram_byte_inc:
    inc a
    di
    call WriteVRAMByteInc
    ei

; The rest of WriteHexDigitTilesOfTemp1Temp0: draws the low nibble of hTemp1 and both nibbles of
; hTemp0 as tiles n + 1, with leading zeros (while C is still 0) as the blank tile $C3 and the last
; digit always drawn. Also called on its own by RunDebugState_E0_ChooseActionTargets_DrawDetails.
; (C1, E-0385)
; the second half of WriteHexDigitTilesOfTemp1Temp0: hTemp1's low nibble and hTemp0's nibbles as
; digit tiles
WriteLowHexDigitTilesOfTemp1Temp0::
    ldh a, [hTemp1]
    and $0f
    ld b, a
    or c
    ld c, a
    ld a, b
    jr nz, .call_write_vram_byte_inc
    ld a, $c2

.call_write_vram_byte_inc:
    inc a
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and $f0
    swap a
    ld b, a
    or c
    ld c, a
    ld a, b
    jr nz, .call_write_vram_byte_inc2
    ld a, $c2

.call_write_vram_byte_inc2:
    inc a
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and $0f
    inc a
    di
    call WriteVRAMByteInc
    ei
    ret

SECTION "Bank E0 DebugSlotLabels", ROMX

; Eight words, one per displayed battle slot 0-7, pointing at the 4-tile labels DebugSlotLabel_Slot0
; to DebugSlotLabel_Slot7: slots 0-3 are tiles $80 $81 $82 and then $01-$04, slots 4-7 tiles $83
; $84, then $01-$04 and the blank $C3. RunDebugState_E0_ChooseActionTargets_DrawDetails reads entry
; DisplayedSlotOfActor and writes its four tiles at vBGMap0 + $23 (row 1, column 3), and entry
; DisplayedTargetChoiceOfActor at vBGMap0 + $20F (row 16, column 15), with
; ReadWordTableEntry_Bank00. Tiles $80-$84 come from category $0E string 0 drawn at vTiles1 and
; $01-$04 from category 0 string 0 ('0123456789ABCDEF') drawn at vTiles2 + $10 by
; RunDebugState_E0_ChooseActionTargets_Start. (C1, E-0373)
DebugSlotLabels::
    dw DebugSlotLabel_Slot0
    dw DebugSlotLabel_Slot1
    dw DebugSlotLabel_Slot2
    dw DebugSlotLabel_Slot3
    dw DebugSlotLabel_Slot4
    dw DebugSlotLabel_Slot5
    dw DebugSlotLabel_Slot6
    dw DebugSlotLabel_Slot7

; Four tile ids, $80 $81 $82 $01: the label of displayed battle slot 0, entry 0 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot0::
    db $80, $81, $82, $01

; Four tile ids, $80 $81 $82 $02: the label of displayed battle slot 1, entry 1 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot1::
    db $80, $81, $82, $02

; Four tile ids, $80 $81 $82 $03: the label of displayed battle slot 2, entry 2 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot2::
    db $80, $81, $82, $03

; Four tile ids, $80 $81 $82 $04: the label of displayed battle slot 3, entry 3 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot3::
    db $80, $81, $82, $04

; Four tile ids, $83 $84 $01 $C3: the label of displayed battle slot 4, entry 4 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot4::
    db $83, $84, $01, $c3

; Four tile ids, $83 $84 $02 $C3: the label of displayed battle slot 5, entry 5 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot5::
    db $83, $84, $02, $c3

; Four tile ids, $83 $84 $03 $C3: the label of displayed battle slot 6, entry 6 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot6::
    db $83, $84, $03, $c3

; Four tile ids, $83 $84 $04 $C3: the label of displayed battle slot 7, entry 7 of DebugSlotLabels,
; written to vBGMap0 by RunDebugState_E0_ChooseActionTargets_DrawDetails for the actor (row 1,
; column 3) or its target choice (row 16, column 15). (C1, E-0373)
DebugSlotLabel_Slot7::
    db $83, $84, $04, $c3

; Runs the AI's full choice for the actor (AIChooseActionForActor, ChooseActionTarget), keeping the
; random seeds in a link session. (C1, E-0357)
RunDebugState_E0_ChooseActionTargets_RunFullAI::
    ld a, [wLinkMode]
    or a
    jr z, .call_ai_choose_action_for_actor
    ld a, [wRandomSeed2Lo]
    ld l, a
    ld a, [wRandomSeed2Hi]
    ld h, a
    push hl
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    push hl
    farcall AIChooseActionForActor
    farcall ChooseActionTarget
    pop hl
    ld a, l
    ld [wRandomLo], a
    ld a, h
    ld [wRandomHi], a
    pop hl
    ld a, l
    ld [wRandomSeed2Lo], a
    ld a, h
    ld [wRandomSeed2Hi], a
    ret

.call_ai_choose_action_for_actor:
    farcall AIChooseActionForActor
    farcall ChooseActionTarget
    ret

SECTION "Bank E0 ShowStringBank08AtTilesHLThenDefault_BankE0_2", ROMX

; A second copy in this bank of ShowStringBank08AtTilesHLThenDefault_BankE0: HL = tile destination,
; DE = window size, far-calls ShowString_Bank08, then the window goes back to vTiles1 with $1202.
; Called three times by RunDebugState_E0_ChooseActionTargets_DrawDetails. (C1, E-0385)
; sets the string window to HL (tile destination) and DE (size), far-calls ShowString_Bank08, then
; sets the window to vTiles1 with size word $1202 (E-0067) (the same 45 bytes appear in 2 banks)
ShowStringBank08AtTilesHLThenDefault_BankE0_2::
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

SECTION "Bank E0 ShowStringBank09AtHLSizeDEThenDefault_BankE0", ROMX

; A second copy in this bank of ShowStringBank09AtHLSizeDEThenDefault: HL = tile destination, DE =
; window size, far-calls ShowString_Bank09, then the window goes back to vTiles1 with $1202. Nothing
; in src calls this copy. (C1, E-0385)
; the same 45 bytes as ShowStringBank09AtHLSizeDEThenDefault (ShowStringBank09AtHLSizeDEThenDefault)
; (E-0121)
ShowStringBank09AtHLSizeDEThenDefault_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

SECTION "Bank E0 DebugStaffRoll_Update_RunScene", ROMX

; The debug staff roll's update, far-called by DebugStaffRoll_Update: while wWorkBuf is 0 it runs
; DebugStaffRoll_Credits instead; otherwise it runs the field event (RunFieldEventFieldEventKind),
; steps the sprite slot counters (IncrementSpriteSlotCounters) and dispatches on wWorkBuf + 2 (1-5)
; to DebugStaffRoll_Scene00 through DebugStaffRoll_Scene04. (C1, E-0371)
DebugStaffRoll_Update_RunScene::
    ld a, [wWorkBuf]
    or a
    jp z, DebugStaffRoll_Credits
    farcall RunFieldEventFieldEventKind
    call IncrementSpriteSlotCounters
    ld a, [wWorkBuf + $2]
    dec a
    jumptable
    dw DebugStaffRoll_Scene00
    dw DebugStaffRoll_Scene01
    dw DebugStaffRoll_Scene02
    dw DebugStaffRoll_Scene03
    dw DebugStaffRoll_Scene04

; Staff roll scene 0 on map 0 (entry 0 of the table in DebugStaffRoll_Update_RunScene, picked by
; wWorkBuf + 2 - 1). Jumps through a table of 16 steps by wWorkBuf + 1, from step 0
; DebugStaffRoll_Scene00_Load to step 15 DebugStaffRoll_Scene00_WalkOff. The last step fades out and
; clears wWorkBuf and wWorkBuf + 1, which hands control back to DebugStaffRoll_Credits. (C1, E-0385)
; by wWorkBuf+1: decompresses the scene's graphics, then one DrawSpriteSlots step per frame step
DebugStaffRoll_Scene00::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene00_Load
    dw DebugStaffRoll_Scene00_WalkSprite3
    dw DebugStaffRoll_Scene00_WalkSprite3Down
    dw DebugStaffRoll_Scene00_WalkSprite3Back
    dw DebugStaffRoll_Scene00_WalkSprite0
    dw DebugStaffRoll_Scene00_WalkSprite3Left
    dw DebugStaffRoll_Scene00_WalkSprite2
    dw DebugStaffRoll_Scene00_WalkPair
    dw DebugStaffRoll_Scene00_WalkPairRight
    dw DebugStaffRoll_Scene00_WalkPairQuick
    dw DebugStaffRoll_Scene00_WalkSprite1
    dw DebugStaffRoll_Scene00_WalkPairUp
    dw DebugStaffRoll_Scene00_WalkSprites01
    dw DebugStaffRoll_Scene00_WalkSprites01Again
    dw DebugStaffRoll_Scene00_WaitAndTurn
    dw DebugStaffRoll_Scene00_WalkOff

; Staff roll scene 0, step 0: loads the field sprites, the area tileset, map 0's screen (and on the
; GBC its attributes and palettes) and places four sprites. (C1, E-0357)
DebugStaffRoll_Scene00_Load::
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx01)
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, BANK(FacetedGrayLumpSpriteTiles)
    ld de, FacetedGrayLumpSpriteTiles
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, BANK(AreaTileset0)
    ld de, AreaTileset0
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, BANK(Map00Screens0_Y2X1)
    ld de, Map00Screens0_Y2X1
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, BANK(Map00Attrs0_Y2X1)
    ld de, Map00Attrs0_Y2X1
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, BANK(AreaPalettes0)
    ld de, AreaPalettes0
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, BANK(DebugStaffRoll_Scene00_Load_OBJPaletteBufferData)
    ld de, DebugStaffRoll_Scene00_Load_OBJPaletteBufferData
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus8Data)
    ld de, OBJPaletteBufferPlus8Data
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data_2)
    ld de, OBJPaletteBufferPlus10Data_2
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus18Data_2)
    ld de, OBJPaletteBufferPlus18Data_2
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, $03
    ld [wSpriteSlotCount], a
    ld a, $01
    ld [wFieldEventKind], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $60
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $0a
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $a0
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $20
    ld [hli], a
    ld a, $00
    ld [hli], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite3", ROMX

; Staff roll scene 0, step 1: after the fade, sprite 3 walks to ($60, $50) and turns; then a
; 15-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprite3::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, $03
    lb de, $60, $50
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite3Down", ROMX

; Staff roll scene 0, step 2: sprite 3 walks every other frame to ($60, $60), then a wait. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprite3Down::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $a]
    inc a
    ld [wWorkBuf + $a], a
    and $01
    ret nz
    ld a, $03
    lb de, $60, $60
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $a], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite3Back", ROMX

; Staff roll scene 0, step 3: sprite 3 walks two steps a frame to ($60, $50). (C2, E-0357; probed
; E-0385)
DebugStaffRoll_Scene00_WalkSprite3Back::
    call DrawSpriteSlots
    ld a, $03
    lb de, $60, $50
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite0", ROMX

; Staff roll scene 0, step 4: sprite 0 walks four steps a frame to ($60, $20), then a wait. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprite0::
    call DrawSpriteSlots
    ld a, $00
    lb de, $60, $20
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite3Left", ROMX

; Staff roll scene 0, step 5: sprite 3 walks to ($60, $40) and turns; then a wait. (C2, E-0357;
; probed E-0385)
DebugStaffRoll_Scene00_WalkSprite3Left::
    call DrawSpriteSlots
    ld a, $03
    lb de, $60, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite2", ROMX

; Staff roll scene 0, step 6: sprite 2 walks to ($60, $30), then a wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprite2::
    call DrawSpriteSlots
    ld a, $02
    lb de, $60, $30
    call StepSpriteSlotTowardDE
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $a], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkPairQuick", ROMX

; Staff roll scene 0, step 9: sprites 2 and 3 walk two steps a frame to ($50, $30) and ($50, $40),
; and sprite 1 turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkPairQuick::
    call DrawSpriteSlots
    ld a, $02
    lb de, $50, $30
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $03
    lb de, $50, $40
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprite1", ROMX

; Staff roll scene 0, step 10: sprite 1 walks four steps a frame to ($10, $40), then a wait and two
; turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprite1::
    call DrawSpriteSlots
    ld a, $01
    lb de, $10, $40
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkPairUp", ROMX

; Staff roll scene 0, step 11: sprites 2 and 3 walk up to Y 0; then turns and a wait. (C2, E-0357;
; probed E-0385)
DebugStaffRoll_Scene00_WalkPairUp::
    call DrawSpriteSlots
    ld a, $02
    lb de, $50, $00
    call StepSpriteSlotToward
    ld a, $03
    lb de, $50, $00
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprites01", ROMX

; Staff roll scene 0, step 12: sprites 1 and 0 walk to ($40, $40) and ($60, $30); sprite 0 turns.
; (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprites01::
    call DrawSpriteSlots
    ld a, $01
    lb de, $40, $40
    call StepSpriteSlotToward
    ld a, $00
    lb de, $60, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkSprites01Again", ROMX

; Staff roll scene 0, step 13: sprites 0 and 1 walk to ($40, $30) and ($40, $40); turns and a wait.
; (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkSprites01Again::
    call DrawSpriteSlots
    ld a, $00
    lb de, $40, $30
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WaitAndTurn", ROMX

; Staff roll scene 0, step 14: a wait, then sprite 0 turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WaitAndTurn::
    call DrawSpriteSlots
    call StepWorkBuf5Mod15
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkOff", ROMX

; Staff roll scene 0, step 15: sprites 0 and 1 walk up to Y 0; then a wait, the field event ends,
; palette fade 4 and the next scene. (C1, E-0357)
DebugStaffRoll_Scene00_WalkOff::
    call DrawSpriteSlots
    ld a, $00
    lb de, $40, $00
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $00
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wFieldEventKind], a
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkPair", ROMX

; Staff roll scene 0, step 7: sprites 2 and 3 walk to ($50, $30) and ($50, $40), then a wait. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkPair::
    call DrawSpriteSlots
    ld a, $02
    lb de, $50, $30
    call StepSpriteSlotToward
    ld a, $03
    lb de, $50, $40
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene00_WalkPairRight", ROMX

; Staff roll scene 0, step 8: sprites 2 and 3 walk every other frame to ($60, $30) and ($60, $40),
; then a wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene00_WalkPairRight::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $a]
    inc a
    ld [wWorkBuf + $a], a
    and $01
    ret nz
    ld a, $02
    lb de, $60, $30
    call StepSpriteSlotToward
    ld a, $03
    lb de, $60, $40
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01", ROMX

; Staff roll scene 1 on map 2 (entry 1 of the table in DebugStaffRoll_Update_RunScene, picked by
; wWorkBuf + 2 - 1). Jumps through a table of 26 steps by wWorkBuf + 1, from step 0
; DebugStaffRoll_Scene01_Load to step 25 DebugStaffRoll_Scene01_PairLeaves. The last step fades out
; and clears wWorkBuf and wWorkBuf + 1, which hands control back to DebugStaffRoll_Credits. (C1,
; E-0385)
; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene01::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene01_Load
    dw DebugStaffRoll_Scene01_WalkSprites
    dw DebugStaffRoll_Scene01_TurnSprites
    dw DebugStaffRoll_Scene01_Wait
    dw DebugStaffRoll_Scene01_HopSprite2
    dw DebugStaffRoll_Scene01_WalkSprite2
    dw DebugStaffRoll_Scene01_HopTo50
    dw DebugStaffRoll_Scene01_HopTo40
    dw DebugStaffRoll_Scene01_HopBackTo50
    dw DebugStaffRoll_Scene01_HopTo60
    dw DebugStaffRoll_Scene01_HopTo50
    dw DebugStaffRoll_Scene01_HopTo40
    dw DebugStaffRoll_Scene01_HopBackTo50
    dw DebugStaffRoll_Scene01_HopTo60
    dw DebugStaffRoll_Scene01_HopTo50
    dw DebugStaffRoll_Scene01_HopTo40
    dw DebugStaffRoll_Scene01_HopBackTo50
    dw DebugStaffRoll_Scene01_HopTo60
    dw DebugStaffRoll_Scene01_HopTo50
    dw DebugStaffRoll_Scene01_HopTo40
    dw DebugStaffRoll_Scene01_TurnAndWalk
    dw DebugStaffRoll_Scene01_StepSprite2
    dw DebugStaffRoll_Scene01_HopSprite2Turn
    dw DebugStaffRoll_Scene01_HopTogether
    dw DebugStaffRoll_Scene01_Sprite2Leaves
    dw DebugStaffRoll_Scene01_PairLeaves

; Staff roll scene 1, step 0: loads the field sprites, map 2's tileset and screen (and on the GBC
; its attributes and palettes) and places the sprites. (C1, E-0357)
DebugStaffRoll_Scene01_Load::
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx01)
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, BANK(Map02Tileset)
    ld de, Map02Tileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, BANK(Map02Tileset)
    ld de, Map02Screens0_Y0X2
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, BANK(Map02Attrs0_Y0X2)
    ld de, Map02Attrs0_Y0X2
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, BANK(Map02Palettes)
    ld de, Map02Palettes
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, BANK(DebugStaffRoll_Scene00_Load_OBJPaletteBufferData)
    ld de, DebugStaffRoll_Scene00_Load_OBJPaletteBufferData
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus8Data)
    ld de, OBJPaletteBufferPlus8Data
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data_2)
    ld de, OBJPaletteBufferPlus10Data_2
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $01
    ld [wFieldEventKind], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $a0
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $b0
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $70
    ld [hli], a
    ld a, $60
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $20
    ld [hli], a
    ld a, $00
    ld [hli], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_WalkSprites", ROMX

; Staff roll scene 1, step 1: after the fade, sprites 0 and 1 walk to ($50, $30) and ($60, $30),
; then a wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_WalkSprites::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    lb de, $50, $30
    call StepSpriteSlotToward
    ld a, $01
    lb de, $60, $30
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_TurnSprites", ROMX

; Staff roll scene 1, step 2: sprites 0 and 1 turn by two frame tables for $9F frames, then face
; down. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_TurnSprites::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, DebugStaffRoll_Scene01_TurnSprites_Data1
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, DebugStaffRoll_Scene01_TurnSprites_Data2
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    cp $9f
    ret c
    xor a
    ld [wWorkBuf + $6], a
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_TurnSprites_Data1", ROMX

; Five facing codes for sprite slot 0: $03, $02, $03, $00, $03. DebugStaffRoll_Scene01_TurnSprites
; picks one by wWorkBuf + $6 >> 5 (0-4, a new entry every 32 frames until the counter reaches $9F)
; and stores it as byte 5 of slot 0, which DrawSpriteSlots turns into the meta-sprite sub-index
; (code 3 is drawn as code 1 with the horizontal flip bit added to hSpriteAttrXor). (C1, E-0381)
DebugStaffRoll_Scene01_TurnSprites_Data1::
    db $03, $02, $03, $00, $03

; Five facing codes for sprite slot 1: $01, $00, $01, $02, $01. DebugStaffRoll_Scene01_TurnSprites
; picks one by wWorkBuf + $6 >> 5 (0-4, every 32 frames) at the same time as the slot 0 code from
; DebugStaffRoll_Scene01_TurnSprites_Data1 and stores it as byte 5 of slot 1 (the facing code
; DrawSpriteSlots turns into a sub-index). (C1, E-0381)
DebugStaffRoll_Scene01_TurnSprites_Data2::
    db $01, $00, $01, $02, $01

; Staff roll scene 1, step 3: draws three sprite slots and waits. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_Wait::
    call DrawSpriteSlots
    ld a, $03
    ld [wSpriteSlotCount], a
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopSprite2", ROMX

; Staff roll scene 1, step 4: sprite 2 walks to X $60 with a hop (its Y plus
; DebugStaffRoll_HopYOffsets), then a wait and a turn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_HopSprite2::
    call DrawSpriteSlots
    ld d, $60
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    call StepWorkBuf5Mod15
    ret nz
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.read_work_buf:
    ld a, [wWorkBuf + $6]
    ld c, a
    ld b, $00
    inc a
    ld [wWorkBuf + $6], a
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

SECTION "Bank E0 DebugStaffRoll_HopYOffsets", ROMX

; Sixteen signed vertical steps for a hop, $FE x3, $FF x3, $00 x4, $01 x3, $02 x3 (-2, -1, 0, +1,
; +2: up then down, net zero). Many staff roll steps add entry [frame] to byte 3 of a sprite slot
; (the Y that DrawSpriteSlots hands to hSpriteOriginY), with the frame taken from wWorkBuf + $6,
; sometimes masked with $0F; the scene 1 hops of slot 2, the scene 2 hops and the scene 3 hops of
; other slots all share it. Two scene 2 steps (DebugStaffRoll_Scene02_WalkPairToPoint and
; DebugStaffRoll_Scene02_WalkPairToPoint2) also load the address of its ninth byte as an immediate,
; which gives D = $60, E = $40 as a target X and Y for StepSpriteSlotToward; the byte values there
; are not read. (C1, E-0381)
DebugStaffRoll_HopYOffsets::
    db $fe, $fe, $fe, $ff, $ff, $ff, $00, $00, $00, $00, $01, $01, $01, $02, $02, $02

; Staff roll scene 1, step 5: sprite 2 walks to ($60, $50), then a 30-frame wait. (C2, E-0357;
; probed E-0385)
DebugStaffRoll_Scene01_WalkSprite2::
    call DrawSpriteSlots
    ld a, $02
    lb de, $60, $50
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopSprite2Turn", ROMX

; Staff roll scene 1, step 22: sprite 2 turns and hops for $20 frames, then a wait. (C2, E-0357;
; probed E-0385)
DebugStaffRoll_Scene01_HopSprite2Turn::
    call DrawSpriteSlots
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    cp $20
    jr nc, .call_step_work_buf5_mod15
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_work_buf5_mod15:
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_TurnAndWalk", ROMX

; Staff roll scene 1, step 20: sprite 2 turns and walks to ($40, $30); then sprites 0-2 turn. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene01_TurnAndWalk::
    call DrawSpriteSlots
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    lb de, $40, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_StepSprite2", ROMX

; Staff roll scene 1, step 21: sprite 2 walks one step every four frames to ($30, $30). (C2, E-0357;
; probed E-0385)
DebugStaffRoll_Scene01_StepSprite2::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $02
    lb de, $30, $30
    call StepSpriteSlotToward
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_Sprite2Leaves", ROMX

; Staff roll scene 1, step 24: sprite 2 moves left two pixels a frame off the screen (to $F0),
; animating; then two slots, turns and a wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_Sprite2Leaves::
    call DrawSpriteSlots
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, [wObject1 + OBJ_SPRITE_ID]
    cp $f0
    jr nz, .set_object1
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $03
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.set_object1:
    sub $02
    ld [wObject1 + OBJ_SPRITE_ID], a
    ld a, [wObject1 + OBJ_STATE]
    inc a
    ld [wObject1 + OBJ_STATE], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_PairLeaves", ROMX

; Staff roll scene 1, step 25: sprites 0 and 1 move left a pixel a frame off the screen, animating;
; then the field event ends, palette fade 4 and the next scene. (C1, E-0357)
DebugStaffRoll_Scene01_PairLeaves::
    call DrawSpriteSlots
    ld a, [wSpriteSlots + $2]
    cp $f0
    jr z, .check_sprite_slots
    sub $01
    ld [wSpriteSlots + $2], a
    ld a, [wSpriteSlots + $7]
    inc a
    ld [wSpriteSlots + $7], a

.check_sprite_slots:
    ld a, [wSpriteSlots + $a]
    cp $f0
    jr nz, .set_sprite_slots
    ld a, $02
    ld [wSpriteSlotCount], a
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wFieldEventKind], a
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

.set_sprite_slots:
    sub $01
    ld [wSpriteSlots + $a], a
    ld a, [wSpriteSlots + $f]
    inc a
    ld [wSpriteSlots + $f], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopTo50", ROMX

; Staff roll scene 1, step 6: sprite 2 walks to X $50 with a hop. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_HopTo50::
    call DrawSpriteSlots
    ld d, $50
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.read_work_buf:
    ld a, [wWorkBuf + $6]
    ld c, a
    ld b, $00
    inc a
    ld [wWorkBuf + $6], a
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopTo60", ROMX

; Staff roll scene 1, step 9: sprite 2 walks to X $60 with a hop. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_HopTo60::
    call DrawSpriteSlots
    ld d, $60
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.read_work_buf:
    ld a, [wWorkBuf + $6]
    ld c, a
    ld b, $00
    inc a
    ld [wWorkBuf + $6], a
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopTo40", ROMX

; Staff roll scene 1, step 7: a sprite walks to X $40 with a hop. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_HopTo40::
    call DrawSpriteSlots
    ld d, $40
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.read_work_buf:
    ld a, [wWorkBuf + $6]
    ld c, a
    ld b, $00
    inc a
    ld [wWorkBuf + $6], a
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopBackTo50", ROMX

; Staff roll scene 1, step 8: a sprite walks to X $50 with a hop. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_HopBackTo50::
    call DrawSpriteSlots
    ld d, $50
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.read_work_buf:
    ld a, [wWorkBuf + $6]
    ld c, a
    ld b, $00
    inc a
    ld [wWorkBuf + $6], a
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopTogether", ROMX

; Staff roll scene 1, step 23: two sprites hop together for 16 frames
; (DebugStaffRoll_Scene01_HopTogether_Data), then a wait and a turn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene01_HopTogether::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_step_work_buf5_mod15
    and $07
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_Scene01_HopTogether_Data
    add hl, bc
    ld a, [wSpriteSlots + $3]
    add [hl]
    ld [wSpriteSlots + $3], a
    ld a, [wSpriteSlots + $b]
    add [hl]
    ld [wSpriteSlots + $b], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_work_buf5_mod15:
    call StepWorkBuf5Mod15
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene01_HopTogether_Data", ROMX

; Eight signed vertical steps: $FD, $FE, $FF, $00, $00, $01, $02, $03 (-3 to +3, net zero).
; DebugStaffRoll_Scene01_HopTogether reads entry (wWorkBuf + $6) & 7 for 16 frames and adds it to
; byte 3 (the Y) of sprite slots 0 and 1, so the two sprites hop together. (C1, E-0381)
DebugStaffRoll_Scene01_HopTogether_Data::
    db $fd, $fe, $ff, $00, $00, $01, $02, $03

; Staff roll scene 2 on map $18 (entry 2 of the table in DebugStaffRoll_Update_RunScene, picked by
; wWorkBuf + 2 - 1). Jumps through a table of 27 steps by wWorkBuf + 1, from step 0
; DebugStaffRoll_Scene02_Load to step 26 DebugStaffRoll_Scene02_Finish. The last step fades out and
; clears wWorkBuf and wWorkBuf + 1, which hands control back to DebugStaffRoll_Credits. (C1, E-0385)
; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene02::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene02_Load
    dw DebugStaffRoll_Scene02_WalkSprites
    dw DebugStaffRoll_Scene02_TurnSprites
    dw DebugStaffRoll_Scene02_WalkSprite
    dw DebugStaffRoll_Scene02_WalkPair
    dw DebugStaffRoll_Scene02_WalkPairLeft
    dw DebugStaffRoll_Scene02_WalkPairDown
    dw DebugStaffRoll_Scene02_WalkPairDownAgain
    dw DebugStaffRoll_Scene02_WalkSpriteDown
    dw DebugStaffRoll_Scene02_WalkSpriteUp
    dw DebugStaffRoll_Scene02_WalkSpriteRight
    dw DebugStaffRoll_Scene02_WalkPairRight
    dw DebugStaffRoll_Scene02_WalkPairBack
    dw DebugStaffRoll_Scene02_WalkPairToPoint
    dw DebugStaffRoll_Scene02_WalkPairToPoint2
    dw DebugStaffRoll_Scene02_WalkSpriteFar
    dw DebugStaffRoll_Scene02_WalkSpriteFarUp
    dw DebugStaffRoll_Scene02_HopTogether
    dw DebugStaffRoll_Scene02_HopSprite5
    dw DebugStaffRoll_Scene02_WaitAndTurn
    dw DebugStaffRoll_Scene02_Wait
    dw DebugStaffRoll_Scene02_StepPair
    dw DebugStaffRoll_Scene02_HopSprites45
    dw DebugStaffRoll_Scene02_WalkPairQuick
    dw DebugStaffRoll_Scene02_WalkSpriteQuick
    dw DebugStaffRoll_Scene02_WalkPairOff
    dw DebugStaffRoll_Scene02_Finish

; Staff roll scene 2, step 0: loads the field sprites, a Watabou sprite and others, map $18's
; tileset and screen (and on the GBC its attributes and palettes) and places the sprites. (C1,
; E-0357)
DebugStaffRoll_Scene02_Load::
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx5F)
    ld de, FieldSpriteGfx5F
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, BANK(MonsterSprite_Watabou)
    ld de, MonsterSprite_Watabou
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx03)
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx03)
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, BANK(Map18Tileset)
    ld de, Map18Tileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, BANK(Map18Tileset)
    ld de, Map18Screens0_Y0X1
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, BANK(Map18Attrs0_Y0X1)
    ld de, Map18Attrs0_Y0X1
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, BANK(Map18Palettes)
    ld de, Map18Palettes
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, BANK(DebugStaffRoll_Scene00_Load_OBJPaletteBufferData)
    ld de, DebugStaffRoll_Scene00_Load_OBJPaletteBufferData
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus8Data)
    ld de, OBJPaletteBufferPlus8Data
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data)
    ld de, OBJPaletteBufferPlus10Data
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus18Data)
    ld de, OBJPaletteBufferPlus18Data
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus20Data)
    ld de, OBJPaletteBufferPlus20Data
    ld hl, wOBJPaletteBuffer + $20
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data_2)
    ld de, OBJPaletteBufferPlus10Data_2
    ld hl, wOBJPaletteBuffer + $28
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, $02
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $a0
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $b0
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $5f
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $20
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $a5
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $04
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $05
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $00
    ld [hli], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSprites", ROMX

; Staff roll scene 2, step 1: after the fade, two sprites walk to ($40, $70) and ($40, $80), then a
; wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkSprites::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    lb de, $40, $70
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $80
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_TurnSprites", ROMX

; Staff roll scene 2, step 2: two sprites turn by two frame tables for $9F frames, then face set
; ways and one more slot is drawn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_TurnSprites::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, DebugStaffRoll_Scene02_TurnSprites_Data1
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, DebugStaffRoll_Scene02_TurnSprites_Data2
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    cp $9f
    ret c
    xor a
    ld [wWorkBuf + $6], a
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_TurnSprites_Data1", ROMX

; Five facing codes for sprite slot 0: $03, $02, $01, $02, $03. DebugStaffRoll_Scene02_TurnSprites
; and DebugStaffRoll_Scene03_TurnSprites pick one by wWorkBuf + $6 >> 5 (0-4, every 32 frames) and
; store it as byte 5 of slot 0, the facing code that DrawSpriteSlots turns into a sub-index. (C1,
; E-0381)
DebugStaffRoll_Scene02_TurnSprites_Data1::
    db $03, $02, $01, $02, $03

; Five facing codes for sprite slot 1: $01, $00, $03, $00, $01. DebugStaffRoll_Scene02_TurnSprites
; and DebugStaffRoll_Scene03_TurnSprites pick one by wWorkBuf + $6 >> 5 (0-4, every 32 frames) at
; the same time as the slot 0 code from DebugStaffRoll_Scene02_TurnSprites_Data1 and store it as
; byte 5 of slot 1. (C1, E-0381)
DebugStaffRoll_Scene02_TurnSprites_Data2::
    db $01, $00, $03, $00, $01

; Staff roll scene 2, step 3: a sprite walks to ($40, $20); then one more slot. (C2, E-0357; probed
; E-0385)
DebugStaffRoll_Scene02_WalkSprite::
    call DrawSpriteSlots
    ld a, $02
    lb de, $40, $20
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPair", ROMX

; Staff roll scene 2, step 4: two sprites walk to ($40, $30) and ($40, $20); then three turns. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPair::
    call DrawSpriteSlots
    ld a, $02
    lb de, $40, $30
    call StepSpriteSlotToward
    ld a, $03
    lb de, $40, $20
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSpriteRight", ROMX

; Staff roll scene 2, step 10: a sprite walks to ($50, $20); then one more slot. (C2, E-0357; probed
; E-0385)
DebugStaffRoll_Scene02_WalkSpriteRight::
    call DrawSpriteSlots
    ld a, $04
    lb de, $50, $20
    call StepSpriteSlotToward
    ret nz
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairRight", ROMX

; Staff roll scene 2, step 11: two sprites walk to ($50, $30) and ($50, $20); then a turn. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairRight::
    call DrawSpriteSlots
    ld a, $04
    lb de, $50, $30
    call StepSpriteSlotToward
    ld a, $05
    lb de, $50, $20
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_HopTogether", ROMX

; Staff roll scene 2, step 17: two sprites hop together for 16 frames; then a turn and a wait. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_HopTogether::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_set_sprite_slot_byte5
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wSpriteSlots + $3]
    add [hl]
    ld [wSpriteSlots + $3], a
    ld a, [wSpriteSlots + $b]
    add [hl]
    ld [wSpriteSlots + $b], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_set_sprite_slot_byte5:
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_HopSprites45", ROMX

; Staff roll scene 2, step 22: for 16 frames the Y bytes of sprites 4 and 5 both get
; DebugStaffRoll_HopYOffsets[wWorkBuf + 6] added, so the two hop in place (wObject2 + OBJ_SPRITE_ID
; + 1 and wObject2 + OBJ_X are byte 3 of slots 4 and 5); then the 30-frame wait runs, sprites 4 and
; 5 face 2, wWorkBuf + 6 is cleared and the step goes on.  (C2, E-0385)
DebugStaffRoll_Scene02_HopSprites45::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_step_work_buf5_mod30
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    ld a, [wObject2 + OBJ_X]
    add [hl]
    ld [wObject2 + OBJ_X], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_work_buf5_mod30:
    call StepWorkBuf5Mod30
    ret nz
    ld a, $04
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $02
    call SetSpriteSlotByte5
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairQuick", ROMX

; Staff roll scene 2, step 23: two sprites walk two steps a frame to ($50, $20) and ($50, $10); then
; fewer slots. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairQuick::
    call DrawSpriteSlots
    ld a, $04
    lb de, $50, $20
    call StepSpriteSlotToward
    ld a, $04
    call StepSpriteSlotToward
    ld a, $05
    lb de, $50, $10
    call StepSpriteSlotToward
    ld a, $05
    call StepSpriteSlotToward
    ret nz
    ld a, $05
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSpriteQuick", ROMX

; Staff roll scene 2, step 24: a sprite walks two steps a frame to ($50, $10); then turns, a wait
; and another turn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkSpriteQuick::
    call DrawSpriteSlots
    ld a, $04
    lb de, $50, $10
    call StepSpriteSlotToward
    ld a, $04
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairOff", ROMX

; Staff roll scene 2, step 25: two sprites walk to ($A0, $70) and ($40, $70); then three turns. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairOff::
    call DrawSpriteSlots
    ld a, $00
    lb de, $a0, $70
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $70
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairLeft", ROMX

; Staff roll scene 2, step 5: two sprites walk to ($30, $30) and ($40, $30); then two turns. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairLeft::
    call DrawSpriteSlots
    ld a, $02
    lb de, $30, $30
    call StepSpriteSlotToward
    ld a, $03
    lb de, $40, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairDown", ROMX

; Staff roll scene 2, step 6: two sprites walk to ($30, $40) and ($30, $30); then a turn. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairDown::
    call DrawSpriteSlots
    ld a, $02
    lb de, $30, $40
    call StepSpriteSlotToward
    ld a, $03
    lb de, $30, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairDownAgain", ROMX

; Staff roll scene 2, step 7: two sprites walk to ($30, $50) and ($30, $40); then a turn. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairDownAgain::
    call DrawSpriteSlots
    ld a, $02
    lb de, $30, $50
    call StepSpriteSlotToward
    ld a, $03
    lb de, $30, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSpriteDown", ROMX

; Staff roll scene 2, step 8: a sprite walks to ($20, $50); then a turn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkSpriteDown::
    call DrawSpriteSlots
    ld a, $02
    lb de, $20, $50
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSpriteUp", ROMX

; Staff roll scene 2, step 9: a sprite walks to ($20, $40); then four turns, a wait and fewer slots.
; (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkSpriteUp::
    call DrawSpriteSlots
    ld a, $02
    lb de, $20, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld a, $05
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairBack", ROMX

; Staff roll scene 2, step 12: two sprites walk to ($60, $30) and ($50, $30); then two turns. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene02_WalkPairBack::
    call DrawSpriteSlots
    ld a, $04
    lb de, $60, $30
    call StepSpriteSlotToward
    ld a, $05
    lb de, $50, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairToPoint", ROMX

; Staff roll scene 2, step 13: sprite 4 walks to ($60, $40) and sprite 5 to ($60, $30). The first
; target is the address DebugStaffRoll_HopYOffsets + 8 ($6040) loaded as an immediate into DE (D =
; $60, E = $40), not a byte read from the table; when sprite 5 has arrived it faces 0 and the step
; goes on.  (C2, E-0385)
DebugStaffRoll_Scene02_WalkPairToPoint::
    call DrawSpriteSlots
    ld a, $04
    ld de, DebugStaffRoll_HopYOffsets + $8
    call StepSpriteSlotToward
    ld a, $05
    lb de, $60, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkPairToPoint2", ROMX

; Staff roll scene 2, step 14: sprite 4 walks to ($60, $50) and sprite 5 to ($60, $40), the second
; target being the address DebugStaffRoll_HopYOffsets + 8 ($6040) loaded as an immediate into DE,
; not a byte read from the table; when sprite 5 has arrived sprite 4 faces 1 and the step goes on.
; (C2, E-0385)
DebugStaffRoll_Scene02_WalkPairToPoint2::
    call DrawSpriteSlots
    ld a, $04
    lb de, $60, $50
    call StepSpriteSlotToward
    ld a, $05
    ld de, DebugStaffRoll_HopYOffsets + $8
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSpriteFar", ROMX

; Staff roll scene 2, step 15: a sprite walks to ($70, $50); then a turn. (C2, E-0357; probed
; E-0385)
DebugStaffRoll_Scene02_WalkSpriteFar::
    call DrawSpriteSlots
    ld a, $04
    lb de, $70, $50
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WalkSpriteFarUp", ROMX

; Staff roll scene 2, step 16: a sprite walks to ($70, $40); then two turns and a wait. (C2, E-0357;
; probed E-0385)
DebugStaffRoll_Scene02_WalkSpriteFarUp::
    call DrawSpriteSlots
    ld a, $04
    lb de, $70, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $03
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_Finish", ROMX

; Staff roll scene 2, step 26: two sprites walk to ($A0, $70); then turns, a wait, a palette fade
; and the next scene. (C1, E-0357)
DebugStaffRoll_Scene02_Finish::
    call DrawSpriteSlots
    ld a, $01
    lb de, $a0, $70
    call StepSpriteSlotToward
    ld a, $00
    lb de, $a0, $70
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_HopSprite5", ROMX

; Staff roll scene 2, step 18: for 16 frames the Y byte of sprite 5 gets
; DebugStaffRoll_HopYOffsets[wWorkBuf + 6] added, so it hops in place (wObject2 + OBJ_X is byte 3 of
; sprite slot 5, its Y); then the 60-frame wait counter runs and at its end sprite 5 faces 1,
; wWorkBuf + 6 is cleared and the step goes on.  (C2, E-0385)
DebugStaffRoll_Scene02_HopSprite5::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_step_work_buf5_mod60
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject2 + OBJ_X]
    add [hl]
    ld [wObject2 + OBJ_X], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_work_buf5_mod60:
    call StepWorkBuf5Mod60
    ret nz
    ld a, $05
    ld c, $01
    call SetSpriteSlotByte5
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_WaitAndTurn", ROMX

; Staff roll scene 2, step 19: a 60-frame wait, then two turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_WaitAndTurn::
    call DrawSpriteSlots
    call StepWorkBuf5Mod60
    ret nz
    ld a, $04
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_Wait", ROMX

; Staff roll scene 2, step 20: a 30-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene02_Wait::
    call DrawSpriteSlots
    call StepWorkBuf5Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene02_StepPair", ROMX

; Staff roll scene 2, step 21: wWorkBuf + 6 counts the frames; on every eighth frame sprite 4 steps
; a pixel toward ($70, $50) and sprite 5 toward ($60, $50). On a tick where sprite 5 does not move
; (it has arrived) wWorkBuf + 7 counts up, and at 3 such ticks both counters are cleared and the
; step goes on.  (C2, E-0385)
DebugStaffRoll_Scene02_StepPair::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $07
    ret nz
    ld a, $04
    lb de, $70, $50
    call StepSpriteSlotToward
    ld a, $05
    lb de, $60, $50
    call StepSpriteSlotToward
    ret nz
    ld a, [wWorkBuf + $7]
    inc a
    ld [wWorkBuf + $7], a
    cp $03
    ret c
    xor a
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03", ROMX

; Staff roll scene 3 on map $19 (entry 3 of the table in DebugStaffRoll_Update_RunScene, picked by
; wWorkBuf + 2 - 1). Jumps through a table of 11 steps by wWorkBuf + 1, from step 0
; DebugStaffRoll_Scene03_Load to step 10 DebugStaffRoll_Scene03_Finish. The last step fades out and
; clears wWorkBuf and wWorkBuf + 1, which hands control back to DebugStaffRoll_Credits. (C1, E-0385)
; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene03::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene03_Load
    dw DebugStaffRoll_Scene03_WalkSprites
    dw DebugStaffRoll_Scene03_TurnSprites
    dw DebugStaffRoll_Scene03_WaitAndTurn
    dw DebugStaffRoll_Scene03_WalkSpritesUp
    dw DebugStaffRoll_Scene03_HopSprite5
    dw DebugStaffRoll_Scene03_Hop
    dw DebugStaffRoll_Scene03_TurnAndWalk
    dw DebugStaffRoll_Scene03_WalkOff
    dw DebugStaffRoll_Scene03_WalkPair
    dw DebugStaffRoll_Scene03_Finish

; Staff roll scene 3, step 0: loads the field sprites and others, map $19's tileset and screen (and
; on the GBC its attributes and palettes) and places the sprites. (C1, E-0357)
DebugStaffRoll_Scene03_Load::
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx01)
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx03)
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx02)
    ld de, FieldSpriteGfx12
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx12)
    ld de, FieldSpriteGfx0E
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, BANK(Tiles0Plus600Gfx)
    ld de, Tiles0Plus600Gfx
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld b, BANK(Map19Tileset)
    ld de, Map19Tileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, BANK(Map19Tileset)
    ld de, Map19Screens0_Y0X0
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jp z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, BANK(Map19Attrs0_Y0X0)
    ld de, Map19Attrs0_Y0X0
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, BANK(Map19Palettes)
    ld de, Map19Palettes
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, BANK(Map18Palettes)
    ld de, Map18Palettes
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, BANK(DebugStaffRoll_Scene00_Load_OBJPaletteBufferData)
    ld de, DebugStaffRoll_Scene00_Load_OBJPaletteBufferData
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus8Data)
    ld de, OBJPaletteBufferPlus8Data
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus20Data)
    ld de, OBJPaletteBufferPlus20Data
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data_2)
    ld de, OBJPaletteBufferPlus10Data_2
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data)
    ld de, OBJPaletteBufferPlus10Data
    ld hl, wOBJPaletteBuffer + $20
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus28Data)
    ld de, OBJPaletteBufferPlus28Data
    ld hl, wOBJPaletteBuffer + $28
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus30Data)
    ld de, OBJPaletteBufferPlus30Data
    ld hl, wOBJPaletteBuffer + $30
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $a0
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $b0
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $60
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $20
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $12
    ld [hli], a
    ld a, $60
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $04
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $0e
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $05
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $15
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $06
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $60
    ld [hli], a
    ld a, $00
    ld [hli], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_WalkSprites", ROMX

; Staff roll scene 3, step 1: after the fade, two sprites walk to ($40, $50) and ($40, $60), then a
; wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene03_WalkSprites::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    lb de, $40, $50
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $60
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_TurnSprites", ROMX

; Staff roll scene 3, step 2: two sprites turn by two frame tables for $9F frames, then face set
; ways and one more slot is drawn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene03_TurnSprites::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, DebugStaffRoll_Scene02_TurnSprites_Data1
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, DebugStaffRoll_Scene02_TurnSprites_Data2
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    cp $9f
    ret c
    xor a
    ld [wWorkBuf + $6], a
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $07
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_WaitAndTurn", ROMX

; Staff roll scene 3, step 3: a 45-frame wait, then a turn and another slot. (C2, E-0357; probed
; E-0385)
DebugStaffRoll_Scene03_WaitAndTurn::
    call DrawSpriteSlots
    call StepWorkBuf5Mod45
    ret nz
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_WalkSpritesUp", ROMX

; Staff roll scene 3, step 4: two sprites walk to ($40, $40) and ($40, $50), then a 30-frame wait.
; (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene03_WalkSpritesUp::
    call DrawSpriteSlots
    ld a, $00
    lb de, $40, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $50
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_HopSprite5", ROMX

; Staff roll scene 3, step 5: for 16 frames the Y byte of sprite 5 gets
; DebugStaffRoll_HopYOffsets[wWorkBuf + 6] added (it hops in place) and its facing byte becomes
; wWorkBuf + 6 / 4. From frame 16 wSpriteSlotCount is set to 5 and the Y of sprite 3 becomes the Y
; of sprite 5 plus the byte at wSpriteSlots + 8 * (the slot count when the step started), which
; DrawSpriteSlots leaves in HL (not a byte of its own table); then the 15-frame wait runs, wWorkBuf
; + 6 is cleared and the step goes on.  (C2, E-0385)
DebugStaffRoll_Scene03_HopSprite5::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .set_sprite_slot_count_to_05
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject2 + OBJ_X]
    add [hl]
    ld [wObject2 + OBJ_X], a
    ld a, [wWorkBuf + $6]
    srl a
    srl a
    ld hl, DebugStaffRoll_Scene03_HopSprite5_Data
    ld [wObject2 + OBJ_FLAGS], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.set_sprite_slot_count_to_05:
    ld a, $05
    ld [wSpriteSlotCount], a
    ld a, [wObject2 + OBJ_X]
    add [hl]
    ld [wObject1 + OBJ_X], a
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_HopSprite5_Data", ROMX

; Four bytes, $03, $02, $01, $00: a descending facing-code sequence.
; DebugStaffRoll_Scene03_HopSprite5 loads the address into HL but no instruction indexes it: during
; the 16 hop frames it stores wWorkBuf + $6 >> 2 (0-3) as byte 5 of a sprite slot, and after the hop
; it adds the byte at the HL that DrawSpriteSlots left behind, not a byte of this table. (C1,
; E-0381)
DebugStaffRoll_Scene03_HopSprite5_Data::
    db $03, $02, $01, $00

; Staff roll scene 3, step 6: a sprite hops for 16 frames, its frame changing every four; then four
; slots, a second sprite takes its Y and a 30-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene03_Hop::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .set_sprite_slot_count_to_04
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    ld a, [wWorkBuf + $6]
    srl a
    srl a
    ld hl, DebugStaffRoll_Scene03_Hop_Data
    ld [wObject2 + $5], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.set_sprite_slot_count_to_04:
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    call StepWorkBuf5Mod30
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_Hop_Data", ROMX

; Four bytes, $02, $01, $00, $03: a facing-code sequence. DebugStaffRoll_Scene03_Hop loads the
; address into HL but no instruction indexes it: during the 16 hop frames it stores wWorkBuf + $6 >>
; 2 (0-3) as byte 5 of a sprite slot, and after the hop it adds the byte at the HL that
; DrawSpriteSlots left behind, not a byte of this table. (C1, E-0381)
DebugStaffRoll_Scene03_Hop_Data::
    db $02, $01, $00, $03

; Staff roll scene 3, step 7: two sprites turn and walk to ($50, $40) and ($50, $30); then four
; turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene03_TurnAndWalk::
    call DrawSpriteSlots
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    lb de, $50, $40
    call StepSpriteSlotToward
    ld a, $03
    lb de, $50, $30
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_WalkOff", ROMX

; Staff roll scene 3, step 8: two sprites walk down to ($50, $A0), off the screen; then two turns
; and a 30-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene03_WalkOff::
    call DrawSpriteSlots
    ld a, $02
    lb de, $50, $a0
    call StepSpriteSlotToward
    ld a, $03
    lb de, $50, $a0
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWorkBuf5Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_WalkPair", ROMX

; Staff roll scene 3, step 9: two sprites walk to ($40, $A0) and ($40, $40); then a turn. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene03_WalkPair::
    call DrawSpriteSlots
    ld a, $00
    lb de, $40, $a0
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene03_Finish", ROMX

; Staff roll scene 3, step 10: two sprites walk to ($40, $A0) and ($40, $B0); then a wait, a palette
; fade and the next scene. (C1, E-0357)
DebugStaffRoll_Scene03_Finish::
    call DrawSpriteSlots
    ld a, $00
    lb de, $40, $a0
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $b0
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04", ROMX

; Staff roll scene 4 on map $1A (entry 4 of the table in DebugStaffRoll_Update_RunScene, picked by
; wWorkBuf + 2 - 1). Jumps through a table of 15 steps by wWorkBuf + 1, from step 0
; DebugStaffRoll_Scene04_Load to step 14 DebugStaffRoll_Scene04_Finish. The last step fades out and
; clears wWorkBuf and wWorkBuf + 1, which hands control back to DebugStaffRoll_Credits. (C1, E-0385)
; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene04::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene04_Load
    dw DebugStaffRoll_Scene04_WalkSprites
    dw DebugStaffRoll_Scene04_StepSpritesLeft
    dw DebugStaffRoll_Scene04_StepSpritesBack
    dw DebugStaffRoll_Scene04_WaitAndTurnAgain
    dw DebugStaffRoll_Scene04_WaitAndTurn
    dw DebugStaffRoll_Scene04_WaitAgain
    dw DebugStaffRoll_Scene04_StepPairRight
    dw DebugStaffRoll_Scene04_WalkPair
    dw DebugStaffRoll_Scene04_HopInTurn
    dw DebugStaffRoll_Scene04_HopTogether
    dw DebugStaffRoll_Scene04_Wait
    dw DebugStaffRoll_Scene04_StepPairRightAgain
    dw DebugStaffRoll_Scene04_WalkApart
    dw DebugStaffRoll_Scene04_Finish

; Staff roll scene 4, step 0: loads the field sprites, map $1A's tileset and screen (and on the GBC
; its attributes and palettes) and places the sprites. (C1, E-0357)
DebugStaffRoll_Scene04_Load::
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx00)
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx01)
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, BANK(FieldSpriteGfx03)
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, BANK(Map1ATileset)
    ld de, Map1ATileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, BANK(Map1ATileset)
    ld de, Map1AScreens0_Y0X0
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, BANK(Map1AAttrs0_Y0X0)
    ld de, Map1AAttrs0_Y0X0
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, BANK(Map1APalettes)
    ld de, Map1APalettes
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, BANK(DebugStaffRoll_Scene00_Load_OBJPaletteBufferData)
    ld de, DebugStaffRoll_Scene00_Load_OBJPaletteBufferData
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus8Data)
    ld de, OBJPaletteBufferPlus8Data
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus20Data)
    ld de, OBJPaletteBufferPlus20Data
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, BANK(OBJPaletteBufferPlus10Data_2)
    ld de, OBJPaletteBufferPlus10Data_2
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, $04
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $a0
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $b0
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $10
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $20
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $50
    ld [hli], a
    ld a, $40
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $00
    ld [hli], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_WalkSprites", ROMX

; Staff roll scene 4, step 1: after the fade, two sprites walk to ($80, $40) and ($90, $40); then a
; 30-frame wait and two turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_WalkSprites::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    lb de, $80, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $90, $40
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod30
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_StepSpritesLeft", ROMX

; Staff roll scene 4, step 2: on every fourth frame (wWorkBuf + 6) sprite 0 steps a pixel toward
; ($70, $40) and sprite 1 toward ($80, $40). On a tick where sprite 1 does not move (it has arrived)
; wWorkBuf + 7 counts up, and at 7 such ticks both counters are cleared and the step goes on.  (C2,
; E-0385)
DebugStaffRoll_Scene04_StepSpritesLeft::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $00
    lb de, $70, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $80, $40
    call StepSpriteSlotToward
    ret nz
    ld a, [wWorkBuf + $7]
    inc a
    ld [wWorkBuf + $7], a
    cp $07
    ret c
    xor a
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_StepSpritesBack", ROMX

; Staff roll scene 4, step 3: on every fourth frame sprite 2 steps a pixel toward ($30, $40) and
; sprite 3 toward ($40, $40). On each tick where sprite 3 does not move (it has arrived) wWorkBuf +
; 7 counts up: from 7 up to 14 both sprites also get facing 3 on every such tick, and at 15 both
; counters are cleared and the step goes on.  (C2, E-0385)
DebugStaffRoll_Scene04_StepSpritesBack::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $02
    lb de, $30, $40
    call StepSpriteSlotToward
    ld a, $03
    lb de, $40, $40
    call StepSpriteSlotToward
    ret nz
    ld a, [wWorkBuf + $7]
    inc a
    ld [wWorkBuf + $7], a
    cp $07
    ret c
    cp $0f
    jr c, .call_set_sprite_slot_byte5
    xor a
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

.call_set_sprite_slot_byte5:
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_HopInTurn", ROMX

; Staff roll scene 4, step 9: two sprites hop in turn while walking to X $10 (16-frame offsets
; apart), then run off to ($10, $A0); then a 30-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_HopInTurn::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $20
    jr nc, .call_step_sprite_slot_toward
    and $1f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_Scene04_HopInTurn_Data
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ld e, a
    ld d, $10
    ld a, $02
    call StepSpriteSlotToward
    jr .read_work_buf

.call_step_sprite_slot_toward:
    ld a, $02
    lb de, $10, $a0
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward

.read_work_buf:
    ld a, [wWorkBuf + $6]
    sub $10
    jr c, .call_step_sprite_slot_toward2
    cp $20
    jr nc, .call_step_sprite_slot_toward3
    and $1f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_Scene04_HopInTurn_Data
    add hl, bc
    ld a, [wObject1 + OBJ_X]
    add [hl]
    ld [wObject1 + OBJ_X], a
    ld e, a
    ld d, $10
    ld a, $03
    call StepSpriteSlotToward
    jr .check_work_buf

.call_step_sprite_slot_toward2:
    ld a, $03
    lb de, $30, $40
    call StepSpriteSlotToward

.check_work_buf:
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_sprite_slot_toward3:
    ld a, $03
    lb de, $10, $a0
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod30
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_HopInTurn_Data", ROMX

; Thirty-two signed vertical steps for a longer hop: $FD x4, $FE x4, $FF x4, $00 x8, $01 x4, $02 x4,
; $03 x4 (net zero). DebugStaffRoll_Scene04_HopInTurn adds entry [wWorkBuf + $6] (frames 0-31) to
; byte 3 of sprite slot 2, then entry [wWorkBuf + $6 - $10] (frames 16-47) to byte 3 of slot 3, so
; the second sprite starts hopping half a hop later. (C1, E-0381)
DebugStaffRoll_Scene04_HopInTurn_Data::
    db $fd, $fd, $fd, $fd, $fe, $fe, $fe, $fe, $ff, $ff, $ff, $ff, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03

; Staff roll scene 4, step 10: two sprites hop together for 16 frames, then after 16 more walk to
; ($30, $40) and ($40, $40). (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_HopTogether::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .cp_20
    and $0f
    ld c, a
    ld b, $00
    ld hl, DebugStaffRoll_HopYOffsets
    add hl, bc
    ld a, [wSpriteSlots + $3]
    add [hl]
    ld [wSpriteSlots + $3], a
    ld a, [wSpriteSlots + $b]
    add [hl]
    ld [wSpriteSlots + $b], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.cp_20:
    cp $20
    push af
    inc a
    ld [wWorkBuf + $6], a
    pop af
    ret c
    ld a, $00
    lb de, $30, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $40
    call StepSpriteSlotToward
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_Wait", ROMX

; Staff roll scene 4, step 11: a 60-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_Wait::
    call DrawSpriteSlots
    call StepWorkBuf5Mod60
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_WalkApart", ROMX

; Staff roll scene 4, step 13: two sprites walk to ($A0, $40) and ($40, $40); then a turn. (C2,
; E-0357; probed E-0385)
DebugStaffRoll_Scene04_WalkApart::
    call DrawSpriteSlots
    ld a, $00
    lb de, $a0, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $40, $40
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_Finish", ROMX

; Staff roll scene 4, step 14: two sprites walk to ($A0, $40); then a wait, a palette fade and the
; next scene. (C1, E-0357)
DebugStaffRoll_Scene04_Finish::
    call DrawSpriteSlots
    ld a, $00
    lb de, $a0, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $a0, $40
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_WaitAndTurn", ROMX

; Staff roll scene 4, step 5: a 60-frame wait, then two turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_WaitAndTurn::
    call DrawSpriteSlots
    call StepWorkBuf5Mod60
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_StepPairRightAgain", ROMX

; Staff roll scene 4, step 12: two sprites step every four frames toward ($40, $40) and ($50, $40);
; then a wait and a turn. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_StepPairRightAgain::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $00
    lb de, $40, $40
    call StepSpriteSlotToward
    ld a, $01
    lb de, $50, $40
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_WaitAndTurnAgain", ROMX

; Staff roll scene 4, step 4: a 60-frame wait, then two turns. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_WaitAndTurnAgain::
    call DrawSpriteSlots
    call StepWorkBuf5Mod60
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_WaitAgain", ROMX

; Staff roll scene 4, step 6: a 60-frame wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_WaitAgain::
    call DrawSpriteSlots
    call StepWorkBuf5Mod60
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_StepPairRight", ROMX

; Staff roll scene 4, step 7: two sprites step every four frames toward ($40, $40) and ($50, $40);
; then a wait. (C2, E-0357; probed E-0385)
DebugStaffRoll_Scene04_StepPairRight::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $02
    lb de, $40, $40
    call StepSpriteSlotToward
    ld a, $03
    lb de, $50, $40
    call StepSpriteSlotToward
    ret nz
    call StepWorkBuf5Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Scene04_WalkPair", ROMX

; Staff roll scene 4, step 8: two sprites walk to ($30, $40) and ($40, $40). (C2, E-0357; probed
; E-0385)
DebugStaffRoll_Scene04_WalkPair::
    call DrawSpriteSlots
    ld a, $02
    lb de, $30, $40
    call StepSpriteSlotToward
    ld a, $03
    lb de, $40, $40
    call StepSpriteSlotToward
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Credits", ROMX

; The staff roll's caption steps by wWorkBuf + 1: with a scene number set the credits text (draw,
; wait, end), otherwise the title card (draw, wait, next). (C1, E-0357)
DebugStaffRoll_Credits::
    ld a, [wWorkBuf + $2]
    or a
    jr z, .read_work_buf
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Credits_ShowLines
    dw DebugStaffRoll_Credits_Caption
    dw DebugStaffRoll_Credits_NextCaption

.read_work_buf:
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Credits_TitleCard
    dw DebugStaffRoll_Credits_TitleCardFadeOut
    dw DebugStaffRoll_Credits_StartFirstScene

; Staff roll credits, step 0: on the first call clears a tile and loads the scene's credit list
; (WorkBufSequenceTable); then draws its lines one by one (strings of the staff list, each in an 18
; x 2 window, advancing $240 bytes of tiles a line) until the list ends. (C1, E-0357)
DebugStaffRoll_Credits_ShowLines::
    ld a, [wWorkBuf + $4]
    or a
    jr nz, .read_work_buf
    ld hl, vTiles2 + $7f0
    ld de, $0101
    call FillTilesRequest
    ld a, [wWorkBuf + $2]
    dec a
    ld hl, WorkBufSequenceTable
    call ReadWordTableEntry_Bank00
    ld a, [hli]
    ld [wWorkBuf + $4], a
    ld a, l
    ld [wWorkBuf + $8], a
    ld a, h
    ld [wWorkBuf + $9], a

.read_work_buf:
    ld a, [wWorkBuf + $8]
    ld l, a
    ld a, [wWorkBuf + $9]
    ld h, a
    ld a, [hli]
    cp $fe
    jp nz, .set_work_buf2
    ld a, l
    ld [wWorkBuf + $10], a
    ld a, h
    ld [wWorkBuf + $11], a
    ld bc, vTiles1
    ld a, c
    ld [wWorkBuf + $c], a
    ld a, b
    ld [wWorkBuf + $d], a
    xor a
    ld [wWorkBuf + $a], a

.skip:
    ld a, [hli]
    ld c, a
    cp $ff
    jp z, .set_work_buf
    ld a, [wWorkBuf + $a]
    add c
    ld [wWorkBuf + $a], a
    ld a, c
    or a
    jr nz, .read_work_buf2
    inc hl
    jr .read_work_buf3

.read_work_buf2:
    push hl
    ld a, [wWorkBuf + $c]
    ld l, a
    ld a, [wWorkBuf + $d]
    ld h, a
    ld de, $1202
    call FillTilesRequest
    ld a, [wWorkBuf + $c]
    ld l, a
    ld a, [wWorkBuf + $d]
    ld h, a
    ld de, $0240
    add hl, de
    ld a, l
    ld [wWorkBuf + $c], a
    ld a, h
    ld [wWorkBuf + $d], a
    pop hl
    xor a
    ld [wStringCategory], a
    ld a, [hli]
    ld [wStringIndex], a
    cp $ff
    jr z, .read_work_buf3
    push hl
    call ShowString_BankE0
    pop hl

.read_work_buf3:
    ld a, [hli]
    ld c, a
    ld a, [wWorkBuf + $a]
    add c
    ld a, a
    ld [wWorkBuf + $a], a
    ld a, c
    or a
    jr nz, .read_work_buf4
    inc hl
    jr .skip

.read_work_buf4:
    push hl
    ld a, [wWorkBuf + $c]
    ld l, a
    ld a, [wWorkBuf + $d]
    ld h, a
    ld de, $1201
    call FillTilesRequest
    ld a, [wWorkBuf + $c]
    ld l, a
    ld a, [wWorkBuf + $d]
    ld h, a
    ld de, $0120
    add hl, de
    ld a, l
    ld [wWorkBuf + $c], a
    ld a, h
    ld [wWorkBuf + $d], a
    pop hl
    ld a, $01
    ld [wStringCategory], a
    ld a, [hli]
    ld [wStringIndex], a
    push hl
    call ShowString_BankE0
    pop hl
    jp .skip

.set_work_buf:
    ld a, l
    ld [wWorkBuf + $8], a
    ld a, h
    ld [wWorkBuf + $9], a
    ld a, [wIsCGB]
    or a
    jr z, .skip2
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    lb bc, $14, $12
    call FillBGMapRectWithAWrapped
    ld a, $00
    ldh [rVBK], a

.skip2:
    ld a, $7f
    ld hl, vBGMap0
    lb bc, $14, $12
    call FillBGMapRectWithAWrapped
    ld bc, vBGMap0 + $41
    ld a, c
    ld [wWorkBuf + $e], a
    ld a, b
    ld [wWorkBuf + $f], a
    ld bc, $0080
    ld a, c
    ld [wWorkBuf + $c], a
    ld a, b
    ld [wWorkBuf + $d], a

.read_work_buf5:
    ld a, [wWorkBuf + $10]
    ld l, a
    ld a, [wWorkBuf + $11]
    ld h, a
    ld a, [hl]
    cp $ff
    jp z, .check_sgb_active
    ld a, [wWorkBuf + $e]
    ld l, a
    ld a, [wWorkBuf + $f]
    ld h, a
    ld a, [wWorkBuf + $c]
    ld b, a
    add $24
    ld [wWorkBuf + $c], a
    ld a, b
    ld b, $12
    ld c, $02
    ld de, $0020
    call FillVRAMRectWithTileSequence
    ld a, l
    and $e0
    add $01
    ld l, a
    push hl
    ld a, [wWorkBuf + $10]
    ld l, a
    ld a, [wWorkBuf + $11]
    ld h, a
    ld a, [hli]
    cp $01
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]
    ld a, l
    ld [wWorkBuf + $10], a
    ld a, h
    ld [wWorkBuf + $11], a
    pop hl
    jr z, .read_work_buf6
    ld de, $0020
    add hl, de

.read_work_buf6:
    ld a, [wWorkBuf + $c]
    ld b, a
    add $12
    ld [wWorkBuf + $c], a
    ld a, b
    ld de, $0040
    ld b, $12
    ld c, $01
    call FillVRAMRectWithTileSequence
    ld a, l
    and $e0
    add $01
    ld l, a
    ld a, l
    ld [wWorkBuf + $e], a
    ld a, h
    ld [wWorkBuf + $f], a
    jr .read_work_buf5

.set_work_buf2:
    ld [wWorkBuf + $a], a
    or a
    jr nz, .skip3
    inc hl
    jr .set_work_buf3

.skip3:
    push hl
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    pop hl
    xor a
    ld [wStringCategory], a
    ld a, [hli]
    ld [wStringIndex], a
    cp $ff
    jr z, .set_work_buf3
    push hl
    call ShowString_BankE0
    pop hl

.set_work_buf3:
    ld a, [hli]
    ld [wWorkBuf + $b], a
    or a
    jr nz, .skip4
    inc hl
    jr .set_work_buf4

.skip4:
    push hl
    ld hl, vTiles1 + $240
    ld de, $1206
    call FillTilesRequest
    pop hl
    ld a, $01
    ld [wStringCategory], a
    ld a, [hli]
    ld [wStringIndex], a
    push hl
    call ShowString_BankE0
    pop hl

.set_work_buf4:
    ld a, l
    ld [wWorkBuf + $8], a
    ld a, h
    ld [wWorkBuf + $9], a
    ld a, [wIsCGB]
    or a
    jr z, .skip5
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    lb bc, $14, $12
    call FillBGMapRectWithAWrapped
    ld a, $00
    ldh [rVBK], a

.skip5:
    ld a, $7f
    ld hl, vBGMap0
    lb bc, $14, $12
    call FillBGMapRectWithAWrapped
    ld hl, wWorkBuf + $b
    ld a, [hld]
    add a
    add [hl]
    ld b, a
    ld a, $12
    sub b
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, vBGMap0
    add hl, de
    ld de, $0001
    add hl, de
    ld de, $0020
    ld b, $12
    ld a, [wWorkBuf + $a]
    ld c, a
    or a
    jr z, .skip6
    ld a, $80
    call FillVRAMRectWithTileSequence

.skip6:
    ld a, l
    and $e0
    ld l, a
    ld de, $0041
    add hl, de
    ld de, $0040
    ld b, $12
    ld a, [wWorkBuf + $b]
    ld c, a
    or a
    jr z, .check_sgb_active
    ld a, $a4
    call FillVRAMRectWithTileSequence

.check_sgb_active:
    ld hl, wWorkBuf + $1
    inc [hl]
    ld a, [wSGBActive]
    or a
    ld hl, $01a4
    jr z, .read_work_buf7
    ld hl, $012c

.read_work_buf7:
    ld a, [wWorkBuf + $8]
    ld e, a
    ld a, [wWorkBuf + $9]
    ld d, a
    dec de
    dec de
    dec de
    ld a, [de]
    cp $00
    jr z, .set_work_buf5
    cp $05
    jr z, .set_work_buf5
    cp $0f
    jr z, .set_work_buf5
    cp $13
    jr z, .set_work_buf5
    cp $14
    jr z, .set_work_buf5
    cp $15
    jr z, .set_work_buf5
    cp $16
    jr z, .set_work_buf5
    cp $17
    jr z, .set_work_buf5
    cp $18
    jr z, .set_work_buf5
    cp $19
    jr z, .set_work_buf5
    cp $1a
    jr z, .set_work_buf5
    cp $1b
    cp $20
    jr c, .set_work_buf6
    ld hl, -1
    jr .set_work_buf6

.set_work_buf5:
    ld hl, $012c

.set_work_buf6:
    ld a, l
    ld [wWorkBuf + $5], a
    ld a, h
    ld [wWorkBuf + $6], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ret

SECTION "Bank E0 DebugStaffRoll_Credits_Caption", ROMX

; Staff roll credits, step 1: counts down the caption's time; after the last scene waits until every
; sound channel has finished, then fades, puts the player on map 0 at (0, 0), keeps the party count,
; sets EVENT_STAFF_ROLL_PARTY_SAVED and switches game mode; otherwise when the time runs out fades
; and goes on. (C1, E-0357)
DebugStaffRoll_Credits_Caption::
    ld hl, wWorkBuf + $5
    ld a, [hli]
    and [hl]
    cp $ff
    jr z, .read_sound_channel2
    ld a, [wWorkBuf + $5]
    sub $01
    ld [wWorkBuf + $5], a
    ld a, [wWorkBuf + $6]
    sbc $00
    ld [wWorkBuf + $6], a
    jr .skip

.read_sound_channel2:
    ld a, [wSoundChannel2]
    ld hl, wSoundChannel2 + $1
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    cp $ff
    ret nz
    ld a, $10
    call StartPaletteFade
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $b0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld a, $40
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    ld de, EVENT_STAFF_ROLL_PARTY_SAVED
    call SetFlagBit
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip:
    ld hl, wWorkBuf + $5
    ld a, [hli]
    or [hl]
    ret nz
    ld a, $04
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Credits_NextCaption", ROMX

; Staff roll credits, step 2: returns while wFadeState is non-zero; then decrements the caption
; count in wWorkBuf + 4 and, while captions remain, goes back to step 0 (wWorkBuf + 1 = 0) for the
; scene's next caption; when none remain it advances the scene number (wWorkBuf + 2) and wWorkBuf
; and restarts at step 0 for the next scene. (C2, E-0371; probed E-0385)
DebugStaffRoll_Credits_NextCaption::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wWorkBuf + $4]
    dec a
    ld [wWorkBuf + $4], a
    jr z, .skip
    xor a
    ld [wWorkBuf + $1], a
    ret

.skip:
    ld hl, wWorkBuf + $2
    inc [hl]
    ld hl, wWorkBuf
    inc [hl]
    xor a
    ld [wWorkBuf + $1], a
    ret

SECTION "Bank E0 DebugStaffRoll_Credits_TitleCard", ROMX

; The staff roll's title card, step 0: clears two tile areas and shows the first string, blanks the
; BG map (and on the GBC its attributes with the first palette), draws the caption's tiles, sets its
; time ($168 frames, $F0 on the SGB), resets the palettes and fades in. (C1, E-0357)
DebugStaffRoll_Credits_TitleCard::
    ld hl, vTiles2 + $7f0
    ld de, $0101
    call FillTilesRequest
    ld hl, vTiles1
    ld de, $0e02
    call FillTilesRequest
    ld a, $02
    ld [wStringCategory], a
    xor a
    ld [wStringIndex], a
    call ShowString_BankE0
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld b, BANK(AreaPalettes0)
    ld de, AreaPalettes0
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    lb bc, $14, $12
    call FillBGMapRectWithAWrapped
    ld a, $00
    ldh [rVBK], a

.skip:
    ld a, $7f
    ld hl, vBGMap0
    lb bc, $14, $12
    call FillBGMapRectWithAWrapped
    ld a, $80
    ld hl, vBGMap0 + $e3
    ld de, $0040
    lb bc, $0e, $02
    call FillVRAMRectWithTileSequence
    ld a, [wSGBActive]
    or a
    ld hl, $0168
    jr z, .set_work_buf
    ld hl, $00f0

.set_work_buf:
    ld a, l
    ld [wWorkBuf + $5], a
    ld a, h
    ld [wWorkBuf + $6], a
    call ResetScreenPalettes_E0
    ld a, $fc
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Credits_TitleCardFadeOut", ROMX

; The title card, step 1: counts down its time, then fades out. (C1, E-0357)
DebugStaffRoll_Credits_TitleCardFadeOut::
    ld a, [wWorkBuf + $5]
    sub $01
    ld [wWorkBuf + $5], a
    ld a, [wWorkBuf + $6]
    sbc $00
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $5
    ld a, [hli]
    or [hl]
    ret nz
    ld a, $04
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

SECTION "Bank E0 DebugStaffRoll_Credits_StartFirstScene", ROMX

; The staff roll's title card, step 2 (DebugStaffRoll_Credits with wWorkBuf + 2 = 0): returns while
; wFadeState is non-zero; then increments the scene number wWorkBuf + 2 (to scene 1) and wWorkBuf,
; and clears the step wWorkBuf + 1. (C2, E-0371; probed E-0385)
DebugStaffRoll_Credits_StartFirstScene::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wWorkBuf + $2
    inc [hl]
    ld hl, wWorkBuf
    inc [hl]
    xor a
    ld [wWorkBuf + $1], a
    ret

SECTION "Bank E0 FillVRAMRectWithTileSequence", ROMX

; A = first tile number, B = width, C = rows, HL = VRAM address, DE = row stride: writes consecutive
; tile numbers (A increases by 1 for every cell, across rows) with WriteVRAMByteInc, interrupts off
; per byte, and moves to the next row by adding DE to the row start. A ends one past the last tile.
; Called by DebugStaffRoll_Credits_ShowLines and DebugStaffRoll_Credits_TitleCard. (C1, E-0385)
; A = first tile, B = width, C = rows, HL = VRAM address, DE = row stride: writes consecutive tile
; numbers with WriteVRAMByteInc (interrupts off per byte), adding DE to the row start after each
; row; A ends past the last tile (E-0077)
FillVRAMRectWithTileSequence::
    push bc
    push hl

.loop:
    di
    call WriteVRAMByteInc
    ei
    inc a
    dec b
    jr nz, .loop
    pop hl
    pop bc
    add hl, de
    dec c
    jr nz, FillVRAMRectWithTileSequence
    ret

SECTION "Bank E0 DrawSpriteSlots", ROMX

; Draws the staff roll sprites. With wSpriteSlotCount 0 it returns at once with A = 0 and Z set.
; Otherwise for each of the wSpriteSlotCount 8-byte slots at wSpriteSlots it sets hSpriteSetIndex =
; byte 1, hSpriteOriginX = byte 2 + 8, hSpriteOriginY = byte 3, hSpriteAttrXor = byte 4 and
; hSpriteTileOffset = byte 6, and hSpriteSubIndex: for a kind 2 slot (byte 0) the facing byte 5 as
; it is, for other kinds 2 * facing + 1 if bit 5 of the counter (byte 7) is set, else 2 * facing,
; where facing code 3 counts as 1 and adds $20 to hSpriteAttrXor. It then far-calls the drawing
; routine for byte 0 from DrawSpriteSlots_Data: DrawMetaSpriteSet_Bank25 for kind 0,
; DrawMetaSprite_Sets98 for kind 1 and DrawMetaSprite for kind 2. HL ends as wSpriteSlots + 8 *
; count. Called first by every staff roll scene step after its Load step. (C2, E-0385)
; for each of the wSpriteSlotCount 8-byte slots at wSpriteSlots: loads hSpriteSetIndex,
; hSpriteOriginX (+8), hSpriteOriginY, hSpriteAttrXor, hSpriteTileOffset and hSpriteSubIndex from
; the slot, then far-calls the routine chosen by the slot's first byte from the 3-byte entries at
; $7477
DrawSpriteSlots::
    ld a, [wSpriteSlotCount]
    or a
    ret z
    ld b, a
    ld hl, wSpriteSlots

.loop:
    push bc
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ldh [hSpriteSetIndex], a
    ld a, [hli]
    add $08
    ldh [hSpriteOriginX], a
    ld a, [hli]
    ldh [hSpriteOriginY], a
    ld a, [hli]
    ldh [hSpriteAttrXor], a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ldh [hSpriteTileOffset], a
    ld a, [hli]
    ld e, a
    ld a, c
    cp $02
    ld a, b
    jr z, .set_sprite_sub_index2
    ld a, e
    and $20
    srl a
    swap a
    ld e, a
    ld a, b
    cp $03
    jr nz, .set_sprite_sub_index
    ldh a, [hSpriteAttrXor]
    or $20
    ldh [hSpriteAttrXor], a
    ld a, $01

.set_sprite_sub_index:
    add a
    add e

.set_sprite_sub_index2:
    ldh [hSpriteSubIndex], a
    ld b, $00
    push hl
    ld hl, DrawSpriteSlots_Data
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, [hl]
    ld l, e
    ld h, d
    rst $10
    pop hl
    pop bc
    dec b
    jr nz, .loop
    ret

SECTION "Bank E0 DrawSpriteSlots_Data", ROMX

; Three 3-byte far-call entries, a code address word then a ROM bank: $4001 in bank $25
; (DrawMetaSpriteSet_Bank25), $4001 in bank $7F (DrawMetaSprite_Sets98) and $700A in bank $7F
; (DrawMetaSprite). DrawSpriteSlots indexes it with byte 0 of each 8-byte slot in wSpriteSlots (0, 1
; or 2), loads HL and B from the entry and calls it with rst $10 to draw the slot. (C1, E-0381)
; DrawSpriteSlots calls entry (slot byte 0) through rst $10; read as raw bytes until the same scan
; (E-0401, C1)
; record: far call to the routine that draws a slot of this kind
DrawSpriteSlots_Data::
    dfar DrawMetaSpriteSet_Bank25 ; id 0
    dfar DrawMetaSprite_Sets98 ; id 1
    dfar DrawMetaSprite ; id 2

; Adds 1 to byte 7, the animation counter, of each of the 8 slots at wSpriteSlots (an $FF wraps to
; 0); the other bytes are left alone. Called every frame by DebugStaffRoll_Update_RunScene before
; the scene step. (C2, E-0385)
; adds 1 to byte 7 of each of the 8 slots at wSpriteSlots
IncrementSpriteSlotCounters::
    ld b, $08
    ld hl, wSpriteSlots

.loop:
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc [hl]
    inc hl
    dec b
    jr nz, .loop
    ret

SECTION "Bank E0 StepSpriteSlotToward", ROMX

; A = slot 0-7 (the 8-byte slot at wSpriteSlots + 8 * A), D = target X, E = target Y: moves the slot
; X (byte 2) and Y (byte 3) one pixel toward D and E (a coordinate that already matches stays) and
; always adds 1 to the counter in byte 7. Returns A = 1 with Z clear when either coordinate moved, A
; = 0 with Z set when the slot is at the target. D and E are kept, so a caller can call it again for
; the same target. Used by the staff roll walking steps. (C2, E-0385)
; A = slot number, D = target X, E = target Y: moves the slot's X and Y bytes one step toward the
; target and adds 1 to its byte 7; returns A = 1 (non-zero) if either moved
StepSpriteSlotToward::
    ld c, $00
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    ld a, [hl]
    cp d
    jr z, .next
    jr c, .skip
    dec a
    jr .skip2

.skip:
    inc a

.skip2:
    ld [hl], a
    ld c, $01

.next:
    inc hl
    ld a, [hl]
    cp e
    jr z, .next2
    jr c, .skip3
    dec a
    jr .skip4

.skip3:
    inc a

.skip4:
    ld [hl], a
    ld c, $01

.next2:
    inc hl
    inc hl
    inc hl
    inc hl
    inc [hl]
    ld a, c
    or a
    ret

SECTION "Bank E0 SetSpriteSlotByte5", ROMX

; A = slot 0-7, C = value: stores C in byte 5 of that slot (the facing code that DrawSpriteSlots
; turns into a sub-index). The other bytes and slots are untouched. Used by the staff roll turn
; steps. (C2, E-0385)
; A = slot number: byte 5 of the slot = C
SetSpriteSlotByte5::
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], c
    ret

SECTION "Bank E0 StepSpriteSlotTowardDE", ROMX

; A = slot, D = target X, E = target Y: when X differs from D it moves by the step Data1[wWorkBuf +
; $A] (StepSpriteSlotTowardDE_Data1: 1 pixel for 8 entries, then 2) toward D; when Y differs from E
; it SUBTRACTS Data2[wWorkBuf + $A] (2 pixels for 4 entries, then 1) whatever side of E it is on,
; and adds 1 to wWorkBuf + $A. Returns A = 1 with Z clear if either was not at its target, A = 0
; with Z set otherwise. Unlike StepSpriteSlotToward it does not touch byte 7. Its only user is
; DebugStaffRoll_Scene00_WalkSprite2. (C2, E-0385)
; moves sprite slot A's position bytes toward D and E by the steps $7535/$7542 indexed by wWorkBuf +
; $A; NZ while still moving (E-0127)
StepSpriteSlotTowardDE::
    ld c, $00
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    cp d
    jr z, .next
    jr c, .read_work_buf
    push hl
    ld a, [wWorkBuf + $a]
    ld hl, StepSpriteSlotTowardDE_Data1
    add_a_to_hl
    ld a, b
    sub [hl]
    pop hl
    ld [hl], a
    jr .skip

.read_work_buf:
    push hl
    ld a, [wWorkBuf + $a]
    ld hl, StepSpriteSlotTowardDE_Data1
    add_a_to_hl
    ld a, b
    add [hl]
    pop hl
    ld [hl], a

.skip:
    ld c, $01

.next:
    inc hl
    ld a, [hl]
    cp e
    jr z, .done
    ld b, a
    push hl
    ld a, [wWorkBuf + $a]
    ld hl, StepSpriteSlotTowardDE_Data2
    add_a_to_hl
    ld a, b
    sub [hl]
    pop hl
    ld [hl], a
    ld a, [wWorkBuf + $a]
    inc a
    ld [wWorkBuf + $a], a
    ld c, $01

.done:
    ld a, c
    or a
    ret

SECTION "Bank E0 StepSpriteSlotTowardDE_Data1", ROMX

; Thirteen step sizes in pixels: $01 x8, $02 x4, then $00. StepSpriteSlotTowardDE moves byte 2 of
; the sprite slot (its X) toward D by the entry at wWorkBuf + $A on each call where X differs, so
; the walk speeds up from 1 to 2 pixels per call; wWorkBuf + $A is advanced only by the Y step. (C1,
; E-0381)
StepSpriteSlotTowardDE_Data1::
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $00

; Thirteen step sizes in pixels: $02 x4, $01 x8, then $00. StepSpriteSlotTowardDE subtracts the
; entry at wWorkBuf + $A from byte 3 of the sprite slot (its Y) while Y differs from E, then
; increments wWorkBuf + $A, so the move slows from 2 to 1 pixel per call. The Y step only subtracts,
; it never adds. (C1, E-0381)
StepSpriteSlotTowardDE_Data2::
    db $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01, $01, $00

; Adds 1 to the wait counter wWorkBuf + 5; below 15 it returns with carry set and Z clear (the
; caller keeps waiting, ret nz), and when the value reaches 15 it resets the counter to 0 and
; returns with Z set. A wait of 15 calls for the staff roll steps. (C2, E-0385)
; wWorkBuf + $5 += 1, reset to 0 when it reaches 15 (E-0340: the address in its name read as its RAM
; name; was StepWorkBuf5Mod15)
StepWorkBuf5Mod15::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $0f
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

SECTION "Bank E0 StepWorkBuf5Mod30", ROMX

; Adds 1 to the wait counter wWorkBuf + 5; below 30 it returns with carry set and Z clear (the
; caller keeps waiting, ret nz), and when the value reaches 30 it resets the counter to 0 and
; returns with Z set. A wait of 30 calls for the staff roll steps. (C2, E-0385)
; wWorkBuf + $5 += 1, reset to 0 when it reaches 30 (E-0340: the address in its name read as its RAM
; name; was StepWorkBuf5Mod30)
StepWorkBuf5Mod30::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $1e
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

SECTION "Bank E0 StepWorkBuf5Mod45", ROMX

; Adds 1 to the wait counter wWorkBuf + 5; below 45 it returns with carry set and Z clear (the
; caller keeps waiting, ret nz), and when the value reaches 45 it resets the counter to 0 and
; returns with Z set. A wait of 45 calls for the staff roll steps. (C2, E-0385)
; wWorkBuf + $5 += 1, reset to 0 when it reaches 45 (E-0340: the address in its name read as its RAM
; name; was StepWorkBuf5Mod45)
StepWorkBuf5Mod45::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $2d
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

SECTION "Bank E0 StepWorkBuf5Mod60", ROMX

; Adds 1 to the wait counter wWorkBuf + 5; below 60 it returns with carry set and Z clear (the
; caller keeps waiting, ret nz), and when the value reaches 60 it resets the counter to 0 and
; returns with Z set. A wait of 60 calls for the staff roll steps. (C2, E-0385)
; wWorkBuf + $5 += 1, reset to 0 when it reaches 60 (E-0340: the address in its name read as its RAM
; name; was StepWorkBuf5Mod60)
StepWorkBuf5Mod60::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $3c
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

SECTION "Bank E0 FillBGMapRectWithAWrapped", ROMX

; A = tile, B = width, C = rows, HL = BG map address: writes A over the B x C rectangle (waiting for
; VRAM access per cell), wrapping the column within its 32-cell row and the row within the 32 rows
; of the map. Called by DebugStaffRoll_Credits_ShowLines and DebugStaffRoll_Credits_TitleCard. (C1,
; E-0385)
; writes A over a B x C rectangle of the BG map at HL, wrapping columns and rows (E-0125)
FillBGMapRectWithAWrapped::
    push bc
    push hl

.loop:
    di
    push af
    call WaitForVRAMAccess
    pop af
    ld [hl], a
    ei
    push af
    ld a, l
    push af
    inc l
    ld a, l
    and $1f
    ld l, a
    pop af
    and $e0
    or l
    ld l, a
    pop af
    dec b
    jr nz, .loop
    pop hl
    push af
    ld a, h
    and $9c
    ld c, a
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, h
    and $03
    or c
    ld h, a
    pop af
    pop bc
    dec c
    jr nz, FillBGMapRectWithAWrapped
    ret

SECTION "Bank E0 ResetScreenPalettes_E0", ROMX

; Sets the DMG palettes wDMGPaletteBGP, wDMGPaletteOBP0 and wDMGPaletteOBP1 to $D2, $D2 and $E2,
; copies them to wDMGPaletteBytes and resets the fade (ResetFadeFromDMGPaletteBGP). On a Super Game
; Boy (wSGBActive) it then blanks rBGP, rOBP0 and rOBP1, sets the four SGB palette numbers
; (wSGBPaletteNum0Lo/Hi to wSGBPaletteNum3Lo/Hi) to wSGBPaletteSet * 4 + 0..3, builds packet $B1
; with wSGBAttrFile in wSGBPacketBuffer, sends it (SendSGBPacketSet), loads the object palettes
; (LoadSGBObjectPalettesFromPointers) and copies the 8 bytes of ResetScreenPalettes_E0_Palette to
; wOBJPaletteBuffer + $20. Called by DebugStaffRoll_Credits_ShowLines and
; DebugStaffRoll_Credits_TitleCard. (C1, E-0385)
; sets the DMG palettes $D2/$D2/$E2 (also in wDMGPaletteBytes) and resets the fade; on the Super
; Game Boy blanks rBGP/rOBP, sends PAL_SET for wSGBPaletteSet and copies 8 bytes from $7641 to
; wOBJPaletteBuffer + $20 (E-0128)
ResetScreenPalettes_E0::
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    call ResetFadeFromDMGPaletteBGP
    ld a, [wSGBActive]
    or a
    jr z, .return
    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    ld a, $b1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $ff
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ld hl, ResetScreenPalettes_E0_Palette
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

.return:
    ret

SECTION "Bank E0 ResetScreenPalettes_E0_Palette", ROMX

; the routine before ResetScreenPalettes_E0.return copies these 8 bytes to wOBJPaletteBuffer + $20
; with CopyBytes (E-0213, C1)
; record: one CGB palette: 4 BGR555 colours
ResetScreenPalettes_E0_Palette::
    dw $67de, $331f, $123c, $0000 ; entry 0

; DebugStaffRoll_Credits_ShowLines reads word wWorkBuf + 2 - 1 of $7649 (ReadWordTableEntry_Bank00),
; stores the first byte in wWorkBuf + 4 and walks the rest as count/value pairs ($FE starts a
; section, $FF ends one); the five lists run to $76E0; the pair meaning is not read (E-0213, C1)
; record: sequence for wWorkBuf + 2 = id
WorkBufSequenceTable::
    dw WorkBufSequence001 ; id 1
    dw WorkBufSequence002 ; id 2
    dw WorkBufSequence003 ; id 3
    dw WorkBufSequence004 ; id 4
    dw WorkBufSequence005 ; id 5

; list for entry $01 of WorkBufSequenceTable; it runs to the next list (E-0199)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence001::
    db $05, $02, $00, $01, $00, $02, $01, $04, $01, $02, $02, $01, $02, $01, $03, $01, $03, $02, $04, $03, $04 ; id 0

; list for entry $02 of WorkBufSequenceTable; it runs to the next list (E-0199)
WorkBufSequence002::
    db $04, $01, $05, $00, $05, $fe, $02, $06, $01, $06, $01, $07, $01, $07, $02, $08, $01, $08, $ff, $01, $09, $03, $09, $01, $0a, $06, $0a ; id 0

; list for entry $03 of WorkBufSequenceTable; it runs to the next list (E-0199)
WorkBufSequence003::
    db $03, $fe, $02, $0b, $01, $0b, $02, $0c, $01, $0c, $01, $0d, $01, $0d, $ff, $01, $0e, $01, $0e, $01, $0f, $00, $0f ; id 0

; list for entry $04 of WorkBufSequenceTable; it runs to the next list (E-0199)
WorkBufSequence004::
    db $0b, $01, $10, $02, $10, $01, $11, $04, $11, $01, $12, $02, $12, $01, $13, $05, $13, $01, $14, $05, $14, $01, $15, $05, $15, $01, $16, $05, $16, $01, $17, $05, $17, $01, $18, $05, $18, $01, $19, $05, $19, $01, $1a, $05, $1a ; id 0

; list for entry $05 of WorkBufSequenceTable; it runs to the next list (E-0199)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence005::
    db $06, $02, $1b, $02, $1b, $01, $1c, $01, $1c, $02, $1d, $02, $1d, $01, $1e, $01, $1e, $00, $1f, $06, $1f, $01, $20, $00, $20 ; id 0

; If wStringCategory is 0 calls BeginStringDisplay with DE =
; BeginStringDisplay_BankE0_StringCategories (the staff roll strings of this bank); otherwise
; far-calls BeginStringDisplay_BankE0_FromBankA2Table. Called by ShowString_BankE0. (C1, E-0385)
; if wStringCategory < 1, BeginStringDisplay with DE = $76FC; otherwise far-calls
; BeginStringDisplay_BankE0_FromBankA2Table
BeginStringDisplay_BankE0::
    ld a, [wStringCategory]
    cp $01
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_BankE0_FromBankA2Table
    ret

.call_begin_string_display:
    ld de, BeginStringDisplay_BankE0_StringCategories
    call BeginStringDisplay
    ret

SECTION "Bank E0 ShowString_BankE0", ROMX

; Shows the string wStringIndex of category wStringCategory: BeginStringDisplay_BankE0, then
; RunStringDisplayToEnd. Used for the staff roll credits lines and the title card by
; DebugStaffRoll_Credits_ShowLines and DebugStaffRoll_Credits_TitleCard. (C1, E-0385)
; BeginStringDisplay_BankE0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_BankE0::
    call BeginStringDisplay_BankE0
    call RunStringDisplayToEnd
    ret

SECTION "Bank E0 BeginStringDisplay_BankE0_StringCategories", ROMX

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_BankE0_StringCategories::
    dw StringList_BankE0_StringCategories_0 ; id 0

; category list of BeginStringDisplay_BankE0_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_BankE0_StringCategories_0::
    dw String_E0_00_00 ; id 0
    dw String_E0_00_01 ; id 1
    dw String_E0_00_02 ; id 2
    dw String_E0_00_03 ; id 3
    dw String_E0_00_04 ; id 4
    dw String_E0_00_05 ; id 5
    dw String_E0_00_06 ; id 6
    dw String_E0_00_07 ; id 7
    dw String_E0_00_08 ; id 8
    dw String_E0_00_09 ; id 9
    dw String_E0_00_0A ; id 10
    dw String_E0_00_0B ; id 11
    dw String_E0_00_0C ; id 12
    dw String_E0_00_0D ; id 13
    dw String_E0_00_0E ; id 14
    dw String_E0_00_0F ; id 15
    dw String_E0_00_10 ; id 16
    dw String_E0_00_11 ; id 17
    dw String_E0_00_12 ; id 18
    dw String_E0_00_13 ; id 19
    dw String_E0_00_14 ; id 20
    dw String_E0_00_15 ; id 21
    dw String_E0_00_16 ; id 22
    dw String_E0_00_17 ; id 23
    dw String_E0_00_18 ; id 24
    dw String_E0_00_19 ; id 25
    dw String_E0_00_1A ; id 26
    dw String_E0_00_1B ; id 27
    dw String_E0_00_1C ; id 28
    dw String_E0_00_1D ; id 29
    dw String_E0_00_1E ; id 30
    dw String_E0_00_1F ; id 31
    dw String_E0_00_20 ; id 32

String_E0_00_00::
    db "EXECUTIVE DIRECTOR@"

String_E0_00_01::
    db "SCENARIO ", $b6, " GAME<LINE>"
    db "         DESIGNERS@"

String_E0_00_02::
    db "CHARACTER ", $b6, "<LINE>"
    db "  MONSTER DESIGNER@"

String_E0_00_03::
    db "  MUSIC COMPOSER@"

String_E0_00_04::
    db "LOCALIZATION<LINE>"
    db "       SPECIALISTS@"

String_E0_00_05::
    db " ENIX AMERICA INC.@"

String_E0_00_06::
    db "LOCALIZATION<LINE>"
    db "           MANAGER@"

String_E0_00_07::
    db "  PRODUCT MANAGER@"

String_E0_00_08::
    db "ASSISTANT<LINE>"
    db "   PRODUCT MANAGER@"

String_E0_00_09::
    db "   QA TRANSLATOR@"

String_E0_00_0A::
    db "   PLAY TESTERS@"

String_E0_00_0B::
    db "SALES/MARKETING<LINE>"
    db "MANAGER@"

String_E0_00_0C::
    db "ACCOUNTING/CREDIT<LINE>"
    db "MANAGER@"

String_E0_00_0D::
    db "    A/R ANALYST@"

String_E0_00_0E::
    db "     PRESIDENT@"

String_E0_00_0F::
    db " ENIX CORPORATION@"

String_E0_00_10::
    db "      ARTWORK@"

String_E0_00_11::
    db " TECHNICAL SUPPORT@"

String_E0_00_12::
    db " TECHNICAL SUPPORT@"

String_E0_00_13::
    db "   PLAY TESTERS@"

String_E0_00_14::
    db "   PLAY TESTERS@"

String_E0_00_15::
    db "   PLAY TESTERS@"

String_E0_00_16::
    db "   PLAY TESTERS@"

String_E0_00_17::
    db "   PLAY TESTERS@"

String_E0_00_18::
    db "   PLAY TESTERS@"

String_E0_00_19::
    db "   PLAY TESTERS@"

String_E0_00_1A::
    db "   PLAY TESTERS@"

String_E0_00_1B::
    db "    ASSISTANT<LINE>"
    db "      PRODUCERS@"

String_E0_00_1C::
    db "     PRODUCER@"

String_E0_00_1D::
    db "    EXECUTIVE<LINE>"
    db "      PRODUCERS@"

String_E0_00_1E::
    db "     PRESIDENT@"

String_E0_00_1F::
    db $f0

String_E0_00_20::
    db "    ©2001 ENIX@"

; A = battle slot: HL = the word at wBattleATK + 2 * A (through GetBattleStatWord_BankE0), A = its
; low byte. Nothing in src calls this bank-$E0 copy. (C2, E-0385)
; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (the bank-$E0 copy of
; the battle library, after a string; E-0213)
GetBattleATK_BankE0:: ; configured code entry (E-0213); C0
    ld hl, wBattleATK
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 GetBattleDEF_BankE0", ROMX

; Bank-$E0 copy of GetBattleDEF: HL = battle slot A's DEF word. (C2, E-0357; probed E-0385)
; the same 50 bytes as GetBattleDEF_Bank39 (GetBattleDEF_Bank39) (E-0060)
GetBattleDEF_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleDEF
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 GetBattleMaxHP_BankE0", ROMX

; Bank-$E0 copy of GetBattleMaxHP: HL = battle slot A's max HP word. (C2, E-0357; probed E-0385)
; the same 45 bytes as GetBattleMaxHP_Bank39 (GetBattleMaxHP_Bank39) (E-0060)
GetBattleMaxHP_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 GetBattleMaxMP_BankE0", ROMX

; Bank-$E0 copy of GetBattleMaxMP: HL = battle slot A's max MP word. (C2, E-0357; probed E-0385)
; the same 40 bytes as GetBattleMaxMP_Bank39 (GetBattleMaxMP_Bank39) (E-0060)
GetBattleMaxMP_BankE0:: ; configured code entry (E-0395 (traced before by the fall-through guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 GetBattleHP_BankE0", ROMX

; Bank-$E0 copy of GetBattleHP: HL = battle slot A's HP word. (C2, E-0357; probed E-0385)
; the same 35 bytes as GetBattleHP_Bank39 (GetBattleHP_Bank39) (E-0060)
GetBattleHP_BankE0:: ; configured code entry (E-0395 (traced before by the fall-through guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleHP
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 GetBattleMP_BankE0", ROMX

; Bank-$E0 copy of GetBattleMP: HL = battle slot A's MP word; 15 unreached bytes follow the jump
; (two more getters). (C2, E-0357; probed E-0385)
; the same 30 bytes as GetBattleMP_Bank39 (GetBattleMP_Bank39) (E-0060)
GetBattleMP_BankE0:: ; configured code entry (E-0395 (traced before by the fall-through guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleMP
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 GetBattleAGL_BankE0", ROMX

; HL = wBattleAGL, then GetBattleStatWord_BankE0: HL = the word at wBattleAGL + 2 x A (A = the
; battle slot). One of this bank's GetBattle* stat getters. No traced code, jump table or pointer
; reaches it (E-0395: it decodes as a routine but is unreached in the static listing). (C2, E-0395;
; probed E-0395)
; the same 25 bytes as GetBattleAGL_Bank39 (GetBattleAGL_Bank39) (E-0060)
GetBattleAGL_BankE0:: ; configured code entry (E-0395); C0
    ld hl, wBattleAGL
    jr GetBattleStatWord_BankE0

SECTION "Bank E0 ReadSlotAIModeIndexed_BankE0", ROMX

; A = the byte at wSlotAIMode + A, the AI mode of slot A. A copy of the routine of the same shape
; found in other banks. No traced code, jump table or pointer reaches it (E-0395: it decodes as a
; routine but is unreached in the static listing). (C2, E-0395; probed E-0395)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 13 banks)
ReadSlotAIModeIndexed_BankE0::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

SECTION "Bank E0 GetBattleStatWord_BankE0", ROMX

; HL = array base, A = battle slot: HL = the 16-bit word at HL + 2 * A (the value, not a pointer); A
; = its low byte. The shared tail of GetBattleATK_BankE0 through GetBattleMP_BankE0, the same bytes
; as ReadBattleWordFromArray in bank $36. (C2, E-0371; probed E-0385)
GetBattleStatWord_BankE0::
    add a
    add_a_to_hl
    deref_hl
    ret

SECTION "Bank E0 AddDoubleAToHL_BankE0", ROMX

; HL = HL + 2 * A. A is doubled in 8 bits first, so an A of $80 or more wraps ($81 adds 2); the
; carry out of L goes into H. A ends equal to the new L. This bank-$E0 copy of the 7-byte helper has
; no caller in src. (C2, E-0385)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    add a
    add_a_to_hl
    ret

SECTION "Bank E0 ActorOnLocalSide_BankE0", ROMX

; Carry set = the battle actor wBattleActor is in slots 0-3, carry clear = slots 4-7. In a link
; battle the answer is reversed (carry set for slots 4-7) when wLinkMode is 1 and bit 1 of wLinkRole
; is set; any other wLinkMode, including 2, leaves it unreversed. A ends holding wBattleActor. This
; bank-$E0 copy has no caller in src; which side is local is inferred from the reversal and is not
; checked. (C2, E-0385)
; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    ret

SECTION "Bank E0 TargetOnLocalSide_BankE0", ROMX

; Carry set = the battle target wBattleTarget is in slots 0-3, carry clear = slots 4-7. In a link
; battle the answer is reversed (carry set for slots 4-7) when wLinkMode is 1 and bit 1 of wLinkRole
; is set; any other wLinkMode, including 2, leaves it unreversed. A ends holding wBattleTarget. This
; bank-$E0 copy has no caller in src; which side is local is inferred from the reversal and is not
; checked. (C2, E-0385)
; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    ret

SECTION "Bank E0 ClearBattleStatusBitsWithMaskD_BankE0", ROMX

; ANDs status byte 0 of slot E (rows of nine bytes) with entry D of
; ClearBattleStatusBitsWithMaskD_BankE0_Data. (C2, E-0357; probed E-0385)
ClearBattleStatusBitsWithMaskD_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_BankE0_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

SECTION "Bank E0 ClearBattleStatusBitsWithMaskD_BankE0_Data", ROMX

; Seven AND masks indexed by D: $DF (clears bit 5), $FE (bit 0), $00 (all bits), $FD (bit 1), $73
; (bits 7, 3 and 2), $EF (bit 4) and $BF (bit 6). ClearBattleStatusBitsWithMaskD_BankE0 ANDs the
; chosen mask into the first byte of the 9-byte status record of slot E (wBattleStatus + 9 * E), the
; byte that holds the bits BSTAT0_POISONED to BSTAT0_ASLEEP. (C1, E-0381)
ClearBattleStatusBitsWithMaskD_BankE0_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A and leaves its other bits, the next byte and HL
; unchanged; A is clobbered (it ends as the low byte of that address). This bank-$E0 copy has no
; caller in src. (C2, E-0385)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

SECTION "Bank E0 SetBit1OfLevelUpGainsIndexed_BankE0", ROMX

; Sets bit 1 of the byte at wLevelUpGains + A and leaves its other bits, the next byte and HL
; unchanged; A is clobbered (it ends as the low byte of that address). This bank-$E0 copy has no
; caller in src. (C2, E-0385)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

SECTION "Bank E0 SetBit2OfLevelUpGainsIndexed_BankE0", ROMX

; Sets bit 2 of the byte at wLevelUpGains + A and leaves its other bits, the next byte and HL
; unchanged; A is clobbered (it ends as the low byte of that address). This bank-$E0 copy has no
; caller in src. (C2, E-0385)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

SECTION "Bank E0 PersonalityIndexOfSlot_BankE0", ROMX

; A = slot 0-7. Returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]), a number 0-26, where g(v) = 0 for v >= $C0, 1 for $40-$BF and 2 for v <
; $40; HL and BC are kept. Called by RunDebugState_E0_ChooseActionTargets_AIChoice, which stores the
; result in wPersonalityIndex before running the AI (ReadBank6TableWord reads the weight rows with
; that index), and by RunDebugState_E0_ChooseActionTargets_DrawDetails, which stores it as
; wStringIndex with wStringCategory = 7 to draw the personality name. (C2, E-0385)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_BankE0::
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip
    ld l, $09
    cp $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip2
    ld l, $03
    cp $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip3
    ld l, $01
    cp $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add b
    pop bc
    pop hl
    ret

SECTION "Bank E0 CheckSlotStatusBlockWide_BankE0", ROMX

; A = slot. Carry set when CheckSlotStatusBlock sets it (slot absent, or one of its status bits set)
; or when status byte 3 of the slot has a bit of $C0 set (BSTAT3_AIRBORNE, BSTAT3_AIRBORNE_HI) or
; status byte 4 has a bit of $0C set (BSTAT4_HIGH_JUMP, BSTAT4_HIGH_JUMP_HI); otherwise carry clear.
; A, BC and HL are kept. This bank-$E0 copy has no caller in src. (C2, E-0385)
; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .set_carry
    ld a, [hl]
    and $0c
    jr nz, .set_carry
    xor a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

SECTION "Bank E0 SlotHasStatus3Or4Bits_BankE0", ROMX

; A = slot. Z clear with A = status byte 3 & $C0 when byte 3 of the slot (wBattleStatus3 + 9 * A)
; has a bit of $C0 set; otherwise A = status byte 4 & $0C, so Z is clear only when byte 4 has a bit
; of $0C set. Byte 4 is not read when byte 3 matches. HL is kept. This bank-$E0 copy has no caller
; in src. (C2, E-0385)
; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_BankE0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .done
    ld a, [hl]
    and $0c

.done:
    pop hl
    ret
    ds $4f9, $00
