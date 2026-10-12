SECTION "Bank 31", ROMX[$4000], BANK[$31]
    db $31

; start-up for wGameMode = 4, the battle: starts music 2, clears the BG map and builds the battle screen; reached from the debug battle setup (Start) and from encounters (E-0042)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode4_Init)
; reads: wSGBActive, wIsCGB
; writes: wSGBPaletteSet, wSGBAttrFile, hScrollX, hScrollXHi, hScrollY, hScrollYHi, rVBK, wTextCursorLo, ...
GameMode4_Init::
Func_031_4001:: ; address name
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a, a
    jr z, .clear_scroll_x
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

.clear_scroll_x:
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $C3
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, .set_text_cursor_lo
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a, a
    call FillBytes
    xor a, a
    ldh [rVBK], a

.set_text_cursor_lo:
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    farcall GameMode4_Init_FillBytes
    ld b, $31
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $FC
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0B
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 4, the battle: in link mode (wC58A) it serves the serial link, otherwise IncrementPlayTime_Bank31 and the phase machine Func_031_40CC (wCFC8 = phase (1 fight, 2 after), wCFC9 = step)
; 1 call site from 1 routine (e.g. RunGameModeUpdate_ToGameMode4_Update)
; reads: wLinkMode, wEffectId, wEffectAnimState, wBattlePhase
GameMode4_Update::
Func_031_40A5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .call_increment_play_time_bank31
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp a, $FF
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp a, $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

.call_increment_play_time_bank31:
    call IncrementPlayTime_Bank31

; runs BattlePhase0, BattlePhaseFight or BattlePhaseEnd for wBattlePhase (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession1Exchange_LinkReceiveStepWithBuffer)
; reads: wBattlePhase
RunBattlePhase::
Func_031_40CC:: ; address name
    ld a, [wBattlePhase]
    rst $00
    dw BattlePhase0
    dw BattlePhaseFight
    dw BattlePhaseEnd

; wBattlePhase = 0: the start of the battle (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
BattlePhase0::
Jump_031_40D6:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw BattlePhase0_Step0
    dw BattlePhase0_Step1
    dw BattlePhase0_Step2
    dw BattlePhase0_Step3
    dw BattlePhase0_Step4

; wBattlePhase 0, wBattleStep 0 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wBattleStep
BattlePhase0_Step0::
Jump_031_40E4:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 0, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wBattleArg0, wArg1
; points at: wBattleStep
BattlePhase0_Step1::
Jump_031_40EE:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleArg0], a
    ld a, [wLinkMode]
    and a, a
    ret z
    xor a, a
    ld [wArg1], a
    ret

; wBattlePhase 0, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wArg1, wBattlePictureIds, wBattleFoeCount
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wTextBuf1, wTextBuf2, wBattleStep
BattlePhase0_Step2::
Jump_031_4106:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_ReadBattlePictureIds
    ld a, [wArg1]
    rst $00
    dw BattlePhase0_Step2_SetArg1
    dw BattlePhase0_Step2_WaitLinkMessage
    dw BattlePhase0_Step2_WriteArg1AndLinkTimeoutLoEtc
    dw BattlePhase0_Step2_CopyFiveGlyphsPlusMarks

; entry 0 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1
; writes: wArg1, wLinkSendByte
BattlePhase0_Step2_SetArg1::
Jump_031_4119:: ; address name
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld a, $D2
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wArg1
; writes: wLinkSendByte, wArg1
BattlePhase0_Step2_WaitLinkMessage::
Jump_031_4126:: ; address name
    ld a, [wLinkMessage]
    cp a, $D2
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ret

; entry 2 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1
; writes: wArg1, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wPlayerName, wBattleByte58
BattlePhase0_Step2_WriteArg1AndLinkTimeoutLoEtc::
Jump_031_4138:: ; address name
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld hl, wPlayerName
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $000A
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wBattleByte58
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 3 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkReady, wArg1, wBattleByte62, wStringIndex, wStringCategory
; points at: wBattleByte58, wTextBuf0, wBattleStep
BattlePhase0_Step2_CopyFiveGlyphsPlusMarks::
Jump_031_416B:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    xor a, a
    ld [wArg1], a
    ld a, $F0
    ld [wBattleByte62], a
    ld de, wBattleByte58
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    jp BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_ReadBattlePictureIds::
Jump_031_418E:: ; address name
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
    cp a, $01
    call nz, CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    ld h, a
    ld de, wTextBuf2
    ld a, [wBattleFoeCount]
    cp a, $03
    call z, CopyMonsterNameToDE_Bank31
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .skip
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattlePictureIds + $2]
    cp a, e
    jr nz, .check_battle_foe_count
    ld a, [wBattlePictureIds + $3]
    cp a, d
    jr nz, .check_battle_foe_count
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip
    ld a, [wBattlePictureIds + $4]
    cp a, e
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip2
    ld a, [wBattlePictureIds + $5]
    cp a, d
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip2
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip

.check_battle_foe_count:
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip3
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld a, [wBattlePictureIds + $4]
    cp a, e
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip4
    ld a, [wBattlePictureIds + $5]
    cp a, d
    jr nz, BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip4
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip5

.skip:
    ld a, $00
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip::
Jump_031_4213:: ; address name
    ld hl, wTextBuf0
    ld a, $01
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip2::
Jump_031_421A:: ; address name
    ld a, $02
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip3::
Jump_031_421E:: ; address name
    ld a, $03
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip4::
Jump_031_4222:: ; address name
    ld a, $04
    jr BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_Skip5::
Jump_031_4226:: ; address name
    ld a, $05

BattlePhase0_Step2_CopyFiveGlyphsPlusMarks_SetStringIndex::
Jump_031_4228:: ; address name
    ld [wStringIndex], a ; 'Monsters appear!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; HL = monster id: H += 2 (string categories 2 and 3 hold the monster names), then CopyStringHLToDE (E-0115)
; 3 call sites from 1 routine (e.g. BattlePhase0_Step2_CopyFiveGlyphsPlusMarks)
CopyMonsterNameToDE_Bank31::
Func_031_423B:: ; address name
    ld a, h
    add a, $02
    ld h, a
    call CopyStringHLToDE
    ret

; wBattlePhase 0, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMode, wBattleKind, wRandomLo, wRandomHi
; writes: wBattleStep, wBattleSubPhase, wStringIndex, wBattleArg0, wStringCategory, wBattleTurn
; points at: wBattlePhase, wSlotMarks
BattlePhase0_Step3::
Jump_031_4243:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a, a
    jp nz, .set_battle_turn_to_01
    ld a, [wBattleKind]
    cp a, $02
    jp nc, .set_battle_turn_to_01
    call NextTableByte
    ld a, [wRandomLo]
    cp a, $08
    jr nc, .call_next_table_byte
    ld a, [wRandomHi]
    and a, $01
    add a, $0B
    ld [wStringIndex], a
    ld a, $00
    ld [wBattleArg0], a
    ld c, $04
    jr .skip

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    cp a, $08
    jr nc, .set_battle_turn_to_01
    ld a, [wRandomLo]
    and a, $01
    add a, $0D
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
    ld [hl], $FF

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

; only called from BattlePhase0_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattlePhase0_Step3)
; reads: wBattlePictureIds, wBattleFoeCount, wStringIndex
; points at: wTextBuf0
BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc::
Func_031_42D5:: ; address name
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .call_battle_phase0_step3_sub01_copy_string_hl
    ld a, [wBattlePictureIds + $2]
    cp a, e
    jr nz, .skip2
    ld a, [wBattlePictureIds + $3]
    cp a, d
    jr nz, .skip2
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, .skip
    ld a, [wBattlePictureIds + $4]
    cp a, e
    jr nz, .skip2
    ld a, [wBattlePictureIds + $5]
    cp a, d
    jr nz, .skip2
    jr .skip

.call_battle_phase0_step3_sub01_copy_string_hl:
    call BattlePhase0_Step3_Sub01_CopyStringHLToDE
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
    ld [hl], $F0
    jr .return

.skip2:
    ld hl, wTextBuf0
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_438E
    ld b, $09
    ld a, [wStringIndex]
    cp a, $0B
    jr nz, .cp_0C
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_4397
    ld b, $09
    jr .loop

.cp_0C:
    cp a, $0C
    jr nz, .cp_0D
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_4397
    ld b, $0D
    jr .loop

.cp_0D:
    cp a, $0D
    jr nz, .cp_0E
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_4397
    ld b, $0D
    jr .loop

.cp_0E:
    cp a, $0E
    jr nz, .loop
    ld b, $09
    ld de, BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_4397

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop

.return:
    ret

; only called from BattlePhase0_Step3_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc)
; reads: wStringCategory, wStringIndex
; writes: wStringCategory, wStringIndex
; points at: wTextBuf0
BattlePhase0_Step3_Sub01_CopyStringHLToDE::
Func_031_4365:: ; address name
    ld a, [wStringCategory]
    ld l, a
    ld a, [wStringIndex]
    ld h, a
    push hl
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld hl, wTextBuf0

.skip:
    ld a, [hl]
    cp a, $F0
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

; address loaded by BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc
BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_438E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_438E:: ; address name
    db $30, $32, $31, $36, $37, $28, $35, $36, $F0

; address loaded by BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc
BattlePhase0_Step3_ReadBattlePictureIdsAndBattleFoeCountEtc_Data_4397:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_4397:: ; address name
    db $16, $32, $31, $36, $37, $28, $35, $36, $F0

; wBattlePhase 0, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0
; writes: wBattleStep
; points at: wBattlePhase
BattlePhase0_Step4::
Jump_031_43A0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    ld a, [wBattleArg0]
    or a, a
    ret

; wBattlePhase = 1: the fight; steps: 1 set-up, 2 command entry, 3 executing the actions (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
BattlePhaseFight::
Jump_031_43B2:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw BattleFight_Step0
    dw BattleFight_Step1
    dw BattleFight_Step2
    dw BattleFight_Step3
    dw BattleFight_Step4

; wBattlePhase 1, wBattleStep 0 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleStep
BattleFight_Step0::
Jump_031_43C0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call BattleFight_Step0_FillBytes
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 1, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step1::
Jump_031_43CD:: ; address name
    call RunBattleSetup
    ret

; wBattlePhase 1, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step2::
Jump_031_43D1:: ; address name
    farcall RunBattleCommandEntry
    ret

; wBattlePhase 1, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step3::
Jump_031_43D8:: ; address name
    farcall RunBattleActions
    ret

; wBattlePhase 1, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step4::
Jump_031_43DF:: ; address name
    farcall RunBattleStep4
    ret

; wBattlePhase = 2: after the fight; steps 0-9 (result message, rewards, recruiting) (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
BattlePhaseEnd::
Jump_031_43E6:: ; address name
    ld a, [wBattleStep]
    rst $00
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
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStep
BattleEnd_Step0::
Jump_031_43FE:: ; address name
    ld a, $02
    call QueueMusic
    call ClearWindowAndCopyRect7345Far
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wLinkMode, wBattleArg0
; writes: wBattleKindFlags, wStringIndex, wStringCategory
; points at: wBattleStep
BattleEnd_Step1::
Jump_031_440E:: ; address name
    ld a, $01
    ld [wBattleKindFlags], a
    call BattleEnd_Step1_WriteDataBankAndDataBankSaveEtc
    ld a, [wBattleScene]
    and a, $01
    jr z, .call_battle_end_step1_write_battle_arg0
    ld a, $06
    jr .set_string_index

.call_battle_end_step1_write_battle_arg0:
    call BattleEnd_Step1_WriteBattleArg0
    ld a, [wBattleScene]
    cp a, $02
    jr z, .read_battle_arg0
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_arg0
    ld a, $87
    jr .set_string_index

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp a, $01
    ld a, $07
    jr nc, .set_string_index
    ld a, $86
    jr .set_string_index

.read_battle_arg0:
    ld a, [wBattleArg0]
    add a, $08

.set_string_index:
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots, wTextFlags
; writes: wBattleSubPhase
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5, wBattleStep
BattleEnd_Step2::
Jump_031_445B:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, BattleEnd_Step2_WriteBattleEndTimer
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; only called from BattleEnd_Step2 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step2)
; reads: wBattleEndTimer
; writes: wBattleEndTimer
BattleEnd_Step2_WriteBattleEndTimer::
Func_031_4493:: ; address name
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleScene, wDisplaySlot
; writes: wBattleSubPhase
; points at: wBattleStep, wRecordBufA, wPlayerName
BattleEnd_Step3::
Jump_031_449C:: ; address name
    call BattleEnd_Step3_SRAMRecordAddressMapped
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a, a
    jr nz, .skip2
    ld a, [wBattleScene]
    or a, a
    jr z, .check_display_slot
    cp a, $03
    jr z, .skip
    cp a, $02
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
    cp a, $FF
    ret z
    sub a, $04
    ret c
    cp a, $03
    ret nc
    ld a, [wLinkMode]
    or a, a
    call z, BattleEnd_Step3_WriteBattleExpAward
    call BattleEnd_Step3_WaitBattleKind
    ld a, [wDisplaySlot]
    dec a
    ld c, $4E
    call Multiply8
    ld a, l
    add a, $D5
    ld e, a
    ld a, h
    adc a, $D0
    ld d, a
    ld hl, wRecordBufA
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $0E
    call CopyBBytesDEToHL_Bank31
    push de
    ld de, wPlayerName
    ld b, $0B
    call CopyBBytesDEToHL_Bank31
    pop de
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call BattleEnd_Step3_Sub04
    ld a, $FF
    ld [hl+], a
    call BattleEnd_Step3_Sub04
    ld a, $FF
    ld [hl+], a
    ld b, $08
    call BattleEnd_Step3_Sub03
    ld a, $FF
    ld b, $19

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld [hl+], a
    ld b, $15
    call CopyBBytesDEToHL_Bank31
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld b, $1F
    call CopyBBytesDEToHL_Bank31
    call BattleEnd_Step3_Sub04
    ld a, $00
    ld [hl+], a
    call BattleEnd_Step3_Sub04
    ld a, $00
    ld [hl+], a
    ld a, [de]
    ld [hl+], a
    farcall BattleEnd_Step3_LoadSpeciesRecord
    farcall BattleEnd_Step3_NextTableByte
    farcall LoadTable4E60EntryForWC991ToWC9DE
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
; 4 call sites from 1 routine (e.g. BattleEnd_Step3)
CopyBBytesDEToHL_Bank31::
Func_031_4566:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank31
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
BattleEnd_Step3_Sub03::
Func_031_456D:: ; address name
    push hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    push hl

.loop:
    ld a, [de]
    inc de
    cp a, $C8
    jr z, .next
    ld [hl+], a

.next:
    dec b
    jr nz, .loop
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3 (E-0047)
; 4 call sites from 1 routine (e.g. BattleEnd_Step3)
BattleEnd_Step3_Sub04::
Func_031_458E:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld b, $06

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wBattleFoeCount, wBattleExpAward
; writes: wBattleExpAward
; points at: wBattleSlotOut
BattleEnd_Step3_WriteBattleExpAward::
Func_031_45A3:: ; address name
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    xor a, a
    ld [wBattleExpAward], a
    ld [wBattleExpAward + $1], a
    ld [wBattleExpAward + $2], a

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr nz, .next
    ld a, c
    and a, $03
    ld hl, BattleEnd_Step3_WriteBattleExpAward_Data
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wBattleExpAward]
    add a, [hl]
    ld [wBattleExpAward], a
    inc hl
    ld a, [wBattleExpAward + $1]
    adc a, [hl]
    ld [wBattleExpAward + $1], a
    inc hl
    ld a, [wBattleExpAward + $2]
    adc a, [hl]
    ld [wBattleExpAward + $2], a

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; address loaded by BattleEnd_Step3_WriteBattleExpAward
BattleEnd_Step3_WriteBattleExpAward_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_45EC:: ; address name
    db $D7, $D1, $25, $D2, $73, $D2

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wBattleKind, wBattleFoeCount, wEncounterMonsters
; writes: hTemp0, hTemp1, wDisplaySlot, wScreenSavedFlag
; points at: wEncounterMonsters
BattleEnd_Step3_WaitBattleKind::
Func_031_45F2:: ; address name
    ld a, [wBattleKind]
    cp a, $02
    ret nz
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .set_temp0
    cp a, $02
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
    or a, a
    jr nz, .cp_01
    ld a, l
    cp a, $07
    jr z, .call_battle_end_step3_sub06_sub01_load
    cp a, $1A
    jr z, .call_battle_end_step3_sub06_sub01_load2
    jr .return

.call_battle_end_step3_sub06_sub01_load:
    ld hl, $0008
    call BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01
    jr .return

.call_battle_end_step3_sub06_sub01_load2:
    ld hl, $001B
    call BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01
    jr .return

.cp_01:
    cp a, $01
    jr nz, .return
    ld a, l
    cp a, $82
    jr z, .call_battle_end_step3_sub06_sub01_load3
    cp a, $AB
    jr z, .set_screen_saved_flag_to_02
    cp a, $90
    jr z, .call_battle_end_step3_sub06_sub01_load4
    jr .return

.call_battle_end_step3_sub06_sub01_load3:
    ld hl, $0183
    call BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01
    jr .return

.set_screen_saved_flag_to_02:
    ld a, $02
    ld [wScreenSavedFlag], a
    ld hl, $01AC
    call BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01
    jr .return

.call_battle_end_step3_sub06_sub01_load4:
    ld hl, $01AF
    call BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01
    jr .return

.return:
    ret

; only called from BattleEnd_Step3_Sub06 (E-0047)
; 5 call sites from 1 routine (e.g. BattleEnd_Step3_WaitBattleKind)
; reads: hTemp0, hTemp1
BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01::
Func_031_4681:: ; address name
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    farcall BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC
    ret

; wBattlePhase 2, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
BattleEnd_Step4::
Jump_031_4693:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, BattleEnd_Step4_WriteBattleEndTimer
    call BattleEnd_GainExperience
    ret

; only called from BattleEnd_Step4 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step4)
; reads: wBattleEndTimer
; writes: wBattleEndTimer
BattleEnd_Step4_WriteBattleEndTimer::
Func_031_46C1:: ; address name
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 5 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step5::
Jump_031_46CA:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc
    dw BattleEnd_Step5_Case01
    dw BattleEnd_Step5_SwapMonstersMenu
    dw BattleEnd_Step5_BuildAndDrawBattleScreen
    dw BattleEnd_Step5_LoadBattleMonsterPictureAndTitle

; entry 0 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wDisplaySlot, wSpeciesIdLo, wSpeciesIdHi
; writes: wBattleSubPhase, wBattlePictureIds, wBattleResolveStep, wBattleSubStep
; points at: wBattleStep, wBattleSubPhase
BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc::
Jump_031_46D8:: ; address name
    farcall BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc
    ld a, [wDisplaySlot]
    cp a, $FF
    jr nz, .read_species_id_lo
    ld hl, wBattleStep
    inc [hl]
    xor a, a
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
    call ClearWindowAndCopyRect7345Far
    ld a, $6C
    call QueueSoundEffect
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_Step5_Case01::
Jump_031_471C:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_Step5_Case01_CopyRect32StrideToVRAM
    dw BattleEnd_Step5_Case01_Case01

