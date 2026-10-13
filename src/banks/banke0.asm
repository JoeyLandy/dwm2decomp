SECTION "Bank E0", ROMX[$4000], BANK[$E0]
    db $E0

; runs the routine for wDebugSubState (jump table of six) (E-0122)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ToRunDebugSubState_E0)
; reads: wDebugSubState
RunDebugSubState_E0::
Func_0E0_4001:: ; address name
    ld a, [wDebugSubState]
    rst $00
    dw RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault
    dw RunDebugSubState_E0_WriteDebugSubStateAndDebugCursor
    dw RunDebugSubState_E0_WriteDebugSubStateAndDebugValue0
    dw RunDebugSubState_E0_WriteDebugSubStateAndDebugValue1
    dw RunDebugSubState_E0_WriteDebugSubStateAndBattleEndFlag
    dw RunDebugSubState_E0_SetDebugSubState

; entry 0 of the `rst $00` table in RunDebugSubState_E0
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wDebugSubState
RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault::
Jump_0E0_4011:: ; address name
    ld hl, vTiles1 + $6D0
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
    ld de, $42D3
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
    ld a, $BB
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

; entry 1 of the `rst $00` table in RunDebugSubState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wDebugCursor
; writes: wDebugSubState, wDebugCursor
RunDebugSubState_E0_WriteDebugSubStateAndDebugCursor::
Jump_0E0_406F:: ; address name
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
    ld hl, vBGMap0 + $A2
    jr .set_debug_sub_state

.skip:
    and a, $30
    ret z
    ld a, [wDebugCursor]
    and a, $01
    xor a, $01
    ld [wDebugCursor], a
    call RunDebugSubState_E0_WriteVRAMByte_Shared01
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

; entry 2 of the `rst $00` table in RunDebugSubState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wDebugValue0
; writes: wDebugSubState, wDebugValue0
RunDebugSubState_E0_WriteDebugSubStateAndDebugValue0::
Jump_0E0_40B7:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    jr z, .check_joypad_pressed
    ld a, $05
    ld [wDebugSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed_repeat
    xor a, a
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
    cp a, $FF
    jr nz, .set_debug_value0
    ld a, $E3

.set_debug_value0:
    ld [wDebugValue0], a
    jr .call_show_skill_number_and_name_bank_e0

.check_bit4:
    bit 4, a
    ret z
    ld a, [wDebugValue0]
    inc a
    cp a, $E4
    jr nz, .set_debug_value02
    xor a, a

.set_debug_value02:
    ld [wDebugValue0], a

.call_show_skill_number_and_name_bank_e0:
    call ShowSkillNumberAndName_BankE0
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $A2
    call WriteVRAMByte
    ret

; entry 3 of the `rst $00` table in RunDebugSubState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wDebugValue1
; writes: wDebugSubState, wDebugValue1
RunDebugSubState_E0_WriteDebugSubStateAndDebugValue1::
Jump_0E0_4123:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    jr z, .check_joypad_pressed_repeat
    ld a, $05
    ld [wDebugSubState], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, $02
    ld hl, vBGMap0 + $A2
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
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $122
    call WriteVRAMByte
    ret

; entry 4 of the `rst $00` table in RunDebugSubState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wBattleEndFlag
; writes: wDebugSubState, wBattleEndFlag
RunDebugSubState_E0_WriteDebugSubStateAndBattleEndFlag::
Jump_0E0_4175:: ; address name
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
    and a, $30
    ret z
    ld a, [wBattleEndFlag]
    and a, $01
    xor a, $01
    ld [wBattleEndFlag], a
    call RunDebugSubState_E0_WriteVRAMByte
    ret

.set_debug_sub_state:
    ld [wDebugSubState], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $182
    call WriteVRAMByte
    ret

; entry 5 of the `rst $00` table in RunDebugSubState_E0
; no direct call (reached through a table, a jump or a vector)
; writes: wDebugSubState, wDebugState
RunDebugSubState_E0_SetDebugSubState::
Jump_0E0_41BD:: ; address name
    xor a, a
    ld [wDebugSubState], a
    ld a, $03
    ld [wDebugState], a
    ret

; only called from routines of RunDebugSubState_E0 (E-0098)
; 2 call sites from 2 routines (e.g. RunDebugSubState_E0_WriteDebugSubStateAndDebugCursor, RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault)
; reads: wDebugCursor
RunDebugSubState_E0_WriteVRAMByte_Shared01::
Func_0E0_41C7:: ; address name
    ld a, [wDebugCursor]
    and a, $01
    xor a, $01
    ld de, $41E6
    add a, e
    ld e, a
    jr nc, .call_write_vram_byte
    inc d

.call_write_vram_byte:
    ld a, [de]
    ld hl, vBGMap0 + $69
    call WriteVRAMByte
    inc de
    ld a, [de]
    ld hl, vBGMap0 + $6D
    call WriteVRAMByte
    ret
    db $BB, $C3, $BB

; writes the two nibbles of wDebugValue0, each plus 1, as tiles at vBGMap0 + $CA; copies string wDebugValue0 of category 4 (skill names) to wTextBuf0 (CopyStringHLToDE) and shows string 5 of category 8 (ShowString_Bank08) (E-0112)
; 3 call sites from 2 routines (e.g. RunDebugSubState_E0_WriteDebugSubStateAndDebugValue0, RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault)
; reads: wDebugValue0
; writes: wStringCategory, wStringIndex
; points at: wTextBuf0
ShowSkillNumberAndName_BankE0::
Func_0E0_41E9:: ; address name
    ld a, [wDebugValue0]
    swap a
    and a, $0F
    add a, $01
    ld hl, vBGMap0 + $CA
    call WriteVRAMByteInc
    ld a, [wDebugValue0]
    and a, $0F
    add a, $01
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

; only called from routines of RunDebugSubState_E0 (E-0098)
; 2 call sites from 2 routines (e.g. RunDebugSubState_E0_WriteDebugSubStateAndDebugValue1, RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault)
; reads: wDebugValue1, wDigits
RunDebugSubState_E0_HLToDecimalDigits::
Func_0E0_421F:: ; address name
    ld a, [wDebugValue1]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld c, $00
    ld hl, vBGMap0 + $14A
    ld a, [wDigits]
    or a, a
    jr z, .call_write_vram_byte_inc
    ld c, $01
    add a, $E0
    jr .call_write_vram_byte_inc2

.call_write_vram_byte_inc:
    ld a, $C3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    or a, a
    jr nz, .skip
    bit 0, c
    jr z, .call_write_vram_byte_inc3

.skip:
    add a, $E0
    jr .call_write_vram_byte_inc4

.call_write_vram_byte_inc3:
    ld a, $C3

.call_write_vram_byte_inc4:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByte
    ret

; only called from routines of RunDebugSubState_E0 (E-0098)
; 2 call sites from 2 routines (e.g. RunDebugSubState_E0_WriteDebugSubStateAndBattleEndFlag, RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault)
; reads: wBattleEndFlag
RunDebugSubState_E0_WriteVRAMByte::
Func_0E0_425A:: ; address name
    ld a, [wBattleEndFlag]
    and a, $01
    xor a, $01
    ld de, $41E6
    add a, e
    ld e, a
    jr nc, .call_write_vram_byte
    inc d

.call_write_vram_byte:
    ld a, [de]
    ld hl, vBGMap0 + $1A9
    call WriteVRAMByte
    inc de
    ld a, [de]
    ld hl, vBGMap0 + $1AD
    call WriteVRAMByte
    ret

; sets the string window to HL (tile destination) and DE (size), far-calls ShowString_Bank08, then sets the window to vTiles1 with size word $1202 (E-0067) (the same 45 bytes appear in 2 banks)
; 3 call sites from 2 routines (e.g. RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault, RunDebugState_E0_ChooseActionTargets_ShowStringBank08AtTilesHLThenDefault_BankE0)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHLThenDefault_BankE0::
Func_0E0_4279:: ; address name
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

; shows the selected string (ShowString_Bank09) in a window at HL with size DE, then restores the default window (vTiles1, $1202) (E-0121)
; 1 call site from 1 routine (e.g. RunDebugSubState_E0_ShowStringBank09AtHLSizeDEThenDefault)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtHLSizeDEThenDefault::
Func_0E0_42A6:: ; address name
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
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $ED, $EE, $EF, $F0, $F1, $F2, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F3
    db $F4, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $ED, $EE, $EF, $FB, $FC, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $E0
    db $E0, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $80, $81, $82, $83, $84, $85, $86, $87, $88, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $FD, $FE, $FF, $00, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $BE, $E2, $E5, $E5, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $F8, $F9, $FA, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F3
    db $F4, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

; runs the routine for wDebugState (jump table of fourteen) (E-0122)
; 2 call sites from 2 routines (e.g. CallFunc443BInBankE0, CallFunc443BInBankE0_BankA0)
; reads: wDebugState
RunDebugState_E0::
Func_0E0_443B:: ; address name
    ld a, [wDebugState]
    rst $00
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

; entry 0 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wDebugSubState
; writes: wStringCategory, wStringIndex
; points at: wDebugState
RunDebugState_E0_ShowStringBank09AtTilesHL_BankE0::
Jump_0E0_445B:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2301
    ld a, $02
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankE0
    call DrawFullScreenFromBankE0_511B
    ld hl, $448A
    ld a, [wDebugSubState]
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BB
    call WriteVRAMByte
    ld hl, wDebugState
    inc [hl]
    ret
    db $24, $98, $2A, $98

; entry 1 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wDebugSubState
; points at: wBattleMeter, wDebugState
RunDebugState_E0_DrawSlotHPMPStats_BankE0::
Jump_0E0_448E:: ; address name
    ld a, [wDebugSubState]
    or a, a
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
    ld hl, vBGMap0 + $20B
    ld de, wBattleMeter
    call RunDebugState_E0_Case01_WordAtDEToPackedBCD
    ld hl, wDebugState
    inc [hl]
    ret

; C = slot: unless its wBattleSlotOut entry is $FF, draws its HP, max HP, MP and max MP words (Func_0E0_4593 for each) at the position from the table at $4652 (C & 3); the rest is not read (E-0112)
; 3 call sites from 1 routine (e.g. RunDebugState_E0_DrawSlotHPMPStats_BankE0)
; writes: hTemp0, hTemp1
; points at: wBattleSlotOut, wBattleHP, wBattleMaxHP, wBattleMP, wBattleMaxMP, wBattleLevel, wBattleATK, wBattleDEF, ...
DrawSlotHPMPStats_BankE0::
Func_0E0_44B3:: ; address name
    ld a, c
    and a, $03
    ld hl, $4652
    add a, a
    add_a_to_hl
    deref_hl
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, $FF
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
    xor a, a
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

; only called from DrawSlotHPMPStats_BankE0 (E-0047)
; 4 call sites from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD::
Func_0E0_455F:: ; address name
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, .call_word_at_de_to_packed_bcd
    inc d

.call_word_at_de_to_packed_bcd:
    call WordAtDEToPackedBCD
    jr DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03

; only called from DrawSlotHPMPStats_BankE0 (E-0047)
; 5 call sites from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
; writes: wDigits
DrawSlotHPMPStats_BankE0_Number24ToPackedBCD::
Func_0E0_456B:: ; address name
    ld a, c
    add a, e
    ld e, a
    jr nc, .set_digits
    inc d

.set_digits:
    push hl
    ld a, [de]
    ld [wDigits], a
    xor a, a
    ld [wDigits + $1], a
    ld [wDigits + $2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    pop hl

; only called from DrawSlotHPMPStats_BankE0 (E-0047)
; 9 call sites from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03::
Func_0E0_4583:: ; address name
    ld b, $00
    push hl
    call DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; DE += 2 * C, then falls into the BCD conversion of the word
; 5 call sites from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
DrawSlotHPMPStats_BankE0_IndexWordC::
Func_0E0_4593:: ; address name
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, RunDebugState_E0_Case01_WordAtDEToPackedBCD
    inc d

; only called from RunDebugState_E0_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunDebugState_E0_DrawSlotHPMPStats_BankE0)
RunDebugState_E0_Case01_WordAtDEToPackedBCD::
Func_0E0_459A:: ; address name
    call WordAtDEToPackedBCD

; only called from DrawSlotHPMPStats_BankE0 (E-0047)
; 5 call sites from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04::
Func_0E0_459D:: ; address name
    push hl
    call DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from DrawSlotHPMPStats_BankE0_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte_Sub04)
; reads: hTemp1, hTemp0
DrawSlotHPMPStats_BankE0_Sub04_WriteVRAMByte::
Func_0E0_45AB:: ; address name
    ld b, $00
    ldh a, [hTemp1]
    swap a
    and a, $0F
    or a, a
    jr z, .next
    add a, $E0
    call WriteVRAMByte
    ld b, $01

.next:
    inc hl

; only called from DrawSlotHPMPStats_BankE0_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte_Sub03)
; reads: hTemp1, hTemp0
DrawSlotHPMPStats_BankE0_Sub03_WriteVRAMByte::
Func_0E0_45BE:: ; address name
    ldh a, [hTemp1]
    and a, $0F
    or a, a
    jr nz, .call_write_vram_byte
    bit 0, b
    jr z, .read_temp0

.call_write_vram_byte:
    add a, $E0
    call WriteVRAMByte
    ld b, $01

.read_temp0:
    inc hl
    ldh a, [hTemp0]
    swap a
    and a, $0F
    or a, a
    jr nz, .call_write_vram_byte2
    bit 0, b
    jr z, .check_temp0

.call_write_vram_byte2:
    add a, $E0
    call WriteVRAMByte

.check_temp0:
    inc hl
    ldh a, [hTemp0]
    and a, $0F
    add a, $E0
    call WriteVRAMByte
    ret

; wDigits/wDigits + $1 = the word at DE, wDigits + $2 = 0, then Number24ToPackedBCD; BC, HL kept (E-0118)
; 2 call sites from 2 routines (e.g. RunDebugState_E0_Case01_WordAtDEToPackedBCD, DrawSlotHPMPStats_BankE0_WordAtDEToPackedBCD)
; writes: wDigits
WordAtDEToPackedBCD::
Func_0E0_45EE:: ; address name
    push hl
    ld a, [de]
    ld [wDigits], a
    inc de
    ld a, [de]
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    pop hl
    ret

