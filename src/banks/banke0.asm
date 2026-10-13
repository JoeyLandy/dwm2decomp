SECTION "Bank E0", ROMX[$4000], BANK[$E0]
    db $e0

; runs the routine for wDebugSubState (jump table of six) (E-0122)
RunDebugSubState_E0::
    ld a, [wDebugSubState]
    jumptable
    dw RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault
    dw RunDebugSubState_E0_WriteDebugSubStateAndDebugCursor
    dw RunDebugSubState_E0_WriteDebugSubStateAndDebugValue0
    dw RunDebugSubState_E0_WriteDebugSubStateAndDebugValue1
    dw RunDebugSubState_E0_WriteDebugSubStateAndBattleEndFlag
    dw RunDebugSubState_E0_SetDebugSubState

RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault::
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
    ld de, $42d3
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
    call RunDebugSubState_E0_WriteVRAMByte_Shared01
    call ShowSkillNumberAndName_BankE0
    call RunDebugSubState_E0_HLToDecimalDigits
    call RunDebugSubState_E0_WriteVRAMByte
    ld hl, wDebugSubState
    inc [hl]
    ld a, $bb
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

RunDebugSubState_E0_WriteDebugSubStateAndDebugCursor::
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
    call RunDebugSubState_E0_WriteVRAMByte_Shared01
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

RunDebugSubState_E0_WriteDebugSubStateAndDebugValue0::
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

RunDebugSubState_E0_WriteDebugSubStateAndDebugValue1::
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
    jr .call_run_debug_sub_state_e0_hl_to_decimal

.check_bit4:
    bit 4, a
    ret z
    ld a, [wDebugValue1]
    inc a
    ld [wDebugValue1], a

.call_run_debug_sub_state_e0_hl_to_decimal:
    call RunDebugSubState_E0_HLToDecimalDigits
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $122
    call WriteVRAMByte
    ret

RunDebugSubState_E0_WriteDebugSubStateAndBattleEndFlag::
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
    call RunDebugSubState_E0_WriteVRAMByte
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $bb
    call WriteVRAMByte
    ld a, $c3
    ld hl, vBGMap0 + $182
    call WriteVRAMByte
    ret

RunDebugSubState_E0_SetDebugSubState::
    xor a
    ld [wDebugSubState], a
    ld a, $03
    ld [wDebugState], a
    ret

RunDebugSubState_E0_WriteVRAMByte_Shared01::
    ld a, [wDebugCursor]
    and $01
    xor $01
    ld de, $41e6
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
    db $bb, $c3, $bb

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

RunDebugSubState_E0_HLToDecimalDigits::
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

RunDebugSubState_E0_WriteVRAMByte::
    ld a, [wBattleEndFlag]
    and $01
    xor $01
    ld de, $41e6
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

; runs the routine for wDebugState (jump table of fourteen) (E-0122)
RunDebugState_E0::
    ld a, [wDebugState]
    jumptable
    dw RunDebugState_E0_ShowStringBank09AtTilesHL_BankE0
    dw RunDebugState_E0_DrawSlotHPMPStats_BankE0
    dw RunDebugState_E0_DrawFullScreenFromBankE0_5283
    dw RunDebugState_E0_WriteVRAMByteInc
    dw RunDebugState_E0_ToDrawTileMap4946AndStep
    dw RunDebugState_E0_DrawPacked2BitFieldsInRows
    dw RunDebugState_E0_WaitJoypadPressed
    dw DrawTileMap4946AndStep
    dw RunDebugState_E0_DrawEightBytesAsHexColumns
    dw RunDebugState_E0_WaitJoypadPressed_Case09
    dw RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0_Case0A
    dw RunDebugState_E0_BlinkWC0A0Tile
    dw RunDebugState_E0_ToRunDebugSubState_E0
    dw RunDebugState_E0_ChooseActionTargets

RunDebugState_E0_ShowStringBank09AtTilesHL_BankE0::
    ld hl, vTiles1 + $6d0
    ld de, $2301
    ld a, $02
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankE0
    call DrawFullScreenFromBankE0_511B
    ld hl, $448a
    ld a, [wDebugSubState]
    add a
    add_a_to_hl
    deref_hl
    ld a, $bb
    call WriteVRAMByte
    ld hl, wDebugState
    inc [hl]
    ret
    db $24, $98, $2a, $98

RunDebugState_E0_DrawSlotHPMPStats_BankE0::
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
    call RunDebugState_E0_Case01_WordAtDEToPackedBCD
    ld hl, wDebugState
    inc [hl]
    ret

; C = slot: unless its wBattleSlotOut entry is $FF, draws its HP, max HP, MP and max MP words
; (DrawSlotHPMPStats_BankE0_IndexWordC for each) at the position from the table at $4652 (C & 3);
; the rest is not read (E-0112)
DrawSlotHPMPStats_BankE0::
    ld a, c
    and $03
    ld hl, $4652
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
    call DrawSlotHPMPStats_BankE0_Number24ToPackedBCD
    ld de, wBattleATK
    call DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD
    ld de, wBattleDEF
    call DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD
    ld de, wBattleAGL
    call DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD
    ld de, wBattleINT
    call DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD
    ld de, wSlotPersonalityHi
    call DrawSlotHPMPStats_BankE0_Number24ToPackedBCD
    ld de, wSlotPersonalityMid
    call DrawSlotHPMPStats_BankE0_Number24ToPackedBCD
    ld de, wSlotPersonalityLo
    call DrawSlotHPMPStats_BankE0_Number24ToPackedBCD
    ld de, wSlotTrait
    call DrawSlotHPMPStats_BankE0_Number24ToPackedBCD
    dec hl
    ld de, wBattleWordArray3F
    call DrawSlotHPMPStats_BankE0_IndexWordC
    call DrawSlotHPMPStats_BankE0_DrawAIModeGlyph
    call DrawSlotHPMPStats_BankE0_WriteVRAMByte
    ret