; entry 0 of the `rst $00` table in BattleEnd_Step5_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer, wBattleResolveStep
BattleEnd_Step5_Case01_CopyRect32StrideToVRAM::
Jump_031_4724:: ; address name
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM
    call LoadBattleMonsterPictureAndTitle
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    ld de, wScreenTileBuffer + $E7
    ld hl, vBGMap0 + $E7
    ld bc, $0606
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step5_Case01
; no direct call (reached through a table, a jump or a vector)
BattleEnd_Step5_Case01_Case01::
Jump_031_474A:: ; address name
    farcall BattleEnd_Step5_Case01_Case01_Sub01
    ret

; entry 2 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wSavedSpriteClipMode, wSavedFieldDrawFlags, wSavedSpriteSlotCount
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wSpriteSlotCount
; points at: wBattleSubPhase, wBattleSubStep
BattleEnd_Step5_SwapMonstersMenu::
Jump_031_4751:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
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
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToVRAM
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep, wBattleScreenFlags
BattleEnd_Step5_BuildAndDrawBattleScreen::
Jump_031_4793:: ; address name
    ld a, [wBattleSubStep]
    cp a, $03
    call z, BuildAndDrawBattleScreen
    farcall RunBattleEndStep5SubSteps
    ld a, [wBattleScreenFlags]
    or a, a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; BuildBattleScreenBuffer, then copies the 20 x 18 wScreenTileBuffer to vBGMap0 (CopyRect32StrideToVRAM) (E-0115)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_BuildAndDrawBattleScreen)
; points at: wScreenTileBuffer
BuildAndDrawBattleScreen::
Func_031_47A9:: ; address name
    call BuildBattleScreenBuffer
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412
    call CopyRect32StrideToVRAM
    ret

; entry 4 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScreenFlags
BattleEnd_Step5_LoadBattleMonsterPictureAndTitle::
Jump_031_47B9:: ; address name
    farcall BattleEnd_Step5_Case04_Sub01
    ld a, [wBattleScreenFlags]
    or a, a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; runs Func_031_47DD, ClearAttributesAndScreenBuffer_Bank31, CopyRectRecordForBattlePartyCount_Bank31, Func_031_7389, LayoutTileBlocksForBattleFoeCount, Func_031_7321 and Func_031_746F in turn (E-0115)
; 2 call sites from 2 routines (e.g. BuildAndDrawBattleScreen, BattleEnd_Step5_SwapMonstersMenu)
BuildBattleScreenBuffer::
Func_031_47C7:: ; address name
    call LoadBattleMonsterPictureAndTitle
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    call ClearWindowAndCopyRect7345Far
    ret

; loads the picture of battle monster wDAAB at vTiles2 + $140, uploads palettes, loads name tiles and shows string 5 of category 2 (bank 09) at vTiles1 + $6D0, then restores the default window (E-0121)
; 4 call sites from 4 routines (e.g. BattleEnd_Step5_LoadBattleMonsterPictureAndTitle, BattleEnd_Step5_BuildAndDrawBattleScreen, BuildBattleScreenBuffer, BattleEnd_Step5_Case01_CopyRect32StrideToVRAM)
; reads: wDisplaySlot
; writes: wBattleScreenFlags, wBGPaletteUploadRequest, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wBattleMonsterId
LoadBattleMonsterPictureAndTitle::
Func_031_47DD:: ; address name
    xor a, a
    ld [wBattleScreenFlags], a
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, vTiles2 + $140
    ld c, $01
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    call LoadRecordListNameTiles
    ld hl, vTiles1 + $6D0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C01
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
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step6::
Jump_031_4840:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step6_QueueMusic
    dw BattleEnd_Step6_WaitFadeState
    dw BattleEnd_Step6_QueueMusic_Case02

; entry 0 of the `rst $00` table in BattleEnd_Step6
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wCurrentMusic
; writes: hSpriteWindowClipMode, hSpriteHideTile
; points at: wTransitionByteCD, wBattleSubPhase
BattleEnd_Step6_QueueMusic::
Jump_031_484A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wCurrentMusic]
    ld hl, wTransitionByteCD
    cp a, [hl]
    jr z, .clear_sprite_window_clip_mode
    ld a, $02
    call QueueMusic

.clear_sprite_window_clip_mode:
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, $04
    call StartPaletteFade
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step6
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wBattleSubPhase
BattleEnd_Step6_WaitFadeState::
Jump_031_486E:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 2 of the `rst $00` table in BattleEnd_Step6
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic, wBattleKind
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wNewRecordByte0D, wScreenState, wFieldInitStage
; points at: wTransitionByteCD, wBGFillFlag
BattleEnd_Step6_QueueMusic_Case02::
Jump_031_4878:: ; address name
    ld a, [wCurrentMusic]
    ld hl, wTransitionByteCD
    cp a, [hl]
    jr z, .check_battle_kind
    ld a, [hl]
    call QueueMusic

.check_battle_kind:
    ld a, [wBattleKind]
    cp a, $02
    jr c, .set_game_mode_to_01
    cp a, $04
    jr nc, .set_game_mode_to_01
    call SetFollowersToPlayer

.set_game_mode_to_01:
    ld a, $01
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wNewRecordByte0D], a
    ld [wScreenState], a
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ExitPauseMenuToField
    ld a, $02
    ld [wFieldInitStage], a
    ld hl, wBGFillFlag
    inc [hl]
    ret

; copies hPlayerFacing to the three follower directions and hPlayerX/hPlayerY to the three follower positions (the facing-preserving form of ResetFollowersToPlayer) (E-0118)
; 1 call site from 1 routine (e.g. BattleEnd_Step6_QueueMusic_Case02)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wFollowerRecords
SetFollowersToPlayer::
Func_031_48C3:: ; address name
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ret

; wBattlePhase 2, wBattleStep 7 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step7::
Jump_031_48E5:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step7_WriteLinkSendByte
    dw BattleEnd_Step7_WaitLinkMessage
    dw BattleEnd_Step7_StartPaletteFade

; entry 0 of the `rst $00` table in BattleEnd_Step7
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots, wTextFlags
; writes: wLinkSendByte
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5, wBattleSubPhase
BattleEnd_Step7_WriteLinkSendByte::
Jump_031_48EF:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step7
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; points at: wBattleSubPhase
BattleEnd_Step7_WaitLinkMessage::
Jump_031_4926:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 2 of the `rst $00` table in BattleEnd_Step7
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wScreenState, wLinkSession, wLinkExchangeState, wLinkRole, ...
; points at: wModeChangeRequest, wBGFillFlag
BattleEnd_Step7_StartPaletteFade::
Jump_031_4931:: ; address name
    ld a, $04
    call StartPaletteFade
    farcall StoreBattleStateToPartyRecords_BankA3
    ld a, $06
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkMessage], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkScreenStep], a
    ret

; wBattlePhase 2, wBattleStep 9 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; writes: wBattleStep
BattleEnd_Step9::
Jump_031_4975:: ; address name
    ld a, [wBattleScene]
    cp a, $04
    jr z, .call_queue_sound_effect
    ld a, $42
    call QueueMusic
    jr .set_battle_step_to_07

.call_queue_sound_effect:
    ld a, $7E
    call QueueSoundEffect

.set_battle_step_to_07:
    ld a, $07
    ld [wBattleStep], a
    ret

; only called from BattleEnd_Step1 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1)
; reads: wLinkMode, wBattleFoeCount
; writes: wBattleArg0
; points at: wBattlePictureIds, wTextBuf0, wBattleByte58
BattleEnd_Step1_WriteBattleArg0::
Func_031_498E:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip
    xor a, a
    ld [wBattleArg0], a
    ld hl, wBattlePictureIds
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc hl
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, BattleEnd_Step1_Sub01_CopyStringHLToDE
    ld a, $01
    ld [wBattleArg0], a
    ld a, [hl+]
    cp a, e
    jr nz, BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip2
    ld a, [hl+]
    cp a, d
    jr nz, BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip2
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, .call_battle_end_step1_sub01_copy_string_hl_to
    ld a, [hl+]
    cp a, e
    jr nz, BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip2
    ld a, [hl]
    cp a, d
    jr nz, BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip2

.call_battle_end_step1_sub01_copy_string_hl_to:
    call BattleEnd_Step1_Sub01_CopyStringHLToDE
    ld hl, wTextBuf0

.loop:
    ld a, [hl+]
    cp a, $F0
    jr nz, .loop
    dec hl
    ld a, $33
    ld [hl+], a
    ld a, $34
    ld [hl+], a
    ld [hl], $F0
    jr BattleEnd_Step1_Sub01_CopyStringHLToDE_Return

; only called from BattleEnd_Step1_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1_WriteBattleArg0)
; points at: wTextBuf0
BattleEnd_Step1_Sub01_CopyStringHLToDE::
Func_031_49D8:: ; address name
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    jr BattleEnd_Step1_Sub01_CopyStringHLToDE_Return

BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip::
Jump_031_49E5:: ; address name
    ld de, wBattleByte58
    ld hl, wTextBuf0
    ld b, $0A

.loop:
    ld a, [de]
    cp a, $F0
    jr z, .set_battle_arg0_to_00
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop

.set_battle_arg0_to_00:
    ld [hl], $F0
    ld a, $00
    ld [wBattleArg0], a
    jr BattleEnd_Step1_Sub01_CopyStringHLToDE_Return

BattleEnd_Step1_Sub01_CopyStringHLToDE_Skip2::
Jump_031_4A00:: ; address name
    ld hl, wTextBuf0
    ld a, $30
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $31
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $37
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld [hl], $F0
    ld a, $02
    ld [wBattleArg0], a

BattleEnd_Step1_Sub01_CopyStringHLToDE_Return::
Jump_031_4A22:: ; address name
    ret

; the same 66 bytes as IncrementPlayTime (02:5F59)
; 1 call site from 1 routine (e.g. GameMode4_Update)
; reads: wPlayHoursLo, wPlayHoursHi, wPlayMinutes
; points at: wPlayFrames
IncrementPlayTime_Bank31::
Func_031_4A23:: ; address name
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    or a, a
    jr nz, .skip
    ld a, [wPlayMinutes]
    cp a, $3B
    ret z

.skip:
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hl-], a
    ld [hl], c
    ret

; only called from BattleFight_Step0 (E-0047)
; 1 call site from 1 routine (e.g. BattleFight_Step0)
; reads: wSide0Flag, wLinkMode, wLinkRole, wSide1Flag
; writes: wBattleFlag92, wBattleFlag93, wMenuState
; points at: wSideControl, wSlotFlags854, wActionQueue, wBattleActionChoice, wSlotMarks, wBattleStep, wBattleStatus3
BattleFight_Step0_FillBytes::
Func_031_4A65:: ; address name
    ld hl, wSideControl
    ld b, $08

.loop:
    set 7, [hl]
    inc hl
    dec b
    jr nz, .loop
    ld hl, wSlotFlags854
    ld bc, $0010
    xor a, a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000A
    xor a, a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld [wBattleFlag92], a
    ld [wBattleFlag93], a
    ld a, $00
    ld [wMenuState], a
    ld a, [wSide0Flag]
    ld b, a
    ld c, $00
    ld a, [wLinkMode]
    or a, a
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
    ld a, [hl+]
    or a, a
    jr nz, .next
    inc c

.next:
    dec b
    jr nz, .loop2
    ld a, c
    or a, a
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
    ld a, [hl+]
    and a, $C0
    jr nz, .skip2
    ld a, [hl+]
    and a, $0C
    jr nz, .skip2
    ld a, [hl+]
    and a, $30
    jr nz, .skip2
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
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

; battle fight step 1: one sub-step per wBattleSubPhase (13 cases, 0-12 observed in the first battle) that builds the battle screen and loads the combatants
; 1 call site from 1 routine (e.g. BattleFight_Step1)
; reads: wBattleSubPhase
RunBattleSetup::
Func_031_4B10:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleSetup_FleeCommand
    dw RunBattleSetup_CommandMenu
    dw RunBattleSetup_Case02
    dw RunBattleSetup_FillWC278WithC3_Bank31
    dw RunBattleSetup_ShowSelectingHeroSMove
    dw RunBattleSetup_WriteLinkSendByte
    dw RunBattleSetup_WriteLinkSendByteAndLinkBufferCountLoEtc
    dw RunBattleSetup_WriteLinkSendByteAndLinkReady
    dw RunBattleSetup_WriteLinkSendByteAndLinkReadyEtc
    dw RunBattleSetup_WriteLinkSendByteAndCounterPtr0Lo
    dw RunBattleSetup_WriteCounterPtr0HiAndLinkSendByte
    dw RunBattleSetup_WriteBattleSubPhase
    dw RunBattleSetup_FillTilesFromRequest

; by wBattleResolveStep: the flee/retire command ('Retire now?', '0 fled!', 'But the escape route was cut', 'No fleeing from this battle!', 'You threw in the towel!')
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_FleeCommand::
Jump_031_4B2E:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_FleeCommand_ReadLinkModeAndLinkRole
    dw RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31
    dw RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02
    dw RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink
    dw RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAMAndStep
    dw RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc
    dw RunBattleSetup_FleeCommand_ClearWindowAndCopyRect7345FarAndStep
    dw RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31_Case07
    dw RunBattleSetup_FleeCommand_ClearWindowAndCopyRect7345Far
    dw RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_Case0A
    dw RunBattleSetup_FleeCommand_ShowRetireNow
    dw RunBattleSetup_FleeCommand_LoadCursorTileAndRect7826
    dw RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D
    dw RunBattleSetup_FleeCommand_WaitTextFlags
    dw RunBattleSetup_FleeCommand_ShowNoFleeingFromThis
    dw RunBattleSetup_FleeCommand_WaitTextFlags_Case10

; entry 0 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
; points at: wBattleSetupF2, wSlotTactic, wBattleResolveStep
RunBattleSetup_FleeCommand_ReadLinkModeAndLinkRole::
Jump_031_4B54:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .check_link_role
    ld c, $00
    jr .skip

.check_link_role:
    ld a, [wLinkRole]
    and a, $02
    sla a
    ld c, a

.skip:
    ld de, wBattleSetupF2
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

; entry 1 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
; writes: wStringCategory, wStringIndex
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31::
Jump_031_4B8F:: ; address name
    ld a, [wLinkRole]
    rlca
    and a, $04
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC278RowsToBGMapRow7
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_FleeCommand_CopyRectRecord73ADToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; points at: wBattleResolveStep
RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02::
Jump_031_4BCC:: ; address name
    call RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM
    ld hl, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02_Data
    ld a, [wMenuState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wMenuState, wMenuSubState, wBattleResolveStep
RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink::
Jump_031_4BEE:: ; address name
    ld de, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02_Data
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
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAMAndStep::
Jump_031_4C19:: ; address name
    call RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState, wLinkMode, wBattleKind, wLinkRole
; writes: wBattleSetupDB, wStringIndex, wStringCategory, wBattleSubPhase, wBattleResolveStep, wCommandMonster
; points at: wBattleResolveStep, wSlotMarks
RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc::
Jump_031_4C21:: ; address name
    ld a, [wMenuState]
    and a, $03
    ld [wBattleSetupDB], a
    or a, a
    jr z, .call_run_battle_setup_flee_command_case05
    cp a, $01
    jr z, .read_link_role
    cp a, $02
    jr z, .check_link_mode
    jp .check_link_mode2

.call_run_battle_setup_flee_command_case05:
    call RunBattleSetup_FleeCommand_Case05_ReadLinkRole
    call RunBattleSetup_FleeCommand_Case05_ReadLinkModeAndLinkRole
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jp .return

.read_link_role:
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, .set_command_monster
    inc c
    dec b
    jr nz, .loop
    ld a, $00
    ld [wStringCategory], a
    ld a, $2D
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_command_monster:
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jr nz, .set_string_index_to_1D
    ld a, [wBattleKind]
    cp a, $04
    jr z, .set_string_index_to_1D
    cp a, $05
    jr z, .set_string_index_to_1D
    call RunBattleSetup_FleeCommand_Case05_ReadLinkRole
    call RunBattleSetup_FleeCommand_Case05_WriteCommandPageCountAndCommandCursorMaxEtc
    ld a, e
    or a, a
    jr nz, .set_battle_sub_phase_to_02
    ld a, $1F
    jr .set_string_index

.set_string_index_to_1D:
    ld a, $1D

.set_string_index:
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_sub_phase_to_02:
    ld a, $02
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.check_link_mode2:
    ld a, [wLinkMode]
    or a, a
    jr z, .call_run_battle_setup_flee_command_case052
    ld a, $20
    jr .set_string_index

.call_run_battle_setup_flee_command_case052:
    call RunBattleSetup_FleeCommand_Case05_ReadLinkRole
    ld hl, wBattleResolveStep
    ld [hl], $08
    ld a, [wBattleKind]
    cp a, $02
    jr c, .return
    ld [hl], $0F
    cp a, $02
    jr z, .return
    cp a, $03
    jr z, .return
    cp a, $05
    jr z, .return
    cp a, $06
    jr z, .return
    cp a, $07
    jr z, .return
    ld [hl], $0B

.return:
    ret

; only called from RunBattleSetup_FleeCommand_Case05 (E-0047)
; 3 call sites from 1 routine (e.g. RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc)
; reads: wLinkRole
; points at: wBattleActionChoice
RunBattleSetup_FleeCommand_Case05_ReadLinkRole::
Func_031_4CEE:: ; address name
    ld a, [wLinkRole]
    and a, $02
    ld hl, wBattleActionChoice
    add a, a
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ret

; only called from RunBattleSetup_FleeCommand_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc)
; reads: wLinkMode, wLinkRole
; points at: wBattleSetupF2, wSlotTactic
RunBattleSetup_FleeCommand_Case05_ReadLinkModeAndLinkRole::
Func_031_4D06:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .check_link_role
    ld c, $00
    jr .skip

.check_link_role:
    ld a, [wLinkRole]
    and a, $02
    sla a
    ld c, a

.skip:
    ld de, wBattleSetupF2
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

; entry 6 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_FleeCommand_ClearWindowAndCopyRect7345FarAndStep::
Jump_031_4D3D:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31_Case07::
Jump_031_4D4E:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC338RowsToBGMapRow13
    call RunBattleSetup_FleeCommand_CopyRectRecord73ADToScreenBuffer
    ld a, $02
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTextBuf0, wPlayerName, wBattleResolveStep
RunBattleSetup_FleeCommand_ClearWindowAndCopyRect7345Far::
Jump_031_4D65:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    ld hl, wTextBuf0
    ld de, wPlayerName
    ld b, $0A

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
    ld [hl], $F0
    ld a, $01
    ld [wStringCategory], a
    ld a, $D8
    ld [wStringIndex], a ; '0 fled!'
    farcall BeginStringDisplay_Bank2F
    ld a, $82
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSoundChannelSlots, wBattleTurn, wBattlePartyCount, wBattleFoeCount, wRandomLo, wLinkMode, wDataBankSave
; writes: wStringCategory, wStringIndex, wBattleScene, wBattlePhase, wBattleStep, wBattleKindFlags, wDataBank, wDataBankSave
; points at: wSoundChannel1, wBattleLevel, wBattleResolveStep
RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty::
Jump_031_4D95:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wBattleTurn]
    or a, a
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
    cp a, e
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
    cp a, d
    jr c, .next2
    ld d, a