; writes the glyph for the slot's wSlotAIMode at the slot's BG address
; 1 call site from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
; points at: wSlotAIMode
DrawSlotHPMPStats_BankE0_DrawAIModeGlyph::
Func_0E0_4603:: ; address name
    ld a, c
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, $465E
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, c
    and a, $03
    ld hl, $4658
    add a, a
    add_a_to_hl
    deref_hl
    pop af
    call WriteVRAMByte
    ret

; only called from DrawSlotHPMPStats_BankE0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotHPMPStats_BankE0)
; points at: wSlotNameSuffix
DrawSlotHPMPStats_BankE0_WriteVRAMByte::
Func_0E0_462B:: ; address name
    ld a, c
    ld de, wSlotNameSuffix
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, c
    and a, $03
    ld hl, $464C
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [de]
    and a, $01
    add a, $CC
    call WriteVRAMByte
    ret
    db $C6, $98, $CC, $98, $D2, $98, $42, $98, $48, $98, $4E, $98, $46, $99, $4C, $99
    db $52, $99, $0B, $0A, $09, $08, $EF

; entry 2 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wBattlePartyCount, wBattleFoeCount, wBattleActor, wBattleTarget, wBattleActionId, wDebugSubState
; writes: wBattlePartyCount, wBattleFoeCount, wDebugState, wDebugSubState, wEffectId
; points at: wWorkBuf, wDebugState
RunDebugState_E0_DrawFullScreenFromBankE0_5283::
Jump_0E0_4663:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    jr z, .check_joypad_pressed
    ld hl, wWorkBuf
    ld a, [wBattlePartyCount]
    ld [hl+], a
    ld a, [wBattleFoeCount]
    ld [hl+], a
    ld a, [wBattleActor]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld [hl+], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld a, $01
    ld [wBattlePartyCount], a
    ld a, $01
    ld [wBattleFoeCount], a
    ld a, $0A
    ld [wDebugState], a
    call DrawFullScreenFromBankE0_5283
    call DrawSkillByte0AndRun502BAnd53B9
    xor a, a
    ld [wDebugSubState], a
    call DrawHexByteAtBGMap8A
    ld a, $FF
    ld [wEffectId], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $08
    jr z, .check_joypad_pressed2
    ld hl, wDebugState
    inc [hl]
    ret

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and a, $30
    jr z, .check_joypad_pressed3
    ld a, [wDebugSubState]
    inc a
    and a, $01
    ld [wDebugSubState], a
    xor a, a
    ld [wDebugState], a
    ret

.check_joypad_pressed3:
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed4
    ld a, $04
    ld [wDebugState], a
    ret

.check_joypad_pressed4:
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld a, $07
    ld [wDebugState], a
    ret

; entry 3 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePartyCount, wLinkRole
; writes: wDebugValue3
; points at: wScreenTileBuffer, wLevelUpGains
RunDebugState_E0_WriteVRAMByteInc::
Jump_0E0_46DD:: ; address name
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
    sub a, b
    add a, e
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
    xor a, a
    ld [wDebugValue3], a
    ret

; entry 4 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
RunDebugState_E0_ToDrawTileMap4946AndStep::
Jump_0E0_4724:: ; address name
    call DrawTileMap4946AndStep
    ret

; entry 5 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotResistances, wDebugState
RunDebugState_E0_DrawPacked2BitFieldsInRows::
Jump_0E0_4728:: ; address name
    ld hl, vBGMap0 + $61
    ld de, wSlotResistances
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $67
    ld de, wSlotResistances + $7
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $6D
    ld de, wSlotResistances + $E
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $141
    ld de, wSlotResistances + $1C
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $147
    ld de, wSlotResistances + $23
    call DrawPacked2BitFieldsInRows
    ld hl, vBGMap0 + $14D
    ld de, wSlotResistances + $2A
    call DrawPacked2BitFieldsInRows
    ld hl, wDebugState
    inc [hl]
    ret

; writes a run of 2-bit fields from [DE] onward as digit tiles with the four DrawBitsNN routines, five per row, moving HL to the next BG map row (+$1B) after each five; the end is not read (E-0112)
; 6 call sites from 1 routine (e.g. RunDebugState_E0_DrawPacked2BitFieldsInRows)
DrawPacked2BitFieldsInRows::
Func_0E0_4763:: ; address name
    ld a, [de]
    ld c, a
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call DrawBits54OfDEAsDigit
    call DrawBits32OfDEAsDigit
    call DrawBits10OfDEAsDigit
    call DrawBits76OfNextDEAsDigit
    call DrawBits54OfDEAsDigit
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call DrawBits32OfDEAsDigit
    ld a, c
    rlca
    rlca
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; DE += 1, then writes bits 7-6 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
; 6 call sites from 1 routine (e.g. DrawPacked2BitFieldsInRows)
DrawBits76OfNextDEAsDigit::
Func_0E0_47E0:: ; address name
    inc de
    ld a, [de]
    rlca
    rlca
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; writes bits 5-4 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
; 7 call sites from 1 routine (e.g. DrawPacked2BitFieldsInRows)
DrawBits54OfDEAsDigit::
Func_0E0_47E6:: ; address name
    ld a, [de]
    swap a
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; writes bits 3-2 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
; 7 call sites from 1 routine (e.g. DrawPacked2BitFieldsInRows)
DrawBits32OfDEAsDigit::
Func_0E0_47EB:: ; address name
    ld a, [de]
    rrca
    rrca
    jr DrawBits10OfDEAsDigit_CallWriteVRAMByteInc

; writes bits 1-0 of [DE] as digit tile $E0 + value (0-3) at HL (WriteVRAMByteInc) (E-0112)
; 6 call sites from 1 routine (e.g. DrawPacked2BitFieldsInRows)
DrawBits10OfDEAsDigit::
Func_0E0_47F0:: ; address name
    ld a, [de]

DrawBits10OfDEAsDigit_CallWriteVRAMByteInc::
Jump_0E0_47F1:: ; address name
    and a, $03
    add a, $E0
    call WriteVRAMByteInc
    ret

; entry 6 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wDebugState
RunDebugState_E0_WaitJoypadPressed::
Jump_0E0_47F9:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    xor a, a
    ld [wDebugState], a
    ret

; writes the 20 x 16 tile map $4946 to vBGMap0 + $20, then wDebugState += 1 (E-0124)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ToDrawTileMap4946AndStep)
; points at: wDebugState
DrawTileMap4946AndStep::
Func_0E0_4804:: ; address name
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

; entry 8 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills, wDebugState
RunDebugState_E0_DrawEightBytesAsHexColumns::
Jump_0E0_4825:: ; address name
    ld de, wBattleSkills
    ld hl, vBGMap0 + $62
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $10
    ld hl, vBGMap0 + $68
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $20
    ld hl, vBGMap0 + $6E
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $40
    ld hl, vBGMap0 + $142
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $50
    ld hl, vBGMap0 + $148
    call DrawEightBytesAsHexColumns
    ld de, wBattleSkills + $60
    ld hl, vBGMap0 + $14E
    call DrawEightBytesAsHexColumns
    call Run48B7ForThreeBattlerRecords
    ld hl, wDebugState
    inc [hl]
    ret

; DrawFourBytesAsHexRows at HL, then the next four bytes in a second column three entries to the right (E-0112)
; 6 call sites from 1 routine (e.g. RunDebugState_E0_DrawEightBytesAsHexColumns)
DrawEightBytesAsHexColumns::
Func_0E0_4863:: ; address name
    push hl
    call DrawFourBytesAsHexRows
    pop hl
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

; writes four bytes from DE as two hex digits each (WriteHexDigitTile), one byte per BG map row (HL += $1E after each) (E-0112)
; 1 call site from 1 routine (e.g. DrawEightBytesAsHexColumns)
DrawFourBytesAsHexRows::
Func_0E0_4870:: ; address name
    ld b, $04

.loop:
    ld a, [de]
    swap a
    and a, $0F
    call WriteHexDigitTile
    ld a, [de]
    and a, $0F
    call WriteHexDigitTile
    ld a, l
    add a, $1E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc de
    inc de
    dec b
    jr nz, .loop
    ret

; A = 0-15: writes tile $E0 + A for 0-9, or A - 2 for 10-15, at HL (WriteVRAMByteInc) (E-0112)
; 2 call sites from 1 routine (e.g. DrawFourBytesAsHexRows)
WriteHexDigitTile::
Func_0E0_488E:: ; address name
    cp a, $0A
    jr nc, .call_write_vram_byte_inc
    add a, $E0
    jr .call_write_vram_byte_inc2

.call_write_vram_byte_inc:
    sub a, $02

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ret

; runs Func_0E0_48B7 for B = 0, 1, 2 on the 78-byte records from wBattlerRecords + $18 + 3 * $4E (E-0122)
; 1 call site from 1 routine (e.g. RunDebugState_E0_DrawEightBytesAsHexColumns)
Run48B7ForThreeBattlerRecords::
Func_0E0_489C:: ; address name
    ld de, $004E
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

; only called from Run48B7ForThreeBattlerRecords (E-0047)
; 3 call sites from 1 routine (e.g. Run48B7ForThreeBattlerRecords)
; reads: hTemp2, hTemp1, hTemp0
; writes: wDigits
Run48B7ForThreeBattlerRecords_Number24ToPackedBCD::
Func_0E0_48B7:: ; address name
    push af
    push bc
    push de
    push hl
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl+]
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
    add a, a
    add_a_to_hl
    deref_hl
    ld b, $00
    ldh a, [hTemp2]
    and a, $0F
    or a, a
    jr z, .read_temp1
    add a, $E0
    call WriteVRAMByte
    ld b, $01

.read_temp1:
    inc hl
    ldh a, [hTemp1]
    swap a
    and a, $0F
    or a, a
    jr nz, .call_write_vram_byte
    bit 0, b
    jr z, .check_temp1

.call_write_vram_byte:
    add a, $E0
    call WriteVRAMByte
    ld b, $01

.check_temp1:
    inc hl
    ldh a, [hTemp1]
    and a, $0F
    or a, a
    jr nz, .call_write_vram_byte2
    bit 0, b
    jr z, .read_temp0

.call_write_vram_byte2:
    add a, $E0
    call WriteVRAMByte
    ld b, $01

.read_temp0:
    inc hl
    ldh a, [hTemp0]
    swap a
    and a, $0F
    or a, a
    jr nz, .call_write_vram_byte3
    bit 0, b
    jr z, .check_temp0

.call_write_vram_byte3:
    add a, $E0
    call WriteVRAMByte
    ld b, $01

.check_temp0:
    inc hl
    ldh a, [hTemp0]
    and a, $0F
    add a, $E0
    call WriteVRAMByte
    pop hl
    ret
    db $E2, $99, $E8, $99, $EE, $99

; entry 9 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wDebugState
RunDebugState_E0_WaitJoypadPressed_Case09::
Jump_0E0_493B:: ; address name
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    xor a, a
    ld [wDebugState], a
    ret
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F8, $C3, $F9, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

; entry 10 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectId, wJoypadPressed
; writes: wBattlePartyCount, wBattleFoeCount, wBattleActor, wBattleTarget, wBattleActionId, wDebugState, wDebugSubState, wDebugCounter, ...
; points at: wDebugSubState, wWorkBuf
RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0_Case0A::
Jump_0E0_4A86:: ; address name
    ld a, [wEffectId]
    cp a, $FF
    jr z, .check_joypad_pressed
    farcall RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $10
    jr z, .check_joypad_pressed2
    ld hl, wDebugSubState
    inc [hl]
    ld a, [hl]
    cp a, $3C
    jr nz, DrawHexByteAtBGMap8A
    xor a, a
    ld [hl], a
    jr DrawHexByteAtBGMap8A

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and a, $20
    jr z, DrawHexByteAtBGMap8A_CheckJoypadPressed
    ld hl, wDebugSubState
    dec [hl]
    ld a, [hl]
    cp a, $FF
    jr nz, DrawHexByteAtBGMap8A
    ld a, $3B
    ld [hl], a

; writes A as two hex-digit tiles (0-9 as $E0 + n, 10-15 as n - 2): the low digit at vBGMap0 + $8A, then the high digit (the second write is not read to its end) (E-0112)
; 1 call site from 1 routine (e.g. RunDebugState_E0_DrawFullScreenFromBankE0_5283)
DrawHexByteAtBGMap8A::
Func_0E0_4ABB:: ; address name
    push af
    and a, $0F
    cp a, $0A
    jr nc, .call_write_vram_byte
    add a, $E0
    jr .call_write_vram_byte2

.call_write_vram_byte:
    sub a, $02

.call_write_vram_byte2:
    ld hl, vBGMap0 + $8A
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, .call_write_vram_byte3
    add a, $E0
    jr .call_write_vram_byte4

.call_write_vram_byte3:
    sub a, $02

.call_write_vram_byte4:
    ld hl, vBGMap0 + $89
    call WriteVRAMByte
    call DrawSkillByte0AndRun502BAnd53B9
    ret

DrawHexByteAtBGMap8A_CheckJoypadPressed::
Jump_0E0_4AE7:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    farcall DrawHexByteAtBGMap8A_FillBytes
    call DrawHexByteAtBGMap8A_QueueSoundEffect
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $04
    jr z, DrawHexByteAtBGMap8A_CheckJoypadPressed2
    ld hl, wWorkBuf
    ld a, [hl+]
    ld [wBattlePartyCount], a
    ld a, [hl+]
    ld [wBattleFoeCount], a
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl]
    ld [wBattleActionId], a
    ld a, $0B
    ld [wDebugState], a
    xor a, a
    ld [wDebugSubState], a
    call DrawHexByteAtBGMap8A_ToCopyRectFromBankToVRAM
    call DrawSlotStatusBitsDebug
    xor a, a
    ld [wDebugCounter], a
    call ReadBGTileAtDebugCounterCell
    ret

DrawHexByteAtBGMap8A_CheckJoypadPressed2::
Jump_0E0_4B2D:: ; address name
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld hl, wWorkBuf
    ld a, [hl+]
    ld [wBattlePartyCount], a
    ld a, [hl+]
    ld [wBattleFoeCount], a
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl]
    ld [wBattleActionId], a
    xor a, a
    ld [wDebugState], a
    ld a, $FF
    ld [wEffectId], a
    ret