.clear_temp0:
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04
    inc hl
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03
    dec hl
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04
    ret

DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD::
    ld a, c
    add a
    add e
    ld e, a
    jr nc, .call_word_at_de_to_packed_bcd
    inc d

.call_word_at_de_to_packed_bcd:
    call WordAtDEToPackedBCD
    jr DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03

DrawSlotHPMPStats_BankE0_Number24ToPackedBCD::
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

DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03::
    ld b, $00
    push hl
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; DE += 2 * C, then falls into the BCD conversion of the word
DrawSlotHPMPStats_BankE0_IndexWordC::
    ld a, c
    add a
    add e
    ld e, a
    jr nc, RunDebugState_E0_Case01_WordAtDEToPackedBCD
    inc d

RunDebugState_E0_Case01_WordAtDEToPackedBCD::
    call WordAtDEToPackedBCD

DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04::
    push hl
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte::
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

DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte::
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

; writes the glyph for the slot's wSlotAIMode at the slot's BG address
DrawSlotHPMPStats_BankE0_DrawAIModeGlyph::
    ld a, c
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, $465e
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, c
    and $03
    ld hl, $4658
    add a
    add_a_to_hl
    deref_hl
    pop af
    call WriteVRAMByte
    ret

DrawSlotHPMPStats_BankE0_WriteVRAMByte::
    ld a, c
    ld de, wSlotNameSuffix
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, c
    and $03
    ld hl, $464c
    add a
    add_a_to_hl
    deref_hl
    ld a, [de]
    and $01
    add $cc
    call WriteVRAMByte
    ret
    db $c6, $98, $cc, $98, $d2, $98, $42, $98, $48, $98, $4e, $98, $46, $99, $4c, $99
    db $52, $99, $0b, $0a, $09, $08, $ef

RunDebugState_E0_DrawFullScreenFromBankE0_5283::
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
    call DrawFullScreenFromBankE0_5283
    call DrawSkillByte0AndRun502BAnd53B9
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

RunDebugState_E0_WriteVRAMByteInc::
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

RunDebugState_E0_ToDrawTileMap4946AndStep::
    call DrawTileMap4946AndStep
    ret

RunDebugState_E0_DrawPacked2BitFieldsInRows::
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

; writes a run of 2-bit fields from [DE] onward as digit tiles with the four DrawBitsNN routines,
; five per row, moving HL to the next BG map row (+$1B) after each five; the end is not read
; (E-0112)
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
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; DE += 1, then writes bits 7-6 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc)
; (E-0112)
DrawBits76OfNextDEAsDigit::
    inc de
    ld a, [de]
    rlca
    rlca
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; writes bits 5-4 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
DrawBits54OfDEAsDigit::
    ld a, [de]
    swap a
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; writes bits 3-2 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
DrawBits32OfDEAsDigit::
    ld a, [de]
    rrca
    rrca
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; writes bits 1-0 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
DrawBits10OfDEAsDigit::
    ld a, [de]

DrawBits10OfDEAsDigit_CallWriteVRAMByteInc::
    and $03
    add $e0
    call WriteVRAMByteInc
    ret

RunDebugState_E0_WaitJoypadPressed::
    ld a, [wJoypadPressed]
    and $01
    ret z
    xor a
    ld [wDebugState], a
    ret

; writes the 20 x 16 tile map $4946 to vBGMap0 + $20, then wDebugState += 1 (E-0124)
DrawTileMap4946AndStep::
    ld de, $4946
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

RunDebugState_E0_DrawEightBytesAsHexColumns::
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
    call Run48B7ForThreeBattlerRecords
    ld hl, wDebugState
    inc [hl]
    ret

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

; runs Run48B7ForThreeBattlerRecords_Number24ToPackedBCD for B = 0, 1, 2 on the 78-byte records from
; wBattlerRecords + $18 + 3 * $4E (E-0122)
Run48B7ForThreeBattlerRecords::
    ld de, $004e
    ld hl, wBattlerRecords + BATTLER_EXP
    add hl, de
    add hl, de
    add hl, de
    ld b, $00
    call Run48B7ForThreeBattlerRecords_Number24ToPackedBCD
    add hl, de
    ld b, $01
    call Run48B7ForThreeBattlerRecords_Number24ToPackedBCD
    add hl, de
    ld b, $02
    call Run48B7ForThreeBattlerRecords_Number24ToPackedBCD
    ret

Run48B7ForThreeBattlerRecords_Number24ToPackedBCD::
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
    ld hl, $4935
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
    db $e2, $99, $e8, $99, $ee, $99

RunDebugState_E0_WaitJoypadPressed_Case09::
    ld a, [wJoypadPressed]
    and $02
    ret z
    xor a
    ld [wDebugState], a
    ret
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

RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0_Case0A::
    ld a, [wEffectId]
    cp $ff
    jr z, .check_joypad_pressed
    farcall RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0
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
    jr z, DrawHexByteAtBGMap8A_CheckJoypadPressed
    ld hl, wDebugSubState
    dec [hl]
    ld a, [hl]
    cp $ff
    jr nz, DrawHexByteAtBGMap8A
    ld a, $3b
    ld [hl], a

; writes A as two hex-digit tiles (0-9 as $E0 + n, 10-15 as n - 2): the low digit at vBGMap0 + $8A,
; then the high digit (the second write is not read to its end) (E-0112)
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
    call DrawSkillByte0AndRun502BAnd53B9
    ret

DrawHexByteAtBGMap8A_CheckJoypadPressed::
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    farcall DrawHexByteAtBGMap8A_FillBytes
    call DrawHexByteAtBGMap8A_QueueSoundEffect
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $04
    jr z, DrawHexByteAtBGMap8A_CheckJoypadPressed2
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
    call DrawHexByteAtBGMap8A_ToCopyRectFromBankToVRAM
    call DrawSlotStatusBitsDebug
    xor a
    ld [wDebugCounter], a
    call ReadBGTileAtDebugCounterCell
    ret

DrawHexByteAtBGMap8A_CheckJoypadPressed2::
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

RunDebugState_E0_BlinkWC0A0Tile::
    call BlinkWC0A0Tile
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
    jr z, .skip8
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
    ld de, $4c76
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
    ld de, $4c6e
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

.skip8:
    jp DrawHexByteAtBGMap8A_CheckJoypadPressed2
    db $fe, $fd, $fb, $f7, $ef, $df, $bf, $7f, $01, $02, $04, $08, $10, $20, $40, $80

; writes either $C3 (bit 3 of wFrameCounterLo clear) or wMenuRowCount at the VRAM address in
; wTemp0/1 (E-0122)
BlinkWC0A0Tile::
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

RunDebugState_E0_ToRunDebugSubState_E0::
    call RunDebugSubState_E0
    ret

; debug battle state $0D: shows a string, reads the slot's personality and, for an actor without a
; target, far-calls ChooseActionTarget
RunDebugState_E0_ChooseActionTargets::
    ld a, [wDebugSubState]
    jumptable
    dw RunDebugState_E0_ChooseActionTargets_ShowStringBank08AtTilesHLThenDefault_BankE0
    dw RunDebugState_E0_ChooseActionTargets_PersonalityIndexOfSlot_BankE0
    dw RunDebugState_E0_ChooseActionTargets_WriteDebugSubState
    dw RunDebugState_E0_ChooseActionTargets_WriteDebugSubStateAndBattleActor
    dw RunDebugState_E0_ChooseActionTargets_WriteBattleActorAndDebugSubStateEtc
    dw RunDebugState_E0_ChooseActionTargets_WriteDebugSubState_Case05

RunDebugState_E0_ChooseActionTargets_ShowStringBank08AtTilesHLThenDefault_BankE0::
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
    ld de, DebugScreenLayout_E0_4D95
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

RunDebugState_E0_ChooseActionTargets_PersonalityIndexOfSlot_BankE0::
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_BankE0
    ld [wPersonalityIndex], a
    farcall RunDebugState_E0_ChooseActionTargets_Case01_WriteRandomLoAndRandomHiEtc
    ld a, $02
    ld [wDebugSubState], a
    ret

RunDebugState_E0_ChooseActionTargets_WriteDebugSubState::
    farcall RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor
    ld a, $03
    ld [wDebugSubState], a
    ret

RunDebugState_E0_ChooseActionTargets_WriteDebugSubStateAndBattleActor::
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

RunDebugState_E0_ChooseActionTargets_WriteBattleActorAndDebugSubStateEtc::
    xor a
    ld [wBattleActor], a
    ld [wDebugSubState], a
    ld a, $03
    ld [wDebugState], a
    ld a, $ff
    ld hl, wBattleActionChoice
    ld bc, $0010
    jp FillBytes

RunDebugState_E0_ChooseActionTargets_WriteDebugSubState_Case05::
    farcall RunDebugState_E0_ChooseActionTargets_Case05_AIChooseActionForActor
    ld a, $02
    ld [wDebugSubState], a
    ret

; a debug screen routine copies 20 x 18 bytes (BC = $1412) from $4D95 to vBGMap0 row by row with
; WriteVRAMByteInc (E-0213, C1)
; record: 20 x 18 tiles, one row per line
DebugScreenLayout_E0_4D95::
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

; copies a 4 x 1 tile strip from bank $E0 (address from the word table at $4F9E + 2 * A) to vBGMap0
; + $27 (CopyRectFromBankToVRAM) (E-0118)
DrawFourTileStripForA::
    add a
    ld hl, $4f9e
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0 + $27
    ld bc, $0401
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret
    dw PointerRun_E0_4F9E_Entry00
    dw PointerRun_E0_4F9E_Entry01
    dw PointerRun_E0_4F9E_Entry02
    dw PointerRun_E0_4F9E_Entry03
    dw PointerRun_E0_4F9E_Entry04
    dw PointerRun_E0_4F9E_Entry05
    dw PointerRun_E0_4F9E_Entry06
    dw PointerRun_E0_4F9E_Entry07