.next2:
    inc hl
    inc c
    dec b
    jr nz, .loop2
    ld a, d
    add a, $05
    cp a, e
    jr c, .check_link_mode
    call NextTableByte
    ld a, [wRandomLo]
    and a, $07
    inc a
    ld b, a
    ld a, [wBattleTurn]
    cp a, $04
    jr c, .skip
    ld a, $07

.skip:
    cp a, b
    jr nc, .check_link_mode
    call RunBattleSetup_FleeCommand_Case09_CheckSlotStatusBlockWide_Bank31
    jr z, .check_link_mode
    ld a, $00
    ld [wStringCategory], a
    ld a, $2C
    ld [wStringIndex], a ; 'But the escape route was cut'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jr nz, .set_battle_scene_to_02
    call RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty

.set_battle_scene_to_02:
    ld a, $02
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $03
    ld [wBattleStep], a
    ld a, $01
    ld [wBattleKindFlags], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ret

; only called from RunBattleSetup_FleeCommand_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wBattleFoeCount
RunBattleSetup_FleeCommand_Case09_CheckSlotStatusBlockWide_Bank31::
Func_031_4E3E:: ; address name
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
    or a, a
    ret

; only called from RunBattleSetup_FleeCommand_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wBattlePartyCount
; points at: wBattleLevel, wSlotTrait, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty::
Func_031_4E54:: ; address name
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
    cp a, $0A
    jr c, .skip
    ld e, $01
    cp a, $14
    jr c, .skip
    ld e, $02
    cp a, $1E
    jr c, .skip
    ld e, $03

.skip:
    ld a, c
    ld hl, wSlotTrait
    add_a_to_hl
    ld a, [hl]
    cp a, $97
    ld hl, RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty_Data_4EC6
    jr c, .skip2
    ld hl, RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty_Data_4ED6

.skip2:
    ld a, e
    add a, a
    add a, a
    add_a_to_hl
    ld de, wSlotPersonalityHi
    call RunBattleSetup_FleeCommand_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotPersonalityMid
    call RunBattleSetup_FleeCommand_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotPersonalityLo
    call RunBattleSetup_FleeCommand_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotTrait
    call RunBattleSetup_FleeCommand_Case09_Sub02_Sub01

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; only called from RunBattleSetup_FleeCommand_Case09_Sub02 (E-0047)
; 4 call sites from 1 routine (e.g. RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty)
RunBattleSetup_FleeCommand_Case09_Sub02_Sub01::
Func_031_4EB9:: ; address name
    ld a, c
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    sub a, [hl]
    ld [de], a
    ret nc
    xor a, a
    ld [de], a
    ret

; address loaded by RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty
RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty_Data_4EC6:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_4EC6:: ; address name
    db $04, $00, $00, $0A, $03, $00, $00, $05, $02, $00, $00, $03, $01, $00, $00, $02

; address loaded by RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty
RunBattleSetup_FleeCommand_Case09_CarryUnlessBattleSlotOutSlotEmpty_Data_4ED6:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_4ED6:: ; address name
    db $08, $00, $00, $0F, $06, $00, $00, $0A, $04, $00, $00, $05, $02, $00, $00, $03

; entry 10 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePartyCount
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wSlotMarks
RunBattleSetup_FleeCommand_CarryUnlessBattleSlotOutSlotEmpty_Case0A::
Jump_031_4EE6:: ; address name
    ld a, [wTextFlags]
    or a, a
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
    ld [hl], $FF

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_FleeCommand_ShowRetireNow::
Jump_031_4F0F:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a ; 'Retire now?'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wWindowTileBuffer, wMenuSubState
; points at: wBattleResolveStep
RunBattleSetup_FleeCommand_LoadCursorTileAndRect7826::
Jump_031_4F2A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld a, $BB
    ld [wWindowTileBuffer + $7], a
    ld a, $01
    ld [wMenuSubState], a
    ld de, wScreenTileBuffer + $10E
    ld hl, vBGMap0 + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState
; writes: wBattleResolveStep, wBattleSubPhase, wStringCategory, wStringIndex
; points at: wMenuSubState, wBattleResolveStep
RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D::
Jump_031_4F50:: ; address name
    ld de, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D_Data_63C5
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, [wMenuSubState]
    and a, $01
    ld hl, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D_Data_4FA4
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ld a, [wMenuSubState]
    and a, $01
    jr z, .set_string_category_to_00
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC278Rect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a, a
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

; address loaded by RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D
RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D_Data_4FA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_4FA4:: ; address name
    db $2F, $99, $6F, $99

; entry 14 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wDataBankSave
; writes: wBattleScene, wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wDataBank, wDataBankSave
RunBattleSetup_FleeCommand_WaitTextFlags::
Jump_031_4FA8:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $03
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $06
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ret

; entry 15 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_FleeCommand_ShowNoFleeingFromThis::
Jump_031_4FCE:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a ; 'No fleeing from this battle!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_FleeCommand
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_FleeCommand_WaitTextFlags_Case10::
Jump_031_4FE9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; by wBattleResolveStep: draws the command windows, moves the command cursor (MoveBattleCommandCursor) and shows 'It has no usable ...'
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_CommandMenu::
Jump_031_4FF4:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31
    dw RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01
    dw RunBattleSetup_CommandMenu_MoveBattleCommandCursor
    dw RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7
    dw RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case04
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case07
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep
    dw RunBattleSetup_CommandMenu_ShowItHasNoUsable
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case0A
    dw RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep_Case0C
    dw RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0D
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case0E
    dw RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0F
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10
    dw RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects_Case11
    dw RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12
    dw RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31AndStep
    dw RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13AndStep
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case16
    dw RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13_Case17
    dw RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31AndStep
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_Case19
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1A
    dw RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9
    dw RunBattleSetup_CommandMenu_CopyRectRecord7750ToScreenBufferFar
    dw RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case1D
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1E
    dw RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11
    dw RunBattleSetup_CommandMenu_WriteCommandMonsterAndBattleResolveStepEtc
    dw RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13AndStep_Case21
    dw RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case16
    dw RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13_Case23

; entry 0 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSetupD7, wCommandMonster
; writes: wStringCategory, wStringIndex, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31::
Jump_031_5040:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    ld a, [wBattleSetupD7]
    or a, a
    jr z, .clear_command_page_count
    ld a, $07
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_Bank31

.clear_command_page_count:
    xor a, a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    call CopyRectRecord73F7ToScreenBufferFar
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable6102
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandMonster, wMenuSubState
; writes: wMenuSubState, wListLastPageSize
; points at: wBattleSetupD8, wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01::
Jump_031_5087:: ; address name
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawWC278Rect12x11ToBGMapRow7
    ld hl, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld a, [wMenuSubState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSubState, wBattleSetupD7
; writes: wBattleResolveStep, wBattleArg1, wCommandMonster
; points at: wMenuSubState, wBattleSetupD8, wBattleActionChoice, wSideControl, wBattleResolveStep, wSlotMarks
RunBattleSetup_CommandMenu_MoveBattleCommandCursor::
Jump_031_50BF:: ; address name
    ld de, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld hl, wMenuSubState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [wMenuSubState]
    and a, $03
    ld [hl], a
    call SetSlotTacticAndSlotLastTacticForCommandMonster
    cp a, $03
    jr nz, .read_command_monster
    ld a, [wBattleSetupD7]
    or a, a
    jr z, .call_fill_wc278_with_c3_bank31
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld [hl], $00
    jr .read_command_monster2

.call_fill_wc278_with_c3_bank31:
    call FillWC278WithC3_Bank31
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
    and a, $03
    jr z, .set_battle_arg1_to_00
    ld a, [wCommandMonster]
    dec a
    ld [wCommandMonster], a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, .loop
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable6102
    ld hl, wBattleResolveStep
    dec [hl]
    jr .return

.set_battle_arg1_to_00:
    ld a, $00
    ld [wBattleArg1], a
    jr .call_fill_wc278_with_c3_bank312

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a

.read_command_monster2:
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    ld a, $20
    ld [wBattleResolveStep], a
    jr .return

.call_fill_wc278_with_c3_bank312:
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7::
Jump_031_517D:: ; address name
    call DrawWC278Rect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster
; writes: wBattleArg1, wStringCategory, wStringIndex, wMenuSelectedMember
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case04::
Jump_031_518A:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC278Rect12x11ToBGMapRow7
    xor a, a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call CopyRectRecord755FToScreenBufferFar
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $141
    call WriteFiveTilesFromTable6102
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4::
Jump_031_51CE:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    ld hl, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    ld a, [wMenuSelectedMember]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSelectedMember
; writes: wBattleArg1, wBattleResolveStep, wSubMenuCursor2
; points at: wMenuSelectedMember, wBattleResolveStep, wSideControl, wBattleActionChoice
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31::
Jump_031_51F0:: ; address name
    ld de, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    ld hl, wMenuSelectedMember
    call RunBattleSetup_CommandMenu_Case06_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld a, $00
    ld [wBattleArg1], a
    call FillWC278WithC3_Bank31
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
    and a, $0F
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    or a, a
    jr z, .call_count_present_foes_of_link_role_side
    cp a, $01
    jr z, .call_run_battle_setup_command_menu_case06
    jr .read_command_monster

.call_count_present_foes_of_link_role_side:
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp a, $01
    jr nz, .call_fill_wc278_with_c3_bank31
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $00
    ld [hl+], a
    ld [hl], e
    jr .set_battle_arg1_to_01

.call_fill_wc278_with_c3_bank31:
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $0C
    ld [wBattleResolveStep], a
    xor a, a
    ld [wSubMenuCursor2], a
    jr .return

.call_run_battle_setup_command_menu_case06:
    call RunBattleSetup_CommandMenu_Case06_WriteBattleArg2AndBattleArg3Etc
    ld a, d
    or a, a
    jr nz, .call_fill_wc278_with_c3_bank312
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.call_fill_wc278_with_c3_bank312:
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    xor a, a
    ld [wBattleArg1], a
    ld a, $10
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $AC
    ld [hl+], a
    ld a, [wCommandMonster]
    ld [hl], a

.set_battle_arg1_to_01:
    ld a, $01
    ld [wBattleArg1], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case07::
Jump_031_52B5:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    ld a, [wBattleArg1]
    or a, a
    jr z, .set_battle_resolve_step
    ld a, $20

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep::
Jump_031_52C4:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    call ClearWindowAndCopyRect7345Far
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_ShowItHasNoUsable::
Jump_031_52CF:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case0A::
Jump_031_52E7:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13::
Jump_031_52F7:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleArg1
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep_Case0C::
Jump_031_5300:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    call CopyRectRecord7750ToScreenBufferFar
    xor a, a
    ld [wBattleArg1], a
    farcall RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_Shared03
    xor a, a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0D::
Jump_031_5319:: ; address name
    call DrawWC2F8RectToBGMapRow11
    xor a, a
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wCommandMonster, wSubMenuCursor2
; writes: wBattleArg0
; points at: wSubMenuCursor2, wBattleResolveStep, wBattleActionChoice
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case0E::
Jump_031_5350:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillWC278WithC3_Bank31
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
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $00
    ld [hl+], a
    ld a, [wSubMenuCursor2]
    and a, $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 15 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0F::
Jump_031_53BA:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wBattleArg0]
    or a, a
    jr z, .set_battle_resolve_step_to_04
    ld a, $20
    jr .set_battle_resolve_step

.set_battle_resolve_step_to_04:
    ld a, $04

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster, wBattleArg2, wBattleArg3, wCommandCursor, wMenuCursor
; writes: wBattleArg1, wMenuCursor, wCommandCursor, wStringCategory
; points at: wSideControl, wCommandCursor, wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10::
Jump_031_53CD:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC2B8LeftToBGMapRow9_74B4
    xor a, a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    call ShowSkillPageNames
    call RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31
    call CopyRectRecords7600And7734ToScreenBufferFar
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    and a, $03
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuCursor
; writes: wListLastPageSize
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects_Case11::
Jump_031_542A:: ; address name
    call DrawWC2A4AndWC2B8Rects
    ld hl, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld a, [wMenuCursor]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 18 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wRecordBufferData, wCommandMonster, wCommandCursor, wMenuCursor, wRecordBuffer
; writes: wBattleArg1, wStringIndex
; points at: wMenuCursor, wBattleMP, wSideControl, wBattleActionChoice, wBattleResolveStep
RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12::
Jump_031_5454:: ; address name
    ld de, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld hl, wMenuCursor
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg1], a
    call LoadSelectedSkillRecord_Bank31
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jp z, .set_string_index_to_25
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp a, $FF
    jr nz, .skip
    ld c, $01

.skip:
    xor a, a
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jp nz, .set_string_index_to_26
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hl+], a
    cp a, $35
    jr z, .check_command_monster3
    ld a, [wRecordBufferData + $4]
    cp a, $FF
    jr z, .skip2
    cp a, $14
    jr z, .skip2
    cp a, $80
    jr z, .check_command_monster
    cp a, $12
    jr z, .check_command_monster2
    cp a, $22
    jr z, .check_command_monster3
    cp a, $11
    jr z, .call_count_present_foes_of_link_role_side
    cp a, $21
    jr z, .call_count_present_slots_of_link_role_side
    cp a, $40
    jr z, .read_command_monster
    jp .return

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_command_monster:
    ld a, [wCommandMonster]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_command_monster2:
    ld a, [wCommandMonster]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_command_monster3:
    ld a, [wCommandMonster]
    and a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_count_present_foes_of_link_role_side:
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp a, $01
    jr nz, .set_battle_arg1_to_1C
    ld [hl], e
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_arg1_to_1C:
    ld a, $1C
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_count_present_slots_of_link_role_side:
    call CountPresentSlotsOfLinkRoleSide_Bank31
    ld a, d
    cp a, $01
    jr nz, .set_battle_arg1_to_18
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, .set_battle_arg1_to_18
    cp a, $1F
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
    call FillWC278WithC3_Bank31
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

; entry 19 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep, wBattleArg1
RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects::
Jump_031_55C1:: ; address name
    call DrawWC2A4AndWC2B8Rects
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleArg1], a
    ret

; entry 20 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31AndStep::
Jump_031_55CF:: ; address name
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC2A4AndWC2B8Rects
    call ClearWindowAndCopyRect7345Far
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13AndStep::
Jump_031_55E0:: ; address name
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case16::
Jump_031_55F2:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13_Case17::
Jump_031_5602:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $10
    ld [wBattleResolveStep], a
    ret

; entry 24 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wSubMenuCursor2
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31AndStep::
Jump_031_560B:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_CommandMenu_Case18_ReadRecordBufferAndLinkRoleEtc
    xor a, a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_Case19::
Jump_031_562A:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, .set_name_slot
    cp a, $1F
    jr z, .set_name_slot
    xor a, a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wRecordBuffer, wCommandMonster, wSubMenuCursor2
; writes: wBattleArg0, wStringIndex, wBattleResolveStep
; points at: wSubMenuCursor2, wBattleResolveStep, wBattleTargetChoice
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1A::
Jump_031_566A:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillWC278WithC3_Bank31
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
    cp a, $1B
    jr z, .check_command_monster
    cp a, $1C
    jr z, .check_command_monster
    cp a, $1D
    jr z, .check_command_monster
    cp a, $97
    jr nz, .read_command_monster

.check_command_monster:
    ld a, [wCommandMonster]
    and a, $03
    ld c, a
    ld a, [wSubMenuCursor2]
    and a, $03
    cp a, c
    jr nz, .read_command_monster
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC2A4AndWC2B8Rects
    call ClearWindowAndCopyRect7345Far
    ld a, $65
    ld [wStringIndex], a
    ld a, $21
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and a, $03
    ld b, a
    ld a, [wCommandMonster]
    and a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 27 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9::
Jump_031_56FE:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

; entry 28 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer
; writes: wBattleArg1, wSubMenuCursor2
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_CopyRectRecord7750ToScreenBufferFar::
Jump_031_5708:: ; address name
    call CopyRectRecord7750ToScreenBufferFar
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, .set_battle_arg1
    cp a, $1F
    jr z, .set_battle_arg1
    xor a, a

.set_battle_arg1:
    ld [wBattleArg1], a
    farcall RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_Shared03
    xor a, a
    ld [wBattleArg1], a
    xor a, a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 29 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case1D::
Jump_031_572D:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, .set_name_slot
    cp a, $1F
    jr z, .set_name_slot
    xor a, a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wCommandMonster, wSubMenuCursor2
; writes: wBattleArg0
; points at: wSubMenuCursor2, wBattleResolveStep, wBattleTargetChoice
RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1E::
Jump_031_576F:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillWC278WithC3_Bank31
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
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and a, $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 31 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11::
Jump_031_57D6:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

; entry 32 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandMonster
; writes: wCommandMonster, wBattleResolveStep, wBattleSubPhase
; points at: wSlotMarks
RunBattleSetup_CommandMenu_WriteCommandMonsterAndBattleResolveStepEtc::
Jump_031_57E0:: ; address name
    ld a, [wCommandMonster]
    and a, $04
    or a, $03
    ld b, a

.loop:
    ld a, [wCommandMonster]
    inc a
    ld [wCommandMonster], a
    cp a, b
    jr z, .clear_battle_resolve_step
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, .loop
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.clear_battle_resolve_step:
    xor a, a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a

.return:
    ret

; entry 33 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13AndStep_Case21::
Jump_031_580E:: ; address name
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 35 of the `rst $00` table in RunBattleSetup_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_CommandMenu_DrawWC338RowsToBGMapRow13_Case23::
Jump_031_5820:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $18
    ld [wBattleResolveStep], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_Case02::
Jump_031_5829:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_Case02_FillWC278WithC3_Bank31
    dw RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case01
    dw RunBattleSetup_Case02_MoveBattleCommandCursor
    dw RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9
    dw RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case04
    dw RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11
    dw RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink
    dw RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11_Case07
    dw RunBattleSetup_Case02_ShowStringBank09AtTilesHL_Bank31AndStep
    dw RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9
    dw RunBattleSetup_Case02_FillWC278WithC3_Bank31_Case0A
    dw RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0B
    dw RunBattleSetup_Case02_CopyRectRecord7750ToScreenBufferFar
    dw RunBattleSetup_Case02_DrawWC2F8RectToBGMapRow11
    dw RunBattleSetup_Case02_FillWC278WithC3_Bank31_Case0E
    dw RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0F
    dw RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9AndStep
    dw RunBattleSetup_Case02_ToDrawWC338RowsToBGMapRow13AndStep
    dw RunBattleSetup_Case02_BeginStringDisplay_Bank2F
    dw RunBattleSetup_Case02_DrawWC338RowsToBGMapRow13

; entry 0 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandCursor, wMenuOption
; writes: wStringCategory, wStringIndex
; points at: wCommandCursor, wInventory, wBattleResolveStep
RunBattleSetup_Case02_FillWC278WithC3_Bank31::
Jump_031_5855:: ; address name
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC278RowsToBGMapRow7
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    call ShowInventoryPageItemNames
    call RunBattleSetup_ClearBit6AndCursorEntryTile_Bank31
    call CopyRectRecord7600ToScreenBufferFar
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuOption]
    and a, $03
    add a, c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wMenuOption
; writes: wBattleArg0, wListLastPageSize
; points at: wBattleResolveStep
RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case01::
Jump_031_589C:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    ld a, [wBattleArg0]
    or a, a
    ret z
    xor a, a
    ld [wBattleArg0], a
    ld hl, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld a, [wMenuOption]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wItemId, wItemRecord