; entry 11 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuRowCount, wTemp0, wTemp1, wDebugSubState, wDebugCounter
; writes: wDebugCounter, wMenuRowCount, wBattlePartyCount, wBattleFoeCount, wBattleActor, wBattleTarget, wBattleActionId, wDebugState, ...
; points at: wDebugSubState, wDebugCounter, wBattleStatus, wWorkBuf
RunDebugState_E0_BlinkWC0A0Tile::
Jump_0E0_4B54:: ; address name
    call BlinkWC0A0Tile
    ld a, [wJoypadPressed]
    and a, $08
    jr z, .check_joypad_pressed
    ld hl, wDebugSubState
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr nz, .call_draw_slot_status_bits_debug
    xor a, a
    ld [hl], a

.call_draw_slot_status_bits_debug:
    call DrawSlotStatusBitsDebug
    xor a, a
    ld [wDebugCounter], a
    call ReadBGTileAtDebugCounterCell
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $20
    jr z, .check_joypad_pressed2
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and a, $0F
    dec a
    and a, $0F
    cp a, $0F
    jr nz, .skip
    ld a, [hl]
    and a, $F0
    or a, $07

.skip:
    push af
    ld a, [hl]
    and a, $F0
    pop bc
    or a, b
    ld [hl], a
    jr .call_read_bg_tile_at_debug_counter_cell

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and a, $10
    jr z, .check_joypad_pressed3
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and a, $0F
    inc a
    and a, $0F
    cp a, $08
    jr nz, .skip2
    ld a, [hl]
    and a, $F0

.skip2:
    push af
    ld a, [hl]
    and a, $F0
    pop bc
    or a, b
    ld [hl], a
    jr .call_read_bg_tile_at_debug_counter_cell

.check_joypad_pressed3:
    ld a, [wJoypadPressed]
    and a, $40
    jr z, .check_joypad_pressed4
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and a, $F0
    sub a, $10
    and a, $F0
    cp a, $F0
    jr nz, .skip3
    ld a, [hl]
    and a, $0F
    or a, $80

.skip3:
    push af
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a
    jr .call_read_bg_tile_at_debug_counter_cell

.check_joypad_pressed4:
    ld a, [wJoypadPressed]
    and a, $80
    jr z, .check_joypad_pressed5
    ld a, [wMenuRowCount]
    call WriteVRAMByte
    ld hl, wDebugCounter
    ld a, [hl]
    and a, $F0
    add a, $10
    and a, $F0
    cp a, $90
    jr nz, .skip4
    ld a, [hl]
    and a, $0F

.skip4:
    push af
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a

.call_read_bg_tile_at_debug_counter_cell:
    call ReadBGTileAtDebugCounterCell
    ret

.check_joypad_pressed5:
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .skip8
    ld a, [wMenuRowCount]
    xor a, $01
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
    and a, $0F
    ld c, a
    ld b, $00
    add hl, bc
    ld a, [wMenuRowCount]
    and a, $01
    jr z, .skip6
    ld a, e
    ld de, $4C76
    and a, $0F
    add a, e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    or a, [hl]
    ld [hl], a
    ret

.skip6:
    ld a, e
    ld de, $4C6E
    and a, $0F
    add a, e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    and a, [hl]
    ld [hl], a
    ret

.skip8:
    jp DrawHexByteAtBGMap8A_CheckJoypadPressed2
    db $FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F, $01, $02, $04, $08, $10, $20, $40, $80

; writes either $C3 (bit 3 of wFrameCounterLo clear) or wMenuRowCount at the VRAM address in wTemp0/1 (E-0122)
; 1 call site from 1 routine (e.g. RunDebugState_E0_BlinkWC0A0Tile)
; reads: wTemp0, wTemp1, wFrameCounterLo, wMenuRowCount
BlinkWC0A0Tile::
Func_0E0_4C7E:: ; address name
    ld a, [wTemp0]
    ld l, a
    ld a, [wTemp1]
    ld h, a
    ld a, [wFrameCounterLo]
    bit 3, a
    ld a, $C3
    jr z, .call_write_vram_byte
    ld a, [wMenuRowCount]

.call_write_vram_byte:
    call WriteVRAMByte
    ret

; entry 12 of the `rst $00` table in RunDebugState_E0
; no direct call (reached through a table, a jump or a vector)
RunDebugState_E0_ToRunDebugSubState_E0::
Jump_0E0_4C96:: ; address name
    call RunDebugSubState_E0
    ret

; debug battle state $0D: shows a string, reads the slot's personality and, for an actor without a target, far-calls ChooseActionTarget
; no direct call (reached through a table, a jump or a vector)
; reads: wDebugSubState
RunDebugState_E0_ChooseActionTargets::
Jump_0E0_4C9A:: ; address name
    ld a, [wDebugSubState]
    rst $00
    dw RunDebugState_E0_ChooseActionTargets_ShowStringBank08AtTilesHLThenDefault_BankE0
    dw RunDebugState_E0_ChooseActionTargets_PersonalityIndexOfSlot_BankE0
    dw RunDebugState_E0_ChooseActionTargets_WriteDebugSubState
    dw RunDebugState_E0_ChooseActionTargets_WriteDebugSubStateAndBattleActor
    dw RunDebugState_E0_ChooseActionTargets_WriteBattleActorAndDebugSubStateEtc
    dw RunDebugState_E0_ChooseActionTargets_WriteDebugSubState_Case05

; entry 0 of the `rst $00` table in RunDebugState_E0_ChooseActionTargets
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wBattleActor, wDebugSubState
RunDebugState_E0_ChooseActionTargets_ShowStringBank08AtTilesHLThenDefault_BankE0::
Jump_0E0_4CAA:: ; address name
    ld hl, vTiles2 + $10
    ld de, $1001
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank08AtTilesHLThenDefault_BankE0
    ld hl, vTiles1
    ld de, $1201
    ld a, $0E
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
    xor a, a
    ld [wBattleActor], a
    ld a, $01
    ld [wDebugSubState], a
    ret

; entry 1 of the `rst $00` table in RunDebugState_E0_ChooseActionTargets
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wPersonalityIndex, wDebugSubState
RunDebugState_E0_ChooseActionTargets_PersonalityIndexOfSlot_BankE0::
Jump_0E0_4CF6:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_BankE0
    ld [wPersonalityIndex], a
    farcall RunDebugState_E0_ChooseActionTargets_Case01_WriteRandomLoAndRandomHiEtc
    ld a, $02
    ld [wDebugSubState], a
    ret

; entry 2 of the `rst $00` table in RunDebugState_E0_ChooseActionTargets
; no direct call (reached through a table, a jump or a vector)
; writes: wDebugSubState
RunDebugState_E0_ChooseActionTargets_WriteDebugSubState::
Jump_0E0_4D0B:: ; address name
    farcall RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor
    ld a, $03
    ld [wDebugSubState], a
    ret

; entry 3 of the `rst $00` table in RunDebugState_E0_ChooseActionTargets
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wBattleActor
; writes: wDebugSubState, wBattleActor
; points at: wBattleSubPhase
RunDebugState_E0_ChooseActionTargets_WriteDebugSubStateAndBattleActor::
Jump_0E0_4D17:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_joypad_pressed_repeat
    ld a, $04
    ld [wDebugSubState], a
    xor a, a
    ld hl, wBattleSubPhase
    ld [hl+], a
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
    and a, $07
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
    and a, $07
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

; entry 4 of the `rst $00` table in RunDebugState_E0_ChooseActionTargets
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wDebugSubState, wDebugState
; points at: wBattleActionChoice
RunDebugState_E0_ChooseActionTargets_WriteBattleActorAndDebugSubStateEtc::
Jump_0E0_4D72:: ; address name
    xor a, a
    ld [wBattleActor], a
    ld [wDebugSubState], a
    ld a, $03
    ld [wDebugState], a
    ld a, $FF
    ld hl, wBattleActionChoice
    ld bc, $0010
    jp FillBytes

; entry 5 of the `rst $00` table in RunDebugState_E0_ChooseActionTargets
; no direct call (reached through a table, a jump or a vector)
; writes: wDebugSubState
RunDebugState_E0_ChooseActionTargets_WriteDebugSubState_Case05::
Jump_0E0_4D89:: ; address name
    farcall RunDebugState_E0_ChooseActionTargets_Case05_AIChooseActionForActor
    ld a, $02
    ld [wDebugSubState], a
    ret

; E-0213 (C1: a debug screen routine copies 20 x 18 bytes (BC = $1412) from $4D95 to vBGMap0 row by row with WriteVRAMByteInc).
; record: 20 x 18 tiles, one row per line
DebugScreenLayout_E0_4D95::
Data_0E0_4D95:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; entry 0: row 0
    db $B6, $C3, $C3, $80, $81, $82, $01, $C3, $C3, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $8B, $8C, $C3, $C3, $C3, $C3, $ED, $EE, $EF, $F0, $F1, $F2, $F3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $C3, $C3, $85, $86, $87, $C3, $C3, $88, $89, $8A, $89, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $02, $AF, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $03, $AF, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $04, $AF, $C3, $C3, $C3, $C3, $B7 ; row 7
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 9
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 10
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 11
    db $B6, $C3, $C3, $AF, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 12
    db $B6, $C3, $02, $AF, $01, $01, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 13
    db $B6, $C3, $04, $AF, $0B, $0D, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 15
    db $B6, $C3, $C3, $C3, $C3, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $C3, $C3, $C3, $C3, $C3, $B7 ; row 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 17

; wDebugCounter = row (high nibble) and column (low nibble): stores vBGMap0 + $89 + 32 * row + column in wTemp0/1 and reads the tile there into wMenuRowCount (E-0121)
; 3 call sites from 2 routines (e.g. RunDebugState_E0_BlinkWC0A0Tile, DrawHexByteAtBGMap8A)
; reads: wDebugCounter
; writes: wTemp0, wTemp1, wMenuRowCount
ReadBGTileAtDebugCounterCell::
Func_0E0_4EFD:: ; address name
    ld a, [wDebugCounter]
    ld b, a
    and a, $0F
    ld c, a
    ld a, b
    swap a
    and a, $0F
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

; debug: draws the four-tile strip for wDebugSubState, then the 9 status bytes of slot wDebugSubState as rows of 0/1 digit tiles from vBGMap0 + $89 (E-0127)
; 2 call sites from 2 routines (e.g. RunDebugState_E0_BlinkWC0A0Tile, DrawHexByteAtBGMap8A)
; reads: wDebugSubState, wBattleArg0, wBattleArg1
; writes: wBattleArg0, wBattleArg1
; points at: wBattleStatus
DrawSlotStatusBitsDebug::
Func_0E0_4F28:: ; address name
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
    add a, b
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    and a, $01
    add a, $E0
    call WriteVRAMByte
    pop hl
    srl d
    inc b
    ld a, b
    cp a, $08
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
    cp a, $09
    jr nz, .loop
    ret

; copies a 4 x 1 tile strip from bank $E0 (address from the word table at $4F9E + 2 * A) to vBGMap0 + $27 (CopyRectFromBankToVRAM) (E-0118)
; 1 call site from 1 routine (e.g. DrawSlotStatusBitsDebug)
DrawFourTileStripForA::
Func_0E0_4F86:: ; address name
    add a, a
    ld hl, $4F9E
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0 + $27
    ld bc, $0401
    ld a, $E0
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

PointerRun_E0_4F9E_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FAE:: ; address name
    db $F5, $F6, $F7, $E0

PointerRun_E0_4F9E_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FB2:: ; address name
    db $F5, $F6, $F7, $E1

PointerRun_E0_4F9E_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FB6:: ; address name
    db $F5, $F6, $F7, $E2

PointerRun_E0_4F9E_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FBA:: ; address name
    db $F5, $F6, $F7, $E3

PointerRun_E0_4F9E_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FBE:: ; address name
    db $F8, $F9, $E0, $C3

PointerRun_E0_4F9E_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FC2:: ; address name
    db $F8, $F9, $E1, $C3

PointerRun_E0_4F9E_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FC6:: ; address name
    db $F8, $F9, $E2, $C3

PointerRun_E0_4F9E_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_4FCA:: ; address name
    db $F8, $F9, $E3, $C3

; DrawSkillRecordByte0DigitsForDebugValue0, Func_0E0_502B, then far-calls Func_03A_53B9 (E-0122)
; 2 call sites from 2 routines (e.g. DrawHexByteAtBGMap8A, RunDebugState_E0_DrawFullScreenFromBankE0_5283)
DrawSkillByte0AndRun502BAnd53B9::
Func_0E0_4FCE:: ; address name
    call DrawSkillRecordByte0DigitsForDebugValue0
    call DrawSkillByte0AndRun502BAnd53B9_LoadSkillRecord
    farcall DrawSkillByte0AndRun502BAnd53B9_WriteBattleArg0AndBattleArg1Etc
    ret

; loads skill wDebugValue0's first record byte (LoadSkillRecordPart) and writes it as three digit tiles at vBGMap0 + $204 (E-0121)
; 1 call site from 1 routine (e.g. DrawSkillByte0AndRun502BAnd53B9)
; reads: wDebugValue0, wRecordBufferData, wDigits
; writes: wBattleArg0, wRecordBuffer, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wRecordBufferData
DrawSkillRecordByte0DigitsForDebugValue0::
Func_0E0_4FDB:: ; address name
    ld a, $00
    ld [wBattleArg0], a
    ld a, [wDebugValue0]
    ld [wRecordBuffer], a
    xor a, a
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
    add a, $E0
    ld hl, vBGMap0 + $204
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add a, $E0
    ld hl, vBGMap0 + $205
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add a, $E0
    ld hl, vBGMap0 + $206
    call WriteVRAMByte
    ret