PointerRun_E0_4F9E_Entry00::
    db $f5, $f6, $f7, $e0

PointerRun_E0_4F9E_Entry01::
    db $f5, $f6, $f7, $e1

PointerRun_E0_4F9E_Entry02::
    db $f5, $f6, $f7, $e2

PointerRun_E0_4F9E_Entry03::
    db $f5, $f6, $f7, $e3

PointerRun_E0_4F9E_Entry04::
    db $f8, $f9, $e0, $c3

PointerRun_E0_4F9E_Entry05::
    db $f8, $f9, $e1, $c3

PointerRun_E0_4F9E_Entry06::
    db $f8, $f9, $e2, $c3

PointerRun_E0_4F9E_Entry07::
    db $f8, $f9, $e3, $c3

; DrawSkillRecordByte0DigitsForDebugValue0, DrawSkillByte0AndRun502BAnd53B9_LoadSkillRecord, then
; far-calls DrawSkillByte0AndRun502BAnd53B9_WriteBattleArg0AndBattleArg1Etc (E-0122)
DrawSkillByte0AndRun502BAnd53B9::
    call DrawSkillRecordByte0DigitsForDebugValue0
    call DrawSkillByte0AndRun502BAnd53B9_LoadSkillRecord
    farcall DrawSkillByte0AndRun502BAnd53B9_WriteBattleArg0AndBattleArg1Etc
    ret

; loads skill wDebugValue0's first record byte (LoadSkillRecordPart) and writes it as three digit
; tiles at vBGMap0 + $204 (E-0121)
DrawSkillRecordByte0DigitsForDebugValue0::
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

DrawSkillByte0AndRun502BAnd53B9_LoadSkillRecord::
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

; copies a 20 x 18 tile map from E0:$511B to vBGMap0 (CopyRectFromBankToVRAM) (E-0116)
DrawFullScreenFromBankE0_511B::
    ld hl, vBGMap0
    ld de, $511b
    ld bc, $1412
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

; copies a 20 x 18 tile map from E0:$5283 to vBGMap0 (E-0116)
DrawFullScreenFromBankE0_5283::
    ld hl, vBGMap0
    ld de, $5283
    ld bc, $1412
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

DrawHexByteAtBGMap8A_ToCopyRectFromBankToVRAM::
    ld hl, vBGMap0
    ld de, $53eb
    ld bc, $1412
    ld a, $e0
    call CopyRectFromBankToVRAM
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
TileRect_E0_511B::
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

TileRect_E0_5283::
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

TileRect_E0_53EB::
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

DrawHexByteAtBGMap8A_QueueSoundEffect::
    ld a, [wDebugSubState]
    ld hl, DebugSoundEffectList
    add_a_to_hl
    ld a, [hl]
    call QueueSoundEffect
    ret

; loads wBattleActor, wBattleTarget, wBattleActionId and wEffectFlags2 from the 4-byte entry A of
; the table at $55FB, then far-calls SelectEffectByEffectFlags2Flags (a test or debug entry list)
; (E-0118)
RunEffectTestEntryA::
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

; DrawHexByteAtBGMap8A_Sub03 (debug menu) plays QueueSoundEffect with the byte at $55BF +
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

RunDebugState_E0_ChooseActionTargets_Case01_WriteRandomLoAndRandomHiEtc::
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

RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor::
    call DisplayedSlotOfActor
    ld hl, $5a05
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
    call ShowStringBank08AtTilesHLThenDefault_BankE0_5A79

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
    call ShowStringBank08AtTilesHLThenDefault_BankE0_5A79
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
    call ShowStringBank08AtTilesHLThenDefault_BankE0_5A79
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
    ld hl, $5a05
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
    ld de, $fffc
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
    dw PointerRun_E0_5A05_Entry00
    dw PointerRun_E0_5A05_Entry01
    dw PointerRun_E0_5A05_Entry02
    dw PointerRun_E0_5A05_Entry03
    dw PointerRun_E0_5A05_Entry04
    dw PointerRun_E0_5A05_Entry05
    dw PointerRun_E0_5A05_Entry06
    dw PointerRun_E0_5A05_Entry07

PointerRun_E0_5A05_Entry00::
    db $80, $81, $82, $01

PointerRun_E0_5A05_Entry01::
    db $80, $81, $82, $02

PointerRun_E0_5A05_Entry02::
    db $80, $81, $82, $03

PointerRun_E0_5A05_Entry03::
    db $80, $81, $82, $04

PointerRun_E0_5A05_Entry04::
    db $83, $84, $01, $c3

PointerRun_E0_5A05_Entry05::
    db $83, $84, $02, $c3

PointerRun_E0_5A05_Entry06::
    db $83, $84, $03, $c3

PointerRun_E0_5A05_Entry07::
    db $83, $84, $04, $c3

RunDebugState_E0_ChooseActionTargets_Case05_AIChooseActionForActor::
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

; sets the string window to HL (tile destination) and DE (size), far-calls ShowString_Bank08, then
; sets the window to vTiles1 with size word $1202 (E-0067) (the same 45 bytes appear in 2 banks)
ShowStringBank08AtTilesHLThenDefault_BankE0_5A79::
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

; the same 45 bytes as ShowStringBank09AtHLSizeDEThenDefault (ShowStringBank09AtHLSizeDEThenDefault)
ShowStringBank09AtHLSizeDEThenDefault_BankE0::
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

