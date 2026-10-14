; ROM bank $31: battle phases, the end of a battle, slot drawing
; The annotated listing of this bank is build/listing/bank31.asm.

SECTION "Bank 31", ROMX[$4000], BANK[$31]
    db $31

; start-up for wGameMode = 4, the battle: starts music 2, clears the BG map and builds the battle
; screen; reached from the debug battle setup (Start) and from encounters (E-0042)
GameMode4_Init::
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a
    jr z, .clear_scroll_x
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

.clear_scroll_x:
    xor a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $c3
    call FillBytes
    ld a, [wIsCGB]
    or a
    jr z, .set_text_cursor_lo
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a
    call FillBytes
    xor a
    ldh [rVBK], a

.set_text_cursor_lo:
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    farcall GameMode4_Init_FillBytes
    ld b, $31
    ld de, Tiles1Plus240Gfx
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx
    ld hl, vTiles1 + $5f0
    call DecompressToRAMLocked
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $fc
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0b
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 4, the battle: in link mode (wLinkMode) it serves the serial
; link, otherwise IncrementPlayTime_Bank31 and the phase machine RunBattlePhase (wBattlePhase =
; phase (1 fight, 2 after), wBattleStep = step)
GameMode4_Update::
    ld a, [wLinkMode]
    or a
    jr z, .call_increment_play_time_bank31
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp $ff
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

.call_increment_play_time_bank31:
    call IncrementPlayTime_Bank31

; runs BattlePhase0, BattlePhaseFight or BattlePhaseEnd for wBattlePhase (E-0122)
RunBattlePhase::
    ld a, [wBattlePhase]
    jumptable
    dw BattlePhase0
    dw BattlePhaseFight
    dw BattlePhaseEnd

; wBattlePhase = 0: the start of the battle (E-0044)
BattlePhase0::
    ld a, [wBattleStep]
    jumptable
    dw BattlePhase0_Step0
    dw BattlePhase0_Step1
    dw BattlePhase0_Step2
    dw BattlePhase0_Step3
    dw BattlePhase0_Step4

; wBattlePhase 0, wBattleStep 0 (E-0044)
BattlePhase0_Step0::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 0, wBattleStep 1 (E-0044)
BattlePhase0_Step1::
    call ClearWindowAndCopyRectFar
    call DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleArg0], a
    ld a, [wLinkMode]
    and a
    ret z
    xor a
    ld [wArg1], a
    ret

; wBattlePhase 0, wBattleStep 2 (E-0044)
BattlePhase0_Step2::
    ld a, [wLinkMode]
    or a
    jp z, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_ReadBattlePictureIds
    ld a, [wArg1]
    jumptable
    dw BattlePhase0_Step2_SetArg1
    dw BattlePhase0_Step2_WaitLinkMessage
    dw BattlePhase0_Step2_WriteArg1AndLinkTimeoutLoEtc
    dw BattlePhase0_Step2_CopyFiveGlyphsPlusMarks

BattlePhase0_Step2_SetArg1::
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld a, $d2
    ld [wLinkSendByte], a
    ret

BattlePhase0_Step2_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $d2
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ret

BattlePhase0_Step2_WriteArg1AndLinkTimeoutLoEtc::
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld hl, wPlayerName
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $000a
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wBattleTextWork
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    xor a
    ld [wArg1], a
    ld a, $f0
    ld [wBattleTextWork2], a
    ld de, wBattleTextWork
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    jp BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_ReadBattlePictureIds::
    ld a, [wBattlePictureIds]
    ld l, a
    ld a, [wBattlePictureIds + $1]
    ld h, a
    ld de, wTextBuf0
    call CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $2]
    ld l, a
    ld a, [wBattlePictureIds + $3]
    ld h, a
    ld de, wTextBuf1
    ld a, [wBattleFoeCount]
    cp $01
    call nz, CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    ld h, a
    ld de, wTextBuf2
    ld a, [wBattleFoeCount]
    cp $03
    call z, CopyMonsterNameToDE_Bank31
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .skip
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattlePictureIds + $2]
    cp e
    jr nz, .check_battle_foe_count
    ld a, [wBattlePictureIds + $3]
    cp d
    jr nz, .check_battle_foe_count
    ld a, [wBattleFoeCount]
    cp $02
    jr z, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip
    ld a, [wBattlePictureIds + $4]
    cp e
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip2
    ld a, [wBattlePictureIds + $5]
    cp d
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip2
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip

.check_battle_foe_count:
    ld a, [wBattleFoeCount]
    cp $02
    jr z, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip3
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld a, [wBattlePictureIds + $4]
    cp e
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip4
    ld a, [wBattlePictureIds + $5]
    cp d
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip4
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip5

.skip:
    ld a, $00
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip::
    ld hl, wTextBuf0
    ld a, $01
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip2::
    ld a, $02
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip3::
    ld a, $03
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip4::
    ld a, $04
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip5::
    ld a, $05

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex::
    ld [wStringIndex], a ; 'Monsters appear!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; HL = monster id: H += 2 (string categories 2 and 3 hold the monster names), then CopyStringHLToDE
; (E-0115)
CopyMonsterNameToDE_Bank31::
    ld a, h
    add $02
    ld h, a
    call CopyStringHLToDE
    ret

; wBattlePhase 0, wBattleStep 3 (E-0044)
BattlePhase0_Step3::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a
    jp nz, .set_battle_turn_to_01
    ld a, [wBattleKind]
    cp $02
    jp nc, .set_battle_turn_to_01
    call NextTableByte
    ld a, [wRandomLo]
    cp $08
    jr nc, .call_next_table_byte
    ld a, [wRandomHi]
    and $01
    add $0b
    ld [wStringIndex], a
    ld a, $00
    ld [wBattleArg0], a
    ld c, $04
    jr .skip

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    cp $08
    jr nc, .set_battle_turn_to_01
    ld a, [wRandomLo]
    and $01
    add $0d
    ld [wStringIndex], a
    ld a, $01
    ld [wBattleArg0], a
    ld c, $00

.skip:
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .skip2
    ld [hl], $03
    jr .next

.skip2:
    ld [hl], $ff

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, $00
    ld [wStringCategory], a
    call BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattlePhase
    dec [hl]
    ld a, $04
    ld [wBattleStep], a
    jr .return

.set_battle_turn_to_01:
    ld a, $01
    ld [wBattleTurn], a

.return:
    ret

BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc::
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .call_battle_phase0_step3_copy_string_hl_to_de
    ld a, [wBattlePictureIds + $2]
    cp e
    jr nz, .skip2
    ld a, [wBattlePictureIds + $3]
    cp d
    jr nz, .skip2
    ld a, [wBattleFoeCount]
    cp $02
    jr z, .skip
    ld a, [wBattlePictureIds + $4]
    cp e
    jr nz, .skip2
    ld a, [wBattlePictureIds + $5]
    cp d
    jr nz, .skip2
    jr .skip

.call_battle_phase0_step3_copy_string_hl_to_de:
    call BattlePhase0_Step3_CopyStringHLToDE
    jr .return

.skip:
    ld hl, wTextBuf0
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $f0
    jr .return

.skip2:
    ld hl, wTextBuf0
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data1
    ld b, $09
    ld a, [wStringIndex]
    cp $0b
    jr nz, .cp_0C
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data2
    ld b, $09
    jr .loop

.cp_0C:
    cp $0c
    jr nz, .cp_0D
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data2
    ld b, $0d
    jr .loop

.cp_0D:
    cp $0d
    jr nz, .cp_0E
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data2
    ld b, $0d
    jr .loop

.cp_0E:
    cp $0e
    jr nz, .loop
    ld b, $09
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data2

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop

.return:
    ret

BattlePhase0_Step3_CopyStringHLToDE::
    ld a, [wStringCategory]
    ld l, a
    ld a, [wStringIndex]
    ld h, a
    push hl
    ld l, e
    ld a, d
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld hl, wTextBuf0

.skip:
    ld a, [hl]
    cp $f0
    jr z, .set_string_category
    inc hl
    jr .skip

.set_string_category:
    pop de
    ld a, e
    ld [wStringCategory], a
    ld a, d
    ld [wStringIndex], a
    ret

BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data1::
    db $30, $32, $31, $36, $37, $28, $35, $36, $f0

BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data2::
    db $16, $32, $31, $36, $37, $28, $35, $36, $f0

; wBattlePhase 0, wBattleStep 4 (E-0044)
BattlePhase0_Step4::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    ld a, [wBattleArg0]
    or a
    ret

; wBattlePhase = 1: the fight; steps: 1 set-up, 2 command entry, 3 executing the actions (E-0044)
BattlePhaseFight::
    ld a, [wBattleStep]
    jumptable
    dw BattleFight_Step0
    dw BattleFight_Step1
    dw BattleFight_Step2
    dw BattleFight_Step3
    dw BattleFight_Step4

; wBattlePhase 1, wBattleStep 0 (E-0044)
BattleFight_Step0::
    ld a, [wTextFlags]
    or a
    ret nz
    call BattleFight_Step0_FillBytes
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 1, wBattleStep 1 (E-0044)
BattleFight_Step1::
    call RunBattleSetup
    ret

; wBattlePhase 1, wBattleStep 2 (E-0044)
BattleFight_Step2::
    farcall RunBattleCommandEntry
    ret

; wBattlePhase 1, wBattleStep 3 (E-0044)
BattleFight_Step3::
    farcall RunBattleActions
    ret

; wBattlePhase 1, wBattleStep 4 (E-0044)
BattleFight_Step4::
    farcall RunBattleStep4
    ret

; wBattlePhase = 2: after the fight; steps 0-9 (result message, rewards, recruiting) (E-0044)
BattlePhaseEnd::
    ld a, [wBattleStep]
    jumptable
    dw BattleEnd_Step0
    dw BattleEnd_Step1
    dw BattleEnd_Step2
    dw BattleEnd_Step3
    dw BattleEnd_Step4
    dw BattleEnd_Step5
    dw BattleEnd_Step6
    dw BattleEnd_Step7
    dw BattleEnd_Step7
    dw BattleEnd_Step9

; wBattlePhase 2, wBattleStep 0 (E-0044)
BattleEnd_Step0::
    ld a, $02
    call QueueMusic
    call ClearWindowAndCopyRectFar
    call DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 1 (E-0044)
BattleEnd_Step1::
    ld a, $01
    ld [wTextSpeed], a
    call BattleEnd_Step1_CountSlots_BattleEnd_Step1_AddAx9ToHL
    ld a, [wBattleScene]
    and $01
    jr z, .call_battle_end_step1_write_battle_arg0
    ld a, $06
    jr .set_string_index

.call_battle_end_step1_write_battle_arg0:
    call BattleEnd_Step1_WriteBattleArg0
    ld a, [wBattleScene]
    cp $02
    jr z, .read_battle_arg0
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_arg0
    ld a, $87
    jr .set_string_index

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp $01
    ld a, $07
    jr nc, .set_string_index
    ld a, $86
    jr .set_string_index

.read_battle_arg0:
    ld a, [wBattleArg0]
    add $08

.set_string_index:
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 2 (E-0044)
BattleEnd_Step2::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    call z, BattleEnd_Step2_WriteBattleEndTimer
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

BattleEnd_Step2_WriteBattleEndTimer::
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 3 (E-0044)
BattleEnd_Step3::
    call BattleEnd_Step3_SubtractBattleMP_2
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a
    jr nz, .skip2
    ld a, [wBattleScene]
    or a
    jr z, .check_display_slot
    cp $03
    jr z, .skip
    cp $02
    jr z, .skip

.skip:
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

.skip2:
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

.check_display_slot:
    ld a, [wDisplaySlot]
    cp $ff
    ret z
    sub $04
    ret c
    cp $03
    ret nc
    ld a, [wLinkMode]
    or a
    call z, BattleEnd_Step3_WriteBattleExpAward
    call BattleEnd_Step3_WaitBattleKind
    ld a, [wDisplaySlot]
    dec a
    ld c, $4e
    call Multiply8
    ld a, l
    add $d5
    ld e, a
    ld a, h
    adc $d0
    ld d, a
    ld hl, wRecordBufA
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $0e
    call CopyBBytesDEToHL_Bank31
    push de
    ld de, wPlayerName
    ld b, $0b
    call CopyBBytesDEToHL_Bank31
    pop de
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call BattleEnd_Step3_WriteUnknownName
    ld a, $ff
    ld [hli], a
    call BattleEnd_Step3_WriteUnknownName
    ld a, $ff
    ld [hli], a
    ld b, $08
    call BattleEnd_Step3_CopySkillsSkippingC8
    ld a, $ff
    ld b, $19

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld [hli], a
    ld b, $15
    call CopyBBytesDEToHL_Bank31
    xor a
    ld [hli], a
    ld [hli], a
    ld b, $1f
    call CopyBBytesDEToHL_Bank31
    call BattleEnd_Step3_WriteUnknownName
    ld a, $00
    ld [hli], a
    call BattleEnd_Step3_WriteUnknownName
    ld a, $00
    ld [hli], a
    ld a, [de]
    ld [hli], a
    farcall BattleEnd_Step3_LoadSpeciesRecord
    farcall BattleEnd_Step3_NextTableByte
    farcall LoadTableEntryForRecordBufASpeciesToRecordBufAExp
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
CopyBBytesDEToHL_Bank31::
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank31
    ret

; fills 8 bytes at HL with $FF, then copies B bytes from DE, skipping $C8
BattleEnd_Step3_CopySkillsSkippingC8::
    push hl
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    push hl

.loop:
    ld a, [de]
    inc de
    cp $c8
    jr z, .next
    ld [hli], a

.next:
    dec b
    jr nz, .loop
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; writes three $98 placeholder glyphs and seven $F0 bytes at HL
BattleEnd_Step3_WriteUnknownName::
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld b, $06

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ret

BattleEnd_Step3_WriteBattleExpAward::
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    xor a
    ld [wBattleExpAward], a
    ld [wBattleExpAward + $1], a
    ld [wBattleExpAward + $2], a

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp $01
    jr nz, .next
    ld a, c
    and $03
    ld hl, BattleEnd_Step3_WriteBattleExpAward_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, [wBattleExpAward]
    add [hl]
    ld [wBattleExpAward], a
    inc hl
    ld a, [wBattleExpAward + $1]
    adc [hl]
    ld [wBattleExpAward + $1], a
    inc hl
    ld a, [wBattleExpAward + $2]
    adc [hl]
    ld [wBattleExpAward + $2], a

.next:
    inc c
    dec b
    jr nz, .loop
    ret

BattleEnd_Step3_WriteBattleExpAward_Data::
    db $d7, $d1, $25, $d2, $73, $d2

BattleEnd_Step3_WaitBattleKind::
    ld a, [wBattleKind]
    cp $02
    ret nz
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .set_temp0
    cp $02
    jr z, .set_temp0
    ld hl, wEncounterMonsters + $2
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, $05
    ld [wDisplaySlot], a
    ld a, [wEncounterMonsters + $2]
    ld l, a
    ld a, [wEncounterMonsters + $3]
    ld h, a
    jr .skip

.set_temp0:
    ld hl, wEncounterMonsters
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wEncounterMonsters]
    ld l, a
    ld a, [wEncounterMonsters + $1]
    ld h, a
    ld a, $04
    ld [wDisplaySlot], a

.skip:
    ld a, h
    or a
    jr nz, .cp_01
    ld a, l
    cp $07
    jr z, .call_battle_end_step3_load_monster_and
    cp $1a
    jr z, .call_battle_end_step3_load_monster_and2
    jr .return

.call_battle_end_step3_load_monster_and:
    ld hl, $0008
    call BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC_2
    jr .return

.call_battle_end_step3_load_monster_and2:
    ld hl, $001b
    call BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC_2
    jr .return

.cp_01:
    cp $01
    jr nz, .return
    ld a, l
    cp $82
    jr z, .call_battle_end_step3_load_monster_and3
    cp $ab
    jr z, .set_screen_saved_flag_to_02
    cp $90
    jr z, .call_battle_end_step3_load_monster_and4
    jr .return

.call_battle_end_step3_load_monster_and3:
    ld hl, $0183
    call BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC_2
    jr .return