; writes: wBattleArg1, wBattleFlag93, wBattleFlag92, wBattleSubPhase, wBattleResolveStep, wStringIndex
; points at: wMenuOption, wBattleResolveStep, wCommandCursor
RunBattleSetup_Case02_MoveBattleCommandCursor::
Jump_031_58CF:: ; address name
    ld de, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld hl, wMenuOption
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg1], a
    call LoadSelectedInventoryItemRecord
    ld a, [wItemId]
    ld [wBattleFlag93], a
    ld a, [wItemRecord + $4]
    bit 0, a
    jr nz, .call_fill_wc278_with_c3_bank31
    ld a, [wItemRecord + $6]
    or a, a
    jr z, .call_fill_wc278_with_c3_bank312
    cp a, $01
    jr z, .set_battle_flag92_to_10
    cp a, $02
    jr z, .call_draw_wc2_b8_rows_to_bg_map_row9
    cp a, $03
    jr z, .set_battle_flag92_to_20
    cp a, $04
    jr z, .set_battle_resolve_step_to_04
    cp a, $05
    jr z, .set_battle_resolve_step_to_04
    cp a, $06
    jr z, .set_battle_sub_phase_to_03
    jp .set_battle_flag92_to_20

.call_fill_wc278_with_c3_bank31:
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleResolveStep], a
    ld a, $1E
    ld [wStringIndex], a
    jr .return

.call_fill_wc278_with_c3_bank312:
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC2B8RowsToBGMapRow9
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.set_battle_flag92_to_10:
    ld a, $10
    ld [wBattleFlag92], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.call_draw_wc2_b8_rows_to_bg_map_row9:
    call DrawWC2B8RowsToBGMapRow9
    ld a, $0C
    ld [wBattleResolveStep], a
    jr .return

.set_battle_flag92_to_20:
    ld a, $20
    ld [wBattleFlag92], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a
    jr .return

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $FF
    ld [wBattleFlag92], a
    ld [wBattleFlag93], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit2:
    bit 2, a
    jr z, .call_run_battle_setup_clear_bit6_and_cursor
    farcall SortInventory
    ld de, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data
    ld hl, wCommandCursor
    set 7, [hl]

.call_run_battle_setup_clear_bit6_and_cursor:
    call RunBattleSetup_ClearBit6AndCursorEntryTile_Bank31
    call DrawInventoryPageIndicator
    jr .return

.return:
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9::
Jump_031_59B0:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor, wBattleArg1
; writes: wSubMenuCursor, wBattleArg1, wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case04::
Jump_031_59BC:: ; address name
    ld a, [wSubMenuCursor]
    and a, $01
    ld [wSubMenuCursor], a
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC2B8RowsToBGMapRow9
    xor a, a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call CopyRectRecord76F8ToScreenBufferFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor
; points at: wBattleResolveStep
RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11::
Jump_031_59EA:: ; address name
    call DrawWC2F8Rect8x7ToBGMapRow11
    ld hl, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02_Data
    ld a, [wSubMenuCursor]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wItemRecord, wItemId, wSubMenuCursor, wBattleSlotOut
; writes: wBattleFlag92, wBattleSubPhase, wBattleResolveStep, wBattleArg0, wSubMenuCursor
; points at: wSubMenuCursor, wBattleResolveStep
RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink::
Jump_031_5A0C:: ; address name
    ld de, RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink_Data
    ld hl, wSubMenuCursor
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    and a, $01
    jr nz, .check_sub_menu_cursor
    ld a, [wItemId]
    cp a, $19
    jr c, .set_battle_arg0_to_01
    cp a, $1F
    jr nc, .set_battle_arg0_to_01
    ld a, [wSubMenuCursor]
    and a, $01
    jr z, .set_battle_arg0_to_01
    ld b, $04
    ld a, [wBattleSlotOut + $4]
    or a, a
    jr z, .set_battle_flag92
    ld b, $05
    ld a, [wBattleSlotOut + $5]
    or a, a
    jr z, .set_battle_flag92
    ld b, $06
    ld a, [wBattleSlotOut + $6]
    or a, a
    jr nz, .return

.set_battle_flag92:
    ld a, b
    ld [wBattleFlag92], a
    jr .set_battle_sub_phase_to_03

.check_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    and a, $01
    inc a
    swap a
    ld [wBattleFlag92], a

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.set_battle_arg0_to_01:
    ld a, $01
    ld [wBattleArg0], a
    jr .call_fill_wc278_with_c3_bank31

.check_bit1:
    bit 1, a
    jr z, .return
    xor a, a
    ld [wSubMenuCursor], a
    ld a, $00
    ld [wBattleArg0], a

.call_fill_wc278_with_c3_bank31:
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wSubMenuCursor
; writes: wBattleResolveStep
RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11_Case07::
Jump_031_5A90:: ; address name
    call DrawWC2F8Rect8x7ToBGMapRow11
    ld a, [wBattleArg0]
    or a, a
    jr z, .set_battle_resolve_step
    ld a, [wSubMenuCursor]
    and a, $01
    add a, a
    add a, a
    add a, $08

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case02_ShowStringBank09AtTilesHL_Bank31AndStep::
Jump_031_5AA6:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9::
Jump_031_5AC1:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wItemId]
    cp a, $0C
    jr z, .set_name_slot
    xor a, a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wSubMenuCursor2
; writes: wBattleArg0, wBattleFlag92
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_FillWC278WithC3_Bank31_Case0A::
Jump_031_5AFD:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillWC278WithC3_Bank31
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
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and a, $03
    ld [wBattleFlag92], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.return:
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wItemRecord
; writes: wBattleResolveStep, wBattleArg0, wBattleSubPhase
RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0B::
Jump_031_5B49:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wBattleArg0]
    or a, a
    jr nz, .set_battle_sub_phase_to_03
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp a, $04
    jr z, .set_battle_resolve_step_to_04
    cp a, $05
    jr z, .set_battle_resolve_step_to_04
    xor a, a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a

.clear_battle_arg0:
    xor a, a
    ld [wBattleArg0], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wBattleArg1
; points at: wBattleResolveStep
RunBattleSetup_Case02_CopyRectRecord7750ToScreenBufferFar::
Jump_031_5B7B:: ; address name
    call CopyRectRecord7750ToScreenBufferFar
    ld a, [wItemId]
    cp a, $0C
    jr z, .set_battle_arg1
    xor a, a

.set_battle_arg1:
    ld [wBattleArg1], a
    farcall RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_Shared03
    xor a, a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_DrawWC2F8RectToBGMapRow11::
Jump_031_5B98:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wItemId]
    cp a, $0C
    jr z, .set_name_slot
    xor a, a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    ld hl, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wSubMenuCursor2
; writes: wBattleArg0, wBattleFlag92
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_FillWC278WithC3_Bank31_Case0E::
Jump_031_5BD6:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data
    call RunBattleSetup_SetBit6AndBlankEntryTile_Bank31
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillWC278WithC3_Bank31
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
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and a, $03
    set 2, a
    ld [wBattleFlag92], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.return:
    ret

; entry 15 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wItemRecord
; writes: wBattleResolveStep, wBattleArg0, wBattleSubPhase
RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0F::
Jump_031_5C26:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wBattleArg0]
    or a, a
    jr nz, .set_battle_sub_phase_to_03
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp a, $04
    jr z, .set_battle_resolve_step_to_04
    cp a, $05
    jr z, .set_battle_resolve_step_to_04
    xor a, a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a

.clear_battle_arg0:
    xor a, a
    ld [wBattleArg0], a
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9AndStep::
Jump_031_5C58:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    call ClearWindowAndCopyRect7345Far
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case02_ToDrawWC338RowsToBGMapRow13AndStep::
Jump_031_5C63:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_Case02_BeginStringDisplay_Bank2F::
Jump_031_5C6B:: ; address name
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ret

; entry 19 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_Case02_DrawWC338RowsToBGMapRow13::
Jump_031_5C80:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 3 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wLinkSendByte
; points at: wSlotMarks, wBattleSubPhase
RunBattleSetup_FillWC278WithC3_Bank31::
Jump_031_5C8D:: ; address name
    ld b, $08
    ld hl, wSlotMarks

.loop:
    ld a, [hl]
    or a, a
    jr nz, .next
    ld [hl], $01

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [wBattleActor], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call ClearWindowAndCopyRect7345Far
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wStringCategory, wStringIndex, wLinkSendByte
; points at: wBattleByte58, wTextBuf0, wBattleSubPhase
RunBattleSetup_ShowSelectingHeroSMove::
Jump_031_5CB5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .done
    ld de, wBattleByte58
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a ; 'Selecting 0's move'
    farcall BeginStringDisplay_Bank2F
    xor a, a
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wLinkSendByte
; points at: wBattleSubPhase
RunBattleSetup_WriteLinkSendByte::
Jump_031_5CDD:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .done
    ld a, $01
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wMenuState
; writes: wLinkSendByte, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi
; points at: wSlotTactic, wLinkRecvBuffer, wBattleActionChoice, wSlotMarks, wSideControl, wLinkPartnerName, wBattleSubPhase
RunBattleSetup_WriteLinkSendByteAndLinkBufferCountLoEtc::
Jump_031_5CED:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, .done
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld de, wSlotTactic
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld de, wSlotTactic + $4

.skip:
    ld hl, wLinkRecvBuffer
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [wRandomLo]
    ld [hl+], a
    ld a, [wRandomHi]
    ld [hl+], a
    ld a, [wMenuState]
    ld [hl+], a
    ld a, [wMenuState]
    ld [hl+], a
    ld de, wBattleActionChoice
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld de, wBattleActionChoice + $8

.skip2:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, wSlotMarks
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip3
    ld de, wSlotMarks + $4

.skip3:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, wSideControl
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip4
    ld de, wSideControl + $4

.skip4:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, $13
    ld [wLinkBufferCountLo], a
    xor a, a
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

; entry 7 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wLinkSendByte, wLinkReady
; points at: wBattleSubPhase
RunBattleSetup_WriteLinkSendByteAndLinkReady::
Jump_031_5D92:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    and a, a
    jr z, .return
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a

.return:
    ret

; entry 8 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wMenuState, wRandomSeed2Lo, wRandomSeed2Hi
; writes: wLinkSendByte, wLinkReady, wCommandBytesE9, wCommandByteEA, wRandomSeed2Lo, wRandomSeed2Hi, wBattleSetupByteBC, wRandomLo, ...
; points at: wSlotTactic, wLinkPartnerName, wBattleActionChoice, wSlotMarks, wSideControl, wBattleSubPhase, wSlotLastTactic
RunBattleSetup_WriteLinkSendByteAndLinkReadyEtc::
Jump_031_5DA7:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, .done
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld de, wSlotTactic + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld de, wSlotTactic

.skip:
    ld hl, wLinkPartnerName
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wCommandBytesE9], a
    ld a, [hl+]
    ld [wCommandByteEA], a
    ld de, wBattleActionChoice + $8
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld de, wBattleActionChoice

.skip2:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, wSlotMarks + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip3
    ld de, wSlotMarks

.skip3:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, wSideControl + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip4
    ld de, wSideControl

.skip4:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_random_seed2_lo
    ld a, [wRandomLo]
    ld [wRandomSeed2Lo], a
    ld a, [wRandomHi]
    ld [wRandomSeed2Hi], a
    ld a, [wMenuState]
    ld [wBattleSetupByteBC], a
    ld a, [wMenuState]
    ld [wCommandBytesE9], a
    ld hl, wSlotTactic + $4
    ld de, wSlotLastTactic + $4
    jr .skip5

.read_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    ld [wRandomLo], a
    ld a, [wRandomSeed2Hi]
    ld [wRandomHi], a
    ld a, [wMenuState]
    ld [wBattleSetupByteBD], a
    ld a, [wMenuState]
    ld [wCommandByteEA], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

.skip5:
    ld b, $03

.loop:
    ld a, [hl]
    cp a, $03
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

; entry 9 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wRandomLo, wRandomSeed2Lo, wRandomHi, wRandomSeed2Hi
; writes: wLinkSendByte, wCounterPtr0Lo
; points at: wBattleSubPhase, wBattleSetupFlagsLo
RunBattleSetup_WriteLinkSendByteAndCounterPtr0Lo::
Jump_031_5E7D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, .skip
    jr .done

.skip:
    ld hl, wBattleSetupFlagsLo
    ld a, [hl+]
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    ld a, [wRandomSeed2Lo]
    cp a, b
    jr nz, .set_link_send_byte_to_33
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp a, b
    ld a, [wRandomSeed2Hi]
    cp a, b
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

; entry 10 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkMessage
; writes: wCounterPtr0Hi, wLinkSendByte
; points at: wBattleSubPhase
RunBattleSetup_WriteCounterPtr0HiAndLinkSendByte::
Jump_031_5EB7:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done
    ld a, [wLinkMessage]
    cp a, $22
    jr z, .set_counter_ptr0_hi
    cp a, $33
    jr z, .set_counter_ptr0_hi
    ret

.set_counter_ptr0_hi:
    ld [wCounterPtr0Hi], a
    xor a, a
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wCounterPtr0Lo, wCounterPtr0Hi
; writes: wBattleSubPhase
; points at: wBattleSubPhase
RunBattleSetup_WriteBattleSubPhase::
Jump_031_5ED5:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done
    ld a, [wCounterPtr0Lo]
    cp a, $22
    jr nz, .set_battle_sub_phase_to_05
    ld a, [wCounterPtr0Hi]
    cp a, $22
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

; entry 12 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase
; points at: wBattleStep
RunBattleSetup_FillTilesFromRequest::
Jump_031_5EF6:: ; address name
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; up/down toggles bit 0 and left/right bit 1 of [HL] (sound $69); otherwise blinks the entry every 16 frames through bit 6 (E-0125)
; 4 call sites from 4 routines (e.g. RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink, RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
ToggleEntryBitsByJoypadAndBlink::
Func_031_5F02:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; only called from RunBattleSetup_CommandMenu_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_CommandMenu_Case06_SetBit6AndBlankEntryTile_Bank31::
Func_031_5F4E:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $03
    dec a
    cp a, $FF
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, $02
    jr .call_clear_bit6_and_cursor_entry_tile_bank31

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $03
    inc a
    cp a, $03
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    xor a, a

.call_clear_bit6_and_cursor_entry_tile_bank31:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; up/down/left/right move the battle command cursor entry wCFD5 within wCFD3, wCFD6, wCFD7, blinking it, with sound $69 (E-0131)
; 4 call sites from 4 routines (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12, RunBattleSetup_CommandMenu_MoveBattleCommandCursor, RunBattleSetup_Case02_MoveBattleCommandCursor, RunBattleEndStep4SubSteps_MoveBattleCommandCursor)
; reads: wJoypadPressedRepeat, wCommandCursor, wCommandPageCount, wCommandCursorMax, wFrameCounterLo, wListLastPageSize
; writes: wFrameCounterLo, wCommandCursor
MoveBattleCommandCursor::
Func_031_5F9E:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank31
    ld a, [wCommandCursorMax]
    or a, a
    jp z, .check_frame_counter_lo3
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, [wCommandCursorMax]
    jr .call_clear_bit6_and_cursor_entry_tile_bank31

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
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
    and a, $80
    jr z, .check_command_page_count
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank312
    ld a, [wCommandCursorMax]
    or a, a
    jp z, .check_frame_counter_lo3
    ld b, a
    call SetBit6AndBlankEntryTile_Bank31
    inc b
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank312
    ld a, $00
    jr .call_clear_bit6_and_cursor_entry_tile_bank312

.call_set_bit6_and_blank_entry_tile_bank312:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank312
    xor a, a

.call_clear_bit6_and_cursor_entry_tile_bank312:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo3

.check_command_page_count:
    ld a, [wCommandPageCount]
    or a, a
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wCommandCursor]
    or a, a
    jr nz, .set_command_cursor
    ld a, b
    jr .set_command_cursor2

.set_command_cursor:
    dec a

.set_command_cursor2:
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank314

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, .check_frame_counter_lo
    ld a, [wCommandCursor]
    cp a, b
    jr nz, .set_command_cursor3
    xor a, a
    jr .set_command_cursor4

.set_command_cursor3:
    inc a

.set_command_cursor4:
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank314

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
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
    cp a, b
    jr nz, .check_frame_counter_lo3
    ld a, [wCommandCursorMax]
    or a, a
    jr nz, .skip
    xor a, a
    jr .check_frame_counter_lo2

.skip:
    ld b, a

.skip2:
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, .check_frame_counter_lo2
    jr c, .check_frame_counter_lo3
    dec [hl]
    jr .skip2

.check_frame_counter_lo2:
    set 7, a
    ld [hl], a

.check_frame_counter_lo3:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 15 call sites from 4 routines (e.g. ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_SetBit6AndBlankEntryTile_Bank31, MoveBattleCommandCursor, RunBattleSetup_CommandMenu_Case06_SetBit6AndBlankEntryTile_Bank31)
SetBit6AndBlankEntryTile_Bank31::
Func_031_60AD:: ; address name
    set 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $C3
    call WriteVRAMByte
    pop hl
    ret

; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 13 call sites from 6 routines (e.g. ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_SetBit6AndBlankEntryTile_Bank31, RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31, MoveBattleCommandCursor, ...)
ClearBit6AndCursorEntryTile_Bank31::
Func_031_60CC:: ; address name
    res 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $BB
    call WriteVRAMByte
    pop hl
    ret

; clears wC46C and writes five consecutive tile numbers starting at Data_031_6102[A] to HL (E-0122)
; 3 call sites from 3 routines (e.g. RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case04, RunBattleSetup_CommandMenu_MoveBattleCommandCursor, RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31)
; writes: wMenuSubState
WriteFiveTilesFromTable6102::
Func_031_60EB:: ; address name
    push hl
    ld hl, WriteFiveTilesFromTable6102_Data
    add_a_to_hl
    xor a, a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

.loop:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop
    ret

; address loaded by WriteFiveTilesFromTable6102
WriteFiveTilesFromTable6102_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_6102:: ; address name
    db $D0, $D5, $DA

; only called from RunBattleSetup_CommandMenu_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31)
; reads: wCommandMonster
; writes: wBattleArg2, wBattleArg3, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleSkills
RunBattleSetup_CommandMenu_Case06_WriteBattleArg2AndBattleArg3Etc::
Func_031_6105:: ; address name
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .skip
    or a, a
    jr z, .skip
    cp a, $A2
    jr c, .next
    cp a, $AA
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
    cp a, $05
    ld a, $00
    jr c, .set_command_page_count
    inc a

.set_command_page_count:
    ld [wCommandPageCount], a
    ld a, c
    or a, a
    jr z, .set_command_cursor_max
    and a, $03
    dec a
    and a, $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    ret

; shows the four skill names (category 4) of page wCFD5 of monster wCFD4's skills (wD989 + 16 * wCFD4) in the four tile rows; $FF shows string 0 (E-0121)
; 2 call sites from 2 routines (e.g. RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10)
; reads: wCommandMonster, wCommandCursor
; writes: wStringCategory, wBattleArg2, wBattleArg3
; points at: wBattleSkills
ShowSkillPageNames::
Func_031_6153:: ; address name
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles16D0
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles1760
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles2080
    ret

; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110)
; 4 call sites from 1 routine (e.g. ShowSkillPageNames)
ReturnZero_61A2::
Func_031_61A2:: ; address name
    xor a, a
    ret