DebugStaffRoll_Update_RunFieldEventFieldEventKind::
    ld a, [wWorkBuf]
    or a
    jp z, DebugStaffRoll_Scene04_DrawSpriteSlots_Case08_CheckWorkBuf
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

; by wWorkBuf+1: decompresses the scene's graphics, then one DrawSpriteSlots step per frame step
DebugStaffRoll_Scene00::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene00_DecompressToVRAM
    dw DebugStaffRoll_Scene00_DrawSpriteSlots
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case02
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case03
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case04
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case05
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case0A
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case0B
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case0C
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case0E
    dw DebugStaffRoll_Scene00_DrawSpriteSlots_Case0F

DebugStaffRoll_Scene00_DecompressToVRAM::
    ld b, $7d
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7e
    ld de, Tiles0Plus300Gfx_7E_4F22
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $93
    ld de, AreaTileset0
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $46
    ld de, Map00Screens0_Y2X1
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $46
    ld de, Map00Attrs0_Y2X1
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $48
    ld de, BGPaletteBufferData_48_4001
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus18Data_7E_4C0D
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

DebugStaffRoll_Scene00_DrawSpriteSlots::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, $03
    ld de, $6050
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case02::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $a]
    inc a
    ld [wWorkBuf + $a], a
    and $01
    ret nz
    ld a, $03
    ld de, $6060
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $a], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case03::
    call DrawSpriteSlots
    ld a, $03
    ld de, $6050
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case04::
    call DrawSpriteSlots
    ld a, $00
    ld de, $6020
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case05::
    call DrawSpriteSlots
    ld a, $03
    ld de, $6040
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case06::
    call DrawSpriteSlots
    ld a, $02
    ld de, $6030
    call StepSpriteSlotTowardDE
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $a], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case09::
    call DrawSpriteSlots
    ld a, $02
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5040
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

DebugStaffRoll_Scene00_DrawSpriteSlots_Case0A::
    call DrawSpriteSlots
    ld a, $01
    ld de, $1040
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
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

DebugStaffRoll_Scene00_DrawSpriteSlots_Case0B::
    call DrawSpriteSlots
    ld a, $02
    ld de, $5000
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5000
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
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

DebugStaffRoll_Scene00_DrawSpriteSlots_Case0C::
    call DrawSpriteSlots
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $00
    ld de, $6030
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D::
    call DrawSpriteSlots
    ld a, $00
    ld de, $4030
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case0E::
    call DrawSpriteSlots
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case0F::
    call DrawSpriteSlots
    ld a, $00
    ld de, $4000
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4000
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
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

DebugStaffRoll_Scene00_DrawSpriteSlots_Case07::
    call DrawSpriteSlots
    ld a, $02
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene00_DrawSpriteSlots_Case08::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $a]
    inc a
    ld [wWorkBuf + $a], a
    and $01
    ret nz
    ld a, $02
    ld de, $6030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $6040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene01::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene01_DecompressToVRAM
    dw DebugStaffRoll_Scene01_DrawSpriteSlots
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case02
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case03
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case04
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case05
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case14
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case15
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case16
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case17
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case18
    dw DebugStaffRoll_Scene01_DrawSpriteSlots_Case19

DebugStaffRoll_Scene01_DecompressToVRAM::
    ld b, $7d
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $46
    ld de, Map02Tileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $46
    ld de, Map02Screens0_Y0X2
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $46
    ld de, Map02Attrs0_Y0X2
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $48
    ld de, BGPaletteBufferData_48_4081
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
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

DebugStaffRoll_Scene01_DrawSpriteSlots::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $01
    ld de, $6030
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case02::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, $5fe3
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, $5fe8
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
    db $03, $02, $03, $00, $03, $01, $00, $01, $02, $01

DebugStaffRoll_Scene01_DrawSpriteSlots_Case03::
    call DrawSpriteSlots
    ld a, $03
    ld [wSpriteSlotCount], a
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case04::
    call DrawSpriteSlots
    ld d, $60
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    call StepWD0A2Mod15
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
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret
    db $fe, $fe, $fe, $ff, $ff, $ff, $00, $00, $00, $00, $01, $01, $01, $02, $02, $02

DebugStaffRoll_Scene01_DrawSpriteSlots_Case05::
    call DrawSpriteSlots
    ld a, $02
    ld de, $6050
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case16::
    call DrawSpriteSlots
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    cp $20
    jr nc, .call_step_wd0_a2_mod15
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_wd0_a2_mod15:
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case14::
    call DrawSpriteSlots
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    ld de, $4030
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

DebugStaffRoll_Scene01_DrawSpriteSlots_Case15::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $02
    ld de, $3030
    call StepSpriteSlotToward
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case18::
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
    call StepWD0A2Mod15
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

DebugStaffRoll_Scene01_DrawSpriteSlots_Case19::
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
    call StepWD0A2Mod15
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

DebugStaffRoll_Scene01_DrawSpriteSlots_Case06::
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
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case09::
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
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case07::
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
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case08::
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
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

DebugStaffRoll_Scene01_DrawSpriteSlots_Case17::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_step_wd0_a2_mod15
    and $07
    ld c, a
    ld b, $00
    ld hl, $625e
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