.set_screen_saved_flag_to_02:
    ld a, $02
    ld [wScreenSavedFlag], a
    ld hl, $01ac
    call BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC_2
    jr .return

.call_battle_end_step3_load_monster_and4:
    ld hl, $01af
    call BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC_2
    jr .return

.return:
    ret

BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC_2::
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    farcall BattleEnd_Step3_LoadMonsterAndSpeciesForListEntryC
    ret

; wBattlePhase 2, wBattleStep 4 (E-0044)
BattleEnd_Step4::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    call z, BattleEnd_Step4_WriteBattleEndTimer
    call BattleEnd_GainExperience
    ret

BattleEnd_Step4_WriteBattleEndTimer::
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 5 (E-0044)
BattleEnd_Step5::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc
    dw BattleEnd_Step5_DrawThenAskToJoin
    dw BattleEnd_Step5_SwapMonstersMenu
    dw BattleEnd_Step5_BuildAndDrawBattleScreen
    dw BattleEnd_Step5_BattleEnd_AddJoinedMonster

BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc::
    farcall BattleEnd_Step5_WriteBattleFoeCountAndSpeciesIdLoEtc
    ld a, [wDisplaySlot]
    cp $ff
    jr nz, .read_species_id_lo
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

.read_species_id_lo:
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    ld [wBattlePictureIds], a
    ld a, h
    ld [wBattlePictureIds + $1], a
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call ClearWindowAndCopyRectFar
    ld a, $6c
    call QueueSoundEffect
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; copies a rectangle to VRAM, then BattleEnd_AskToJoin
BattleEnd_Step5_DrawThenAskToJoin::
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_Step5_DrawThenAskToJoin_CopyRect32StrideToVRAM
    dw BattleEnd_Step5_DrawThenAskToJoin_ToBattleEnd_AskToJoin

BattleEnd_Step5_DrawThenAskToJoin_CopyRect32StrideToVRAM::
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    lb bc, $14, $12
    call CopyRect32StrideToVRAM
    call LoadBattleMonsterPictureAndTitle
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    ld de, wScreenTileBuffer + $e7
    ld hl, vBGMap0 + $e7
    lb bc, $06, $06
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

BattleEnd_Step5_DrawThenAskToJoin_ToBattleEnd_AskToJoin::
    farcall BattleEnd_AskToJoin
    ret

BattleEnd_Step5_SwapMonstersMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    ld [wSpriteSlotCount], a
    call BuildBattleScreenBuffer
    ld b, $31
    ld de, Tiles1Plus240Gfx
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Tiles1Plus5F0Gfx
    ld hl, vTiles1 + $5f0
    call DecompressToVRAM
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

BattleEnd_Step5_BuildAndDrawBattleScreen::
    ld a, [wBattleSubStep]
    cp $03
    call z, BuildAndDrawBattleScreen
    farcall RunBattleEndStep5SubSteps
    ld a, [wBattleScreenFlags]
    or a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; BuildBattleScreenBuffer, then copies the 20 x 18 wScreenTileBuffer to vBGMap0
; (CopyRect32StrideToVRAM) (E-0115)
BuildAndDrawBattleScreen::
    call BuildBattleScreenBuffer
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $12
    call CopyRect32StrideToVRAM
    ret

BattleEnd_Step5_BattleEnd_AddJoinedMonster::
    farcall BattleEnd_AddJoinedMonster
    ld a, [wBattleScreenFlags]
    or a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; runs LoadBattleMonsterPictureAndTitle, ClearAttributesAndScreenBuffer_Bank31,
; CopyRectRecordForBattlePartyCount_Bank31, DrawPartySlotStatusPanels,
; LayoutTileBlocksForBattleFoeCount, LoadBattleMonsterPictureAttributes and
; ClearWindowAndCopyRectFar in turn (E-0115)
BuildBattleScreenBuffer::
    call LoadBattleMonsterPictureAndTitle
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    call ClearWindowAndCopyRectFar
    ret

; loads the picture of battle monster wDisplaySlot at vTiles2 + $140, uploads palettes, loads name
; tiles and shows string 5 of category 2 (bank 09) at vTiles1 + $6D0, then restores the default
; window (E-0121)
LoadBattleMonsterPictureAndTitle::
    xor a
    ld [wBattleScreenFlags], a
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, vTiles2 + $140
    ld c, $01
    call LoadMonsterPicture
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    call LoadRecordListNameTiles
    ld hl, vTiles1 + $6d0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a ; 'InfoOKMonsterEgg'
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

; wBattlePhase 2, wBattleStep 6 (E-0044)
BattleEnd_Step6::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_Step6_QueueMusic
    dw BattleEnd_Step6_WaitFadeState
    dw BattleEnd_Step6_QueueMusic_2

BattleEnd_Step6_QueueMusic::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wCurrentMusic]
    ld hl, wTransitionMusic
    cp [hl]
    jr z, .clear_sprite_window_clip_mode
    ld a, $02
    call QueueMusic

.clear_sprite_window_clip_mode:
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, $04
    call StartPaletteFade
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_Step6_WaitFadeState::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_Step6_QueueMusic_2::
    ld a, [wCurrentMusic]
    ld hl, wTransitionMusic
    cp [hl]
    jr z, .check_battle_kind
    ld a, [hl]
    call QueueMusic

.check_battle_kind:
    ld a, [wBattleKind]
    cp $02
    jr c, .set_game_mode_to_01
    cp $04
    jr nc, .set_game_mode_to_01
    call SetFollowersToPlayer

.set_game_mode_to_01:
    ld a, $01
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wNewRecordFamily], a
    ld [wScreenState], a
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ExitPauseMenuToField
    ld a, $02
    ld [wFieldInitStage], a
    ld hl, wBGFillFlag
    inc [hl]
    ret

; copies hPlayerFacing to the three follower directions and hPlayerX/hPlayerY to the three follower
; positions (the facing-preserving form of ResetFollowersToPlayer) (E-0118)
SetFollowersToPlayer::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ret

; wBattlePhase 2, wBattleStep 7 (E-0044)
BattleEnd_Step7::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_Step7_WriteLinkSendByte
    dw BattleEnd_Step7_WaitLinkMessage
    dw BattleEnd_Step7_StartPaletteFade

BattleEnd_Step7_WriteLinkSendByte::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    ret nz
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_Step7_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_Step7_StartPaletteFade::
    ld a, $04
    call StartPaletteFade
    farcall StoreBattleStateToPartyRecords_BankA3
    ld a, $06
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a
    ld [wLinkMode], a
    xor a
    ld [wLinkMessage], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkScreenStep], a
    ret

; wBattlePhase 2, wBattleStep 9 (E-0044)
BattleEnd_Step9::
    ld a, [wBattleScene]
    cp $04
    jr z, .call_queue_sound_effect
    ld a, $42
    call QueueMusic
    jr .set_battle_step_to_07

.call_queue_sound_effect:
    ld a, $7e
    call QueueSoundEffect

.set_battle_step_to_07:
    ld a, $07
    ld [wBattleStep], a
    ret

BattleEnd_Step1_WriteBattleArg0::
    ld a, [wLinkMode]
    or a
    jr nz, BattleEnd_Step1_CopyStringHLToDE_Skip
    xor a
    ld [wBattleArg0], a
    ld hl, wBattlePictureIds
    ld a, [hli]
    ld d, [hl]
    ld e, a
    inc hl
    ld a, [wBattleFoeCount]
    cp $01
    jr z, BattleEnd_Step1_CopyStringHLToDE
    ld a, $01
    ld [wBattleArg0], a
    ld a, [hli]
    cp e
    jr nz, BattleEnd_Step1_CopyStringHLToDE_Skip2
    ld a, [hli]
    cp d
    jr nz, BattleEnd_Step1_CopyStringHLToDE_Skip2
    ld a, [wBattleFoeCount]
    cp $02
    jr z, .call_battle_end_step1_copy_string_hl_to_de
    ld a, [hli]
    cp e
    jr nz, BattleEnd_Step1_CopyStringHLToDE_Skip2
    ld a, [hl]
    cp d
    jr nz, BattleEnd_Step1_CopyStringHLToDE_Skip2

.call_battle_end_step1_copy_string_hl_to_de:
    call BattleEnd_Step1_CopyStringHLToDE
    ld hl, wTextBuf0

.loop:
    ld a, [hli]
    cp $f0
    jr nz, .loop
    dec hl
    ld a, $33
    ld [hli], a
    ld a, $34
    ld [hli], a
    ld [hl], $f0
    jr BattleEnd_Step1_CopyStringHLToDE_Return

BattleEnd_Step1_CopyStringHLToDE::
    ld l, e
    ld a, d
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    jr BattleEnd_Step1_CopyStringHLToDE_Return

BattleEnd_Step1_CopyStringHLToDE_Skip::
    ld de, wBattleTextWork
    ld hl, wTextBuf0
    ld b, $0a

.loop:
    ld a, [de]
    cp $f0
    jr z, .set_battle_arg0_to_00
    ld [hli], a
    inc de
    dec b
    jr nz, .loop

.set_battle_arg0_to_00:
    ld [hl], $f0
    ld a, $00
    ld [wBattleArg0], a
    jr BattleEnd_Step1_CopyStringHLToDE_Return

BattleEnd_Step1_CopyStringHLToDE_Skip2::
    ld hl, wTextBuf0
    ld a, $30
    ld [hli], a
    ld a, $32
    ld [hli], a
    ld a, $31
    ld [hli], a
    ld a, $36
    ld [hli], a
    ld a, $37
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld a, $35
    ld [hli], a
    ld a, $36
    ld [hli], a
    ld [hl], $f0
    ld a, $02
    ld [wBattleArg0], a

BattleEnd_Step1_CopyStringHLToDE_Return::
    ret

; the same 66 bytes as IncrementPlayTime (IncrementPlayTime)
IncrementPlayTime_Bank31::
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03e7
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    or a
    jr nz, .skip
    ld a, [wPlayMinutes]
    cp $3b
    ret z

.skip:
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hld], a
    ld [hl], c
    ret

BattleFight_Step0_FillBytes::
    ld hl, wSideControl
    ld b, $08

.loop:
    set 7, [hl]
    inc hl
    dec b
    jr nz, .loop
    ld hl, wPersonalityActs
    ld bc, $0010
    xor a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000a
    xor a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $ff
    call FillBytes
    ld a, $ff
    ld [wBattleItemTarget], a
    ld [wBattleItemId], a
    ld a, $00
    ld [wMenuState], a
    ld a, [wSide0Flag]
    ld b, a
    ld c, $00
    ld a, [wLinkMode]
    or a
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, [wSide1Flag]
    ld b, a
    ld c, $04

.skip:
    push bc
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld c, $00

.loop2:
    ld a, [hli]
    or a
    jr nz, .next
    inc c

.next:
    dec b
    jr nz, .loop2
    ld a, c
    or a
    jr nz, .restore
    ld hl, wBattleStep
    inc [hl]

.restore:
    pop bc

.loop3:
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip2
    ld e, $01
    ld a, c
    call CheckSlotStatusBlock
    jr c, .skip2
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .skip2
    ld a, [hli]
    and $0c
    jr nz, .skip2
    ld a, [hli]
    and $30
    jr nz, .skip2
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr nz, .skip2
    ld e, $00

.skip2:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], e
    inc c
    dec b
    jr nz, .loop3
    ret

; battle fight step 1: one sub-step per wBattleSubPhase (13 cases, 0-12 observed in the first
; battle) that builds the battle screen and loads the combatants
RunBattleSetup::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleSetup_FleeCommand
    dw RunBattleSetup_CommandMenu
    dw RunBattleSetup_ItemCommand
    dw RunBattleSetup_FillScreenTileBufferRow11Col4WithC3_Bank31
    dw RunBattleSetup_ShowSelectingHeroSMove
    dw RunBattleSetup_WriteLinkSendByte
    dw RunBattleSetup_WriteLinkSendByteAndLinkBufferCountLoEtc
    dw RunBattleSetup_WriteLinkSendByteAndLinkReady
    dw RunBattleSetup_WriteLinkSendByteAndLinkReadyEtc
    dw RunBattleSetup_WriteLinkSendByteAndCounterPtr0Lo
    dw RunBattleSetup_WriteCounterPtr0HiAndLinkSendByte
    dw RunBattleSetup_WriteBattleSubPhase
    dw RunBattleSetup_FillTilesFromRequest

; by wBattleResolveStep: the flee/retire command ('Retire now?', '0 fled!', 'But the escape route
; was cut', 'No fleeing from this battle!', 'You threw in the towel!')
RunBattleSetup_FleeCommand::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_FleeCommand_ReadLinkModeAndLinkRole
    dw RunBattleSetup_FleeCommand_FillScreenTileBufferRow11Col4WithC3_Bank31
    dw RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_AdvanceBattleResolveStep
    dw RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink
    dw RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAMAndStep
    dw RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc
    dw RunBattleSetup_FleeCommand_ClearWindowAndCopyRectFarAndStep
    dw RunBattleSetup_FleeCommand_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_FleeCommand_ClearWindowAndCopyRectFar
    dw RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_3
    dw RunBattleSetup_FleeCommand_ShowRetireNow
    dw RunBattleSetup_FleeCommand_LoadCursorTileAndRect
    dw RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_SetBattleResolveStep
    dw RunBattleSetup_FleeCommand_WaitTextFlags
    dw RunBattleSetup_FleeCommand_ShowNoFleeingFromThis
    dw RunBattleSetup_FleeCommand_WaitTextFlags_SetBattleResolveStep

RunBattleSetup_FleeCommand_ReadLinkModeAndLinkRole::
    ld a, [wLinkMode]
    or a
    jr nz, .check_link_role
    ld c, $00
    jr .skip

.check_link_role:
    ld a, [wLinkRole]
    and $02
    sla a
    ld c, a

.skip:
    ld de, wFleeWork
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    ld a, $08
    add_a_to_hl
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc c
    dec b
    jr nz, .loop
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld a, [wLinkRole]
    rlca
    and $04
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    ld hl, vTiles1 + $6d0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_FleeCommand_CopyRectRecordToScreenBuffer_2
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_AdvanceBattleResolveStep::
    call RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM
    ld hl, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Data
    ld a, [wMenuState]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink::
    ld de, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Data
    ld hl, wMenuState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    ld hl, wMenuSubState
    ld bc, $0007
    ld a, $00
    call FillBytes
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAMAndStep::
    call RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc::
    ld a, [wMenuState]
    and $03
    ld [wBattleSetupDB], a
    or a
    jr z, .call_run_battle_setup_flee_command_read_link
    cp $01
    jr z, .read_link_role
    cp $02
    jr z, .check_link_mode
    jp .check_link_mode2

.call_run_battle_setup_flee_command_read_link:
    call RunBattleSetup_FleeCommand_ReadLinkRole
    call RunBattleSetup_FleeCommand_ReadLinkModeAndLinkRole_2
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jp .return

.read_link_role:
    ld a, [wLinkRole]
    sla a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, .set_command_monster
    inc c
    dec b
    jr nz, .loop
    ld a, $00
    ld [wStringCategory], a
    ld a, $2d
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_command_monster:
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr nz, .set_string_index_to_1D
    ld a, [wBattleKind]
    cp $04
    jr z, .set_string_index_to_1D
    cp $05
    jr z, .set_string_index_to_1D
    call RunBattleSetup_FleeCommand_ReadLinkRole
    call RunBattleSetup_FleeCommand_WriteCommandPageCountAndCommandCursorMaxEtc
    ld a, e
    or a
    jr nz, .set_battle_sub_phase_to_02
    ld a, $1f
    jr .set_string_index

.set_string_index_to_1D:
    ld a, $1d

.set_string_index:
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_sub_phase_to_02:
    ld a, $02
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.check_link_mode2:
    ld a, [wLinkMode]
    or a
    jr z, .call_run_battle_setup_flee_command_read_link2
    ld a, $20
    jr .set_string_index

.call_run_battle_setup_flee_command_read_link2:
    call RunBattleSetup_FleeCommand_ReadLinkRole
    ld hl, wBattleResolveStep
    ld [hl], $08
    ld a, [wBattleKind]
    cp $02
    jr c, .return
    ld [hl], $0f
    cp $02
    jr z, .return
    cp $03
    jr z, .return
    cp $05
    jr z, .return
    cp $06
    jr z, .return
    cp $07
    jr z, .return
    ld [hl], $0b

.return:
    ret

RunBattleSetup_FleeCommand_ReadLinkRole::
    ld a, [wLinkRole]
    and $02
    ld hl, wBattleActionChoice
    add a
    add a
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ret

RunBattleSetup_FleeCommand_ReadLinkModeAndLinkRole_2::
    ld a, [wLinkMode]
    or a
    jr nz, .check_link_role
    ld c, $00
    jr .skip

.check_link_role:
    ld a, [wLinkRole]
    and $02
    sla a
    ld c, a

.skip:
    ld de, wFleeWork
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    ld a, $08
    add_a_to_hl
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc de
    inc c
    dec b
    jr nz, .loop
    ret

RunBattleSetup_FleeCommand_ClearWindowAndCopyRectFarAndStep::
    call ClearWindowAndCopyRectFar
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    call RunBattleSetup_FleeCommand_CopyRectRecordToScreenBuffer_2
    ld a, $02
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_FleeCommand_ClearWindowAndCopyRectFar::
    call ClearWindowAndCopyRectFar
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld hl, wTextBuf0
    ld de, wPlayerName
    ld b, $0a

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ld [hl], $f0
    ld a, $01
    ld [wStringCategory], a
    ld a, $d8
    ld [wStringIndex], a ; '0 fled!'
    farcall BeginStringDisplay_Bank2F
    ld a, $82
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld a, [wBattleTurn]
    or a
    jr z, .check_link_mode
    ld a, [wBattlePartyCount]
    ld b, a
    ld e, $00
    ld c, $00
    ld hl, wBattleLevel

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, [hl]
    cp e
    jr c, .next
    ld e, a

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleFoeCount]
    ld b, a
    ld d, $00
    ld c, $04
    ld hl, wBattleLevel + $4

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld a, [hl]
    cp d
    jr c, .next2
    ld d, a