; only called from routines of RunBattleSetup_CommandMenu (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10)
; reads: wCommandCursor, wMenuCursor, wBattleArg2, wBattleArg3
; writes: wCommandCursor, wMenuCursor, wStringCategory
; points at: wMenuCursor
RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31::
Func_031_61A4:: ; address name
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
    and a, $0F
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1F0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; only called from RunBattleSetup_FleeCommand_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_FleeCommand_WriteBattleSetupDBAndStringIndexEtc)
; writes: wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wInventory
RunBattleSetup_FleeCommand_Case05_WriteCommandPageCountAndCommandCursorMaxEtc::
Func_031_6200:: ; address name
    ld hl, wInventory
    ld bc, $1800
    ld e, $00

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .skip
    or a, a
    jr z, .skip
    inc c
    cp a, $0D
    jr c, .next
    cp a, $19
    jr c, .next2
    cp a, $20
    jr c, .next
    cp a, $22
    jr c, .next2
    cp a, $28
    jr nc, .next2

.next:
    inc e

.next2:
    dec b
    jr nz, .loop

.skip:
    ld a, c
    and a, $FC
    rrca
    rrca
    ld [wCommandPageCount], a
    ld a, c
    or a, a
    jr z, .set_command_cursor_max
    and a, $03
    call z, RunBattleSetup_FleeCommand_Case05_Sub03_WriteCommandPageCount
    dec a
    and a, $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    ret

; only called from RunBattleSetup_FleeCommand_Case05_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_FleeCommand_Case05_WriteCommandPageCountAndCommandCursorMaxEtc)
; reads: wCommandPageCount
; writes: wCommandPageCount
RunBattleSetup_FleeCommand_Case05_Sub03_WriteCommandPageCount::
Func_031_6245:: ; address name
    push af
    ld a, [wCommandPageCount]
    dec a
    ld [wCommandPageCount], a
    pop af
    ret

; shows the four item names of inventory page wCFD5 (category 5) in the four tile rows of ShowStringAAtTiles16D0 ... 2080; an empty slot ($FF) shows string 0 (E-0120)
; 2 call sites from 2 routines (e.g. RunBattleSetup_ClearBit6AndCursorEntryTile_Bank31, RunBattleSetup_Case02_FillWC278WithC3_Bank31)
; reads: wCommandCursor
; writes: wStringCategory
; points at: wInventory
ShowInventoryPageItemNames::
Func_031_624F:: ; address name
    ld a, $05
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles16D0
    ld a, [hl+]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles1760
    ld a, [hl+]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles2080
    ret

; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110)
; 4 call sites from 1 routine (e.g. ShowInventoryPageItemNames)
ReturnZero_6286::
Func_031_6286:: ; address name
    xor a, a
    ret

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case02_MoveBattleCommandCursor, RunBattleSetup_Case02_FillWC278WithC3_Bank31)
; reads: wCommandCursor, wMenuOption
; writes: wCommandCursor, wMenuOption, wStringCategory, wStringIndex
; points at: wMenuOption, wInventory
RunBattleSetup_ClearBit6AndCursorEntryTile_Bank31::
Func_031_6288:: ; address name
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
    and a, $0F
    push af
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ret

; wItemId = wInventory[(wCFD5 & $0F) * 4 + (wC471 & 3)], then far-calls LoadItemRecord (E-0118)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0F, RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0B, RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_Case02_MoveBattleCommandCursor)
; reads: wCommandCursor, wMenuOption
; writes: wItemId
; points at: wInventory
LoadSelectedInventoryItemRecord::
Func_031_62D3:: ; address name
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld hl, wInventory
    add_a_to_hl
    ld a, [wMenuOption]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    farcall LoadItemRecord
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $6D0 with size $0901; HL kept (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles16D0::
Func_031_62F7:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6D0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $760 with size $0901; HL kept (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles1760::
Func_031_6306:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $7F0 with size $0901; HL kept (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles17F0::
Func_031_6315:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7F0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles2 + $80 with size $0901 (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles2080::
Func_031_6324:: ; address name
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    ret

; only called from routines of RunBattleSetup_CommandMenu (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_CommandMenu_ClearBit6AndCursorEntryTile_Bank31, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10)
; reads: wRecordBufferData, wCommandMonster
; writes: wStringIndex, wRecordBuffer
; points at: wBattleMP
RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31::
Func_031_6331:: ; address name
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    pop af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, .skip
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
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

; when wCFD7 is non-zero writes tiles $C5, $E0 + (wCFD5 & 7) + 1, $BE, $E0 + wCFD7 + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0120)
; 4 call sites from 4 routines (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12, RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects_Case11, RunBattleSetup_Case02_MoveBattleCommandCursor, RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case01)
; reads: wCommandPageCount, wCommandCursor
DrawInventoryPageIndicator::
Func_031_6373:: ; address name
    ld a, [wCommandPageCount]
    or a, a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $C5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and a, $07
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $BE
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $C6
    call WriteVRAMByte
    ret

; address loaded by RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11
RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_639F:: ; address name
    db $C1, $01, $01, $02, $C8, $01, $08, $02

; address loaded by RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01, RunBattleSetup_CommandMenu_MoveBattleCommandCursor, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10, RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects_Case11 and 4 more
RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_63A7:: ; address name
    db $41, $01, $81, $01, $C1, $01, $01, $02

; address loaded by RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4, RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31, RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0D, RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case0E and 8 more
RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_63AF:: ; address name
    db $81, $01, $C1, $01, $01, $02

; address loaded by RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink
RunBattleSetup_Case02_ToggleEntryBitsByJoypadAndBlink_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_63B5:: ; address name
    db $C1, $01, $01, $02, $C1, $01, $01, $02

; address loaded by RunBattleEndStep4SubSteps_MoveBattleCommandCursor, RunBattleEndStep4SubSteps_CopyRectRecord7345ToScreenBuffer
RunBattleEndStep4SubSteps_MoveBattleCommandCursor_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_63BD:: ; address name
    db $29, $00, $69, $00, $A9, $00, $E9, $00

; address loaded by RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D, RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink
RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D_Data_63C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_63C5:: ; address name
    db $2F, $01, $6F, $01, $2F, $01, $6F, $01

; A = value: stores A in wDA43[wCFD4], and also in wDA4B[wCFD4] unless A is 3 (E-0118)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor)
; reads: wCommandMonster
; points at: wSlotTactic, wSlotLastTactic
SetSlotTacticAndSlotLastTacticForCommandMonster::
Func_031_63CD:: ; address name
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; wRecordBuffer = the skill at wD989 + 16 * wCFD4 + 2 * (4 * (wCFD5 & 1) + (wC46E & 3)), wCFED = 0, then far-calls LoadSkillRecord (E-0120) (the same 48 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12)
; reads: wMenuCursor, wCommandCursor, wCommandMonster
; writes: wRecordBuffer
; points at: wBattleSkills
LoadSelectedSkillRecord_Bank31::
Func_031_63ED:: ; address name
    ld a, [wMenuCursor]
    and a, $03
    ld b, a
    ld a, [wCommandCursor]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; side base = ((wC57F << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A, BC (E-0067) (the same 28 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12, RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31)
; reads: wLinkRole
CountPresentFoesOfLinkRoleSide_Bank31::
Func_031_641D:: ; address name
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
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

; side base = (wC57F << 1) & 4: D = how many of its three slots are present; clobbers A, BC (E-0067) (the same 24 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_MoveBattleCommandCursor_Case12)
; reads: wLinkRole
CountPresentSlotsOfLinkRoleSide_Bank31::
Func_031_6439:: ; address name
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
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

; only called from RunBattleSetup_CommandMenu_Case18 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31AndStep)
; reads: wRecordBuffer, wLinkRole, wSlotChoices
; points at: wBattleSlotOut, wSlotChoices
RunBattleSetup_CommandMenu_Case18_ReadRecordBufferAndLinkRoleEtc::
Func_031_6451:: ; address name
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_ReadLinkRole
    cp a, $1F
    jr z, RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_ReadLinkRole
    jr RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_ReadLinkRole2

; only called from RunBattleSetup_Case02_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_ShowStringBank09AtTilesHL_Bank31AndStep)
; reads: wItemId, wLinkRole, wSlotChoices
; points at: wBattleSlotOut, wSlotChoices
RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc::
Func_031_645E:: ; address name
    ld a, [wItemId]
    cp a, $0C
    jr nz, RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_ReadLinkRole2

RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_ReadLinkRole::
Jump_031_6465:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $03
    ld hl, wSlotChoices

.loop:
    ld a, [de]
    cp a, $FF
    jr z, .skip2
    xor a, a

.skip2:
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    jr RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_CallCopyRectRecord76ACToScreenBufferFar

RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_ReadLinkRole2::
Jump_031_6486:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $03
    ld hl, wSlotChoices

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    jr RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_CallCopyRectRecord76ACToScreenBufferFar

RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc_CallCopyRectRecord76ACToScreenBufferFar::
Jump_031_64A2:: ; address name
    call CopyRectRecord76ACToScreenBufferFar
    ld hl, wWindowTileBuffer + $1A
    ld a, [wSlotChoices]
    or a, a
    call nz, FillFiveC3AtHL
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSlotChoices + $1]
    or a, a
    call nz, FillFiveC3AtHL
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSlotChoices + $2]
    or a, a
    call nz, FillFiveC3AtHL
    ret

; stores tile $C3 in the five bytes from HL; HL kept (E-0118)
; 3 call sites from 1 routine (e.g. RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc)
FillFiveC3AtHL::
Func_031_64CE:: ; address name
    push hl
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; only called from routines of RunBattleSetup (E-0098)
; 7 call sites from 6 routines (e.g. RunBattleSetup_SetBit6AndBlankEntryTile_Bank31, RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case1D, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_Case19, RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0D, ...)
; reads: wNameSlot
RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty::
Func_031_64D8:: ; address name
    or a, a
    jr nz, .skip2
    ld a, [wNameSlot]
    or a, a
    jr z, .skip
    ld c, $00
    jr .skip5

.skip:
    ld a, [hl]
    and a, $03
    dec a
    jr .skip3

.skip2:
    ld a, [hl]
    and a, $03

.skip3:
    add a, e
    and a, $03
    or a, b
    ld c, a
    ld d, $04

.loop:
    ld a, c
    and a, $03
    cp a, $03
    jr z, .skip4
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip5
    jr z, .skip4
    ld a, [wNameSlot]
    or a, a
    jr nz, .skip5

.skip4:
    ld a, c
    add a, e
    and a, $03
    or a, b
    ld c, a
    dec d
    jr nz, .loop

.skip5:
    ld a, c
    and a, $03
    ld [hl], a
    ret

; only called from routines of RunBattleSetup (E-0098)
; 5 call sites from 5 routines (e.g. RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1E, RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1A, RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case0E, RunBattleSetup_Case02_FillWC278WithC3_Bank31_Case0E, ...)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_SetBit6AndBlankEntryTile_Bank31::
Func_031_6518:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $FF
    ld a, $01
    call RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $80
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
    and a, $0F
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; far-calls Func_0E0_443B (E-0122)
; no direct call (reached through a table, a jump or a vector)
CallFunc443BInBankE0:: ; heuristic: follows a terminator; C0
Func_031_6564:: ; address name
    farcall RunDebugState_E0
    ret

; only called from BattleEnd_Step1 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1)
; reads: wDataBankSave, wBattleKind, wBattleScene, wLinkRole
; writes: wDataBank, wDataBankSave, wBattleScene
BattleEnd_Step1_WriteDataBankAndDataBankSaveEtc::
Func_031_656B:: ; address name
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ld a, [wBattleKind]
    cp a, $08
    jr nc, .check_battle_scene
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
    jr c, .skip2
    ld bc, $0304
    ld de, $0000
    call BattleEnd_Step1_Sub02_Sub02
    jr nc, .skip2
    ld a, d
    or a, a
    jr z, .skip
    xor a, a
    jr .set_battle_scene

.skip:
    ld a, $02
    jr .set_battle_scene

.skip2:
    ld a, $01
    jr .set_battle_scene

.check_battle_scene:
    ld a, [wBattleScene]
    or a, a
    jr nz, .set_battle_scene
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_battle_end_step1_sub02_add_ax9_to_hl2
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
    jr nc, .call_battle_end_step1_sub02_add_ax9_to_hl
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
    jr c, .set_battle_scene_to_80
    jr .skip4

.call_battle_end_step1_sub02_add_ax9_to_hl:
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
    jr c, .skip3
    jr .set_battle_scene_to_80

.call_battle_end_step1_sub02_add_ax9_to_hl2:
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
    jr nc, .call_battle_end_step1_sub02_add_ax9_to_hl3
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
    jr c, .set_battle_scene_to_80
    jr .skip4

.call_battle_end_step1_sub02_add_ax9_to_hl3:
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_AddAx9ToHL
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

; only called from BattleEnd_Step1_Sub02 (E-0047)
; 7 call sites from 1 routine (e.g. BattleEnd_Step1_WriteDataBankAndDataBankSaveEtc)
; points at: wBattleSlotOut, wBattleStatus
BattleEnd_Step1_Sub02_AddAx9ToHL::
Func_031_65FF:: ; address name
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .next
    inc e

.next:
    inc c
    dec b
    jr nz, BattleEnd_Step1_Sub02_AddAx9ToHL
    ld a, e
    cp a, $01
    ret

; only called from BattleEnd_Step1_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1_WriteDataBankAndDataBankSaveEtc)
; points at: wBattleSlotOut
BattleEnd_Step1_Sub02_Sub02::
Func_031_6620:: ; address name
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, .next2
    or a, a
    jr nz, .next
    inc e
    jr .next2

.next:
    inc d

.next2:
    inc c
    dec b
    jr nz, BattleEnd_Step1_Sub02_Sub02
    ld a, e
    cp a, $01
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wLinkMode, wBattlePartyCount
; writes: rRAMG, rRAMB
BattleEnd_Step3_SRAMRecordAddressMapped::
Func_031_663D:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .return
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

.loop:
    push bc
    call BattleEnd_Step3_Sub07_WriteBattleResultByte
    ld a, c
    push bc
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    pop bc
    call BattleEnd_Step3_Sub07_AddAx9ToHL
    call BattleEnd_Step3_Sub07_WriteBattleArg0
    call BattleEnd_Step3_Sub07_Sub04
    call BattleEnd_Step3_Sub07_ReadBattleArg0
    call BattleEnd_Step3_Sub07_ReadBattleArg0_Sub06
    pop bc
    inc c
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a

.return:
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_SRAMRecordAddressMapped)
; reads: wMenuState
; writes: wBattleResultByte
; points at: wSlotTactic, wSlotLastTactic
BattleEnd_Step3_Sub07_WriteBattleResultByte::
Func_031_6678:: ; address name
    push bc
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld b, a
    ld a, c
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    rlca
    rlca
    and a, $0C
    or a, b
    swap a
    push af
    ld a, c
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a
    ld a, [wMenuState]
    and a, $03
    ld [wBattleResultByte], a
    pop bc
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_SRAMRecordAddressMapped)
; reads: wBattleKind
; points at: wBattleSlotOut, wBattleStatus
BattleEnd_Step3_Sub07_AddAx9ToHL::
Func_031_66AE:: ; address name
    ld [hl], $00
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, $01
    jr z, .done
    ld a, [wBattleKind]
    cp a, $04
    ret z
    ld a, c
    push hl
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    bit 5, a
    call nz, BattleEnd_Step3_Sub07_Sub02_Sub01
    and a, $03
    call nz, BattleEnd_Step3_Sub07_Sub02_Sub02
    ret

.done:
    set 7, [hl]
    ret

; only called from BattleEnd_Step3_Sub07_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07_AddAx9ToHL)
BattleEnd_Step3_Sub07_Sub02_Sub01::
Func_031_66DC:: ; address name
    set 0, [hl]
    ret

; only called from BattleEnd_Step3_Sub07_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07_AddAx9ToHL)
BattleEnd_Step3_Sub07_Sub02_Sub02::
Func_031_66DF:: ; address name
    set 2, [hl]
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_SRAMRecordAddressMapped)
; writes: wBattleArg0
; points at: wBattleHP
BattleEnd_Step3_Sub07_WriteBattleArg0::
Func_031_66E2:: ; address name
    ld a, [hl]
    ld [wBattleArg0], a
    bit 7, [hl]
    push af
    ld a, l
    add a, $06
    ld l, a
    ld a, h
    adc a, $00
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
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    pop hl
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
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
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc hl
    inc hl
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_SRAMRecordAddressMapped)
; points at: wBattleMP
BattleEnd_Step3_Sub07_Sub04::
Func_031_6723:: ; address name
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    pop hl
    bit 7, d
    jr nz, .skip
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
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
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_SRAMRecordAddressMapped)
; reads: wBattleArg0
; points at: wBattleWordArray3F
BattleEnd_Step3_Sub07_ReadBattleArg0::
Func_031_6757:: ; address name
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, .skip2
    ld a, c
    ld de, wBattleWordArray3F
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl-], a

.skip2:
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_SRAMRecordAddressMapped)
; reads: wBattleArg0
; points at: wSlotPersonalityHi, wSlotPersonalityLo, wSlotTrait, wSlotPersonalityMid
BattleEnd_Step3_Sub07_ReadBattleArg0_Sub06::
Func_031_6776:: ; address name
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, .return
    ld a, c
    ld de, wSlotPersonalityHi
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, wSlotPersonalityLo
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, wSlotTrait
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, wSlotPersonalityMid
    add a, e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ld [hl], a

.return:
    ret

; by wBattleSubPhase: adds experience to each record (AddExpToRecordCCapped/HLCapped), checks RecordReachedNextLevelExp, computes level-up stat gains and learned skills ('0 learned G!')
; 1 call site from 1 routine (e.g. BattleEnd_Step4)
; reads: wBattleSubPhase
BattleEnd_GainExperience::
Func_031_67AA:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_GainExperience_WriteBattleResolveStepAndBattleSubPhaseEtc
    dw BattleEnd_GainExperience_AddExpToRecordCCapped
    dw BattleEnd_GainExperience_Case02
    dw BattleEnd_GainExperience_CountDownBattleEndTimerWhenSoundIdle
    dw BattleEnd_GainExperience_StoreWorkBufToRecordSkills
    dw BattleEnd_GainExperience_AddExpToRecordHLCapped
    dw BattleEnd_GainExperience_RecordReachedNextLevelExp
    dw BattleEnd_GainExperience_ComputeLevelUpStatGainsForBattleArg1
    dw BattleEnd_GainExperience_SetBattleStep
    dw BattleEnd_GainExperience_Case09

; entry 0 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleKind, wLinkMode, wBattleExpAward
; writes: wBattleResolveStep, wBattleSubPhase, hTemp0, wBattleExpAward, hTemp1, hTemp2
; points at: wBattleSlotOut, wTextBuf0, wBattleSubPhase
BattleEnd_GainExperience_WriteBattleResolveStepAndBattleSubPhaseEtc::
Jump_031_67C2:: ; address name
    ld a, [wBattleKind]
    cp a, $04
    jr c, .skip
    cp a, $06
    jr z, .skip
    cp a, $07
    jr z, .skip
    xor a, a
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
    or a, a
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
    db $FE, $02, $C8, $FE, $03, $28, $0D, $7D, $D6, $01, $6F, $7C, $DE, $00, $67, $7B
    db $DE, $00, $5F, $C9, $7D, $C6, $01, $6F, $7C, $CE, $00, $67, $7B, $CE, $00, $5F
    db $C9