.call_step_wd0_a2_mod15:
    call StepWD0A2Mod15
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $fd, $fe, $ff, $00, $00, $01, $02, $03

; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene02::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene02_DecompressToVRAM
    dw DebugStaffRoll_Scene02_DrawSpriteSlots
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case02
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case03
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case04
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case05
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case0A
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case0B
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case0C
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case0D
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case0E
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case0F
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case10
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case11
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case12
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case13
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case14
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case15
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case16
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case17
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case18
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case19
    dw DebugStaffRoll_Scene02_DrawSpriteSlots_Case1A

DebugStaffRoll_Scene02_DecompressToVRAM::
    ld b, $7d
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7e
    ld de, FieldSpriteGfx5F
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $21
    ld de, MonsterSprite_Watabou
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, $48
    ld de, Map18Tileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $48
    ld de, Map18Screens0_Y0X1
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $48
    ld de, Map18Attrs0_Y0X1
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $48
    ld de, BGPaletteBufferData_48_5138
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B2D
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $27
    ld de, OBJPaletteBufferPlus18Data_27_7850
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus20Data_7E_4B4D
    ld hl, wOBJPaletteBuffer + $20
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
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

DebugStaffRoll_Scene02_DrawSpriteSlots::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    ld de, $4070
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4080
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case02::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, $6490
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, $6495
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
    db $03, $02, $01, $02, $03, $01, $00, $03, $00, $01

DebugStaffRoll_Scene02_DrawSpriteSlots_Case03::
    call DrawSpriteSlots
    ld a, $02
    ld de, $4020
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case04::
    call DrawSpriteSlots
    ld a, $02
    ld de, $4030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4020
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

DebugStaffRoll_Scene02_DrawSpriteSlots_Case0A::
    call DrawSpriteSlots
    ld a, $04
    ld de, $5020
    call StepSpriteSlotToward
    ret nz
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case0B::
    call DrawSpriteSlots
    ld a, $04
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $05
    ld de, $5020
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case11::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_set_sprite_slot_byte5
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
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
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case16::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_step_wd0_a2_mod30
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
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

.call_step_wd0_a2_mod30:
    call StepWD0A2Mod30
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

DebugStaffRoll_Scene02_DrawSpriteSlots_Case17::
    call DrawSpriteSlots
    ld a, $04
    ld de, $5020
    call StepSpriteSlotToward
    ld a, $04
    call StepSpriteSlotToward
    ld a, $05
    ld de, $5010
    call StepSpriteSlotToward
    ld a, $05
    call StepSpriteSlotToward
    ret nz
    ld a, $05
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case18::
    call DrawSpriteSlots
    ld a, $04
    ld de, $5010
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
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case19::
    call DrawSpriteSlots
    ld a, $00
    ld de, $a070
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4070
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

DebugStaffRoll_Scene02_DrawSpriteSlots_Case05::
    call DrawSpriteSlots
    ld a, $02
    ld de, $3030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4030
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

DebugStaffRoll_Scene02_DrawSpriteSlots_Case06::
    call DrawSpriteSlots
    ld a, $02
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $3030
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case07::
    call DrawSpriteSlots
    ld a, $02
    ld de, $3050
    call StepSpriteSlotToward
    ld a, $03
    ld de, $3040
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case08::
    call DrawSpriteSlots
    ld a, $02
    ld de, $2050
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case09::
    call DrawSpriteSlots
    ld a, $02
    ld de, $2040
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
    call StepWD0A2Mod15
    ret nz
    ld a, $05
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case0C::
    call DrawSpriteSlots
    ld a, $04
    ld de, $6030
    call StepSpriteSlotToward
    ld a, $05
    ld de, $5030
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

DebugStaffRoll_Scene02_DrawSpriteSlots_Case0D::
    call DrawSpriteSlots
    ld a, $04
    ld de, $6040
    call StepSpriteSlotToward
    ld a, $05
    ld de, $6030
    call StepSpriteSlotToward
    ret nz
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case0E::
    call DrawSpriteSlots
    ld a, $04
    ld de, $6050
    call StepSpriteSlotToward
    ld a, $05
    ld de, $6040
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case0F::
    call DrawSpriteSlots
    ld a, $04
    ld de, $7050
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case10::
    call DrawSpriteSlots
    ld a, $04
    ld de, $7040
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $03
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case1A::
    call DrawSpriteSlots
    ld a, $01
    ld de, $a070
    call StepSpriteSlotToward
    ld a, $00
    ld de, $a070
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case12::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .call_step_wd0_a2_mod60
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_X]
    add [hl]
    ld [wObject2 + OBJ_X], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_wd0_a2_mod60:
    call StepWD0A2Mod60
    ret nz
    ld a, $05
    ld c, $01
    call SetSpriteSlotByte5
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case13::
    call DrawSpriteSlots
    call StepWD0A2Mod60
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

DebugStaffRoll_Scene02_DrawSpriteSlots_Case14::
    call DrawSpriteSlots
    call StepWD0A2Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene02_DrawSpriteSlots_Case15::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $07
    ret nz
    ld a, $04
    ld de, $7050
    call StepSpriteSlotToward
    ld a, $05
    ld de, $6050
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

; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene03::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene03_DecompressToVRAM
    dw DebugStaffRoll_Scene03_DrawSpriteSlots
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case02
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case03
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case04
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case05
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene03_DrawSpriteSlots_Case0A