.next2:
    inc hl
    inc c
    dec b
    jr nz, .loop2
    ld a, d
    add $05
    cp e
    jr c, .check_link_mode
    call NextTableByte
    ld a, [wRandomLo]
    and $07
    inc a
    ld b, a
    ld a, [wBattleTurn]
    cp $04
    jr c, .skip
    ld a, $07

.skip:
    cp b
    jr nc, .check_link_mode
    call RunBattleSetup_FleeCommand_CheckSlotStatusBlockWide_Bank31
    jr z, .check_link_mode
    ld a, $00
    ld [wStringCategory], a
    ld a, $2c
    ld [wStringIndex], a ; 'But the escape route was cut'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr nz, .set_battle_scene_to_02
    call RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_2

.set_battle_scene_to_02:
    ld a, $02
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $03
    ld [wBattleStep], a
    ld a, $01
    ld [wTextSpeed], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ret

RunBattleSetup_FleeCommand_CheckSlotStatusBlockWide_Bank31::
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    ld e, $00

.loop:
    ld a, c
    call CheckSlotStatusBlockWide_Bank31
    jr c, .next
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, e
    or a
    ret

RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_2::
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    ld e, $00
    cp $0a
    jr c, .skip
    ld e, $01
    cp $14
    jr c, .skip
    ld e, $02
    cp $1e
    jr c, .skip
    ld e, $03

.skip:
    ld a, c
    ld hl, wSlotTrait
    add_a_to_hl
    ld a, [hl]
    cp $97
    ld hl, RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_Data1
    jr c, .skip2
    ld hl, RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_Data2

.skip2:
    ld a, e
    add a
    add a
    add_a_to_hl
    ld de, wSlotPersonalityHi
    call RunBattleSetup_FleeCommand_SubtractFloor0
    inc hl
    ld de, wSlotPersonalityMid
    call RunBattleSetup_FleeCommand_SubtractFloor0
    inc hl
    ld de, wSlotPersonalityLo
    call RunBattleSetup_FleeCommand_SubtractFloor0
    inc hl
    ld de, wSlotTrait
    call RunBattleSetup_FleeCommand_SubtractFloor0

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; the byte at DE + C -= the byte at HL, not below 0
RunBattleSetup_FleeCommand_SubtractFloor0::
    ld a, c
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    sub [hl]
    ld [de], a
    ret nc
    xor a
    ld [de], a
    ret

RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_Data1::
    db $04, $00, $00, $0a, $03, $00, $00, $05, $02, $00, $00, $03, $01, $00, $00, $02

RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_Data2::
    db $08, $00, $00, $0f, $06, $00, $00, $0a, $04, $00, $00, $05, $02, $00, $00, $03

RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_3::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotMarks

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld [hl], $03
    jr .next

.skip:
    ld [hl], $ff

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_FleeCommand_ShowRetireNow::
    call ClearWindowAndCopyRectFar
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a ; 'Retire now?'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_LoadCursorTileAndRect::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall LoadCursorTileAndRect
    ld a, $bb
    ld [wWindowTileBuffer + $7], a
    ld a, $01
    ld [wMenuSubState], a
    ld de, wScreenTileBuffer + $10e
    ld hl, vBGMap0 + $10e
    lb bc, $06, $05
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_SetBattleResolveStep::
    ld de, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Data2
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, [wMenuSubState]
    and $01
    ld hl, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Data1
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ld a, [wMenuSubState]
    and $01
    jr z, .set_string_category_to_00
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

.set_string_category_to_00:
    ld a, $00
    ld [wStringCategory], a
    ld a, $60
    ld [wStringIndex], a ; 'You threw in the towel!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Data1::
    db $2f, $99, $6f, $99

RunBattleSetup_FleeCommand_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $03
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $06
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ret

RunBattleSetup_FleeCommand_ShowNoFleeingFromThis::
    call ClearWindowAndCopyRectFar
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a ; 'No fleeing from this battle!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_FleeCommand_WaitTextFlags_SetBattleResolveStep::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; by wBattleResolveStep: draws the command windows, moves the command cursor
; (MoveBattleCommandCursor) and shows 'It has no usable ...'
RunBattleSetup_CommandMenu::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_SetMenuSubState
    dw RunBattleSetup_CommandMenu_MoveBattleCommandCursor
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_ShowStringBank09AtTilesHL_Bank31
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_2
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2AndStep
    dw RunBattleSetup_CommandMenu_ShowItHasNoUsable
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2AndStep_2
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11_2
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_2
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11_3
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_SetBattleArg1
    dw RunBattleSetup_CommandMenu_WriteListLastPageSize
    dw RunBattleSetup_CommandMenu_MoveBattleCommandCursor_FillScreenTileBufferRow11Col4WithC3_Bank31
    dw RunBattleSetup_CommandMenu_WriteBattleResolveStepAndBattleArg1
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31AndStep
    dw RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13AndStep
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount_2
    dw RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_SetBattleResolveStep
    dw RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31AndStep
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_3
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_3
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    dw RunBattleSetup_CommandMenu_CopyRectRecordToScreenBufferFar_6
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11_4
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_4
    dw RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11
    dw RunBattleSetup_CommandMenu_WriteCommandMonsterAndBattleResolveStepEtc
    dw RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13AndStep_BeginStringDisplay_Bank2F
    dw RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount_2
    dw RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_SetBattleResolveStep_2

RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31::
    ld hl, vTiles1 + $6d0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    ld a, [wCommandMenuState]
    or a
    jr z, .clear_command_page_count
    ld a, $07
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_Bank31

.clear_command_page_count:
    xor a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    call CopyRectRecordToScreenBufferFar
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_SetMenuSubState::
    ld a, [wCommandMonster]
    and $03
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld a, [wMenuSubState]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

RunBattleSetup_CommandMenu_MoveBattleCommandCursor::
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld hl, wMenuSubState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    and $03
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [wMenuSubState]
    and $03
    ld [hl], a
    call SetSlotTacticAndSlotLastTacticForCommandMonster
    cp $03
    jr nz, .read_command_monster
    ld a, [wCommandMenuState]
    or a
    jr z, .call_fill_screen_tile_buffer_row11_col4_with
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld [hl], $00
    jr .read_command_monster2

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $00
    ld [wBattleArg1], a
    ret

.check_bit1:
    bit 1, a
    jr z, .return

.loop:
    ld a, [wCommandMonster]
    and $03
    jr z, .set_battle_arg1_to_00
    ld a, [wCommandMonster]
    dec a
    ld [wCommandMonster], a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .loop
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable
    ld hl, wBattleResolveStep
    dec [hl]
    jr .return

.set_battle_arg1_to_00:
    ld a, $00
    ld [wBattleArg1], a
    jr .call_fill_screen_tile_buffer_row11_col4_with2

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hl], a

.read_command_monster2:
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    ld a, $20
    ld [wBattleResolveStep], a
    jr .return

.call_fill_screen_tile_buffer_row11_col4_with2:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7::
    call DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_ShowStringBank09AtTilesHL_Bank31::
    ld a, [wBattleArg1]
    or a
    call z, DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7
    xor a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call CopyRectRecordToScreenBufferFar_2
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $141
    call WriteFiveTilesFromTable
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    ld a, [wMenuSelectedMember]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    ld hl, wMenuSelectedMember
    call RunBattleSetup_CommandMenu_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld a, $00
    ld [wBattleArg1], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_bit0:
    bit 0, a
    jp z, .return
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $0f
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and $03
    swap a
    or [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and $03
    or a
    jr z, .call_count_present_foes_of_link_role_side
    cp $01
    jr z, .call_run_battle_setup_command_menu_write
    jr .read_command_monster

.call_count_present_foes_of_link_role_side:
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp $01
    jr nz, .call_fill_screen_tile_buffer_row11_col4_with
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $00
    ld [hli], a
    ld [hl], e
    jr .set_battle_arg1_to_01

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $0c
    ld [wBattleResolveStep], a
    xor a
    ld [wSubMenuCursor2], a
    jr .return

.call_run_battle_setup_command_menu_write:
    call RunBattleSetup_CommandMenu_WriteBattleArg2AndBattleArg3Etc
    ld a, d
    or a
    jr nz, .call_fill_screen_tile_buffer_row11_col4_with2
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.call_fill_screen_tile_buffer_row11_col4_with2:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    xor a
    ld [wBattleArg1], a
    ld a, $10
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ac
    ld [hli], a
    ld a, [wCommandMonster]
    ld [hl], a

.set_battle_arg1_to_01:
    ld a, $01
    ld [wBattleArg1], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_2::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2
    ld a, [wBattleArg1]
    or a
    jr z, .set_battle_resolve_step
    ld a, $20

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2AndStep::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2
    call ClearWindowAndCopyRectFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_ShowItHasNoUsable::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld a, $04
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2AndStep_2::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2
    call CopyRectRecordToScreenBufferFar_6
    xor a
    ld [wBattleArg1], a
    farcall RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_2
    xor a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11_2::
    call DrawScreenTileBufferRow17Col12RectToBGMapRow11
    xor a
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_2::
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $00
    ld [hli], a
    ld a, [wSubMenuCursor2]
    and $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    or b
    ld [hl], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11_3::
    call DrawScreenTileBufferRow17Col12RectToBGMapRow11
    ld a, [wBattleArg0]
    or a
    jr z, .set_battle_resolve_step_to_04
    ld a, $20
    jr .set_battle_resolve_step

.set_battle_resolve_step_to_04:
    ld a, $04

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_SetBattleArg1::
    ld a, [wBattleArg1]
    or a
    call z, DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2
    xor a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    call ShowSkillPageNames
    call RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31
    call CopyRectRecordsAndToScreenBufferFar
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    ld a, [wMenuCursor]
    and $03
    add c
    add a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_WriteListLastPageSize::
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld a, [wMenuCursor]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

RunBattleSetup_CommandMenu_MoveBattleCommandCursor_FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld hl, wMenuCursor
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg1], a
    call LoadSelectedSkillRecord_Bank31
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jp z, .set_string_index_to_25
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp $ff
    jr nz, .skip
    ld c, $01

.skip:
    xor a
    ld b, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jp nz, .set_string_index_to_26
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $f0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and $04
    or [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and $03
    or [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hli], a
    cp $35
    jr z, .check_command_monster3
    ld a, [wRecordBufferData + $4]
    cp $ff
    jr z, .skip2
    cp $14
    jr z, .skip2
    cp $80
    jr z, .check_command_monster
    cp $12
    jr z, .check_command_monster2
    cp $22
    jr z, .check_command_monster3
    cp $11
    jr z, .call_count_present_foes_of_link_role_side
    cp $21
    jr z, .call_count_present_slots_of_link_role_side
    cp $40
    jr z, .read_command_monster
    jp .return

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_command_monster:
    ld a, [wCommandMonster]
    and $04
    xor $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_command_monster2:
    ld a, [wCommandMonster]
    and $04
    xor $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_command_monster3:
    ld a, [wCommandMonster]
    and $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_count_present_foes_of_link_role_side:
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp $01
    jr nz, .set_battle_arg1_to_1C
    ld [hl], e
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_arg1_to_1C:
    ld a, $1c
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_count_present_slots_of_link_role_side:
    call CountPresentSlotsOfLinkRoleSide_Bank31
    ld a, d
    cp $01
    jr nz, .set_battle_arg1_to_18
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_battle_arg1_to_18
    cp $1f
    jr z, .set_battle_arg1_to_18
    ld a, [wCommandMonster]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_arg1_to_18:
    ld a, $18
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .call_run_battle_setup_command_menu_clear_bit6
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $04
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_run_battle_setup_command_menu_clear_bit6:
    call RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31
    call DrawInventoryPageIndicator

.return:
    ret

.set_string_index_to_25:
    ld a, $25
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_string_index_to_26:
    ld a, $26
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

RunBattleSetup_CommandMenu_WriteBattleResolveStepAndBattleArg1::
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleArg1], a
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31AndStep::
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects
    call ClearWindowAndCopyRectFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13AndStep::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_LayoutTileBlocksForBattleFoeCount_2::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_SetBattleResolveStep::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld a, $10
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31AndStep::
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_CommandMenu_ReadRecordBufferAndLinkRoleEtc
    xor a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_3::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_name_slot
    cp $1f
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_3::
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    ld a, [wRecordBuffer]
    cp $1b
    jr z, .check_command_monster
    cp $1c
    jr z, .check_command_monster
    cp $1d
    jr z, .check_command_monster
    cp $97
    jr nz, .read_command_monster

.check_command_monster:
    ld a, [wCommandMonster]
    and $03
    ld c, a
    ld a, [wSubMenuCursor2]
    and $03
    cp c
    jr nz, .read_command_monster
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects
    call ClearWindowAndCopyRectFar
    ld a, $65
    ld [wStringIndex], a
    ld a, $21
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and $03
    ld b, a
    ld a, [wCommandMonster]
    and $04
    or b
    ld [hl], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_CommandMenu_CopyRectRecordToScreenBufferFar_6::
    call CopyRectRecordToScreenBufferFar_6
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_battle_arg1
    cp $1f
    jr z, .set_battle_arg1
    xor a

.set_battle_arg1:
    ld [wBattleArg1], a
    farcall RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_2
    xor a
    ld [wBattleArg1], a
    xor a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11_4::
    call DrawScreenTileBufferRow17Col12RectToBGMapRow11
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_name_slot
    cp $1f
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_FillScreenTileBufferRow11Col4WithC3_Bank31_4::
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    or b
    ld [hl], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow17Col12RectToBGMapRow11::
    call DrawScreenTileBufferRow17Col12RectToBGMapRow11
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_CommandMenu_WriteCommandMonsterAndBattleResolveStepEtc::
    ld a, [wCommandMonster]
    and $04
    or $03
    ld b, a

.loop:
    ld a, [wCommandMonster]
    inc a
    ld [wCommandMonster], a
    cp b
    jr z, .clear_battle_resolve_step
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .loop
    xor a
    ld [wBattleResolveStep], a
    jr .return

.clear_battle_resolve_step:
    xor a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a

.return:
    ret

RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13AndStep_BeginStringDisplay_Bank2F::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_CommandMenu_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_SetBattleResolveStep_2::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld a, $18
    ld [wBattleResolveStep], a
    ret