; entry 1 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: rRAMG, rRAMB, wBattleResolveStep, wBattleArg0
; points at: wBattleSlotOut, wBattleSubPhase
BattleEnd_GainExperience_AddExpToRecordCCapped::
Jump_031_6851:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld bc, $0300

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    call z, AddExpToRecordCCapped
    inc c
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleArg0], a
    ret

; adds the 24-bit wDA6B-wDA6D to the 3-byte field $58 of record C, capped at 9,999,999 ($98967F) (E-0125)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_AddExpToRecordCCapped)
; reads: wBattleExpAward
AddExpToRecordCCapped::
Func_031_6885:: ; address name
    push bc
    ld a, c
    ld c, MON_EXP
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add a, c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc a, b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc a, d
    ld d, a
    ld a, $7F
    sub a, c
    ld a, $96
    sbc a, b
    ld a, $98
    sbc a, d
    jr nc, .skip
    ld c, $7F
    ld b, $96
    ld d, $98

.skip:
    ld a, d
    ld [hl-], a
    ld a, b
    ld [hl-], a
    ld [hl], c
    pop bc
    ret

; entry 2 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_GainExperience_Case02::
Jump_031_68B8:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_GainExperience_Case02_RecordReachedNextLevelExp
    dw BattleEnd_GainExperience_Case02_CopyTenByteNameToTextBuf0

; entry 0 of the `rst $00` table in BattleEnd_GainExperience_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0, wPartyCount
; writes: wBattleArg0, wBattleEndTimer
; points at: wBattleSlotOut, wPartyList, wBattleSubPhase, wBattleLevel, wBattleResolveStep
BattleEnd_GainExperience_Case02_RecordReachedNextLevelExp::
Jump_031_68C0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleArg0]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
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
    cp a, b
    ret c
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.set_battle_end_timer_to_3C:
    ld a, $3C
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

; entry 1 of the `rst $00` table in BattleEnd_GainExperience_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: rRAMG, rRAMB, wBattleArg1, wBattleResolveStep
; points at: wPartyList, wBattleSubPhase
BattleEnd_GainExperience_Case02_CopyTenByteNameToTextBuf0::
Jump_031_6925:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
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
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 3 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_GainExperience_CountDownBattleEndTimerWhenSoundIdle::
Jump_031_6966:: ; address name
    call CountDownBattleEndTimerWhenSoundIdle
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_GainExperience_Case03_FillBytes
    dw BattleEnd_GainExperience_Case03_FindNewlyLearnableSkills
    dw BattleEnd_GainExperience_Case03_ToRunBattleEndStep4SubSteps

; entry 0 of the `rst $00` table in BattleEnd_GainExperience_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0
; writes: rRAMG, rRAMB
; points at: wWorkBuf, wBattleResolveStep
BattleEnd_GainExperience_Case03_FillBytes::
Jump_031_6973:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wWorkBuf
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_GainExperience_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, hTemp3, hTemp4, hTemp5
; writes: wBattleSubStep
; points at: wTextBuf2, wTextBuf3, wWorkBuf, wBattleResolveStep
BattleEnd_GainExperience_Case03_FindNewlyLearnableSkills::
Jump_031_69A4:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall FindNewlyLearnableSkills
    ldh a, [hTemp3]
    cp a, $FF
    jr z, .call_for_each_sram_record_run6_e18
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld c, $FF
    ld hl, $0503
    ldh a, [hTemp4]
    or a, a
    jr z, .call_show_string_hl_bank31
    ld hl, $0505
    ldh a, [hTemp4]
    cp a, $02
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
    cp a, c
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

.call_for_each_sram_record_run6_e18:
    call ForEachSRAMRecordRun6E18
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 2 of the `rst $00` table in BattleEnd_GainExperience_Case03
; no direct call (reached through a table, a jump or a vector)
BattleEnd_GainExperience_Case03_ToRunBattleEndStep4SubSteps::
Jump_031_6A06:: ; address name
    call RunBattleEndStep4SubSteps
    ret

; entry 4 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB, wBattleResolveStep
; points at: wBattleSubPhase
BattleEnd_GainExperience_StoreWorkBufToRecordSkills::
Jump_031_6A0A:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call StoreWorkBufToRecordSkills
    call ApplyLevelUpToRecordBattleArg0
    call ShowString0ACat5IfField56AtLeast57
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubPhase
    dec [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; record wD868: level (field $56) += 1 and the gains wD095-wD09A are added to its six stat words (E-0127)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_StoreWorkBufToRecordSkills)
; reads: wBattleArg0, wLevelUpGains
ApplyLevelUpToRecordBattleArg0::
Func_031_6A2D:: ; address name
    ld a, [wBattleArg0]
    ld c, MON_LEVEL
    call SRAMRecordAddressMapped
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31_6A8B
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. ApplyLevelUpToRecordBattleArg0)
AddAToWordAtHL_Bank31_6A8B::
Func_031_6A8B:: ; address name
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; for record wD868: if field $56 (level) >= field $57, begins showing string $0A of category 5 (BeginStringDisplay_Bank2F) (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_StoreWorkBufToRecordSkills)
; reads: wBattleArg0
; writes: wStringIndex, wStringCategory
ShowString0ACat5IfField56AtLeast57::
Func_031_6A92:: ; address name
    ld a, [wBattleArg0]
    ld c, MON_LEVEL
    call SRAMRecordAddressMapped
    ld a, [hl+]
    cp a, [hl]
    ret c
    ld a, $0A
    ld [wStringIndex], a ; 'It has reached the limit for'
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; copies the 8 bytes at wD09D to the skill list (field $34) of record wD868 (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_StoreWorkBufToRecordSkills)
; reads: wBattleArg0
; points at: wWorkBuf
StoreWorkBufToRecordSkills::
Func_031_6AAE:: ; address name
    ld a, [wBattleArg0]
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ret

; entry 5 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB
; points at: sRecords, wBattleSubPhase
BattleEnd_GainExperience_AddExpToRecordHLCapped::
Jump_031_6AC2:: ; address name
    call DivideBattleExpAwardByModeFactor
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $1E
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $01
    jr nz, .skip
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    and a, a
    pop hl
    call z, AddExpToRecordHLCapped

.skip:
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; divides the 24-bit wDA6B-wDA6D by 20, 15 or 10 for wC7C7 = 0, 1 or other (E-0124)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_AddExpToRecordHLCapped)
; reads: wBattleExpAward, wFarmLevel
; writes: wBattleExpAward
DivideBattleExpAwardByModeFactor::
Func_031_6AFE:: ; address name
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, [wFarmLevel]
    or a, a
    jr z, .skip
    cp a, $01
    jr z, .call_divide24_by_a
    ld a, $0A
    jr .call_divide24_by_a2

.skip:
    ld a, $14
    jr .call_divide24_by_a2

.call_divide24_by_a:
    ld a, $0F

.call_divide24_by_a2:
    call Divide24ByA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    ld a, e
    ld [wBattleExpAward + $2], a
    ret

; adds the 24-bit wDA6B-wDA6D to the 3-byte field $58 of the record at HL, capped at 9,999,999 ($98967F) (E-0125)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_AddExpToRecordHLCapped)
; reads: wBattleExpAward
AddExpToRecordHLCapped::
Func_031_6B2E:: ; address name
    push bc
    push hl
    ld a, l
    add a, $58
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add a, c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc a, b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc a, d
    ld d, a
    ld a, $7F
    sub a, c
    ld a, $96
    sbc a, b
    ld a, $98
    sbc a, d
    jr nc, .skip
    ld c, $7F
    ld b, $96
    ld d, $98

.skip:
    ld a, d
    ld [hl-], a
    ld a, b
    ld [hl-], a
    ld [hl], c
    pop hl
    pop bc
    ret

; entry 6 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB, wBattleArg1
; points at: sRecords, wBattleSubPhase
BattleEnd_GainExperience_RecordReachedNextLevelExp::
Jump_031_6B65:: ; address name
    ld hl, sRecords
    ld b, $1E
    ld c, $00

.loop:
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $01
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
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.skip2:
    xor a, a
    ld [rRAMG], a
    ld a, c
    ld [wBattleArg1], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 7 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB
; points at: wBattleSubPhase
BattleEnd_GainExperience_ComputeLevelUpStatGainsForBattleArg1::
Jump_031_6BAC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    call ApplyLevelUpToRecordBattleArg1
    call CopyRecordFields5DTo5BAnd61To5F
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ret

; record wD869: level (field $56) += 1 and the gains wD095-wD09A are added to its six stat words (E-0127)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_ComputeLevelUpStatGainsForBattleArg1)
; reads: wBattleArg1, wLevelUpGains
ApplyLevelUpToRecordBattleArg1::
Func_031_6BCA:: ; address name
    ld a, [wBattleArg1]
    ld c, MON_LEVEL
    call SRAMRecordAddress
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. ApplyLevelUpToRecordBattleArg1)
AddAToWordAtHL_Bank31::
Func_031_6C28:: ; address name
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; for SRAM record wD869: field $5B = word field $5D, field $5F = word field $61, field $55 = 0 (E-0121)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_ComputeLevelUpStatGainsForBattleArg1)
; reads: wBattleArg1
CopyRecordFields5DTo5BAnd61To5F::
Func_031_6C2F:: ; address name
    ld a, [wBattleArg1]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    ld a, l
    add a, $FC
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    pop hl
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld [hl], $00
    ret

; entry 8 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase
; points at: wBattleStep
BattleEnd_GainExperience_SetBattleStep::
Jump_031_6C5E:: ; address name
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 9 of the `rst $00` table in BattleEnd_GainExperience
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_GainExperience_Case09::
Jump_031_6C67:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc
    dw BattleEnd_GainExperience_Case09_ClearTemp0AndA
    dw BattleEnd_GainExperience_Case09_WaitTextFlags

; entry 0 of the `rst $00` table in BattleEnd_GainExperience_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank, wBattlePartyCount, wBattleByte93
; writes: wBattleByte93, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep, wBattleStep
BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc::
Jump_031_6C71:: ; address name
    ld a, [wArenaRank]
    cp a, $05
    jr c, BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc_Skip
    ld a, [wBattlePartyCount]
    cp a, $01
    jr nz, BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc_Skip
    ld a, [wBattleByte93]
    or a, a
    jr z, BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc_Skip
    cp a, $AA
    jr nz, .done
    ld a, $8F
    ld [wBattleByte93], a

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc_Skip::
Jump_031_6C93:: ; address name
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 1 of the `rst $00` table in BattleEnd_GainExperience_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleByte93, wPartyList, hTemp0
; writes: hTemp0, rRAMG, rRAMB, wBattleSubPhase, wBattleResolveStep, wStringCategory, wStringIndex
; points at: wWorkBuf, wBattleStep, wTextBuf1, wTextBuf0, wBattleResolveStep
BattleEnd_GainExperience_Case09_ClearTemp0AndA::
Jump_031_6CA0:: ; address name
    ld a, [wBattleByte93]
    ldh [hTemp0], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wPartyList]
    ld c, MON_SKILLS
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    farcall ClearTemp0AndA
    ldh a, [hTemp0]
    or a, a
    jr nz, .skip
    xor a, a
    ld [rRAMG], a
    jr BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc_Skip

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
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop2
    xor a, a
    ld [rRAMG], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $1F
    ld [wStringIndex], a ; '0 learned G!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in BattleEnd_GainExperience_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleStep
BattleEnd_GainExperience_Case09_WaitTextFlags::
Jump_031_6D17:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    jp BattleEnd_GainExperience_Case09_WriteBattleByte93AndBattleSubPhaseEtc_Skip

; HL += A * $4E (the battler-record size, Multiply8); clobbers BC (E-0115)
; no direct call (reached through a table, a jump or a vector)
AddAx4EToHL:: ; heuristic: follows a terminator; C0
Func_031_6D1F:: ; address name
    push hl
    ld c, $4E
    call Multiply8
    pop bc
    add hl, bc
    ret

; record A below its level cap: C = 1 when its EXP (field $58) has reached the next level's total from the species growth table, else 0 (E-0127)
; 2 call sites from 2 routines (e.g. BattleEnd_GainExperience_RecordReachedNextLevelExp, BattleEnd_GainExperience_Case02_RecordReachedNextLevelExp)
; reads: wSpeciesExpCurve, hTemp2, hTemp3, hTemp4
; writes: rRAMG, rRAMB, hTemp1, wSpeciesIdLo, wSpeciesIdHi, hTemp0
RecordReachedNextLevelExp::
Func_031_6D28:: ; address name
    push af
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    pop af
    ld c, MON_LEVEL
    call SRAMRecordAddress
    ld a, [hl+]
    cp a, [hl]
    jr nc, .skip2
    ldh [hTemp1], a
    ld a, l
    add a, $B4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl+]
    ld [wSpeciesIdHi], a
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    farcall LoadExpTableEntryToTemp2
    pop hl
    ldh a, [hTemp2]
    sub a, [hl]
    ld e, a
    inc hl
    ldh a, [hTemp3]
    sbc a, [hl]
    ld d, a
    inc hl
    ldh a, [hTemp4]
    sbc a, [hl]
    jr c, .skip
    or a, d
    or a, e
    jr nz, .skip2

.skip:
    ld c, $01
    jr .done

.skip2:
    ld c, $00

.done:
    xor a, a
    ld [rRAMG], a
    ret

; copies 10 bytes from HL to wC130 and appends a $F0 terminator (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_Case02_CopyTenByteNameToTextBuf0)
; points at: wTextBuf0
CopyTenByteNameToTextBuf0::
Func_031_6D87:: ; address name
    ld de, wTextBuf0
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $F0
    ld [de], a
    ret

; writes [HL + $4B] + 1 to wC140 and wD095-wD09A to wC150-wC164 as decimal strings (E-0121)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_Case02_CopyTenByteNameToTextBuf0)
; reads: wLevelUpGains
; points at: wTextBuf1, wTextBuf2, wTextBuf3
WriteRecordField4BAndStatsDecimal::
Func_031_6D96:: ; address name
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
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
    ld hl, wTextBuf2 + $C
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $4]
    ld hl, wTextBuf3
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $5]
    ld hl, wTextBuf3 + $4
    call WriteDecimalByteString
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank2F (E-0110)
; 6 call sites from 6 routines (e.g. BattleEnd_GainExperience_WriteBattleResolveStepAndBattleSubPhaseEtc, BattleEnd_GainExperience_Case02_CopyTenByteNameToTextBuf0, BattleEnd_GainExperience_Case03_FindNewlyLearnableSkills, RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink, ...)
; writes: wStringCategory, wStringIndex
ShowStringHL_Bank31::
Func_031_6DDD:: ; address name
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ret

; with SRAM enabled runs Func_031_6E18 for each of the 30 records ($A5 bytes from sA000) whose first byte is non-zero (E-0124)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_Case03_FindNewlyLearnableSkills)
; writes: rRAMG, rRAMB
; points at: sRecords
ForEachSRAMRecordRun6E18::
Func_031_6DEC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $00

.loop:
    ld a, [hl]
    or a, a
    jr z, .skip
    push hl
    push bc
    call ForEachSkillOfRecordBRun6E30
    pop bc
    pop hl

.skip:
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $1E
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ret

; runs Func_031_6E30 for each of the eight skills (field $34) of record B that is not $FF (E-0124)
; 1 call site from 1 routine (e.g. ForEachSRAMRecordRun6E18)
ForEachSkillOfRecordBRun6E30::
Func_031_6E18:: ; address name
    push bc
    ld a, b
    ld c, MON_SKILLS
    call SRAMRecordAddress
    pop bc
    ld c, $08

.loop:
    ld a, [hl+]
    cp a, $FF
    push hl
    push bc
    call nz, ForEachSkillOfRecordBRun6E30_SRAMRecordAddress
    pop bc
    pop hl
    dec c
    jr nz, .loop
    ret

; only called from ForEachSkillOfRecordBRun6E30 (E-0047)
; 1 call site from 1 routine (e.g. ForEachSkillOfRecordBRun6E30)
ForEachSkillOfRecordBRun6E30_SRAMRecordAddress::
Func_031_6E30:: ; address name
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
    cp a, d
    jr nz, .next
    ld [hl], $FF

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
    ld a, $FF
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld de, wBattlerRecords + $4
    ld b, $19

.loop3:
    ld a, [de]
    cp a, $FF
    jr z, .next2
    ld [hl+], a

.next2:
    inc de
    dec b
    jr nz, .loop3
    ret

; runs the routine for wBattleSubStep (jump table of seven) (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_Case03_ToRunBattleEndStep4SubSteps)
; reads: wBattleSubStep
RunBattleEndStep4SubSteps::
Func_031_6E67:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw RunBattleEndStep4SubSteps_ClearAttributesAndScreenBuffer_Bank31
    dw RunBattleEndStep4SubSteps_FillWC278WithC3_Bank31
    dw RunBattleEndStep4SubSteps_MoveBattleCommandCursor
    dw RunBattleEndStep4SubSteps_CopyRectRecord7345ToScreenBuffer
    dw RunBattleEndStep4SubSteps_LoadCursorTileAndRect7826
    dw RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink
    dw RunBattleEndStep4SubSteps_WaitTextFlags

; entry 0 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wCommandCursorMax, wCommandPageCount, wCommandCursor, wListLastPageSize, wMenuState
; points at: wBattleSubPhase, wScreenTileBuffer, wBattleSubStep
RunBattleEndStep4SubSteps_ClearAttributesAndScreenBuffer_Bank31::
Jump_031_6E79:: ; address name
    call RunBattleEndStep4SubSteps_Case00_FillBytes
    cp a, $09
    jr nc, .skip
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall DrawPartySlotStatusPanels
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
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
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, e
    add a, $0C
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, .loop
    ret

.skip:
    ld b, a
    dec a
    and a, $03
    ld [wCommandCursorMax], a
    ld a, $04
    call DivideBByA
    cp a, $00
    jr nz, .set_command_page_count
    dec b

.set_command_page_count:
    ld a, b
    ld [wCommandPageCount], a
    xor a, a
    ld [wCommandCursor], a
    ld a, $03
    ld [wListLastPageSize], a
    ld hl, $0506
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    xor a, a
    ld [wMenuState], a
    ret

; entry 1 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0, wCommandPageCount
; writes: rRAMG, rRAMB, wScreenTileBuffer
; points at: wBattleSubStep
RunBattleEndStep4SubSteps_FillWC278WithC3_Bank31::
Jump_031_6EF7:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call DrawWC278RowsToBGMapRow7
    call RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc
    farcall CopyRectRecords77B6And79CBAndPlaySound6C
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A2
    call WriteDecimalDigitTiles
    xor a, a
    ld [rRAMG], a
    ld a, [wCommandPageCount]
    add a, $E1
    ld [wScreenTileBuffer + $111], a
    call ShowSelectedSkillNameAndCost
    ld de, wScreenTileBuffer + $8
    ld hl, vBGMap0 + $8
    ld bc, $0C09
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    call DrawCommandCursorPageNumber
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandCursor, wMenuState, wJoypadPressedRepeat
; points at: wMenuState, wWorkBuf, wTextBuf2, wBattleSubStep, wCommandCursor
RunBattleEndStep4SubSteps_MoveBattleCommandCursor::
Jump_031_6F57:: ; address name
    ld de, RunBattleEndStep4SubSteps_MoveBattleCommandCursor_Data
    ld hl, wMenuState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuState]
    and a, $0F
    add a, b
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
    and a, $C0
    jr z, .check_joypad_pressed_repeat2
    call DrawWC39EThreeTilesAtBGMap206
    ret

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $30
    ret z
    ld hl, wCommandCursor
    res 7, [hl]
    call RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc
    call DrawWC39EThreeTilesAtBGMap206
    call DrawCommandCursorPageNumber
    ret