; only called from DrawSkillByte0AndRun502BAnd53B9 (E-0047)
; 1 call site from 1 routine (e.g. DrawSkillByte0AndRun502BAnd53B9)
; reads: wDebugValue0, wRecordBufferData, wDigits
; writes: wRecordBuffer
DrawSkillByte0AndRun502BAnd53B9_LoadSkillRecord::
Func_0E0_502B:: ; address name
    ld a, [wDebugValue0]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $A]
    ld h, a
    push hl
    call HLToDecimalDigits
    ld a, [wDigits]
    add a, $E0
    ld hl, vBGMap0 + $1C3
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add a, $E0
    ld hl, vBGMap0 + $1C4
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add a, $E0
    ld hl, vBGMap0 + $1C5
    call WriteVRAMByte
    pop hl
    ld a, [wRecordBufferData + $B]
    ld c, a
    ld b, $00
    add hl, bc
    call HLToDecimalDigits
    ld a, [wDigits]
    add a, $E0
    ld hl, vBGMap0 + $1E3
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add a, $E0
    ld hl, vBGMap0 + $1E4
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add a, $E0
    ld hl, vBGMap0 + $1E5
    call WriteVRAMByte
    ld a, [wRecordBufferData + $D]
    ld l, a
    ld a, [wRecordBufferData + $E]
    ld h, a
    push hl
    call HLToDecimalDigits
    ld a, [wDigits]
    add a, $E0
    ld hl, vBGMap0 + $1C7
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add a, $E0
    ld hl, vBGMap0 + $1C8
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add a, $E0
    ld hl, vBGMap0 + $1C9
    call WriteVRAMByte
    pop hl
    ld a, [wRecordBufferData + $F]
    ld c, a
    ld b, $00
    add hl, bc
    call HLToDecimalDigits
    ld a, [wDigits]
    add a, $E0
    ld hl, vBGMap0 + $1E7
    call WriteVRAMByte
    ld a, [wDigits + $1]
    add a, $E0
    ld hl, vBGMap0 + $1E8
    call WriteVRAMByte
    ld a, [wDigits + $2]
    add a, $E0
    ld hl, vBGMap0 + $1E9
    call WriteVRAMByte
    ret

; copies a 20 x 18 tile map from E0:$511B to vBGMap0 (CopyRectFromBankToVRAM) (E-0116)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ShowStringBank09AtTilesHL_BankE0)
DrawFullScreenFromBankE0_511B::
Func_0E0_50EE:: ; address name
    ld hl, vBGMap0
    ld de, $511B
    ld bc, $1412
    ld a, $E0
    call CopyRectFromBankToVRAM
    ret

; copies a 20 x 18 tile map from E0:$5283 to vBGMap0 (E-0116)
; 1 call site from 1 routine (e.g. RunDebugState_E0_DrawFullScreenFromBankE0_5283)
DrawFullScreenFromBankE0_5283::
Func_0E0_50FD:: ; address name
    ld hl, vBGMap0
    ld de, $5283
    ld bc, $1412
    ld a, $E0
    call CopyRectFromBankToVRAM
    ret

; only called from DrawHexByteAtBGMap8A (E-0047)
; 1 call site from 1 routine (e.g. DrawHexByteAtBGMap8A)
DrawHexByteAtBGMap8A_ToCopyRectFromBankToVRAM::
Func_0E0_510C:: ; address name
    ld hl, vBGMap0
    ld de, $53EB
    ld bc, $1412
    ld a, $E0
    call CopyRectFromBankToVRAM
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_E0_511B::
Data_0E0_511B:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $C3, $F8, $F9, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $EA, $C3, $C3, $C3, $C3, $C3, $EA, $C3, $C3, $C3, $C3, $C3, $EA, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $ED, $FF, $C3, $C3, $C3, $C3, $ED, $FF, $C3, $C3, $C3, $C3, $ED, $FF, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $EE, $00, $C3, $C3, $C3, $C3, $EE, $00, $C3, $C3, $C3, $C3, $EE, $00, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $EF, $01, $C3, $C3, $C3, $C3, $EF, $01, $C3, $C3, $C3, $C3, $EF, $01, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B6, $F0, $02, $C3, $C3, $C3, $C3, $F0, $02, $C3, $C3, $C3, $C3, $F0, $02, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $F2, $04, $C3, $C3, $C3, $C3, $F2, $04, $C3, $C3, $C3, $C3, $F2, $04, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $F4, $06, $C3, $C3, $C3, $C3, $F4, $06, $C3, $C3, $C3, $C3, $F4, $06, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $F3, $05, $C3, $C3, $C3, $C3, $F3, $05, $C3, $C3, $C3, $C3, $F3, $05, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $B6, $F1, $03, $C3, $C3, $C3, $C3, $F1, $03, $C3, $C3, $C3, $C3, $F1, $03, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $F1, $07, $C3, $C3, $C3, $C3, $F1, $07, $C3, $C3, $C3, $C3, $F1, $07, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $B6, $C3, $C3, $C3, $C3, $FA, $FB, $FC, $FD, $FE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_E0_5283::
Data_0E0_5283:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $0E, $09, $0F, $C3, $0C, $0D, $0D, $0C, $0A, $FF, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $14, $15, $16, $17, $18, $19, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $1A, $1B, $1C, $1D, $1E, $1F, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $20, $21, $22, $23, $24, $25, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $26, $27, $28, $29, $2A, $2B, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $2C, $2D, $2E, $2F, $30, $31, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $32, $33, $34, $35, $36, $37, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $0B, $C3, $F5, $F6, $F7, $C3, $F8, $F9, $C3, $C3, $EC, $C3, $F5, $F6, $F7, $C3, $F8, $F9, $B7 ; id 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $E1, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $E2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $B6, $EC, $01, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $E3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_E0_53EB::
Data_0E0_53EB:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $09, $F0, $FF, $C3, $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $09, $FF, $E0, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $09, $FF, $E1, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $09, $FF, $E2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $09, $FF, $E3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $09, $FF, $E4, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $09, $FF, $E5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B6, $C3, $09, $FF, $E6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $09, $FF, $E7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 11
    db $B6, $C3, $09, $FF, $E8, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 12
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 15
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 17

; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ShowStringBank09AtTilesHL_BankE0)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtTilesHL_BankE0::
Func_0E0_5553:: ; address name
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

; only called from DrawHexByteAtBGMap8A (E-0047)
; 1 call site from 1 routine (e.g. DrawHexByteAtBGMap8A)
; reads: wDebugSubState
DrawHexByteAtBGMap8A_QueueSoundEffect::
Func_0E0_558E:: ; address name
    ld a, [wDebugSubState]
    ld hl, DebugSoundEffectList
    add_a_to_hl
    ld a, [hl]
    call QueueSoundEffect
    ret

; loads wBattleActor, wBattleTarget, wBattleActionId and wEffectFlags2 from the 4-byte entry A of the table at $55FB, then far-calls SelectEffectByEffectFlags2Flags (a test or debug entry list) (E-0118)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wBattleTarget, wBattleActionId, wEffectFlags2
RunEffectTestEntryA:: ; heuristic: follows a terminator; C0
Func_0E0_559E:: ; address name
    add a, a
    add a, a
    ld hl, EffectTestEntries
    add_a_to_hl
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl+]
    ld [wBattleActionId], a
    ld a, [hl]
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ret

; E-0213 (C1: DrawHexByteAtBGMap8A_Sub03 (debug menu) plays QueueSoundEffect with the byte at $55BF + wDebugSubState; 60 bytes end at EffectTestEntries).
; record: sound effect number
DebugSoundEffectList::
Data_0E0_55BF:: ; address name
    db $89 ; id 0
    db $8B ; id 1
    db $8B ; id 2
    db $8D ; id 3
    db $8D ; id 4
    db $8F ; id 5
    db $90 ; id 6
    db $D9 ; id 7
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
    db $9A ; id 24
    db $9B ; id 25
    db $9D ; id 26
    db $9E ; id 27
    db $9F ; id 28
    db $99 ; id 29
    db $A2 ; id 30
    db $A3 ; id 31
    db $A4 ; id 32
    db $A5 ; id 33
    db $A7 ; id 34
    db $A8 ; id 35
    db $DA ; id 36
    db $99 ; id 37
    db $A9 ; id 38
    db $AA ; id 39
    db $AB ; id 40
    db $AC ; id 41
    db $AE ; id 42
    db $B0 ; id 43
    db $85 ; id 44
    db $B2 ; id 45
    db $B4 ; id 46
    db $B8 ; id 47
    db $B6 ; id 48
    db $DC ; id 49
    db $BA ; id 50
    db $BC ; id 51
    db $BD ; id 52
    db $BF ; id 53
    db $C1 ; id 54
    db $C3 ; id 55
    db $C5 ; id 56
    db $C7 ; id 57
    db $C9 ; id 58
    db $CB ; id 59

; E-0213 (C1: RunEffectTestEntryA loads the 4-byte entry at $55FB + 4 * A into wBattleActor, wBattleTarget, wBattleActionId and wEffectFlags2, then far-calls SelectEffectByEffectFlags2Flags; 51 entries end at the code at $56C7).
; record: wBattleActor, wBattleTarget, wBattleActionId, wEffectFlags2
EffectTestEntries::
Data_0E0_55FB:: ; address name
    db $00, $04, $01, $40 ; id 0
    db $00, $04, $02, $40 ; id 1
    db $00, $04, $03, $40 ; id 2
    db $00, $04, $04, $40 ; id 3
    db $00, $04, $05, $40 ; id 4
    db $00, $04, $06, $40 ; id 5
    db $00, $04, $07, $40 ; id 6
    db $00, $04, $08, $40 ; id 7
    db $00, $04, $09, $40 ; id 8
    db $00, $04, $0A, $40 ; id 9
    db $00, $04, $0B, $40 ; id 10
    db $00, $04, $0C, $40 ; id 11
    db $00, $04, $10, $40 ; id 12
    db $00, $04, $11, $40 ; id 13
    db $00, $04, $12, $40 ; id 14
    db $00, $04, $0D, $40 ; id 15
    db $00, $04, $0E, $40 ; id 16
    db $00, $04, $0F, $40 ; id 17
    db $00, $04, $27, $40 ; id 18
    db $04, $04, $25, $40 ; id 19
    db $04, $04, $16, $40 ; id 20
    db $00, $04, $2F, $40 ; id 21
    db $00, $04, $34, $40 ; id 22
    db $00, $04, $2E, $40 ; id 23
    db $04, $04, $3B, $40 ; id 24
    db $04, $04, $39, $40 ; id 25
    db $00, $04, $47, $40 ; id 26
    db $00, $04, $4B, $40 ; id 27
    db $00, $04, $43, $40 ; id 28
    db $00, $04, $62, $40 ; id 29
    db $00, $04, $50, $40 ; id 30
    db $00, $04, $52, $40 ; id 31
    db $00, $04, $51, $40 ; id 32
    db $00, $04, $53, $40 ; id 33
    db $00, $04, $54, $40 ; id 34
    db $00, $04, $57, $40 ; id 35
    db $00, $04, $5A, $40 ; id 36
    db $00, $04, $5C, $40 ; id 37
    db $00, $04, $67, $40 ; id 38
    db $00, $04, $66, $40 ; id 39
    db $00, $04, $3F, $40 ; id 40
    db $00, $04, $3E, $40 ; id 41
    db $00, $04, $3D, $40 ; id 42
    db $00, $04, $83, $40 ; id 43
    db $10, $04, $FF, $04 ; id 44
    db $00, $04, $4C, $40 ; id 45
    db $00, $04, $4D, $40 ; id 46
    db $00, $04, $5D, $40 ; id 47
    db $00, $04, $91, $40 ; id 48
    db $04, $04, $9B, $40 ; id 49
    db $04, $04, $A1, $40 ; id 50

; only called from RunDebugState_E0_ChooseActionTargets_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_PersonalityIndexOfSlot_BankE0)
; reads: wBattleActor, wLinkMode, wRandomSeed2Lo, wRandomSeed2Hi, wRandomLo, wRandomHi
; writes: wRandomLo, wRandomHi, wRandomSeed2Lo, wRandomSeed2Hi
; points at: wBattleActionChoice
RunDebugState_E0_ChooseActionTargets_Case01_WriteRandomLoAndRandomHiEtc::
Func_0E0_56C7:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wLinkMode]
    or a, a
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

; when the actor's wBattleTargetChoice entry is $FF (no target yet), far-calls ChooseActionTarget (E-0112)
; 2 call sites from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case01_WriteRandomLoAndRandomHiEtc)
; reads: wBattleActor
; points at: wBattleTargetChoice
ChooseTargetIfUnset::
Func_0E0_5715:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, .return
    farcall ChooseActionTarget

.return:
    ret

; only called from RunDebugState_E0_ChooseActionTargets_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_WriteDebugSubState)
; reads: wBattleActor, wLinkMode, hTemp3, hTemp2
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory, wDigits, hTemp1, ...
; points at: wSlotTactic, wSlotAIMode, wBattleSkillsPrefix, wAIWeights, wBattleActionChoice, wAIChoiceOrder
RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor::
Func_0E0_572D:: ; address name
    call DisplayedSlotOfActor
    ld hl, $5A05
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
    ld hl, vTiles1 + $1B0
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
    and a, $03
    cp a, $03
    jr z, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    add a, $02
    ld [wStringIndex], a
    ld a, $0E
    ld [wStringCategory], a
    ld hl, vTiles1 + $1B0
    ld de, $0801
    call ShowStringBank08AtTilesHLThenDefault_BankE0_5A79

.read_battle_actor:
    ld a, [wBattleActor]
    ld de, wSlotAIMode
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a, $8D
    ld hl, vBGMap0 + $46
    di
    call WriteVRAMByte
    ei
    ld hl, vTiles1 + $6D0
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
    ld hl, vTiles1 + $6D0
    ld de, $0701
    call ShowStringBank08AtTilesHLThenDefault_BankE0_5A79
    ld a, [wLinkMode]
    cp a, $01
    ld a, [wBattleActor]
    jr z, .skip2
    sub a, $04
    jr nc, .skip3

.skip2:
    ld a, $C3
    ld hl, vBGMap0 + $1AF
    di
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByte
    ei
    jr .read_battle_actor2

.skip3:
    ld de, wEncounterMonsters + $1
    add a, a
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld hl, vBGMap0 + $1AF
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    dec de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
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
    ld hl, vBGMap0 + $A2
    ld b, $08

.loop2:
    push hl
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    inc hl
    inc de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
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
    ld hl, vBGMap0 + $A8
    ld b, $0A