; by wBattleResolveStep: the battle item command; its steps use wItemId, wItemRecord, wSlotChoices
; and the command cursor
RunBattleSetup_ItemCommand::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_ItemCommand_FillScreenTileBufferRow11Col4WithC3_Bank31
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9_SetBattleArg0
    dw RunBattleSetup_ItemCommand_MoveBattleCommandCursor
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9_SetSubMenuCursor
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11
    dw RunBattleSetup_ItemCommand_ToggleEntryBitsByJoypadAndBlink
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11_2
    dw RunBattleSetup_ItemCommand_ShowStringBank09AtTilesHL_Bank31AndStep
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    dw RunBattleSetup_ItemCommand_FillScreenTileBufferRow11Col4WithC3_Bank31_2
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_LoadSelectedInventoryItemRecord
    dw RunBattleSetup_ItemCommand_CopyRectRecordToScreenBufferFar_6
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow17Col12RectToBGMapRow11
    dw RunBattleSetup_ItemCommand_FillScreenTileBufferRow11Col4WithC3_Bank31_3
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_LoadSelectedInventoryItemRecord_2
    dw RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9AndStep
    dw RunBattleSetup_ItemCommand_DrawWindowTileBufferRow2Col16RowsToBGMapRow13AndStep
    dw RunBattleSetup_ItemCommand_BeginStringDisplay_Bank2F
    dw RunBattleSetup_ItemCommand_DrawWindowTileBufferRow2Col16RowsToBGMapRow13

RunBattleSetup_ItemCommand_FillScreenTileBufferRow11Col4WithC3_Bank31::
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    call ShowInventoryPageItemNames
    call RunBattleSetup_ItemCommand_ClearBit6AndCursorEntryTile_Bank31
    call CopyRectRecordToScreenBufferFar_3
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld c, a
    ld a, [wMenuOption]
    and $03
    add c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9_SetBattleArg0::
    call DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    ld a, [wBattleArg0]
    or a
    ret z
    xor a
    ld [wBattleArg0], a
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld a, [wMenuOption]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

RunBattleSetup_ItemCommand_MoveBattleCommandCursor::
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld hl, wMenuOption
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg1], a
    call LoadSelectedInventoryItemRecord
    ld a, [wItemId]
    ld [wBattleItemId], a
    ld a, [wItemRecord + $4]
    bit 0, a
    jr nz, .call_fill_screen_tile_buffer_row11_col4_with
    ld a, [wItemRecord + $6]
    or a
    jr z, .call_fill_screen_tile_buffer_row11_col4_with2
    cp $01
    jr z, .set_battle_item_target_to_10
    cp $02
    jr z, .call_draw_screen_tile_buffer_row14_col8_rows
    cp $03
    jr z, .set_battle_item_target_to_20
    cp $04
    jr z, .set_battle_resolve_step_to_04
    cp $05
    jr z, .set_battle_resolve_step_to_04
    cp $06
    jr z, .set_battle_sub_phase_to_03
    jp .set_battle_item_target_to_20

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleResolveStep], a
    ld a, $1e
    ld [wStringIndex], a
    jr .return

.call_fill_screen_tile_buffer_row11_col4_with2:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.set_battle_item_target_to_10:
    ld a, $10
    ld [wBattleItemTarget], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.call_draw_screen_tile_buffer_row14_col8_rows:
    call DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    ld a, $0c
    ld [wBattleResolveStep], a
    jr .return

.set_battle_item_target_to_20:
    ld a, $20
    ld [wBattleItemTarget], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a
    jr .return

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $ff
    ld [wBattleItemTarget], a
    ld [wBattleItemId], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit2:
    bit 2, a
    jr z, .call_run_battle_setup_item_command_clear_bit6
    farcall SortInventory
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data
    ld hl, wCommandCursor
    set 7, [hl]

.call_run_battle_setup_item_command_clear_bit6:
    call RunBattleSetup_ItemCommand_ClearBit6AndCursorEntryTile_Bank31
    call DrawInventoryPageIndicator
    jr .return

.return:
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9::
    call DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9_SetSubMenuCursor::
    ld a, [wSubMenuCursor]
    and $01
    ld [wSubMenuCursor], a
    ld a, [wBattleArg1]
    or a
    call z, DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    xor a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call CopyRectRecordToScreenBufferFar_5
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11::
    call DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11
    ld hl, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Data
    ld a, [wSubMenuCursor]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_ToggleEntryBitsByJoypadAndBlink::
    ld de, RunBattleSetup_ItemCommand_ToggleEntryBitsByJoypadAndBlink_Data
    ld hl, wSubMenuCursor
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    and $01
    jr nz, .check_sub_menu_cursor
    ld a, [wItemId]
    cp ITEM_BEEFJERKY
    jr c, .set_battle_arg0_to_01
    cp ITEM_BEASTTAIL
    jr nc, .set_battle_arg0_to_01
    ld a, [wSubMenuCursor]
    and $01
    jr z, .set_battle_arg0_to_01
    ld b, $04
    ld a, [wBattleSlotOut + $4]
    or a
    jr z, .set_battle_item_target
    ld b, $05
    ld a, [wBattleSlotOut + $5]
    or a
    jr z, .set_battle_item_target
    ld b, $06
    ld a, [wBattleSlotOut + $6]
    or a
    jr nz, .return

.set_battle_item_target:
    ld a, b
    ld [wBattleItemTarget], a
    jr .set_battle_sub_phase_to_03

.check_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    and $01
    inc a
    swap a
    ld [wBattleItemTarget], a

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.set_battle_arg0_to_01:
    ld a, $01
    ld [wBattleArg0], a
    jr .call_fill_screen_tile_buffer_row11_col4_with

.check_bit1:
    bit 1, a
    jr z, .return
    xor a
    ld [wSubMenuCursor], a
    ld a, $00
    ld [wBattleArg0], a

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11_2::
    call DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11
    ld a, [wBattleArg0]
    or a
    jr z, .set_battle_resolve_step
    ld a, [wSubMenuCursor]
    and $01
    add a
    add a
    add $08

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_ItemCommand_ShowStringBank09AtTilesHL_Bank31AndStep::
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8LeftToBGMapRow9::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_FillScreenTileBufferRow11Col4WithC3_Bank31_2::
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and $03
    ld [wBattleItemTarget], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.return:
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_LoadSelectedInventoryItemRecord::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    ld a, [wBattleArg0]
    or a
    jr nz, .set_battle_sub_phase_to_03
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp $04
    jr z, .set_battle_resolve_step_to_04
    cp $05
    jr z, .set_battle_resolve_step_to_04
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a

.clear_battle_arg0:
    xor a
    ld [wBattleArg0], a
    ret

RunBattleSetup_ItemCommand_CopyRectRecordToScreenBufferFar_6::
    call CopyRectRecordToScreenBufferFar_6
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr z, .set_battle_arg1
    xor a

.set_battle_arg1:
    ld [wBattleArg1], a
    farcall RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_2
    xor a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow17Col12RectToBGMapRow11::
    call DrawScreenTileBufferRow17Col12RectToBGMapRow11
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_FillScreenTileBufferRow11Col4WithC3_Bank31_3::
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and $03
    set 2, a
    ld [wBattleItemTarget], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.return:
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_LoadSelectedInventoryItemRecord_2::
    call DrawScreenTileBufferRow14Col8LeftToBGMapRow9
    ld a, [wBattleArg0]
    or a
    jr nz, .set_battle_sub_phase_to_03
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp $04
    jr z, .set_battle_resolve_step_to_04
    cp $05
    jr z, .set_battle_resolve_step_to_04
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a

.clear_battle_arg0:
    xor a
    ld [wBattleArg0], a
    ret

RunBattleSetup_ItemCommand_DrawScreenTileBufferRow14Col8RowsToBGMapRow9AndStep::
    call DrawScreenTileBufferRow14Col8RowsToBGMapRow9
    call ClearWindowAndCopyRectFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_DrawWindowTileBufferRow2Col16RowsToBGMapRow13AndStep::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunBattleSetup_ItemCommand_BeginStringDisplay_Bank2F::
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ret

RunBattleSetup_ItemCommand_DrawWindowTileBufferRow2Col16RowsToBGMapRow13::
    ld a, [wTextFlags]
    or a
    ret nz
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13
    xor a
    ld [wBattleResolveStep], a
    ret

RunBattleSetup_FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld b, $08
    ld hl, wSlotMarks

.loop:
    ld a, [hl]
    or a
    jr nz, .next
    ld [hl], $01

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [wBattleActor], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call ClearWindowAndCopyRectFar
    call DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

RunBattleSetup_ShowSelectingHeroSMove::
    ld a, [wLinkMode]
    or a
    jr z, .done
    ld de, wBattleTextWork
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a ; 'Selecting 0's move…'
    farcall BeginStringDisplay_Bank2F
    xor a
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_WriteLinkSendByte::
    ld a, [wLinkMode]
    or a
    jr z, .done
    ld a, $01
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_WriteLinkSendByteAndLinkBufferCountLoEtc::
    ld a, [wLinkMode]
    or a
    jp z, .done
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld de, wSlotTactic
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld de, wSlotTactic + $4

.skip:
    ld hl, wLinkRecvBuffer
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld a, [wRandomLo]
    ld [hli], a
    ld a, [wRandomHi]
    ld [hli], a
    ld a, [wMenuState]
    ld [hli], a
    ld a, [wMenuState]
    ld [hli], a
    ld de, wBattleActionChoice
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld de, wBattleActionChoice + $8

.skip2:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld de, wSlotMarks
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip3
    ld de, wSlotMarks + $4

.skip3:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld de, wSideControl
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip4
    ld de, wSideControl + $4

.skip4:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld a, $13
    ld [wLinkBufferCountLo], a
    xor a
    ld [wLinkBufferCountHi], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_WriteLinkSendByteAndLinkReady::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    and a
    jr z, .return
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a

.return:
    ret

RunBattleSetup_WriteLinkSendByteAndLinkReadyEtc::
    ld a, [wLinkMode]
    or a
    jp z, .done
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld de, wSlotTactic + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld de, wSlotTactic

.skip:
    ld hl, wLinkPartnerName
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc hl
    inc hl
    ld a, [hli]
    ld [wSlotCommands], a
    ld a, [hli]
    ld [wPartnerCommand], a
    ld de, wBattleActionChoice + $8
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld de, wBattleActionChoice

.skip2:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld de, wSlotMarks + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip3
    ld de, wSlotMarks

.skip3:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld de, wSideControl + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip4
    ld de, wSideControl

.skip4:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_random_seed2_lo
    ld a, [wRandomLo]
    ld [wRandomSeed2Lo], a
    ld a, [wRandomHi]
    ld [wRandomSeed2Hi], a
    ld a, [wMenuState]
    ld [wLinkPartnerCommandA], a
    ld a, [wMenuState]
    ld [wSlotCommands], a
    ld hl, wSlotTactic + $4
    ld de, wSlotLastTactic + $4
    jr .skip5

.read_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    ld [wRandomLo], a
    ld a, [wRandomSeed2Hi]
    ld [wRandomHi], a
    ld a, [wMenuState]
    ld [wLinkPartnerCommandB], a
    ld a, [wMenuState]
    ld [wPartnerCommand], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

.skip5:
    ld b, $03

.loop:
    ld a, [hl]
    cp $03
    jr z, .next
    ld [de], a

.next:
    inc hl
    inc de
    dec b
    jr nz, .loop

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_WriteLinkSendByteAndCounterPtr0Lo::
    ld a, [wLinkMode]
    and a
    jr nz, .skip
    jr .done

.skip:
    ld hl, wBattleSetupFlagsLo
    ld a, [hli]
    ld b, a
    ld a, [wRandomLo]
    cp b
    ld a, [wRandomSeed2Lo]
    cp b
    jr nz, .set_link_send_byte_to_33
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp b
    ld a, [wRandomSeed2Hi]
    cp b
    jr nz, .set_link_send_byte_to_33
    ld a, $22
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a
    jr .done

.set_link_send_byte_to_33:
    ld a, $33
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_WriteCounterPtr0HiAndLinkSendByte::
    ld a, [wLinkMode]
    and a
    jr z, .done
    ld a, [wLinkMessage]
    cp $22
    jr z, .set_counter_ptr0_hi
    cp $33
    jr z, .set_counter_ptr0_hi
    ret

.set_counter_ptr0_hi:
    ld [wCounterPtr0Hi], a
    xor a
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_WriteBattleSubPhase::
    ld a, [wLinkMode]
    and a
    jr z, .done
    ld a, [wCounterPtr0Lo]
    cp $22
    jr nz, .set_battle_sub_phase_to_05
    ld a, [wCounterPtr0Hi]
    cp $22
    jr nz, .set_battle_sub_phase_to_05
    jr .done

.set_battle_sub_phase_to_05:
    ld a, $05
    ld [wBattleSubPhase], a
    ret

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleSetup_FillTilesFromRequest::
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; up/down toggles bit 0 and left/right bit 1 of [HL] (sound $69); otherwise blinks the entry every
; 16 frames through bit 6 (E-0125)
ToggleEntryBitsByJoypadAndBlink::
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

RunBattleSetup_CommandMenu_SetBit6AndBlankEntryTile_Bank31::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $03
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, $02
    jr .call_clear_bit6_and_cursor_entry_tile_bank31

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $03
    inc a
    cp $03
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    xor a

.call_clear_bit6_and_cursor_entry_tile_bank31:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; up/down/left/right move the battle command cursor entry wCommandCursor within wListLastPageSize,
; wCommandCursorMax, wCommandPageCount, blinking it, with sound $69 (E-0131)
MoveBattleCommandCursor::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank31
    ld a, [wCommandCursorMax]
    or a
    jp z, .check_frame_counter_lo3
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, [wCommandCursorMax]
    jr .call_clear_bit6_and_cursor_entry_tile_bank31

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, [wListLastPageSize]

.call_clear_bit6_and_cursor_entry_tile_bank31:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jp .check_frame_counter_lo3

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_command_page_count
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank312
    ld a, [wCommandCursorMax]
    or a
    jp z, .check_frame_counter_lo3
    ld b, a
    call SetBit6AndBlankEntryTile_Bank31
    inc b
    ld a, [hl]
    and $0f
    inc a
    cp b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank312
    ld a, $00
    jr .call_clear_bit6_and_cursor_entry_tile_bank312

.call_set_bit6_and_blank_entry_tile_bank312:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and $0f
    inc a
    cp b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank312
    xor a

.call_clear_bit6_and_cursor_entry_tile_bank312:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo3

.check_command_page_count:
    ld a, [wCommandPageCount]
    or a
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wCommandCursor]
    or a
    jr nz, .set_command_cursor
    ld a, b
    jr .set_command_cursor2

.set_command_cursor:
    dec a

.set_command_cursor2:
    or $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank314

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .check_frame_counter_lo
    ld a, [wCommandCursor]
    cp b
    jr nz, .set_command_cursor3
    xor a
    jr .set_command_cursor4

.set_command_cursor3:
    inc a

.set_command_cursor4:
    or $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank314

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank313
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo3

.call_set_bit6_and_blank_entry_tile_bank313:
    call SetBit6AndBlankEntryTile_Bank31
    jr .check_frame_counter_lo3

.call_set_bit6_and_blank_entry_tile_bank314:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wCommandPageCount]
    ld b, a
    ld a, [wCommandCursor]
    res 7, a
    cp b
    jr nz, .check_frame_counter_lo3
    ld a, [wCommandCursorMax]
    or a
    jr nz, .skip
    xor a
    jr .check_frame_counter_lo2

.skip:
    ld b, a

.skip2:
    ld a, [hl]
    and $0f
    cp b
    jr z, .check_frame_counter_lo2
    jr c, .check_frame_counter_lo3
    dec [hl]
    jr .skip2

.check_frame_counter_lo2:
    set 7, a
    ld [hl], a

.check_frame_counter_lo3:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 +
; table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
SetBit6AndBlankEntryTile_Bank31::
    set 6, [hl]
    ld a, [hl]
    and $3f
    push hl
    add a
    add e
    ld l, a
    ld a, d
    adc $00
    ld h, a
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, $c3
    call WriteVRAMByte
    pop hl
    ret

; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 +
; table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
ClearBit6AndCursorEntryTile_Bank31::
    res 6, [hl]
    ld a, [hl]
    and $3f
    push hl
    add a
    add e
    ld l, a
    ld a, d
    adc $00
    ld h, a
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, $bb
    call WriteVRAMByte
    pop hl
    ret

; clears wMenuSubState and writes five consecutive tile numbers starting at
; WriteFiveTilesFromTable_Data[A] to HL (E-0122) (E-0344: the address in its name dropped or read as
; the label there; was WriteFiveTilesFromTable6102)
WriteFiveTilesFromTable::
    push hl
    ld hl, WriteFiveTilesFromTable_Data
    add_a_to_hl
    xor a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ret

WriteFiveTilesFromTable_Data::
    db $d0, $d5, $da

RunBattleSetup_CommandMenu_WriteBattleArg2AndBattleArg3Etc::
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and $f0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    cp $a2
    jr c, .next
    cp $aa
    jr c, .next2

.next:
    inc d

.next2:
    inc c
    inc hl
    dec b
    jr nz, .loop

.skip:
    ld a, c
    cp $05
    ld a, $00
    jr c, .set_command_page_count
    inc a

.set_command_page_count:
    ld [wCommandPageCount], a
    ld a, c
    or a
    jr z, .set_command_cursor_max
    and $03
    dec a
    and $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    ret

; shows the four skill names (category 4) of page wCommandCursor of monster wCommandMonster's skills
; (wBattleSkills + 16 * wCommandMonster) in the four tile rows; $FF shows string 0 (E-0121)
ShowSkillPageNames::
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and $f0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    inc hl
    cp $ff
    call z, ReturnZero
    call ShowStringAAtTiles16D0
    ld a, [hli]
    inc hl
    cp $ff
    call z, ReturnZero
    call ShowStringAAtTiles1760
    ld a, [hli]
    inc hl
    cp $ff
    call z, ReturnZero
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp $ff
    call z, ReturnZero
    call ShowStringAAtTiles2080
    ret

; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110) (E-0344: the address in
; its name dropped or read as the label there; was ReturnZero_61A2)
ReturnZero::
    xor a
    ret

RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31::
    ld a, [wCommandCursor]
    bit 7, a
    jr z, .check_menu_cursor
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuCursor
    call ClearBit6AndCursorEntryTile_Bank31
    call ShowSkillPageNames
    ld hl, wMenuCursor
    set 7, [hl]

.check_menu_cursor:
    ld a, [wMenuCursor]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuCursor], a
    and $0f
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    pop af
    add c
    add a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1f0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

RunBattleSetup_FleeCommand_WriteCommandPageCountAndCommandCursorMaxEtc::
    ld hl, wInventory
    ld bc, $1800
    ld e, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    inc c
    cp $0d
    jr c, .next
    cp $19
    jr c, .next2
    cp $20
    jr c, .next
    cp $22
    jr c, .next2
    cp $28
    jr nc, .next2

.next:
    inc e

.next2:
    dec b
    jr nz, .loop

.skip:
    ld a, c
    and $fc
    rrca
    rrca
    ld [wCommandPageCount], a
    ld a, c
    or a
    jr z, .set_command_cursor_max
    and $03
    call z, RunBattleSetup_FleeCommand_WriteCommandPageCount
    dec a
    and $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    ret

RunBattleSetup_FleeCommand_WriteCommandPageCount::
    push af
    ld a, [wCommandPageCount]
    dec a
    ld [wCommandPageCount], a
    pop af
    ret

; shows the four item names of inventory page wCommandCursor (category 5) in the four tile rows of
; ShowStringAAtTiles16D0 ... 2080; an empty slot ($FF) shows string 0 (E-0120)
ShowInventoryPageItemNames::
    ld a, $05
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    cp $ff
    call z, ReturnZero_2
    call ShowStringAAtTiles16D0
    ld a, [hli]
    cp $ff
    call z, ReturnZero_2
    call ShowStringAAtTiles1760
    ld a, [hli]
    cp $ff
    call z, ReturnZero_2
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp $ff
    call z, ReturnZero_2
    call ShowStringAAtTiles2080
    ret

; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110) (E-0344: the address in
; its name dropped or read as the label there; was ReturnZero_6286)
ReturnZero_2::
    xor a
    ret

RunBattleSetup_ItemCommand_ClearBit6AndCursorEntryTile_Bank31::
    ld a, [wCommandCursor]
    bit 7, a
    jr z, .check_menu_option
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuOption
    call ClearBit6AndCursorEntryTile_Bank31
    call ShowInventoryPageItemNames
    ld hl, wMenuOption
    set 7, [hl]

.check_menu_option:
    ld a, [wMenuOption]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuOption], a
    and $0f
    push af
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    pop af
    add c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ret

; wItemId = wInventory[(wCommandCursor & $0F) * 4 + (wMenuOption & 3)], then far-calls
; LoadItemRecord (E-0118)
LoadSelectedInventoryItemRecord::
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld hl, wInventory
    add_a_to_hl
    ld a, [wMenuOption]
    and $03
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    farcall LoadItemRecord
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $6D0 with size $0901; HL kept
; (E-0115)
ShowStringAAtTiles16D0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6d0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $760 with size $0901; HL kept
; (E-0115)
ShowStringAAtTiles1760::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $7F0 with size $0901; HL kept
; (E-0115)
ShowStringAAtTiles17F0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7f0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles2 + $80 with size $0901 (E-0115)
ShowStringAAtTiles2080::
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    ret

RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31::
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    pop af
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp $ff
    jr nz, .skip
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    jr .call_hl_to_decimal_digits

.skip:
    ld l, a
    ld h, $00
    jr .call_hl_to_decimal_digits

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $88
    call WriteDecimalDigitTiles
    ret

; when wCommandPageCount is non-zero writes tiles $C5, $E0 + (wCommandCursor & 7) + 1, $BE, $E0 +
; wCommandPageCount + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0120)
DrawInventoryPageIndicator::
    ld a, [wCommandPageCount]
    or a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $c5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and $07
    inc a
    add $e0
    call WriteVRAMByteInc
    ld a, $be
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add $e0
    call WriteVRAMByteInc
    ld a, $c6
    call WriteVRAMByte
    ret

RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Data::
    db $c1, $01, $01, $02, $c8, $01, $08, $02

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7_Data::
    db $41, $01, $81, $01, $c1, $01, $01, $02

RunBattleSetup_CommandMenu_DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2_Data::
    db $81, $01, $c1, $01, $01, $02

RunBattleSetup_ItemCommand_ToggleEntryBitsByJoypadAndBlink_Data::
    db $c1, $01, $01, $02, $c1, $01, $01, $02

RunBattleEndStep4SubSteps_MoveBattleCommandCursor_Data::
    db $29, $00, $69, $00, $a9, $00, $e9, $00

RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Data2::
    db $2f, $01, $6f, $01, $2f, $01, $6f, $01

; A = value: stores A in wSlotTactic[wCommandMonster], and also in wSlotLastTactic[wCommandMonster]
; unless A is 3 (E-0118)
SetSlotTacticAndSlotLastTacticForCommandMonster::
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; wRecordBuffer = the skill at wBattleSkills + 16 * wCommandMonster + 2 * (4 * (wCommandCursor & 1)
; + (wMenuCursor & 3)), wRecordBuffer + $1 = 0, then far-calls LoadSkillRecord (E-0120) (the same 48
; bytes appear in 2 banks)
LoadSelectedSkillRecord_Bank31::
    ld a, [wMenuCursor]
    and $03
    ld b, a
    ld a, [wCommandCursor]
    and $01
    add a
    add a
    add b
    add a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; side base = ((wLinkRole << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide; D = how
; many of its three slots are present, E = the last present one (0 when none); clobbers A, BC
; (E-0067) (the same 28 bytes appear in 2 banks)
CountPresentFoesOfLinkRoleSide_Bank31::
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d
    ld e, c

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; side base = (wLinkRole << 1) & 4: D = how many of its three slots are present; clobbers A, BC
; (E-0067) (the same 24 bytes appear in 2 banks)
CountPresentSlotsOfLinkRoleSide_Bank31::
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and $04
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ret

RunBattleSetup_CommandMenu_ReadRecordBufferAndLinkRoleEtc::
    ld a, [wRecordBuffer]
    cp $1e
    jr z, RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_ReadLinkRole
    cp $1f
    jr z, RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_ReadLinkRole
    jr RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_ReadLinkRole2

RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc::
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr nz, RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_ReadLinkRole2

RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_ReadLinkRole::
    ld a, [wLinkRole]
    sla a
    and $04
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $03
    ld hl, wSlotChoices

.loop:
    ld a, [de]
    cp $ff
    jr z, .skip2
    xor a

.skip2:
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    jr RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_CallCopyRectRecordToScreenBufferFar_4

RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_ReadLinkRole2::
    ld a, [wLinkRole]
    sla a
    and $04
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $03
    ld hl, wSlotChoices

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    jr RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_CallCopyRectRecordToScreenBufferFar_4

RunBattleSetup_ItemCommand_ReadItemIdAndLinkRoleEtc_CallCopyRectRecordToScreenBufferFar_4::
    call CopyRectRecordToScreenBufferFar_4
    ld hl, wWindowTileBuffer + $1a
    ld a, [wSlotChoices]
    or a
    call nz, FillFiveC3AtHL
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSlotChoices + $1]
    or a
    call nz, FillFiveC3AtHL
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSlotChoices + $2]
    or a
    call nz, FillFiveC3AtHL
    ret

; stores tile $C3 in the five bytes from HL; HL kept (E-0118)
FillFiveC3AtHL::
    push hl
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ret

RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty::
    or a
    jr nz, .skip2
    ld a, [wNameSlot]
    or a
    jr z, .skip
    ld c, $00
    jr .skip5

.skip:
    ld a, [hl]
    and $03
    dec a
    jr .skip3

.skip2:
    ld a, [hl]
    and $03

.skip3:
    add e
    and $03
    or b
    ld c, a
    ld d, $04

.loop:
    ld a, c
    and $03
    cp $03
    jr z, .skip4
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip5
    jr z, .skip4
    ld a, [wNameSlot]
    or a
    jr nz, .skip5

.skip4:
    ld a, c
    add e
    and $03
    or b
    ld c, a
    dec d
    jr nz, .loop

.skip5:
    ld a, c
    and $03
    ld [hl], a
    ret

RunBattleSetup_SetBit6AndBlankEntryTile_Bank31::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $ff
    ld a, $01
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $01
    ld a, $01
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; far-calls RunDebugState_E0 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was CallFunc443BInBankE0)
CallRunDebugState_E0InBankE0::
    farcall RunDebugState_E0
    ret

BattleEnd_Step1_CountSlots_BattleEnd_Step1_AddAx9ToHL::
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ld a, [wBattleKind]
    cp $08
    jr nc, .check_battle_scene
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr c, .skip2
    ld bc, $0304
    ld de, $0000
    call BattleEnd_Step1_CountSlots
    jr nc, .skip2
    ld a, d
    or a
    jr z, .skip
    xor a
    jr .set_battle_scene

.skip:
    ld a, $02
    jr .set_battle_scene

.skip2:
    ld a, $01
    jr .set_battle_scene

.check_battle_scene:
    ld a, [wBattleScene]
    or a
    jr nz, .set_battle_scene
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_battle_end_step1_add_ax9_to_hl2
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr nc, .call_battle_end_step1_add_ax9_to_hl
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr c, .set_battle_scene_to_80
    jr .skip4

.call_battle_end_step1_add_ax9_to_hl:
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr c, .skip3
    jr .set_battle_scene_to_80

.call_battle_end_step1_add_ax9_to_hl2:
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr nc, .call_battle_end_step1_add_ax9_to_hl3
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr c, .set_battle_scene_to_80
    jr .skip4

.call_battle_end_step1_add_ax9_to_hl3:
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_AddAx9ToHL
    jr c, .skip3
    jr .set_battle_scene_to_80

.skip3:
    ld a, $04
    jr .set_battle_scene

.skip4:
    ld a, $05
    jr .set_battle_scene

.set_battle_scene_to_80:
    ld a, $80

.set_battle_scene:
    ld [wBattleScene], a
    ret

BattleEnd_Step1_AddAx9ToHL::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr nz, .next
    inc e

.next:
    inc c
    dec b
    jr nz, BattleEnd_Step1_AddAx9ToHL
    ld a, e
    cp $01
    ret

; over B slots from C counts present (wBattleSlotOut 0) in E and out in D; Z when exactly one is
; present
BattleEnd_Step1_CountSlots::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr z, .next2
    or a
    jr nz, .next
    inc e
    jr .next2

.next:
    inc d

.next2:
    inc c
    dec b
    jr nz, BattleEnd_Step1_CountSlots
    ld a, e
    cp $01
    ret

BattleEnd_Step3_SubtractBattleMP_2::
    ld a, [wLinkMode]
    or a
    jr nz, .return
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

.loop:
    push bc
    call BattleEnd_Step3_WriteBattleResultByte
    ld a, c
    push bc
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    pop bc
    call BattleEnd_Step3_AddAx9ToHL
    call BattleEnd_Step3_WriteBattleArg0
    call BattleEnd_Step3_SubtractBattleMP
    call BattleEnd_Step3_ReadBattleArg0
    call BattleEnd_Step3_ReadBattleArg0_2
    pop bc
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a

.return:
    ret

BattleEnd_Step3_WriteBattleResultByte::
    push bc
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and $03
    ld b, a
    ld a, c
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    rlca
    rlca
    and $0c
    or b
    swap a
    push af
    ld a, c
    ld c, MON_SEX
    call SRAMRecordAddressMapped
    ld a, [hl]
    and $0f
    pop bc
    or b
    ld [hl], a
    ld a, [wMenuState]
    and $03
    ld [wBattleResultByte], a
    pop bc
    ret

BattleEnd_Step3_AddAx9ToHL::
    ld [hl], $00
    ld a, c
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $01
    jr z, .done
    ld a, [wBattleKind]
    cp $04
    ret z
    ld a, c
    push hl
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    bit 5, a
    call nz, BattleEnd_Step3_ReturnAfterSetup
    and $03
    call nz, BattleEnd_Step3_ReturnAfterSetup_2
    ret

.done:
    set 7, [hl]
    ret

BattleEnd_Step3_ReturnAfterSetup::
    set 0, [hl]
    ret

BattleEnd_Step3_ReturnAfterSetup_2::
    set 2, [hl]
    ret

BattleEnd_Step3_WriteBattleArg0::
    ld a, [hl]
    ld [wBattleArg0], a
    bit 7, [hl]
    push af
    ld a, l
    add $06
    ld l, a
    ld a, h
    adc $00
    ld h, a
    pop af
    jr nz, .skip
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleHP
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    pop hl
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    bit 7, h
    jr z, .restore
    add hl, de
    ld d, h
    ld e, l

.restore:
    pop hl
    jr .skip2

.skip:
    ld de, $0000

.skip2:
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    inc hl
    inc hl
    ret

; the record word - the slot's wBattleMP word, keeping the word when the result would be negative
BattleEnd_Step3_SubtractBattleMP::
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    pop hl
    bit 7, d
    jr nz, .skip
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    bit 7, h
    jr z, .restore
    add hl, de

.skip:
    ld d, h
    ld e, l

.restore:
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

BattleEnd_Step3_ReadBattleArg0::
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, .skip2
    ld a, c
    ld de, wBattleExtraStat
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hld], a

.skip2:
    ld a, l
    add $04
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

BattleEnd_Step3_ReadBattleArg0_2::
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, .return
    ld a, c
    ld de, wSlotPersonalityHi
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    ld a, c
    ld de, wSlotPersonalityLo
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld [hli], a
    ld a, c
    ld de, wSlotTrait
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld [hli], a
    ld a, c
    ld de, wSlotPersonalityMid
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ld [hl], a

.return:
    ret