; entry 3 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; points at: wBattleSubStep
RunBattleEndStep4SubSteps_CopyRectRecord7345ToScreenBuffer::
Jump_031_6FB1:: ; address name
    ld a, [wMenuState]
    and a, $0F
    ld hl, RunBattleEndStep4SubSteps_MoveBattleCommandCursor_Data
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld [hl], $BC
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM
    ld hl, $0508
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wWindowTileBuffer, wMenuSubState
; points at: wBattleSubStep
RunBattleEndStep4SubSteps_LoadCursorTileAndRect7826::
Jump_031_6FE9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld a, $BB
    ld [wWindowTileBuffer + $7], a
    ld hl, vBGMap0 + $10E
    ld de, wScreenTileBuffer + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wMenuSubState], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState, wCommandCursor, wMenuState
; writes: wBattleSubStep
; points at: wMenuSubState, wWorkBuf, wBattleSubStep
RunBattleEndStep4SubSteps_ToggleEntryBitsByJoypadAndBlink::
Jump_031_700F:: ; address name
    ld de, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D_Data_63C5
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSubState]
    bit 0, a
    jr nz, .set_battle_sub_step_to_01
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuState]
    and a, $0F
    add a, b
    ld hl, wWorkBuf
    add_a_to_hl
    ld [hl], $FF
    ld hl, $0509
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    ret z

.set_battle_sub_step_to_01:
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 6 of the `rst $00` table in RunBattleEndStep4SubSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleSubStep
RunBattleEndStep4SubSteps_WaitTextFlags::
Jump_031_705A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wBattleSubStep], a
    ret

; only called from RunBattleEndStep4SubSteps_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleEndStep4SubSteps_ClearAttributesAndScreenBuffer_Bank31)
; points at: wWorkBuf
RunBattleEndStep4SubSteps_Case00_FillBytes::
Func_031_7064:: ; address name
    ld hl, wBattlerRecords + $4
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38
    ld c, $00

.loop:
    ld a, [hl+]
    cp a, $FF
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
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop2
    pop af
    ret

; only called from routines of RunBattleEndStep4SubSteps (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleEndStep4SubSteps_MoveBattleCommandCursor, RunBattleEndStep4SubSteps_FillWC278WithC3_Bank31)
; reads: wCommandCursor
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi, wStringIndex, wStringCategory
; points at: wWorkBuf
RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc::
Func_031_7096:: ; address name
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld hl, wWorkBuf
    add_a_to_hl
    ld bc, $0400

.loop:
    push bc
    push hl
    ld a, c
    ld hl, RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc_Data
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    pop hl
    ld a, [hl+]
    push hl
    cp a, $FF
    jr nz, .set_string_index
    xor a, a

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

; address loaded by RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc
RunBattleEndStep4SubSteps_WriteTextWindowRowsAndTextWindowWidthEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_70FD:: ; address name
    db $C0, $95, $50, $96, $E0, $96, $70, $97

; shows the name (category 9) of skill wD09D[4 * page + row] at vTiles2 + $260, loads its record and writes its MP cost (or the record's MP for skills $3D, $20, $7B) as digits at wC39E (E-0128)
; 2 call sites from 2 routines (e.g. DrawWC39EThreeTilesAtBGMap206, RunBattleEndStep4SubSteps_FillWC278WithC3_Bank31)
; reads: wCommandCursor, wMenuState, wRecordBuffer, wBattleArg0, wRecordBufferData
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory, wRecordBuffer, rRAMG, ...
; points at: wWorkBuf
ShowSelectedSkillNameAndCost::
Func_031_7105:: ; address name
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
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuState]
    and a, $0F
    add a, b
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
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBuffer]
    cp a, $3D
    jr z, .skip
    cp a, $20
    jr z, .skip
    cp a, $7B
    jr nz, .read_record_buffer_data

.skip:
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    xor a, a
    ld [rRAMG], a
    jr .call_hl_to_decimal_digits

.read_record_buffer_data:
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $9E
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

; runs Func_031_7105, then writes the three bytes at wC39E to vBGMap0 + $206 (E-0122)
; 2 call sites from 1 routine (e.g. RunBattleEndStep4SubSteps_MoveBattleCommandCursor)
DrawWC39EThreeTilesAtBGMap206::
Func_031_719E:: ; address name
    call ShowSelectedSkillNameAndCost
    ld hl, vBGMap0 + $206
    ld de, wWindowTileBuffer + $9E
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; writes tile $E1 + (wCFD5 & $0F) at vBGMap0 + $10F (E-0115)
; 2 call sites from 2 routines (e.g. RunBattleEndStep4SubSteps_MoveBattleCommandCursor, RunBattleEndStep4SubSteps_FillWC278WithC3_Bank31)
; reads: wCommandCursor
DrawCommandCursorPageNumber::
Func_031_71B6:: ; address name
    ld a, [wCommandCursor]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte
    ret

; when every sound channel slot flag is $FF (all idle), decrements wD2CE (E-0121)
; 1 call site from 1 routine (e.g. BattleEnd_GainExperience_CountDownBattleEndTimerWhenSoundIdle)
; reads: wSoundChannelSlots, wBattleEndTimer
; writes: wBattleEndTimer
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
CountDownBattleEndTimerWhenSoundIdle::
Func_031_71C4:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; on CGB writes 0 to the 20 x 18 visible attributes of vBGMap0 in VRAM bank 1 (rows 32 apart, WriteVRAMByteInc); then fills the $240 bytes of wScreenTileBuffer with $C3; what follows is not read (E-0110)
; 6 call sites from 6 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31, ...)
; reads: wIsCGB
; writes: rVBK
; points at: wScreenTileBuffer
ClearAttributesAndScreenBuffer_Bank31::
Func_031_71F5:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $1412

.loop:
    push bc
    push hl

.loop2:
    xor a, a
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
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop3
    ret

; Fills the $160 bytes at wC278 with $C3; clobbers A, BC, HL (the same 15 bytes appear in 2 banks)
; 39 call sites from 22 routines (e.g. RunBattleSetup_FillWC278WithC3_Bank31, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D, RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31_Case07, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink, ...)
FillWC278WithC3_Bank31::
Func_031_722A:: ; address name
    ld hl, wScreenTileBuffer + $E0
    ld bc, $0160

.loop:
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ret

; only called from GameMode4_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31)
; reads: wBattlePartyCount, wLinkRole
; writes: wNameGlyphBuf
; points at: wNameGlyphBuf
GameMode4_Init_Sub01_Sub02_CopyGlyphTilesToVRAM::
Func_031_7239:: ; address name
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $F0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5A0
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
    ld bc, $004E
    call Multiply8By16
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld de, wNameGlyphBuf
    ld b, $0A

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    pop bc
    push bc
    ld b, $00
    ld hl, $72A0
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
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8D, $50, $8D, $A0, $8D

; picks record wD88F - 1 from Data_031_72C3 and copies it into wScreenTileBuffer (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31) (E-0078)
; 5 call sites from 5 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31, ...)
; reads: wBattlePartyCount
CopyRectRecordForBattlePartyCount_Bank31::
Func_031_72AC:: ; address name
    ld a, [wBattlePartyCount]
    dec a
    ld hl, PartyCountRects
    add a, a
    add_a_to_hl
    deref_hl
    call ReadScreenBufferRectHeader_Bank31
    call CopyRectToStride32_Bank31
    ret

; E-0221 (C1: CopyRectRecordForBattlePartyCount_Bank31 reads word wD88F - 1 of $72C3 and copies that record into wScreenTileBuffer (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31); three records, for 1-3 party monsters).
; record: rectangle record for this party count
PartyCountRects::
Data_031_72C3:: ; address name
    dw TileRect_31_757C ; id 1
    dw TileRect_31_75B8 ; id 2
    dw TileRect_31_761E ; id 3

; FillWC278WithC3_Bank31, then falls into LayoutTileBlocksForBattleFoeCount (E-0071)
; 16 call sites from 10 routines (e.g. RunBattleSetup_BankA0_Case00_ClearAndLayoutTileBlocksForBattleFoeCount, RunBattleSetup_BankA0_Case00_ClearAndLayoutTileBlocksForBattleFoeCount_Case02, RunBattleSetup_BankA0_Case00_ClearAndLayoutTileBlocksForBattleFoeCount_Case07, RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc, ...)
; reads: wBattleFoeCount
ClearAndLayoutTileBlocksForBattleFoeCount::
Func_031_72C9:: ; address name
    call FillWC278WithC3_Bank31

; wD890 = count 1-3: writes that many 6 x 6 blocks of consecutive tile numbers, starting at $14 ($24 per block), into the 32-byte-wide buffer at wC278 (row 0); left columns are 7 for one block, 4 and 10 for two, 1, 7 and 13 for three (centred in a 20-column view). Clobbers A, BC, D, HL (E-0060)
; 41 call sites from 24 routines (e.g. BuildBattleScreenBuffer, RunBattleSetup_FillWC278WithC3_Bank31, RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D, RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31_Case07, ...)
; reads: wBattleFoeCount
LayoutTileBlocksForBattleFoeCount::
Func_031_72CC:: ; address name
    ld d, $14
    ld a, [wBattleFoeCount]
    dec a
    ld hl, LayoutTileBlocksForBattleFoeCount_Data_7317
    add a, a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_Sub01
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, LayoutTileBlocksForBattleFoeCount_Sub01_Return
    dec a
    dec a
    ld hl, LayoutTileBlocksForBattleFoeCount_Data_731D
    add a, a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_Sub01
    ld a, [wBattleFoeCount]
    cp a, $03
    jr nz, LayoutTileBlocksForBattleFoeCount_Sub01_Return
    ld hl, wScreenTileBuffer + $ED
    jr LayoutTileBlocksForBattleFoeCount_Sub01_Skip

; only called from LayoutTileBlocksForBattleFoeCount (E-0047)
; 2 call sites from 1 routine (e.g. LayoutTileBlocksForBattleFoeCount)
LayoutTileBlocksForBattleFoeCount_Sub01::
Func_031_72FF:: ; address name
    deref_hl

LayoutTileBlocksForBattleFoeCount_Sub01_Skip::
Jump_031_7302:: ; address name
    ld bc, $0606

.loop:
    push bc
    push hl

.loop2:
    ld a, d
    inc d
    ld [hl+], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop

LayoutTileBlocksForBattleFoeCount_Sub01_Return::
Jump_031_7316:: ; address name
    ret

; address loaded by LayoutTileBlocksForBattleFoeCount
LayoutTileBlocksForBattleFoeCount_Data_7317:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_7317:: ; address name
    db $7F, $C2, $7C, $C2, $79, $C2

; address loaded by LayoutTileBlocksForBattleFoeCount
LayoutTileBlocksForBattleFoeCount_Data_731D:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_731D:: ; address name
    db $82, $C2, $7F, $C2

; on CGB loads the picture attribute blocks for one, two or three battle monsters (wD960, or wBattleMonsterId when bit 1 of wC57F is set) at vBGMap0 + $E1-$ED (E-0125)
; 4 call sites from 4 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_Case01_CopyRect32StrideToVRAM, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31)
; reads: wIsCGB, wLinkRole, wBattleFoeCount
; points at: wBattlePictureIds, wBattleMonsterId
LoadBattleMonsterPictureAttributes::
Func_031_7321:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [wLinkRole]
    bit 1, a
    ld de, wBattlePictureIds
    jr z, .check_battle_foe_count
    ld de, wBattleMonsterId

.check_battle_foe_count:
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .call_load_monster_picture_attributes_from_de
    cp a, $02
    jr z, .call_load_monster_picture_attributes_from_de2
    jr .call_load_monster_picture_attributes_from_de3

.call_load_monster_picture_attributes_from_de:
    ld c, $01
    ld hl, vBGMap0 + $E7
    call LoadMonsterPictureAttributesFromDE
    ret

.call_load_monster_picture_attributes_from_de2:
    ld c, $01
    ld hl, vBGMap0 + $E4
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $EA
    call LoadMonsterPictureAttributesFromDE
    ret

.call_load_monster_picture_attributes_from_de3:
    ld c, $01
    ld hl, vBGMap0 + $E1
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $E7
    call LoadMonsterPictureAttributesFromDE
    ld c, $05
    inc de
    inc de
    ld hl, vBGMap0 + $ED
    call LoadMonsterPictureAttributesFromDE
    ret

; hFFC6 = C (palette number), DE = the monster id word stored at [DE], then LoadMonsterPictureAttributes (HL = BG map address from the caller); DE kept (E-0110)
; 6 call sites from 1 routine (e.g. LoadBattleMonsterPictureAttributes)
; writes: hTemp0
LoadMonsterPictureAttributesFromDE::
Func_031_7379:: ; address name
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

; draws the HP, MP and status of the first one, two or three slots (by wD88F) (E-0122)
; 5 call sites from 5 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31, ...)
; reads: wBattlePartyCount
DrawPartySlotStatusPanels::
Func_031_7389:: ; address name
    call DrawSlotPanelStats0
    ld a, [wBattlePartyCount]
    cp a, $01
    ret z
    call DrawSlotPanelStats1
    ld a, [wBattlePartyCount]
    cp a, $02
    ret z
    call DrawSlotPanelStats2
    ret

; draws HP, MP and status marks of slot 0 (slot 4 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. DrawPartySlotStatusPanels)
; reads: wLinkMode, wLinkRole
DrawSlotPanelStats0::
Func_031_739F:: ; address name
    ld c, $00
    ld a, [wLinkMode]
    or a, a
    jr z, .call_draw_slot_hp_digits
    cp a, $02
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

; draws HP, MP and status marks of slot 1 (slot 5 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. DrawPartySlotStatusPanels)
; reads: wLinkMode, wLinkRole
DrawSlotPanelStats1::
Func_031_73BE:: ; address name
    ld c, $01
    ld a, [wLinkMode]
    or a, a
    jr z, .call_draw_slot_hp_digits
    cp a, $02
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

; draws HP, MP and status marks of slot 2 (slot 6 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. DrawPartySlotStatusPanels)
; reads: wLinkMode, wLinkRole
DrawSlotPanelStats2::
Func_031_73DD:: ; address name
    ld c, $02
    ld a, [wLinkMode]
    or a, a
    jr z, .call_draw_slot_hp_digits
    cp a, $02
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

; copies the panels of the first one, two or three slots (by wD88F) to VRAM (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePartyCount
CopyPartySlotPanelsToVRAM:: ; heuristic: follows a terminator; C0
Func_031_73FC:: ; address name
    call CopySlotPanel0ToVRAM
    ld a, [wBattlePartyCount]
    cp a, $01
    ret z
    call CopySlotPanel1ToVRAM
    ld a, [wBattlePartyCount]
    cp a, $02
    ret z
    call CopySlotPanel2ToVRAM
    ret

; builds and copies the panel row of slot 0 (slot 4 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. CopyPartySlotPanelsToVRAM)
; reads: wLinkMode, wLinkRole
CopySlotPanel0ToVRAM::
Func_031_7412:: ; address name
    ld c, $00
    ld a, [wLinkMode]
    or a, a
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    cp a, $02
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    ld c, $04

.call_copy_slot_panel_part7_ac8_to_vram:
    call CopySlotPanelPart7AC8ToVRAM
    call CopySlotPanelPart7ACEToVRAM
    call CopySlotPanelRowToVRAM
    ret

; builds and copies the panel row of slot 1 (slot 5 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. CopyPartySlotPanelsToVRAM)
; reads: wLinkMode, wLinkRole
CopySlotPanel1ToVRAM::
Func_031_7431:: ; address name
    ld c, $01
    ld a, [wLinkMode]
    or a, a
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    cp a, $02
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    ld c, $05

.call_copy_slot_panel_part7_ac8_to_vram:
    call CopySlotPanelPart7AC8ToVRAM
    call CopySlotPanelPart7ACEToVRAM
    call CopySlotPanelRowToVRAM
    ret

; builds and copies the panel row of slot 2 (slot 6 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. CopyPartySlotPanelsToVRAM)
; reads: wLinkMode, wLinkRole
CopySlotPanel2ToVRAM::
Func_031_7450:: ; address name
    ld c, $02
    ld a, [wLinkMode]
    or a, a
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    cp a, $02
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_panel_part7_ac8_to_vram
    ld c, $06

.call_copy_slot_panel_part7_ac8_to_vram:
    call CopySlotPanelPart7AC8ToVRAM
    call CopySlotPanelPart7ACEToVRAM
    call CopySlotPanelRowToVRAM
    ret

; FillTilesFromRequest, then far-calls CopyRectRecord7345ToScreenBuffer (E-0119)
; 13 call sites from 13 routines (e.g. BattlePhase0_Step1, BattleEnd_Step0, BuildBattleScreenBuffer, BattleEnd_Step5_WriteBattleSubPhaseAndBattlePictureIdsEtc, ...)
ClearWindowAndCopyRect7345Far::
Func_031_746F:: ; address name
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ret

; copies a 20 x 5 rectangle from wC338 (rows 32 bytes apart) to vBGMap0 + $1A0 (row 13) with CopyRect32StrideToVRAM (E-0073)
; 13 call sites from 13 routines (e.g. RunBattleSetup_FleeCommand_ShowNoFleeingFromThis, RunBattleSetup_FleeCommand_ShowRetireNow, RunBattleSetup_FleeCommand_ClearWindowAndCopyRect7345Far, RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31_Case07, ...)
DrawWC338RowsToBGMapRow13::
Func_031_7479:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    call CopyRect32StrideToVRAM
    ret

; only called from routines of RunBattleSetup_FleeCommand (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31_Case07, RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31)
RunBattleSetup_FleeCommand_CopyRectRecord73ADToScreenBuffer::
Func_031_7486:: ; address name
    farcall CopyRectRecord73ADToScreenBuffer

; only called from routines of RunBattleSetup_FleeCommand (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAMAndStep, RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM_Case02)
RunBattleSetup_FleeCommand_ToCopyRect32StrideToVRAM::
Func_031_748C:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $0E05
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord73F7ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31)
CopyRectRecord73F7ToScreenBufferFar::
Func_031_7499:: ; address name
    farcall CopyRectRecord73F7ToScreenBuffer
    ret

; copies a 12 x 11 rectangle from wC278 (rows 32 bytes apart) to vBGMap0 + $E0 (row 7) with CopyRect32StrideToVRAM (E-0110)
; 4 call sites from 4 routines (e.g. RunBattleSetup_FleeCommand_ToggleEntryBitsByJoypadAndBlink_Case0D, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case04, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case01)
DrawWC278Rect12x11ToBGMapRow7::
Func_031_74A0:: ; address name
    ld de, wScreenTileBuffer + $E0
    ld hl, vBGMap0 + $E0
    ld bc, $0C0B
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord755FToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case04)
CopyRectRecord755FToScreenBufferFar::
Func_031_74AD:: ; address name
    farcall CopyRectRecord755FToScreenBuffer
    ret