.loop3:
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    and a, c
    cp a, $FF
    jr nz, .skip5
    ld a, [de]
    and a, $F0
    swap a
    push hl
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    dec de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
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
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop bc
    pop de
    pop hl
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp2]
    or a, c
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
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    or a, a
    jr nz, .call_show_string_bank08_at_tiles_hl_then
    ld a, $0E
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a

.call_show_string_bank08_at_tiles_hl_then:
    ld hl, vTiles1 + $120
    ld de, $0901
    call ShowStringBank08AtTilesHLThenDefault_BankE0_5A79
    ld a, [wBattleActor]
    add a, a
    ld de, wBattleActionChoice
    add a, e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    ld hl, vBGMap0 + $202
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    call DisplayedTargetChoiceOfActor
    ld hl, $5A05
    call ReadWordTableEntry_Bank00
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $20F
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
    ld a, [hl+]
    cp a, c
    jr nz, .next2
    ld de, $FFFC
    add hl, de
    ld a, [hl]
    ld [wDigits], a
    xor a, a
    ld [wDigits + $1], a
    ld [wDigits + $2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    swap c
    ld b, $00
    ld hl, vBGMap0 + $8F
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
    and a, $0F
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

; A = wBattleActor, with bit 2 flipped when wLinkMode = 1 and wLinkRole bit 1 is set (the side swap of the battle panels) (E-0118)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor)
; reads: wLinkMode, wBattleActor
; points at: wLinkRole
DisplayedSlotOfActor::
Func_0E0_5992:: ; address name
    ld a, [wLinkMode]
    ld hl, wLinkRole
    cp a, $01
    ld a, [wBattleActor]
    ret nz
    bit 1, [hl]
    ret z
    xor a, $04
    ret

; A = wBattleTargetChoice[wBattleActor * 2]; in link mode 1 with wLinkRole bit 1 set, flips bit 2 (the side) so the choice is shown from this player's side
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor)
; reads: wBattleActor, wLinkMode
; points at: wBattleTargetChoice, wLinkRole
DisplayedTargetChoiceOfActor::
Func_0E0_59A4:: ; address name
    ld a, [wBattleActor]
    add a, a
    ld de, wBattleTargetChoice
    add a, e
    ld e, a
    jr nc, .read_link_mode
    inc d

.read_link_mode:
    ld a, [wLinkMode]
    ld hl, wLinkRole
    cp a, $01
    ld a, [de]
    ret nz
    bit 1, [hl]
    ret z
    xor a, $04
    ret

; writes hTemp1's high nibble as a tile (nibble + 1, or $C3 while every digit so far is zero; C tracks that), then falls into WriteLowHexDigitTilesOfTemp1Temp0 for the remaining nibbles
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor)
; reads: hTemp1, hTemp0
WriteHexDigitTilesOfTemp1Temp0::
Func_0E0_59C0:: ; address name
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, .call_write_vram_byte_inc
    ld a, $C2

.call_write_vram_byte_inc:
    inc a
    di
    call WriteVRAMByteInc
    ei

; the second half of WriteHexDigitTilesOfTemp1Temp0: hTemp1's low nibble and hTemp0's nibbles as digit tiles
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor)
; reads: hTemp1, hTemp0
WriteLowHexDigitTilesOfTemp1Temp0::
Func_0E0_59D4:: ; address name
    ldh a, [hTemp1]
    and a, $0F
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, .call_write_vram_byte_inc
    ld a, $C2

.call_write_vram_byte_inc:
    inc a
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, .call_write_vram_byte_inc2
    ld a, $C2

.call_write_vram_byte_inc2:
    inc a
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and a, $0F
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

PointerRun_E0_5A05_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A15:: ; address name
    db $80, $81, $82, $01

PointerRun_E0_5A05_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A19:: ; address name
    db $80, $81, $82, $02

PointerRun_E0_5A05_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A1D:: ; address name
    db $80, $81, $82, $03

PointerRun_E0_5A05_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A21:: ; address name
    db $80, $81, $82, $04

PointerRun_E0_5A05_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A25:: ; address name
    db $83, $84, $01, $C3

PointerRun_E0_5A05_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A29:: ; address name
    db $83, $84, $02, $C3

PointerRun_E0_5A05_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A2D:: ; address name
    db $83, $84, $03, $C3

PointerRun_E0_5A05_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_0E0_5A31:: ; address name
    db $83, $84, $04, $C3

; only called from RunDebugState_E0_ChooseActionTargets_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_WriteDebugSubState_Case05)
; reads: wLinkMode, wRandomSeed2Lo, wRandomSeed2Hi, wRandomLo, wRandomHi
; writes: wRandomLo, wRandomHi, wRandomSeed2Lo, wRandomSeed2Hi
RunDebugState_E0_ChooseActionTargets_Case05_AIChooseActionForActor::
Func_0E0_5A35:: ; address name
    ld a, [wLinkMode]
    or a, a
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

; sets the string window to HL (tile destination) and DE (size), far-calls ShowString_Bank08, then sets the window to vTiles1 with size word $1202 (E-0067) (the same 45 bytes appear in 2 banks)
; 3 call sites from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHLThenDefault_BankE0_5A79::
Func_0E0_5A79:: ; address name
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

; the same 45 bytes as ShowStringBank09AtHLSizeDEThenDefault (E0:42A6)
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtHLSizeDEThenDefault_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 00:2E98; C0
Func_0E0_5AA6:: ; address name
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

; only called from DebugStaffRoll_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugStaffRoll_Update)
; reads: wWorkBuf
DebugStaffRoll_Update_RunFieldEventFieldEventKind::
Func_0E0_5AD3:: ; address name
    ld a, [wWorkBuf]
    or a, a
    jp z, DebugStaffRoll_Scene04_DrawSpriteSlots_Case08_CheckWorkBuf
    farcall RunFieldEventFieldEventKind
    call IncrementSpriteSlotCounters
    ld a, [wWorkBuf + $2]
    dec a
    rst $00
    dw DebugStaffRoll_Scene00
    dw DebugStaffRoll_Scene01
    dw DebugStaffRoll_Scene02
    dw DebugStaffRoll_Scene03
    dw DebugStaffRoll_Scene04

; by wWorkBuf+1: decompresses the scene's graphics, then one DrawSpriteSlots step per frame step
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
DebugStaffRoll_Scene00::
Jump_0E0_5AF2:: ; address name
    ld a, [wWorkBuf + $1]
    rst $00
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

; entry 0 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount, wFieldEventKind
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wSpriteSlots
DebugStaffRoll_Scene00_DecompressToVRAM::
Jump_0E0_5B16:: ; address name
    ld b, $7D
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7E
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
    or a, a
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
    ld b, $7E
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
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
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $0A
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wSpriteSlotCount
DebugStaffRoll_Scene00_DrawSpriteSlots::
Jump_0E0_5C32:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
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

; entry 2 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene00_DrawSpriteSlots_Case02::
Jump_0E0_5C58:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $A]
    inc a
    ld [wWorkBuf + $A], a
    and a, $01
    ret nz
    ld a, $03
    ld de, $6060
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wWorkBuf + $A], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case03::
Jump_0E0_5C7B:: ; address name
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

; entry 4 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case04::
Jump_0E0_5C91:: ; address name
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

; entry 5 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case05::
Jump_0E0_5CB5:: ; address name
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

; entry 6 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; writes: wWorkBuf
DebugStaffRoll_Scene00_DrawSpriteSlots_Case06::
Jump_0E0_5CD1:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $6030
    call StepSpriteSlotTowardDE
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wWorkBuf + $A], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 9 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case09::
Jump_0E0_5CEA:: ; address name
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

; entry 10 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case0A::
Jump_0E0_5D14:: ; address name
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

; entry 11 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case0B::
Jump_0E0_5D46:: ; address name
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

; entry 12 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case0C::
Jump_0E0_5D7F:: ; address name
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

; entry 13 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D::
Jump_0E0_5D9F:: ; address name
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

; entry 14 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case0E::
Jump_0E0_5DCA:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 15 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventKind, wWorkBuf
DebugStaffRoll_Scene00_DrawSpriteSlots_Case0F::
Jump_0E0_5DDD:: ; address name
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
    xor a, a
    ld [wFieldEventKind], a
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; entry 7 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene00_DrawSpriteSlots_Case07::
Jump_0E0_5E07:: ; address name
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

; entry 8 of the `rst $00` table in DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene00_DrawSpriteSlots_Case08::
Jump_0E0_5E24:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $A]
    inc a
    ld [wWorkBuf + $A], a
    and a, $01
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
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
DebugStaffRoll_Scene01::
Jump_0E0_5E4B:: ; address name
    ld a, [wWorkBuf + $1]
    rst $00
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

; entry 0 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount, wFieldEventKind
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wSpriteSlots
DebugStaffRoll_Scene01_DecompressToVRAM::
Jump_0E0_5E83:: ; address name
    ld b, $7D
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
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
    or a, a
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
    ld b, $7E
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
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
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $70
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
DebugStaffRoll_Scene01_DrawSpriteSlots::
Jump_0E0_5F6F:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
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

; entry 2 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene01_DrawSpriteSlots_Case02::
Jump_0E0_5F91:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and a, $07
    ld hl, $5FE3
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and a, $07
    ld hl, $5FE8
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    cp a, $9F
    ret c
    xor a, a
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

; entry 3 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene01_DrawSpriteSlots_Case03::
Jump_0E0_5FED:: ; address name
    call DrawSpriteSlots
    ld a, $03
    ld [wSpriteSlotCount], a
    call StepWD0A2Mod15
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wWorkBuf
; writes: wWorkBuf, wObject1
DebugStaffRoll_Scene01_DrawSpriteSlots_Case04::
Jump_0E0_5FFE:: ; address name
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
    xor a, a
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
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret
    db $FE, $FE, $FE, $FF, $FF, $FF, $00, $00, $00, $00, $01, $01, $01, $02, $02, $02

; entry 5 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene01_DrawSpriteSlots_Case05::
Jump_0E0_6048:: ; address name
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

; entry 22 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wObject1
; writes: wObject1, wWorkBuf
DebugStaffRoll_Scene01_DrawSpriteSlots_Case16::
Jump_0E0_605D:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    cp a, $20
    jr nc, .call_step_wd0_a2_mod15
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.call_step_wd0_a2_mod15:
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 20 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene01_DrawSpriteSlots_Case14::
Jump_0E0_6093:: ; address name
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

; entry 21 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene01_DrawSpriteSlots_Case15::
Jump_0E0_60C0:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $3030
    call StepSpriteSlotToward
    ret nz
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 24 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wSpriteSlotCount, wObject1
DebugStaffRoll_Scene01_DrawSpriteSlots_Case18::
Jump_0E0_60DF:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, [wObject1 + OBJ_SPRITE_ID]
    cp a, $F0
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
    sub a, $02
    ld [wObject1 + OBJ_SPRITE_ID], a
    ld a, [wObject1 + OBJ_STATE]
    inc a
    ld [wObject1 + OBJ_STATE], a
    ret

; entry 25 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wSpriteSlots, wSpriteSlotCount, wFieldEventKind, wWorkBuf
DebugStaffRoll_Scene01_DrawSpriteSlots_Case19::
Jump_0E0_6120:: ; address name
    call DrawSpriteSlots
    ld a, [wSpriteSlots + $2]
    cp a, $F0
    jr z, .check_sprite_slots
    sub a, $01
    ld [wSpriteSlots + $2], a
    ld a, [wSpriteSlots + $7]
    inc a
    ld [wSpriteSlots + $7], a

.check_sprite_slots:
    ld a, [wSpriteSlots + $A]
    cp a, $F0
    jr nz, .set_sprite_slots
    ld a, $02
    ld [wSpriteSlotCount], a
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wFieldEventKind], a
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ret

.set_sprite_slots:
    sub a, $01
    ld [wSpriteSlots + $A], a
    ld a, [wSpriteSlots + $F]
    inc a
    ld [wSpriteSlots + $F], a
    ret

; entry 6 of the `rst $00` table in DebugStaffRoll_Scene01; also entries 10, 14, 18 of the table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wWorkBuf
; writes: wWorkBuf, wObject1
DebugStaffRoll_Scene01_DrawSpriteSlots_Case06::
Jump_0E0_6165:: ; address name
    call DrawSpriteSlots
    ld d, $50
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a, a
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
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

; entry 9 of the `rst $00` table in DebugStaffRoll_Scene01; also entries 13, 17 of the table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wWorkBuf
; writes: wWorkBuf, wObject1
DebugStaffRoll_Scene01_DrawSpriteSlots_Case09::
Jump_0E0_6194:: ; address name
    call DrawSpriteSlots
    ld d, $60
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a, a
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
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

; entry 7 of the `rst $00` table in DebugStaffRoll_Scene01; also entries 11, 15, 19 of the table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wWorkBuf
; writes: wWorkBuf, wObject1
DebugStaffRoll_Scene01_DrawSpriteSlots_Case07::
Jump_0E0_61C3:: ; address name
    call DrawSpriteSlots
    ld d, $40
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a, a
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
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

; entry 8 of the `rst $00` table in DebugStaffRoll_Scene01; also entries 12, 16 of the table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wWorkBuf
; writes: wWorkBuf, wObject1
DebugStaffRoll_Scene01_DrawSpriteSlots_Case08::
Jump_0E0_61F2:: ; address name
    call DrawSpriteSlots
    ld d, $50
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, .read_work_buf
    xor a, a
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
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ret

; entry 23 of the `rst $00` table in DebugStaffRoll_Scene01
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wSpriteSlots
; writes: wSpriteSlots, wWorkBuf
DebugStaffRoll_Scene01_DrawSpriteSlots_Case17::
Jump_0E0_6221:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .call_step_wd0_a2_mod15
    and a, $07
    ld c, a
    ld b, $00
    ld hl, $625E
    add hl, bc
    ld a, [wSpriteSlots + $3]
    add a, [hl]
    ld [wSpriteSlots + $3], a
    ld a, [wSpriteSlots + $B]
    add a, [hl]
    ld [wSpriteSlots + $B], a
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $FD, $FE, $FF, $00, $00, $01, $02, $03

; as DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
DebugStaffRoll_Scene02::
Jump_0E0_6266:: ; address name
    ld a, [wWorkBuf + $1]
    rst $00
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