; by wBattleSubPhase: adds experience to each record (AddExpToRecordCCapped/HLCapped), checks
; RecordReachedNextLevelExp, computes level-up stat gains and learned skills ('0 learned G!')
BattleEnd_GainExperience::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_GainExperience_WriteBattleResolveStepAndBattleSubPhaseEtc
    dw BattleEnd_GainExperience_AddExpToRecordCCapped
    dw BattleEnd_GainExperience_CheckLevelUp
    dw BattleEnd_GainExperience_CountDownBattleEndTimerWhenSoundIdle
    dw BattleEnd_GainExperience_StoreWorkBufToRecordSkills
    dw BattleEnd_GainExperience_AddExpToRecordHLCapped
    dw BattleEnd_GainExperience_RecordReachedNextLevelExp
    dw BattleEnd_GainExperience_ComputeLevelUpStatGainsForBattleArg1
    dw BattleEnd_GainExperience_SetBattleStep
    dw BattleEnd_GainExperience_LearnSkill

BattleEnd_GainExperience_WriteBattleResolveStepAndBattleSubPhaseEtc::
    ld a, [wBattleKind]
    cp $04
    jr c, .skip
    cp $06
    jr z, .skip
    cp $07
    jr z, .skip
    xor a
    ld [wBattleResolveStep], a
    ld a, $09
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    ret z
    ld a, $08
    ld [wBattleSubPhase], a
    ret

.skip:
    ld bc, $0300
    ld d, $00

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .next
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, d
    push af
    call Divide24ByA
    pop af
    ld a, l
    ldh [hTemp0], a
    ld [wBattleExpAward], a
    ld a, h
    ldh [hTemp1], a
    ld [wBattleExpAward + $1], a
    ld a, e
    ldh [hTemp2], a
    ld [wBattleExpAward + $2], a
    ld hl, wTextBuf0
    call WriteNumber24AsDecimalString
    ld hl, $0500
    call ShowStringHL_Bank31
    ld hl, wBattleSubPhase
    inc [hl]
    ret
    db $fe, $02, $c8, $fe, $03, $28, $0d, $7d, $d6, $01, $6f, $7c, $de, $00, $67, $7b
    db $de, $00, $5f, $c9, $7d, $c6, $01, $6f, $7c, $ce, $00, $67, $7b, $ce, $00, $5f
    db $c9

BattleEnd_GainExperience_AddExpToRecordCCapped::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld bc, $0300

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    call z, AddExpToRecordCCapped
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleArg0], a
    ret

; adds the 24-bit wBattleExpAward-wBattleExpAward + $2 to the 3-byte field $58 of record C, capped
; at 9,999,999 ($98967F) (E-0125)
AddExpToRecordCCapped::
    push bc
    ld a, c
    ld c, MON_EXP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc d
    ld d, a
    ld a, $7f
    sub c
    ld a, $96
    sbc b
    ld a, $98
    sbc d
    jr nc, .skip
    ld c, $7f
    ld b, $96
    ld d, $98

.skip:
    ld a, d
    ld [hld], a
    ld a, b
    ld [hld], a
    ld [hl], c
    pop bc
    ret

; by its step: RecordReachedNextLevelExp and the record name
BattleEnd_GainExperience_CheckLevelUp::
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_GainExperience_CheckLevelUp_RecordReachedNextLevelExp
    dw BattleEnd_GainExperience_CheckLevelUp_CopyTenByteNameToTextBuf0

BattleEnd_GainExperience_CheckLevelUp_RecordReachedNextLevelExp::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattleArg0]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .read_party_count
    ld a, [wBattleArg0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    call RecordReachedNextLevelExp
    bit 0, c
    jr nz, .set_battle_end_timer_to_3C

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld a, [wBattleArg0]
    inc a
    ld [wBattleArg0], a
    cp b
    ret c
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.set_battle_end_timer_to_3C:
    ld a, $3c
    ld [wBattleEndTimer], a
    ld a, [wBattleArg0]
    ld hl, wBattleLevel
    add_a_to_hl
    inc [hl]
    ld a, [wBattleArg0]
    ld c, a
    call DrawSlotStatusMarks
    ld a, [wBattleArg0]
    ld c, a
    call CopySlotPanelRowToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

BattleEnd_GainExperience_CheckLevelUp_CopyTenByteNameToTextBuf0::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    call CopyTenByteNameToTextBuf0
    push hl
    ld a, [wBattleArg0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wBattleArg1], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    pop hl
    call WriteRecordField4BAndStatsDecimal
    ld hl, $0501
    call ShowStringHL_Bank31
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

BattleEnd_GainExperience_CountDownBattleEndTimerWhenSoundIdle::
    call CountDownBattleEndTimerWhenSoundIdle
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_GainExperience_FillBytes
    dw BattleEnd_GainExperience_FindNewlyLearnableSkills
    dw BattleEnd_GainExperience_ToRunBattleEndStep4SubSteps

BattleEnd_GainExperience_FillBytes::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wWorkBuf
    ld bc, $0038
    ld a, $ff
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wBattleResolveStep
    inc [hl]
    ret

BattleEnd_GainExperience_FindNewlyLearnableSkills::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall FindNewlyLearnableSkills
    ldh a, [hTemp3]
    cp $ff
    jr z, .call_for_each_sram_record_run
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld c, $ff
    ld hl, $0503
    ldh a, [hTemp4]
    or a
    jr z, .call_show_string_hl_bank31
    ld hl, $0505
    ldh a, [hTemp4]
    cp $02
    jr z, .call_show_string_hl_bank31
    ldh a, [hTemp5]
    ld l, a
    ld h, $04
    ld de, wTextBuf3
    call CopyStringHLToDE
    ld hl, $0504
    ldh a, [hTemp5]
    ld c, a

.call_show_string_hl_bank31:
    push bc
    call ShowStringHL_Bank31
    pop bc
    ld hl, wWorkBuf
    ld b, $38

.loop:
    ld a, [hl]
    cp c
    jr nz, .next
    ldh a, [hTemp3]
    ld [hl], a
    jr .return

.next:
    inc hl
    dec b
    jr nz, .loop

.return:
    ret

.call_for_each_sram_record_run:
    call ForEachSRAMRecordRun
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

BattleEnd_GainExperience_ToRunBattleEndStep4SubSteps::
    call RunBattleEndStep4SubSteps
    ret

BattleEnd_GainExperience_StoreWorkBufToRecordSkills::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call StoreWorkBufToRecordSkills
    call ApplyLevelUpToRecordBattleArg0
    call ShowString0ACat5IfField56AtLeast57
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubPhase
    dec [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

; record wBattleArg0: level (field $56) += 1 and the gains wLevelUpGains-wLevelUpGains + $5 are
; added to its six stat words (E-0127)
ApplyLevelUpToRecordBattleArg0::
    ld a, [wBattleArg0]
    ld c, MON_LEVEL
    call SRAMRecordAddressMapped
    inc [hl]
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $03
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31_2
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes
; appear in 2 banks)
AddAToWordAtHL_Bank31_2::
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    ret

; for record wBattleArg0: if field $56 (level) >= field $57, begins showing string $0A of category 5
; (BeginStringDisplay_Bank2F) (E-0122)
ShowString0ACat5IfField56AtLeast57::
    ld a, [wBattleArg0]
    ld c, MON_LEVEL
    call SRAMRecordAddressMapped
    ld a, [hli]
    cp [hl]
    ret c
    ld a, $0a
    ld [wStringIndex], a ; 'It has reached the limit for'
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; copies the 8 bytes at wWorkBuf to the skill list (field $34) of record wBattleArg0 (E-0122)
StoreWorkBufToRecordSkills::
    ld a, [wBattleArg0]
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ret

BattleEnd_GainExperience_AddExpToRecordHLCapped::
    call DivideBattleExpAwardByModeFactor
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $1e
    ld c, $00

.loop:
    ld a, [hl]
    cp $01
    jr nz, .skip
    push hl
    ld a, l
    add $6e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    and a
    pop hl
    call z, AddExpToRecordHLCapped

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; divides the 24-bit wBattleExpAward-wBattleExpAward + $2 by 20, 15 or 10 for wFarmLevel = 0, 1 or
; other (E-0124)
DivideBattleExpAwardByModeFactor::
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, [wFarmLevel]
    or a
    jr z, .skip
    cp $01
    jr z, .call_divide24_by_a
    ld a, $0a
    jr .call_divide24_by_a2

.skip:
    ld a, $14
    jr .call_divide24_by_a2

.call_divide24_by_a:
    ld a, $0f

.call_divide24_by_a2:
    call Divide24ByA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    ld a, e
    ld [wBattleExpAward + $2], a
    ret

; adds the 24-bit wBattleExpAward-wBattleExpAward + $2 to the 3-byte field $58 of the record at HL,
; capped at 9,999,999 ($98967F) (E-0125)
AddExpToRecordHLCapped::
    push bc
    push hl
    ld a, l
    add $58
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc d
    ld d, a
    ld a, $7f
    sub c
    ld a, $96
    sbc b
    ld a, $98
    sbc d
    jr nc, .skip
    ld c, $7f
    ld b, $96
    ld d, $98

.skip:
    ld a, d
    ld [hld], a
    ld a, b
    ld [hld], a
    ld [hl], c
    pop hl
    pop bc
    ret

BattleEnd_GainExperience_RecordReachedNextLevelExp::
    ld hl, sRecords
    ld b, $1e
    ld c, $00

.loop:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    cp $01
    jr nz, .skip
    push hl
    push bc
    ld a, c
    call RecordReachedNextLevelExp
    bit 0, c
    pop bc
    pop hl
    jr nz, .skip2

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.skip2:
    xor a
    ld [rRAMG], a
    ld a, c
    ld [wBattleArg1], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

BattleEnd_GainExperience_ComputeLevelUpStatGainsForBattleArg1::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    call ApplyLevelUpToRecordBattleArg1
    call CopyRecordFields5DTo5BAnd61To5F
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ret

; record wBattleArg1: level (field $56) += 1 and the gains wLevelUpGains-wLevelUpGains + $5 are
; added to its six stat words (E-0127)
ApplyLevelUpToRecordBattleArg1::
    ld a, [wBattleArg1]
    ld c, MON_LEVEL
    call SRAMRecordAddress
    inc [hl]
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $03
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes
; appear in 2 banks)
AddAToWordAtHL_Bank31::
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    ret

; for SRAM record wBattleArg1: field $5B = word field $5D, field $5F = word field $61, field $55 = 0
; (E-0121)
CopyRecordFields5DTo5BAnd61To5F::
    ld a, [wBattleArg1]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push hl
    ld a, l
    add $fc
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], b
    pop hl
    push hl
    inc hl
    inc hl
    ld a, [hli]
    ld c, a
    ld b, [hl]
    pop hl
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, l
    add $f4
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld [hl], $00
    ret

BattleEnd_GainExperience_SetBattleStep::
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; by its step: '0 learned G!'
BattleEnd_GainExperience_LearnSkill::
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc
    dw BattleEnd_GainExperience_LearnSkill_ClearTemp0AndA
    dw BattleEnd_GainExperience_LearnSkill_WaitTextFlags

BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc::
    ld a, [wArenaRank]
    cp $05
    jr c, BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc_Skip
    ld a, [wBattlePartyCount]
    cp $01
    jr nz, BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc_Skip
    ld a, [wLearnSkillState]
    or a
    jr z, BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc_Skip
    cp $aa
    jr nz, .done
    ld a, $8f
    ld [wLearnSkillState], a

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc_Skip::
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

BattleEnd_GainExperience_LearnSkill_ClearTemp0AndA::
    ld a, [wLearnSkillState]
    ldh [hTemp0], a
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wPartyList]
    ld c, MON_SKILLS
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    farcall ClearTemp0AndA
    ldh a, [hTemp0]
    or a
    jr nz, .skip
    xor a
    ld [rRAMG], a
    jr BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc_Skip

.skip:
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, [wPartyList]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld d, h
    ld e, l
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, [wPartyList]
    ld c, MON_SKILLS
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $1f
    ld [wStringIndex], a ; '0 learned G!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

BattleEnd_GainExperience_LearnSkill_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    jp BattleEnd_GainExperience_LearnSkill_WriteLearnSkillStateAndBattleSubPhaseEtc_Skip

; HL += A * $4E (the battler-record size, Multiply8); clobbers BC (E-0115)
AddAx4EToHL::
    push hl
    ld c, $4e
    call Multiply8
    pop bc
    add hl, bc
    ret

; record A below its level cap: C = 1 when its EXP (field $58) has reached the next level's total
; from the species growth table, else 0 (E-0127)
RecordReachedNextLevelExp::
    push af
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    pop af
    ld c, MON_LEVEL
    call SRAMRecordAddress
    ld a, [hli]
    cp [hl]
    jr nc, .skip2
    ldh [hTemp1], a
    ld a, l
    add $b4
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hli]
    ld [wSpeciesIdHi], a
    ld a, l
    add $4b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    farcall LoadExpTableEntryToTemp2
    pop hl
    ldh a, [hTemp2]
    sub [hl]
    ld e, a
    inc hl
    ldh a, [hTemp3]
    sbc [hl]
    ld d, a
    inc hl
    ldh a, [hTemp4]
    sbc [hl]
    jr c, .skip
    or d
    or e
    jr nz, .skip2

.skip:
    ld c, $01
    jr .done

.skip2:
    ld c, $00

.done:
    xor a
    ld [rRAMG], a
    ret

; copies 10 bytes from HL to wTextBuf0 and appends a $F0 terminator (E-0122)
CopyTenByteNameToTextBuf0::
    ld de, wTextBuf0
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    ret

; writes [HL + $4B] + 1 to wTextBuf1 and wLevelUpGains-wLevelUpGains + $5 to wTextBuf2-wTextBuf3 +
; $4 as decimal strings (E-0121)
WriteRecordField4BAndStatsDecimal::
    ld a, l
    add $4b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    inc a
    ld hl, wTextBuf1
    call WriteDecimalByteString
    ld a, [wLevelUpGains]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $1]
    ld hl, wTextBuf2 + $4
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $2]
    ld hl, wTextBuf2 + $8
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $3]
    ld hl, wTextBuf2 + $c
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $4]
    ld hl, wTextBuf3
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $5]
    ld hl, wTextBuf3 + $4
    call WriteDecimalByteString
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank2F (E-0110)
ShowStringHL_Bank31::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ret

; with SRAM enabled runs ForEachSkillOfRecordBRun for each of the 30 records ($A5 bytes from
; sRecords) whose first byte is non-zero (E-0124) (E-0344: the address in its name dropped or read
; as the label there; was ForEachSRAMRecordRun6E18)
ForEachSRAMRecordRun::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $00

.loop:
    ld a, [hl]
    or a
    jr z, .skip
    push hl
    push bc
    call ForEachSkillOfRecordBRun
    pop bc
    pop hl

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc b
    ld a, b
    cp $1e
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; runs ForEachSkillOfRecordBRun_SRAMRecordAddress for each of the eight skills (field $34) of record
; B that is not $FF (E-0124) (E-0344: the address in its name dropped or read as the label there;
; was ForEachSkillOfRecordBRun6E30)
ForEachSkillOfRecordBRun::
    push bc
    ld a, b
    ld c, MON_SKILLS
    call SRAMRecordAddress
    pop bc
    ld c, $08

.loop:
    ld a, [hli]
    cp $ff
    push hl
    push bc
    call nz, ForEachSkillOfRecordBRun_SRAMRecordAddress
    pop bc
    pop hl
    dec c
    jr nz, .loop
    ret

ForEachSkillOfRecordBRun_SRAMRecordAddress::
    ld d, a
    push de
    ld a, b
    ld c, MON_SKILL_LIST
    call SRAMRecordAddress
    pop de
    push hl
    ld c, $19

.loop:
    ld a, [hl]
    cp d
    jr nz, .next
    ld [hl], $ff

.next:
    inc hl
    dec c
    jr nz, .loop
    pop hl
    push hl
    ld de, wBattlerRecords + $4
    ld b, $19

.loop2:
    ld a, [hl]
    ld [de], a
    ld a, $ff
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld de, wBattlerRecords + $4
    ld b, $19

.loop3:
    ld a, [de]
    cp $ff
    jr z, .next2
    ld [hli], a

.next2:
    inc de
    dec b
    jr nz, .loop3
    ret

; runs the routine for wBattleSubStep (jump table of seven) (E-0122)
RunBattleEndStep4SubSteps::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleEndStep4SubSteps_ClearAttributesAndScreenBuffer_Bank31
    dw RunBattleEndStep4SubSteps_FillScreenTileBufferRow11Col4WithC3_Bank31
    dw RunBattleEndStep4SubSteps_MoveBattleCommandCursor
    dw RunBattleEndStep4SubSteps_CopyRectRecordToScreenBuffer
    dw RunBattleEndStep4SubSteps_LoadCursorTileAndRect
    dw RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink
    dw RunBattleEndStep4SubSteps_WaitTextFlags