DebugStaffRoll_Scene03_DecompressToVRAM::
    ld b, $7d
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx12
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx0E
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, $7e
    ld de, Tiles0Plus600Gfx_7E_52BC
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld b, $48
    ld de, Map19Tileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $48
    ld de, Map19Screens0_Y0X0
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jp z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $48
    ld de, Map19Attrs0_Y0X0
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $94
    ld de, BGPaletteBufferData_94_4001
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $48
    ld de, BGPaletteBufferData_48_5138
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus20Data_7E_4B4D
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B2D
    ld hl, wOBJPaletteBuffer + $20
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus28Data_7E_4B1D
    ld hl, wOBJPaletteBuffer + $28
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus30Data_7E_4C65
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

DebugStaffRoll_Scene03_DrawSpriteSlots::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    ld de, $4050
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4060
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene03_DrawSpriteSlots_Case02::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, $6490
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and $07
    ld hl, $6495
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

DebugStaffRoll_Scene03_DrawSpriteSlots_Case03::
    call DrawSpriteSlots
    call StepWD0A2Mod45
    ret nz
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene03_DrawSpriteSlots_Case04::
    call DrawSpriteSlots
    ld a, $00
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4050
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene03_DrawSpriteSlots_Case05::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .set_sprite_slot_count_to_05
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_X]
    add [hl]
    ld [wObject2 + OBJ_X], a
    ld a, [wWorkBuf + $6]
    srl a
    srl a
    ld hl, $6b06
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
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $03, $02, $01, $00

DebugStaffRoll_Scene03_DrawSpriteSlots_Case06::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .set_sprite_slot_count_to_04
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add [hl]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    ld a, [wWorkBuf + $6]
    srl a
    srl a
    ld hl, $6b52
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
    call StepWD0A2Mod30
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $02, $01, $00, $03

DebugStaffRoll_Scene03_DrawSpriteSlots_Case07::
    call DrawSpriteSlots
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    ld de, $5040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5030
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

DebugStaffRoll_Scene03_DrawSpriteSlots_Case08::
    call DrawSpriteSlots
    ld a, $02
    ld de, $50a0
    call StepSpriteSlotToward
    ld a, $03
    ld de, $50a0
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene03_DrawSpriteSlots_Case09::
    call DrawSpriteSlots
    ld a, $00
    ld de, $40a0
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene03_DrawSpriteSlots_Case0A::
    call DrawSpriteSlots
    ld a, $00
    ld de, $40a0
    call StepSpriteSlotToward
    ld a, $01
    ld de, $40b0
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

; as DebugStaffRoll_Scene00
DebugStaffRoll_Scene04::
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Scene04_DecompressToVRAM
    dw DebugStaffRoll_Scene04_DrawSpriteSlots
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case02
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case03
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case04
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case05
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case06
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case07
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case08
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case09
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case0A
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case0B
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case0C
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case0D
    dw DebugStaffRoll_Scene04_DrawSpriteSlots_Case0E

DebugStaffRoll_Scene04_DecompressToVRAM::
    ld b, $7d
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7d
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $49
    ld de, Map1ATileset
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $49
    ld de, Map1AScreens0_Y0X0
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $49
    ld de, Map1AAttrs0_Y0X0
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $49
    ld de, BGPaletteBufferData_49_52BB
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus20Data_7E_4B4D
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
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

DebugStaffRoll_Scene04_DrawSpriteSlots::
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $00
    ld de, $8040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $9040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
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

DebugStaffRoll_Scene04_DrawSpriteSlots_Case02::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $00
    ld de, $7040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $8040
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

DebugStaffRoll_Scene04_DrawSpriteSlots_Case03::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $02
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4040
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

DebugStaffRoll_Scene04_DrawSpriteSlots_Case09::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $20
    jr nc, .call_step_sprite_slot_toward
    and $1f
    ld c, a
    ld b, $00
    ld hl, $6e83
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
    ld de, $10a0
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
    ld hl, $6e83
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
    ld de, $3040
    call StepSpriteSlotToward

.check_work_buf:
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_sprite_slot_toward3:
    ld a, $03
    ld de, $10a0
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $fd, $fd, $fd, $fd, $fe, $fe, $fe, $fe, $ff, $ff, $ff, $ff, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03

DebugStaffRoll_Scene04_DrawSpriteSlots_Case0A::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp $10
    jr nc, .cp_20
    and $0f
    ld c, a
    ld b, $00
    ld hl, $6038
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
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case0B::
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case0D::
    call DrawSpriteSlots
    ld a, $00
    ld de, $a040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case0E::
    call DrawSpriteSlots
    ld a, $00
    ld de, $a040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $a040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case05::
    call DrawSpriteSlots
    call StepWD0A2Mod60
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

DebugStaffRoll_Scene04_DrawSpriteSlots_Case0C::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $00
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $5040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case04::
    call DrawSpriteSlots
    call StepWD0A2Mod60
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

DebugStaffRoll_Scene04_DrawSpriteSlots_Case06::
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case07::
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and $03
    ret nz
    ld a, $02
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case08::
    call DrawSpriteSlots
    ld a, $02
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

DebugStaffRoll_Scene04_DrawSpriteSlots_Case08_CheckWorkBuf::
    ld a, [wWorkBuf + $2]
    or a
    jr z, .read_work_buf
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Update_Sub01_Table2_Case00
    dw DebugStaffRoll_Update_Sub01_Table2_Case01
    dw DebugStaffRoll_Update_Sub01_Table2_Case02