; entry 0 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wSpriteSlots
DebugStaffRoll_Scene02_DecompressToVRAM::
Jump_0E0_62A0:: ; address name
    ld b, $7D
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7E
    ld de, FieldSpriteGfx5F
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $21
    ld de, MonsterSprite_Watabou
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, $7D
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
    or a, a
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
    ld b, $7E
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus10Data_7E_4B2D
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $27
    ld de, OBJPaletteBufferPlus18Data_27_7850
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus20Data_7E_4B4D
    ld hl, wOBJPaletteBuffer + $20
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
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
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $5F
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A5
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
DebugStaffRoll_Scene02_DrawSpriteSlots::
Jump_0E0_6417:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
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

; entry 2 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf, wSpriteSlotCount
DebugStaffRoll_Scene02_DrawSpriteSlots_Case02::
Jump_0E0_6439:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and a, $07
    ld hl, $6490
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and a, $07
    ld hl, $6495
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    cp a, $9F
    ret c
    xor a, a
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

; entry 3 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene02_DrawSpriteSlots_Case03::
Jump_0E0_649A:: ; address name
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

; entry 4 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case04::
Jump_0E0_64B0:: ; address name
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

; entry 10 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene02_DrawSpriteSlots_Case0A::
Jump_0E0_64DE:: ; address name
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

; entry 11 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case0B::
Jump_0E0_64F4:: ; address name
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

; entry 17 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wSpriteSlots
; writes: wSpriteSlots, wWorkBuf
DebugStaffRoll_Scene02_DrawSpriteSlots_Case11::
Jump_0E0_6514:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .call_set_sprite_slot_byte5
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wSpriteSlots + $3]
    add a, [hl]
    ld [wSpriteSlots + $3], a
    ld a, [wSpriteSlots + $B]
    add a, [hl]
    ld [wSpriteSlots + $B], a
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 22 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wObject2
; writes: wObject2, wWorkBuf
DebugStaffRoll_Scene02_DrawSpriteSlots_Case16::
Jump_0E0_6551:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .call_step_wd0_a2_mod30
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add a, [hl]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    ld a, [wObject2 + OBJ_X]
    add a, [hl]
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 23 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene02_DrawSpriteSlots_Case17::
Jump_0E0_6595:: ; address name
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

; entry 24 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene02_DrawSpriteSlots_Case18::
Jump_0E0_65BD:: ; address name
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

; entry 25 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case19::
Jump_0E0_65F8:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $A070
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

; entry 5 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case05::
Jump_0E0_6626:: ; address name
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

; entry 6 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case06::
Jump_0E0_664D:: ; address name
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

; entry 7 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case07::
Jump_0E0_666D:: ; address name
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

; entry 8 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case08::
Jump_0E0_668D:: ; address name
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

; entry 9 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene02_DrawSpriteSlots_Case09::
Jump_0E0_66A5:: ; address name
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

; entry 12 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case0C::
Jump_0E0_66DB:: ; address name
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

; entry 13 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case0D::
Jump_0E0_6702:: ; address name
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

; entry 14 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case0E::
Jump_0E0_6722:: ; address name
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

; entry 15 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case0F::
Jump_0E0_6742:: ; address name
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

; entry 16 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case10::
Jump_0E0_675A:: ; address name
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

; entry 26 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; writes: wWorkBuf
DebugStaffRoll_Scene02_DrawSpriteSlots_Case1A::
Jump_0E0_677D:: ; address name
    call DrawSpriteSlots
    ld a, $01
    ld de, $A070
    call StepSpriteSlotToward
    ld a, $00
    ld de, $A070
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
    xor a, a
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; entry 18 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wObject2
; writes: wObject2, wWorkBuf
DebugStaffRoll_Scene02_DrawSpriteSlots_Case12::
Jump_0E0_67B1:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .call_step_wd0_a2_mod60
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_X]
    add a, [hl]
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 19 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case13::
Jump_0E0_67E7:: ; address name
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

; entry 20 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene02_DrawSpriteSlots_Case14::
Jump_0E0_6801:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod30
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 21 of the `rst $00` table in DebugStaffRoll_Scene02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene02_DrawSpriteSlots_Case15::
Jump_0E0_680D:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and a, $07
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
    cp a, $03
    ret c
    xor a, a
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; as DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
DebugStaffRoll_Scene03::
Jump_0E0_6841:: ; address name
    ld a, [wWorkBuf + $1]
    rst $00
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

; entry 0 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wSpriteSlots
DebugStaffRoll_Scene03_DecompressToVRAM::
Jump_0E0_685B:: ; address name
    ld b, $7D
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx02
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx12
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx0E
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, $7E
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
    or a, a
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
    ld b, $7E
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus20Data_7E_4B4D
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus10Data_7E_4B45
    ld hl, wOBJPaletteBuffer + $18
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus10Data_7E_4B2D
    ld hl, wOBJPaletteBuffer + $20
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus28Data_7E_4B1D
    ld hl, wOBJPaletteBuffer + $28
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
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
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $12
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $0E
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $15
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $06
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
DebugStaffRoll_Scene03_DrawSpriteSlots::
Jump_0E0_6A10:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
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

; entry 2 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf, wSpriteSlotCount
DebugStaffRoll_Scene03_DrawSpriteSlots_Case02::
Jump_0E0_6A32:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and a, $07
    ld hl, $6490
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    srl a
    swap a
    and a, $07
    ld hl, $6495
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    cp a, $9F
    ret c
    xor a, a
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

; entry 3 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
DebugStaffRoll_Scene03_DrawSpriteSlots_Case03::
Jump_0E0_6A89:: ; address name
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

; entry 4 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene03_DrawSpriteSlots_Case04::
Jump_0E0_6AA1:: ; address name
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

; entry 5 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wObject2
; writes: wObject2, wWorkBuf, wSpriteSlotCount, wObject1
DebugStaffRoll_Scene03_DrawSpriteSlots_Case05::
Jump_0E0_6ABE:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .set_sprite_slot_count_to_05
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_X]
    add a, [hl]
    ld [wObject2 + OBJ_X], a
    ld a, [wWorkBuf + $6]
    srl a
    srl a
    ld hl, $6B06
    ld [wObject2 + OBJ_FLAGS], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.set_sprite_slot_count_to_05:
    ld a, $05
    ld [wSpriteSlotCount], a
    ld a, [wObject2 + OBJ_X]
    add a, [hl]
    ld [wObject1 + OBJ_X], a
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $03, $02, $01, $00

; entry 6 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wObject2
; writes: wObject2, wWorkBuf, wSpriteSlotCount, wObject1
DebugStaffRoll_Scene03_DrawSpriteSlots_Case06::
Jump_0E0_6B0A:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .set_sprite_slot_count_to_04
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add a, [hl]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    ld a, [wWorkBuf + $6]
    srl a
    srl a
    ld hl, $6B52
    ld [wObject2 + $5], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.set_sprite_slot_count_to_04:
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, [wObject2 + OBJ_SPRITE_ID + 1]
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    call StepWD0A2Mod30
    ret nz
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $02, $01, $00, $03

; entry 7 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene03_DrawSpriteSlots_Case07::
Jump_0E0_6B56:: ; address name
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

; entry 8 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene03_DrawSpriteSlots_Case08::
Jump_0E0_6B99:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $50A0
    call StepSpriteSlotToward
    ld a, $03
    ld de, $50A0
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

; entry 9 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene03_DrawSpriteSlots_Case09::
Jump_0E0_6BC4:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $40A0
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

; entry 10 of the `rst $00` table in DebugStaffRoll_Scene03
; no direct call (reached through a table, a jump or a vector)
; writes: wWorkBuf
DebugStaffRoll_Scene03_DrawSpriteSlots_Case0A::
Jump_0E0_6BE4:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $40A0
    call StepSpriteSlotToward
    ld a, $01
    ld de, $40B0
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; as DebugStaffRoll_Scene00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
DebugStaffRoll_Scene04::
Jump_0E0_6C0A:: ; address name
    ld a, [wWorkBuf + $1]
    rst $00
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

; entry 0 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wSpriteSlots
DebugStaffRoll_Scene04_DecompressToVRAM::
Jump_0E0_6C2C:: ; address name
    ld b, $7D
    ld de, FieldSpriteGfx00
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx01
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, FieldSpriteGfx03
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7D
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
    or a, a
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
    ld b, $7E
    ld de, OBJPaletteBufferData_7E_4BA5
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus8Data_7E_4BAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus20Data_7E_4B4D
    ld hl, wOBJPaletteBuffer + $10
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
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
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
DebugStaffRoll_Scene04_DrawSpriteSlots::
Jump_0E0_6D43:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
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

; entry 2 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case02::
Jump_0E0_6D73:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and a, $03
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
    cp a, $07
    ret c
    xor a, a
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case03::
Jump_0E0_6DA7:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and a, $03
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
    cp a, $07
    ret c
    cp a, $0F
    jr c, .call_set_sprite_slot_byte5
    xor a, a
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

; entry 9 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wObject1
; writes: wObject1, wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case09::
Jump_0E0_6DEE:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $20
    jr nc, .call_step_sprite_slot_toward
    and a, $1F
    ld c, a
    ld b, $00
    ld hl, $6E83
    add hl, bc
    ld a, [wObject1 + OBJ_SPRITE_ID + 1]
    add a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ld e, a
    ld d, $10
    ld a, $02
    call StepSpriteSlotToward
    jr .read_work_buf

.call_step_sprite_slot_toward:
    ld a, $02
    ld de, $10A0
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward

.read_work_buf:
    ld a, [wWorkBuf + $6]
    sub a, $10
    jr c, .call_step_sprite_slot_toward2
    cp a, $20
    jr nc, .call_step_sprite_slot_toward3
    and a, $1F
    ld c, a
    ld b, $00
    ld hl, $6E83
    add hl, bc
    ld a, [wObject1 + OBJ_X]
    add a, [hl]
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
    ld de, $10A0
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret
    db $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03

; entry 10 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wSpriteSlots
; writes: wSpriteSlots, wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case0A::
Jump_0E0_6EA3:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    cp a, $10
    jr nc, .cp_20
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wSpriteSlots + $3]
    add a, [hl]
    ld [wSpriteSlots + $3], a
    ld a, [wSpriteSlots + $B]
    add a, [hl]
    ld [wSpriteSlots + $B], a
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    ret

.cp_20:
    cp a, $20
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 11 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene04_DrawSpriteSlots_Case0B::
Jump_0E0_6EEF:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 13 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene04_DrawSpriteSlots_Case0D::
Jump_0E0_6EFB:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $A040
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

; entry 14 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; writes: wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case0E::
Jump_0E0_6F1B:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $A040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $A040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; entry 5 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene04_DrawSpriteSlots_Case05::
Jump_0E0_6F41:: ; address name
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

; entry 12 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case0C::
Jump_0E0_6F5B:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and a, $03
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene04_DrawSpriteSlots_Case04::
Jump_0E0_6F8D:: ; address name
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

; entry 6 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene04_DrawSpriteSlots_Case06::
Jump_0E0_6FA7:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 7 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Scene04_DrawSpriteSlots_Case07::
Jump_0E0_6FB3:: ; address name
    call DrawSpriteSlots
    ld a, [wWorkBuf + $6]
    inc a
    ld [wWorkBuf + $6], a
    and a, $03
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
    xor a, a
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 8 of the `rst $00` table in DebugStaffRoll_Scene04
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Scene04_DrawSpriteSlots_Case08::
Jump_0E0_6FDE:: ; address name
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
Jump_0E0_6FF7:: ; address name
    ld a, [wWorkBuf + $2]
    or a, a
    jr z, .read_work_buf
    ld a, [wWorkBuf + $1]
    rst $00
    dw DebugStaffRoll_Update_Sub01_Table2_Case00
    dw DebugStaffRoll_Update_Sub01_Table2_Case01
    dw DebugStaffRoll_Update_Sub01_Table2_Case02

.read_work_buf:
    ld a, [wWorkBuf + $1]
    rst $00
    dw DebugStaffRoll_Update_Sub01_Table3_Case00
    dw DebugStaffRoll_Update_Sub01_Table3_Case01
    dw DebugStaffRoll_Update_Sub01_Table3_Case02

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wIsCGB, wSGBActive
; writes: wWorkBuf, wStringCategory, wStringIndex, rVBK
DebugStaffRoll_Update_Sub01_Table2_Case00::
Jump_0E0_7011:: ; address name
    ld a, [wWorkBuf + $4]
    or a, a
    jr nz, .read_work_buf
    ld hl, vTiles2 + $7F0
    ld de, $0101
    call FillTilesRequest
    ld a, [wWorkBuf + $2]
    dec a
    ld hl, WorkBufSequenceTable
    call ReadWordTableEntry_Bank00
    ld a, [hl+]
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
    ld a, [hl+]
    cp a, $FE
    jp nz, .set_work_buf2
    ld a, l
    ld [wWorkBuf + $10], a
    ld a, h
    ld [wWorkBuf + $11], a
    ld bc, vTiles1
    ld a, c
    ld [wWorkBuf + $C], a
    ld a, b
    ld [wWorkBuf + $D], a
    xor a, a
    ld [wWorkBuf + $A], a

.skip:
    ld a, [hl+]
    ld c, a
    cp a, $FF
    jp z, .set_work_buf
    ld a, [wWorkBuf + $A]
    add a, c
    ld [wWorkBuf + $A], a
    ld a, c
    or a, a
    jr nz, .read_work_buf2
    inc hl
    jr .read_work_buf3

.read_work_buf2:
    push hl
    ld a, [wWorkBuf + $C]
    ld l, a
    ld a, [wWorkBuf + $D]
    ld h, a
    ld de, $1202
    call FillTilesRequest
    ld a, [wWorkBuf + $C]
    ld l, a
    ld a, [wWorkBuf + $D]
    ld h, a
    ld de, $0240
    add hl, de
    ld a, l
    ld [wWorkBuf + $C], a
    ld a, h
    ld [wWorkBuf + $D], a
    pop hl
    xor a, a
    ld [wStringCategory], a
    ld a, [hl+]
    ld [wStringIndex], a
    cp a, $FF
    jr z, .read_work_buf3
    push hl
    call ShowString_BankE0
    pop hl