RunBattleEndStep4SubSteps_ClearAttributesAndScreenBuffer_Bank31::
    call RunBattleEndStep4SubSteps_FillBytes
    cp $09
    jr nc, .skip
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall DrawPartySlotStatusPanels
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ld hl, vBGMap0
    ld bc, $1412
    ld de, wScreenTileBuffer

.loop:
    push bc

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, e
    add $0c
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop bc
    dec c
    jr nz, .loop
    ret

.skip:
    ld b, a
    dec a
    and $03
    ld [wCommandCursorMax], a
    ld a, $04
    call DivideBByA
    cp $00
    jr nz, .set_command_page_count
    dec b

.set_command_page_count:
    ld a, b
    ld [wCommandPageCount], a
    xor a
    ld [wCommandCursor], a
    ld a, $03
    ld [wListLastPageSize], a
    ld hl, $0506
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    xor a
    ld [wMenuState], a
    ret

RunBattleEndStep4SubSteps_FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    call RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc
    farcall CopyRectRecordsAndPlaySound6C
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a2
    call WriteDecimalDigitTiles
    xor a
    ld [rRAMG], a
    ld a, [wCommandPageCount]
    add $e1
    ld [wScreenTileBuffer + $111], a
    call ShowSelectedSkillNameAndCost
    ld de, wScreenTileBuffer + $8
    ld hl, vBGMap0 + $8
    lb bc, $0c, $09
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM
    call DrawCommandCursorPageNumber
    ld hl, wBattleSubStep
    inc [hl]
    ret

RunBattleEndStep4SubSteps_MoveBattleCommandCursor::
    ld de, RunBattleEndStep4SubSteps_MoveBattleCommandCursor_Data
    ld hl, wMenuState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuState]
    and $0f
    add b
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat2
    call DrawWindowTileBufferRow7Col18ThreeTilesAtBGMap206
    ret

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $30
    ret z
    ld hl, wCommandCursor
    res 7, [hl]
    call RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc
    call DrawWindowTileBufferRow7Col18ThreeTilesAtBGMap206
    call DrawCommandCursorPageNumber
    ret

RunBattleEndStep4SubSteps_CopyRectRecordToScreenBuffer::
    ld a, [wMenuState]
    and $0f
    ld hl, RunBattleEndStep4SubSteps_MoveBattleCommandCursor_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld [hl], $bc
    farcall CopyRectRecordToScreenBuffer
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM
    ld hl, $0508
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

RunBattleEndStep4SubSteps_LoadCursorTileAndRect::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall LoadCursorTileAndRect
    ld a, $bb
    ld [wWindowTileBuffer + $7], a
    ld hl, vBGMap0 + $10e
    ld de, wScreenTileBuffer + $10e
    lb bc, $06, $05
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wMenuSubState], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink::
    ld de, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Data2
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSubState]
    bit 0, a
    jr nz, .set_battle_sub_step_to_01
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuState]
    and $0f
    add b
    ld hl, wWorkBuf
    add_a_to_hl
    ld [hl], $ff
    ld hl, $0509
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z

.set_battle_sub_step_to_01:
    ld a, $01
    ld [wBattleSubStep], a
    ret

RunBattleEndStep4SubSteps_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wBattleSubStep], a
    ret

RunBattleEndStep4SubSteps_FillBytes::
    ld hl, wBattlerRecords + $4
    ld bc, $0038
    ld a, $ff
    call FillBytes
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38
    ld c, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .next
    ld [de], a
    inc de
    inc c

.next:
    dec b
    jr nz, .loop
    ld a, c
    push af
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop af
    ret

RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc::
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld hl, wWorkBuf
    add_a_to_hl
    ld bc, $0400

.loop:
    push bc
    push hl
    ld a, c
    ld hl, RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    pop hl
    ld a, [hli]
    push hl
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop hl
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc_Data::
    db $c0, $95, $50, $96, $e0, $96, $70, $97

; shows the name (category 9) of skill wWorkBuf[4 * page + row] at vTiles2 + $260, loads its record
; and writes its MP cost (or the record's MP for skills $3D, $20, $7B) as digits at
; wWindowTileBuffer + $9E (E-0128)
ShowSelectedSkillNameAndCost::
    ld hl, vTiles2 + $260
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1203
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuState]
    and $0f
    add b
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    push af
    ld [wStringIndex], a
    ld a, $09
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop af
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBuffer]
    cp $3d
    jr z, .skip
    cp $20
    jr z, .skip
    cp $7b
    jr nz, .read_record_buffer_data

.skip:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    xor a
    ld [rRAMG], a
    jr .call_hl_to_decimal_digits

.read_record_buffer_data:
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $9e
    call WriteDecimalDigitTiles
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; runs ShowSelectedSkillNameAndCost, then writes the three bytes at wWindowTileBuffer + $9E to
; vBGMap0 + $206 (E-0122) (E-0340: the address in its name read as its RAM name; was
; DrawWC39EThreeTilesAtBGMap206)
DrawWindowTileBufferRow7Col18ThreeTilesAtBGMap206::
    call ShowSelectedSkillNameAndCost
    ld hl, vBGMap0 + $206
    ld de, wWindowTileBuffer + $9e
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; writes tile $E1 + (wCommandCursor & $0F) at vBGMap0 + $10F (E-0115)
DrawCommandCursorPageNumber::
    ld a, [wCommandCursor]
    and $0f
    add $e1
    ld hl, vBGMap0 + $10f
    call WriteVRAMByte
    ret

; when every sound channel slot flag is $FF (all idle), decrements wBattleEndTimer (E-0121)
CountDownBattleEndTimerWhenSoundIdle::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    ret nz
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; on CGB writes 0 to the 20 x 18 visible attributes of vBGMap0 in VRAM bank 1 (rows 32 apart,
; WriteVRAMByteInc); then fills the $240 bytes of wScreenTileBuffer with $C3; what follows is not
; read (E-0110)
ClearAttributesAndScreenBuffer_Bank31::
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $1412

.loop:
    push bc
    push hl

.loop2:
    xor a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ld a, $00
    ldh [rVBK], a

.skip:
    ld hl, wScreenTileBuffer
    ld bc, $0240

.loop3:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop3
    ret

; Fills the $160 bytes at wScreenTileBuffer + $E0 with $C3; clobbers A, BC, HL (the same 15 bytes
; appear in 2 banks)
FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld hl, wScreenTileBuffer + $e0
    ld bc, $0160

.loop:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

GameMode4_Init_CopyGlyphTilesToVRAM::
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $f0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5a0
    call CopyGlyphTilesToVRAM
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, .loop
    ld c, $03

.loop:
    push bc
    ld a, c
    ld bc, $004e
    call Multiply8By16
    ld a, l
    add $d5
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld de, wNameGlyphBuf
    ld b, $0a

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    pop bc
    push bc
    ld b, $00
    ld hl, $72a0
    add hl, bc
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret
    db $00, $8d, $50, $8d, $a0, $8d, $00, $8d, $50, $8d, $a0, $8d

; picks record wBattlePartyCount - 1 from PartyCountRects and copies it into wScreenTileBuffer
; (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31) (E-0078)
CopyRectRecordForBattlePartyCount_Bank31::
    ld a, [wBattlePartyCount]
    dec a
    ld hl, PartyCountRects
    add a
    add_a_to_hl
    deref_hl
    call ReadScreenBufferRectHeader_Bank31
    call CopyRectToStride32_Bank31
    ret

; CopyRectRecordForBattlePartyCount_Bank31 reads word wBattlePartyCount - 1 of $72C3 and copies that
; record into wScreenTileBuffer (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31);
; three records, for 1-3 party monsters (E-0221, C1)
; record: rectangle record for this party count
PartyCountRects::
    dw TileRect_PartyCountRects_1 ; id 1
    dw TileRect_PartyCountRects_2 ; id 2
    dw TileRect_PartyCountRects_3 ; id 3

; FillWC278WithC3_Bank31, then falls into LayoutTileBlocksForBattleFoeCount (E-0071)
ClearAndLayoutTileBlocksForBattleFoeCount::
    call FillScreenTileBufferRow11Col4WithC3_Bank31

; wBattleFoeCount = count 1-3: writes that many 6 x 6 blocks of consecutive tile numbers, starting
; at $14 ($24 per block), into the 32-byte-wide buffer at wScreenTileBuffer + $E0 (row 0); left
; columns are 7 for one block, 4 and 10 for two, 1, 7 and 13 for three (centred in a 20-column
; view). Clobbers A, BC, D, HL (E-0060)
LayoutTileBlocksForBattleFoeCount::
    ld d, $14
    ld a, [wBattleFoeCount]
    dec a
    ld hl, LayoutTileBlocksForBattleFoeCount_Data1
    add a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_DerefHL
    ld a, [wBattleFoeCount]
    cp $01
    jr z, LayoutTileBlocksForBattleFoeCount_DerefHL_Return
    dec a
    dec a
    ld hl, LayoutTileBlocksForBattleFoeCount_Data2
    add a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_DerefHL
    ld a, [wBattleFoeCount]
    cp $03
    jr nz, LayoutTileBlocksForBattleFoeCount_DerefHL_Return
    ld hl, wScreenTileBuffer + $ed
    jr LayoutTileBlocksForBattleFoeCount_DerefHL_Skip

; HL = the word at HL (deref_hl), falling into the next code
LayoutTileBlocksForBattleFoeCount_DerefHL::
    deref_hl

LayoutTileBlocksForBattleFoeCount_DerefHL_Skip::
    ld bc, $0606

.loop:
    push bc
    push hl

.loop2:
    ld a, d
    inc d
    ld [hli], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop

LayoutTileBlocksForBattleFoeCount_DerefHL_Return::
    ret

LayoutTileBlocksForBattleFoeCount_Data1::
    db $7f, $c2, $7c, $c2, $79, $c2

LayoutTileBlocksForBattleFoeCount_Data2::
    db $82, $c2, $7f, $c2

; on CGB loads the picture attribute blocks for one, two or three battle monsters
; (wBattlePictureIds, or wBattleMonsterId when bit 1 of wLinkRole is set) at vBGMap0 + $E1-$ED
; (E-0125)
LoadBattleMonsterPictureAttributes::
    ld a, [wIsCGB]
    or a
    ret z
    ld a, [wLinkRole]
    bit 1, a
    ld de, wBattlePictureIds
    jr z, .check_battle_foe_count
    ld de, wBattleMonsterId

.check_battle_foe_count:
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .call_load_monster_picture_attributes_from_de
    cp $02
    jr z, .call_load_monster_picture_attributes_from_de2
    jr .call_load_monster_picture_attributes_from_de3

.call_load_monster_picture_attributes_from_de:
    ld c, $01
    ld hl, vBGMap0 + $e7
    call LoadMonsterPictureAttributesFromDE
    ret

.call_load_monster_picture_attributes_from_de2:
    ld c, $01
    ld hl, vBGMap0 + $e4
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $ea
    call LoadMonsterPictureAttributesFromDE
    ret

.call_load_monster_picture_attributes_from_de3:
    ld c, $01
    ld hl, vBGMap0 + $e1
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $e7
    call LoadMonsterPictureAttributesFromDE
    ld c, $05
    inc de
    inc de
    ld hl, vBGMap0 + $ed
    call LoadMonsterPictureAttributesFromDE
    ret

; hTemp0 = C (palette number), DE = the monster id word stored at [DE], then
; LoadMonsterPictureAttributes (HL = BG map address from the caller); DE kept (E-0110)
LoadMonsterPictureAttributesFromDE::
    push de
    ld a, c
    ldh [hTemp0], a
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call LoadMonsterPictureAttributes
    pop de
    ret

; draws the HP, MP and status of the first one, two or three slots (by wBattlePartyCount) (E-0122)
DrawPartySlotStatusPanels::
    call DrawSlotPanelStats0
    ld a, [wBattlePartyCount]
    cp $01
    ret z
    call DrawSlotPanelStats1
    ld a, [wBattlePartyCount]
    cp $02
    ret z
    call DrawSlotPanelStats2
    ret

; draws HP, MP and status marks of slot 0 (slot 4 when wLinkMode is 1 and bit 1 of wLinkRole is set)
; (E-0122)
DrawSlotPanelStats0::
    ld c, $00
    ld a, [wLinkMode]
    or a
    jr z, .call_draw_slot_hp_digits
    cp $02
    jr z, .call_draw_slot_hp_digits
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_draw_slot_hp_digits
    ld c, $04

.call_draw_slot_hp_digits:
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; draws HP, MP and status marks of slot 1 (slot 5 when wLinkMode is 1 and bit 1 of wLinkRole is set)
; (E-0122)
DrawSlotPanelStats1::
    ld c, $01
    ld a, [wLinkMode]
    or a
    jr z, .call_draw_slot_hp_digits
    cp $02
    jr z, .call_draw_slot_hp_digits
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_draw_slot_hp_digits
    ld c, $05

.call_draw_slot_hp_digits:
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; draws HP, MP and status marks of slot 2 (slot 6 when wLinkMode is 1 and bit 1 of wLinkRole is set)
; (E-0122)
DrawSlotPanelStats2::
    ld c, $02
    ld a, [wLinkMode]
    or a
    jr z, .call_draw_slot_hp_digits
    cp $02
    jr z, .call_draw_slot_hp_digits
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_draw_slot_hp_digits
    ld c, $06

.call_draw_slot_hp_digits:
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; copies the panels of the first one, two or three slots (by wBattlePartyCount) to VRAM (E-0122)
CopyPartySlotPanelsToVRAM::
    call CopySlotPanel0ToVRAM
    ld a, [wBattlePartyCount]
    cp $01
    ret z
    call CopySlotPanel1ToVRAM
    ld a, [wBattlePartyCount]
    cp $02
    ret z
    call CopySlotPanel2ToVRAM
    ret

; builds and copies the panel row of slot 0 (slot 4 when wLinkMode is 1 and bit 1 of wLinkRole is
; set) (E-0122)
CopySlotPanel0ToVRAM::
    ld c, $00
    ld a, [wLinkMode]
    or a
    jr z, .call_copy_slot_panel_part_to_vram
    cp $02
    jr z, .call_copy_slot_panel_part_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_panel_part_to_vram
    ld c, $04

.call_copy_slot_panel_part_to_vram:
    call CopySlotPanelPartToVRAM
    call CopySlotPanelPartToVRAM_2
    call CopySlotPanelRowToVRAM
    ret

; builds and copies the panel row of slot 1 (slot 5 when wLinkMode is 1 and bit 1 of wLinkRole is
; set) (E-0122)
CopySlotPanel1ToVRAM::
    ld c, $01
    ld a, [wLinkMode]
    or a
    jr z, .call_copy_slot_panel_part_to_vram
    cp $02
    jr z, .call_copy_slot_panel_part_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_panel_part_to_vram
    ld c, $05

.call_copy_slot_panel_part_to_vram:
    call CopySlotPanelPartToVRAM
    call CopySlotPanelPartToVRAM_2
    call CopySlotPanelRowToVRAM
    ret

; builds and copies the panel row of slot 2 (slot 6 when wLinkMode is 1 and bit 1 of wLinkRole is
; set) (E-0122)
CopySlotPanel2ToVRAM::
    ld c, $02
    ld a, [wLinkMode]
    or a
    jr z, .call_copy_slot_panel_part_to_vram
    cp $02
    jr z, .call_copy_slot_panel_part_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_panel_part_to_vram
    ld c, $06

.call_copy_slot_panel_part_to_vram:
    call CopySlotPanelPartToVRAM
    call CopySlotPanelPartToVRAM_2
    call CopySlotPanelRowToVRAM
    ret

; FillTilesFromRequest, then far-calls CopyRectRecord7345ToScreenBuffer (E-0119) (E-0344: the
; address in its name dropped or read as the label there; was ClearWindowAndCopyRect7345Far)
ClearWindowAndCopyRectFar::
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ret