; copies an 8 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9, column 0) with CopyRect32StrideToVRAM (identical to DrawWC2B8LeftToBGMapRow9 at $74E1) (E-0078)
; 5 call sites from 5 routines (e.g. RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep_Case0C, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case07, ...)
DrawWC2B8LeftToBGMapRow9_74B4::
Func_031_74B4:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord7600ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_FillWC278WithC3_Bank31)
CopyRectRecord7600ToScreenBufferFar::
Func_031_74C1:: ; address name
    farcall CopyRectRecord7600ToScreenBuffer
    ret

; copies a 20 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9) with CopyRect32StrideToVRAM, then wD868 = 1 (E-0077)
; 6 call sites from 5 routines (e.g. RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9AndStep, RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case04, RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9, RunBattleSetup_Case02_MoveBattleCommandCursor, ...)
; writes: wBattleArg0
DrawWC2B8RowsToBGMapRow9::
Func_031_74C8:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wBattleArg0], a
    ret

; far-calls CopyRectRecord76ACToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_Case08_ReadItemIdAndLinkRoleEtc)
CopyRectRecord76ACToScreenBufferFar::
Func_031_74DA:: ; address name
    farcall CopyRectRecord76ACToScreenBuffer
    ret

; copies an 8 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9, column 0) with CopyRect32StrideToVRAM (E-0078)
; 5 call sites from 5 routines (e.g. RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_Case19, RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0F, RunBattleSetup_Case02_DrawWC2B8LeftToBGMapRow9_Case0B, ...)
DrawWC2B8LeftToBGMapRow9::
Func_031_74E1:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord76F8ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_DrawWC2B8RowsToBGMapRow9_Case04)
CopyRectRecord76F8ToScreenBufferFar::
Func_031_74EE:: ; address name
    farcall CopyRectRecord76F8ToScreenBuffer
    ret

; copies an 8 x 7 rectangle from wC2F8 to vBGMap0 + $160 (row 11) with CopyRect32StrideToVRAM (E-0115)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11_Case07, RunBattleSetup_Case02_DrawWC2F8Rect8x7ToBGMapRow11)
DrawWC2F8Rect8x7ToBGMapRow11::
Func_031_74F5:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0807
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecords7600And7734ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4_Case10)
CopyRectRecords7600And7734ToScreenBufferFar::
Func_031_7502:: ; address name
    farcall CopyRectRecords7600And7734ToScreenBuffer
    ret

; copies a 7 x 1 rectangle from wC2A4 to vBGMap0 + $10C (row 8, column 12) and a 20 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9), both with CopyRect32StrideToVRAM (E-0110)
; 4 call sites from 4 routines (e.g. RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31_Case1A, RunBattleSetup_CommandMenu_FillWC278WithC3_Bank31AndStep, RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects, RunBattleSetup_CommandMenu_DrawWC2A4AndWC2B8Rects_Case11)
DrawWC2A4AndWC2B8Rects::
Func_031_7509:: ; address name
    ld de, wScreenTileBuffer + $10C
    ld hl, vBGMap0 + $10C
    ld bc, $0701
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord7750ToScreenBuffer in bank $1A (E-0115)
; 3 call sites from 3 routines (e.g. RunBattleSetup_CommandMenu_CopyRectRecord7750ToScreenBufferFar, RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep_Case0C, RunBattleSetup_Case02_CopyRectRecord7750ToScreenBufferFar)
CopyRectRecord7750ToScreenBufferFar::
Func_031_7522:: ; address name
    farcall CopyRectRecord7750ToScreenBuffer
    ret

; copies a 14 x 7 rectangle from wC2F8 (rows 32 bytes apart) to vBGMap0 + $160 (row 11) with CopyRect32StrideToVRAM (E-0078)
; 5 call sites from 5 routines (e.g. RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11, RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case1D, RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0F, RunBattleSetup_CommandMenu_DrawWC2F8RectToBGMapRow11_Case0D, ...)
DrawWC2F8RectToBGMapRow11::
Func_031_7529:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0E07
    call CopyRect32StrideToVRAM
    ret

; copies a 20 x 11 rectangle from wC278 (rows 32 bytes apart) to vBGMap0 + $E0 (row 7), falling into CopyRect32StrideToVRAM (E-0075)
; 8 call sites from 8 routines (e.g. BattlePhase0_Step1, BattleEnd_Step0, RunBattleSetup_FillWC278WithC3_Bank31, RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31, ...)
DrawWC278RowsToBGMapRow7::
Func_031_7536:: ; address name
    ld de, wScreenTileBuffer + $E0
    ld hl, vBGMap0 + $E0
    ld bc, $140B

; B = width, C = rows, DE = source with 32-byte rows, HL = VRAM address with 32-byte rows: copies a B x C rectangle with WriteVRAMByteInc. DE ends 32 * C past its start and HL at the start of the row below; B kept, C = 0 (E-0060)
; 18 call sites from 15 routines (e.g. BuildAndDrawBattleScreen, DrawWC338RowsToBGMapRow13, DrawWC278Rect12x11ToBGMapRow7, RunBattleSetup_FleeCommand_LoadCursorTileAndRect7826, ...)
CopyRect32StrideToVRAM::
Func_031_753F:: ; address name
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
    sub a, b
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyRect32StrideToVRAM
    ret

; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. CopyRectRecordForBattlePartyCount_Bank31)
; points at: wScreenTileBuffer
ReadScreenBufferRectHeader_Bank31::
Func_031_755B:: ; address name
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

; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0 (E-0065) (the same 18 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. CopyRectRecordForBattlePartyCount_Bank31)
CopyRectToStride32_Bank31::
Func_031_756A:: ; address name
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_Bank31
    ret

; E-0221 (C1: a rectangle record of PartyCountRects (offset, width, rows, tiles)).
; record: offset $0000; 8 x 7 tiles
TileRect_31_757C::
Data_031_757C:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $07 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $B7 ; row 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; row 2
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $EA, $AF, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 6

; E-0221 (C1: a rectangle record of PartyCountRects (offset, width, rows, tiles)).
; record: offset $0000; 14 x 7 tiles
TileRect_31_75B8::
Data_031_75B8:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0E, $07 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $B7 ; row 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; row 2
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 6

; E-0221 (C1: a rectangle record of PartyCountRects (offset, width, rows, tiles)).
; record: offset $0000; 20 x 7 tiles
TileRect_31_761E::
Data_031_761E:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $07 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB, $DC, $DD, $DE, $C3, $B7 ; row 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; row 2
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 6

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: draws the slot's status markers from its status bytes (the per-status part is not read to its end) (E-0111)
; 7 call sites from 6 routines (e.g. DrawSlotPanelStats2, DrawSlotPanelStats1, DrawSlotPanelStats0, BattleEnd_GainExperience_Case02_RecordReachedNextLevelExp, ...)
; reads: wLinkMode, wLinkRole
; points at: wBattleStatus
DrawSlotStatusMarks::
Func_031_76AE:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, .check_link_mode
    farcall DrawSlotStatusMarks_BankA0
    ret

.check_link_mode:
    push bc
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp a, $04
    jr c, .done
    jr .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .done

.skip2:
    and a, $03
    cp a, $03
    jr z, .done
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_draw_slot_status_marks_draw_slot_level2
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a, a
    jr z, .call_draw_slot_status_marks_draw_slot_level
    call DrawSlotStatusMarks_ReadWordTableEntryForSlotC
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub03
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub04
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub06
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub02
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub07
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub05
    jr .done

.call_draw_slot_status_marks_draw_slot_level:
    call DrawSlotStatusMarks_DrawSlotLevel_BankA0
    ld a, c
    and a, $03
    ld hl, DrawSlotStatusMarks_Data
    add a, a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $C3
    jr .done

.call_draw_slot_status_marks_draw_slot_level2:
    call DrawSlotStatusMarks_DrawSlotLevel_BankA0
    ld a, c
    and a, $03
    ld hl, DrawSlotStatusMarks_Data
    add a, a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $C2

.done:
    pop bc
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC::
Func_031_773C:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data
    call ReadWordTableEntryForSlotC
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub02::
Func_031_774C:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $C0
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub03::
Func_031_7757:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub03_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $C1
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub04::
Func_031_7762:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub03_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $C7
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub05::
Func_031_776D:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub05_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $C8
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub06::
Func_031_7778:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub06_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $C9
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub07::
Func_031_7783:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $CA
    pop hl
    ret

; HL = table: HL = the word at HL + 2 * (C & 3) (falls into DerefHL_Bank31) (E-0110)
; 7 call sites from 7 routines (e.g. DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub05, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub07, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub02, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub06, ...)
ReadWordTableEntryForSlotC::
Func_031_778E:: ; address name
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, DerefHL_Bank31
    inc h

; HL = the word at HL; A = its low byte (E-0110)
; 2 call sites from 1 routine (e.g. DrawSlotStatusMarks)
DerefHL_Bank31::
Func_031_7797:: ; address name
    deref_hl
    ret

; address loaded by DrawSlotStatusMarks_ReadWordTableEntryForSlotC, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub02
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_779B:: ; address name
    db $39, $C2, $3F, $C2, $45, $C2

; address loaded by DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub06
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub06_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_77A1:: ; address name
    db $3A, $C2, $40, $C2, $46, $C2

; address loaded by DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub03, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub04
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_77A7:: ; address name
    db $3B, $C2, $41, $C2, $47, $C2

; address loaded by DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub05
DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub05_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_77AD:: ; address name
    db $3C, $C2, $42, $C2, $48, $C2

; address loaded by DrawSlotStatusMarks, DrawSlotStatusMarks_ReadWordTableEntryForSlotC_Sub07
DrawSlotStatusMarks_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_77B3:: ; address name
    db $3D, $C2, $43, $C2, $49, $C2

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: copies the slot's 5-tile panel row from wScreenTileBuffer to the same position of vBGMap0 (offset from Data_031_7ADA, WriteVRAMByteInc) (E-0111)
; 7 call sites from 6 routines (e.g. BattleEnd_GainExperience_Case02_RecordReachedNextLevelExp, CopySlotPanel2ToVRAM, CopySlotPanel1ToVRAM, CopySlotPanel0ToVRAM, ...)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelRowToVRAM::
Func_031_77B9:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    cp a, $02
    jr nz, .check_link_role
    farcall CopySlotPanelRowToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp a, $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .return

.skip2:
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, SlotPanelRowOffsets
    add a, a
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

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: writes the slot's HP (wBattleHP) as decimal digit tiles (HLToDecimalDigits) into wScreenTileBuffer at the position from Data_031_7AC8 (E-0111)
; 6 call sites from 5 routines (e.g. DrawSlotPanelStats2, DrawSlotPanelStats1, DrawSlotPanelStats0, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wBattleHP, wScreenTileBuffer
DrawSlotHPDigits::
Func_031_7806:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, .skip
    farcall DrawSlotHPDigits_BankA0
    ret

.skip:
    push bc
    or a, a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp a, $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp a, $04
    jr nc, .done

.skip3:
    and a, $03
    cp a, $03
    jr z, .done
    ld a, c
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, DrawSlotHPDigits_Data
    add a, a
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

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: writes the slot's MP (wBattleMP) as decimal digit tiles into wScreenTileBuffer at the slot's position (E-0111)
; 6 call sites from 5 routines (e.g. DrawSlotPanelStats2, DrawSlotPanelStats1, DrawSlotPanelStats0, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wBattleMP, wScreenTileBuffer
DrawSlotMPDigits::
Func_031_785F:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, .skip
    farcall DrawSlotMPDigits_BankA0
    ret

.skip:
    push bc
    or a, a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp a, $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp a, $04
    jr nc, .done

.skip3:
    and a, $03
    cp a, $03
    jr z, .done
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, DrawSlotMPDigits_Data
    add a, a
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

; only called from DrawSlotStatusMarks (E-0047)
; 2 call sites from 1 routine (e.g. DrawSlotStatusMarks)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer, wBattleLevel
DrawSlotStatusMarks_DrawSlotLevel_BankA0::
Func_031_78B8:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, .skip
    farcall DrawSlotLevel_BankA0
    ret

.skip:
    push bc
    or a, a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp a, $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp a, $04
    jr nc, .done

.skip3:
    and a, $03
    cp a, $03
    jr z, .done
    ld a, c
    and a, $03
    ld hl, DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
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
    call WriteTwoDigitTilesFromWC8C1

.done:
    pop bc
    ret

; copies three tiles at offset Data_031_7AC8[slot] from the screen buffer to vBGMap0 for the shown side (CopySlotPanelPart6D47ToVRAM in mode 2) (E-0125)
; 6 call sites from 5 routines (e.g. CopySlotPanel2ToVRAM, CopySlotPanel1ToVRAM, CopySlotPanel0ToVRAM, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelPart7AC8ToVRAM::
Func_031_7914:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    cp a, $02
    jr nz, .check_link_role
    farcall CopySlotPanelPart6D47ToVRAM
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp a, $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .return

.skip2:
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, DrawSlotHPDigits_Data
    add a, a
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

; copies three tiles at offset Data_031_7ACE[slot] from the screen buffer to vBGMap0 for the shown side (CopySlotPanelPart6D4BToVRAM in mode 2) (E-0125)
; 6 call sites from 5 routines (e.g. CopySlotPanel2ToVRAM, CopySlotPanel1ToVRAM, CopySlotPanel0ToVRAM, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelPart7ACEToVRAM::
Func_031_7965:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    cp a, $02
    jr nz, .check_link_role
    farcall CopySlotPanelPart6D4BToVRAM
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp a, $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .return

.skip2:
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, DrawSlotMPDigits_Data
    add a, a
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

; copies two tiles at offset Data_031_7AD4[slot] from the screen buffer to vBGMap0 for the shown side (CopySlotPanelPart6D4FToVRAM in mode 2) (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelPart7AD4ToVRAM:: ; heuristic: follows a terminator; C0
Func_031_79B6:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    cp a, $02
    jr nz, .check_link_role
    farcall CopySlotPanelPart6D4FToVRAM
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp a, $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .return

.skip2:
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data
    add a, a
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

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes appear in 3 banks)
; 7 call sites from 6 routines (e.g. RunBattleSetup_FleeCommand_FillWC278WithC3_Bank31, RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31AndStep, RunBattleSetup_CommandMenu_DrawWC278Rect12x11ToBGMapRow7_Case04, RunBattleSetup_CommandMenu_ShowStringBank09AtTilesHL_Bank31, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtTilesHL_Bank31::
Func_031_7A02:: ; address name
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

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes appear in 2 banks)
; 7 call sites from 7 routines (e.g. RunBattleSetup_CommandMenu_ShowStringBank08AtTilesHL_Bank31, ShowStringAAtTiles2080, ShowStringAAtTiles17F0, ShowStringAAtTiles1760, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_Bank31::
Func_031_7A3D:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wTextBuf0
UnreferencedShowFiveGlyphsAtTilesHL_Bank31:: ; configured code entry (E-0238); C0
Func_031_7A78:: ; address name
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

; address loaded by DrawSlotHPDigits, CopySlotPanelPart7AC8ToVRAM
DrawSlotHPDigits_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_7AC8:: ; address name
    db $62, $00, $68, $00, $6E, $00

; address loaded by DrawSlotMPDigits, CopySlotPanelPart7ACEToVRAM
DrawSlotMPDigits_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_7ACE:: ; address name
    db $82, $00, $88, $00, $8E, $00

; address loaded by DrawSlotStatusMarks_DrawSlotLevel_BankA0, CopySlotPanelPart7AD4ToVRAM
DrawSlotStatusMarks_DrawSlotLevel_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_031_7AD4:: ; address name
    db $A1, $00, $A7, $00, $AD, $00

; E-0212 (C1: CopySlotPanelRowToVRAM reads the word at $7ADA + 2 * (slot & 3) and copies 5 tiles from wScreenTileBuffer + offset to the same offset of vBGMap0; three words for slots 0-2).
; record: offset of the slot's panel row in the screen buffer / BG map
SlotPanelRowOffsets::
Data_031_7ADA:: ; address name
    dw $00A1 ; id 0
    dw $00A7 ; id 1
    dw $00AD ; id 2

; the same 55 bytes as GetBattleATK_Bank39 (39:71E5)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AE0:: ; address name
    ld hl, wBattleATK
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 50 bytes as GetBattleDEF_Bank39 (39:71EA)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleDEF
GetBattleDEF_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AE5:: ; address name
    ld hl, wBattleDEF
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 45 bytes as GetBattleMaxHP_Bank39 (39:71EF)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AEA:: ; address name
    ld hl, wBattleMaxHP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 40 bytes as GetBattleMaxMP_Bank39 (39:71F4)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AEF:: ; address name
    ld hl, wBattleMaxMP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 35 bytes as GetBattleHP_Bank39 (39:71F9)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AF4:: ; address name
    ld hl, wBattleHP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 30 bytes as GetBattleMP_Bank39 (39:71FE)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AF9:: ; address name
    ld hl, wBattleMP
    jr ReadSlotAIModeIndexed_Bank31_Skip

; the same 25 bytes as GetBattleAGL_Bank39 (39:7203)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleAGL
GetBattleAGL_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AFE:: ; address name
    ld hl, wBattleAGL
    jr ReadSlotAIModeIndexed_Bank31_Skip

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 5 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotAIMode
ReadSlotAIModeIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B03:: ; address name
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

ReadSlotAIModeIndexed_Bank31_Skip::
Jump_031_7B0D:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7B17:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7B1E:: ; address name
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

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7B39:: ; address name
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

; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank31[D] (AddAx9ToHL); not reached from traced code (E-0212)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B54:: ; address name
    ld a, d
    ld hl, ClearBitMaskTable_Bank31
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; E-0212 (C1: the copy in bank $31 of ClearBitMaskTable (E-0205), read by the routine at $7B54; the block $7B54-$7BEE has the same bytes as $4075-$410F in banks $05, $A1 and $A3, apart from the table address).
; record: AND mask
ClearBitMaskTable_Bank31::
Data_031_7B69:: ; address name
    db $DF ; id 0
    db $FE ; id 1
    db $00 ; id 2
    db $FD ; id 3
    db $73 ; id 4
    db $EF ; id 5
    db $BF ; id 6

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B70:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B7D:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B8A:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B97:: ; address name
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

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_FleeCommand_Case09_CheckSlotStatusBlockWide_Bank31)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank31::
Func_031_7BEE:: ; address name
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

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7C0D:: ; address name
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

; address loaded by GameMode5_Init_SendSGBPaletteSetPacket_Case04, RunBattleEndStep5SubSteps_WriteArg1AndArg2Etc, BattleEnd_Step5_Case04_Sub01_SwapMonstersMenu, GameMode4_Init and 2 more
; LZSS-compressed asset: 477 bytes expand to 704 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles1Plus240Gfx_31_7C1E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_031_7C1E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0C7C1E, $1DD

; address loaded by GameMode5_Init_SendSGBPaletteSetPacket_Case04, RunBattleEndStep5SubSteps_WriteArg1AndArg2Etc, BattleEnd_Step5_Case04_Sub01_SwapMonstersMenu, GameMode4_Init and 2 more
; LZSS-compressed asset: 151 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles1Plus5F0Gfx_31_7DFB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_031_7DFB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0C7DFB, $97
    ds $16E, $00