.read_work_buf3:
    ld a, [hl+]
    ld c, a
    ld a, [wWorkBuf + $A]
    add a, c
    ld a, a
    ld [wWorkBuf + $A], a
    ld a, c
    or a, a
    jr nz, .read_work_buf4
    inc hl
    jr .skip

.read_work_buf4:
    push hl
    ld a, [wWorkBuf + $C]
    ld l, a
    ld a, [wWorkBuf + $D]
    ld h, a
    ld de, $1201
    call FillTilesRequest
    ld a, [wWorkBuf + $C]
    ld l, a
    ld a, [wWorkBuf + $D]
    ld h, a
    ld de, $0120
    add hl, de
    ld a, l
    ld [wWorkBuf + $C], a
    ld a, h
    ld [wWorkBuf + $D], a
    pop hl
    ld a, $01
    ld [wStringCategory], a
    ld a, [hl+]
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
    or a, a
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
    ld a, $7F
    ld hl, vBGMap0
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld bc, vBGMap0 + $41
    ld a, c
    ld [wWorkBuf + $E], a
    ld a, b
    ld [wWorkBuf + $F], a
    ld bc, $0080
    ld a, c
    ld [wWorkBuf + $C], a
    ld a, b
    ld [wWorkBuf + $D], a

.read_work_buf5:
    ld a, [wWorkBuf + $10]
    ld l, a
    ld a, [wWorkBuf + $11]
    ld h, a
    ld a, [hl]
    cp a, $FF
    jp z, .check_sgb_active
    ld a, [wWorkBuf + $E]
    ld l, a
    ld a, [wWorkBuf + $F]
    ld h, a
    ld a, [wWorkBuf + $C]
    ld b, a
    add a, $24
    ld [wWorkBuf + $C], a
    ld a, b
    ld b, $12
    ld c, $02
    ld de, $0020
    call FillVRAMRectWithTileSequence
    ld a, l
    and a, $E0
    add a, $01
    ld l, a
    push hl
    ld a, [wWorkBuf + $10]
    ld l, a
    ld a, [wWorkBuf + $11]
    ld h, a
    ld a, [hl+]
    cp a, $01
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    ld a, l
    ld [wWorkBuf + $10], a
    ld a, h
    ld [wWorkBuf + $11], a
    pop hl
    jr z, .read_work_buf6
    ld de, $0020
    add hl, de

.read_work_buf6:
    ld a, [wWorkBuf + $C]
    ld b, a
    add a, $12
    ld [wWorkBuf + $C], a
    ld a, b
    ld de, $0040
    ld b, $12
    ld c, $01
    call FillVRAMRectWithTileSequence
    ld a, l
    and a, $E0
    add a, $01
    ld l, a
    ld a, l
    ld [wWorkBuf + $E], a
    ld a, h
    ld [wWorkBuf + $F], a
    jr .read_work_buf5

.set_work_buf2:
    ld [wWorkBuf + $A], a
    or a, a
    jr nz, .skip3
    inc hl
    jr .set_work_buf3

.skip3:
    push hl
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    pop hl
    xor a, a
    ld [wStringCategory], a
    ld a, [hl+]
    ld [wStringIndex], a
    cp a, $FF
    jr z, .set_work_buf3
    push hl
    call ShowString_BankE0
    pop hl

.set_work_buf3:
    ld a, [hl+]
    ld [wWorkBuf + $B], a
    or a, a
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
    ld a, [hl+]
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
    or a, a
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
    ld a, $7F
    ld hl, vBGMap0
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld hl, wWorkBuf + $B
    ld a, [hl-]
    add a, a
    add a, [hl]
    ld b, a
    ld a, $12
    sub a, b
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
    ld a, [wWorkBuf + $A]
    ld c, a
    or a, a
    jr z, .skip6
    ld a, $80
    call FillVRAMRectWithTileSequence

.skip6:
    ld a, l
    and a, $E0
    ld l, a
    ld de, $0041
    add hl, de
    ld de, $0040
    ld b, $12
    ld a, [wWorkBuf + $B]
    ld c, a
    or a, a
    jr z, .check_sgb_active
    ld a, $A4
    call FillVRAMRectWithTileSequence

.check_sgb_active:
    ld hl, wWorkBuf + $1
    inc [hl]
    ld a, [wSGBActive]
    or a, a
    ld hl, $01A4
    jr z, .read_work_buf7
    ld hl, $012C

.read_work_buf7:
    ld a, [wWorkBuf + $8]
    ld e, a
    ld a, [wWorkBuf + $9]
    ld d, a
    dec de
    dec de
    dec de
    ld a, [de]
    cp a, $00
    jr z, .set_work_buf5
    cp a, $05
    jr z, .set_work_buf5
    cp a, $0F
    jr z, .set_work_buf5
    cp a, $13
    jr z, .set_work_buf5
    cp a, $14
    jr z, .set_work_buf5
    cp a, $15
    jr z, .set_work_buf5
    cp a, $16
    jr z, .set_work_buf5
    cp a, $17
    jr z, .set_work_buf5
    cp a, $18
    jr z, .set_work_buf5
    cp a, $19
    jr z, .set_work_buf5
    cp a, $1A
    jr z, .set_work_buf5
    cp a, $1B
    cp a, $20
    jr c, .set_work_buf6
    ld hl, $FFFF
    jr .set_work_buf6

.set_work_buf5:
    ld hl, $012C

.set_work_buf6:
    ld a, l
    ld [wWorkBuf + $5], a
    ld a, h
    ld [wWorkBuf + $6], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wSoundChannel2, wPartyCount
; writes: wWorkBuf, hMapId, hMapScreenX, hMapScreenY, hPlayerX, wFollowerRecords, hPlayerY, hPlayerFacing, ...
; points at: wSoundChannel3, wSoundChannel4, wModeChangeRequest
DebugStaffRoll_Update_Sub01_Table2_Case01::
Jump_0E0_72C0:: ; address name
    ld hl, wWorkBuf + $5
    ld a, [hl+]
    and a, [hl]
    cp a, $FF
    jr z, .read_sound_channel2
    ld a, [wWorkBuf + $5]
    sub a, $01
    ld [wWorkBuf + $5], a
    ld a, [wWorkBuf + $6]
    sbc a, $00
    ld [wWorkBuf + $6], a
    jr .skip

.read_sound_channel2:
    ld a, [wSoundChannel2]
    ld hl, wSoundChannel2 + $1
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $10
    call StartPaletteFade
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $B0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld a, $40
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    ld de, $019F
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
    ld a, [hl+]
    or a, [hl]
    ret nz
    ld a, $04
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wWorkBuf
; writes: wWorkBuf
; points at: wWorkBuf
DebugStaffRoll_Update_Sub01_Table2_Case02::
Jump_0E0_733E:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wWorkBuf + $4]
    dec a
    ld [wWorkBuf + $4], a
    jr z, .skip
    xor a, a
    ld [wWorkBuf + $1], a
    ret

.skip:
    ld hl, wWorkBuf + $2
    inc [hl]
    ld hl, wWorkBuf
    inc [hl]
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wSGBActive
; writes: wStringCategory, wStringIndex, rVBK, wWorkBuf
; points at: wBGPaletteBuffer
DebugStaffRoll_Update_Sub01_Table3_Case00::
Jump_0E0_735E:: ; address name
    ld hl, vTiles2 + $7F0
    ld de, $0101
    call FillTilesRequest
    ld hl, vTiles1
    ld de, $0E02
    call FillTilesRequest
    ld a, $02
    ld [wStringCategory], a
    xor a, a
    ld [wStringIndex], a
    call ShowString_BankE0
    ld a, [wIsCGB]
    or a, a
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
    ld a, $7F
    ld hl, vBGMap0
    ld bc, $1412
    call FillBGMapRectWithAWrapped
    ld a, $80
    ld hl, vBGMap0 + $E3
    ld de, $0040
    ld bc, $0E02
    call FillVRAMRectWithTileSequence
    ld a, [wSGBActive]
    or a, a
    ld hl, $0168
    jr z, .set_work_buf
    ld hl, $00F0

.set_work_buf:
    ld a, l
    ld [wWorkBuf + $5], a
    ld a, h
    ld [wWorkBuf + $6], a
    call ResetScreenPalettes_E0
    ld a, $FC
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf
; writes: wWorkBuf
DebugStaffRoll_Update_Sub01_Table3_Case01::
Jump_0E0_73DC:: ; address name
    ld a, [wWorkBuf + $5]
    sub a, $01
    ld [wWorkBuf + $5], a
    ld a, [wWorkBuf + $6]
    sbc a, $00
    ld [wWorkBuf + $6], a
    ld hl, wWorkBuf + $5
    ld a, [hl+]
    or a, [hl]
    ret nz
    ld a, $04
    call StartPaletteFade
    ld hl, wWorkBuf + $1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wWorkBuf
; points at: wWorkBuf
DebugStaffRoll_Update_Sub01_Table3_Case02::
Jump_0E0_73FC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wWorkBuf + $2
    inc [hl]
    ld hl, wWorkBuf
    inc [hl]
    xor a, a
    ld [wWorkBuf + $1], a
    ret

; A = first tile, B = width, C = rows, HL = VRAM address, DE = row stride: writes consecutive tile numbers with WriteVRAMByteInc (interrupts off per byte), adding DE to the row start after each row; A ends past the last tile (E-0077)
; 5 call sites from 2 routines (e.g. DebugStaffRoll_Update_Sub01_Table3_Case00, DebugStaffRoll_Update_Sub01_Table2_Case00)
FillVRAMRectWithTileSequence::
Func_0E0_740E:: ; address name
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

; for each of the wSpriteSlotCount 8-byte slots at wSpriteSlots: loads hSpriteSetIndex, hSpriteOriginX (+8), hSpriteOriginY, hSpriteAttrXor, hSpriteTileOffset and hSpriteSubIndex from the slot, then far-calls the routine chosen by the slot's first byte from the 3-byte entries at $7477
; 80 call sites from 80 routines (e.g. DebugStaffRoll_Scene00_DrawSpriteSlots_Case0F, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0E, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0C, ...)
; reads: wSpriteSlotCount, hSpriteAttrXor
; writes: hSpriteSetIndex, hSpriteOriginX, hSpriteOriginY, hSpriteAttrXor, hSpriteTileOffset, hSpriteSubIndex
; points at: wSpriteSlots
DrawSpriteSlots::
Func_0E0_7420:: ; address name
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    ld b, a
    ld hl, wSpriteSlots

.loop:
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ldh [hSpriteSetIndex], a
    ld a, [hl+]
    add a, $08
    ldh [hSpriteOriginX], a
    ld a, [hl+]
    ldh [hSpriteOriginY], a
    ld a, [hl+]
    ldh [hSpriteAttrXor], a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ldh [hSpriteTileOffset], a
    ld a, [hl+]
    ld e, a
    ld a, c
    cp a, $02
    ld a, b
    jr z, .set_sprite_sub_index2
    ld a, e
    and a, $20
    srl a
    swap a
    ld e, a
    ld a, b
    cp a, $03
    jr nz, .set_sprite_sub_index
    ldh a, [hSpriteAttrXor]
    or a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

.set_sprite_sub_index:
    add a, a
    add a, e

.set_sprite_sub_index2:
    ldh [hSpriteSubIndex], a
    ld b, $00
    push hl
    ld hl, $7477
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
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
    db $01, $40, $25, $01, $40, $7F, $0A, $70, $7F

; adds 1 to byte 7 of each of the 8 slots at wSpriteSlots
; 1 call site from 1 routine (e.g. DebugStaffRoll_Update_RunFieldEventFieldEventKind)
; points at: wSpriteSlots
IncrementSpriteSlotCounters::
Func_0E0_7480:: ; address name
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

; A = slot number, D = target X, E = target Y: moves the slot's X and Y bytes one step toward the target and adds 1 to its byte 7; returns A = 1 (non-zero) if either moved
; 116 call sites from 58 routines (e.g. DebugStaffRoll_Scene00_DrawSpriteSlots_Case0F, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0C, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0B, ...)
; points at: wSpriteSlots
StepSpriteSlotToward::
Func_0E0_7492:: ; address name
    ld c, $00
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, d
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
    cp a, e
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
    or a, a
    ret

; A = slot number: byte 5 of the slot = C
; 91 call sites from 45 routines (e.g. DebugStaffRoll_Scene00_DrawSpriteSlots_Case0E, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0C, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0B, ...)
; points at: wSpriteSlots
SetSpriteSlotByte5::
Func_0E0_74C5:: ; address name
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

; moves sprite slot A's position bytes toward D and E by the steps $7535/$7542 indexed by wWorkBuf + $A; NZ while still moving (E-0127)
; 1 call site from 1 routine (e.g. DebugStaffRoll_Scene00_DrawSpriteSlots_Case06)
; reads: wWorkBuf
; writes: wWorkBuf
; points at: wSpriteSlots
StepSpriteSlotTowardDE::
Func_0E0_74D8:: ; address name
    ld c, $00
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    cp a, d
    jr z, .next
    jr c, .read_work_buf
    push hl
    ld a, [wWorkBuf + $A]
    ld hl, $7535
    add_a_to_hl
    ld a, b
    sub a, [hl]
    pop hl
    ld [hl], a
    jr .skip

.read_work_buf:
    push hl
    ld a, [wWorkBuf + $A]
    ld hl, $7535
    add_a_to_hl
    ld a, b
    add a, [hl]
    pop hl
    ld [hl], a

.skip:
    ld c, $01

.next:
    inc hl
    ld a, [hl]
    cp a, e
    jr z, .done
    ld b, a
    push hl
    ld a, [wWorkBuf + $A]
    ld hl, $7542
    add_a_to_hl
    ld a, b
    sub a, [hl]
    pop hl
    ld [hl], a
    ld a, [wWorkBuf + $A]
    inc a
    ld [wWorkBuf + $A], a
    ld c, $01

.done:
    ld a, c
    or a, a
    ret
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $00, $02, $02, $02
    db $02, $01, $01, $01, $01, $01, $01, $01, $01, $00