; copies a 20 x 5 rectangle from wWindowTileBuffer + $38 (rows 32 bytes apart) to vBGMap0 + $1A0
; (row 13) with CopyRect32StrideToVRAM (E-0073) (E-0340: the address in its name read as its RAM
; name; was DrawWC338RowsToBGMapRow13)
DrawWindowTileBufferRow2Col16RowsToBGMapRow13::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $14, $05
    call CopyRect32StrideToVRAM
    ret

RunBattleSetup_FleeCommand_CopyRectRecordToScreenBuffer_2::
    farcall CopyRectRecordToScreenBuffer_2

RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $0e, $05
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord73F7ToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was CopyRectRecord73F7ToScreenBufferFar)
CopyRectRecordToScreenBufferFar::
    farcall CopyRectRecordToScreenBuffer_3
    ret

; copies a 12 x 11 rectangle from wScreenTileBuffer + $E0 (rows 32 bytes apart) to vBGMap0 + $E0
; (row 7) with CopyRect32StrideToVRAM (E-0110) (E-0340: the address in its name read as its RAM
; name; was DrawWC278Rect12x11ToBGMapRow7)
DrawScreenTileBufferRow11Col4Rect12x11ToBGMapRow7::
    ld de, wScreenTileBuffer + $e0
    ld hl, vBGMap0 + $e0
    lb bc, $0c, $0b
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord755FToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was CopyRectRecord755FToScreenBufferFar)
CopyRectRecordToScreenBufferFar_2::
    farcall CopyRectRecordToScreenBuffer_5
    ret

; copies an 8 x 9 rectangle from wScreenTileBuffer + $120 (rows 32 bytes apart) to vBGMap0 + $120
; (row 9, column 0) with CopyRect32StrideToVRAM (identical to DrawWC2B8LeftToBGMapRow9 at $74E1)
; (E-0078) (E-0340: the address in its name read as its RAM name; was DrawWC2B8LeftToBGMapRow9_74B4)
; (E-0344: the address in its name dropped or read as the label there; was
; DrawScreenTileBufferRow14Col8LeftToBGMapRow9_74B4)
DrawScreenTileBufferRow14Col8LeftToBGMapRow9_2::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $08, $09
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord7600ToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was CopyRectRecord7600ToScreenBufferFar)
CopyRectRecordToScreenBufferFar_3::
    farcall CopyRectRecordToScreenBuffer_7
    ret

; copies a 20 x 9 rectangle from wScreenTileBuffer + $120 (rows 32 bytes apart) to vBGMap0 + $120
; (row 9) with CopyRect32StrideToVRAM, then wBattleArg0 = 1 (E-0077) (E-0340: the address in its
; name read as its RAM name; was DrawWC2B8RowsToBGMapRow9)
DrawScreenTileBufferRow14Col8RowsToBGMapRow9::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wBattleArg0], a
    ret

; far-calls CopyRectRecord76ACToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was CopyRectRecord76ACToScreenBufferFar)
CopyRectRecordToScreenBufferFar_4::
    farcall CopyRectRecordToScreenBuffer_8
    ret

; copies an 8 x 9 rectangle from wScreenTileBuffer + $120 (rows 32 bytes apart) to vBGMap0 + $120
; (row 9, column 0) with CopyRect32StrideToVRAM (E-0078) (E-0340: the address in its name read as
; its RAM name; was DrawWC2B8LeftToBGMapRow9)
DrawScreenTileBufferRow14Col8LeftToBGMapRow9::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $08, $09
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord76F8ToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was CopyRectRecord76F8ToScreenBufferFar)
CopyRectRecordToScreenBufferFar_5::
    farcall CopyRectRecordToScreenBuffer_9
    ret

; copies an 8 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (row 11) with
; CopyRect32StrideToVRAM (E-0115) (E-0340: the address in its name read as its RAM name; was
; DrawWC2F8Rect8x7ToBGMapRow11)
DrawScreenTileBufferRow17Col12Rect8x7ToBGMapRow11::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $08, $07
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecords7600And7734ToScreenBuffer in bank $1A (E-0115) (E-0344: the address in
; its name dropped or read as the label there; was CopyRectRecords7600And7734ToScreenBufferFar)
CopyRectRecordsAndToScreenBufferFar::
    farcall CopyRectRecordsAndToScreenBuffer
    ret

; copies a 7 x 1 rectangle from wScreenTileBuffer + $10C to vBGMap0 + $10C (row 8, column 12) and a
; 20 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9), both with
; CopyRect32StrideToVRAM (E-0110) (E-0340: the address in its name read as its RAM name; was
; DrawWC2A4AndWC2B8Rects)
DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects::
    ld de, wScreenTileBuffer + $10c
    ld hl, vBGMap0 + $10c
    lb bc, $07, $01
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord7750ToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was CopyRectRecord7750ToScreenBufferFar)
CopyRectRecordToScreenBufferFar_6::
    farcall CopyRectRecordToScreenBuffer_10
    ret

; copies a 14 x 7 rectangle from wScreenTileBuffer + $160 (rows 32 bytes apart) to vBGMap0 + $160
; (row 11) with CopyRect32StrideToVRAM (E-0078) (E-0340: the address in its name read as its RAM
; name; was DrawWC2F8RectToBGMapRow11)
DrawScreenTileBufferRow17Col12RectToBGMapRow11::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $0e, $07
    call CopyRect32StrideToVRAM
    ret

; copies a 20 x 11 rectangle from wScreenTileBuffer + $E0 (rows 32 bytes apart) to vBGMap0 + $E0
; (row 7), falling into CopyRect32StrideToVRAM (E-0075) (E-0340: the address in its name read as its
; RAM name; was DrawWC278RowsToBGMapRow7)
DrawScreenTileBufferRow11Col4RowsToBGMapRow7::
    ld de, wScreenTileBuffer + $e0
    ld hl, vBGMap0 + $e0
    ld bc, $140b

; B = width, C = rows, DE = source with 32-byte rows, HL = VRAM address with 32-byte rows: copies a
; B x C rectangle with WriteVRAMByteInc. DE ends 32 * C past its start and HL at the start of the
; row below; B kept, C = 0 (E-0060)
CopyRect32StrideToVRAM::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
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
    jr nz, CopyRect32StrideToVRAM
    ret

; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B
; = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
ReadScreenBufferRectHeader_Bank31::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de
    ret

; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies
; a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0
; (E-0065) (the same 18 bytes appear in 2 banks)
CopyRectToStride32_Bank31::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_Bank31
    ret

; a rectangle record of PartyCountRects (offset, width, rows, tiles) (E-0221, C1)
; record: offset $0000; 8 x 7 tiles
TileRect_PartyCountRects_1::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0000; 14 x 7 tiles
TileRect_PartyCountRects_2::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0e, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $c3, $ea, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0000; 20 x 7 tiles
TileRect_PartyCountRects_3::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $da, $db, $dc, $dd, $de, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $c3, $ea, $af, $c3, $c3, $c3, $c3, $ea, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: draws the slot's status markers from its status bytes (the per-status part is
; not read to its end) (E-0111)
DrawSlotStatusMarks::
    ld a, [wLinkMode]
    cp $02
    jr nz, .check_link_mode
    farcall DrawSlotStatusMarks_BankA0
    ret

.check_link_mode:
    push bc
    ld a, [wLinkMode]
    or a
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .done
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .done

.skip2:
    and $03
    cp $03
    jr z, .done
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_draw_slot_status_marks_draw_slot_level2
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a
    jr z, .call_draw_slot_status_marks_draw_slot_level
    call DrawSlotStatusMarks_ReadWordTableEntryForSlotC
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_3
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_4
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_6
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_2
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_7
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_5
    jr .done

.call_draw_slot_status_marks_draw_slot_level:
    call DrawSlotStatusMarks_DrawSlotLevel_BankA0
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_Data
    add a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $c3
    jr .done

.call_draw_slot_status_marks_draw_slot_level2:
    call DrawSlotStatusMarks_DrawSlotLevel_BankA0
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_Data
    add a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $c2

.done:
    pop bc
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC::
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data
    call ReadWordTableEntryForSlotC
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_2::
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $c0
    pop hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_3::
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_3
    call ReadWordTableEntryForSlotC
    ld [hl], $c1
    pop hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_4::
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_3
    call ReadWordTableEntryForSlotC
    ld [hl], $c7
    pop hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_5::
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_4
    call ReadWordTableEntryForSlotC
    ld [hl], $c8
    pop hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_6::
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_2
    call ReadWordTableEntryForSlotC
    ld [hl], $c9
    pop hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_7::
    push hl
    ld hl, DrawSlotStatusMarks_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $ca
    pop hl
    ret

; HL = table: HL = the word at HL + 2 * (C & 3) (falls into DerefHL_Bank31) (E-0110)
ReadWordTableEntryForSlotC::
    ld a, c
    and $03
    add a
    add l
    ld l, a
    jr nc, DerefHL_Bank31
    inc h

; HL = the word at HL; A = its low byte (E-0110)
DerefHL_Bank31::
    deref_hl
    ret

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data::
    db $39, $c2, $3f, $c2, $45, $c2

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_2::
    db $3a, $c2, $40, $c2, $46, $c2

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_3::
    db $3b, $c2, $41, $c2, $47, $c2

DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data_4::
    db $3c, $c2, $42, $c2, $48, $c2

DrawSlotStatusMarks_Data::
    db $3d, $c2, $43, $c2, $49, $c2

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: copies the slot's 5-tile panel row from wScreenTileBuffer to the same position
; of vBGMap0 (offset from SlotPanelRowOffsets, WriteVRAMByteInc) (E-0111)
CopySlotPanelRowToVRAM::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotPanelRowToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, SlotPanelRowOffsets
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld b, $05

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop

.return:
    ret

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: writes the slot's HP (wBattleHP) as decimal digit tiles (HLToDecimalDigits)
; into wScreenTileBuffer at the position from DrawSlotHPDigits_Data (E-0111)
DrawSlotHPDigits::
    ld a, [wLinkMode]
    cp $02
    jr nz, .skip
    farcall DrawSlotHPDigits_BankA0
    ret

.skip:
    push bc
    or a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp $04
    jr nc, .done

.skip3:
    and $03
    cp $03
    jr z, .done
    ld a, c
    ld hl, wBattleHP
    add a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and $03
    push hl
    ld hl, DrawSlotHPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

.done:
    pop bc
    ret

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: writes the slot's MP (wBattleMP) as decimal digit tiles into wScreenTileBuffer
; at the slot's position (E-0111)
DrawSlotMPDigits::
    ld a, [wLinkMode]
    cp $02
    jr nz, .skip
    farcall DrawSlotMPDigits_BankA0
    ret

.skip:
    push bc
    or a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp $04
    jr nc, .done

.skip3:
    and $03
    cp $03
    jr z, .done
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and $03
    push hl
    ld hl, DrawSlotMPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

.done:
    pop bc
    ret

DrawSlotStatusMarks_DrawSlotLevel_BankA0::
    ld a, [wLinkMode]
    cp $02
    jr nz, .skip
    farcall DrawSlotLevel_BankA0
    ret

.skip:
    push bc
    or a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp $04
    jr nc, .done

.skip3:
    and $03
    cp $03
    jr z, .done
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $ea
    inc hl
    ld [hl], $af
    inc hl
    push hl
    ld a, c
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    pop de
    call WriteTwoDigitTilesFromDigits1

.done:
    pop bc
    ret

; copies three tiles at offset DrawSlotHPDigits_Data[slot] from the screen buffer to vBGMap0 for the
; shown side (CopySlotPanelPart6D47ToVRAM in mode 2) (E-0125) (E-0344: the address in its name
; dropped or read as the label there; was CopySlotPanelPart7AC8ToVRAM)
CopySlotPanelPartToVRAM::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotHPDigitsPanelToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotHPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; copies three tiles at offset DrawSlotMPDigits_Data[slot] from the screen buffer to vBGMap0 for the
; shown side (CopySlotPanelPart6D4BToVRAM in mode 2) (E-0125) (E-0344: the address in its name
; dropped or read as the label there; was CopySlotPanelPart7ACEToVRAM)
CopySlotPanelPartToVRAM_2::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotMPDigitsPanelToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotMPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; copies two tiles at offset DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data[slot] from the screen
; buffer to vBGMap0 for the shown side (CopySlotPanelPart6D4FToVRAM in mode 2) (E-0125) (E-0344: the
; address in its name dropped or read as the label there; was CopySlotPanelPart7AD4ToVRAM)
CopySlotPanelPartToVRAM_3::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotLevelPanelToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes
; appear in 3 banks)
ShowStringBank09AtTilesHL_Bank31::
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

; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes
; appear in 2 banks)
ShowStringBank08AtTilesHL_Bank31::
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
    farcall ShowString_Bank08
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

; the same 80 bytes as UnreferencedShowFiveGlyphsAtTilesHL_BankA0; no caller found (E-0238)
UnreferencedShowFiveGlyphsAtTilesHL_Bank31:: ; configured code entry (E-0238); C0
    push hl
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    pop hl
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
    ld de, $0501
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
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

DrawSlotHPDigits_Data::
    db $62, $00, $68, $00, $6e, $00

DrawSlotMPDigits_Data::
    db $82, $00, $88, $00, $8e, $00

DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data::
    db $a1, $00, $a7, $00, $ad, $00

; CopySlotPanelRowToVRAM reads the word at $7ADA + 2 * (slot & 3) and copies 5 tiles from
; wScreenTileBuffer + offset to the same offset of vBGMap0; three words for slots 0-2 (E-0212, C1)
; record: offset of the slot's panel row in the screen buffer / BG map
SlotPanelRowOffsets::
    dw $00a1 ; id 0
    dw $00a7 ; id 1
    dw $00ad ; id 2

; the same 55 bytes as GetBattleATK_Bank39 (GetBattleATK_Bank39)
GetBattleATK_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleATK
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 50 bytes as GetBattleDEF_Bank39 (GetBattleDEF_Bank39)
GetBattleDEF_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleDEF
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 45 bytes as GetBattleMaxHP_Bank39 (GetBattleMaxHP_Bank39)
GetBattleMaxHP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleMaxHP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 40 bytes as GetBattleMaxMP_Bank39 (GetBattleMaxMP_Bank39)
GetBattleMaxMP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleMaxMP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 35 bytes as GetBattleHP_Bank39 (GetBattleHP_Bank39)
GetBattleHP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleHP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 30 bytes as GetBattleMP_Bank39 (GetBattleMP_Bank39)
GetBattleMP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleMP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 25 bytes as GetBattleAGL_Bank39 (GetBattleAGL_Bank39)
GetBattleAGL_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleAGL
    jr ReadSlotAIModeIndexed_Bank31_Skip

; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 5 banks)
ReadSlotAIModeIndexed_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

ReadSlotAIModeIndexed_Bank31_Skip::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank31::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank31::
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
TargetOnLocalSide_Bank31::
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

; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank31[D] (AddAx9ToHL); not reached from traced code
; (E-0212)
ClearBattleStatusBitsWithMaskD_Bank31:: ; configured code entry (E-0212); C0
    ld a, d
    ld hl, ClearBitMaskTable_Bank31
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

; the copy in bank $31 of ClearBitMaskTable (E-0205), read by the routine at $7B54; the block
; $7B54-$7BEE has the same bytes as $4075-$410F in banks $05, $A1 and $A3, apart from the table
; address (E-0212, C1)
; record: AND mask
ClearBitMaskTable_Bank31::
    db $df ; id 0
    db $fe ; id 1
    db $00 ; id 2
    db $fd ; id 3
    db $73 ; id 4
    db $ef ; id 5
    db $bf ; id 6

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
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
PersonalityIndexOfSlot_Bank31:: ; configured code entry (E-0212); C0
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
CheckSlotStatusBlockWide_Bank31::
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
SlotHasStatus3Or4Bits_Bank31::
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

; LZSS-compressed: 477 bytes that expand to 704 (E-0016, E-0017)
Tiles1Plus240Gfx::
    INCBIN "gfx/misc/tiles1_plus240_gfx.lz"

; LZSS-compressed: 151 bytes that expand to 224 (E-0016, E-0017)
Tiles1Plus5F0Gfx::
    INCBIN "gfx/misc/tiles1_plus5_f0_gfx.lz"
    ds $16e, $00