.read_work_buf:
    ld a, [wWorkBuf + $1]
    jumptable
    dw DebugStaffRoll_Update_Sub01_Table3_Case00
    dw DebugStaffRoll_Update_Sub01_Table3_Case01
    dw DebugStaffRoll_Update_Sub01_Table3_Case02

DebugStaffRoll_Update_Sub01_Table2_Case00::
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
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld a, $00
    ldh [rVBK], a

.skip2:
    ld a, $7f
    ld hl, vBGMap0
    ld bc, $1412
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
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld a, $00
    ldh [rVBK], a

.skip5:
    ld a, $7f
    ld hl, vBGMap0
    ld bc, $1412
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
    ld hl, $ffff
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

DebugStaffRoll_Update_Sub01_Table2_Case01::
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
    ld de, $019f
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

DebugStaffRoll_Update_Sub01_Table2_Case02::
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

DebugStaffRoll_Update_Sub01_Table3_Case00::
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
    ld b, $48
    ld de, BGPaletteBufferData_48_4001
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld a, $00
    ldh [rVBK], a

.skip:
    ld a, $7f
    ld hl, vBGMap0
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld a, $80
    ld hl, vBGMap0 + $e3
    ld de, $0040
    ld bc, $0e02
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

DebugStaffRoll_Update_Sub01_Table3_Case01::
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

DebugStaffRoll_Update_Sub01_Table3_Case02::
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
    ld hl, $7477
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
    db $01, $40, $25, $01, $40, $7f, $0a, $70, $7f

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
    ld hl, $7535
    add_a_to_hl
    ld a, b
    sub [hl]
    pop hl
    ld [hl], a
    jr .skip

.read_work_buf:
    push hl
    ld a, [wWorkBuf + $a]
    ld hl, $7535
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
    ld hl, $7542
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
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $00, $02, $02, $02
    db $02, $01, $01, $01, $01, $01, $01, $01, $01, $00

; wWorkBuf + $5 += 1, reset to 0 when it reaches 15
StepWD0A2Mod15::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $0f
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

; wWorkBuf + $5 += 1, reset to 0 when it reaches 30
StepWD0A2Mod30::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $1e
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

; wWorkBuf + $5 += 1, reset to 0 when it reaches 45
StepWD0A2Mod45::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $2d
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

; wWorkBuf + $5 += 1, reset to 0 when it reaches 60
StepWD0A2Mod60::
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp $3c
    ret c
    xor a
    ld [wWorkBuf + $5], a
    ret

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
    ld hl, Palette_E0_7641
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

.return:
    ret

; the routine before ResetScreenPalettes_E0.return copies these 8 bytes to wOBJPaletteBuffer + $20
; with CopyBytes (E-0213, C1)
; record: one CGB palette: 4 BGR555 colours
Palette_E0_7641::
    dw $67de, $331f, $123c, $0000 ; entry 0

; DebugStaffRoll_Update_Sub01_Table2_Case00 reads word wWorkBuf + 2 - 1 of $7649
; (ReadWordTableEntry_Bank00), stores the first byte in wWorkBuf + 4 and walks the rest as
; count/value pairs ($FE starts a section, $FF ends one); the five lists run to $76E0; the pair
; meaning is not read (E-0213, C1)
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

; if wStringCategory < 1, BeginStringDisplay with DE = $76FC; otherwise far-calls
; BeginStringDisplay_BankE0_BeginStringDisplay
BeginStringDisplay_BankE0::
    ld a, [wStringCategory]
    cp $01
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_BankE0_BeginStringDisplay
    ret

.call_begin_string_display:
    ld de, $76fc
    call BeginStringDisplay
    ret

; BeginStringDisplay_BankE0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_BankE0::
    call BeginStringDisplay_BankE0
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_E0_76FC::
    dw StringList_E0_76FE ; id 0

; category list of StringCategories_E0_76FC; one pointer per wStringIndex (E-0217)
; record: string
StringList_E0_76FE::
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

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (the bank-$E0 copy of
; the battle library, after a string; E-0213)
GetBattleATK_BankE0:: ; configured code entry (E-0213); C0
    ld hl, wBattleATK
    jr GetBattleMP_BankE0_Skip

GetBattleDEF_BankE0::
    ld hl, wBattleDEF
    jr GetBattleMP_BankE0_Skip

GetBattleMaxHP_BankE0::
    ld hl, wBattleMaxHP
    jr GetBattleMP_BankE0_Skip

GetBattleMaxMP_BankE0::
    ld hl, wBattleMaxMP
    jr GetBattleMP_BankE0_Skip

GetBattleHP_BankE0::
    ld hl, wBattleHP
    jr GetBattleMP_BankE0_Skip

GetBattleMP_BankE0::
    ld hl, wBattleMP
    jr GetBattleMP_BankE0_Skip
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

GetBattleMP_BankE0_Skip::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_BankE0::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_BankE0::
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

; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_BankE0::
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

ClearBattleStatusBitsWithMaskD_BankE0::
    ld a, d
    ld hl, $7a52
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_BankE0::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_BankE0::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_BankE0::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

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

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_BankE0::
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

; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_BankE0::
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