; wWorkBuf + $5 += 1, reset to 0 when it reaches 15
; 31 call sites from 31 routines (e.g. DebugStaffRoll_Scene00_DrawSpriteSlots_Case0F, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0E, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0D, DebugStaffRoll_Scene00_DrawSpriteSlots_Case0B, ...)
; reads: wWorkBuf
; writes: wWorkBuf
StepWD0A2Mod15::
Func_0E0_754F:: ; address name
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp a, $0F
    ret c
    xor a, a
    ld [wWorkBuf + $5], a
    ret

; wWorkBuf + $5 += 1, reset to 0 when it reaches 30
; 8 call sites from 8 routines (e.g. DebugStaffRoll_Scene01_DrawSpriteSlots_Case05, DebugStaffRoll_Scene02_DrawSpriteSlots_Case16, DebugStaffRoll_Scene02_DrawSpriteSlots_Case14, DebugStaffRoll_Scene03_DrawSpriteSlots_Case08, ...)
; reads: wWorkBuf
; writes: wWorkBuf
StepWD0A2Mod30::
Func_0E0_755E:: ; address name
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp a, $1E
    ret c
    xor a, a
    ld [wWorkBuf + $5], a
    ret

; wWorkBuf + $5 += 1, reset to 0 when it reaches 45
; 1 call site from 1 routine (e.g. DebugStaffRoll_Scene03_DrawSpriteSlots_Case03)
; reads: wWorkBuf
; writes: wWorkBuf
StepWD0A2Mod45::
Func_0E0_756D:: ; address name
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp a, $2D
    ret c
    xor a, a
    ld [wWorkBuf + $5], a
    ret

; wWorkBuf + $5 += 1, reset to 0 when it reaches 60
; 6 call sites from 6 routines (e.g. DebugStaffRoll_Scene02_DrawSpriteSlots_Case13, DebugStaffRoll_Scene02_DrawSpriteSlots_Case12, DebugStaffRoll_Scene04_DrawSpriteSlots_Case0B, DebugStaffRoll_Scene04_DrawSpriteSlots_Case06, ...)
; reads: wWorkBuf
; writes: wWorkBuf
StepWD0A2Mod60::
Func_0E0_757C:: ; address name
    ld a, [wWorkBuf + $5]
    inc a
    ld [wWorkBuf + $5], a
    cp a, $3C
    ret c
    xor a, a
    ld [wWorkBuf + $5], a
    ret

; writes A over a B x C rectangle of the BG map at HL, wrapping columns and rows (E-0125)
; 6 call sites from 2 routines (e.g. DebugStaffRoll_Update_Sub01_Table3_Case00, DebugStaffRoll_Update_Sub01_Table2_Case00)
FillBGMapRectWithAWrapped::
Func_0E0_758B:: ; address name
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
    and a, $1F
    ld l, a
    pop af
    and a, $E0
    or a, l
    ld l, a
    pop af
    dec b
    jr nz, .loop
    pop hl
    push af
    ld a, h
    and a, $9C
    ld c, a
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, c
    ld h, a
    pop af
    pop bc
    dec c
    jr nz, FillBGMapRectWithAWrapped
    ret

; sets the DMG palettes $D2/$D2/$E2 (also in wDMGPaletteBytes) and resets the fade; on the Super Game Boy blanks rBGP/rOBP, sends PAL_SET for wSGBPaletteSet and copies 8 bytes from $7641 to wOBJPaletteBuffer + $20 (E-0128)
; 7 call sites from 7 routines (e.g. DebugStaffRoll_Update_Sub01_Table3_Case00, DebugStaffRoll_Update_Sub01_Table2_Case00, DebugStaffRoll_Scene00_DecompressToVRAM, DebugStaffRoll_Scene01_DecompressToVRAM, ...)
; reads: wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1, wSGBActive, wSGBPaletteSet, wSGBAttrFile
; writes: rBGP, rOBP0, rOBP1, wSGBPaletteNum0Lo, wSGBPaletteNum0Hi, wSGBPaletteNum1Lo, wSGBPaletteNum1Hi, wSGBPaletteNum2Lo, ...
; points at: wDMGPaletteBGP, wDMGPaletteBytes
ResetScreenPalettes_E0::
Func_0E0_75BF:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    call ResetFadeFromDMGPaletteBGP
    ld a, [wSGBActive]
    or a, a
    jr z, .return
    xor a, a
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
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $FF
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

; E-0213 (C1: the routine before ResetScreenPalettes_E0.return copies these 8 bytes to wOBJPaletteBuffer + $20 with CopyBytes).
; record: one CGB palette: 4 BGR555 colours
Palette_E0_7641::
Data_0E0_7641:: ; address name
    dw $67DE, $331F, $123C, $0000 ; entry 0

; E-0213 (C1: DebugStaffRoll_Update_Sub01_Table2_Case00 reads word wWorkBuf + 2 - 1 of $7649 (ReadWordTableEntry_Bank00), stores the first byte in wWorkBuf + 4 and walks the rest as count/value pairs ($FE starts a section, $FF ends one); the five lists run to $76E0; the pair meaning is not read).
; record: sequence for wWorkBuf + 2 = id
WorkBufSequenceTable::
Data_0E0_7649:: ; address name
    dw WorkBufSequence001 ; id 1
    dw WorkBufSequence002 ; id 2
    dw WorkBufSequence003 ; id 3
    dw WorkBufSequence004 ; id 4
    dw WorkBufSequence005 ; id 5

; E-0199 (derived: list for entry $01 of WorkBufSequenceTable; it runs to the next list)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence001::
Data_0E0_7653:: ; address name
    db $05, $02, $00, $01, $00, $02, $01, $04, $01, $02, $02, $01, $02, $01, $03, $01, $03, $02, $04, $03, $04 ; id 0

; E-0199 (derived: list for entry $02 of WorkBufSequenceTable; it runs to the next list)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence002::
Data_0E0_7668:: ; address name
    db $04, $01, $05, $00, $05, $FE, $02, $06, $01, $06, $01, $07, $01, $07, $02, $08, $01, $08, $FF, $01, $09, $03, $09, $01, $0A, $06, $0A ; id 0

; E-0199 (derived: list for entry $03 of WorkBufSequenceTable; it runs to the next list)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence003::
Data_0E0_7683:: ; address name
    db $03, $FE, $02, $0B, $01, $0B, $02, $0C, $01, $0C, $01, $0D, $01, $0D, $FF, $01, $0E, $01, $0E, $01, $0F, $00, $0F ; id 0

; E-0199 (derived: list for entry $04 of WorkBufSequenceTable; it runs to the next list)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence004::
Data_0E0_769A:: ; address name
    db $0B, $01, $10, $02, $10, $01, $11, $04, $11, $01, $12, $02, $12, $01, $13, $05, $13, $01, $14, $05, $14, $01, $15, $05, $15, $01, $16, $05, $16, $01, $17, $05, $17, $01, $18, $05, $18, $01, $19, $05, $19, $01, $1A, $05, $1A ; id 0

; E-0199 (derived: list for entry $05 of WorkBufSequenceTable; it runs to the next list)
; record: first byte to wWorkBuf + 4, then count/value pairs; $FE and $FF are markers
WorkBufSequence005::
Data_0E0_76C7:: ; address name
    db $06, $02, $1B, $02, $1B, $01, $1C, $01, $1C, $02, $1D, $02, $1D, $01, $1E, $01, $1E, $00, $1F, $06, $1F, $01, $20, $00, $20 ; id 0

; if wStringCategory < 1, BeginStringDisplay with DE = $76FC; otherwise far-calls Func_0A2_49E2
; 1 call site from 1 routine (e.g. ShowString_BankE0)
; reads: wStringCategory
BeginStringDisplay_BankE0::
Func_0E0_76E0:: ; address name
    ld a, [wStringCategory]
    cp a, $01
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_BankE0_BeginStringDisplay
    ret

.call_begin_string_display:
    ld de, $76FC
    call BeginStringDisplay
    ret

; Func_0E0_76E0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 5 call sites from 2 routines (e.g. DebugStaffRoll_Update_Sub01_Table3_Case00, DebugStaffRoll_Update_Sub01_Table2_Case00)
ShowString_BankE0::
Func_0E0_76F5:: ; address name
    call BeginStringDisplay_BankE0
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_E0_76FC::
Data_0E0_76FC:: ; address name
    dw StringList_E0_76FE ; id 0

; E-0217 (derived: category list of StringCategories_E0_76FC; one pointer per wStringIndex)
; record: string
StringList_E0_76FE::
Data_0E0_76FE:: ; address name
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

String_E0_00_00:: ; heuristic: string; C0
Data_0E0_7740:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EXECUTIVE DIRECTOR", $F0

String_E0_00_01:: ; heuristic: string; C0
Data_0E0_7753:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SCENARIO ", $B6, " GAME", $F1
    db "         DESIGNERS", $F0

String_E0_00_02:: ; heuristic: string; C0
Data_0E0_7776:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CHARACTER ", $B6, $F1
    db "  MONSTER DESIGNER", $F0

String_E0_00_03:: ; heuristic: string; C0
Data_0E0_7795:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MUSIC COMPOSER", $F0

String_E0_00_04:: ; heuristic: string; C0
Data_0E0_77A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LOCALIZATION", $F1
    db "       SPECIALISTS", $F0

String_E0_00_05:: ; heuristic: string; C0
Data_0E0_77C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ENIX AMERICA INC.", $F0

String_E0_00_06:: ; heuristic: string; C0
Data_0E0_77D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LOCALIZATION", $F1
    db "           MANAGER", $F0

String_E0_00_07:: ; heuristic: string; C0
Data_0E0_77F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  PRODUCT MANAGER", $F0

String_E0_00_08:: ; heuristic: string; C0
Data_0E0_780B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ASSISTANT", $F1
    db "   PRODUCT MANAGER", $F0

String_E0_00_09:: ; heuristic: string; C0
Data_0E0_7828:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   QA TRANSLATOR", $F0

String_E0_00_0A:: ; heuristic: string; C0
Data_0E0_7839:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_0B:: ; heuristic: string; C0
Data_0E0_7849:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SALES", $9E, "MARKETING", $F1
    db "MANAGER", $F0

String_E0_00_0C:: ; heuristic: string; C0
Data_0E0_7861:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ACCOUNTING", $9E, "CREDIT", $F1
    db "MANAGER", $F0

String_E0_00_0D:: ; heuristic: string; C0
Data_0E0_787B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    A", $9E, "R ANALYST", $F0

String_E0_00_0E:: ; heuristic: string; C0
Data_0E0_788B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     PRESIDENT", $F0

String_E0_00_0F:: ; heuristic: string; C0
Data_0E0_789A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ENIX CORPORATION", $F0

String_E0_00_10:: ; heuristic: string; C0
Data_0E0_78AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "      ARTWORK", $F0

String_E0_00_11:: ; heuristic: string; C0
Data_0E0_78BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " TECHNICAL SUPPORT", $F0

String_E0_00_12:: ; heuristic: string; C0
Data_0E0_78CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " TECHNICAL SUPPORT", $F0

String_E0_00_13:: ; heuristic: string; C0
Data_0E0_78E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_14:: ; heuristic: string; C0
Data_0E0_78F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_15:: ; heuristic: string; C0
Data_0E0_7900:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_16:: ; heuristic: string; C0
Data_0E0_7910:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_17:: ; heuristic: string; C0
Data_0E0_7920:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_18:: ; heuristic: string; C0
Data_0E0_7930:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_19:: ; heuristic: string; C0
Data_0E0_7940:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_1A:: ; heuristic: string; C0
Data_0E0_7950:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   PLAY TESTERS", $F0

String_E0_00_1B:: ; heuristic: string; C0
Data_0E0_7960:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    ASSISTANT", $F1
    db "      PRODUCERS", $F0

String_E0_00_1C:: ; heuristic: string; C0
Data_0E0_797E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     PRODUCER", $F0

String_E0_00_1D:: ; heuristic: string; C0
Data_0E0_798C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    EXECUTIVE", $F1
    db "      PRODUCERS", $F0

String_E0_00_1E:: ; heuristic: string; C0
Data_0E0_79AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     PRESIDENT", $F0

String_E0_00_1F:: ; heuristic: string; C0
Data_0E0_79B9:: ; address name
    db $F0

String_E0_00_20:: ; heuristic: string; C0
Data_0E0_79BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    ", $B8, "2001 ENIX", $F0

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (the bank-$E0 copy of the battle library, after a string; E-0213)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankE0:: ; configured code entry (E-0213); C0
Func_0E0_79C9:: ; address name
    ld hl, wBattleATK
    jr GetBattleMP_BankE0_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleDEF
GetBattleDEF_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4006; C0
Func_0E0_79CE:: ; address name
    ld hl, wBattleDEF
    jr GetBattleMP_BankE0_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxHP
GetBattleMaxHP_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:400B; C0
Func_0E0_79D3:: ; address name
    ld hl, wBattleMaxHP
    jr GetBattleMP_BankE0_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxMP
GetBattleMaxMP_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4010; C0
Func_0E0_79D8:: ; address name
    ld hl, wBattleMaxMP
    jr GetBattleMP_BankE0_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4015; C0
Func_0E0_79DD:: ; address name
    ld hl, wBattleHP
    jr GetBattleMP_BankE0_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:401A; C0
Func_0E0_79E2:: ; address name
    ld hl, wBattleMP
    jr GetBattleMP_BankE0_Skip
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

GetBattleMP_BankE0_Skip::
Jump_0E0_79F6:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7A00:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7A07:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7A22:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp a, $04
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_0E0_7A3D:: ; address name
    ld a, d
    ld hl, $7A52
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4091; C0
Func_0E0_7A59:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_BankE0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:409E; C0
Func_0E0_7A66:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7A73:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) + g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; 2 call sites from 2 routines (e.g. RunDebugState_E0_ChooseActionTargets_Case02_DisplayedSlotOfActor, RunDebugState_E0_ChooseActionTargets_PersonalityIndexOfSlot_BankE0)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankE0::
Func_0E0_7A80:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip
    ld l, $09
    cp a, $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip2
    ld l, $03
    cp a, $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip3
    ld l, $01
    cp a, $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7AD7:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .set_carry
    ld a, [hl]
    and a, $0C
    jr nz, .set_carry
    xor a, a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7AF6:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .done
    ld a, [hl]
    and a, $0C

.done:
    pop hl
    ret
    ds $4F9, $00
